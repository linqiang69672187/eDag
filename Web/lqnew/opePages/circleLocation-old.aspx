<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="circleLocation.aspx.cs" Inherits="Web.lqnew.opePages.circleLocation" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <link href="../../CSS/pagestyle.css" rel="stylesheet" type="text/css" />
    <link href="../css/lq_addedit.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/lq_calloutExtender.css" rel="stylesheet" type="text/css" />

    <script src="../js/geturl.js" type="text/javascript"></script>
    <script src="../../JQuery/jquery-1.5.2.js" type="text/javascript"></script>
    <script src="../../JS/LangueSwitch.js" type="text/javascript"></script>
    <script src="../js/StringPrototypeFunction.js" type="text/javascript"></script>
    <script src="../js/CommValidator.js" type="text/javascript"></script>

    <script type="text/javascript">
        var SelectUsers = new Array();
        var everypagecount = 50;
        var currentPage = 1;
        var totalPage = 1;
        var totalCounts = 0;


        var Lang_SendUpIntralMustInt = window.parent.parent.GetTextByName("Lang_SendUpIntralMustInt", window.parent.parent.useprameters.languagedata);
        var Lang_SendUpDestISSIMustInt = window.parent.parent.GetTextByName("Lang_SendUpDestISSIMustInt", window.parent.parent.useprameters.languagedata);
        var Lang_GPS_LangeOfDest = window.parent.parent.GetTextByName("Lang_GPS_LangeOfDest", window.parent.parent.useprameters.languagedata);
        var Lang_PullUpControlISDoing = window.parent.parent.GetTextByName("Lang_PullUpControlISDoing", window.parent.parent.useprameters.languagedata);
        var Lang_PleaseEnterPullUpParam = window.parent.parent.GetTextByName("Lang_PleaseEnterPullUpParam", window.parent.parent.useprameters.languagedata);
        var Lang_PullUpCycleMustTenTimes = window.parent.parent.GetTextByName("Lang_PullUpCycleMustTenTimes", window.parent.parent.useprameters.languagedata);
        var Lang_PullUpCountMustInt = window.parent.parent.GetTextByName("Lang_PullUpCountMustInt", window.parent.parent.useprameters.languagedata);
        var Lang_Illegal_ISSI_or_fail_to_mobile_user_bind = window.parent.parent.GetTextByName("Lang_Illegal_ISSI_or_fail_to_mobile_user_bind", window.parent.parent.useprameters.languagedata);
        var Lang_Illegal_terminal_identification = window.parent.parent.GetTextByName("Lang_Illegal_terminal_identification", window.parent.parent.useprameters.languagedata);
        var Delete = window.parent.parent.GetTextByName("Delete", window.parent.parent.useprameters.languagedata);
        var Lang_ThisRecordHasAdd = window.parent.parent.GetTextByName("Lang_ThisRecordHasAdd", window.parent.parent.useprameters.languagedata);
        var Memberscannotbeempty = window.parent.parent.GetTextByName("Memberscannotbeempty", window.parent.parent.useprameters.languagedata);
        var Lang_SendZLIsSendingPleaseSeeSysLogWindow = window.parent.parent.GetTextByName("Lang_SendZLIsSendingPleaseSeeSysLogWindow", window.parent.parent.useprameters.languagedata);
        var distanceMustInt = window.parent.parent.GetTextByName("distanceMustInt", window.parent.parent.useprameters.languagedata);
        var zzbj = window.parent.parent.GetTextByName("Total_CycleBiggerPullUp_Cycle", window.parent.parent.useprameters.languagedata);
        //添加成员
        function addSelectUsers(uname, uissi, utype, issitype) {
            if (issitype.toString().trim() != "PDT") {
                var Lang_Remove_LTE_user = window.parent.parent.GetTextByName("Lang_remove_user_not_PDT", window.parent.parent.useprameters.languagedata);
                alert(Lang_Remove_LTE_user);
                return;
            }
            SelectUsers.push({ uname: uname, uissi: uissi, utype: utype, issitype: issitype });
        }

        function CloseWindow() {
            window.parent.hiddenbg2();
            window.parent.mycallfunction('circleLocation');
        }

        function addMemberToSelectUsers() {
            var issi = document.getElementById("txtISSIText").value;
            for (var i = 0; i < SelectUsers.length; i++) {
                if (SelectUsers[i].uissi == issi) {
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
                    if (my[0].issitype.toString().trim() != "PDT") {
                        var Lang_Remove_LTE_user = window.parent.parent.GetTextByName("Lang_remove_user_not_PDT", window.parent.parent.useprameters.languagedata);
                        IsGoOn = false;
                        alert(Lang_Remove_LTE_user);
                    }
                    if (IsGoOn) {
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
                    strResult += "<tr><td align='center' style='width:70px'>" + SelectUsers[i].uname + "</td><td align='center' style='width:70px'>" + SelectUsers[i].uissi + "</td><td align='center' style='width:70px'>" + SelectUsers[i].utype + "</td><td align='center' style='width:90px'>" + SelectUsers[i].issitype + "</td><td align='center' style='width:90px'><span style='cursor:pointer;;color:red' onclick='DelUserMember(\"" + i + "\")'>" + Delete + "</span></td></tr>";
                }
            }
            strResult += "</table>";
            window.document.getElementById("div_selectUserList").innerHTML = strResult;
        }

        function DelUserMember(i) {
            SelectUsers.splice(i, 1);
            reroadpagetitle();
            renderTable();
        }

        function removeSelectUsers(i) {
            SelectUsers.splice(i, 1);
        }

        function reroadpagetitle() {
            totalCounts = SelectUsers.length;
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

        function scrollBottom() {
            document.getElementById("div_selectUserList").scrollTop = document.getElementById("div_selectUserList").scrollHeight;
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

        function OnAddMember() {
            window.parent.mycallfunction('AddMemberTree/add_Member', 650, 514, '0&ifr=circleLocation_ifr&selectcount=-1&type=user', 2001);
        }

        function IsTenTimes(time)
        {
            var x = parseFloat(time);
            x = x % 10;
            return (x > 0 ? false : true);
        }

        function checkInfo()
        {
            if (SelectUsers.length == 0) {
                alert(Memberscannotbeempty);
                return true;
            }
            var destissi = window.document.getElementById("sendDestISSI").value;
            if (destissi == "") {
               // window.document.getElementById("span_result").innerHTML = Lang_PleaseEnterPullUpParam;
                alert(Lang_PleaseEnterPullUpParam);
                return true;
            }
            if (!ValiateInt(destissi) && destissi != "") {
                //window.document.getElementById("span_result").innerHTML = Lang_SendUpDestISSIMustInt;
                alert(Lang_SendUpDestISSIMustInt);
                return true;
            }
            //if (parseInt(destissi) > 16777215 || parseInt(destissi) <= 0) {
            if (parseInt(destissi) > 99999999 || parseInt(destissi) <= 0) {
               // window.document.getElementById("span_result").innerHTML = Lang_GPS_LangeOfDest;
                alert(Lang_GPS_LangeOfDest);
                return true;
            }
            if (!ValiateInt(destissi) && destissi != "") {
                //window.document.getElementById("span_result").innerHTML = Lang_SendUpDestISSIMustInt;
                alert(Lang_SendUpDestISSIMustInt);
                return true;
            }
            var distanceNum = window.document.getElementById("distanceNum").value;
            if (distanceNum.trim() == "") {
                //window.document.getElementById("span_result").innerHTML = distanceMustInt;
                alert(distanceMustInt);
                return true;
            }
            if (!ValiateInt(distanceNum.trim()) && distanceNum.trim() != "") {
                //window.document.getElementById("span_result").innerHTML = distanceMustInt;
                alert(distanceMustInt);
                return true;
            }
            if (PullUpCount_textChange() == null)
            { return true;}
            return false;
        }

        function SendPullUPContralRequest() {
            //if (SelectUsers.length == 0) {
            //    alert(Memberscannotbeempty);
            //    return;
            //}
            //var destissi = window.document.getElementById("sendDestISSI").value;
            //if (destissi == "") {
            //    window.document.getElementById("span_result").innerHTML = Lang_PleaseEnterPullUpParam;
            //    return;
            //}
            //if (!ValiateInt(destissi) && destissi != "") {
            //    window.document.getElementById("span_destissi").innerHTML = Lang_SendUpDestISSIMustInt;
            //    return;
            //}
            //if (parseInt(destissi) > 16777215 || parseInt(destissi) <= 0) {
            //    window.document.getElementById("span_destissi").innerHTML = Lang_GPS_LangeOfDest;
            //    return;
            //}
            //if (!ValiateInt(destissi) && destissi != "") {
            //    window.document.getElementById("span_destissi").innerHTML = Lang_SendUpDestISSIMustInt;
            //    return;
            //}
            if (!checkInfo()) {
                var destissi = window.document.getElementById("sendDestISSI").value;
                var distanceNum = window.document.getElementById("distanceNum").value;
                var totleCycle = PullUpCount_textChange();
                var times = window.document.getElementById("PullUpCycle").value;
                hasNullTypeUser = false;
                IsNotPDTUser = false;
                checkUser_IsNotPDTOrNoType();
                alert(window.parent.parent.GetTextByName("Effective_Cycle_PullUp", window.parent.parent.useprameters.languagedata) + totleCycle);
                if (window.document.getElementById("openSwitch").checked == true) {
                    window.parent.sendPullUpControl(SelectUsers, "1", times, totleCycle, destissi.trim(), distanceNum.trim());
                } else { window.parent.sendPullUpControl(SelectUsers, "0", times, totleCycle, destissi.trim(), distanceNum.trim()); }
                alert(Lang_SendZLIsSendingPleaseSeeSysLogWindow);
                CloseWindow();
            }
        }

        function Cancel() {
            SelectUsers.length = 0;
            currentPage = 1;
            reroadpagetitle();
            renderTable();
        }

        var hasNullTypeUser = false;
        var IsNotPDTUser = false;
        function checkUser_IsNotPDTOrNoType() {
            for (var i = 0; i < SelectUsers.length; i++) {
                if (SelectUsers[i].issitype.toString().trim() == "" || SelectUsers[i].issitype.toString().trim() == null || SelectUsers[i].issitype.toString().trim() == undefined) {
                    hasNullTypeUser = true;
                    SelectUsers.splice(i, 1);
                    checkUser_IsNotPDTOrNoType();
                    return;
                }
                if (SelectUsers[i].issitype.toString().trim() != "PDT") {
                    IsNotPDTUser = true;
                    SelectUsers.splice(i, 1);
                    checkUser_IsNotPDTOrNoType();
                    return;
                }
            }
            if (hasNullTypeUser) {
                var Lang_remove_user_no_type = window.parent.parent.GetTextByName("Lang_remove_user_no_type", window.parent.parent.useprameters.languagedata);
                alert(Lang_remove_user_no_type);
            }
            if (IsNotPDTUser) {
                var Lang_remove_user_not_PDT = window.parent.parent.GetTextByName("Lang_remove_user_not_PDT", window.parent.parent.useprameters.languagedata);
                alert(Lang_remove_user_not_PDT);
            }
        }

        var IsPullUpCycle = false;
        
        function PullUpCount_textChange() {
            var cycle = window.document.getElementById("PullUpCycle").value;
            if (IsPullUpCycle) {
                var totleCycle = parseInt(document.getElementById("PullUpCount").value.toString());
                if (isNaN(totleCycle)) {
                    alert(window.parent.parent.GetTextByName("Effective_Cycle_NotNul", window.parent.parent.useprameters.languagedata));
                    return null;
                
                }
                if (!IsTenTimes(cycle) || cycle == "" || parseInt(cycle) <= 0 || isNaN(parseInt(cycle))) {
                    //window.document.getElementById("span_PullUpCycle").innerHTML = Lang_PullUpCycleMustTenTimes;
                    alert(Lang_PullUpCycleMustTenTimes);
                    return null;
                } else { window.document.getElementById("span_PullUpCycle").innerHTML = ""; }
                if (totleCycle < cycle) {
                    alert(window.parent.parent.GetTextByName("Total_CycleBiggerPullUp_Cycle", window.parent.parent.useprameters.languagedata));
                    return null;
                }
                var temp = parseInt(totleCycle / cycle);
                var effective_Cycle = temp * cycle;
                // if (isNaN(effective_Cycle)) { effective_Cycle = '无';}
                
                
                return effective_Cycle;
            } else {
                document.getElementById("show_effectCircle").innerHTML = "";
                var counts = window.document.getElementById("PullUpCount").value;
                if (counts == "" || cycle == "" || counts == undefined || cycle == undefined) {
                    window.document.getElementById("span_result").innerHTML = Lang_PleaseEnterPullUpParam;
                    return null;
                } else { window.document.getElementById("span_PullUpCycle").innerHTML = ""; }
                if (!IsTenTimes(cycle) || cycle == "" || parseInt(cycle) <= 0) {
                    window.document.getElementById("span_PullUpCycle").innerHTML = Lang_PullUpCycleMustTenTimes;
                    return null;
                } else { window.document.getElementById("span_PullUpCycle").innerHTML = ""; }
                if (!ValiateInt(counts) || counts == "" || parseInt(counts) <= 0) {
                    window.document.getElementById("span_PullUpCount").innerHTML = Lang_PullUpCountMustInt;
                    return null;
                } else { window.document.getElementById("span_PullUpCount").innerHTML = ""; }
                var effective_Cycle = counts * cycle;
               
                return effective_Cycle;
            }
        }

        $(document).ready(function () {
            if (window.parent.isSendingPullUpControl) {
                alert(Lang_PullUpControlISDoing);
                CloseWindow();
                return;
            }
            window.parent.visiablebg2();
            if (document.getElementById("hiduserinfo").value != "") {
                var users = document.getElementById("hiduserinfo").value.split(";");

                for (var i = 0; i < users.length; i++) {
                    var sx = users[i].split(",");
                    if (sx[3].toString().trim() == "PDT") {
                        addSelectUsers(sx[0], sx[1], sx[2], sx[3]);
                    }
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
            if (div1 && event.button == 1 && dragEnable == 'True') {
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

        function faterdo(retrunissis) {
            SelectUsers.length = 0;
            var hasNotPDT = false;
            for (var i = 0; i < retrunissis.length; i++) {
                if (retrunissis[i].issitype.toString().trim() != "PDT") {
                    hasNotPDT = true;
                    continue;
                }
                addSelectUsers(retrunissis[i].uname, retrunissis[i].uissi, retrunissis[i].utype, retrunissis[i].issitype);
            }
            if (hasNotPDT)
            {
                var Lang_Remove_LTE_user = window.parent.parent.GetTextByName("Lang_remove_user_not_PDT", window.parent.parent.useprameters.languagedata);
                alert(Lang_Remove_LTE_user);
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
        document.onkeypress = function () {
            if (event.keyCode == 13) {
                event.keyCode = 0;
                event.returnValue = false;
                addMemberToSelectUsers();
            }
        }
    </script>
</head>
<body onselect="return false">
    <form id="form1" runat="server">
    <div>
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
            <td height="30">
                <div id="divdrag" style="cursor:move">
                    <table width="100%" border="0" cellpadding="0" cellspacing="0">
                        <tr>
                            <td width="15" height="32">
                                <img alt="" src="../images/tab_03.png" width="15" height="32" />
                            </td>
                            <td width="1101" height="32" background="../images/tab_05.gif">
                                <ul class="hor_ul">
                                    <li>
                                        <img alt="" src="../images/037.gif" /><span id="Lang_PullUp_Control"></span>
                                    </li>
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
                <table width="100%" border="0" cellpadding="0" cellspacing="0">
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
                                        <input type="text" id="txtISSIText" runat="server" /><input onclick="addMemberToSelectUsers()" type="button" id="aLang-Add" value="添加" />
                                        <input type="hidden" id="hiduserinfo" runat="server" />
                                         <table style="width: 400px; border-top: solid; border-top-color: mediumseagreen; border-top-width: 1px">
                                            <tr>
                                                <td align="left" colspan="4" style="width: 270px"><span onclick="firstPage()" class="YangdjPageStyle" id="Lang_FirstPage">首页</span>&nbsp;&nbsp;<span onclick="prePage()" class="YangdjPageStyle" id="Lang_PrePage">上一页</span>&nbsp;&nbsp;<span onclick="nextPage()" class="YangdjPageStyle" id="Lang_play_next_page">下一页</span>&nbsp;&nbsp;<span onclick="lastPage()" class="YangdjPageStyle" id="Lang_LastPage">尾页</span></td>
                                                <td align="right">
                                                    <select onchange="tzpage()" id="sel_page"></select>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right" colspan="5">
                                                    <span id="span_page"></span>
                                                    <span id="span_currentPage">0</span>/<span id="span_totalpage">0</span>&nbsp;&nbsp;&nbsp;
                                                    <span id="span_Article"></span>
                                                    <span id="span_currentact">0~0</span>/<span id="span_total">0</span>
                                                </td>
                                            </tr>
                                            <tr class="gridheadcss">
                                                <th align="center" style="width: 70px; background-color: ActiveBorder"><span id="Lang_Name">名称</span></th>
                                                <th align="center" style="width: 70px; background-color: ActiveBorder"><span id="txtISSIText1">终端号码</span></th>
                                                <th align="center" style="width: 70px; background-color: ActiveBorder"><span id="Lang_style">用户类型</span></th>
                                                <th align="center" style="width: 90px; background-color: ActiveBorder"><span id="Lang_ISSItype">终端类型</span></th>
                                                <th align="center" style="background-color: ActiveBorder" colspan="2"><span id="Lang_Operater"></span></th>
                                            </tr>
                                        </table>
                                        <div id="div_selectUserList" style="position: absolute; top: 126px; width: 400px; height: 158px; background-color: azure; overflow: auto"></div>
                                    </td>
                                    <td align="left" style="width: 80px;">
                                            <img alt="" src="<%--../images/chooseMember0.png--%>" id="imgSelectUser" onclick="OnAddMember()" onmouseover="<%--javascript:this.src='../images/chooseMember_un.png';--%>"
                                                onmouseout="<%--javascript:this.src='../images/chooseMember0.png';--%>" />&nbsp;
                                    </td>
                                 </tr> 
                                 <tr style="display: inline">
                                    <td>
                                        <span id="switchSpan">GPS上拉控制</span>
                                    </td>
                                    <td align="left" colspan="2">
                                       <%-- <asp:RadioButton Text="已激活" ID="openSwitch" runat="server" Checked="true"/>
                                        <asp:RadioButton Text="去激活" ID="closeSwitch" runat="server"/>--%>
                                        <input type="radio" id="openSwitch" name="switch" checked="checked" /><span id="Lang_Open"></span>&nbsp;&nbsp;
                                        <input type="radio" id="closeSwitch" name="switch" /><span id="sssssssss"></span>
                                    </td>
                                </tr>
                                 <tr>
                                    <td>
                                        <span id="PullUpStyle">有效期</span>
                                    </td>
                                    <td align="left" colspan="2">
                                        <input type="text" value="" id="PullUpCount" onchange="PullUpCount_textChange()" runat="server"/><span id="show_effectCircle" style="color:red"></span>&nbsp;&nbsp;<span id="span_PullUpCount" style="color: red"></span>
                                    </td>
                                </tr>
                                <tr style="display: inline">
                                    <td>
                                        <span id="Lang_PullUpCycle">上拉周期</span>
                                    </td>
                                    <td align="left" colspan="2">
                                        <input type="text" id="PullUpCycle" />S<span style="color: red" id="explain_PullUpCycle">* 10秒的倍数</span>&nbsp;&nbsp;<span id="span_PullUpCycle" style="color: red"></span>
                                    </td>
                                </tr>
                                <tr style="display: inline">
                                    <td>
                                        <span id="distance">上拉距离</span>
                                    </td>
                                    <td align="left" colspan="2">
                                        <input type="text" id="distanceNum" style="width:80px;"/>m
                                    </td>
                                </tr>
                                <tr id="Tr1">
                                    <td>
                                        <span id="Lang_GPSPullDestISSI">GPS上拉目的地</span>
                                    </td>
                                    <td align="left" colspan="2">
                                        <input type="text" value="16777213" id="sendDestISSI" /><span style="color: red" id="GPS_ID_Destination_warn"></span>&nbsp;&nbsp;<span id="span_destissi" style="color: red"></span>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="style3" align="center" colspan="3">
                                        <table>
                                            <tr>
                                                <%--<td>
                                                    <button class="CALLBUTTON1" id="start" style="text-align: center; cursor: pointer;"
                                                        onclick="SendPullUPContralRequest()">
                                                       </button>
                                                </td>
                                                <td>
                                                    <button class="CALLBUTTON1" id="BeCancel" style="text-align: center; cursor: pointer;"
                                                        onclick="Cancel()">
                                                       </button>
                                                </td>--%>
                                                 <td>
                                                    <img id="start" src="../images/add_ok.png" onclick="SendPullUPContralRequest()" style="cursor: hand;" />&nbsp;&nbsp;&nbsp;
                                                </td>
                                                <td>
                                                    <img id="BeCancel"  style="cursor: hand;" onclick=" window.parent.hiddenbg2();window.parent.mycallfunction('circleLocation');" src="../images/add_cancel.png" />
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

    var image = window.document.getElementById("imgSelectUser");
    var srouce = "../" + window.parent.parent.GetTextByName("Lang_chooseMemberPNG", window.parent.parent.useprameters.languagedata);
    image.setAttribute("src", srouce);
    var strpath = "../" + window.parent.parent.GetTextByName("Lang_chooseMemberPNG", window.parent.parent.useprameters.languagedata);
    var strpathmove = "../" + window.parent.parent.GetTextByName("Lang_chooseMemberPNG_un", window.parent.parent.useprameters.languagedata);
    image.onmousemove = function () { this.src = strpathmove }//"javascript:this.src='../../images/btn_add_un.png'";// onmouse_move();
    image.onmouseout = function () { this.src = strpath }//"javascript:this.src='../../images/btn_add.png'";//  onmouse_out();

    window.document.getElementById("usermember").innerHTML = window.parent.parent.GetTextByName("usermember", window.parent.parent.useprameters.languagedata);
    window.document.getElementById("span_page").innerHTML = window.parent.parent.GetTextByName("Page", window.parent.parent.useprameters.languagedata);
    window.document.getElementById("span_Article").innerHTML = window.parent.parent.GetTextByName("Article", window.parent.parent.useprameters.languagedata);
    window.document.getElementById("aLang-Add").value = window.parent.parent.GetTextByName("Lang-Add", window.parent.parent.useprameters.languagedata);
    window.document.getElementById("txtISSIText1").innerHTML = window.parent.parent.GetTextByName("Lang_ISSS", window.parent.parent.useprameters.languagedata);
    window.document.getElementById("Lang_ISSItype").innerHTML = window.parent.parent.GetTextByName("Lang_TerminalType", window.parent.parent.useprameters.languagedata);
    //window.document.getElementById("start").innerHTML = window.parent.parent.GetTextByName("Start", window.parent.parent.useprameters.languagedata);
    //window.document.getElementById("BeCancel").innerHTML = window.parent.parent.GetTextByName("BeCancel", window.parent.parent.useprameters.languagedata);
    //window.document.getElementById("DestIssi").style.height = "0px";
    window.document.getElementById("Lang_PullUpCycle").innerHTML = window.parent.parent.GetTextByName("PullUp_Cycle", window.parent.parent.useprameters.languagedata);
    //window.document.getElementById("Lang_PullUp_Way").innerHTML = window.parent.parent.GetTextByName("Lang_PullUp_Style", window.parent.parent.useprameters.languagedata);
    window.document.getElementById("explain_PullUpCycle").innerHTML = window.parent.parent.GetTextByName("Lang_PullUpCycleMustTenTimes", window.parent.parent.useprameters.languagedata);
    window.document.getElementById("switchSpan").innerHTML = window.parent.parent.GetTextByName("Lang_GPSPullEnableOrDisable", window.parent.parent.useprameters.languagedata);
    window.document.getElementById("Lang_Open").innerHTML = window.parent.parent.GetTextByName("Single_Open", window.parent.parent.useprameters.languagedata);
    window.document.getElementById("sssssssss").innerHTML = window.parent.parent.GetTextByName("Closebtn", window.parent.parent.useprameters.languagedata);

    window.document.getElementById("Lang_GPSPullDestISSI").innerHTML = window.parent.parent.GetTextByName("Lang_GPSPullDestISSI", window.parent.parent.useprameters.languagedata);
    window.document.getElementById("distance").innerHTML = window.parent.parent.GetTextByName("Lang_Distance_CycleLocation_PullUp", window.parent.parent.useprameters.languagedata);

    window.document.getElementById("show_effectCircle").innerHTML = zzbj;
    //var sel_optin = window.document.getElementById("sel_PullUp_Style");
    //var option1 = document.createElement("option");
    //option1.value = "0";
    //option1.innerHTML = window.parent.parent.GetTextByName("PullUp_Total_Count", window.parent.parent.useprameters.languagedata);
    //sel_optin.appendChild(option1);
    //var option2 = document.createElement("option");
    //window.document.getElementById("PullUpStyle").innerHTML = window.parent.parent.GetTextByName("PullUp_Total_Count", window.parent.parent.useprameters.languagedata);
    //option2.value = "1";
    //option2.innerHTML = window.parent.parent.GetTextByName("PullUp_Total_Cycle", window.parent.parent.useprameters.languagedata);
    //sel_optin.appendChild(option2);
    //sel_optin.onchange = function () {
    //    if (sel_optin.selectedIndex == 0) {
            //window.document.getElementById("PullUpStyle").innerHTML = window.parent.parent.GetTextByName("PullUp_Total_Count", window.parent.parent.useprameters.languagedata);
            //IsPullUpCycle = false;
    //    } else {
            window.document.getElementById("PullUpStyle").innerHTML = window.parent.parent.GetTextByName("PullUp_Total_Cycle", window.parent.parent.useprameters.languagedata);
            IsPullUpCycle = true;
    //    }
    //}

    function changeTitle_Distance() {
        if (ValiateInt(document.getElementById("distanceNum").value.toString().trim()) && document.getElementById("distanceNum").value.toString().trim() != "") {
            var sendDistance = parseInt(document.getElementById("distanceNum").value.toString().trim());
            showEffectDistance(sendDistance, getTETRA_Distance(sendDistance), getPDT_Distance(sendDistance));
        } else { window.document.getElementById("span_sendDistance").innerHTML = Invalid; }
    }

    function view_Distance() {
        window.parent.parent.mycallfunction('view_info/View_Cycle', 450, 600);
        var parInterval = setInterval(function () {
            if (document.frames["view_info/View_Cycle_ifr"] != null || document.frames["view_info/View_Cycle_ifr"] != undefined) {
                if ((typeof document.frames["view_info/View_Cycle_ifr"].toHTML).toString() != "undefined") {
                    if (ValiateInt(document.getElementById("distanceNum").value.toString().trim()) && document.getElementById("distanceNum").value.toString().trim() != "") {
                        document.frames["view_info/View_Cycle_ifr"].toHTML(parseInt(document.getElementById("distanceNum").value.toString().trim()), false);
                    }
                }
            }
            clearInterval(parInterval);
        }, 500);
    }
</script>