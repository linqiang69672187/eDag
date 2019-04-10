<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="OperationLog.aspx.cs" Inherits="Web.lqnew.opePages.LogView.OperationLog" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title><%--接收号码--%></title>
    <link href="../../css/lq_manager.css" rel="stylesheet" />
    <link href="../../../CSS/pagestyle.css" rel="stylesheet" />
    <link href="style/StyleSheet.css" rel="stylesheet" />
    <link href="../../../CSS/jquery-ui-1.8.14.custom.css" rel="stylesheet" type="text/css" />
    <link href="../../../CSS/jquery-ui-timepicker-addon.css" rel="stylesheet" type="text/css" />
    <link href="../../../CSS/ui-lightness/jquery-ui-1.8.13.custom.css" rel="stylesheet" />

</head>
<body>
    <div id="toolTip"></div>
    <form id="form1" runat="server">

        <table class="style1" cellpadding="0" cellspacing="0" frame="void" style="border-collapse: collapse;">
            <tr style="height: 5px;" id="derppp">
                <td>
                    <img src="../../images/tab_03.png" width="15" height="32" /></td>
                <td  background="../../images/tab_05.gif" style="background-repeat:repeat-x;vertical-align:top">
                    <div id="Lang_OperationLog" style="display: inline; float: left; padding-top: 5px; text-align: left; width: 30%; color: white"><%--操作日志--%></div>
                    <div id="divClose" onmouseover="Divover('on')" onclick="closethispage()" onmouseout="Divover('out')"></div>
                </td>
                <td>
                    <img src="../../images/tab_07.png" width="14" height="32" /></td>
                </td>
            </tr>
            <tr>
                <td background="../../images/tab_12.gif" style="background-repeat:repeat-y">&nbsp;
                </td>
                <td class="bg4" id="dragtd">
                    <table border="0" cellpadding="0" cellspacing="0" align="left" class="style3" frame="void" style="border-collapse: collapse;">
                        <tr>

                            <td>
                                <table id="Table1" align="left" bgcolor="#c0de98" runat="server" border="0" cellpadding="0" cellspacing="0" width="700px">
                                    <tr>
                                        <td align="left" valign="top" style="background-color: white" id="dragtd">
                                            <table style="width: 800px; font-size: 12px">
                                                <tr>
                                                    <td align="left" style="text-align: right; width: 300px">
                                                        <span id="Lang_BegTime">开始时间</span>
                                                        <input readonly="readonly" type="text" style="width: 105px; ime-mode: disabled" id="begTime" class="Wdate" onfocus="">
                                                        <img onclick="delBegtime()" src="../../images/close.png" />
                                                    </td>
                                                    <td style="text-align: right; width: 300px">
                                                        <span id="Lang_EndTime">结束时间</span>
                                                        <input readonly="readonly" type="text" style="width: 105px;" id="endTime" class="Wdate" onfocus="">
                                                        <img onclick="delEndtime()" src="../../images/close.png" />
                                                    </td>
                                                    <td style="text-align: right; width: 300px">
                                                        <span id="Lang_LoginUser">登陆用户</span>
                                                        <input id="txtloginuser" style="width: 80px" type="text" onkeypress="checkComments()" />
                                                    </td>
                                                    <%-- <td style="text-align:right; width: 50px">
                                                        <span id="Lang_OperationType">操作类型</span>
                                                        <select id="selOperationType" style="width: 80px"></select>
                                                    </td>--%>
                                                </tr>
                                                <tr>
                                                    <td align="left" style="text-align: right; width: 290px; padding-right: 22px;">
                                                        <span id="Lang_IdentityUnit">移动用户单位</span>
                                                        <select id="selIdentityUnit" runat="server" style="width: 105px"></select>
                                                        <%--<input id="txtIdentityUnit" style="width: 80px" type="text" onclick="OpenEntityWindow('identityunit')" />--%>
                                                        <%--<img onclick="delIdentityUnit()" src="../../images/close.png" />--%>
                                                    </td>
                                                    <td style="text-align: right; width: 300px">
                                                        <span id="Lang_IdentityID">移动用户号码</span>
                                                        <input id="txtIdentityID" style="width: 80px" type="text" onkeypress="checkComments()" />
                                                    </td>
                                                    <td style="text-align: right; width: 300px">
                                                        <span id="Lang_IdentityName">移动用户名称</span>
                                                        <input id="txtIdentityName" style="width: 80px" type="text" onkeypress="checkComments()" />
                                                    </td>
                                                    <%--<td style="text-align:right; width: 50px; visibility: hidden">
                                                       <span id="Lang_IdentityType">移动用户类型</span>
                                                        <select id="SelIdentityType" style="width: 80px"></select>
                                                    </td>--%>
                                                </tr>
                                                <tr>
                                                    <td align="left" style="text-align: right; width: 300px; padding-right: 22px;">
                                                        <span id="Lang_spIdentityDeviceUnit">设备单位</span>
                                                        <select id="selIdentityDeviceUnit" runat="server" style="width: 105px"></select>
                                                        <%--<input id="txtIdentityDeviceUnit" style="width: 80px" type="text" onclick="OpenEntityWindow('deviceunit')" />--%>
                                                        <%--<img onclick="delDeviceUnit()" src="../../images/close.png" />--%>
                                                    </td>
                                                    <td style="text-align: right; width: 300px" onmouseover="ShowToolTipTitle('Lang_TerminalIDorBSIDorGroupID');" onmouseout="hideToolTip();">
                                                        <span id="Lang_spIdentityDeviceID">设备标识</span>
                                                        <input id="txtIdentityDeviceID" style="width: 80px" type="text" onkeypress="checkComments()" />
                                                    </td>
                                                    <td style="text-align: right; width: 300px;">
                                                        <span id="Lang_OperationType">操作类型</span>
                                                        <select id="selOperationType" style="width: 100px"></select>
                                                        <%--<span id="Lang_spIdentityDeviceType">设备类型</span>
                                                        <select id="selIdentityDeviceType" style="width: 80px"></select>--%>
                                                    </td>
                                                    <td style="text-align: right; width: 10px">
                                                        <img id="btnSearch" style="cursor: pointer" onclick="searchList()" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="left" colspan="2">
                                                        <span onclick="firstPage()" class="YangdjPageStyle" id="Lang_FirstPage">首页</span>
                                                        &nbsp;&nbsp;<span onclick="prePage()" class="YangdjPageStyle" id="Lang_PrePage">上一页</span>
                                                        &nbsp;&nbsp;<span onclick="nextPage()" class="YangdjPageStyle" id="Lang_play_next_page">下一页</span>
                                                        &nbsp;&nbsp;<span onclick="lastPage()" class="YangdjPageStyle" id="Lang_LastPage">尾页</span>
                                                        &nbsp;&nbsp;<select onchange="tzpage()" id="sel_page"></select>
                                                    </td>
                                                    <td align="right" colspan="1" class="auto-style5">
                                                        <span id="span_page"></span>
                                                        <span id="span_currentPage"></span>/
                                                        <span id="span_totalpage"></span>&nbsp;&nbsp;&nbsp;
                                                        <span id="span_Article"></span>
                                                        <span id="span_currentact"></span>/
                                                        <span id="span_total"></span>
                                                    </td>
                                                    <td></td>
                                                </tr>
                                            </table>
                                            <table id="GridView1" style="background-color: #C0DE98; border-color: White; border-width: 0px; border-style: Ridge; width: 800px; font-size: 12px">
                                                <tr class="gridheadcss">
                                                    <th style="width: 100px; background-color: ActiveBorder"><span style="font-size: 10px; color: darkgreen" id="Lang_OperatDateTime">操作时间</span></th>
                                                    <th style="background-color: ActiveBorder; width: 100px" class="auto-style4"><span style="font-size: 10px; color: darkgreen" id="Lang_SchedulISSI">调度台号</span></th>
                                                    <th style="width: 100px; background-color: ActiveBorder"><span style="font-size: 10px; color: darkgreen" id="Lang_SchedulIP">IP</span></th>
                                                    <th style="width: 100px; background-color: ActiveBorder"><span style="font-size: 10px; color: darkgreen" id="Lang_IdentityDeviceID">设备标识</span></th>
                                                    <th style="width: 100px; background-color: ActiveBorder"><span style="font-size: 10px; color: darkgreen" id="Lang_IdentityDeviceType">设备类型</span></th>
                                                    <th style="width: 100px; background-color: ActiveBorder"><span style="font-size: 10px; color: darkgreen" id="Lang_IdentityDeviceUnit">设备单位</span></th>
                                                    <th style="width: 100px; background-color: ActiveBorder"><span style="font-size: 10px; color: darkgreen" id="Lang_ModelName">模块名称</span></th>
                                                    <th style="width: 100px; background-color: ActiveBorder"><span style="font-size: 10px; color: darkgreen" id="Lang_Content">操作内容</span></th>
                                                </tr>
                                            </table>
                                            <div id="div_selectUserList" style="position: relative; font-size: 12px; top: 0px; width: 800px; height: 255px; background-color: azure;">
                                                <table cellspacing="0" cellpadding="0" id="GridViewLog" style="background-color: #C0DE98; border-color: White; border-width: 0px; border-style: Ridge; width: 100%; top: 0px">
                                                    <tbody id="Tbody1">
                                                    </tbody>
                                                </table>
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
                <td  background="../../images/tab_16.gif" style="background-repeat:repeat-y;width:10px"></td>
            </tr>
            <tr style="height: 5px;">
                <td><img src="../../images/tab_20.png" width="15" height="15" /></td>
                <td background="../../images/tab_21.gif" style="background-repeat:repeat-x"></td>
                <td><img src="../../images/tab_22.png" width="14" height="15" /></td>
            </tr>
        </table>
    </form>

    <script src="../../../JQuery/jquery-1.7.2.min.js" type="text/javascript"></script>
    <script src="../../../JS/LangueSwitch.js"></script>
    <script src="../../../JQuery/jquery-ui-autocomplete.js" type="text/javascript"></script>
    <script src="../../../JQuery/jquery-ui.js" type="text/javascript"></script>
    <script src="../../../JQuery/jquery-ui-slide.min.js" type="text/javascript"></script>
    <script src="../../../JQuery/jquery-ui-timepicker-addon.js" type="text/javascript"></script>
    <%if (System.Configuration.ConfigurationManager.AppSettings["defaultLanguage"] == "zh-CN")
      { %>
    <script src="../../../JQuery/jquery-ui-timepicker-zh-CN.js" type="text/javascript"></script>
    <%} %>

    <script type="text/javascript">

        window.parent.closeprossdiv();

        LanguageSwitch(window.parent.parent);

        window.document.getElementById("Lang_OperationLog").innerHTML = window.parent.parent.GetTextByName("Lang_OperationLog", window.parent.parent.useprameters.languagedata);
        var Lang_Search22 = "../" + window.parent.parent.GetTextByName("Lang_Search2", window.parent.parent.useprameters.languagedata);
        var Lang_Search2_un = "../" + window.parent.parent.GetTextByName("Lang_Search2_un", window.parent.parent.useprameters.languagedata);
        var Lang_Search2 = window.document.getElementById("btnSearch");
        Lang_Search2.setAttribute("src", Lang_Search22);
        Lang_Search2.onmousedown = function () {
            Lang_Search2.src = Lang_Search2_un;
            return false;
        }
        Lang_Search2.onmouseup = function () {
            Lang_Search2.src = Lang_Search22;
            return false;
        }

        function openDetail(id) {
            window.parent.parent.mycallfunction("LogView/view_OperationLog", "400", "400", id);
        }

        function backcolor(obj) {
            if (!obj.contains(event.toElement)) {
                var img = document.getElementById("imgaddmeb");
                if (img) {
                    obj.removeChild(img);
                }
                img = null;
                var img = document.getElementById("imgremmeb");
                if (img) {
                    obj.removeChild(img);
                }
                img = null;
            }
        }

        function changebgcolor(obj, id, type, treedepth) {
            if (!obj.contains(event.fromElement)) {
                var div = document.getElementById("imgaddmeb") || document.createElement("img");
                div.style.marginLeft = "3px";
                div.style.cursor = "hand";
                div.id = "imgaddmeb";
                div.onclick = function () {
                    SelectMember(id, type, treedepth, "add");
                };
                div.src = '../images/addmember.gif';
                obj.appendChild(div);

                var div = document.getElementById("imgremmeb") || document.createElement("img");
                div.id = "imgremmeb";
                div.style.cursor = "hand";
                div.style.marginLeft = "5px";
                div.style.marginBottom = "4px";
                div.onclick = function () {
                    SelectMember(id, type, treedepth, "del");
                };
                div.src = '../../images/removemember.gif';
                obj.appendChild(div);
            }

        }

        var Lang_loading = window.parent.parent.GetTextByName("Lang_loading", window.parent.parent.useprameters.languagedata);
        var LangNone = window.parent.parent.GetTextByName("Lang-None", window.parent.parent.useprameters.languagedata);

        var everypagecount = 10;
        var currentPage = 1;
        var totalPage = 1;
        var totalCounts = 0;

        function reroadpagetitle() {

            if (totalCounts % everypagecount == 0) {
                totalPage = parseInt(totalCounts / everypagecount);
            } else {
                totalPage = parseInt(totalCounts / everypagecount + 1);
            }
            if (currentPage > totalPage) {
                currentPage = totalPage;
            }

            var sel = document.getElementById("sel_page");

            if (totalPage < sel.length) {
                sel.length = totalPage;
            } else if (totalPage == sel.length) {

            } else {
                sel.style.display = "none";
                for (var p = sel.length + 1; p <= totalPage; p++) {
                    var option = document.createElement("option");
                    option.value = p;
                    option.innerHTML = p;
                    sel.appendChild(option);
                }
                sel.style.display = "inline";
            }

            sel.value = currentPage;
            document.getElementById("span_currentPage").innerHTML = currentPage;
            document.getElementById("span_totalpage").innerHTML = totalPage;
            document.getElementById("span_total").innerHTML = totalCounts;
            isFirstPage();
            if (isLastPage(currentPage) && currentPage > 0) {
                document.getElementById("span_currentact").innerHTML = (currentPage - 1) * everypagecount + 1 + "~" + totalCounts;
            } else if (currentPage <= 0) {
                document.getElementById("span_currentact").innerHTML = 0 + "~" + currentPage * everypagecount;

            } else {
                document.getElementById("span_currentact").innerHTML = (currentPage - 1) * everypagecount + 1 + "~" + currentPage * everypagecount;
            }

        }

        document.onkeypress = function () {
            if (event.keyCode == 13) {
                event.keyCode = 0;
                event.returnValue = false;
                searchList();
            }
        }

        ///获取数据
        function getData() {
            var begtime = document.getElementById("begTime").value;
            var endtime = document.getElementById("endTime").value;
            //设备
            var IdentityDeviceUnit = "";
            if (document.getElementById("selIdentityDeviceUnit").value > 0) {
                IdentityDeviceUnit = document.getElementById("selIdentityDeviceUnit").options[document.getElementById("selIdentityDeviceUnit").selectedIndex].text;
            }
            else {
                IdentityDeviceUnit = "";
            }

            //alert("设备" + IdentityDeviceUnit);
            var IdentityDeviceID = document.getElementById("txtIdentityDeviceID").value;
            var IdentityDeviceType = ""; //document.getElementById("selIdentityDeviceType").value;

            //载体
            var IdentityUnit = "";
            if (document.getElementById("selIdentityUnit").value > 0) {
                IdentityUnit = document.getElementById("selIdentityUnit").options[document.getElementById("selIdentityUnit").selectedIndex].text;
            }
            else {
                IdentityUnit = "";
            }

            //alert("载体" + IdentityUnit);
            var IdentityID = document.getElementById("txtIdentityID").value;
            var IdentityName = document.getElementById("txtIdentityName").value;
            var IdentityType = "";//document.getElementById("SelIdentityType").value;
            var LoginUser = document.getElementById("txtloginuser").value;
            //var type =  $('#SelOperationType option:selected').val();
            var type = $("#selOperationType").find("option:selected").val();
            //if (begtime == null || endtime == null) {
            //var begname = window.parent.parent.GetTextByName("begTime", window.parent.parent.useprameters.languagedata);
            //var endname = window.parent.parent.GetTextByName("endTime", window.parent.parent.useprameters.languagedata);
            //return;
            //}

            $("#isprocessing").remove();
            $("#Tbody1").append("<tr id='isprocessing' style='background-color:White;height:25px;color:red'><td colspan='5' >" + Lang_loading + "</td></tr>");

            window.parent.jquerygetNewData_ajax("../../Handlers/GetOperationLog.ashx", {
                endtime: endtime,
                begtime: begtime,
                IdentityDeviceUnit: IdentityDeviceUnit,
                IdentityDeviceID: IdentityDeviceID,
                IdentityDeviceType: IdentityDeviceType,
                IdentityUnit: IdentityUnit,
                IdentityID: IdentityID,
                IdentityName: IdentityName,
                IdentityType: IdentityType,
                LoginUser: LoginUser,
                type: type,
                PageIndex: currentPage,
                Limit: everypagecount
            }, function (msg) {
                $("#isprocessing").remove();
                totalCounts = msg.totalcount;
                reroadpagetitle();
                $("#Tbody1 tr").remove();
                if (msg.data.logList.length == 0) {
                    $("#Tbody1").append("<tr id='isprocessing' style='background-color:White;height:25px;color:red'><td colspan='5' >" + LangNone + "</td></tr>");
                    return;
                }

                ///数据赋值
                for (var i = 0; i < msg.data.logList.length; i++) {
                    var row = msg.data.logList[i];
                    var id = row[0];
                    var date = row[1];
                    var ssi = row[3];
                    var ip = row[4];
                    var deviceid = row[8] == null ? "" : row[8];
                    var devicetype = row[10] == null ? "" : window.parent.parent.GetTextByName("OperateLogIdentityDeviceType" + row[10], window.parent.parent.useprameters.languagedata);
                    var deviceunit = row[11] == null ? "" : row[11];
                    var modelname = window.parent.getTextByNumForModule(row[16]);
                    var content = row[18];//= window.parent.parent.GetTextByName(row[18], window.parent.parent.useprameters.languagedata);
                    var mouseover_show = "";
                    if (content.indexOf(';') > -1) {
                        content = GetContentResult(row[18]);
                        mouseover_show = content;
                    }
                    else {
                        content = window.parent.parent.GetTextByName(row[18], window.parent.parent.useprameters.languagedata);
                        mouseover_show = content;
                    }
                    if (content.length > 5)
                        <%if (System.Configuration.ConfigurationManager.AppSettings["defaultLanguage"] == "zh-CN")
                          { %>
                        content = content.substring(0, 5) + "......";
                    <%}
                          else
                          {%>
                    content = content.substring(0, 10) + "......";
                    <%}%>
                    $("#Tbody1").append("<tr id="
                        + id + " onclick='openDetail(\"" + id + "\")' onmouseover='changeTgBg(this,&#39;font&#39;)' onmouseout='overchangeTgBg(this,&#39;font&#39;)' style='background-color:White;height:25px;cursor:hand'><td style='width:100px'  align='center'>"
                        + date + "</td><td style='width:100px' align='center'>"
                        + ssi + "</td><td style='width:100px' align='center'>"
                        + ip + "</td><td style='width:100px' align='center'>"
                        + deviceid + "</td><td style='width:100px' align='center'>"
                        + devicetype + "</td><td style='width:100px' align='center'>"
                        + deviceunit + "</td><td style='width:100px' align='center'>"
                        + modelname + "</td><td style='width:100px' align='center' onmouseover=\"ShowContent('" + mouseover_show + "');\" onmouseout=\"hideToolTip();\" >"
                        + content + "</td></tr>");
                }
            });
        }

        function GetContentResult(s) {
            var str = "";
            var values = s.split(';');
            var count = values.length;
            for (i = 0; i < count; i++) {
                switch (values[i].match(/\w+:\w+/g) != null || values[i].indexOf(':') >= 0) {
                    case true:
                        var v = values[i].split(':');
                        if (v[0] == "Log_GPS_SMS_IsHZ") {
                            if (v[1] == "1")
                                v[1] = window.parent.parent.GetTextByName("Lang_Yes", window.parent.parent.useprameters.languagedata);
                            else
                                v[1] = window.parent.parent.GetTextByName("Lang_No", window.parent.parent.useprameters.languagedata);
                        }

                        if (v[0] == "Log_Elect_Type") {
                            if (v[1] == "rect")
                                v[1] = window.parent.parent.GetTextByName("Lang_square", window.parent.parent.useprameters.languagedata);
                            if (v[1] == "ellipse") //椭圆
                                v[1] = window.parent.parent.GetTextByName("Lang_ellipse", window.parent.parent.useprameters.languagedata);
                            if (v[1] == "oval")
                                v[1] = window.parent.parent.GetTextByName("Lang_oval", window.parent.parent.useprameters.languagedata);
                            if (v[1] == "polygon")
                                v[1] = window.parent.parent.GetTextByName("Lang_polygon", window.parent.parent.useprameters.languagedata);

                        }

                        str += window.parent.parent.GetTextByName(v[0], window.parent.parent.useprameters.languagedata) + ":" + v[1] + ";";
                        break;
                    default:
                        str += window.parent.parent.GetTextByName(values[i], window.parent.parent.useprameters.languagedata) + ";";
                        break;
                }
            }
            return str;
        }

        function searchList() {
            currentPage = 1;
            getData();
        }
        //分页代码--开始
        function isFirstPage() {
            if (currentPage <= 1) {
                window.document.getElementById("Lang_FirstPage").style.color = "gray";
                window.document.getElementById("Lang_PrePage").style.color = "gray";
                window.document.getElementById("Lang_FirstPage").style.textDecoration = "none";
                window.document.getElementById("Lang_PrePage").style.textDecoration = "none";
            } else {
                window.document.getElementById("Lang_FirstPage").style.color = "blue";
                window.document.getElementById("Lang_PrePage").style.color = "blue";
                window.document.getElementById("Lang_FirstPage").style.textDecoration = "underline";
                window.document.getElementById("Lang_PrePage").style.textDecoration = "underline";
            }
        }
        //判断是否为最后一页
        function isLastPage(currentPage) {
            if (currentPage >= totalPage) {
                window.document.getElementById("Lang_play_next_page").style.color = "gray";
                window.document.getElementById("Lang_LastPage").style.color = "gray";
                window.document.getElementById("Lang_play_next_page").style.textDecoration = "none";
                window.document.getElementById("Lang_LastPage").style.textDecoration = "none";
                return true;
            } else {
                window.document.getElementById("Lang_play_next_page").style.color = "blue";
                window.document.getElementById("Lang_LastPage").style.color = "blue";
                window.document.getElementById("Lang_play_next_page").style.textDecoration = "underline";
                window.document.getElementById("Lang_LastPage").style.textDecoration = "underline";
                return false;
            }
        }
        function nextPage() {
            if (totalPage <= currentPage) {
                return;
            }
            currentPage++;
            getData();
            document.getElementById("sel_page").value = currentPage;
        }
        function prePage() {
            if (currentPage <= 1) {
                return;
            }
            currentPage--;
            getData();
            document.getElementById("sel_page").value = currentPage;
        }
        function firstPage() {
            if (currentPage == 1) {
                return;
            }
            currentPage = 1;
            getData();
            document.getElementById("sel_page").value = currentPage;
        }
        function lastPage() {
            if (currentPage == totalPage) {
                return;
            }
            currentPage = totalPage;
            getData();
            document.getElementById("sel_page").value = currentPage;
        }
        function tzpage() {
            var sel = document.getElementById("sel_page").value;
            if (sel == currentPage) {
                return;
            }
            currentPage = sel;
            getData();
            document.getElementById("sel_page").value = currentPage;
        }

        //分页代码--结束
        //窗体拖动
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
            if (Request.QueryString("selfclose") != undefined) {
                window.parent.hiddenbg2();
            }
            window.parent.lq_closeANDremovediv('LogView/OperationLog', 'bgDiv');
        }

        var dragEnable = 'True';
        function dragdiv() {
            var div1 = window.parent.document.getElementById('LogView/OperationLog');
            if (div1 && event.button == 0 && dragEnable == 'True') {
                window.parent.mystartDragWindow(div1, null, event); div1.style.border = "solid 0px transparent"; window.parent.cgzindex(div1);
            }
        }

        function mydragWindow() {
            var div1 = window.parent.document.getElementById('LogView/OperationLog');
            if (div1) {
                window.parent.mydragWindow(div1, event);
            }
        }

        function mystopDragWindow() {
            var div1 = window.parent.document.getElementById('LogView/OperationLog');
            if (div1) {
                window.parent.mystopDragWindow(div1); div1.style.border = "0px";
            }
        }



        window.onload = function () {
            //移动用户类型
            //window.parent.jquerygetNewData_ajax("../../Handlers/GetIdentityTypes.ashx", {
            //    Table:"operationlog"
            //}, function (msg,state) {
            //    for (var k in msg)
            //    {
            //        $("#SelIdentityType").append("<option value=" + msg[k] + ">" + msg[k] + "</option>");
            //    }
            //});
            var tempname = "";
            var json =<%=GetEnumJson<MyModel.Enum.OperateLogOperType>()%>
            $.each(json, function (k, v) {
                tempname = window.parent.parent.GetTextByName(k, window.parent.parent.useprameters.languagedata)
                $("#selOperationType").append("<option value=" + v + " title='" + tempname + "'>" + tempname + "</option>");
            });

            //隐藏设备类型选项
            //devicetyps =
            //=GetEnumJson<MyModel.Enum.OperateLogIdentityDeviceType>()
            //$.each(devicetyps, function (k, v) {
            //    $("#selIdentityDeviceType").append("<option value=" + v + ">" + k + "</option>");
            //});

            window.document.getElementById("divClose").style.display = "inline";
              <%if (System.Configuration.ConfigurationManager.AppSettings["defaultLanguage"] == "zh-CN")
                { %>
            $("#begTime").datetimepicker();
            $("#endTime").datetimepicker();
            <%}
                else
                {%>
            $("#begTime").datetimepicker();
            $("#endTime").datetimepicker();
            <%}%>

            document.onmousedown = function () {
                var div1 = window.parent.document.getElementById('LogView/OperationLog');
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

        var searchbegtime = "";
        var searchendtime = "";
        var identityname = "";
        var identitytype = "";
        var loginuser = "";
        var operationtype = "";

        function searchList() {
            var searchbegtime = document.getElementById("begTime").value;
            var searchendtime = document.getElementById("endTime").value;
            //identityname = document.getElementById("txtIdentityName").value;
            //identitytype = document.getElementById("SelIdentityType").value;
            //loginuser = document.getElementById("txtloginuser").value;
            //operationtype = document.getElementById("seloperationtype").value;

            if (searchbegtime == "") {
                var s = window.parent.parent.GetTextByName("Lang_start_time_can_not_be_empty", window.parent.parent.useprameters.languagedata);
                alert(s);
                return;
            }
            if (searchendtime == "") {
                var s = window.parent.parent.GetTextByName("Lang_end_time_can_not_be_empty", window.parent.parent.useprameters.languagedata);
                alert(s);
                return;
            }
            if (searchbegtime > searchendtime) {
                var s = window.parent.parent.GetTextByName("Lang_end_time_cannot_least_start_time", window.parent.parent.useprameters.languagedata);
                alert(s);
                return;
            }

            currentPage = 1;
            getData();
        }

        //function clearCondition() {
        //    document.getElementById("txtIdentityName").value = "";
        //    document.getElementById("SelIdentityType").value = "";
        //    document.getElementById("txtloginuser").value = "";
        //    document.getElementById("seloperationtype").value = "";
        //    document.getElementById("begTime").value = "";
        //    document.getElementById("endTime").value = "";

        //    searchbegtime = "";
        //    searchendtime = "";
        //    identityname = "";
        //    identitytype = "";
        //    entity = "";
        //    loginuser = "";
        //    operationtype = "";
        //}

        function delBegtime() {
            window.document.getElementById("begTime").value = "";
        }
        function delEndtime() {
            window.document.getElementById("endTime").value = "";
        }

        function delIdentityUnit() {
            window.document.getElementById("txtIdentityUnit").value = "";
        }
        function delDeviceUnit() {
            window.document.getElementById("txtIdentityDeviceUnit").value = "";
        }

        ///判断选择单位
        var selectunit = "";
        ///选择单位赋值
        function selectData(entityid, entityName) {
            if (selectunit == "deviceunit")
                $("#txtIdentityDeviceUnit").val(entityName);
            else
                $("#txtIdentityUnit").val(entityName);
            selectunit = "";
        }

        //弹出窗体
        function OpenEntityWindow(unit) {
            if (unit == "deviceunit")
                selectunit = "deviceunit";
            else
                selectunit = "identityunit";
            visiablebg();
            window.parent.parent.mycallfunction("LogView/Unittree", 230, 230, "0&ifr=LogView/OperationLog_ifr&unit=" + unit, 2002);
        }

        function ShowToolTipTitle(title) {
            var msg = window.parent.parent.GetTextByName(title, window.parent.parent.useprameters.languagedata);
            showToolTip('', msg, event);
        }

        function ShowContent(content) {
            var msg = content;
            showToolTip('', msg, event);
        }

        function visiablebg() {
            var bgObj = window.parent.document.getElementById("bgDiv");
            bgObj.style.width = window.parent.document.body.offsetWidth + "px";
            bgObj.style.height = screen.height + "px";
            bgObj.style.display = "block";
        }

        function checkComments() {
            if ((event.keyCode > 32 && event.keyCode < 48) || (event.keyCode > 57 && event.keyCode < 65) || (event.keyCode > 90 && event.keyCode < 97)) {
                event.returnValue = false;
            }
        }
    </script>
    <script src="../../js/geturl.js" type="text/javascript"></script>
    <script src="../../js/tooltip.js" type="text/javascript"></script>
</body>
</html>
