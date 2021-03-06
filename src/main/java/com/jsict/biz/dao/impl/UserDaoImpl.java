package com.jsict.biz.dao.impl;

import com.jsict.biz.dao.UserDao;
import com.jsict.biz.model.User;
import com.jsict.framework.core.dao.hibernate.GenericHibernateDaoImpl;
import com.jsict.framework.core.security.model.IUser;
import com.jsict.framework.utils.Encodes;
import java.util.Date;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.springframework.stereotype.Repository;

/**
* Auto-Generated by UDP Generator
*/
@Repository
public class UserDaoImpl extends GenericHibernateDaoImpl<User, String> implements UserDao {

    @Override
    public User save(User user){
        user.setId(null);
        String defualtPassword = Encodes.encodeMD5(sysConfig.getConfig().getString("defaultPassword"));
        user.setPassword(defualtPassword);
        user.setScore(0);
        return super.save(user);
    }

    @Override
    public User update(User user){
        User dbUser = getById(user.getId());
        dbUser.setPhoto(user.getPhoto());
        dbUser.setSort(user.getSort());
        dbUser.setBirthday(user.getBirthday());
        dbUser.setDeptId(user.getDeptId());
        if(user.getGender().contains("|")){
            String[] genders = user.getGender().split("\\|");
            dbUser.setGender(genders[2]);
        }else
            dbUser.setGender(user.getGender());
        dbUser.setRoleList(user.getRoleList());
        dbUser.setMobile(user.getMobile());
        dbUser.setName(user.getName());
        dbUser.setDeptList(user.getDeptList());
        dbUser.setLastPasswordErrorTime(user.getLastPasswordErrorTime());
        dbUser.setPasswordErrorTimes(user.getPasswordErrorTimes());
        if(StringUtils.isNotBlank(user.getPassword()))
            dbUser.setPassword(user.getPassword());
        if(user.getType() != null && user.getType().contains("|")){
            String[] types = user.getType().split("\\|");
            dbUser.setType(types[2]);
        }else
            dbUser.setType(user.getType());
        if(user.getTitle() != null && user.getTitle().contains("|")){
            String[] titles = user.getTitle().split("\\|");
            dbUser.setTitle(titles[2]);
        }else
            dbUser.setTitle(user.getTitle());
        dbUser.setPhoto(user.getPhoto());
        dbUser.setInstruction(user.getInstruction());
        dbUser.setGood(user.getGood());
        dbUser.setTime(user.getTime());
        dbUser.setHourPeople(user.getHourPeople());
        dbUser.setUserId(user.getUserId());
        dbUser.setUpdatedDate(new Date());
        IUser iu = (IUser)SecurityUtils.getSubject().getPrincipal();
        if (iu != null) {
            dbUser.setUpdaterId(iu.getId());
        }
        return super.update(dbUser);
    }

    @Override
    public User updateScore(User user) {
        this.encodeEntity(user);
        this.entityManager.merge(user);
        return user;
    }
}
