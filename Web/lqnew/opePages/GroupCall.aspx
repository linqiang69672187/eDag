<%@ Page Language="C#" AutoEventWireup="true"  ValidateRequest="false"  CodeBehind="GroupCall.aspx.cs" Inherits="Web.lqnew.opePages.GroupCall" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link href="../css/lq_addedit.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/pagestyle.css" rel="stylesheet" type="text/css" />
    <script src="../js/geturl.js" type="text/javascript"></script>
    <link href="../css/btn.css" rel="stylesheet" type="text/css" />
    <script src="../../JQuery/jquery-1.5.2.js" type="text/javascript"></script>
    <script src="../../JS/LangueSwitch.js" type="text/javascript"></script>
    <script src="../js/StringPrototypeFunction.js" type="text/javascript"></script>
    <script language="javascript" type="text/javascript">
       
        var flag = false;
        var isCallGssi = "";
        var Lang_start_call_failure = window.parent.parent.GetTextByName("Lang_start_call_failure", window.parent.parent.useprameters.languagedata);
        var Lang_Illegal_terminal_identification = window.parent.parent.GetTextByName("Lang_Illegal_terminal_identification", window.parent.parent.useprameters.languagedata);
        var Lang_CALL_REQUEST_IN = window.parent.parent.GetTextByName("Lang_CALL_REQUEST_IN", window.parent.parent.useprameters.languagedata);
        var Lang_CallEnd = window.parent.parent.GetTextByName("Lang_CallEnd", window.parent.parent.useprameters.languagedata);
        var CC_RELEASE = window.parent.parent.GetTextByName("CC_RELEASE", window.parent.parent.useprameters.languagedata);// "对方挂断";
        var Lang_This_call_is_not_end = window.parent.parent.GetTextByName("Lang_This_call_is_not_end", window.parent.parent.useprameters.languagedata);// "对方挂断";

        function CloseWindow() {
            var a = $("#divstatue").html();
            var b = CC_RELEASE //"对方挂断";
            if (a.indexOf(b) > 0 || a == Lang_CallEnd) {
                flag = false;
            }
            if (flag) {
                alert(Lang_This_call_is_not_end); //呼叫未结束
                return;
            }
            window.parent.hiddenbg2();
            window.parent.mycallfunction('GroupCall');
        }
        function keyPress() {
            if (event.keyCode == 32) {
                PTTGCALL();
            }
        }
        function keyUp() {
            if (event.keyCode == 32) {
                CEASEDGCALL();
            }
        }
        var Lang_Illegal_group_identification = window.parent.parent.GetTextByName("Lang_Illegal_group_identification", window.parent.parent.useprameters.languagedata);// 非法小组标识;
        var GSSIFieldMust = window.parent.parent.GetTextByName("GSSIFieldMust", window.parent.parent.useprameters.languagedata);// 非法小组标识;
        var Lang_call_failure = window.parent.parent.GetTextByName("Lang_call_failure", window.parent.parent.useprameters.languagedata);// 呼叫失败;
        function PTTGCALL() {
            var inttxtGISSI = document.getElementById('txtGIIS').value.trim();

            if (/[^\d]/.test(inttxtGISSI)) {
                alert(Lang_Illegal_group_identification);
                return;
            }

            if (inttxtGISSI <= 0 || inttxtGISSI > 80699999) {
                alert(Lang_Illegal_group_identification);
                return;
            }

            if (inttxtGISSI == "") {
                alert(GSSIFieldMust);//("小组标识不能为空");
                $("#showmessage").html(GSSIFieldMust);
                return;
            }
            if (!flag) {
                doPostData();
            }
            $("#showmessage").html("");
            var isEncryption = "0"//xzj--20190320--添加呼叫加密参数
            if (document.getElementById("isEncryption").checked) {
                isEncryption = "1";
            }
            var iscall = window.parent.parent.startGC2(inttxtGISSI, isEncryption);
            if (iscall == 0) {
                $("#divstatue").html(Lang_call_failure); //呼叫失败
                document.getElementById("imgSelectUser").style.display = "block";
                document.getElementById("txtGIIS").disabled = false;
                document.getElementById("isEncryption").disabled = false;//xzj--20190320--添加呼叫加密参数
                return;
            }

            document.getElementById("imgSelectUser").style.display = "none";
            document.getElementById("txtGIIS").disabled = true;
            document.getElementById("isEncryption").disabled = true;//xzj--20190320--添加呼叫加密参数
            isCallGssi = inttxtGISSI;
            flag = true;
        }
        function CEASEDGCALL() {
            var inttxtGISSI = document.getElementById('txtGIIS').value.trim();
            if (/[^\d]/.test(inttxtGISSI)) {
                //alert("非法ISSI");
                return;
            }
            if (inttxtGISSI == "") {
                $("#showmessage").html(GSSIFieldMust);
                return;
            }

            var iscall = window.parent.parent.gceasedPTT2(inttxtGISSI);
            if (iscall == 0) {
                $("#divstatue").html(Lang_call_failure); //呼叫失败
                document.getElementById("imgSelectUser").style.display = "block";
                document.getElementById("txtGIIS").disabled = false;
                document.getElementById("isEncryption").disabled = false;//xzj--20190320--添加呼叫加密参数
                flag = false;
                return;
            }
           
            flag = true;
        }
        var Lang_havenot_start_call_failure = window.parent.parent.GetTextByName("Lang_havenot_start_call_failure", window.parent.parent.useprameters.languagedata);//未发起呼叫
        var Lang_Ending_group_calling_failure = window.parent.parent.GetTextByName("Lang_havenot_start_call_failure", window.parent.parent.useprameters.languagedata);
        function CALLEND() {

            /**让调度台结束终端发起的
            if (!flag) {
                alert(Lang_havenot_start_call_failure);
                return;
            }
            */
            flag = false;
            isCallGssi = "";
            var iscall = window.parent.parent.endGC2(document.getElementById('txtGIIS').value.trim());
                //document.getElementById('divstatue').innerHTML = Lang_CallEnd;
            if (iscall == 0) {
                //$("#divstatue").html(Lang_havenot_start_call_failure); //("结束组呼失败");
                $("#divstatue").html(Lang_Ending_group_calling_failure); //("结束组呼失败");
                return;
            }
            document.getElementById("imgSelectUser").style.display = "block";
            document.getElementById("txtGIIS").disabled = false;
            document.getElementById("isEncryption").disabled = false;//xzj--20190320--添加呼叫加密参数

        }
        var multicastgroup = window.parent.parent.GetTextByName("multicastgroup", window.parent.parent.useprameters.languagedata);
        var putong_group = window.parent.parent.GetTextByName("putong_group", window.parent.parent.useprameters.languagedata);
        var lang_group = window.parent.parent.GetTextByName("Group", window.parent.parent.useprameters.languagedata);
        function doPostData() {

            $.ajax({
                type: "POST",
                url: "../../Handlers/GetGroupInfo_Handler.ashx",
                data: "giis=" + $("#txtGIIS").val().trim(),
                success: function (msg) {

                    var my = eval(msg);
                    if (my.length > 0) {
                        if (my[0].groupname == "") {
                            $("#txtGroupName").val($("#txtGIIS").val().trim());
                        }
                        else {
                            $("#txtGroupName").val(my[0].groupname);
                        }
                        $("#txtEntityName").val(my[0].entityname);

                        if (my[0].grouptype == 'dtgroup') {
                            $("#txtGType").val(multicastgroup); //val('通播组');
                        } else
                            if (my[0].grouptype == 'group') {
                                $("#txtGType").val(putong_group);//val('普通组');
                            } else {
                                $("#txtGType").val(putong_group);
                            }
                        SelectUsers.length = 0;
                        if (my[0].groupname != undefined) {
                            SelectUsers.push({ uname: my[0].groupname, uissi: $("#txtGIIS").val().trim(), utype: lang_group });
                        }
                    }
                }
            });
        }
        $(document).ready(function () {
            window.parent.visiablebg2();
            $("#txtGIIS").change(function () {
//                if (isCallGssi != "") {//不需要控制了
//                    document.getElementById('txtGIIS').value = isCallGssi;
//                    return;
//                }
                doPostData();

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
            //xzj--20190320--设置加密呼叫默认值
            var callEncryption = window.parent.parent.useprameters.CallEncryption;
            if (callEncryption.indexOf("Group") >= 0) {
                $("#isEncryption").attr("checked", true);
            }
            else {
                $("#isEncryption").attr("checked", false);
            }
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
            window.parent.mycallfunction('AddMemberTree/add_Member', 650, 514, '0&ifr=GroupCall_ifr&selectcount=1&type=group', 2001);
            //window.parent.mycallfunction('AddGroupCallMember/add_Member', 635, 514, '0&ifr=GroupCall_ifr&issi=' + $("#txtGIIS").val().trim(), 2001);
        }
        function faterdo(retrunissis) {
            if (retrunissis.length > 0) {
                SelectUsers.length = 0;
                SelectUsers.push({ uname: retrunissis[0].uname, uissi: retrunissis[0].uissi, utype: retrunissis[0].utype });
            } else {
                return;
            }
            $("#txtGIIS").val(retrunissis[0].uissi);
            $.ajax({
                type: "POST",
                url: "../../Handlers/GetGroupInfo_Handler.ashx",
                data: "giis=" + retrunissis[0].uissi,
                success: function (msg) {
                   
                    var my = eval(msg);
                    $("#txtGroupName").val(my[0].groupname);
                    $("#txtEntityName").val(my[0].entityname);
                    if (my[0].grouptype == 'dtgroup') {
                        $("#txtGType").val(multicastgroup);//val('通播组');
                    } else
                        if (my[0].grouptype == 'group') {
                            $("#txtGType").val(putong_group);//.val('普通组');
                        } else {
                            $("#txtGType").val(putong_group);
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
                <div id="divdrag" style="cursor:move">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td width="15" height="32">
                                <img src="../images/tab_03.png" width="15" height="32" />
                            </td>
                            <td width="1101" background="../images/tab_05.gif">
                                <ul class="hor_ul">
                                    <li>
                                        <img src="../images/037.gif" /><span id="Lang_smallGroupCall"><%--小组呼叫--%></span></li>
                                </ul>
                            </td>
                            <td width="281" background="../images/tab_05.gif" align="right">
                                <img class="style6" style="cursor: pointer;" onclick="CloseWindow()"
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
                            <td align="center">
                                <table class="style1" cellspacing="1" id="dragtd">
                                    <tr>
                                        <td class="style3" align="right" style="width: 80px;">
                                            <div >
                                               <%-- 小组标识：--%><span id="divIssiTitle"></span><span>&nbsp;&nbsp</span></div>
                                        </td>
                                        <td class="style3" align="left">
                                         <input type="text" id="txtGIIS" runat="server" />
                                            
                                        </td>
                                        <td align="left" style="width: 120px;">
                                        <form id="Form1" runat="server"> 
                                            <img src="<%--../images/chooseMember0.png--%>" id="imgSelectUser" onclick="OnAddMember()" onmouseover="<%--javascript:this.src='../images/chooseMember_un.png';--%>"
                                                onmouseout="<%--javascript:this.src='../images/chooseMember0.png';--%>" />
                                              <asp:Button ID="btnnew" runat="server" Visible="false" Text="新增" CssClass="CALLBUTTON2" Enabled="false" />   </form>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td  class="style3" align="right" style="width: 60px;">
                                            <%--组名：--%><span id="GroupName"></span><span>&nbsp;&nbsp</span>
                                        </td>
                                        <td class="style3" align="left" colspan="2">
                                            <input type="text" readonly="readonly" disabled="disabled" style="width:240px" id="txtGroupName" runat="server" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td  class="style3" align="right" style="width: 60px;">
                                           <%-- 单位：--%><span id="Lang_Unit"></span><span>&nbsp;&nbsp</span>
                                        </td>
                                        <td class="style3" align="left" colspan="2">
                                            <input type="text" readonly="readonly" disabled="disabled" style="width:240px" id="txtEntityName" runat="server" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td  class="style3" align="right" style="width: 60px;">
                                            <%--类型：--%> <span id="Lang_style"></span><span>&nbsp;&nbsp</span>
                                        </td>
                                        <td class="style3" align="left" colspan="2">
                                            <input type="text" readonly="readonly" disabled="disabled" style="width:240px" id="txtGType" runat="server" />
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
                                            <%--状态：--%><span id="Lang_Status"></span><span>&nbsp;&nbsp</span>
                                        </td>
                                        <td class="style3" align="left" colspan="2">
                                            <div id="divstatue" style=" height:60px">
                                                <%--无--%></div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="style3" align="center" colspan="3">
                                            <button id="btnBegin" class="btn" style="width: 60px; text-align: center; vertical-align: bottom"
                                                onmousedown="PTTGCALL()" onmouseup="CEASEDGCALL()" onkeypress="keyPress();" onkeyup="keyUp();" onclick="return btnBegin_onclick()">
                                                PTT
                                            </button>
                                            &nbsp;&nbsp;
                                            <button id="btnEnd" class="btn" style="width:60px; text-align: center" onclick="CALLEND()">
                                                <%--结束--%>
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

    window.document.getElementById("divIssiTitle").innerHTML = window.parent.parent.GetTextByName("groupbz", window.parent.parent.useprameters.languagedata);
    window.document.getElementById("btnEnd").innerHTML = window.parent.parent.GetTextByName("TOend", window.parent.parent.useprameters.languagedata);
    window.document.getElementById("divstatue").innerHTML = window.parent.parent.GetTextByName("Lang-None", window.parent.parent.useprameters.languagedata);
    window.document.getElementById("GroupName").innerHTML = window.parent.parent.GetTextByName("Lang_GroupName", window.parent.parent.useprameters.languagedata);
    function btnBegin_onclick() {
    }

</script>
<link href="../../CSS/lq_calloutExtender.css" rel="stylesheet" type="text/css" />
</html>
