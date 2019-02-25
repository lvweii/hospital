<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@include file="../header.jsp" %>
<div class="layui-fluid" style="padding: 20px 5%;">
    <form class="layui-form layui-form-pane" action="" id="userForm" lay-filter="userForm">
        <input id="id" name="id" type="hidden">
        <input name="CSRFToken" type="hidden" value="${CSRFToken}">
        <div class="layui-form-item">
            <label class="layui-form-label">用户类型<label style="color:red;">*</label></label>
            <div class="layui-input-block">
                <select id="type"
                        name="type"
                        class="layui-select-button"
                        lay-filter="type"
                        lay-verify="required"
                        type="text">
                    <option value="">请选择</option>
                    <option value="1">医生</option>
                    <option value="2">患者</option>
                </select>
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">科室<label style="color:red;">*</label></label>
            <div class="layui-input-block">
                <select id="deptId"
                        name="deptId"
                        class="layui-select-button"
                        lay-filter="deptId"
                        lay-verify="required"
                        type="text">
                </select>
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">姓名<label style="color:red;">*</label></label>
            <div class="layui-input-block">
                <input class="layui-input" type="text" placeholder="请输入姓名" name="name" id="name" lay-verify="required|name"/>
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">用户名<label style="color:red;">*</label></label>
            <div class="layui-input-block">
                <input class="layui-input" type="text" name="userId" id="userId" placeholder="请输入用户名" lay-verify="required|userId"/>
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">手机号<label style="color:red;">*</label></label>
            <div class="layui-input-block">
                <input class="layui-input" type="text" name="mobile" id="mobile" placeholder="请输入手机号" lay-verify="mobile"/>
            </div>
        </div>
        <div class="layui-form-item" pane>
            <label class="layui-form-label">出生日期</label>
            <div class="layui-input-block">
                <input class="layui-input" type="text" name="birthday" id="birthday" placeholder="yyyy-MM-dd"/>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">性别</label>
            <div class="layui-input-block">
                <select id="gender"
                        name="gender"
                        class="layui-select-button"
                        lay-filter="gender"
                        type="text">
                    <option value="">请选择</option>
                    <option value="0">男</option>
                    <option value="1">女</option>
                </select>
            </div>
        </div>
        <div class="layui-form-item" id="divtitle" style="display: none">
            <label class="layui-form-label">职称<label style="color:red;">*</label></label>
            <div class="layui-input-block">
                <select id="title"
                        name="title"
                        class="layui-select-button"
                        lay-filter="title"
                        lay-verify="showRequired"
                        type="text">
                    <option value="">请选择</option>
                    <option value="0">医师</option>
                    <option value="1">主治医师</option>
                    <option value="2">副主任医师</option>
                    <option value="3">主任医师</option>
                </select>
            </div>
        </div>

        <div class="layui-form-item layui-form-text" id="divinstruction" style="display: none">
            <label class="layui-form-label">医生简介<label style="color:red;">*</label></label>
            <div class="layui-input-block">
                <textarea class="layui-textarea" id="instruction" name="instruction" rows="6" lay-verify="instruction|showRequired" placeholder="请输入医生简介"></textarea>
            </div>
        </div>

        <div class="layui-form-item layui-form-text" id="divgood" style="display: none">
            <label class="layui-form-label">擅长<label style="color:red;">*</label></label>
            <div class="layui-input-block">
                <textarea class="layui-textarea" id="good" name="good" rows="3" lay-verify="good|showRequired" placeholder="请输入医生擅长领域"></textarea>
            </div>
        </div>

        <div class="layui-form-item" id="divtime" style="display: none">
            <label class="layui-form-label">出诊时间</label>
            <div class="layui-input-block">
                <input type="checkbox"  lay-filter="dtime" name="dtime" value="1" title="周一上午"/>
                <input type="checkbox"  lay-filter="dtime" name="dtime" value="2" title="周一下午"/>
                <input type="checkbox"  lay-filter="dtime" name="dtime" value="3" title="周二上午"/>
                <input type="checkbox"  lay-filter="dtime" name="dtime" value="4" title="周二下午"/>
                <input type="checkbox"  lay-filter="dtime" name="dtime" value="5" title="周三上午"/>
                <input type="checkbox"  lay-filter="dtime" name="dtime" value="6" title="周三下午"/>
                <input type="checkbox"  lay-filter="dtime" name="dtime" value="7" title="周四上午"/>
                <input type="checkbox"  lay-filter="dtime" name="dtime" value="8" title="周四下午"/>
                <input type="checkbox"  lay-filter="dtime" name="dtime" value="9" title="周五上午"/>
                <input type="checkbox"  lay-filter="dtime" name="dtime" value="10" title="周五下午"/>
            </div>
            <input class="layui-input" type="hidden"  name="time" id="time" lay-filter="time"/>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">排序<label style="color:red;">*</label></label>
            <div class="layui-input-block">
                <input class="layui-input" type="text" name="sort" id="sort" placeholder="请输入序号" lay-verify="sort"/>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">角色</label>
            <div class="layui-input-inline">
                <a class="layui-icon" href="#" style="font-size: 30px; color: #33ABA0;" id="roles">&#xe654;</a><br>
                <div id="roleNames"></div>
            </div>

        </div>
        <div class="layui-form-item layui-hide">
            <input type="button" lay-submit lay-filter="layuiadmin-app-form-submit" id="layuiadmin-app-form-submit" value="提交">
        </div>
    </form>
</div>
<script>
    layui.use(['form', 'layedit', 'laydate','layer'], function () {
        var form = layui.form
            , layer = layui.layer
            , laydate = layui.laydate
            , $ = layui.jquery;

        window.roleIdArr = [];

        window.doctorHtml = '';
        window.patientHtml = '';

        //日期
        laydate.render({
            elem: '#birthday',
            type: 'date'
        });

        //用户类型下拉事件监听
      form.on('select(type)', function(data){
        if (data.value == '1'){
            //医生
          //加载科室列表
          if (window.doctorHtml == ''){
            //没有请求过，走ajax请求
            $.ajax({
              url: "./getDeptList?type=1",
              type: "get",
              dataType: "json",
              success: function (data) {
                var html = "<option value=''>请选择</option>";
                if (null !=data && data.length>0){
                  for(var i=0;i<data.length;i++){
                    html += "<option value='"+data[i].id+"'>"+data[i].deptName+"</option>";
                  }
                }
                $("#deptId").html(html);
                form.render();  //重新渲染form
                window.doctorHtml = html;
              }
            });
          }else{
            //请求过，则直接从全局变量中取
            $("#deptId").html(window.doctorHtml);
            form.render();  //重新渲染form
          }
          $("#divtitle").show();
          $("#divinstruction").show();
          $("#divgood").show();
          $("#divtime").show();
        } else if (data.value == '2'){
            //患者
          //加载患者部门列表
          if (window.patientHtml == ''){
            //防止重复请求
            $.ajax({
              url: "./getDeptList?type=2",
              type: "get",
              dataType: "json",
              success: function (data) {
                var html = "<option value=''>请选择</option>";
                if (null !=data && data.length>0){
                  for(var i=0;i<data.length;i++){
                    html += "<option value='"+data[i].id+"'>"+data[i].deptName+"</option>";
                  }
                }
                $("#deptId").html(html);
                form.render();  //重新渲染form
                window.patientHtml = html;
              }
            });
          }else{
            //请求过，则直接从全局变量中取
            $("#deptId").html(window.patientHtml);
            form.render();  //重新渲染form
          }
          $("#divtitle").hide();
          $("#divinstruction").hide();
          $("#divgood").hide();
          $("#divtime").hide();
        }
      });

      //医生出诊时间checkbox监听
      form.on('checkbox(dtime)', function(data){
        //每次复选框被勾选或者取消勾选，重新计算值
        var time = $("input[name='dtime']:checked");
        var times = "";
        if (time.length>0){
          for (var i=0;i<time.length;i++){
            if (i<time.length-1){
              times += time[i].value + ",";
            }else{
              times += time[i].value;
            }
          }
        }
        $("#time").val(times);
      });

        //角色
        $("#roles").on('click', function () {
            //$("#roleNames").empty();
            //window.roleIdArr = [];
            layer.open({
                type: 2,
                title: '添加角色',
                area: ['350px', '400px'],
                content: '${ctxPath}/user/?method=roleAdd',
                cancel: function (index, layero) {
                    layer.close(index);
                    return false;
                }
            });
        });

        //字段自定义验证
        form.verify({
            sort: function (value) {
                if (value<1 || value >99) {
                    return '排序必须1到99位';
                }else if(isNaN(value)){
                    return '排序必须为整数';
                }
            },
            instruction:function (value) {
                if (value.length >200) {
                    return '医生简介长度必须小于200';
                }
            },
            good:function (value) {
                if (value.length >50) {
                    return '医生擅长领域长度必须小于50';
                }
            },
            name: [/^([\u4E00-\u9FA5A-Za-z0-9_]){0,20}$/, '必须是长度小于20的字符'],
            userId: [/^([\u4E00-\u9FA5A-Za-z0-9_]){0,20}$/, '必须是长度小于20的字符'],
            mobile: [/^1[3|4|5|7|8|9]\d{9}$/, '手机必须11位，只能是数字！'],
            showRequired:function (value) {
              var type = $("#type").val();
              if (type == '1') {//选择的是医生
                if (value.length < 1) {
                  return '必填项不能为空';
                }
              }else if (type == '2'){//患者不验证
                return;
              }
            },


        });

        //新增、编辑

        //监听提交
        form.on('submit(layuiadmin-app-form-submit)', function (e) {
          var type = $("#type").val();
          if (type == '2') {
            //如果选择的是患者，则将医生职称，医生简介，擅长，出诊时间全部置为空
            $("#title").val('');
            $("#instruction").val('');
            $("#good").val('');
            $("#time").val('');
            var item = $("input[name='dtime']");
            for (var i = 0; i < item.length ; i++) {
              $(item[i]).prop("checked", false);
            }
            form.render('checkbox');
          }
              <c:if test="${empty id}">var url = "./save";
          </c:if>
              <c:if test="${not empty id}">var url = "./update";
          </c:if>

            var length = window.roleIdArr.length;
            for (var i = 0; i < length; i++) {
                var roleIdInput = $("<input type='hidden' name='roleList[" + i + "].id' value='" + window.roleIdArr[i] + "'>");
                $("#userForm").append(roleIdInput);
            }
            $("#userForm").ajaxSubmit({
                type: "post",
                url: url,
                dataType: "json",
                success: function (data) {
                    if (data.responseCode == 0) {
                        //提交成功
                        parent.layui.layer.msg("提交成功");
                        backToList();
                        parent.layui.table.reload('userTable'); //重载表格
                    } else {
                        layui.layer.msg(data.msg);
                    }

                },
                error: function () {
                    layui.layer.msg("用户添加失败");
                }
            });
            return false;
        });

        var id = "${id}";
        if (id != "") {
            var dt = (new Date()).getTime();
            $.ajax({
                url: "./getUserForUpdate/" + id,
                dataType: "json",
                type: "get",
                data: {
                    dt: dt
                },
                success: function (data) {

                    $("#id").val(data.id);
                    $("#type").val(data.type);

                    var html = "<option value=''>请选择</option>";
                    if (null !=data.selectDeptList && data.selectDeptList.length>0){
                        for(var i=0;i<data.selectDeptList.length;i++){
                            html += "<option value='"+data.selectDeptList[i].id+"'>"+data.selectDeptList[i].deptName+"</option>";
                        }
                    }
                    $("#deptId").html(html);
                    $("#deptId").val(data.deptId);
                    form.render();  //重新渲染form

                    $("#deptId").val(data.deptId);
                    $("#name").val(data.name);
                    $("#userId").val(data.userId);
                    $("#mobile").val(data.mobile);
                    if (data.birthday) {
                        var birth = data.birthday.toString();
                        $("#birthday").attr("value", birth.substr(0, 10));
                    }
                    $("#gender").val(data.gender);

                    //显示隐藏内容并赋值
                    var type = data.type;
                    if (type =='1') {
                      $("#title").val(data.title);
                      $("#instruction").val(data.instruction);
                      $("#good").val(data.good);
                      $("#time").val(data.time);
                      if (data.time != null && data.time != ''){
                        var times = $("input[name='dtime']");
                        var timeArr = data.time.split(",");
                        for (var i = 0; i < times.length; i++) {
                          if (timeArr.indexOf($(times[i]).val()) != -1){
                            $(times[i]).prop("checked", true);
                          }
                        }
                        form.render('checkbox');
                      }

                      $("#divtitle").show();
                      $("#divinstruction").show();
                      $("#divgood").show();
                      $("#divtime").show();
                    }

                    $("#sort").val(data.sort);
                    var length = data.roleList.length;
                    for (var i = 0; i < length; i++) {
                        var roleSpan = $("<div id='" + data.roleList[i].id + "'>" + data.roleList[i].roleName + "<a href='#' onclick='roleDel(\"" + data.roleList[i].id + "\")'  class='layui-icon' style=\"color: #33ABA0;\">&#x1006;</a></div>");
                        $("#roleNames").append(roleSpan);
                        window.roleIdArr.push(data.roleList[i].id);
                    }
                    form.render();
                },
                error: function () {
                    //获取用户失败
                }
            });
        }



    });

    function roleDel(roleId) {
        $("#" + roleId).remove();
        var length = window.roleIdArr.length;
        for (var i = 0; i < length; i++) {
            if (window.roleIdArr[i] === roleId) {
                window.roleIdArr.splice(i, 1);
                break;
            }
        }

    }

    function backToList() {
        var index = parent.layer.getFrameIndex(window.name);
        parent.layer.close(index);
    }

</script>
<script type="text/javascript" src="${ctxPath}/resources/js/jquery.js"></script>
<script type="text/javascript" src="${ctxPath}/resources/js/jquery.form.min.js"></script>

<%@include file="../footer.jsp" %>
