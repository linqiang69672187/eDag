<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DispatchFunc.aspx.cs" Inherits="Web.lqnew.opePages.DispatchFunc" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../css/lq_addedit.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/pagestyle.css" rel="stylesheet" type="text/css" />
    <script src="../js/geturl.js" type="text/javascript"></script>
    <script src="../js/dragwindow.js" type="text/javascript"></script>
    <script src="../js/GlobalConst.js" type="text/javascript"></script>
    <script src="../../JS/LangueSwitch.js" type="text/javascript"></script>
    <script src="../js/geturl.js" type="text/javascript"></script>
    <script src="../js/commonJS.js" type="text/javascript"></script>
    <script src="../js/Cookie.js" type="text/javascript"></script>
    <script src="/JQuery/jquery-1.5.2.js" type="text/javascript"></script>
    <script type="text/javascript">


              //打开单呼操作窗口 前提：1、空间必须加载成功 2、不存在在操作窗口中已经发起其他单呼 3、不存在在呼叫栏发起单呼
        var HassingleCallTobeClose = window.parent.GetTextByName("HassingleCallTobeClose", window.parent.useprameters.languagedata);
        var RightMeHavingSMJT = window.parent.GetTextByName("RightMeHavingSMJT", window.parent.useprameters.languagedata);
        var RightMe_havingHJJT = window.parent.GetTextByName("RightMe_havingHJJT", window.parent.useprameters.languagedata);
        var Alert_BaseStationCalling = window.parent.GetTextByName("Alert_BaseStationCalling", window.parent.useprameters.languagedata);
        var ToEndSMSMultiSend = window.parent.GetTextByName("ToEndSMSMultiSend", window.parent.useprameters.languagedata);
        var Alert_PleaseOverKX = window.parent.GetTextByName("Alert_PleaseOverKX", window.parent.useprameters.languagedata);
        var PleaseEndRang = window.parent.GetTextByName("PleaseEndRang", window.parent.useprameters.languagedata);
        function panelSingleCall() {
            if (window.parent.useprameters.callActivexable == false) {
                alert(window.parent.GetTextByName("checkcallcontrolregister", window.parent.useprameters.languagedata));//checkcallcontrolregister
                return;
            };
            if (window.parent.callPanalISSI != "") {
                //alert('已发起一个单呼，请先结束');
                alert(HassingleCallTobeClose);
                return;
            };
            try {
                //var ifrs = window.parent.document.frames["ifr_callcontent"];//与呼叫兰对应
                if (!checkcallimg(window.parent)) {
                    //alert("已发起一个单呼，请先结束");
                    alert(HassingleCallTobeClose);
                    return;
                }
            } catch (ex) {

            }
            if (window.parent.document.frames["PrivateCall"] != null || window.parent.document.frames["PrivateCall"] != undefined) {
                window.parent.mycallfunction('PrivateCall', 380, 302);//xzj--20190320--修改高度280为302
            }
            window.parent.mycallfunction('PrivateCall', 380, 302, 0, 1999);
        }
        function panelCroupCall() {
            if (window.parent.useprameters.callActivexable == false) {
                alert(window.parent.GetTextByName("checkcallcontrolregister", window.parent.useprameters.languagedata));//checkcallcontrolregister
                return;
            };
            window.parent.mycallfunction('GroupCall', 380, 302, 0, 1999);
        }

        function panelDLCall() {
            if (window.parent.useprameters.callActivexable == false) {
                alert(window.parent.GetTextByName("checkcallcontrolregister", window.parent.useprameters.languagedata));//checkcallcontrolregister
                return;
            };
            if (window.parent.isPanalDLCall) {
                //alert("已慎密监听用户，请先结束");
                alert(RightMeHavingSMJT);
                return;
            }
            window.parent.mycallfunction('DLCall', 380, 300, 0, 1999);
        }
        function panelPPCCall() {

            if (window.parent.useprameters.callActivexable == false) {
                alert(window.parent.GetTextByName("checkcallcontrolregister", window.parent.useprameters.languagedata));//checkcallcontrolregister
                return;
            };
            if (window.parent.callPanalISSI != "") {
                         //alert('已发起一个单呼，请先结束');
                alert(HassingleCallTobeClose);
                return;
            };
            try {
                //var ifrs = window.parent.document.frames["ifr_callcontent"];
                if (!checkcallimg(window.parent)) {
                    // alert("已发起一个单呼，请结束");
                    alert(HassingleCallTobeClose);
                    return;
                }
            } catch (exception) {

            }
            window.parent.mycallfunction('PPCCall', 380, 350, 0, 1999);
        }
        function panelAlCall() {
            if (window.parent.useprameters.callActivexable == false) {
                alert(window.parent.GetTextByName("checkcallcontrolregister", window.parent.useprameters.languagedata));//checkcallcontrolregister
                return
            };
            if (window.parent.isPanalALCall) {
                            // alert("已环境监听用户，请先结束");
                alert(RightMe_havingHJJT);
                return;
            }
            window.parent.mycallfunction('ALCall', 380, 280, 0, 1999);
        }
        function panelPJCall() {
            if (window.parent.useprameters.callActivexable == false) {
                alert(window.parent.GetTextByName("checkcallcontrolregister", window.parent.useprameters.languagedata));//checkcallcontrolregister
                return
            };
            window.parent.mycallfunction('PJGroup', 580, 600, 0, 1999);
        }
        function panelDXCall() {
            if (window.parent.useprameters.callActivexable == false) {
                alert(window.parent.GetTextByName("checkcallcontrolregister", window.parent.useprameters.languagedata));//checkcallcontrolregister
                return;
            };
            window.parent.mycallfunction('DXGroup', 580, 600, 0, 1999);
        }
        function panelBSCall() {
            if (window.parent.useprameters.callActivexable == false) {
                alert(window.parent.GetTextByName("checkcallcontrolregister", window.parent.useprameters.languagedata));//checkcallcontrolregister
                return
            };
            if (window.parent.isPanalBSCall) {
                //alert("已发起一个基站呼叫");
                alert(Alert_BaseStationCalling);
                return;
            }
            window.parent.mycallfunction('SBCall', 380, 320, 0, 1999);
        }
        function panelEnableDisableRadio() {
            if (window.parent.useprameters.callActivexable == false) {
                alert(window.parent.GetTextByName("checkcallcontrolregister", window.parent.useprameters.languagedata));//checkcallcontrolregister
                return
            };
            window.parent.mycallfunction('EnableDisableRadio', 380, 220, 0, 1999);

        }
        function panelGPSEnableOrDisable() {
            if (window.parent.useprameters.callActivexable == false) {
                alert(window.parent.GetTextByName("checkcallcontrolregister", window.parent.useprameters.languagedata));//checkcallcontrolregister
                return
            };
            window.parent.mycallfunction('SendGPSEnableOrDisable', 580, 700, 0, 1999);
            //window.parent.mycallfunction('SearchGpsStatues', 680, 700, 0, 1999);

        }
        function panelGPSControl() {
            if (window.parent.useprameters.callActivexable == false) {
                alert(window.parent.GetTextByName("checkcallcontrolregister", window.parent.useprameters.languagedata));//checkcallcontrolregister
                return
            };
            window.parent.mycallfunction('SendGPSContral', 580, 700, 0, 1999);
        }
        function panelDTCZ() {
            if (window.parent.useprameters.callActivexable == false) {
                alert(window.parent.GetTextByName("checkcallcontrolregister", window.parent.useprameters.languagedata));//checkcallcontrolregister
                return
            };
            window.parent.mycallfunction('SendDTCZ', 580, 700, 0, 1999);
        }
        function panelStatock() {
            if (window.parent.isBegSendMsgSel) {
                // alert("请先完成短信群发功能");
                alert(ToEndSMSMultiSend);
                return;
            }
            if (window.parent.ismyrectangleSel) {
                // alert("请先完成框选");
                alert(Alert_PleaseOverKX);
                return;
            }
            var cj = window.parent.document.getElementById("imgrang");

            if (cj.src.indexOf("Images/ToolBar/rightbg/ring_un.png") > 0) {
                 // alert("请结束当前测距状态");
                alert(PleaseEndRang);
                return;
            }
            window.parent.mycallfunction('path_selectcolor', 450, 370, 0, 1999); window.parent.mycallfunction('DispatchFunc');
        }
        function panelVolumeControl() {

            window.parent.mycallfunction('volumeControl', 580, 700, 0, 1999);
        }

        function cyclePullUpControl() {
            if (window.parent.useprameters.callActivexable == false) {
                alert(window.parent.GetTextByName("checkcallcontrolregister", window.parent.useprameters.languagedata));//checkcallcontrolregister
                return
            };
            window.parent.mycallfunction('circleLocation', 580, 700, 0, 1999);
        }

        $(document).ready(function () {

            if (window.parent.useprameters.PrivateCallEnable == "0" && window.parent.useprameters.GroupCallEnable == "0" && window.parent.useprameters.BaseStationCallEnable == "0" && window.parent.useprameters.YQYBEnable == "0" && window.parent.useprameters.PJCallEnable == "0" && window.parent.useprameters.DXCallEnable == "0" && window.parent.useprameters.CloseMonitoringEnable == "0" && window.parent.useprameters.EnvironmentalMonitoringEnable == "0" && window.parent.useprameters.EmergencyCallEnable == "0" && window.parent.useprameters.DTCZEnable == "0" && window.parent.useprameters.GPS_ControlEnable == "0" && window.parent.useprameters.volumeControlEnable == "0") {
                document.getElementById("Panel1").style.display = "none";
            }
            else {
                document.getElementById("Panel1").style.display = "block";
            }

            if (window.parent.useprameters.SMSEnable == "0" && window.parent.useprameters.Status_messageEnable == "0") {
                document.getElementById("Panel2").style.display = "none";
            }
            else {
                document.getElementById("Panel2").style.display = "block";
            }

            if (window.parent.useprameters.HistoricalTraceEnable == "0" && window.parent.useprameters.RealTimeTraceEnable == "0" && window.parent.useprameters.lockingFunctionEnable == "0" && window.parent.useprameters.StackEnable == "0" && window.parent.useprameters.GPSEnable == "0" && window.parent.useprameters.DisplayEnable == "0") {
                document.getElementById("Panel3").style.display = "none";
            }
            else {
                document.getElementById("Panel3").style.display = "block";
            }

            if (window.parent.useprameters.PrivateCallEnable == "0") {
                document.getElementById("Lang_sigle_call").disabled = true;
            }
            if (window.parent.useprameters.GroupCallEnable == "0") {
                document.getElementById("Lang_smallGroupCall").disabled = true;
            }
            if (window.parent.useprameters.BaseStationCallEnable == "0") {
                document.getElementById("Lang_baseStationCall").disabled = true;
            }
            if (window.parent.useprameters.YQYBEnable == "0") {
                document.getElementById("Lang_YAOQIYAOBI").disabled = true;
            }
            if (window.parent.useprameters.PJCallEnable == "0") {
                document.getElementById("Lang_PJgroup_call").disabled = true;
            }
            if (window.parent.useprameters.DXCallEnable == "0") {
                document.getElementById("Lang_DXgroup_call").disabled = true;
            }
            if (window.parent.useprameters.CloseMonitoringEnable == "0") {
                document.getElementById("Lang_CloseMonitoring").disabled = true;
            }
            if (window.parent.useprameters.EnvironmentalMonitoringEnable == "0") {
                document.getElementById("Lang_EnvironmentalMonitoring").disabled = true;
            }
            if (window.parent.useprameters.EmergencyCallEnable == "0") {
                document.getElementById("Lang_EmergencyCall").disabled = true;
            }
            if (window.parent.useprameters.GPS_ControlEnable == "0") {
                document.getElementById("Lang_GPS_Control").disabled = true;
            }
            if (window.parent.useprameters.DTCZEnable == "0") {
                document.getElementById("Lang_DTCZ").disabled = true;
            }
            if (window.parent.useprameters.volumeControlEnable == "0") {
                document.getElementById("Lang_volumeControl").disabled = true;
            }
            //if (window.parent.useprameters.SMSEnable == "0") {            //2018.1.9虞晨超 只选组短信权限时 操作窗口短信灰掉
            //document.getElementById("Lang_shortMessage").disabled = true;
            //}
            if (window.parent.useprameters.Status_messageEnable == "0") {
                document.getElementById("Lang_Status_message").disabled = true;
            }
            if (window.parent.useprameters.HistoricalTraceEnable == "0") {
                document.getElementById("Lang_HistoricalTrace").disabled = true;
            }
            if (window.parent.useprameters.RealTimeTraceEnable == "0") {
                document.getElementById("Lang_RealTimeTrace").disabled = true;
            }
            if (window.parent.useprameters.lockingFunctionEnable == "0") {
                document.getElementById("Lang_lockingFunction").disabled = true;
            }
            if (window.parent.useprameters.StackEnable == "0") {
                document.getElementById("Lang_Stack").disabled = true;
            }
            if (window.parent.useprameters.GPSEnable == "1") {
                var roleId = Cookies.get("roleId");
                //alert(document.cookie.toString());
                if (roleId == "1") {
                    document.getElementById("Lang_immediateLocation").disabled = true;
                }

            }
            if (window.parent.useprameters.DisplayEnable == "0") {
                document.getElementById("Lang_realTimeDisplay").disabled = true;
            }
            if (window.parent.useprameters.PullUp_ControlEnable == "0") {
                document.getElementById("Lang_PullUp_Control").disabled = true;
            }

        });
    </script>
    <style type="text/css">
        .auto-style1 {
            width: 50%;
            height: 29px;
        }

        .auto-style2 {
            height: 29px;
        }

        a {
            cursor: pointer;
        }

        .PageDisplay {
            display: none;
            width:400px;
        }
    </style>
</head>
<body style="height:600px" onselectstart="return false;">
    <form id="form1" runat="server">
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
                                <ul class="hor_ul">
                                    <li id="Lang_Callpanel">
                                        <img src="../images/037.gif" /><%--操作窗口--%></li>
                                </ul>
                            </td>
                            <td width="281" background="../images/tab_05.gif" align="right">
                                <img class="style6" style="cursor: hand;" onclick="window.parent.mycallfunction('DispatchFunc')"
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
                            <td align="center">
                                <table class="style1" cellspacing="1" id="dragtd">
                                    <%--<tr>
                                        <td colspan="2" align="left" style="background-image: url(../images/add_entity_infobg.png);
                                            height: 33;">
                                            <div style="background-image: url(../images/add_entity_info.png); width: 109px; height: 23px;">
                                                <div style="margin-left: 34px; font-size: 14px; font-weight: bold; color: #006633;
                                                    padding-top: 5px;">
                                                    调度功能</div>
                                            </div>
                                        </td>
                                    </tr>--%>
                                    <tr>
                                        <td>
                                            <table border="0" cellpadding="0" cellspacing="0" align="center" style="height: 140px;
                                                width: 31%;">
                                                <tr>
                                                    <td>
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                                <tr align="center">
                                                    <td>
                                                        <asp:Panel ID="Panel1" runat="server" CssClass="PageDisplay" GroupingText="呼叫业务" Font-Names="Arial" HorizontalAlign="Left"
                                                            Width="400px">
                                                            <ul>
                                                                <table width="90%">
                                                                    
                                                                    <tr>
                                                                        <td style="width: 50%">
                                                                            <li style="padding-top: 10px;"><a style="cursor: hand;" onclick="panelSingleCall()" id="Lang_sigle_call">
                                                                               <%-- 单&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;呼--%></a></li>
                                                                        </td>
                                                                        <td>
                                                                            <li style="padding-top: 10px;"><a style="cursor: hand;" onclick="panelCroupCall()" id="Lang_smallGroupCall">
                                                                                <%--小组呼叫--%></a></li>
                                                                        </td>
                                                                    </tr>

                                                                    <tr>
                                                                        <td style="width: 50%">
                                                                        <li style="padding-top: 10px;"><a id="Lang_baseStationCall" style="cursor: hand;" onclick="panelBSCall()"><%--基站类呼叫--%></a></li>
                                                                              <li style="padding-top: 10px;  display:none"><a id="Lang_EmergencyCall_1" style="cursor: hand;" onclick="javascript:if(window.parent.useprameters.callActivexable==false){alert(window.parent.GetTextByName('checkcallcontrolregister', window.parent.useprameters.languagedata));return};window.parent.mycallfunction('PPCCall', 380, 350);">紧急呼叫</a></li>
                                                                        </td>
                                                                        <td>
                                                                            <li style="padding-top: 10px;"><a style="cursor: hand;" onclick="panelEnableDisableRadio()" id="Lang_YAOQIYAOBI">
                                                                                <%--遥启遥毙--%></a></li>
                                                                        </td>
                                                                    </tr>

                                                                    <tr>
                                                                        <td style="width: 50%;">
                                                                            <li style="padding-top: 10px;"><a style="cursor: hand;" onclick="panelPJCall()" id="Lang_PJgroup_call">
                                                                                <%--派接组呼叫--%></a></li>
                                                                        </td>
                                                                        <td>
                                                                            <li style="padding-top: 10px;"><a style="cursor: hand;" onclick="panelDXCall()" id="Lang_DXgroup_call">
                                                                                <%--多选组呼叫--%></a></li>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td style="width: 50%">
                                                                            <li  style="padding-top: 10px;"><a style="cursor: hand;" onclick="panelDLCall()" id="Lang_CloseMonitoring">
                                                                                <%--慎密监听--%></a></li>
                                                                        </td>
                                                                        <td>
                                                                            <li style="padding-top: 10px;"><a style="cursor: hand;" onclick="panelAlCall()" id="Lang_EnvironmentalMonitoring">
                                                                                <%--环境监听--%></a></li>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td style="width: 50%">
                                                                     
                                                                     <li style="padding-top: 10px; "><a id="Lang_EmergencyCall" style="cursor: hand;" onclick="panelPPCCall()"><%--紧急呼叫--%></a></li>
                                                                         
                                                                        </td>
                                                                       <%-- <td>
                                                                        <li style="padding-top: 10px; "><a id="Lang_GPSEnableOrDisable" style="cursor: hand;" onclick="panelGPSEnableOrDisable()"></a></li>
                                                                        </td>--%>
                                                                        <td>
                                                                             <li style="padding-top: 10px;"><a id="Lang_volumeControl" style="cursor: hand;" onclick="panelVolumeControl()"></a></li>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td style="width: 50%">
                                                                            <li style="padding-top: 10px;"><a id="Lang_GPS_Control" style="cursor: hand;" onclick="panelGPSControl()"></a></li>
                                                                        </td>      
                                                                        <td style="width:50%">
                                                                            <li style="padding-top:10px;">
                                                                                <a id="Lang_PullUp_Control" style="cursor:hand;" onclick="cyclePullUpControl()"></a>
                                                                            </li>
                                                                        </td>
                                                                    </tr>
                                                                     <tr style="display:block">
                                                                         <td>
                                                                             <li style="padding-top: 10px;"><a id="Lang_DTCZ" style="cursor: hand;" onclick="panelDTCZ()"></a></li>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </ul>
                                                        </asp:Panel>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                                <tr align="center">
                                                    <td>
                                                        <asp:Panel ID="Panel2" CssClass="PageDisplay" runat="server" GroupingText="" Font-Names="Arial" HorizontalAlign="Left"
                                                           Width="400">
                                                            <ul>                                                              
                                                                <table width="90%">                                                                    
                                                                    <tr>
                                                                        <td style="width: 50%">
                                                                            <li><a id="Lang_shortMessage" style="cursor: hand;" onclick="javascript:if(window.parent.useprameters.callActivexable==false){alert(window.parent.GetTextByName('checkcallcontrolregister', window.parent.useprameters.languagedata));return};window.parent.mycallfunction('Send_SMS', 380, 400,'&cmd=SEND');">
                                                                 <%--  短&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;信--%></a></li>
                                                                        </td>
                                                                        <td>
                                                                            <li><a id="Lang_Status_message" style="cursor: hand;" onclick="javascript:if(window.parent.useprameters.callActivexable==false){alert(window.parent.GetTextByName('checkcallcontrolregister', window.parent.useprameters.languagedata));return};window.parent.mycallfunction('Send_StatusMS', 380, 400,'&cmd=SEND');">
                                                                    <%--状态消息--%></a></li>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </ul>

                                                        </asp:Panel>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                                <tr align="center">
                                                    <td>
                                                        <asp:Panel ID="Panel3" CssClass="PageDisplay" runat="server" GroupingText="<%--应用业务--%>" Font-Names="Arial" HorizontalAlign="Left"
                                                            Width="400">
                                                            <ul>
                                                                <table width="90%">
                                                                    <tr>
                                                                        <td class="auto-style1">
                                                                            <li  style="padding-top: 10px;"><a style="cursor: hand;" onclick="window.parent.mycallfunction('SubmitToHistoryByCtrlPanl', 350, 460,0,1999);;window.parent.mycallfunction('DispatchFunc');" id="Lang_HistoricalTrace">
                                                                                <%--历史轨迹--%></a></li>
                                                                        </td>
                                                                        <td class="auto-style2">
                                                                            <li " style="padding-top: 10px;"><a id="Lang_RealTimeTrace" style="cursor: hand;" onclick="window.parent.mycallfunction('RtTrackByCtrlPanl', 350, 380,0,1999);window.parent.mycallfunction('DispatchFunc', 350, 380);"><%--实时轨迹--%></a></li>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td style="width: 50%">
                                                                          <li style="padding-top: 10px;"><a id="Lang_lockingFunction" style="cursor: hand;" onclick="window.parent.mycallfunction('LockkByCtrlPanl', 350, 220,0,1999);<%--window.parent.mycallfunction('DispatchFunc');--%>"><%--锁定功能--%></a></li>
                                                                           
                                                                        </td>
                                                                        <td>
                                                                            <%--<li style="padding-top: 10px;"><a id="Lang_Stack" style="cursor: hand;" onclick="panelStatock()">--%>
<li style="padding-top: 10px;"><a id="Lang_Stack" style="cursor: hand;" onclick="window.parent.mycallfunction('manager_Stackade',600, 354);">
                                                                                <%--电子栅栏--%></a></li>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td style="width: 50%">
                                                                            <li style="padding-top: 10px;"><a id="Lang_immediateLocation" style="cursor: hand;" onclick="window.parent.mycallfunction('LocationAtOnceByCtrlPanl', 350, 320,0,1999);window.parent.mycallfunction('DispatchFunc');"><%--立即定位--%></a></li>
                                                                        </td>
                                                                        <td>
                                                                             <li style="padding-top: 10px;"><a id="Lang_realTimeDisplay" style="cursor: hand;" onclick="window.parent.mycallfunction('ShowRTByCtrlPanl', 350, 320,0,1999);window.parent.mycallfunction('DispatchFunc');"><%--实时显示--%></a></li>
                                                                        </td>
                                                                    </tr>
                                                                    
                                                                </table>
                                                            </ul>
                                                        </asp:Panel>
                                                    </td>
                                                </tr>
                                                <tr align="center">
                                                    <td>
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
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
    </form>
</body>
</html>
<script>    window.parent.closeprossdiv();
    // alert(typeof LanguageSwitch);
    LanguageSwitch(window.parent);



</script>
<link href="../../CSS/lq_calloutExtender.css" rel="stylesheet" type="text/css" />
