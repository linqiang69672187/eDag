<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GroupCallPanal.aspx.cs"
    Inherits="Web.lqnew.callPanal.GroupCallPanal" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="../../JQuery/jquery-1.5.2.js" type="text/javascript"></script>
    <script src="../../MyCommonJS/ajax.js" type="text/javascript"></script>
    <link href="../css/lq_addedit.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        .btn {
            border-right: #7b9ebd 1px solid;
            background: linear-gradient(#ffffff, #3C9562); /* 标准的语法 */
            border-right: #7b9ebd 1px solid;
            padding-right: 2px;
            border-top: #7b9ebd 1px solid;
            padding-left: 2px;
            font-size: 12px;
            filter: alpha(opacity=50); /* IE */
            border-left: #7b9ebd 1px solid;
            cursor: pointer;
            color: black;
            padding-top: 2px;
            border-bottom: #7b9ebd 1px solid;
            width: 52px;
            height: 20px;
        }

        .table1 {
            background: linear-gradient(#ffffff, #0072bc); /* 标准的语法 */
            position: relative;
            filter: alpha(opacity=50); /* IE */
            left: 2px;
            width: 270px;
            border-bottom-width: 1px;
            border-bottom-style: inset;
            border-bottom-color: Black;
            border-left-width: 1px;
            border-left-style: inset;
            border-left-color: Black;
            border-top-width: 1px;
            border-top-style: inset;
            border-top-color: Black;
            border-right-width: 1px;
            border-right-style: inset;
            border-right-color: Black;
        }

        .table2 {
            background: linear-gradient(#ffffff, #0072bc); /* 标准的语法 */
            position: relative;
            filter: alpha(opacity=50); /* IE */
            left: 2px;
            width: 270px;
            border-bottom-width: 1px;
            border-bottom-style: inset;
            border-bottom-color: Black;
            border-left-width: 1px;
            border-left-style: inset;
            border-left-color: Black;
            border-top-width: 1px;
            border-top-style: inset;
            border-top-color: Black;
            border-right-width: 1px;
            border-right-style: inset;
            border-right-color: Black;
        }
    </style>
    <script type="text/javascript">
        var vissiList = new Array();

        var tempMuteList = new Array();//全部静音时，原本未静音的组压入此数组

        var showLimit = 30;
        function IsExsit(issi) {
            var mydiv = document.getElementById("div_" + issi);
            if (mydiv) {
                return true;
            } else {
                return false;
            }
        }
        function toRenderHtml(issi, calltype, msg, mytype) {
            //多语言:标识；类型；消息

            var showMsg = msg;
            if (showMsg.length > 18) {
                showMsg = msg.substring(0, 20) + "...";
            }
            var str = "<div id=\"div_" + issi + "\"><table  border=\"0\" cellspacing=\"0\" cellpadding=\"0\" style=\"height:2px\"><tr><td></td></tr></table><table class='table2' onmouseover='addMember(\"" + issi + "\",\"" + calltype + "\",\"" + msg + "\")' ><tr><td align=\"right\">" + window.parent.parent.GetTextByName("Identification", window.parent.parent.useprameters.languagedata) + ":</td><td align=\"left\" style=\"width: 85px\">" + issi + "</td><td>" + window.parent.parent.GetTextByName("Type", window.parent.parent.useprameters.languagedata) + ":</td><td align=\"left\" style=\"width: 85px\">" + calltype + "</td> </tr><tr><td align=\"right\">" + window.parent.parent.GetTextByName("Message", window.parent.parent.useprameters.languagedata) + ":</td> <td align=\"left\" colspan=\"3\" style=\"width: 95px\"><span title=" + msg + " id=\"sp_" + issi + "\">" + showMsg + "</span></td></tr></table></div>";
            if (vissiList.length == 0) {
                $("#maindiv").before(str);
            } else {
                $("#div_" + vissiList[vissiList.length - 1].issi).before(str);
            }
            if (vissiList.length > showLimit) {
                for (var i = 0; i < vissiList.length - showLimit; i++) {
                    removePanalByIssi(vissiList[i].issi);
                }
            }
            vissiList.push({ issi: issi, Cflag: false });
            if (mytype == 1) {
                addMember(issi, calltype, msg);
            }
        }
        function msgToPanal(issi, calltype, msg) {
            $("#noList").css("display", "none");
            if (msg == window.parent.parent.GetTextByName("CC_CALLREQUEST", window.parent.parent.useprameters.languagedata)) {//多语言:有呼叫请求进入
                if (IsExsit(issi)) {
                    var myflag = false;
                    if (document.getElementById("tdp_" + issi) != null) {
                        myflag = true;
                    }
                    removePanalByIssi(issi); //移除原来的
                    if (myflag) {
                        toRenderHtml(issi, calltype, msg, 1); //添加新的
                    } else {
                        toRenderHtml(issi, calltype, msg, 0); //添加新的
                    }
                } else {
                    toRenderHtml(issi, calltype, msg, 0); //添加新的
                }
            } else {
                var mydiv = document.getElementById("div_" + issi);
                if (mydiv) {
                    return;
                }
                toRenderHtml(issi, calltype, msg, 0);
            }
        }

        function CALLEND(Gissi) {

            /**让调度台结束终端发起的
            if (!flag) {
                alert(Lang_havenot_start_call_failure);
                return;
            }
            */
            flag = false;
            isCallGssi = "";
            var iscall = parent.parent.endGC2(Gissi);
            //document.getElementById('divstatue').innerHTML = Lang_CallEnd;
            if (iscall == 0) {
                //$("#divstatue").html(Lang_havenot_start_call_failure); //("结束组呼失败");
                //$("#divstatue").html(Lang_Ending_group_calling_failure); //("结束组呼失败");
                return;
            }
            else {
                document.getElementById("btnGroupEndCall_" + Gissi).disabled = true;
            }
            //document.getElementById("imgSelectUser").style.display = "block";

        }

        //页面最多只能添加10个呼叫，当呼叫结束后自动从页面已除
        //要让最新上来的放在最前面，每次上来后需要重新加载，假如存在处理的，改用啥方案
        function addMember(issi, calltype, msg) {
            msg = $("#sp_" + issi).html();
            var mydiv = document.getElementById("div_" + issi);
            if (mydiv) {
                var username = ""; //去异步查询数据库
                var entity = "";
                getNewData_ajax("../../Handlers/GetGroupInfo_Handler.ashx", { giis: issi }, function (msgs) {
                    var mydd = eval(msgs);
                    if (mydd.length > 0) {
                        username = mydd[0].groupname;
                        entity = mydd[0].entityname;

                        if (username == undefined) {
                            username = window.parent.parent.GetTextByName("Unkown", window.parent.parent.useprameters.languagedata);
                        }
                        if (entity == undefined) {
                            entity = window.parent.parent.GetTextByName("Unkown", window.parent.parent.useprameters.languagedata);
                        }
                        //多语言:标识;类型;姓名;单位;消息;关闭
                        var showMsg = msg;
                        if (showMsg.length > 20) {
                            showMsg = msg.substring(0, 20) + "...";
                        }
                        var showEntity = entity;
                        if (showEntity.length > 4) {
                            showEntity = entity.substring(0, 4) + "...";
                        }
                    }
                    var str = "<table  border=\"0\" cellspacing=\"0\" cellpadding=\"0\" style=\"height:2px\"><tr><td></td></tr></table><table class='table1'><tr><td align=\"right\">" + window.parent.parent.GetTextByName("Identification", window.parent.parent.useprameters.languagedata) + ":</td><td align=\"left\" style=\"width: 85px\">" + issi + "</td><td>" + window.parent.parent.GetTextByName("Type", window.parent.parent.useprameters.languagedata) + ":</td><td align=\"left\" style=\"width: 85px\">" + calltype + "</td> </tr><tr id=\"tdp_" + issi + "\"><td align=\"right\">" + window.parent.parent.GetTextByName("Username", window.parent.parent.useprameters.languagedata) + ":</td><td align=\"left\" style=\"width: 85px\">" + username + "</td><td>" + window.parent.parent.GetTextByName("Unit", window.parent.parent.useprameters.languagedata) + ":</td><td title=" + entity + " align=\"left\" style=\"width: 85px\">" + showEntity + "</td> </tr><tr><td align=\"right\">" + window.parent.parent.GetTextByName("Message", window.parent.parent.useprameters.languagedata) + ":</td> <td align=\"left\" colspan=\"3\" style=\"width: 95px\"><span title=" + msg + " id=\"sp_" + issi + "\">" + showMsg
                        + "</span></td></tr><tr> <td align=\"right\" colspan=\"3\" ><input onmouseout=\"lostFocus('btnppt_" + issi + "')\" id=\"btnppt_" + issi + "\" type=\"button\" class=\"btn\"  onmouseup=\"caset(" + issi + ")\" onmousedown=\"RevCall(" + issi + ")\" onkeypress=\"keyPress(" + issi + ")\" onkeyup=\"keyUp(" + issi
                        + ");\" value=\"PTT\" />&nbsp;&nbsp;<input type=\"button\" class=\"btn\"   onclick=\"CloseCallPanal(" + issi + ")\" value=\"" + window.parent.parent.GetTextByName("Closebtn", window.parent.parent.useprameters.languagedata)
                        + "\" />&nbsp;&nbsp;<input type=\"button\" class=\"btn\" id=\"btnGroupEndCall_" + issi + "\"   onclick=\"CALLEND(" + issi + ")\" value=\"" + window.parent.parent.GetTextByName("hangsup", window.parent.parent.useprameters.languagedata) + "\" /></td>";
                    if (!isMute(issi)) {
                        str += "<td  style=\"width:20px;padding-left:15px;\"><img id='voiceImg_" + issi + "' style='cursor:pointer' src='../img/loud.png' onclick = 'changeVoiceAndPictureAndVar(" + issi + ");'/></td>";
                    }
                    else {
                        str += "<td  style=\"width:20px;;padding-left:15px;\"><img id='voiceImg_" + issi + "' style='cursor:pointer' src='../img/mute.png' onclick = 'changeVoiceAndPictureAndVar(" + issi + ");'/></td>";
                    }
                    str += "</tr></table>";
                    $("#div_" + issi).html(str);
                });
            }

        }

        function ChangeMsgByGssi(gssi, issi, msg) {
            //document.getElementById('sp_' + gssi).title = issi + ":" + msg;
            $("#sp_" + gssi).attr("title", issi + ":" + msg)
            if (msg.length > 20) {
                msg = msg.substring(0, 20) + "...";
            }
            document.getElementById('sp_' + gssi).innerHTML = issi + ":" + msg;
        }

        function CloseCallPanal(issi) {
            if (confirm(window.parent.parent.GetTextByName("Confirm_AreYouSureToCloseUpCallPanel", window.parent.parent.useprameters.languagedata))) {//多语言:确定要关闭此呼叫上行面板吗?
                //var iscall = window.parent.parent.endGC2(issi);
                //var Lang_Ending_group_calling_failure = window.parent.parent.GetTextByName("Lang_Ending_group_calling_failure", window.parent.parent.useprameters.languagedata);
                //if (iscall == 0) {
                //    $("#divstatue").html(Lang_Ending_group_calling_failure); //("结束组呼失败");
                //    return;
                //}
                removePanalByIssi(issi);
                if (vissiList.length == 0) {
                    $("#noList").css("display", "block");
                }
                window.parent.parent.mainSwfFocus();
            }
        }

        //根据issi号码删除相应的div 
        function removePanalByIssi(issi) {
            $("#div_" + issi).remove();
            var tempArray = new Array();
            for (var i = 0; i < vissiList.length; i++) {
                if (vissiList[i].issi.toString() != issi.toString()) {
                    tempArray.push(vissiList[i]);
                }
            }
            vissiList.length = 0;
            for (var i = 0; i < tempArray.length; i++) {
                vissiList.push(tempArray[i]);
            }
        }


        function keyPress(issi) {
            if (event.keyCode == 32) {
                RevCall(issi);
            }
        }
        function keyUp(issi) {
            if (event.keyCode == 32) {
                caset(issi);
            }
        }
        //ppt
        function RevCall(issi) {
            var isEncryption = "0";//xzj--20190320--添加呼叫加密参数
            if (window.parent.parent.useprameters.CallEncryption.indexOf("Single") >= 0) {
                isEncryption = "1";
            }
            var result = window.parent.parent.startGC2(issi, isEncryption);
            if (result == 1) {
                document.getElementById("btnGroupEndCall_" + issi).disabled = false;
            }
            window.parent.parent.mainSwfFocus();


        }

        function lostFocus(id) {
            //alert(id);
            //document.getElementById(id).blur();
            //window.parent.parent.mainSwfFocus();

        }

        function caset(issi) {
            window.parent.parent.gceasedPTT2(issi);
            document.getElementById("btnppt_" + issi).blur();
            window.parent.parent.mainSwfFocus();

        }
        $(document).ready(function () {
            RendGroupCallPanalLang();
            document.body.oncontextmenu = function () { return false; };
        });

        function RendGroupCallPanalLang() {
            //多语言:暂无上行普通组呼记录!
            $("#HasNoCallRecord").html(window.parent.parent.GetTextByName("HasNoCallRecord", window.parent.parent.useprameters.languagedata));
        }

        function changeVoiceAndPictureAndVar(issi) {
            var isMuted = isMute(issi);
            if (isMuted) {
                //打开声音
                var reVal = changeVoiceByGroupISSI(issi, 100);
                if (reVal == 1) {
                    document.getElementById("voiceImg_" + issi).src = "../img/loud.png";
                    removeFromMuteList(issi);
                }
                else if (reVal == 0) {
                    alert(Operationfails);
                }
            }
            else {
                //关闭声音
                var reVal = changeVoiceByGroupISSI(issi, 0);
                if (reVal == 1) {
                    document.getElementById("voiceImg_" + issi).src = "../img/mute.png";
                    addToMuteList(issi);
                }
                else if (reVal == 0) {
                    alert(Operationfails);
                }
            }
        }
        function isMute(issi) {
            var isMuted = false;
            if (getisAllMute() == true) {
                isMuted = true;
            }
            else {
                for (var i = 0; i < getmuteList().length; i++) {
                    if (getmuteList()[i] == issi) {
                        isMuted = true;
                        break;
                    }
                }
            }
            return isMuted;
        }
        function removeFromMuteList(issi) {
            for (var i = 0; i < getmuteList().length; i++) {
                if (getmuteList()[i] == issi) {
                    splicemuteList(i);
                }
            }
        }
        function addToMuteList(issi) {
            if (notInMuteList(issi)) {
                addmuteList(issi);
            }
        }
        function notInMuteList(issi) {
            var notIn = true;
            for (var i = 0; i < getmuteList().length; i++) {
                if (getmuteList()[i] == issi) {
                    notIn = false;
                }
            }
            return notIn;
        }
        function changeVoiceByGroupISSI(issi, voice) {
            var reVal = -1;
            var scactionX = window.parent.parent.document.frames['log_windows_ifr'].document.getElementById('SCactionX');
            if (scactionX) {
                try {
                    if (voice == 0) {
                        //关闭声音
                        reVal = scactionX.VolumeControl(4, issi, 0);
                    }
                    else if (voice > 0 && voice <= 100) {
                        //打开声音
                        if (getisAllMute()) {
                            //如果已经全部静音，先打开全部音量
                            var reValAllVoice = changeAllVoice();
                            if (reValAllVoice == 1) {
                                changeisAllMuteVar();
                                changeallVoiveImgPicture();
                                pushTempMuteListToMuteList();
                                reVal = scactionX.VolumeControl(4, issi, 100);
                            }
                            else if (reValAllVoice == 0) {
                                reVal = 0;
                            }
                        }
                        else {
                            //如果没有全部静音，直接开启该组音量
                            reVal = scactionX.VolumeControl(4, issi, 100);
                        }
                    }
                }
                catch (ex) {
                    reVal = 0;
                    //alert(ex.message);
                }
            }
            else {
                alert(checkcallcontrolregister);
            }
            return reVal;
        }
        function pushTempMuteListToMuteList() {
            for (var i = 0; i < tempMuteList.length; i++) {
                addmuteList(tempMuteList[i]);
            }
        }
        var checkcallcontrolregister = window.parent.parent.GetTextByName("checkcallcontrolregister", window.parent.parent.useprameters.languagedata);//请检查呼叫控件是否正确安装
        var Operationfails = window.parent.parent.GetTextByName("Operationfails", window.parent.parent.useprameters.languagedata);//操作失败

        function changeAllVoiceAndPicture() {
            var reVal = changeAllVoice();
            if (reVal == 1) {
                changeisAllMuteVar();
                changeallVoiveImgPicture();
                checkAllGroupcallVoicePicture();
            }
            else if (reVal == 0) {
                alert(Operationfails);
            }
        }
        function changeisAllMuteVar() {
            if (getisAllMute()) {
                setisAllMute(false);
            }
            else {
                setisAllMute(true);
            }
        }
        function changeallVoiveImgPicture() {
            if (getisAllMute()) {
                window.parent.document.getElementById("allVoiveImg").src = "../img/mute.png";
            }
            else {
                window.parent.document.getElementById("allVoiveImg").src = "../img/loud.png";
            }
        }
        function changeAllVoice() {
            var reVal = -1;
            var scactionX = window.parent.parent.frames['log_windows_ifr'].document.getElementById('SCactionX');
            if (scactionX) {
                try {
                    if (getisAllMute()) {
                        //打开所有声音
                        reVal = scactionX.VolumeControl(2, 0, 0);
                    }
                    else {
                        //关闭所有声音
                        reVal = scactionX.VolumeControl(1, 0, 0);
                    }
                }
                catch (ex) {
                    reVal = 0;
                    //alert(ex.message);
                }
            }
            else {
                alert(checkcallcontrolregister);
            }
            return reVal;
        }
        function checkAllGroupcallVoicePicture() {
            var groupcallPictures = $("[id^=voiceImg_]");
            if (getisAllMute()) {
                //按下全部静音按钮
                tempMuteList.length = 0;
                for (var i = 0; i < groupcallPictures.length; i++) {
                    if (groupcallPictures[i].src.indexOf("loud") > 0) {
                        groupcallPictures[i].src = "../img/mute.png";
                        tempMuteList.push(groupcallPictures[i].id.split('_')[1]);
                    }
                }
            }
            else {
                //按下取消全部静音按钮
                tempMuteList.length = 0;
                for (var i = 0; i < groupcallPictures.length; i++) {
                    if (notInMuteList(groupcallPictures[i].id.split('_')[1])) {
                        groupcallPictures[i].src = "../img/loud.png";
                    }
                }
            }
        }
        function getisAllMute() {
            return window.parent.parent.useprameters.isAllMute;
        }
        function setisAllMute(isAllMute) {
            window.parent.parent.useprameters.isAllMute = isAllMute;
        }
        function getmuteList() {
            return window.parent.parent.useprameters.muteGroupList;
        }
        function addmuteList(GSSI) {
            window.parent.parent.useprameters.muteGroupList.push(GSSI);
        }
        function splicemuteList(i) {
            window.parent.parent.useprameters.muteGroupList.splice(i, 1);
        }
        function tongbumuteGroupListtothispagepicture() {
            var groupcallPictures = $("[id^=voiceImg_]");
            for (var i = 0; i < groupcallPictures.length; i++) {
                var isThisGSSIMuted = false;
                for (var j = 0; j < getmuteList().length; j++) {
                    if (groupcallPictures[i].id.split('_')[1] == getmuteList()[j]) {
                        groupcallPictures[i].src = "../img/mute.png";
                        isThisGSSIMuted = true;
                    }
                }
                if (!isThisGSSIMuted) {
                    groupcallPictures[i].src = "../img/loud.png";
                }
            }
        }
        function tongbuvoiceImgByGSSI(GSSI, isMute) {
            try {
                var voiceImg = document.getElementById("voiceImg_" + GSSI);
                if (voiceImg) {
                    if (isMute) {
                        voiceImg.src = "../img/mute.png";
                    }
                    else {
                        if (getisAllMute()) {
                            //如果已经全部静音，先打开全部音量
                            var reValAllVoice = changeAllVoice();
                            if (reValAllVoice == 1) {
                                changeisAllMuteVar();
                                changeallVoiveImgPicture();
                                pushTempMuteListToMuteList();
                                voiceImg.src = "../img/loud.png";
                            }
                            else if (reValAllVoice == 0) {

                            }
                        }
                        else {
                            voiceImg.src = "../img/loud.png";
                        }

                    }
                }
            }
            catch (e) { }
        }
    </script>
</head>
<body style="background-color: White">
    <form id="form1" runat="server">
        <div id="maindiv" style="z-index: 1999">
        </div>
        <div id="test" style="top: 0; left: 0; width: 100%; height: 100%; z-index: 0">
            <center id="noList">
                <br />
                <br />
                <br />
                <%-- <img src="../../Images/sorry.gif" />--%>
                <p></p>
                <p id="HasNoCallRecord">
                </p>
            </center>
        </div>
    </form>
</body>
</html>
