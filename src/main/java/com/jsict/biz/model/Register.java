package com.jsict.biz.model;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.jsict.framework.core.dao.annotation.LogicDel;
import com.jsict.framework.core.model.BaseEntity;
import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

/**
 * Register ：
 *
 * @author Lv
 * @since 2019/2/28 20:09
 */
@Entity
@LogicDel
@Table(name = "register")
public class Register extends BaseEntity<String> {

  @Column(name = "user_id", length = 32)
  private String userId;

  @ManyToOne(fetch = FetchType.EAGER)
  @JoinColumn(name = "user_id", insertable = false, updatable = false)
  private User patient;

  @Column(name = "doctor_id", length = 32)
  private String doctorId;

  @ManyToOne(fetch = FetchType.EAGER)
  @JoinColumn(name = "doctor_id", insertable = false, updatable = false)
  private User doctor;

  @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone="GMT+8")
  @Column(name = "register_time")
  private Date registerTime;

  @JsonFormat(pattern = "yyyy-MM-dd", timezone="GMT+8")
  @Column(name = "choose_date")
  private Date chooseDate;

  @Column(name = "am", length = 2)
  private String am;

  @Column(name = "time_range", length = 2)
  private String timeRange;

  @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone="GMT+8")
  @Column(name = "finish_time")
  private Date finishTime;

  @Column(name = "status", length = 2)
  private String status;

  @Column(name = "sort", length = 3)
  private Integer sort;

  @Column(name = "range_sort", length = 10)
  private String rangeSort;

  @Transient
  private String date;

  @Transient
  private String deptId;

  public String getUserId() {
    return userId;
  }

  public void setUserId(String userId) {
    this.userId = userId;
  }

  public String getDoctorId() {
    return doctorId;
  }

  public void setDoctorId(String doctorId) {
    this.doctorId = doctorId;
  }

  public Date getRegisterTime() {
    return registerTime;
  }

  public void setRegisterTime(Date registerTime) {
    this.registerTime = registerTime;
  }

  public Date getChooseDate() {
    return chooseDate;
  }

  public void setChooseDate(Date chooseDate) {
    this.chooseDate = chooseDate;
  }

  public String getAm() {
    return am;
  }

  public void setAm(String am) {
    this.am = am;
  }

  public String getTimeRange() {
    return timeRange;
  }

  public void setTimeRange(String timeRange) {
    this.timeRange = timeRange;
  }

  public Date getFinishTime() {
    return finishTime;
  }

  public void setFinishTime(Date finishTime) {
    this.finishTime = finishTime;
  }

  public String getStatus() {
    return status;
  }

  public void setStatus(String status) {
    this.status = status;
  }

  public Integer getSort() {
    return sort;
  }

  public void setSort(Integer sort) {
    this.sort = sort;
  }

  public String getDate() {
    return date;
  }

  public void setDate(String date) {
    this.date = date;
  }

  public String getRangeSort() {
    return rangeSort;
  }

  public void setRangeSort(String rangeSort) {
    this.rangeSort = rangeSort;
  }

  public User getPatient() {
    return patient;
  }

  public void setPatient(User patient) {
    this.patient = patient;
  }

  public User getDoctor() {
    return doctor;
  }

  public void setDoctor(User doctor) {
    this.doctor = doctor;
  }

  public String getDeptId() {
    return deptId;
  }

  public void setDeptId(String deptId) {
    this.deptId = deptId;
  }
}
