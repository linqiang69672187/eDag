
<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="searchDispatchTree.aspx.cs" Inherits="Web.lqnew.opePages.AddMemberTree.searchDispatchTree" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <link href="../../../CSS/pagestyle.css" rel="stylesheet" type="text/css" />
    <link href="../../css/lq_addedit.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../../js/Cookie.js"></script>

    <link rel="stylesheet" type="text/css"
        href="../../js/resPermissions/jquery-easyui-1.4/themes/default/easyui.css" />
    <link rel="stylesheet" type="text/css"
        href="../../js/resPermissions/jquery-easyui-1.4/themes/icon.css" />
    <link rel="stylesheet" type="text/css"
        href="../../js/resPermissions/jquery-easyui-1.4.1/themes/demo/demo.css" />
    <script type="text/javascript"
        src="../../js/resPermissions/jquery-easyui-1.4/jquery.min.js"></script>
    <script type="text/javascript"
        src="../../js/resPermissions/jquery-easyui-1.4/jquery.easyui.min.js"></script>
    <script type="text/javascript"
        src="../../js/resPermissions/jquery-easyui-1.4/locale/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript"
        src="../../js/resPermissions/config_p/dispatcher.js"></script>

</head>
<body>
    <form id="form1" runat="server" style="height: 380px;">
     <div class="easyui-panel" style="padding: 5px; height: 380px; overflow: scroll">
            <ul id="entityAndTypeTree" class="easyui-tree" data-options="animate:true"></ul>
        </div>

        <script type="text/javascript">
            var noData = window.parent.parent.parent.parent.GetTextByName("Nodata", window.parent.parent.parent.parent.useprameters.languagedata);

            $.ajax({
                type: "POST",
                url: "../../../Handlers/resPermissions/LoginuserResourcePermissionsByUserId_get.ashx",
                data: { "loginUserId": +Cookies.get("loginUserId"), "dispatchGroup": "dispatch" },
                success: function (msg) {
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
                                    if (node.entityId == null || node.entityId == undefined || node.entityId == "") {
                                        if (node.type == "zhishu") {
                                            var node1 = $("#entityAndTypeTree").tree("getParent", node.target);
                                            window.parent.parent.selectData(node.id, "-1", "dispatch", "", node1.text);
                                        } else { window.parent.parent.selectData(node.id, "-1", "dispatch", "", node.text); }

                                    } else {
                                        window.parent.parent.selectData(node.entityId, node.id, "dipatch", "", node.text);

                                    }
                                },
                                onBeforeExpand: function (node, param) {
                                    $('#entityAndTypeTree').tree('options').url = "../../../Handlers/resPermissions/getOnlySubEntity.ashx?loginuserEntityId=" + Cookies.get["id"] + "&nodeId=" + node.id;
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
        </script>

    </form>
</body>
</html>
