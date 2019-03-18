package com.jsict.biz.controller;

import com.jsict.biz.dao.DepartmentDao;
import com.jsict.biz.dao.RegisterDao;
import com.jsict.biz.dao.UserDao;
import com.jsict.biz.model.Constant;
import com.jsict.biz.model.Department;
import com.jsict.biz.model.Register;
import com.jsict.biz.model.User;
import com.jsict.biz.service.RegisterService;
import com.jsict.biz.service.UserService;
import com.jsict.framework.core.controller.AbstractGenericController;
import com.jsict.framework.core.controller.Response;
import com.jsict.framework.core.controller.RestControllerException;
import com.jsict.framework.core.security.model.IUser;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * RegisterController ：
 *
 * @author Lv
 * @since 2019/2/28 20:20
 */
@Controller
@RequestMapping("/register")
public class RegisterController extends
    AbstractGenericController<Register, String, Register> {

  private static final Logger logger = LoggerFactory.getLogger(RegisterController.class);

  @Autowired
  private DepartmentDao departmentDao;

  @Autowired
  private UserService userService;

  @Autowired
  private RegisterService registerService;

  @Autowired
  private RegisterDao registerDao;

  /**
   *
   * 功能描述: 预约挂号页医生列表
   *
   * @param:
   * @return:
   * @auther: Lv
   * @date: 2019/3/18 10:42
   */
  @RequestMapping(value = "/doctorPage", method = RequestMethod.POST, produces = "application/json")
  @ResponseBody
  public Page<User> doctorPage(@ModelAttribute User user, @PageableDefault Pageable pageable){
    try{
      user.setType("1");//查询医生
      String dateStr = user.getDate();//就诊日期
      String am = user.getAm();//0:上午  1：下午
      if (StringUtils.isNotBlank(dateStr)){
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Date date = sdf.parse(dateStr);
        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        int w = cal.get(Calendar.DAY_OF_WEEK) - 1;//获取当天是周几
        String time = null;
        switch(w){
          case 1:
            if ("0".equals(am)){time = "1,";}
            else {time = "2,";}
            break;
          case 2:
            if ("0".equals(am)){time = "3,";}
            else {time = "4,";}
            break;
          case 3:
            if ("0".equals(am)){time = "5,";}
            else {time = "6,";}
            break;
          case 4:
            if ("0".equals(am)){time = "7,";}
            else {time = "8,";}
            break;
          case 5:
            if ("0".equals(am)){time = "9,";}
            else {time = "10,";}
            break;
        }
        user.setTime(time);
      }
      return userService.findByPage(user, pageable);
    }catch(Exception e){
      logger.error("翻页查询出错", e);
      throw new RestControllerException("翻页查询出错", e);
    }
  }

  @RequestMapping(value = "/patientRegisterPage", method = RequestMethod.POST, produces = "application/json")
  @ResponseBody
  public Page<Register> patientRegisterPage(@ModelAttribute Register register, @PageableDefault Pageable pageable){
    try{
      User user = (User)SecurityUtils.getSubject().getPrincipal();
      if (user != null && !user.isAdmin()){
        register.setUserId(user.getId());
      }
      return registerService.findByPage(register, pageable);
    }catch(Exception e){
      logger.error("翻页查询出错", e);
      throw new RestControllerException("翻页查询出错", e);
    }
  }

  /**
   *
   * 功能描述: 
   *
   * @param: 退号
   * @return: 
   * @auther: Lv
   * @date: 2019/3/18 16:24
   */
  @RequestMapping(value = {"/cancel/{id}"}, method = {RequestMethod.POST}, produces = {"application/json"})
  @ResponseBody
  public Response delete(@PathVariable String id) {
    Response response;
    try {
      Register register = this.generiService.getWithoutDic(id);
      if (!"0".equals(register.getStatus())){
        //只有待就诊状态的号可以退
        response = new Response(ERROR,"只有待就诊状态的号可以退");
        return response;
      }
      Date chooseDate = register.getChooseDate();//选择的日期
      String am = register.getAm();//0、上午  1、下午
      Date now = new Date();//当前系统时间
      Calendar c = Calendar.getInstance();
      c.setTime(chooseDate);
      if ("0".equals(am)){
        //上午截止时间设为12点
        c.set(Calendar.HOUR_OF_DAY, 12);
      }else{
        //下午截止时间设为18点
        c.set(Calendar.HOUR_OF_DAY, 18);
      }
      if (now.getTime() > c.getTimeInMillis()){
        response = new Response(ERROR,"已超过规定退号的时间，无法退号");
        return response;
      }

      //退号
      register.setStatus("2");
      User user = (User)SecurityUtils.getSubject().getPrincipal();
      if (user != null){
        user.setUpdaterId(user.getId());
      }
      this.generiService.update(register);

    } catch (Exception var4) {
      logger.error(var4.getLocalizedMessage(), var4);
      response = new Response(ERROR, var4.getLocalizedMessage());
      return response;
    }
    response = new Response(SUCCESS);
    return response;
  }
  

  /**
   *
   * 功能描述: 获取科室或者患者部门
   *
   * @param:
   * @return:
   * @auther: Lv
   * @date: 2019/2/25 10:27
   */
  @RequestMapping(value = "/getDeptList", method = RequestMethod.GET, produces = "application/json")
  @ResponseBody
  public List<Department> getDeptList(String type){
    Map<String,Object> params = new HashMap<>();
    params.put("delFlag",0);
    params.put("type",type);
    List<Department> list = departmentDao.getObjectListBySqlKey("getListByNameCode",params,Department.class);
    return list;
  }

  @RequestMapping(value = {"/getInfo/{id}"}, method = {RequestMethod.GET}, produces = {"application/json"})
  @ResponseBody
  public Map<String,Object> getInfo(@PathVariable String id) {
    Map<String,Object> returnMap = new HashMap<>();
    User doctor = userService.get(id);
    returnMap.put("doctor",doctor);//医生信息

    Map<String,Object> params = new HashMap<>();
    params.put("delFlag",0);
    params.put("doctorId",id);
    params.put("status","0");
    List<Register> list = registerDao.getObjectListBySqlKey("getListByParams",params,Register.class);//该医生所有的挂号信息
    IUser user = (IUser)SecurityUtils.getSubject().getPrincipal();//获取当前登入用户
    if (user == null) {
      params.put("userId",user.getId());
    }
    List<Register> selfList = registerDao.getObjectListBySqlKey("getListByParams",params,Register.class);//自己在该医生处所有的挂号信息

    List<Map<String,Object>> returnList = new ArrayList<>();
    if(doctor != null && StringUtils.isNotBlank(doctor.getTime())){
      //如果查询到该医生的班表信息
      String time = doctor.getTime().substring(0,doctor.getTime().length()-1);
      String[] timeArr = time.split(",");
      Date now = new Date();
      long nowTime = now.getTime();
      int week = now.getDay();//0-周日，6-周六
      List<String> thisWeek = new ArrayList<>();
      List<String> nextWeek = new ArrayList<>();
      for (String temp:timeArr) {
        if (Integer.parseInt(temp) <= 2*week){
          //如果temp是8，即为周四下午。今天如果是周四，2*week=8。那么这个周四算在下周
          nextWeek.add(temp);
        }else{
          thisWeek.add(temp);
        }
      }
      thisWeek.addAll(nextWeek);//此时thisWeek为重新排列过的星期

      for (String temp:thisWeek) {
        int intTemp = Integer.parseInt(temp);
        int intTemp1 = intTemp%2==0?intTemp:intTemp+1;
        String am = intTemp%2==0?"1":"0";
        Date date = null;
        if (Integer.parseInt(temp) > 2*week){
          date = new Date(nowTime+(intTemp1-2*week)*12*60*60*1000);
        }else{
          date = new Date(nowTime+(intTemp1-2*week+14)*12*60*60*1000);
        }

        List<Map<String,Object>> resList = new ArrayList<>();
        //遍历该医生所有的挂号信息
        if (list != null && list.size() > 0){
          int people1 =0,people2 =0,people3 =0,people4 =0;
          for (Register register:list) {
            if (register.getChooseDate().getTime() <= date.getTime() && register.getChooseDate().getTime()+24*60*60*1000 > date.getTime()){
              //介于当天0点与24点之间
              if ("0".equals(am)){//上午
                if ("1".equals(register.getTimeRange())){
                  people1++;
                }else if ("2".equals(register.getTimeRange())){
                  people2++;
                }else if ("3".equals(register.getTimeRange())){
                  people3++;
                } else if ("4".equals(register.getTimeRange())){
                  people4++;
                }
              }else{//下午
                if ("5".equals(register.getTimeRange())){
                  people1++;
                }else if ("6".equals(register.getTimeRange())){
                  people2++;
                }else if ("7".equals(register.getTimeRange())){
                  people3++;
                } else if ("8".equals(register.getTimeRange())){
                  people4++;
                }
              }
            }
          }
          //获取医生每小时就诊人数上限，没设置就取默认值5
          int hourPeople = doctor.getHourPeople() ==null?Constant.HOUR_PEOPLE:doctor.getHourPeople();
          if (people1 < hourPeople){
            Map<String,Object> map = new HashMap<>();
            map.put("1",true);
            resList.add(map);
          }else{
            Map<String,Object> map = new HashMap<>();
            map.put("1",false);
            resList.add(map);
          }

          if (people2 < hourPeople){
            Map<String,Object> map = new HashMap<>();
            map.put("2",true);
            resList.add(map);
          }else{
            Map<String,Object> map = new HashMap<>();
            map.put("2",false);
            resList.add(map);
          }

          if (people3 < hourPeople){
            Map<String,Object> map = new HashMap<>();
            map.put("3",true);
            resList.add(map);
          }else{
            Map<String,Object> map = new HashMap<>();
            map.put("3",false);
            resList.add(map);
          }

          if (people4 < hourPeople){
            Map<String,Object> map = new HashMap<>();
            map.put("4",true);
            resList.add(map);
          }else{
            Map<String,Object> map = new HashMap<>();
            map.put("4",false);
            resList.add(map);
          }

        }else if(list != null && list.size() == 0){
          //没有挂号信息
          for (int i = 1; i < 5; i++) {
            Map<String,Object> map = new HashMap<>();
            map.put(String.valueOf(i),true);
            resList.add(map);
          }
        }
        Map<String,Object> map = new HashMap<>();
        map.put(temp,resList);
        returnList.add(map);
      }
    }
    returnMap.put("result",returnList);
    return returnMap;
  }

  @RequestMapping(value = {"/register"}, method = {RequestMethod.POST}, produces = {"application/json"})
  @ResponseBody
  public Response register(Register register) {
    Response response = registerService.saveRegister(register);
    return response;
  }

}
