package com.jsict.biz.service;

import com.jsict.framework.core.service.GeneriService;
import com.jsict.biz.model.User;
import java.util.List;

/**
 * Auto-Generated by UDP Generator
 */
public interface UserService extends GeneriService<User, String> {

    /**
     * 初始化密码
     *
     * @param id
     * @return
     */
    User initPassword(String id);

    /**
     * 修改密码
     *
     * @param id
     * @param newPassword
     * @param oldPassword
     * @return
     */
    User changePassword(String id, String oldPassword, String newPassword);

    /**
     * 用户密码错误后判断是否需要锁定
     *
     * @param userId
     * @param increase
     * @return
     */
    String doErrorPassword(String userId, Boolean increase);

    /**
     * 清除用户锁定
     *
     * @param id
     */
    void clearUserLock(String id);

    /**
     * 激活用户
     *
     * @param id
     */
    void enable(String id);

    /**
     * 禁用用户
     *
     * @param id
     */
    void disable(String id);

    List<User> findAll();

    void addScore(String userId,int score);
}
