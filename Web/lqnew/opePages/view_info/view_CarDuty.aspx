<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="view_CarDuty.aspx.cs" Inherits="Web.lqnew.opePages.view_info.view_CarDuty" %>



<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title></title>
    <style type="text/css">
        body, .style1
        {
            background-color:white;
            margin: 0px;
            font-size: 12px;
        }

        .style1
        {
            width: 100%;
            background-repeat: repeat-y;
        }

        .style2
        {
            width: 10px;
        }

        .bg1
        {
            background-image: url('../../view_infoimg/images/bg_02.png');
            background-repeat: repeat-x;
            vertical-align: top;
        }

        .bg2
        {
            background-image: url('../../view_infoimg/images/bg_10.png');
            background-repeat: repeat-x;
        }

        .bg3
        {
            background-image: url('../../view_infoimg/images/bg_05.png');
            background-repeat: repeat-y;
        }

        .bg4
        {
           
        }

        .bg5
        {
            background-image: url('../../view_infoimg/images/bg_07.png');
            background-repeat: repeat-y;
        }

        #divClose
        {
            width: 33px;
            height: 16px;
            position: relative;
            border: 0px;
            float: right;
            margin-top: 1px;
            background-image: url('../../view_infoimg/images/minidict_03.png');
            cursor: pointer;
        }

        .gridheadcss th
        {
            background-image: url(../images/tab_14.gif);
            height: 25px;
        }

        #GridView1
        {
            margin-top: 3px;
        }

        .td1td
        {
            background-color:white;
            width: 150px;
            height: 25px;
            text-align: left;
            font-weight: bold;
        }

        .divgrd
        {
            margin: 2 0 2 0;
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
    <script src="../../../JS/LangueSwitch.js" type="text/javascript"></script>
</head>
<body>
    <form id="form1" runat="server">
        <table class="style1" cellpadding="0" cellspacing="0">
            <tr style="height: 5px;">
                <td class="style2">
                    <img src="../../images/tab_03.png" /></td>
                <td background="../../images/tab_05.gif">
                    <div id="divClose" onmouseover="Divover('on')" onclick="window.parent.mycallfunction('view_info/view_CarDuty')" onmouseout="Divover('out')"></div>
                </td>
               <td width="14">
                                <img src="../../images/tab_07.png" width="14" height="32" />
                            </td>
            </tr>
            <tr>
                <td  background="../../images/tab_12.gif">&nbsp;</td>
                <td class="bg4" id="dragtd">
                    <div style="width:100%;height:300px;overflow:auto">
                    <asp:Label runat="server" ID="lb_Content"></asp:Label>
                   </div>
                </td>
                <td background="../../images/tab_16.gif">&nbsp;</td>
            </tr>
            <tr style="height: 5px;">
                <td width="15" height="15">
                                <img src="../../images/tab_20.png" width="15" height="15" />
                            </td>
                            <td background="../../images/tab_21.gif">
                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td width="25%" nowrap="nowrap">
                                            &nbsp;
                                        </td>
                                        <td width="75%" valign="top" class="STYLE1">
                                            &nbsp;
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td width="14">
                                <img src="../../images/tab_22.png" width="14" height="15" />
                            </td>
            </tr>
        </table>
    </form>
</body>
<script type="text/javascript">
    var dragEnable = 'True';
    function dragdiv() {
        var div1 = window.parent.document.getElementById('view_info/view_CarDuty');
        if (div1 && event.button == 0 && dragEnable == 'True') {
            window.parent.mystartDragWindow(div1, null, event); div1.style.border = "solid 0px transparent";
            window.parent.cgzindex(div1);

        }
    }
    function mydragWindow() {
        var div1 = window.parent.document.getElementById('view_info/view_CarDuty');
        if (div1) {
            window.parent.mydragWindow(div1, event);
        }
    }

    function mystopDragWindow() {
        var div1 = window.parent.document.getElementById('view_info/view_CarDuty');
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
    window.parent.lq_changeheight('view_info/view_CarDuty', document.body.clientHeight);
    window.parent.change('view_info/view_CarDuty');

</script>
</html>
<script type="text/javascript">
    window.parent.closeprossdiv();

</script>
