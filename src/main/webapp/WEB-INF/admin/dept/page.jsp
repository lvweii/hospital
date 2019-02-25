<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@include file="../header.jsp" %>
<div class="layui-fluid">
    <div class="layui-row layui-col-space15">
        <div class="layui-card">
            <form class="layui-form layui-card-header layuiadmin-card-header-auto">
                <div class="layui-form-item">
                    <div class="layui-inline">
                        <label class="layui-form-label-search">科室名称</label>
                        <div class="layui-input-inline">
                            <input type="text" name="deptName" id="deptName" autocomplete="off" placeholder="请输入科室名称" class="layui-input">
                        </div>
                        <label class="layui-form-label-search">科室编码</label>
                        <div class="layui-input-inline">
                            <input type="text" name="deptCode" id="deptCode" autocomplete="off" placeholder="请输入科室编码" class="layui-input">
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
                <table id="departmentTable" lay-filter="departmentTable"></table>
            </div>
        </div>
    </div>

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
        window.loadDept = function () {
            var where = {};
            if ($("#deptName").val() != "") {
                where.deptName = $("#deptName").val();
            }
            if ($("#deptCode").val() != "") {
              where.deptCode = $("#deptCode").val();
            }
            table.render({
                elem: '#departmentTable'
                , cols: [[
                    {checkbox: true, fixed: true}
                    , {field: 'deptName', title: '科室名称', width: 120}
                    , {field: 'deptCode', title: '科室编码', width: 120}
                    , {field: 'instruction', title: '科室简介', width: 360}
                    , {fixed: 'right', title: '操作',width: 200, align: 'center', toolbar: '#barOption'}
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
        loadDept();

        //监听搜索
        form.on('submit(LAY-app-search)', function (data) {
            var field = data.field;
            //执行重载
            table.reload('departmentTable', {
                where: field,
                page:{ curr:1 }
            });
            return false;
        });

        //监听工具条
        table.on('tool(departmentTable)', function (obj) {
            var data = obj.data
                , layEvent = obj.event;
            if (layEvent == "edit") {
                add(data);
            } else if (layEvent == "del") {
                del(data);
            }
        });

        var active = {
            add: add,
        };

        $('.layui-btn.layuiadmin-btn-list').on('click', function () {
            var type = $(this).data('type');
            active[type] ? active[type].call(this) : '';
        });

        function add(data) {
            url = "${ctxPath}/dept/?method=edit";
            if (data) {
                url += "&id=" + data.id;
                openSubmitLayer(url, "编辑科室", '600px', '500px');
            } else {
                openSubmitLayer(url, "添加科室", '600px', '500px');
            }
        }

        function del(value) {
          layer.confirm('确定删除吗？', function (index) {
            $.ajax({
              url: "./delete/" + value.id,
              type: "post",
              dataType: "json",
              success: function (d) {
                if (d.responseCode == 0) {
                  parent.layui.layer.msg("删除成功");
                  table.reload('departmentTable');
                } else {
                  layer.msg(d.msg);
                }
              }
            });
            layer.close(index);
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