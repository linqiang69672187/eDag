<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="view_Cycle.aspx.cs" Inherits="Web.lqnew.opePages.view_info.View_Cycle" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
</head>
     <script src="../../js/geturl.js" type="text/javascript"></script>
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

    .Langtxt {
        border:0px;
    }
    
    .gridheadcss th {
        background-image: url(../images/tab_14.gif);
        height: 25px;
    }

    #GridView1 {
        margin-top: 3px;
    }

    .divgrd {
        padding-top: 2px;
        padding-bottom: 2px;
    }

    .td1td {
        background-color: #FFFFFF;
        width: 150px;
        height: 25px;
        text-align: right;
        font-weight: bold;
    }
</style>
<script type="text/javascript">
    window.parent.closeprossdiv();

    var isCycle = false;
    function Divover(str) {
        var div1 = document.getElementById("divClose");
        if (str == "on") { div1.style.backgroundPosition = "66 0"; }
        else { div1.style.backgroundPosition = "0 0"; }
    }

    function toHTML(setNum, IsCycle) {
        isCycle = IsCycle;
        if (IsCycle) {
            document.getElementById("setValue").innerHTML = window.parent.parent.GetTextByName("window_Set_Number", window.parent.parent.useprameters.languagedata) + ":" + setNum + "s, ";
            document.getElementById("value").innerHTML = window.parent.parent.GetTextByName("everyISSI_Effective_Number", window.parent.parent.useprameters.languagedata);
            document.getElementById("lte_Explain").style.visibility = "visible";
            if (parseInt(setNum) == 0) {
                document.getElementById("TETRA_num").innerHTML = window.parent.parent.GetTextByName("Invalid", window.parent.parent.useprameters.languagedata);
                document.getElementById("PDT_num").innerHTML = "0s";
                document.getElementById("BEIDOU_num").innerHTML = window.parent.parent.GetTextByName("Invalid", window.parent.parent.useprameters.languagedata);
                document.getElementById("LTE_num").innerHTML = window.parent.parent.GetTextByName("Invalid", window.parent.parent.useprameters.languagedata);
            } else if (parseInt(setNum) > 0) {
                document.getElementById("TETRA_num").innerHTML = getTETRA_Cycle(parseInt(setNum)) + "";
                document.getElementById("PDT_num").innerHTML = getPDT_Cycle(parseInt(setNum)) + "";
                document.getElementById("BEIDOU_num").innerHTML = getTETRA_Cycle(parseInt(setNum)) + "";
                document.getElementById("LTE_num").innerHTML = parseInt(setNum) + "";
            } else {
                document.getElementById("TETRA_num").innerHTML = window.parent.parent.GetTextByName("Invalid", window.parent.parent.useprameters.languagedata);
                document.getElementById("PDT_num").innerHTML = window.parent.parent.GetTextByName("Invalid", window.parent.parent.useprameters.languagedata);
                document.getElementById("BEIDOU_num").innerHTML = window.parent.parent.GetTextByName("Invalid", window.parent.parent.useprameters.languagedata);
                document.getElementById("LTE_num").innerHTML = window.parent.parent.GetTextByName("Invalid", window.parent.parent.useprameters.languagedata);
            }
        } else {
            document.getElementById("setValue").innerHTML = window.parent.parent.GetTextByName("window_Set_Number", window.parent.parent.useprameters.languagedata) + ":" + setNum + "m, ";
            document.getElementById("value").innerHTML = window.parent.parent.GetTextByName("everyISSI_Effective_Number", window.parent.parent.useprameters.languagedata);
            document.getElementById("lte_Explain").style.visibility = "hidden";
            if (parseInt(setNum) == 0) {
                document.getElementById("TETRA_num").innerHTML = window.parent.parent.GetTextByName("Invalid", window.parent.parent.useprameters.languagedata);
                document.getElementById("PDT_num").innerHTML = "0m";
                document.getElementById("BEIDOU_num").innerHTML = window.parent.parent.GetTextByName("Invalid", window.parent.parent.useprameters.languagedata);
                document.getElementById("LTE_num").innerHTML = window.parent.parent.GetTextByName("Invalid", window.parent.parent.useprameters.languagedata);
            } else if (parseInt(setNum) > 0) {
                document.getElementById("TETRA_num").innerHTML = getTETRA_Distance(parseInt(setNum)) + "m";
                document.getElementById("PDT_num").innerHTML = getPDT_Distance(parseInt(setNum)) + "m";
                document.getElementById("BEIDOU_num").innerHTML = getTETRA_Distance(parseInt(setNum)) + "m";
                document.getElementById("LTE_num").innerHTML = parseInt(setNum) + "m";
            } else {
                document.getElementById("TETRA_num").innerHTML = window.parent.parent.GetTextByName("Invalid", window.parent.parent.useprameters.languagedata);
                document.getElementById("PDT_num").innerHTML = window.parent.parent.GetTextByName("Invalid", window.parent.parent.useprameters.languagedata);
                document.getElementById("BEIDOU_num").innerHTML = window.parent.parent.GetTextByName("Invalid", window.parent.parent.useprameters.languagedata);
                document.getElementById("LTE_num").innerHTML = window.parent.parent.GetTextByName("Invalid", window.parent.parent.useprameters.languagedata);
            }
        }
    }

    function tohidclosebtn() {
        document.getElementById("divClose").style.display = "none";
    }
    function getTETRA_Cycle(num) {
        if (num <= 0)
        { return -1; }
        else if (num < 10)
        { return 10; }
        else if (num < 300) {
            if (num % 10 == 0) {
                return 10 * parseInt(num / 10);
            } else {
                return 10 * parseInt(num / 10 + 1);
            }
        }
        else if (num < 1200) {
            if ((num - 300) % 30 == 0) { return parseInt((num - 300) / 30) * 30 + 300; } else {
                return parseInt((num - 300) / 30 + 1) * 30 + 300;
            }
        }
        else if (num < 5220) {
            if ((num - 1200) % 60 == 0) { return parseInt((num - 1200) / 60) * 60 + 1200; } else {
                return parseInt((num - 1200) / 60 + 1) * 60 + 1200;
            }
        }
        else
            return 5280;
    }

    function getPDT_Cycle(num) {
        if (num < 0)
        { return -1; }
        else if (num < 30)
        { return num; }
        else if (num < 62)
        { return 30; }
        else if (num < 100) {
                return parseInt(num / 2 ) * 2;
        }
        else if (num < 153)
        { return 100; }
        else if (num < 240) {
                return parseInt(num / 3 ) * 3;
        }
        else if (num < 405)
        { return 240; }
        else if (num < 500) {
                return parseInt(num / 5 ) * 5;
        }
        else if (num < 1010)
        { return 500; }
        else if (num < 1100) {
                return parseInt(num / 10 ) * 10;
        }
        else if (num < 3330)
        { return 1100; }
        else if (num < 3750) {
                return parseInt(num / 30 ) * 30;
        }
        else if (num < 7200)
        { return 3750; }
        else if (num < 10800)
        { return 7200; }
        else
            return 10800;
        /*
        if (num < 0)
        { return -1; }
        else if (num < 30)
        { return num; }
        else if (num < 62)
        { return 30; }
        else if (num < 100) {
            if (num % 2 == 0) { return parseInt(num / 2) * 2; } else {
                return parseInt(num / 2 + 1) * 2;
            }
        }
        else if (num < 153)
        { return 100; }
        else if (num < 240) {
            if (num % 3 == 0) { return parseInt(num / 3) * 3; } else {
                return parseInt(num / 3 + 1) * 3;
            }
        }
        else if (num < 405)
        { return 240; }
        else if (num < 500) {
            if (num % 5 == 0) { return parseInt(num / 5) * 5; } else {
                return parseInt(num / 5 + 1) * 5;
            }
        }
        else if (num < 1010)
        { return 500; }
        else if (num < 1100) {
            if (num % 10 == 0) { return parseInt(num / 10) * 10; } else {
                return parseInt(num / 10 + 1) * 10;
            }
        }
        else if (num < 3330)
        { return 1100; }
        else if (num < 3750) {
            if (num % 30 == 0) { return parseInt(num / 30) * 30; } else {
                return parseInt(num / 30 + 1) * 30;
            }
        }
        else if (num < 7200)
        { return 3750; }
        else if (num < 10800)
        { return 7200; }
        else
            return 10800;
            */
    }

    function getTETRA_Distance(num) {
        if (num <= 0)
        { return -1; }
        if (num <= 10000) {
            if (num % 100 == 0) { return (parseInt(num / 100) * 100); } else {
                return (parseInt(num / 100 + 1) * 100);
            }
        }
        else if (num <= 24000) {
            if ((num - 10000) % 500 == 0) { return parseInt((num - 10000) / 500) * 500 + 10000; } else {
                return parseInt((num - 10000) / 500 + 1) * 500 + 10000;
            }
        } else {
            return 24000;
        }
    }

    function getPDT_Distance(num) {
        if (num == 0)
        { return -1; }
        else if (num < 5)
        { return 0; }
        else if (num < 10)
        { return 5; }
        else if (num < 30)
        { return 10; }
        else if (num < 60)
        { return 30; }
        else if (num < 120)
        { return 60; }
        else if (num < 220)
        { return 120; }
        else if (num < 350)
        { return 220; }
        else if (num < 500)
        { return 350; }
        else if (num < 700)
        { return 500; }
        else if (num < 1000)
        { return 700; }
        else if (num < 1300)
        { return 1000; }
        else if (num < 1700)
        { return 1300; }
        else if (num < 2200)
        { return 1700; }
        else if (num < 2800)
        { return 2200; }
        else if (num < 3500)
        { return 2800; }
        else { return 3500; }
    }
    function view(type) {
        window.parent.parent.parent.mycallfunction('view_info/view_ExplainCycle', 500, 800, 0, 2014);
        var num = 0;
        var viewInterval = setInterval(function () {
            if (window.parent.parent.parent.document.frames["view_info/view_ExplainCycle_ifr"] != null || window.parent.parent.parent.document.frames["view_info/View_ExplainCycle_ifr"] != undefined) {
                if ((typeof window.parent.parent.parent.document.frames["view_info/view_ExplainCycle_ifr"].toHTML).toString() != "undefined") {
                    clearInterval(viewInterval);
                    window.parent.parent.parent.document.frames["view_info/view_ExplainCycle_ifr"].toHTML(type, true);
                } else { clearInterval(viewInterval); }
            } else {
                if (num >= 5) { clearInterval(viewInterval); }
                else { num++; }
            }
        }, 1000);
    }
    var dragEnable = 'True';
    function dragdiv() {
        var div1 = window.parent.parent.parent.document.getElementById("view_info/view_Cycle");
        if (div1 && event.button == 0 && dragEnable == 'True') {
            window.parent.parent.parent.mystartDragWindow(div1, null, event); div1.style.border = "solid 0px transparent"; window.parent.cgzindex(div1);

        }
    }
    function mydragWindow() {
        var div1 = window.parent.parent.parent.document.getElementById("view_info/view_Cycle");
        if (div1) {
            window.parent.parent.parent.mydragWindow(div1, event);
        }
    }
    function mystopDragWindow() {
        var div1 = window.parent.parent.parent.document.getElementById("view_info/view_Cycle");
        if (div1) {
            window.parent.parent.parent.mystopDragWindow(div1); div1.style.border = "0px";
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
        }}
</script>
<body>
    <form id="form1" runat="server">
        <table class="style1" cellpadding="0" cellspacing="0">
            <tr style="height: 5px;">
                <td class="style2">
                    <img alt="" src="../../view_infoimg/images/bg_01.png" />
                </td>
                <td class="bg1" colspan="2" onmousemove=" mydragWindow()" onmouseup="mystopDragWindow()" onmousedown="dragdiv()">
                    <div id="divClose" onclick="window.parent.parent.parent.parent.mycallfunction('view_info/view_Cycle')">
                    </div>
                </td>
                <td class="style2">
                    <img alt="" src="../../view_infoimg/images/bg_04.png" />
                </td>
            </tr>
            <tr>
                <td class="bg3">&nbsp;
                </td>
                <td class="bg4" id="dragtd" colspan="2">
                    <table id="tb1" align="center" bgcolor="#c0de98" runat="server" border="0" cellpadding="0"
                        cellspacing="1" width="100%">
                        <tr>
                            <td colspan="3" class="td1td" style="text-align:center">
                                <span id="setValue" style="color: blue;"></span>
                                <span id="value" style="color: blue;"></span>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" class="td1td" style="width:40%;">
                                <span class="Langtxt">TETRA</span>&nbsp;&nbsp;
                            </td>
                            <td style="text-align:center;width:40%;" bgcolor="#FFFFFF">
                                <span class="Langtxt" id="TETRA_num"></span>
                            </td>
                            <td align="left" bgcolor="#FFFFFF" id="Td1" style="width:20%;">
                                <img src="../../../Images/question.jpg" onclick="view('TETRA')" style="cursor:hand;"/>
                            </td>
                        </tr>
                        <tr>
                            <td align="center" class="td1td" style="width:40%;">
                                <span class="Langtxt">PDT</span>&nbsp;&nbsp;
                            </td>
                            <td style="text-align:center;width:40%;" bgcolor="#FFFFFF">
                                <span class="Langtxt" id="PDT_num"></span>
                            </td>
                            <td align="left" bgcolor="#FFFFFF" style="width:20%;">
                                <img src="../../../Images/question.jpg" onclick="view('PDT')" style="cursor:hand;" />
                            </td>
                        </tr>
                        <tr>
                            <td align="left" class="td1td" style="width:40%;">
                                <span class="Langtxt">BEIDOU</span>&nbsp;&nbsp;
                            </td>
                            <td style="text-align:center;width:40%;" bgcolor="#FFFFFF">
                                <span class="Langtxt" id="BEIDOU_num"></span>
                            </td>
                            <td align="left" bgcolor="#FFFFFF" style="width:20%;">
                                <img src="../../../Images/question.jpg" onclick="view('BEIDOU')"  style="cursor:hand;"/>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" class="td1td" style="width:40%;">
                                <span class="Langtxt">LTE</span>&nbsp;&nbsp;
                            </td>
                            <td style="text-align:center;width:40%;" bgcolor="#FFFFFF">
                                <span class="Langtxt" id="LTE_num"></span>
                            </td>
                            <td align="left" bgcolor="#FFFFFF" style="width:20%;">
                                <img id="lte_Explain" src="../../../Images/question.jpg" onclick="view('LTE')" style="cursor:hand;" />
                            </td>
                        </tr>
                    </table>
                </td>
                <td class="bg5">&nbsp;
                </td>
            </tr>
            <tr style="height: 5px;">
                <td>
                    <img src="../../view_infoimg/images/bg_09.png" />
                </td>
                <td class="bg2" colspan="2"></td>
                <td>
                    <img src="../../view_infoimg/images/bg_11.png" />
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
