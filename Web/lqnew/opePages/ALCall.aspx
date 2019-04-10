<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ALCall.aspx.cs" Inherits="Web.lqnew.opePages.ALCall" %>

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
        var flag = false;
        var myISSI = "";
        var myPName = "";
        var myPNum = "";
        var myDw = "";
        var Lang_Monitoring_call_break = window.parent.parent.GetTextByName("Lang_Monitoring_call_break", window.parent.parent.useprameters.languagedata);
        var Pleaseendenvironmentalmonitoring = window.parent.parent.GetTextByName("Pleaseendenvironmentalmonitoring", window.parent.parent.useprameters.languagedata);//请先结束环境监听

        function setFlagFalse() {
            flag = false;
            myISSI = "";
        }
        function setFlagTrue() {
            flag = true;
        }

        function CloseWindow() {
            if ($("#divstatue").html().indexOf(Lang_Monitoring_call_break) > 0) {//监听呼叫断开
                flag = false;
                myISSI = "";
            }
            if (flag) {
                alert(Pleaseendenvironmentalmonitoring);//("请先结束环境监听");
                return;
            }
            window.parent.isPanalALCall = false;
            window.parent.hiddenbg2();
            window.parent.mycallfunction('ALCall');
        }
        var Lang_Please_choose_monitoring_Terminal = window.parent.parent.GetTextByName("Lang_Please_choose_monitoring_Terminal", window.parent.parent.useprameters.languagedata);
        var Lang_Monitoring_call_break = window.parent.parent.GetTextByName("Lang_Monitoring_call_break", window.parent.parent.useprameters.languagedata);//监听呼叫断开
        var Lang_Illegal_terminal_identification = window.parent.parent.GetTextByName("Lang_Illegal_terminal_identification", window.parent.parent.useprameters.languagedata);
        var Lang_This_number_is_in_environmental_monitored = window.parent.parent.GetTextByName("Lang_This_number_is_in_environmental_monitored", window.parent.parent.useprameters.languagedata);
        var Lang_please_end_environmental_monitoring_of_otherCall = window.parent.parent.GetTextByName("Lang_please_end_environmental_monitoring_of_otherCall", window.parent.parent.useprameters.languagedata);
        var Lang_Environmental_monitoring_failure = window.parent.parent.GetTextByName("Lang_Environmental_monitoring_failure", window.parent.parent.useprameters.languagedata);

        
        function StartALCall() {
            var intISSI = document.getElementById('txtISSIText').value.trim();
            if (intISSI == "") {
                alert(Lang_Please_choose_monitoring_Terminal);//("请选择要监听的终端");
                return;
            }
            if ($("#divstatue").html().indexOf(Lang_Monitoring_call_break) > 0) {//监听呼叫断开
                $("#btnEndCall").css("display", "none");
                $("#btnStartCall").css("display", "block");
                flag = false;
                myISSI = "";
            }
            if (/[^\d]/.test(intISSI)){
                alert(Lang_Illegal_terminal_identification);//("非法终端号码");
                return;
            }
            if (intISSI <= 0 || intISSI > 80699999) {
                alert(Lang_Illegal_terminal_identification);
                return;
            }
            if (intISSI == "")
                return;
            if (myISSI != "") {
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
            } else {
                if (window.parent.parent.startAL(intISSI) == 1) {
                    flag = true;
                    myISSI = intISSI;
                    $("#btnEndCall").css("display", "block");
                    $("#btnStartCall").css("display", "none");
                } else {
                    document.getElementById("divstatue").innerHTML = Lang_Environmental_monitoring_failure;//"环境监听失败!";
                }
            }
            document.getElementById("imgSelectUser").style.display = "none";
            document.getElementById("txtISSIText").disabled = true;
        }
        function EndALCall() {
            var intISSI = document.getElementById('txtISSIText').value.trim();
            if ($("#divstatue").html().indexOf(Lang_Monitoring_call_break) > 0) {//监听呼叫断开

                $("#btnEndCall").css("display", "none");
                $("#btnStartCall").css("display", "block");
                myISSI = "";
                flag = false;
                return;
            }
            if (!flag) {
                $("#btnEndCall").css("display", "none");
                $("#btnStartCall").css("display", "block");
                return;
            }
            window.parent.parent.endAL(myISSI);
            flag = false;
            myISSI = "";
            $("#btnEndCall").css("display", "none");
            $("#btnStartCall").css("display", "block");
            document.getElementById("imgSelectUser").style.display = "block";
            document.getElementById("txtISSIText").disabled = false;
        }


        $(document).ready(function () {
            
            window.parent.visiablebg2();
            $("#txtISSIText").change(function () {
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
            //window.parent.mycallfunction('AddPrivateCallMember/add_Member', 635, 514, '0&ifr=ALCall_ifr&issi=' + $("#txtISSIText").val().trim(), 2001);
            window.parent.mycallfunction('AddMemberTree/add_Member', 650, 514, '0&ifr=ALCall_ifr&selectcount=1&type=user', 2001);
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
                                    <img alt="" src="../images/tab_03.png" width="15" height="32" />
                                </td>
                                <td width="1101" background="../images/tab_05.gif">
                                    <ul class="hor_ul">
                                        <li>
                                            <img alt="" src="../images/037.gif" /><span id="Lang_EnvironmentalMonitoring" ><%--环境监听--%></span></li>
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
                                        <td class="style3" align="right" style="width: 80px;">
                                            <div>
                                                <%--终端号码：--%><span  id="divIssiTitle"></span><span>&nbsp;&nbsp</span></div>
                                        </td>
                                        <td class="style3" align="left">
                                         <input type="text" id="txtISSIText" runat="server" />
                                           
                                        </td>
                                        <td align="left" style="width: 120px;">
                                         <form id="Form1" runat="server">
                                            
                                            <img alt="" src="<%--../images/chooseMember0.png--%>" id="imgSelectUser" onclick="OnAddMember()" onmouseover="<%--javascript:this.src='../images/chooseMember_un.png';--%>"
                                                onmouseout="<%--javascript:this.src='../images/chooseMember0.png';--%>" />
                                               
                                            <asp:Button ID="btnnew" runat="server" Visible="false" Text="<%--新增--%>" CssClass="CALLBUTTON2" Enabled="false" />
                                            </form>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td  class="style3" align="right" style="width: 60px;">
                                          <%--  姓名：--%><span id="Lang_name"></span><span>&nbsp;&nbsp</span>
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
                                        <td  class="style3" align="right" style="width: 60px; height:40px">
                                           <%-- 呼叫状态：--%><span id="Lang_call_status"></span><span>&nbsp;&nbsp</span>
                                        </td>
                                        <td class="style3" align="left" colspan="2">
                                            <div id="divstatue">
                                                <%--无--%></div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="style3" align="center" colspan="3">
                                            <button id="btnStartCall" class="btn" style="width: 70px; text-align: center; vertical-align: bottom"
                                                onclick="StartALCall()">
                                                <%--开始监听--%></button>
                                            <button id="btnEndCall" class="btn" style="width: 70px; display: none; text-align: center"
                                                onclick="EndALCall()">
                                                <%--结束监听--%></button>
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

    window.document.getElementById("btnStartCall").innerHTML = window.parent.parent.GetTextByName("btn_StartListening", window.parent.parent.useprameters.languagedata);
    window.document.getElementById("btnEndCall").innerHTML = window.parent.parent.GetTextByName("btn_EndListening", window.parent.parent.useprameters.languagedata);
    window.document.getElementById("divIssiTitle").innerHTML = window.parent.parent.GetTextByName("Lang_terminal_identification", window.parent.parent.useprameters.languagedata);
    window.document.getElementById("divstatue").innerHTML = window.parent.parent.GetTextByName("Lang-None", window.parent.parent.useprameters.languagedata);

</script>
<link href="../../CSS/lq_calloutExtender.css" rel="stylesheet" type="text/css" />
