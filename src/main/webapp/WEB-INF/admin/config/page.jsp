<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@include file="../header.jsp" %>
<div class="layui-fluid">
    <div class="layui-card">
        <form class="layui-form layui-card-header layuiadmin-card-header-auto">
            <div class="layui-form-item">
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
                <button class="layui-btn layuiadmin-btn-list" lay-event="batchdel" data-type="batchdel">批量删除
                </button>
            </div>
            <table id="configTable" lay-filter="configTable"></table>
        </div>
    </div>
</div>

<script>

    layui.config({
        base: '${ctxPath}/resources/layuiadmin/' //静态资源所在路径
    }).extend({
        index: 'lib/index' //主入口模块
    }).use(['index', 'form', 'table'], function () {
        var table = layui.table
                ,layer = layui.layer
                ,laydate = layui.laydate
                ,$ = layui.jquery
                , form = layui.form;


        table.render({
            elem: '#configTable'
            , cols: [[
                {checkbox: true, fixed: true}
                    , {
                        field: 'name',
                        title: 'name',
                        width: 150
                    }
                    , {
                        field: 'keyy',
                        title: 'key',
                        width: 150
                    }
                    , {
                        field: 'valuee',
                        title: 'value',
                        width: 150
                    }
                , {fixed: 'right', title: '操作', align: 'center', toolbar: '#barOption'}
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
        });


        //监听搜索
        form.on('submit(LAY-app-search)', function (data) {
            var field = data.field;
            //执行重载
            table.reload('configTable', {
                where: field,
                page:{ curr:1 }
            });
            return false;
        });

        //监听工具条
        table.on('tool(configTable)', function (obj) {
            var data = obj.data
                    , layEvent = obj.event;
            if (layEvent == "detail") {
                detail(data);
            } else if (layEvent == "edit") {
                add(data);
            } else if (layEvent == "del") {
                del(data);
            }
        });

        var $ = layui.$, active = {
            batchdel: batchdel,
            add: add
        };

        $('.layui-btn.layuiadmin-btn-list').on('click', function () {
            var type = $(this).data('type');
            active[type] ? active[type].call(this) : '';
        });

        function add(data) {
            url = "${ctxPath}/config/?method=edit";
            if (data) {
                url += "&id=" + data.id;
                openSubmitLayer(url, "编辑config", '800px', '500px');
            }else {
                openSubmitLayer(url, "添加config", '800px', '500px');
            }
        }

        function detail(data) {
            layer.open({
                type: 2,
                title: "查看config",
                maxmin: true,
                area: ["800px", "500px"],
                content: "${ctxPath}/config/?method=view&id=" + data.id
            });
        }

        function del(data) {
            layer.confirm('确定删除吗？', function (index) {
                $.ajax({
                    url: "./delete/" + data.id,
                    type: "post",
                    dataType: "json",
                    success: function (data) {
                        if (data.responseCode == 0) {
                            parent.layui.layer.msg("删除成功");
                            table.reload('configTable');
                        } else {
                            parent.layui.layer.msg(data.msg);
                        }
                    }
                })
                layer.close(index);
            });
        }

        function batchdel() {
            var checkStatus = table.checkStatus('configTable')
                    , checkData = checkStatus.data; //得到选中的数据
            if (checkData.length === 0) {
                return layer.msg('请选择数据');
            }
            layer.confirm('确定删除吗？', function (index) {
                var ids = "";
                for (var i = 0; i < checkStatus.data.length; i++) {
                    ids = ids + checkStatus.data[i].id + ","
                }
                $.ajax({
                    url: "./delete",
                    type: "post",
                    data: {"ids": ids},
                    dataType: 'json',
                    success: function (data) {
                        if (data.responseCode == 0) {
                            parent.layui.layer.msg("删除成功");
                            table.reload('configTable');
                        } else {
                            parent.layui.layer.msg(data.msg);
                        }
                    }
                })
                layer.close(index);
            });
        }

    });

</script>

<script type="text/html" id="barOption">
    <a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="detail"><i
            class="layui-icon layui-icon-about"></i>查看</a>
    <a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="edit"><i
            class="layui-icon layui-icon-edit"></i>编辑</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del"><i
            class="layui-icon layui-icon-delete"></i>删除</a>
</script>
<%@include file="../footer.jsp" %>