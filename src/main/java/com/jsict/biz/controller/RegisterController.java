package com.jsict.biz.controller;

import com.jsict.biz.dao.DepartmentDao;
import com.jsict.biz.dao.UserDao;
import com.jsict.biz.model.Department;
import com.jsict.biz.model.Register;
import com.jsict.biz.model.User;
import com.jsict.biz.service.UserService;
import com.jsict.framework.core.controller.AbstractGenericController;
import com.jsict.framework.core.controller.RestControllerException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
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

  @RequestMapping(value = "/doctorPage", method = RequestMethod.POST, produces = "application/json")
  @ResponseBody
  public Page<User> doctorPage(@ModelAttribute User user, @PageableDefault Pageable pageable){
    try{
      user.setType("1");
      return userService.findByPage(user, pageable);
    }catch(Exception e){
      logger.error("翻页查询出错", e);
      throw new RestControllerException("翻页查询出错", e);
    }
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

}