<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SMSDetail.aspx.cs" Inherits="Web.lqnew.opePages.SMS.SMSDetail" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title></title>


    <style type="text/css">
        body, .style1
        {
            background-color: transparent;
            margin: 0px;  
            font-size: 12px;
        }

        .style1
        {
            width: 100%;height: 100%;
            background-repeat: repeat-y;
        }

        .style2
        {
            width: 10px;
        }

        .bg1
        {
            background-image: url('../../view_infoimg/images/bg_02.png');
            background-repeat: repeat-x;
            vertical-align: top;
        }

        .bg2
        {
            background-image: url('../../view_infoimg/images/bg_10.png');
            background-repeat: repeat-x;
        }

        .bg3
        {
            background-image: url('../../view_infoimg/images/bg_05.png');
            background-repeat: repeat-y;
        }

        .bg4
        {
            background-image: url('../../view_infoimg/images/bg_06.png');
        }

        .bg5
        {
            background-image: url('../../view_infoimg/images/bg_07.png');
            background-repeat: repeat-y;
        }

        #divClose
        {
            width: 33px;
            height: 16px;
            position: relative;
            border: 0px;
            float: right;
            margin-top: 1px;
            background-image: url('../../view_infoimg/images/minidict_03.png');
            cursor: pointer;
        }

        .td1td
        {
            background-color: #FFFFFF;
            width: 110px;
            height: 25px;
            text-align: right;
            font-weight: bold;
        }

        #sash_left
        {
            width: 250px;
            box-shadow: 3px 3px 4px #999;
            -moz-box-shadow: 3px 3px 4px #999;
            -webkit-box-shadow: 3px 3px 4px #999;
            /* For IE 5.5 - 7 */
            filter: progid:DXImageTransform.Microsoft.Shadow(Strength=4, Direction=135, Color='#999999');
            /* For IE 8 */
            -ms-filter: "progid:DXImageTransform.Microsoft.Shadow(Strength=4, Direction=135, Color='#999999')";
        }

            #sash_left ul
            {
                text-align: left;
                vertical-align: middle;
                padding-left: 75px;
            }

                #sash_left ul li
                {
                    line-height: 16px;
                    margin: 2px 0;
                }

        .b1, .b2, .b3, .b4
        {
            font-size: 1px;
            overflow: hidden;
            display: block;
        }

        .b1
        {
            height: 1px;
            background: #AAA;
            margin: 0 5px;
        }

        .b2
        {
            height: 1px;
            background: #E0E0E0;
            border-right: 2px solid #AAA;
            border-left: 2px solid #AAA;
            margin: 0 3px;
        }

        .b3
        {
            height: 1px;
            background: #E3E3E3;
            border-right: 1px solid #AAA;
            border-left: 1px solid #AAA;
            margin: 0 2px;
        }

        .b4
        {
            height: 2px;
            background: #E6E6E6;
            border-right: 1px solid #AAA;
            border-left: 1px solid #AAA;
            margin: 0 1px;
        }

        .contentb
        {
            background: #E9E9E9;
            border-right: 1px solid #AAA;
            border-left: 1px solid #AAA;
            word-break: break-all;
            text-align: left;
            font-family: Arial;
        }

        .b11, .b22, .b33, .b44
        {
            font-size: 1px;
            overflow: hidden;
            display: block;
        }

        .b11
        {
            height: 1px;
            background: #AAA;
            margin: 0 5px;
        }

        .b22
        {
            height: 1px;
            background: #c0de98;
            border-right: 2px solid #AAA;
            border-left: 2px solid #AAA;
            margin: 0 3px;
        }

        .b33
        {
            height: 1px;
            background: #c0de98;
            border-right: 1px solid #AAA;
            border-left: 1px solid #AAA;
            margin: 0 2px;
        }

        .b44
        {
            height: 2px;
            background: #c0de98;
            border-right: 1px solid #AAA;
            border-left: 1px solid #AAA;
            margin: 0 1px;
        }

        .contentb2
        {
            background: #c0de98;
            border-right: 1px solid #AAA;
            border-left: 1px solid #AAA;
            word-break: break-all;
            text-align: left;
            font-family: Arial;
        }

        .timeclass
        {
            background: #E9E9E9;
            border-right: 1px solid #AAA;
            border-left: 1px solid #AAA;
            word-break: break-all;
            color: blue;
            text-align: left;
            font-family: Arial;
        }

        .timeclass2
        {
            background: #c0de98;
            border-right: 1px solid #AAA;
            border-left: 1px solid #AAA;
            word-break: break-all;
            color: blue;
            text-align: left;
            font-family: Arial;
        }
    </style>

    <script src="../../js/geturl.js" type="text/javascript"></script>
    <script src="../../../JQuery/jquery-1.5.2.js" type="text/javascript"></script>
    <script src="../../../LangJS/managerGroup_langjs.js" type="text/javascript"></script>
    <script src="../../js/CommValidator.js" type="text/javascript"></script>
    <script type="text/javascript">
        var SMS = window.parent.parent.GetTextByName("SMS", window.parent.parent.useprameters.languagedata);
        var Lang_please_input_shortMessage = window.parent.parent.GetTextByName("Lang_please_input_shortMessage", window.parent.parent.useprameters.languagedata);
        var Lang_shortMessage_include_special_words = window.parent.parent.GetTextByName("Lang_shortMessage_include_special_words", window.parent.parent.useprameters.languagedata);
        var group = window.parent.parent.GetTextByName("Group", window.parent.parent.useprameters.languagedata);
        var member = window.parent.parent.GetTextByName("Members", window.parent.parent.useprameters.languagedata);
        var baseStation = window.parent.parent.GetTextByName("Station", window.parent.parent.useprameters.languagedata);//xzj--20190227--添加基站短信
        var strSendMsg = window.parent.parent.GetTextByName("Lang_send_shortMessage_1", window.parent.parent.useprameters.languagedata);
        var strSendStatusNum = window.parent.parent.GetTextByName("Lang_send_StatusID", window.parent.parent.useprameters.languagedata);
        var lang_plese_input_statusNum = window.parent.parent.GetTextByName("Lang_please_input_statusNum", window.parent.parent.useprameters.languagedata);
        var StatusMessage = window.parent.parent.GetTextByName("Lang_Status_message", window.parent.parent.useprameters.languagedata);
        var messageRestrict = window.parent.parent.GetTextByName("numb4", window.parent.parent.useprameters.languagedata);
        var messageRestrict1 = window.parent.parent.GetTextByName("numb5", window.parent.parent.useprameters.languagedata);
        var messageRestrict2 = window.parent.parent.GetTextByName("numb17", window.parent.parent.useprameters.languagedata);
        var messageRestrict3 = window.parent.parent.GetTextByName("numb18", window.parent.parent.useprameters.languagedata);
        var strSMSType = SMS;
        function Divover(str) {
            var div1 = document.getElementById("divClose");
            if (str == "on") { div1.style.backgroundPosition = "66 0"; }
            else { div1.style.backgroundPosition = "0 0"; }
        }
        $(document).ready(function () {
            if ("<%=smsType%>" == "2") {
                document.getElementById("txtContent").value = strSendStatusNum;
                strSMSType = StatusMessage;
            }
            else {
                document.getElementById("txtContent").value = strSendMsg;
                strSMSType = SMS;
            }
        })
        function CheckContent() {
            if ($("#txtContent").val() == strSendMsg)
                $("#txtContent").val("");
        }

        function sendMSG() {
            var toissi = '<%=toissi%>';
            var myissi = '<%=myissi%>';
            var toname = '<%=toname%>';
            var myname = '<%=myname%>';
            var smsType = '<%=smsType%>';
            var isGroup = '<%=isGroup%>';
            var tt = member;
            var myMemberArray = new Array();
            if (isGroup == "1") {
                tt = group;
            }
            else if (toissi.indexOf("(") != -1) {//xzj--20190227--添加基站短信
                tt = baseStation;
            }
            else {
                tt = member;
            }
            var isconsume = 0;

            myMemberArray.push({ name: toname, issi: toissi, type: tt });
            var messages = document.getElementById("txtContent").value;

            if(messages ==strSendMsg)
            {
                alert(Lang_please_input_shortMessage);//("请输入短信内容");
                return;
            }
            if (messages == strSendStatusNum) {
                alert(lang_plese_input_statusNum);//("请输入状态号");
                return;
            }

            if (messages == ""&& "<%=smsType%>"==2) {
                alert(lang_plese_input_statusNum);//("请输入状态号");
                return;
            }
            if (messages == "") {
                alert(Lang_please_input_shortMessage);//("请输入短信内容");
                return;
            }
            if (!checkMsgContent(messages)) {
                alert(Lang_shortMessage_include_special_words);//("短信内容包含<、>、\\、/等特殊字符");
                return;
            }
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
            var SendContent = "";
            var mes = messages;
            //for (var mui = 1; mui <= pd; mui++) {
            //    var sendmsg = BindSize(mes, 140);
                //TODO需要判断内容中是否含有汉字,含有汉字 就再拆分成70个字符一条  这种方式不太好，有时候本来只需发2条就行了 现在要变成3条了，比较好的方式是判断中文在第几个字符 在小于70  在70到140之间的 等等情况特殊处理
                //if (/.*[\u4e00-\u9fa5]+.*$/.test(sendmsg)) {
                //    var sendmsg1 = BindSize(sendmsg, 70);
                //    if (smsType != 2) {
                //        window.parent.sendMsg(myMemberArray, sendmsg1, isconsume);
                //        SendContent = sendmsg1;
                //    }
                //    else {
                //        window.parent.sendreportnum(myMemberArray, sendmsg1);
                //        SendContent = "STATUS:" + sendmsg1;
                //    }
                //    var data = new Date();
                //    var thistime = data.getFullYear().toString() + "/" + (data.getMonth() + 1).toString() + "/" + data.getDate().toString() + " " + data.getHours().toString() + ":" + data.getMinutes().toString() + ":" + data.getSeconds();

                //    $("#tb1").append("<tr><td Align='right' style='width:200px'><div id='sash_left'><b class='b1'></b><b class='b2'></b><b class='b3'></b><b class='b4'></b><div align='left' class='contentb'><span style='font-size: 14px; color: red;text-decoration-line:underline'><b>" + myname + "(" + myissi + ")[" + strSMSType + "]</b></span>:" + SendContent + "</div><div align='left' class='timeclass'>" + thistime + "</div><b class='b4'></b><b class='b3'></b><b class='b2'></b><b class='b1'></b></div><br></td></tr>");

                //    if (sendmsg1.length != sendmsg.length) {
                //        var sendmsg2 = sendmsg.substring(sendmsg1.length, sendmsg.length);
                //        if (smsType != 2) {
                //            window.parent.sendMsg(myMemberArray, sendmsg2, isconsume);
                //            SendContent = sendmsg2;
                //        }
                //        else {
                //            window.parent.sendreportnum(myMemberArray, sendmsg2);
                //            SendContent ="STATUS:"+ sendmsg2;
                //        }
                //        var data = new Date();
                //        var thistime = data.getFullYear().toString() + "/" + (data.getMonth() + 1).toString() + "/" + data.getDate().toString() + " " + data.getHours().toString() + ":" + data.getMinutes().toString() + ":" + data.getSeconds();

                //        $("#tb1").append("<tr><td Align='right' style='width:200px'><div id='sash_left'><b class='b1'></b><b class='b2'></b><b class='b3'></b><b class='b4'></b><div align='left' class='contentb'><span style='font-size: 14px; color: red;text-decoration-line:underline'><b>" + myname + "(" + myissi + ")[" + strSMSType + "]</b></span>:" + SendContent + "</div><div align='left' class='timeclass'>" + thistime + "</div><b class='b4'></b><b class='b3'></b><b class='b2'></b><b class='b1'></b></div><br></td></tr>");
                //    }

                //    mes = mes.substring(sendmsg.length, mes.length)

                //}
                //else {
                    if (smsType != 2) {
                        window.parent.sendMsg(myMemberArray, mes, isconsume);
                        SendContent = mes;
                    }
                    else {
                        window.parent.sendreportnum(myMemberArray, mes);
                        SendContent = "STATUS:" + mes;
                    }

                    var data = new Date();
                    var thistime = data.getFullYear().toString() + "/" + (data.getMonth() + 1).toString() + "/" + data.getDate().toString() + " " + data.getHours().toString() + ":" + data.getMinutes().toString() + ":" + data.getSeconds();

                    $("#tb1").append("<tr><td Align='right' style='width:200px'><div id='sash_left'><b class='b1'></b><b class='b2'></b><b class='b3'></b><b class='b4'></b><div align='left' class='contentb'><span style='font-size: 14px; color: red;text-decoration-line:underline'><b>" + myname + "(" + myissi + ")[" + strSMSType + "]</b></span>:" + SendContent + "</div><div align='left' class='timeclass'>" + thistime + "</div><b class='b4'></b><b class='b3'></b><b class='b2'></b><b class='b1'></b></div><br></td></tr>");
                    //mes = mes.substring(sendmsg.length, mes.length)
                //}
            //}

            document.getElementById("txtContent").value = "";
            scrollBottom();
        }

        function BindSize(text, size) {
            var x = 0;
            str = text.replace(/[\s\S]/g, function (d, i, s) {
                if (d.charCodeAt(0) > 127) x++;
                if (x + i >= size) return "";
                return d;
            });
            return str;
        }
        function scrollBottom() {
            document.getElementById("div_content").scrollTop = document.getElementById("div_content").scrollHeight;
        }
        function RevMSG(myname, myissi, msg, msgtype) {
          
            var toissi = '<%=toissi%>';
            if (myissi == toissi) {//实时接收消息
                 var data = new Date();
                 var thistime = data.getFullYear().toString() + "/" + (data.getMonth()+1).toString() + "/" + data.getDate().toString() + " " + data.getHours().toString() + ":" + data.getMinutes().toString() + ":" + data.getSeconds();
                 $("#tb1").append("<tr><td Align='left' style='width:200px'><div id='sash_left'><b class='b11'></b><b class='b22'></b><b class='b33'></b><b class='b44'></b><div align='left' class='contentb2'><span style='font-size: 14px; color: red;text-decoration-line:underline'><b>" + myname + "(" + myissi + ")[" + msgtype + "]</b></span>:" + msg + "</div><div align='left' class='timeclass2'>" + thistime + "</div><b class='b44'></b><b class='b33'></b><b class='b22'></b><b class='b11'></b></div><br></td></tr>");
                 scrollBottom();
            }
           
         }
    </script>
</head>
<body>
    <table class="style1" cellpadding="0" cellspacing="0">
        <tr>
            <td class="style2">
                <img src="../../view_infoimg/images/bg_01.png" /></td>
            <td class="bg1">
                <span id="span_title" style="color:blue;font-family:Arial;font-size:18px"><b></b></span>
                <div id="divClose" onmouseover="Divover('on')" onclick="window.parent.mycallfunction('SMS/SMSDetail')" onmouseout="Divover('out')"></div>
            </td>
            <td class="style2">
                <img src="../../view_infoimg/images/bg_04.png" /></td>
        </tr>
        <tr>
            <td class="bg3">&nbsp;</td>
            <td class="bg4" id="dragtd">
                <div id="div_content" align="center" style="width: 100%; height: 250px; overflow: scroll; background-color: #c4f6f0">
                    <table id="tb1" align="center" bgcolor="#c4f6f0" runat="server" border="0" cellpadding="0"
                        cellspacing="1" width="96%">
                    </table>
                </div>
                <table cellpadding="0" cellspacing="0">
                    <tr>
                        <td>
                            <textarea rows="5" onclick="CheckContent()" id="txtContent" style=" width: 265px"></textarea></td>
                        <td>
                            <img onclick="sendMSG()" id="imgSumit" style="cursor: hand;" src="<%--../images/SMSSend.png--%>" /></td>
                    </tr>
                </table>
             </td>
            <td class="bg5">&nbsp;</td>
        </tr>
        <tr>
            <td class="style2">
                <img src="../../view_infoimg/images/bg_09.png" /></td>
            <td class="bg2"></td>
            <td class="style2">
                <img src="../../view_infoimg/images/bg_11.png" /></td>
        </tr>
    </table>
</body>
<script>
    var dragEnable = 'True';
    function dragdiv() {
        var div1 = window.parent.document.getElementById('SMS/SMSDetail');
        window.parent.windowDivOnClick(div1);
        if (div1 && event.button == 0 && dragEnable == 'True') {
            window.parent.mystartDragWindow(div1, null, event); div1.style.border = "solid 0px transparent"; window.parent.cgzindex(div1);

        }
    }
    function mydragWindow() {
        var div1 = window.parent.document.getElementById('SMS/SMSDetail');
        if (div1) {
            window.parent.mydragWindow(div1, event);
        }
    }

    function mystopDragWindow() {
        var div1 = window.parent.document.getElementById('SMS/SMSDetail');
        if (div1) {
            window.parent.mystopDragWindow(div1); div1.style.border = "0px";
        }
    }
    window.onload = function () {
        var toissi = '<%=toissi%>';
       
        var toname = '<%=toname%>';
        window.document.getElementById("span_title").innerHTML = '<B>' + toname + '(' + toissi + ')</B>';

        scrollBottom();
        document.body.onmousedown = function () { dragdiv(); }
        document.body.onmousemove = function () { mydragWindow(); }
        document.body.onmouseup = function () { mystopDragWindow(); }
        document.body.oncontextmenu = function () { return false; }
        document.body.oncontextmenu = function () { return false; }
        var arrayelement = ["input", "a", "select", "li", "font", "textarea"];
        for (n = 0; n < arrayelement.length; n++) {
            var inputs = document.getElementsByTagName(arrayelement[n]);
            for (i = 0; i < inputs.length; i++) {
                inputs[i].onmouseout = function () {
                    dragEnable = 'True';
                }
                inputs[i].onmouseover = function () {
                    dragEnable = 'False';
                }
            }
        }
        var table = document.getElementById("dragtd");
        table.onmouseout = function () {
            dragEnable = 'True';
        }

        table.onmouseover = function () {
            dragEnable = 'False';
        }
    }
    window.parent.lq_changeheight('SMS/SMSDetail', document.body.clientHeight); window.parent.change('SMS/SMSDetail');</script>
</html>
<script>window.parent.closeprossdiv();

    var image1 = window.document.getElementById("imgSumit");
    var srouce1 = "../" + window.parent.parent.GetTextByName("Lang_SMSSend", window.parent.parent.useprameters.languagedata);
    image1.setAttribute("src", srouce1);
</script>
