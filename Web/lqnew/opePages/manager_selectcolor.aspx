<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="manager_selectcolor.aspx.cs"
    Inherits="Web.lqnew.opePages.manager_selectcolor" EnableViewState="false" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <?import namespace="v" implementation="#default#VML" ?>
    <link href="../css/lq_addedit.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/pagestyle.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        body {
            color: White;
            font-size: 12px;
        }

        .auto-style1 {
            height: 25px;
        }

        v\:* {
            behavior: url(#default#VML);
            position: absolute;
        }

        o\:* {
            behavior: url(#default#VML);
        }
        /* range控件 */

        input[type=range] {
            display: block;
            position: relative;
            width: 300px;
            height: 35px;
            margin: 0px 0;
            padding: 0 0px;
            background: none;
            -webkit-appearance: none;
            -moz-appearance: none;
            cursor: pointer;
        }
    </style>
    <script src="../../JQuery/jquery-1.5.2.js" type="text/javascript"></script>
    <script src="../iColorPicker.js" type="text/javascript"></script>
    <script src="../../JS/LangueSwitch.js" type="text/javascript"></script>
    <title></title>
    <script src="../js/geturl.js" type="text/javascript"></script>
    <script src="../js/dragwindow.js" type="text/javascript"></script>
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
                                        <asp:ScriptManager ID="ScriptManager1" runat="server">
                                        </asp:ScriptManager>
                                        <img src="../images/tab_03.png" width="15" height="32" />
                                    </td>
                                    <td id="Lang_select_trace_style" width="1101" background="../images/tab_05.gif">选择轨迹线样式
                                    </td>
                                    <td width="281" background="../images/tab_05.gif" align="right">
                                        <!-----------------xzj--2018/8/2------------------取消onclick中添加的window.parent.cancelOpenRealTimeTrajectory(getQueryStringRegExp('id'));事件-->
                                        <!-----------------xzj--2018/7/9------------------onclick中添加cancelOpenRealTimeTrajectory事件，cursor属性值改为pointer-->
                                        <img class="style6" style="cursor: pointer;" onclick="window.parent.mycallfunction(geturl(),693, 354);"
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
                        <table width="100%" border="0" style="background-color: White; color: Black;" cellspacing="0"
                            cellpadding="0">
                            <tr>
                                <td width="15" background="../images/tab_12.gif">&nbsp;
                                </td>
                                <td>
                                    <table class="style1" cellspacing="1" id="dragtd">
                                        <tr>
                                            <td id="Lang_color" align="right" valign="middle" height="25px" width="40px">颜色：
                                            </td>
                                            <td align="left" valign="middle" colspan="2">
                                                <div style="display: none">
                                                    <input class="iColorPicker" id="color1" onpropertychange="rewritevml();" style="background-color: #000000; margin-top: 5px; width: 85px;"
                                                        type="text" value="#000" />
                                                </div>
                                                <select id="selColor" onchange="rewritevml()"></select>
                                            </td>

                                        </tr>
                                        <tr>
                                            <td id="Lang_width" style="vertical-align: middle; text-align: right; height: 25px;">宽度：</td>
                                            <td style="text-align: left; vertical-align: middle; height: 30px;">
                                                <input type="range" value="1" style="height: 5px;" onchange="rewritevml();" max="5" min="1" id="TextBox1" />
                                            </td>

                                        </tr>
                                        <tr style="display: none">
                                            <td id="Lang_style_2" align="right" height="25px" valign="middle">样式：
                                            </td>
                                            <td align="left" valign="middle" colspan="2">
                                                <select id="Select1" name="D1" onchange="rewritevml()">
                                                    <option value="solid" id="Lang_solid">实线</option>
                                                    <option value="dot" id="Lang_dot">点线</option>
                                                    <option value="dash" id="Lang_dash">虚线</option>
                                                    <option value="dashdot" id="Lang_dashdot">点虚线</option>
                                                    <option value="longdash" id="Lang_longdash">长虚线</option>
                                                    <option value="longdashdot" id="Lang_longdashdot">虚点线</option>
                                                    <option value="longdashdotdot" id="Lang_longdashdotdot">双点线</option>
                                                </select>&nbsp;
                                            <select id="Select2" name="D2" style="display: none;">
                                                <option value="100">100</option>
                                                <option value="500">500</option>
                                                <option value="0" id="Lang_Unlimited">不限</option>
                                            </select>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td id="Lang_Effect" align="right" height="25px" valign="middle">效果：
                                            </td>
                                            <td align="left" valign="middle" colspan="2">
                                                <canvas id="polyline1" style="height: 25px; width: 200px;"></canvas>
                                            </td>

                                        </tr>
                                        <tr>
                                            <td align="center" colspan="3">
                                                <img style="margin: 0px 0px 0px 3px; cursor: hand;" src="../images/add_ok.png" onclick="selectcolor()" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td width="14" background="../images/tab_16.gif">&nbsp;
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td height="15">
                        <table width="100%" border="0" style="background-color: White;" cellspacing="0" cellpadding="0">
                            <tr>
                                <td width="15" height="15">
                                    <img src="../images/tab_20.png" width="15" height="15" />
                                </td>
                                <td background="../images/tab_21.gif">
                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td width="25%" nowrap="nowrap">&nbsp;
                                            </td>
                                            <td width="75%" valign="top" class="STYLE1">&nbsp;
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
<script type="text/javascript">
    function geturl() {
        //        var str = window.location.href;
        //        str = str.substring(str.lastIndexOf("/") + 1)
        //        str = str.split(".")[0];
        //        return str;
        return "manager_selectcolor";
    }
</script>
</html>
<script type="text/javascript">
    window.parent.closeprossdiv();
    //alert(window.parent.document.getElementById("Text_OpenRealTimeTrajectory"));
    window.parent.document.getElementById("Text_OpenRealTimeTrajectory").disabled = true;

    function selectcolor() {
        var colorbox = document.getElementById("color1");
        var color = colorbox.value;
        color = "#" + window.parent.colorCodeToFlashColor(window.document.getElementById("selColor").value);
        var id = getQueryStringRegExp('id');
        var ISSI = getQueryStringRegExp('ISSI');
        var lineweight = $("#TextBox1").val();
        var linestyle = $("#Select1").val();
        var lineint = $("#Select2").val();     
           //将开启实时轨迹的id存入useprameters.realtimeTraceUserIds中---------------xzj--2018/8/2---------------
        var i = window.parent.useprameters.realtimeTraceUserIds.length;
        while (i--) {
            if (window.parent.useprameters.realtimeTraceUserIds[i] == id)
                break;
        }
        if (i == -1) {
            window.parent.useprameters.realtimeTraceUserIds.push(id);
        }
        
        window.parent.selectcolortrace(id, color, lineweight, linestyle, lineint, ISSI);
        window.parent.document.getElementById("Text_OpenRealTimeTrajectory").disabled = false;
        window.parent.AddPeruserRealtimeTrace_line(id);
        //window.parent.ReLoadUser();
        window.parent.mycallfunction(geturl(), 693, 354);
       
        // var sendtime = getQueryStringRegExp('sendtime');
        //var layerCell = window.parent.LayerControl.CellGet("Police,0,0", id);
        // window.parent.writeLog("oper", "[实时轨迹]：开启ISSI(" + layerCell.ISSI + ")的实时轨迹" + "[" + window.parent.LOGTimeGet() + "]");         /**日志：操作日志 **/

    }
    function getQueryStringRegExp(id) {
        var reg = new RegExp("(^|\\?|&)" + id + "=([^&]*)(\\s|&|$)", "i");
        if (reg.test(location.href)) return unescape(RegExp.$2.replace(/\+/g, " ")); return "";
    }
    window.onload = function () {
        $("#TextBox1").bind('');
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
    }
    function rewritevml() {

        var colorbox = document.getElementById("color1");
        var color = colorbox.value;
        color = window.parent.colorCodeToHtmlColor(window.document.getElementById("selColor").value);
        var lineweight = $("#TextBox1").val();
        var linestyle = $("#Select1").val();

        var mycanvas = document.getElementById('polyline1');
        mycanvas.width = "200";
        mycanvas.height = "25";
        var ctx = mycanvas.getContext("2d");
        ctx.lineWidth = lineweight;
        //起始一条路径，或重置当前路径  
        ctx.beginPath();
        //设置画笔颜色  
        ctx.strokeStyle = color;
        //把路径移动到画布中的指定点，不创建线条  
        ctx.moveTo(2, mycanvas.height / 2);
        ctx.lineTo(180, mycanvas.height / 2);
        ctx.closePath();
        //绘制已定义的路径  
        ctx.stroke();

        var canvasHeight = mycanvas.height;
        lineweight = lineweight * 3;
        ctx.fillStyle = color;
        ctx.beginPath();
        ctx.moveTo(180, canvasHeight / 2 - lineweight / 2);
        ctx.lineTo(180, canvasHeight / 2 + lineweight / 2);
        var jiantouX = 180 + (lineweight / 2) / Math.tan(Math.PI / 6);
        ctx.lineTo(jiantouX, canvasHeight / 2);
        ctx.closePath();
        ctx.fill();

    }
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
    window.parent.loadColorOption(window.document.getElementById("selColor"));
</script>
