<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="view_ISSI.aspx.cs" Inherits="Web.lqnew.opePages.view_info.add_Member" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title></title>
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

        .td1td
        {
            background-color: #FFFFFF;
            width: 90px;
            height: 25px;
            text-align: right;
            font-weight: bold;
        }

        .divgrd
        {
            margin: 2 0 2 0;
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
    <script src="../../../JS/LangueSwitch.js" type="text/javascript"></script>
</head>
<body>
    <form id="form1" runat="server">
        <table class="style1" cellpadding="0" cellspacing="0">
            <tr style="height: 5px;">
                <td class="style2">
                    <img src="../../view_infoimg/images/bg_01.png" /></td>
                <td class="bg1">
                    <div id="divClose" onmouseover="Divover('on')" onclick="window.parent.mycallfunction('view_info/view_ISSI')" onmouseout="Divover('out')"></div>
                </td>
                <td class="style2">
                    <img src="../../view_infoimg/images/bg_04.png" /></td>
            </tr>
            <tr>
                <td class="bg3">&nbsp;</td>
                <td class="bg4" id="dragtd">
                    <table id="tb1" align="center" bgcolor="#c0de98" runat="server" border="0" cellpadding="0"
                        cellspacing="1" width="100%">
                        <tr>
                            <td align="left" class="td1td"><%--终端号码：--%>

                                <span id="Lang_terminal_identification"></span>&nbsp;&nbsp;
                            </td>
                            <td align="left" bgcolor="#FFFFFF">&nbsp;</td>
                        </tr>
                        
                        <tr>
                            <td align="left" class="td1td"><%--终端类型：--%>

                                <span id="Lang_TerminalType"></span>&nbsp;&nbsp;
                            </td>
                            <td align="left" bgcolor="#FFFFFF" class="auto-style1"></td>
                        </tr>
                        <tr id="tr_ipAddress" style="display:none">
                            <td align="left" class="td1td"><%--IP：--%>
                                <span id="Lang_ipAddress"></span>&nbsp;&nbsp;
                            </td>
                            <td align="left" bgcolor="#FFFFFF" class="auto-style1"></td>
                        </tr>
                        <tr>
                            <td align="left" class="td1td"><%--终端是否有效：--%>
                                <span id="Lang_terminalStatus"></span>&nbsp;&nbsp;
                            </td>
                            <td align="left" bgcolor="#FFFFFF" class="auto-style1"></td>
                        </tr>
                        <tr>
                            <td align="left" class="td1td"><%--所属单位：--%>

                                 <span id="Lang_SubordinateunitsBelong"></span>&nbsp;&nbsp;
                            </td>
                            <td align="left" bgcolor="#FFFFFF">&nbsp;</td>
                        </tr>
                        <tr>
                            <td align="left" class="td1td"><%--备注：--%>
                                 <span id="Lang_Remark"></span>&nbsp;&nbsp;
                            </td>
                            <td align="left" bgcolor="#FFFFFF">&nbsp;</td>
                        </tr>
                        <tr>
                            <td align="left" class="td1td"><%--驻留组：--%>
                                <span id="Lang_zhuliuzuBelong"></span>&nbsp;&nbsp;
                            </td>
                            <td align="left" bgcolor="#FFFFFF">&nbsp;</td>
                        </tr>
                        <tr>
                            <td  align="left" class="td1td"><%--通播组：--%>
                                <span id="Lang_multicastgroupBelong"></span>&nbsp;&nbsp;
                            </td>
                            <td align="left" bgcolor="#FFFFFF">
                                <table align="center" border="0" cellpadding="0" cellspacing="0" width="100%">
                                    <tr>
                                        <td height="30">
                                            <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                                <tr>
                                                    <td height="30" width="15">
                                                        <img height="30" src="../images/tab_03.gif" width="15" /></td>
                                                    <td background="../images/tab_05.gif">&nbsp;</td>
                                                    <td width="14">
                                                        <img height="30" src="../images/tab_07.gif" width="14" /></td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                                <tr>
                                                    <td background="../images/tab_12.gif" width="9">&nbsp;</td>
                                                    <td bgcolor="#f3ffe3">
                                                        <div class="divgrd" runat="server" id="tbtbz" style="overflow-y: auto; height: 120px">
                                                        </div>
                                                    </td>
                                                    <td background="../images/tab_16.gif" width="9">&nbsp;</td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td height="15">
                                            <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                                <tr>
                                                    <td height="29" width="15">
                                                        <img height="29" src="../images/tab_20.gif" width="15" /></td>
                                                    <td background="../images/tab_21.gif">&nbsp;</td>
                                                    <td width="14">
                                                        <img height="29" src="../images/tab_22.gif" width="14" /></td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" class="td1td"><%--扫描组：--%>
                                <span id="Lang_saomiaozuBelong"></span>&nbsp;&nbsp;
                            </td>
                            <td align="left" bgcolor="#FFFFFF">
                                <table align="center" border="0" cellpadding="0" cellspacing="0" width="100%">
                                    <tr>
                                        <td height="30">
                                            <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                                <tr>
                                                    <td height="30" width="15">
                                                        <img height="30" src="../images/tab_03.gif" width="15" /></td>
                                                    <td background="../images/tab_05.gif">&nbsp;</td>
                                                    <td width="14">
                                                        <img height="30" src="../images/tab_07.gif" width="14" /></td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                                <tr>
                                                    <td background="../images/tab_12.gif" width="9">&nbsp;</td>
                                                    <td bgcolor="#f3ffe3">
                                                        <div class="divgrd" runat="server" id="tbsmz" style="overflow-y: auto; height: 120px">
                                                        </div>
                                                    </td>
                                                    <td background="../images/tab_16.gif" width="9">&nbsp;</td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td height="15">
                                            <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                                <tr>
                                                    <td height="29" width="15">
                                                        <img height="29" src="../images/tab_20.gif" width="15" /></td>
                                                    <td background="../images/tab_21.gif">&nbsp;</td>
                                                    <td width="14">
                                                        <img height="29" src="../images/tab_22.gif" width="14" /></td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
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
    </form>
</body>
<script type="text/javascript">
    var dragEnable = 'True';
    function dragdiv() {
        var div1 = window.parent.document.getElementById('view_info/view_ISSI');
        if (div1 && event.button == 0 && dragEnable == 'True') {
            window.parent.mystartDragWindow(div1, null, event); div1.style.border = "solid 0px transparent";
            window.parent.cgzindex(div1);

        }
    }
    function mydragWindow() {
        var div1 = window.parent.document.getElementById('view_info/view_ISSI');
        if (div1) {
            window.parent.mydragWindow(div1, event);
        }
    }

    function mystopDragWindow() {
        var div1 = window.parent.document.getElementById('view_info/view_ISSI');
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
    window.parent.lq_changeheight('view_info/view_ISSI', document.body.clientHeight);
    window.parent.change('view_info/view_ISSI');

</script>
</html>
<script type="text/javascript">
    window.parent.closeprossdiv();

</script>
