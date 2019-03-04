<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@include file="../header.jsp" %>
<div class="layui-fluid"  style="padding: 20px;">
<form class="layui-form" action="" id="departmentForm" lay-filter="deptForm">
    <input id="id" name="id" type="hidden">
    <input name="CSRFToken" type="hidden" value="${CSRFToken}">
    <div class="layui-form-item" style="margin-bottom: 0px;">
        <label class="layui-form-label" style="padding: 4px 15px 4px 0px;width: 60px;">姓名：</label>
        <div class="layui-input-block" style="margin-left: 75px">
            <label class="layui-form-label" style="text-align: left;padding: 4px 0px;width: 200px;">医生一</label>
            <input class="layui-input" type="hidden" name="doctorId" id="doctor_id" />
        </div>
    </div>
    <div class="layui-form-item" style="margin-bottom: 0px;">
        <label class="layui-form-label" style="padding: 4px 15px 4px 0px;width: 60px;">科室：</label>
        <div class="layui-input-block" style="margin-left: 75px">
            <label class="layui-form-label" style="text-align: left;padding: 4px 0px;width: 200px;">内科</label>
        </div>
    </div>
    <div class="layui-form-item" style="margin-bottom: 0px;">
        <label class="layui-form-label" style="padding: 4px 15px 4px 0px;width: 60px;">职称：</label>
        <div class="layui-input-block" style="margin-left: 75px">
            <label class="layui-form-label" style="text-align: left;padding: 4px 0px;width: 200px;">主任医师</label>
        </div>
    </div>
    <div class="layui-collapse" lay-accordion style="margin-left: 8px;margin-bottom: 15px;">
        <div class="layui-colla-item">
            <h2 class="layui-colla-title" style="background-color: #F2F2D3">医生简介</h2>
            <div class="layui-colla-content layui-show">
                <span>以下文件请上传.docx格式的模板，如为.doc格式，请另存为.docx格式后再上传！（请勿直接修改后缀名）</span>
            </div>
        </div>
    </div>
    <div class="layui-collapse" lay-accordion style="margin-left: 8px;margin-bottom: 30px;">
        <div class="layui-colla-item">
            <h2 class="layui-colla-title" style="background-color: #F2F2D3">擅长</h2>
            <div class="layui-colla-content layui-show">
                <span>以下文件请上传.docx格式的模板，如为.doc格式，请另存为.docx格式后再上传！（请勿直接修改后缀名）</span>
            </div>
        </div>
    </div>

    <div class="layui-form-item" style="margin-bottom: 0px;">
        <label class="layui-form-label" style="padding: 4px 15px 4px 0px;width: 100px;"><h2>班表信息</h2></label>
    </div>

    <table class="layui-table" style="width: 100%" id="week">
        <colgroup>
            <col span="1" width="100">
            <col span="1" width="100">
            <col span="1" width="200">
            <col span="1" width="50">
        </colgroup>
        <thead>
        <tr style="background-color: #F2F2D3">
            <th>科室</th>
            <th>星期</th>
            <th>时间段</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <td id="d1_1">消化科</td>
            <td id="d2_1">星期三 上午<br>2019-03-01</td>
            <td id="d3_1">
                <input type="radio" name="timeRange" value="1" title="08:00-09:00">
                <input type="radio" name="timeRange" value="2" title="09:00-10:00">
                <input type="radio" name="timeRange" value="3" title="10:00-11:00">
                <input type="radio" name="timeRange" value="4" title="11:00-12:00">
            </td>
            <td id="d4_1">
                <a class="layui-btn layui-btn-normal layui-btn-xs"><i
                    class="layui-icon layui-icon-survey"></i>预约</a>
            </td>
        </tr>
        <tr>
            <td id="d1_2">心血管科</td>
            <td id="d2_2">星期四 下午<br>2019-03-02</td>
            <td id="d3_2">
                <input type="radio" name="timeRange" value="5" title="14:00-15:00">
                <input type="radio" name="timeRange" value="6" title="15:00-16:00">
                <input type="radio" name="timeRange" value="7" title="16:00-17:00">
                <input type="radio" name="timeRange" value="8" title="17:00-18:00">
            </td>
            <td id="d4_2">
                <a class="layui-btn layui-btn-normal layui-btn-xs"><i
                        class="layui-icon layui-icon-survey"></i>预约</a>
            </td>
        </tr>
        </tbody>
    </table>

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
