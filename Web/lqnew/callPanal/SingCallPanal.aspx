<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SingCallPanal.aspx.cs"
    Inherits="Web.lqnew.callPanal.SingCallPanal" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="../../JQuery/jquery-1.5.2.js" type="text/javascript"></script>
    <script src="../../MyCommonJS/ajax.js" type="text/javascript"></script>
    <link href="../css/lq_addedit.css" rel="stylesheet" type="text/css" />
    <script src="../js/GlobalConst.js" type="text/javascript"></script>
    <script src="../js/commonJS.js" type="text/javascript"></script>

    <style type="text/css">
        .btn {
            border-right: #7b9ebd 1px solid;
            padding-right: 2px;
            border-top: #7b9ebd 1px solid;
            padding-left: 2px;
            font-size: 12px;
            background: linear-gradient(#ffffff, #3C9562);
            filter: alpha(opacity=50);
            border-left: #7b9ebd 1px solid;
            cursor: pointer;
            color: black;
            padding-top: 2px;
            border-bottom: #7b9ebd 1px solid;
            width: 52px;
            height: 20px;
        }

        .ppcTable1 {
            position: relative;
            background: linear-gradient(#ffffff, red);
            filter: alpha(opacity=50);
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
            border-top-color: red;
            border-right-width: 1px;
            border-right-style: inset;
            border-right-color: Black;
        }

        .ppcTable2 {
            position: relative;
            left: 2px;
            width: 270px;
            border-bottom-width: 1px;
            border-bottom-style: inset;
            background: linear-gradient(#ffffff, red);
            filter: alpha(opacity=50);
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

        .ppcTable3 {
            position: relative;
            left: 2px;
            width: 270px;
            border-bottom-width: 1px;
            border-bottom-style: inset;
            background: linear-gradient(#ffffff, #yellow);
            filter: alpha(opacity=50);
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

        .table1 {
            position: relative;
            left: 2px;
            background: linear-gradient(#ffffff, #0072bc);
            filter: alpha(opacity=50);
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
            position: relative;
            left: 2px;
            background: linear-gradient(#ffffff, #0072bc);
            filter: alpha(opacity=50);
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
        /*<%--普通呼叫已处理的--%>*/
        .table3 {
            position: relative;
            left: 2px;
            background: linear-gradient(#ffffff, #DDFFDD);
            filter: alpha(opacity=50);
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
        $(document).ready(function () {
            RendGroupCallPanalLang();
            document.body.oncontextmenu = function () { return false; };
        });
        var callingType = new Array(); //正在呼叫的类型 数组 主要用于正在处理的面板超过制定长度后也不能删除
        var vissiList = new Array(); //可以判断未接
        var showLimit = 14;
        var unRevList = new Array(); //未接列表

        function addCallingType(issi, ctype) {
            if (callingType.length > 0) {
                for (var i = 0; i < callingType.length; i++) {
                    if (callingType[i].issi.toString() == issi.toString() && callingType[i].ctype.toString() == ctype.toString()) {
                    } else {
                        callingType.push({ issi: issi, ctype: ctype });
                    }
                }
            } else {
                callingType.push({ issi: issi, ctype: ctype });
            }
        }
        function removeCallingtype(issi, ctype) {
            var tempArray = new Array();
            for (var i = 0; i < callingType.length; i++) {
                if (callingType[i].issi.toString() == issi.toString() && callingType[i].ctype.toString() == ctype.toString()) {
                } else {
                    tempArray.push(callingType[i]);
                }
            }
            callingType.length = 0;
            for (var i = 0; i < tempArray.length; i++) {
                callingType.push(tempArray[i]);
            }

        }

        function toRenderHtml(issi, calltype, msg, mytype) {
            var ctype = "00";
            var divName = "div_" + issi;
            var tableName = "table_" + issi;
            var spanName = "sp_" + issi;
            var imgName = "img_" + issi;

            if (calltype == window.parent.parent.GetTextByName("NormalHalfSingleCall", window.parent.parent.useprameters.languagedata)) {//多语言:普通半双工单呼

                ctype = "00";
                divName = "div00_" + issi;
                tableName = "table00_" + issi;
                spanName = "sp00_" + issi;
                imgName = "img00_" + issi;
            }
            else if (calltype == window.parent.parent.GetTextByName("NormalAllSingleCall", window.parent.parent.useprameters.languagedata)) {//多语言:普通全双工单呼

                ctype = "01";
                divName = "div01_" + issi;
                tableName = "table01_" + issi;
                spanName = "sp01_" + issi;
                imgName = "img01_" + issi;
            }
            else if (calltype == window.parent.parent.GetTextByName("EmergencyHalfSingleCall", window.parent.parent.useprameters.languagedata)) {//多语言:紧急半双工单呼

                ctype = "10";
                divName = "div10_" + issi;
                tableName = "table10_" + issi;
                spanName = "sp10_" + issi;
                imgName = "img10_" + issi;
            }
            else if (calltype == window.parent.parent.GetTextByName("EmergencyAllSingleCall", window.parent.parent.useprameters.languagedata)) {//多语言:紧急全双工单呼

                ctype = "11";
                divName = "div11_" + issi;
                tableName = "table11_" + issi;
                spanName = "sp11_" + issi;
                imgName = "img11_" + issi;
            }

            var strClass = "table2";

            if (calltype == window.parent.parent.GetTextByName("EmergencyHalfSingleCall", window.parent.parent.useprameters.languagedata) || calltype == window.parent.parent.GetTextByName("EmergencyAllSingleCall", window.parent.parent.useprameters.languagedata)) {//多语言:紧急半双工单呼;紧急全双工单呼

                strClass = "ppcTable2";
            }

            var picUrl = strUpCallComingPicUrl;

            var str = "<div id=\"" + divName + "\"><table border=\"0\" cellspacing=\"0\" cellpadding=\"0\" style=\"height:2px\"><tr><td></td></tr></table><table id=\"" + tableName + "\"  class='" + strClass + "' onmouseover='ToAddMember(\"" + issi + "\",\"" + calltype + "\",\"" + msg + "\",\"" + ctype + "\")' ><tr><td align=\"right\">" + window.parent.parent.GetTextByName("Identification", window.parent.parent.useprameters.languagedata) + ":</td><td align=\"left\" style=\"width: 85px\">" + issi + "</td><td>" + window.parent.parent.GetTextByName("Type", window.parent.parent.useprameters.languagedata) + ":</td><td align=\"left\" style=\"width: 85px\">" + calltype + "</td> </tr><tr><td style='height:20px' align=\"right\">" + window.parent.parent.GetTextByName("Message", window.parent.parent.useprameters.languagedata) + ":</td> <td align=\"left\" colspan=\"3\" style=\"width: 95px\"><img id=\"" + imgName + "\" src=\"" + picUrl + "\" />&nbsp;<span id=\"" + spanName + "\">" + msg + "</span><span style=\"display:none\" id=\"hid_" + spanName + "\">" + msg + "</span></td></tr></table></div>";

            //正在呼叫的放最前面

            if (vissiList.length == 0) {
                $("#maindiv").before(str);
            }
            else {
                $("#div" + vissiList[vissiList.length - 1].ctype + "_" + vissiList[vissiList.length - 1].issi).before(str);
            }

            if (vissiList.length > showLimit) {
                for (var i = 0; i < vissiList.length - showLimit; i++) {
                    var canDelete = false;
                    for (var p = 0; p < callingType.length; p++) {
                        if (vissiList[i].issi.toString() == callingType[p].issi.toString() && callingType[p].ctype.toString() == ctype.toString()) {
                            canDelete = true;
                        }
                    }
                    if (!canDelete) {
                        removePanalByIssi(vissiList[i].issi, vissiList[i].ctype); //正在呼叫的不能别移除 也就是正在呼叫的最好放顶端
                    }
                }
            }

            vissiList.push({ issi: issi, Cflag: false, ctype: ctype });

            if (mytype == 1) {
                ToAddMember(issi, calltype, msg, ctype);
            }
        }
        function msgToPanal(issi, calltype, msg) {
            $("#noList").css("display", "none");

            var divName = "div_" + issi;
            var tdpName = "tdp_" + issi;
            var ctype = "00";

            //将switch改为if
            if (calltype == window.parent.parent.GetTextByName("NormalHalfSingleCall", window.parent.parent.useprameters.languagedata)) {//多语言:普通半双工单呼
                divName = "div00_" + issi;
                tdpName = "tdp00_" + issi;
                ctype = "00";
            }
            else if (calltype == window.parent.parent.GetTextByName("NormalAllSingleCall", window.parent.parent.useprameters.languagedata)) {//多语言:普通全双工单呼
                divName = "div01_" + issi;
                tdpName = "tdp01_" + issi;
                ctype = "01";
            }
            else if (calltype == window.parent.parent.GetTextByName("EmergencyHalfSingleCall", window.parent.parent.useprameters.languagedata)) {//多语言:紧急半双工单呼
                divName = "div10_" + issi;
                tdpName = "tdp10_" + issi;
                ctype = "10";
            }
            else if (calltype == window.parent.parent.GetTextByName("EmergencyAllSingleCall", window.parent.parent.useprameters.languagedata)) {//多语言:紧急全双工单呼
                divName = "div11_" + issi;
                tdpName = "tdp11_" + issi;
                ctype = "11";
            }

            if (msg == window.parent.parent.GetTextByName("CC_CALLREQUEST", window.parent.parent.useprameters.languagedata)) {//有呼叫请求进入的 按时间排名,原来有的也需要跳到第一位 多语言:有呼叫请求进入

                var mydiv = document.getElementById(divName);
                if (mydiv) {
                    var myflag = false;
                    if (document.getElementById(tdpName) != null) {
                        myflag = true;
                    }
                    removePanalByIssi(issi, ctype); //移除原来的 同时删除闪烁
                    if (myflag) {
                        toRenderHtml(issi, calltype, msg, 1); //添加新的
                    } else {
                        toRenderHtml(issi, calltype, msg, 0); //添加新的
                    }

                } else {
                    toRenderHtml(issi, calltype, msg, 0); //添加新的
                }
                window.parent.SingCallComeOn();
            }
            else {
                var mydiv = document.getElementById(divName);
                if (mydiv) {
                    return;
                }
                toRenderHtml(issi, calltype, msg, 0);
            }
        }

        function ToAddMember(issi, calltype, msg, ctype) {
            setTimeout(function () {
                addMember(issi, calltype, msg, ctype);
            }, 100);//防止按钮等还未初始化完成 消息就进来了
        }
        //页面最多只能添加10个呼叫，当呼叫结束后自动从页面已除
        //要让最新上来的放在最前面，每次上来后需要重新加载，假如存在处理的，改用啥方案
        function addMember(issi, calltype, msg, ctype) {
            msg = $("#sp" + ctype + "_" + issi).html();
            var yuanMSG = $("#hid_sp" + ctype + "_" + issi).html();
            var showMsg = msg;
            if (msg.length > 20) {
                //showMsg = msg.substring(0, 20) + "...";
            }

            var mydiv = document.getElementById("div" + ctype + "_" + issi);
            if (mydiv) {
                getNewData_ajax("../../Handlers/GetUserInfo_Handler.ashx", { issi: issi }, function (msgs) {
                    var mydd = eval(msgs);
                    //alert(mydd.length);
                    var username = ""; //去异步查询数据库
                    var entity = "";

                    var picUrl = strUpCallComingPicUrl;
                    if (mydd.length > 0) {
                        username = mydd[0].nam;
                        entity = mydd[0].entity;

                        if (username == undefined) {
                            username = window.parent.parent.GetTextByName("Unkown", window.parent.parent.useprameters.languagedata);
                        }
                        if (entity == undefined) {
                            entity = window.parent.parent.GetTextByName("Unkown", window.parent.parent.useprameters.languagedata);
                        }
                        var showEntity = entity;
                        if (showEntity.length > 4) {
                            showEntity = entity.substring(0, 4) + "...";
                        }
                    }
                    var str = "<table border=\"0\" cellspacing=\"0\" cellpadding=\"0\" style=\"height:2px\"><tr><td></td></tr></table>";

                    if (calltype == window.parent.parent.GetTextByName("NormalHalfSingleCall", window.parent.parent.useprameters.languagedata)) {//多语言:普通半双工单呼
                        var btnppcbegptt_show = "block";
                        var btnppcptt_show = "none";
                        if (yuanMSG.indexOf(window.parent.parent.GetTextByName("CC_CALLREQUEST", window.parent.parent.useprameters.languagedata)) >= 0) {//多语言:有呼叫请求进入
                            picUrl = strUpCallComingPicUrl;
                        } else {
                            btnppcbegptt_show = "none";
                            btnppcptt_show = "block";
                            picUrl = strUpCallingPicUrl;
                        }

                        var btnbegpttname = window.parent.parent.GetTextByName("Toanswer", window.parent.parent.useprameters.languagedata);//多语言:接听
                        var btndisabled = "";
                        var btnClose = "";
                        if (yuanMSG.indexOf(window.parent.parent.GetTextByName("CC_RELEASE", window.parent.parent.useprameters.languagedata)) >= 0 || msg.indexOf(window.parent.parent.GetTextByName("Call_Div_UnReceiveCall", window.parent.parent.useprameters.languagedata)) >= 0) {//多语言:对方挂断;未接
                            btnppcbegptt_show = "block";
                            btnppcptt_show = "none";
                            btnbegpttname = window.parent.parent.GetTextByName("Called", window.parent.parent.useprameters.languagedata);//多语言:呼叫
                            btndisabled = "disabled=disabled";
                        } else {
                            btnClose = "disabled=disabled";
                        }
                        var cssclass = "table1";
                        if (yuanMSG.indexOf(window.parent.parent.GetTextByName("CC_RELEASE", window.parent.parent.useprameters.languagedata)) >= 0) {//多语言:对方挂断
                            cssclass = "table3";
                            picUrl = strUpCallEndCallPicUrl;
                        }
                        if (yuanMSG.indexOf(window.parent.parent.GetTextByName("Call_Div_UnReceiveCall", window.parent.parent.useprameters.languagedata)) >= 0) {//多语言:未接
                            picUrl = strUpCallUnRevPicUrl;
                        }
                        str += "<table id=\"table00_" + issi + "\"   class='" + cssclass + "'><tr><td align=\"right\">" + window.parent.parent.GetTextByName("Identification", window.parent.parent.useprameters.languagedata) + ":</td><td align=\"left\" style=\"width: 85px\">" + issi + "</td><td>" + window.parent.parent.GetTextByName("Type", window.parent.parent.useprameters.languagedata) + ":</td><td align=\"left\" style=\"width: 85px\">" + calltype + "</td> </tr><tr id=\"tdp" + ctype + "_" + issi + "\"><td align=\"right\">" + window.parent.parent.GetTextByName("Username", window.parent.parent.useprameters.languagedata) + ":</td><td align=\"left\" style=\"width: 85px\">" + username + "</td><td>" + window.parent.parent.GetTextByName("Unit", window.parent.parent.useprameters.languagedata) + ":</td><td align=\"left\" title=\"" + entity + "\" style=\"width: 85px\">" + showEntity + "</td> </tr><tr><td style='height:20px' align=\"right\">" + window.parent.parent.GetTextByName("Message", window.parent.parent.useprameters.languagedata) + ":</td> <td align=\"left\" colspan=\"3\" style=\"width: 95px\"><img id=\"img00_" + issi + "\" src=\"" + picUrl + "\" />&nbsp;<span  id=\"sp" + ctype + "_" + issi + "\">" + showMsg + "</span><span style=\"display:none\"  id=\"hid_sp" + ctype + "_" + issi + "\">" + yuanMSG + "</span></td></tr><tr> <td align=\"right\" colspan=\"2\"><input id=\"btnbegptt_" + issi + "\" type=\"button\" style=\"display:" + btnppcbegptt_show + "\" class=\"btn\" onclick=\"begHalfSingCall(" + issi + ")\" value=\"" + btnbegpttname + "\" /><input id=\"btnptt_" + issi + "\" type=\"button\" style=\"display:" + btnppcptt_show + "\" class=\"btn\"  onmouseup=\"CEASEDSCALL(" + issi + ")\" onmousedown=\"halfSingCall(" + issi + ")\" onkeypress=\"keyPress(" + issi + ")\" onkeyup=\"keyUp(" + issi + ");\" value=\"PTT\" /></td><td align=\"left\" colspan=\"2\"><input id=\"btnendptt_" + issi + "\" type=\"button\" class=\"btn\" " + btndisabled + "  onclick=\"EndhalfSingCall(" + issi + ")\" value=\"" + window.parent.parent.GetTextByName("hangsup", window.parent.parent.useprameters.languagedata) + "\" />&nbsp;&nbsp;<input  id=\"btnclose00_" + issi + "\"  type=\"button\" class=\"btn\" " + btnClose + " onclick=\"CloseCallPanal(" + issi + ",'00')\" value=\"" + window.parent.parent.GetTextByName("Closebtn", window.parent.parent.useprameters.languagedata) + "\" /></td></tr></table>";
                        $("#div00_" + issi).html(str);
                    }
                    else if (calltype == window.parent.parent.GetTextByName("NormalAllSingleCall", window.parent.parent.useprameters.languagedata)) {//多语言:普通全双工单呼
                        var btndisabled = "";
                        var vclosedisable = "";
                        var btnbegpttname = window.parent.parent.GetTextByName("Toanswer", window.parent.parent.useprameters.languagedata);//多语言:接听
                        if (yuanMSG.indexOf(window.parent.parent.GetTextByName("CC_RELEASE", window.parent.parent.useprameters.languagedata)) >= 0 || msg.indexOf(window.parent.parent.GetTextByName("Call_Div_UnReceiveCall", window.parent.parent.useprameters.languagedata)) >= 0) {//多语言:对方挂断；未接
                            btndisabled = "disabled=disabled";
                            btnbegpttname = window.parent.parent.GetTextByName("Called", window.parent.parent.useprameters.languagedata);//多语言:呼叫
                        } else {
                            vclosedisable = "disabled=disabled";
                        }
                        var cssclass = "table1";
                        if (yuanMSG.indexOf(window.parent.parent.GetTextByName("CC_RELEASE", window.parent.parent.useprameters.languagedata)) >= 0) {//多语言:对方挂断
                            cssclass = "table3";
                            picUrl = strUpCallEndCallPicUrl;
                        }


                        var vrevdisable = "";
                        if (yuanMSG.indexOf(window.parent.parent.GetTextByName("CC_CONNECTACK", window.parent.parent.useprameters.languagedata)) >= 0) {//多语言:呼叫已连接
                            btndisabled = "";

                            vrevdisable = "disabled=disabled";
                            picUrl = strUpCallingPicUrl;
                        }
                        if (yuanMSG.indexOf(window.parent.parent.GetTextByName("Call_Div_UnReceiveCall", window.parent.parent.useprameters.languagedata)) >= 0) {//多语言:未接
                            picUrl = strUpCallUnRevPicUrl;
                        }
                        if (yuanMSG.indexOf(window.parent.parent.GetTextByName("CC_CALLREQUEST", window.parent.parent.useprameters.languagedata)) >= 0) {//多语言:有呼叫请求进入
                            picUrl = strUpCallComingPicUrl;
                        }

                        str += "<table id=\"table01_" + issi + "\"   class='" + cssclass + "'><tr><td align=\"right\">" + window.parent.parent.GetTextByName("Identification", window.parent.parent.useprameters.languagedata) + ":</td><td align=\"left\" style=\"width: 85px\">" + issi + "</td><td>" + window.parent.parent.GetTextByName("Type", window.parent.parent.useprameters.languagedata) + ":</td><td align=\"left\" style=\"width: 85px\">" + calltype + "</td> </tr><tr id=\"tdp" + ctype + "_" + issi + "\"><td align=\"right\">" + window.parent.parent.GetTextByName("Username", window.parent.parent.useprameters.languagedata) + ":</td><td align=\"left\" style=\"width: 85px\">" + username + "</td><td>" + window.parent.parent.GetTextByName("Unit", window.parent.parent.useprameters.languagedata) + ":</td><td title=\"" + entity + "\" align=\"left\" style=\"width: 85px\">" + showEntity + "</td> </tr><tr><td style='height:20px' align=\"right\">" + window.parent.parent.GetTextByName("Message", window.parent.parent.useprameters.languagedata) + ":</td> <td align=\"left\" colspan=\"3\" style=\"width: 95px\"><img id=\"img01_" + issi + "\" src=\"" + picUrl + "\" />&nbsp;<span  id=\"sp" + ctype + "_" + issi + "\">" + showMsg + "</span><span style=\"display:none\"  id=\"hid_sp" + ctype + "_" + issi + "\">" + yuanMSG + "</span></td></tr><tr> <td align=\"right\" colspan=\"2\"><input id=\"btnrev_" + issi + "\" type=\"button\" class=\"btn\" " + vrevdisable + " onclick=\"RevCall(" + issi + ")\" value=\"" + btnbegpttname + "\" /></td><td align=\"left\" colspan=\"2\"><input id=\"btnendqsg_" + issi + "\" type=\"button\" class=\"btn\"  " + btndisabled + " onclick=\"RefuseCall(" + issi + ")\" value=\"" + window.parent.parent.GetTextByName("hangsup", window.parent.parent.useprameters.languagedata) + "\" />&nbsp;&nbsp;<input type=\"button\" class=\"btn\" id=\"btnclose01_" + issi + "\" " + vclosedisable + " onclick=\"CloseCallPanal(" + issi + ",'01')\" value=\"" + window.parent.parent.GetTextByName("Closebtn", window.parent.parent.useprameters.languagedata) + "\" /></td></tr></table>";
                        $("#div01_" + issi).html(str);
                    }
                    else if (calltype == window.parent.parent.GetTextByName("EmergencyHalfSingleCall", window.parent.parent.useprameters.languagedata)) {//多语言:紧急半双工单呼
                        var btnppcbegptt_show = "block";
                        var btnClose = "";
                        var btnppcptt_show = "none";
                        if (yuanMSG.indexOf(window.parent.parent.GetTextByName("CC_CALLREQUEST", window.parent.parent.useprameters.languagedata)) >= 0) {//多语言:有呼叫请求进入
                            picUrl = strUpCallComingPicUrl;
                        } else {
                            btnppcbegptt_show = "none";
                            btnppcptt_show = "block";
                            picUrl = strUpCallingPicUrl;
                        }

                        var btnbegpttname = window.parent.parent.GetTextByName("Toanswer", window.parent.parent.useprameters.languagedata);//多语言:接听
                        var btndisabled = "";
                        var cssclass = "ppcTable1";
                        if (yuanMSG.indexOf(window.parent.parent.GetTextByName("CC_RELEASE", window.parent.parent.useprameters.languagedata)) >= 0 || msg.indexOf(window.parent.parent.GetTextByName("Call_Div_UnReceiveCall", window.parent.parent.useprameters.languagedata)) >= 0) {//多语言:对方挂断；未接
                            btnppcbegptt_show = "block";
                            btnppcptt_show = "none";
                            btnbegpttname = window.parent.parent.GetTextByName("Called", window.parent.parent.useprameters.languagedata);//多语言:呼叫
                            btndisabled = "disabled=disabled";
                        } else {
                            btnClose = "disabled=disabled";
                        }
                        if (yuanMSG.indexOf(window.parent.parent.GetTextByName("CC_RELEASE", window.parent.parent.useprameters.languagedata)) >= 0) {//多语言:对方挂断
                            cssclass = "ppcTable3";
                            picUrl = strUpCallEndCallPicUrl
                        }
                        if (yuanMSG.indexOf(window.parent.parent.GetTextByName("Call_Div_UnReceiveCall", window.parent.parent.useprameters.languagedata)) >= 0) {//多语言:未接
                            picUrl = strUpCallUnRevPicUrl;
                        }


                        str += "<table id=\"table10_" + issi + "\" class='" + cssclass + "'><tr><td align=\"right\">" + window.parent.parent.GetTextByName("Identification", window.parent.parent.useprameters.languagedata) + ":</td><td align=\"left\" style=\"width: 85px\">" + issi + "</td><td>" + window.parent.parent.GetTextByName("Type", window.parent.parent.useprameters.languagedata) + ":</td><td align=\"left\" style=\"width: 85px\">" + calltype + "</td> </tr><tr id=\"tdp" + ctype + "_" + issi + "\"><td align=\"right\">" + window.parent.parent.GetTextByName("Username", window.parent.parent.useprameters.languagedata) + ":</td><td align=\"left\" style=\"width: 85px\">" + username + "</td><td>" + window.parent.parent.GetTextByName("Unit", window.parent.parent.useprameters.languagedata) + ":</td><td title=\"" + entity + "\" align=\"left\" style=\"width: 85px\">" + showEntity + "</td> </tr><tr><td style='height:20px' align=\"right\">" + window.parent.parent.GetTextByName("Message", window.parent.parent.useprameters.languagedata) + ":</td> <td align=\"left\" colspan=\"3\" style=\"width: 95px\"><img id=\"img10_" + issi + "\" src=\"" + picUrl + "\" />&nbsp;<span id=\"sp" + ctype + "_" + issi + "\">" + showMsg + "</span><span style=\"display:none\"  id=\"hid_sp" + ctype + "_" + issi + "\">" + yuanMSG + "</span></td></tr><tr> <td align=\"right\" colspan=\"2\"><input id=\"btnppcbegptt_" + issi + "\" type=\"button\" class=\"btn\"  style=\"display:" + btnppcbegptt_show + "\" onclick=\"begPPCHalfSingCall(" + issi + ")\" value=\"" + btnbegpttname + "\" /><input id=\"btnppcptt_" + issi + "\" type=\"button\" style=\"display:" + btnppcptt_show + "\" class=\"btn\"   onmouseup=\"ppcceasedscall(" + issi + ")\" onmousedown=\"beghalfppcCall(" + issi + ")\" onkeypress=\"ppckeyPress(" + issi + ")\" onkeyup=\"ppckeyUp(" + issi + ");\"  value=\"PTT\" /></td><td align=\"left\" colspan=\"2\"><input id=\"btnendppcqsg_" + issi + "\" type=\"button\" class=\"btn\" onclick=\"endppchalfCall(" + issi + ")\" " + btndisabled + " value=\"" + window.parent.parent.GetTextByName("hangsup", window.parent.parent.useprameters.languagedata) + "\" />&nbsp;&nbsp;<input type=\"button\"  id=\"btnclose10_" + issi + "\"  class=\"btn\" " + btnClose + "  onclick=\"CloseCallPanal(" + issi + ",'10')\" value=\"" + window.parent.parent.GetTextByName("Closebtn", window.parent.parent.useprameters.languagedata) + "\" /></td></tr></table>";
                        $("#div10_" + issi).html(str);
                    }
                    else if (calltype == window.parent.parent.GetTextByName("EmergencyAllSingleCall", window.parent.parent.useprameters.languagedata)) {//多语言:紧急全双工单呼
                        var btndisabled = "";
                        var btnbegpttname = window.parent.parent.GetTextByName("Toanswer", window.parent.parent.useprameters.languagedata);//多语言:接听
                        var vclosedisable = "";
                        if (yuanMSG.indexOf(window.parent.parent.GetTextByName("CC_RELEASE", window.parent.parent.useprameters.languagedata)) >= 0 || msg.indexOf(window.parent.parent.GetTextByName("Call_Div_UnReceiveCall", window.parent.parent.useprameters.languagedata)) >= 0) {//多语言:对方挂断；未接
                            btndisabled = "disabled=disabled";
                            btnbegpttname = window.parent.parent.GetTextByName("Called", window.parent.parent.useprameters.languagedata);//多语言:呼叫
                        } else {
                            vclosedisable = "disabled=disabled";
                        }
                        var cssclass = "ppcTable1";
                        if (yuanMSG.indexOf(window.parent.parent.GetTextByName("CC_RELEASE", window.parent.parent.useprameters.languagedata)) >= 0) {//多语言:对方挂断
                            cssclass = "ppcTable3";
                            picUrl = strUpCallEndCallPicUrl;
                        }
                        if (yuanMSG.indexOf(window.parent.parent.GetTextByName("Call_Div_UnReceiveCall", window.parent.parent.useprameters.languagedata)) >= 0) {//多语言:未接
                            picUrl = strUpCallUnRevPicUrl;
                        }
                        if (yuanMSG.indexOf(window.parent.parent.GetTextByName("CC_CALLREQUEST", window.parent.parent.useprameters.languagedata)) >= 0) {//多语言:有呼叫请求进入
                            picUrl = strUpCallComingPicUrl;
                        }
                        if (yuanMSG.indexOf(window.parent.parent.GetTextByName("CC_CONNECTACK", window.parent.parent.useprameters.languagedata)) >= 0) {//多语言:呼叫已连接
                            picUrl = strUpCallingPicUrl;
                        }
                        str += "<table id=\"table11_" + issi + "\"  class='" + cssclass + "'><tr><td align=\"right\">" + window.parent.parent.GetTextByName("Identification", window.parent.parent.useprameters.languagedata) + ":</td><td align=\"left\" style=\"width: 85px\">" + issi + "</td><td>" + window.parent.parent.GetTextByName("Type", window.parent.parent.useprameters.languagedata) + ":</td><td align=\"left\" style=\"width: 85px\">" + calltype + "</td> </tr><tr id=\"tdp" + ctype + "_" + issi + "\"><td align=\"right\">" + window.parent.parent.GetTextByName("Username", window.parent.parent.useprameters.languagedata) + ":</td><td align=\"left\" style=\"width: 85px\">" + username + "</td><td>" + window.parent.parent.GetTextByName("Unit", window.parent.parent.useprameters.languagedata) + ":</td><td align=\"left\" title=" + entity + " style=\"width: 85px\">" + showEntity + "</td> </tr><tr><td style='height:20px' align=\"right\">" + window.parent.parent.GetTextByName("Message", window.parent.parent.useprameters.languagedata) + ":</td> <td align=\"left\" colspan=\"3\" style=\"width: 95px\"><img id=\"img11_" + issi + "\" src=\"" + picUrl + "\" />&nbsp;<span  id=\"sp" + ctype + "_" + issi + "\">" + showMsg + "</span><span style=\"display:none\"  id=\"hid_sp" + ctype + "_" + issi + "\">" + yuanMSG + "</span></td></tr><tr> <td align=\"right\" colspan=\"2\"><input id=\"btnbegppc_" + issi + "\" type=\"button\" class=\"btn\" onclick=\"begPPCCall(" + issi + ")\" value=\"" + btnbegpttname + "\" /></td><td align=\"left\" colspan=\"2\"><input id=\"btnendppc_" + issi + "\" type=\"button\" class=\"btn\" onclick=\"endPPCCall(" + issi + ")\" " + btndisabled + " value=\"" + window.parent.parent.GetTextByName("hangsup", window.parent.parent.useprameters.languagedata) + "\" />&nbsp;&nbsp;<input id=\"btnclose11_" + issi + "\" type=\"button\" class=\"btn\" " + vclosedisable + "  onclick=\"CloseCallPanal(" + issi + ",'11')\" value=\"" + window.parent.parent.GetTextByName("Closebtn", window.parent.parent.useprameters.languagedata) + "\" /></td></tr></table>";
                        $("#div11_" + issi).html(str);
                    }

                });

            }

        }

        function ChangeMsgByIssi(id, issi, msg, flag) {
            //document.getElementById('sp_' + gssi).title = issi + ":" + msg;
            var mymsg = msg;
            msg = issi + ":" + msg;
            $("#" + id + "_" + issi).attr("title", msg)
            if (msg.length > 25) {
                msg = msg.substring(0, 25) + "...";
            }
            //document.getElementById(id + "_" + issi).innerHTML = issi + ":" + msg;
            if (iscallissi == "") {
                $("#" + id + "_" + issi).html(msg);//调度台获取授权时无法显示；
                $("#hid_" + id + "_" + issi).html(mymsg);//调度台获取授权时无法显示；
                // <span style=\"display:none\" id=\"hid_" + spanName + "\">" + msg + "</span>
            } else {
                $("#" + id + "_" + iscallissi).html(msg);
                $("#" + id + "_" + iscallissi).attr("title", issi + ":" + mymsg);
                $("#hid_" + id + "_" + iscallissi).html(mymsg);//调度台获取授权时无法显示；
            }
        }

        function CloseCallPanal(issi, ctype) {
            if (confirm(window.parent.parent.GetTextByName("Confirm_AreYouSureToCloseUpCallPanel", window.parent.parent.useprameters.languagedata))) {//多语言:确定要关闭此呼叫上行面板吗？
                for (var p = 0; p < callingType.length; p++) {
                    if (issi.toString() == callingType[p].issi.toString() && callingType[p].ctype.toString() == ctype.toString()) {
                        alert(window.parent.parent.GetTextByName("Alert_PleaseOverTheCallOfThisPanel", window.parent.parent.useprameters.languagedata));//多语言:请先结束此面板的呼叫
                        return;
                    }
                }
                removePanalByIssi(issi, ctype);
                if (vissiList.length == 0) {
                    $("#noList").css("display", "block");
                }
            }
        }

        var iscallissi = "";
        //根据issi号码删除相应的div
        function removePanalByIssi(issi, ctype) {
            //移到处理显示个数的逻辑中去
            //for (var p = 0; p < callingType.length; p++) {//当正在通话时，断开网络后，终端再次呼入时会有两个相同操作窗口的问题
            //    if (issi.toString() == callingType[p].issi.toString() && callingType[p].ctype.toString() == ctype.toString()) {
            //        return;
            //    }
            //}
            removeCallingtype(issi, ctype);//当断网情况下，自动去除该ISSI下面正在呼叫的

            $("#div" + ctype + "_" + issi).remove();

            var tempArray = new Array();
            for (var i = 0; i < vissiList.length; i++) {
                if (vissiList[i].issi.toString() == issi.toString() && vissiList[i].ctype.toString() == ctype.toString()) {

                } else {
                    tempArray.push(vissiList[i]);
                }
            }
            vissiList.length = 0;
            for (var i = 0; i < tempArray.length; i++) {
                vissiList.push(tempArray[i]);
            }
            window.parent.EndSingCallFun();
        }
        function updateFlagByIssi(issi, flags, ctype) {
            var tempArray = new Array();
            for (var i = 0; i < vissiList.length; i++) {
                if (vissiList[i].issi.toString() == issi.toString() && vissiList[i].ctype.toString() == ctype.toString()) {
                    tempArray.push({ issi: issi, Cflag: flags, ctype: ctype });
                }
                else {
                    tempArray.push(vissiList[i]);
                }
            }
            vissiList.length = 0;
            for (var i = 0; i < tempArray.length; i++) {
                vissiList.push(tempArray[i]);
            }
        }
        function findFlagByIssi(issi, ctype) {
            var rflag = false;
            for (var i = 0; i < vissiList.length; i++) {
                if (vissiList[i].issi.toString() == issi.toString() && vissiList[i].ctype.toString() == ctype.toString()) {
                    rflag = vissiList[i].Cflag
                    break;
                }
            }
            return rflag;
        }
        //判断是否有未接
        function havaUnRev() {
            var rflag = false;
            for (var i = 0; i < vissiList.length; i++) {
                if (vissiList[i].Cflag == false) {
                    rflag = true;
                    break;
                }
            }
            return rflag;
        }
        //普通全双工接听事件的方法
        //判断系统是否有其他单呼在通话
        //点击接听后，接听按钮不可用
        function RevCall(issi) {
            if (window.parent.parent.callPanalISSI != "" || callingType.length > 0) {
                alert(window.parent.parent.GetTextByName("HassingleCallTobeClose", window.parent.parent.useprameters.languagedata));//多语言:已发起一个单呼，请先结束
                return;
            };
            //var ifrs = window.parent.parent.document.frames["ifr_callcontent"];
            //去除呼叫栏中处理中，请先结束，修改人：张谦
            //if (!checkcallimg(window.parent.parent)) {
            //    alert(window.parent.parent.GetTextByName("HassingleCallInDowncall", window.parent.parent.useprameters.languagedata));//多语言:呼叫栏中处理中，请先结束
            //    return;
            //}
            //有此号码的issi呼叫进入 应该先去处理
            if (document.getElementById('sp00_' + issi) != null) {
                if (document.getElementById('sp00_' + issi).innerHTML.indexOf(window.parent.parent.GetTextByName("CC_CALLREQUEST", window.parent.parent.useprameters.languagedata)) >= 0) {//多语言:有呼叫请求进入
                    alert(window.parent.parent.GetTextByName("HassingleCallInToHandle", window.parent.parent.useprameters.languagedata) + "(ISSI:" + issi + ")");//多语言:普通半双工单呼进入,请先去处理
                    return;
                }
            }
            if (document.getElementById('sp11_' + issi) != null) {
                if (document.getElementById('sp11_' + issi).innerHTML.indexOf(window.parent.parent.GetTextByName("CC_CALLREQUEST", window.parent.parent.useprameters.languagedata)) >= 0) {//多语言:有呼叫请求进入
                    alert(window.parent.parent.GetTextByName("EmergencyCallInToHandle", window.parent.parent.useprameters.languagedata) + "(ISSI:" + issi + ")");//多语言:有紧急全双工单呼进入,请先去处理
                    return;
                }
            }
            if (document.getElementById('sp10_' + issi) != null) {
                if (document.getElementById('sp10_' + issi).innerHTML.indexOf(window.parent.parent.GetTextByName("CC_CALLREQUEST", window.parent.parent.useprameters.languagedata)) >= 0) {//多语言:有呼叫请求进入
                    alert(window.parent.parent.GetTextByName("EmergencyHalfCallInToHandle", window.parent.parent.useprameters.languagedata) + "(ISSI:" + issi + ")");//多语言:有紧急半双工单呼进入,请先去处理
                    return;
                }
            }

            var isEncryption = "0";//xzj--20190320--添加呼叫加密参数
            if (window.parent.parent.useprameters.CallEncryption.indexOf("Single") >= 0) {
                isEncryption = "1";
            }
            if (window.parent.parent.startDC2(issi, isEncryption)) {
                updateFlagByIssi(issi, true, "01");
                window.parent.parent.callPanalISSI = issi;
                iscallissi = issi;
                $("#sp_" + issi).html(window.parent.parent.GetTextByName("RECEIVE_SUCCESS", window.parent.parent.useprameters.languagedata));//多语言:接听成功
                window.parent.EndSingCallFun2();
                document.getElementById("btnrev_" + issi).disabled = true;
                document.getElementById("btnendqsg_" + issi).disabled = false;
                document.getElementById("btnclose01_" + issi).disabled = true;
                addCallingType(issi, "01");
                document.getElementById('table01_' + issi).setAttribute("class", "table2");
            }
        }
        //普通全双工拒绝接听 
        //接听按钮变成 呼叫 拒绝按钮隐藏
        function RefuseCall(issi) {
            //已发起的不为空的时候 且 本地号码不等于以发起的号码 相等的时候结束本机
            if (window.parent.parent.callPanalISSI != "" && issi != window.parent.parent.callPanalISSI) {
                alert(window.parent.parent.GetTextByName("HassingleCallTobeClose", window.parent.parent.useprameters.languagedata));//多语言:已发起一个单呼，请先结束
                return;
            };
            // var ifrs = window.parent.parent.document.frames["ifr_callcontent"];
            //去除呼叫栏中处理中，请先结束，修改人：张谦
            //if (!checkcallimg(window.parent.parent)) {
            //    alert(window.parent.parent.GetTextByName("HassingleCallInDowncall", window.parent.parent.useprameters.languagedata));//多语言:呼叫栏中处理中，请先结束
            //    return;
            //}
            window.parent.parent.callPanalISSI = "";
            iscallissi = "";
            updateFlagByIssi(issi, true, "01");  //按拒绝按钮 也是已处理
            if (window.parent.parent.endDC2(issi)) {
                $("#sp_" + issi).html(window.parent.parent.GetTextByName("ENDING_CALL", window.parent.parent.useprameters.languagedata));//多语言:结束呼叫
            }
        }
        //开始于获取授权分开
        function begHalfSingCall(issi) {
            if (window.parent.parent.callPanalISSI != "" || callingType.length > 0) {
                alert(window.parent.parent.GetTextByName("HassingleCallTobeClose", window.parent.parent.useprameters.languagedata));//多语言:已发起一个单呼，请先结束
                return;
            };
            //var ifrs = window.parent.parent.document.frames["ifr_callcontent"];
            //去除呼叫栏中处理中，请先结束，修改人：张谦
            //if (!checkcallimg(window.parent.parent)) {
            //    alert(window.parent.parent.GetTextByName("HassingleCallInDowncall", window.parent.parent.useprameters.languagedata));//多语言:呼叫栏中处理中，请先结束
            //    return;
            //}

            //有此号码的issi呼叫进入 应该先去处理
            if (document.getElementById('sp01_' + issi) != null) {
                if (document.getElementById('sp01_' + issi).innerHTML.indexOf(window.parent.parent.GetTextByName("CC_CALLREQUEST", window.parent.parent.useprameters.languagedata)) >= 0) {//多语言:有呼叫请求进入
                    alert(window.parent.parent.GetTextByName("havingSingleComeInPleastToHandle", window.parent.parent.useprameters.languagedata) + "(ISSI:" + issi + ")");//多语言:有普通全双工单呼进入,请先去处理
                    return;
                }
            }
            if (document.getElementById('sp11_' + issi) != null) {
                if (document.getElementById('sp11_' + issi).innerHTML.indexOf(window.parent.parent.GetTextByName("CC_CALLREQUEST", window.parent.parent.useprameters.languagedata)) >= 0) {//多语言:有呼叫请求进入
                    alert(window.parent.parent.GetTextByName("EmergencyCallInToHandle", window.parent.parent.useprameters.languagedata) + "(ISSI:" + issi + ")");//多语言:有紧急全双工单呼进入,请先去处理
                    return;
                }
            }
            if (document.getElementById('sp10_' + issi) != null) {
                if (document.getElementById('sp10_' + issi).innerHTML.indexOf(window.parent.parent.GetTextByName("CC_CALLREQUEST", window.parent.parent.useprameters.languagedata)) >= 0) {//多语言:有呼叫请求进入
                    alert(window.parent.parent.GetTextByName("EmergencyHalfCallInToHandle", window.parent.parent.useprameters.languagedata) + "(ISSI:" + issi + ")");//多语言:有紧急半双工单呼进入,请先去处理
                    return;
                }
            }
            var isEncryption = "0";//xzj--20190320--添加呼叫加密参数
            if (window.parent.parent.useprameters.CallEncryption.indexOf("Single") >= 0) {
                isEncryption = "1";
            }
            if (window.parent.parent.startSC2(issi, isEncryption)) {
                window.parent.EndSingCallFun2();
                updateFlagByIssi(issi, true, "00");
                window.parent.parent.callPanalISSI = issi;
                iscallissi = issi;
                $("#btnbegptt_" + issi).css("display", "none");
                $("#btnptt_" + issi).css("display", "block");
                document.getElementById('btnendptt_' + issi).disabled = false;
                document.getElementById('btnclose00_' + issi).disabled = true;
                document.getElementById('table00_' + issi).setAttribute("class", "table2");
                addCallingType(issi, "00");
            }
        }

        function keyPress(issi) {
            if (event.keyCode == 32) {
                halfSingCall(issi);
            }
        }
        function keyUp(issi) {
            if (event.keyCode == 32) {
                CEASEDSCALL(issi);
            }
        }
        //半双工获取授权
        function halfSingCall(issi) {
            //var ifrs = window.parent.parent.document.frames["ifr_callcontent"];
            //去除呼叫栏中处理中，请先结束，修改人：张谦
            //if (!checkcallimg(window.parent.parent)) {
            //    alert(window.parent.parent.GetTextByName("HassingleCallInDowncall", window.parent.parent.useprameters.languagedata));//多语言:呼叫栏中处理中，请先结束
            //    return;
            //}
            var isEncryption = "0";//xzj--20190320--添加呼叫加密参数
            if (window.parent.parent.useprameters.CallEncryption.indexOf("Single") >= 0) {
                isEncryption = "1";
            }
            window.parent.parent.startSC2(issi, isEncryption);
        }
        //半双工释放授权
        function CEASEDSCALL(issi) {
            window.parent.parent.sceasedPTT2(issi);
        }
        //结束半双工单呼
        function EndhalfSingCall(issi) {
            if (window.parent.parent.callPanalISSI != "" && issi != window.parent.parent.callPanalISSI) {
                alert(window.parent.parent.GetTextByName("HassingleCallTobeClose", window.parent.parent.useprameters.languagedata));//多语言:已发起一个单呼，请先结束
                return;
            };
            //var ifrs = window.parent.parent.document.frames["ifr_callcontent"];
            //去除呼叫栏中处理中，请先结束，修改人：张谦
            //if (!checkcallimg(window.parent.parent)) {
            //    alert(window.parent.parent.GetTextByName("HassingleCallInDowncall", window.parent.parent.useprameters.languagedata));//多语言:呼叫栏中处理中，请先结束
            //    return;
            //}
            window.parent.parent.callPanalISSI = "";
            iscallissi = "";
            updateFlagByIssi(issi, true, "00");  //按拒绝按钮 也是已处理
            window.parent.parent.endSC2(issi);


        }

        //开始于获取授权分开
        function begPPCHalfSingCall(issi) {
            if (window.parent.parent.callPanalISSI != "" || callingType.length > 0) {
                alert(window.parent.parent.GetTextByName("HassingleCallTobeClose", window.parent.parent.useprameters.languagedata));//多语言:已发起一个单呼，请先结束
                return;
            };
            //var ifrs = window.parent.parent.document.frames["ifr_callcontent"];
            if (!checkcallimg(window.parent.parent)) {
                alert(window.parent.parent.GetTextByName("HassingleCallTobeClose", window.parent.parent.useprameters.languagedata));//多语言:已发起一个单呼，请先结束
                return;
            }

            //有此号码的issi呼叫进入 应该先去处理
            if (document.getElementById('sp01_' + issi) != null) {
                if (document.getElementById('sp01_' + issi).innerHTML.indexOf(window.parent.parent.GetTextByName("CC_CALLREQUEST", window.parent.parent.useprameters.languagedata)) >= 0) {//多语言:有呼叫请求进入
                    alert(window.parent.parent.GetTextByName("havingSingleComeInPleastToHandle", window.parent.parent.useprameters.languagedata) + "(ISSI:" + issi + ")");//多语言:有普通全双工单呼进入,请先去处理
                    return;
                }
            }
            if (document.getElementById('sp11_' + issi) != null) {
                if (document.getElementById('sp11_' + issi).innerHTML.indexOf(window.parent.parent.GetTextByName("CC_CALLREQUEST", window.parent.parent.useprameters.languagedata)) >= 0) {//多语言:有呼叫请求进入
                    alert(window.parent.parent.GetTextByName("EmergencyCallInToHandle", window.parent.parent.useprameters.languagedata) + "(ISSI:" + issi + ")");//多语言:有紧急全双工单呼进入,请先去处理
                    return;
                }
            }
            if (document.getElementById('sp00_' + issi) != null) {
                if (document.getElementById('sp00_' + issi).innerHTML.indexOf(window.parent.parent.GetTextByName("CC_CALLREQUEST", window.parent.parent.useprameters.languagedata)) >= 0) {//多语言:有呼叫请求进入
                    alert(window.parent.parent.GetTextByName("HassingleCallInToHandle", window.parent.parent.useprameters.languagedata) + "(ISSI:" + issi + ")");//多语言:有普通半双工单呼进入,请先去处理
                    return;
                }
            }

            if (window.parent.parent.startppcSC(issi)) {
                window.parent.EndSingCallFun2();
                updateFlagByIssi(issi, true, "10");
                window.parent.parent.callPanalISSI = issi;
                iscallissi = issi;
                $("#btnppcbegptt_" + issi).css("display", "none");
                $("#btnppcptt_" + issi).css("display", "block");
                document.getElementById('btnendppcqsg_' + issi).disabled = false;
                document.getElementById('btnclose10_' + issi).disabled = true;
                addCallingType(issi, "10");
                document.getElementById('table10_' + issi).setAttribute("class", "ppcTable2");
            }
        }

        function ppckeyPress(issi) {
            if (event.keyCode == 32) {
                beghalfppcCall(issi);
            }
        }
        function ppckeyUp(issi) {
            if (event.keyCode == 32) {
                ppcceasedscall(issi);
            }
        }
        //TODO 需要判断是否有其他呼叫正在进行
        function beghalfppcCall(issi) {
            window.parent.parent.startppcSC(issi);

        }
        //紧急呼叫释放授权
        function ppcceasedscall(issi) {
            window.parent.parent.ppcsceasedPTT(issi);
        }
        //结束紧急呼叫
        function endppchalfCall(issi) {
            if (window.parent.parent.callPanalISSI != "" && issi != window.parent.parent.callPanalISSI) {
                alert(window.parent.parent.GetTextByName("HassingleCallTobeClose", window.parent.parent.useprameters.languagedata));//多语言:已发起一个单呼，请先结束
                return;
            };
            // var ifrs = window.parent.parent.document.frames["ifr_callcontent"];
            if (!checkcallimg(window.parent.parent)) {
                alert(window.parent.parent.GetTextByName("HassingleCallTobeClose", window.parent.parent.useprameters.languagedata));//多语言:已发起一个单呼，请先结束
                return;
            }
            window.parent.parent.callPanalISSI = "";
            iscallissi = "";
            updateFlagByIssi(issi, true, "10");  //按拒绝按钮 也是已处理
            window.parent.parent.endppcSC(issi);
            //$("#table_" + issi).addClass("ppcTable3");
        }

        //开始全双工紧急呼叫单呼
        function begPPCCall(issi) {
            if (window.parent.parent.callPanalISSI != "" || callingType.length > 0) {
                alert(window.parent.parent.GetTextByName("HassingleCallTobeClose", window.parent.parent.useprameters.languagedata));//多语言:已发起一个单呼，请先结束
                return;
            };
            //var ifrs = window.parent.parent.document.frames["ifr_callcontent"];
            if (!checkcallimg(window.parent.parent)) {
                alert(window.parent.parent.GetTextByName("HassingleCallTobeClose", window.parent.parent.useprameters.languagedata));//多语言:已发起一个单呼，请先结束
                return;
            }
            //有此号码的issi呼叫进入 应该先去处理
            if (document.getElementById('sp01_' + issi) != null) {
                if (document.getElementById('sp01_' + issi).innerHTML.indexOf(window.parent.parent.GetTextByName("CC_CALLREQUEST", window.parent.parent.useprameters.languagedata)) >= 0) {//多语言:有呼叫请求进入
                    alert(window.parent.parent.GetTextByName("havingSingleComeInPleastToHandle", window.parent.parent.useprameters.languagedata) + "(ISSI:" + issi + ")");//多语言:有普通全双工单呼进入,请先去处理
                    return;
                }
            }
            if (document.getElementById('sp10_' + issi) != null) {
                if (document.getElementById('sp10_' + issi).innerHTML.indexOf(window.parent.parent.GetTextByName("CC_CALLREQUEST", window.parent.parent.useprameters.languagedata)) >= 0) {//多语言:有呼叫请求进入
                    alert(window.parent.parent.GetTextByName("EmergencyHalfCallInToHandle", window.parent.parent.useprameters.languagedata) + "(ISSI:" + issi + ")");//多语言:有紧急半双工单呼进入,请先去处理
                    return;
                }
            }
            if (document.getElementById('sp00_' + issi) != null) {
                if (document.getElementById('sp00_' + issi).innerHTML.indexOf(window.parent.parent.GetTextByName("CC_CALLREQUEST", window.parent.parent.useprameters.languagedata)) >= 0) {//多语言:有呼叫请求进入
                    alert(window.parent.parent.GetTextByName("HassingleCallInToHandle", window.parent.parent.useprameters.languagedata) + "(ISSI:" + issi + ")");//多语言:有普通半双工单呼进入,请先去处理
                    return;
                }
            }
            if (window.parent.parent.startppcDC(issi)) {
                window.parent.EndSingCallFun2();
                updateFlagByIssi(issi, true, "11");
                window.parent.parent.callPanalISSI = issi;
                iscallissi = issi;
                $("#sp_" + issi).html(window.parent.parent.GetTextByName("RECEIVE_SUCCESS", window.parent.parent.useprameters.languagedata));//多语言:接听成功
                document.getElementById("btnbegppc_" + issi).disabled = true;
                document.getElementById("btnendppc_" + issi).disabled = false;
                document.getElementById("btnclose11_" + issi).disabled = true;
                addCallingType(issi, "11");
                document.getElementById('table11_' + issi).setAttribute("class", "ppcTable2");
            }
        }
        //结束全双工紧急呼叫单呼
        function endPPCCall(issi) {
            if (window.parent.parent.callPanalISSI != "" && issi != window.parent.parent.callPanalISSI) {
                alert(window.parent.parent.GetTextByName("HassingleCallTobeClose", window.parent.parent.useprameters.languagedata));//多语言:已发起一个单呼，请先结束
                return;
            };
            //var ifrs = window.parent.parent.document.frames["ifr_callcontent"];
            if (!checkcallimg(window.parent.parent)) {
                alert(window.parent.parent.GetTextByName("HassingleCallTobeClose", window.parent.parent.useprameters.languagedata));//多语言:已发起一个单呼，请先结束
                return;
            }
            window.parent.parent.callPanalISSI = "";
            iscallissi = "";
            updateFlagByIssi(issi, true, "11");  //按拒绝按钮 也是已处理
            if (window.parent.parent.endppcDC(issi)) {
                //$("#table_" + issi).addClass("ppcTable3");
                //$("#sp_" + issi).html("结束呼叫");
            }
        }
        function RendGroupCallPanalLang() {
            //多语言:暂无上行普通组呼记录！
            $("#HasNoUpSingleCallRecords").html(window.parent.parent.GetTextByName("HasNoUpSingleCallRecords", window.parent.parent.useprameters.languagedata));
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
                <%--  <img src="../../Images/sorry.gif" />--%>
                <p></p>
                <p id="HasNoUpSingleCallRecords">
                </p>
            </center>
        </div>
    </form>
</body>
</html>
