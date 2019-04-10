<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SubmitToHistory.aspx.cs"
    Inherits="Web.lqnew.opePages.SubmitToHistory" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns:v>
<head id="Head1" runat="server">
    <title></title>
    <?import namespace="v" implementation="#default#VML" ?>
    <style>
        v\:* {
            behavior: url(#default#VML);
            position: absolute;
        }

        o\:* {
            behavior: url(#default#VML);
        }
    </style>
    <link href="../css/lq_addedit.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/pagestyle.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/ui-lightness/demos.css" rel="stylesheet" type="text/css" />
    <link href="../css/lq_manager.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/pagestyle.css" rel="stylesheet" type="text/css" />
    <script src="../js/geturl.js" type="text/javascript"></script>
    <script src="../../JQuery/jquery-1.5.2(ture).js" type="text/javascript"></script>
    <link href="../../CSS/ui-lightness/jquery-ui-1.8.13.custom.css" rel="stylesheet" type="text/css" />
    <script src="../../JS/LangueSwitch.js" type="text/javascript"></script>
    <script src="../../JQuery/jquery-ui-1.8.13.custom.min.js" type="text/javascript"></script>
    <%--  <script src="../js/DateSelect.js" type="text/javascript"></script>--%>
    <script src="../../My97DatePicker/WdatePicker.js" type="text/javascript"></script>
    <%if (System.Configuration.ConfigurationManager.AppSettings["defaultLanguage"] == "zh-CN")
      { %>
    <script src="../../JQuery/ui.datepicker-zh-CN.js" type="text/javascript"></script>
    <%} %>
    <script src="../iColorPicker.js" type="text/javascript"></script>
    <%--
     <script src="../js/dragwindow.js" type="text/javascript"></script>--%>
    <script type="text/javascript">

        $(document).ready(function () {
            $("#BegSelectMinu").empty();
            $("#endSelectMinu").empty();

            var varcolor = $("#color1").val().replace("#", "");
            var selColor = document.getElementById("selColor");
            if (selColor.value.toString() == "1") {
                varcolor = "000000";
            } else if (selColor.value.toString() == "2") {
                varcolor = "ff0033";
            } else if (selColor.value.toString() == "3") {
                varcolor = "0000FF ";
            } else if (selColor.value.toString() == "4") {
                varcolor = "33FF33";
            } else if (selColor.value.toString() == "5") {
                varcolor = "FFFF00";
            }

            var selectWidth = $("#selectWidth").val();
            var selectLine = $("#selectLine").val();

            //$("#showLine").html(varcolor + "-" + selectWidth + "-" + selectLine);
            //DrawLine(varcolor, selectWidth, selectLine);

            for (var i = 0; i < 60; i++) {
                var s = 0;
                if (i < 10)
                    s = "0" + i.toString();
                else s = i;
                $("#BegSelectMinu").append("<option value='" + s + "'>" + i + "</option>");  //添加一项option
                //cxy-20180723-初始化选择59min
                if (i == 59) {
                    $("#endSelectMinu").append("<option selected value='" + s + "'>" + i + "</option>");
                } else {
                    $("#endSelectMinu").append("<option value='" + s + "'>" + i + "</option>");
                }
            }

            <%if (System.Configuration.ConfigurationManager.AppSettings["defaultLanguage"] == "zh-CN")
              { %>
            $("#begTime").datepicker({ dateFormat: 'yy-mm-dd', changeMonth: true, changeYear: true });

            $("#endTime").datepicker({ dateFormat: 'yy-mm-dd', changeMonth: true, changeYear: true });
            <%}
              else
              {%>
            $("#begTime").datepicker({ dateFormat: 'mm/dd/yy', changeMonth: true, changeYear: true });

            $("#endTime").datepicker({ dateFormat: 'mm/dd/yy', changeMonth: true, changeYear: true });
            <%}%>

            $.ajax({
                type: "POST",
                url: "../../Handlers/GetUserInfoByID_Handler.ashx",
                data: "id=" + '<%=Request["id"] %>',
                success: function (msg) {
                    var my = eval(msg);
                   
                    <%if (System.Configuration.ConfigurationManager.AppSettings["defaultLanguage"] == "zh-CN")
               { %>
                    $("#begTime").val(my[0].year + "-" + my[0].month + "-" + my[0].day);
                    $("#endTime").val(my[0].year + "-" + my[0].month + "-" + my[0].day);
                        <%}
               else
               {%>
                    $("#begTime").val(my[0].month + "/" + my[0].day + "/" + my[0].year);
                    $("#endTime").val(my[0].month + "/" + my[0].day + "/" + my[0].year);
                    <%}%>
                }
          });

            $("#divdrag").mousedown(function () {
                $("#color1").focus();

                dragdiv();
            });
            $("#divdrag").mousemove(function () {
                mydragWindow();
            });
            $("#divdrag").mouseup(function () {
                mystopDragWindow();
            });
            document.body.oncontextmenu = function () { return false; };

            rewritevml();
        })




        function ToSubmit(option) {
            var FT = $("#SelTime").val();
            var Lim = $("#SelLimit").val();
            var BTime ;
            var ETime;
            if (option == "limit") {
                BTime = $("#begTime").val() + " " + $("#begSelectHour").val() + ":" + $("#BegSelectMinu").val() + ":00";
                ETime = $("#endTime").val() + " " + $("#endSelectHour").val() + ":" + $("#endSelectMinu").val() + ":00";
            } else {
                var time = new Date();
                BTime = time.getFullYear() + "-" + (time.getMonth() + 1) + "-" + time.getDate() + " " + "00:00:00";
                ETime = time.getFullYear() + "-" + (time.getMonth() + 1) + "-" + time.getDate() + " " + time.getHours() + ":" + time.getMinutes() + ":" + time.getSeconds();
            }
            var PGHZ = "1";
            var UserID = '<%=Request["id"] %>';
            var datatimenow = '<%=strDataNow%>';
            var PCname = $("#Label1").text();
            var usertype =escape($("#usertype").text());
            var ISSI = $("#labelISSI").text();//xzj--20181120
            var ZDGZ = "false"; //
            var AutoPlay = "false"; //

            var threemonthe = window.parent.historySelectTimeSpace;
            var beginTime = new Date(Date.parse(BTime.replace(/-/g, "/")));
            var endTime = new Date(Date.parse(ETime.replace(/-/g, "/")));
            var Lang_Please_note_the_largest_single_query_time_span_of_3_hours = window.parent.parent.GetTextByName("Lang_Please_note_the_largest_single_query_time_span_of_3_hours", window.parent.parent.useprameters.languagedata);
            if ((endTime - beginTime) > threemonthe) {
                alert(Lang_Please_note_the_largest_single_query_time_span_of_3_hours);//("请注意，单次查询最大时间跨度为3个小时。")
                return;
            }
            var Lang_The_playback_start_time_can_not_be_empty = window.parent.parent.GetTextByName("Lang_The_playback_start_time_can_not_be_empty", window.parent.parent.useprameters.languagedata);
            var Lang_The_playback_end_time_can_not_be_empty = window.parent.parent.GetTextByName("Lang_The_playback_end_time_can_not_be_empty", window.parent.parent.useprameters.languagedata);
            var Lang_The_playback_end_time_cannot_least_playback_start_time = window.parent.parent.GetTextByName("Lang_The_playback_end_time_cannot_least_playback_start_time", window.parent.parent.useprameters.languagedata);
            if (option == "limit") {
                if ($("#begTime").val() == "") {
                    alert(Lang_The_playback_start_time_can_not_be_empty);//("播放开始时间不能为空");
                    return;
                }
                if ($("#endTime").val() == "") {
                    alert(Lang_The_playback_end_time_can_not_be_empty);//("播放结束时间不能为空");
                    return;
                }
                if (BTime > ETime) {
                    alert(Lang_The_playback_end_time_cannot_least_playback_start_time);//("播放结束时间不能小于播放开始时间");
                    return;
                }
            }
            
            //if (endTime > new Date(Date.parse(datatimenow.replace(/-/g, "/"))))
            //{
            //    var Lang_end_time_more_than_current_server_time = window.parent.parent.GetTextByName("Lang_end_time_more_than_current_server_time", window.parent.parent.useprameters.languagedata);
            //    alert(Lang_end_time_more_than_current_server_time);
            //    return;
            //}

            var varcolor = $("#color1").val().replace("#", "");
        
            varcolor = window.parent.colorCodeToFlashColor(document.getElementById("selColor").value);
            var selectWidth = $("#selectWidth").val();
            var selectLine = $("#selectLine").val();
            var Time = window.parent.parent.GetTextByName("Time", window.parent.parent.useprameters.languagedata);
            var Lang_open_user = window.parent.parent.GetTextByName("Lang_open_user", window.parent.parent.useprameters.languagedata);
            var Lang_open_user_Terminal = window.parent.parent.GetTextByName("Lang_open_user_Terminal", window.parent.parent.useprameters.languagedata);//xzj--20181120--开启用户的终端号码

            var Lang_HistoricalTrace = window.parent.parent.GetTextByName("Lang_HistoricalTrace", window.parent.parent.useprameters.languagedata);

            //window.parent.writeLog("oper", "[历史轨迹]：开启用户(" + PCname + ")时间（" + BTime + "-" + ETime + "）的历史时轨迹" + "[" + window.parent.LOGTimeGet() + "]");         /**日志：操作日志 **/
            //xzj--20181120--日志中添加开启用户的ISSI
            window.parent.writeLog("oper", "[" + Lang_HistoricalTrace + "]:" + Lang_open_user + "(" + PCname + ")" + Lang_open_user_Terminal + "(" + ISSI + ")" + Time + "（" + BTime + "-" + ETime + "）" + Lang_HistoricalTrace + "" + "[" + window.parent.LOGTimeGet() + "]");         /**日志：操作日志 **/
            //xzj--20181120--添加ISSI参数
            window.open("../../HistoryPlayer.aspx?usertype=" + usertype + "&selectLine=" + selectLine + "&selectWidth=" + selectWidth + "&varcolor=" + varcolor + "&AutoPlay=" + AutoPlay + "&PCname=" + PCname + "&ISSI=" + ISSI + "&ZDGZ=" + ZDGZ + "&UserID=" + UserID + "&freshTime=" + FT + "&limit=" + Lim + "&BegHistoryTime=" + BTime + "&EndHistoryTime=" + ETime + "&PlayGHz=" + PGHZ, UserID, "height=" + window.screen.height + ",width=" + window.screen.width + ",top=0,left=0,toolbar=no,menubar=no, scrollbars=no, resizable=no,  location=no, status=yes ");
            window.parent.mycallfunction('SubmitToHistory', 440, 390);
        }

        var dragEnable = 'True';
        function dragdiv() {
            var div1 = window.parent.document.getElementById(geturl());
            if (div1 && event.button == 0 && dragEnable == 'True') {
                window.parent.mystartDragWindow(div1, null, event); div1.style.border = "solid 3px transparent"; window.parent.cgzindex(div1);

            }
        }
        function mydragWindow() {
            var div1 = window.parent.document.getElementById(geturl());
            if (div1) {
                window.parent.mydragWindow(div1, event);
            }
        }
        function mystopDragWindow() {
            var div1 = window.parent.document.getElementById(geturl());
            if (div1) {
                window.parent.mystopDragWindow(div1); div1.style.border = "0px";
            }
        }

    </script>
    <style type="text/css">
        #Label1 {
            font-weight: bold;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div style="background-color: White">
            <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
                <tr>
                    <td height="30">
                        <div id="divdrag">
                            <table width="100%" border="0" cellspacing="0" cellpadding="0" style="height: 32px">
                                <tr>
                                    <td width="15" height="32">
                                        <img src="../images/tab_03.png" width="15" height="32" />
                                    </td>
                                    <td width="1101" background="../images/tab_05.gif">
                                        <ul class="hor_ul" id="userul" runat="server">
                                            <li>
                                                <img src="../images/311.gif" width="16" height="16" />
                                                <span id=""><%--查看[--%></span>
                                                <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label><%--]历史轨迹播放--%>
                                                <asp:Label ID="usertype" runat="server"></asp:Label>
                                                <asp:Label ID="labelISSI" runat="server"></asp:Label><!--xzj--20181120-->
                                            </li>
                                            <li></li>
                                            <li></li>
                                            <li></li>
                                            <li></li>
                                            <li style="float: right;">
                                                <img class="style6" style="cursor: hand;" onclick="window.parent.mycallfunction(geturl(),693, 354);"
                                                    onmouseover="javascript:this.src='../images/close_un.png';" onmouseout="javascript:this.src='../images/close.png';"
                                                    src="../images/close.png" />
                                            </li>
                                        </ul>
                                    </td>
                                    <td width="14">
                                        <img src="../images/tab_07.png" width="14" height="32" />
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td width="15" background="../images/tab_12.gif">&nbsp;
                                </td>
                                <td align="center">
                                    <table class="style1" cellspacing="1" id="dragtd">
                                        <tr style="height: 25px">
                                            <td width="100px" align="right">
                                                <span style="color: Red">*</span><span id="Lang_Player_start_time"><%--播放开始时间:--%></span>
                                            </td>
                                            <td align="left">
                                                <input type="text" readonly="readonly" style="width: 80px; height: 13px" id="begTime" class="Wdate" onfocus="">
                                                <select id="begSelectHour" style="width: 40px; height: 20px">
                                                    <option value="00">0</option>
                                                    <option value="01">1</option>
                                                    <option value="02">2</option>
                                                    <option value="03">3</option>
                                                    <option value="04">4</option>
                                                    <option value="05">5</option>
                                                    <option value="06">6</option>
                                                    <option value="07">7</option>
                                                    <option value="08">8</option>
                                                    <option value="09">9</option>
                                                    <option value="10">10</option>
                                                    <option value="11">11</option>
                                                    <option value="12">12</option>
                                                    <option value="13">13</option>
                                                    <option value="14">14</option>
                                                    <option value="15">15</option>
                                                    <option value="16">16</option>
                                                    <option value="17">17</option>
                                                    <option value="18">18</option>
                                                    <option value="19">19</option>
                                                    <option value="20">20</option>
                                                    <option value="21">21</option>
                                                    <option value="22">22</option>
                                                    <option value="23">23</option>
                                                </select><span style="display:none" id="Lang_hour"><%--时--%></span>:
                                                <select id="BegSelectMinu" style="width: 40px; height: 20px">
                                                </select><span style="display:none" id="Lang_Minute"><%--分--%></span>
                                            </td>
                                        </tr>
                                        <tr style="height: 25px">
                                            <td width="100px" align="right">
                                                <span style="color: Red">*</span> <span id="Lang_play_end_time"><%--播放结束时间：--%></span>
                                            </td>
                                            <td align="left">
                                                <input type="text" readonly="readonly" style="width: 80px; height: 13px" id="endTime" class="Wdate" onfocus="<%--new WdatePicker(this,'%Y-%M-%D %h:%m:%s',true,'whyGreen')--%>">
                                                <select id="endSelectHour" style="width: 40px; height: 20px">
                                                    <option value="00">0</option>
                                                    <option value="01">1</option>
                                                    <option value="02">2</option>
                                                    <option value="03">3</option>
                                                    <option value="04">4</option>
                                                    <option value="05">5</option>
                                                    <option value="06">6</option>
                                                    <option value="07">7</option>
                                                    <option value="08">8</option>
                                                    <option value="09">9</option>
                                                    <option value="10">10</option>
                                                    <option value="11">11</option>
                                                    <option value="12">12</option>
                                                    <option value="13">13</option>
                                                    <option value="14">14</option>
                                                    <option value="15">15</option>
                                                    <option value="16">16</option>
                                                    <option value="17">17</option>
                                                    <option value="18">18</option>
                                                    <option value="19">19</option>
                                                    <option value="20">20</option>
                                                    <option value="21">21</option>
                                                    <option value="22">22</option>
                                                    <option value="23" selected="selected">23</option>
                                                </select><span style="display:none" id="Span1"><%--时--%></span>:
                                                <select id="endSelectMinu" style="width: 40px; height: 20px">
                                                </select><span style="display:none" id="Span2"><%--分--%></span>
                                            </td>
                                        </tr>
                                        <tr style="height: 25px">
                                            <td id="Lang_playback_interval" width="100px" align="right">
                                                <%-- 播放时间间隔：--%>
                                            </td>
                                            <td align="left">
                                                <select id="SelTime" style="width: 80px; height: 20px">
                                                  
                                                    <option selected="selected" value="100" id="Lang_0.1second"><%--0.1秒--%></option>
                                                    <option value="200" id="Lang_0.2second"><%--0.2秒--%></option>
                                                    <option value="300" id="Lang_0.3second"><%--0.3秒--%></option>
                                                    <option value="400" id="Lang_0.4second"><%--0.4秒--%></option>
                                                    <option value="500" id="Lang_0.5second"><%--0.5秒--%></option>
                                                    <option value="1000" id="Lang_1second"><%--1秒--%></option>
                                                    <option value="2000" id="Lang_2second"><%--2秒--%></option>
                                                    <option value="3000" id="Lang_3second"><%--3秒--%></option>
                                                    <option value="4000" id="Lang_4second"><%--4秒--%></option>
                                                    <option value="5000" id="Lang_5second"><%--5秒--%></option>
                                                </select>
                                            </td>
                                        </tr>
                                        <%--<tr style="height: 25px">
                                        <td width="100px" align="right">
                                            播放时间密度:
                                        </td>
                                        <td colspan="2" align="left">
                                            <select id="SelPlayGHz" style="width: 80px; height: 20px">
                                                <option value="1">1分钟</option>
                                                <option value="2">2分钟</option>
                                                <option value="5">5分钟</option>
                                                <option value="10">10分钟</option>
                                                <option value="20">20分钟</option>
                                                <option value="30">30分钟</option>
                                                <option value="60">60分钟</option>
                                            </select>
                                        </td>
                                    </tr>--%>
                                        <tr style="height: 25px">
                                            <td id="Lang_Each_page_shows_number" width="100px" align="right">
                                                <%--每页显示条数：--%>
                                            </td>
                                            <td colspan="2" align="left">
                                                <select id="SelLimit" style="width: 80px; height: 20px">
                                                    <option value="50" id="Lang_50tiao"><%--50条--%></option>
                                                    <option value="100" id="Lang_100tiao"><%--100条--%></option>
                                                    <option value="200" id="Lang_200tiao"><%--200条--%></option>
                                                    <option value="500" id="Lang_500tiao"><%--500条--%></option>
                                                    <option value="1000" id="Lang_1000tiao"><%--1000条--%></option>
                                                    <option value="5000" id="Lang_5000tiao"><%--5000条--%></option>
                                                  
                                                </select>
                                            </td>
                                        </tr>
                                        <tr style="height: 25px;">
                                            <td id="Lang_color" width="100px" align="right">
                                                <%--  颜色：--%>
                                            </td>
                                            <td align="left">
                                                <div style="display:none">
                                                <input class="iColorPicker" readonly="readonly" id="color1" onpropertychange="rewritevml()" style="background-color: #000000; margin-top: 5px; width: 85px;"
                                                    type="text" value="#000" /></div>
                                                 <select id="selColor" onchange="rewritevml()">
                                                   
                                                </select>
                                            </td>
                                        </tr>
                                        <tr style="height: 25px">
                                            <td id="Lang_width" width="100px" align="right">
                                                <%-- 宽度：--%>
                                            </td>
                                            <td align="left">
                                                <select id="selectWidth" onchange="rewritevml()" name="D1">
                                                    <option value="1">1</option>
                                                    <option value="2">2</option>
                                                    <option value="3">3</option>
                                                    <option value="4">4</option>
                                                    <option value="5">5</option>
                                                </select>&nbsp;
                                            </td>
                                        </tr>
                                        <tr style="display:none">
                                            <td id="Lang_style_2" width="100px" align="right">
                                                <%--样式：--%>
                                            </td>
                                            <td align="left">
                                                <select id="selectLine" onchange="rewritevml()" name="D1">
                                                    <option value="solid" id="Lang_solid"><%--实线--%></option>
                                                    <option value="dot" id="Lang_dot"><%--点线--%></option>
                                                    <option value="dash" id="Lang_dash"><%--虚线--%></option>
                                                    <option value="dashdot" id="Lang_dashdot"><%--点虚线--%></option>
                                                    <option value="longdash" id="Lang_longdash"><%--长虚线--%></option>
                                                    <option value="longdashdot" id="Lang_longdashdot"><%--虚点线--%></option>
                                                    <option value="longdashdotdot" id="Lang_longdashdotdot"><%--双点线--%></option>
                                                </select>&nbsp;
                                            </td>
                                        </tr>
                                        <tr style="height: 25px">
                                            <td align="center" colspan="3">
                                                <canvas id="polyline1" style="height: 25px; width: 200px;"></canvas>
                                            </td>
                                        </tr>
                                        <tr style="height: 25px">
                                          
                                            <td align="center" colspan="2">
                                                 <img style="margin: 0px 0px 0px 3px; cursor: hand" id="add_Today" src="<%--../images/add_ok.png--%>" onclick="ToSubmit('today')" />&nbsp;&nbsp;&nbsp;&nbsp;
                                                <img style="margin: 0px 0px 0px 3px; cursor: hand" id="add_okPNG" src="<%--../images/add_ok.png--%>" onclick="ToSubmit('limit')" />
                                                <%--<input type="button" value="提交" onclick="ToSubmit();" />--%>
                                            </td>
                                        </tr>
                                    </table>
                                    &nbsp;
                                </td>
                                <td width="14" background="../images/tab_16.gif">&nbsp;
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td height="15">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td width="15" height="15">
                                    <img src="../images/tab_20.png" width="15" height="15" />
                                </td>
                                <td background="../images/tab_21.gif"></td>
                                <td width="14">
                                    <img src="../images/tab_22.png" width="14" height="15" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>

        </div>
    </form>
</body>
</html>
<script type="text/javascript">

    window.parent.closeprossdiv();
    LanguageSwitch(window.parent);

    var image1 = window.document.getElementById("add_okPNG");
    var srouce1 = window.parent.parent.GetTextByName("Lang_edit_entity", window.parent.parent.useprameters.languagedata);
    image1.setAttribute("src", srouce1);

    var image2 = window.document.getElementById("add_Today");
    var source2 = window.parent.parent.GetTextByName("Lang_show_today_history", window.parent.parent.useprameters.languagedata);
    image2.setAttribute("src", source2);

    window.document.getElementById("Span1").innerHTML = window.parent.parent.GetTextByName("Lang_hour", window.parent.parent.useprameters.languagedata);
    window.document.getElementById("Span2").innerHTML = window.parent.parent.GetTextByName("Lang_Minute", window.parent.parent.useprameters.languagedata);

    function rewritevml() {//cxy-20180712-箭头图形
        //var stroke1 = document.getElementById("stroke1");
        //var polyline1 = document.getElementById("polyline1");
        //var colorbox = document.getElementById("color1");

        //var color = colorbox.value;
        //color = window.parent.colorCodeToHtmlColor(window.document.getElementById("selColor").value);

        //var lineweight = $("#selectWidth").val();
        //var linestyle = $("#selectLine").val();
        //stroke1.Weight = lineweight;
        //stroke1.dashstyle = linestyle;
        //polyline1.strokecolor = color;
        color = window.parent.colorCodeToHtmlColor(window.document.getElementById("selColor").value);
        var lineweight = $("#selectWidth").val();
        //var linestyle = $("#Select1").val();

        var mycanvas = document.getElementById('polyline1');
        mycanvas.width = "200";
        mycanvas.height = "25";
        var ctx = mycanvas.getContext("2d");
        ctx.lineWidth = lineweight;
        ctx.beginPath();
        ctx.strokeStyle = color;
        ctx.moveTo(2, mycanvas.height / 2);
        ctx.lineTo(180, mycanvas.height / 2);
        ctx.closePath();
        ctx.stroke();

        var canvasHeight = mycanvas.height;
        lineweight = lineweight * 3;
        ctx.fillStyle = color;
        ctx.beginPath();
        ctx.moveTo(180, canvasHeight / 2 - lineweight / 2);
        ctx.lineTo(180, canvasHeight / 2 + lineweight / 2);
        var jiantouX = 180 + (lineweight / 2) / Math.tan(Math.PI / 6);
        ctx.lineTo(jiantouX, canvasHeight / 2);
        ctx.closePath();
        ctx.fill();

    }
    window.parent.loadColorOption(window.document.getElementById("selColor"));
</script>
