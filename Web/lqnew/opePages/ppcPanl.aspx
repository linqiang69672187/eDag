<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ppcPanl.aspx.cs" Inherits="Web.lqnew.opePages.ppcPanl" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        body
        {
            margin: 0px;
        }
        #div2
        {
            /*background: url('../images/upcall/边框.png');*/
            position: absolute;
            top: 0px;
            left: 0px;
            margin-left: 0px;
            z-index: 1;
            background-color: transparent;
        }
    </style>
    <link rel="stylesheet" type="text/css" href="../css/tab2.css" />
    <link href="../css/lq_addedit.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/pagestyle.css" rel="stylesheet" type="text/css" />
    <script src="../js/geturl.js" type="text/javascript"></script>
    <script src="../../JQuery/jquery-1.5.2.js" type="text/javascript"></script>
    <script type="text/javascript">
        var playfast = 500;
        function singcallpanal() {
            $("#singcallpanel").css("display", "block");
            $("#groupcallpanel").css("display", "none");
            $("#ppcgroupcallpanel").css("display", "none");
            document.getElementById("tdsingleCall").background = "../images/upcall/single1.png";
            document.getElementById("tdsingleCall1").background = "../images/upcall/single1.png";
            document.getElementById("tdppcCall").background = "../images/upcall/single2.png";
            document.getElementById("tdppcCall1").background = "../images/upcall/single2.png";
            document.getElementById("tdGroupCall").background = "../images/upcall/single3.png";
            document.getElementById("tdGroupCall1").background = "../images/upcall/single3.png";
            //TODO 还需要更改选项卡图标
        }
        function singcallpanal2() {
            singcallpanal();
            ShowCallPanal();
        }

        function groupcallpanal() {
            $("#singcallpanel").css("display", "none");
            $("#groupcallpanel").css("display", "block");
            $("#ppcgroupcallpanel").css("display", "none");
            //TODO 还需要更改选项卡图标

            document.getElementById("tdsingleCall").background = "../images/upcall/ppcgroup1.png";
            document.getElementById("tdsingleCall1").background = "../images/upcall/ppcgroup1.png";
            document.getElementById("tdppcCall").background = "../images/upcall/ppcgroup2.png";
            document.getElementById("tdppcCall1").background = "../images/upcall/ppcgroup2.png";
            document.getElementById("tdGroupCall").background = "../images/upcall/ppcgroup3.png";
            document.getElementById("tdGroupCall1").background = "../images/upcall/ppcgroup3.png";
        }
        function groupcallpanal2() {
            groupcallpanal();
            ShowCallPanal();
         }
        function PPCGroupCallPanal() {
            $("#singcallpanel").css("display", "none");
            $("#groupcallpanel").css("display", "none");
            $("#ppcgroupcallpanel").css("display", "block");
            //TODO 还需要更改选项卡图标
            document.getElementById("tdsingleCall").background = "../images/upcall/group1.png";
            document.getElementById("tdsingleCall1").background = "../images/upcall/group1.png";
            document.getElementById("tdppcCall").background = "../images/upcall/group2.png";
            document.getElementById("tdppcCall1").background = "../images/upcall/group2.png";
            document.getElementById("tdGroupCall").background = "../images/upcall/group3.png";
            document.getElementById("tdGroupCall1").background = "../images/upcall/group3.png";
        }
        function PPCGroupCallPanal2() {
            PPCGroupCallPanal();
            ShowCallPanal();
        }
        //缩进方法
        function HideCallPanal() {

            $("#UpCallPanl", window.parent.document).animate({ right: -290 }, playfast, function () {
                $("#div2").animate({ left: 45 }, playfast, function () {
                    $("#div2").hide();
                    $("#div1").show();
                    $("#div1").animate({ left: 0 }, playfast, function () {

                    });
                });
            });
        }
        //展开方法
        function ShowCallPanal() {
            $("#div1").animate({ left: 20 }, playfast, function () {
                $("#div1").hide();
                $("#div2").show();
                $("#div2").animate({ left: 0 }, playfast, function () {
                    $("#UpCallPanl", window.parent.document).animate({ right: 0 }, playfast, function () {

                    });
                });
            });
        }

        function ppcPanlLoadTitle() {
           
            if (window.document.getElementById("spSingCall")) {
                window.document.getElementById("spSingCall").innerText = window.parent.parent.GetTextByName("spSingCall", window.parent.parent.useprameters.languagedata);
                window.document.getElementById("spSingCall").title = window.parent.parent.GetTextByName("spSingCalltitle", window.parent.parent.useprameters.languagedata);
            }
            if (window.document.getElementById("spSingCall1")) {
                window.document.getElementById("spSingCall1").innerText = window.parent.parent.GetTextByName("spSingCall", window.parent.parent.useprameters.languagedata);
                window.document.getElementById("spSingCall1").title = window.parent.parent.GetTextByName("spSingCalltitle", window.parent.parent.useprameters.languagedata);
            }
            if (window.document.getElementById("spGroupCall")) {
                window.document.getElementById("spGroupCall").innerText = window.parent.parent.GetTextByName("spGroupCall", window.parent.parent.useprameters.languagedata);
                window.document.getElementById("spGroupCall").title = window.parent.parent.GetTextByName("spGroupCalltitle", window.parent.parent.useprameters.languagedata);
            }
            if (window.document.getElementById("spGroupCall1")) {
                window.document.getElementById("spGroupCall1").innerText = window.parent.parent.GetTextByName("spGroupCall", window.parent.parent.useprameters.languagedata);
                window.document.getElementById("spGroupCall1").title = window.parent.parent.GetTextByName("spGroupCalltitle", window.parent.parent.useprameters.languagedata);
            }
            if (window.document.getElementById("spPPCCall")) {
                window.document.getElementById("spPPCCall").innerText = window.parent.parent.GetTextByName("spPPCCall", window.parent.parent.useprameters.languagedata);
                window.document.getElementById("spPPCCall").title = window.parent.parent.GetTextByName("spPPCCalltitle", window.parent.parent.useprameters.languagedata);
            }
            if (window.document.getElementById("spPPCCall1")) {
                window.document.getElementById("spPPCCall1").innerText = window.parent.parent.GetTextByName("spPPCCall", window.parent.parent.useprameters.languagedata);
                window.document.getElementById("spPPCCall1").title = window.parent.parent.GetTextByName("spPPCCalltitle", window.parent.parent.useprameters.languagedata);
            }
        }

        $(document).ready(function () {
            ppcPanlLoadTitle();
            $("#UpCallPanl", window.parent.document).css("right", -290);
            $("#div2").css("left", 45);
            $("#div1").css("left", 0);

            $("#div2").hide();
            $("#div1").show();
            document.body.oncontextmenu = function () { return false; };
        });

        var singCallFunc = "";
        function SingCallComeOn() {
            clearInterval(singCallFunc);
            singCallFunc = setInterval(function () {//直接在里面判断是否存在未接的

                if ($("#spSingCall").css("color") == "red") {
                    $("#spSingCall").css("color", "blue");
                    $("#spSingCall1").css("color", "blue");
                } else {
                    $("#spSingCall").css("color", "red");
                    $("#spSingCall1").css("color", "red");

                }
            }, 100);
        }
        function HaveComeOn() {
            var haveCCRequestCome = window.parent.parent.GetTextByName("CC_CALLREQUEST", window.parent.parent.useprameters.languagedata);//有呼叫请求进入

            for (var i = 0; i < document.frames["singlecallContent"].vissiList.length; i++) {
                if (document.frames["singlecallContent"].document.getElementById('sp00_' + document.frames["singlecallContent"].vissiList[i].issi.toString()) != null) {
                    if (document.frames["singlecallContent"].document.getElementById('sp00_' + document.frames["singlecallContent"].vissiList[i].issi.toString()).innerText.indexOf(haveCCRequestCome) >= 0) {
                        SingCallComeOn();
                        break;
                    }
                }
                if (document.frames["singlecallContent"].document.getElementById('sp01_' + document.frames["singlecallContent"].vissiList[i].issi.toString()) != null) {
                    if (document.frames["singlecallContent"].document.getElementById('sp01_' + document.frames["singlecallContent"].vissiList[i].issi.toString()).innerText.indexOf(haveCCRequestCome) >= 0) {
                        SingCallComeOn();
                        break;
                    }
                }
                if (document.frames["singlecallContent"].document.getElementById('sp11_' + document.frames["singlecallContent"].vissiList[i].issi.toString()) != null) {
                    if (document.frames["singlecallContent"].document.getElementById('sp11_' + document.frames["singlecallContent"].vissiList[i].issi.toString()).innerText.indexOf(haveCCRequestCome) >= 0) {
                        SingCallComeOn();
                        break;
                    }
                }
                if (document.frames["singlecallContent"].document.getElementById('sp10_' + document.frames["singlecallContent"].vissiList[i].issi.toString()) != null) {
                    if (document.frames["singlecallContent"].document.getElementById('sp10_' + document.frames["singlecallContent"].vissiList[i].issi.toString()).innerText.indexOf(haveCCRequestCome) >= 0) {
                        SingCallComeOn();
                        break;
                    }
                }
            }
        }
        function EndSingCallFun() {
            clearInterval(singCallFunc);
            if (window.parent.callPanalISSI != "") {
                $("#spSingCall").css("color", "#57FA05");
                $("#spSingCall1").css("color", "#57FA05");
                return;
            }
            $("#spSingCall").css("color", "black");
            $("#spSingCall1").css("color", "black");
            if (document.frames["singlecallContent"].havaUnRev()) {
                $("#spSingCall").css("color", "red");
                $("#spSingCall1").css("color", "red");
            }
            HaveComeOn();
        }
        function EndSingCallFun2() {
            clearInterval(singCallFunc);
            $("#spSingCall").css("color", "#57FA05");
            $("#spSingCall1").css("color", "#57FA05");
            HaveComeOn();
        }

        var ppcCallFunc = "";
        var playSound = "";
        function PPCCallComeOn() {
            clearInterval(ppcCallFunc);
            clearInterval(playSound);
            ppcCallFunc = setInterval(function () {
                if ($("#spPPCCall").css("color") == "red") {
                    $("#spPPCCall").css("color", "blue");
                    $("#spPPCCall1").css("color", "blue");
                } else {
                    $("#spPPCCall").css("color", "red");
                    $("#spPPCCall1").css("color", "red");

                }

            }, 100);
            window.parent.endPlay();
            window.parent.doPaly();
            playSound = setInterval(function () {
                window.parent.endPlay();
                window.parent.doPaly();
            }, 4500);
        }
        function EndPPCCall() {
            window.parent.endPlay(); //停止播放铃声
            clearInterval(ppcCallFunc);
            clearInterval(playSound);
            $("#spPPCCall").css("color", "black");
            $("#spPPCCall1").css("color", "black");
            PPCComeOn();
        }
        function EndPPCCall2() {
            window.parent.endPlay(); //停止播放铃声
            clearInterval(ppcCallFunc);
            clearInterval(playSound);
            $("#spPPCCall").css("color", "black");
            $("#spPPCCall1").css("color", "black");
            PPCComeOn();
        }
        function PPCComeOn() {
            var haveCCRequestCome = window.parent.parent.GetTextByName("CC_CALLREQUEST", window.parent.parent.useprameters.languagedata);//有呼叫请求进入
            for (var i = 0; i < document.frames["ppcgroupcallContent"].vissiList.length; i++) {
                if (document.frames["ppcgroupcallContent"].document.getElementById('sp_' + document.frames["ppcgroupcallContent"].vissiList[i].issi.toString()) != null) {
                    if (document.frames["ppcgroupcallContent"].document.getElementById('sp_' + document.frames["ppcgroupcallContent"].vissiList[i].issi.toString()).innerText.indexOf(haveCCRequestCome) >= 0) {
                        PPCCallComeOn();
                        break;
                    }
                }
            }
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div id="div1" style="position: absolute; top: 0px; left: 10px; width: 31px; display: none;">
        <table style="width: 31px; height: 200px" border="0" cellspacing="0" cellpadding="0">
            <tr style="height: 69px">
                <td id="tdsingleCall" background="../images/upcall/single1.png" align="right">
                    <span style="cursor: pointer; width:1px" onclick="singcallpanal2()" id="spSingCall"><%--单<br />呼 --%></span>
                </td>
            </tr>
            <tr style="height: 69px">
                <td id="tdppcCall" background="../images/upcall/single2.png" align="right">
                    <span id="spGroupCall" style="cursor: pointer;" onclick="groupcallpanal2()"><%--组<br />呼--%></span>
                </td>
            </tr>
            <tr style="height: 69px;">
                <td id="tdGroupCall" background="../images/upcall/single3.png" align="right">
                    <span id="spPPCCall" style="cursor: pointer;" onclick="PPCGroupCallPanal2()"><%--紧<br />急--%></span>
                </td>
            </tr>
            <tr style="height: 15px; cursor: pointer">
                <td background="../images/upcall/ls22.png" onclick="ShowCallPanal()" align="center">
                    &nbsp;
                </td>
            </tr>
        </table>
    </div>
    <div id="div2">
        <div id="divleft" style="position: absolute; top: 0; left: 0; width: 31px; height: 250px">
            <table style="width: 31px; height: 200px" border="0" cellspacing="0" cellpadding="0">
                <tr style="height: 69px">
                    <td id="tdsingleCall1" background="../images/upcall/single1.png" align="right">
                        <span id="spSingCall1" onclick="singcallpanal()" style="cursor: pointer; width:40px;height:25px;"><%--单<br />呼--%></span>
                    </td>
                </tr>
                <tr style="height: 69px">
                    <td id="tdppcCall1" background="../images/upcall/single2.png" align="right">
                        <span id="spGroupCall1" style="cursor: pointer;" onclick="groupcallpanal()"><%--组<br />呼--%></span>
                    </td>
                </tr>
                <tr style="height: 69px;">
                    <td id="tdGroupCall1" background="../images/upcall/single3.png" align="right">
                        <span id="spPPCCall1" onclick="PPCGroupCallPanal()" style="cursor: pointer;"><%--紧<br />急--%></span>
                    </td>
                </tr>
                <tr style="height: 15px; cursor: pointer">
                    <td background="../images/upcall/ls1.png" onclick="HideCallPanal()" align="center">
                        &nbsp;
                    </td>
                </tr>
            </table>
        </div>
        <table style="background-color: #0072bc; width: 290px; height: 250px; top: 0; left: 31px;
            position: absolute" border="0" cellspacing="0" cellpadding="0">
            <tr style="width: 100%; height: 5px"><td></td> <td> </td></tr>
            <tr style="height:20px;background-color:white"><td><div style="margin-right:20px;display:inline"><span id="allVoice"></span>: <img id="allVoiveImg" style="cursor:pointer" alt="" src ="../img/loud.png" onclick ="changeAllVoice();"/></div></td><td>                </td></tr>
            <tr>
                <td align="center">
                    <div id="singcallpanel" style="position: absolute; top: 25px">
                        <iframe id="singlecallContent" name="singlecallContent" src="../callPanal/SingCallPanal.aspx"
                            width="100%" allowtransparency="true" scrolling="auto" style="padding-bottom: 0px;"
                            frameborder="0" height="220px"></iframe>
                    </div>
                    <div id="groupcallpanel" style="position: absolute; top: 25px; display: none">
                        <iframe id="groupcallContent" name="groupcallContent" src="../callPanal/GroupCallPanal.aspx"
                            width="100%" allowtransparency="true" scrolling="auto" style="padding-bottom: 0px;"
                            frameborder="0" height="220px"></iframe>
                    </div>
                    <div id="ppcgroupcallpanel" style="position: absolute; top: 25px; display: none">
                        <iframe id="ppcgroupcallContent" name="ppcgroupcallContent" src="../callPanal/PPCGroupCallPanal.aspx"
                            width="100%" allowtransparency="true" scrolling="auto" style="padding-bottom: 0px;"
                            frameborder="0" height="220px"></iframe>
                    </div>
                </td>  <td></td>
            </tr>
            <tr style="width: 100%; height: 5px">
                <td>
                </td>
                <td>
                </td>
            </tr>
        </table>
    </div>
    </form>
    <script type="text/javascript">
        document.getElementById("allVoice").innerHTML = window.parent.parent.GetTextByName("allVoice", window.parent.parent.useprameters.languagedata);
        function changeAllVoice() {
            document.frames["groupcallContent"].changeAllVoiceAndPicture();
        }
        function changeallVoiveImg(isAllMute) {
            if (isAllMute) {
                document.getElementById("allVoice").src = "../img/mute.png";
            }
            else {
                document.getElementById("allVoice").src = "../img/loud.png";
            }
        }
    </script>
</body>
</html>
