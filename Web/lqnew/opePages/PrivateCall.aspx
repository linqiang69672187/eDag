<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PrivateCall.aspx.cs" Inherits="Web.lqnew.opePages.PrivateCall" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link href="../css/lq_addedit.css" rel="stylesheet" type="text/css" /><link href="../../CSS/pagestyle.css" rel="stylesheet" type="text/css" />
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
            visibility: hidden;
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
        .CALLBUTTON2
        {
            visibility: visible;
            border-right: #bdbcbc 1px solid;
            padding-right: 2px;
            border-top: #bdbcbc 1px solid;
            padding-left: 2px;
            font-size: 12px;
            filter: progid:DXImageTransform.Microsoft.Gradient(GradientType=0, StartColorStr=#ffffff, EndColorStr=#bdbcbc);
            border-left: #bdbcbc 1px solid;
            cursor: pointer;
            color: black;
            padding-top: 2px;
            border-bottom: #bdbcbc 1px solid;
            width: 60px;
            height: 25px;
        }
    </style>
    <script type="text/javascript">

        


        var flag = false;
        var selecti = 0;
        var Lang_start_call_failure = window.parent.parent.GetTextByName("Lang_start_call_failure", window.parent.parent.useprameters.languagedata);
        var Lang_Illegal_terminal_identification = window.parent.parent.GetTextByName("Lang_Illegal_terminal_identification", window.parent.parent.useprameters.languagedata);//非法终端号码
        var HAS_CALL_REQUEST_IN = window.parent.parent.GetTextByName("HAS_CALL_REQUEST_IN", window.parent.parent.useprameters.languagedata);
        var CC_END = window.parent.parent.GetTextByName("CC_END", window.parent.parent.useprameters.languagedata);
        var Lang_THE_OTHER_HANGUP = window.parent.parent.GetTextByName("Lang_THE_OTHER_HANGUP", window.parent.parent.useprameters.languagedata);// "对方挂断";
        var CC_RELEASE = window.parent.parent.GetTextByName("CC_RELEASE", window.parent.parent.useprameters.languagedata);// "对方挂断";

        function setFlagFalse() {
            flag = false;
        }

        //alert(Lang_start_call_failure);
        function CloseWindow() {
            var a = $("#divstatue").html();

            var Lang_release_authorization_failed = window.parent.parent.GetTextByName("Lang_release_authorization_failed", window.parent.parent.useprameters.languagedata);

            var Lang_This_call_is_not_end = window.parent.parent.GetTextByName("Lang_This_call_is_not_end", window.parent.parent.useprameters.languagedata);
            //alert(Lang_This_call_is_not_end);
            if (a.indexOf(CC_RELEASE) > 0 || a == CC_END || a == Lang_release_authorization_failed || a == Lang_start_call_failure || a.indexOf(HAS_CALL_REQUEST_IN) > 0) {
                flag = false;
            }
            window.parent.callPanalISSI = "";
            if (flag) {
                alert(Lang_This_call_is_not_end);
                return;
            }
            window.parent.hiddenbg2();
            window.parent.mycallfunction('PrivateCall');
        }

        function keyPress() {
            if (event.keyCode == 32) {
                PTTSCALL();
            }
        }
        function keyUp() {
            if (event.keyCode == 32) {
                CEASEDSCALL();
            }
        }

        function STARTCALL() {
            
            var intISSI = document.getElementById('txtISSIText').value.trim();

            if (/[^\d]/.test(intISSI)) {

                alert(Lang_Illegal_terminal_identification);
                return;
            }
            if (intISSI <= 0 || intISSI > 80699999) {
                alert(Lang_Illegal_terminal_identification);
                return;
            }
            var Lang_PleaseInputTerminalOrGroup = window.parent.parent.GetTextByName("Lang_PleaseInputTerminalOrGroup", window.parent.parent.useprameters.languagedata);
            if (intISSI == "") {
                alert(Lang_PleaseInputTerminalOrGroup);
                return;
            }
            var Called = window.parent.parent.GetTextByName("Called", window.parent.parent.useprameters.languagedata);
            var Toanswer = window.parent.parent.GetTextByName("Toanswer", window.parent.parent.useprameters.languagedata);
            if (document.getElementById('begincall').innerHTML == Called || document.getElementById('begincall').innerHTML == Toanswer) {
                document.getElementById('begincall').innerHTML = Called;
                var isEncryption = "0"//xzj--20190320--添加呼叫加密参数
                if (document.getElementById("isEncryption").checked) {
                    isEncryption = "1";
                }
                var iscall = window.parent.parent.startDC2(intISSI,isEncryption);
                if (iscall == 0) {
                    $("#divstatue").html(Lang_start_call_failure);
                    flag = false;
                    return;
                }
                flag = true;
                document.getElementById('endcall').style.display = "block";
                document.getElementById('begincall').style.display = "none";
                document.getElementById("txtISSIText").disabled = true;
                document.getElementById("imgSelectISSI").style.display = "none";
                document.getElementById("isEncryption").disabled = true;//xzj--20190320--添加呼叫加密参数
            }
           
        }
        var pptcount = 0;
        function PTTSCALL() {
            var intISSI = document.getElementById('txtISSIText').value.trim();

            document.getElementById('endcall').style.display = "block";
            if (/[^\d]/.test(intISSI)) {
                alert(Lang_Illegal_terminal_identification);
                return;
            }
            if (intISSI <= 0 || intISSI > 80699999) {
                alert(Lang_Illegal_terminal_identification);
                return;
            }
            if (intISSI == "") {
                return;
            }
            //if (pptcount == 0) {
            $.ajax({
                type: "POST",
                url: "../../Handlers/GetUserInfo_Handler.ashx",
                data: "type=pc&issi=" + $("#txtISSIText").val().trim(),
                success: function (msg) {
                    var my = eval(msg);
                    $("#txtUserName").val(my[0].nam);
                    $("#txtUserEntity").val(my[0].entity);
                    $("#txtPoliceNo").val(my[0].num);
                }
            });
            // }
            if (document.getElementById('begincall').innerHTML == "PTT") {
                var isEncryption = "0"//xzj--20190320--添加呼叫加密参数
                if (document.getElementById("isEncryption").checked) {
                    isEncryption = "1";
                }
                var iscall = window.parent.parent.startSC2(intISSI, isEncryption);
                if (iscall == 0) {
                    // $("#divstatue").html("开始呼叫或获取授权失败");
                    flag = false;
                    return;
                }
                document.getElementById('endcall').style.display = "block";
                document.getElementById("txtISSIText").disabled = true;
                document.getElementById("imgSelectISSI").style.display = "none";
                document.getElementById("isEncryption").disabled = true;//xzj--20190320--添加呼叫加密参数
            }
            flag = true;
            pptcount++;
        }
        function CEASEDSCALL() {
            if (document.getElementById('txtISSIText').value.trim() == "") {
                return;
            }

            if (document.getElementById('begincall').innerHTML == "PTT") {
                var iscall = window.parent.parent.sceasedPTT2(document.getElementById('txtISSIText').value.trim());
                if (iscall == 0) {
                    //$("#divstatue").html("释放授权失败");
                    flag = false;
                    document.getElementById('begincall').style.display = "block";
                    return;
                } else {
                    flag = true;
                }
            }

        }
        var Lang_call_end_failure = window.parent.parent.GetTextByName("Lang_call_end_failure", window.parent.parent.useprameters.languagedata);
        function ENDCALL() {
            var a = $("#divstatue").html();
            var b = HAS_CALL_REQUEST_IN;
            if (a.indexOf(b) > 0) {
                flag = true;
            }
            // if (!flag) {
            //    alert("未发起呼叫");
            //    return;
            //}
            if (document.getElementById('begincall').innerHTML == "PTT") {
                var iscall = window.parent.parent.endSC2(document.getElementById('txtISSIText').value.trim());
                if (iscall == 0) {
                    $("#divstatue").html(Lang_call_end_failure);
                    // return;
                }
            }
            else {
                var iscall = window.parent.parent.endDC2(document.getElementById('txtISSIText').value.trim());
                if (iscall == 0) {
                    $("#divstatue").html(Lang_call_end_failure);
                    //  return;
                }
            }
            flag = false;
            pptcount = 0;
            document.getElementById('endcall').style.display = "none";
            document.getElementById('begincall').style.display = "block";
            document.getElementById('divstatue').innerHTML = CC_END;
            document.getElementById("txtISSIText").disabled = false;
            document.getElementById("imgSelectISSI").style.display = "block";
            document.getElementById("isEncryption").disabled = false;//xzj--20190320--添加呼叫加密参数
        }
        var Lang_CALL_IN_HANDLE = window.parent.parent.GetTextByName("Lang_CALL_IN_HANDLE", window.parent.parent.useprameters.languagedata);
        var Lang_cannot_chose_calltype = window.parent.parent.GetTextByName("Lang_cannot_chose_calltype", window.parent.parent.useprameters.languagedata);
        function CheckMe() {//替换显示内容
            var a = $("#divstatue").html();
            var b = CC_RELEASE;//Lang_THE_OTHER_HANGUP; //"对方挂断";
            //var c = Lang_CALL_IN_HANDLE;   //"呼叫正在处理中";
            var c = window.parent.parent.GetTextByName("CC_CALLPROCEEDING", window.parent.parent.useprameters.languagedata);
            if (a.indexOf(b) > 0 || a == CC_END) {
                flag = false;
            };
            if (a.indexOf(c) > 0) {
                flag = true;
            }
            if (flag) {
                document.getElementById('calltype').selectedIndex = selecti;
                alert(Lang_cannot_chose_calltype);
                return;
            };
            selecti = document.getElementById('calltype').selectedIndex;
            if (document.getElementById('calltype').selectedIndex == "0") {
                document.getElementById('begincall').style.display = "none";
                document.getElementById('endcall').style.display = "none";
            }
            if (document.getElementById('calltype').selectedIndex == "2") {
                document.getElementById('begincall').innerHTML = "PTT";
                document.getElementById('begincall').style.display = "block";
                document.getElementById('endcall').style.display = "none";
            }
            else if (document.getElementById('calltype').selectedIndex == "1") {
                document.getElementById('begincall').innerHTML = window.parent.parent.GetTextByName("Called", window.parent.parent.useprameters.languagedata);//"呼叫";
                document.getElementById('begincall').style.display = "block";
                document.getElementById('endcall').style.display = "none";
            }
            document.getElementById('begincall').className = "CALLBUTTON1";
            document.getElementById('endcall').className = "CALLBUTTON1";
        }

        function tochanage() {
            $.ajax({
                type: "POST",
                url: "../../Handlers/GetUserInfo_Handler.ashx",
                data: "type=pc&issi=" + $("#txtISSIText").val().trim(),
                success: function (msg) {

                    var my = eval(msg);
                    $("#txtUserName").val(my[0].nam);
                    $("#txtUserEntity").val(my[0].entity);
                    $("#txtPoliceNo").val(my[0].num);
                    SelectUsers.length = 0;
                    if (my[0].nam != "") {
                       
                        SelectUsers.push({ uname: my[0].nam, uissi: $("#txtISSIText").val().trim(), utype: my[0].type }); 
                    }
                }
            });
        }
        $(document).ready(function () {
            window.parent.visiablebg2();
            $("#txtISSIText").change(function () {
                if ($("#txtISSIText").val().trim() == "") {
                    $("#txtUserName").val("");
                    $("#txtUserEntity").val("");
                    $("#txtPoliceNo").val("");
                    return;
                }
                tochanage();

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
            $("#drdiv").mousedown(function () {
                dragdiv();
            });
            $("#drdiv").mousemove(function () {
                mydragWindow();
            });
            $("#drdiv").mouseup(function () {
                mystopDragWindow();
            });
            document.body.oncontextmenu = function () { return false; };
            //xzj--20190320--设置加密呼叫默认值
            var callEncryption = window.parent.parent.useprameters.CallEncryption;
            if (callEncryption.indexOf("Single") >= 0) {
                $("#isEncryption").attr("checked", true);
            }
            else {
                $("#isEncryption").attr("checked", false);
            }
        });

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
        var SelectUsers = new Array();
        function OnAddMember() {
            //window.parent.mycallfunction('AddPrivateCallMember/add_Member', 635, 514, '0&ifr=PrivateCall_ifr&issi=' + $("#txtISSIText").val().trim(), 2001);
            window.parent.mycallfunction('AddMemberTree/add_Member', 650, 514, '0&ifr=PrivateCall_ifr&selectcount=1&type=userdispatch', 2001);
        }
        function faterdo(retrunissis) {
           
            if (retrunissis.length > 0) {
                SelectUsers.length = 0;
                SelectUsers.push({ uname: retrunissis[0].uname, uissi: retrunissis[0].uissi, utype: retrunissis[0].utype });
            } else {
                return;
            }
            $.ajax({
                type: "POST",
                url: "../../Handlers/GetUserInfo_Handler.ashx",
                data: "type=pc&issi=" + retrunissis[0].uissi,
                success: function (msg) {
                    var my = eval(msg);
                    $("#txtISSIText").val(retrunissis[0].uissi);
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
                                    <img src="../images/tab_03.png" width="15" height="32" />
                                </td>
                                <td width="1101" background="../images/tab_05.gif">
                                    <ul class="hor_ul">
                                        <li >
                                            <img src="../images/037.gif" /><span id="Lang_SingleCall"></span></li>
                                    </ul>
                                </td>
                                <td width="281" background="../images/tab_05.gif" align="right">
                                    <img class="style6" style="cursor: pointer;" onclick="CloseWindow()" onmouseover="javascript:this.src='../images/close_un.png';"
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
                                        <td class="style3" align="right" style="width: 60px;">
                                            <div ><span id="Lang_terminal_identification"></span><span>&nbsp;&nbsp</span>
                                                </div>
                                        </td>
                                        <td class="style3" align="left">
                                         <input runat="server" name="txtISSIText" type="text" id="txtISSIText" />
                                            
                                        </td>
                                            <td align="left" style="width: 120px;">
 <form id="Form1" runat="server">
                                           
                                                        <img src=" <%--../images/chooseMember0.png--%>" id="imgSelectISSI" onmouseover="<%--javascript:this.src='../images/chooseMember_un.png';--%>"
                                                            onmouseout="<%--javascript:this.src='../images/chooseMember0.png';--%>" onclick="OnAddMember()" />
                                                <asp:Button ID="btnnew" runat="server" Visible="false" Text="<%--新增--%>" CssClass="CALLBUTTON2"
                                                Enabled="false" />
                                            
                                            </form>
                                            </td>
                                    </tr>
                                    <tr>
                                        <td  class="style3" align="right" style="width: 60px;"><span id="Lang_name"></span><span>&nbsp;&nbsp</span>
                                            
                                        </td>
                                        <td class="style3" align="left" colspan="2">
                                            <input runat="server" name="txtUserName" type="text" id="txtUserName" readonly="readonly" disabled="disabled" style="width: 240px" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td  class="style3" align="right" style="width: 60px;">
                                            <span id="Lang_Unit"></span><span>&nbsp;&nbsp</span>
                                        </td>
                                        <td class="style3" align="left" colspan="2">
                                            <input runat="server" name="txtUserEntity" type="text" id="txtUserEntity" readonly="readonly" disabled="disabled" style="width: 240px" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td  class="style3" align="right" style="width: 60px;">
                                             <span id="Lang_Serialnumber"></span><span>&nbsp;&nbsp</span>
                                        </td>
                                        <td class="style3" align="left" colspan="2">
                                            <input runat="server" name="txtPoliceNo" type="text" id="txtPoliceNo" readonly="readonly" disabled="disabled" style="width: 240px" />
                                        </td>
                                    </tr>
                                    <tr><%--xzj--20190320--添加呼叫加密--%>
                                        <td  class="style3" align="right" style="width: 60px;">
                                             <span id="Lang_Encryption"></span><span>&nbsp;&nbsp</span>
                                        </td>
                                        <td class="style3" align="left" colspan="2">
                                           <input runat="server" type="checkbox" id="isEncryption" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td  class="style3" align="right" style="width: 60px;">  
                                            <span id="Lang_Status"></span><span>&nbsp;&nbsp</span>                                       
                                        </td>
                                        <td class="style3" align="left" colspan="2">
                                            <div id="divstatue" style="height: 60px">

                                                <%--无--%></div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td  class="style3" align="right" style="width: 60px;">
                                           <span id="Lang_call_style"></span><span>&nbsp;&nbsp</span>
                                            
                                        </td>
                                        <td class="style3" align="left" colspan="2">
                                            <select name="calltype" id="calltype" runat="server" onchange="CheckMe()">
	<option selected="selected" value="" id="Lang_select_call_style"></option>
	  <option id="Lang_TellMode" value="<%--电话模式--%>"><%--电话模式--%></option>
      <option id="Lang_PTTMode"  value="<%--对讲模式--%>"><%--对讲模式--%></option>
</select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="style3" align="center" colspan="3">
                                            <table>
                                                <tr>
                                                    <td>
                                                        <button class="CALLBUTTON" id="begincall" style="text-align: center; cursor: pointer;"
                                                            onclick="STARTCALL()" onmousedown="PTTSCALL()"  onmouseup="CEASEDSCALL()" onkeypress="keyPress();"
                                                            onkeyup="keyUp();">                                                         
                                                            </button>
                                                    </td>
                                                    <td>
                                                        <button class="CALLBUTTON" id="endcall" style="text-align: center; cursor: pointer;"
                                                            onclick="ENDCALL()">                                                         
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
                <div id="drdiv" style="cursor: move">
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
                    </div>
                </td>
            </tr>
        </table>
    </div>
</body>
</html>
<script type="text/javascript">

    window.parent.closeprossdiv();
    LanguageSwitch(window.parent);

    var image = window.document.getElementById("imgSelectISSI");
    var srouce = window.parent.parent.GetTextByName("Lang_chooseMemberPNG", window.parent.parent.useprameters.languagedata);
    image.setAttribute("src", srouce);
    var strpath = window.parent.parent.GetTextByName("Lang_chooseMemberPNG", window.parent.parent.useprameters.languagedata);
    var strpathmove = window.parent.parent.GetTextByName("Lang_chooseMemberPNG_un", window.parent.parent.useprameters.languagedata);
    image.onmouseover = function () { this.src = strpathmove }
    image.onmouseout = function () { this.src = strpath }

    window.document.getElementById("divstatue").innerHTML = window.parent.parent.GetTextByName("Lang-None", window.parent.parent.useprameters.languagedata);
    window.document.getElementById("begincall").innerHTML = window.parent.parent.GetTextByName("Called", window.parent.parent.useprameters.languagedata);
    window.document.getElementById("endcall").innerHTML = window.parent.parent.GetTextByName("hangsup", window.parent.parent.useprameters.languagedata);
    window.document.getElementById("Lang_TellMode").value = window.parent.parent.GetTextByName("Lang_TellMode", window.parent.parent.useprameters.languagedata);
    window.document.getElementById("Lang_PTTMode").value = window.parent.parent.GetTextByName("Lang_PTTMode", window.parent.parent.useprameters.languagedata);


</script>
<link href="../../CSS/lq_calloutExtender.css" rel="stylesheet" type="text/css" />
