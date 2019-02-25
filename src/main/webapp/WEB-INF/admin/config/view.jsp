<%@ page import="com.jsict.framework.core.security.model.IUser" %>
<%@ page import="org.apache.shiro.SecurityUtils" %>
<%@ page import="com.jsict.biz.model.User" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
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
<%@include file="../header_form.jsp"%>
    <form class="layui-form layui-form-pane" id="configForm" style="padding: 20px 30px 0 30px;">
        <input id="id" name="id" type="hidden">
        <input id="levelll" name="levelll" type="hidden" >
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
                        <input id="name"
                               name="name"
                               class="layui-input" readonly/>
                    </div>
                </div>
        </div>
            <div class="layui-form-item">

                    <div class="layui-inline">
                        <label class="layui-form-label">key</label>
                        <div class="layui-input-inline">
                                <input id="keyy"
                                       name="keyy"
                                       class="layui-input" readonly/>
                        </div>
                    </div>
            </div>
            <div class="layui-form-item">
                        <div class="layui-inline">
                            <label class="layui-form-label">value</label>
                            <div class="layui-input-inline">
                                    <input id="valuee"
                                           name="valuee"
                                           class="layui-input" readonly/>
                            </div>
                        </div>

            </div>
        <c:if test = "${isAdminConfig == 'yes'}" >
            <div class="layui-form-item">
                <div class="layui-inline">
                <label class="layui-form-label">是否开放</label>
                <c:if test = "${level == '2'}" >
                    <input type="checkbox"  name="levell" id="levell"  value="2" title="开放"    checked="checked"  >
                </c:if>
                <c:if test = "${level != '2'}" >
                    <input type="checkbox"  name="levell" id="levell"  value="1"  title="开放"  >
                </c:if>
                </div>
            </div>

        </c:if>

        <div class="layui-form-item" align="center">
            <button type="button" class="layui-btn layui-btn-primary" onclick="backToList()">返回</button>
        </div>
    </form>


<%@include file="../footer.jsp"%>
<script>
    layui.use(['form', 'layedit', 'laydate', 'tree'], function () {
        var form = layui.form
                , layer = layui.layer
                , layedit = layui.layedit
                , laydate = layui.laydate
                , tree = layui.tree
                , $ = layui.jquery;

        viewconfig();

        function viewconfig(){
            var id = "${id}";
            if (id === "")
                return;
            var dt = (new Date()).getTime();
            $.ajax({
                url: "${ctxPath}/config/get/" + id,
                dataType: "json",
                data: {
                    dt: dt
                },
                type: "get",
                success: function (data) {
                    console.log(JSON.stringify(data));
                    $("#id").val(data.id);
                    $("#name").val(data.name);
                                $("#keyy").val(data.keyy);
                                $("#valuee").val(data.valuee);
                    $("#levelll").val(data.levell);
                }
            });
        }

    });

    function backToList() {
        var index = parent.layer.getFrameIndex(window.name);
        parent.layer.close(index);
    }

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

