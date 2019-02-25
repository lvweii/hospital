<%@ page import="com.jsict.framework.core.security.model.IUser" %>
<%@ page import="org.apache.shiro.SecurityUtils" %>
<%@ page import="com.jsict.biz.model.User" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@include file="../header.jsp" %>
<%
    IUser user = (IUser)SecurityUtils.getSubject().getPrincipal();
    User u = (User) user;
    String isadmin = "no";
    if(u.isAdmin())
    {
        isadmin = "yes";
    }
    request.setAttribute("isAdminConfig", isadmin);
%>
<script>
    function update()
    {
        var id = $('#id').val();
        var keyy = $('#keyy').val();
        var valuee = $('#valuee').val();
        $.ajax({
            url: "${ctxPath}/config/updateConfig",
            type: "post",
            data:{
                id: id,
                keyy: keyy,
                valuee: valuee,
                model:"update"
            },
            dataType: "json",
            success: function (data) {

            }
        });

    }
</script>

<link rel="stylesheet" href="${ctxPath}/resources/css/wangEditor.min.css">
    <form class="layui-form layui-form-pane" id="configForm" lay-filter="configForm" style="padding: 20px 30px 0 30px;">
        <input id="id" name="id" type="hidden" value="${id}">
        <input id="CSRFToken" name="CSRFToken" type="hidden" value="${CSRFToken}">
       <div class="layui-form-item">
    </div>
       <div class="layui-form-item">
    </div>
       <div class="layui-form-item">
    </div>
       <div class="layui-form-item">

               <div class="layui-inline">
                   <label class="layui-form-label">配置名称</label>
                   <div class="layui-input-inline">
                       <c:if test = "${empty id}" >
                           <input id="name" name="name" type="text" class="layui-input" >
                       </c:if>
                       <c:if test = "${not empty id}" >
                           <input id="name" name="name" type="text" class="layui-input" readonly>
                       </c:if>

                   </div>
               </div>
       </div>
        <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label">key</label>
                    <div class="layui-input-inline">
                        <c:if test = "${empty id}" >
                            <input id="keyy" name="keyy" type="text" class="layui-input" >
                        </c:if>
                        <c:if test = "${not empty id}" >
                            <input id="keyy" name="keyy" type="text" class="layui-input" readonly>
                        </c:if>

                    </div>
                </div>
        </div>
        <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label">value</label>
                    <div class="layui-input-inline">
                        <input id="valuee"
                               name="valuee"
                               type="text"
                               class="layui-input">
                    </div>
                </div>
    </div>

        <c:if test = "${isAdminConfig == 'yes'}" >
            <c:if test = "${level == '2'}" >
                <label class="layui-form-label">是否开放</label>
                <input type="checkbox"  name="levell" id="levell" value="2" title="开放" onclick="javascript:document.getElementById('public').value=this.checked;" checked>
                <input name="levell" type="hidden" value="1" id="public">
            </c:if>
            <c:if test = "${level != '2'}" >
                <label class="layui-form-label">是否开放</label>
                <input type="checkbox"  name="levell" id="levell" value="2" title="开放" onclick="javascript:document.getElementById('public').value=this.checked; ">
                <input name="levell" type="hidden" value="1" id="public">
            </c:if>
        </c:if>

        <div class="layui-form-item layui-hide">
            <input type="button" lay-submit lay-filter="layuiadmin-app-form-submit" id="layuiadmin-app-form-submit" value="提交">
        </div>
    </form>

<%@include file="../footer.jsp"%>
<script src="${ctxPath}/resources/js/ueditor.config.js"></script>
<script src="${ctxPath}/resources/js/ueditor.all.min.js"></script>
<script>
    layui.use(['form', 'layedit', 'laydate', 'tree','upload'], function () {
        var form = layui.form
                , layer = layui.layer
                , layedit = layui.layedit
                , laydate = layui.laydate
                , tree = layui.tree
                , upload = layui.upload
                , $ = layui.jquery;


            laydate.render({
                elem: '#createdDate',
                type: 'date'
            });

            laydate.render({
                elem: '#updatedDate',
                type: 'date'
            });






        form.verify({
            keyy:function (valuee) {
                        if(valuee.length>255)
                            return 'keyy长度不能超过255位';

            },
            valuee:function (valuee) {
                        if(valuee.length>255)
                            return 'valuee长度不能超过255位';

            },

    });

    //监听提交
    form.on('submit(layuiadmin-app-form-submit)', function (e) {
        <c:if test = "${empty id}" >
                var url = "./save";
        </c:if>
        <c:if test = "${not empty id}" >
                var url = "./update";
        </c:if>

        $("#configForm").ajaxSubmit({
            type: "post",
            url: url,
            datatype: "json",
            success: function (data) {
                if (data.responseCode == 0) {
                    parent.layui.layer.msg("提交成功");
                    var index = parent.layer.getFrameIndex(window.name);
                    parent.layer.close(index);
                    parent.layui.table.reload('configTable'); //重载表格
                    //刷新
                } else {
                    parent.layui.layer.msg(data.msg);
                }
            }

        });
        return false;
    });


        var id = "${id}";
        if (id != "") {
            var dt = (new Date()).getTime();
            $.ajax({
                url: "./get/" + id,
                dataType: "json",
                type: "get",
                data: {
                    dt: dt
                },
                success: function (data) {
                    console.log(JSON.stringify(data));
                    $("#id").val(data.id);
                    $("#name").val(data.name);
                            $("#keyy").val(data.keyy);
                            $("#valuee").val(data.valuee);
                    form.render();


                }
            });
        }

    });

    function decodeHTML(str) {
        var s = "";
        if (!str || str.length == 0) return "";
        s = str.replace(/&amp;/g, "&");
        s = s.replace(/&lt;/g, "<");
        s = s.replace(/&gt;/g, ">");
        s = s.replace(/&nbsp;/g, " ");
        s = s.replace(/&#39;/g, "\'");
        s = s.replace(/&quot;/g, "\"");
        return s;
    }

</script>

