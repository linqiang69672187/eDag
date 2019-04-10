<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Send_SMS.aspx.cs" Inherits="Web.lqnew.opePages.Send_SMS" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <script src="../../JQuery/jquery-1.5.2.js" type="text/javascript"></script>
    <link href="../css/lq_addedit.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/pagestyle.css" rel="stylesheet" type="text/css" />
    <script src="../js/geturl.js" type="text/javascript"></script>
    <script src="../../MyCommonJS/ajax.js" type="text/javascript"></script>
    <script src="../js/CommValidator.js" type="text/javascript"></script>
    <script src="../../JS/LangueSwitch.js" type="text/javascript"></script>
    <style type="text/css">
        #multiinput
        {
            font-size: 12px;
            position:relative;
            left:0px;
            top:0px;
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
        var UserID = '<%=Request["id"] %>';
        var memberlimitcount = 100;

        var myMemberArray = new Array(); //存放发短信的数组，格式为:[{name:name,issi:issi,type,编组}]
        var Group = window.parent.parent.GetTextByName("Group", window.parent.parent.useprameters.languagedata);
        var lang_dispatch = window.parent.parent.GetTextByName("Dispatch", window.parent.parent.useprameters.languagedata);
        var lang_baseStation = window.parent.parent.GetTextByName("Station", window.parent.parent.useprameters.languagedata);//xzj--20190218--添加基站短信

        function checkHaveGSSI() {//验证是否存在编组 存在的话不能有回执，不存在就可以有回执
            var myflag = false;
            for (var i = 0; i < myMemberArray.length; i++) {
                if (myMemberArray[i].type == Group) { //"编组"
                    myflag = true;
                    break;
                }
            }
            if (myflag) {
                $("#trHZ").css("display", "none");
            } else {
                $("#trHZ").css("display", "");
            }
        }
       
        function faterdo(results) {
            //myMemberArray = results;
            myMemberArray.length = 0;
            var noDispatch = false;
            SendMsgIssiString = "";
            for (var i = 0; i < results.length; i++) {
                if (results[i].utype != window.parent.parent.GetTextByName("Dispatch", window.parent.parent.useprameters.languagedata) && results[i].utype != window.parent.parent.GetTextByName("Station", window.parent.parent.useprameters.languagedata)) {//xzj--20190218--添加基站短信
                    noDispatch = true;
                }
                myMemberArray.push({ name: results[i].uname, issi: results[i].uissi, type: results[i].utype });
                if (i != results.length - 1) {
                    SendMsgIssiString = SendMsgIssiString + results[i].uname + "," + results[i].uissi + "," + results[i].utype + ";"
                }
                else {
                    SendMsgIssiString = SendMsgIssiString + results[i].uname + "," + results[i].uissi + "," + results[i].utype
                }
            }
            if (noDispatch) {
                document.getElementById("Lang_Receipt").style.display = "block";
                document.getElementById("cbIsBack").style.display = "block";
            } else {
                document.getElementById("Lang_Receipt").style.display = "none";
                document.getElementById("cbIsBack").checked = false;
                document.getElementById("cbIsBack").style.display = "none";
            }
            window.parent.hiddenbg2();
            showTitle();
        }
        //每一次显示前 清空重新生成
        function showTitle() {
            checkHaveGSSI();
            var strRes = "";
            for (var i = 0; i < myMemberArray.length; i++) {
                if (myMemberArray[i].issi != "" && myMemberArray[i].issi != "0") {//20171127虞晨超 为0或空时不显示
                    strRes += "<span id='span_member_'" + i + ">" + myMemberArray[i].name + "(" + myMemberArray[i].issi + ")" + "<span style='cursor:hand' onclick=\"DeleteArray('" + i + "')\"><img class='style6'  src=\"../images/close.png\" /></span></span> &nbsp;&nbsp;"
                }
            }
            $("#txtISSI").val(strRes);
            if (strRes == "")
                strRes = "&nbsp;";
                $("#multiinput").html(strRes);

           

        }

        function DeleteArray(i) {
            myMemberArray.splice(i, 1);
            var noDispatch = true;
            for (var m = 0; m < myMemberArray.length; m++)
            {
                if (myMemberArray[m].type == window.parent.parent.GetTextByName("Dispatch", window.parent.parent.useprameters.languagedata) || myMemberArray[m].type == window.parent.parent.GetTextByName("Station", window.parent.parent.useprameters.languagedata))//xzj--20190218--添加基站短信
                {
                    noDispatch = false;
                }
            }
            if (noDispatch) {
                document.getElementById("Lang_Receipt").style.display = "block";
                document.getElementById("cbIsBack").style.display = "block";
            } else {
                document.getElementById("Lang_Receipt").style.display = "none";
                document.getElementById("cbIsBack").style.display = "none";
            }
            showTitle();
            
        }
        var SelectUsers = new Array();
        $(document).ready(function () {
            $("#Lang_BaseStation_1").text(window.parent.parent.GetTextByName("Station", window.parent.parent.useprameters.languagedata));//xzj--20190218--添加基站短信
            SendMsgIssiString = $("#txtISSIValue").val();
            myMemberArray.length = 0;
            var noDispatch = true;
            if ($("#txtISSIValue").val() != "") {
                var a = $("#txtISSIValue").val().split(";");
               
                if (a != undefined) {
                    for (var i = 0; i < a.length; i++) {
                        var b = a[i].split(",");
                        if (b != undefined) {
                            if (b[2] == window.parent.parent.GetTextByName("Dispatch", window.parent.parent.useprameters.languagedata) || b[2] == window.parent.parent.GetTextByName("Station", window.parent.parent.useprameters.languagedata)) {//xzj--20190218--添加基站短信
                                noDispatch = false;
                            }
                            myMemberArray.push({ name: b[0], issi: b[1], type: b[2] });
                        }
                    }
                }
            }
            if (noDispatch) {
                document.getElementById("Lang_Receipt").style.display = "block";
                document.getElementById("cbIsBack").style.display = "block";
            } else {
                document.getElementById("Lang_Receipt").style.display = "none";
                document.getElementById("cbIsBack").style.display = "none";
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
            });
           
            //选择ISSI
            $("#imgSelectISSI").click(function () {
                flags = true;
                window.parent.visiablebg2();
                //var urlparam = "";
                //if (myMemberArray.length <= 50) {//限制为100 大于100的舍去
                //    for (var i = 0; i < myMemberArray.length; i++) {
                //        urlparam += myMemberArray[i].name + "(" + myMemberArray[i].issi + ");";
                //    }
                //} else {
                //    for (var i = 0; i < 50; i++) {
                //        urlparam += myMemberArray[i].name + "(" + myMemberArray[i].issi + ");";
                //    }
                //}
                //window.parent.mycallfunction('Add_Member/add_Member', 635, 514, '0&ifr=Send_SMS_ifr&issi=' + urlparam, 2001);
                SelectUsers.length = 0;
                for (var i = 0; i < myMemberArray.length; i++) {
                    SelectUsers.push({ uname: myMemberArray[i].name, uissi: myMemberArray[i].issi, utype: myMemberArray[i].type });
                }
                var type_ISSI//虞晨超2018 完善个组短信权限问题
                if (window.parent.useprameters.SMSEnable == "1" && window.parent.useprameters.GroupSMSEnable == "1") {
                    type_ISSI = "all";
                } else if (window.parent.useprameters.SMSEnable == "1") {
                    type_ISSI = "user";
                } else if (window.parent.useprameters.GroupSMSEnable == "1") {
                    type_ISSI = "group";
                } else {
                    type_ISSI = "dispatch";
                }
                '<%if(Request["sid"] != null){%>'
                window.parent.mycallfunction('AddMemberTree/add_Member', 650, 514, '0&ifr=Send_SMS_ifr&selectcount=' + memberlimitcount + '&type=' + type_ISSI, 2001);
                '<%}else{%>'
                window.parent.mycallfunction('AddMemberTree/add_Member', 650, 514, '0&ifr=Send_SMS_ifr&selectcount=' + memberlimitcount + '&type=' + type_ISSI + '&selfclose=1', 2001);
                '<%}%>'
            })
            var Lang_please_select_transmission_target = window.parent.parent.GetTextByName("Lang_please_select_transmission_target", window.parent.parent.useprameters.languagedata);
            var Lang_please_input_shortMessage = window.parent.parent.GetTextByName("Lang_please_input_shortMessage", window.parent.parent.useprameters.languagedata);           
            var Lang_shortMessage_include_special_words = window.parent.parent.GetTextByName("Lang_shortMessage_include_special_words", window.parent.parent.useprameters.languagedata);
            var lang_dispatch=window.parent.parent.GetTextByName("Dispatch", window.parent.parent.useprameters.languagedata);
            var lang_group=window.parent.parent.GetTextByName("Group", window.parent.parent.useprameters.languagedata);
            var lang_samemtype = window.parent.parent.GetTextByName("numb19", window.parent.parent.useprameters.languagedata);

            function BindSize(text, size) {
                var x = 0;
                str = text.replace(/[\s\S]/g, function (d, i, s) {
                    if (d.charCodeAt(0) > 127) x++;
                    if (x + i >= size) return "";
                    return d;
                });
                return str;
            }

            $("#imgSumit").click(function () {
                
                if (myMemberArray.length == 0) {
                    alert(Lang_please_select_transmission_target);//("请选择发送目标");
                    return;
                }
                //发送短信时只能选择一种类别
                var sameType = "same";
                var defaultType = "personal";
                var mt1 = "";
                for (var i = 0; i < myMemberArray.length; i++) {

                    var tempType = myMemberArray[i].type;
                    if (tempType != lang_dispatch && tempType != Group && tempType != lang_baseStation)//xzj--20190218--添加基站短信
                        tempType = defaultType;

                    if (mt1 == "")
                        mt1 = tempType;
                    else {
                        if (mt1 != tempType)
                            sameType = "different";
                    }

                    if (!sameType)
                        break;
                }

                if (sameType == "different") {
                    alert(lang_samemtype);
                    return sameType;
                }

                SendMsgIssiString = "";
                for (var i = 0; i < myMemberArray.length; i++) {
                    if (i != myMemberArray.length - 1) {
                        SendMsgIssiString = SendMsgIssiString + myMemberArray[i].name + "," + myMemberArray[i].issi + "," + myMemberArray[i].type + ";"
                    }
                    else {
                        SendMsgIssiString = SendMsgIssiString + myMemberArray[i].name + "," + myMemberArray[i].issi + "," + myMemberArray[i].type
                    }
                }

                if (myMemberArray.length > memberlimitcount) {
                    var Lang_biggerthansystemlimit = window.parent.parent.GetTextByName("Lang_biggerthansystemlimit", window.parent.parent.useprameters.languagedata);
                    alert(Lang_biggerthansystemlimit + "[" + memberlimitcount + "]");//电子栅栏最多支持的成员数[200];
                    return;
                }
                var hz = 0;
                var a = $("#cbIsBack");
                if (a[0].checked)
                { hz = 1; }
               
                if ($("#trHZ").css("display") == "none") {
                    hz = 0;
                }               
                var messages = $("#txtContent").val();
                if (messages == "") {
                    alert(Lang_please_input_shortMessage);//("请输入短信内容");
                    return;
                }
                if (!checkMsgContent(messages)) {
                    alert(Lang_shortMessage_include_special_words);//("短信内容包含<、>、\\、/等特殊字符");
                    return;
                }
                var Lang_send_shortMessage = window.parent.parent.GetTextByName("Lang_send_shortMessage", window.parent.parent.useprameters.languagedata);
                var messageRestrict = window.parent.parent.GetTextByName("numb4", window.parent.parent.useprameters.languagedata);
                var messageRestrict1 = window.parent.parent.GetTextByName("numb5", window.parent.parent.useprameters.languagedata);
                var messageRestrict2 = window.parent.parent.GetTextByName("numb17", window.parent.parent.useprameters.languagedata);
                var messageRestrict3 = window.parent.parent.GetTextByName("numb18", window.parent.parent.useprameters.languagedata);
   
                //var zjlength = messages.replace(/[^\x00-\xff]/gi, "--").length;
                //取消短信拆分，限制中文长度为500字符，英文为1000字符，张谦改
                var isContainChinese = isContainDoubleChars(messages);
                if (myMemberArray[0].type == window.parent.parent.GetTextByName("Group", window.parent.parent.useprameters.languagedata)) { //当只有一个对象的时候特殊处理，不然循环发送的时候会出问题；多语言：编组
                    //组短信
                    if (isContainChinese) {
                        if (messages.length > 70) {
                            alert(messageRestrict2);
                            return;
                        }
                    }
                    else {
                        if (messages.length > 140) {
                            alert(messageRestrict3);
                            return;
                        }
                    }
                }
                else {
                    //个短信
                    if (isContainChinese) {
                        if (messages.length > 500) {
                            alert(messageRestrict);
                            return;
                        }
                    }
                    else {
                        if (messages.length > 1000) {
                            alert(messageRestrict1);
                            return;
                        }
                    }
                }
                //var pd = 0;
                //if (zjlength % 140 == 0) {
                //    pd = parseInt(zjlength / 140); //取整数部分 共几条
                //}
                //else {
                //    pd = parseInt(zjlength / 140) + 1; //取整数部分 共几条
                //}
                var mes = messages; 
                //for (var mui = 1; mui <= pd; mui++) {
                //    var sendmsg = BindSize(mes, 140);
                //    //TODO需要判断内容中是否含有汉字,含有汉字 就再拆分成70个字符一条  这种方式不太好，有时候本来只需发2条就行了 现在要变成3条了，比较好的方式是判断中文在第几个字符 在小于70  在70到140之间的 等等情况特殊处理
                //    if (/.*[\u4e00-\u9fa5]+.*$/.test(sendmsg)) {
                //        var sendmsg1 = BindSize(sendmsg, 70);
                //        window.parent.sendMsg(myMemberArray, sendmsg1, hz);
                //        if (sendmsg1.length != sendmsg.length) {
                //            var sendmsg2 = sendmsg.substring(sendmsg1.length, sendmsg.length);
                //            window.parent.sendMsg(myMemberArray, sendmsg2, hz);
                //        }

                //        mes = mes.substring(sendmsg.length, mes.length)
                //        if (mui == pd) {
                //            window.parent.hiddenbg2();
                //            window.parent.mycallfunction(geturl(), 710, 354);
                //        }
                //    }
                //    else {
                       // var sendmsg1 = BindSize(sendmsg, 70);
                if (window.parent.sendMsg(myMemberArray, mes, hz))
                    //mes = mes.substring(sendmsg.length, mes.length)
                    //if (mui == pd) {
                {
                    var Lang_send_shortMessage_1 = window.parent.parent.GetTextByName("Lang_send_shortMessage_1", window.parent.parent.useprameters.languagedata);
                    window.parent.writeLog("oper", "[" + Lang_send_shortMessage + "]:ISSI/GSSI(" + SendMsgIssiString + ")" + Lang_send_shortMessage_1 + "[" + window.parent.LOGTimeGet() + "]");         /**日志:操作日志 **/

                    window.parent.hiddenbg2();
                    window.parent.mycallfunction(geturl(), 710, 354);
                }
                        //}
                    //}
                //}
                
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
        //useprameters.GroupSMSEnable = data.GroupSMSEnable;                                     //组短消息是否启用
        //useprameters.SMSEnable = data.SMSEnable;                                          //短消息是否启用
        window.onload = function () {//虞晨超2018.1.9 
            function SMS_typeRight() {
                if (window.parent.useprameters.SMSEnable == "0") {
                    document.getElementById("Lang_Terminal_1").style.display = "none";
                };
                if (window.parent.useprameters.GroupSMSEnable == "0") {
                    document.getElementById("Lang_group_1").style.display = "none";
                };
            }
            SMS_typeRight()
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
                                        <img src="../images/037.gif" /><span id="Lang_send_shortMessage" ><%--短信发送--%></span></li>
                                </ul>
                            </td>
                            <td width="281" background="../images/tab_05.gif" align="right">
                                <img class="style6" style="cursor: hand;" onclick="window.parent.hiddenbg2();;window.parent.mycallfunction(geturl(),693, 354);"
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
                                               <span id="Lang_group_1"><%--小组\--%></span><br />
                                               <span id="Lang_Dispatch_1" ><%--调度台:--%></span><br />
                                               <span id="Lang_BaseStation_1" ><%--基站:xzj--20190218--添加基站短信--%></span><img src="<%--../images/btn_add.png--%>" id="imgSelectISSI" onmouseover="<%--javascript:this.src='../images/btn_add_un.png';--%>"
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
                                        <td  class="style3" align="right">
                                           <%-- 内容:--%><span id="Lang_content"></span><span>&nbsp;&nbsp</span>
                                        </td>
                                        <td align="left">
                                            <textarea rows="5" id="txtContent" style="height: 100%; width: 288px"></textarea>
                                            &nbsp;
                                        </td>
                                    </tr>
                                    <tr id="trHZ" runat="server">
                                        <td  class="style3" align="right">
                                           <%-- 回执:--%><span id="Lang_Receipt"></span><span>&nbsp;&nbsp</span>
                                        </td>
                                        <td align="left">
                                            <input type="checkbox" id="cbIsBack" />
                                        </td>
                                    </tr>
                                    <tr style="display:none;">
                                        <td  class="style3" colspan="2" align="center">
                                           <span id="Lang_send_publicNet_mobilephone"><%--发送公网手机--%></span>
                                            <input type="checkbox" id="cbSendToPublicNet" /><span id="Lang_Sent_to_the_digital_trunking_terminal" ><%--&nbsp;&nbsp; 发送到数字集群终端--%></span><input
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
                                <img id="imgcancel" style="cursor: hand;" onclick="window.parent.hiddenbg2();window.parent.mycallfunction(geturl(),693, 354);"
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

    var image1 = window.document.getElementById("imgSumit");
    var srouce1 = window.parent.parent.GetTextByName("Lang_SMSSend", window.parent.parent.useprameters.languagedata);
    image1.setAttribute("src", srouce1);
    //var strpath1 = window.parent.parent.GetTextByName("Lang_SMSSend", window.parent.parent.useprameters.languagedata);
    //var commendover1 = "javascript:this.src='" + strpath1 + "';"
    //image1.setAttribute("onmouseover", commendover1);
    //var commendout1 = "javascript:this.src='" + strpath1 + "';"
    //image.setAttribute("onmouseout", commendout1);
    var image2 = window.document.getElementById("imgcancel");
    srouce2 = window.parent.parent.GetTextByName("Lang_cancel_SMS", window.parent.parent.useprameters.languagedata);
    image2.setAttribute("src", srouce2);
    //var strpath2 = window.parent.parent.GetTextByName("Lang_cancel_SMS", window.parent.parent.useprameters.languagedata);
    //var commendover2 = "javascript:this.src='" + strpath2 + "';"
    //image2.setAttribute("onmouseover", commendover2);
    //var commendout2 = "javascript:this.src='" + strpath2 + "';"
    //image2.setAttribute("onmouseout", commendout2);
   // window.document.getElementById("cbSendToPublicNet").innerHTML = window.parent.parent.GetTextByName("Lang_Sent_to_the_digital_trunking_terminal", window.parent.parent.useprameters.languagedata);
</script>
<link href="../../CSS/lq_calloutExtender.css" rel="stylesheet" type="text/css" />
