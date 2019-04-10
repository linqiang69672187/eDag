<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DispatchtreeResPermission.aspx.cs" Inherits="Web.lqnew.opePages.DispatchtreeResPermission" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>

    <link href="../../CSS/pagestyle.css" rel="stylesheet" type="text/css" />
    <link href="../css/lq_addedit.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../js/Cookie.js"></script>

    <link rel="stylesheet" type="text/css"
        href="../js/resPermissions/jquery-easyui-1.4/themes/default/easyui.css" />
    <link rel="stylesheet" type="text/css"
        href="../js/resPermissions/jquery-easyui-1.4/themes/icon.css" />
    <link rel="stylesheet" type="text/css"
        href="../js/resPermissions/jquery-easyui-1.4.1/themes/demo/demo.css" />
    <script type="text/javascript"
        src="../js/resPermissions/jquery-easyui-1.4/jquery.min.js"></script>
    <script type="text/javascript"
        src="../js/resPermissions/jquery-easyui-1.4/jquery.easyui.min.js"></script>
    <script type="text/javascript"
        src="../js/resPermissions/jquery-easyui-1.4/locale/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript"
        src="../js/resPermissions/config_p/dispatcher.js"></script>
        <script src="../js/MouseMenu.js" type="text/javascript"></script>
</head>
<body>
    <form id="form1" runat="server" style="height: 380px;">
     <div class="easyui-panel" style="padding: 5px;width:300px; height: 380px; overflow: scroll">
            <ul id="entityAndTypeTree" class="easyui-tree" data-options="animate:true"></ul>
        </div>

        <script type="text/javascript">
            //鼠标点击事件
            window.onload = function () {
                getentitytree();

                MouseMenu(window.parent.parent.parent, "a", "dispatchmouseMenu");
                try {
                    window.parent.hideDispatchtreeProcessImg();
                }
                catch (e) { }
            }
            function getentitytree() {
                var noData = window.parent.parent.parent.parent.GetTextByName("Nodata", window.parent.parent.parent.parent.useprameters.languagedata);

                $.ajax({
                    type: "POST",
                    url: "../../Handlers/resPermissions/LoginuserResourcePermissionsByUserId_get.ashx",
                    data: { "loginUserId": +Cookies.get("loginUserId"), "dispatchGroup": "dispatch" },
                    success: function (msg) {
                        //var mydd = eval("(" + msg + ")");
                        var mydd = eval(msg);
                        if (mydd != null && mydd.length > 0) {
                            if (mydd[0]["text"] == null || mydd[0]["text"] == undefined) {
                                $("#entityAndTypeTree").tree({
                                    data: [{ text: noData }]
                                });
                            } else {
                                $("#entityAndTypeTree").tree({
                                    data: mydd,
                                    onClick: function (node) {
                                        displayGrouplists();

                                        
                                            if (node.type == "zhishu") {
                                                var node1 = $("#entityAndTypeTree").tree("getParent", node.target);
                                                var entityId = node1.id;
                                                var entityName = node1.text;
                                                var clickItemType = "zhishu";
                                                window.parent.parent.parent.frames["dispatchlists"].getGroup(entityId, entityName, clickItemType);
                                            } else if (node.type == "unit") {
                                                var entityId = node.id;
                                                var entityName = node.text;
                                                var clickItemType = "entity";
                                                window.parent.parent.parent.frames["dispatchlists"].getGroup(entityId, entityName, clickItemType);
                                            }
                                       
                                    },
                                    onBeforeExpand: function (node, param) {
                                        $('#entityAndTypeTree').tree('options').url = "../../Handlers/resPermissions/getOnlySubEntity.ashx?loginuserEntityId=" + Cookies.get["id"] + "&nodeId=" + node.id;
                                    }
                                });
                            }
                        } else {
                            $("#entityAndTypeTree").tree({
                                data: [{ text: noData }]
                            });
                        }
                    }
                });
            }
            function displayGrouplists() {
                window.parent.parent.parent.document.getElementById("grouplistsdiv").style.display = "none";
                window.parent.parent.parent.document.getElementById("dispatchlistsdiv").style.display = "block";
                window.parent.parent.parent.document.getElementById("policelistsdiv").style.display = "none";
            }
        </script>

    </form>
</body>
</html>
