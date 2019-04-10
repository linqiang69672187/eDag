<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SearchGpsPullStatues.aspx.cs" Inherits="Web.lqnew.opePages.SearchGpsPullStatues" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="../../JS/LangueSwitch.js" type="text/javascript"></script>
    <link href="../css/lq_manager.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/pagestyle.css" rel="stylesheet" type="text/css" />
    <script src="../js/geturl.js" type="text/javascript"></script>
    <script src="../js/dragwindow.js" type="text/javascript"></script>
    <script src="../../JQuery/jquery-1.5.2.js" type="text/javascript"></script>
    <script src="../js/manageStopSelectSubmit.js" type="text/javascript"></script>
    <link href="../../../CSS/ui-lightness/jquery-ui-1.8.13.custom.css" rel="stylesheet"
        type="text/css" />
    <script src="../../JQuery/jquery-ui-1.8.13.custom.min.js" type="text/javascript"></script>
    <script src="../js/Rediocall.js" type="text/javascript"></script>
    <%if (System.Configuration.ConfigurationManager.AppSettings["defaultLanguage"] == "zh-CN")
      { %>
    <script src="../../JQuery/ui.datepicker-zh-CN.js" type="text/javascript"></script>
    <%} %>
    <script type="text/javascript">

        var Lang_loading = window.parent.parent.GetTextByName("Lang_loading", window.parent.parent.useprameters.languagedata);
        var LangNone = window.parent.parent.GetTextByName("Lang-None", window.parent.parent.useprameters.languagedata);
        var Unkown = window.parent.parent.GetTextByName("Unkown", window.parent.parent.useprameters.languagedata);
        var Undo = window.parent.parent.GetTextByName("Undo", window.parent.parent.useprameters.languagedata);
        var arrayISSI = new Array();
        var everypagecount = 10;
        var currentPage = 1;
        var totalPage = 1;
        var totalCounts = 0;

        var selentityid = "";
        var selissiorname = "";
        var selfun = "";
        var selStatues = "";
        var begtime = "";
        var endtime = "";
        var PUStatus = "";
        var PUResult = "";

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

            $("#Tbody1").append("<tr id='isprocessing' style='background-color:White;height:22px;color:red'><td colspan='9' >" + Lang_loading + "</td></tr>");
            window.parent.jquerygetNewData_ajax("../../Handlers/GetGPSPullStatusList.ashx", { begtime: begtime, endtime: endtime, PageIndex: currentPage, Limit: everypagecount, selentity: selentityid, selwhere: selissiorname, selfun: selfun, selStatues: selStatues }, function (msg) {
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
                        if (CheckMember[j] == msg.data[i].id) {
                            strcheck = " checked = 'checked'";
                        }
                    }
                    switch (msg.data[i].Result) {
                        case "1":
                            PUResult = "处理中，网关响应成功";
                            break;
                        case "2":
                            PUResult = "成功，终端响应成功";
                            break;
                        case "3":
                            PUResult = "失败，网关响应超时";
                            break;
                        case "5":
                            PUResult = "失败，去激活响应失败";
                            break;
                        case "6":
                            PUResult = "成功，去激活响应成功";
                            break;
                        default:
                            PUResult = "激活失败";
                            break;
                    }
                    switch (msg.data[i].PullStatus) {
                        case "1":
                            PUStatus = "正在上拉";
                            break;
                        default:
                            PUStatus = "未操作";
                            break;
                    }
                    if (msg.data[i].ipAddress != null && msg.data[i].ipAddress.toString().trim() != "" && msg.data[i].ipAddress != undefined && msg.data[i].ipAddress.toString().trim() != "0.0.0.0" && msg.data[i].ipAddress.toString().trim() != "0.0.0.0:0") {
                        $("#Tbody1").append("<tr id=" + msg.data[i].SrcISSI + " onmouseover='changeTgBg(this,&#39;font&#39;)' onmouseout='overchangeTgBg(this,&#39;font&#39;)' style='background-color:White;height:22px;'><td><input id='checkbox_" + msg.data[i].SrcISSI + "' type='checkbox' " + strcheck + " onclick='onclickCheckBoxp(this)' value='" + msg.data[i].id + "' /></td><td align='center' style='cursor: hand;'  >" + msg.data[i].SrcISSI + "</td><td  align='center'>" + msg.data[i].CreateTime + "</td><td  align='center'>" + msg.data[i].OperateTime + "</td><td align='center'>" + msg.data[i].Expire + "</td><td  align='center'>" + msg.data[i].Period + "</td><td align='center' >" + msg.data[i].DstISSI + "</td><td align='center' >" + PUResult + "</td><td align='center' >" + PUStatus + "</td></tr>");
                    } else {
                        $("#Tbody1").append("<tr id=" + msg.data[i].SrcISSI + " onmouseover='changeTgBg(this,&#39;font&#39;)' onmouseout='overchangeTgBg(this,&#39;font&#39;)' style='background-color:White;height:22px;'><td><input id='checkbox_" + msg.data[i].SrcISSI + "' type='checkbox' " + strcheck + " onclick='onclickCheckBoxp(this)' value='" + msg.data[i].id + "' /></td><td align='center' style='cursor: hand;'  >" + msg.data[i].SrcISSI + "</td><td  align='center'>" + msg.data[i].CreateTime + "</td><td  align='center'>" + msg.data[i].OperateTime + "</td><td align='center'>" + msg.data[i].Expire + "</td><td  align='center'>" + msg.data[i].Period + "</td><td align='center' >" + msg.data[i].DstISSI + "</td><td align='center' >" + PUResult + "</td><td align='center' >" + PUStatus + "</td></tr>");
                    }
                    arrayISSI.push(msg.data[i].SrcISSI); 
                }
                tocheckall();
            });
        }
        var ISSIFieldMust = window.parent.parent.GetTextByName("ISSIFieldMust", window.parent.parent.useprameters.languagedata);
        var Lang_Illegal_ISSI = window.parent.parent.GetTextByName("Lang_Illegal_ISSI", window.parent.parent.useprameters.languagedata);

        //function viewLTEStatues(issi, dest, successOrFail) {
        //    if (issi == "" || issi == null || issi == undefined) {
        //        alert(ISSIFieldMust);
        //        return;
        //    }
        //    if (/[^\d]/.test(issi)) {
        //        alert(Lang_Illegal_ISSI);   //("非法ISSI");
        //        return;
        //    }
        //    //var IsSucceed = false; //false表示失败，true表示成功
        //    //if (successOrFail == window.parent.parent.GetTextByName("Unkown", window.parent.parent.useprameters.languagedata))
        //    //{
        //    //    IsSucceed = false;
        //    //} else if (successOrFail == window.parent.parent.GetTextByName("Failed", window.parent.parent.useprameters.languagedata)) {
        //    //    IsSucceed = false;
        //    //} else if (successOrFail == window.parent.parent.GetTextByName("Success", window.parent.parent.useprameters.languagedata)) {
        //    //    IsSucceed = true;
        //    //}
        //    //getLTEStautes(issi, dest, IsSucceed);
        //    window.parent.parent.getLTEStautes(issi, dest, true);
        //}

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
            window.parent.document.getElementById("sendgpspullcontralhidsids").value = sid;
            window.parent.mycallfunction('circleLocation', 580, 700, '', 1999);
            window.parent.SendGPSPullContralFrom.submit();
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
                //if (begtime != "") {
                //    begtime = begtime + " " + $("#begSelectHour").val() + ":" + $("#BegSelectMinu").val() + ":00";
                //}
                //if (endtime != "") {
                //    endtime = endtime + " " + $("#endSelectHour").val() + ":" + $("#endSelectMinu").val() + ":00";
                //}
                window.parent.jquerygetNewData_ajax("../../Handlers/GetGPSPullStatusList.ashx", { begtime: begtime, endtime: endtime, PageIndex: 1, Limit: 100000000, selentity: selentityid, selwhere: selissiorname, selfun: selfun, selStatues: selStatues }, function (msg) {
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

                    if (dd[j].type == "checkbox" && !dd[j].checked) {
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
            selentityid = window.document.getElementById("ddlentity").value;
            selissiorname = window.document.getElementById("txtNameOrIssi").value;
            //selfun = document.getElementById("selFunc").value;
            //selStatues = document.getElementById("SelStatues").value;
            begtime = document.getElementById("begTime").value;
            endtime = document.getElementById("endTime").value;
            if (begtime != "") {
                begtime = begtime + " " + $("#begSelectHour").val() + ":" + $("#BegSelectMinu").val() + ":00";
            }
            if (endtime != "") {
                endtime = endtime + " " + $("#endSelectHour").val() + ":" + $("#endSelectMinu").val() + ":00";
            }
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
            //document.getElementById("sel_page").value = currentPage;
            //reloadSel_Page();
        }
        function prePage() {
            if (currentPage <= 1) {
                return;
            }
            currentPage--;
            getData();
            //document.getElementById("sel_page").value = currentPage;
            //reloadSel_Page();
        }
        function firstPage() {
            if (currentPage == 1) {
                return;
            }
            currentPage = 1;
            getData();
            //document.getElementById("sel_page").value = currentPage;
            //reloadSel_Page();
        }
        function lastPage() {
            if (currentPage == totalPage) {
                return;
            }
            currentPage = totalPage;
            getData();
            //document.getElementById("sel_page").value = currentPage;
            //reloadSel_Page();
        }
        function tzpage() {

            var sel = document.getElementById("sel_page").value;

            if (sel == currentPage) {
                return;
            }
            currentPage = sel;
            getData();
            //document.getElementById("sel_page").value = currentPage;
            //reloadSel_Page();
        }
        var Single_Open = window.parent.parent.GetTextByName("Single_Open", window.parent.parent.useprameters.languagedata);
        var Closebtn = window.parent.parent.GetTextByName("Closebtn", window.parent.parent.useprameters.languagedata);
        var Success = window.parent.parent.GetTextByName("Success", window.parent.parent.useprameters.languagedata);
        var Unkown = window.parent.parent.GetTextByName("Unkown", window.parent.parent.useprameters.languagedata);
        var Failed = window.parent.parent.GetTextByName("Failed", window.parent.parent.useprameters.languagedata);

        function delBegtime() {
            window.document.getElementById("begTime").value = "";
            window.document.getElementById("begSelectHour").selectedIndex = 0;
            window.document.getElementById("BegSelectMinu").selectedIndex = 0;
        }
        function delEndtime() {
            window.document.getElementById("endTime").value = "";
            window.document.getElementById("endSelectHour").selectedIndex = 0;
            window.document.getElementById("endSelectMinu").selectedIndex = 0;
        }
    </script>

</head>
<body style="height: 430px" onselectstart="return false;">
    <form id="form2" runat="server">
        <div>
            <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
                <tr>
                    <td height="30">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr id="derppp">
                                <td width="15" height="32">
                                    <img src="../images/tab_03.png" width="15" height="32" />
                                </td>
                                <td width="1101" background="../images/tab_05.gif">
                                    <ul class="hor_ul" id="userul2" runat="server">
                                        <li>
                                            <img src="../images/311.gif" width="16" height="16" /><span id="Lang_GPSPullList">控制列表</span></li>

                                    </ul>
                                </td>
                                <td width="50" background="../images/tab_05.gif" align="right">
                                    <img style="cursor: pointer;" onclick="window.parent.mycallfunction('SearchGpsPullStatues',693, 702)"
                                        onmouseover="javascript:this.src='../images/close_un.png';" onmouseout="javascript:this.src='../images/close.png';"
                                        src="../images/close.png" />
                                </td>
                                <td width="14">
                                    <img src="../images/tab_07.png" width="14" height="32" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td width="15" background="../images/tab_12.gif">&nbsp;
                                </td>
                                <td align="center" valign="top" style="height: 300px; background-color: white" id="dragtd">

                                    <table cellspacing="1" cellpadding="0" id="GridView1" style="background-color: #C0DE98; border-color: White; border-width: 0px; border-style: Ridge; width: 99%;">
                                        <tr style="color: blue; background-color: White; height: 28px;">
                                            <th style="font-family: Arial" scope="col" colspan="9" align="right">
                                                <table style="width: 100%">
                                                    <tr>
                                                        <td colspan="2" align="left">
                                                            <asp:DropDownList ID="ddlentity" Width="240px" runat="server">
                                                                <asp:ListItem Value="0">选择所属单位</asp:ListItem>
                                                            </asp:DropDownList>

                                                        </td>
                                                        <td align="right" colspan="1" style="width: 100px;">
                                                            <span id="pp">name or issi</span>
                                                        </td>
                                                        <td style="width: 150px" align="left">
                                                            <input id="txtNameOrIssi" style="width: 150px" />
                                                        </td>
                                                        <%--未启用代码
                                                          <td align="left" colspan="2">
                                                                    <select id="selFunc" onchange="selfunOnChange()" class="">
                                                                        <option id="Lang_all_searchoption" value="-1"></option>
                                                                        <option id="Lang_GPSSwitch" value="1"></option>
                                                                        <option id="Lang_GPSDest" value="0"></option>
                                                                        <option id="Lang_GPSCritical" value="2"></option>
                                                                        <option id="Lang_GPS_Mode_Modify" value="3"></option>
                                                                        <option id="Lang_GPS_Distance_Modify" value="4"></option>
                                                                    </select>
                                                          
                                                                <div id="listatues" style="display:none">

                                                                    <select id="SelStatues" onchange="" class="">
                                                                        <option id="opSuccess" value="1"></option>
                                                                        <option id="opFailed" value="0"></option>
                                                                        <option id="opUnknow" value="-1"></option>
                                                                    </select>
                                                              </div>
                                                              

                                                        
                                                        </td>--%>
                                                    </tr>
                                                    <tr>
                                                        <td align="left" style="width: 60px">
                                                            <span id="Lang_BegTime">开始时间</span>
                                                        </td>
                                                        <td align="left" style="width: 200px">
                                                            <input readonly="readonly" type="text" style="width: 80px; ime-mode: disabled" id="begTime" class="Wdate" onfocus="" />
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
                                                            </select>:
                                                <select id="BegSelectMinu" style="width: 40px; height: 20px">
                                                </select><img onclick="delBegtime()" style="cursor: pointer" src="../images/close.png" />
                                                        </td>
                                                        <td align="right" style="width: 80px">
                                                            <span id="Lang_EndTime">结束时间</span>
                                                        </td>
                                                        <td align="left" style="width: 200px">
                                                            <input readonly="readonly" type="text" style="width: 80px;" id="endTime" class="Wdate" onfocus="" />
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
                                                                <option value="23">23</option>
                                                            </select>:
                                                <select id="endSelectMinu" style="width: 40px; height: 20px">
                                                </select><img alt="d" onclick="delEndtime()" style="cursor: pointer" src="../images/close.png" />
                                                        </td>
                                                        <td align="left">
                                                            <img alt="t" id="Lang_Search2" style="cursor: pointer" onclick="searchList()" />


                                                        </td>
                                                    </tr>
                                                </table>
                                            </th>
                                        </tr>
                                        <tr style="color: blue; background-color: White; height: 28px;">

                                            <th style="font-family: Arial" scope="col" colspan="9" align="right">
                                                <table style="width: 100%">
                                                    <tr>
                                                        <td align="center" style="width: 4%">
                                                            <input type="checkbox" id="checkAll" onclick="onclickSelectAll(this)" />
                                                        </td>
                                                        <td align="left" style="width: 45%">
                                                            <input type="button" id="btn_Open" onclick="openclick()" />&nbsp;&nbsp;
                                                        </td>
                                                        <td align="right" style="width: 28%">
                                                            <span onclick="firstPage()" class="YangdjPageStyle" id="Lang_FirstPage">首页</span>&nbsp;&nbsp;<span onclick="prePage()" class="YangdjPageStyle" id="Lang_PrePage">上一页</span>&nbsp;&nbsp;<span onclick="nextPage()" class="YangdjPageStyle" id="Lang_play_next_page">下一页</span>&nbsp;&nbsp;<span onclick="lastPage()" class="YangdjPageStyle" id="Lang_LastPage">尾页</span>
                                                        </td>
                                                        <td align="right" style="width: 7%">

                                                            <select onchange="tzpage()" id="sel_page"></select>
                                                        </td>
                                                        <td align="right" style="width: 20%">
                                                            <span id="span_page"></span><span id="span_currentPage">0</span>/<span id="span_totalpage">0</span>&nbsp;&nbsp;
                                                          <span id="span_Article"></span>
                                                            <span id="span_currentact">0~0</span>/<span id="span_total">0</span>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </th>


                                        </tr>
                                        <tr class="gridheadcss" style="font-weight: bold;">
                                            <th style="width: 4%" id="Th1" scope="col">
                                                <input type="checkbox" id="selthisPageAll" onclick="onclickSelctThisPageAll(this)" />
                                            </th>
                                            <th style="width: 12%" id="Lang_terminal_identification" scope="col">终端号码</th>
                                            <th style="width: 12%" id="Lang_CreateTime" scope="col">创建时间</th>
                                            <th style="width: 12%" id="Lang_Operatetime" scope="col">更新时间</th>
                                            <th style="width: 12%" id="Lang_Expire" scope="col">有效期</th>
                                            <th style="width: 12%" id="tdcpscritical" style="display: inline" scope="col"><span id="Lang_Period">上拉周期</span>(s)</th>
                                            <th style="width: 12%" id="Lang_GPSDest2" scope="col">上报目的</th>
                                            <th style="width: 12%" id="Lang_Result" scope="col">结果</th>
                                            <th style="width: 12%" id="Lang_PullStatus" scope="col">状态</th>
                                        </tr>

                                        <tbody id="Tbody1">
                                        </tbody>
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
                                    <img src="../images/tab_20.png" width="15" height="15" />
                                </td>
                                <td background="../images/tab_21.gif">
                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td width="25%" nowrap="nowrap">&nbsp;
                                            </td>
                                            <td width="75%" valign="top" class="STYLE1"></td>
                                        </tr>
                                    </table>
                                </td>
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
<script>    window.parent.closeprossdiv(); searchList();

    var Lang_Search22 = window.parent.parent.GetTextByName("Lang_Search2", window.parent.parent.useprameters.languagedata);
    var Lang_Search2_un = window.parent.parent.GetTextByName("Lang_Search2_un", window.parent.parent.useprameters.languagedata);
    var Lang_Search2 = window.document.getElementById("Lang_Search2");
    Lang_Search2.onmousedown = function () {
        Lang_Search2.src = Lang_Search2_un;
    }
    Lang_Search2.onmouseup = function () {
        Lang_Search2.src = Lang_Search22;
    }

    window.document.getElementById("btn_Open").value = window.parent.GetTextByName("Lang_GPS_Pull", window.parent.useprameters.languagedata);

    window.document.getElementById("Lang_terminal_identification").innerHTML = window.parent.parent.GetTextByName("Lang_terminal_identification", window.parent.parent.useprameters.languagedata);
    window.document.getElementById("Lang_CreateTime").innerHTML = window.parent.parent.GetTextByName("Lang_CreateTime", window.parent.parent.useprameters.languagedata);
    window.document.getElementById("Lang_Operatetime").innerHTML = window.parent.parent.GetTextByName("Lang_Operatetime", window.parent.parent.useprameters.languagedata);
    window.document.getElementById("Lang_Expire").innerHTML = window.parent.parent.GetTextByName("Lang_Expire", window.parent.parent.useprameters.languagedata);
    window.document.getElementById("Lang_Period").value = window.parent.GetTextByName("Lang_Period", window.parent.useprameters.languagedata);
    window.document.getElementById("Lang_GPSDest2").innerHTML = window.parent.parent.GetTextByName("Lang_GPSDest", window.parent.parent.useprameters.languagedata);
    window.document.getElementById("Lang_Result").innerHTML = window.parent.parent.GetTextByName("Lang_Result", window.parent.parent.useprameters.languagedata);
    window.document.getElementById("Lang_PullStatus").innerHTML = window.parent.parent.GetTextByName("Lang_PullStatus", window.parent.parent.useprameters.languagedata);
    window.document.getElementById("pp").innerHTML = window.parent.parent.GetTextByName("Lang_NameOrISSI", window.parent.parent.useprameters.languagedata);
    window.document.getElementById("Lang_BegTime").innerHTML = window.parent.parent.GetTextByName("Lang_BegTime", window.parent.parent.useprameters.languagedata);
    window.document.getElementById("Lang_EndTime").innerHTML = window.parent.parent.GetTextByName("Lang_EndTime", window.parent.parent.useprameters.languagedata);

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

    $("#BegSelectMinu").empty();
    $("#endSelectMinu").empty();
    for (var i = 0; i < 60; i++) {
        var s = 0;
        if (i < 10)
            s = "0" + i.toString();
        else s = i;
        $("#BegSelectMinu").append("<option value='" + s + "'>" + i + "</option>");  //添加一项option
        $("#endSelectMinu").append("<option value='" + s + "'>" + i + "</option>");  //添加一项option
    }
    window.document.getElementById("span_page").innerHTML = window.parent.parent.GetTextByName("Page", window.parent.parent.useprameters.languagedata);
    window.document.getElementById("span_Article").innerHTML = window.parent.parent.GetTextByName("Article", window.parent.parent.useprameters.languagedata);

    //窗体拖动
    var dragEnable = 'True';
    function dragdiv() {
        var div1 = window.parent.document.getElementById('SearchGpsPullStatues');
        if (div1 && event.button == 1 && dragEnable == 'True') {
            window.parent.mystartDragWindow(div1, null, event); div1.style.border = "solid 0px transparent"; window.parent.cgzindex(div1);
        }
    }

    function mydragWindow() {
        var div1 = window.parent.document.getElementById('SearchGpsPullStatues');
        if (div1) {
            window.parent.mydragWindow(div1, event);
        }
    }

    function mystopDragWindow() {
        var div1 = window.parent.document.getElementById('SearchGpsPullStatues');
        if (div1) {
            window.parent.mystopDragWindow(div1); div1.style.border = "0px";
        }
    }


    document.onmousedown = function () {
        var div1 = window.parent.document.getElementById('SearchGpsPullStatues');
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

</script>

