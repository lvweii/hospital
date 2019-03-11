<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@include file="../header.jsp" %>
<div class="layui-fluid"  style="padding: 20px;">
<form class="layui-form" action="" id="departmentForm" lay-filter="deptForm">
    <input id="id" name="id" type="hidden">
    <input name="CSRFToken" type="hidden" value="${CSRFToken}">
    <div class="layui-form-item" style="margin-bottom: 0px;">
        <label class="layui-form-label" style="padding: 4px 15px 4px 0px;width: 60px;">姓名：</label>
        <div class="layui-input-block" style="margin-left: 75px">
            <label id="doctorName" class="layui-form-label" style="text-align: left;padding: 4px 0px;width: 200px;">-</label>
            <input class="layui-input" type="hidden" name="doctorId" id="doctorId" />
        </div>
    </div>
    <div class="layui-form-item" style="margin-bottom: 0px;">
        <label class="layui-form-label" style="padding: 4px 15px 4px 0px;width: 60px;">科室：</label>
        <div class="layui-input-block" style="margin-left: 75px">
            <label id="deptName" class="layui-form-label" style="text-align: left;padding: 4px 0px;width: 200px;">-</label>
        </div>
    </div>
    <div class="layui-form-item" style="margin-bottom: 0px;">
        <label class="layui-form-label" style="padding: 4px 15px 4px 0px;width: 60px;">职称：</label>
        <div class="layui-input-block" style="margin-left: 75px">
            <label id="title" class="layui-form-label" style="text-align: left;padding: 4px 0px;width: 200px;">-</label>
        </div>
    </div>
    <div class="layui-collapse" lay-accordion style="margin-left: 8px;margin-bottom: 15px;">
        <div class="layui-colla-item">
            <h2 class="layui-colla-title" style="background-color: #F2F2D3">医生简介</h2>
            <div class="layui-colla-content layui-show">
                <span id="instruction"></span>
            </div>
        </div>
    </div>
    <div class="layui-collapse" lay-accordion style="margin-left: 8px;margin-bottom: 30px;">
        <div class="layui-colla-item">
            <h2 class="layui-colla-title" style="background-color: #F2F2D3">擅长</h2>
            <div class="layui-colla-content layui-show">
                <span id="good"></span>
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
        <tbody id="tbody">
        <%--<tr>--%>
            <%--<td id="d1_1">消化科</td>--%>
            <%--<td id="d2_1">星期三 上午<br>2019-03-01</td>--%>
            <%--<td id="d3_1">--%>
                <%--<input type="radio" name="timeRange" value="1" title="08:00-09:00">--%>
                <%--<input type="radio" name="timeRange" value="2" title="09:00-10:00">--%>
                <%--<input type="radio" name="timeRange" value="3" title="10:00-11:00">--%>
                <%--<input type="radio" name="timeRange" value="4" title="11:00-12:00">--%>
            <%--</td>--%>
            <%--<td id="d4_1">--%>
                <%--<a class="layui-btn layui-btn-normal layui-btn-xs"><i--%>
                    <%--class="layui-icon layui-icon-survey"></i>预约</a>--%>
            <%--</td>--%>
        <%--</tr>--%>
        <%--<tr>--%>
            <%--<td id="d1_2">心血管科</td>--%>
            <%--<td id="d2_2">星期四 下午<br>2019-03-02</td>--%>
            <%--<td id="d3_2">--%>
                <%--<input type="radio" name="timeRange" value="5" title="14:00-15:00">--%>
                <%--<input type="radio" name="timeRange" value="6" title="15:00-16:00">--%>
                <%--<input type="radio" name="timeRange" value="7" title="16:00-17:00">--%>
                <%--<input type="radio" name="timeRange" value="8" title="17:00-18:00">--%>
            <%--</td>--%>
            <%--<td id="d4_2">--%>
                <%--<a class="layui-btn layui-btn-normal layui-btn-xs"><i--%>
                        <%--class="layui-icon layui-icon-survey"></i>预约</a>--%>
            <%--</td>--%>
        <%--</tr>--%>
        </tbody>
    </table>

    <%--<div class="layui-form-item layui-hide">--%>
        <%--<input type="button" lay-submit lay-filter="layuiadmin-app-form-submit" id="layuiadmin-app-form-submit" value="提交">--%>
    <%--</div>--%>
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

      function showLoad(){
        return layer.msg('保存中...', {icon: 16,shade: [0.5, '#f5f5f5'],scrollbar: false, time:100000}) ;
      }
      function closeLoad(){
        layer.close(layer.index);
      }

      $(document).ready(function(){
        // 获取医生信息及值班情况
        getInfo("${id}");
      });

        function getInfo(id) {
            var dt = (new Date()).getTime();
            $.ajax({
                url: "./getInfo/" + id,
                dataType: "json",
                type: "get",
                data: {
                    dt: dt
                },
                success: function (data) {
                  console.log(data);
                    $("#doctorName").text(data.doctor.name);
                    $("#doctorId").val(data.doctor.id);
                    $("#deptName").text(data.doctor.department.deptName);
                    if (data.doctor.title){
                      var info = data.doctor.title.split("|");
                      $("#title").text(info[info.length - 1]);
                    }
                    $("#instruction").text(data.doctor.instruction);
                    $("#good").text(data.doctor.good);

                    //加载班表信息
                    var html = '';
                    if(data.doctor.time){
                      var time = data.doctor.time.substring(0,data.doctor.time.length-1);
                      var timeArr = time.split(",");
                      var now = new Date();
                      var nowTime = now.getTime();
                      var week = now.getDay();//0-周日，6-周六
                      var arr = ["周日","周一","周二","周三","周四","周五","周六"];
                      var thisWeek = [];
                      var nextWeek = [];
                      for (var i = 0; i < timeArr.length; i++) {
                        if (timeArr[i]<=2*week){
                          nextWeek.push(timeArr[i]);
                        }else {
                          thisWeek.push(timeArr[i]);
                        }
                      }
                      var newTime = thisWeek.concat(nextWeek);//按照时间顺序排列一周内的新的时间
                      console.log(newTime);
                      for (var i = 0; i < newTime.length; i++) {
                        var temp = newTime[i]%2==0?parseInt(newTime[i]):parseInt(newTime[i])+1;//不用parseInt会当成字符串拼接
                        // console.log(temp);
                        if (newTime[i]>2*week){
                          var date = new Date(nowTime+(temp-2*week)*12*60*60*1000);
                        }else{
                          var date = new Date(nowTime+(temp-2*week+14)*12*60*60*1000);
                        }
                        var nian = date.getFullYear();
                        var yue = date.getMonth()+1;
                        var ri = date.getDate();
                        var riqi = nian+"-"+(yue<10?"0"+yue:yue)+"-"+(ri<10?"0"+ri:ri);//这一天的日期
                        var h = arr[date.getDay()]+" "+(newTime[i]%2==0?"下午":"上午")+"<br>"+riqi;
                        // console.log(h);
                        if (newTime[i]%2==0){
                          var title = ["14:00-15:00","15:00-16:00","16:00-17:00","17:00-18:00"];
                          var value = ["5","6","7","8"];
                        }else{
                          var title = ["08:00-09:00","09:00-10:00","10:00-11:00","11:00-12:00"];
                          var value = ["1","2","3","4"];
                        }

                        html +='<tr>'
                            +'<td>'+data.doctor.department.deptName+'</td>'
                            +'<td>'+h+'</td>'
                            +'<td name="range">'
                            +'<input type="radio" name="timeRange" value="'+value[0]+'" title="'+title[0]+'">'
                            +'<input type="radio" name="timeRange" value="'+value[1]+'" title="'+title[1]+'">'
                            +'<input type="radio" name="timeRange" value="'+value[2]+'" title="'+title[2]+'">'
                            +'<input type="radio" name="timeRange" value="'+value[3]+'" title="'+title[3]+'">'
                            +'</td>'
                            +'<td>'
                            +'<a class="layui-btn layui-btn-normal layui-btn-xs" name="register"><i class="layui-icon layui-icon-survey"></i>预约</a>'
                            +'<input type="hidden" name="date" value="'+ riqi +'">'
                            +'</td>'
                            +'</tr>';
                      }
                    }else{
                      //暂无班表
                      html += '<tr>'
                          +'<td colspan="4" style="text-align: center">暂无班表信息</td>'
                          +'</tr>';
                    }
                  $("#tbody").html(html);
                  form.render();//刷新radio

                  //预约按钮绑定提交事件
                  $("a[name='register']").on('click', function () {
                    var date = $(this).siblings("input[name='date']").val();
                    var timeRange = $(this).parent().siblings("td[name='range']").children("input[name='timeRange']:checked").val();
                    var doctorId = $("#doctorId").val();
                    if (!timeRange) {
                      layer.msg("请选择时间段");
                      return false;
                    }
                    //ajax提交
                    $.ajax({
                      url: "./register",
                      type: "post",
                      dataType: "json",
                      data:{
                        date:date,
                        timeRange:timeRange,
                        doctorId:doctorId,
                      },
                      beforeSend:function(){
                        showLoad();
                      },
                      success: function (d) {
                        closeLoad();
                        if (d.responseCode == 0) {
                          parent.layui.layer.msg("挂号成功");
                          backToList();
                        } else {
                          layer.msg(d.msg);
                        }
                      }
                    });
                  });

                },
                error: function () {
                    //获取医生信息失败
                }
            });
        }


    });

    function backToList() {
        var index = parent.layer.getFrameIndex(window.name);
        parent.layer.close(index);
    }

</script>
<script type="text/javascript" src="${ctxPath}/resources/js/jquery.js"></script>
<script type="text/javascript" src="${ctxPath}/resources/js/jquery.form.min.js"></script>

<%@include file="../footer.jsp" %>
