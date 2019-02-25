<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@include file="header.jsp"%>

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
  })

</script>