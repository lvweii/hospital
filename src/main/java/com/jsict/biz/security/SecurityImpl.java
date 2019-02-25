package com.jsict.biz.security;

import com.jsict.biz.dao.ModuleDao;
import com.jsict.biz.model.Department;
import com.jsict.biz.model.Module;
import com.jsict.biz.model.Role;
import com.jsict.biz.model.User;
import com.jsict.biz.service.ModuleService;
import com.jsict.biz.service.UserService;
import com.jsict.framework.core.security.SecurityService;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.config.Ini;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

/**
 * Created by caron on 2017/5/9.
 */
public class SecurityImpl implements SecurityService<User> {

    private static final String MODULE_IN_ROLE_SQL = "select m.module_addr as module_addr from module_in_role mir left join module m on m.id = mir.module_id where role_id in (:roleIds)";

    private static final String MODULE_IN_OPEN = "select m.module_addr as module_addr from module m  where m.is_public = 1";
    @Autowired
    private ModuleDao moduleDao;

    @Autowired
    private ModuleService moduleService;

    @Autowired
    private UserService userService;

    @Transactional(readOnly = true)
    @Override
    public Ini.Section getFilterChainDefinitionFromDb(Ini.Section section) {
        List<Module> moduleList = moduleService.findAll();
        for(Module module: moduleList){
            String url = module.getModuleAddr();
            List<Role> roleList = module.getRoleList();
            if(StringUtils.isBlank(url) || (roleList==null || roleList.isEmpty()))
                continue;
            if(module.getStick()==null || module.getStick()==0){
                int pos = url.indexOf('?');
                if(pos!=-1)
                    url = url.substring(0, pos) + "**";
                else
                    url = url + "**";
            }
            StringBuilder sb = new StringBuilder("authc, roleOrFilter[");
            for(Role role: roleList){
                sb.append(role.getRoleName());
                sb.append(",");
            }
            sb.deleteCharAt(sb.length()-1);
            sb.append("]");
            section.put(url, sb.toString());
        }
        return section;
    }

    @Transactional(readOnly = true)
    @Override
    public User login(String userid, String password) {
        User query = new User(userid, password);
        User user = userService.singleResult(query);
        if(user==null)
            throw new SecurityException("用户名或密码错误");
        String msg = userService.doErrorPassword(userid, false);
        if(StringUtils.isNotBlank(msg))
            throw new SecurityException(msg);
        if(user.getDepartment().getEnable()!=1)
            throw new SecurityException("用户所在部门被禁用，用户禁止登录");
        if(user.getEnable()!=1)
            throw new SecurityException("用户被禁用");
        return user;
    }

    @Transactional(readOnly = true)
    @Override
    public AuthorizationInfo getAuthorizationInfoByUser(User user) {
        SimpleAuthorizationInfo authorizationInfo = new SimpleAuthorizationInfo();
        List<Role> roles = user.getRoleList();
        Department dept = user.getDepartment();
        if(dept.getDeptRoleList()!=null)
            roles.addAll(dept.getDeptRoleList());
        List<Department> departmentList = user.getDeptList();
        if(departmentList!=null && !departmentList.isEmpty()){
            for(Department department: departmentList){
                if(department.getDeptRoleList()!=null)
                    roles.addAll(department.getDeptRoleList());
            }
        }
        List<String> roleIds = new ArrayList<>();
        List<Role> roleList = new ArrayList<>();
        for(Role role: roles) {
            if(role.getAdmin()!=null && role.getAdmin())
                user.setAdmin(true);
            authorizationInfo.addRole(role.getRoleName());
            if(!roleIds.contains(role.getId()))
                roleIds.add(role.getId());
            if(!roleList.contains(role))
                roleList.add(role);
        }
        user.setRoleList(roleList);
        Map<String, Object> param = new HashMap<>();
        param.put("roleIds", roleIds);
        List<Map> list;
        if (roleIds.size() != 0)
            list = moduleDao.getListBySql(MODULE_IN_ROLE_SQL, param);
        else
            list = moduleDao.getListBySql(MODULE_IN_OPEN, null);
        List<String> permosisons = new ArrayList<>();
        for(Map map: list){
            permosisons.add((String)map.get("module_addr"));
        }
        authorizationInfo.addStringPermissions(permosisons);
        return authorizationInfo;
    }

    @Transactional(readOnly = true)
    @Override
    public User getUserByUserid(String userid) {
        User query = new User(userid);
        return userService.singleResult(query);
    }
}
