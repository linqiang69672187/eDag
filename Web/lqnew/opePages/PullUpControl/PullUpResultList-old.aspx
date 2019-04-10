<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PullUpResultList.aspx.cs" Inherits="Web.lqnew.opePages.PullUpControl.PullUpResultList" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
 <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title><%--接收号码--%></title>
    <link href="../../css/lq_manager.css" rel="stylesheet" />
    <link href="../../../CSS/pagestyle.css" rel="stylesheet" />
    <style type="text/css">
        body, .style1 {
            background-color: transparent;
            margin: 0px;
            font-size: 12px;
            scrollbar-face-color: #DEDEDE;
            scrollbar-base-color: #F5F5F5;
            scrollbar-arrow-color: black;
            scrollbar-track-color: #F5F5F5;
            scrollbar-shadow-color: #EBF5FF;
            scrollbar-highlight-color: #F5F5F5;
            scrollbar-3dlight-color: #C3C3C3;
            scrollbar-darkshadow-Color: #9D9D9D;
        }

        .style2 {
            width: 10px;
        }

        .bg1 {
            background-image: url('../../view_infoimg/images/bg_02.png');
            background-repeat: repeat-x;
            vertical-align: top;
        }

        .bg2 {
            background-image: url('../../view_infoimg/images/bg_10.png');
            background-repeat: repeat-x;
        }

        .bg3 {
            background-image: url('../../view_infoimg/images/bg_05.png');
            background-repeat: repeat-y;
        }

        .bg4 {
            background-image: url('../../view_infoimg/images/bg_06.png');
        }

        .bg5 {
            background-image: url('../../view_infoimg/images/bg_07.png');
            background-repeat: repeat-y;
        }

        #divClose {
            width: 33px;
            height: 16px;
            position: relative;
            border: 0px;
            float: right;
            margin-top: 1px;
            background-image: url('../../view_infoimg/images/minidict_03.png');
            cursor: hand;
        }

        .gridheadcss th {
            background-image: url(../images/tab_14.gif);
            height: 25px;
        }

        #GridView1, #GridView12 {
            margin-top: 3px;
            font-size: 12px;
        }

        .td1td {
            background-color: #FFFFFF;
            text-align: right;
        }

        .divgrd {
            margin: 2 0 2 0;
            overflow: auto;
            height: 365px;
        }

        #tags {
            width: 99px;
        }

        .style3 {
            width: 37px;
        }
    </style>

    <script src="../../../JQuery/jquery-1.5.2.js" type="text/javascript"></script>
    <script src="../../../JQuery/jquery-ui-autocomplete.js" type="text/javascript"></script>
    <link href="../../../CSS/jquery-ui-1.8.14.custom.css" rel="stylesheet" type="text/css" />
    <script src="../../../JS/LangueSwitch.js"></script>
    <link href="../../../CSS/ui-lightness/jquery-ui-1.8.13.custom.css" rel="stylesheet"
        type="text/css" />
    <script src="../../../JQuery/jquery-ui-1.8.13.custom.min.js" type="text/javascript"></script>
    
    <%if (System.Configuration.ConfigurationManager.AppSettings["defaultLanguage"] == "zh-CN")
      { %>
    <script src="../../../JQuery/ui.datepicker-zh-CN.js" type="text/javascript"></script>
    <%} %>
    <script type="text/javascript">
        function changeTwoDecimal(x) {
            var f_x = parseFloat(x);
            if (isNaN(f_x)) {
                alert('function:changeTwoDecimal->parameter error');
                return false;
            }
            var f_x = Math.round(x * 100) / 100;

            return f_x;
        }
        var LangSureTOCancelDoing = window.parent.GetTextByName("LangSureTOCancelDoing", window.parent.useprameters.languagedata);
        var LangYouHaveCancel = window.parent.GetTextByName("LangYouHaveCancel", window.parent.useprameters.languagedata);
        var LangAddDTMemberTODTGroup = window.parent.GetTextByName("LangAddDTMemberTODTGroup", window.parent.useprameters.languagedata);
        var LangDelDtMemberFromDTGroup = window.parent.GetTextByName("LangDelDtMemberFromDTGroup", window.parent.useprameters.languagedata);
        var LangHaveDoingCount = window.parent.GetTextByName("LangHaveDoingCount", window.parent.useprameters.languagedata);
        var LangHaveDoingPercent = window.parent.GetTextByName("LangHaveDoingPercent", window.parent.useprameters.languagedata);
        var LangRemainDoingTime = window.parent.GetTextByName("LangRemainDoingTime", window.parent.useprameters.languagedata);
        var LangHaveDoingSUCEESSCount = window.parent.GetTextByName("LangHaveDoingSUCEESSCount", window.parent.useprameters.languagedata);
        var LangHaveDoingSUCEESSPercent = window.parent.GetTextByName("LangHaveDoingSUCEESSPercent", window.parent.useprameters.languagedata);
        var LangHaveDoingFailedCount = window.parent.GetTextByName("LangHaveDoingFailedCount", window.parent.useprameters.languagedata);
        var LangHaveDoingFailedPercent = window.parent.GetTextByName("LangHaveDoingFailedPercent", window.parent.useprameters.languagedata);
        var LangUnKnownCount = window.parent.GetTextByName("LangUnKnownCount", window.parent.useprameters.languagedata);
        var LangUnKnownPercent = window.parent.GetTextByName("LangUnKnownPercent", window.parent.useprameters.languagedata);
        var LangUnHaveDoingCount = window.parent.GetTextByName("LangUnHaveDoingCount", window.parent.useprameters.languagedata);
        var LangUnHaveDoingPercent = window.parent.GetTextByName("LangUnHaveDoingPercent", window.parent.useprameters.languagedata);
        var LangThisRWHaveOver = window.parent.GetTextByName("LangThisRWHaveOver", window.parent.useprameters.languagedata);
        var Lang_PullUp_Success = window.parent.GetTextByName("Success", window.parent.useprameters.languagedata);
        var Lang_PullUp_Failed = window.parent.GetTextByName("Failed", window.parent.useprameters.languagedata);
        var Lang_PullUp_Unkown = window.parent.GetTextByName("Unkown", window.parent.useprameters.languagedata);

        var thisSendTDGFlashTime = parseFloat(window.parent.sendTDGFlashTime) / 1000;
        function CancalDo() {
            if (!confirm(LangSureTOCancelDoing + "?")) {
                return;
            }
            window.parent.clear_pullupcontral_run();
            document.getElementById("resultContent").innerHTML += "<br>" + LangYouHaveCancel;
            document.getElementById("qxzx").style.display = "none";
        }

        function toHTML(totalcount, havedocount, openorclose, cjarry, sbarry) {

            //if (totalcount == sbarry.length + cjarry.length)
            //{
            //    for (var i = 0; i < cjarry.length; i++) {
            //        document.getElementById("GPSPullDetailInfo").innerHTML += cjarry[i] + "    成功" + "<br>";
            //    }

            //    for (var i = 0; i < sbarry.length; i++) {
            //        var detail = sbarry[i].toString().split(','); 
            //        document.getElementById("GPSPullDetailInfo").innerHTML += detail[0] + "  " + detail[1] + "<br>";
            //    }
            //}
 
            
            var cjcount = cjarry.length;
            var sbcount = sbarry.length;
            var strtitle = "";
            var wcgs = "";
            var otherstr = "";

            if (havedocount >= totalcount) {
                havedocount = totalcount;
            } else {
                havedocount = parseFloat(havedocount) + 1;
            }
            var wzarraycount = totalcount - parseFloat(cjcount) - parseFloat(sbcount);//开关操作未知个数=总数量-成功-失败
          
            var haveokpercent = changeTwoDecimal((parseFloat(parseFloat(havedocount) / parseFloat(totalcount))) * 100);

            wcgs += LangHaveDoingCount + ":" + havedocount + "/" + totalcount;
            wcgs += "   " + LangHaveDoingPercent + ":" + haveokpercent + "%";
            otherstr += LangRemainDoingTime + ":" + (parseFloat(totalcount) - parseFloat(havedocount)) * thisSendTDGFlashTime + "S";

            otherstr += "<br>" + Lang_PullUp_Success + ":" + cjcount;
            otherstr += "   " + LangHaveDoingSUCEESSPercent + ":" + changeTwoDecimal((parseFloat(parseFloat(cjcount) / parseFloat(totalcount))) * 100) + "%";

            otherstr += "<br>" + Lang_PullUp_Failed + ":<span id='span_sb'>" + sbcount + "</span>";
            otherstr += "   " + LangHaveDoingFailedPercent + ":" + changeTwoDecimal((parseFloat(parseFloat(sbcount) / parseFloat(totalcount))) * 100) + "%";

            otherstr += "<br>" + Lang_PullUp_Unkown + ":" + wzarraycount;
            otherstr += "   " + LangUnKnownPercent + ":" + changeTwoDecimal((parseFloat(parseFloat(wzarraycount) / parseFloat(totalcount))) * 100) + "%";
 
            document.getElementById("divtitle").innerHTML = strtitle;
            document.getElementById("wcgs").innerHTML = wcgs;
            document.getElementById("span_ok").style.width = haveokpercent * thisSendTDGFlashTime + "px";
            document.getElementById("span_ok").title = LangHaveDoingCount + ":" + havedocount + ";" + LangHaveDoingPercent + ":" + haveokpercent + "%";

            document.getElementById("span_un").style.width = (200.0 - haveokpercent * thisSendTDGFlashTime) + "px";
            document.getElementById("span_un").title = LangUnHaveDoingCount + ":" + (parseFloat(totalcount) - parseFloat(havedocount)) + ";" + LangUnHaveDoingPercent + ":" + (100 - haveokpercent) + "%";

            document.getElementById("resultContent").innerHTML = otherstr;
            if (totalcount == havedocount || document.getElementById("divClose").style.display != "none") {
                document.getElementById("qxzx").style.display = "none";
            }
            else {
                document.getElementById("qxzx").style.display = "block";
            }
        }

        function toshowclosebtn() {
            document.getElementById("divClose").style.display = "block";
        }
        function tohidclosebtn() {
            document.getElementById("divClose").style.display = "none";
        }
        window.onload = function () {
            document.onmousedown = function () {
                var div1 = window.parent.document.getElementById('PullUpControl/PullUpResultList');
                window.parent.windowDivOnClick(div1);
            }
            document.getElementById("derppp").onmousedown = function () { dragdiv(); }
            document.getElementById("derppp").onmousemove = function () { mydragWindow(); }
            document.getElementById("derppp").onmouseup = function () { mystopDragWindow(); }
            document.body.oncontextmenu = function () { return false; }
            document.body.oncontextmenu = function () { return false; }
            var arrayelement = ["input", "a", "select", "li", "font", "textarea", "option"];
            for (n = 0; n < arrayelement.length; n++) {
                var inputs = document.getElementsByTagName(arrayelement[n]);
                for (i = 0; i < inputs.length; i++) {
                    inputs[i].onmouseout = function () {
                        dragEnable = 'True';
                    }
                    inputs[i].onmouseover = function () {
                        dragEnable = 'False';
                    }
                    inputs[i].onmousedown = function () {
                        dragEnable = 'False';
                    }
                    inputs[i].onmouseup = function () {
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
            var tbdiv = document.getElementById("tbtbz");
            if (tbdiv) {
                tbdiv.onmouseout = function () {
                    dragEnable = 'True';
                }
                tbdiv.onmouseover = function () {
                    dragEnable = 'False';
                }
            }

        }



        function Divover(str) {
            var div1 = document.getElementById("divClose");
            if (str == "on") { div1.style.backgroundPosition = "66 0"; }
            else { div1.style.backgroundPosition = "0 0"; }
        }

        document.oncontextmenu = new Function("event.returnValue=false;"); //禁止右键功能,单击右键将无任何反应
        document.onselectstart = new Function("event.returnValue=false;"); //禁止先择,也就是无法复制
        Request = {
            QueryString: function (item) {
                var svalue = location.search.match(new RegExp("[\?\&]" + item + "=([^\&]*)(\&?)", "i"));
                return svalue ? svalue[1] : svalue;
            }
        }


        function closethispage() {
            if (Request.QueryString("selfclose") != undefined) {
                window.parent.hiddenbg2();
            }
            window.parent.lq_closeANDremovediv('PullUpControl/PullUpResultList', 'bgDiv');
        }


        var dragEnable = 'True';
        function dragdiv() {
            var div1 = window.parent.document.getElementById('PullUpControl/PullUpResultList');
            if (div1 && event.button == 1 && dragEnable == 'True') {
                window.parent.mystartDragWindow(div1, null, event); div1.style.border = "solid 0px transparent"; window.parent.cgzindex(div1);

            }
        }
        function mydragWindow() {
            var div1 = window.parent.document.getElementById('PullUpControl/PullUpResultList');
            if (div1) {
                window.parent.mydragWindow(div1, event);
            }
        }

        function mystopDragWindow() {
            var div1 = window.parent.document.getElementById('PullUpControl/PullUpResultList');
            if (div1) {
                window.parent.mystopDragWindow(div1); div1.style.border = "0px";
            }
        }
    </script>

    <script src="../../js/geturl.js" type="text/javascript"></script>
</head>
    <body>
    <form id="form1" runat="server">

        <table class="style1" cellpadding="0" cellspacing="0">
            <tr style="height: 5px;" id="derppp">
                <td class="style2">
                    <img src="../../images/tab_03.png" width="15" height="32" /></td>
                <td background="../../images/tab_05.gif">
                    <div id="divClose" style="display: none" onmouseover="Divover('on')" onclick="closethispage()" onmouseout="Divover('out')"></div>
                </td>
                <td class="style2">
                    <img src="../../images/tab_07.png" width="14" height="32" /></td>
            </tr>
            <tr>
                <td width="15" background="../../images/tab_12.gif">&nbsp;
                </td>
                <td class="bg4" id="dragtd">
                    <div style="width: 400px; height: 150px">
                        <div id="divtitle"></div>
                        <div id="wcgs"></div>
                        <table cellspacing="1" cellpadding="0" id="GridView1" style="border-color: White; border-width: 0px; border-style: Ridge; width: 390px; font-size: 12px">
                            <tr class="gridheadcss" style="width: 390px; height: 10px">
                                <td>
                                    <span id="LangHaveOverPregrss"></span>:
                                    <span id="span_ok" style="background-color: green; width: 0px; height: 8px;display:block;"></span>
                                    <span id="span_un" style="background-color: yellow; width: 200px; height: 8px;display:block;"></span>
                                </td>
                            </tr>
                        </table>
                        <div id="resultContent"></div>
                        <input type="button" id="qxzx" onclick="CancalDo()" value="" />
                    </div>

                </td>
                <td width="14" background="../../images/tab_16.gif">&nbsp;
                </td>
            </tr>
            <%--<tr style="height: 15px;">
                <td width="15" background="../../images/tab_12.gif">&nbsp;
                </td>
                <th  class="bg4">详细信息</th>
                <td width="14" background="../../images/tab_16.gif">&nbsp;
                </td>
            </tr>
            <tr style="height: 15px;">
                <td width="15" background="../../images/tab_12.gif">&nbsp;
                </td>
                <td  class="bg4">
                    <div id="GPSPullDetailInfo" style="height:100px;overflow:auto;"></div>
                </td>
                <td width="14" background="../../images/tab_16.gif">&nbsp;
                </td>
            </tr>--%>
            <tr style="height: 15px;">
                <td>
                    <img src="../../images/tab_20.png" width="15" height="15" /></td>
                <td background="../../images/tab_21.gif"></td>
                <td>
                    <img src="../../images/tab_22.png" width="14" height="15" /></td>
            </tr>
        </table>
    </form>
</body>
</html>
<script>
    window.parent.closeprossdiv();
    LanguageSwitch(window.parent.parent);
    document.getElementById("qxzx").value = window.parent.GetTextByName("LangBtnToCancelDoing", window.parent.useprameters.languagedata);


</script>
