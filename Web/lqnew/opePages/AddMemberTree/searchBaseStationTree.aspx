<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="searchBaseStationTree.aspx.cs" Inherits="Web.lqnew.opePages.AddMemberTree.searchBaseStationTree" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
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
                url: "../../../Handlers/GetBaseStationForTree.ashx",
                data: "bsType=singleRoot",
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
                                    window.parent.parent.selectBaseStationData("singleChildren",node.text);
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
