<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LocationAtOnceByCtrlPanl.aspx.cs" Inherits="Web.lqnew.opePages.LocationAtOnceByCtrlPanl" %>


<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns:v>
<head id="Head1" runat="server">
    <link href="../css/btn.css" rel="stylesheet" type="text/css" />
    <link href="../css/lq_addedit.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/pagestyle.css" rel="stylesheet" type="text/css" />
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
    <script src="../../JQuery/jquery-1.5.2.js" type="text/javascript"></script>
    <title></title>
    <style type="text/css">
        body {
            color: White;
            font-size: 12px;
        }
    </style>
    <script src="../js/geturl.js" type="text/javascript"></script>
    <script src="../js/dragwindow.js" type="text/javascript"></script>
    <script src="../../JS/LangueSwitch.js" type="text/javascript"></script>
    <script type="text/javascript">
        var SelectUsers = new Array();
        function OnAddMember() {
            window.parent.mycallfunction('AddMemberTree/add_Member', 650, 514, '0&ifr=LocationAtOnceByCtrlPanl_ifr&selectcount=1&type=user', 2001);
            //window.parent.mycallfunction('AddPrivateCallMember/add_Member', 635, 514, '0&ifr=LocationAtOnceByCtrlPanl_ifr&issi=' + $("#txtISSIText").val(), 2001);
        }

        function immediately() {
            var element = document.getElementById("txtISSIText");
            if (element.value == "") {
                element.onpropertychange = webchange;
            }
            else {
                element.addEventListener("input", webChange, false);
            }
        }
        function webchange() {

            document.getElementById("txtUserName").value = "";
            document.getElementById("txtUserEntity").value = "";
        }

        function faterdo(retrunissis) {
            var Lang_This_ISSI_number_have_no_GPS = window.parent.parent.GetTextByName("Lang_This_ISSI_number_have_no_GPS", window.parent.parent.useprameters.languagedata);
            if (retrunissis.length > 0) {
                SelectUsers.length = 0;
                SelectUsers.push({ uname: retrunissis[0].uname, uissi: retrunissis[0].uissi, utype: retrunissis[0].utype, issitype: retrunissis[0].issitype });
            } else {
                return;
            }
            $("#txtISSIText").val(retrunissis[0].uissi);
            $.ajax({
                type: "POST",
                url: "../../Handlers/GetUserLoLaInfoByISSI.ashx",
                data: "issi=" + retrunissis[0].uissi,
                success: function (msg) {

                    var my = eval(msg);
                    if (my.length > 0 && $("#txtISSIText").val() != undefined && $("#txtISSIText").val() != "") {
                        myID = my[0].Identification;
                        $("#txtUserName").val(my[0].Lang_name);
                        $("#txtUserEntity").val(my[0].Unit);
                        $("#txtPoliceNo").val(my[0].Number);
                        myLo = my[0].Lang_Longitude;
                        myLa = my[0].Lang_Latitude;

                    } else {
                        alert(Lang_This_ISSI_number_have_no_GPS);//("此ISSI号码无GPS经纬度信息");
                    }

                }
            });
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
                                    <td id="Lang_immediateLocation" width="1101" background="../images/tab_05.gif">
                                        <%-- 立即定位--%>
                                    </td>
                                    <td width="281" background="../images/tab_05.gif" align="right">
                                        <img class="style6" style="cursor: hand;" onclick="javacript:window.parent.hiddenbg2();window.parent.mycallfunction(geturl(),693, 354)"
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
                        <table width="100%" border="0" style="background-color: White; color: Black;" cellspacing="0"
                            cellpadding="0">
                            <tr>
                                <td width="15" background="../images/tab_12.gif">&nbsp;
                                </td>
                                <td>
                                    <table class="style1" cellspacing="1" id="dragtd">
                                        <tr>
                                            <td align="right">
                                                <%-- 终端号码:--%><span id="Lang_terminal_identification"></span><span>&nbsp;&nbsp</span>
                                            </td>
                                            <td colspan="1">
                                                <input type="text" id="txtISSIText" runat="server" />
                                                <asp:Button ID="btnnew" runat="server" Text="<%--新增--%>" Visible="false" CssClass="CALLBUTTON2" Enabled="false" />
                                            </td>
                                            <td>
                                                <img src="<%--../images/chooseMember0.png--%>" id="imgSelectUser" onclick="OnAddMember()" onmouseover="<%--javascript:this.src='../images/chooseMember_un.png';--%>"
                                                    onmouseout="<%--javascript:this.src='../images/chooseMember0.png';--%>" />
                                            </td>
                                        </tr>
                                        <tr>

                                            <td align="right">
                                                <%--姓名:--%><span id="Lang_name"></span><span>&nbsp;&nbsp</span>
                                            </td>
                                            <td colspan="2">
                                                <input type="text" readonly="readonly" disabled="disabled" style="width: 240px" id="txtUserName" runat="server" />
                                            </td>

                                        </tr>
                                        <tr>

                                            <td align="right">
                                                <%--单位:--%><span id="Lang_Unit"></span><span>&nbsp;&nbsp</span>
                                            </td>
                                            <td colspan="2">
                                                <input type="text" readonly="readonly" disabled="disabled" style="width: 240px" id="txtUserEntity" runat="server" />
                                            </td>

                                        </tr>
                                        <%-- <tr>
                            <td width="15" background="../images/tab_12.gif">
                                &nbsp;
                            </td>
                            <td>
                                状态
                            </td>
                            <td colspan="2">
                                <input type="text" readonly="readonly" style="width: 240px" id="txtStutas" runat="server" />
                            </td>
                            <td width="15" background="../images/tab_16.gif">
                                &nbsp;
                            </td>
                        </tr>--%>
                                        <tr>

                                            <td colspan="3" align="center">
                                                <img id="add_okPNG" style="margin: 0px 0px 0px 3px; cursor: hand;" src="<%--../images/add_ok.png--%>" onclick="DoSubmit()" />
                                            </td>

                                        </tr>
                                    </table>
                                </td>

                                <td width="15" background="../images/tab_16.gif">&nbsp;
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
<script language="javascript">
    function geturl() {
        var str = window.location.href;
        str = str.substring(str.lastIndexOf("/") + 1)
        str = str.split(".")[0];
        return str;
    }
</script>
</html>
<script>
    window.parent.closeprossdiv();
    immediately();
    var myID = "";
    var myLo = "";
    var myLa = "";
    //function DoSubmit() {
    //    var Lang_Latitude_and_longitude_does_not_exist = window.parent.parent.GetTextByName("Lang_Latitude_and_longitude_does_not_exist", window.parent.parent.useprameters.languagedata);
    //    var Lang_Illegal_ISSI_or_fail_to_mobile_user_bind = window.parent.parent.GetTextByName("Lang_Illegal_ISSI_or_fail_to_mobile_user_bind", window.parent.parent.useprameters.languagedata);
    //    if ($("#txtUserName").val() == "") {
    //        alert(Lang_Illegal_ISSI_or_fail_to_mobile_user_bind);//("非法ISSI或未于移动用户绑定");
    //        return;
    //    }
    //    if (myLo == "" || myLa == "" || myLa == "0.0000000" || myLo == "0.0000000") {
    //        alert(Lang_Latitude_and_longitude_does_not_exist);//("经纬度不存在");
    //        return;
    //    }
    //    pars = "Police,0,0" + "|" + myID + "|" + myLo + "|" + myLa;
    //    //window.parent.thisLocation(pars);
    //    //window.parent.showlocalpic(pars);
    //    window.parent.locationbyUseid(myID);
    //    window.parent.hiddenbg2();
    //    window.parent.mycallfunction(geturl(), 693, 354);
    //}
    function DoSubmit() {

        var Lang_Illegal_ISSI_or_fail_to_mobile_user_bind = window.parent.parent.GetTextByName("Lang_Illegal_ISSI_or_fail_to_mobile_user_bind", window.parent.parent.useprameters.languagedata);//非法ISSI
        var Lang_InstructionSucess = window.parent.parent.GetTextByName("Lang_InstructionSucess", window.parent.parent.useprameters.languagedata);//指令下发成功
        var Lang_LocationFailed = window.parent.parent.GetTextByName("Lang_LocationFailed", window.parent.parent.useprameters.languagedata);//定位失败
        var Lang_ThisOperFailed = window.parent.parent.GetTextByName("Lang_ThisOperFailed", window.parent.parent.useprameters.languagedata); //该次操作失败
        var Lang_oxcunsuporrtlocation = window.parent.parent.GetTextByName("Lang_oxcunsuporrtlocation", window.parent.parent.useprameters.languagedata);//所安装控件不支持立即定位功能，若需使用立即定位功能，请更新控件版本
        var checkcallcontrolregister = window.parent.parent.GetTextByName("checkcallcontrolregister", window.parent.parent.useprameters.languagedata);//请检查呼叫控件是否正确安装
        var Lang_Illegal_ISSI = window.parent.parent.GetTextByName("Lang_Illegal_ISSI", window.parent.parent.useprameters.languagedata);//非法终端号码
        var LTE_NotAccept_toLocationGPS = window.parent.parent.GetTextByName("LTE_NotAccept_toLocationGPS", window.parent.parent.useprameters.languagedata);//非法终端号码

        if (/[^\d]/.test($("#txtISSIText").val())) {
            alert(Lang_Illegal_ISSI);//("闈炴硶ISSI");
            return;
        }
        if ($("#txtUserName").val() == "") {
            alert(Lang_Illegal_ISSI_or_fail_to_mobile_user_bind);
            return;
        }

        if (SelectUsers <= 0) {
            alert(Lang_Illegal_ISSI_or_fail_to_mobile_user_bind);
            return;
        }

        var issi = document.getElementById("txtISSIText").value;

        //陈洁伟修改，调用控件立即定位
        var scactionX = window.parent.frames['log_windows_ifr'].document.getElementById('SCactionX');
        if (scactionX) {
            if (typeof scactionX.SendGPSRequest != "undefined") {
                if (SelectUsers[0].issitype == "TETRA" || SelectUsers[0].issitype == "PDT") {
                    try {
                        var reVal = scactionX.SendGPSRequest(issi);
                        if (reVal == "1") {
                            window.parent.parent.LocateAtOnce(issi, "Lang_InstructionSucess");
                            alert(Lang_InstructionSucess);
                        } else {
                            if (reVal == "0") {
                                window.parent.parent.LocateAtOnce(issi, "Lang_LocationFailed");
                                alert(Lang_LocationFailed);
                            }
                            else {
                                window.parent.parent.LocateAtOnce(issi, "Lang_LocationFailed");
                                alert(Lang_LocationFailed);
                            }
                        }
                    }
                    catch (ex) {
                        alert(ex.message);
                    }
                } else if (SelectUsers[0].issitype == "BEIDOU") {
                    try {
                        var reVal = scactionX.SendImmediateLocationReportRequestForMultiType(3, issi, "0", "");
                        if (reVal == "1") {
                            window.parent.parent.LocateAtOnce(issi, "Lang_InstructionSucess");
                            alert(Lang_InstructionSucess);
                        } else {
                            if (reVal == "0") {
                                window.parent.parent.LocateAtOnce(issi, "Lang_LocationFailed");
                                alert(Lang_LocationFailed);
                            }
                            else {
                                window.parent.parent.LocateAtOnce(issi, "Lang_LocationFailed");
                                alert(Lang_LocationFailed);
                            }
                        }
                    } catch (ex) {
                        alert(ex.message);
                    }
                } else if (SelectUsers[0].issitype == "LTE")
                {
                    window.parent.parent.LocateAtOnce(issi, "Lang_LocationFailed");
                    alert(LTE_NotAccept_toLocationGPS);
                }
            }
            else {
                window.parent.parent.LocateAtOnce(issi, "Lang_oxcunsuporrtlocation");
                alert(Lang_oxcunsuporrtlocation);
            }
        }
        else {
            window.parent.parent.LocateAtOnce(issi, "checkcallcontrolregister");
            alert(checkcallcontrolregister);
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

        var image1 = window.document.getElementById("add_okPNG");
        var srouce1 = window.parent.parent.GetTextByName("Lang_edit_entity", window.parent.parent.useprameters.languagedata);
        image1.setAttribute("src", srouce1);






        var Lang_No_localtion_information = window.parent.parent.GetTextByName("Lang_No_localtion_information", window.parent.parent.useprameters.languagedata);
        var Lang_Illegal_ISSI = window.parent.parent.GetTextByName("Lang_Illegal_ISSI", window.parent.parent.useprameters.languagedata);
        $("#txtISSIText").change(function () {

            SelectUsers.length = 0;
            $.ajax({
                type: "POST",
                url: "../../Handlers/GetUserLoLaInfoByISSI.ashx",
                data: "issi=" + $("#txtISSIText").val(),
                success: function (msg) {

                    var my = eval(msg);

                    if (my.length > 0 && $("#txtISSIText").val() != undefined && $("#txtISSIText").val() != "") {

                        myID = my[0].Identification;
                        $("#txtUserName").val(my[0].Lang_name);
                        $("#txtUserEntity").val(my[0].Unit);
                        $("#txtPoliceNo").val(my[0].Number);
                        myLo = my[0].Lang_Longitude;
                        myLa = my[0].Lang_Latitude;
                        if (my[0].Lang_name != undefined) {
                            SelectUsers.push({ uname: my[0].Lang_name, uissi: $("#txtISSIText").val().trim(), utype: my[0].Unit, issitype: my[0].issitype });
                        }
                    } else {
                        $("#txtUserName").val("");
                        $("#txtUserEntity").val("");
                        $("#txtPoliceNo").val("");
                        //alert(Lang_No_localtion_information);//("无定位信息");
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
</script>
