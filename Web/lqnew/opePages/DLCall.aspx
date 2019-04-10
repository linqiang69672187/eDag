<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DLCall.aspx.cs" Inherits="Web.lqnew.DLCall" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../css/lq_addedit.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/pagestyle.css" rel="stylesheet" type="text/css" />
    <script src="../js/geturl.js" type="text/javascript"></script>
    <script src="../../JQuery/jquery-1.5.2.js" type="text/javascript"></script>
    <link href="../css/btn.css" rel="stylesheet" type="text/css" />
    <script src="../../JS/LangueSwitch.js" type="text/javascript"></script>
    <script src="../js/StringPrototypeFunction.js" type="text/javascript"></script>
    <script type="text/javascript">
        var flag = false; //是否开始监听
        var iscall = false;
        var myISSI = "";
        var myPName = "";
        var myPNum = "";
        var myDw = "";
       

        var DL_END_DEACTIVATE_SUCCEED = window.parent.parent.GetTextByName("DL_END_DEACTIVATE_SUCCEED", window.parent.parent.useprameters.languagedata);
        var DL_START_ACTIVATE_FAILURED = window.parent.parent.GetTextByName("DL_START_ACTIVATE_FAILURED", window.parent.parent.useprameters.languagedata);
        
        var Lang_Please_end_monitoring = window.parent.parent.GetTextByName("Lang_Please_end_monitoring", window.parent.parent.useprameters.languagedata);
        function CloseWindow() {
            var a = $("#divstatue").html(); 
            var b = DL_END_DEACTIVATE_SUCCEED;// "成功取消激活";
            var c = DL_START_ACTIVATE_FAILURED;//"开始失败";
            if (a.indexOf(b) > 0 || a.indexOf(c) > 0 || !window.parent.isPanalDLCall) {
                myISSI = "";
                flag = false;
            }
            if (flag) {
                alert(Lang_Please_end_monitoring);//("请先结束监听");
                return;
            }
            window.parent.hiddenbg2();
            window.parent.isPanalDLCall = false;
            window.parent.mycallfunction('DLCall');
        }
        //开始监听
        var Lang_Please_choose_monitoring_Terminal = window.parent.parent.GetTextByName("Lang_Please_choose_monitoring_Terminal", window.parent.parent.useprameters.languagedata);
        var Lang_Illegal_terminal_identification = window.parent.parent.GetTextByName("Lang_Illegal_terminal_identification", window.parent.parent.useprameters.languagedata);
        var Lang_This_number_is_in_environmental_monitored = window.parent.parent.GetTextByName("Lang_This_number_is_in_environmental_monitored", window.parent.parent.useprameters.languagedata);
        var Lang_please_end_environmental_monitoring_of_otherCall = window.parent.parent.GetTextByName("Lang_please_end_environmental_monitoring_of_otherCall", window.parent.parent.useprameters.languagedata);

       
        function StartDLCall() {
            var intISSI = document.getElementById('txtISSIText').value.trim();
            var a = $("#divstatue").html();
            var b = DL_END_DEACTIVATE_SUCCEED;//"成功取消激活";
            var c = DL_START_ACTIVATE_FAILURED;// "开始失败";


            if (a.indexOf(b) > 0 || a.indexOf(c) > 0) {
                myISSI = "";
            }
            if (intISSI == "") {
                alert(Lang_Please_choose_monitoring_Terminal);//("请选择要监听的终端");
                return;
            }
            if (/[^\d]/.test(intISSI)) {
                alert(Lang_Illegal_terminal_identification);//("非法终端号码");
                return;
            }
            if (intISSI <= 0 || intISSI > 80699999) {
                alert(Lang_Illegal_terminal_identification);
                return;
            }

            if (myISSI != '') {
                if (intISSI == myISSI) {
                    alert(Lang_This_number_is_in_environmental_monitored);//('此号码已经环境监听了');
                    return;
                }
                if (intISSI != myISSI) {
                    document.getElementById('txtISSIText').value = myISSI;
                    document.getElementById('txtUserName').value = myPName;
                    document.getElementById('txtPoliceNo').value = myPNum;
                    document.getElementById('txtUserEntity').value = myDw;

                    alert(Lang_please_end_environmental_monitoring_of_otherCall);//('请先结束其他号码的环境监听');
                    return;
                }
            }
            $("#btnQCha").css("display", "none");
            $("#btnQChai").css("display", "none");

            if (window.parent.parent.startDL(intISSI) == 1) {
                flag = true;
                myISSI = intISSI;
                $("#btnKSJT").css("display", "none");
                $("#btnJSJT").css("display", "block");
                $("#trBegJT").css("display", "table-row");
                document.getElementById("imgSelectUser").style.display = "none";
                document.getElementById("txtISSIText").disabled = true;
            } else {
                myISSI = "";
              
                flag = false;
            }
        }
        //结束监听
        var Lang_have_stoped_monitoring = window.parent.parent.GetTextByName("Lang_have_stoped_monitoring", window.parent.parent.useprameters.languagedata);
        function EndDLCall() {
            var intISSI = document.getElementById('txtISSIText').value.trim();
            if (!flag) {
                alert(Lang_have_stoped_monitoring);//("监听已经断开");
                return;
            }
            window.parent.parent.endDL(intISSI);
            flag = false;
            myISSI = "";
            $("#btnQCha").css("display", "none");
            $("#btnQChai").css("display", "none");
            $("#btnKSJT").css("display", "block");
            $("#btnJSJT").css("display", "none");
            $("#trBegJT").css("display", "none");
            $("#trQCQC").css("display", "none");
            $("#trPJ").css("display", "none");
            document.getElementById("imgSelectUser").style.display = "block";
            document.getElementById("txtISSIText").disabled = false;
        }
        //强插 监听不结束
        var Lang_Before_listening_do_not_plug = window.parent.parent.GetTextByName("Lang_Before_listening_do_not_plug", window.parent.parent.useprameters.languagedata);
        var Lang_Please_end_other_single_call_in_plug = window.parent.parent.GetTextByName("Lang_Please_end_other_single_call_in_plug", window.parent.parent.useprameters.languagedata);
        function StartCallIntrusion() {
            var intISSI = document.getElementById('txtISSIText').value.trim();
            if (!flag) {
                alert(Lang_Before_listening_do_not_plug);//("还未监听，不可强插");
                return;
            }
            if (window.parent.parent.callPanalISSI != "") {
                alert(Lang_Please_end_other_single_call_in_plug);//("请先结束其他单呼后在强插");
                return;
            }
            if (window.parent.parent.document.frames["PrivateCall"] != null || window.parent.parent.document.frames["PrivateCall"] != undefined) {
                window.parent.parent.mycallfunction('PrivateCall', 380, 280);
            }

            window.parent.parent.startCallintrusion(intISSI);
            myISSI = "";
            iscall = true;
            //强插、开始监听跟结束监听隐藏。显示结束呼叫，假如是半双工则外加显示ptt 强插影藏
            $("#btnQCha").css("display", "none");
            $("#btnKSJT").css("display", "none");
            $("#btnQChai").css("display", "none");
            $("#btnJSJT").css("display", "none");
            $("#btnEndCall").css("display", "block");
            $("#trBegJT").css("display", "none");
            $("#trQCQC").css("display", "none");
            $("#trPJ").css("display", "table-row");
            //            if ($("#divstatue").html().indexOf("全双工还是半双工标志0") > 0) {
            //                $("#btnPTT").css("display", "block");
            //            }
        }
        //强拆 监听结束
        var Lang_Before_listening_do_not_break = window.parent.parent.GetTextByName("Lang_Before_listening_do_not_break", window.parent.parent.useprameters.languagedata);
        function ForceRelease() {
            var intISSI = document.getElementById('txtISSIText').value.trim();
            if (!flag) {
                alert(Lang_Before_listening_do_not_break);//("还未监听，不可强拆");
                return;
            }
            window.parent.parent.forceRelease(intISSI);
            myISSI = "";
            flag = false;
            //强插强拆隐藏，开始监听 结束监听显示
            $("#btnQCha").css("display", "none");
            $("#btnQChai").css("display", "none");
            $("#btnKSJT").css("display", "block");
            $("#btnJSJT").css("display", "none");
            $("#trBegJT").css("display", "table-row");
            $("#trQCQC").css("display", "none");
            $("#trPJ").css("display", "none");

            document.getElementById("imgSelectUser").style.display = "block";
            document.getElementById("txtISSIText").disabled = false;
        }

        //强插后结束呼叫 监听不结束
        var Lang_be_monitored_number = window.parent.parent.GetTextByName("Lang_be_monitored_number", window.parent.parent.useprameters.languagedata);
        var Lang_be_monitoring = window.parent.parent.GetTextByName("Lang_be_monitoring", window.parent.parent.useprameters.languagedata);
        var Lang_None= window.parent.parent.GetTextByName("Lang-None", window.parent.parent.useprameters.languagedata);
        function EndCall() {
            var intISSI = document.getElementById('txtISSIText').value.trim();
            if (document.getElementById("btnPTT").style.display == "block") {
                window.parent.parent.endDC2(intISSI); //半双工
            } else {
                window.parent.parent.endSC2(intISSI); //全双工
            }
            $("#divstatue").html(Lang_be_monitored_number + intISSI + "<br>" + Lang_be_monitoring + "<br>" + Lang_None);//("被监听的号码：" + document.getElementById('txtISSIText').value+"<br>监听中<br>无");
//            if ($("#divstatue").html().indexOf("全双工") > 0) {
//                window.parent.parent.endSC2(document.getElementById('txtISSIText').value); //全双工
//            }
//            if ($("#divstatue").html().indexOf("半双工") > 0) {
//                window.parent.parent.endDC2(document.getElementById('txtISSIText').value); //半双工
//            }
            iscall = false;
            //呼叫结束后 显示强插、强拆按钮
            $("#btnKSJT").css("display", "none");
            $("#btnJSJT").css("display", "block");
            $("#btnEndCall").css("display", "none");
            $("#btnPTT").css("display", "none");
            $("#btnQCha").css("display", "none");
            $("#btnQChai").css("display", "none");
            $("#trBegJT").css("display", "table-row");
            $("#trQCQC").css("display", "none");
            $("#trPJ").css("display", "none");
        }
        function PTTSCALL() {
            var intISSI = document.getElementById('txtISSIText').value.trim();
            if (intISSI == "") {
                return;
            }
            var isEncryption = "0";//xzj--20190320--添加呼叫加密参数
            if (window.parent.parent.useprameters.CallEncryption.indexOf("Single") >= 0) {
                isEncryption = "1";
            }
            window.parent.parent.startSC2(intISSI, isEncryption);
        }
        function CEASEDSCALL() {
            var intISSI = document.getElementById('txtISSIText').value.trim();
            window.parent.parent.sceasedPTT2(intISSI);
        }

        $(document).ready(function () {
            intISSI = document.getElementById('txtISSIText').value.trim();
            window.parent.visiablebg2();
            $("#txtISSIText").change(function () {
//                if (!flag) {
                    $.ajax({
                        type: "POST",
                        url: "../../Handlers/GetUserInfo_Handler.ashx",
                        data: "issi=" + $("#txtISSIText").val().trim(),
                        success: function (msg) {
                            var my = eval(msg);
                            $("#txtUserName").val(my[0].nam);
                            $("#txtUserEntity").val(my[0].entity);
                            $("#txtPoliceNo").val(my[0].num);
                            if (!flag) {
                                myPName = my[0].nam;
                                myPNum = my[0].num;
                                myDw = my[0].entity;
                            }
                            SelectUsers.length = 0;
                            if (my[0].nam != undefined) {
                              
                                SelectUsers.push({ uname: my[0].nam, uissi: $("#txtISSIText").val().trim(), utype: my[0].type, issitype: my[0].issitype });
                            }
                        }
                    });
//                } else {
//                    $("#txtISSIText").val(myISSI);

//                }
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
        var SelectUsers = new Array();
        function OnAddMember() {
            window.parent.mycallfunction('AddMemberTree/add_Member', 650, 514, '0&ifr=DLCall_ifr&selectcount=1&type=user', 2001);
            //window.parent.mycallfunction('AddPrivateCallMember/add_Member', 635, 514, '0&ifr=DLCall_ifr&issi=' + $("#txtISSIText").val().trim(), 2001);
        }
        function faterdo(retrunissis) {
            if (retrunissis.length > 0) {
                SelectUsers.length = 0;
                SelectUsers.push({ uname: retrunissis[0].uname, uissi: retrunissis[0].uissi, utype: retrunissis[0].utype, issitype: retrunissis[0].issitype });
            } else {
                return;
            }

            $("#txtISSIText").val(retrunissis[0].uissi);
            $.ajax({
                type: "POST",
                url: "../../Handlers/GetUserInfo_Handler.ashx",
                data: "issi=" + retrunissis[0].uissi,
                success: function (msg) {
                    var my = eval(msg);
                    $("#txtUserName").val(my[0].nam);
                    $("#txtUserEntity").val(my[0].entity);
                    $("#txtPoliceNo").val(my[0].num);
                    if (!flag) {
                        myPName = my[0].nam;
                        myPNum = my[0].num;
                        myDw = my[0].entity;
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
                                    <img src="../images/tab_03.png" width="15" height="32" />
                                </td>
                                <td width="1101" background="../images/tab_05.gif">
                                    <ul class="hor_ul">
                                        <li>
                                            <img src="../images/037.gif" /><span id="Lang_CloseMonitoring" ><%--慎密监听--%></span></li>
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
                                        <td class="style3" align="right" style="width: 80px;">
                                            <div >
                                                <%--终端号码：--%><span id="divIssiTitle"></span><span>&nbsp;&nbsp</span></div>
                                        </td>
                                        <td class="style3" align="left">

                                        <input type="text" id="txtISSIText" runat="server" />
                                           
                                        </td>
                                        <td align="left" style="width: 120px;">
                                             <form id="Form1" runat="server">
                                            
                                            <img src="<%--../images/chooseMember0.png--%>" id="imgSelectUser" onclick="OnAddMember()" onmouseover="<%--javascript:this.src='../images/chooseMember_un.png';--%>"
                                                onmouseout="<%--javascript:this.src='../images/chooseMember0.png';--%>" />
                                            <asp:Button ID="btnnew" runat="server" Visible="false" Text="<%--新增--%>" CssClass="CALLBUTTON2" Enabled="false" />
                                            </form>
                                            </td>
                                    </tr>
                                    <tr>
                                        <td  class="style3" align="right" style="width: 60px;">
                                            <%--姓名：--%><span id="Lang_name"></span><span>&nbsp;&nbsp</span>
                                        </td>
                                        <td class="style3" align="left" colspan="2">
                                            <input type="text" readonly="readonly" disabled="disabled" style="width: 240px" id="txtUserName" runat="server" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td  class="style3" align="right" style="width: 60px;">
                                           <%-- 单位：--%><span id="Lang_Unit"></span><span>&nbsp;&nbsp</span>
                                        </td>
                                        <td class="style3" align="left" colspan="2">
                                            <input type="text" readonly="readonly" disabled="disabled" style="width: 240px" id="txtUserEntity" runat="server" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td  class="style3" align="right" style="width: 60px;">
                                            <%--编号：--%><span id="Lang_Serialnumber"></span><span>&nbsp;&nbsp</span>
                                        </td>
                                        <td class="style3" align="left" colspan="2">
                                            <input type="text" readonly="readonly" disabled="disabled" style="width: 240px" id="txtPoliceNo" runat="server" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td  class="style3" align="right" style="width: 60px; height: 60px">
                                           <%-- 呼叫状态：--%><span id="Lang_call_status"></span><span>&nbsp;&nbsp</span>
                                        </td>
                                        <td class="style3" align="left" colspan="2">
                                            <div id="divstatue">
                                                <%--无--%></div>
                                        </td>
                                    </tr>
                                    <tr id="trBegJT">
                                        <td class="style3" align="center" colspan="3">
                                            <table>
                                                <tr>
                                                    <td>
                                                        <button id="btnKSJT" class="btn" style="width: 70px; text-align: center; vertical-align: bottom"
                                                            onclick="StartDLCall()">
                                                            <%--开始监听--%></button>
                                                    </td>
                                                    <td>
                                                        <button id="btnJSJT" class="btn" style="width: 70px; display: none; text-align: center"
                                                            onclick="EndDLCall()">
                                                            <%--结束监听--%></button>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr id="trQCQC" style="display: none">
                                        <td class="style3" align="center" colspan="3">
                                            <table>
                                                <tr>
                                                    <td>
                                                        <button id="btnQCha" class="btn" style="width: 120px; display: none; text-align: center;
                                                            vertical-align: bottom;" onclick="StartCallIntrusion()">
                                                            <%--强插--%></button>
                                                    </td>
                                                    <td>
                                                        <button id="btnQChai" class="btn" style="width: 120px; display: none; text-align: center"
                                                            onclick="ForceRelease()">
                                                            <%--强拆--%>
                                                        </button>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr id="trPJ" style="display: none">
                                        <td class="style3" align="center" colspan="3">
                                            <table>
                                                <tr>
                                                    <td>
                                                        <button id="btnPTT" class="btn" style="width: 70px; display: none; text-align: center;
                                                            vertical-align: bottom;" onmousedown="PTTSCALL()" onmouseout="CEASEDSCALL()" onmouseup="CEASEDSCALL()">
                                                            PTT
                                                        </button>
                                                    </td>
                                                    <td>
                                                        <button id="btnEndCall" class="btn" style="width: 70px; display: none; text-align: center"
                                                            onclick="EndCall()">
                                                            <%--结束呼叫--%>
                                                        </button>
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

    window.document.getElementById("btnQChai").innerHTML = window.parent.parent.GetTextByName("Lang_break", window.parent.parent.useprameters.languagedata);  
    window.document.getElementById("btnEndCall").innerHTML = window.parent.parent.GetTextByName("ENDING_CALL", window.parent.parent.useprameters.languagedata);
    window.document.getElementById("divIssiTitle").innerHTML = window.parent.parent.GetTextByName("Lang_terminal_identification", window.parent.parent.useprameters.languagedata);
    window.document.getElementById("divstatue").innerHTML = window.parent.parent.GetTextByName("Lang-None", window.parent.parent.useprameters.languagedata);
    window.document.getElementById("btnKSJT").innerHTML = window.parent.parent.GetTextByName("btn_StartListening", window.parent.parent.useprameters.languagedata);
    window.document.getElementById("btnJSJT").innerHTML = window.parent.parent.GetTextByName("btn_EndListening", window.parent.parent.useprameters.languagedata);
    window.document.getElementById("btnQCha").innerHTML = window.parent.parent.GetTextByName("Lang_plug", window.parent.parent.useprameters.languagedata);

</script>
<link href="../../CSS/lq_calloutExtender.css" rel="stylesheet" type="text/css" />
