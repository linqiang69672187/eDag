<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="view_GPSSetInfo.aspx.cs" Inherits="Web.lqnew.opePages.view_info.view_GPSSetInfo" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title><%--接收号码--%></title>
    <link href="../../css/lq_manager.css" rel="stylesheet" />
    <link href="../../../CSS/pagestyle.css" rel="stylesheet" />
    <style type="text/css">
        body, .style1 {
            background-color: transparent;
            margin: 0px;
            font-size: 12px;
            scrollbar-face-color: #DEDEDE;
            scrollbar-base-color: #F5F5F5;
            scrollbar-arrow-color: black;
            scrollbar-track-color: #F5F5F5;
            scrollbar-shadow-color: #EBF5FF;
            scrollbar-highlight-color: #F5F5F5;
            scrollbar-3dlight-color: #C3C3C3;
            scrollbar-darkshadow-Color: #9D9D9D;
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
            cursor: hand;
        }

        .gridheadcss th {
            background-image: url(../images/tab_14.gif);
            height: 25px;
        }

        #GridView1, #GridView12 {
            margin-top: 3px;
            font-size: 12px;
        }

        .td1td {
            background-color: #FFFFFF;
            text-align: right;
        }

        .divgrd {
            margin: 2 0 2 0;
            overflow: auto;
            height: 365px;
        }

        #tags {
            width: 99px;
        }

        .style3 {
            width: 37px;
        }
    </style>

    <script src="../../../JQuery/jquery-1.5.2.js" type="text/javascript"></script>
    <script src="../../../JQuery/jquery-ui-autocomplete.js" type="text/javascript"></script>
    <link href="../../../CSS/jquery-ui-1.8.14.custom.css" rel="stylesheet" type="text/css" />
    <script src="../../../JS/LangueSwitch.js"></script>
    <link href="../../../CSS/ui-lightness/jquery-ui-1.8.13.custom.css" rel="stylesheet"
        type="text/css" />
    <script src="../../../JQuery/jquery-ui-1.8.13.custom.min.js" type="text/javascript"></script>
    <%if (System.Configuration.ConfigurationManager.AppSettings["defaultLanguage"] == "zh-CN")
      { %>
    <script src="../../../JQuery/ui.datepicker-zh-CN.js" type="text/javascript"></script>
    <%} %>
  
    <script src="../../js/geturl.js" type="text/javascript"></script>
</head>
<body>
    <form id="form1" runat="server">

        <table class="style1" cellpadding="0" cellspacing="0">
            <tr style="height: 5px;" id="derppp">
                <td class="style2">
                    <img src="../../images/tab_03.png" width="15" height="32" /></td>
                <td background="../../images/tab_05.gif">
                    <div id="divClose" onmouseover="Divover('on')" onclick="closethispage()" onmouseout="Divover('out')"></div>
                </td>
                <td class="style2">
                    <img src="../../images/tab_07.png" width="14" height="32" /></td>
            </tr>
            <tr>
                <td width="15" background="../../images/tab_12.gif">&nbsp;
                </td>
                <td class="bg4" id="dragtd">
                    <div style="width: 600px; height: 150px" id="showDiv">
                        <div id="divtitle" style="width:100%;"></div>
                        <div id="Tetra" style="width:100%;"></div>
                        <div id="Pdt" style="width:100%;"></div>
                         <div id="Beidou" style="width:100%;"></div>
                         <div id="Lte" style="width:100%;"></div>
                         <div style="position:absolute;left:200px;width:300px;">
                            <img id="sure" src="../../images/add_ok.png" onclick="toBeSure()" style="cursor: hand;visibility:hidden;" />&nbsp;&nbsp;&nbsp;
                            <img id="cancel"  style="cursor: hand;visibility:hidden;" onclick="toBeCancel()" src="../../images/add_cancel.png" />
                        </div>
                    </div>
                </td>
                <td width="14" background="../../images/tab_16.gif">&nbsp;
                </td>
            </tr>
            <tr style="height: 15px;">
                <td>
                    <img src="../../images/tab_20.png" width="15" height="15" /></td>
                <td background="../../images/tab_21.gif"></td>
                <td>
                    <img src="../../images/tab_22.png" width="14" height="15" /></td>
            </tr>
        </table>
    </form>
</body>
    
 <script type="text/javascript">
     window.parent.closeprossdiv();
     LanguageSwitch(window.parent.parent);

     var imageOK = window.document.getElementById("sure");
     var sourceOK ="../"+ window.parent.parent.GetTextByName("LangConfirm", window.parent.parent.useprameters.languagedata);
     imageOK.setAttribute("src", sourceOK);
     var imageCancel = document.getElementById("cancel");
     var sourceCancel ="../"+ window.parent.parent.GetTextByName("Lang-Cancel", window.parent.parent.useprameters.languagedata);
     imageCancel.setAttribute("src", sourceCancel);

     function changeTwoDecimal(x) {
         var f_x = parseFloat(x);
         if (isNaN(f_x)) {
             alert('function:changeTwoDecimal->parameter error');
             return false;
         }
         var f_x = Math.round(x * 100) / 100;

         return f_x;
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

     var controlUsers = new Array();
     var model;
     var cycle;
     var destissi;
     var distance;
     var open;
     var switchToAll;
     var cycleToAll;

     function toHTML(SelectUsers, hasTETRA, hasPDT, hasBEIDOU, hasLTE, Open, Cycle, Distance, DestIssi, Model, SwitchToAll, CycleToAll) {
         controlUsers = SelectUsers;
         model = Model;
         cycle = Cycle;
         destissi = DestIssi;
         distance = Distance;
         open = Open;
         switchToAll = SwitchToAll;
         cycleToAll = CycleToAll;
         var height = 40
         if (hasTETRA) {
             var strTETRA = "<table style='width:100%;'>";
             strTETRA += "<tr style='text-align:center;'><th style='font-family: Arial' scope='col' colspan='5' align='center'><span>" + "TETRA" + " " + window.parent.GetTextByName("Terminal_GPSControlInfo", window.parent.useprameters.languagedata) + "</span></th></tr>";
             strTETRA += "<tr>";
             if (SwitchToAll) {
                 if (open == "-1") {
                     strTETRA += "<td style='width:20%;text-align:center;'><span>" + window.parent.GetTextByName("Lang_GPSEnableOrDisable", window.parent.useprameters.languagedata) + ":" + window.parent.GetTextByName("Undo", window.parent.useprameters.languagedata) + "</span></td>";
                 } else {
                     if (open == "1") {
                         strTETRA += "<td style='width:20%;text-align:center;'><span>" + window.parent.GetTextByName("Lang_GPSEnableOrDisable", window.parent.useprameters.languagedata) + ":" + window.parent.GetTextByName("Log_GPS_Open_Success", window.parent.useprameters.languagedata) + "</span></td>";
                     } else {
                         strTETRA += "<td style='width:20%;text-align:center;'><span>" + window.parent.GetTextByName("Lang_GPSEnableOrDisable", window.parent.useprameters.languagedata) + ":" + window.parent.GetTextByName("Log_GPS_Close_Success", window.parent.useprameters.languagedata) + "</span></td>";
                     }
                 }
             } else {
                 strTETRA += "<td style='width:20%;text-align:center;'><span>" + window.parent.GetTextByName("Lang_GPSEnableOrDisable", window.parent.useprameters.languagedata) + ":" + window.parent.GetTextByName("Undo", window.parent.useprameters.languagedata) + "</span></td>";
             }
             if (CycleToAll) {
                 if (parseInt(Cycle.trim()) > 0 && Cycle.trim() != "") {
                     strTETRA += "<td style='width:20%;text-align:center;'><span>" + window.parent.GetTextByName("Lang_SendUpIntral", window.parent.useprameters.languagedata) + ":" + getTETRA_Cycle(cycle) + "s</span></td>";
                 } else {
                     strTETRA += "<td style='width:20%;text-align:center;'><span>" + window.parent.GetTextByName("Lang_SendUpIntral", window.parent.useprameters.languagedata) + ":" + window.parent.GetTextByName("Undo", window.parent.useprameters.languagedata) + "</span></td>";
                 }
             } else {
                 strTETRA += "<td style='width:20%;text-align:center;'><span>" + window.parent.GetTextByName("Lang_SendUpIntral", window.parent.useprameters.languagedata) + ":" + window.parent.GetTextByName("Undo", window.parent.useprameters.languagedata) + "</span></td>";
             }
             if (parseInt(DestIssi.trim()) > 0 && DestIssi.trim() != "" && parseInt(DestIssi.trim()) < 16777216) {
                 strTETRA += "<td style='width:20%;text-align:center;'><span>" + window.parent.GetTextByName("Lang_SendUpDestISSI", window.parent.useprameters.languagedata) + ":" + parseInt(DestIssi.trim()) + "</span></td>";
             } else {
                 strTETRA += "<td style='width:20%;text-align:center;'><span>" + window.parent.GetTextByName("Lang_SendUpDestISSI", window.parent.useprameters.languagedata) + ":" + window.parent.GetTextByName("Undo", window.parent.useprameters.languagedata) + "</span></td>";
             }
             if (parseInt(Distance.trim()) > 0 && Distance.trim() != "") {
                 strTETRA += "<td style='width:20%;text-align:center;'><span>" + window.parent.GetTextByName("Lang_GPS_Distance_Modify", window.parent.useprameters.languagedata) + ":" + getTETRA_Distance(parseInt(distance.trim())) + "m</span></td>";
             } else {
                 strTETRA += "<td style='width:20%;text-align:center;'><span>" + window.parent.GetTextByName("Lang_GPS_Distance_Modify", window.parent.useprameters.languagedata) + ":" + window.parent.GetTextByName("Undo", window.parent.useprameters.languagedata) + "</span></td>";
             }
             strTETRA += "<td style='width:20%;text-align:center;'><span>" + window.parent.GetTextByName("Lang_GPS_Model", window.parent.useprameters.languagedata) + ":GPS</span></td>";
             strTETRA += "</tr>";
             strTETRA += "</table>";
             height += 50;
             window.document.getElementById("Tetra").innerHTML = strTETRA;
         }
         if (hasPDT) {
             var strPDT = "<table style='width:100%;'>";
             strPDT += "<tr style='text-align:center;' colSpan='5'><th style='font-family: Arial' scope='col' colspan='5' align='center'><span>" + "PDT" + " " + window.parent.GetTextByName("Terminal_GPSControlInfo", window.parent.useprameters.languagedata) + "</span></th></tr>";
             strPDT += "<tr>";
             if (SwitchToAll) {
                 if (open == "-1") {
                     strPDT += "<td style='width:20%;text-align:center;'><span>" + window.parent.GetTextByName("Lang_GPSEnableOrDisable", window.parent.useprameters.languagedata) + ":" + window.parent.GetTextByName("Undo", window.parent.useprameters.languagedata) + "</span></td>";
                 } else {
                     if (open == "1") {
                         strPDT += "<td style='width:20%;text-align:center;'><span>" + window.parent.GetTextByName("Lang_GPSEnableOrDisable", window.parent.useprameters.languagedata) + ":" + window.parent.GetTextByName("Log_GPS_Open_Success", window.parent.useprameters.languagedata) + "</span></td>";
                     } else {
                         strPDT += "<td style='width:20%;text-align:center;'><span>" + window.parent.GetTextByName("Lang_GPSEnableOrDisable", window.parent.useprameters.languagedata) + ":" + window.parent.GetTextByName("Log_GPS_Close_Success", window.parent.useprameters.languagedata) + "</span></td>";
                     }
                 }
             } else {
                 strPDT += "<td style='width:20%;text-align:center;'><span>" + window.parent.GetTextByName("Lang_GPSEnableOrDisable", window.parent.useprameters.languagedata) + ":" + window.parent.GetTextByName("Undo", window.parent.useprameters.languagedata) + "</span></td>";
             }
             if (CycleToAll) {
                 if (parseInt(Cycle.trim()) > 0 && Cycle.trim() != "") {
                     strPDT += "<td style='width:20%;text-align:center;'><span>" + window.parent.GetTextByName("Lang_SendUpIntral", window.parent.useprameters.languagedata) + ":" + getPDT_Cycle(cycle) + "s</span></td>";
                 } else {
                     strPDT += "<td style='width:20%;text-align:center;'><span>" + window.parent.GetTextByName("Lang_SendUpIntral", window.parent.useprameters.languagedata) + ":" + window.parent.GetTextByName("Undo", window.parent.useprameters.languagedata) + "</span></td>";
                 }
             }
             if (parseInt(DestIssi.trim()) > 0 && DestIssi.trim() != "" && parseInt(DestIssi.trim()) < 16777216) {
                 strPDT += "<td style='width:20%;text-align:center;'><span>" + window.parent.GetTextByName("Lang_SendUpDestISSI", window.parent.useprameters.languagedata) + ":" + parseInt(DestIssi.trim()) + "</span></td>";
             } else {
                 strPDT += "<td style='width:20%;text-align:center;'><span>" + window.parent.GetTextByName("Lang_SendUpDestISSI", window.parent.useprameters.languagedata) + ":" + window.parent.GetTextByName("Undo", window.parent.useprameters.languagedata) + "</span></td>";
             }
             if (parseInt(Distance.trim()) > 0 && Distance.trim() != "") {
                 strPDT += "<td style='width:20%;text-align:center;'><span>" + window.parent.GetTextByName("Lang_GPS_Distance_Modify", window.parent.useprameters.languagedata) + ":" + getPDT_Distance(parseInt(distance.trim())) + "m</span></td>";
             } else {
                 strPDT += "<td style='width:20%;text-align:center;'><span>" + window.parent.GetTextByName("Lang_GPS_Distance_Modify", window.parent.useprameters.languagedata) + ":" + window.parent.GetTextByName("Undo", window.parent.useprameters.languagedata) + "</span></td>";
             }
             strPDT += "<td style='width:20%;text-align:center;'><span>" + window.parent.GetTextByName("Lang_GPS_Model", window.parent.useprameters.languagedata) + ":GPS</span></td>";
             strPDT += "</tr>";
             strPDT += "</table>";
             height += 50;
             window.document.getElementById("Pdt").innerHTML = strPDT;
         }
         if (hasBEIDOU) {
             var strBEIDOU = "<table style='width:100%;'>";
                strBEIDOU += "<tr style='text-align:center;' colSpan='5'><th style='font-family: Arial' scope='col' colspan='5' align='center'><span>" + "BEIDOU" + " " + window.parent.GetTextByName("Terminal_GPSControlInfo", window.parent.useprameters.languagedata) + "</span></th></tr>";//xzj--20190114--将拼接的字符串“TETRA”改为“BEIDOU”
             strBEIDOU += "<tr>";
             if (SwitchToAll) {
                 if (open == "-1") {
                     strBEIDOU += "<td style='width:20%;text-align:center;'><span>" + window.parent.GetTextByName("Lang_GPSEnableOrDisable", window.parent.useprameters.languagedata) + ":" + window.parent.GetTextByName("Undo", window.parent.useprameters.languagedata) + "</span></td>";
                 } else {
                     if (open == "1") {
                         strBEIDOU += "<td style='width:20%;text-align:center;'><span>" + window.parent.GetTextByName("Lang_GPSEnableOrDisable", window.parent.useprameters.languagedata) + ":" + window.parent.GetTextByName("Log_GPS_Open_Success", window.parent.useprameters.languagedata) + "</span></td>";
                     } else {
                         strBEIDOU += "<td style='width:20%;text-align:center;'><span>" + window.parent.GetTextByName("Lang_GPSEnableOrDisable", window.parent.useprameters.languagedata) + ":" + window.parent.GetTextByName("Log_GPS_Close_Success", window.parent.useprameters.languagedata) + "</span></td>";
                     }
                 }
             } else {
                 strBEIDOU += "<td style='width:20%;text-align:center;'><span>" + window.parent.GetTextByName("Lang_GPSEnableOrDisable", window.parent.useprameters.languagedata) + ":" + window.parent.GetTextByName("Undo", window.parent.useprameters.languagedata) + "</span></td>";
             }
             if (CycleToAll) {
                 if (parseInt(Cycle.trim()) > 0 && Cycle.trim() != "") {
                     strBEIDOU += "<td style='width:20%;text-align:center;'><span>" + window.parent.GetTextByName("Lang_SendUpIntral", window.parent.useprameters.languagedata) + ":" + getTETRA_Cycle(cycle) + "s</span></td>";
                 } else {
                     strBEIDOU += "<td style='width:20%;text-align:center;'><span>" + window.parent.GetTextByName("Lang_SendUpIntral", window.parent.useprameters.languagedata) + ":" + window.parent.GetTextByName("Undo", window.parent.useprameters.languagedata) + "</span></td>";
                 }
             } else {
                 strBEIDOU += "<td style='width:20%;text-align:center;'><span>" + window.parent.GetTextByName("Lang_SendUpIntral", window.parent.useprameters.languagedata) + ":" + window.parent.GetTextByName("Undo", window.parent.useprameters.languagedata) + "</span></td>";
             }
             if (parseInt(DestIssi.trim()) > 0 && DestIssi.trim() != "" && parseInt(DestIssi.trim()) < 16777216) {
                 strBEIDOU += "<td style='width:20%;text-align:center;'><span>" + window.parent.GetTextByName("Lang_SendUpDestISSI", window.parent.useprameters.languagedata) + ":" + parseInt(DestIssi.trim()) + "</span></td>";
             } else {
                 strBEIDOU += "<td style='width:20%;text-align:center;'><span>" + window.parent.GetTextByName("Lang_SendUpDestISSI", window.parent.useprameters.languagedata) + ":" + window.parent.GetTextByName("Undo", window.parent.useprameters.languagedata) + "</span></td>";
             }
             if (parseInt(Distance.trim()) > 0 && Distance.trim() != "") {
                 strBEIDOU += "<td style='width:20%;text-align:center;'><span>" + window.parent.GetTextByName("Lang_GPS_Distance_Modify", window.parent.useprameters.languagedata) + ":" + getTETRA_Distance(parseInt(distance.trim())) + "m</span></td>";
             } else {
                 strBEIDOU += "<td style='width:20%;text-align:center;'><span>" + window.parent.GetTextByName("Lang_GPS_Distance_Modify", window.parent.useprameters.languagedata) + ":" + window.parent.GetTextByName("Undo", window.parent.useprameters.languagedata) + "</span></td>";
             }
             if (Model == "-1") {
                 strBEIDOU += "<td style='width:20%;text-align:center;'><span>" + window.parent.GetTextByName("Lang_GPS_Model", window.parent.useprameters.languagedata) + ":" + window.parent.GetTextByName("Undo", window.parent.useprameters.languagedata) + "</span></td>";
             } else if (Model == "1") {
                 strBEIDOU += "<td style='width:20%;text-align:center;'><span>" + window.parent.GetTextByName("Lang_GPS_Model", window.parent.useprameters.languagedata) + ":BEIDOU</span></td>";
             } else if (Model == "3") {
                 strBEIDOU += "<td style='width:20%;text-align:center;'><span>" + window.parent.GetTextByName("Lang_GPS_Model", window.parent.useprameters.languagedata) + ":GPS</span></td>";
             } else if (Model == "7") {
                 strBEIDOU += "<td style='width:20%;text-align:center;'><span>" + window.parent.GetTextByName("Lang_GPS_Model", window.parent.useprameters.languagedata) + ":" + window.parent.GetTextByName("Lang_GPSandBEIDOU_Model", window.parent.useprameters.languagedata) + "</span></td>";
             } else {
                 strBEIDOU += "<td style='width:20%;text-align:center;'><span>" + window.parent.GetTextByName("Lang_GPS_Model", window.parent.useprameters.languagedata) + ":" + window.parent.GetTextByName("Undo", window.parent.useprameters.languagedata) + "</span></td>";
             }
             strBEIDOU += "</tr>";
             strBEIDOU += "</table>";
             height += 50;
             window.document.getElementById("Beidou").innerHTML = strBEIDOU;
         }
         if (hasLTE) {
             var strLTE = "<table style='width:100%;'>";
             strLTE += "<tr style='text-align:center;' colSpan='5'><th style='font-family: Arial' scope='col' colspan='5' align='center'><span>" + "LTE" + " " + window.parent.GetTextByName("Terminal_GPSControlInfo", window.parent.useprameters.languagedata) + "</span></th></tr>";
             strLTE += "<tr>";
             if (open == "-1") {
                 strLTE += "<td style='width:20%;text-align:center;'><span>" + window.parent.GetTextByName("Lang_GPSEnableOrDisable", window.parent.useprameters.languagedata) + ":" + window.parent.GetTextByName("Undo", window.parent.useprameters.languagedata) + "</span></td>";
                 window.document.getElementById("sure").disabled = true;
             } else {
                 if (open == "1") {
                     strLTE += "<td style='width:20%;text-align:center;'><span>" + window.parent.GetTextByName("Lang_GPSEnableOrDisable", window.parent.useprameters.languagedata) + ":" + window.parent.GetTextByName("Log_GPS_Open_Success", window.parent.useprameters.languagedata) + "</span></td>";
                 } else {
                     strLTE += "<td style='width:20%;text-align:center;'><span>" + window.parent.GetTextByName("Lang_GPSEnableOrDisable", window.parent.useprameters.languagedata) + ":" + window.parent.GetTextByName("Log_GPS_Close_Success", window.parent.useprameters.languagedata) + "</span></td>";
                 }
             }

             if (parseInt(Cycle.trim()) > 0 && Cycle.trim() != "") {
                 strLTE += "<td style='width:20%;text-align:center;'><span>" + window.parent.GetTextByName("Lang_SendUpIntral", window.parent.useprameters.languagedata) + ":" +cycle + "s</span></td>";
             } else {
                 strLTE += "<td style='width:20%;text-align:center;'><span>" + window.parent.GetTextByName("Lang_SendUpIntral", window.parent.useprameters.languagedata) + ":" + window.parent.GetTextByName("Undo", window.parent.useprameters.languagedata) + "</span></td>";
                 //window.document.getElementById("sure").disabled = true;//xzj--20190111--注释改行使按钮能执行
                }

             //if (parseInt(DestIssi.trim()) > 0 && DestIssi.trim() != "" && parseInt(DestIssi.trim()) < 16777216) {
             //    strLTE += "<td style='width:20%;text-align:center;'><span>" + window.parent.GetTextByName("Lang_SendUpDestISSI", window.parent.useprameters.languagedata) + ":" + parseInt(DestIssi.trim()) + "</span></td>";
             //} else {
             //    strLTE += "<td style='width:20%;text-align:center;'><span>" + window.parent.GetTextByName("Lang_SendUpDestISSI", window.parent.useprameters.languagedata) + ":" + window.parent.GetTextByName("Undo", window.parent.useprameters.languagedata) + "</span></td>";
             //    window.document.getElementById("sure").disabled = true;
             //}
             strLTE += "</tr>";
             strLTE += "</table>";
             height += 50;
             window.document.getElementById("Lte").innerHTML = strLTE;
         }
         window.document.getElementById("showDiv").style.height = height+'px';//xzj--20190114--添加px,否则赋值无效
         window.document.getElementById("sure").style.visibility = "visible";
         window.document.getElementById("cancel").style.visibility = "visible";

     }


     window.onload = function () {



         document.onmousedown = function () {
             var div1 = window.parent.document.getElementById('view_info/view_GPSSetInfo');
             window.parent.windowDivOnClick(div1);
         }
         document.getElementById("derppp").onmousedown = function () { dragdiv(); }
         document.getElementById("derppp").onmousemove = function () { mydragWindow(); }
         document.getElementById("derppp").onmouseup = function () { mystopDragWindow(); }
         document.body.oncontextmenu = function () { return false; }
         document.body.oncontextmenu = function () { return false; }
         var arrayelement = ["input", "a", "select", "li", "font", "textarea", "option"];
         for (n = 0; n < arrayelement.length; n++) {
             var inputs = document.getElementsByTagName(arrayelement[n]);
             for (i = 0; i < inputs.length; i++) {
                 inputs[i].onmouseout = function () {
                     dragEnable = 'True';
                 }
                 inputs[i].onmouseover = function () {
                     dragEnable = 'False';
                 }
                 inputs[i].onmousedown = function () {
                     dragEnable = 'False';
                 }
                 inputs[i].onmouseup = function () {
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
         var tbdiv = document.getElementById("tbtbz");
         if (tbdiv) {
             tbdiv.onmouseout = function () {
                 dragEnable = 'True';
             }
             tbdiv.onmouseover = function () {
                 dragEnable = 'False';
             }
         }

     }



     function Divover(str) {
         var div1 = document.getElementById("divClose");
         if (str == "on") { div1.style.backgroundPosition = "66 0"; }
         else { div1.style.backgroundPosition = "0 0"; }
     }

     document.oncontextmenu = new Function("event.returnValue=false;"); //禁止右键功能,单击右键将无任何反应
     document.onselectstart = new Function("event.returnValue=false;"); //禁止先择,也就是无法复制
     Request = {
         QueryString: function (item) {
             var svalue = location.search.match(new RegExp("[\?\&]" + item + "=([^\&]*)(\&?)", "i"));
             return svalue ? svalue[1] : svalue;
         }
     }


     function closethispage() {
         //window.parent.parent.hiddenbg2();
         window.parent.lq_closeANDremovediv('view_info/view_GPSSetInfo', 'bgDiv');
     }


     var dragEnable = 'True';
     function dragdiv() {
         var div1 = window.parent.document.getElementById('view_info/view_GPSSetInfo');
         if (div1 && event.button == 0 && dragEnable == 'True') {
             window.parent.mystartDragWindow(div1, null, event); div1.style.border = "solid 0px transparent"; window.parent.cgzindex(div1);

         }
     }
     function mydragWindow() {
         var div1 = window.parent.document.getElementById('view_info/view_GPSSetInfo');
         if (div1) {
             window.parent.mydragWindow(div1, event);
         }
     }

     function mystopDragWindow() {
         var div1 = window.parent.document.getElementById('view_info/view_GPSSetInfo');
         if (div1) {
             window.parent.mystopDragWindow(div1); div1.style.border = "0px";
         }
     }

     function toBeSure() {
         window.parent.parent.sendGPSControl(controlUsers, open, cycle, destissi, distance, model, switchToAll, cycleToAll);
         closethispage();
     }

     function toBeCancel() {
         closethispage();
     }

     //$(document).ready(function () {
     //    window.parent.visiablebg2();
     //});

    </script>
</html>

