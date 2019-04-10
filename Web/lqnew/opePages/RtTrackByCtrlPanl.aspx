<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RtTrackByCtrlPanl.aspx.cs"
    Inherits="Web.lqnew.opePages.RtTrackByCtrlPanl" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns:v>
<head runat="server">
    <?import namespace="v" implementation="#default#VML" ?>
    <style>
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
    <link href="../css/lq_addedit.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/pagestyle.css" rel="stylesheet" type="text/css" />
    <script src="../../JQuery/jquery-1.5.2.js" type="text/javascript"></script>
    <script src="../iColorPicker.js" type="text/javascript"></script>
    <link href="../css/btn.css" rel="stylesheet" type="text/css" />
    <script src="../../JS/LangueSwitch.js"></script>
    <title></title>
    <style type="text/css">
        body
        {
            color: White;
            font-size: 12px;
        }
    </style>
    <script src="../js/geturl.js"  type="text/javascript"></script>
    <script src="../js/dragwindow.js"  type="text/javascript"></script>
    <script type="text/javascript">
        var SelectUsers = new Array();
        function OnAddMember() {
            window.parent.mycallfunction('AddMemberTree/add_Member', 650, 514, '0&ifr=RtTrackByCtrlPanl_ifr&selectcount=1&type=user', 2001);
            //window.parent.mycallfunction('AddPrivateCallMember/add_Member', 635, 514, '0&ifr=RtTrackByCtrlPanl_ifr&issi=' + $("#txtISSIText").val(), 2001);
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
                    isShow = my[0].isdisplay;
                }
            });
        }
        $(document).ready(function () {
            window.parent.visiablebg2();
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
                                <td id="Lang_select_trace_style" width="1101" background="../images/tab_05.gif">
                                    <%--选择轨迹线样式--%>
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
                            <td width="15" background="../images/tab_12.gif">
                                &nbsp;
                            </td>
                            <td>
                                <table class="style1" cellspacing="1" id="dragtd">
                                    <tr>
                                        <td  width="100px" align="right">
                                           <%-- 终端号码：--%> <span id="Lang_terminal_identification"></span><span>&nbsp;&nbsp</span>
                                        </td>
                                        <td align="left">
                                            <input type="text" id="txtISSIText" runat="server" />&nbsp;<img height="16px" src="<%--../images/chooseMember0.png--%>"
                                               STYLE="display:none" id="imgSelectUser1" onclick="OnAddMember()" onmouseover="<%--javascript:this.src='../images/chooseMember_un.png';--%>"
                                                onmouseout="<%--javascript:this.src='../images/chooseMember0.png';--%>" />
                                            <asp:Button ID="btnnew" runat="server" STYLE="display:none" Text="" Visible="FALSE" CssClass="CALLBUTTON2"
                                                Enabled="true" /><%--新增--%>
                                        </td>
                                          <td  align="left">
                                        <img height="20px" src="<%--../images/chooseMember0.png--%>"
                                                id="imgSelectUser" onclick="OnAddMember()" onmouseover="<%--javascript:this.src='../images/chooseMember_un.png';--%>"
                                                onmouseout="<%--javascript:this.src='../images/chooseMember0.png';--%>" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td  align="right">
                                           <%-- 姓名：--%><span id="Lang_name"></span><span>&nbsp;&nbsp</span>
                                        </td>
                                        <td colspan="2">
                                            <input type="text" disabled="disabled" readonly="readonly" style="width: 240px" id="txtUserName"
                                                runat="server" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td  align="right">
                                           <%-- 单位：--%><span id="Lang_Unit"></span><span>&nbsp;&nbsp</span>
                                        </td>
                                        <td colspan="2">
                                            <input type="text" disabled="disabled" readonly="readonly" style="width: 240px" id="txtUserEntity"
                                                runat="server" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td  align="right" valign="middle" height="25px" width="40px">
                                           <%-- 颜色：--%><span id="Lang_color"></span><span>&nbsp;&nbsp</span>
                                        </td>
                                        <td align="left" valign="middle" colspan="2">
                                            <div style="display:none">
                                            <input class="iColorPicker" id="color1" onpropertychange="rewritevml();" style="background-color: #000000;
                                                margin-top: 5px; width: 85px;" type="text" value="#000" />
                                                </div>
                                              <select id="selColor" onchange="rewritevml()"></select>
                                        </td>
                                       
                                    </tr>
                                    <tr><%-- cxy-20180711 --%>
                                        <td align="right" height="25px" valign="middle">
                                           <span id="Lang_width"><%--宽度：--%></span><span>&nbsp;&nbsp</span>
                                        </td>
                                        <td align="left" valign="middle" colspan="2" style="text-align: left; vertical-align: middle; height: 30px;">
                                                <input type="range" value="1" style="height: 5px;width:250px;" onchange="rewritevml();" max="5" min="1" id="TextBox1" />
                                          </td>
                                       
                                    </tr>
                                    <tr style="display:none">
                                        <td  align="right" height="25px" valign="middle">
                                            <%--样式：--%><span id="Lang_style_2"></span><span>&nbsp;&nbsp</span>
                                        </td>
                                        <td align="left" valign="middle" colspan="2">                                     
                                           <select id="Select3" name="D1" onchange="rewritevml()">
                                                <option value="solid" id="Lang_solid"><%--实线--%></option>
                                                <option value="dot" id="Lang_dot"><%--点线--%></option>
                                                <option value="dash" id="Lang_dash"><%--虚线--%></option>
                                                <option value="dashdot" id="Lang_dashdot"><%--点虚线--%></option>
                                                <option value="longdash" id="Lang_longdash"><%--长虚线--%></option>
                                                <option value="longdashdot" id="Lang_longdashdot"><%--虚点线--%></option>
                                                <option value="longdashdotdot" id="Lang_longdashdotdot"><%--双点线--%></option>
                                            </select>&nbsp;<div id="Lang_trace_point" style="display:none"><%--轨迹点：--%><select id="Select2" name="D2">
                                                <option value="100">100</option>
                                                <option value="500">500</option>
                                                <option value="0" id="Lang_Unlimited"><%--不限--%></option>
                                            </select></div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td  align="right" height="25px" valign="middle">
                                           <%--效果：--%><span id="Lang_Effect"></span><span>&nbsp;&nbsp</span>
                                        </td>
                                        <td align="left" valign="middle" colspan="2"><%-- cxy-20180711 去掉vml标签 --%>
                                            <%--<v:polyline id="polyline1" filled="false" strokecolor="black" points="0,0 200,0"
                                                z-index="999" style="position: absolute; display: inline-block">
         <v:stroke id="stroke1" StartArrow="Oval"  Weight="1" EndArrow="Classic" dashstyle="solid" />
         </v:polyline>--%>
                                            <canvas id="polyline1" style="height: 25px; width: 200px;"></canvas><%-- cxy-20180711 --%>
                                        </td>
                                       
                                    </tr>
                                     <tr>
                                       
                                        <td align="center" valign="middle" colspan="3">
                                        <img id="add_okPNG" style="margin: 0px 0px 0px 3px; cursor: hand;" src="<%--../images/add_ok.png--%>" onclick="selectcolor()" />
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
    </form>
</body>
<script language="javascript">

    LanguageSwitch(window.parent);
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

    var image = window.document.getElementById("imgSelectUser");
    var srouce = window.parent.parent.GetTextByName("Lang_chooseMemberPNG", window.parent.parent.useprameters.languagedata);
    image.setAttribute("src", srouce);
    var strpath = window.parent.parent.GetTextByName("Lang_chooseMemberPNG", window.parent.parent.useprameters.languagedata);
    var strpathmove = window.parent.parent.GetTextByName("Lang_chooseMemberPNG_un", window.parent.parent.useprameters.languagedata);
    image.onmouseover = function () { this.src = strpathmove }
    image.onmouseout = function () { this.src = strpath }
   

    var image1 = window.document.getElementById("add_okPNG");
    var srouce1 = window.parent.parent.GetTextByName("Lang_edit_entity", window.parent.parent.useprameters.languagedata);
    image1.setAttribute("src", srouce1);

    var myID = "";
    var isShow = "False";
    var Lang_Real_time_trajectory_has_been_opened = window.parent.parent.GetTextByName("Lang_Real_time_trajectory_has_been_opened", window.parent.parent.useprameters.languagedata);
    var Lang_please_select_user = window.parent.parent.GetTextByName("Lang_please_select_user", window.parent.parent.useprameters.languagedata);
    var Lang_Illegal_ISSI_or_fail_to_mobile_user_bind = window.parent.parent.GetTextByName("Lang_Illegal_ISSI_or_fail_to_mobile_user_bind", window.parent.parent.useprameters.languagedata);
    var Lang_Mobile_subscriber_in_a_hidden_state = window.parent.parent.GetTextByName("Lang_Mobile_subscriber_in_a_hidden_state", window.parent.parent.useprameters.languagedata);

    function selectcolor() {
        var colorbox = document.getElementById("color1");
        var color = colorbox.value;
        color = "#" + window.parent.colorCodeToFlashColor(window.document.getElementById("selColor").value);
        var id = myID;
        var ISSI = $("#txtISSIText").val();
        var lineweight = $("#TextBox1").val();
        var linestyle = $("#Select1").val();
        var lineint = $("#Select2").val();
        var sendtime = new Date().toString();
        if (window.parent.istracein(id)) {
            alert(Lang_Real_time_trajectory_has_been_opened);//('实时轨迹已开启');
            return;
        }
        if (id == "") {
            alert(Lang_please_select_user);//("请选择用户");
            return;
        }
        if ($("#txtUserName").val() == "") {
            alert(Lang_Illegal_ISSI_or_fail_to_mobile_user_bind);//("非法ISSI或未于移动用户绑定");
            return;
        }
        if (isShow == "False") {
            alert(Lang_Mobile_subscriber_in_a_hidden_state);//("移动用户处于隐藏状态");
            return;
        }

        window.parent.removeIdTorealtimeTraceUserIds(id,true);

        window.parent.hiddenbg2();
        window.parent.selectcolortrace2(id, color, lineweight, linestyle, lineint, ISSI);
        window.parent.AddPeruserRealtimeTrace_line(id);
        
        //关闭颜色选择页面
        window.parent.mycallfunction('RtTrackByCtrlPanl', 350, 380);
        //window.parent.CloseAllFrameWindow();
    }
    var Lang_Illegal_ISSI = window.parent.parent.GetTextByName("Lang_Illegal_ISSI", window.parent.parent.useprameters.languagedata);
    function getQueryStringRegExp(id) {
        var reg = new RegExp("(^|\\?|&)" + id + "=([^&]*)(\\s|&|$)", "i");
        if (reg.test(location.href)) return unescape(RegExp.$2.replace(/\+/g, " ")); return "";
    };
    window.onload = function () {
        $("#TextBox1").bind('');
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
                    myID = my[0].id;
                    $("#txtUserName").val(my[0].nam);
                    $("#txtUserEntity").val(my[0].entity);
                    $("#txtPoliceNo").val(my[0].num);
                    isShow = my[0].isdisplay;

                    SelectUsers.length = 0;
                    if (my[0].nam != undefined) {
                        SelectUsers.push({ uname: my[0].nam, uissi: $("#txtISSIText").val().trim(), utype: my[0].type });
                    }
                }
            });

        });
    }
    function rewritevml() {<%-- cxy-20180711 去掉VML标签  添加canvas显示 --%>
        //var stroke1 = document.getElementById("stroke1");
        //var polyline1 = document.getElementById("polyline1");
        //var colorbox = document.getElementById("color1");
        //var color = colorbox.value;
        //var lineweight = $("#TextBox1").val();
        //var linestyle = $("#Select1").val();
        //color = window.parent.colorCodeToHtmlColor(window.document.getElementById("selColor").value);
        //stroke1.Weight = lineweight;
        //stroke1.dashstyle = linestyle;
        //polyline1.strokecolor = color;

        var colorbox = document.getElementById("color1");
        var color = colorbox.value;
        color = window.parent.colorCodeToHtmlColor(window.document.getElementById("selColor").value);
        var lineweight = $("#TextBox1").val();
        var linestyle = $("#Select1").val();

        var mycanvas = document.getElementById('polyline1');
        mycanvas.width = "200";
        mycanvas.height = "25";
        var ctx = mycanvas.getContext("2d");
        ctx.lineWidth = lineweight;
        ctx.beginPath();
        ctx.strokeStyle = color;
        ctx.moveTo(2, mycanvas.height / 2);
        ctx.lineTo(180, mycanvas.height / 2);
        ctx.closePath();
        ctx.stroke();

        var canvasHeight = mycanvas.height;
        lineweight = lineweight * 3;
        ctx.fillStyle = color;
        ctx.beginPath();
        ctx.moveTo(180, canvasHeight / 2 - lineweight / 2);
        ctx.lineTo(180, canvasHeight / 2 + lineweight / 2);
        var jiantouX = 180 + (lineweight / 2) / Math.tan(Math.PI / 6);
        ctx.lineTo(jiantouX, canvasHeight / 2);
        ctx.closePath();
        ctx.fill();

    }
    window.parent.loadColorOption(window.document.getElementById("selColor"));
</script>
