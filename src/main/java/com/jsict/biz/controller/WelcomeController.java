package com.jsict.biz.controller;


import com.jsict.biz.dao.RegisterDao;
import com.jsict.biz.model.Register;
import com.jsict.biz.model.Role;
import com.jsict.biz.model.User;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * WelcomeController ：
 *
 * @author Lv
 * @since 2018/12/13 09:55
 */
@Controller
@RequestMapping("/welcome")
public class WelcomeController {

  @Autowired
  RegisterDao registerDao;

  @SuppressWarnings("rawtypes")
  @ResponseBody
  @RequestMapping(value = "/getNum", method = RequestMethod.POST)
  public Map<String, Object> getNum(){
    Map<String, Object> data = new HashMap<>();
    int n1 = 0;//患者-待就诊
    int n2 = 0;//患者-已就诊
    int n3 = 0;//患者-已退号
    int n4 = 0;//患者-过期
    int n5 = 0;//医生-待诊断
    int n6 = 0;//医生-已诊断
    int n7 = 0;//医生-已退号
    int n8 = 0;//医生-过期
    int n9 = 0;//患者-信用分

    Map<String,Object> params = new HashMap<>();
    params.put("delFlag",0);
    User user = (User)SecurityUtils.getSubject().getPrincipal();
    String currentUser = user == null?"":user.getId();
    boolean isAdmin = user == null?false:user.isAdmin();
    List<Register> list = registerDao.getObjectListBySqlKey("getListByParams",params,Register.class);//该医生所有的挂号信息
    if (isAdmin){
      //是admin
      if (list != null && list.size() > 0) {
        for (Register register:list) {
          if ("0".equals(register.getStatus())) {
            n1++;
            n5++;
          } else if ("1".equals(register.getStatus())) {
            n2++;
            n6++;
          } else if ("2".equals(register.getStatus())) {
            n3++;
            n7++;
          } else if ("3".equals(register.getStatus())) {
            n4++;
            n8++;
          }
        }
      }
    }else{
      //不是admin
      if (list != null && list.size() > 0) {
        for (Register register:list) {
          if (currentUser.equals(register.getUserId())) {
            //当前用户是患者
            if ("0".equals(register.getStatus())) {
              n1++;
            } else if ("1".equals(register.getStatus())) {
              n2++;
            } else if ("2".equals(register.getStatus())) {
              n3++;
            } else if ("3".equals(register.getStatus())) {
              n4++;
            }
          } else if (currentUser.equals(register.getDoctorId())) {
            //当前用户是医生
            if ("0".equals(register.getStatus())) {
              n5++;
            } else if ("1".equals(register.getStatus())) {
              n6++;
            } else if ("2".equals(register.getStatus())) {
              n7++;
            } else if ("3".equals(register.getStatus())) {
              n8++;
            }
          }
        }
      }
    }
    n9 = user == null?0:user.getScore() == null?0:user.getScore();
    data.put("n1",n1);
    data.put("n2",n2);
    data.put("n3",n3);
    data.put("n4",n4);
    data.put("n5",n5);
    data.put("n6",n6);
    data.put("n7",n7);
    data.put("n8",n8);
    data.put("n9",n9);
    return data;
  }
}
