<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@include file="../header.jsp" %>
<div class="layui-fluid">
    <div class="layui-row layui-col-space15">
        <div class="layui-card">
            <form class="layui-form layui-card-header layuiadmin-card-header-auto">
                <div class="layui-form-item">
                    <div class="layui-inline">
                        <label class="layui-form-label-search">挂号科室</label>
                        <div class="layui-input-inline">
                            <select id="deptId"
                                    name="deptId"
                                    class="layui-select" style="width: 100px;">
                            </select>
                        </div>
                        <label class="layui-form-label-search">预约日期</label>
                        <div class="layui-input-inline">
                            <input type="text" name="chooseDate" id="chooseDate" autocomplete="off" placeholder="点击选择" class="layui-input" readonly="readonly">
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
                <table id="registerTable" lay-filter="registerTable"></table>
            </div>
        </div>
    </div>

</div>
<script>
    layui.config({
        base: '${ctxPath}/resources/layuiadmin/' //静态资源所在路径
    }).extend({
        index: 'lib/index' //主入口模块
    }).use(['tree', 'index', 'form','laydate', 'table', 'layer'], function () {
        var table = layui.table
            , form = layui.form
            , laydate = layui.laydate
            , $ = layui.jquery;

      laydate.render({
        elem: '#chooseDate',
        type: 'date'
      });

      $(document).ready(function () {
        getDept();
      })

      function getDept(){
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
          }
        });
      }

        window.loadRegister = function () {
            var where = {};
            if ($("#deptId").val() != "") {
                where.deptId = $("#deptId").val();
            }
            if ($("#chooseDate").val() != "") {
              where.chooseDate = $("#chooseDate").val();
            }
            table.render({
                elem: '#registerTable'
                , cols: [[
                    {type: 'numbers',  fixed: true}
                    , {field: '', title: '患者姓名', width: 100,templet: function(d){
                        return d.patient.name;
                    }}
                    , {field: '', title: '科室名称', width: 120,templet: function(d){
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
                    , {fixed: 'right', title: '操作',width: 100, align: 'center', toolbar: '#barOption'}
                ]]
                , url: './patientRegisterPage'
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
        loadRegister();

        //监听搜索
        form.on('submit(LAY-app-search)', function (data) {
            var field = data.field;
            //执行重载
            table.reload('registerTable', {
                where: field,
                page:{ curr:1 }
            });
            return false;
        });

        //监听工具条
        table.on('tool(registerTable)', function (obj) {
            var data = obj.data
                , layEvent = obj.event;
            if (layEvent == "cancel") {
                cancel(data);
            }
        });

        function cancel(value) {
          layer.confirm('确定取消该预约吗？', function (index) {
            $.ajax({
              url: "./cancel/" + value.id,
              type: "post",
              dataType: "json",
              success: function (d) {
                if (d.responseCode == 0) {
                  parent.layui.layer.msg("退号成功");
                  table.reload('registerTable');
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
    {{#  if(d.status == "0"){ }}
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="cancel"><i class="layui-icon layui-icon-return"></i>退号</a>
    {{#  }else{ }}
    <a class="layui-btn layui-btn-disabled layui-btn-xs"><i class="layui-icon layui-icon-return"></i>退号</a>
    {{#  } }}

</script>
<%@include file="../footer.jsp" %>