<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SBCall.aspx.cs" Inherits="Web.lqnew.opePages.SBCall" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title></title>
    <link href="../css/lq_addedit.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/pagestyle.css" rel="stylesheet" type="text/css" />
    <script src="../js/geturl.js" type="text/javascript"></script>
    <link href="../css/btn.css" rel="stylesheet" type="text/css" />
    <script src="../../JQuery/jquery-1.5.2.js" type="text/javascript"></script>
    <script src="../../JS/LangueSwitch.js" type="text/javascript"></script>
    <script language="javascript" type="text/javascript">
        var flag = false;
        var ISCallNO = "";
        var ISSwitchNO = "";
        var isCheck = 0;
        var isBSGCallISSI = "";
        var Lang_This_call_is_not_end = window.parent.parent.GetTextByName("Lang_This_call_is_not_end", window.parent.parent.useprameters.languagedata);
        function CloseWindow() {
            if (flag) {
                alert(Lang_This_call_is_not_end); //呼叫未结束
                return;
            }
            if (isBSGCallISSI != "") {//关闭前先删除基站组标识
                window.parent.parent.DelMBSGroupId(isBSGCallISSI);
                isBSGCallISSI = "";
            }
            window.parent.hiddenbg2();
            window.parent.parent.isPanalBSCall = false;
            window.parent.mycallfunction('SBCall');
        }

        //开始基站组呼叫
        var Lang_Multi_station_launch_failure = window.parent.parent.GetTextByName("Lang_Multi_station_launch_failure", window.parent.parent.useprameters.languagedata);
        function BegMutipleBSGCall() {
            if (window.parent.StartMBSGroupCall(isBSGCallISSI)) {
                $("#btnEndMulCall").css("display", "block");
                $("#btnBegMulCall").css("display", "none");
                window.parent.parent.isPanalBSCall = true;
                flag = true;
                document.getElementById("rsingcall").disabled = true;
                document.getElementById("rgroupcall").disabled = true;
                document.getElementById("rallcall").disabled = true;
                var mysel = document.getElementById("selBSGroup");
                for (var ipp = 0; ipp < mysel.length; ipp++) {
                    mysel[ipp].disabled = true;
                }
            }
            else
            {
                document.getElementById("divstatue").innerHTML = Lang_Multi_station_launch_failure;//"多站发起失败";
            }
        }
        //结束基站组呼叫
        function EndMutipleBSGCall() {
            $("#btnBegMulCall").css("display", "block");
            $("#btnEndMulCall").css("display", "none");
            window.parent.EndMBSGroupCall(isBSGCallISSI);
            window.parent.parent.isPanalBSCall = false;
            flag = false;
            document.getElementById("rsingcall").disabled = false;
            document.getElementById("rgroupcall").disabled = false;
            document.getElementById("rallcall").disabled = false;

            var mysel = document.getElementById("selBSGroup");
            for (var ipp = 0; ipp < mysel.length; ipp++) {
                mysel[ipp].disabled = false;
            }

        }
        //开始全站呼叫
        var Lang_All_station_launch_failure = window.parent.parent.GetTextByName("Lang_All_station_launch_failure", window.parent.parent.useprameters.languagedata);
        function BegAllCall() {
            if (window.parent.parent.startAllCall()) {
                window.parent.parent.isPanalBSCall = true;
                $("#btnEndAllCall").css("display", "block");
                $("#btnBegAllCall").css("display", "none");
                flag = true;
                document.getElementById("rsingcall").disabled = true;
                document.getElementById("rgroupcall").disabled = true;
                document.getElementById("rallcall").disabled = true;
            } else {
                document.getElementById("divstatue").innerHTML = Lang_All_station_launch_failure;// "全站发起失败";
            }
        }
        //结束全站呼叫
        function EndAllCall() {
            window.parent.parent.endAllCall();
            window.parent.parent.isPanalBSCall = false;

            $("#btnEndAllCall").css("display", "none");
            $("#btnBegAllCall").css("display", "block");
            flag = false;
            document.getElementById("rsingcall").disabled = false;
            document.getElementById("rgroupcall").disabled = false;
            document.getElementById("rallcall").disabled = false;
        }
        //开始单站呼叫
        var Lang_Please_choose_BS = window.parent.parent.GetTextByName("Lang_Please_choose_BS", window.parent.parent.useprameters.languagedata);
        var Lang_Illegal_ISSI = window.parent.parent.GetTextByName("Lang_Illegal_ISSI", window.parent.parent.useprameters.languagedata);
        var Lang_Single_station_launch_failure = window.parent.parent.GetTextByName("Lang_Single_station_launch_failure", window.parent.parent.useprameters.languagedata);
        function BegSingAll() {
            if (/[^\d]/.test(document.getElementById('txtBaseStationNo').value)) {
                alert(Lang_Illegal_ISSI);//("非法ISSI");
                return;
            }
            if ($("#txtBaseStationNo").val() == "") {
                alert(Lang_Please_choose_BS);//("请选择基站");
                return;
            }
            if (window.parent.parent.startSBCall($("#txtSwitch").val(), $("#txtBaseStationNo").val())) {//xzj--20181217--添加交换
                window.parent.parent.isPanalBSCall = true;

                flag = true;

                ISCallNO = $("#txtBaseStationNo").val();
                ISSwitchNO = $("#txtSwitch").val();//xzj--20181217--添加交换
                $("#btnBegSingCall").css("display", "none");
                $("#btnEndSingCall").css("display", "block");
                //选择按钮灰掉 选择按钮不见 输入框不可用
                document.getElementById("rsingcall").disabled = true;
                document.getElementById("rgroupcall").disabled = true;
                document.getElementById("rallcall").disabled = true;

                document.getElementById("txtBaseStationNo").disabled = true;
                document.getElementById("txtSwitch").disabled = true;//xzj--20190318--设置交换不能输入
                document.getElementById("btnnew").style.display = "none";
            } else {
                document.getElementById("divstatue").innerHTML = Lang_Single_station_launch_failure;// "单站发起失败";
            }
        }
        //结束基站
        function EndSingAll() {
            window.parent.parent.endSBCall(ISSwitchNO, ISCallNO);//xzj--20181217--添加交换
            window.parent.parent.isPanalBSCall = false;
            flag = false;
            ISCallNO = "";
            ISSwitchNO = "";
            $("#btnBegSingCall").css("display", "block");
            $("#btnEndSingCall").css("display", "none");

            //选择按钮 选择按钮可见 输入框可用
            document.getElementById("rsingcall").disabled = false;
            document.getElementById("rgroupcall").disabled = false;
            document.getElementById("rallcall").disabled = false;

            document.getElementById("txtBaseStationNo").disabled = false;
            document.getElementById("txtSwitch").disabled = false;//xzj--20190318--设置交换不能输入
            document.getElementById("btnnew").style.display = "block";
        }

        function chockSing() {
            $("#trBaseStationNo").css("display", "");
            $("#trBaseStationName").css("display", "");
            $("#trSingBtn").css("display", "");
            $("#trBaseStationGroupName").css("display", "none");
            $("#trBaseStationGroupPerson").css("display", "none");
            $("#stMulBtn").css("display", "none");
            $("#stAllBtn").css("display", "none");
            $("#trSwitch").css("display", "");
        }
        function BSGroupChanage() {
            //删除基站组
            window.parent.parent.DelMBSGroupId(isBSGCallISSI);
            var obj = document.getElementById('selBSGroup');
            var bsgissi = obj.options[obj.selectedIndex].value;
            getBSGroupMember(bsgissi);
            //创建新的基站组
            window.parent.parent.AddMBSGroupId(bsgissi);
            isBSGCallISSI = bsgissi;
        
        }
        function getBSGroupMember(BSISSI) {

            $.ajax({
                type: "POST",
                url: "../../Handlers/GetBSGroupMember_Handlers.ashx",
                data: { BSISSI: BSISSI },
                success: function (msg) {

                    var myresult = eval(msg);
                    if (myresult != undefined && myresult != null) {
                        document.getElementById('selBCGroupMember').options.length = 0;
                        for (var i = 0; i < myresult.length; i++) {
                            var varitem = new Option(myresult[i].StationName, myresult[i].SwitchID + "," + myresult[i].StationISSI);//xzj--20181217--添加交换
                            document.getElementById('selBCGroupMember').options.add(varitem);
                            //将成员添加到基站组中
                            window.parent.parent.AddMBSGroupMem(isBSGCallISSI, myresult[i].SwitchID, myresult[i].StationISSI);
                        }
                    }
                }
            });
        }
        function getBSGroupInfo() {
            $.ajax({
                type: "POST",
                url: "../../Handlers/GetBSGroupList_Handlers.ashx",
                data: "",
                success: function (msg) {
                    var myresult = eval(msg);
                    if (myresult != undefined && myresult != null) {
                        document.getElementById('selBSGroup').options.length = 0;
                        for (var i = 0; i < myresult.length; i++) {
                            var varitem = new Option(myresult[i].BSGroupName, myresult[i].BSISSI);
                            document.getElementById('selBSGroup').options.add(varitem);
                            if (i == 0) {
                                getBSGroupMember(myresult[i].BSISSI);
                                isBSGCallISSI = myresult[i].BSISSI;
                                window.parent.parent.AddMBSGroupId(isBSGCallISSI); //开始创建基站组
                            }
                        }
                    }
                }
            });
        }

        $(document).ready(function () {
           
            chockSing();
            window.parent.visiablebg2();
            $("input[name='rbccall']").click(function () {

            })
            $("input[name='rbccall']").change(function () {

                if (flag) {
                    $("input[name=rbccall]:eq(" + isCheck + ")").attr("checked", 'checked');

                    return;
                }
                $("#divstatue").html(window.parent.parent.GetTextByName("Lang-None", window.parent.parent.useprameters.languagedata));// html("无");
                if ($('input:radio[name="rbccall"]:checked').val() == "singlebasecall") {
                    if (isBSGCallISSI != "") {// 先删除基站组标识
                        window.parent.parent.DelMBSGroupId(isBSGCallISSI);
                        isBSGCallISSI = "";
                    }
                    chockSing();
                    isCheck = 0;
                } else
                    if ($('input:radio[name="rbccall"]:checked').val() == "multbasecall") { //多基站呼叫
                        getBSGroupInfo();
                        $("#trBaseStationGroupName").css("display", "");
                        $("#trBaseStationGroupPerson").css("display", "");
                        $("#stMulBtn").css("display", "");
                        $("#trBaseStationNo").css("display", "none");
                        $("#trBaseStationName").css("display", "none");
                        $("#trSingBtn").css("display", "none");
                        $("#stAllBtn").css("display", "none");
                        $("#trSwitch").css("display", "none");
                        isCheck = 1;
                    } else
                        if ($('input:radio[name="rbccall"]:checked').val() == "allbasecall") {//'全站呼叫'
                            if (isBSGCallISSI != "") {//先删除基站组标识
                                window.parent.parent.DelMBSGroupId(isBSGCallISSI);
                                isBSGCallISSI = "";
                            }
                            $("#trBaseStationGroupName").css("display", "none");
                            $("#trBaseStationGroupPerson").css("display", "none");
                            $("#stMulBtn").css("display", "none");
                            $("#trBaseStationNo").css("display", "none");
                            $("#trBaseStationName").css("display", "none");
                            $("#trSingBtn").css("display", "none");
                            $("#stAllBtn").css("display", "");
                            $("#trSwitch").css("display", "none");
                            isCheck = 2;
                        };

            });
            $("#txtBaseStationNo").change(function () {
                if ($("#txtBaseStationNo").val() != "" && $("#txtSwitch").val() != "") {
                $.ajax({
                    type: "POST",
                    url: "../../Handlers/GetBaseStationInfo.ashx",
                    data: "stationissi=" + $("#txtBaseStationNo").val() + "&switchID=" + $("#txtSwitch").val(),
                    success: function (msg) {

                        var my = eval(msg);
                        if (my != undefined || my != null || my != "") {
                            if (my[0].sname != undefined) {
                                $("#txtBaseStationName").val(my[0].sname);
                            } else {
                                $("#txtBaseStationName").val('');
                            }
                        } else {
                            $("#txtBaseStationName").val('');
                        }
                    }
                });
            }

            });
            $("#txtSwitch").change(function () {//xzj--20181228
                if ($("#txtBaseStationNo").val() != "" && $("#txtSwitch").val() != "") {
                    var re = /^(25[0-5]|2[0-4]\d|1\d\d|[1-9]\d|[0-9])$/;
                    var switchID = $("#txtSwitch").val();
                    if (re.test(switchID)) {
                    $.ajax({
                        type: "POST",
                        url: "../../Handlers/GetBaseStationInfo.ashx",
                        data: "stationissi=" + $("#txtBaseStationNo").val() + "&switchID=" + $("#txtSwitch").val(),
                        success: function (msg) {

                            var my = eval(msg);
                            if (my != undefined || my != null || my != "") {
                                if (my[0].sname != undefined) {
                                    $("#txtBaseStationName").val(my[0].sname);
                                } else {
                                    $("#txtBaseStationName").val('');
                                }
                            } else {
                                $("#txtBaseStationName").val('');
                            }
                        }
                        });
                    }
                    else {
                        $("#txtSwitch").val(0);
                    }
                }

            });
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
        function OnAddMember() {
            window.parent.mycallfunction('BaseStationPicker/add_Member', 635, 514, '0&ifr=SBCall_ifr&issi=' + $("#txtBaseStationNo").val() + '&name=' + encodeURI($("#txtBaseStationName").val()+'&switchID='+$("#txtSwitch").val()), 2001);
        }

        function faterdo(str) {
            if (str != null && str != "" && str != undefined) {

                $("#txtBaseStationNo").val(str.issi);
                $("#txtBaseStationName").val(str.name);
                $("#txtSwitch").val(str.switchID);//xzj--20181217--添加交换
            }
        }
    </script>
</head>
<body>
    <div>
        <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
            <tr>
                <td height="30">
                    <div id="divdrag" style="cursor: move">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td width="15" height="32">
                                    <img src="../images/tab_03.png" width="15" height="32" />
                                </td>
                                <td width="1101" background="../images/tab_05.gif">
                                    <ul class="hor_ul">
                                        <li>
                                            <img src="../images/037.gif" /><span id="Lang_StationCall"><%--基站呼叫--%></span></li>
                                    </ul>
                                </td>
                                <td width="281" background="../images/tab_05.gif" align="right">
                                    <img class="style6" style="cursor: hand;" onclick="CloseWindow()" onmouseover="javascript:this.src='../images/close_un.png';"
                                        onmouseout="javascript:this.src='../images/close.png';" src="../images/close.png" />
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
                            <td width="15" background="../images/tab_12.gif">
                                &nbsp;
                            </td>
                            <td align="center">
                                <table class="style1" cellspacing="1" id="dragtd">
                                    <tr>
                                        <td  class="style3" align="right" style="width: 80px;">
                                            <%--呼叫类型：--%><span id="Lang_calltype_1"></span><span>&nbsp;&nbsp</span>
                                        </td>
                                        <td class="style3" align="left" colspan="2">
                                           <input type="radio" id="rsingcall"  name="rbccall" value="singlebasecall" checked="checked" /><span class="style3" style="width: 80px;" id="Lang_SingleStationCall"><%--单站呼叫&nbsp;--%></span>                                     
                                           <input type="radio" id="rgroupcall" name="rbccall" value="multbasecall" /><span class="style3" style="width: 80px;" id="Lang_SMultiStationCall"><%--多站呼叫&nbsp;--%></span>
                                           <input type="radio" id="rallcall" name="rbccall" value="allbasecall" /><span class="style3" style="width: 80px;" id="Lang_TheStationCall"><%--全站呼叫&nbsp;--%></span>
                                        </td>
                                    </tr>
                                    <tr id="trSwitch">
                                        <td class="style3" align="right" style="width: 80px;">
                                            <%--交换：xzj--20181217--%><span  id ="spanSwitch"></span><span>&nbsp;&nbsp</span>
                                        </td>
                                        <td class="style3" align="left" colspan="2">
                                            <input type="text"   style="width: 150px" id="txtSwitch"
                                                runat="server" />
                                        </td>
                                    </tr>
                                    <tr id="trBaseStationNo">
                                        <td class="style3" align="right" style="width: 80px;">
                                            <div >
                                                <%--基站标识：--%><span id="divIssiTitle"></span><span>&nbsp;&nbsp</span></div>
                                        </td>
                                        <td class="style3" align="left">
                                         <input type="text" id="txtBaseStationNo" runat="server" />
                                            
                                           
                                        </td>
                                        <td  style="width:120px;" align="left">
                                        <form id="Form1" runat="server">
                                           <%--&nbsp;<img src="../images/btn_add.png" id="imgSelectISSI" style="FILTER:gray;" onmouseover="javascript:this.src='../images/btn_add_un.png';"  onmouseout="javascript:this.src='../images/btn_add.png';" /><font color="red">*</font><span style="color:Red" id ="showmessage"></span>--%>
                                            <img src="<%--../images/chooseMember0.png--%>" id="btnnew" onmouseover="<%--javascript:this.src='../images/chooseMember_un.png';--%>"
                                                            onmouseout="<%--javascript:this.src='../images/chooseMember0.png';--%>" onclick="OnAddMember()" />
                                           
                                            </form>
                                        </td>
                                    </tr>

                                    <tr id="trBaseStationName">
                                        <td class="style3" align="right" style="width: 80px;">
                                            <%--基站名称：--%><span  id ="Lang_StationName"></span><span>&nbsp;&nbsp</span>
                                        </td>
                                        <td class="style3" align="left" colspan="2">
                                            <input type="text" readonly="readonly" disabled="disabled" style="width: 150px" id="txtBaseStationName"
                                                runat="server" />
                                        </td>
                                    </tr>

                                    <tr id="trBaseStationGroupName">
                                        <td class="style3" align="right" style="width: 80px;">
                                            <div id="div1">
                                               <%-- 基站组名称：--%></div><span>&nbsp;&nbsp</span>
                                        </td>
                                        <td class="style3" align="left" colspan="2">
                                            <select id="selBSGroup" onchange="BSGroupChanage()" runat="server" style="width:90%">
                                            </select>
                                            <%--<asp:Button ID="Button1" runat="server" Text="新增" CssClass="CALLBUTTON2" Enabled="false" />--%>
                                            <font
                                                    color="red">*</font><span style="color: Red" id="Span1"></span>
                                        </td>
                                    </tr>
                                    <tr id="trBaseStationGroupPerson">
                                        <td class="style3" align="right" style="width: 80px;">
                                            <span id="Lang_membership_Stationgroupname"><%--基站组成员：--%></span><span>&nbsp;&nbsp</span>
                                        </td>
                                        <td class="style3" align="left" colspan="2">
                                          
                                                 <select  id="selBCGroupMember" name="selBCGroupMember" multiple="multiple" style="width: 90%;
                                                height: 100px">
                                                
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td  class="style3" align="right" style="width: 80px; height:45px">
                                           <%--状态：--%><span id="Lang_Status"></span><span>&nbsp;&nbsp</span>
                                        </td>
                                        <td class="style3" align="left" colspan="2">
                                            <div id="divstatue">
                                                <%--无--%></div>
                                        </td>
                                    </tr>
                                    <tr id="trSingBtn">
                                        <td class="style3" align="center" colspan="3">
                                            <button id="btnBegSingCall" class="btn" style="width: 60px; text-align: center; vertical-align: bottom"
                                                onclick="BegSingAll()">
                                                <%--单站呼叫--%></button>
                                            <button id="btnEndSingCall" class="btn" style="width: 60px; text-align: center; display: none"
                                                onclick="EndSingAll()">
                                                <%--结束呼叫--%>
                                            </button>
                                        </td>
                                    </tr>
                                    <tr id="stMulBtn">
                                        <td class="style3" align="center" colspan="3">
                                            <button id="btnBegMulCall" class="btn" style="width: 60px; text-align: center; vertical-align: bottom"
                                                onclick="BegMutipleBSGCall()">
                                                <%--多站呼叫--%></button>
      
                                            <button id="btnEndMulCall" class="btn" style="width: 60px; text-align: center; display:none" onclick="EndMutipleBSGCall()">
                                                <%--结束呼叫--%>
                                            </button>
                                        </td>
                                    </tr>
                                    <tr id="stAllBtn">
                                        <td class="style3" align="center" colspan="3">
                                            <button id="btnBegAllCall" class="btn" style="width: 60px; text-align: center; vertical-align: bottom"
                                                onclick="BegAllCall()">
                                                <%--全站呼叫--%></button>
                                            <button id="btnEndAllCall" class="btn" style="width: 60px; text-align: center; display: none"
                                                onclick="EndAllCall()">
                                                <%--结束呼叫--%>
                                            </button>
                                        </td>
                                    </tr>
                                </table>
                              
                            </td>
                            <td width="14" background="../images/tab_16.gif">
                                &nbsp;
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
                                        <td width="25%" nowrap="nowrap">
                                            &nbsp;
                                        </td>
                                        <td width="75%" valign="top" class="STYLE1">
                                            &nbsp;
                                        </td>
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
</body>
<script>
    window.parent.closeprossdiv();
    LanguageSwitch(window.parent);

    var image = window.document.getElementById("btnnew");
    var srouce = window.parent.parent.GetTextByName("Lang_chooseMemberPNG", window.parent.parent.useprameters.languagedata);
    image.setAttribute("src", srouce);
    var strpath = window.parent.parent.GetTextByName("Lang_chooseMemberPNG", window.parent.parent.useprameters.languagedata);
    var strpathmove = window.parent.parent.GetTextByName("Lang_chooseMemberPNG_un", window.parent.parent.useprameters.languagedata);
    image.onmouseover = function () { this.src = strpathmove }
    image.onmouseout = function () { this.src = strpath }



    //window.document.getElementById("rsingcall").value = window.parent.parent.GetTextByName("SingleStationCall", window.parent.parent.useprameters.languagedata);
    //window.document.getElementById("rgroupcall").value = window.parent.parent.GetTextByName("MultiStationCall", window.parent.parent.useprameters.languagedata);
    //alert(window.document.getElementById("rgroupcall").value);
    window.document.getElementById("div1").innerHTML = window.parent.parent.GetTextByName("Lang_Stationgroupname", window.parent.parent.useprameters.languagedata);
    //window.document.getElementById("rsingcall").innerHTML = window.parent.parent.GetTextByName("Lang_SingleStationCall", window.parent.parent.useprameters.languagedata);

    window.document.getElementById("divIssiTitle").innerHTML = window.parent.parent.GetTextByName("Lang_BaseStationIdentification", window.parent.parent.useprameters.languagedata);
    
    window.document.getElementById("divstatue").innerHTML = window.parent.parent.GetTextByName("Lang-None", window.parent.parent.useprameters.languagedata);
    window.document.getElementById("spanSwitch").innerHTML = window.parent.parent.GetTextByName("switchID", window.parent.parent.useprameters.languagedata);//xzj--20181217--添加交换

   // window.document.getElementById("rallcall").value = window.parent.parent.GetTextByName("TheStationCall", window.parent.parent.useprameters.languagedata);
    
    window.document.getElementById("btnBegSingCall").innerHTML = window.parent.parent.GetTextByName("SingleStationCall", window.parent.parent.useprameters.languagedata);
    window.document.getElementById("btnEndSingCall").innerHTML = window.parent.parent.GetTextByName("ENDING_CALL", window.parent.parent.useprameters.languagedata);
    window.document.getElementById("btnBegMulCall").innerHTML = window.parent.parent.GetTextByName("MultiStationCall", window.parent.parent.useprameters.languagedata);
    
    window.document.getElementById("btnEndMulCall").innerHTML = window.parent.parent.GetTextByName("ENDING_CALL", window.parent.parent.useprameters.languagedata);
    window.document.getElementById("btnBegAllCall").innerHTML = window.parent.parent.GetTextByName("TheStationCall", window.parent.parent.useprameters.languagedata);
    window.document.getElementById("btnEndAllCall").innerHTML = window.parent.parent.GetTextByName("ENDING_CALL", window.parent.parent.useprameters.languagedata);

</script>
<link href="../../CSS/lq_calloutExtender.css" rel="stylesheet" type="text/css" />
</html>
