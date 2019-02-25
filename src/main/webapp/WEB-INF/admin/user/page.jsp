<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@include file="../header.jsp" %>
<div class="layui-fluid">
    <div class="layui-card">
        <form class="layui-form layui-card-header layuiadmin-card-header-auto">
            <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label-search">姓名</label>
                    <div class="layui-input-inline">
                        <input type="text" id="name" name="name" autocomplete="off"
                               placeholder="请输入姓名" class="layui-input">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label-search">用户类型</label>
                    <div class="layui-input-inline">
                        <select id="type"
                                name="type"
                                class="layui-select" style="width: 100px;">
                            <option value="">请选择</option>
                            <option value="0">系统管理员</option>
                            <option value="1">医生</option>
                            <option value="2">患者</option>
                        </select>
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label-search">科室部门</label>
                    <div class="layui-input-inline">
                        <select id="deptId"
                                name="deptId"
                                class="layui-select" style="width: 100px;">
                        </select>
                    </div>
                </div>
                <div class="layui-inline">
                    <button class="layui-btn layuiadmin-btn-list" lay-submit lay-filter="LAY-app-search">
                        <i class="layui-icon layui-icon-search layuiadmin-button-btn"></i>
                    </button>
                    <button type="reset" class="layui-btn layui-btn-primary">重置</button>
                </div>
            </div>
        </form>
        <div class="layui-card-body">
            <div style="padding-bottom: 10px;">
                <button class="layui-btn layuiadmin-btn-list" lay-event="add" data-type="add"><i
                        class="layui-icon layui-icon-add-1"></i>添加
                </button>
            </div>
            <table id="userTable" lay-filter="userTable"></table>
        </div>
    </div>
</div>
<script>

    layui.config({
        base: '${ctxPath}/resources/layuiadmin/' //静态资源所在路径
    }).extend({
        index: 'lib/index' //主入口模块
    }).use(['tree', 'index', 'form', 'table'], function () {
        var table = layui.table
            , tree = layui.tree
            , form = layui.form
            , $ = layui.jquery;

          $(document).ready(function(){
            // 加载科室下拉选择框
            deptSelect();
          });

        window.loadUser = function () {
            var where = {};
            if ($("#name").val() != "") {
                where.name = $("#name").val();
            }
            if($("#type").val() !=""){
                where.type = $("#type").val();
            }
            if($("#deptId").val() !=""){
              where.deptId = $("#deptId").val();
            }
            table.render({
                elem: '#userTable'
                , cols: [[
                    {checkbox: true, fixed: true}
                    , {field: 'name', title: '姓名', width: 120}
                    , {field: 'gender', title: '性别', width: 120,templet: function(d){
                        var info = d.gender.split("|");
                        return info[info.length - 1];
                    }}
                    , {field: 'userId', title: '用户名', width: 120}
                    , {field: 'type', title: '用户类型', width: 120,templet: function(d){
                        var info = d.type.split("|");
                        return info[info.length - 1];
                    }}
                    , {field: '', title: '科室部门', width: 120,templet: function(d){
                        return d.department.deptName;
                      }}
                    , {fixed: 'right', title: '操作', width: 200,align: 'center', toolbar: '#barOption'}
                ]]
                , url: './page'
                , method: 'post'
                , page: true
                , request: {
                    limitName: "size"
                }
                , response: {
                    countName: "totalElements",
                    dataName: "content"
                }
                , limits: [30, 60, 90, 150, 300]
                , limit: 30
                , where: where
            });
        };
        loadUser();

        //监听搜索
        form.on('submit(LAY-app-search)', function (data) {
            var field = data.field;
            //执行重载
            table.reload('userTable', {
                where: field,
                page:{ curr:1 }
            });
            return false;
        });

        //监听工具条
        table.on('tool(userTable)', function (obj) {
            var data = obj.data
                , layEvent = obj.event;
            if (layEvent == "edit") {
                add(data);
            } else if (layEvent == "del") {
                del(data);
            }
        });

        var active = {
            add: add
        };

        $('.layui-btn.layuiadmin-btn-list').on('click', function () {
            var type = $(this).data('type');
            active[type] ? active[type].call(this) : '';
        });

        function add(data) {
            url = "${ctxPath}/user/?method=edit";
            if (data) {
                url += "&id=" + data.id;
                openSubmitLayer(url, "编辑用户", '800px', '530px');
            }else {
                openSubmitLayer(url, "添加用户", '800px', '530px');
            }
        }

        function del(data) {
            if ('admin' == data.userId){
                layer.msg('系统管理员不能删除！')
                return;
            }
            layer.confirm('确定删除吗？', function (index) {
                $.ajax({
                    url: "./delete/" + data.id,
                    type: "post",
                    dataType: "json",
                    success: function (data) {
                        if (data.responseCode == 0) {
                            parent.layui.layer.msg("删除成功");
                            table.reload('userTable');
                        } else {
                            parent.layui.layer.msg(data.msg);
                        }
                    }
                });
                layer.close(index);
            });
        }

      function deptSelect(){
        $.ajax({
          url: "${ctxPath}/user/getDept",
          dataType: "json",
          type: "get",
          data: {
          },
          success: function (data) {
            var html = "<option value=''>请选择</option>";
            if (null !=data && data.length>0){
              for(var i=0;i<data.length;i++){
                html += "<option value='"+data[i].id+"'>"+data[i].deptName+"</option>";
              }
            }
            $("#deptId").html(html);
            form.render();  //重新渲染form
          },
          error: function () {
            //管理所列表加载失败
          }
        });
      }

    });

</script>

<script type="text/html" id="barOption">
    <a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="edit"><i
            class="layui-icon layui-icon-edit"></i>编辑</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del"><i
            class="layui-icon layui-icon-delete"></i>删除</a>
</script>
<%@include file="../footer.jsp" %>