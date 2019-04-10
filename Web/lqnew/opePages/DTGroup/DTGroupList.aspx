<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DTGroupList.aspx.cs" Inherits="Web.lqnew.opePages.DTGroup.DTGroupList" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
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
        
        .button-blue {
            height:22px;
            text-align:center;
            border-radius:5px;
            border:1px solid #000000;
            box-shadow:inset 0px 5px 4px #808492;
            background-color:#003D53;
            color:white;
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

    <script type="text/javascript">
        document.onkeypress = function () {

        }
    </script>


    <script type="text/javascript">
        var Lang_AddCZFaild = window.parent.parent.GetTextByName("Lang_AddCZFaild", window.parent.parent.useprameters.languagedata);
        var Lang_AddCZSuccess = window.parent.parent.GetTextByName("Lang_AddCZSuccess", window.parent.parent.useprameters.languagedata);
        var Lang_AddCZUn = window.parent.parent.GetTextByName("Lang_AddCZUn", window.parent.parent.useprameters.languagedata);
        var Lang_loading = window.parent.parent.GetTextByName("Lang_loading", window.parent.parent.useprameters.languagedata);
        var LangNone = window.parent.parent.GetTextByName("Lang-None", window.parent.parent.useprameters.languagedata);
        var Unkown = window.parent.parent.GetTextByName("Unkown", window.parent.parent.useprameters.languagedata);
        var BeSureToDelete = window.parent.parent.GetTextByName("BeSureToDelete", window.parent.parent.useprameters.languagedata);
        var Lang_DTCZISDoing = window.parent.parent.GetTextByName("Lang_DTCZISDoing", window.parent.parent.useprameters.languagedata);
        var Lang_DTCZIsSendingPleaseSeeSysLogWindow = window.parent.parent.GetTextByName("Lang_DTCZIsSendingPleaseSeeSysLogWindow", window.parent.parent.useprameters.languagedata);
        var Lang_DTCZIsNotSendingPleaseSeeSysLogWindow = window.parent.parent.GetTextByName("Lang_DTCZIsNotSendingPleaseSeeSysLogWindow", window.parent.parent.useprameters.languagedata);
        var BeSureToADDCZ = window.parent.parent.GetTextByName("BeSureToADDCZ", window.parent.parent.useprameters.languagedata);
        var BeSureToDelCZ = window.parent.parent.GetTextByName("BeSureToDelCZ", window.parent.parent.useprameters.languagedata);

        var arrayISSI = new Array();
        var everypagecount = 20;
        var currentPage = 1;
        var totalPage = 1;
        var totalCounts = 0;
        var Span_Statues = "";
        var whereISSI = "";
        var whereStatues = "-1";

        var selentityid = "";
        var selissiorname = "";
        var selfun = "";
        var selStatues = "";
        var begtime = "";
        var endtime = "";
        var typeid = 0;
        var GSSI = "";
        var myid;

        function selectReset() {
            document.getElementById("txt_MemberNo").value = "";
            document.getElementById("selFunc").selectedIndex = 0;
        }

        function deleteToDb() {
            var paintpolice_length = CheckMember.length;
            if (paintpolice_length == 0) {
                alert(window.parent.parent.GetTextByName("Lang_all_searchoption", window.parent.parent.useprameters.languagedata));
                return;
            }
            if (!confirm(BeSureToDelete + "?")) {
                return;
            }
            var sid = "";
            
            for (var i = 0; i < paintpolice_length; i++) {
                sid += CheckMember[i] + ";";
            }
            window.parent.jquerygetNewData_ajax("../../Handlers/DeleteDTGMemberToDb.ashx", { sids: sid, dtgroupid: typeid }, function (msg) {
                alert(msg.result);
                searchList();
            });
        }
        function toAddCZ() {
            var paintpolice_length = CheckMember.length;
            if (paintpolice_length == 0) {
                alert(window.parent.parent.GetTextByName("Lang_all_searchoption", window.parent.parent.useprameters.languagedata));
                return;
            }
            if (window.parent.useprameters.callActivexable == false) {
                alert(window.parent.parent.GetTextByName("Alert_OcxUnLoad", window.parent.parent.useprameters.languagedata));//控件未加载，短信功能不可用
                return;
            }
            if (window.parent.isSendingDTCX) {
                alert(Lang_DTCZISDoing);
               
                return;
            }
            if (!confirm(BeSureToADDCZ + "?")) {
                return;
            }
           
            //alert(Lang_DTCZIsSendingPleaseSeeSysLogWindow);
            window.parent.SendAddMemberToDTGroup(GSSI, CheckMember);
            if (window.parent.document.frames["DTGroup/ResultList_ifr"] != null || window.parent.document.frames["DTGroup/ResultList_ifr"] != undefined) {
                window.parent.document.frames["DTGroup/ResultList_ifr"].tohidclosebtn();
            } else {
                window.parent.mycallfunction('DTGroup/ResultList', 450, 250);
            }
            closethispage();
        }
        function toDelCZ() {
            var paintpolice_length = CheckMember.length;
            if (paintpolice_length == 0) {
                alert(window.parent.parent.GetTextByName("Lang_all_searchoption", window.parent.parent.useprameters.languagedata));
                return;
            }
            if (window.parent.useprameters.callActivexable == false) {
                alert(window.parent.parent.GetTextByName("Alert_OcxUnLoad", window.parent.parent.useprameters.languagedata));//控件未加载，短信功能不可用
                return;
            }
            if (window.parent.isSendingDTCX) {
                alert(Lang_DTCZISDoing);

                return;
            }
            if (!confirm(BeSureToDelCZ + "?")) {
                return;
            }
           
           // alert(Lang_DTCZIsNotSendingPleaseSeeSysLogWindow);
            window.parent.SendDelMemberFromDTGroup(GSSI, CheckMember);
            if (window.parent.document.frames["DTGroup/ResultList_ifr"] != null || window.parent.document.frames["DTGroup/ResultList_ifr"] != undefined) {
                window.parent.document.frames["DTGroup/ResultList_ifr"].tohidclosebtn();
            } else {
                window.parent.mycallfunction('DTGroup/ResultList', 450, 250);
            }
            closethispage();
        }
        function OnclickTree(obj, ytypeid, gssi) {
            obj.style.color = "red";
            if (document.getElementById(myid) && obj.id != myid) {
                document.getElementById(myid).style.color = "black";
            }
            myid = obj.id;
            if (typeid == ytypeid) {
                return;
            }
            selectReset();
            whereStatues = document.getElementById("selFunc").value;
            whereISSI = document.getElementById("txt_MemberNo").value;
            CheckMember.length = 0;
            typeid = ytypeid;
            GSSI = gssi;
            currentPage = 1;
            getData();
        }
        window.onload = function () {

            window.document.getElementById("divClose").style.display = "inline";

            document.onmousedown = function () {
                var div1 = window.parent.document.getElementById('DTGroup/DTGroupList');
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
        function getData() {


            for (var i = 0; i < arrayISSI.length; i++) {
                $("#" + arrayISSI[i]).remove();
            }
            $("#isprocessing").remove();

            $("#Tbody1").append("<tr id='isprocessing' style='background-color:White;height:22px;color:red'><td colspan='7' >" + Lang_loading + "</td></tr>");
            window.parent.jquerygetNewData_ajax("../../Handlers/GetDTG_Member.ashx", { issi: whereISSI, statues: whereStatues, PageIndex: currentPage, Limit: everypagecount, dtgroupid: typeid }, function (msg) {
                $("#isprocessing").remove();
                totalCounts = msg.totalcount;
                if (totalCounts == 0) {
                    $("#selthisPageAll").css("display", "none");
                    $("#checkAll").css("display", "none");
                } else {
                    $("#selthisPageAll").css("display", "inline");
                    $("#checkAll").css("display", "inline");
                }

                reroadpagetitle();
                for (var i = 0; i < arrayISSI.length; i++) {
                    $("#" + arrayISSI[i]).remove();
                }
                arrayISSI.length = 0;

                if (msg.data.length == 0) {
                    $("#Tbody1").append("<tr id='isprocessing' style='background-color:White;height:22px;color:red'><td colspan='7' >" + LangNone + "</td></tr>");
                }


                for (var i = 0; i < msg.data.length; i++) {
                    var strcheck = "";

                    for (var j = 0; j < CheckMember.length; j++) {
                        if (CheckMember[j] == msg.data[i].Memb_ISSI) {
                            strcheck = " checked = 'checked'";
                        }
                    }

                    if (msg.data[i].Status == "1") {
                        Span_Statues = "<span>" + Lang_AddCZSuccess + "</span>";
                    } else if (msg.data[i].Status == "0") {
                        Span_Statues = "<span>" + Lang_AddCZFaild + "</span>";
                    } else if (msg.data[i].Status == "2") {
                        Span_Statues = "<span>" + Lang_AddCZUn + "</span>";
                    }

                    $("#Tbody1").append("<tr id=" + msg.data[i].ID + " onmouseover='changeTgBg(this,&#39;font&#39;)' onmouseout='overchangeTgBg(this,&#39;font&#39;)' style='background-color:White;height:22px;'><td align='center' style=\"width: 30px\"><input id='checkbox_" + msg.data[i].Memb_ISSI + "' type='checkbox' " + strcheck + " onclick='onclickCheckBoxp(this)' value='" + msg.data[i].Memb_ISSI + "' /></td><td style='width:140px;'  align='center' onclick=''> " + msg.data[i].Memb_ISSI + "</td><td style='width:140px'  align='center'>" + Span_Statues + "</td><td style='width:140px'  align='center'>" + msg.data[i].CreateTime + "</td></tr>");
                    arrayISSI.push(msg.data[i].ID);
                }
                tocheckall();
            });
        }

        var CheckMember = new Array();

        function clearCheckMember() {
            CheckMember.length = 0;
            uncheckall();
        }

        function addMemberToChecked(id) {
            CheckMember.push(id);
        }
        function removeMemberToChecked(id) {

            for (var i = 0; i < CheckMember.length; i++) {
                if (CheckMember[i] == id) {

                    CheckMember.splice(i, 1);
                    break;
                }
            }
        }

        function paramclick() {
            if (window.parent.useprameters.callActivexable == false) {
                alert(window.parent.parent.GetTextByName("Alert_OcxUnLoad", window.parent.parent.useprameters.languagedata));//控件未加载，短信功能不可用
                return;
            }
            var sid = "";
            var paintpolice_length = CheckMember.length;
            for (var i = 0; i < paintpolice_length; i++) {
                sid += CheckMember[i] + ";";
            }
            GPSContral(sid);
        }
        function openclick() {
            if (window.parent.useprameters.callActivexable == false) {
                alert(window.parent.parent.GetTextByName("Alert_OcxUnLoad", window.parent.parent.useprameters.languagedata));//控件未加载，短信功能不可用
                return;
            }
            var sid = "";
            var paintpolice_length = CheckMember.length;
            for (var i = 0; i < paintpolice_length; i++) {
                sid += CheckMember[i] + ";";
            }
            GPSEnableOrDisplay(sid);
        }
        function GPSEnableOrDisplay(sid) {
            window.parent.document.getElementById("sendgpshidsids").value = sid;
            window.parent.mycallfunction('SendGPSEnableOrDisable', 580, 700, '', 1999);
            if (window.parent.document.getElementById('SendGPSEnableOrDisable'))//20181119--xzj
            {
                window.parent.SendGPSEnableOrDisableFrom.submit();
            }
            //window.parent.lq_hiddenvml('myrectangle_choose');
            //window.parent.lq_closeANDremovediv('select_user');
        }
        function GPSContral(sid) {
            window.parent.document.getElementById("sendgpscontralhidsids").value = sid;
            window.parent.mycallfunction('SendGPSContral', 580, 700, '', 1999);
            if (window.parent.document.getElementById('SendGPSContral'))//20181119--xzj
            {
                window.parent.SendGPSContralFrom.submit();
            }
            //window.parent.lq_hiddenvml('myrectangle_choose');
            //window.parent.lq_closeANDremovediv('select_user');
        }

        function uncheckall() {//不全选
            window.document.getElementById("selthisPageAll").checked = false;
            window.document.getElementById("checkAll").checked = false;
        }
        function tocheckall() {//判断本页是否全选
            var isallcheck = true;
            var dd = document.getElementsByTagName("input");
            for (var i = 0; i < dd.length; i++) {
                if (dd[i].type == "checkbox" && dd[i].id != "selthisPageAll" && dd[i].id != "checkAll" && !dd[i].checked) {
                    window.document.getElementById("selthisPageAll").checked = false;
                    return;
                }
            }
            if (isallcheck) {
                window.document.getElementById("selthisPageAll").checked = true;
            }
        }
        //点击成员复选框
        function onclickCheckBoxp(obj) {
            if (obj.checked) {
                addMemberToChecked(obj.value);
                tocheckall();
                //alert(CheckMember.length + " " + totalCounts)
                if (CheckMember.length == totalCounts) {
                    window.document.getElementById("checkAll").checked = true;
                }
            } else {
                removeMemberToChecked(obj.value);
                uncheckall();
            }
        }
        //点击全选复选框
        function onclickSelectAll(obj) {
            if (obj.checked) {
                //var selentityid = window.document.getElementById("ddlentity").value;
                //var selissiorname = window.document.getElementById("txtNameOrIssi").value;
                //var selfun = document.getElementById("selFunc").value;
                //var selStatues = document.getElementById("SelStatues").value;
                //var begtime = document.getElementById("begTime").value;
                //var endtime = document.getElementById("endTime").value;
                if (begtime != "") {
                    begtime = begtime + " " + $("#begSelectHour").val() + ":" + $("#BegSelectMinu").val() + ":00";
                }
                if (endtime != "") {
                    endtime = endtime + " " + $("#endSelectHour").val() + ":" + $("#endSelectMinu").val() + ":00";
                }
                window.parent.jquerygetNewData_ajax("../../Handlers/GetGPSStatusList.ashx", { begtime: begtime, endtime: endtime, PageIndex: 1, Limit: 100000000, selentity: selentityid, selwhere: selissiorname, selfun: selfun, selStatues: selStatues }, function (msg) {
                    CheckMember.length = 0;

                    for (var i = 0; i < msg.data.length; i++) {
                        addMemberToChecked(msg.data[i].id);
                    }

                    var dd = document.getElementsByTagName("input");

                    for (var j = 0; j < dd.length; j++) {

                        if (dd[j].type == "checkbox") {
                            dd[j].checked = true;
                        }
                    }

                });

            } else {
                clearCheckMember();
                var dd = document.getElementsByTagName("input");
                for (var j = 0; j < dd.length; j++) {

                    if (dd[j].type == "checkbox" && !dd[i].checked) {
                        dd[j].checked = false;
                    }
                }
            }
        }
        //点击选中本页复选框
        function onclickSelctThisPageAll(obj) {
            var dd = document.getElementsByTagName("input");

            if (obj.checked) {
                for (var i = 0; i < dd.length; i++) {

                    if (dd[i].type == "checkbox" && dd[i].id != "selthisPageAll" && dd[i].id != "checkAll" && !dd[i].checked) {
                        dd[i].checked = obj.checked;
                        addMemberToChecked(dd[i].value);
                    }
                }
                if (CheckMember.length == totalCounts) {
                    window.document.getElementById("checkAll").checked = true;
                }
            } else {
                for (var i = 0; i < dd.length; i++) {
                    if (dd[i].type == "checkbox" && dd[i].id != "selthisPageAll" && dd[i].id != "checkAll") {
                        dd[i].checked = obj.checked;
                        removeMemberToChecked(dd[i].value);

                    }
                }
                window.document.getElementById("checkAll").checked = false;
            }

        }

        document.onkeypress = function () {
            if (event.keyCode == 13) {
                event.keyCode = 0;
                event.returnValue = false;
                searchList();
            }
        }
        function searchList() {

            whereStatues = document.getElementById("selFunc").value;
            whereISSI = document.getElementById("txt_MemberNo").value;

            clearCheckMember();//检索的时候 之前全选的取消
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
            //reloadSel_Page();
            //document.getElementById("sel_page").value = currentPage;
        }
        function prePage() {
            if (currentPage <= 1) {
                return;
            }
            currentPage--;
            getData();
            //reloadSel_Page();
            //document.getElementById("sel_page").value = currentPage;
        }
        function firstPage() {
            if (currentPage == 1) {
                return;
            }
            currentPage = 1;
            getData();
            //reloadSel_Page();
            //document.getElementById("sel_page").value = currentPage;
        }
        function lastPage() {
            if (currentPage == totalPage) {
                return;
            }
            currentPage = totalPage;
            getData();
            //document.getElementById("sel_page").value = currentPage;
        }
        function tzpage() {

            var sel = document.getElementById("sel_page").value;

            if (sel == currentPage) {
                return;
            }
            currentPage = sel;
            getData();
           // reloadSel_Page();
            //document.getElementById("sel_page").value = currentPage;
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
            window.parent.lq_closeANDremovediv('DTGroup/DTGroupList', 'bgDiv');
        }


        var dragEnable = 'True';
        function dragdiv() {
            var div1 = window.parent.document.getElementById('DTGroup/DTGroupList');
            if (div1 && event.button == 0 && dragEnable == 'True') {
                window.parent.mystartDragWindow(div1, null, event); div1.style.border = "solid 0px transparent"; window.parent.cgzindex(div1);

            }
        }
        function mydragWindow() {
            var div1 = window.parent.document.getElementById('DTGroup/DTGroupList');
            if (div1) {
                window.parent.mydragWindow(div1, event);
            }
        }

        function mystopDragWindow() {
            var div1 = window.parent.document.getElementById('DTGroup/DTGroupList');
            if (div1) {
                window.parent.mystopDragWindow(div1); div1.style.border = "0px";
            }
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
                    <div id="Lang_dtzxxwh" style="display: inline; float: left; text-align: left; width: 30%; color: white"><%--动态组信息维护--%></div>
                    <div id="divClose" style="display: block" onmouseover="Divover('on')" onclick="closethispage()" onmouseout="Divover('out')"></div>
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
                                            <div style="height: 400px; overflow-y: auto">
                                                <asp:TreeView runat="server" ID="tv_SMS"></asp:TreeView>
                                            </div>
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
                                        <td align="left" valign="top" style="background-color: white" id="Td1">
                                            <table style="width: 685px; font-size: 12px">

                                                <tr>


                                                    <td align="left" colspan="2">
                                                        <span id="Lang_MemberNO_DT"></span>
                                                        <input type="text" id="txt_MemberNo" style="width: 120px" />&nbsp;&nbsp;<span id="Lang_Status"></span>
                                                        <select id="selFunc" class="">
                                                            <option id="Lang_all_searchoption" value="-1"></option>
                                                            <option id="Lang_AddCZSuccess" value="1"></option>
                                                            <option id="Lang_AddCZFaild" value="0"></option>
                                                            <option id="Lang_AddCZUn" value="2"></option>
                                                        </select>
                                                      <!------xzj--2018/7/11-------------style添加vertical-align:bottom-->
                                                        <img id="Lang_Search2" style="cursor: pointer;vertical-align:bottom" onclick="searchList()" />

                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="left" colspan="1">
                                                        <div style="display: none">
                                                            <input type="checkbox" style="display: none" id="checkAll" onclick="onclickSelectAll(this)" />
                                                        </div>
                                                        <span onclick="firstPage()" class="YangdjPageStyle" id="Lang_FirstPage">首页</span>&nbsp;&nbsp;<span onclick="prePage()" class="YangdjPageStyle" id="Lang_PrePage">上一页</span>&nbsp;&nbsp;<span onclick="nextPage()" class="YangdjPageStyle" id="Lang_play_next_page">下一页</span>&nbsp;&nbsp;<span onclick="lastPage()" class="YangdjPageStyle" id="Lang_LastPage">尾页</span>
                                                        <select onchange="tzpage()" id="sel_page"></select>
                                                    </td>
                                                    <td align="right" colspan="1"><span id="span_page"></span>&nbsp;&nbsp;<span id="span_currentPage"></span>/<span id="span_totalpage"></span>&nbsp;&nbsp;&nbsp;<span id="span_Article"></span>&nbsp;&nbsp;<span id="span_currentact"></span>/<span id="span_total"></span></td>
                                                </tr>
                                            </table>

                                            <table cellspacing="1" cellpadding="0" id="GridView1" style="background-color: #C0DE98; border-color: White; border-width: 0px; border-style: Ridge; width: 683px; font-size: 12px">
                                                <tr class="gridheadcss">
                                                    <th style="width: 30px" id="Th1" scope="col">
                                                        <input type="checkbox" id="selthisPageAll" onclick="onclickSelctThisPageAll(this)" />
                                                    </th>

                                                    <th align="center" style="width: 140px; background-color: ActiveBorder"><b><span style="font-size: 14px; color: darkgreen" id="Lang_MemberNO_DT"></span></b></th>
                                                    <th align="center" style="width: 140px; background-color: ActiveBorder"><b><span style="font-size: 14px; color: darkgreen" id="Lang_Status">内容</span></b></th>
                                                    <th align="center" style="width: 140px; background-color: ActiveBorder"><b><span style="font-size: 14px; color: darkgreen" id="Lang_Operatetime">内容</span></b></th>

                                                </tr>

                                            </table>
                                            <div id="div_selectUserList" style="position: relative; font-size: 12px; top: 0px; width: 700px; height: 330px; background-color: azure; overflow-y: scroll">
                                                <table cellspacing="1" cellpadding="0" id="GridView12" style="background-color: #C0DE98; border-color: White; border-width: 0px; border-style: Ridge; width: 100%; top: 0px">
                                                    <tbody id="Tbody1">
                                                    </tbody>
                                                </table>

                                            </div>
                                            <table style="width: 685px; font-size: 12px">

                                                <tr>

                                                    <td align="center" colspan="2">
                                                        <input type="button" style="display:none" onclick="window.parent.clear_p_run()" id="btn_qx" value="取消" />
                                                        <input type="button" onclick="toAddCZ()" class="button-blue" id="Lang_sendAddCZ" value="重组" />
                                                        <input type="button" onclick="toDelCZ()" class="button-blue" id="Lang_SendDelCZ" value="解除重组" />
                                                        <input type="button" onclick="deleteToDb()" class="button-blue" id="Lang_DelMemberToDB" value="删除成员" />
                                                    </td>
                                                </tr>
                                            </table>
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
                <td background="../../images/tab_21.gif"></td>
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
    var Lang_Search2 = window.document.getElementById("Lang_Search2");
    Lang_Search2.onmousedown = function () {
        Lang_Search2.src = Lang_Search2_un;
    }
    Lang_Search2.onmouseup = function () {
        Lang_Search2.src = Lang_Search22;

    }
    Lang_Search2.setAttribute("src", Lang_Search22);
    window.document.getElementById("Lang_dtzxxwh").innerHTML = window.parent.parent.GetTextByName("dtczxx", window.parent.parent.useprameters.languagedata);
    window.document.getElementById("span_page").innerHTML = window.parent.parent.GetTextByName("Page", window.parent.parent.useprameters.languagedata);
    window.document.getElementById("span_Article").innerHTML = window.parent.parent.GetTextByName("Article", window.parent.parent.useprameters.languagedata);

    var id = "span_tv_" + "<%=firstGSSI%>";
    var fist_obj=document.getElementById(id);
    if (fist_obj) {
        OnclickTree(fist_obj, '<%=firstGSSI%>', '<%=firstGSSI%>');
    }
</script>
