package com.jsict.biz.service.impl;

import com.jsict.biz.dao.DepartmentDao;
import com.jsict.biz.dao.UserDao;
import com.jsict.biz.model.Department;
import com.jsict.biz.model.User;
import com.jsict.biz.service.UserService;
import com.jsict.framework.core.controller.RestControllerException;
import com.jsict.framework.core.service.impl.GeneriServiceImpl;
import com.jsict.framework.utils.Encodes;
import com.jsict.framework.utils.SysConfig;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;

/**
 * Auto-Generated by UDP Generator
 */
@Service("userService")
public class UserServiceImpl extends GeneriServiceImpl<User, String> implements UserService {

    @Autowired
    private DepartmentDao departmentDao;

    @Autowired
    private UserDao userDao;

    @Autowired
    private SysConfig sysConfig;

    /**
     * 添加userId唯一性校验
     *
     * @param entity  实体
     * @return
     */
    @Override
    @Transactional
    public User save(User entity) {
//        User query = new User();
//        query.setUserId(entity.getUserId());
//        User user = singleResult(query);
//        if(user!=null)
//            throw new RestControllerException("用户名已经存在");
        return super.save(entity);
    }

    /**
     * 添加userId唯一性校验
     *
     * @param entity  实体
     * @return
     */
    @Override
    @Transactional
    public User update(User entity) {
//        User db = super.get(entity.getId());
//        if (!entity.getUserId().equals(db.getUserId())){
//            User query = new User();
//            query.setUserId(entity.getUserId());
//            User user = singleResult(query);
//            if(user!=null)
//                throw new RestControllerException("用户名已经存在");
//        }
        return super.update(entity);
    }

    /**
     * @param id  主键
     * @return
     */
    @Override
    @Transactional(readOnly = true)
    public User get(String id){
        User user = super.get(id);
        if(StringUtils.isNotBlank(user.getDeptId())){
            Department department = departmentDao.getById(user.getDeptId());
            user.setDepartment(department);
        }
        return user;
    }

    @Override
    @Transactional
    public User changePassword(String id, String oldPassword, String newPassword) {
        User user = get(id);
        if(Encodes.encodeMD5(oldPassword).equals(user.getPassword())){
            user.setPassword(Encodes.encodeMD5(newPassword));
            user.setLastChangePwdTime(user.getUpdatedDate());
            return update(user);
        }else
            throw new SecurityException("密码错误");
    }

    @Override
    @Transactional
    public String doErrorPassword(String userId, Boolean increase) {
        User query = new User();
        query.setUserId(userId);
        User user = singleResult(query);
        if(null != user){
            if(user.getGender().contains("|")){
                String[] genders = user.getGender().split("\\|");
                user.setGender(genders[2]);
            }
            Integer errorTimes = user.getPasswordErrorTimes();
            Date lastErrorTime = user.getLastPasswordErrorTime();
            Date now = new Date();
            if(null == errorTimes)
                errorTimes = 0;
            if(null == lastErrorTime)
                lastErrorTime = now;
            long interval = (now.getTime()/60000) - (lastErrorTime.getTime()/60000);
            Integer maxErrorTimes = sysConfig.getConfig().getInt("passwordMaxErrorTimes");
            Integer maxLockTime = sysConfig.getConfig().getInt("passwordMaxLockedTime");
            if(interval > maxLockTime)
                errorTimes = 0;
            if(errorTimes >= maxErrorTimes)
                return "对不起，因为您输入的密码已经多次错误，该账号将被锁定" + maxLockTime + "分钟。";
            if(increase){
                errorTimes++;
                user.setPasswordErrorTimes(errorTimes);
                user.setLastPasswordErrorTime(now);
                update(user);
            }
        }
        return null;
    }

    @Override
    @Transactional
    public void clearUserLock(String id) {
        User user = get(id);
        user.setLastPasswordErrorTime(null);
        user.setPasswordErrorTimes(0);
        update(user);
    }

    @Override
    @Transactional
    public User initPassword(String id) {
        User user = get(id);
        String password = sysConfig.getConfig().getString("defaultPassword");
        user.setPassword(Encodes.encodeMD5(password));
        return update(user);
    }

    @Transactional
    @Override
    public void enable(String id) {
        troggleEnable(id, 1);
    }

    @Transactional
    @Override
    public void disable(String id) {
        troggleEnable(id, 0);
    }

    @Override
    public List<User> findAll() {
        Map<String, Object> params = new HashMap<>();
        params.put("delFlag", 0);
        return genericDao.findByProperty(params);
    }

    @Transactional
    @Override
    public void addScore(String userId,int score){
        try {
            User loginUser = (User)SecurityUtils.getSubject().getPrincipal();
            User user = this.getWithoutDic(userId);
            if (loginUser != null) {
                user.setUpdaterId(loginUser.getId());
            }
            user.setUpdatedDate(new Date());
            user.setScore(user.getScore() + score);
            updateScore(user);
        }catch (Exception e){
            e.printStackTrace();
        }
    }

    @Transactional
    public User updateScore(User user) {
        return userDao.updateScore(user);
    }

    private void troggleEnable(String id, Integer enable){
        User user = get(id);
        user.setEnable(enable);
        genericDao.update(user);
    }
}
