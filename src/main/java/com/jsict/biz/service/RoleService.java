package com.jsict.biz.service;

import com.jsict.framework.core.service.GeneriService;
import com.jsict.biz.model.Role;

import java.util.List;

/**
 * Auto-Generated by UDP Generator
 */
public interface RoleService extends GeneriService<Role, String> {

    /**
     * 保存模块的角色
     *
     * @param moduleIds
     * @param roleId
     */
    void saveModuleRole(List<String> moduleIds, String roleId);

    /**
     * 保存模块的角色
     *
     */
    List<Role> selectAll();
}