<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="view_ExplainCycle.aspx.cs" Inherits="Web.lqnew.opePages.view_info.view_Explain" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
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

        .Langtxt {
            border: 0px;
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

   
</head>
<body>
    <form id="form1" runat="server">
        <table class="style1" cellpadding="0" cellspacing="0">
            <tr style="height: 5px;">
                <td class="style2">
                    <img alt="" src="../../view_infoimg/images/bg_01.png" />
                </td>
                <td class="bg1" colspan="2" onmousemove=" mydragWindow()" onmouseup="mystopDragWindow()" onmousedown="dragdiv()">
                    <div id="divClose" onclick="window.parent.parent.parent.parent.mycallfunction('view_info/view_ExplainCycle')">
                    </div>
                </td>
                <td class="style2">
                    <img alt="" src="../../view_infoimg/images/bg_04.png" />
                </td>
            </tr>
            <tr>
                <td class="bg3">
                </td>
                <td class="bg4" id="dragtd" colspan="2">
                    <table align="center" bgcolor="#c0de98" runat="server" border="0" cellpadding="0"
                        cellspacing="1" width="100%">
                        <tr>
                            <td colspan="2" class="td1td" style="text-align: center">
                                <span id="setValue" style="color: blue;"></span>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 75%; text-align: center;background-color: #FFFFFF;font-weight: bold;height:25px;" >
                                <span id="Lang_Value_Range"></span>
                                <span id="Span1" class="Langtxt">(x)</span>
                            </td>
                            <td style="width: 25%; text-align: center;background-color: #FFFFFF;font-weight: bold;height:25px;">
                                <span id="Lang_Effective_Value"></span>
                            </td>
                        </tr>
                    </table>
                    <div id="tab"  style="width: 100%; height: 350px; background-color: azure; overflow: auto">
                    </div>
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
     <script type="text/javascript">
         window.parent.closeprossdiv();
         window.document.getElementById("Lang_Value_Range").innerHTML = window.parent.parent.parent.GetTextByName("Lang_Value_Range", window.parent.parent.parent.parent.useprameters.languagedata);
         window.document.getElementById("Lang_Effective_Value").innerHTML = window.parent.parent.parent.GetTextByName("Lang_Effective_Value", window.parent.parent.parent.parent.useprameters.languagedata);

         function toHTML(ISSI_Type, IsCycle) {
             //for (var i = 0; i < arrayISSI.length; i++) {
             //    $("#" + arrayISSI[i]).remove();
             //}
            
             if (IsCycle) {
                 document.getElementById("setValue").innerHTML = ISSI_Type + window.parent.parent.GetTextByName("value_Rule1", window.parent.parent.useprameters.languagedata);

                 var strResult = "<table id='0' style='width:100%;'>";
                 if (ISSI_Type == "TETRA" || ISSI_Type == "BEIDOU") {
                     var strResult = "<table id='0' style='width:100%;'>";
                     strResult += "<tr><td style='width:75%;text-align:center;' class='td1td'><span>" + "x <= 0" + "</span></td><td style='width:25%;text-align:center;background-color: #FFFFFF;'><span>" + window.parent.parent.GetTextByName("Invalid", window.parent.parent.useprameters.languagedata) + "</span></td></tr>";
                     strResult += "<tr id='1'><td style='width:75%;text-align:center;' class='td1td'><span>" + "0 < x <= 10" + "</span></td><td style='width:25%;text-align:center;background-color: #FFFFFF;'><span>" + 10 + "</span></td></tr>";
                     strResult += "<tr id='2'><td style='width:75%;text-align:center;' class='td1td'><span>" + "10 < x <= 20" + "</span></td><td style='width:25%;text-align:center;background-color: #FFFFFF;'><span>" + 20 + "</span></td></tr>";
                     strResult += "<tr id='3'><td style='width:75%;text-align:center;' class='td1td'><span>" + "20 < x <= 30" + "</span></td><td style='width:25%;text-align:center;background-color: #FFFFFF;'><span>" + 30 + "</span></td></tr>";
                     strResult += "<tr id='4'><td style='width:75%;text-align:center;' class='td1td'><span>" + "...(10n < x <= 10*(n+1))" + "</span></td><td style='width:25%;text-align:center;background-color: #FFFFFF;'><span>" + "...(10*(n+1))" + "</span></td></tr>";
                     strResult += "<tr id='5'><td style='width:75%;text-align:center;' class='td1td'><span>" + "290 < x <= 300" + "</span></td><td style='width:25%;text-align:center;background-color: #FFFFFF;'><span>" + 300 + "</span></td></tr>";
                     strResult += "<tr id='6'><td style='width:75%;text-align:center;' class='td1td'><span>" + "300 < x <= 330" + "</span></td><td style='width:25%;text-align:center;background-color: #FFFFFF;'><span>" + 330 + "</span></td></tr>";
                     strResult += "<tr id='7'><td style='width:75%;text-align:center;' class='td1td'><span>" + "330 < x <= 360" + "</span></td><td style='width:25%;text-align:center;background-color: #FFFFFF;'><span>" + 360 + "</span></td></tr>";
                     strResult += "<tr id='8'><td style='width:75%;text-align:center;' class='td1td'><span>" + "...((300+30n) < x <= (300+30*(n+1)))" + "</span></td><td style='width:25%;text-align:center;background-color: #FFFFFF;'><span>" + "...(300+30*(n+1))" + "</span></td></tr>";
                     strResult += "<tr id='9'><td style='width:75%;text-align:center;' class='td1td'><span>" + "1170 < x <= 1200" + "</span></td><td style='width:25%;text-align:center;background-color: #FFFFFF;'><span>" + "1200" + "</span></td></tr>";
                     strResult += "<tr id='10'><td style='width:75%;text-align:center;' class='td1td'><span>" + "1200 < x <= 1260" + "</span></td><td style='width:25%;text-align:center;background-color: #FFFFFF;'><span>" + "1260" + "</span></td></tr>";
                     strResult += "<tr id='11'><td style='width:75%;text-align:center;' class='td1td'><span>" + "1260 < x <= 1320" + "</span></td><td style='width:25%;text-align:center;background-color: #FFFFFF;'><span>" + "1320" + "</span></td></tr>";
                     strResult += "<tr id='12'><td style='width:75%;text-align:center;' class='td1td'><span>" + "...((1200+60n) < x <= (1200+60*(n+1)))" + "</span></td><td style='width:25%;text-align:center;background-color: #FFFFFF;'><span>" + "...(1200+60*(n+1))" + "</span></td></tr>";
                     strResult += "<tr id='13'><td style='width:75%;text-align:center;' class='td1td'><span>" + "x > 5220" + "</span></td><td style='width:25%;text-align:center;background-color: #FFFFFF;'><span>" + "5280" + "</span></td></tr>";
                     
                     document.getElementById("tab").style.height=420;
                     //document.getElementById("tab").innerHTML = strResult;
                 } else if (ISSI_Type == "PDT") {
                   /*strResult += "<tr id='0'><td style='width:75%;text-align:center;' class='td1td'><span>" + "x < 0" + "</span></td><td style='width:25%;text-align:center;background-color: #FFFFFF;'><span>" + window.parent.parent.GetTextByName("Invalid", window.parent.parent.useprameters.languagedata) + "</span></td></tr>";
                     strResult += "<tr id='1'><td style='width:75%;text-align:center;' class='td1td'><span>" + "x = 0" + "</span></td><td style='width:25%;text-align:center;background-color: #FFFFFF;'><span>" + window.parent.parent.GetTextByName("close_GPS_Cycle_PullUp", window.parent.parent.useprameters.languagedata) + "</span></td></tr>";
                     strResult += "<tr id='2'><td style='width:75%;text-align:center;' class='td1td'><span>" + "x = 1" + "</span></td><td style='width:25%;text-align:center;background-color: #FFFFFF;'><span>" + 1 + "</span></td></tr>";
                     strResult += "<tr id='3'><td style='width:75%;text-align:center;' class='td1td'><span>" + "x = 2" + "</span></td><td style='width:25%;text-align:center;background-color: #FFFFFF;'><span>" + 2 + "</span></td></tr>";
                     strResult += "<tr id='4'><td style='width:75%;text-align:center;' class='td1td'><span>" + "...(x = (n*1))" + "</span></td><td style='width:25%;text-align:center;background-color: #FFFFFF;'><span>" + "...(n)" + "</span></td></tr>";
                     strResult += "<tr id='5'><td style='width:75%;text-align:center;' class='td1td'><span>" + "30 <= x < 62" + "</span></td><td style='width:25%;text-align:center;background-color: #FFFFFF;'><span>" + 30 + "</span></td></tr>";
                     strResult += "<tr id='6'><td style='width:75%;text-align:center;' class='td1td'><span>" + " x = 62" + "</span></td><td style='width:25%;text-align:center;background-color: #FFFFFF;'><span>" + 62 + "</span></td></tr>";
                     strResult += "<tr id='7'><td style='width:75%;text-align:center;' class='td1td'><span>" + "62 < x <= 64" + "</span></td><td style='width:25%;text-align:center;background-color: #FFFFFF;'><span>" + 64 + "</span></td></tr>";
                     strResult += "<tr id='8'><td style='width:75%;text-align:center;' class='td1td'><span>" + "...((30+2n) < x <= (30+2*(n+1)))" + "</span></td><td style='width:25%;text-align:center;background-color: #FFFFFF;'><span>" + "...(30+2*(n+1))" + "</span></td></tr>";
                     strResult += "<tr id='9'><td style='width:75%;text-align:center;' class='td1td'><span>" + "98 < x <= 100" + "</span></td><td style='width:25%;text-align:center;background-color: #FFFFFF;'><span>" + "100" + "</span></td></tr>";
                     strResult += "<tr id='10'><td style='width:75%;text-align:center;' class='td1td'><span>" + "100 < x <= 153" + "</span></td><td style='width:25%;text-align:center;background-color: #FFFFFF;'><span>" + "153" + "</span></td></tr>";
                     strResult += "<tr id='11'><td style='width:75%;text-align:center;' class='td1td'><span>" + "153 < x <= 156" + "</span></td><td style='width:25%;text-align:center;background-color: #FFFFFF;'><span>" + "156" + "</span></td></tr>";
                     strResult += "<tr id='12'><td style='width:75%;text-align:center;' class='td1td'><span>" + "...((150+3n) < x <= (150+3*(n+1)))" + "</span></td><td style='width:25%;text-align:center;background-color: #FFFFFF;'><span>" + "...(150+3*(n+1))" + "</span></td></tr>";
                     strResult += "<tr id='13'><td style='width:75%;text-align:center;' class='td1td'><span>" + "237 < x <= 240" + "</span></td><td style='width:25%;text-align:center;background-color: #FFFFFF;'><span>" + "240" + "</span></td></tr>";
                     strResult += "<tr id='14'><td style='width:75%;text-align:center;' class='td1td'><span>" + "240 < x <= 405" + "</span></td><td style='width:25%;text-align:center;background-color: #FFFFFF;'><span>" + "405" + "</span></td></tr>";
                     strResult += "<tr id='15'><td style='width:75%;text-align:center;' class='td1td'><span>" + "405 < x <= 410" + "</span></td><td style='width:25%;text-align:center;background-color: #FFFFFF;'><span>" + "410" + "</span></td></tr>";
                     strResult += "<tr id='16'><td style='width:75%;text-align:center;' class='td1td'><span>" + "...((400+5n) < x <= (400+5*(n+1)))" + "</span></td><td style='width:25%;text-align:center;background-color: #FFFFFF;'><span>" + "...(400+5*(n+1))" + "</span></td></tr>";
                     strResult += "<tr id='17'><td style='width:75%;text-align:center;' class='td1td'><span>" + "495 < x <= 500" + "</span></td><td style='width:25%;text-align:center;background-color: #FFFFFF;'><span>" + "500" + "</span></td></tr>";
                     strResult += "<tr id='18'><td style='width:75%;text-align:center;' class='td1td'><span>" + "500 < x <= 1010" + "</span></td><td style='width:25%;text-align:center;background-color: #FFFFFF;'><span>" + "1010" + "</span></td></tr>";
                     strResult += "<tr id='19'><td style='width:75%;text-align:center;' class='td1td'><span>" + "1010 < x <= 1020" + "</span></td><td style='width:25%;text-align:center;background-color: #FFFFFF;'><span>" + "1020" + "</span></td></tr>";
                     strResult += "<tr id='20'><td style='width:75%;text-align:center;' class='td1td'><span>" + "...((1000+10n) < x <= (1000+10*(n+1)))" + "</span></td><td style='width:25%;text-align:center;background-color: #FFFFFF;'><span>" + "...(1000+10*(n+1))" + "</span></td></tr>";
                     strResult += "<tr id='21'><td style='width:75%;text-align:center;' class='td1td'><span>" + "1090 < x <= 1100" + "</span></td><td style='width:25%;text-align:center;background-color: #FFFFFF;'><span>" + "1100" + "</span></td></tr>";
                     strResult += "<tr id='22'><td style='width:75%;text-align:center;' class='td1td'><span>" + "1100 < x <= 3330" + "</span></td><td style='width:25%;text-align:center;background-color: #FFFFFF;'><span>" + "3330" + "</span></td></tr>";
                     strResult += "<tr id='23'><td style='width:75%;text-align:center;' class='td1td'><span>" + "3330 < x <= 3360" + "</span></td><td style='width:25%;text-align:center;background-color: #FFFFFF;'><span>" + "3360" + "</span></td></tr>";
                     strResult += "<tr id='24'><td style='width:75%;text-align:center;' class='td1td'><span>" + "...((3300+30n) < x <= (3300+30*(n+1)))" + "</span></td><td style='width:25%;text-align:center;background-color: #FFFFFF;'><span>" + "...(3300+30*(n+1))" + "</span></td></tr>";
                     strResult += "<tr id='25'><td style='width:75%;text-align:center;' class='td1td'><span>" + "x > 3720" + "</span></td><td style='width:25%;text-align:center;background-color: #FFFFFF;'><span>" + "3750" + "</span></td></tr>";
                     */
                     strResult += "<tr id='0'><td style='width:75%;text-align:center;' class='td1td'><span>" + "x <= 0" + "</span></td><td style='width:25%;text-align:center;background-color: #FFFFFF;'><span>" + window.parent.parent.GetTextByName("Invalid", window.parent.parent.useprameters.languagedata) + "</span></td></tr>";
                     strResult += "<tr id='1'><td style='width:75%;text-align:center;' class='td1td'><span>" + "x < 30" + "</span></td><td style='width:25%;text-align:center;background-color: #FFFFFF;'><span>" + "x" + "</span></td></tr>";
                     strResult += "<tr id='2'><td style='width:75%;text-align:center;' class='td1td'><span>" + "30 <=x < 62" + "</span></td><td style='width:25%;text-align:center;background-color: #FFFFFF;'><span>" + 30 + "</span></td></tr>";
                     strResult += "<tr id='3'><td style='width:75%;text-align:center;' class='td1td'><span>" + "62 <= x < 100" + "</span></td><td style='width:25%;text-align:center;background-color: #FFFFFF;'><span>" + "x-x%2" + "<br>" + "（例：62 64 66...）" + "</span></td></tr>";
                     strResult += "<tr id='4'><td style='width:75%;text-align:center;' class='td1td'><span>" + "100 <= x < 153" + "</span></td><td style='width:25%;text-align:center;background-color: #FFFFFF;'><span>" + 100 + "</span></td></tr>";
                     strResult += "<tr id='5'><td style='width:75%;text-align:center;' class='td1td'><span>" + "153 <= x < 240" + "</span></td><td style='width:25%;text-align:center;background-color: #FFFFFF;'><span>" + "x-x%3" + "<br>" + "(例：153 156 159...)" + "</span></td></tr>";
                     strResult += "<tr id='6'><td style='width:75%;text-align:center;' class='td1td'><span>" + "240 <= x < 405" + "</span></td><td style='width:25%;text-align:center;background-color: #FFFFFF;'><span>" + 240 + "</span></td></tr>";
                     strResult += "<tr id='7'><td style='width:75%;text-align:center;' class='td1td'><span>" + "405 <= x < 500" + "</span></td><td style='width:25%;text-align:center;background-color: #FFFFFF;'><span>" + "x-x%5" + "<br>" + "(例：405 410 415...)" + "</span></td></tr>";
                     strResult += "<tr id='8'><td style='width:75%;text-align:center;' class='td1td'><span>" + "500 <= x < 1010" + "</span></td><td style='width:25%;text-align:center;background-color: #FFFFFF;'><span>" + 500 + "</span></td></tr>";
                     strResult += "<tr id='9'><td style='width:75%;text-align:center;' class='td1td'><span>" + "1010 <= x < 1100" + "</span></td><td style='width:25%;text-align:center;background-color: #FFFFFF;'><span>" + "x-x%10" + "<br>" + "(例：1010 1020 1030...)" + "</span></td></tr>";
                     strResult += "<tr id='10'><td style='width:75%;text-align:center;' class='td1td'><span>" + "1100 <= x < 3330" + "</span></td><td style='width:25%;text-align:center;background-color: #FFFFFF;'><span>" + 1100 + "</span></td></tr>";
                     strResult += "<tr id='11'><td style='width:75%;text-align:center;' class='td1td'><span>" + "3330 <= x < 3750" + "</span></td><td style='width:25%;text-align:center;background-color: #FFFFFF;'><span>" + "x-x%30" + "<br>" + "(例：3330 3360 3390...)" + "</span></td></tr>";
                     strResult += "<tr id='12'><td style='width:75%;text-align:center;' class='td1td'><span>" + "3750 <= x < 7200" + "</span></td><td style='width:25%;text-align:center;background-color: #FFFFFF;'><span>" + 3750 + "</span></td></tr>";
                     strResult += "<tr id='13'><td style='width:75%;text-align:center;' class='td1td'><span>" + "7200 <= x < 10800" + "</span></td><td style='width:25%;text-align:center;background-color: #FFFFFF;'><span>" + 7200 + "</span></td></tr>";
                     strResult += "<tr id='14'><td style='width:75%;text-align:center;' class='td1td'><span>" + "10800 <= x " + "</span></td><td style='width:25%;text-align:center;background-color: #FFFFFF;'><span>" + 10800 + "</span></td></tr>";

                     document.getElementById("tab").style.height = 495;
                     //document.getElementById("tab").innerHTML = strResult;
                 } else {
                     strResult += "<tr id='0'><td style='width:75%;text-align:center;' class='td1td'><span>" + "x = n" + "</span></td><td style='width:25%;text-align:center;background-color: #FFFFFF;'><span>" +"n"+ "</span></td></tr>";
                     document.getElementById("tab").style.height = 30;
                     //document.getElementById("tab").innerHTML = strResult;
                 }
             } else {
                 document.getElementById("setValue").innerHTML = ISSI_Type + window.parent.parent.GetTextByName("value_Rule2", window.parent.parent.useprameters.languagedata);

                 var strResult = "<table id='0' style='width:100%;'>";
                 if (ISSI_Type == "TETRA" || ISSI_Type == "BEIDOU") {
                     strResult += "<tr id='0'><td style='width:75%;text-align:center;' class='td1td'><span>" + "x <= 0" + "</span></td><td style='width:25%;text-align:center;background-color: #FFFFFF;'><span>" + window.parent.parent.GetTextByName("Invalid", window.parent.parent.useprameters.languagedata) + "</span></td></tr>";
                     strResult += "<tr id='1'><td style='width:75%;text-align:center;' class='td1td'><span>" + "0 < x <= 100" + "</span></td><td style='width:25%;text-align:center;background-color: #FFFFFF;'><span>" + 100 + "</span></td></tr>";
                     strResult += "<tr id='2'><td style='width:75%;text-align:center;' class='td1td'><span>" + "100 < x <= 200" + "</span></td><td style='width:25%;text-align:center;background-color: #FFFFFF;'><span>" + 200 + "</span></td></tr>";
                     strResult += "<tr id='3'><td style='width:75%;text-align:center;' class='td1td'><span>" + "...(100n < x <= 100*(n+1))" + "</span></td><td style='width:25%;text-align:center;background-color: #FFFFFF;'><span>" + "...(100*(n+1))" + "</span></td></tr>";
                     strResult += "<tr id='4'><td style='width:75%;text-align:center;' class='td1td'><span>" + "9900 < x <= 10000" + "</span></td><td style='width:25%;text-align:center;background-color: #FFFFFF;'><span>" + 10000 + "</span></td></tr>";
                     strResult += "<tr id='5'><td style='width:75%;text-align:center;' class='td1td'><span>" + "10000 < x <= 10500" + "</span></td><td style='width:25%;text-align:center;background-color: #FFFFFF;'><span>" + 10500 + "</span></td></tr>";
                     strResult += "<tr id='6'><td style='width:75%;text-align:center;' class='td1td'><span>" + "10500 < x <= 11000" + "</span></td><td style='width:25%;text-align:center;background-color: #FFFFFF;'><span>" + 11000 + "</span></td></tr>";
                     strResult += "<tr id='7'><td style='width:75%;text-align:center;' class='td1td'><span>" + "...((10000+500n) < x <= (10000+500*(n+1)))" + "</span></td><td style='width:25%;text-align:center;background-color: #FFFFFF;'><span>" + "...(10000+500*(n+1))" + "</span></td></tr>";
                     strResult += "<tr id='8'><td style='width:75%;text-align:center;' class='td1td'><span>" + "23500 < x <= 24000" + "</span></td><td style='width:25%;text-align:center;background-color: #FFFFFF;'><span>" + 24000 + "</span></td></tr>";
                     strResult += "<tr id='9'><td style='width:75%;text-align:center;' class='td1td'><span>" + "x > 24000" + "</span></td><td style='width:25%;text-align:center;background-color: #FFFFFF;'><span>" + 24000 + "</span></td></tr>";
                     document.getElementById("tab").style.height = 350;
                     //document.getElementById("tab").innerHTML = strResult;
                 } else if (ISSI_Type == "PDT") {
                     strResult += "<tr id='0'><td style='width:75%;text-align:center;' class='td1td'><span>" + "x < 0" + "</span></td><td style='width:25%;text-align:center;background-color: #FFFFFF;'><span>" + window.parent.parent.GetTextByName("Invalid", window.parent.parent.useprameters.languagedata) + "</span></td></tr>";
                     strResult += "<tr id='1'><td style='width:75%;text-align:center;' class='td1td'><span>" + "x = 0" + "</span></td><td style='width:25%;text-align:center;background-color: #FFFFFF;'><span>" + window.parent.parent.GetTextByName("close_GPS_Distance_PullUp", window.parent.parent.useprameters.languagedata) + "</span></td></tr>";
                     strResult += "<tr id='2'><td style='width:75%;text-align:center;' class='td1td'><span>" + "0 < x < 5" + "</span></td><td style='width:25%;text-align:center;background-color: #FFFFFF;'><span>" + 0 + "</span></td></tr>";
                     strResult += "<tr id='3'><td style='width:75%;text-align:center;' class='td1td'><span>" + "5 <= x < 10" + "</span></td><td style='width:25%;text-align:center;background-color: #FFFFFF;'><span>" + 5 + "</span></td></tr>";
                     strResult += "<tr id='4'><td style='width:75%;text-align:center;' class='td1td'><span>" + "10 <= x < 30" + "</span></td><td style='width:25%;text-align:center;background-color: #FFFFFF;'><span>" + 10 + "</span></td></tr>";
                     strResult += "<tr id='5'><td style='width:75%;text-align:center;' class='td1td'><span>" + "30 <= x < 60" + "</span></td><td style='width:25%;text-align:center;background-color: #FFFFFF;'><span>" + 30 + "</span></td></tr>";
                     strResult += "<tr id='6'><td style='width:75%;text-align:center;' class='td1td'><span>" + "60 <= x < 120" + "</span></td><td style='width:25%;text-align:center;background-color: #FFFFFF;'><span>" + 60 + "</span></td></tr>";
                     strResult += "<tr id='7'><td style='width:75%;text-align:center;' class='td1td'><span>" + "120 <= x < 220" + "</span></td><td style='width:25%;text-align:center;background-color: #FFFFFF;'><span>" + 120 + "</span></td></tr>";
                     strResult += "<tr id='8'><td style='width:75%;text-align:center;' class='td1td'><span>" + "220 <= x < 350" + "</span></td><td style='width:25%;text-align:center;background-color: #FFFFFF;'><span>" + 220 + "</span></td></tr>";
                     strResult += "<tr id='9'><td style='width:75%;text-align:center;' class='td1td'><span>" + "350 <= x < 500" + "</span></td><td style='width:25%;text-align:center;background-color: #FFFFFF;'><span>" + 350 + "</span></td></tr>";
                     strResult += "<tr id='10'><td style='width:75%;text-align:center;' class='td1td'><span>" + "500 <= x < 700" + "</span></td><td style='width:25%;text-align:center;background-color: #FFFFFF;'><span>" + 500 + "</span></td></tr>";
                     strResult += "<tr id='11'><td style='width:75%;text-align:center;' class='td1td'><span>" + "700 <= x < 1000" + "</span></td><td style='width:25%;text-align:center;background-color: #FFFFFF;'><span>" + 700 + "</span></td></tr>";
                     strResult += "<tr id='12'><td style='width:75%;text-align:center;' class='td1td'><span>" + "1000 <= x < 1300" + "</span></td><td style='width:25%;text-align:center;background-color: #FFFFFF;'><span>" + 1000 + "</span></td></tr>";
                     strResult += "<tr id='13'><td style='width:75%;text-align:center;' class='td1td'><span>" + "1300 <= x < 1700" + "</span></td><td style='width:25%;text-align:center;background-color: #FFFFFF;'><span>" + 1300 + "</span></td></tr>";
                     strResult += "<tr id='14'><td style='width:75%;text-align:center;' class='td1td'><span>" + "1700 <= x < 2200" + "</span></td><td style='width:25%;text-align:center;background-color: #FFFFFF;'><span>" + 1700 + "</span></td></tr>";
                     strResult += "<tr id='15'><td style='width:75%;text-align:center;' class='td1td'><span>" + "2200 <= x < 2800" + "</span></td><td style='width:25%;text-align:center;background-color: #FFFFFF;'><span>" + 2200 + "</span></td></tr>";
                     strResult += "<tr id='16'><td style='width:75%;text-align:center;' class='td1td'><span>" + "2800 <= x < 3500" + "</span></td><td style='width:25%;text-align:center;background-color: #FFFFFF;'><span>" + 2800 + "</span></td></tr>";
                     strResult += "<tr id='17'><td style='width:75%;text-align:center;' class='td1td'><span>" + "x >= 3500" + "</span></td><td style='width:25%;text-align:center;background-color: #FFFFFF;'><span>" + 3500 + "</span></td></tr>";
                     document.getElementById("tab").style.height = 420;
                     //document.getElementById("tab").innerHTML = strResult;
                 } else {
                    
                     strResult += "<tr id='0'><td style='width:75%;text-align:center;' class='td1td'><span>" + window.parent.parent.GetTextByName("Invalid", window.parent.parent.useprameters.languagedata) + "</span></td><td style='width:25%;text-align:center;background-color: #FFFFFF;'><span>" + window.parent.parent.GetTextByName("Invalid", window.parent.parent.useprameters.languagedata) + "</span></td></tr>";
                     //document.getElementById("tab").innerHTML = strResult;
                     document.getElementById("tab").style.height = 30;
                 }
             }
             strResult += "</table>";
             document.getElementById("tab").innerHTML = strResult;
         }
         var dragEnable = 'True';
         function Divover(str) {
             var div1 = document.getElementById("divClose");
             if (str == "on") { div1.style.backgroundPosition = "66 0"; }
             else { div1.style.backgroundPosition = "0 0"; }
         }

         function dragdiv() {
             var div1 = window.parent.parent.document.getElementById("view_info/view_ExplainCycle");
             if (div1 && event.button == 0 && dragEnable == 'True') {
                 window.parent.parent.parent.mystartDragWindow(div1, null, event); div1.style.border = "solid 0px transparent"; window.parent.cgzindex(div1);

             }
         }
         function mydragWindow() {
             var div1 = window.parent.parent.parent.document.getElementById("view_info/view_ExplainCycle");
             if (div1) {
                 window.parent.parent.parent.mydragWindow(div1, event);
             }
         }
         function mystopDragWindow() {
             var div1 = window.parent.parent.parent.document.getElementById("view_info/view_ExplainCycle");
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
             }
         }
      
     </script>
</html>
