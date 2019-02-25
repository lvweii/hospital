package com.jsict.biz.controller;

import com.jsict.biz.dao.DepartmentDao;
import com.jsict.biz.dao.UserDao;
import com.jsict.biz.model.Department;
import com.jsict.biz.model.Role;
import com.jsict.biz.service.UserService;
import com.jsict.framework.core.controller.AbstractGenericController;
import com.jsict.biz.model.User;

import com.jsict.framework.core.controller.CSRFTokenManager;
import com.jsict.framework.core.controller.Response;
import com.jsict.framework.core.controller.RestControllerException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.web.bind.annotation.*;
import org.springframework.stereotype.Controller;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


/**
 * Auto-Generated by UDP Generator
 */
@Controller
@RequestMapping("/user")
public class UserController extends
    AbstractGenericController<User, String,
            User> {

    private static final Logger logger = LoggerFactory.getLogger(UserController.class);

    @Autowired
    private UserDao userDao;

    @Autowired
    private DepartmentDao departmentDao;

   /**
    *
    * 功能描述: 保存用户
    *
    * @param:
    * @return: 
    * @auther: Lv
    * @date: 2019/2/25 15:39
    */
    @Override
    @RequestMapping(value = "/save", method = RequestMethod.POST, produces = "application/json")
    @ResponseBody
    public Response save(@ModelAttribute User entity, @RequestParam(value = CSRFTokenManager.CSRF_PARAM_NAME) String paramToken, HttpServletRequest request){
        Map<String,Object> params = new HashMap<>();
        params.put("delFlag",0);
        params.put("userId",entity.getUserId());
        List<User> list = userDao.getObjectListBySqlKey("getListByUserId",params,User.class);
        if(list != null && list.size() > 0){
            return new Response(ERROR,"用户名已经存在");
        }
        return super.save(entity, paramToken, request);
    }

    /**
     *
     * 功能描述: 编辑用户
     *
     * @param:
     * @return:
     * @auther: Lv
     * @date: 2019/2/25 16:56
     */
    @Override
    @RequestMapping(value = "/update", method = RequestMethod.POST, produces = "application/json")
    @ResponseBody
    public Response update(@ModelAttribute User entity, @RequestParam(value = CSRFTokenManager.CSRF_PARAM_NAME) String paramToken, HttpServletRequest request){
        User db = this.generiService.getWithoutDic(entity.getId());
        if(!entity.getUserId().equals(db.getUserId())){
            Map<String,Object> params = new HashMap<>();
            params.put("delFlag",0);
            params.put("userId",entity.getUserId());
            List<User> list = userDao.getObjectListBySqlKey("getListByUserId",params,User.class);
            if(list != null && list.size() > 0){
                return new Response(ERROR,"用户名已经存在");
            }
        }
        return super.update(entity, paramToken, request);
    }

    @RequestMapping(value = {"/getUserForUpdate/{id}"}, method = {RequestMethod.GET}, produces = {"application/json"})
    @ResponseBody
    public User get(@PathVariable String id) {
        try {
            User user = this.generiService.getWithoutDic(id);
            Map<String,Object> params = new HashMap<>();
            params.put("delFlag",0);
            params.put("type",user.getType());
            List<Department> list = departmentDao.getObjectListBySqlKey("getListByNameCode",params,Department.class);
            user.setSelectDeptList(list);
            return user;
        } catch (Exception var3) {
            logger.error("主键查询出错", var3);
            throw new RestControllerException("主键查询出错", var3);
        }
    }

    @ResponseBody
    @RequestMapping(value = "/clearUserLock", method = RequestMethod.POST)
    public Response clearUserLock(@RequestParam String id){
        try{
            ((UserService)generiService).clearUserLock(id);
            return new Response(0);
        }catch(Exception e){
            logger.debug("解除用户锁定出错", e);
            return new Response(-1, e.getMessage());
        }
    }

    @ResponseBody
    @RequestMapping(value = "/initPassword", method = RequestMethod.POST)
    public Response initPassword(@RequestParam String id){
        try{
            ((UserService)generiService).initPassword(id);
            return new Response(0);
        }catch(Exception e){
            logger.debug("初始化密码出错", e);
            return new Response(-1, e.getMessage());
        }
    }

    @Override
    @RequestMapping(value = "/page", method = RequestMethod.POST, produces = "application/json")
    @ResponseBody
    public Page<User> page(@ModelAttribute User query, @PageableDefault Pageable pageable){
        try{
            return generiService.findByPage(query, pageable);
        }catch(Exception e){
            logger.error("翻页查询出错", e);
            throw new RestControllerException("翻页查询出错", e);
        }
    }

    /**
     *
     * 功能描述: 获取所有科室部门
     *
     * @param:
     * @return:
     * @auther: Lv
     * @date: 2019/2/23 17:41
     */
    @RequestMapping(value = "/getDept", method = RequestMethod.GET, produces = "application/json")
    @ResponseBody
    public List<Department> getDept(){
        Map<String,Object> params = new HashMap<>();
        params.put("delFlag",0);
        List<Department> list = departmentDao.getObjectListBySqlKey("getListByNameCode",params,Department.class);
        return list;
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

    @ResponseBody
    @RequestMapping(value = "/enable", method = RequestMethod.POST)
    public Response enable(@RequestParam String id){
        try{
            ((UserService)generiService).enable(id);
            return new Response(0);
        }catch(Exception e){
            logger.debug("激活用户出错", e);
            return new Response(-1, e.getMessage());
        }
    }

    @ResponseBody
    @RequestMapping(value = "/disable", method = RequestMethod.POST)
    public Response disable(@RequestParam String id){
        try{
            ((UserService)generiService).disable(id);
            return new Response(0);
        }catch(Exception e){
            logger.debug("禁用用户出错", e);
            return new Response(-1, e.getMessage());
        }
    }

    @RequestMapping(value = "/queryUsers", method = RequestMethod.GET, produces = "application/json")
    @ResponseBody
    public List<Role> queryUsers(@RequestParam String userQuery){
        Map<String, Object> params = new HashMap<>();
        params.put("name", userQuery);
        params.put("userId",userQuery);
        return userDao.find("selectByPage", params);
    }

}