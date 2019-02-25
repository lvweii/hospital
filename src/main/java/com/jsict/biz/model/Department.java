package com.jsict.biz.model;

import com.jsict.framework.core.dao.annotation.LogicDel;
import com.jsict.framework.core.model.BaseEntity;
import com.jsict.framework.core.security.model.IDepartment;
import java.util.ArrayList;
import java.util.List;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.validation.constraints.Max;
import org.hibernate.validator.constraints.NotBlank;


/**
 * Department ：科室
 *
 * @author Lv
 * @since 2019/2/22 17:13
 */
@Entity
@LogicDel
@Table(name = "department")
public class Department extends BaseEntity<String> implements IDepartment<Department, Role> {

    /** 科室编码 */
    @Column(name = "dept_code", length = 300, nullable = false)
    private String deptCode;

    /** 科室名称 */
    @NotBlank(message="科室名称不能为空")
    @Column(name = "dept_name", length = 100, nullable = false)
    private String deptName;

    /** 排序 */
    @Max(value = 99, message = "排序必须小于99")
    @Column(name = "sort", length = 2)
    private Integer sort;

    /** 上级科室（暂未用到） */
    @Column(name = "parent_dept_id", length = 32)
    private String parentDeptId;

    @Column(name = "enable", length = 1)
    private Integer enable = 1;

    @Column(name = "content", length = 255)
    private String content;

    @Column(name = "type", length = 10)
    private String type;

    @Column(name = "instruction", length = 500)
    private String instruction;

    /** 部门所有角色 */
    @ManyToMany(fetch = FetchType.EAGER)
    @JoinTable(name = "department_in_role",
        joinColumns = {
            @JoinColumn(name = "dept_id")
        },
        inverseJoinColumns = {
            @JoinColumn(name = "role_id")
        }
    )
    private List<Role> deptRoleList = new ArrayList<>();

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "parent_dept_id", insertable = false, updatable = false)
    private Department parentDept;


    public Department(){
        // default constractor
    }

    public Department(String id){
        this.id = id;
    }

    public Department(String id, String deptCode, String deptName, Integer sort, Integer enable) {
        this.id = id;
        this.deptCode = deptCode;
        this.deptName = deptName;
        this.sort = sort;
        this.enable = enable;
    }

    public void setDeptCode(String deptCode){
        this.deptCode = deptCode;
    }

    public String getDeptCode(){
        return this.deptCode;
    }
    public void setDeptName(String deptName){
        this.deptName = deptName;
    }

    public String getDeptName(){
        return this.deptName;
    }
    public void setParentDeptId(String parentDeptId){
        this.parentDeptId = parentDeptId;
    }

    public String getParentDeptId(){
        return this.parentDeptId;
    }

    public Integer getSort() {
        return sort;
    }

    public void setSort(Integer sort) {
        this.sort = sort;
    }

    public Integer getEnable() {
        return enable;
    }

    public void setEnable(Integer enable) {
        this.enable = enable;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public List<Role> getDeptRoleList() {
        return deptRoleList;
    }

    public void setDeptRoleList(List<Role> deptRoleList) {
        this.deptRoleList = deptRoleList;
    }

    @Override
    public Department getParentDept() {
        return parentDept;
    }

    @Override
    public void setParentDept(Department parentDept) {
        this.parentDept = parentDept;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getInstruction() {
        return instruction;
    }

    public void setInstruction(String instruction) {
        this.instruction = instruction;
    }
}