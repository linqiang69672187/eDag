<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PPCGroupCallPanal.aspx.cs"
    Inherits="Web.lqnew.callPanal.PPCGroupCallPanal" %>

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

        .btn2 {
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
            width: 60px;
            height: 20px;
        }

        .table1 {
            background: #88D8F6;
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
            border-top-color: Black;
            border-right-width: 1px;
            border-right-style: inset;
            border-right-color: Black;
        }

        .table2 {
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
            border-top-color: Black;
            border-right-width: 1px;
            border-right-style: inset;
            border-right-color: Black;
        }

        .table3 {
            position: relative;
            background: linear-gradient(#ffffff, yellow);
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
            border-top-color: Black;
            border-right-width: 1px;
            border-right-style: inset;
            border-right-color: Black;
        }
    </style>
    <script type="text/javascript">
        var vissiList = new Array();
        var showLimit = 10;

        function IsExsit(issi) {
            var mydiv = document.getElementById("div_" + issi);
            if (mydiv) {
                return true;
            } else {
                return false;
            }
        }
        function toRenderHtml(issi, calltype, msg, mytype) {
            var str = "<div id=\"div_" + issi + "\"><table border=\"0\" cellspacing=\"0\" cellpadding=\"0\" style=\"height:2px\"><tr><td></td></tr></table><table  id=\"table_" + issi + "\"  class='table2' onmouseover='addMember(\"" + issi + "\",\"" + calltype + "\",\"" + msg + "\")' ><tr><td align=\"right\">" + window.parent.parent.GetTextByName("Identification", window.parent.parent.useprameters.languagedata) + ":</td><td align=\"left\" style=\"width: 85px\">" + issi + "</td><td>" + window.parent.parent.GetTextByName("Type", window.parent.parent.useprameters.languagedata) + ":</td><td align=\"left\" style=\"width: 85px\">" + calltype + "</td> </tr><tr><td align=\"right\">" + window.parent.parent.GetTextByName("Message", window.parent.parent.useprameters.languagedata) + ":</td> <td align=\"left\" colspan=\"3\" style=\"width: 95px\"><span id=\"sp_" + issi + "\">" + msg + "</span></td></tr></table></div>";
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
            if (msg == window.parent.parent.GetTextByName("PPC_CALLREQUEST", window.parent.parent.useprameters.languagedata)) {//有呼叫请求进入
                window.parent.PPCCallComeOn()
                if (IsExsit(issi)) {
                    var myflag = false;
                    if (document.getElementById("tdp_" + issi) != null) {
                        myflag = true;
                    }
                    removePanalByIssi(issi); //移除原来的 先判断原来是否存在去读过数据
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


                        var showMsg = msg;
                        if (showMsg.length > 8) {
                            showMsg = msg.substring(0, 20) + "...";
                        }


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
                    var btnppcenddisable = "";
                    var classstyle = "table1";
                    if (msg == window.parent.parent.GetTextByName("PPC_CALLREQUEST", window.parent.parent.useprameters.languagedata)) {//有呼叫请求进入
                        showMsg = msg;
                    } else {
                        btnppcenddisable = "disabled=disabled";
                        classstyle = "table3";
                    }



                    var str = "<table border=\"0\" cellspacing=\"0\" cellpadding=\"0\" style=\"height:2px\"><tr><td></td></tr></table><table  id=\"table_" + issi + "\"  class='" + classstyle + "'><tr><td align=\"right\">" + window.parent.parent.GetTextByName("Identification", window.parent.parent.useprameters.languagedata) + ":</td><td align=\"left\" style=\"width: 85px\">" + issi + "</td><td>" + window.parent.parent.GetTextByName("Type", window.parent.parent.useprameters.languagedata) + ":</td><td align=\"left\" style=\"width: 85px\">" + calltype + "</td> </tr><tr id=\"tdp_" + issi + "\"><td align=\"right\">" + window.parent.parent.GetTextByName("Username", window.parent.parent.useprameters.languagedata) + ":</td><td align=\"left\" style=\"width: 85px\">" + username + "</td><td>" + window.parent.parent.GetTextByName("Unit", window.parent.parent.useprameters.languagedata) + ":</td><td title=\"" + entity + "\" align=\"left\" style=\"width: 85px\">" + showEntity + "</td> </tr><tr><td align=\"right\">" + window.parent.parent.GetTextByName("Message", window.parent.parent.useprameters.languagedata) + ":</td> <td align=\"left\" colspan=\"3\" style=\"width: 95px\"><span title=\"" + msg + "\" id=\"sp_" + issi + "\">" + showMsg + "</span></td></tr><tr> <td align=\"right\" colspan=\"2\"><input id=\"btnppcend_" + issi + "\" type=\"button\" " + btnppcenddisable + " class=\"btn2\"   onclick=\"endPPCCall(" + issi + ")\" value=\"" + window.parent.parent.GetTextByName("EndEmergency", window.parent.parent.useprameters.languagedata) + "\" /></td><td align=\"center\"><input id=\"btnppcppt_" + issi + "\" type=\"button\" class=\"btn\"  onmouseup=\"caset(" + issi + ")\" onmousedown=\"RevCall(" + issi + ")\" onkeypress=\"keyPress(" + issi + ")\" onkeyup=\"keyUp(" + issi + ");\"  value=\"PTT\"  /></td><td align=\"left\"><input type=\"button\" class=\"btn\"   onclick=\"CloseCallPanal(" + issi + ")\" value=\"" + window.parent.parent.GetTextByName("Closebtn", window.parent.parent.useprameters.languagedata) + "\" /></td></tr></table>";
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

                removePanalByIssi(issi);
                if (vissiList.length == 0) {
                    $("#noList").css("display", "block");
                }

                window.parent.EndPPCCall();
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
            window.parent.parent.startppcGC(issi);
        }

        function caset(issi) {
            window.parent.parent.ppcgceasedPTT(issi);
        }

        function endPPCCall(issi) {
            window.parent.parent.endppcGC(issi);
        }

        $(document).ready(function () {
            RendGroupCallPanalLang();
            document.body.oncontextmenu = function () { return false; };
        });
        function RendGroupCallPanalLang() {
            //多语言:暂无上行普通组呼记录!
            $("#HasNoEmergencyCallRecord").html(window.parent.parent.GetTextByName("HasNoEmergencyCallRecord", window.parent.parent.useprameters.languagedata));
        }
    </script>
</head>
<body style="background-color: White">
    <form id="form1" runat="server">
        <div id="maindiv">
        </div>
        <div id="test" style="top: 0; left: 0; width: 100%; height: 100%; z-index: 0">
            <center id="noList">
                <br />
                <br />
                <br />
                <%--  <img src="../../Images/sorry.gif" />--%>
                <p></p>
                <p id="HasNoEmergencyCallRecord">
                </p>
            </center>
        </div>
    </form>
</body>
</html>
