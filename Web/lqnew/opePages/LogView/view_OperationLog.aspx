<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="view_OperationLog.aspx.cs" Inherits="Web.lqnew.opePages.LogView.view_OperationLog" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title></title>


    <style type="text/css">
        body, .style1 {
            background-color: transparent;
            margin: 0px;
            font-size: 12px;
        }

        .style1 {
            width: 100%;
            background-repeat: repeat-y;
        }

        .style2 {
            width: 10px;
        }

        .bg1 {
            background-image: url('../../view_infoimg/images/bg_02.png');
            background-repeat: repeat-x;
            vertical-align: top;
        }

        .bg2 {
            background-image: url('../../view_infoimg/images/bg_10.png');
            background-repeat: repeat-x;
        }

        .bg3 {
            background-image: url('../../view_infoimg/images/bg_05.png');
            background-repeat: repeat-y;
        }

        .bg4 {
            background-image: url('../../view_infoimg/images/bg_06.png');
        }

        .bg5 {
            background-image: url('../../view_infoimg/images/bg_07.png');
            background-repeat: repeat-y;
        }

        #divClose {
            width: 33px;
            height: 16px;
            position: relative;
            border: 0px;
            float: right;
            margin-top: 1px;
            background-image: url('../../view_infoimg/images/minidict_03.png');
            cursor: pointer;
        }

        .td1td {
            background-color: #FFFFFF;
            width: 150px;
            height: 25px;
            text-align: right;
            font-weight: bold;
        }

        .auto-style1 {
            height: 25px;
        }
    </style>
    <script type="text/javascript">
        function Divover(str) {
            var div1 = document.getElementById("divClose");
            if (str == "on") { div1.style.backgroundPosition = "66 0"; }
            else { div1.style.backgroundPosition = "0 0"; }
        }
    </script>
    <script src="../../js/geturl.js" type="text/javascript"></script>
    <script src="../../../JQuery/jquery-1.5.2.js" type="text/javascript"></script>
    <script src="../../../LangJS/managerGroup_langjs.js" type="text/javascript"></script>
</head>
<body>
    <table class="style1" cellpadding="0" cellspacing="0">
        <tr style="height: 5px;">
            <td class="style2">
                <img src="../../view_infoimg/images/bg_01.png" /></td>
            <td class="bg1">
                <div id="divClose" onmouseover="Divover('on')" onclick="window.parent.mycallfunction('LogView/view_OperationLog')" onmouseout="Divover('out')"></div>
            </td>
            <td class="style2">
                <img src="../../view_infoimg/images/bg_04.png" /></td>
        </tr>
        <tr>
            <td class="bg3">&nbsp;</td>
            <td class="bg4" id="dragtd">
                <table id="tb1" align="center" bgcolor="#c0de98" runat="server" border="0" cellpadding="0"
                    cellspacing="1" width="100%" style="table-layout: fixed">
                    <tr>
                        <td align="left" class="td1td">
                            <span id="Lang_sDate" class="Langtxt">时间</span>&nbsp;&nbsp;
                        </td>
                        <td align="left" bgcolor="#FFFFFF">&nbsp;</td>
                    </tr>
                    <tr>
                        <td align="left" class="td1td">
                            <span id="Lang_SchedulISSI" class="Langtxt">调度台ISSI</span>&nbsp;&nbsp;
                        </td>
                        <td align="left" bgcolor="#FFFFFF">&nbsp;</td>
                    </tr>
                    <tr>
                        <td align="left" class="td1td">
                            <span id="Lang_SchedulIP" class="Langtxt">IP</span>&nbsp;&nbsp;
                        </td>
                        <td align="left" bgcolor="#FFFFFF" class="auto-style1"></td>
                    </tr>
                    <tr>
                        <td align="left" class="td1td">
                            <span id="Lang_LoginUser" class="Langtxt">登录用户</span>&nbsp;&nbsp;
                        </td>
                        <td align="left" bgcolor="#FFFFFF">&nbsp;</td>
                    </tr>
                    <tr>
                        <td align="left" class="td1td">
                            <span id="Lang_IdentityDeviceID" class="Langtxt">设备标识</span>&nbsp;&nbsp;
                        </td>
                        <td align="left" bgcolor="#FFFFFF">&nbsp;</td>
                    </tr>
                    <tr>
                        <td align="left" class="td1td">
                            <span id="Lang_IdentityDeviceType" class="Langtxt">设备类型</span>&nbsp;&nbsp;
                        </td>
                        <td align="left" bgcolor="#FFFFFF">&nbsp;</td>
                    </tr>
                    <tr>
                        <td align="left" class="td1td">
                            <span id="Lang_IdentityDeviceUnit" class="Langtxt">设备单位</span>&nbsp;&nbsp;
                        </td>
                        <td align="left" bgcolor="#FFFFFF">&nbsp;</td>
                    </tr>
                    <tr>
                        <td align="left" class="td1td">
                            <span id="Lang_IdentityID" class="Langtxt">载体标识</span>&nbsp;&nbsp;
                        </td>
                        <td align="left" bgcolor="#FFFFFF">&nbsp;</td>
                    </tr>
                    <tr>
                        <td align="left" class="td1td">
                            <span id="Lang_IdentityName" class="Langtxt">载体名称</span>&nbsp;&nbsp;
                        </td>
                        <td align="left" bgcolor="#FFFFFF">&nbsp;</td>
                    </tr>
                    <tr>
                        <td align="left" class="td1td">
                            <span id="Lang_IdentityType" class="Langtxt">载体类型</span>&nbsp;&nbsp;
                        </td>
                        <td align="left" bgcolor="#FFFFFF" class="auto-style1"></td>
                    </tr>
                    <tr>
                        <td align="left" class="td1td">
                            <span id="Lang_IdentityUnit" class="Langtxt">载体单位</span>&nbsp;&nbsp;
                        </td>
                        <td align="left" bgcolor="#FFFFFF">&nbsp;</td>
                    </tr>
                    <tr>
                        <td align="left" class="td1td">
                            <span id="Lang_ModelName" class="Langtxt">模块名称</span>&nbsp;&nbsp;
                        </td>
                        <td align="left" bgcolor="#FFFFFF">&nbsp;</td>
                    </tr>
                    <tr>
                        <td align="left" class="td1td">
                            <span id="Lang_OperationType" class="Langtxt">操作类型</span>&nbsp;&nbsp;
                        </td>
                        <td align="left" bgcolor="#FFFFFF">&nbsp;</td>
                    </tr>
                    <tr style="height: auto">
                        <td align="left" class="td1td">

                            <span id="Lang_Content" class="Langtxt">操作内容</span>&nbsp;&nbsp;
                             
                        </td>
                        <td align="left" bgcolor="#FFFFFF" style="width: 60px; word-wrap: break-word"></td>
                    </tr>
                    <%--<tr>
                        <td align="left" class="td1td">
                            <span id="Lang_Remarks" class="Langtxt" >备注</span>&nbsp;&nbsp;
                        </td>
                        <td align="left" bgcolor="#FFFFFF">&nbsp;</td>
                    </tr>--%>
                </table>
            </td>
            <td class="bg5">&nbsp;</td>
        </tr>
        <tr style="height: 5px;">
            <td>
                <img src="../../view_infoimg/images/bg_09.png" /></td>
            <td class="bg2"></td>
            <td>
                <img src="../../view_infoimg/images/bg_11.png" /></td>
        </tr>
    </table>
    <script src="../../../JQuery/jquery-1.5.2.js" type="text/javascript"></script>
    <script src="../../../JQuery/jquery-ui-autocomplete.js" type="text/javascript"></script>
    <link href="../../../CSS/jquery-ui-1.8.14.custom.css" rel="stylesheet" type="text/css" />
    <script src="../../../JS/LangueSwitch.js"></script>
    <link href="../../../CSS/ui-lightness/jquery-ui-1.8.13.custom.css" rel="stylesheet" type="text/css" />
    <script src="../../../JQuery/jquery-ui-1.8.13.custom.min.js" type="text/javascript"></script>
    <%if (System.Configuration.ConfigurationManager.AppSettings["defaultLanguage"] == "zh-CN")
      { %>
    <script src="../../../JQuery/ui.datepicker-zh-CN.js" type="text/javascript"></script>
    <%} %>
    <script language="javascript" type="text/javascript">
        window.parent.closeprossdiv();
        var dragEnable = 'True';
        function dragdiv() {
            var div1 = window.parent.document.getElementById('LogView/view_OperationLog');
            if (div1 && event.button == 0 && dragEnable == 'True') {
                window.parent.mystartDragWindow(div1, null, event); div1.style.border = "solid 0px transparent"; window.parent.cgzindex(div1);
            }
        }
        function mydragWindow() {
            var div1 = window.parent.document.getElementById('LogView/view_OperationLog');
            if (div1) {
                window.parent.mydragWindow(div1, event);
            }
        }

        function mystopDragWindow() {
            var div1 = window.parent.document.getElementById('LogView/view_OperationLog');
            if (div1) {
                window.parent.mystopDragWindow(div1); div1.style.border = "0px";
            }
        }
        window.onload = function () {

            document.body.onmousedown = function () { dragdiv(); }
            document.body.onmousemove = function () { mydragWindow(); }
            document.body.onmouseup = function () { mystopDragWindow(); }
            document.body.oncontextmenu = function () { return false; }
            document.body.oncontextmenu = function () { return false; }
            var arrayelement = ["input", "a", "select", "li", "font", "textarea"];
            for (n = 0; n < arrayelement.length; n++) {
                var inputs = document.getElementsByTagName(arrayelement[n]);
                for (i = 0; i < inputs.length; i++) {
                    inputs[i].onmouseout = function () {
                        dragEnable = 'True';
                    }
                    inputs[i].onmouseover = function () {
                        dragEnable = 'False';
                    }
                }
            }
            var table = document.getElementById("dragtd");
            table.onmouseout = function () {
                dragEnable = 'True';
            }

            table.onmouseover = function () {
                dragEnable = 'False';
            }
        }
        window.parent.lq_changeheight('LogView/view_OperationLog', document.body.clientHeight); window.parent.change('LogView/view_OperationLog');</script>
    </body>
</html>

