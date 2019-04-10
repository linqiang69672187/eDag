<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="sms_log.aspx.cs" Inherits="Web.lqnew.logwindow.sms_log" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <style>
        body
        {
            background-color: transparent;
            font-size: 12px;
            margin: 0px;
            scrollbar-face-color: #DEDEDE;
            scrollbar-base-color: #F5F5F5;
            scrollbar-arrow-color: black;
            scrollbar-track-color: #F5F5F5;
            scrollbar-shadow-color: #EBF5FF;
            scrollbar-highlight-color: #F5F5F5;
            scrollbar-3dlight-color: #C3C3C3;
            scrollbar-darkshadow-color: #9D9D9D;
        }

        table
        {
            font-size: 12px;
        }

        span
        {
            cursor: hand;
            text-decoration: underline;
            color: Blue;
        }

        .myspan
        {
            color: Red;
            text-decoration: none;
        }
          li {
            line-height:22px;background-image:url(backgline.gif);background-position-y:bottom;background-repeat:repeat-x;
        }
    </style>
    <script src="../../JQuery/jquery-1.5.2.js" type="text/javascript"></script>
    <script src="../../JS/jquery-smartMenu2.js" type="text/javascript"></script>
    <script src="../js/commonJS.js" type="text/javascript"></script>
</head>
<body>
    <form id="form1" runat="server">
        <div id="scrolldiv1" style="overflow: auto; height: 103px; width: 295px">
             <table id="log">

        </table>
        </div>
    </form>
</body>

<script type="text/javascript">
    var rightGSSI;
    var CallMsg = new Array();
    function GetCallMsg() {
        return CallMsg;
    }
    document.body.onclick = function () {
        $("#smartMenu_mail", window.parent.parent.document).remove();
    }
    //自定义右键上下文
    var call = {
        text: window.parent.parent.GetTextByName("CallService", window.parent.parent.useprameters.languagedata),//多语言：呼叫业务
        data: [
		[{
		    text: window.parent.parent.GetTextByName("SingleCall", window.parent.parent.useprameters.languagedata),//多语言：单呼
		    func: function () {
		        if (window.parent.parent.callPanalISSI != "") {
		            alert(window.parent.parent.GetTextByName("HassingleCallTobeClose", window.parent.parent.useprameters.languagedata));//多语言：已发起一个单呼，请先结束
		            return;
		        };
		        //var ifrs = window.parent.parent.document.frames["ifr_callcontent"];
		        if (!checkcallimg(window.parent.parent)) {
		            alert(window.parent.parent.GetTextByName("HassingleCallTobeClose", window.parent.parent.useprameters.languagedata));//多语言：已发起一个单呼，请结束
		            return;
		        }
		        if (window.parent.parent.document.frames["PrivateCall"] != null || window.parent.parent.document.frames["PrivateCall"] != undefined) {
		            window.parent.parent.mycallfunction('PrivateCall', 380, 280, 0, 1999);
		        }
		        window.parent.parent.mycallfunction('PrivateCall', 380, 500, "&type=UID&myid=" + window.parent.parent.useprameters.rightselectid, 1999);
		    }
		}, {
		    text: window.parent.parent.GetTextByName("smallGroupCall", window.parent.parent.useprameters.languagedata),//多语言：小组呼叫
		    func: function () {
		        window.parent.parent.mycallfunction('GroupCall', 380, 500, "&type=UID&myid=" + window.parent.parent.useprameters.rightselectid, 1999);
		    }
		},
        //        {
        //		    text: "紧急呼叫",
        //		    func: function () {
        //		        window.parent.parent.mycallfunction('PPCCall', 380, 500, "&type=UID&myid=" + window.parent.parent.useprameters.rightselectid);
        //		    }
        //		},
         {
             text: window.parent.parent.GetTextByName("YAOQIYAOBI", window.parent.parent.useprameters.languagedata),//多语言：遥启遥毙
             func: function () {
                 window.parent.parent.mycallfunction('EnableDisableRadio', 380, 500, "&type=UID&myid=" + window.parent.parent.useprameters.rightselectid, 1999);
             }
         }
        ,
        {
            text: window.parent.parent.GetTextByName("CloseMonitoring", window.parent.parent.useprameters.languagedata),//多语言：慎密监听
            func: function () {
                if (window.parent.parent.isPanalDLCall) {
                    alert(window.parent.parent.GetTextByName("RightMeHavingSMJT", window.parent.parent.useprameters.languagedata));//多语言：已慎密监听用户，请先结束
                    return;
                }
                if (window.parent.parent.document.frames["DLCall"] != null || window.parent.parent.document.frames["DLCall"] != undefined) {
                    window.parent.parent.mycallfunction('DLCall', 380, 280, 0, 1999);
                }
                window.parent.parent.mycallfunction('DLCall', 380, 500, "&type=UID&myid=" + window.parent.parent.useprameters.rightselectid, 1999);
            }
        }
        ,
        {
            text: window.parent.parent.GetTextByName("EnvironmentalMonitoring", window.parent.parent.useprameters.languagedata),//多语言：环境监听
            func: function () {
                if (window.parent.parent.isPanalALCall) {
                    alert(window.parent.parent.GetTextByName("RightMe_havingHJJT", window.parent.parent.useprameters.languagedata));//多语言：已环境监听用户，请先结束
                    return;
                }
                if (window.parent.parent.document.frames["ALCall"] != null || window.parent.parent.document.frames["ALCall"] != undefined) {
                    window.parent.parent.mycallfunction('ALCall', 380, 280, 0, 1999);
                }
                window.parent.parent.mycallfunction('ALCall', 380, 500, "&type=UID&myid=" + window.parent.parent.useprameters.rightselectid, 1999);
            }
        }

		]
        ]
    },
            sms = {
                text: window.parent.parent.GetTextByName("Shortmessageservice", window.parent.parent.useprameters.languagedata),//多语言：短信业务
                data: [
		[{
		    text: window.parent.parent.GetTextByName("Personalmessage", window.parent.parent.useprameters.languagedata),//多语言：个人短信
		    func: function () {
		        window.parent.parent.mycallfunction('Send_SMS', 380, 400, window.parent.parent.useprameters.rightselectid, 1999);
		    }
		}, {
		    text: window.parent.parent.GetTextByName("Groupmessage", window.parent.parent.useprameters.languagedata),//多语言：组短信
		    func: function () {
		        window.parent.parent.mycallfunction('Send_SMS', 380, 400, window.parent.parent.useprameters.rightselectid + "&cmd=G", 1999)
		    }
		}, {
		    text: window.parent.parent.GetTextByName("Statusmessage", window.parent.parent.useprameters.languagedata),//多语言：状态消息
		    func: function () {
		        window.parent.parent.mycallfunction('Send_StatusMS', 380, 400, window.parent.parent.useprameters.rightselectid, 1999);
		    }
		}]
                ]
            },
    apllication = {
        text: window.parent.parent.GetTextByName("ApplicationService", window.parent.parent.useprameters.languagedata),//多语言：应用业务
        data: [
		[{
		    text: window.parent.parent.GetTextByName("DetailedInformation", window.parent.parent.useprameters.languagedata),//多语言：详细信息
		    func: function () {
		        window.parent.parent.showCIMessage(window.parent.parent.useprameters.rightselectid)
		    }
		}, {
		    text: window.parent.parent.GetTextByName("RealTimeTrace", window.parent.parent.useprameters.languagedata),//多语言：实时轨迹
		    func: function () {
		        window.parent.parent.trayceit('Police,0,0', window.parent.parent.useprameters.rightselectid);
		    }
		}, {
		    text: window.parent.parent.GetTextByName("HistoricalTrace", window.parent.parent.useprameters.languagedata),//多语言：历史轨迹
		    func: function () {
		        window.parent.parent.mycallfunction('SubmitToHistory', 380, 370, window.parent.parent.useprameters.rightselectid, 1999)
		    }
		},
         {
             text: window.parent.parent.GetTextByName("LockInTheMap", window.parent.parent.useprameters.languagedata),//多语言：图上定位
             func: function () {
                 window.parent.parent.locationbyUseid(window.parent.parent.useprameters.rightselectid);
             }
         },
         {
             text: window.parent.parent.GetTextByName("Stack", window.parent.parent.useprameters.languagedata),//多语言：电子栅栏
             func: function () {
                 if (window.parent.parent.isBegSendMsgSel) {
                     alert(window.parent.parent.GetTextByName("ToEndSMSMultiSend", window.parent.parent.useprameters.languagedata));//多语言：请先完成短信群发功能
                     return;
                 }
                 window.parent.parent.mycallfunction('path_selectcolor', 450, 370, window.parent.parent.useprameters.rightselectid, 1999)
             }
         },
        {
            text: window.parent.parent.GetTextByName("LockFunction", window.parent.parent.useprameters.languagedata),//多语言：开启锁定
            text: window.parent.parent.GetTextByName("UnLockFunction", window.parent.parent.useprameters.languagedata),//多语言：关闭锁定
            func: function () {
                window.parent.parent.lock_it(window.parent.parent.useprameters.rightselectid);
            }
        }]
        ]
    },
     groupcall = {
         text: window.parent.parent.GetTextByName("smallGroupCall", window.parent.parent.useprameters.languagedata),//多语言：小组呼叫
         func: function () {

             window.parent.parent.mycallfunction('GroupCall', 380, 500, '&type=GSSI&myid=' + rightGSSI, 1999);
         }
     },
     groupsms = {
         text: window.parent.parent.GetTextByName("SMS", window.parent.parent.useprameters.languagedata),//多语言：短信
         func: function () {
             window.parent.parent.mycallfunction('Send_SMS', 380, 400, rightGSSI + '&cmd=GSSI', 1999);
         }
     };

    dispatchPCall = {
        text: window.parent.parent.GetTextByName("SingleCall", window.parent.parent.useprameters.languagedata),//多语言：单呼
        func: function () {
            if (window.parent.parent.callPanalISSI != "") {
                alert(window.parent.parent.GetTextByName("HassingleCallTobeClose", window.parent.parent.useprameters.languagedata));//多语言：已发起一个单呼，请先结束
                return;
            };
           // var ifrs = window.parent.parent.document.frames["ifr_callcontent"];
            if (!checkcallimg(window.parent.parent)) {
                alert(window.parent.parent.GetTextByName("HassingleCallTobeClose", window.parent.parent.useprameters.languagedata));//多语言：已发起一个单呼，请结束
                return;
            }
            window.parent.parent.mycallfunction('PrivateCall', 380, 500, '&type=Dispatch&myid=' + rightISSI, 1999);
        }
    }
    dispatchGSMS = {
        text: window.parent.parent.GetTextByName("SMS", window.parent.parent.useprameters.languagedata),//多语言：短信
        func: function () {
            window.parent.parent.mycallfunction('Send_SMS', 380, 400, rightISSI + '&cmd=DISSI', 1999);
        }
    }
    baseStationCall = {//xzj--20190225--添加基站短信
        text: window.parent.parent.GetTextByName("SingleStationCall", window.parent.parent.useprameters.languagedata),
        func: function () {
            if (window.parent.parent.isPanalBSCall) {
                alert(window.parent.parent.GetTextByName("Alert_BaseStationCalling", window.parent.parent.useprameters.languagedata));//多语言：已发起一个基站呼叫，请先结束
                return;
            };
            if (window.parent.parent.document.frames["SBCall"] != null || window.parent.parent.document.frames["SBCall"] != undefined) {
                window.parent.parent.mycallfunction('SBCall', 380, 320, 0, 1999);
            }
            window.parent.parent.mycallfunction('SBCall', 380, 320, "&bsid=" + rightBSID, 1999);
        }    
    }
    baseStationSMS = {
        text: window.parent.parent.GetTextByName("SMS", window.parent.parent.useprameters.languagedata),
        func: function () {
            window.parent.parent.mycallfunction('Send_SMS', 380, 400, rightBSISSI + '&cmd=BSISSI&name=' + rightBSName + '&switchID=' + rigthSwitchID , 1999);
        }
    }

    var mailMenuData = [];
    var rightselecttype = "unkown";
    $("div").smartMenu(mailMenuData, {
        name: "mail",
        type: rightselecttype,
        afterShow: function () {
            rightselecttype = "unkown";
        },
        beforeShow: function () {
            //根据选中的是否是已读显示不同的上下文菜单
            // $(this).find("input").attr("checked", "checked");
            //动态数据，及时清除
            //确定显示数据 - 主要是已读与未读
            //  mailMenuData = [];

            $("#smartMenu_mail", window.parent.parent.document).remove();

            if (rightselecttype == "group") {
                mailMenuData.length = 1;
                mailMenuData[0] = [groupcall, groupsms];
            } else if (rightselecttype == "dispatch") {
                //全是粗体	
                mailMenuData.length = 1;
                mailMenuData[0] = [dispatchPCall, dispatchGSMS];
            } else if (rightselecttype == "cell") {
                //全是正常
                mailMenuData[0] = [call, sms];
                mailMenuData[1] = [apllication];

           }
            else if(rightselecttype=="baseStation"){
                mailMenuData.length = 1;
                mailMenuData[0] = [baseStationCall, baseStationSMS];
            }
            else {
                //混杂
                mailMenuData.length = 0;

            }
        }
    });
</script>
</html>
<script type="text/javascript">
    window.parent.parent.isLoadSys = "SYS";

</script>
