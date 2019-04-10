<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Send_StatusMS.aspx.cs"
    Inherits="Web.lqnew.opePages.Send_StatusMS" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <script src="../../JQuery/jquery-1.5.2.js" type="text/javascript"></script>
    <link href="../css/lq_addedit.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/pagestyle.css" rel="stylesheet" type="text/css" />
    <script src="../js/geturl.js" type="text/javascript"></script>
    <script src="../../JS/LangueSwitch.js" type="text/javascript"></script>
    <style type="text/css">
        #multiinput
        {
            font-size: 12px;
            border: 1px #000 solid;
            font-weight: 700;
            height: 105px;
            width: 292px;
            overflow-y: auto;
        }
        /*span
        {
            color: Blue;
            cursor: hand;
        }*/
        
        #multiinput a:hover
        {
            background-color: #eee;
            cursor: text;
        }
    </style>
    <script type="text/javascript">
        var memberlimitcount = 100;
        var UserID = '<%=Request["id"] %>';
        var myMemberArray = new Array(); //存放发短信的数组，格式为：[{name:name,issi:issi,type,编组}]
        var sendflag = 0;
        var Lang_input_ISSI_or_GSSI_number = window.parent.parent.GetTextByName("Lang_input_ISSI_or_GSSI_number", window.parent.parent.useprameters.languagedata);
        SendStatusMsgIssiString = "";
        function faterdo(results) {
            myMemberArray.length = 0;
            for (var i = 0; i < results.length; i++) {
                myMemberArray.push({ name: results[i].uname, issi: results[i].uissi, type: results[i].utype });
                if (i != results.length - 1) {
                    SendStatusMsgIssiString = SendStatusMsgIssiString + results[i].uname + "," + results[i].uissi + "," + results[i].utype + ";"
                }
                else {
                    SendStatusMsgIssiString = SendStatusMsgIssiString + results[i].uname + "," + results[i].uissi + "," + results[i].utype
                }
            }
            window.parent.hiddenbg2();
            showTitle();
        }
        //每一次显示前 清空重新生成
        function showTitle() {
          
            var strRes = "";
            for (var i = 0; i < myMemberArray.length; i++) {
                strRes += myMemberArray[i].name + "(" + myMemberArray[i].issi + ")" + "<span style='cursor:hand' onclick=\"DeleteArray('" + i + "')\"><img class='style6'  src=\"../images/close.png\" /></span> &nbsp;&nbsp;"
            }
            $("#txtISSI").val(strRes);
            if (strRes == "")
                strRes = "&nbsp;";
            $("#multiinput").html(strRes);
        }
        var Lang_content_toomuch = window.parent.parent.GetTextByName("Lang_content_toomuch", window.parent.parent.useprameters.languagedata);
        var Lang_Status_message = window.parent.parent.GetTextByName("Lang_Status_message", window.parent.parent.useprameters.languagedata);
        var Lang_send_Status_text = window.parent.parent.GetTextByName("Lang_send_Status_text", window.parent.parent.useprameters.languagedata);
        var Lang_send_StatusID = window.parent.parent.GetTextByName("Lang_send_StatusID", window.parent.parent.useprameters.languagedata);
        var Lang_select_send_method = window.parent.parent.GetTextByName("Lang_select_send_method", window.parent.parent.useprameters.languagedata);
        function DeleteArray(i) {
            myMemberArray.splice(i, 1);

            showTitle();
        }
        var SelectUsers = new Array();
        $(document).ready(function () {
            $("#Lang_Terminal_1").text(window.parent.parent.GetTextByName("Terminal", window.parent.parent.useprameters.languagedata));//xzj--20190218--添加基站短信
            CheckMe();
            SendStatusMsgIssiString = $("#txtISSIValue").val();
            myMemberArray.length = 0;
            if ($("#txtISSIValue").val() != "") {
                var a = $("#txtISSIValue").val().split(";");
                if (a != undefined) {
                    for (var i = 0; i < a.length; i++) {
                        var b = a[i].split(",");
                        if (b != undefined) {
                            myMemberArray.push({ name: b[0], issi: b[1], type: b[2] });
                        }
                    }
                }
            }
            showTitle();
            $("#cbSendToPublicNet").change(function () {
                if ($("#cbSendToPublicNet").attr("checked") == "checked") {
                    alert("true");
                } else {
                    alert("false");
                }
            })
            $("#cbSendToPrivateNet").change(function () {
                if ($("#cbSendToPrivateNet").attr("checked") == "checked") {
                    alert("true");
                } else {
                    alert("false");
                }
            })
            //选择ISSI
            $("#imgSelectISSI").click(function () {
                flags = true;
                window.parent.visiablebg2();
              
                SelectUsers.length = 0;
                for (var i = 0; i < myMemberArray.length; i++) {
                    SelectUsers.push({ uname: myMemberArray[i].name, uissi: myMemberArray[i].issi, utype: myMemberArray[i].type });
                }
                window.parent.mycallfunction('AddMemberTree/add_Member', 650, 514, '0&ifr=Send_StatusMS_ifr&selectcount=' + memberlimitcount + '&type=user&selfclose=1', 2001);//xzj--20190218--将type参数的值由all改为user

            })
            $("#imgSumit").click(function () {
                if (myMemberArray.length == 0) {
                    alert(Lang_input_ISSI_or_GSSI_number);//("请输入ISSI号码或者GSSI号码");
                    return;
                }
                var messages = $("#txtContent").val();
                if (messages.length > 2550) {
                    alert(Lang_content_toomuch);//("内容过长");
                    return;
                }
                if (sendflag == 1) {//文本发送
                    window.parent.sendreportMsg(myMemberArray, messages);
                    window.parent.writeLog("oper", "[" + Lang_Status_message + "]:ISSI/GSSI(" + SendStatusMsgIssiString + ")" + Lang_send_Status_text + "[" + window.parent.LOGTimeGet() + "]");         /**日志：操作日志 **/

                    window.parent.mycallfunction(geturl(), 710, 354);
                }
                else if (sendflag == 2) {//状态号发送
                    window.parent.sendreportnum(myMemberArray, messages);
                    window.parent.writeLog("oper", "[" + Lang_Status_message + "]:ISSI/GSSI(" + SendStatusMsgIssiString + ")" + Lang_send_StatusID+ "[" + window.parent.LOGTimeGet() + "]");         /**日志：操作日志 **/

                    window.parent.mycallfunction(geturl(), 710, 354);
                }
                else if (sendflag == 0) {
                    alert(Lang_select_send_method);//("请选择发送方式");
                }
                sendflag = 0;
            })
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
          

        function CheckMe() {                                                                  //替换显示内容

            var selecti = document.getElementById('sendmsgtype').selectedIndex;
            //if (document.getElementById('sendmsgtype').selectedIndex == "0") {                //选择发送方式
            //    sendflag = 0;
            //    $("#trContent").css("display", "none");
            //}
            if (document.getElementById('sendmsgtype').selectedIndex == "0") {                //文本发送
                var Lang_Text = window.parent.parent.GetTextByName("Lang_Text", window.parent.parent.useprameters.languagedata);
                $("#divcont").text(Lang_Text);//("文本：");
                $("#trContent").css("display", "");
                sendflag = 1;
            }
            else if (document.getElementById('sendmsgtype').selectedIndex == "1") {
                var Lang_StatusID = window.parent.parent.GetTextByName("Lang_StatusID", window.parent.parent.useprameters.languagedata);
                $("#divcont").text(Lang_StatusID);//("状态号：");
                $("#trContent").css("display", "");
                sendflag = 2;
            }

            //去掉后
            //var Lang_StatusID = window.parent.parent.GetTextByName("Lang_StatusID", window.parent.parent.useprameters.languagedata);
            //$("#divcont").text(Lang_StatusID);//("状态号：");
            //$("#trContent").css("display", "block");
            //sendflag = 2;
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
                                <img src="../images/tab_03.png" width="15" height="32" />
                            </td>
                            <td width="1101" background="../images/tab_05.gif">
                                <ul class="hor_ul">
                                    <li>
                                        <img src="../images/037.gif" /><span id="Lang_send_statusMessage" ><%--状态消息发送--%></span></li>
                                </ul>
                            </td>
                            <td width="281" background="../images/tab_05.gif" align="right">
                                <img class="style6" style="cursor: hand;" onclick="window.parent.mycallfunction(geturl(),693, 354);"
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
                                        <td class="style3" align="left">
                                            <div id="divIssiTitle">
                                              <span id="Lang_Terminal_1" ><%--终端\--%></span><br>
                                              <%-- <span id="Lang_group_1"></span><br />
                                              <span id="Lang_Dispatch_1" ></span>--%><%--xzj--20190218-注释小组和调度台，控件没有该接口--%>
                                              <img src="<%--../images/btn_add.png--%>" id="imgSelectISSI" onmouseover="<%--javascript:this.src='../images/btn_add_un.png';--%>"
                                                    onmouseout="<%--javascript:this.src='../images/btn_add.png';--%>" />&nbsp;</div>

                                            

                                        </td>
                                        <td align="left">
                                            <div style="display: none">
                                                <textarea type="text" id="txtISSI" style="height: 100%; width: 90%" rows="3" runat="server"></textarea><input
                                                    type="text" id="txtISSIValue" runat="server" /><input type="text" id="txtISSIText"
                                                        runat="server" /></div>
                                            <div id="multiinput">
                                                &nbsp; <a id="t"></a>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td  class="style3" align="right" style="width: 60px;">
                                            <%--方式：--%><span id="Lang_style_1"></span><span>&nbsp;&nbsp</span>
                                        </td>
                                        <td class="style3" align="left">
                                            <select onchange="CheckMe()" id="sendmsgtype">
                                            <%--<option value="" selected="selected" id="Lang_select_send_method"></option>--%><%--请选择发送方式--%>
                                                <option style="display:none" id="Lang_send_text" value=""></option><%--文本发送--%>
                                                <option id="Lang_send_statusID" value="<%--状态号发送--%>"><%--状态号发送--%></option>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr id="trContent" style="display: none">
                                        <td class="style3" align="right">
                                            <div >
                                               <%-- 内容：--%><span id="divcont"></span><span>&nbsp;&nbsp</span>
                                        </td>
                                        <td align="left">
                                            <input type="text" id="txtContent" style="width: 260px" />
                                        </td>
                                    </tr>
                                    <tr style="display:none;">
                                        <td class="style3" colspan="2" align="center">
                                               <span id="Lang_send_publicNet_mobilephone"><%--发送公网手机--%></span>
                                            <input type="checkbox" id="Checkbox1" /><span id="Lang_Sent_to_the_digital_trunking_terminal" ><%--&nbsp;&nbsp; 发送到数字集群终端--%></span><input                                        
                                                type="checkbox" id="cbSendToPrivateNet" checked="checked" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td width="14" background="../images/tab_16.gif">
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td width="15" background="../images/tab_12.gif">
                                &nbsp;
                            </td>
                            <td align="center" height="30">
                                <img id="imgSumit" style="cursor: hand;" src="<%--../images/SMSSend.png--%>" />
                                &nbsp;&nbsp;&nbsp;
                                <img id="imgcancel" style="cursor: hand;" onclick="window.parent.mycallfunction(geturl(),693, 354);"
                                    src="<%--../images/cancel_SMS.png--%>" />
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
</html>
<script>
    window.parent.closeprossdiv();
    LanguageSwitch(window.parent);
  
    var image = window.document.getElementById("imgSelectISSI");
    var srouce = window.parent.parent.GetTextByName("Lang_chooseMemberPNG", window.parent.parent.useprameters.languagedata);
    image.setAttribute("src", srouce);
    var strpath = window.parent.parent.GetTextByName("Lang_chooseMemberPNG", window.parent.parent.useprameters.languagedata);
    var strpathmove = window.parent.parent.GetTextByName("Lang_chooseMemberPNG_un", window.parent.parent.useprameters.languagedata);
    image.onmouseover = function () { this.src = strpathmove }
    image.onmouseout = function () { this.src = strpath }

    var image2 = window.document.getElementById("imgcancel");
    srouce2 = window.parent.parent.GetTextByName("Lang_cancel_SMS", window.parent.parent.useprameters.languagedata);
    image2.setAttribute("src", srouce2);

    var image1 = window.document.getElementById("imgSumit");
    var srouce1 = window.parent.parent.GetTextByName("Lang_SMSSend", window.parent.parent.useprameters.languagedata);
    image1.setAttribute("src", srouce1);

    //window.document.getElementById("Lang_send_text").value = window.parent.parent.GetTextByName("Lang_send_text", window.parent.parent.useprameters.languagedata);
    window.document.getElementById("Lang_send_statusID").value = window.parent.parent.GetTextByName("Lang_send_statusID", window.parent.parent.useprameters.languagedata);   
    window.document.getElementById("divcont").innerHTML = window.parent.parent.GetTextByName("Lang_content", window.parent.parent.useprameters.languagedata);

</script>
<link href="../../CSS/lq_calloutExtender.css" rel="stylesheet" type="text/css" />
