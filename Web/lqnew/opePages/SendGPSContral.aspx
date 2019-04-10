<%@ Page Language="C#" AutoEventWireup="true" ValidateRequest="false" CodeBehind="SendGPSContral.aspx.cs"
    Inherits="Web.lqnew.opePages.SendGPSContral" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../css/lq_addedit.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/pagestyle.css" rel="stylesheet" type="text/css" />
    <script src="../js/geturl.js" type="text/javascript"></script>
    <link href="../css/btn.css" rel="stylesheet" type="text/css" />
    <script src="../../JQuery/jquery-1.5.2.js" type="text/javascript"></script>
    <script src="../../JS/LangueSwitch.js" type="text/javascript"></script>
    <script src="../js/StringPrototypeFunction.js" type="text/javascript"></script>
    <script src="../js/CommValidator.js" type="text/javascript"></script>
    <style type="text/css">
        .typelist {
            border: solid;
            border: 1px 1px 1px 1px;
            filter: alpha(opacity:0);
            visibility: hidden;
            position: absolute;
            z-index: 1;
        }

        .noselect {
            border-top: #eee 1px solid;
            padding-left: 2px;
            background: #fff;
            width: 100%;
            color: #000;
        }

        .isselect {
            border-top: #047 1px solid;
            padding-left: 2px;
            background: #058;
            width: 100%;
            color: #fe0;
        }

        .CALLBUTTON {
            visibility: visible;
        }

        .CALLBUTTON1 {
            visibility: visible;
            border-right: #7b9ebd 1px solid;
            padding-right: 2px;
            border-top: #7b9ebd 1px solid;
            padding-left: 2px;
            font-size: 12px;
            filter: progid:DXImageTransform.Microsoft.Gradient(GradientType=0, StartColorStr=#ffffff, EndColorStr=#3C9562);
            border-left: #7b9ebd 1px solid;
            cursor: pointer;
            color: black;
            padding-top: 2px;
            border-bottom: #7b9ebd 1px solid;
            width: 60px;
            height: 25px;
        }
        .button-blue {
            height:20px;
            text-align:center;
            border-radius:5px;
            border:1px solid #000000;
            box-shadow:inset 0px 5px 4px #808492;
            background-color:#003D53;
            color:white;
        }
    </style>
    <script type="text/javascript">
        var SelectUsers = new Array();
        var AllUsers = new Array();
        var everypagecount = 50;
        var currentPage = 1;
        var totalPage = 1;
        var totalCounts = 0;

        var Lang_Illegal_ISSI_or_fail_to_mobile_user_bind = window.parent.parent.GetTextByName("Lang_Illegal_ISSI_or_fail_to_mobile_user_bind", window.parent.parent.useprameters.languagedata);
        var Lang_Illegal_terminal_identification = window.parent.parent.GetTextByName("Lang_Illegal_terminal_identification", window.parent.parent.useprameters.languagedata);
        var Delete = window.parent.parent.GetTextByName("Delete", window.parent.parent.useprameters.languagedata);
        var Lang_PleaseEnterGPSParam = window.parent.parent.GetTextByName("Lang_PleaseEnterGPSParam", window.parent.parent.useprameters.languagedata);
        var Lang_SendUpIntralMustInt = window.parent.parent.GetTextByName("Lang_SendUpIntralMustInt", window.parent.parent.useprameters.languagedata);
        var Lang_SendUpDestISSIMustInt = window.parent.parent.GetTextByName("Lang_SendUpDestISSIMustInt", window.parent.parent.useprameters.languagedata);
        var Lang_SendZLIsSendingPleaseSeeSysLogWindow = window.parent.parent.GetTextByName("Lang_SendZLIsSendingPleaseSeeSysLogWindow", window.parent.parent.useprameters.languagedata);
        var Lang_GPSControlISDoing = window.parent.parent.GetTextByName("Lang_GPSControlISDoing", window.parent.parent.useprameters.languagedata);
        var Memberscannotbeempty = window.parent.parent.GetTextByName("Memberscannotbeempty", window.parent.parent.useprameters.languagedata);
        var Lang_GPS_LangeOfDest = window.parent.parent.GetTextByName("Lang_GPS_LangeOfDest", window.parent.parent.useprameters.languagedata);
        var Lang_GPS_LangeOfTime = window.parent.parent.GetTextByName("Lang_GPS_LangeOfTime", window.parent.parent.useprameters.languagedata);
        var Lang_GPS_model_choose = window.parent.parent.GetTextByName("Lang_GPS_model_choose", window.parent.parent.useprameters.languagedata);
        var notOnlyCycleAndDistance = window.parent.parent.GetTextByName("notOnlyCycleAndDistance", window.parent.parent.useprameters.languagedata);
        var haveDestIssiNotCycle = window.parent.parent.GetTextByName("haveDestIssiNotCycle", window.parent.parent.useprameters.languagedata);


        //添加成员
        function addSelectUsers(uname, uissi, utype, issitype) {
            SelectUsers.push({ uname: uname, uissi: uissi, utype: utype, issitype: issitype });
            AllUsers.push({ uname: uname, uissi: uissi, utype: utype, issitype: issitype });
            changeControlEnableOrDisable();
        }
        //移除成员
        function removeSelectUsers(i) {
            for (var m = 0; m < AllUsers.length; m++)
            {
                if (AllUsers[m].uissi == SelectUsers[i].uissi)
                {
                    AllUsers.splice(m, 1);
                    break;
                }
            }
            SelectUsers.splice(i, 1);
            changeControlEnableOrDisable();        
        }

        function reroadpagetitle() {
            if (document.getElementById("onlyShowChecked").checked == true) {
                totalCounts = SelectUsers.length;
            } else { totalCounts = AllUsers.length; }
            currentPage = 1;
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



        }
        var Lang_ThisRecordHasAdd = window.parent.parent.GetTextByName("Lang_ThisRecordHasAdd", window.parent.parent.useprameters.languagedata);
        var Lang_LTE_IsNotAccept = window.parent.parent.GetTextByName("Lang_LTE_IsNotAccept", window.parent.parent.useprameters.languagedata);

        function addMemberToSelectUsers() {
            var issi = document.getElementById("txtISSIText").value;
            for (var i = 0; i < AllUsers.length; i++) {
                if (AllUsers[i].uissi == issi) {
                    alert(Lang_ThisRecordHasAdd);
                    return;
                }
            }

            $.ajax({
                type: "POST",
                url: "../../Handlers/GetUserInfo_Handler.ashx",
                data: "issi=" + issi,
                success: function (msg) {

                    var my = eval(msg);

                    if (my[0].nam == undefined) {
                        alert(Lang_Illegal_ISSI_or_fail_to_mobile_user_bind);//Lang_Illegal_terminal_identification
                        return;
                    }
                    var IsGoOn = true;
                    if (my[0].issitype.toString().trim() == "" || my[0].issitype.toString().trim() == null || my[0].issitype.toString().trim() == undefined) {
                        var Lang_remove_user_no_type = window.parent.parent.GetTextByName("Lang_remove_user_no_type", window.parent.parent.useprameters.languagedata);
                        IsGoOn = false;
                        alert(Lang_remove_user_no_type);
                    }
                    //if (my[0].issitype.toString().trim() == "LTE") {
                    //    var Lang_Remove_LTE_user = window.parent.parent.GetTextByName("Lang_Remove_LTE_user", window.parent.parent.useprameters.languagedata);
                    //    IsGoOn = false;
                    //    alert(Lang_Remove_LTE_user);
                    //}
                    if (IsGoOn) {
                        for (var i = 0; i < AllUsers.length; i++) {
                            if (AllUsers[i].uissi == issi) {
                                return;
                            }
                        }
                        addSelectUsers(my[0].nam, issi, my[0].type, my[0].issitype);
                    }
                    reroadpagetitle();
                    currentPage = totalPage;//显示最后一页
                    var sel = document.getElementById("sel_page");
                    sel.value = totalPage;//最后一页
                    document.getElementById("span_currentPage").innerHTML = currentPage;
                    renderTable();
                    document.getElementById("txtISSIText").value = "";
                    scrollBottom();
                }
            });


        }
        function DelUserMember(i) {
            removeSelectUsers(i);
            reroadpagetitle();

            renderTable();
        }
        function renderTable() {
            isFirstPage();
            var strResult = "<table>";

            var ii = 0;
            if (isLastPage(currentPage) && currentPage > 0) {
                ii = totalCounts;
                document.getElementById("span_currentact").innerHTML = (currentPage - 1) * everypagecount + 1 + "~" + totalCounts;
            } else if (currentPage <= 0) {
                document.getElementById("span_currentact").innerHTML = 0 + "~" + currentPage * everypagecount;

            } else {
                ii = (currentPage - 1) * everypagecount + everypagecount;
                document.getElementById("span_currentact").innerHTML = (currentPage - 1) * everypagecount + 1 + "~" + currentPage * everypagecount;
            }

            if (currentPage > 0) {
                for (var i = (currentPage - 1) * everypagecount; i < ii; i++) {
                    if (document.getElementById("onlyShowChecked").checked == true) {
                        strResult += "<tr><td align='center' style='width:70px'>" + SelectUsers[i].uname + "</td><td align='center' style='width:70px'>" + SelectUsers[i].uissi + "</td><td align='center' style='width:70px'>" + SelectUsers[i].utype + "</td><td align='center' style='width:90px'>" + SelectUsers[i].issitype + "</td><td align='center' style='width:90px'><span style='cursor:pointer;;color:red' onclick='DelUserMember(\"" + i + "\")'>" + Delete + "</span></td></tr>";
                    } else {
                        strResult += "<tr><td align='center' style='width:70px'>" + AllUsers[i].uname + "</td><td align='center' style='width:70px'>" + AllUsers[i].uissi + "</td><td align='center' style='width:70px'>" + AllUsers[i].utype + "</td><td align='center' style='width:90px'>" + AllUsers[i].issitype + "</td><td align='center' style='width:90px'><span style='cursor:pointer;;color:red' onclick='DelUserMember(\"" + i + "\")'>" + Delete + "</span></td></tr>";
                    }
                }
            }
            strResult += "</table>";

            window.document.getElementById("div_selectUserList").innerHTML = strResult;
        }
        function isFirstPage() {
            if (currentPage <= 1) {
                window.document.getElementById("Lang_FirstPage").className = "YangdjPageStyleUnClick";
                window.document.getElementById("Lang_PrePage").className = "YangdjPageStyleUnClick";
            } else {
                window.document.getElementById("Lang_FirstPage").className = "YangdjPageStyle";
                window.document.getElementById("Lang_PrePage").className = "YangdjPageStyle";
            }
        }
        //判断是否为最后一页
        function isLastPage(currentPage) {
            if (currentPage >= totalPage) {
                window.document.getElementById("Lang_play_next_page").className = "YangdjPageStyleUnClick";
                window.document.getElementById("Lang_LastPage").className = "YangdjPageStyleUnClick";
                return true;
            } else {
                window.document.getElementById("Lang_play_next_page").className = "YangdjPageStyle";
                window.document.getElementById("Lang_LastPage").className = "YangdjPageStyle";
                return false;
            }
        }
        function nextPage() {
            if (totalPage <= currentPage) {
                return;
            }
            currentPage++;
            reroadpagetitle();
            renderTable();
            document.getElementById("sel_page").value = currentPage;
        }
        function prePage() {
            if (currentPage <= 1) {
                return;
            }
            currentPage--;
            reroadpagetitle();
            renderTable();
            document.getElementById("sel_page").value = currentPage;
        }
        function firstPage() {
            if (currentPage == 1) {
                return;
            }
            currentPage = 1;
            reroadpagetitle();
            renderTable();
            document.getElementById("sel_page").value = currentPage;
        }
        function lastPage() {
            if (currentPage == totalPage) {
                return;
            }
            currentPage = totalPage;
            reroadpagetitle();
            renderTable();
            document.getElementById("sel_page").value = currentPage;
        }
        function tzpage() {

            var sel = document.getElementById("sel_page").value;

            if (sel == currentPage) {
                return;
            }
            currentPage = sel;
            reroadpagetitle();
            renderTable();
            document.getElementById("sel_page").value = currentPage;
        }

        function CloseWindow() {
            window.parent.hiddenbg2();
            window.parent.mycallfunction('SendGPSContral');
        }

        $(document).ready(function () {
            if (window.parent.isSendingGPSControl) {
                alert(Lang_GPSControlISDoing);
                CloseWindow();
                return;
            }
            window.parent.visiablebg2();
            if (document.getElementById("hiduserinfo").value != "") {
                var users = document.getElementById("hiduserinfo").value.split(";");

                for (var i = 0; i < users.length; i++) {
                    var sx = users[i].split(",");
                    if (sx[3].toString().trim() == "BEIDOU")
                    {
                        document.getElementById("Beidou_model").disabled = false;
                        document.getElementById("GPS_model").disabled = false;
                    }
                    addSelectUsers( sx[0],  sx[1], sx[2], sx[3] );
                }
                reroadpagetitle();
                renderTable();
            } else {
                isFirstPage();
                isLastPage(currentPage);
            }
            $("#divdrag").mousedown(function () {
                dragdiv();
            });
            $("#divdrag").mousemove(function () {
                mydragWindow();
            });
            $("#divdrag").mouseup(function () {
                mystopDragWindow();
            });
            document.body.oncontextmenu = function () { return false; };
        });

        var dragEnable = 'True';
        function dragdiv() {
            var div1 = window.parent.document.getElementById(geturl());
            if (div1 && event.button == 0 && dragEnable == 'True') {
                window.parent.mystartDragWindow(div1, null, event); div1.style.border = "solid 0px transparent"; window.parent.cgzindex(div1);

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
        function OnAddMember() {
            window.parent.mycallfunction('AddMemberTree/add_Member', 650, 514, '0&ifr=SendGPSContral_ifr&selectcount=-1&type=user', 2001);
        }
        function faterdo(retrunissis) {
            SelectUsers.length = 0;
            AllUsers.length = 0;
            //document.getElementById("TETRA_type").disabled = true;
            //document.getElementById("TETRA_type").checked = false;
            //document.getElementById("PDT_type").disabled = true;
            //document.getElementById("PDT_type").checked = false;
            //document.getElementById("BEIDOU_type").disabled = true;
            //document.getElementById("BEIDOU_type").checked = false;
            //document.getElementById("LTE_type").disabled = true;
            //document.getElementById("LTE_type").checked = false;
            //document.getElementById("span_TETRA").disabled = true;
            //document.getElementById("span_PDT").disabled = true;
            //document.getElementById("span_BEIDOU").disabled = true;
            //document.getElementById("span_LTE").disabled = true;

            //document.getElementById("Beidou_model").disabled = false;
            //document.getElementById("GPS_model").disabled = false;
            //document.getElementById("Beidou_model").checked = false;
            //document.getElementById("GPS_model").checked = false;

            //document.getElementById("applySpan_Switch").style.visibility = "hidden";
            //document.getElementById("applyToOther_Cycle").style.visibility = "hidden";
            //document.getElementById("applyToOther_Cycle").checked = true;
            //document.getElementById("applyToOther").style.visibility = "hidden";
            //document.getElementById("applyToOther_Switch").style.visibility = "hidden";


            for (var i = 0; i < retrunissis.length; i++) {
                //if (retrunissis[i].issitype.toString().trim() == "BEIDOU")
                //{
                //    document.getElementById("Beidou_model").checked = false;
                //    document.getElementById("GPS_model").checked = false;
                //    document.getElementById("Beidou_model").disabled = false;
                //    document.getElementById("GPS_model").disabled = false;
                //    document.getElementById("BEIDOU_type").disabled = false;
                //    document.getElementById("BEIDOU_type").checked = true;
                //    document.getElementById("span_BEIDOU").disabled = false;
                //}
                //if (retrunissis[i].issitype.toString().trim() == "TETRA") {
                //    document.getElementById("TETRA_type").disabled = false;
                //    document.getElementById("TETRA_type").checked = true;
                //    document.getElementById("span_TETRA").disabled = false;
                //}
                //if (retrunissis[i].issitype.toString().trim() == "PDT") {
                //    document.getElementById("PDT_type").disabled = false;
                //    document.getElementById("PDT_type").checked = true;
                //    document.getElementById("span_PDT").disabled = false;
                //}
                //if (retrunissis[i].issitype.toString().trim() == "LTE") {
                //    document.getElementById("LTE_type").disabled = false;
                //    document.getElementById("LTE_type").checked = true;
                //    document.getElementById("applySpan_Switch").style.visibility = "visible";
                //    document.getElementById("applyToOther_Cycle").style.visibility = "visible";
                //    document.getElementById("applyToOther_Cycle").checked = false;
                //    document.getElementById("applyToOther").style.visibility = "visible";
                //    document.getElementById("applyToOther_Switch").style.visibility = "visible";
                //    document.getElementById("span_LTE").disabled = false;
                //}
                addSelectUsers(retrunissis[i].uname, retrunissis[i].uissi, retrunissis[i].utype, retrunissis[i].issitype);
            }
            currentPage = 1;
            reroadpagetitle();
            renderTable();
        }

        function clearTS() {
            window.document.getElementById("span_result").innerHTML = "";
            window.document.getElementById("span_sendtimes").innerHTML = "";
            window.document.getElementById("span_destissi").innerHTML = "";
        }
        //使能开关  1表示开启，0表示关闭
        function startSet()
        {
            if (checkInfo())
            {
                hasNullTypeUser = false;
                checkUserNoType();
                window.parent.mycallfunction('view_info/view_GPSSetInfo', 850, 500, 0, 2015);
                var num = 0;
                var controlInterval = setInterval(function () {
                    if (window.parent.parent.document.frames["view_info/view_GPSSetInfo_ifr"] != null && window.parent.parent.document.frames["view_info/view_GPSSetInfo_ifr"] != undefined && (typeof window.parent.parent.document.frames["view_info/view_GPSSetInfo_ifr"].toHTML).toString() != "undefined") {
                        if (hasLTE) {
                            window.parent.parent.document.frames["view_info/view_GPSSetInfo_ifr"].toHTML(SelectUsers, hasTETRA, hasPDT, hasBEIDOU, hasLTE, isEnable, times, distance, destissi, model, window.document.getElementById("applyToOther_Switch").checked, window.document.getElementById("applyToOther_Cycle").checked);
                        } else {
                            window.parent.parent.document.frames["view_info/view_GPSSetInfo_ifr"].toHTML(SelectUsers, hasTETRA, hasPDT, hasBEIDOU, hasLTE, isEnable, times, distance, destissi, model, true, true);
                        }
                        clearInterval(controlInterval);
                    } else {
                        if (num >= 10) { clearInterval(controlInterval); }
                        else { num++; }
                    }
                }, 1000);
            }
        }

        var Lang_SendUpDistanceMustInt = window.parent.parent.GetTextByName("distanceMustInt", window.parent.parent.useprameters.languagedata);

        var model = "0";
        var times = "0";
        var destissi = "0";
        var distance = "0";
        var isEnable = "-1";
        function checkInfo()
        {
            if (SelectUsers.length == 0) {
                alert(Memberscannotbeempty);
                return false;
            }
            times = window.document.getElementById("sendtimes").value;
            destissi = window.document.getElementById("sendDestISSI").value;
            distance = window.document.getElementById("distanceNum").value;
            if (times == "" && distance == "" && (document.getElementById("closeGPS").checked == false && document.getElementById("openGPS").checked == false)) {
                if (document.getElementById("Beidou_model").disabled == true && document.getElementById("GPS_model").disabled == true) {
                    //window.document.getElementById("span_result").innerHTML = Lang_PleaseEnterGPSParam;
                    alert(Lang_PleaseEnterGPSParam);
                    return false;
                }
                if (document.getElementById("Beidou_model").disabled == false && document.getElementById("GPS_model").disabled == false && document.getElementById("Beidou_model").checked == false && document.getElementById("GPS_model").checked == false) {
                    // window.document.getElementById("span_result").innerHTML = Lang_PleaseEnterGPSParam;
                    alert(Lang_PleaseEnterGPSParam);
                    return false;
                }
            }
            if (!ValiateInt(times) && times != "") {
                //window.document.getElementById("span_result").innerHTML = Lang_SendUpIntralMustInt;
                alert(Lang_SendUpIntralMustInt);
                return false;
            }
            if (!ValiateInt(distance) && distance != "") {
                //window.document.getElementById("span_result").innerHTML = Lang_SendUpDistanceMustInt;
                alert(Lang_SendUpDistanceMustInt);
                return false;
            }
            if (!ValiateInt(destissi) && destissi.trim() != "") {
                //window.document.getElementById("span_result").innerHTML = Lang_SendUpDestISSIMustInt;
                alert(Lang_SendUpDestISSIMustInt);
                return false;
            }
            //if (parseInt(destissi) > 16777215 || parseInt(destissi) <= 0) {
            if (parseInt(destissi) > 99999999 || parseInt(destissi) <= 0) {
                //window.document.getElementById("span_result").innerHTML = Lang_GPS_LangeOfDest;
                alert(Lang_GPS_LangeOfDest);
                return false;
            }
            if (parseInt(times) < 0 && times != "") {
                // window.document.getElementById("span_result").innerHTML = Lang_SendUpIntralMustInt;
                alert(Lang_SendUpIntralMustInt);
                return false;
            }
            if (destissi.trim() != "" && times.trim() == "") {
                //window.document.getElementById("span_result").innerHTML = haveDestIssiNotCycle;
                alert(haveDestIssiNotCycle);
                return false;
            }
            if (parseInt(times) == 0 && times != "") {
                var goOn = true;
                for (var i = 0; i < SelectUsers.length; i++) {
                    if (SelectUsers[i].issitype.trim() == "PDT")
                    { goOn = false; }
                }
                if (goOn) {
                    //window.document.getElementById("span_result").innerHTML = Lang_GPS_LangeOfTime;
                    alert(Lang_GPS_LangeOfTime);
                    return false;
                }
            }
            model = "0";
            if (document.getElementById("Beidou_model").checked == false && document.getElementById("GPS_model").checked == false) {
                model = "-1";
            }
            else if (document.getElementById("Beidou_model").checked == true && document.getElementById("GPS_model").checked == false) {
                model = "1";
            }
            else if (document.getElementById("Beidou_model").checked == false && document.getElementById("GPS_model").checked == true) {
                model = "3";
            }
            else if (document.getElementById("Beidou_model").checked == true && document.getElementById("GPS_model").checked == true) {
                model = "7";
            }
            if (model == "0" && document.getElementById("Beidou_model").disabled == false && document.getElementById("GPS_model").disabled == false) {
                // window.document.getElementById("span_result").innerHTML = Lang_GPS_model_choose;
                alert(Lang_GPS_model_choose);
                return false;
            }
            if (hasLTE) {//xzj--20190111--将 || times.trim() == ""改为 && times.trim() == ""
                if ((document.getElementById("closeGPS").checked == false && document.getElementById("openGPS").checked == false) && times.trim() == "") {
                   // window.document.getElementById("span_result").innerHTML = Lang_PleaseEnterGPSParam;
                    alert(Lang_PleaseEnterGPSParam);
                    return false;
                }
            }
            return true;
        }

        var hasNullTypeUser = false;
        function checkUserNoType() {
            for (var i = 0; i < SelectUsers.length; i++) {
                if (SelectUsers[i].issitype.toString().trim() == "" || SelectUsers[i].issitype.toString().trim() == null || SelectUsers[i].issitype.toString().trim() == undefined) {
                    hasNullTypeUser = true;
                    SelectUsers.splice(i, 1);
                    checkUserNoType();
                    return;
                }
            }
            if (hasNullTypeUser) {
                var Lang_remove_user_no_type = window.parent.parent.GetTextByName("Lang_remove_user_no_type", window.parent.parent.useprameters.languagedata);
                alert(Lang_remove_user_no_type);
            }
        }

        document.onkeypress = function () {
            if (event.keyCode == 13) {
                event.keyCode = 0;
                event.returnValue = false;
                addMemberToSelectUsers();
            }
        }
        function scrollBottom() {
            document.getElementById("div_selectUserList").scrollTop = document.getElementById("div_selectUserList").scrollHeight;
        }

        //function sendControlInfo(IsContinue)
        //{
        //    if (IsContinue)
        //    {
        //        if (document.getElementById("LTE_type").disabled == false) {
        //            window.parent.sendGPSControl(SelectUsers, isEnable, times, destissi, window.document.getElementById("distanceNum").value, model, window.document.getElementById("applyToOther_Switch").checked, window.document.getElementById("applyToOther_Cycle").checked);
        //        } else {
        //            window.parent.sendGPSControl(SelectUsers, isEnable, times, destissi, window.document.getElementById("distanceNum").value, model, true, true);
        //        }
        //    }
        //}
    </script>
</head>
<body onselectstart="return false;">
    <form id="Form1" runat="server">
        <div>
            <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
                <tr>
                    <td height="30">
                        <div id="divdrag" style="cursor: move">
                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td width="15" height="32">
                                        <img alt="" src="../images/tab_03.png" width="15" height="32" />
                                    </td>
                                    <td width="1101" background="../images/tab_05.gif">
                                        <ul class="hor_ul">
                                            <li>
                                                <img alt="" src="../images/037.gif" /><span id="Lang_GPS_Control"></span></li>
                                        </ul>
                                    </td>
                                    <td width="281" background="../images/tab_05.gif" align="right">
                                        <img alt="" class="style6" style="cursor: pointer;" onclick="CloseWindow()" onmouseover="javascript:this.src='../images/close_un.png';"
                                            onmouseout="javascript:this.src='../images/close.png';" src="../images/close.png" />
                                    </td>
                                    <td width="14">
                                        <img alt="" src="../images/tab_07.png" width="14" height="32" />
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
                                        <tr>
                                            <td class="style3" align="right" style="width: 100px; height: 250px">
                                                <div>
                                                    <%--终端号码:--%><span id="usermember"></span><span>&nbsp;&nbsp</span>
                                                </div>
                                            </td>
                                            <td class="style3" align="left" valign="top">
                                                <span id="Lang_ISSS"></span>
                                                <input type="text" id="txtISSIText" runat="server" /><input onclick="addMemberToSelectUsers()" type="button" class="button-blue" id="aLang-Add" value="添加" />
                                                <input type="hidden" id="hiduserinfo" runat="server" />
                                                <table style="width: 400px; border-top: solid; border-top-color: mediumseagreen; border-top-width: 1px">
                                                    <tr>
                                                        <td align="left" colspan="4" style="width: 270px"><span onclick="firstPage()" class="YangdjPageStyle" id="Lang_FirstPage">首页</span>&nbsp;&nbsp;<span onclick="prePage()" class="YangdjPageStyle" id="Lang_PrePage">上一页</span>&nbsp;&nbsp;<span onclick="nextPage()" class="YangdjPageStyle" id="Lang_play_next_page">下一页</span>&nbsp;&nbsp;<span onclick="lastPage()" class="YangdjPageStyle" id="Lang_LastPage">尾页</span></td>
                                                        <td align="right">
                                                            <select onchange="tzpage()" id="sel_page"></select></td>
                                                    </tr>
                                                    <tr>
                                                        <td align="left" colspan="2" style="height:27px;display:none"><input type="checkbox" id="onlyShowChecked" onclick="IsOnlyShowChecked()"  /><span id="hideTheUserNotSelected" /></td>
                                                        <td align="right" colspan="5"><span id="span_page"></span><span id="span_currentPage">0</span>/<span id="span_totalpage">0</span>&nbsp;&nbsp;&nbsp;<span id="span_Article"></span><span id="span_currentact">0~0</span>/<span id="span_total">0</span></td>
                                                    </tr>
                                                    <tr class="gridheadcss">
                                                        <th align="center" style="width: 70px; background-color: ActiveBorder"><span id="Lang_Name">名称</span></th>
                                                        <th align="center" style="width: 70px; background-color: ActiveBorder"><span id="txtISSIText1">终端号码</span></th>
                                                        <th align="center" style="width: 70px; background-color: ActiveBorder"><span id="Lang_style">用户类型</span></th>
                                                        <th align="center" style="width: 90px; background-color: ActiveBorder"><span id="Lang_ISSItype">终端类型</span></th>
                                                        <th align="center" style="background-color: ActiveBorder" colspan="2"><span id="Lang_Operater"></span></th>
                                                    </tr>

                                                </table>
                                                <div id="div_selectUserList" style="position: absolute; top: 126px; width: 400px; height: 150px; background-color: azure; overflow: auto"></div>
                                            </td>
                                            <td align="left" style="width: 80px;">

                                                <img alt="" src="<%--../images/chooseMember0.png--%>" id="imgSelectUser" onclick="OnAddMember()" onmouseover="<%--javascript:this.src='../images/chooseMember_un.png';--%>"
                                                    onmouseout="<%--javascript:this.src='../images/chooseMember0.png';--%>" />&nbsp;
                                            <asp:Button ID="btnnew" Visible="false" runat="server" Text="新增" CssClass="CALLBUTTON2" Enabled="false" />

                                            </td>
                                        </tr>
                                        <tr>
                                            <td><span id="Lang_GPS_ISSIType">要操作的终端类型</span></td>
                                            <td align="left" style="width:100px" colspan="2">
                                                <input type="checkbox" id="TETRA_type" disabled="disabled" onclick="TETRA_click()"/><span id="span_TETRA">TETRA</span>
                                               <input type="checkbox" id="PDT_type" disabled="disabled" onclick="PDT_click()"/><span id="span_PDT">PDT</span>
                                                 <input type="checkbox" id="BEIDOU_type" disabled="disabled" onclick="BEIDOU_click()"/><span id="span_BEIDOU">BEIDOU</span>
                                               <input type="checkbox" id="LTE_type" disabled="disabled" onclick="LTE_click()"/><span id="span_LTE">LTE</span>
                                            </td>
                                        </tr>
                                         <tr>
                                            <td><span id="Lang_GPS_on-off">使能开关</span></td>
                                            <td align="left" style="width: 100px" colspan="2">
                                                <input type="checkbox" id="openGPS" onclick="openGPS111()" /><span id="Lang_GPS_Open">开启GPS</span>
                                                <input type="checkbox" id="closeGPS" onclick="closeGPS111()"/><span id="Lang_GPS_Close">关闭GPS</span>
                                                <input type="checkbox" id="applyToOther_Switch" onclick="applyToOther_Swtch()" style="visibility:hidden"/><span id="applySpan_Switch" style="visibility:hidden;color:blue;"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td><span id="Lang_GPS_Model">上报模式</span></td>
                                            <td align="left" style="width: 100px" colspan="2">
                                                <asp:CheckBox ID="Beidou_model" runat="server" Enabled="false"/>
                                                <asp:CheckBox ID="GPS_model" runat="server" Enabled="false"/>
                                                <span id="choose_model_show" style="color: red"></span>

                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <span id="Lang_SendUpIntral">上报周期</span>
                                            </td>
                                            <td align="left" colspan="2">
                                                <input type="text" id="sendtimes" style="width:80px;" onblur="changeTitle_Cycle()"/>s&nbsp;
                                                <input type="checkbox" id="applyToOther_Cycle" style="visibility:hidden" onclick="changeCycleToAll()" />
                                                <span id="applyToOther" style="color:blue;visibility:hidden;"></span>&nbsp;
                                                <span id="ssss" style="color: red;visibility:visible;" ></span>
                                                <img src="../../Images/question.jpg" onclick="view_Cycle()" style="cursor:hand;"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <span id="Lang_GPS_Distance">距离门限</span>
                                            </td>
                                            <td align="left" colspan="2">
                                                <input type="text" id="distanceNum" style="width:80px;" onblur="changeTitle_Distance()" />m
                                                <span style="color: red"></span>&nbsp;&nbsp;
                                                <span id="span_sendDistance" style="color: red"></span>
                                                 <img id="distanceQuestion" src="../../Images/question.jpg" onclick="view_Distance()" style="cursor:hand;"/>
                                            </td>
                                        </tr>
                                        <tr id="DestIssi">
                                            <td>
                                                <span id="Lang_SendUpDestISSI">上报目的地</span>

                                            </td>
                                            <td align="left" colspan="2">
                                                <input type="text" value="" id="sendDestISSI" style="width:80px;"/><span style="color: red" id="GPS_ID_Destination_warn"></span>&nbsp;&nbsp;<span id="span_destissi" style="color: red"></span>
                                            </td>

                                        </tr>
                                        <tr>
                                            <td class="style3" align="center" colspan="3">
                                                <table>
                                                    <tr>
                                                        <td>
                                                            <%--<button class="CALLBUTTON1" id="startBtn" style="text-align: center; cursor: pointer;"
                                                                onclick="startSet()">
                                                                </button>--%>
                                                             <img id="sure" src="../images/add_ok.png" onclick="startSet()" style="cursor: hand;" />&nbsp;&nbsp;&nbsp;

                                                        </td>
                                                        <td>
                                                            <%--<button class="CALLBUTTON1" id="closeBtn" style="text-align: center; cursor: pointer;"
                                                                 onclick=" window.parent.hiddenbg2();window.parent.mycallfunction('SendGPSContral');">
                                                                </button>--%>  
                                                            <img id="cancel"  style="cursor: hand;" onclick=" window.parent.hiddenbg2();window.parent.mycallfunction('SendGPSContral');" src="../images/add_cancel.png" />
                      
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td align="center">
                                                            <span style="color: red" id="span_result"></span>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
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
                                    <img alt="" src="../images/tab_20.png" width="15" height="15" />
                                </td>
                                <td background="../images/tab_21.gif">
                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td width="25%" nowrap="nowrap">&nbsp;
                                            </td>
                                            <td width="75%" valign="top" class="STYLE1">&nbsp;
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td width="14">
                                    <img alt="" src="../images/tab_22.png" width="14" height="15" />
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

    var imageOK = window.document.getElementById("sure");
    var sourceOK = window.parent.parent.GetTextByName("LangConfirm", window.parent.parent.useprameters.languagedata);
    imageOK.setAttribute("src", sourceOK);
    var imageCancel = document.getElementById("cancel");
    var sourceCancel = window.parent.parent.GetTextByName("Lang-Cancel", window.parent.parent.useprameters.languagedata);
    imageCancel.setAttribute("src", sourceCancel);

    var image = window.document.getElementById("imgSelectUser");
    var srouce = "../" + window.parent.parent.GetTextByName("Lang_chooseMemberPNG", window.parent.parent.useprameters.languagedata);
    image.setAttribute("src", srouce);
    //var Lang_AddNew_un = window.parent.parent.GetTextByName("Lang_AddNew_un", window.parent.parent.useprameters.languagedata);
    var strpath = "../" + window.parent.parent.GetTextByName("Lang_chooseMemberPNG", window.parent.parent.useprameters.languagedata);
    var strpathmove = "../" + window.parent.parent.GetTextByName("Lang_chooseMemberPNG_un", window.parent.parent.useprameters.languagedata);
    image.onmousemove = function () { this.src = strpathmove }//"javascript:this.src='../../images/btn_add_un.png'";// onmouse_move();
    image.onmouseout = function () { this.src = strpath }//"javascript:this.src='../../images/btn_add.png'";//  onmouse_out();

    window.document.getElementById("usermember").innerHTML = window.parent.parent.GetTextByName("usermember", window.parent.parent.useprameters.languagedata);
    //window.document.getElementById("btn_OK").innerHTML = window.parent.parent.GetTextByName("BeSure", window.parent.parent.useprameters.languagedata);

    window.document.getElementById("span_page").innerHTML = window.parent.parent.GetTextByName("Page", window.parent.parent.useprameters.languagedata);
    window.document.getElementById("span_Article").innerHTML = window.parent.parent.GetTextByName("Article", window.parent.parent.useprameters.languagedata);
    window.document.getElementById("aLang-Add").value = window.parent.parent.GetTextByName("Lang-Add", window.parent.parent.useprameters.languagedata);
    window.document.getElementById("txtISSIText1").innerHTML = window.parent.parent.GetTextByName("Lang_ISSS", window.parent.parent.useprameters.languagedata);
    window.document.getElementById("GPS_ID_Destination_warn").innerHTML = window.parent.parent.GetTextByName("Lang_GPS_ID_Destination_warn", window.parent.parent.useprameters.languagedata);
    window.document.getElementById("Lang_ISSItype").innerHTML = window.parent.parent.GetTextByName("Lang_TerminalType", window.parent.parent.useprameters.languagedata);
  //  window.document.getElementById("closeBtn").innerHTML = window.parent.parent.GetTextByName("BeCancel", window.parent.parent.useprameters.languagedata);
  //  window.document.getElementById("startBtn").innerHTML = window.parent.parent.GetTextByName("Start", window.parent.parent.useprameters.languagedata);
  ////  window.document.getElementById("port_LTE").innerHTML = window.parent.parent.GetTextByName("Lang_LTE_Port", window.parent.parent.useprameters.languagedata);
    window.document.getElementById("DestIssi").style.height = "0px";
    
    window.document.getElementById("hideTheUserNotSelected").innerHTML = window.parent.parent.GetTextByName("onlyShowTheChecked", window.parent.parent.useprameters.languagedata);
    //effectiveAll
    window.document.getElementById("applySpan_Switch").innerHTML = window.parent.parent.GetTextByName("effectiveAll", window.parent.parent.useprameters.languagedata);
    window.document.getElementById("applyToOther").innerHTML = window.parent.parent.GetTextByName("effectiveAll", window.parent.parent.useprameters.languagedata);


    function openGPS111() {
        var openGPS = document.getElementById("openGPS");
        var sendtimes = document.getElementById("sendtimes");
        var distanceNum = document.getElementById("distanceNum");
        var sendDestISSI = document.getElementById("sendDestISSI");
        if (openGPS.checked == true) {
            var closeGPS = document.getElementById("closeGPS");
            closeGPS.checked = false;
            isEnable = "1";
            sendDestISSI.disabled = distanceNum.disabled = sendtimes.disabled = false;
        } else {
            var closeGPS = document.getElementById("closeGPS");
            if (closeGPS.checked == false) {
                isEnable = "-1";
            } else { isEnable = "0";}
        }
    }

    function closeGPS111() {
        var closeGPS = document.getElementById("closeGPS");
        var sendtimes = document.getElementById("sendtimes");
        var distanceNum = document.getElementById("distanceNum");
        var sendDestISSI = document.getElementById("sendDestISSI");
        if (closeGPS.checked == true) {

            var openGPS = document.getElementById("openGPS");
            openGPS.checked = false;
            isEnable = "0";
            sendDestISSI.disabled = distanceNum.disabled = sendtimes.disabled = true;
            sendDestISSI.value = distanceNum.value = sendtimes.value = "";
        } else {
            var openGPS = document.getElementById("openGPS");
            sendDestISSI.disabled = distanceNum.disabled = sendtimes.disabled = false;
            if (openGPS.checked == false) {
                isEnable = "-1";
            } else { isEnable = "1"; }
        }
    }

    function IsOnlyShowChecked()
    {
        reroadpagetitle();
        renderTable();
    }

    var hasTETRA = false;
    var hasPDT = false;
    var hasBEIDOU = false;
    var hasLTE = false;

    function changeCycleToAll() {
        if (document.getElementById("applyToOther_Cycle").checked == false) {
            document.getElementById("Lang_SendUpDestISSI").disabled = true;
            document.getElementById("sendDestISSI").disabled = true;
            document.getElementById("sendDestISSI").value = "";
        } else {
            document.getElementById("Lang_SendUpDestISSI").disabled = false;
            document.getElementById("sendDestISSI").disabled = false;
        }
    }
    function applyToOther_Swtch() {//xzj--20181122--添加LTE用户全部有效勾选框的函数（原有函数名，没有函数定义，根据另一个全部有效勾选框猜测定义为控制距离门限）
       //不知道需求，老代码中只有一个函数名，建个空函数防止错误--xzj--20181123
    }

    function changeControlEnableOrDisable() {
        
        document.getElementById("Lang_GPS_Distance").disabled = true;
        document.getElementById("distanceNum").disabled = true;
        document.getElementById("distanceQuestion").disabled = true;
        

        document.getElementById("Lang_SendUpDestISSI").disabled = true;
        document.getElementById("sendDestISSI").disabled = true;
        document.getElementById("Beidou_model").disabled = true;
        document.getElementById("GPS_model").disabled = true;

        document.getElementById("span_TETRA").disabled = true;
        document.getElementById("span_PDT").disabled = true;
        document.getElementById("span_BEIDOU").disabled = true;
        document.getElementById("span_LTE").disabled = true;

        document.getElementById("TETRA_type").disabled = true;
        document.getElementById("TETRA_type").checked = false;
        document.getElementById("PDT_type").disabled = true;
        document.getElementById("PDT_type").checked = false;
        document.getElementById("BEIDOU_type").disabled = true;
        document.getElementById("BEIDOU_type").checked = false;
        document.getElementById("LTE_type").disabled = true;
        document.getElementById("LTE_type").checked = false;

        document.getElementById("applySpan_Switch").style.visibility = "hidden";
        document.getElementById("applyToOther_Cycle").style.visibility = "hidden";
        document.getElementById("applyToOther_Cycle").checked = true;
        document.getElementById("applyToOther").style.visibility = "hidden";
        document.getElementById("applyToOther_Switch").style.visibility = "hidden";

        hasTETRA = false;
        hasPDT = false;
        hasBEIDOU = false;
        hasLTE = false;

        if (SelectUsers.length > 0) {
            for (var i = 0; i < SelectUsers.length; i++) {
                if (SelectUsers[i].issitype.toString().trim() == "BEIDOU") {
                    document.getElementById("Beidou_model").disabled = false;
                    document.getElementById("GPS_model").disabled = false;
                    document.getElementById("Beidou_model").checked = false;
                    document.getElementById("GPS_model").checked = false;
                    document.getElementById("Lang_SendUpDestISSI").disabled = false;
                    document.getElementById("sendDestISSI").disabled = false;
                    document.getElementById("BEIDOU_type").disabled = false;
                    document.getElementById("BEIDOU_type").checked = true;
                    document.getElementById("span_TETRA").disabled = false;
                    document.getElementById("Lang_GPS_Distance").disabled = false;
                    document.getElementById("distanceNum").disabled = false;
                    document.getElementById("distanceQuestion").disabled = false;
                    hasBEIDOU = true;
                }
                if (SelectUsers[i].issitype.toString().trim() == "TETRA") {
                    document.getElementById("TETRA_type").disabled = false;
                    document.getElementById("TETRA_type").checked = true;
                    document.getElementById("span_TETRA").disabled = false;
                    document.getElementById("sendDestISSI").disabled = false;
                    document.getElementById("Lang_SendUpDestISSI").disabled = false;
                    document.getElementById("Lang_GPS_Distance").disabled = false;
                    document.getElementById("distanceNum").disabled = false;
                    document.getElementById("distanceQuestion").disabled = false;
                    hasTETRA = true;
                }
                if (SelectUsers[i].issitype.toString().trim() == "PDT") {
                    document.getElementById("PDT_type").disabled = false;
                    document.getElementById("PDT_type").checked = true;
                    document.getElementById("span_PDT").disabled = false;
                    document.getElementById("sendDestISSI").disabled = false;
                    document.getElementById("Lang_SendUpDestISSI").disabled = false;

                    document.getElementById("Lang_GPS_Distance").disabled = false;
                    document.getElementById("distanceNum").disabled = false;
                    document.getElementById("distanceQuestion").disabled = false;
                    hasPDT = true;
                }
                if (SelectUsers[i].issitype.toString().trim() == "LTE") {
                    document.getElementById("LTE_type").disabled = false;
                    document.getElementById("LTE_type").checked = true;
                    document.getElementById("applySpan_Switch").style.visibility = "visible";//xzj--20181123--未知需求，暂时隐藏，将visible改为hidden--20190114--再改为visible
                    document.getElementById("applyToOther_Cycle").style.visibility = "visible";
                    document.getElementById("applyToOther_Cycle").checked = false;
                    document.getElementById("applyToOther").style.visibility = "visible";
                    document.getElementById("applyToOther_Switch").style.visibility = "visible";//xzj--20181123--未知需求，暂时隐藏，将visible改为hidden--20190114--再改为visible
                    document.getElementById("span_LTE").disabled = false;
                    hasLTE = true;
                }
            }
            if (document.getElementById("applyToOther_Cycle").checked == false) {
                document.getElementById("Lang_SendUpDestISSI").disabled = true;
                document.getElementById("sendDestISSI").disabled = true;
                document.getElementById("sendDestISSI").value = "";
            }

            if (document.getElementById("Beidou_model").disabled == true && document.getElementById("GPS_model").disabled == true) {
                document.getElementById("Beidou_model").checked = false;
                document.getElementById("GPS_model").checked = true;
            }
        }
        else {
            document.getElementById("Beidou_model").disabled = true;
            document.getElementById("GPS_model").disabled = true;
            document.getElementById("Beidou_model").checked = false;
            document.getElementById("GPS_model").checked = false;
        }
    }

    function TETRA_click() {
        if (document.getElementById("TETRA_type").checked == true) {
            for (var i = 0; i < AllUsers.length; i++) {
                if (AllUsers[i].issitype.trim() == "TETRA") {
                    SelectUsers.push(AllUsers[i]);
                }
            }
        } else {
            while (removeUserByCheckBox("TETRA"))
            { }
        }
        changeControlEnableOrDisable();
        IsOnlyShowChecked();
    }

    function PDT_click() {
        if (document.getElementById("PDT_type").checked == true) {
            for (var i = 0; i < AllUsers.length; i++) {
                if (AllUsers[i].issitype.trim() == "PDT") {
                    SelectUsers.push(AllUsers[i]);
                }
            }
        } else {
            while (removeUserByCheckBox("PDT"))
            { }
        }
        changeControlEnableOrDisable();
        IsOnlyShowChecked();
    }

    function BEIDOU_click() {
        if (document.getElementById("BEIDOU_type").checked == true) {
            for (var i = 0; i < AllUsers.length; i++) {
                if (AllUsers[i].issitype.trim() == "BEIDOU") {
                    SelectUsers.push(AllUsers[i]);
                }
            }
        } else {
            while (removeUserByCheckBox("BEIDOU"))
            { }
        }
        changeControlEnableOrDisable();
        IsOnlyShowChecked();
    }

    function LTE_click() {
        if (document.getElementById("LTE_type").checked == true) {
            for (var i = 0; i < AllUsers.length; i++) {
                if (AllUsers[i].issitype.trim() == "LTE") {
                    SelectUsers.push(AllUsers[i]);
                    document.getElementById("applySpan_Switch").style.visibility = "visible";//xzj--20181123--未知需求，暂时隐藏，将visible改为hidden--20190114--再改为visible
                    document.getElementById("applyToOther_Cycle").style.visibility = "visible";
                    document.getElementById("applyToOther_Cycle").checked = false;
                    document.getElementById("applyToOther").style.visibility = "visible";
                    document.getElementById("applyToOther_Switch").style.visibility = "visible";//xzj--20181123--未知需求，暂时隐藏，将visible改为hidden--20190114--再改为visible
                }
            }
        } else {
            while (removeUserByCheckBox("LTE"))
            { }
            document.getElementById("applySpan_Switch").style.visibility = "hidden";
            document.getElementById("applyToOther_Cycle").style.visibility = "hidden";
            document.getElementById("applyToOther_Cycle").checked = true;
            document.getElementById("applyToOther").style.visibility = "hidden";
            document.getElementById("applyToOther_Switch").style.visibility = "hidden";
        }
        changeControlEnableOrDisable();
        IsOnlyShowChecked();
    }

    function removeUserByCheckBox(type)
    {
        var hasExist = false;
        for (var i = 0; i < SelectUsers.length; i++)
        {
            if (SelectUsers[i].issitype.trim() == type)
            {
                removeSelectUsers(i);
                // SelectUsers.splice(i, 1);
                hasExist = true;
                return hasExist;
            }
        }
        return hasExist;
    }
    var Invalid=window.parent.parent.GetTextByName("Invalid", window.parent.parent.useprameters.languagedata);

    function showEffectCycle(setNum, TETRA_Num, PDT_Num)
    {
        if (document.getElementById("applyToOther_Cycle").checked == true) {
            var show = "";
            var IsChecked = false;
            if (document.getElementById("TETRA_type").checked == true) {
                if(TETRA_Num==-1)
                { show += "TETRA:" + Invalid;}else
                show += "TETRA:" + TETRA_Num + "s";
                IsChecked = true;
            }
            if (document.getElementById("PDT_type").checked == true) {
                if (IsChecked) {
                    show += ";";
                }
                show += "PDT:" + PDT_Num + "s";
                IsChecked = true;
            }
            if (document.getElementById("BEIDOU_type").checked == true) {
                if (IsChecked) {
                    show += ";";
                }
                if(TETRA_Num==-1)
                { show += "BEIDOU:" + Invalid;}else
                show += "BEIDOU:" + TETRA_Num + "s";
                IsChecked = true;
            }
            if (document.getElementById("LTE_type").checked == true) {
                if (IsChecked) {
                    show += ";";
                } if(setNum<=0)
                { show += "LTE:" + Invalid;}else
                show += "LTE:" + setNum + "s";
                IsChecked = true;
            }
            this.document.getElementById("ssss").innerHTML = show;
        } else {
            if (document.getElementById("LTE_type").checked == true) {
              // $("#ssss").innerHTML = "LTE:" + setNum + "s";
                this.document.getElementById("ssss").innerHTML = "LTE:" + setNum + "s";
            }
        }
    }

    function showEffectDistance(TETRA_Num, PDT_Num) {
        var show = "";
        var IsChecked = false;
        if (document.getElementById("TETRA_type").checked == true) {
            show += "TETRA:" + TETRA_Num + "m";
            IsChecked = true;
        }
        if (document.getElementById("PDT_type").checked == true) {
            if (IsChecked) {
                show += ";";
            }
            show += "PDT:" + PDT_Num + "m";
            IsChecked = true;
        }
        if (document.getElementById("BEIDOU_type").checked == true) {
            if (IsChecked) {
                show += ";";
            }
            show += "BEIDOU:" + TETRA_Num + "m";
            IsChecked = true;
        }
        document.getElementById("span_sendDistance").innerHTML = show;
    }


    function changeTitle_Cycle()
    {
        if (ValiateInt(document.getElementById("sendtimes").value.toString().trim()) && document.getElementById("sendtimes").value.toString().trim() != "") {
            var sendTime = parseInt(document.getElementById("sendtimes").value.toString().trim());
            showEffectCycle(sendTime, getTETRA_Cycle(sendTime), getPDT_Cycle(sendTime));
        } else { window.document.getElementById("ssss").innerHTML = Invalid; }
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
          else if (num <= 100) {
              return parseInt(num / 2)*2;
          }
          else if (num < 153)
          { return 100; }
          else if (num <= 240) {
                  return parseInt(num / 3)*3;
          }
          else if (num < 405)
          { return 240; }
          else if (num <= 500) {
                  return parseInt(num / 5)*5;
          }
          else if (num < 1010)
          { return 500; }
          else if (num <= 1100) {
                  return parseInt(num / 10)*10;
          }
          else if (num < 3330)
          { return 1100; }
          else if (num <= 3750) {
                  return parseInt(num / 30)*30;
          }
          else if (num < 7200)
          { return 3750; }
          else if (num < 10800)
          { return 7200; }
          else
              return 10800;

      /*if (num < 0)
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
        if(num <= 0)
        { return -1;}
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
        if(num==0)
        {return -1;}
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
        else { return 3500;}
    }

    function changeTitle_Distance() {
        if (ValiateInt(document.getElementById("distanceNum").value.toString().trim()) && document.getElementById("distanceNum").value.toString().trim() != "") {
            var sendDistance = parseInt(document.getElementById("distanceNum").value.toString().trim());
            showEffectDistance(getTETRA_Distance(sendDistance), getPDT_Distance(sendDistance));
        } else { window.document.getElementById("span_sendDistance").innerHTML = Invalid; }
    }

    function view_Cycle() {
        window.parent.parent.mycallfunction('view_info/view_Cycle', 450, 600, 0, 2000);
        var num = 0;
        var CycleInterval = setInterval(function () {
            if (window.parent.parent.document.frames["view_info/view_Cycle_ifr"] != null && window.parent.parent.document.frames["view_info/view_Cycle_ifr"] != undefined && (typeof window.parent.parent.document.frames["view_info/view_Cycle_ifr"].toHTML).toString() != "undefined") {
                if (ValiateInt(document.getElementById("sendtimes").value.toString().trim()) && document.getElementById("sendtimes").value.toString().trim() != "") {
                    window.parent.parent.document.frames["view_info/view_Cycle_ifr"].toHTML(parseInt(document.getElementById("sendtimes").value.toString().trim()), true);
                    clearInterval(CycleInterval);
                } else { clearInterval(CycleInterval); }
            } else {
                if (num >= 5) { clearInterval(CycleInterval); }
                else { num++; }
            }
        }, 1000);
    }

    function view_Distance() {
        window.parent.parent.mycallfunction('view_info/view_Distance', 450, 600, 0, 2000);
        var num = 0;
        var DistanceInterval = setInterval(function () {
            if (window.parent.parent.document.frames["view_info/view_Distance_ifr"] != null && window.parent.parent.document.frames["view_info/view_Distance_ifr"]!=undefined&&(typeof window.parent.parent.document.frames["view_info/view_Distance_ifr"].toHTML).toString() != "undefined") {
                if (ValiateInt(document.getElementById("distanceNum").value.toString().trim()) && document.getElementById("distanceNum").value.toString().trim() != "") {
                    window.parent.parent.document.frames["view_info/view_Distance_ifr"].toHTML(parseInt(document.getElementById("distanceNum").value.toString().trim()), false);
                    clearInterval(DistanceInterval);
                } else { clearInterval(DistanceInterval); }
            } else {
                if (num >= 5) { clearInterval(DistanceInterval); }
                else { num++; }
            }
        }, 1000);
    }
</script>

<link href="../../CSS/lq_calloutExtender.css" rel="stylesheet" type="text/css" />
