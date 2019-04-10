<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="view_DXgroup.aspx.cs" Inherits="Web.lqnew.opePages.view_info.view_DXgroup" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title>DIV</title>
    <style type="text/css">
        body, .style1
        {
            background-color: transparent;
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
            background-image: url('../../view_infoimg/images/bg_06.png');
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
        .divgrd
        {
            padding-top: 2px;
            padding-bottom: 2px;
        }
        .td1td
        {
            background-color: #FFFFFF;
            width: 70px;
            height: 25px;
            text-align: right;
            font-weight: bold;
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
    <form id="form1" runat="server">
    <table class="style1" cellpadding="0" cellspacing="0">
        <tr style="height: 5px;">
            <td class="style2">
                <img alt="" src="../../view_infoimg/images/bg_01.png" />
            </td>
            <td class="bg1">
                <div id="divClose" onmouseover="Divover('on')" onclick="window.parent.mycallfunction('view_info/view_DXgroup')"
                    onmouseout="Divover('out')">
                </div>
            </td>
            <td class="style2">
                <img alt="" src="../../view_infoimg/images/bg_04.png" />
            </td>
        </tr>
        <tr>
            <td class="bg3">
                &nbsp;
            </td>
            <td class="bg4" id="dragtd">
                <table id="tb1" align="center" bgcolor="#c0de98" runat="server" border="0" cellpadding="0"
                    cellspacing="1" width="100%">
                    <tr>
                        <td align="left" class="td1td">
                         <span class="Langtxt" id="GroupName" ></span>&nbsp;&nbsp;
                        </td>
                        <td align="left" bgcolor="#FFFFFF">
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td align="left" class="td1td">
                              <span class="Langtxt" id="Unit" ></span>&nbsp;&nbsp;
                        </td>
                        <td align="left" bgcolor="#FFFFFF">
                            &nbsp;
                        </td>
                    </tr>
                    
                    <tr>
                        <td align="left" class="td1td">
                             <span class="Langtxt" id="Membersgroup" ></span>&nbsp;&nbsp;
                        </td>
                        <td align="left" bgcolor="#FFFFFF">
                            <div class="divgrd" runat="server" id="tbtbz" style="overflow-y: auto; height: 120px">
                            </div>
                        </td>
                    </tr>
                </table>
            </td>
            <td class="bg5">
                &nbsp;
            </td>
        </tr>
        <tr style="height: 5px;">
            <td>
                <img alt="" src="../../view_infoimg/images/bg_09.png" />
            </td>
            <td class="bg2">
            </td>
            <td>
                <img alt="" src="../../view_infoimg/images/bg_11.png" />
            </td>
        </tr>
    </table>
    </form>
</body>
<script type="text/javascript">
    var dragEnable = 'True';
    function dragdiv() {
        var div1 = window.parent.document.getElementById('view_info/view_DXgroup');
        if (div1 && event.button == 0 && dragEnable == 'True') {
            window.parent.mystartDragWindow(div1, null, event); div1.style.border = "solid 0px transparent"; window.parent.cgzindex(div1);

        }
    }
    function mydragWindow() {
        var div1 = window.parent.document.getElementById('view_info/view_DXgroup');
        if (div1) {
            window.parent.mydragWindow(div1, event);
        }
    }

    function mystopDragWindow() {
        var div1 = window.parent.document.getElementById('view_info/view_DXgroup');
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

    window.parent.lq_changeheight('view_info/view_DXgroup', document.body.clientHeight);
    window.parent.change('view_info/view_DXgroup');

</script>
</html>
<script type="text/javascript">
    window.parent.closeprossdiv();

</script>
