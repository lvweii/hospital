<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@include file="../header.jsp" %>
<style type="text/css">
    #week td{
        text-align: center;
    }
    #week tbody tr:hover{
        background-color: #fff;
    }
    #week tbody tr td:hover{
        background-color: #f2f2f2;
        cursor: pointer;
    }
</style>
<div class="layui-fluid">
    <div class="layui-row layui-col-space15">
        <div class="layui-card">
            <div class="layui-card-body">
                <form class="layui-form layui-card-header layuiadmin-card-header-auto" style="border-bottom: 0px;padding-bottom: 15px;">
                    <div class="layui-form-item">
                        <div class="layui-inline">
                            <label class="layui-form-label-search">挂号科室</label>
                            <div class="layui-input-inline">
                                <select id="deptId"
                                        name="deptId"
                                        class="layui-select" style="width: 100px;">
                                </select>
                            </div>
                        </div>
                        <input type="hidden" id="date" name="date">
                        <input type="hidden" id="am" name="am">
                        <div class="layui-inline">
                            <button class="layui-btn layuiadmin-btn-list" lay-submit lay-filter="LAY-app-search" id="LAY-app-search">
                                <i class="layui-icon layui-icon-search layuiadmin-button-btn"></i>
                            </button>
                            <button type="reset" class="layui-btn layui-btn-primary">重置</button>
                        </div>
                    </div>
                </form>
                <table class="layui-table" style="width: 80%" id="week">
                    <colgroup>
                        <col span="5" width="100">
                    </colgroup>
                    <tbody>
                    <tr>
                        <td id="d1_1">-</td>
                        <td id="d2_1">-</td>
                        <td id="d3_1">-</td>
                        <td id="d4_1">-</td>
                        <td id="d5_1">-</td>
                    </tr>
                    <tr>
                        <td id="d1_2">-</td>
                        <td id="d2_2">-</td>
                        <td id="d3_2">-</td>
                        <td id="d4_2">-</td>
                        <td id="d5_2">-</td>
                    </tr>
                    </tbody>
                </table>
                <div style="padding-bottom: 10px;padding-top: 30px">
                   <h2>门诊医生信息</h2>
                </div>
                <table id="doctorTable" lay-filter="doctorTable"></table>
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

      $(document).ready(function () {
        getDept();
        initWeek();
      })

        function initWeek(){
          var now = new Date().getTime();
          var day = 24*60*60*1000;
          var j=1;
          for (var i = 1; i < 8 ; i++) {
            var date = new Date(now+i*day);//当前时间往后几天
            var weekend = date.getDay();//0-周日，6-周六
            if(weekend==0 || weekend==6){
              continue;
            }else {
              var week = ["周日","周一","周二","周三","周四","周五","周六"][weekend];//这一天是周几
              var nian = date.getFullYear();
              var yue = date.getMonth()+1;
              var ri = date.getDate();
              var riqi = nian+"-"+(yue<10?"0"+yue:yue)+"-"+(ri<10?"0"+ri:ri);//这一天的日期
              $("#d"+j+"_1").html(week+"上午"+"<input type='hidden' name='am' value='0'><br><span name='date'>"+riqi+"</span>");
              $("#d"+j+"_2").html(week+"下午"+"<input type='hidden' name='am' value='1'><br><span name='date'>"+riqi+"</span>");
              j++;
            }
          }
        }

      $('#week tbody tr td').on('click', function () {
        $('#week tbody tr td').css("background-color","#fff");
        $(this).css("background-color","#f2f2f2");
        var date = $(this).children("span[name='date']").text();
        var am = $(this).children("input[name='am']").val();
        $("#date").val(date);
        $("#am").val(am);
      });

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

        window.loadDoctor = function () {
            var where = {};
            if ($("#deptId").val() != "") {
                where.deptId = $("#deptId").val();
            }
          if ($("#date").val() != "") {
            where.date = $("#date").val();
          }
          if ($("#am").val() != "") {
            where.am = $("#am").val();
          }
           table.render({
                elem: '#doctorTable'
              , cols: [[
                {type: 'numbers',  fixed: true}
                , {field: 'name', title: '姓名', width: 120}
                , {field: 'gender', title: '性别', width: 100,templet: function(d){
                      var info = d.gender.split("|");
                      return info[info.length - 1];
                  }}
                , {field: '', title: '科室', width: 120,templet: function(d){
                    return d.department.deptName;
                  }}
                , {field: 'title', title: '职称', width: 100,templet: function(d){
                    var info = d.title.split("|");
                    return info[info.length - 1];
                  }}
                , {field: 'instruction', title: '医生简介', width: 150}
                , {field: 'good', title: '擅长领域', width: 150}
                , {fixed: 'right', title: '操作', width: 200,align: 'center', toolbar: '#barOption'}
              ]]
                , url: '${ctxPath}/register/doctorPage'
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
        loadDoctor();

        //监听搜索
        form.on('submit(LAY-app-search)', function (data) {
            var field = data.field;
            //执行重载
            table.reload('doctorTable', {
                where: field,
                page:{ curr:1 }
            });
            return false;
        });

        //监听工具条
        table.on('tool(doctorTable)', function (obj) {
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
              url: "${ctxPath}/dept/delete/" + value.id,
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