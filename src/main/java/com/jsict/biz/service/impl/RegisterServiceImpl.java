package com.jsict.biz.service.impl;

import com.jsict.biz.dao.RegisterDao;
import com.jsict.biz.dao.UserDao;
import com.jsict.biz.model.Constant;
import com.jsict.biz.model.Register;
import com.jsict.biz.model.User;
import com.jsict.biz.service.RegisterService;
import com.jsict.biz.service.UserService;
import com.jsict.framework.core.controller.Response;
import com.jsict.framework.core.security.model.IUser;
import com.jsict.framework.core.service.impl.GeneriServiceImpl;
import com.jsict.framework.utils.BeanMapper;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * RegisterServiceImpl ：
 *
 * @author Lv
 * @since 2019/2/28 20:22
 */
@Service
public class RegisterServiceImpl extends GeneriServiceImpl<Register, String> implements
    RegisterService {

  @Autowired
  private RegisterDao registerDao;

  @Autowired
  private UserDao userDao;

  @Autowired
  private UserService userService;

  protected static final Integer SUCCESS = 0;
  protected static final Integer ERROR = -1;

  @Transactional
  @Override
  public Response saveRegister(Register register) {
    Response response;
    User user = (User)SecurityUtils.getSubject().getPrincipal();//获取当前登入用户
    if (user != null){
      //信用分小于等于-10，不能挂号
      User temp = userService.getWithoutDic(user.getId());
      if (temp != null && temp.getScore() <= -10){
        response = new Response(ERROR,"您的信用分小于等于-10，不能挂号！");
        return response;
      }
    }
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    Date chooseDate = null;
    try {
      chooseDate = sdf.parse(register.getDate());//转换前台选择的挂号时间
    } catch (ParseException e) {
      e.printStackTrace();
    }
    if (chooseDate != null && chooseDate.getTime() <= new Date().getTime()){
      response = new Response(ERROR,"选择的日期小于当前时间");
      return response;
    }
    Map<String,Object> params = new HashMap<>();
    params.put("delFlag",0);
    params.put("doctorId",register.getDoctorId());
    params.put("chooseDate",chooseDate);
    params.put("timeRange",register.getTimeRange());
    List<Register> allList = registerDao.getObjectListBySqlKey("getListByParams",params,Register.class);//该医生该时间段所有的挂号信息
    params.put("status","0");
    List<Register> waitList = registerDao.getObjectListBySqlKey("getListByParams",params,Register.class);//该医生该时间段待就诊的挂号信息，不包括已经退号的
    if (Integer.valueOf(register.getTimeRange()) <= 4){
      params.put("am","0");
    }else {
      params.put("am","1");
    }
    params.remove("timeRange");
    if (user != null) {
      params.put("userId",user.getId());
    }
    List<Register> selfList = registerDao.getObjectListBySqlKey("getListByParams",params,Register.class);//自己单个半天的挂号信息，不包括已经退号的
    if (selfList != null && selfList.size() > 0){
      response = new Response(ERROR,"您在当前半天内已存在挂号信息");
      return response;
    }
    User doctor = userDao.getWithoutDic(register.getDoctorId());
    int hourPeople = Constant.HOUR_PEOPLE;//每个医生默认的每小时就诊人数
    if (doctor != null && doctor.getHourPeople() != null){
      hourPeople = doctor.getHourPeople();//如果医生设置了每个小时就诊人数，则以设置为准
    }
    if (waitList.size() >= hourPeople){
      response = new Response(ERROR,"该时间段已约满");
      return response;
    }
    //否则正常保存挂号信息
    Register rg = new Register();
    rg.setId(null);
    if (user != null){
      rg.setUserId(user.getId());
      rg.setCreatorId(user.getId());
    }
    rg.setDoctorId(register.getDoctorId());
    rg.setRegisterTime(new Date());
    rg.setChooseDate(chooseDate);
    if (Integer.valueOf(register.getTimeRange()) <= 4) {
      rg.setAm("0");//上午
    }else {
      rg.setAm("1");//下午
    }
    rg.setTimeRange(register.getTimeRange());
    rg.setStatus("0");//初始状态置为0，待就诊
    int sort = 1;//初始序号为1
    if (allList != null && allList.size() > 0){
      //如果已有人挂号，那么去最后一个人的序号加1
      sort = allList.get(allList.size()-1).getSort() + 1;
    }
    //如果没有人挂号，则序号就是初始值1
    rg.setSort(sort);
    //生成的就诊号格式为时间段-序号，如预约早上八点到九点时间段的第5号患者的就诊号为1-5
    rg.setRangeSort(register.getTimeRange()+"-"+sort);
    super.save(rg);
    //挂号成功+2分
    if (user != null) {
      userService.addScore(user.getId(),2);
    }
    response = new Response(SUCCESS);
    return response;
  }

  @Override
  @Transactional(readOnly = true)
  public Page<Register> findByPageForDoctor(Register register, Pageable pageable) {
    Map<String, Object> params = (Map)BeanMapper.map(register, Map.class);
    List<String> keys = new ArrayList();
    Iterator var5 = params.entrySet().iterator();

    while(true) {
      Entry entry;
      do {
        if (!var5.hasNext()) {
          if (!keys.isEmpty()) {
            var5 = keys.iterator();

            while(var5.hasNext()) {
              String key = (String)var5.next();
              params.remove(key);
            }
          }

          return this.genericDao.page("selectByPageForDoctor", params, pageable);
        }

        entry = (Entry)var5.next();
      } while(entry.getValue() != null && !"".equals(entry.getValue()));

      keys.add((String) entry.getKey());
    }
  }
}
