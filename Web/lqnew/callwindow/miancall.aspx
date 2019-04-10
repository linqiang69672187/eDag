<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="miancall.aspx.cs" Inherits="Web.lqnew.callwindow.miancall" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        body
        {
            background-color: transparent;
            margin: 0px;
            text-align: center;
        }

        #bg
        {
            width: 399px;
            height: 92px;
            background-image: url(bgup.gif);
            background-repeat: no-repeat;
            position: absolute;
            top: 67px;
        }

        table td
        {
            text-align: center;
            vertical-align: middle;
            font-size: 12px;
        }

        #tb1
        {
            margin-top: -4px;
        }

        .style1
        {
            width: 100%;
        }

        #call1
        {
            width: 99px;
            height: 57px;
            /*background: url(groupcall.png) no-repeat;*/
            line-height: 21px;
            cursor: pointer;
            margin-left: auto;
            margin-right: auto;
        }

        #call2
        {
            width: 99px;
            height: 57px;
            /*background: url(siglecall.png) no-repeat 0px 0px;*/
            line-height: 21px;
            cursor: hand;
            margin-left: auto;
            margin-right: auto;
        }

        #call4
        {
            width: 57px;
            height: 57px;
            background: url(button.gif) no-repeat -61px 0;
            line-height: 57px;
            cursor: hand;
            margin-left: auto;
            margin-right: auto;
        }

        .style4
        {
            width: 37px;
            margin-top: 7px;
            height: 43px;
        }

        #leftinfodivgroup, #singlecalltype
        {
            position: absolute;
            width: 90px;
            background: #e0e7ed;
            padding: 3px;
            border: 1px solid #5c731e;
            display: none;
            left: 265px;
            z-index: 100;
            top: 0px;
        }

            #leftinfodivgroup li, #singlecalltype li
            {
                display: block;
                height: 20px;
                position: relative;
                font-size: 12px;
            }

            #leftinfodivgroup ul, #singlecalltype ul
            {
                padding: 0;
                margin: 0;
            }

        .outstyle
        {
            display: block;
            font-size: 12px;
            height: 20px;
            width: 88px;
            line-height: 18px;
            text-indent: 5px;
            color: #000;
            text-decoration: none;
            border: 1px solid #e0e7ed;
        }

        .overstyle
        {
            background: #6a812c;
            color: #fff;
            border-color: #fff;
        }

        a
        {
            display: block;
            font-size: 12px;
            height: 20px;
            width: 88px;
            line-height: 18px;
            text-indent: 5px;
            color: #000;
            text-decoration: none;
            border: 1px solid #e0e7ed;
        }

        #bgDiv
        {
            width: 365px;
            height: 100px;
            display: none;
            position: absolute;
            top: 20px;
            left: 17px;
            right: 0px;
            background-color: #000000;
            color: #ffffff;
            vertical-align: middle;
            line-height: 100px;
            z-index: 2000;
            filter: progid:DXImageTransform.Microsoft.Alpha(opacity=50);
        }

        ul, li
        {
            text-decoration: none;
            list-style: none;
            color: White;
            margin: 0;
            padding: 0;
        }

        #scrollDiv, #scrollDiv1
        {
            overflow: auto;
            display: none;
        }

        .scrollText
        {
            width: 99;
            height: 21px;
            min-height: 21px;
            line-height: 21px;
            float: none;
            overflow: hidden;
        }

            .scrollText li
            {
                height: 21px;
                padding-left: 10px;
                text-align: center;
            }

        span
        {
            color: White;
        }

        #MSN
        {
            position: absolute;
            z-index: 99;
            width: 320px;
            height: 20px;
            top: 63px;
            left: 40px;
            font-size: 12px;
            color: White;
        }

            #MSN ul
            {
                margin-top: 5px;
                text-align: center;
                list-style: none;
            }

        #scrollarea
        {
            margin-left: 5px;
            width: 320px;
            text-align: left;
        }
    </style>
    <script src="../../JQuery/jquery-1.5.2.js" type="text/javascript"></script>
    <script src="../js/jQuery.textSlider.js" type="text/javascript"></script>
    <script language="javascript" type="text/javascript">
        var calltype = 0; //0全双工，1半双工
        var arry;
        function changeimg(value) {
            var bgimg = document.getElementById("bgimg");
            if (value == 1) {  //移进
                if (bgimg.src.indexOf("down") > 0) {
                    bgimg.src = "../logwindow/pic/down_un.gif";
                }
                else {
                    bgimg.src = "../logwindow/pic/up_un.gif";
                }
            }
            else //移出
            {
                if (bgimg.src.indexOf("down") > 0) {
                    bgimg.src = "../logwindow/pic/down.gif";
                }
                else {
                    bgimg.src = "../logwindow/pic/up.gif";
                }
            }
        }

        function closebg(click) {
            if (click == "click" && $("#bgimg").attr("src").indexOf("down") > 0)         /**单击呼叫栏已打开**/
                return;
            if ($("#bgimg").attr("src").indexOf("down") > 0 && (window.parent.useprameters.Selectid.length < 1 || window.parent.useprameters.callActivexable == false)) {
                $("#bgDiv").hide(); //隐藏遮罩背景
                $("#bg").animate({ top: 107 }, 500, function () {
                    $("#bgimg").attr("src", "../logwindow/pic/up.gif");
                    $("#bg").css("backgroundImage", "url(bgup.gif)");
                    $("#bg").animate({ top: 67 }, 500);
                    $("#MSN").animate({ top: 63 }, 500);
                });
            }
            else {
                $("#bg").animate({ top: 107 }, 500, function () {
                    $("#bg").css("backgroundImage", "url(bg.gif)");
                    $("#bg").animate({ top: 0 }, 500, function () {
                        $("#bgimg").attr("src", "../logwindow/pic/down.gif")
                        $("#MSN").animate({ top: 0 }, 500);
                        if (!window.parent.useprameters.callActivexable) {
                            $("#bgDiv").show(); //显示遮罩背景
                        }
                    });
                });
            }
        }

        function openleftwindowpc() {

            if (window.parent.useprameters.SelectISSI.length != 1) {
                alert(window.parent.GetTextByName("ToSelectUser", window.parent.useprameters.languagedata));//请选中一个用户
                return;
            }

            if ($("#call2").css("backgroundImage").indexOf(window.parent.GetTextByName("maincall_btn_img_name_callfinish", window.parent.useprameters.languagedata)) > 0) {//callfinish.png
                switch (calltype) {
                    case 0:
                        window.parent.endDC(); //调用全双工单呼结束
                        break;
                    case 1:
                        window.parent.endSC(); //调用半双工单呼结束
                        break;
                }
                return;
            }

            if ($("#call2").css("backgroundImage").indexOf(window.parent.GetTextByName("maincall_btn_img_name_siglecall", window.parent.useprameters.languagedata)) > 0) {//siglecall.png
                $("#leftinfodivgroup").fadeIn(500);
            }

            if ($("#call2").css("backgroundImage").indexOf(window.parent.GetTextByName("maincall_btn_img_name_receivecall", window.parent.useprameters.languagedata)) > 0) {//receivecall.png
                if (event.x >= 255 && event.y <= 40) {
                    $("#singlecalltype").fadeIn(500);
                }
                else {
                    //操作窗口已发起呼叫
                    if (window.parent.callPanalISSI != "" || window.parent.ppcCallingIssi != "") {
                        alert(window.parent.GetTextByName("HasCallingPleaseWaiting", window.parent.useprameters.languagedata));//已发起一个呼叫，请结束后再接听
                        return;
                    }
                    if (window.parent.document.frames["PrivateCall"] != null || window.parent.document.frames["PrivateCall"] != undefined) {
                        window.parent.mycallfunction('PrivateCall', 380, 280);
                    }
                    window.parent.startDC(); //接听呼叫
                    $("#call2").css("backgroundImage", "url(" + window.parent.GetTextByName("maincall_btn_img_src_callfinish", window.parent.useprameters.languagedata) + ")");//callfinish.png
                }
            }

        }
        function Ssinglecall()//开始全双工单呼
        {
            if (window.parent.useprameters.eTramsg == window.parent.GetTextByName("LINK_DISCONNECT", window.parent.useprameters.languagedata) || window.parent.useprameters.callActivexable == false) {//链路断开
                alert(window.parent.GetTextByName("Callcontrolisnotavailable", window.parent.useprameters.languagedata));//呼叫控件不可用
                window.parent.writeLog("oper", "[" + window.parent.GetTextByName("SingleCALL(all)", window.parent.useprameters.languagedata) + "]:" + window.parent.GetTextByName("Callcontrolisnotavailable", window.parent.useprameters.languagedata) + "[" + window.parent.LOGTimeGet() + "]");         /**日志：操作日志 **/
                //单呼(全);呼叫控件不可用
                return;
            }
            //操作窗口已发起呼叫 
            if (window.parent.callPanalISSI != "" || window.parent.ppcCallingIssi != "") {
                alert(window.parent.GetTextByName("HasCallingPleaseWaiting", window.parent.useprameters.languagedata));//
                window.parent.writeLog("oper", "[" + window.parent.GetTextByName("SingleCALL(all)", window.parent.useprameters.languagedata) + "]:" + window.parent.GetTextByName("HasCallingPleaseWaiting", window.parent.useprameters.languagedata) + "[" + window.parent.LOGTimeGet() + "]");         /**日志：操作日志 **/
                return;
            }

            if (window.parent.document.frames["PrivateCall"] != null || window.parent.document.frames["PrivateCall"] != undefined) {
                window.parent.mycallfunction('PrivateCall', 380, 280);
            }

            calltype = 0;
            window.parent.startDC();

            //            var div = document.getElementById("scrollDiv");
            //            div.style.display = "none";
            document.getElementById("singal1").innerHTML = window.parent.GetTextByName("TellMode", window.parent.useprameters.languagedata);//电话模式
            // window.parent.useprameters.SelectGSSI = "";
            $("#call2").css("backgroundImage", "url(" + window.parent.GetTextByName("maincall_btn_img_src_callfinish", window.parent.useprameters.languagedata) + ")");//callfinish

            $("#leftinfodivgroup").fadeOut(500);

        }

        function Spttcall() {//开始半双工单呼
            //操作窗口已发起呼叫 
            if (window.parent.callPanalISSI != "" || window.parent.ppcCallingIssi != "") {
                alert(window.parent.GetTextByName("HasCallingPleaseWaiting", window.parent.useprameters.languagedata));//已发起一个呼叫，请结束后再发起
                window.parent.writeLog("oper", "[" + window.parent.GetTextByName("SingleCALL(half)", window.parent.useprameters.languagedata) + "]:" + window.parent.GetTextByName("HasCallingPleaseWaiting", window.parent.useprameters.languagedata) + "[" + window.parent.LOGTimeGet() + "]");         /**日志：操作日志 **/
                //SingleCALL(half)[单呼(半)]
                return;
            }

            if (window.parent.document.frames["PrivateCall"] != null || window.parent.document.frames["PrivateCall"] != undefined) {
                window.parent.mycallfunction('PrivateCall', 380, 280);
            }
            calltype = 1;
            window.parent.startSC();
            //            var div = document.getElementById("scrollDiv");
            //            div.style.display = "none";
            document.getElementById("singal1").innerHTML = window.parent.GetTextByName("PTTMode", window.parent.useprameters.languagedata);//对讲模式
            //    window.parent.useprameters.SelectGSSI = "";
            $("#call2").css("backgroundImage", "url(" + window.parent.GetTextByName("maincall_btn_img_src_callfinish", window.parent.useprameters.languagedata) + ")");//callfinish
            $("#leftinfodivgroup").fadeOut(500);
        }
        var lastvalue = "";
        function pttD() {
            if ($("#call2").css("backgroundImage").indexOf(window.parent.GetTextByName("maincall_btn_img_name_callfinish", window.parent.useprameters.languagedata)) > 0 && calltype == 1) {//callfinish
                $("#call4").css("backgroundPosition", "0 0");
                window.parent.startSC();
                // var div = document.getElementById("scrollDiv");
                //div.style.display = "none";
                return;
            } //企图获取单呼授权
            if (window.parent.useprameters.SelectGSSI != "") {
                $("#call4").css("backgroundPosition", "0 0");
                window.parent.startGC();
                //  var div1 = document.getElementById("scrollDiv1");
                // div1.style.display = "none";
                return;
            } //企图获取组呼授权
            alert(window.parent.GetTextByName("PTTUnuseable", window.parent.useprameters.languagedata));//PTTUnuseable PPT不可用
        }
        function pttU() {
            $("#call4").css("backgroundPosition", "-61px 0");
            if ($("#call2").css("backgroundImage").indexOf(window.parent.GetTextByName("maincall_btn_img_name_callfinish", window.parent.useprameters.languagedata)) > 0 && calltype == 1) {//callfinish
                $("#call4").css("backgroundPosition", "-61px 0"); window.parent.sceasedPTT()//释放单呼授权
                return;
            }
            $("#call4").css("backgroundPosition", "-61px 0"); window.parent.gceasedPTT()//释放组呼授权
            return;
        }

        function groupcallrelease() {
            $("#call2").css("backgroundPosition", "-61px 0");
            if ($("#mygroupcall").attr("src") == window.parent.GetTextByName("maincall_btn_img_src_finishcall", window.parent.useprameters.languagedata)) {//../images/finishcall.png
                window.parent.gceasedPTT()//释放组呼授权
            }
        }
        function groupcall() { //根据图片执行方法
            if ($("#call2").css("backgroundImage").indexOf(window.parent.GetTextByName("maincall_btn_img_name_callfinish", window.parent.useprameters.languagedata)) > 0) {//callfinish.png
                alert(window.parent.GetTextByName("PleaseEndOtherCall", window.parent.useprameters.languagedata));//请结束其它呼叫 
                return;
            }
            if (window.parent.useprameters.SelectISSI.length != 1) {
                alert(window.parent.GetTextByName("ToSelectUser", window.parent.useprameters.languagedata));//请选中一个用户
                return;
            }

            var mygroupcall_src = $("#mygroupcall").attr("src");
            if (mygroupcall_src == window.parent.GetTextByName("maincall_btn_img_src_finishcall", window.parent.useprameters.languagedata))//finishcall.png
            {
                window.parent.endGC();
            }
            else if (mygroupcall_src == window.parent.GetTextByName("maincall_btn_img_src_Receiver", window.parent.useprameters.languagedata))//Receiver
            {
                window.parent.recevieGC();
            }
            else {
                window.parent.GetGSSIbyISSI(window.parent.useprameters.SelectISSI[0]);
                window.parent.useprameters.bzGSSI = "";
            }
            /*
            switch ($("#mygroupcall").attr("src")) {
                case "../images/thisgroup.png":
                    window.parent.GetGSSIbyISSI(window.parent.useprameters.SelectISSI[0]);
                    window.parent.useprameters.bzGSSI = "";
                    break;
                case "../images/finishcall.png":
                    window.parent.endGC();
                    break;
                case "../images/Receiver.png":
                    window.parent.recevieGC();
                    break;

            }
            */
        }
        function creatGroupdiv(obj) { //创建编组窗口

            var array = new Array();
            for (var group in obj) {
                var temp1 = {};
                temp1[0] = function (arg, mousetype, name) {
                    window.parent.useprameters.SelectGSSI = arg.split('|')[0];
                    innerhtmltoele("group1", name);
                    innerhtmltoele("group2", arg);

                    if (mousetype == 'down') {
                    }
                    else {
                        //$("#bzmenu", window.parent.document).fadeOut(500);
                        window.parent.document.getElementById("bzmenu").style.display = "none";
                    }
                };
                if (obj[group].GSSI != undefined) {                //fun
                    temp1[1] = obj[group].GSSI; //arg
                    temp1[2] = obj[group].groupname; //name
                    array.push(temp1);
                }
            }
            var removemenu = window.parent.document.getElementById("callrightMenu");
            if (removemenu) {
                window.parent.removeChildSafe(removemenu);
            }
            var obj = createMenu(array);
            var bzmenu = window.parent.document.getElementById("bzmenu");
            bzmenu.style.left = (parseFloat(window.parent.document.body.offsetWidth) - parseFloat(document.body.offsetWidth)) / 2 + 140;
            bzmenu.appendChild(obj);



        }


        function removetable(id) {
            var opanel = document.getElementById(id);
            var pchildren = opanel.childNodes;
            for (var a = 0; a < pchildren.length; a++) {
                opanel.removeChild(pchildren[a]);
            }

        }


        function GetGrouparray() {//获取全组GSSI列表
            window.parent.jquerygetNewData_ajax("../../WebGis/Service/GetGrouparraybyentiyID.aspx", null, function (request) {
                var _data = request;
                window.parent.useprameters.Grouparray = request;
                creatGroupdiv(request); //生成编组列表
            }, false, false);
        }
        function opengroupwindow() {
            if ($("#call2").css("backgroundImage").indexOf(window.parent.GetTextByName("maincall_btn_img_name_callfinish", window.parent.useprameters.languagedata)) > 0) {//callfinish
                alert(window.parent.GetTextByName("PleaseEndOtherCall", window.parent.useprameters.languagedata));// 请结束其它呼叫
                return;
            }
            if (window.parent.useprameters.Grouparray.length == 0) {
                alert(window.parent.GetTextByName("HasnoGroup", window.parent.useprameters.languagedata));// 不存在编组

                return;
            }
            //if (event.x > 110 && event.y < 40) {
            //$("#bzmenu", window.parent.document).fadeIn(100);
            window.parent.document.getElementById("bzmenu").style.display = "block";
            //   }
            //  else {
            //  window.parent.GetGSSIbyISSI(window.parent.useprameters.SelectISSI[0]);
            // }
        }

        $(document).ready(function () {

            //创建编组列表
            $("#scrollDiv,#scrollDiv1").textSlider({
                line: 1,
                speed: 500,
                timer: 3000
            });
        });

        function delObj(obj) {
            if (typeof (obj) == "string") {
                obj = document.getElementById(obj);
                obj.style.display = "none";
            }
        }
        //function checkcallimg() {
        //    try{
        //        var isCall = false;
        //        var mainSWF = window.parent.document.getElementById("main");
        //        if (mainSWF) {
        //            isCall = mainSWF.callbackCheckcallimg();
        //        }
        //        return isCall;

        //    }
        //    catch (e) {
        //        return isCall;
        //    }
        //    //if ($("#call2").css("backgroundImage").indexOf(window.parent.GetTextByName("maincall_btn_img_name_callfinish", window.parent.useprameters.languagedata)) > 0) {//callfinish
        //    //    return false;
        //    //}
        //    //return true;
        //}
        function createMenu(array) { //创建右键菜单
            if (!array) { return null; }
            var divContainer = document.getElementById("callrightMenu") || document.createElement("div");
            divContainer.style.cursor = "default";
            divContainer.style.borderStyle = "solid";
            divContainer.style.borderWidth = "1px";
            divContainer.style.borderColor = "green";
            divContainer.style.fontSize = "13px";
            divContainer.style.backgroundColor = "white";
            divContainer.id = "callrightMenu";
            divContainer.style.width = "90px";
            divContainer.style.position = "relative";
            divContainer.style.zIndex = 9999;
            for (var menu in array) {
                if (typeof (array[menu]) != "function") {
                    var divTr = document.createElement("div");
                    divTr.innerHTML = array[menu][2];
                    divTr.fun = array[menu][0];
                    divTr.arg = array[menu][1];
                    divTr.title = array[menu][1];
                    divTr.name = array[menu][2];
                    divTr.style.margin = "2px";
                    divContainer.appendChild(divTr);
                    divTr.onmouseover = function () {
                        window.parent.right_colorChange(this, 'green');
                        if (array[menu][2]) {
                            this.innerHTML = this.title;
                        }
                        this.style.color = 'white';
                    };
                    divTr.onmouseout = function () {
                        window.parent.right_colorChange(this, 'white');
                        this.innerHTML = this.name;
                        this.style.color = 'black';
                    };
                    divTr.onmousedown = function () {
                        this.fun(this.arg, 'down', this.name);
                    };
                    divTr.onmouseup = function () {
                        this.fun(this.arg, 'up', this.name);
                    };
                }

            }
            divContainer.onmouseleave = function () {
                //$("#bzmenu", window.parent.document).fadeOut(100);
                window.parent.document.getElementById("bzmenu").style.display = "none";
            };
            return divContainer;
        }
        $(document).ready(function () {
            document.onkeydown = function () {
                if (window.parent.useprameters.keyiIsUP == true && event.keyCode == 32) {
                    window.parent.useprameters.keyiIsUP = false;
                    pttD(); //调用PTT
                }
            }
            document.onkeyup = function () {
                if (window.parent.useprameters.keyiIsUP == false && event.keyCode == 32) {
                    window.parent.useprameters.keyiIsUP = true;
                    pttU() //释放PTT
                }
            }
        });

        function innerhtmltoele(id, text) {
            var div = document.getElementById("scrollDiv");
            div.style.display = "block";
            var div1 = document.getElementById("scrollDiv1");
            div1.style.display = "block";
            document.getElementById(id).innerHTML = text;
        }

        function restbackimg() {
            //                var div = document.getElementById("scrollDiv");
            //                div.style.display = "none";
            //                var div1 = document.getElementById("scrollDiv1");
            //                div1.style.display = "none";
            $("#call2").css("backgroundImage", "url(" + window.parent.GetTextByName("maincall_btn_img_src_siglecall", window.parent.useprameters.languagedata) + ")");//singlecall
        }
        window.onload = function () {
            GetGrouparray();
            
            document.oncontextmenu = function () {
                return false;
            }
        }

        function acceptAll() {
            //操作窗口已发起呼叫 
            if (window.parent.callPanalISSI != "" || window.parent.ppcCallingIssi != "") {
                
                alert(window.parent.GetTextByName("HasCallingPleaseWaiting", window.parent.useprameters.languagedata));//已发起一个呼叫，请结束后再接听
                return;
            }
            window.parent.startDC();
            $('#call2').css('backgroundImage', 'url(' + window.parent.GetTextByName("maincall_btn_img_src_callfinish", window.parent.useprameters.languagedata) + ')');//callfinish
        }

    </script>
</head>
<body onselectstart="return false">
    <center>
        <form id="form1" runat="server">
        <div id="bg" style="left: 0px;">
            <table width="345px" id="tb1" cellpadding="0" cellspacing="0" border="0">
                <tr>
                    <td style="height: 25px; width: 70px; vertical-align: middle; text-align: left;"><div id="callgif" style="background-image:url(call.gif); background-repeat:no-repeat;width:17px;height:16px;margin:0;padding:0px;"></div></td>
                    <td>
                    </td>
                    <td>
                    </td>
                    <td align="right" style="text-align: right;">
                        <img id="bgimg" style="cursor: hand;" onmouseover="changeimg(1)" onclick="closebg()"
                            onmouseout="changeimg(2)" src="../logwindow/pic/up.gif" />
                    </td>
                </tr>
                <tr>
                    <td style="height: 67px;" colspan="4">
                        <table class="style1">
                            <tr>
                                <td valign="middle" align="center"  style="width:130px;">
                                <div id="call1">
                                <table width="92px" cellpadding="0"  onclick="opengroupwindow()" cellspacing="0">
                                <tr style="height: 36px;"><td>&nbsp;&nbsp;</td></tr>
                                <tr style="height: 21px;">
                                    <td  align="center">
                               <div id="scrollDiv">
                               <div class="scrollText">
                                   <ul >
                                    <li id="group1" >选择组</li>
                                    <li id="group2" >PTT或空格呼叫</li>
                                    </ul>
                               </div>
                               </div>
                              <span id="groupspan">选择组</span>
                            </td></tr>
                                </table>
                                </div></td>
                                <td valign="middle" align="center" >
                                <div id="call2">
                            <table width="92px" cellpadding="0" cellspacing="0" onclick="openleftwindowpc()">
                                <tr style="height: 36px;"><td>&nbsp;&nbsp;</td></tr>
                                <tr style="height: 21px;">
                                    <td  align="center">                             
                             <div id="scrollDiv1">
                               <div class="scrollText">
                                   <ul >
                                    <li id="singal1" ></li>
                                    <li id="singal2" ></li>
                                    <li id="singal3" ></li>
                                    </ul>
                               </div>
                               </div>
                               <span id="singalspan">选择移动用户</span>
                            </td></tr>
                                </table>


                                </div></td>
                                <td valign="middle" style="width:85px;">
                                    <div id="call4"> <img id="myPTT"  title="按下鼠标(空格键)发起PTT,松开释放" onmousedown="pttD()"  onmouseup="pttU()" class="style4"  /></div><%--src="../images/ptt.png"--%>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </div>
        <div id="leftinfodivgroup" class="top" onmouseout="this.style.display='none'" onmouseover="this.style.display='block'">
            <ul style="width: 90px;">
                <li><a href="#GIS" id="Ssinglecall" onclick="Ssinglecall()" style="width: 90px" onmouseover="over(this)" onmouseout="out(this)" >电话模式</a></li>
                <li><a href="#GIS"  id="Spttcall"  onclick="Spttcall()" style="width: 90px" onmouseover="over(this)" onmouseout="out(this)">对讲模式</a></li>
            </ul>
        </div>
        <div id="MSN"><ul><li id="scrollarea"></li></ul></div>

         <%--编组按钮--%>
        <div id="singlecalltype" class="top" onmouseout="this.style.display='none'" onmouseover="this.style.display='block'">
            <ul style="width: 90px;">
                <li><a href="#GIS" id="acceptAll" onclick="acceptAll(); " style="width: 90px" onmouseover="over(this)" onmouseout="out(this)">接听</a></li>
                <li><a href="#GIS" id="endDC" onclick="window.parent.endDC();" style="width: 90px" onmouseover="over(this)" onmouseout="out(this)">结束</a></li>
            </ul>
        </div>
        <%--遮罩背景--%>
      <div id="bgDiv" onclick="onbgdivclick()"></div></form>
    </center>
</body>
<script type="text/javascript">
    document.body.onclick = function () {
        $("#smartMenu_mail", window.parent.parent.document).remove();
    }
    function over(obj) {
        var objs = ["Ssinglecall", "Spttcall", "acceptAll", "endDC"];
        $("#Ssinglecall").addClass("outstyle");
        $("#Spttcall").addClass("outstyle");
        $("#acceptAll").addClass("outstyle");
        $("#endDC").addClass("outstyle");
        $("#" + obj.id).addClass("overstyle");
    }
    function out(obj) {
        $("#" + obj.id).removeClass("overstyle");
        $("#" + obj.id).addClass("outstyle");
    }
    function onbgdivclick()
    {
        alert(window.parent.GetTextByName("Alert_OcxUnLoadCanNotCall", window.parent.useprameters.languagedata));
    }

    window.document.getElementById("myPTT").title = window.parent.GetTextByName("pptpictitle", window.parent.useprameters.languagedata);
    window.document.getElementById("singalspan").innerHTML = window.parent.GetTextByName("ToSelectUser", window.parent.useprameters.languagedata);
    window.document.getElementById("groupspan").innerHTML = window.parent.GetTextByName("ToSelectGroup", window.parent.useprameters.languagedata);
    window.document.getElementById("group1").innerHTML = window.parent.GetTextByName("ToSelectGroup", window.parent.useprameters.languagedata);
    window.document.getElementById("group2").innerHTML = window.parent.GetTextByName("PTTorPressBar", window.parent.useprameters.languagedata);

    window.document.getElementById("Ssinglecall").innerHTML = window.parent.GetTextByName("TellMode", window.parent.useprameters.languagedata); //电话模式
    window.document.getElementById("Spttcall").innerHTML = window.parent.GetTextByName("PTTMode", window.parent.useprameters.languagedata); //对讲模式
    window.document.getElementById("acceptAll").innerHTML = window.parent.GetTextByName("Toanswer", window.parent.useprameters.languagedata); //接听
    window.document.getElementById("endDC").innerHTML = window.parent.GetTextByName("TOend", window.parent.useprameters.languagedata); //结束

    window.document.getElementById("myPTT").src = window.parent.GetTextByName("maincall_btn_img_src_ptt", window.parent.useprameters.languagedata);
    window.document.getElementById("call1").style.background = "url(" + window.parent.GetTextByName("maincall_btn_img_src_groupcall", window.parent.useprameters.languagedata) + ") no-repeat";
    window.document.getElementById("call2").style.background = "url(" + window.parent.GetTextByName("maincall_btn_img_src_siglecall", window.parent.useprameters.languagedata) + ") no-repeat 0px 0px";


</script>

</html>
<script type="text/javascript">
    window.parent.isLoadMain = "main";

</script>