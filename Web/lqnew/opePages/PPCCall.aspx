<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PPCCall.aspx.cs" Inherits="Web.lqnew.PPCCall" %>

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
    <style type="text/css">
        .typelist
        {
            border: solid;
            border: 1px 1px 1px 1px;
            filter: alpha(opacity:0);
            visibility: hidden;
            position: absolute;
            z-index: 1;
        }
        .noselect
        {
            border-top: #eee 1px solid;
            padding-left: 2px;
            background: #fff;
            width: 100%;
            color: #000;
        }
        .isselect
        {
            border-top: #047 1px solid;
            padding-left: 2px;
            background: #058;
            width: 100%;
            color: #fe0;
        }
        .CALLBUTTON
        {
            display:none;
        }
        .CALLBUTTON1
        {
      
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
    </style>
    <script type="text/javascript">
        var flag = false;
        var CC_RELEASE = window.parent.parent.GetTextByName("CC_RELEASE", window.parent.parent.useprameters.languagedata);
        
        var Lang_CallEnd = window.parent.parent.GetTextByName("Lang_CallEnd", window.parent.parent.useprameters.languagedata);
        var Lang_please_end_EmergencyCallGroup = window.parent.parent.GetTextByName("Lang_please_end_EmergencyCallGroup", window.parent.parent.useprameters.languagedata);

        function CloseWindow() {
            var a = $("#divstatue").html();
            var b = CC_RELEASE; //"对方挂断";
            if (a.indexOf(b) > 0 || a == Lang_CallEnd) {//"呼叫结束"
                flag = false;
            }

            if (flag) {
                alert(Lang_please_end_EmergencyCallGroup);//("请先结束紧急呼叫！");
                return;
            }
            window.parent.hiddenbg2();
            window.parent.mycallfunction('PPCCall');
        }

        function keyPress() {
            if (event.keyCode == 32) {
                PTTPPCGCALL();
            }
        }
        function keyUp() {
            if (event.keyCode == 32) {
                CEASEDPPCGCALL();
            }
        }

        function PrivateKeyPress() {
            if (event.keyCode == 32) {
                PTTPPCSCALL();
            }
        }
        function PrivateKeyUp() {
            if (event.keyCode == 32) {
                CEASEDPPCSCALL();
            }
        }
        //开始紧急呼叫全双工 单呼叫
        var Lang_illeagal_ISSI_or_GSSI = window.parent.parent.GetTextByName("Lang_illeagal_ISSI_or_GSSI", window.parent.parent.useprameters.languagedata);
        var Called = window.parent.parent.GetTextByName("Called", window.parent.parent.useprameters.languagedata);//呼叫
        var Lang_input_ISSI_or_GSSI_number = window.parent.parent.GetTextByName("Lang_input_ISSI_or_GSSI_number", window.parent.parent.useprameters.languagedata);
        var Toanswer = window.parent.parent.GetTextByName("Toanswer", window.parent.parent.useprameters.languagedata);//接听
        var lang_group = window.parent.parent.GetTextByName("Group", window.parent.parent.useprameters.languagedata);
        var lang_dispatch = window.parent.parent.GetTextByName("Dispatch", window.parent.parent.useprameters.languagedata);
        function STARTPPCSCALL() {
            var intISSIORGSSI = document.getElementById('txtISSIOrGSSIText').value.trim();

            if (/[^\d]/.test(intISSIORGSSI)) {
                alert(Lang_illeagal_ISSI_or_GSSI);//("非法ISSI或GSSI");
                return;
            }
            if (intISSIORGSSI <= 0 || intISSIORGSSI > 80699999) {
                alert(Lang_illeagal_ISSI_or_GSSI);
                return;
            }

            if (intISSIORGSSI == "") {
                alert(Lang_input_ISSI_or_GSSI_number);//("请输入ISSI号码或者GIIS号码");
                return;
            }
            if (document.getElementById('begincall').innerHTML == Called || document.getElementById('begincall').innerHTML == Toanswer) {
                window.parent.parent.startppcDC(intISSIORGSSI);
                window.parent.ppcCallingIssi = intISSIORGSSI
                flag = true;
                $("#begincall").css("display", "none");
                $("#endcall").css("display", "");
            }
        }
        //开始紧急呼叫半双工授权
        function PTTPPCSCALL() {
            var intISSIORGSSI = document.getElementById('txtISSIOrGSSIText').value.trim();
            if (/[^\d]/.test(intISSIORGSSI)) {
                alert(Lang_illeagal_ISSI_or_GSSI);//("非法ISSI或GSSI");
                return;
            }
            if (intISSIORGSSI <= 0 || intISSIORGSSI > 80699999) {
                alert(Lang_illeagal_ISSI_or_GSSI);
                return;
            }
            if (intISSIORGSSI == "") {
                alert(Lang_input_ISSI_or_GSSI_number);//("请输入ISSI号码或者GIIS号码");
                return;
            }
            if (document.getElementById('begincall').innerHTML == "PTT") {
                window.parent.parent.startppcSC(intISSIORGSSI);
                window.parent.ppcCallingIssi = intISSIORGSSI;
                document.getElementById('endcall').style.display = "";
                flag = true;
            }
        }
        //取消紧急呼叫半双工单户授权
        function CEASEDPPCSCALL() {
            if (document.getElementById('begincall').innerHTML == "PTT") {
                window.parent.parent.ppcsceasedPTT(document.getElementById('txtISSIOrGSSIText').value.trim());
            }
        }
        //结束紧急呼叫单户
        var Lang_CallEnd = window.parent.parent.GetTextByName("Lang_CallEnd", window.parent.parent.useprameters.languagedata);
        function ENDPPCSCALL() {
            if (document.getElementById('begincall').innerHTML == "PTT") {
                window.parent.parent.endppcSC(document.getElementById('txtISSIOrGSSIText').value.trim());
            }
            else {
                window.parent.parent.endppcDC(document.getElementById('txtISSIOrGSSIText').value.trim());
            }
            window.parent.ppcCallingIssi = "";
            window.parent.callPanalISSI = "";
            flag = false;
            $("#begincall").css("display", "");
            $("#endcall").css("display", "none");
            document.getElementById('divstatue').innerHTML = Lang_CallEnd;//"呼叫结束";
        }
        //开始紧急呼叫组呼
        function PTTPPCGCALL() {
            var intISSIORGSSI = document.getElementById('txtISSIOrGSSIText').value.trim();

            if (/[^\d]/.test(intISSIORGSSI)) {
                alert(Lang_illeagal_ISSI_or_GSSI);//("非法ISSI或GSSI");
                return;
            }
            if (intISSIORGSSI <= 0 || intISSIORGSSI > 80699999) {
                alert(Lang_illeagal_ISSI_or_GSSI);
                return;
            }
            if (intISSIORGSSI == "") {
                alert(Lang_input_ISSI_or_GSSI_number);//("请输入ISSI号码或者GIIS号码");
                return;
            }

            document.getElementById('btnGEndCall').style.display = "block";
            if (window.parent.parent.startppcGC(intISSIORGSSI)) {
                document.getElementById("imgSelectUser").style.display = "none";
                document.getElementById("txtISSIOrGSSIText").disabled = true;
            } else {
                document.getElementById("imgSelectUser").style.display = "inline";
                document.getElementById("txtISSIOrGSSIText").disabled = false;
            }
            flag = true;
        }
        //释放紧急呼叫组呼授权
        function CEASEDPPCGCALL() {
            window.parent.parent.ppcgceasedPTT(document.getElementById('txtISSIOrGSSIText').value.trim());
        }

        //结束紧急呼叫
        function ENDPPCGCALL() {
            window.parent.parent.endppcGC(document.getElementById('txtISSIOrGSSIText').value.trim());
            document.getElementById("imgSelectUser").style.display = "inline";
            document.getElementById("txtISSIOrGSSIText").disabled = false;
            flag = false;
            document.getElementById('btnGEndCall').style.display = "none";
            document.getElementById('divstatue').innerHTML = Lang_CallEnd; // "呼叫结束";
            window.parent.ppcCallingIssi = "";
            window.parent.callPanalISSI = "";
        }
        var CC_RELEASE = window.parent.parent.GetTextByName("CC_RELEASE", window.parent.parent.useprameters.languagedata);
        var Lang_cannot_chose_calltype = window.parent.parent.GetTextByName("Lang_cannot_chose_calltype", window.parent.parent.useprameters.languagedata);
        function CheckMe() {//替换显示内容
            var a = $("#divstatue").html();
            var b = CC_RELEASE; //"对方挂断";
            if (a.indexOf(b) > 0 || a == Lang_CallEnd) {//"呼叫结束"
                flag = false;
            };

            if (flag) {
                document.getElementById('calltype').selectedIndex = selecti;
                alert(Lang_cannot_chose_calltype);//("通话中,不能选择呼叫类型");
                return;
            };
            selecti = document.getElementById('calltype').selectedIndex;
            if (document.getElementById('calltype').selectedIndex == "0") {
                document.getElementById('begincall').style.display = "none";
                document.getElementById('endcall').style.display = "none";
            }
            if (document.getElementById('calltype').selectedIndex == "2") {
                document.getElementById('begincall').innerHTML = "PTT";
                document.getElementById('begincall').style.display = "";
                document.getElementById('endcall').style.display = "none";
            }
            else if (document.getElementById('calltype').selectedIndex == "1") {
                document.getElementById('begincall').innerHTML = Called; //"呼叫";
                document.getElementById('begincall').style.display = "";
                document.getElementById('endcall').style.display = "none";
            }
            document.getElementById('begincall').className = "CALLBUTTON1";
            document.getElementById('endcall').className = "CALLBUTTON1";
        }
        function tochanage() {
            $.ajax({
                type: "POST",
                url: "../../Handlers/GetUserOrGoupInfo_Handler.ashx",
                data: "issi=" + $("#txtISSIOrGSSIText").val().trim(),
                success: function (msg) {
                    var my = eval(msg);
                    if (my[0].type == "user") {
                        $("#divPUserName").css("display", "block");
                        $("#divTxtUserName").css("display", "block");
                        $("#trPoliceNO").css("display", "");
                        $("#trUserCallType").css("display", "");
                        $("#trUserBtn").css("display", "");
                        $("#divPGroupName").css("display", "none");
                        $("#divTxtGoupName").css("display", "none");
                        $("#trGroupBtn").css("display", "none");

                        $("#txtUserName").val(my[0].nam);
                        $("#txtEntity").val(my[0].entity);
                        $("#txtPoliceNo").val(my[0].num);
                        SelectUsers.length = 0;
                        if (my[0].nam != "") {
                            SelectUsers.push({ uname: my[0].nam, uissi: $("#txtISSIOrGSSIText").val().trim(), utype: my[0].type });
                        }
                    } else
                        if (my[0].type == "group") {
                            $("#divPUserName").css("display", "none");
                            $("#divTxtUserName").css("display", "none");
                            $("#trPoliceNO").css("display", "none");
                            $("#trUserCallType").css("display", "none");
                            $("#trUserBtn").css("display", "none");
                            $("#divPGroupName").css("display", "block");
                            $("#divTxtGoupName").css("display", "block");
                            $("#trGroupBtn").css("display", "");//cxy-20180719-block有显示错误，删除block

                            $("#txtGroupName").val(my[0].groupname);
                            $("#txtEntity").val(my[0].entityname);
                            SelectUsers.length = 0;
                            if (my[0].groupname != undefined) {
                                SelectUsers.push({ uname: my[0].nam, uissi: $("#txtISSIOrGSSIText").val().trim(), utype: lang_group });//Group
                            }
                        } else {
                            $("#txtUserName").val(my[0].nam);
                            $("#txtEntity").val(my[0].entity);
                            $("#txtPoliceNo").val(my[0].num);
                            SelectUsers.length = 0;
                            if (my[0].nam != undefined) {
                                SelectUsers.push({ uname: my[0].nam, uissi: $("#txtISSIOrGSSIText").val().trim(), utype: lang_dispatch });//Group
                            }
//                            $("#txtUserName").val("");
//                            $("#txtEntity").val("");
//                            $("#txtPoliceNo").val("");
//                            $("#txtGroupName").val("");
//                            $("#txtEntity").val("");
                        }


                }
            });
        }
        $(document).ready(function () {
            window.parent.visiablebg2();
            $("#txtISSIOrGSSIText").change(function () {
                if ($("#txtISSIOrGSSIText").val().trim() == "") {

                    $("#txtUserName").val("");
                    $("#txtEntity").val("");
                    $("#txtPoliceNo").val("");
                    SelectUsers.length = 0;
                    return;
                }
                $.ajax({
                    type: "POST",
                    url: "../../Handlers/GetUserOrGoupInfo_Handler.ashx",
                    data: "issi=" + $("#txtISSIOrGSSIText").val().trim(),
                    success: function (msg) {
                        var my = eval(msg);
                        if (my[0].type == "user") {
                            $("#divPUserName").css("display", "block");
                            $("#divTxtUserName").css("display", "block");
                            $("#trPoliceNO").css("display", "");
                            $("#trUserCallType").css("display", "");
                            $("#trUserBtn").css("display", "");
                            $("#divPGroupName").css("display", "none");
                            $("#divTxtGoupName").css("display", "none");
                            $("#trGroupBtn").css("display", "none");

                            $("#txtUserName").val(my[0].nam);
                            $("#txtEntity").val(my[0].entity);
                            $("#txtPoliceNo").val(my[0].num);
                            SelectUsers.length = 0;
                            if (my[0].nam != "") {
                                SelectUsers.push({ uname: my[0].nam, uissi: $("#txtISSIOrGSSIText").val().trim(), utype: my[0].type });
                            }
                        } else
                            if (my[0].type == "group") {
                                $("#divPUserName").css("display", "none");
                                $("#divTxtUserName").css("display", "none");
                                $("#trPoliceNO").css("display", "none");
                                $("#trUserCallType").css("display", "none");
                                $("#trUserBtn").css("display", "none");
                                $("#divPGroupName").css("display", "block");
                                $("#divTxtGoupName").css("display", "block");
                                $("#trGroupBtn").css("display", "");//cxy-20180719-block有显示错误，删除block

                                $("#txtGroupName").val(my[0].groupname);
                                $("#txtEntity").val(my[0].entityname);
                                SelectUsers.length = 0;
                                if (my[0].groupname != undefined) {
                                    SelectUsers.push({ uname: my[0].groupname, uissi: $("#txtISSIOrGSSIText").val().trim(), utype: lang_group });//Group
                                }
                            } else {
                                $("#txtUserName").val(my[0].nam);
                                $("#txtEntity").val(my[0].entity);
                                $("#txtPoliceNo").val(my[0].num);
                                SelectUsers.length = 0;
                               
                                if (my[0].nam != "") {
                                    SelectUsers.push({ uname: my[0].nam, uissi: $("#txtISSIOrGSSIText").val().trim(), utype: lang_dispatch });//Group
                                }
                                //                                $("#txtUserName").val("");
                                //                                $("#txtEntity").val("");
                                //                                $("#txtPoliceNo").val("");
                                //                                $("#txtGroupName").val("");
                                //                                $("#txtEntity").val("");

                            }

                        if (my[0].type == undefined && $("#txtISSIOrGSSIText").val().trim() != "") {

                           // alert("输入号码在系统中不存在");
                        }

                    }
                });
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
        })
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
        var SelectUsers = new Array();
        function OnAddMember() {
            window.parent.mycallfunction('AddMemberTree/add_Member', 650, 514, '0&ifr=PPCCall_ifr&selectcount=1&type=all', 2001);
            // window.parent.mycallfunction('AddPPCCallMember/add_Member', 635, 514, '0&ifr=PPCCall_ifr&issi=' + $("#txtISSIOrGSSIText").val().trim(), 2001);
        }
        function faterdo(retrunissis) {
            if (retrunissis.length > 0) {
                SelectUsers.length = 0;
                SelectUsers.push({ uname: retrunissis[0].uname, uissi: retrunissis[0].uissi, utype: retrunissis[0].utype });
            } else {
                return;
            }
            $("#txtISSIOrGSSIText").val(retrunissis[0].uissi);
            $.ajax({
                type: "POST",
                url: "../../Handlers/GetUserOrGoupInfo_Handler.ashx",
                data: "issi=" + retrunissis[0].uissi,
                success: function (msg) {
                    var my = eval(msg);
                    if (my[0].type == "user") {
                        $("#divPUserName").css("display", "block");
                        $("#divTxtUserName").css("display", "block");
                        $("#trPoliceNO").css("display", "");
                        $("#trUserCallType").css("display", "");
                        $("#trUserBtn").css("display", "");
                        $("#divPGroupName").css("display", "none");
                        $("#divTxtGoupName").css("display", "none");
                        $("#trGroupBtn").css("display", "none");

                        $("#txtUserName").val(my[0].nam);
                        $("#txtEntity").val(my[0].entity);
                        $("#txtPoliceNo").val(my[0].num);

                    } else
                        if (my[0].type == "group") {
                            $("#divPUserName").css("display", "none");
                            $("#divTxtUserName").css("display", "none");
                            $("#trPoliceNO").css("display", "none");
                            $("#trUserCallType").css("display", "none");
                            $("#trUserBtn").css("display", "none");
                            $("#divPGroupName").css("display", "block");
                            $("#divTxtGoupName").css("display", "block");
                            $("#trGroupBtn").css("display", "");//cxy-20180719-block有显示错误，删除block

                            $("#txtGroupName").val(my[0].groupname);
                            $("#txtEntity").val(my[0].entityname);

                        } else {

                            $("#txtUserName").val(my[0].nam);
                            $("#txtEntity").val(my[0].entity);
                            $("#txtPoliceNo").val(my[0].num);
//                            $("#txtUserName").val("");
//                            $("#txtEntity").val("");
//                            $("#txtPoliceNo").val("");
//                            $("#txtGroupName").val("");
//                            $("#txtEntity").val("");
                        }

                    if (my[0].type == undefined && $("#txtISSIOrGSSIText").val().trim() != "") {

                       // alert("输入号码在系统中不存在");
                    }
                }
            });
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
                                    <img alt="" src="../images/tab_03.png" width="15" height="32" />
                                </td>
                                <td width="1101" background="../images/tab_05.gif">
                                    <ul class="hor_ul">
                                        <li>
                                            <img alt="" src="../images/037.gif" /><span id="Lang_EmergencyCall" ><%--紧急呼叫--%></span></li>
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
                            <td width="15" background="../images/tab_12.gif">
                                &nbsp;
                            </td>
                            <td align="center">
                                <table class="style1" cellspacing="1" id="dragtd">
                                    <tr>
                                        <td class="style3" align="right" style="width: 90px;">
                                            <div >
                                                <%--标识：--%><span id="divISSIOrGSSI"></span><span>&nbsp;&nbsp</span></div>
                                        </td>
                                        <td class="style3" align="left" >
                                         
                                            <input type="text" id="txtISSIOrGSSIText" runat="server" />
                           
                                            
                                         
                                        </td>
                                        <td align="left" style="width:120px;">
                                      
                                        <img alt="" src="<%--../images/chooseMember0.png--%>" id="imgSelectUser" onclick="OnAddMember()" onmouseover="<%--javascript:this.src='../images/chooseMember_un.png';--%>"
                                                onmouseout="<%--javascript:this.src='../images/chooseMember0.png';--%>" />&nbsp;
                                           
                                               
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="style3" align="right" style="width: 90px;">
                                            <div >
                                                <%--姓名：--%><span id="divPUserName"></span><span>&nbsp;&nbsp</span></div>
                                            <div id="divPGroupName" style="display: none">
                                               <%-- 组名：--%></div>
                                        </td>
                                        <td class="style3" align="left" colspan="2">
                                            <div id="divTxtUserName">
                                                <input type="text" readonly="readonly" disabled="disabled" id="txtUserName" runat="server"  /></div>
                                            <div id="divTxtGoupName" style="display: none">
                                                <input type="text" readonly="readonly" disabled="disabled" id="txtGroupName" runat="server"  /></div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td  class="style3" align="right" style="width: 90px;">
                                           <%-- 单位：--%><span id="Lang_Unit"></span><span>&nbsp;&nbsp</span>
                                        </td>
                                        <td class="style3" align="left" colspan="2">
                                            <input type="text" readonly="readonly" disabled="disabled" id="txtEntity" runat="server" />
                                        </td>
                                    </tr>
                                    <tr id="trPoliceNO">
                                        <td  class="style3" align="right" style="width: 90px;">
                                            <%--编号：--%><span id="Lang_Serialnumber"></span><span>&nbsp;&nbsp</span>
                                        </td>
                                        <td class="style3" align="left" colspan="2">
                                            <input type="text" readonly="readonly" disabled="disabled" id="txtPoliceNo" runat="server" />
                                        </td>
                                    </tr>
                                    <tr id="trUserCallType">
                                        <td  class="style3" align="right" style="width: 60px;">
                                           <%-- 呼叫方式：--%><span id="Lang_call_style"></span><span>&nbsp;&nbsp</span>
                                        </td>
                                        <td class="style3" align="left" colspan="2">
                                            <select onchange="CheckMe()" id="calltype">
                                                <option value="" selected="selected" id="Lang_select_call_style"><%--请选择呼叫方式--%></option>
                                                <option value="<%--电话模式--%>" id="Lang_TellMode"><%--电话模式--%></option>
                                                <option value="<%--对讲模式--%>" id="Lang_PTTMode"><%--对讲模式--%></option>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td  class="style3" align="right" style="width: 60px; height: 80px">
                                           <%-- 呼叫状态：--%><span id="Lang_call_status"></span><span>&nbsp;&nbsp</span>
                                        </td>
                                        <td class="style3" align="left" colspan="2">
                                            <div id="divstatue">
                                                <%--无--%></div>
                                        </td>
                                    </tr>
                                    <tr id="trUserBtn">
                                        <td class="style3" align="center" colspan="3">
                                            <table>
                                                <tr>
                                                    <td style="width: 200px" align="center"  colspan=2 >
                                                    <div style="width:200px; display:inline">
                                                        <button class="CALLBUTTON1"  id="begincall" style="display:none;width: 45px; text-align: center;
                                                            cursor: pointer;" onclick="STARTPPCSCALL()" onmousedown="PTTPPCSCALL()" onmouseup="CEASEDPPCSCALL()" onkeypress="PrivateKeyPress()" onkeyup="PrivateKeyUp()">
                                                            <%--呼叫--%></button>
                                               
                                                        <button class="CALLBUTTON1"  id="endcall" style="display:none;width: 45px; text-align: center; cursor: pointer;"
                                                            onclick="ENDPPCSCALL()">
                                                            <%--结束--%></button>
                                                            </div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr id="trGroupBtn" style="display: none">
                                        <td class="style3" align="center" colspan="3">
                                            <table>
                                                <tr>
                                                    <td style="width: 60px">
                                                        <button id="btnGBegCall" class="btn" style="width: 100%; text-align: center; cursor: pointer;"
                                                            onmousedown="PTTPPCGCALL()"  onmouseup="CEASEDPPCGCALL()"  onkeypress="keyPress();" onkeyup="keyUp();">
                                                            PTT</button>
                                                    </td>
                                                    <td style="width: 60px">
                                                        <button id="btnGEndCall" class="btn" style="width: 100%; text-align: center; cursor: pointer;
                                                            display: none" onclick="ENDPPCGCALL()">
                                                            <%--结束--%></button>
                                                    </td>
                                                </tr>
                                            </table>
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
                                <img alt="" src="../images/tab_20.png" width="15" height="15" />
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
                                <img alt="" src="../images/tab_22.png" width="14" height="15" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
</body>
</html>
<script type="text/javascript">
    window.parent.closeprossdiv();
    LanguageSwitch(window.parent);
   

    var image = window.document.getElementById("imgSelectUser");
    var srouce = window.parent.parent.GetTextByName("Lang_chooseMemberPNG", window.parent.parent.useprameters.languagedata);
    image.setAttribute("src", srouce);
    var strpath = window.parent.parent.GetTextByName("Lang_chooseMemberPNG", window.parent.parent.useprameters.languagedata);
    var strpathmove = window.parent.parent.GetTextByName("Lang_chooseMemberPNG_un", window.parent.parent.useprameters.languagedata);
    image.onmouseover = function () { this.src = strpathmove }
    image.onmouseout = function () { this.src = strpath }


    window.document.getElementById("divISSIOrGSSI").innerHTML = window.parent.parent.GetTextByName("Lang_Identification", window.parent.parent.useprameters.languagedata);
    window.document.getElementById("Lang_TellMode").value = window.parent.parent.GetTextByName("Lang_TellMode", window.parent.parent.useprameters.languagedata);
    window.document.getElementById("Lang_PTTMode").value = window.parent.parent.GetTextByName("Lang_PTTMode", window.parent.parent.useprameters.languagedata);
    window.document.getElementById("divstatue").innerHTML = window.parent.parent.GetTextByName("Lang-None", window.parent.parent.useprameters.languagedata);
    window.document.getElementById("begincall").innerHTML = window.parent.parent.GetTextByName("Called", window.parent.parent.useprameters.languagedata);
    window.document.getElementById("endcall").innerHTML = window.parent.parent.GetTextByName("TOend", window.parent.parent.useprameters.languagedata);
    window.document.getElementById("divPUserName").innerHTML = window.parent.parent.GetTextByName("Lang_name", window.parent.parent.useprameters.languagedata);
    window.document.getElementById("divPGroupName").innerHTML = window.parent.parent.GetTextByName("Lang_GroupName", window.parent.parent.useprameters.languagedata);
    window.document.getElementById("btnGEndCall").innerHTML = window.parent.parent.GetTextByName("TOend", window.parent.parent.useprameters.languagedata);


</script>
<link href="../../CSS/lq_calloutExtender.css" rel="stylesheet" type="text/css" />
