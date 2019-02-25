<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@include file="../header.jsp" %>
<link rel="stylesheet" href="${ctxPath}/resources/ztree/css/zTreeStyle/zTreeStyle.css" type="text/css">
<script type="text/javascript" src="${ctxPath}/resources/js/jquery.js"></script>
<link rel="stylesheet" href="${ctxPath}/resources/ztree/css/zTreeStyle/zTreeStyle.css" type="text/css">
<script type="text/javascript" src="${ctxPath}/resources/ztree/js/jquery.ztree.core.js"></script>

<div class="layui-fluid">
    <div class="layui-card">
        <ul id="moduleTree" class="ztree"></ul>
    </div>
</div>

<script>
    layui.config({
        base: '${ctxPath}/resources/layuiadmin/' //静态资源所在路径
    }).extend({
        index: 'lib/index' //主入口模块
    }).use(['layer'], function () {
    // zTree 的参数配置，深入使用请参考 API 文档（setting 配置详解）
    var setting = {
        view: {
            dblClickExpand: false,
            showLine: true,
            showIcon: false
        },
        callback: {
            onClick: ztreeClick
        },
        data: {
            key: {
                name: "moduleName"
            },
            simpleData: {
                enable: true,
                idKey: "id", // id编号命名
                pIdKey: "parentModuleId", // 父id编号命名
                rootPId: 0//根节点
            }
        },
    };
    function ztreeClick(event, treeId, treeNode){
        if(treeNode.moduleName == "模块树"){
            parent.layui.layer.msg("请选择模块！");
        }else{
            parent.window.parentModuleId = treeNode.id;
            parent.window.parentModuleName = treeNode.moduleName;
        }

    }
    $(document).ready(function () {
        var index = layer.load(1);
        var zNodes = [{
            moduleName: "模块树"
        }];
        $.ajax({
            type: "post",
            url: "./moduleTree",
            dataType: "json",
            async: true,
            success: function (res) {
                if (res != null && res.length > 0) {
                    var length = res.length;
                    for (var i = 0; i < length; i++) {
                        zNodes.push({
                            moduleName: res[i].moduleName,
                            id: res[i].id,
                            parentModuleId:res[i].parentModuleId
                        })
                    }
                    $.fn.zTree.init($("#moduleTree"), setting, zNodes);
                    layer.close(index);
                }
            },
            error:function(){
                layer.close(index);
                layer.alert('加载失败');
            }
        });
    });
})


</script>

<%@include file="../footer.jsp" %>