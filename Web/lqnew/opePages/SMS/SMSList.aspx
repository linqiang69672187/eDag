<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SMSList.aspx.cs" Inherits="Web.lqnew.opePages.SMS.SMSList" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title><%--接收号码--%></title>
    <link href="../../css/lq_manager.css" rel="stylesheet" />
    <link href="../../../CSS/pagestyle.css" rel="stylesheet" />
    <style type="text/css">
        body, .style1
        {
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
            cursor: hand;
        }

        .gridheadcss th
        {
            background-image: url(../images/tab_14.gif);
            height: 25px;
        }

        #GridView1, #GridView12
        {
            margin-top: 3px;
            font-size: 12px;
        }

        .td1td
        {
            background-color: #FFFFFF;
            text-align: right;
        }

        .divgrd
        {
            margin: 2 0 2 0;
            overflow: auto;
            height: 365px;
        }

        #tags
        {
            width: 99px;
        }

        .style3
        {
            width: 37px;
        }
    </style>

    <script src="../../../JQuery/jquery-1.5.2(ture).js" type="text/javascript"></script>
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

    <script type="text/javascript">
        document.onkeypress = function () {

        }
    </script>
    <script type="text/javascript">
        var varreply = window.parent.parent.GetTextByName("Reply", window.parent.parent.useprameters.languagedata);
        var varsend = window.parent.parent.GetTextByName("Send", window.parent.parent.useprameters.languagedata);
        var Lang_loading = window.parent.parent.GetTextByName("Lang_loading", window.parent.parent.useprameters.languagedata);
        var LangNone = window.parent.parent.GetTextByName("Lang-None", window.parent.parent.useprameters.languagedata);
        var Unkown = window.parent.parent.GetTextByName("Unkown", window.parent.parent.useprameters.languagedata);
        var Statusmessage = window.parent.parent.GetTextByName("Statusmessage", window.parent.parent.useprameters.languagedata);
        var SMS = window.parent.parent.GetTextByName("SMS", window.parent.parent.useprameters.languagedata);
        var Receipt = window.parent.parent.GetTextByName("Receipt", window.parent.parent.useprameters.languagedata);
        var UnkownUser = window.parent.parent.GetTextByName("UnkownUser", window.parent.parent.useprameters.languagedata);
        var MessageUnArrive = window.parent.parent.GetTextByName("SM_DESTINATION_NOT_REACHABLE_MESSAGE_DELIVERY_FAILED", window.parent.parent.useprameters.languagedata);
        var DestUnRegister = window.parent.parent.GetTextByName("SM_DESTINATION_NOT_REGISTERED_ON_SYSTEM", window.parent.parent.useprameters.languagedata);
        var typeid = -1;//短信类型 0收件箱、1发件箱
        var arrayid = new Array();
        var everypagecount = 20;
        var currentPage = 1;
        var totalPage = 1;
        var totalCounts = 0;
        var orderby = "down";

        var showSel_PageCount = 10;

        function reloadSel_Page() {

            var sel = document.getElementById("sel_page");
            sel.length = 0;
            sel.style.display = "none";
            var v_FI = 1;
            if (parseInt(currentPage) - parseInt(showSel_PageCount) > 0) {
                v_FI = parseInt(currentPage) - parseInt(showSel_PageCount);
            }
            var v_LI = totalPage;
            if (parseInt(totalPage) > parseInt(currentPage) + parseInt(showSel_PageCount)) {
                v_LI = parseInt(currentPage) + parseInt(showSel_PageCount);
            }


            for (var p = v_FI; p <= v_LI; p++) {
                var option = document.createElement("option");
                option.value = p;
                option.innerHTML = p;
                sel.appendChild(option);
            }
            sel.style.display = "inline";
            sel.value = currentPage;
        }

        function reroadpagetitle() {

            if (totalCounts % everypagecount == 0) {
                totalPage = parseInt(totalCounts / everypagecount);
            } else {
                totalPage = parseInt(totalCounts / everypagecount + 1);
            }
            if (currentPage > totalPage) {
                currentPage = totalPage;
            }
            reloadSel_Page();
            //var sel = document.getElementById("sel_page");

            //if (totalPage < sel.length) {
            //    sel.length = totalPage;
            //} else if (totalPage == sel.length) {

            //} else {
            //    sel.style.display = "none";
            //    for (var p = sel.length + 1; p <= totalPage; p++) {
            //        var option = document.createElement("option");
            //        option.value = p;
            //        option.innerHTML = p;
            //        sel.appendChild(option);
            //    }
            //    sel.style.display = "inline";
            //}

            //sel.value = currentPage;
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
        function openDetail(issi,name,smsType,isgroup) {
            window.parent.parent.mycallfunction("SMS/SMSDetail", "400", "400", "&name=" + encodeURI(name) + "&ISSI=" + issi + "&type=" + smsType+"&isGroup="+isgroup);

        }
        function getData() {
            var txtCondtion = document.getElementById("txtCondtion").value;
            var begtime = document.getElementById("begTime").value;
            var endtime = document.getElementById("endTime").value;
            var txtissi = document.getElementById("txtPople").value;
            for (var i = 0; i < arrayid.length; i++) {
                $("#" + arrayid[i]).remove();
            }
            $("#isprocessing").remove();
            $("#Tbody1").append("<tr id='isprocessing' style='background-color:White;height:22px;color:red'><td colspan='5' >" + Lang_loading + "</td></tr>");
            window.parent.jquerygetNewData_ajax("../../Handlers/GetSMSByTypeID.ashx", { txtissi: txtissi, endtime: endtime, begtime: begtime, PageIndex: currentPage, Limit: everypagecount, typeid: typeid, txtCondtion: txtCondtion, orderby: orderby }, function (msg) {
                $("#isprocessing").remove();
                totalCounts = msg.totalcount;
                reroadpagetitle();
                for (var i = 0; i < arrayid.length; i++) {
                    $("#" + arrayid[i]).remove();
                }
                arrayid.length = 0;

                if (msg.data.length == 0) {
                    $("#Tbody1").append("<tr id='isprocessing' style='background-color:White;height:22px;color:red'><td colspan='5' >" + LangNone + "</td></tr>");
                }
                var msgcontent = "";
                var varissi = "";
                var MYName = "";
                var mytype = "";
                for (var i = 0; i < msg.data.length; i++) {
                    if (msg.data[i].SMSContent.length > 19) {
                        msgcontent = msg.data[i].SMSContent.substring(0, 19) + "...";
                    } else {
                        msgcontent = msg.data[i].SMSContent;
                    }
                    if (typeid == "0") {
                        varissi = msg.data[i].SendISSI;
                    } else if(typeid == 1) {
                        varissi = msg.data[i].RevISSI;
                    }
                    if (msg.data[i].SMSType == '2') {
                        mytype = Statusmessage;
                    } else  {
                        mytype = SMS;
                    }
                    if (msg.data[i].ReturnID != '-1') {
                    
                        mytype = Receipt;
                    }

                    MYName = msg.data[i].Nam;
                    if (msg.data[i].Nam != "") {
                       
                    } else if (msg.data[i].Group_name != "") {
                        MYName = msg.data[i].Group_name;
                    } else if (msg.data[i].IPAddress != "") {
                        MYName = msg.data[i].IPAddress;
                    } else if (msg.data[i].StationName != "") {//xzj--20190227--添加基站短信
                        MYName = msg.data[i].StationName;
                    }else {
                        MYName = UnkownUser;
                    }

                    if (msg.data[i].IsGroup == "1") {
                        if (msg.data[i].SMSType == '2') {
                            if (msg.data[i].SMSMsg == MessageUnArrive || msg.data[i].SMSMsg == DestUnRegister)
                                $("#Tbody1").append("<tr id=" + msg.data[i].ID + " onmouseover='changeTgBg(this,&#39;font&#39;)' onmouseout='overchangeTgBg(this,&#39;font&#39;)' style='background-color:White;height:22px;'><td style='width:60px;color:red;cursor: pointer;'  align='center' onclick='window.parent.parent.mycallfunction(\"Send_StatusMS\",\"380\",400,\"&gssi=" + varissi + "&cmd=GR&name=" + encodeURI(MYName) + "\")'> " + "! " + varreply + "</td><td style='width:100px'  align='center'>" + mytype + "</td><td style='width:140px;cursor: pointer;color:blue;text-decoration-line: underline' onclick='openDetail(\"" + varissi + "\",\"" + MYName + "\",\"" + msg.data[i].SMSType + "\",\"" + msg.data[i].IsGroup + "\")'  align='center'>" + MYName + "(" + varissi + ")" + "</td><td style='width:240px' title='" + msg.data[i].SMSContent + "'  align='left'>&nbsp;&nbsp;" + msgcontent + "</td><td style='width:140px'  align='center'>" + msg.data[i].SendTime + "</td></tr>");
                            else
                                $("#Tbody1").append("<tr id=" + msg.data[i].ID + " onmouseover='changeTgBg(this,&#39;font&#39;)' onmouseout='overchangeTgBg(this,&#39;font&#39;)' style='background-color:White;height:22px;'><td style='width:60px;color:black;cursor: pointer;'  align='center' onclick='window.parent.parent.mycallfunction(\"Send_StatusMS\",\"380\",400,\"&gssi=" + varissi + "&cmd=GR&name=" + encodeURI(MYName) + "\")'> " + varreply + "</td><td style='width:100px'  align='center'>" + mytype + "</td><td style='width:140px;cursor: pointer;color:blue;text-decoration-line: underline' onclick='openDetail(\"" + varissi + "\",\"" + MYName + "\",\"" + msg.data[i].SMSType + "\",\"" + msg.data[i].IsGroup + "\")'  align='center'>" + MYName + "(" + varissi + ")" + "</td><td style='width:240px' title='" + msg.data[i].SMSContent + "'  align='left'>&nbsp;&nbsp;" + msgcontent + "</td><td style='width:140px'  align='center'>" + msg.data[i].SendTime + "</td></tr>");
                        }
                        else {
                            if (msg.data[i].SMSMsg == MessageUnArrive || msg.data[i].SMSMsg == DestUnRegister)
                                $("#Tbody1").append("<tr id=" + msg.data[i].ID + " onmouseover='changeTgBg(this,&#39;font&#39;)' onmouseout='overchangeTgBg(this,&#39;font&#39;)' style='background-color:White;height:22px;'><td style='width:60px;color:red;cursor: pointer;'  align='center' onclick='window.parent.parent.mycallfunction(\"Send_SMS\",\"380\",400,\"&gssi=" + varissi + "&cmd=GR&name=" + encodeURI(MYName) + "\")'> " + "! " + varreply + "</td><td style='width:100px'  align='center'>" + mytype + "</td><td style='width:140px;cursor: pointer;color:blue;text-decoration-line: underline' onclick='openDetail(\"" + varissi + "\",\"" + MYName + "\",\"" + msg.data[i].SMSType + "\",\"" + msg.data[i].IsGroup + "\")'  align='center'>" + MYName + "(" + varissi + ")" + "</td><td style='width:240px' title='" + msg.data[i].SMSContent + "'  align='left'>&nbsp;&nbsp;" + msgcontent + "</td><td style='width:140px'  align='center'>" + msg.data[i].SendTime + "</td></tr>");
                            else
                                $("#Tbody1").append("<tr id=" + msg.data[i].ID + " onmouseover='changeTgBg(this,&#39;font&#39;)' onmouseout='overchangeTgBg(this,&#39;font&#39;)' style='background-color:White;height:22px;'><td style='width:60px;color:black;cursor: pointer;'  align='center' onclick='window.parent.parent.mycallfunction(\"Send_SMS\",\"380\",400,\"&gssi=" + varissi + "&cmd=GR&name=" + encodeURI(MYName) + "\")'> " + varreply + "</td><td style='width:100px'  align='center'>" + mytype + "</td><td style='width:140px;cursor: pointer;color:blue;text-decoration-line: underline' onclick='openDetail(\"" + varissi + "\",\"" + MYName + "\",\"" + msg.data[i].SMSType + "\",\"" + msg.data[i].IsGroup + "\")'  align='center'>" + MYName + "(" + varissi + ")" + "</td><td style='width:240px' title='" + msg.data[i].SMSContent + "'  align='left'>&nbsp;&nbsp;" + msgcontent + "</td><td style='width:140px'  align='center'>" + msg.data[i].SendTime + "</td></tr>");

                            }
                    }
                    else {
                        if (msg.data[i].StationName != "") {//xzj--20190227--添加基站短信
                            if (msg.data[i].SMSType == '2') {//基站不存在状态消息
                                if (msg.data[i].SMSMsg == MessageUnArrive || msg.data[i].SMSMsg == DestUnRegister)
                                    $("#Tbody1").append("<tr id=" + msg.data[i].ID + " onmouseover='changeTgBg(this,&#39;font&#39;)' onmouseout='overchangeTgBg(this,&#39;font&#39;)' style='background-color:White;height:22px;'><td style='width:60px;color:red;cursor: pointer;'  align='center' onclick='window.parent.parent.mycallfunction(\"Send_StatusMS\",\"380\",400,\"&gssi=" + varissi + "&cmd=GR&name=" + encodeURI(MYName) + "\")'> " + "! " + varreply + "</td><td style='width:100px'  align='center'>" + mytype + "</td><td style='width:140px;cursor: pointer;color:blue;text-decoration-line: underline' onclick='openDetail(\"" + varissi + "\",\"" + MYName + "\",\"" + msg.data[i].SMSType + "\",\"" + msg.data[i].IsGroup + "\")'  align='center'>" + MYName + "(" + varissi + ")" + "</td><td style='width:240px' title='" + msg.data[i].SMSContent + "'  align='left'>&nbsp;&nbsp;" + msgcontent + "</td><td style='width:140px'  align='center'>" + msg.data[i].SendTime + "</td></tr>");
                                else
                                    $("#Tbody1").append("<tr id=" + msg.data[i].ID + " onmouseover='changeTgBg(this,&#39;font&#39;)' onmouseout='overchangeTgBg(this,&#39;font&#39;)' style='background-color:White;height:22px;'><td style='width:60px;color:black;cursor: pointer;'  align='center' onclick='window.parent.parent.mycallfunction(\"Send_StatusMS\",\"380\",400,\"&gssi=" + varissi + "&cmd=GR&name=" + encodeURI(MYName) + "\")'> " + varreply + "</td><td style='width:100px'  align='center'>" + mytype + "</td><td style='width:140px;cursor: pointer;color:blue;text-decoration-line: underline' onclick='openDetail(\"" + varissi + "\",\"" + MYName + "\",\"" + msg.data[i].SMSType + "\",\"" + msg.data[i].IsGroup + "\")'  align='center'>" + MYName + "(" + varissi + ")" + "</td><td style='width:240px' title='" + msg.data[i].SMSContent + "'  align='left'>&nbsp;&nbsp;" + msgcontent + "</td><td style='width:140px'  align='center'>" + msg.data[i].SendTime + "</td></tr>");
                            }
                            else {
                                var bsISSIAndSwitchID = varissi.split(/[()]/);
                                var bsISSI = bsISSIAndSwitchID[0];
                                var switchID = bsISSIAndSwitchID[1];
                                if (msg.data[i].SMSMsg == MessageUnArrive || msg.data[i].SMSMsg == DestUnRegister)
                                    $("#Tbody1").append("<tr id=" + msg.data[i].ID + " onmouseover='changeTgBg(this,&#39;font&#39;)' onmouseout='overchangeTgBg(this,&#39;font&#39;)' style='background-color:White;height:22px;'><td style='width:60px;color:red;cursor: pointer;'  align='center' onclick='window.parent.parent.mycallfunction(\"Send_SMS\",\"380\",400,\"&gssi=" + varissi + "&cmd=GR&name=" + encodeURI(MYName) + "\")'> " + "! " + varreply + "</td><td style='width:100px'  align='center'>" + mytype + "</td><td style='width:140px;cursor: pointer;color:blue;text-decoration-line: underline' onclick='openDetail(\"" + varissi + "\",\"" + MYName + "\",\"" + msg.data[i].SMSType + "\",\"" + msg.data[i].IsGroup + "\")'  align='center'>" + MYName + "(" + varissi + ")" + "</td><td style='width:240px' title='" + msg.data[i].SMSContent + "'  align='left'>&nbsp;&nbsp;" + msgcontent + "</td><td style='width:140px'  align='center'>" + msg.data[i].SendTime + "</td></tr>");
                                else
                                    $("#Tbody1").append("<tr id=" + msg.data[i].ID + " onmouseover='changeTgBg(this,&#39;font&#39;)' onmouseout='overchangeTgBg(this,&#39;font&#39;)' style='background-color:White;height:22px;'><td style='width:60px;color:black;cursor: pointer;'  align='center' onclick='window.parent.parent.mycallfunction(\"Send_SMS\",\"380\",400,\"" + bsISSI + "&switchID=" + switchID + "&cmd=BSISSI&name=" + encodeURI(MYName) + "\")'> " + varreply + "</td><td style='width:100px'  align='center'>" + mytype + "</td><td style='width:140px;cursor: pointer;color:blue;text-decoration-line: underline' onclick='openDetail(\"" + varissi + "\",\"" + MYName + "\",\"" + msg.data[i].SMSType + "\",\"" + msg.data[i].IsGroup + "\")'  align='center'>" + MYName + "(" + varissi + ")" + "</td><td style='width:240px' title='" + msg.data[i].SMSContent + "'  align='left'>&nbsp;&nbsp;" + msgcontent + "</td><td style='width:140px'  align='center'>" + msg.data[i].SendTime + "</td></tr>");

                        }
                    }
                    else {
                        if (msg.data[i].SMSType == '2') {
                            if (msg.data[i].SMSMsg == MessageUnArrive || msg.data[i].SMSMsg == DestUnRegister)
                                $("#Tbody1").append("<tr id=" + msg.data[i].ID + " onmouseover='changeTgBg(this,&#39;font&#39;)' onmouseout='overchangeTgBg(this,&#39;font&#39;)' style='background-color:White;height:22px;'><td style='width:60px;color:red;cursor: pointer;'  align='center' onclick='window.parent.parent.mycallfunction(\"Send_StatusMS\",\"380\",400,\"&cmd=ISSI&issi=" + varissi + "&name=" + encodeURI(MYName) + "\")'> " + "! " + varreply + "</td><td style='width:100px'  align='center'>" + mytype + "</td><td style='width:140px;cursor: pointer;color:blue;text-decoration-line: underline' onclick='openDetail(\"" + varissi + "\",\"" + MYName + "\",\"" + msg.data[i].SMSType + "\",\"" + msg.data[i].IsGroup + "\")'  align='center'>" + MYName + "(" + varissi + ")" + "</td><td style='width:240px' title='" + msg.data[i].SMSContent + "'  align='left'>&nbsp;&nbsp;" + msgcontent + "</td><td style='width:140px'  align='center'>" + msg.data[i].SendTime + "</td></tr>");
                            else
                                $("#Tbody1").append("<tr id=" + msg.data[i].ID + " onmouseover='changeTgBg(this,&#39;font&#39;)' onmouseout='overchangeTgBg(this,&#39;font&#39;)' style='background-color:White;height:22px;'><td style='width:60px;color:black;cursor: pointer;'  align='center' onclick='window.parent.parent.mycallfunction(\"Send_StatusMS\",\"380\",400,\"&cmd=ISSI&issi=" + varissi + "&name=" + encodeURI(MYName) + "\")'> " + varreply + "</td><td style='width:100px'  align='center'>" + mytype + "</td><td style='width:140px;cursor: pointer;color:blue;text-decoration-line: underline' onclick='openDetail(\"" + varissi + "\",\"" + MYName + "\",\"" + msg.data[i].SMSType + "\",\"" + msg.data[i].IsGroup + "\")'  align='center'>" + MYName + "(" + varissi + ")" + "</td><td style='width:240px' title='" + msg.data[i].SMSContent + "'  align='left'>&nbsp;&nbsp;" + msgcontent + "</td><td style='width:140px'  align='center'>" + msg.data[i].SendTime + "</td></tr>");
                        }
                        else {
                            if (msg.data[i].SMSMsg == MessageUnArrive || msg.data[i].SMSMsg == DestUnRegister)
                                $("#Tbody1").append("<tr id=" + msg.data[i].ID + " onmouseover='changeTgBg(this,&#39;font&#39;)' onmouseout='overchangeTgBg(this,&#39;font&#39;)' style='background-color:White;height:22px;'><td style='width:60px;color:red;cursor: pointer;'  align='center' onclick='window.parent.parent.mycallfunction(\"Send_SMS\",\"380\",400,\"&cmd=ISSI&issi=" + varissi + "&name=" + encodeURI(MYName) + "\")'> " + "! " + varreply + "</td><td style='width:100px'  align='center'>" + mytype + "</td><td style='width:140px;cursor: pointer;color:blue;text-decoration-line: underline' onclick='openDetail(\"" + varissi + "\",\"" + MYName + "\",\"" + msg.data[i].SMSType + "\",\"" + msg.data[i].IsGroup + "\")'  align='center'>" + MYName + "(" + varissi + ")" + "</td><td style='width:240px' title='" + msg.data[i].SMSContent + "'  align='left'>&nbsp;&nbsp;" + msgcontent + "</td><td style='width:140px'  align='center'>" + msg.data[i].SendTime + "</td></tr>");
                            else
                                $("#Tbody1").append("<tr id=" + msg.data[i].ID + " onmouseover='changeTgBg(this,&#39;font&#39;)' onmouseout='overchangeTgBg(this,&#39;font&#39;)' style='background-color:White;height:22px;'><td style='width:60px;color:black;cursor: pointer;'  align='center' onclick='window.parent.parent.mycallfunction(\"Send_SMS\",\"380\",400,\"&cmd=ISSI&issi=" + varissi + "&name=" + encodeURI(MYName) + "\")'> " + varreply + "</td><td style='width:100px'  align='center'>" + mytype + "</td><td style='width:140px;cursor: pointer;color:blue;text-decoration-line: underline' onclick='openDetail(\"" + varissi + "\",\"" + MYName + "\",\"" + msg.data[i].SMSType + "\",\"" + msg.data[i].IsGroup + "\")'  align='center'>" + MYName + "(" + varissi + ")" + "</td><td style='width:240px' title='" + msg.data[i].SMSContent + "'  align='left'>&nbsp;&nbsp;" + msgcontent + "</td><td style='width:140px'  align='center'>" + msg.data[i].SendTime + "</td></tr>");

                        }
                    }
                }

                    arrayid.push(msg.data[i].ID);
                }
            });
        }
        document.onkeypress = function () {
            if (event.keyCode == 13) {
                event.keyCode = 0;
                event.returnValue = false;
                searchList();
            }
        }
        function searchList() {
            currentPage = 1;
            getData();
        }
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
           // document.getElementById("sel_page").value = currentPage;
        }
        function prePage() {
            if (currentPage <= 1) {
                return;
            }
            currentPage--;
            getData();
           // document.getElementById("sel_page").value = currentPage;
        }
        function firstPage() {
            if (currentPage == 1) {
                return;
            }
            currentPage = 1;
            getData();
            //document.getElementById("sel_page").value = currentPage;
        }
        function lastPage() {
            if (currentPage == totalPage) {
                return;
            }
            currentPage = totalPage;
            getData();
           // document.getElementById("sel_page").value = currentPage;
        }
        function tzpage() {

            var sel = document.getElementById("sel_page").value;

            if (sel == currentPage) {
                return;
            }
            currentPage = sel;
            getData();
            //document.getElementById("sel_page").value = currentPage;
        }




        function onpresskey() {
            if (event.keyCode == 13) {

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
            if (Request.QueryString("selfclose") != undefined) {
                window.parent.hiddenbg2();
            }
            window.parent.lq_closeANDremovediv('SMS/SMSList', 'bgDiv');
        }


        var dragEnable = 'True';
        function dragdiv() {
            var div1 = window.parent.document.getElementById('SMS/SMSList');
            if (div1 && event.button == 0 && dragEnable == 'True') {
                window.parent.mystartDragWindow(div1, null, event); div1.style.border = "solid 0px transparent"; window.parent.cgzindex(div1);

            }
        }
        function mydragWindow() {
            var div1 = window.parent.document.getElementById('SMS/SMSList');
            if (div1) {
                window.parent.mydragWindow(div1, event);
            }
        }

        function mystopDragWindow() {
            var div1 = window.parent.document.getElementById('SMS/SMSList');
            if (div1) {
                window.parent.mystopDragWindow(div1); div1.style.border = "0px";
            }
        }

        window.onload = function () {
            //getData();
            window.document.getElementById("divClose").style.display = "inline";
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
            document.onmousedown = function () {
                var div1 = window.parent.document.getElementById('SMS/SMSList');
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
        document.onkeypress = function () {
            if (event.keyCode == 13) {
                event.keyCode = 0;
                event.returnValue = false;
                searchList();
            }
        }



        function selEntityTitle(title) {
            window.document.getElementById("selEntityTitle").innerHTML = title;
        }

        var varfjr = window.parent.parent.GetTextByName("Lang_SENDMSGPeople", window.parent.parent.useprameters.languagedata);
        var varsjr = window.parent.parent.GetTextByName("Lang_RevMSGPeople", window.parent.parent.useprameters.languagedata);
        var myReply = window.parent.parent.GetTextByName("Reply", window.parent.parent.useprameters.languagedata);
        var myid;
        function OnclickTree(obj, ytypeid) {
            obj.style.color = "red";
            if (document.getElementById(myid) && obj.id != myid) {
                document.getElementById(myid).style.color = "black";
            }
            myid = obj.id;
            if (typeid == ytypeid) {
                return;
            }
            typeid = ytypeid;
            clearCondtion();
            if (ytypeid == '0') {
                varreply = myReply;
                window.document.getElementById("Reply").innerHTML = myReply
                window.document.getElementById("Lang_SENDMSGPeople").innerHTML = varfjr;
                window.document.getElementById("Lang_RevMSGPeople1").innerHTML = varfjr;
            } else if (ytypeid == "1") {
                varreply = varsend;
                window.document.getElementById("Reply").innerHTML = varsend
                window.document.getElementById("Lang_SENDMSGPeople").innerHTML = varsjr;
                window.document.getElementById("Lang_RevMSGPeople1").innerHTML = varsjr;
            }
            currentPage = 1;
            getData();
        }
        var searchContent = "";
        var searchbegtime = "";
        var searchendtime = "";
        var searchtxtissi = "";
        function searchList() {
            if (window.document.getElementById("txtCondtion").value == searchContent && searchbegtime == document.getElementById("begTime").value && searchendtime == document.getElementById("endTime").value && searchtxtissi == document.getElementById("txtPople").value) {
                return;
            } else {
                searchContent = window.document.getElementById("txtCondtion").value;
                searchbegtime = document.getElementById("begTime").value;
                searchendtime = document.getElementById("endTime").value;
                searchtxtissi = document.getElementById("txtPople").value;
            }
            currentPage = 1;
            getData();
        }
        function clearCondtion() {
            window.document.getElementById("txtCondtion").value = "";
            document.getElementById("begTime").value = "";
            document.getElementById("endTime").value = "";
            document.getElementById("txtPople").value = "";
            searchContent = "";
            searchbegtime = "";
            searchendtime = "";
            searchtxtissi = "";
        }
        function orderbyfun() {
            if (orderby == "down") {
                orderby = "up";
            } else {
                orderby = "down";
            }
            currentPage = 1;
            getData();
        }
        function delBegtime() {
            window.document.getElementById("begTime").value = "";
        }
        function delEndtime() {
            window.document.getElementById("endTime").value = "";
        }
    </script>
    <script src="../../js/geturl.js" type="text/javascript"></script>
</head>
<body>
    <form id="form1" runat="server">

        <table class="style1" cellpadding="0" cellspacing="0">
            <tr style="height: 5px;" id="derppp">
                <td class="style2">
                   <img src="../../images/tab_03.png" width="15" height="32" /></td>
                 <td background="../../images/tab_05.gif">
                     <div id="Lang_smsmail" style="display: inline; float: left; text-align: left; width: 30%; color: white"><%--短信收发件箱--%></div>
                    <div id="divClose" style="display: none" onmouseover="Divover('on')" onclick="closethispage()" onmouseout="Divover('out')"></div>
                     </td>
                <td class="style2">
                     <img src="../../images/tab_07.png" width="14" height="32" /></td>
            </tr>
            <tr>
                <td width="15" background="../../images/tab_12.gif">&nbsp;
                                </td>
                <td class="bg4" id="dragtd">
                    <table cellpadding="0" cellspacing="0" align="left" class="style3">
                        <tr>
                            <td valign="top" align="left" style="background-color: white">
                                <table id="tb1" align="center" valign="top" runat="server" border="0" cellpadding="0" cellspacing="1" width="150px">
                                    <tr>
                                        <td align="left">
                                            <asp:TreeView runat="server" ID="tv_SMS"></asp:TreeView>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td>&nbsp;<br />
                                <br />
                                &nbsp;</td>
                            <td>
                                <table id="Table1" align="left" bgcolor="#c0de98" runat="server" border="0" cellpadding="0" cellspacing="1" width="700px" height="435px">
                                    <tr>
                                        <td align="left" valign="top" style="background-color: white" id="dragtd">
                                            <table style="width: 685px; font-size: 12px">
                                                <tr>

                                                    <td align="right" colspan="2">
                                                        <span id="Lang_BegTime">开始时间</span>
                                                        <input readonly="readonly" type="text" style="width: 80px; ime-mode: disabled" id="begTime" class="Wdate" onfocus=""><img onclick="delBegtime()" src="../../images/close.png" />
                                                        <span id="Lang_EndTime">技术时间</span>
                                                        <input readonly="readonly" type="text" style="width: 80px;" id="endTime" class="Wdate" onfocus=""><img onclick="delEndtime()" src="../../images/close.png" />
                                                        <%-- <span id="btnShowALLCheck" style="cursor:pointer"></span>--%>
                                                        <span id="dxnr">短信内容</span>
                                                        <input id="txtCondtion" style="width:80px" type="text" />
                                                          <span id="Lang_RevMSGPeople1">发件人</span>
                                                        <input id="txtPople" style="width:80px" type="text" />
                                                        <img id="btnSearch" style="cursor: pointer" onclick="searchList()" />
                                                    </td>

                                                </tr>
                                                <tr>


                                                    <td align="right" colspan="2">
                                                      
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="left" colspan="1">
                                                        <span onclick="firstPage()" class="YangdjPageStyle" id="Lang_FirstPage">首页</span>&nbsp;&nbsp;<span onclick="prePage()" class="YangdjPageStyle" id="Lang_PrePage">上一页</span>&nbsp;&nbsp;<span onclick="nextPage()" class="YangdjPageStyle" id="Lang_play_next_page">下一页</span>&nbsp;&nbsp;<span onclick="lastPage()" class="YangdjPageStyle" id="Lang_LastPage">尾页</span>
                                                        <select onchange="tzpage()" id="sel_page"></select>
                                                    </td>
                                                    <td align="right" colspan="1"><span id="span_page"></span>&nbsp;&nbsp;<span id="span_currentPage"></span>/<span id="span_totalpage"></span>&nbsp;&nbsp;&nbsp;<span id="span_Article"></span>&nbsp;&nbsp;<span id="span_currentact"></span>/<span id="span_total"></span></td>
                                                </tr>
                                            </table>

                                            <table cellspacing="1" cellpadding="0" id="GridView1" style="background-color: #C0DE98; border-color: White; border-width: 0px; border-style: Ridge; width: 683px; font-size: 12px">
                                                <tr class="gridheadcss">

                                                    <th align="center" style="width: 60px; background-color: ActiveBorder">
                                                        <span id="Reply"></span></th>
                                                    <th align="center" style="width: 100px; background-color: ActiveBorder"><b><span style="font-size: 14px; color: darkgreen" id="Lang_style">发件人</span></b></th>
                                                    <th align="center" style="width: 140px; background-color: ActiveBorder"><b><span style="font-size: 14px; color: darkgreen" id="Lang_SENDMSGPeople">发件人</span></b></th>
                                                    <th align="center" style="width: 240px; background-color: ActiveBorder"><b><span style="font-size: 14px; color: darkgreen" id="Lang_MSGContext">内容</span></b></th>
                                                    <th align="center" style="width: 140px; background-color: ActiveBorder"><b><span onclick="orderbyfun()" style="cursor: pointer; font-size: 14px; color: darkgreen; text-decoration-line: underline" id="Lang_SendMSGTIME">发送时间</span></b></th>

                                                </tr>

                                            </table>
                                            <div id="div_selectUserList" style="position: relative; font-size: 12px; top: 0px; width: 700px; height: 340px; background-color: azure; overflow-y: scroll">
                                                <table cellspacing="1" cellpadding="0" id="GridView12" style="background-color: #C0DE98; border-color: White; border-width: 0px; border-style: Ridge; width: 100%; top: 0px">
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
                 <td width="14" background="../../images/tab_16.gif">&nbsp;
                                </td>
            </tr>

            <tr style="height: 15px;">
                <td>
                    <img src="../../images/tab_20.png" width="15" height="15" /></td>
                <td background="../../images/tab_21.gif">
                                  
                                </td>
                <td>
                      <img src="../../images/tab_22.png" width="14" height="15" /></td>
            </tr>
        </table>
    </form>
</body>
    <script>
       
    </script>
</html>
<script>
    window.parent.closeprossdiv();
    LanguageSwitch(window.parent.parent);

    var Lang_Search22 = "../" + window.parent.parent.GetTextByName("Lang_Search2", window.parent.parent.useprameters.languagedata);
    var Lang_Search2_un = "../" + window.parent.parent.GetTextByName("Lang_Search2_un", window.parent.parent.useprameters.languagedata);
    var Lang_Search2 = window.document.getElementById("btnSearch");
    Lang_Search2.onmousedown = function () {
        Lang_Search2.src = Lang_Search2_un;
    }
    Lang_Search2.onmouseup = function () {
        Lang_Search2.src = Lang_Search22;

    }
    Lang_Search2.setAttribute("src", Lang_Search22);

    window.document.getElementById("Lang_smsmail").innerHTML = window.parent.parent.GetTextByName("Lang_DXSJX", window.parent.parent.useprameters.languagedata);
    window.document.getElementById("Lang_RevMSGPeople1").innerHTML = varfjr;
    window.document.getElementById("dxnr").innerHTML = window.parent.parent.GetTextByName("Lang_MSGContext", window.parent.parent.useprameters.languagedata);
    window.document.getElementById("Reply").innerHTML = varreply;
    window.document.getElementById("span_page").innerHTML = window.parent.parent.GetTextByName("Page", window.parent.parent.useprameters.languagedata);
    window.document.getElementById("span_Article").innerHTML = window.parent.parent.GetTextByName("Article", window.parent.parent.useprameters.languagedata);

    
</script>
