<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="view_LTE_GPS_info.aspx.cs" Inherits="Web.lqnew.opePages.view_info.view_LTE_GPS_info" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
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
            width: 150px;
            height: 25px;
            text-align: right;
            font-weight: bold;
        }
    </style>
<script type="text/javascript">
    window.parent.closeprossdiv();

    function Divover(str) {
        var div1 = document.getElementById("divClose");
        if (str == "on") { div1.style.backgroundPosition = "66 0"; }
        else { div1.style.backgroundPosition = "0 0"; }
    }

    function toHTML(issi, dest, openOrClose, circyle) {
        document.getElementById("Lang_terminal_identification").innerHTML = window.parent.parent.GetTextByName("Lang_terminal_identification", window.parent.parent.useprameters.languagedata);
        document.getElementById("Lang_SendUpDestISSI").innerHTML = window.parent.parent.GetTextByName("Lang_SendUpDestISSI", window.parent.parent.useprameters.languagedata);
        document.getElementById("Lang_GPSSwitch").innerHTML = window.parent.parent.GetTextByName("Lang_GPSSwitch", window.parent.parent.useprameters.languagedata);
        document.getElementById("Lang_GPSCritical").innerHTML = window.parent.parent.GetTextByName("Lang_GPSCritical", window.parent.parent.useprameters.languagedata);

        document.getElementById("issi_Info").innerHTML = issi;
        document.getElementById("dest_Info").innerHTML = dest;
        document.getElementById("openOrClose_Info").innerHTML = openOrClose;
        document.getElementById("circyle_Info").innerHTML = circyle;
    }

    function tohidclosebtn() {
        document.getElementById("divClose").style.display = "none";
    }

   

</script>
<body>
    <form id="form1" runat="server">
    <table class="style1" cellpadding="0" cellspacing="0">
        <tr style="height: 5px;">
            <td class="style2">
                <img alt="" src="../../view_infoimg/images/bg_01.png" />
            </td>
            <td class="bg1">
                <div id="divClose" onmouseover="Divover('on')" onclick="window.parent.mycallfunction('view_info/view_LTE_GPS_info')"
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
                            <span class="Langtxt" id="Lang_terminal_identification" ></span>&nbsp;&nbsp;
                        </td>
                        <td align="left" bgcolor="#FFFFFF" id="issi_info">
                           <span class="Langtxt" id="issi_Info" ></span>&nbsp;&nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td align="left" class="td1td">
                            <span class="Langtxt" id="Lang_SendUpDestISSI" ></span>&nbsp;&nbsp;
                        </td>
                        <td align="left" bgcolor="#FFFFFF">
                            <span class="Langtxt" id="dest_Info" ></span>&nbsp;&nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td align="left" class="td1td">
                            <span class="Langtxt" id="Lang_GPSSwitch" ></span>&nbsp;&nbsp;
                        </td>
                        <td align="left" bgcolor="#FFFFFF">
                           <span class="Langtxt" id="openOrClose_Info" ></span>&nbsp;&nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td align="left" class="td1td">
                            <span class="Langtxt" id="Lang_GPSCritical" ></span>&nbsp;&nbsp;
                        </td>
                        <td align="left" bgcolor="#FFFFFF">
                           <span class="Langtxt" id="circyle_Info" ></span>&nbsp;&nbsp;
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
                <img src="../../view_infoimg/images/bg_09.png" />
            </td>
            <td class="bg2">
            </td>
            <td>
                <img src="../../view_infoimg/images/bg_11.png" />
            </td>
        </tr>
    </table>
    </form>
</body>
</html>
