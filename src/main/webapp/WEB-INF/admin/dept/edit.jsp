<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@include file="../header.jsp" %>
<div class="layui-fluid"  style="padding: 20px;">
<form class="layui-form layui-form-pane" action="" id="departmentForm" lay-filter="deptForm">
    <input id="id" name="id" type="hidden">
    <input name="CSRFToken" type="hidden" value="${CSRFToken}">
    <div class="layui-form-item">
        <label class="layui-form-label">科室名称<label style="color:red;">*</label></label>
        <div class="layui-input-block">
            <input class="layui-input" type="text" name="deptName" id="deptName" lay-verify="required|deptName" placeholder="请输入科室名称"/>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">科室编码<label style="color:red;">*</label></label>
        <div class="layui-input-block">
            <input class="layui-input" type="text" name="deptCode" id="deptCode" lay-verify="required|deptCode" placeholder="请输入科室编码"/>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">排序<label style="color:red;">*</label></label>
        <div class="layui-input-block">
            <input class="layui-input" type="text" name="sort" id="sort" lay-verify="required|sort" placeholder="请输入"/>
        </div>
    </div>
    <div class="layui-form-item layui-form-text">
        <label class="layui-form-label">科室简介<label style="color:red;">*</label></label>
        <div class="layui-input-block">
            <textarea class="layui-textarea" id="instruction" name="instruction" rows="6" lay-verify="instruction|required" placeholder="请输入科室简介"></textarea>
        </div>
    </div>
    <div class="layui-form-item layui-hide">
        <input type="button" lay-submit lay-filter="layuiadmin-app-form-submit" id="layuiadmin-app-form-submit" value="提交">
    </div>
</form>
</div>
<script>
    layui.config({
        base: '${ctxPath}/resources/layuiadmin/' //静态资源所在路径
    }).extend({
        index: 'lib/index' //主入口模块
    }).use(['tree', 'index', 'form', 'table', 'layer'], function () {
        var table = layui.table
            , form = layui.form
            , $ = layui.jquery;

        var id = "${id}";
        if (id !== "") {
            editdept();
        }
        //根据id获取科室详情
        function editdept() {
            var dt = (new Date()).getTime();
            $.ajax({
                url: "./get/" + id,
                dataType: "json",
                type: "get",
                data: {
                    dt: dt
                },
                success: function (data) {
                    $("#id").val(data.id);
                    $("#deptCode").val(data.deptCode);
                    $("#deptName").val(data.deptName);
                    $("#sort").val(data.sort);
                    $("#instruction").val(data.instruction);
                },
                error: function () {
                    //获取科室失败
                }
            });
        }


        //字段自定义验证
        form.verify({
            deptName:[/^([\u4E00-\u9FA5A-Za-z0-9]){0,10}$/, '科室名称必须是长度小于10的字符,且不能有特殊符号'],
            deptCode:[/^[0-9]{3}$/,'科室编码必须是三位数字'],
            sort: function (value) {
                if (value<1 || value >99) {
                    return '排序必须1到99位';
                }else if(isNaN(value)){
                    return '排序必须为整数';
                }
            },
            instruction:function (value) {
              if (value.length >100) {
                return '科室简介长度必须小于100';
              }
            },
        });

        //新增、编辑

        //监听提交
        form.on('submit(layuiadmin-app-form-submit)', function (e) {
                <c:if test="${empty id}">var url = "./save";
            </c:if>
                <c:if test="${not empty id}">var url = "./update";
            </c:if>

            $("#departmentForm").ajaxSubmit({
                type: "post",
                url: url,
                dataType: "json",
                success: function (data) {
                    if (data.responseCode == 0) {
                        //提交成功
                        parent.layui.layer.msg("提交成功");
                        backToList();
                        parent.layui.table.reload('departmentTable'); //重载表格
                    } else {
                        layer.msg(data.msg);
                    }
                },
                error: function () {
                    alert("error!");
                }
            });
            return false;
        });

    });

    function backToList() {
        var index = parent.layer.getFrameIndex(window.name);
        parent.layer.close(index);
    }

</script>
<script type="text/javascript" src="${ctxPath}/resources/js/jquery.js"></script>
<script type="text/javascript" src="${ctxPath}/resources/js/jquery.form.min.js"></script>

<%@include file="../footer.jsp" %>
