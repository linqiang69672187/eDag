<%@ Page Language="C#" AutoEventWireup="true"  ValidateRequest="false"  CodeBehind="EnableDisableRadio.aspx.cs"
    Inherits="Web.lqnew.opePages.EnableDisableRadio" %>

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
            visibility: visible;
        }
        .CALLBUTTON1
        {
            visibility: visible;
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

        function CloseWindow() {
            window.parent.hiddenbg2();
            window.parent.mycallfunction('EnableDisableRadio');
        }
        var Lang_Illegal_terminal_identification = window.parent.parent.GetTextByName("Lang_Illegal_terminal_identification", window.parent.parent.useprameters.languagedata);
        var Lang_PleaseInputTerminalOrGroup = window.parent.parent.GetTextByName("Lang_PleaseInputTerminalOrGroup", window.parent.parent.useprameters.languagedata);

        function DISABLERADIO() {
            var intIssi = document.getElementById('txtISSIText').value.trim();

            if (/[^\d]/.test(intIssi)) {
                alert(Lang_Illegal_terminal_identification); //非法终端号码
                return;
            }
            if (intIssi == "") {
                alert(Lang_PleaseInputTerminalOrGroup); //请输入终端号码
                return;
            }
            if (intIssi <= 0 || intIssi > 80699999) {
                alert(Lang_Illegal_terminal_identification);
                return;
            }

            window.parent.parent.disableRadio(intIssi);
        }
        function ENABLERADIO() {
            var intIssi = document.getElementById('txtISSIText').value.trim();
            if (/[^\d]/.test(intIssi)) {
                alert(Lang_Illegal_terminal_identification);//("非法终端号码");
                return;
            }
            if (intIssi == "") {
                alert(Lang_PleaseInputTerminalOrGroup);//("请输入终端号码");
                return;
            }
            if (intIssi <= 0 || intIssi > 80699999) {
                alert(Lang_Illegal_terminal_identification);
                return;
            }
            window.parent.parent.enableRadio(intIssi);
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
            window.parent.mycallfunction('AddMemberTree/add_Member', 650, 514, '0&ifr=EnableDisableRadio_ifr&selectcount=1&type=user', 2001);
            //window.parent.mycallfunction('AddPrivateCallMember/add_Member', 635, 514, '0&ifr=EnableDisableRadio_ifr&issi=' + $("#txtISSIText").val().trim(), 2001);
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
                    $("#txtUserName").val(my[0].nam);
                    $("#txtUserEntity").val(my[0].entity);
                    $("#txtPoliceNo").val(my[0].num);
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
                                            <img alt="" src="../images/037.gif" /><span id="Lang_YAOQIYAOBI"><%--遥启遥毙--%></span></li>
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
                                        <td class="style3" align="right" style="width: 60px;">
                                            <div >
                                                <%--终端号码:--%><span id="divIssiTitle"></span><span>&nbsp;&nbsp</span></div>
                                        </td>
                                        <td class="style3" align="left">
                                          <input type="text" id="txtISSIText" runat="server" />
                                           
                                        </td>
                                          <td align="left" style="width: 120px;">
                                           <form id="Form1" runat="server">
                                         <img alt="" src="<%--../images/chooseMember0.png--%>" id="imgSelectUser" onclick="OnAddMember()" onmouseover="<%--javascript:this.src='../images/chooseMember_un.png';--%>"
                                                onmouseout="<%--javascript:this.src='../images/chooseMember0.png';--%>" />&nbsp;
                                            <asp:Button ID="btnnew" Visible="false" runat="server" Text="新增" CssClass="CALLBUTTON2" Enabled="false" />
                                            </form>
                                          </td>
                                    </tr>
                                    <tr>
                                        <td  class="style3" align="right" style="width: 60px;">
                                            <%--姓名:--%><span id="Lang_name"></span><span>&nbsp;&nbsp</span>
                                        </td>
                                        <td class="style3" align="left" colspan="2">
                                            <input type="text" disabled="disabled" readonly="readonly" style="width: 240px" id="txtUserName" runat="server" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td  class="style3" align="right" style="width: 60px;">
                                           <%-- 单位:--%><span id="Lang_Unit"></span><span>&nbsp;&nbsp</span>
                                        </td>
                                        <td class="style3" align="left" colspan="2">
                                            <input type="text" disabled="disabled" readonly="readonly" style="width: 240px" id="txtUserEntity" runat="server" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td  class="style3" align="right" style="width: 60px;">
                                            <%--编号:--%><span id="Lang_Serialnumber"></span><span>&nbsp;&nbsp</span>
                                        </td>
                                        <td class="style3" align="left" colspan="2">
                                            <input type="text" disabled="disabled" readonly="readonly" style="width: 240px" id="txtPoliceNo" runat="server" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="style3" align="center" colspan="3">
                                            <table>
                                                <tr>
                                                    <td>
                                                        <button class="CALLBUTTON1" id="disableradio" style="text-align: center; cursor: pointer;"
                                                            onclick="DISABLERADIO()">
                                                            <%--遥毙--%></button>
                                                    </td>
                                                    <td>
                                                        <button class="CALLBUTTON1" id="enableradio" style="text-align: center; cursor: pointer;"
                                                            onclick="ENABLERADIO()">
                                                            <%--遥启--%></button>
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
    var srouce = "../" + window.parent.parent.GetTextByName("Lang_chooseMemberPNG", window.parent.parent.useprameters.languagedata);
    image.setAttribute("src", srouce);
    //var Lang_AddNew_un = window.parent.parent.GetTextByName("Lang_AddNew_un", window.parent.parent.useprameters.languagedata);
    var strpath = "../" + window.parent.parent.GetTextByName("Lang_chooseMemberPNG", window.parent.parent.useprameters.languagedata);
    var strpathmove = "../" + window.parent.parent.GetTextByName("Lang_chooseMemberPNG_un", window.parent.parent.useprameters.languagedata);
    image.onmousemove = function () { this.src = strpathmove }//"javascript:this.src='../../images/btn_add_un.png'";// onmouse_move();
    image.onmouseout = function () { this.src = strpath }//"javascript:this.src='../../images/btn_add.png'";//  onmouse_out();

    window.document.getElementById("divIssiTitle").innerHTML = window.parent.parent.GetTextByName("Lang_terminal_identification", window.parent.parent.useprameters.languagedata);
    window.document.getElementById("enableradio").innerHTML = window.parent.parent.GetTextByName("YaoQi", window.parent.parent.useprameters.languagedata);

    window.document.getElementById("disableradio").innerHTML = window.parent.parent.GetTextByName("YaoBi", window.parent.parent.useprameters.languagedata);


</script>

<link href="../../CSS/lq_calloutExtender.css" rel="stylesheet" type="text/css" />
