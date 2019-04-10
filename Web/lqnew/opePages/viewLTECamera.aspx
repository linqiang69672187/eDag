<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="viewLTECamera.aspx.cs" Inherits="Web.lqnew.opePages.view_info.viewLTECamera" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <script type="text/javascript" src="../../swf/swfobject.js"></script>
     <script src="../js/geturl.js" type="text/javascript"></script>
    <script type="text/javascript">
            <!-- For version detection, set to min. required Flash Player version, or 0 (or 0.0.0), for no version detection. --> 
    var swfVersionStr = "11.1.0";
    <!-- To use express install, set to playerProductInstall.swf, otherwise the empty string. -->
    var xiSwfUrlStr = "playerProductInstall.swf";
    var flashvars = {};
    var params = {};
    params.wmode = "window";
    params.quality = "high";
    params.bgcolor = "#ffffff";
    params.allowscriptaccess = "sameDomain";
    params.allowfullscreen = "true";
    var attributes = {};
    attributes.id = "login";
    attributes.name = "login";
    attributes.align = "middle";
    swfobject.embedSWF(
        "../../swf/LTECamera.swf", "flashContent", 
        "500", "500", 
        swfVersionStr, xiSwfUrlStr, 
        flashvars, params, attributes);
    <!-- JavaScript enabled so display the flashContent div in case it is not replaced with a swf object. -->
    swfobject.createCSS("#flashContent", "display:block;text-align:left;");
    function hiddenpalyer(){
        var flash = document.getElementById("flashimg");
        flash.style.display='none';
    }
        </script>
</head>
<body>
    <script type="text/javascript">
        window.onload=function(){
            //getLTECamera();
            document.body.onmousedown = function () {
                dragdiv();
            }
            document.body.onmousemove = function () { mydragWindow(); }
            document.body.onmouseup = function () { mystopDragWindow(); }
            document.body.oncontextmenu = function () { return false;}
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
            var table = document.getElementById("nodragtd");
            table.onmouseout = function () {
                dragEnable = 'True';
            }
            table.onmouseover = function () {
                dragEnable = 'False';
            }
        }
        var failNum = 0;
        var failNumMax = 5;
        function getLTECamera()
        {
            var swf = document.getElementById("LTECamera");
            if(swf){
                try{
                    swf.getCamera();
                }
                catch(e){
                    failNum +=1;
                    if(failNum < failNumMax){
                        setTimeout(getLTECamera,1000);
                    }
                }
            }
        }
    </script>
    
    <div>
        <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
            <tr>
                <td height="30">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td width="15" height="32">
                                <img src="../images/tab_03.png" width="15" height="32" />
                            </td>
                            <td width="1101" background="../images/tab_05.gif">
                                &nbsp;</td>
                            <td width="281" background="../images/tab_05.gif" align="right">
                                <img class="style6" style="cursor: hand;" onclick="window.parent.mycallfunction(geturl())"
                                    onmouseover="javascript:this.src='../images/close_un.png';" onmouseout="javascript:this.src='../images/close.png';"
                                    src="../images/close.png" />
                            </td>
                            <td width="14">
                                <img src="../images/tab_07.png" width="14" height="32" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td width="15" background="../images/tab_12.gif">
                                &nbsp;
                            </td>
                            <td id="nodragtd">
                                <%--内容--%>
                                <div id="flashContent">    </div>
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
     <script type="text/javascript">
    var dragEnable = 'True';
        function dragdiv() {
            var div1 = window.parent.document.getElementById(geturl());
            window.parent.windowDivOnClick(div1);
            if (div1 && event.button == 0 && dragEnable == 'True') {
                window.parent.mystartDragWindow(div1, null, event); div1.style.border = "solid 0px transparent"; window.parent.cgzindex(div1);

            }
        }
        function mydragWindow() {
            var div1 = window.parent.document.getElementById(geturl());
            if (div1 && event.button == 0 && dragEnable == 'True') {
                window.parent.mydragWindow(div1, event);
            }
        }

        function mystopDragWindow() {
            var div1 = window.parent.document.getElementById(geturl());
            if (div1 && event.button == 0 && dragEnable == 'True') {
                window.parent.mystopDragWindow(div1); div1.style.border = "0px";
            }
        }
         </script>
</body>
</html>
    <script type="text/javascript">
        window.parent.closeprossdiv();
        
</script>