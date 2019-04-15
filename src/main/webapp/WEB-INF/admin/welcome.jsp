<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ page import="com.jsict.framework.core.security.model.IUser" %>
<%@ page import="org.apache.shiro.SecurityUtils" %>
<%@ page import="com.jsict.biz.model.User" %>
<%@include file="header.jsp"%>
<%
    IUser user = (IUser)SecurityUtils.getSubject().getPrincipal();
    User u = (User) user;
    if (u != null){
        request.setAttribute("username", u.getUserId());
    }else{
        request.setAttribute("username", "");
    }

%>
<style>
    .layadmin-carousel {
        height: auto !important;
    }
</style>
<div class="layui-fluid">
    <div class="layui-row layui-col-space15">
        <div class="layui-col-md6">
            <div class="layui-row layui-col-space15">
                <!-- 快捷方式 -->
                <div class="layui-col-md12">
                    <div class="layui-card">
                        <div class="layui-card-header">快捷方式</div>
                        <div class="layui-card-body">
                            <div class="layui-carousel layadmin-carousel layadmin-shortcut">
                                <ul class="layui-row layui-col-space10">
                                    <shiro:hasAnyRoles name="admin">
                                        <li class="layui-col-xs3">
                                            <a lay-href="${ctxPath}/user/?method=page"><i class="layui-icon layui-icon-user"></i><cite>用户管理</cite></a>
                                        </li>
                                    </shiro:hasAnyRoles>
                                    <shiro:hasAnyRoles name="admin">
                                        <li class="layui-col-xs3">
                                            <a lay-href="${ctxPath}/dept/?method=page"><i class="layui-icon layui-icon-layouts"></i><cite>科室管理</cite></a>
                                        </li>
                                    </shiro:hasAnyRoles>
                                    <shiro:hasAnyRoles name="admin,patient">
                                        <li class="layui-col-xs3">
                                            <a lay-href="${ctxPath}/register/?method=page"><i class="layui-icon layui-icon-date"></i><cite>预约挂号</cite></a>
                                        </li>
                                    </shiro:hasAnyRoles>
                                    <shiro:hasAnyRoles name="admin,patient">
                                        <li class="layui-col-xs3">
                                            <a lay-href="${ctxPath}/register/?method=patientPage"><i class="layui-icon layui-icon-log"></i><cite>我的预约</cite></a>
                                        </li>
                                    </shiro:hasAnyRoles>
                                    <shiro:hasAnyRoles name="admin,doctor">
                                        <li class="layui-col-xs3">
                                            <a lay-href="${ctxPath}/doc/?method=doctorPage"><i class="layui-icon layui-icon-chart"></i><cite>门诊诊断</cite></a>
                                        </li>
                                    </shiro:hasAnyRoles>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- 我的预约 -->
                <shiro:hasAnyRoles name="admin,patient">
                    <div class="layui-col-md12">
                        <div class="layui-card">
                            <div class="layui-card-header">我的预约</div>
                            <div class="layui-card-body">
                                <table id="registerTable" lay-filter="registerTable"></table>
                            </div>
                        </div>
                    </div>
                </shiro:hasAnyRoles>
                <shiro:hasAnyRoles name="doctor">
                    <div class="layui-col-md12">
                        <div class="layui-card">
                            <div class="layui-card-header">门诊诊断</div>
                            <div class="layui-card-body">
                                <table id="registerTable2" lay-filter="registerTable2"></table>
                            </div>
                        </div>
                    </div>
                </shiro:hasAnyRoles>
            </div>
        </div>
        <div class="layui-col-md6">
            <div class="layui-row layui-col-space15">
                <!-- 数据统计 -->
                <div class="layui-col-md12">
                    <div class="layui-card">
                        <div class="layui-card-header">数据统计</div>
                        <div class="layui-card-body">
                            <div class="layui-carousel layadmin-carousel layadmin-backlog">
                                <div class="carousel-item">
                                    <ul class="layui-row layui-col-space10 layui-this">
                                        <shiro:hasAnyRoles name="admin,patient">
                                            <li class="layui-col-xs3">
                                                <a class="layadmin-backlog-body">
                                                    <h3>待就诊</h3><p><cite id="n1">-</cite></p>
                                                </a>
                                            </li>
                                            <li class="layui-col-xs3">
                                                <a class="layadmin-backlog-body">
                                                    <h3>已就诊</h3><p><cite id="n2">-</cite></p>
                                                </a>
                                            </li>
                                            <li class="layui-col-xs3">
                                                <a class="layadmin-backlog-body">
                                                    <h3>已退号</h3><p><cite id="n3">-</cite></p>
                                                </a>
                                            </li>
                                            <li class="layui-col-xs3">
                                                <a class="layadmin-backlog-body">
                                                    <h3>过期</h3><p><cite id="n4">-</cite></p>
                                                </a>
                                            </li>
                                        </shiro:hasAnyRoles>
                                        <shiro:hasAnyRoles name="admin,doctor">
                                            <li class="layui-col-xs3">
                                                <a class="layadmin-backlog-body">
                                                    <h3>待诊断</h3><p><cite id="n5">-</cite></p>
                                                </a>
                                            </li>
                                            <li class="layui-col-xs3">
                                                <a class="layadmin-backlog-body">
                                                    <h3>已诊断</h3><p><cite id="n6">-</cite></p>
                                                </a>
                                            </li>
                                            <li class="layui-col-xs3">
                                                <a class="layadmin-backlog-body">
                                                    <h3>已退号</h3><p><cite id="n7">-</cite></p>
                                                </a>
                                            </li>
                                            <li class="layui-col-xs3">
                                                <a class="layadmin-backlog-body">
                                                    <h3>过期</h3><p><cite id="n8">-</cite></p>
                                                </a>
                                            </li>
                                        </shiro:hasAnyRoles>
                                        <shiro:hasAnyRoles name="admin,patient">
                                            <li class="layui-col-xs3">
                                                <a class="layadmin-backlog-body">
                                                    <h3>信用分</h3><p><cite id="n9">-</cite></p>
                                                </a>
                                            </li>
                                        </shiro:hasAnyRoles>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- 门诊诊断 -->
                <shiro:hasAnyRoles name="admin">
                    <div class="layui-col-md12">
                        <div class="layui-card">
                            <div class="layui-card-header">门诊诊断</div>
                            <div class="layui-card-body">
                                <table id="registerTable2" lay-filter="registerTable2"></table>
                            </div>
                        </div>
                    </div>
                </shiro:hasAnyRoles>
                <!-- 指令处理 -->
                <shiro:hasAnyRoles name="bqgcsz_sz,bqgcsz,bqgtz_sz,bqgtz,zztz_sz,zztz,ythkzz_sz,ythkzz,fjhz_sz,fjhz,httz_sz,httz,zttz_sz,zttz">
                    <div class="layui-col-md12">
                        <div class="layui-card">
                            <div class="layui-card-header">指令处理</div>
                            <div class="layui-card-body">
                                <table id="orderCaseTable" lay-filter="orderCaseTable"></table>
                            </div>
                        </div>
                    </div>
                </shiro:hasAnyRoles>
            </div>
        </div>
    </div>


</div>
<%@include file="footer.jsp"%>
<script>
  layui.config({
    base: '${ctxPath}/resources/layuiadmin/' //静态资源所在路径
  }).extend({
    index: 'lib/index' //主入口模块
  }).use(['laypage', 'carousel', 'index','element','table'],function(){

    var carousel = layui.carousel,
        table = layui.table,
        laypage = layui.laypage,
        $ = layui.jquery;

    //待办事项数目数量
    $.ajax({
      url: "${ctxPath}/welcome/getNum",
      type: "post",
      data:{},
      dataType: "json",
      success: function(data){
        $("#n1").text(data.n1);
        $("#n2").text(data.n2);
        $("#n3").text(data.n3);
        $("#n4").text(data.n4);
        $("#n5").text(data.n5);
        $("#n6").text(data.n6);
        $("#n7").text(data.n7);
        $("#n8").text(data.n8);
        $("#n9").text(data.n9);
      }
    });

    table.render({
      elem: '#registerTable'
      , cols: [[
        {type: 'numbers',  fixed: true}
        , {field: '', title: '患者姓名', width: 100,templet: function(d){
            return d.patient.name;
          }}
        , {field: '', title: '科室名称', width: 100,templet: function(d){
            return d.doctor.department.deptName;
          }}
        , {field: '', title: '医生姓名', width: 100,templet: function(d){
            return d.doctor.name;
          }}
        , {field: 'chooseDate', title: '预约日期', width: 120}
        , {field: 'am', title: '上/下午', width: 80,templet: function(d){
            if (d.am == '0') {
              return '上午';
            }else if (d.am == '1'){
              return '下午';
            }
          }}
        , {field: 'timeRange', title: '时间段', width: 120,templet: function(d){
            if (d.timeRange == '1') {return '08:00-09:00';}
            else if (d.timeRange == '2'){return '09:00-10:00';}
            else if (d.timeRange == '3'){return '10:00-11:00';}
            else if (d.timeRange == '4'){return '11:00-12:00';}
            else if (d.timeRange == '5'){return '14:00-15:00';}
            else if (d.timeRange == '6'){return '15:00-16:00';}
            else if (d.timeRange == '7'){return '16:00-17:00';}
            else if (d.timeRange == '8'){return '17:00-18:00';}
          }}
        , {field: 'rangeSort', title: '就诊号', width: 80}
        , {field: 'status', title: '状态', width: 80,templet: function(d){
            if (d.status == '0') {
              return '待就诊';
            }else if (d.status == '1'){
              return '已就诊';
            }else if (d.status == '2'){
              return '已退号';
            }else if (d.status == '3'){
              return '过期';
            }
          }}
      ]]
      , url: '${ctxPath}/register/patientRegisterPage'
      , method: 'post'
      , page: true
      , request: {
        limitName: "size"
      }
      , response: {
        countName: "totalElements",
        dataName: "content"
      }
      , limits: [10, 20, 30]
      , limit: 10
    });

    table.render({
      elem: '#registerTable2'
      , cols: [[
        {type: 'numbers',  fixed: true}
        , {field: '', title: '患者姓名', width: 100,templet: function(d){
            return d.patient.name;
          }}
        , {field: '', title: '科室名称', width: 100,templet: function(d){
            return d.doctor.department.deptName;
          }}
        , {field: '', title: '医生姓名', width: 100,templet: function(d){
            return d.doctor.name;
          }}
        , {field: 'chooseDate', title: '预约日期', width: 120}
        , {field: 'am', title: '上/下午', width: 80,templet: function(d){
            if (d.am == '0') {
              return '上午';
            }else if (d.am == '1'){
              return '下午';
            }
          }}
        , {field: 'timeRange', title: '时间段', width: 120,templet: function(d){
            if (d.timeRange == '1') {return '08:00-09:00';}
            else if (d.timeRange == '2'){return '09:00-10:00';}
            else if (d.timeRange == '3'){return '10:00-11:00';}
            else if (d.timeRange == '4'){return '11:00-12:00';}
            else if (d.timeRange == '5'){return '14:00-15:00';}
            else if (d.timeRange == '6'){return '15:00-16:00';}
            else if (d.timeRange == '7'){return '16:00-17:00';}
            else if (d.timeRange == '8'){return '17:00-18:00';}
          }}
        , {field: 'rangeSort', title: '就诊号', width: 80}
        , {field: 'status', title: '状态', width: 80,templet: function(d){
            if (d.status == '0') {
              return '待就诊';
            }else if (d.status == '1'){
              return '已就诊';
            }else if (d.status == '2'){
              return '已退号';
            }else if (d.status == '3'){
              return '过期';
            }
          }}
      ]]
      , url: '${ctxPath}/doc/doctorRegisterPage'
      , method: 'post'
      , page: true
      , request: {
        limitName: "size"
      }
      , response: {
        countName: "totalElements",
        dataName: "content"
      }
      , limits: [10, 20, 30]
      , limit: 10
    });

  })

</script>