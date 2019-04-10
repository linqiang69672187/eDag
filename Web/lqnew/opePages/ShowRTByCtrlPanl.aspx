<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ShowRTByCtrlPanl.aspx.cs"
    Inherits="Web.lqnew.opePages.ShowRTByCtrlPanl" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns:v>
<head id="Head1" runat="server">
    <link href="../css/lq_addedit.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/pagestyle.css" rel="stylesheet" type="text/css" />
    <link href="../css/btn.css" rel="stylesheet" type="text/css" />
    <?import namespace="v" implementation="#default#VML" ?>
    <style>
        v\:* {
            behavior: url(#default#VML);
            position: absolute;
        }

        o\:* {
            behavior: url(#default#VML);
        }
    </style>
    <script src="/JQuery/jquery-1.5.2.js" type="text/javascript"></script>
    <script src="/MyCommonJS/ajax.js" type="text/javascript"></script>
    <script src="/JS/LangueSwitch.js" type="text/javascript"></script>
    <title></title>
    <style type="text/css">
        body {
            color: White;
            font-size: 12px;
        }
    </style>
    <script src="../js/geturl.js" type="text/javascript"></script>
    <script src="../js/dragwindow.js" type="text/javascript"></script>
    <script type="text/javascript">
        var la = "";
        var lo = "";
        var SelectUsers = new Array();
        function OnAddMember() {
            window.parent.mycallfunction('AddMemberTree/add_Member', 650, 514, '0&ifr=ShowRTByCtrlPanl_ifr&selectcount=1&type=user', 2001);
            //window.parent.mycallfunction('AddPrivateCallMember/add_Member', 635, 514, '0&ifr=ShowRTByCtrlPanl_ifr&issi=' + $("#txtISSIText").val(), 2001);
        }
        function faterdo(retrunissis) {
            if (retrunissis.length > 0) {
                SelectUsers.length = 0;
                SelectUsers.push({ uname: retrunissis[0].uname, uissi: retrunissis[0].uissi, utype: retrunissis[0].utype });
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
                    myID = my[0].id;
                    $("#txtUserName").val(my[0].nam);
                    $("#txtUserEntity").val(my[0].entity);
                    $("#txtPoliceNo").val(my[0].num);
                    lo = my[0].lo;
                    la = my[0].la;
                    //alert(my[0].isdisplay);
                    var Lang_Display_click_OK_button_turn_off_the_display = window.parent.parent.GetTextByName("Lang_Display_click_OK_button_turn_off_the_display", window.parent.parent.useprameters.languagedata);
                    var Lang_Hidden_click_the_OK_button_will_open_display = window.parent.parent.GetTextByName("Lang_Hidden_click_the_OK_button_will_open_display", window.parent.parent.useprameters.languagedata);

                    if (my[0].isdisplay == 'True') {
                        $("#txtStutas").val(Lang_Display_click_OK_button_turn_off_the_display);//('显示中，点击确定按钮将关闭显示');
                        isShowed = true;
                    } else if (my[0].isdisplay == 'False') {
                        $("#txtStutas").val(Lang_Hidden_click_the_OK_button_will_open_display);//('隐藏中，点击确定按钮将开启显示');

                        isShowed = false;
                    } else {
                        $("#txtStutas").val('');
                    }

                }
            });
        }
        function immediately() {
            var element = document.getElementById("txtISSIText");
            if (element.value == "") {
                element.onpropertychange = webChange;
            }
        }
        function webChange() {
            document.getElementById("txtUserName").value = "";
            document.getElementById("txtUserEntity").value = "";
            document.getElementById("txtStutas").value = "";

        }

    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
                <tr>
                    <td height="30">
                        <div id="divdrag" style="cursor: move">
                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td width="15" height="32">
                                        <asp:ScriptManager ID="ScriptManager1" runat="server">
                                        </asp:ScriptManager>
                                        <img src="../images/tab_03.png" width="15" height="32" />
                                    </td>
                                    <td id="Lang_realTimeDisplay" width="1101" background="../images/tab_05.gif">
                                        <%--实时显示--%>
                                    </td>
                                    <td width="281" background="../images/tab_05.gif" align="right">
                                        <img class="style6" style="cursor: hand;" onclick="javascript:window.parent.hiddenbg2();window.parent.mycallfunction(geturl(),693, 354)"
                                            onmouseover="javascript:this.src='../images/close_un.png';" onmouseout="javascript:this.src='../images/close.png';"
                                            src="../images/close.png" />
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
                                <td width="15" background="../images/tab_12.gif">&nbsp;
                                </td>
                                <td>
                                    <table class="style1" cellspacing="1" id="dragtd">
                                        <tr>
                                            <td class="style3" align="right">
                                                <%--终端号码:--%><span id="Lang_terminal_identification"></span><span>&nbsp;&nbsp</span>
                                            </td>
                                            <td colspan="1">
                                                <input type="text" id="txtISSIText" runat="server" />
                                                <asp:Button ID="btnnew" runat="server" Visible="false" Text="" CssClass="CALLBUTTON2"
                                                    Enabled="false" /><%--新增--%>
                                            </td>
                                            <td>
                                                <img src="<%--../images/chooseMember0.png--%>"
                                                    id="imgSelectUser" onclick="OnAddMember()" onmouseover="<%--javascript:this.src='../images/chooseMember_un.png';--%>"
                                                    onmouseout="<%--javascript:this.src='../images/chooseMember0.png';--%>" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">
                                                <%--姓名--%><span id="Lang_name"></span><span>&nbsp;&nbsp</span>
                                            </td>
                                            <td colspan="2">
                                                <input type="text" disabled="disabled" readonly="readonly" style="width: 240px" id="txtUserName" runat="server" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">
                                                <%--单位--%><span id="Lang_Unit"></span><span>&nbsp;&nbsp</span>
                                            </td>
                                            <td colspan="2">
                                                <input type="text" disabled="disabled" readonly="readonly" style="width: 240px" id="txtUserEntity" runat="server" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">
                                                <%-- 状态--%><span id="Lang_Status"></span><span>&nbsp;&nbsp</span>
                                            </td>
                                            <td colspan="2">
                                                <input type="text" disabled="disabled" readonly="readonly" style="width: 240px" id="txtStutas" runat="server" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="3" align="center">
                                                <img id="add_okPNG" style="margin: 0px 0px 0px 3px; cursor: hand;" src="<%--../images/add_ok.png--%>" onclick="DoSubmit()" />
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
                        <table width="100%" border="0" style="background-color: White;" cellspacing="0" cellpadding="0">
                            <tr>
                                <td width="15" height="15">
                                    <img src="../images/tab_20.png" width="15" height="15" />
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
<script language="javascript" type="text/javascript">
    function geturl() {
        var str = window.location.href;
        str = str.substring(str.lastIndexOf("/") + 1)
        str = str.split(".")[0];
        return str;
    }
</script>
</html>
<script type="text/javascript">
    window.parent.closeprossdiv();
    immediately();
    var myID = "";
    var myISSI = "";
    var isShowed = false;
    var Terminal = window.parent.parent.GetTextByName("Terminal", window.parent.parent.useprameters.languagedata);
    var Lang_open_ISSI = window.parent.parent.GetTextByName("Lang_open_ISSI", window.parent.parent.useprameters.languagedata);
    var Lang_hidden_ISSI = window.parent.parent.GetTextByName("Lang_hidden_ISSI", window.parent.parent.useprameters.languagedata);
    var DeviceDisplay = window.parent.parent.GetTextByName("DeviceDisplay", window.parent.parent.useprameters.languagedata);
    var Lang_Illegal_ISSI_or_fail_to_mobile_user_bind = window.parent.parent.GetTextByName("Lang_Illegal_ISSI_or_fail_to_mobile_user_bind", window.parent.parent.useprameters.languagedata);

    var image1 = window.document.getElementById("add_okPNG");
    var srouce1 = window.parent.parent.GetTextByName("Lang_edit_entity", window.parent.parent.useprameters.languagedata);
    image1.setAttribute("src", srouce1);
    var loIsOAndLaIsONotOpenShowRT = window.parent.parent.GetTextByName("loIsOAndLaIsONotOpenShowRT", window.parent.parent.useprameters.languagedata);

    function DoSubmit() {
        if (lo == "" || la == "" || lo == "0.0000000" || la == "0.0000000") {
            alert(loIsOAndLaIsONotOpenShowRT);//("此用户经纬度为0 或者不存在，不能开始或关闭实时显示");
            return;
        }

        if (isShowed) {//显示状态去关闭
            //window.parent.changevis('hidden', $("#txtISSIText").val());
            //window.parent.writeLog("oper", "[终端显示]：隐藏ISSI(" + $("#txtISSIText").val() + ")的终端" + "[" + window.parent.LOGTimeGet() + "]");         /**日志：操作日志 **/
            window.parent.writeLog("oper", "[" + DeviceDisplay + "]:" + Lang_hidden_ISSI + "(" + $("#txtISSIText").val() + ")" + Terminal + "[" + window.parent.LOGTimeGet() + "]");         /**日志：操作日志 **/

        } else { //关闭状态 去显示
            //window.parent.changevis('visable', $("#txtISSIText").val()); 
            //window.parent.writeLog("oper", "[终端显示]：开启ISSI(" + $("#txtISSIText").val() + ")的终端" + "[" + window.parent.LOGTimeGet() + "]");         /**日志：操作日志 **/
            window.parent.writeLog("oper", "[" + DeviceDisplay + "]:" + Lang_open_ISSI + "(" + $("#txtISSIText").val() + ")" + Terminal + "[" + window.parent.LOGTimeGet() + "]");         /**日志：操作日志 **/

        }
        if ($("#txtUserName").val() == "") {
            alert(Lang_Illegal_ISSI_or_fail_to_mobile_user_bind);//("非法ISSI或未予移动用户绑定");
            return;
        }
        var userissi = $("#txtISSIText").val();
        if (window.parent.useprameters.lockid == myID) {
            alert(window.parent.GetTextByName("PoliceLockUnHidden", window.parent.useprameters.languagedata)); //多语言：锁定状态禁止隐藏
            return;
        }

        $.ajax({
            type: "POST",
            url: "../../Handlers/OpenOrDisplayUserShow.ashx?cmd=" + isShowed + "&userissi=" + $("#txtISSIText").val(),
            success: function (msg) {

                changeUserVisible(userissi, isShowed);

                //window.parent.hiddenbg2();
                //window.parent.mycallfunction(geturl(), 693, 354);
            }
        });
    }

    function changeUserVisible(ISSI, isShowed) {
        try {

            var myDate = new Date();
            var sec = myDate.getSeconds().toString() + myDate.getMilliseconds().toString();
            var param = {
                sec: sec,
                ISSI: ISSI
            };
            jquerygetNewData_ajax("/WebGis/Service/getIdByISSI.aspx", param, function (request) {
                var userId = request;
                if (isShowed) {
                    var i = window.parent.inarrISSI.length;
                    while (i--) {
                        if (window.parent.inarrISSI[i] == ISSI)
                            break;
                    }
                    if (i == -1) {
                        window.parent.inarrISSI.push(ISSI);
                        window.parent.delSelectUserVar(userId, ISSI);
                        //checkDisplayImg(id, false);
                        window.parent.hidPerUser(userId, 1);

                    }
                }
                else {
                    var i = window.parent.inarrISSI.length;
                    while (i--) {
                        if (window.parent.inarrISSI[i] == ISSI) {
                            window.parent.inarrISSI.splice(i, 1);
                            //window.parent.useprameters.Selectid.push(userId);
                            //window.parent.useprameters.SelectISSI.push(ISSI);
                            //checkDisplayImg(id, true);
                            window.parent.hidPerUser(userId, "0");
                            break;
                        }
                    }

                }

                //window.parent.hiddenbg2();
                setTimeout(window.parent.mycallfunction(geturl(), 693, 354),1000);
            }
            );

        }
        catch (e) {
            changeUserVisible(ISSI, isShowed)
        }

    }

    function getQueryStringRegExp(id) {
        var reg = new RegExp("(^|\\?|&)" + id + "=([^&]*)(\\s|&|$)", "i");
        if (reg.test(location.href)) return unescape(RegExp.$2.replace(/\+/g, " ")); return "";
    };
    window.onload = function () {
        LanguageSwitch(window.parent);
        window.parent.visiablebg2();

        var image = window.document.getElementById("imgSelectUser");
        var srouce = window.parent.parent.GetTextByName("Lang_chooseMemberPNG", window.parent.parent.useprameters.languagedata);
        image.setAttribute("src", srouce);
        var strpath = window.parent.parent.GetTextByName("Lang_chooseMemberPNG", window.parent.parent.useprameters.languagedata);
        var strpathmove = window.parent.parent.GetTextByName("Lang_chooseMemberPNG_un", window.parent.parent.useprameters.languagedata);
        image.onmouseover = function () { image.src = strpathmove }
        image.onmouseout = function () { image.src = strpath }




        var Lang_Illegal_ISSI = window.parent.parent.GetTextByName("Lang_Illegal_ISSI", window.parent.parent.useprameters.languagedata);
        $("#txtISSIText").change(function () {
            if (/[^\d]/.test($("#txtISSIText").val())) {
                alert(Lang_Illegal_ISSI);//("非法ISSI");
                return;
            }

            $.ajax({
                type: "POST",
                url: "../../Handlers/GetUserInfo_Handler.ashx",
                data: "issi=" + $("#txtISSIText").val(),
                success: function (msg) {

                    var my = eval(msg);
                    var Lang_Display_click_OK_button_turn_off_the_display = window.parent.parent.GetTextByName("Lang_Display_click_OK_button_turn_off_the_display", window.parent.parent.useprameters.languagedata);
                    var Lang_Hidden_click_the_OK_button_will_open_display = window.parent.parent.GetTextByName("Lang_Hidden_click_the_OK_button_will_open_display", window.parent.parent.useprameters.languagedata);
                    myID = my[0].id;
                    $("#txtUserName").val(my[0].nam);
                    $("#txtUserEntity").val(my[0].entity);
                    $("#txtPoliceNo").val(my[0].num);
                    lo = my[0].lo;
                    la = my[0].la;
                    //alert(my[0].isdisplay);
                    if (my[0].isdisplay == 'True') {
                        $("#txtStutas").val(Lang_Display_click_OK_button_turn_off_the_display);//('显示中，点击确定按钮将关闭显示');
                        isShowed = true;
                    } else if (my[0].isdisplay == 'False') {
                        $("#txtStutas").val(Lang_Hidden_click_the_OK_button_will_open_display);//('鍏抽棴鏄剧ず涓紝鐐瑰嚮纭畾鎸夐挳灏嗗紑鍚樉绀?);
                        isShowed = false;
                    } else {
                        $("#txtStutas").val('');
                    }
                    SelectUsers.length = 0;
                    if (my[0].nam != undefined) {
                        SelectUsers.push({ uname: my[0].nam, uissi: $("#txtISSIText").val().trim(), utype: my[0].type });
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
    }
    var dragEnable = 'True';
    function dragdiv() {
        var div1 = window.parent.document.getElementById(geturl());
        if (div1 && event.button == 1 && dragEnable == 'True') {
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
</script>
