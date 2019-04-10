<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LockkByCtrlPanl.aspx.cs"
    Inherits="Web.lqnew.opePages.LockkByCtrlPanl" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns:v>
<head runat="server">
    <link href="../css/btn.css" rel="stylesheet" type="text/css" />
       <link href="../css/lq_addedit.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/pagestyle.css" rel="stylesheet" type="text/css" />
    <?import namespace="v" implementation="#default#VML" ?>
    <style type="text/css">
        v\:*
        {
            behavior: url(#default#VML);
            position: absolute;
        }
        o\:*
        {
            behavior: url(#default#VML);
        }
    </style>
    <script src="../../JQuery/jquery-1.5.2.js" type="text/javascript"></script>
    <script src="../../JS/LangueSwitch.js" type="text/javascript"></script>
    <title></title>
    <style type="text/css">
        body
        {
            color: White;
            font-size: 12px;
        }
    </style>
    <script src="../js/geturl.js" type="text/javascript"></script>
    <script src="../js/dragwindow.js" type="text/javascript"></script>
    <script type="text/javascript">
        var SelectUsers = new Array();
        function OnAddMember() {
            window.parent.mycallfunction('AddMemberTree/add_Member', 650, 514, '0&ifr=LockkByCtrlPanl_ifr&selectcount=1&type=user', 2001);
            //window.parent.mycallfunction('AddPrivateCallMember/add_Member', 635, 514, '0&ifr=LockkByCtrlPanl_ifr&issi=' + $("#txtISSIText").val(), 2001);
        }
        function faterdo(retrunissis) {
            var Lang_have_been_Locked = window.parent.parent.GetTextByName("Lang_have_been_Locked", window.parent.parent.useprameters.languagedata);            
            var Lang_have_beennot_Locked = window.parent.parent.GetTextByName("Lang_have_beennot_Locked", window.parent.parent.useprameters.languagedata);
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
                    if (my[0].nam == "" || my[0].nam == undefined) {
                        return;
                    }
                    if (window.parent.useprameters.lockid == myID) {
                        $("#txtStutas").val(Lang_have_been_Locked);//('已被锁定');
                        document.getElementById("lockorunlock").value = window.parent.GetTextByName("Lang_unlocked", window.parent.useprameters.languagedata);
                    } else {
                        $("#txtStutas").val(Lang_have_beennot_Locked);//('未被锁定');
                        document.getElementById("lockorunlock").value = window.parent.GetTextByName("Lang_Lock", window.parent.useprameters.languagedata);
                    }
                    lo = my[0].lo;
                    la = my[0].la;
                }
            });
        }
        function unlockbyidfromrightmenu(id) {
            var Lang_have_been_Locked = window.parent.parent.GetTextByName("Lang_have_been_Locked", window.parent.parent.useprameters.languagedata);
            var Lang_have_beennot_Locked = window.parent.parent.GetTextByName("Lang_have_beennot_Locked", window.parent.parent.useprameters.languagedata);
                        
            $.ajax({
                type: "POST",
                url: "../../Handlers/GetUserInfoByID_Handler.ashx",
                data: "id=" + id,
                success: function (msg) {
                    var my = eval(msg);
                    myID = my[0].id;
                    $("#txtISSIText").val(my[0].issi);
                    $("#txtUserName").val(my[0].nam);
                    $("#txtUserEntity").val(my[0].entity);
                    $("#txtPoliceNo").val(my[0].num);
                    if (my[0].nam == "" || my[0].nam == undefined) {
                        return;
                    }
                    if (window.parent.useprameters.lockid == myID) {
                        $("#txtStutas").val(Lang_have_been_Locked);//('已被锁定');
                        document.getElementById("lockorunlock").value = window.parent.GetTextByName("Lang_unlocked", window.parent.useprameters.languagedata);
                    } else {
                        $("#txtStutas").val(Lang_have_beennot_Locked);//('未被锁定');
                        document.getElementById("lockorunlock").value = window.parent.GetTextByName("Lang_Lock", window.parent.useprameters.languagedata);
                    }
                    lo = my[0].lo;
                    la = my[0].la;
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
                                    <img alt="" src="../images/tab_03.png" width="15" height="32" />
                                </td>
                                <td id="Lang_Lock" width="1101" background="../images/tab_05.gif">
                                    <%--锁定--%>
                                </td>
                                <td width="281" background="../images/tab_05.gif" align="right">
                                    <img alt="" class="style6" style="cursor: pointer;" onclick="javascript:window.parent.hiddenbg2();window.parent.mycallfunction(geturl(),693, 354)"
                                        onmouseover="javascript:this.src='../images/close_un.png';" onmouseout="javascript:this.src='../images/close.png';"
                                        src="../images/close.png" />
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
                                        <td  class="style3" align="right" style="width: 60px;">
                                        <%-- 终端号码:--%><span id="Lang_terminal_identification"></span><span>&nbsp;&nbsp</span>
                            </td>
                            <td colspan="1" align="left">
                                <input  type="text" id="txtISSIText" runat="server" />
                                <asp:Button style="display:none" ID="btnnew" runat="server" Text="" Visible="false" CssClass="CALLBUTTON2" Enabled="false" /><%--新增--%>
                            </td>
                            <td align="left">
<img  height="20px" alt="" src="<%--../images/chooseMember0.png--%>" id="imgSelectUser" onclick="OnAddMember()" onmouseover="<%--javascript:this.src='../images/chooseMember_un.png';--%>"
                                                onmouseout="<%--javascript:this.src='../images/chooseMember0.png';--%>" />
                            </td>
                            </tr>
                            <tr>
                           
                             <td  align="right">
                               <%-- 姓名:--%><span id="Lang_name"></span><span>&nbsp;&nbsp</span>
                            </td>
                            <td colspan="2" align="left">
                                <input type="text" disabled="disabled" readonly="readonly" style="width: 240px" id="txtUserName" runat="server" />
                            </td>
                            
                        </tr>
                        <tr>
                           
                            <td  align="right">
                                <%--单位:--%><span id="Lang_Unit"></span><span>&nbsp;&nbsp</span>
                            </td>
                            <td colspan="2" align="left">
                                <input type="text" disabled="disabled" readonly="readonly" style="width: 240px" id="txtUserEntity" runat="server" />
                            </td>
                          
                        </tr>
                        <tr>
                         
                            <td  align="right">
                                <%--状态:--%><span id="Lang_Status"></span><span>&nbsp;&nbsp</span>
                            </td>
                            <td colspan="2" align="left">
                                <input type="text" disabled="disabled" readonly="readonly" style="width: 240px" id="txtStutas" runat="server" />
                            </td>
                          
                        </tr>
                        <tr>
                         
                            <td colspan="3" align="center">
                                <%--<img style="margin: 0px 0px 0px 3px; cursor: pointer;" src="../images/add_ok.png" onclick="selectcolor()" />--%>
                                <input id="lockorunlock" type="button" value="" onclick="selectcolor()"/>
                            </td>
                         
                        </tr>
                            </table>
                            </td>
                      
                            <td width="15" background="../images/tab_16.gif">
                                &nbsp;
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
    </form>
</body>
<script type="text/javascript" language="javascript">
    LanguageSwitch(window.parent);
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
    var image = window.document.getElementById("imgSelectUser");
    var srouce = window.parent.parent.GetTextByName("Lang_chooseMemberPNG", window.parent.parent.useprameters.languagedata);
    image.setAttribute("src", srouce);
    var strpath = window.parent.parent.GetTextByName("Lang_chooseMemberPNG", window.parent.parent.useprameters.languagedata);
    var strpathmove = window.parent.parent.GetTextByName("Lang_chooseMemberPNG_un", window.parent.parent.useprameters.languagedata);
    image.onmouseover = function () { this.src = strpathmove }
    image.onmouseout = function () { this.src = strpath }
    var myID = "";
    var lo = "";
    var la = "";
    var Lang_Illegal_terminal_identification = window.parent.parent.GetTextByName("Lang_Illegal_terminal_identification", window.parent.parent.useprameters.languagedata);
    function selectcolor() {
        var Lang_Illegal_ISSI_or_fail_to_mobile_user_bind = window.parent.parent.GetTextByName("Lang_Illegal_ISSI_or_fail_to_mobile_user_bind", window.parent.parent.useprameters.languagedata);
        
        var Lang_latitude_and_longitude_null_could_not_be_locked = window.parent.parent.GetTextByName("Lang_latitude_and_longitude_null_could_not_be_locked", window.parent.parent.useprameters.languagedata);

        if ($("#txtUserName").val() == "") {
            alert(Lang_Illegal_ISSI_or_fail_to_mobile_user_bind);//("非法ISSI或未于移动用户绑定");
            return;
        }
        
        if (lo == "" || la == "" || lo == "0.0000000" || la == "0.0000000") {
            alert(Lang_latitude_and_longitude_null_could_not_be_locked);//("此用户经纬度为0 或者不存在，不能锁定");
            return;
        }

        //        if (window.parent.isLocked(myID)) {
        //            alert('已锁定');
        //            return;
        //        }
        window.parent.hiddenbg2();
        window.parent.lockuser(myID);
        window.parent.mycallfunction(geturl(), 693, 354);
        //window.parent.CloseAllFrameWindow();
    }
    function getQueryStringRegExp(id) {
        var reg = new RegExp("(^|\\?|&)" + id + "=([^&]*)(\\s|&|$)", "i");
        if (reg.test(location.href)) return unescape(RegExp.$2.replace(/\+/g, " ")); return "";
    };
    window.onload = function () {
        var Lang_have_been_Locked = window.parent.parent.GetTextByName("Lang_have_been_Locked", window.parent.parent.useprameters.languagedata);
        var Lang_have_beennot_Locked = window.parent.parent.GetTextByName("Lang_have_beennot_Locked", window.parent.parent.useprameters.languagedata);
        window.parent.visiablebg2();
        $("#txtISSIText").change(function () {
            if (/[^\d]/.test($("#txtISSIText").val())) {
                alert(Lang_Illegal_terminal_identification);//("非法终端号码");
                return;
            }
            $.ajax({
                type: "POST",
                url: "../../Handlers/GetUserInfo_Handler.ashx",
                data: "issi=" + $("#txtISSIText").val(),
                success: function (msg) {
                    var my = eval(msg);
                    myID = my[0].id;
                    $("#txtUserName").val(my[0].nam);
                    $("#txtUserEntity").val(my[0].entity);
                    $("#txtPoliceNo").val(my[0].num);
                    if (my[0].nam == "" || my[0].nam == undefined) {
                        return;
                    }
                    if (window.parent.useprameters.lockid == myID) {
                        $("#txtStutas").val(Lang_have_been_Locked);//('已被锁定');
                        document.getElementById("lockorunlock").value = window.parent.GetTextByName("Lang_unlocked", window.parent.useprameters.languagedata);
                    } else {
                        $("#txtStutas").val(Lang_have_beennot_Locked);//('未被锁定');
                        document.getElementById("lockorunlock").value = window.parent.GetTextByName("Lang_Lock", window.parent.useprameters.languagedata);
                    }
                    lo = my[0].lo;
                    la = my[0].la;
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
        if (window.parent.useprameters.lockid != 0) {
            unlockbyidfromrightmenu(window.parent.useprameters.lockid);
        }
        else {
            document.getElementById("lockorunlock").value = window.parent.GetTextByName("Lang_Lock", window.parent.useprameters.languagedata);
        }
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
