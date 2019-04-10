<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="mian.aspx.cs" Inherits="Web.lqnew.logwindow.mian" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        body
        {
            margin: 0px;
            font-size: 12px;
            background-color: transparent;
        }

        #div1
        {
            position: absolute;
            top: 0px;
            left: 3px;
            margin-left: 0px;
            z-index: 2;
        }

        #div2
        {
            position: absolute;
            top: 0px;
            left: 0px;
            margin-left: 0px;
            z-index: 1;
            background-color: transparent;
        }

        #div3
        {
            position: absolute;
            top: 131px;
            left: 0px;
            margin-left: 0px;
            z-index: 3;
            width: 103px;
            height: 19px;
            background-repeat: no-repeat;
        }

        #div3
        {
            color: White;
            padding-left: 30px;
            padding-top: 5px;
        }

        .panes div
        {
            display: none;
            margin-left: 3px;
            margin-top: -3px;
            border-top: 0;
            height: 100%;
            font-size: 14px;
            width: 100%;
        }

        .panes
        {
            height: 100%;
            background: white;
            z-index: -1;
            margin-top: 2px;
        }
    </style>
    <script src="../../JQuery/jquery-1.5.2.js" type="text/javascript"></script>
    <script src="../js/tabs.js" type="text/javascript"></script>
    <link rel="stylesheet" type="text/css" href="../css/standalone.css" />
    <!-- tab styling -->
    <link rel="stylesheet" type="text/css" href="../css/tab2.css" />

    <script language="javascript" type="text/javascript" >
        function closebl() {
            var miandiv = window.parent.document.getElementById("log_windows");
            if ($("#bgimg").attr("src").indexOf("down") > 0) {

                $("#log_windows", window.parent.document).animate({ bottom: -98 }, 500, function () {
                    $("#div2,#div1").animate({ top: 98 }, 200);
                    $("#div3").animate({ top: 0 }, 500);
                    $("#bgimg").attr("src", "pic/up.gif");

                });
            }
            else {
                $("#div3").animate({ top: 130 }, 200, function () {
                    $("#log_windows", window.parent.document).animate({ bottom: 0 }, 500)
                    $("#div2,#div1").animate({ top: 0 }, 500);
                    $("#bgimg").attr("src", "pic/down.gif");

                });
            }
        }
        function changeimg(value) {
            var bgimg = document.getElementById("bgimg");
            if (value == 1) {  //移进
                if (bgimg.src.indexOf("down") > 0) {
                    bgimg.src = "pic/down_un.gif";
                }
                else {
                    bgimg.src = "pic/up_un.gif";
                }
            }
            else //移出
            {
                if (bgimg.src.indexOf("down") > 0) {
                    bgimg.src = "pic/down.gif";
                }
                else {
                    bgimg.src = "pic/up.gif";
                }
            }
        }
        window.onload = function () {
            window.parent.writeLog("system", window.parent.parent.GetTextByName("WelcomeToEndSystem", window.parent.parent.useprameters.languagedata));
        }
    </script>
</head>
<body>
   
    <form id="form1" runat="server">
         <%--呼叫控件--%>
        <%                     
            if (int.Parse(Request.Cookies["usertype"].Value) == 1)
            {
                                %>
        <object classid="clsid:C9C49299-69B6-4080-8747-8801C8397B3B"  style="display: none;" id="SCactionX" codebase="CallActiveocx.cab#version=4,2,1,0">
        </object><%                                
                    }                                      
                    %>
        
        <%-- 声音播放--%>
        <object id="mhplayer" style="display: none" classid='CLSID:6BF52A52-394A-11d3-B153-00C04F79FAA6' width="0"
            height="0" type="application/x-oleobject">
            <param name='AutoStart' value='false' />
            <param name='Enabled' value='true' />
            <param name="volume" value="5000" />
        </object>
        <div style="background-image: url(pic/nowup.gif); cursor: hand;" onclick="closebl()" id="div3">日志</div>
        <div id="div2">
            <table border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td rowspan="1" colspan="1" style="background-image: url(pic/2.jpg); background-repeat: repeat-x; width: 305px; height: 20px; text-align: right; vertical-align: top;">
                        <ul class="tabs" style="z-index: 1;">
                            <li><a id="lang_system" href="#"></a></li>
                            <li><a id="lang_call" href="#"></a></li>
                            <li><a id="lang_msg" href="#"></a></li>
                            <li><a id="lang_oper" href="#"></a></li>
                            <li style="float: right;">
                                <img id="bgimg" onmouseover="changeimg(1)" onmouseout="changeimg(2)" onclick="closebl()" style="margin-top: 5px; cursor: hand;" src="pic/down.gif" /></li>
                        </ul>
                    </td>
                    <td rowspan="2" colspan="1" valign="top">
                        <img class="style1" src="pic/1.png" /></td>
                </tr>
                <tr>
                    <td>
                        <div class="panes">
                            <div>
                                <iframe name="system" src="system_log.aspx" width="100%" allowtransparency="true" scrolling="auto" style="padding-bottom: 20px;" frameborder="0" height="405px"></iframe>
                            </div>
                            <div>
                                <iframe name="call" src="call_log.aspx" width="100%" allowtransparency="true" scrolling="auto" style="padding-bottom: 20px;" frameborder="0" height="405px"></iframe>
                            </div>
                            <div>
                                <iframe name="sms" src="sms_log.aspx" width="100%" allowtransparency="true" scrolling="auto" style="padding-bottom: 20px;" frameborder="0" height="405px"></iframe>
                            </div>
                            <div>
                                <iframe name="oper" src="oper_log.aspx" width="100%" allowtransparency="true" scrolling="auto" style="padding-bottom: 20px;" frameborder="0" height="405px"></iframe>
                            </div>
                        </div>
                    </td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
<script>

    $(function () {

        window.document.getElementById("lang_system").innerHTML = window.parent.parent.GetTextByName("System", window.parent.parent.useprameters.languagedata);
        window.document.getElementById("lang_call").innerHTML = window.parent.parent.GetTextByName("Called", window.parent.parent.useprameters.languagedata);
        window.document.getElementById("lang_msg").innerHTML = window.parent.parent.GetTextByName("Message", window.parent.parent.useprameters.languagedata);
        window.document.getElementById("lang_oper").innerHTML = window.parent.parent.GetTextByName("Operater", window.parent.parent.useprameters.languagedata);
        window.document.getElementById("div3").innerHTML = window.parent.parent.GetTextByName("Log", window.parent.parent.useprameters.languagedata);
        
        $("ul.tabs").tabs("div.panes > div", {
            //  effect: 'slide'
        });
    });
    document.body.onclick = function () {
        $("#smartMenu_mail", window.parent.parent.document).remove();
    }
    window.parent.isLoadLog = "log";
</script>
