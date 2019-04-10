/// <reference path="LogModule.js" />
var isLoadLog = ""; //用来判断log中的mian是否加载完毕
var isLoadMain = ""; //用来判断miancall是否加载完毕
var isLoadSys = "";//用来判断isLoadSyst是否加载完毕
var begtime = "";
var refUserFlag = false; //调度台用户是否关联成功 关联成功了则去判断用户是否越界
var ppcCallingIssi = "";
var lastDlISSI = 0;//慎密监听
var jjissi = "";//调度台自动拒绝的issi
var mymassage;
var isconsume;
var ix = 0;
var arryIssi = new Array();
var arryIssiText = new Array();
var issiLenght = 0;
var isCallBackSMSMsg = false;
var iszd = false;
//var callBackRestlt = "";
var callBackIssiName = "";
//消息常量
var constMsgHaveRead = "SM_CONSUMED_BY_DESTINATION";//短信已读
var constMsgSendSucess = "SM_RECEIPT_ACK_BY_DESTINATION";//发送成功
var constMsgSendToGroupUnCheck = "EC_SM_SENT_TO_GROUP_ACK_PREVENTED";//发给组不确认
var kdocTitle = "";
var smsType_Commom_Msg = 0;
var smsType_Need_Receipt_Msg = 1;
var smsType_Status_Msg = 2;


//MSG: 注册返回消息的函数
function REGMsg(msg, dispName) {


    //将消息翻译成相关语言 逻辑中就使用相关语言
    msg = GetTextByName(msg, useprameters.languagedata);//多语言版才能使用
    writeLog("system", "REGMsg(" + msg + "," + dispName + ")");
    if (msg == GetTextByName("LINK_DISCONNECT", useprameters.languagedata)) {//多语言：链路断开 
        useprameters.callActivexable = false;
        callPanalISSI = "";
        useprameters.eTramsg = GetTextByName("LINK_DISCONNECT", useprameters.languagedata);//多语言：链路断开

    }
    if (msg == GetTextByName("REG_FAIL", useprameters.languagedata) || msg == GetTextByName("LINK_DISCONNECT", useprameters.languagedata)) {
        //呼叫栏禁用
        ChangeCallbannerEnable(false);
    }
    if (msg == GetTextByName("REG_SUCCESS", useprameters.languagedata) || msg == GetTextByName("LINK_SUCCESS", useprameters.languagedata)) {
        //启用呼叫栏
        ChangeCallbannerEnable(true);
        setVoiceType(useprameters.voiceType);
    }

    if (msg == GetTextByName("REG_SUCCESS", useprameters.languagedata) || msg == GetTextByName("REG_FAIL", useprameters.languagedata) || msg == GetTextByName("LINK_SUCCESS", useprameters.languagedata) || msg == GetTextByName("LINK_DISCONNECT", useprameters.languagedata)) {//多语言：注册成功;注册失败;连接成功;链路断开
        var scactionX = document.getElementById("SCactionX");
        useprameters.hostISSI = scactionX.DispISSI(); //只有返回成功后才能调用此函数
        useprameters.eTramsg = msg;
        useprameters.dispName = dispName;


    }

    if (msg == GetTextByName("RADIO_ENABLE_FAIL", useprameters.languagedata) || msg == GetTextByName("RADIO_DISABLE_FAIL", useprameters.languagedata) || msg == GetTextByName("RADIO_DISABLE_SUCCESS", useprameters.languagedata) || msg == GetTextByName("RADIO_ENABLE_SUCCESS", useprameters.languagedata)) {//多语言：遥启成功；遥毙成功
        alert(msg)
    };

    //flex新版
    if (msg == GetTextByName("REG_SUCCESS", useprameters.languagedata)) {//多语言：注册成功
        useprameters.callActivexable = true;
        var param1 = { "issi": useprameters.hostISSI };                           //**以下主要在操作窗口显示呼叫信息；将调度台ISSI跟调度登录用户关联写入日志
        jquerygetNewData_ajax("Handlers/RelUserAndDispatch.ashx", param1, function (request1) {
            var resMsg = request1.result;
            var LoginUserName = request1.LoginUserName;
            writeLog("system", resMsg);
            refUserFlag = true;
            setTimeout(function () { IsInStockade() }, 5000);
        })
    }
    if (msg == GetTextByName("LINK_SUCCESS", useprameters.languagedata)) {//多语言：连接成功
        useprameters.callActivexable = true;
    }
    if (msg == GetTextByName("LINK_DISCONNECT", useprameters.languagedata) || msg == GetTextByName("REG_FAIL", useprameters.languagedata)) {//多语言：链路断开；注册失败
        useprameters.callActivexable = false;
    }
    /* 原版的
    var ifrs = document.frames["ifr_callcontent"];
    if (ifrs && ifrs.document.getElementById("scrollarea")) {
        ifrs.document.getElementById("scrollarea").innerHTML = msg;
        if (msg == GetTextByName("REG_SUCCESS", useprameters.languagedata)) {//多语言：注册成功
            ifrs.$("#bgDiv").hide();
            useprameters.callActivexable = true;
            var param1 = { "issi": useprameters.hostISSI };                           //**以下主要在操作窗口显示呼叫信息；将调度台ISSI跟调度登录用户关联写入日志
            jquerygetNewData_ajax("Handlers/RelUserAndDispatch.ashx", param1, function (request1) {
                var resMsg = request1.result;
                var LoginUserName = request1.LoginUserName;
                var ifrs = document.frames["ifr_callcontent"];
                if (ifrs) {
                    ifrs.document.getElementById("scrollarea").innerHTML = resMsg;
                }
                refUserFlag = true;
            })
        }
        if (msg == GetTextByName("LINK_SUCCESS", useprameters.languagedata)) {//多语言：连接成功
            ifrs.$("#bgDiv").hide();
            useprameters.callActivexable = true;
        }
        if (msg == GetTextByName("LINK_DISCONNECT", useprameters.languagedata) || msg == GetTextByName("REG_FAIL", useprameters.languagedata)) {//多语言：链路断开；注册失败
            if (ifrs.document.getElementById("bgimg").src.indexOf("down") > 0) {
                ifrs.$("#bgDiv").show();
                useprameters.callActivexable = false;
            } else {
                ifrs.$("#bgDiv").hide();
                useprameters.callActivexable = true;
            }
        }
    }
    */
    document.getElementById("regDiv").style.display = "none";
}
//MSG: 派接组返回消息
function PatchMsg(patchgroupid, issi, msg, hookmethodsel, Activetype) {
    //将消息翻译成相关语言 逻辑中就使用相关语言

    if (issi == "NULL" || issi == "") {
       issi = Cookies.get("dispatchissi");
    }

    msg = GetTextByName(msg, useprameters.languagedata);//多语言版才能使用

    if (document.frames["PJGroup_ifr"] != null || document.frames["PJGroup_ifr"] != undefined) {

        var obj = document.frames["PJGroup_ifr"];
        var SelCY = obj.document.getElementById('SelCY');

        if (msg == GetTextByName("PATCH_END", useprameters.languagedata)) {//多语言：呼叫结束
            obj.AddMsg(GetTextByName("Lang_EndPJGroupCall", useprameters.languagedata) + "(" + patchgroupid + ")");//多语言：派接组结束呼叫
        }

        switch (Activetype.toString()) {
            case "0":
                if (document.frames["PJGroup_ifr"].document.getElementById(issi) != null) {
                    document.frames["PJGroup_ifr"].document.getElementById(issi).innerHTML = "<span style='color:red'>" + GetTextByName("PJFailed", useprameters.languagedata) + "</span>";//多语言 派接失败
                }
                obj.updateMemberStatusByGssi(patchgroupid, issi, GetTextByName("PJFailed", useprameters.languagedata));//多语言：派接失败
                break;
            case "1":
                break;
            case "2":
                if (msg.indexOf(GetTextByName("PATCH_CC_GRANTED", useprameters.languagedata)) >= 0 || msg.indexOf(GetTextByName("PATCH_CC_CALLREQUEST", useprameters.languagedata)) >= 0 || msg.indexOf(GetTextByName("PATCH_CC_CONNECT", useprameters.languagedata)) >= 0) {//多语言：获取授权；有呼叫请求进入;对方已接听

                    if (document.frames["PJGroup_ifr"].document.getElementById("img_" + patchgroupid) != null) {
                        document.frames["PJGroup_ifr"].document.getElementById("img_" + patchgroupid).src = "../../Images/calltype/pj1.gif";
                    }

                    //obj.AddMsg(issi + "在派接号为" + patchgroupid + "的派接组中获取授权");//获取授权(ISSI:2344;派接组号:20302)
                    obj.AddMsg(GetTextByName("PATCH_CC_GRANTED", useprameters.languagedata) + "(ISSI:" + issi + ";" + GetTextByName("Lang_PatchGroupNo", useprameters.languagedata) + ":" + patchgroupid + ")");//获取授权;派接组号
                }
                else if (msg.indexOf(GetTextByName("PATCH_CC_CEASED", useprameters.languagedata)) >= 0) {//多语言：发射权已释放

                    if (document.frames["PJGroup_ifr"].document.getElementById("img_" + patchgroupid) != null) {
                        document.frames["PJGroup_ifr"].document.getElementById("img_" + patchgroupid).src = "../../Images/calltype/pj0.gif";
                    }

                    obj.AddMsg(GetTextByName("PATCH_CC_CEASED", useprameters.languagedata) + "(ISSI:" + issi + ";" + GetTextByName("Lang_PatchGroupNo", useprameters.languagedata) + ":" + patchgroupid + ")");//发射权已释放;派接组号
                }
                else if (msg.indexOf(GetTextByName("PATCH_END", useprameters.languagedata)) >= 0 || msg.indexOf(GetTextByName("PATCH_CC_RELEASE", useprameters.languagedata)) >= 0) {//多语言：呼叫结束；对方挂断

                    if (document.frames["PJGroup_ifr"].document.getElementById("img_" + patchgroupid) != null) {
                        document.frames["PJGroup_ifr"].document.getElementById("img_" + patchgroupid).src = "../../Images/calltype/pj0.gif";
                    }

                    obj.AddMsg(GetTextByName("PATCH_END", useprameters.languagedata) + "(ISSI:" + issi + ";" + GetTextByName("Lang_PatchGroupNo", useprameters.languagedata) + ":" + patchgroupid + ")");//呼叫结束;派接组号
                }
                else if (msg.indexOf(GetTextByName("PATCH_CC_INTERRUPT", useprameters.languagedata)) >= 0) {//多语言：发射权被抢占

                    if (document.frames["PJGroup_ifr"].document.getElementById("img_" + patchgroupid) != null) {
                        document.frames["PJGroup_ifr"].document.getElementById("img_" + patchgroupid).src = "../../Images/calltype/pj1.gif";
                    }

                    obj.AddMsg(GetTextByName("PATCH_CC_INTERRUPT", useprameters.languagedata) + "(ISSI:" + issi + ";" + GetTextByName("Lang_PatchGroupNo", useprameters.languagedata) + ":" + patchgroupid + ")");//发射权被抢占;派接组号
                }
                break;
            default: break;
        }
    }

    document.getElementById("scrollarea").innerHTML = patchgroupid + ":" + issi + msg;

}
//MSG: 多选 返回消息
function MulSMsg(mselGroupId, issi, msg, hookmethodsel) {
    //将消息翻译成相关语言 逻辑中就使用相关语言
    msg = GetTextByName(msg, useprameters.languagedata);//多语言版才能使用

    if (document.frames["DXGroup_ifr"] != null || document.frames["DXGroup_ifr"] != undefined) {
        var obj = document.frames["DXGroup_ifr"];
        if (msg == GetTextByName("MSEL_CC_CONNECT", useprameters.languagedata)) {//多语言：对方已接听
            obj.AddMsg(GetTextByName("Lang_BegDXGroupCall", useprameters.languagedata) + "(" + mselGroupId + ")");//多语言：开始多选组广播
        }
        if (msg == GetTextByName("MSEL_END", useprameters.languagedata)) {//多语言：呼叫结束
            obj.AddMsg(GetTextByName("Lang_EndDXGroupCall", useprameters.languagedata) + "(" + mselGroupId + ")");//多语言：结束多选组广播
        }
    }
}
//MSG: 紧急呼叫消息
function PPCMsg(issi, eventtype, msg, gssi, hookmethodsel) {
    //将消息翻译成相关语言 逻辑中就使用相关语言
    msg = GetTextByName(msg, useprameters.languagedata);//多语言版才能使用

    if (msg == GetTextByName("PPC_CONNECTACK", useprameters.languagedata) || msg == GetTextByName("PPC_CONNECT", useprameters.languagedata) || msg == GetTextByName("PPC_CALLREQUEST", useprameters.languagedata)) {//多语言：呼叫已连接；对方已接听；有呼叫请求进入
        ppcCallingIssi = issi;
    }

    if (eventtype == "00") {
        if (msg == GetTextByName("PPC_CONNECTACK", useprameters.languagedata) || msg == GetTextByName("PPC_CONNECT", useprameters.languagedata)) {//多语言：呼叫已连接；对方已接听
            ppcsceasedPTT(issi);
        }
    }

    if (eventtype.toString() == "10") {//组呼
        //**********************************************************
        //**********************************************************
        //#######################  组呼   ##########################
        //**********************************************************
        //**********************************************************
        if (document.frames["mypancallContent"].document.frames["ppcgroupcallContent"].IsExsit(gssi) && msg != GetTextByName("PPC_CALLREQUEST", useprameters.languagedata)) {//多语言：有呼叫请求进入

            //**********************************************************
            //#######################  有呼叫请求进入   #################
            //**********************************************************
            if (document.frames["mypancallContent"].document.frames["ppcgroupcallContent"].document.getElementById('sp_' + gssi) != null) {
                //document.frames["mypancallContent"].document.frames["ppcgroupcallContent"].document.getElementById('sp_' + gssi).innerHTML = issi + ":" + msg;
                document.frames["mypancallContent"].document.frames["ppcgroupcallContent"].ChangeMsgByGssi(gssi, issi, msg);
            }
        }
        else {
            document.frames["mypancallContent"].document.frames["ppcgroupcallContent"].msgToPanal(gssi, GetTextByName("EmergencyCallGroup", useprameters.languagedata), msg);//多语言：紧急呼叫组呼
        }
        if (msg == GetTextByName("PPC_CALLREQUEST", useprameters.languagedata)) {//多语言：有呼叫请求进入

            //*************************************************************
            //##########  组呼  #########  有呼叫请求进入   #################
            //*************************************************************
            if (document.frames["mypancallContent"].document.frames["ppcgroupcallContent"].document.getElementById('btnppcend_' + gssi) != null) {
                document.frames["mypancallContent"].document.frames["ppcgroupcallContent"].document.getElementById('btnppcend_' + gssi).disabled = false;
            }
        }
        else {
            if (document.frames["mypancallContent"].document.frames["ppcgroupcallContent"].document.getElementById('btnppcend_' + gssi) != null) {
                document.frames["mypancallContent"].document.frames["ppcgroupcallContent"].document.getElementById('btnppcend_' + gssi).disabled = false;
            }
            if (document.frames["mypancallContent"].document.frames["ppcgroupcallContent"].document.getElementById('sp_' + gssi) != null) {
                //document.frames["mypancallContent"].document.frames["ppcgroupcallContent"].document.getElementById('sp_' + gssi).innerHTML = issi + ":" + msg;
                document.frames["mypancallContent"].document.frames["ppcgroupcallContent"].ChangeMsgByGssi(gssi, issi, msg);
            }
            document.frames["mypancallContent"].EndPPCCall2();
            //改变呼叫框样式 
            if (document.frames["mypancallContent"].document.frames["ppcgroupcallContent"].document.getElementById('table_' + gssi) != null) {
                document.frames["mypancallContent"].document.frames["ppcgroupcallContent"].document.getElementById('table_' + gssi).setAttribute("class", "table3");
            }
        }
        if (msg == GetTextByName("PPC_RELEASE", useprameters.languagedata)) {//多语言：对方挂断

            //*************************************************************
            //##########  组呼  #########  对方挂断   #################
            //*************************************************************
            ppcCallingIssi = "";
            if (document.frames["mypancallContent"].document.frames["ppcgroupcallContent"].document.getElementById('btnppcend_' + gssi) != null) {
                document.frames["mypancallContent"].document.frames["ppcgroupcallContent"].document.getElementById('btnppcend_' + gssi).disabled = true;
            }
        }
        if (msg == GetTextByName("PPC_END", useprameters.languagedata)) {//多语言：呼叫结束

            //*************************************************************
            //##########  组呼  #########  呼叫结束   #################
            //*************************************************************
            ppcCallingIssi = "";
            if (document.frames["mypancallContent"].document.frames["ppcgroupcallContent"].document.getElementById('btnppcend_' + gssi) != null) {
                document.frames["mypancallContent"].document.frames["ppcgroupcallContent"].document.getElementById('btnppcend_' + gssi).disabled = true;
            }
        }
    }
    else if (eventtype.toString() == "22") {//表示呼叫结束 调度台结束
        if (document.frames["mypancallContent"].document.frames["ppcgroupcallContent"].document.getElementById('btnppcend_' + gssi) != null) {
            document.frames["mypancallContent"].document.frames["ppcgroupcallContent"].document.getElementById('btnppcend_' + gssi).disabled = true;
        }
        if (document.frames["mypancallContent"].document.frames["ppcgroupcallContent"].document.getElementById('sp_' + gssi) != null) {
            //document.frames["mypancallContent"].document.frames["ppcgroupcallContent"].document.getElementById('sp_' + gssi).innerHTML = issi + ":" + msg;
            document.frames["mypancallContent"].document.frames["ppcgroupcallContent"].ChangeMsgByGssi(gssi, issi, msg);
        }
        document.frames["mypancallContent"].EndPPCCall2();
        //改变呼叫框样式 
        if (document.frames["mypancallContent"].document.frames["ppcgroupcallContent"].document.getElementById('table_' + gssi) != null) {
            document.frames["mypancallContent"].document.frames["ppcgroupcallContent"].document.getElementById('table_' + gssi).setAttribute("class", "table3");
        }
    }
    else if (eventtype.toString() == "01") { //全双工单呼

        //**********************************************************
        //**********************************************************
        //#######################  全双工单呼   #####################
        //**********************************************************
        //**********************************************************
        if (msg == GetTextByName("PPC_CALLREQUEST", useprameters.languagedata)) {//多语言：有呼叫请求进入

            document.frames["mypancallContent"].document.frames["singlecallContent"].msgToPanal(issi, GetTextByName("EmergencyAllSingleCall", useprameters.languagedata), msg);//多语言：EmergencyAllSingleCall紧急全双工单呼

        }
        else if (msg == GetTextByName("PPC_ALERT", useprameters.languagedata)) {//多语言：对方在振铃中

            if (document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('table11_' + issi) != null) {
                document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('table11_' + issi).setAttribute("class", "ppcTable1");
            }
            if (document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('img11_' + issi) != null) {
                document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('img11_' + issi).src = strUpCallingPicUrl;
            }
            if (document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('btnbegppc_' + issi) != null) {
                document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('btnbegppc_' + issi).disabled = true;
                document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('btnendppc_' + issi).disabled = false;
                document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('btnclose11_' + issi).disabled = true;
            }
            if (document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('sp11_' + issi) != null) {
                //document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('sp11_' + issi).innerHTML = msg;
                document.frames["mypancallContent"].document.frames["singlecallContent"].ChangeMsgByIssi('sp11', issi, msg);
            }

        }
        else if (msg == GetTextByName("PPC_CONNECTACK", useprameters.languagedata)) {//多语言：呼叫已连接
            //自动接听的时候 需要特殊处理
            document.frames["mypancallContent"].document.frames["singlecallContent"].addCallingType(issi, "11");
            if (document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('sp11_' + issi) != null) {
                //document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('sp11_' + issi).innerHTML = msg;
                document.frames["mypancallContent"].document.frames["singlecallContent"].ChangeMsgByIssi('sp11', issi, msg);
            }
            document.frames["mypancallContent"].EndSingCallFun2();
            document.frames["mypancallContent"].document.frames["singlecallContent"].iscallissi = issi;
            callPanalISSI = issi;
            document.frames["mypancallContent"].document.frames["singlecallContent"].updateFlagByIssi(issi, true, "11"); //对方挂断后，设置为未读状态
            if (document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('img11_' + issi) != null) {
                document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('img11_' + issi).src = strUpCallingPicUrl;
            }

        }
        else if (msg == GetTextByName("PPC_RELEASE", useprameters.languagedata)) {//多语言：对方挂断

            ppcCallingIssi = "";
            document.frames["mypancallContent"].document.frames["singlecallContent"].removeCallingtype(issi, "11");
            var mycallPanalISSI = callPanalISSI;
            var myiscallissi = document.frames["mypancallContent"].document.frames["singlecallContent"].iscallissi;
            callPanalISSI = "";
            document.frames["mypancallContent"].document.frames["singlecallContent"].iscallissi = "";

            if (document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('img11_' + issi) != null) {
                document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('img11_' + issi).src = strUpCallEndCallPicUrl;
            }

            //改变呼叫框样式 
            if (document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('table11_' + issi) != null) {
                document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('table11_' + issi).setAttribute("class", "ppcTable3");
            }

            //改变呼叫按钮
            if (document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('btnbegppc_' + issi) != null) {
                document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('btnbegppc_' + issi).disabled = false;
                document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('btnendppc_' + issi).disabled = true;
                document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('btnclose11_' + issi).disabled = false;
                document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('btnbegppc_' + issi).value = GetTextByName("Called", useprameters.languagedata);//多语言：呼叫
            }

            //自动接听
            if (hookmethodsel.toString() == "0" && document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('sp11_' + issi) != null) {//自动接听
                //document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('sp11_' + issi).innerHTML = msg;
                document.frames["mypancallContent"].document.frames["singlecallContent"].ChangeMsgByIssi('sp11', issi, msg);
            }

            //1已接听
            if (issi.toString() == document.frames["mypancallContent"].document.frames["singlecallContent"].iscallissi.toString()) {
                if (document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('sp11_' + issi) != null) {
                    //document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('sp11_' + issi).innerHTML = msg;
                    document.frames["mypancallContent"].document.frames["singlecallContent"].ChangeMsgByIssi('sp11', issi, msg);
                }
                document.frames["mypancallContent"].document.frames["singlecallContent"].updateFlagByIssi(issi, true, "11"); //对方挂断后，设置为未读状态
            }
            else {//2未接听
                if (document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('sp11_' + issi) != null) {
                    if (!document.frames["mypancallContent"].document.frames["singlecallContent"].findFlagByIssi(issi, "11")) {
                        document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('sp11_' + issi).innerHTML = "<span  style='color:Blue'>" + GetTextByName("Call_Div_UnReceiveCall", useprameters.languagedata) + "</span>" + "[" + LOGTimeGet() + "]";//多语言：未接呼叫
                        //document.frames["mypancallContent"].document.frames["singlecallContent"].ChangeMsgByIssi('sp11', issi, "<span  style='color:Blue'>" + GetTextByName("Call_Div_UnReceiveCall", useprameters.languagedata) + "</span>" + "[" + LOGTimeGet() + "]");

                        document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('table11_' + issi).setAttribute("class", "ppcTable2");
                        callPanalISSI = mycallPanalISSI;
                        document.frames["mypancallContent"].document.frames["singlecallContent"].iscallissi = myiscallissi;
                        document.frames["mypancallContent"].document.frames["singlecallContent"].updateFlagByIssi(issi, false, "11"); //对方挂断后，设置为未读状态
                        if (document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('img11_' + issi) != null) {
                            document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('img11_' + issi).src = strUpCallUnRevPicUrl;
                        }
                    }
                    else {
                        //document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('sp11_' + issi).innerHTML = msg;
                        document.frames["mypancallContent"].document.frames["singlecallContent"].ChangeMsgByIssi('sp11', issi, msg);
                        document.frames["mypancallContent"].document.frames["singlecallContent"].updateFlagByIssi(issi, true, "11"); //对方挂断后，设置为未读状态
                    }
                }
            }

        }
        else {

            if (document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('sp11_' + issi) != null) {
                //document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('sp11_' + issi).innerHTML = msg;
                document.frames["mypancallContent"].document.frames["singlecallContent"].ChangeMsgByIssi('sp11', issi, msg);
            }

        }
    }
    else if (eventtype == "00") {//半双工单呼

        //**********************************************************
        //**********************************************************
        //#######################  半双工单呼   #####################
        //**********************************************************
        //**********************************************************
        if (msg == GetTextByName("PPC_CALLREQUEST", useprameters.languagedata)) {//多语言：有呼叫请求进入

            //**********************************************************
            //###########################有呼叫请求进入##################
            //**********************************************************
            document.frames["mypancallContent"].document.frames["singlecallContent"].msgToPanal(issi, GetTextByName("EmergencyHalfSingleCall", useprameters.languagedata), msg);//多语言：紧急半双工单呼

        }
        else if (msg == GetTextByName("PPC_CONNECTACK", useprameters.languagedata)) {//多语言：呼叫已连接

            if (document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('table10_' + issi) != null) {
                document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('table10_' + issi).setAttribute("class", "ppcTable1");
            }
            if (document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('img10_' + issi) != null) {
                document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('img10_' + issi).src = strUpCallingPicUrl;
            }
            document.frames["mypancallContent"].document.frames["singlecallContent"].addCallingType(issi, "10");
            if (document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('btnppcbegptt_' + issi) != null) {
                document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('btnppcbegptt_' + issi).style.display = "none";
                document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('btnppcptt_' + issi).style.display = "block";
                document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('btnendppcqsg_' + issi).disabled = false;
                document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('btnclose10_' + issi).disabled = true;
            }

            if (document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('sp10_' + issi) != null) {
                //document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('sp10_' + issi).innerHTML = issi + ":" + msg;
                document.frames["mypancallContent"].document.frames["singlecallContent"].ChangeMsgByIssi('sp10', issi, msg);
            }
            document.frames["mypancallContent"].EndSingCallFun2();
            callPanalISSI = issi;
            document.frames["mypancallContent"].document.frames["singlecallContent"].iscallissi = issi;
            document.frames["mypancallContent"].document.frames["singlecallContent"].updateFlagByIssi(issi, true, "10"); //对方挂断后，设置为未读状态

        }
        else if (msg == GetTextByName("CALL_IN_HANDLE", useprameters.languagedata)) {//多语言：呼叫正在处理中，API把此消息给过滤了
            //**********************************************************
            //###########################呼叫正在处理中######################
            //**********************************************************
            if (document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('table10_' + issi) != null) {
                document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('table10_' + issi).setAttribute("class", "ppcTable1");
            }
            if (document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('img10_' + issi) != null) {
                document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('img10_' + issi).src = strUpCallingPicUrl;
            }
            if (document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('sp10_' + document.frames["mypancallContent"].document.frames["singlecallContent"].iscallissi.toString()) != null) {
                //document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('sp10_' + document.frames["mypancallContent"].document.frames["singlecallContent"].iscallissi.toString()).innerHTML = issi + ":" + msg;
                document.frames["mypancallContent"].document.frames["singlecallContent"].ChangeMsgByIssi('sp10', issi, msg);
            }
            if (document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('sp10_' + issi) != null) {
                //document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('sp10_' + issi).innerHTML = issi + ":" + msg;
                document.frames["mypancallContent"].document.frames["singlecallContent"].ChangeMsgByIssi('sp10', issi, msg);
            }

            if (document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('btnppcbegptt_' + issi) != null && document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('btnppcptt_' + issi) != null) {
                document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('btnppcptt_' + issi).style.display = "block";
                document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('btnppcbegptt_' + issi).style.display = "none";
                document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('btnendppcqsg_' + issi).disabled = false;
                document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('btnclose10_' + issi).disabled = false;
                document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('btnppcbegptt_' + issi).value = GetTextByName("Called", useprameters.languagedata);//多语言：呼叫
            }

        }
        else if (msg == GetTextByName("PPC_CONNECT", useprameters.languagedata)) {//多语言：对方已接听

            //**********************************************************
            //###########################对方已接听######################
            //**********************************************************
            if (document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('table10_' + issi) != null) {
                document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('table10_' + issi).setAttribute("class", "ppcTable1");
            }
            if (document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('img10_' + issi) != null) {
                document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('img10_' + issi).src = strUpCallingPicUrl;
            }
            document.frames["mypancallContent"].document.frames["singlecallContent"].addCallingType(issi, "10");
            if (document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('btnppcbegptt_' + issi) != null) {
                document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('btnppcbegptt_' + issi).style.display = "none";
                document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('btnppcptt_' + issi).style.display = "block";
                document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('btnendppcqsg_' + issi).disabled = false;
                document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('btnclose10_' + issi).disabled = true;
            } else {
                setTimeout(function () {
                    if (document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('btnppcbegptt_' + issi) != null) {
                        document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('btnppcbegptt_' + issi).style.display = "none";
                        document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('btnppcptt_' + issi).style.display = "block";
                        document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('btnendppcqsg_' + issi).disabled = false;
                        document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('btnclose10_' + issi).disabled = true;
                    }
                }, 1000);

            }

            if (document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('sp10_' + issi) != null) {
                //document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('sp10_' + issi).innerHTML = issi + ":" + msg;
                document.frames["mypancallContent"].document.frames["singlecallContent"].ChangeMsgByIssi('sp10', issi, msg);
            }
            document.frames["mypancallContent"].EndSingCallFun2();
            callPanalISSI = issi;
            document.frames["mypancallContent"].document.frames["singlecallContent"].iscallissi = issi;
            document.frames["mypancallContent"].document.frames["singlecallContent"].updateFlagByIssi(issi, true, "10"); //对方挂断后，设置为未读状态
        }
        else if (msg == GetTextByName("PPC_RELEASE", useprameters.languagedata)) {//多语言：对方挂断

            //**********************************************************
            //###########################对方挂断########################
            //**********************************************************
            ppcCallingIssi = "";
            document.frames["mypancallContent"].document.frames["singlecallContent"].removeCallingtype(issi, "10");
            var mycallPanalISSI = callPanalISSI;
            var myiscallissi = document.frames["mypancallContent"].document.frames["singlecallContent"].iscallissi;
            callPanalISSI = "";
            document.frames["mypancallContent"].document.frames["singlecallContent"].iscallissi = "";
            if (document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('img10_' + issi) != null) {
                document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('img10_' + issi).src = strUpCallEndCallPicUrl;
            }
            if (document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('table10_' + issi) != null) {
                document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('table10_' + issi).setAttribute("class", "ppcTable3");
            }
            //修改PTT为开始按钮
            if (document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('btnppcptt_' + issi) != null && document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('btnppcbegptt_' + issi) != null) {
                document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('btnppcptt_' + issi).style.display = "none";
                document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('btnppcbegptt_' + issi).style.display = "block";
                document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('btnendppcqsg_' + issi).disabled = true;
                document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('btnclose10_' + issi).disabled = false;
                document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('btnppcbegptt_' + issi).value = GetTextByName("Called", useprameters.languagedata);//多语言：呼叫
            }
            if (hookmethodsel.toString() == "0" && document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('sp10_' + issi) != null) {
                //document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('sp10_' + issi).innerHTML = msg;
                document.frames["mypancallContent"].document.frames["singlecallContent"].ChangeMsgByIssi('sp10', issi, msg);
            }
            if (issi.toString() == document.frames["mypancallContent"].document.frames["singlecallContent"].iscallissi.toString()) {
                if (document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('sp10_' + issi) != null) {
                    //document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('sp10_' + issi).innerHTML = issi + ":" + msg;
                    document.frames["mypancallContent"].document.frames["singlecallContent"].ChangeMsgByIssi('sp10', issi, msg);
                }
                document.frames["mypancallContent"].document.frames["singlecallContent"].updateFlagByIssi(issi, true, "10"); //对方挂断后，设置为未读状态
            } else {
                if (document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('sp10_' + issi) != null) {
                    if (!document.frames["mypancallContent"].document.frames["singlecallContent"].findFlagByIssi(issi, "10")) {
                        document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('sp10_' + issi).innerHTML = "<span  style='color:Blue'>" + GetTextByName("Call_Div_UnReceiveCall", useprameters.languagedata) + "</span>" + "[" + LOGTimeGet() + "]";//多语言：未接呼叫
                        //document.frames["mypancallContent"].document.frames["singlecallContent"].ChangeMsgByIssi('sp10', issi, "<span  style='color:Blue'>" + GetTextByName("Call_Div_UnReceiveCall", useprameters.languagedata) + "</span>" + "[" + LOGTimeGet() + "]");
                        document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('table10_' + issi).setAttribute("class", "ppcTable2");
                        callPanalISSI = mycallPanalISSI;
                        document.frames["mypancallContent"].document.frames["singlecallContent"].iscallissi = myiscallissi;
                        document.frames["mypancallContent"].document.frames["singlecallContent"].updateFlagByIssi(issi, false, 10); //对方挂断后，设置为未读状态
                        if (document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('img10_' + issi) != null) {
                            document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('img10_' + issi).src = strUpCallUnRevPicUrl;
                        }
                    } else {
                        //document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('sp10_' + issi).innerHTML = msg;
                        document.frames["mypancallContent"].document.frames["singlecallContent"].ChangeMsgByIssi('sp10', issi, msg);
                        document.frames["mypancallContent"].document.frames["singlecallContent"].updateFlagByIssi(issi, true, 10); //对方挂断后，设置为未读状态
                    }
                }
            }
        }
        else {

            if (document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('img10_' + issi) != null) {
                document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('img10_' + issi).src = strUpCallingPicUrl;
            }
            if (document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('sp10_' + document.frames["mypancallContent"].document.frames["singlecallContent"].iscallissi.toString()) != null) {
                //document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('sp10_' + document.frames["mypancallContent"].document.frames["singlecallContent"].iscallissi.toString()).innerHTML = issi + ":" + msg;
                document.frames["mypancallContent"].document.frames["singlecallContent"].ChangeMsgByIssi('sp10', issi, msg);
            }
            if (document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('sp10_' + issi) != null) {
                //document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('sp10_' + issi).innerHTML = issi + ":" + msg;
                document.frames["mypancallContent"].document.frames["singlecallContent"].ChangeMsgByIssi('sp10', issi, msg);
            }
        }

    }

    if (msg == GetTextByName("PPC_CALLREQUEST", useprameters.languagedata)) {//多语言：有呼叫请求进入

        upgrouparry(gssi, issi, eventtype, GetTextByName("Up_Call", useprameters.languagedata), "ppc");//多语言：上行
        if (eventtype.toString() == "10") {
            //doPaly(); //播放组呼紧急呼叫铃音
        } else if (eventtype.toString() == "01") {  //根据呼叫类型在操作窗口中显示 全双工单呼
        }

    }
    else if (msg == GetTextByName("PPC_CONNECTACK", useprameters.languagedata)) {//多语言：呼叫已连接

        upgrouparry(gssi, issi, eventtype, GetTextByName("Up_Call", useprameters.languagedata), "ppc");//多语言：上行

    }
    else if (msg == GetTextByName("PPC_ALERT", useprameters.languagedata)) {//多语言：对方在振铃中

        upgrouparry(gssi, issi, eventtype, GetTextByName("Down_Call", useprameters.languagedata), "ppc");//多语言：下行

    }
    else if (msg == GetTextByName("PPC_CONNECT", useprameters.languagedata)) {//多语言：对方已接听

        upgrouparry(gssi, issi, eventtype, GetTextByName("Down_Call", useprameters.languagedata), "ppc");//多语言：下行

    }
    else if (msg == GetTextByName("PPC_RELEASE", useprameters.languagedata)) {//多语言：对方挂断

        delgrouparry(issi);
        if (eventtype.toString() == "10") {
            delgrouparry(getISSIByGssi(gssi));
        }
        if (eventtype.toString() == "00" || eventtype.toString() == "01") {
            document.frames["mypancallContent"].EndSingCallFun();
        }
        if (eventtype.toString() == "10") {
            //endPlay();
        }

    }
    else if (msg == GetTextByName("PPC_END", useprameters.languagedata)) {//多语言：呼叫结束

        delgrouparry(issi);
        if (eventtype.toString() == "10") {
            delgrouparry(getISSIByGssi(gssi));
        }

    }

    getIssiNameLoLaForPPCCall(issi, eventtype, msg, gssi, hookmethodsel);

    if (document.frames["PPCCall_ifr"] != null || document.frames["PPCCall_ifr"] != undefined) {

        if (msg == GetTextByName("PPC_CALLREQUEST", useprameters.languagedata)) {//多语言：有呼叫请求进入
            document.frames["PPCCall_ifr"].tochanage();
        }
        var str;
        switch (hookmethodsel) {
            case "0":
                str = GetTextByName("Automaticansweringmode", useprameters.languagedata);//多语言：自动应答模式
                if (msg == GetTextByName("PPC_CONNECTACK", useprameters.languagedata) || msg == GetTextByName("PPC_CONNECT", useprameters.languagedata)) {//多语言：呼叫已连接；对方已接听
                    document.frames["PPCCall_ifr"].flag = true;
                    ppcsceasedPTT(issi);
                }
                break;
            case "1":
                str = GetTextByName("NoAutomaticansweringmode", useprameters.languagedata);//多语言：非自动应答模式
                break;
            case "2":
                str = GetTextByName("DL_REJECTED_FOR_ANY_REASON", useprameters.languagedata);//多语言：无
                break;
            default: break;
        };

        switch (eventtype) {
            case "00": //表示单呼半双工
                var isCase1 = document.frames["PPCCall_ifr"].document.getElementById("txtISSIOrGSSIText").value.trim() == issi ? true : false;
                var isCase2 = (useprameters.hostISSI == issi && PanalPPCCallISSI == document.frames["PPCCall_ifr"].document.getElementById("txtISSIOrGSSIText").value.trim()) ? true : false;

                if (isCase1 || isCase2) {
                    document.frames["PPCCall_ifr"].document.getElementById("divstatue").innerHTML = GetTextByName("Number", useprameters.languagedata) + ":" + issi + "<br>" + GetTextByName("Type", useprameters.languagedata) + ":" + GetTextByName("EmergencyHalfSingleCall", useprameters.languagedata) + "<br>" + GetTextByName("Message", useprameters.languagedata) + ":" + msg + "<br>" + GetTextByName("answeringmode", useprameters.languagedata) + ":" + str;//多语言：号码，类型，单呼半双工，消息，应答模式

                    var calltype = document.frames["PPCCall_ifr"].document.getElementById('calltype');

                    if (msg == GetTextByName("PPC_RELEASE", useprameters.languagedata)) {//开始按钮显示（呼叫），结束按钮隐藏，用户名可改，用户选择按钮可见，呼叫类型可改 多语言：对方挂断
                        document.frames["PPCCall_ifr"].document.getElementById("begincall").style.display = "inline";
                        document.frames["PPCCall_ifr"].document.getElementById('begincall').innerHTML = "PTT";
                        document.frames["PPCCall_ifr"].document.getElementById("endcall").style.display = "none";
                        endppcSC(issi);
                        document.frames["PPCCall_ifr"].document.getElementById("imgSelectUser").style.display = "inline";
                        document.frames["PPCCall_ifr"].document.getElementById("txtISSIOrGSSIText").disabled = false;
                        callPanalISSI = "";//对方挂断
                        calltype[0].disabled = false;
                        calltype[1].disabled = false;
                        calltype[2].disabled = false;
                    }
                    else if (msg == GetTextByName("PPC_CALLREQUEST", useprameters.languagedata)) { //处理半双工紧急呼叫请求进入 多语言：有呼叫请求进入
                        if (isCase1) {//变成接听的界面，还需要处理自动接听的 
                            if (hookmethodsel == "0") {//自动应答模式 
                                calltype.selectedIndex = 2;
                                calltype[0].disabled = true;
                                calltype[1].disabled = true;
                                calltype[2].disabled = false;
                                document.frames["PPCCall_ifr"].document.getElementById("trUserBtn").style.display = "inline";
                                document.frames["PPCCall_ifr"].document.getElementById("begincall").style.display = "inline";
                                document.frames["PPCCall_ifr"].document.getElementById("endcall").style.display = "inline";
                                document.frames["PPCCall_ifr"].document.getElementById("begincall").innerHTML = "PTT";
                                document.frames["PPCCall_ifr"].document.getElementById("imgSelectUser").style.display = "none";
                                document.frames["PPCCall_ifr"].document.getElementById("txtISSIOrGSSIText").disabled = true;

                            }
                            else {//非自动应答模式 
                                calltype.selectedIndex = 2;
                                calltype[0].disabled = true;
                                calltype[1].disabled = true;
                                calltype[2].disabled = false;
                                document.frames["PPCCall_ifr"].document.getElementById("trUserBtn").style.display = "inline";
                                document.frames["PPCCall_ifr"].document.getElementById("begincall").style.display = "inline";
                                document.frames["PPCCall_ifr"].document.getElementById("endcall").style.display = "inline";
                                document.frames["PPCCall_ifr"].document.getElementById("begincall").innerHTML = "PTT";
                                document.frames["PPCCall_ifr"].document.getElementById("imgSelectUser").style.display = "none";
                                document.frames["PPCCall_ifr"].document.getElementById("txtISSIOrGSSIText").disabled = true;
                            }
                        }
                    }
                    else {
                        calltype.selectedIndex = 2;
                        calltype[0].disabled = true;
                        calltype[1].disabled = true;
                        calltype[2].disabled = false;
                        document.frames["PPCCall_ifr"].document.getElementById("trUserBtn").style.display = "inline";
                        document.frames["PPCCall_ifr"].document.getElementById("begincall").style.display = "inline";
                        document.frames["PPCCall_ifr"].document.getElementById("endcall").style.display = "inline";
                        document.frames["PPCCall_ifr"].document.getElementById("begincall").innerHTML = "PTT";
                        document.frames["PPCCall_ifr"].document.getElementById("imgSelectUser").style.display = "none";
                        document.frames["PPCCall_ifr"].document.getElementById("txtISSIOrGSSIText").disabled = true;
                    }

                }
                break;
            case "01": //表示单呼全双工
                var isCase1 = document.frames["PPCCall_ifr"].document.getElementById("txtISSIOrGSSIText").value.trim() == issi ? true : false;
                var isCase2 = (useprameters.hostISSI == issi && PanalPPCCallISSI == document.frames["PPCCall_ifr"].document.getElementById("txtISSIOrGSSIText").value.trim()) ? true : false;
                if (isCase1 || isCase2) {
                    //打印消息
                    document.frames["PPCCall_ifr"].document.getElementById("divstatue").innerHTML = GetTextByName("Number", useprameters.languagedata) + ":" + issi + "<br>" + GetTextByName("Type", useprameters.languagedata) + ":" + GetTextByName("EmergencyAllSingleCall", useprameters.languagedata) + "<br>" + GetTextByName("Message", useprameters.languagedata) + ":" + msg + "<br>" + GetTextByName("answeringmode", useprameters.languagedata) + ":" + str;//多语言：号码，类型，单呼全双工，消息，应答模式

                    var calltype = document.frames["PPCCall_ifr"].document.getElementById('calltype');

                    if (msg == GetTextByName("PPC_RELEASE", useprameters.languagedata)) {//开始按钮显示（呼叫），结束按钮隐藏，用户名可改，用户选择按钮可见，呼叫类型可改
                        document.frames["PPCCall_ifr"].document.getElementById("begincall").style.display = "inline";
                        document.frames["PPCCall_ifr"].document.getElementById('begincall').innerHTML = GetTextByName("Called", useprameters.languagedata);//多语言：呼叫
                        document.frames["PPCCall_ifr"].document.getElementById("endcall").style.display = "none";
                        document.frames["PPCCall_ifr"].document.getElementById("imgSelectUser").style.display = "inline";
                        document.frames["PPCCall_ifr"].document.getElementById("txtISSIOrGSSIText").disabled = false;
                        endppcDC(issi);
                        callPanalISSI = "";
                        calltype[0].disabled = false;
                        calltype[1].disabled = false;
                        calltype[2].disabled = false;
                    }
                    else if (msg == GetTextByName("PPC_CALLREQUEST", useprameters.languagedata)) {//处理全双工紧急呼叫请求进入

                        if (isCase1) {//变成接听的界面，还需要处理自动接听的 
                            if (hookmethodsel == "0") {//自动应答模式  全双工没有自动应答模式

                            }
                            else {//非自动应答模式 
                                calltype.selectedIndex = 1;
                                calltype[0].disabled = true;
                                calltype[1].disabled = false;
                                calltype[2].disabled = true;
                                document.frames["PPCCall_ifr"].document.getElementById("trUserBtn").style.display = "inline";
                                document.frames["PPCCall_ifr"].document.getElementById("begincall").style.display = "inline";
                                document.frames["PPCCall_ifr"].document.getElementById("endcall").style.display = "inline";
                                document.frames["PPCCall_ifr"].document.getElementById("begincall").innerHTML = GetTextByName("Toanswer", useprameters.languagedata);//多语言：接听
                                document.frames["PPCCall_ifr"].document.getElementById("imgSelectUser").style.display = "none";
                                document.frames["PPCCall_ifr"].document.getElementById("txtISSIOrGSSIText").disabled = true;
                            }
                        }
                    }
                    else {//将半双工接受的 转过来
                        calltype.selectedIndex = 1;
                        calltype[0].disabled = true;
                        calltype[1].disabled = false;
                        calltype[2].disabled = true;
                        document.frames["PPCCall_ifr"].document.getElementById("trUserBtn").style.display = "inline";
                        document.frames["PPCCall_ifr"].document.getElementById("begincall").style.display = "none";
                        document.frames["PPCCall_ifr"].document.getElementById("endcall").style.display = "inline";
                        document.frames["PPCCall_ifr"].document.getElementById("imgSelectUser").style.display = "none";
                        document.frames["PPCCall_ifr"].document.getElementById("txtISSIOrGSSIText").disabled = true;
                    }
                }
                break;
            case "10": //表示组呼
                //只有当操作窗口的GSSI跟返回的消息GSSI相同 或者是调度台issi（只有同时打开一个紧急呼叫才行，不然无法处理） 才处理 组消息
                if (document.frames["PPCCall_ifr"].document.getElementById("txtISSIOrGSSIText").value.trim() == gssi || useprameters.hostISSI == issi) {
                    //打印消息
                    document.frames["PPCCall_ifr"].document.getElementById("divstatue").innerHTML = "ISSI:" + issi + "<br>GSSI:" + gssi + "<br>" + GetTextByName("Type", useprameters.languagedata) + ":" + GetTextByName("GroupCall", useprameters.languagedata) + "<br>" + GetTextByName("Message", useprameters.languagedata) + ":" + msg + "<br>" + GetTextByName("answeringmode", useprameters.languagedata) + ":" + str;//多语言：类型；组呼；消息；应答模式
                    if (msg == GetTextByName("PPC_CALLREQUEST", useprameters.languagedata)) {//多语言:有呼叫请求进入

                        document.frames["PPCCall_ifr"].document.getElementById("btnGEndCall").style.display = "block";

                    };
                }
                break;
            case "11":
                //oxc不存在11这个类型
                break;
            case "22":
                if (document.frames["PPCCall_ifr"].document.getElementById("txtISSIOrGSSIText").value.trim() == gssi || document.frames["PPCCall_ifr"].document.getElementById("txtISSIOrGSSIText").value.trim() == issi || useprameters.hostISSI == issi) {
                    document.frames["PPCCall_ifr"].document.getElementById("divstatue").innerHTML = GetTextByName("PPC_END", useprameters.languagedata);//多语言：呼叫结束
                }
                break;

            default: break;
        }
    }
}
//MSG: 环境监听
function AlMsg(issi, report, altype) {
    //将消息翻译成相关语言 逻辑中就使用相关语言
    report = GetTextByName(report, useprameters.languagedata);//多语言版才能使用

    if (altype == 0) {
        if (document.frames["ALCall_ifr"] != null || document.frames["ALCall_ifr"] != undefined) {
            document.frames["ALCall_ifr"].document.getElementById("divstatue").innerHTML = GetTextByName("MonitoredNumber", useprameters.languagedata) + ":" + issi + "<br>" + GetTextByName("StartListening", useprameters.languagedata) + ":" + report;//多语言：被监听的号码;开始监听
            document.frames["ALCall_ifr"].document.getElementById("btnEndCall").style.display = "block";
            document.frames["ALCall_ifr"].document.getElementById("btnStartCall").style.display = "none";

            document.frames["ALCall_ifr"].document.getElementById("imgSelectUser").style.display = "none";
            document.frames["ALCall_ifr"].document.getElementById("txtISSIText").disabled = true;
        }
    }
    else if (altype == 1 || altype == 3) {//1是结束监听；3是中断监听
        if (document.frames["ALCall_ifr"] != null || document.frames["ALCall_ifr"] != undefined) {

            document.frames["ALCall_ifr"].setFlagFalse();

            document.frames["ALCall_ifr"].document.getElementById("divstatue").innerHTML = GetTextByName("MonitoredNumber", useprameters.languagedata) + ":" + issi + "<br>" + GetTextByName("EndListening", useprameters.languagedata) + ":" + report;//多语言：被监听的号码；结束监听
            document.frames["ALCall_ifr"].document.getElementById("btnEndCall").style.display = "none";
            document.frames["ALCall_ifr"].document.getElementById("btnStartCall").style.display = "block";

            document.frames["ALCall_ifr"].document.getElementById("imgSelectUser").style.display = "block";
            document.frames["ALCall_ifr"].document.getElementById("txtISSIText").disabled = false;
            isPanalALCall = false;
        }
    }

}
//MSG: 基站呼叫
function BCMsg(issi, bctype, msg) {
    //将消息翻译成相关语言 逻辑中就使用相关语言
    msg = GetTextByName(msg, useprameters.languagedata);//多语言版才能使用

    mapMsgShow(issi, bctype, msg);

    if (document.frames["SBCall_ifr"] != null || document.frames["SBCall_ifr"] != undefined) {
        //基站广播回来的issi与操作窗口中的issi不相同 则操作窗口中不显示
        //操作窗口中的所有按钮都不可用（其实也没必要，地图上呼叫按钮时按着的时候才能使用，松开广播其实也结束了）
        //当操作窗口中存在以广播的 就不能发起下一个
        if (bctype.toString() == "3" && document.frames["SBCall_ifr"].document.getElementById("txtBaseStationNo").value != issi) {
            return;
        }

        var atype = "";
        switch (bctype.toString()) {
            case "3":
                atype = GetTextByName("Lang_SingleStationCall", useprameters.languagedata);//多语言：单站呼叫
                if (msg.indexOf(GetTextByName("BC_RELEASE", useprameters.languagedata)) >= 0) {//多语言：对方已挂断
                    showradio();
                    document.frames["SBCall_ifr"].document.getElementById("txtBaseStationNo").disabled = false;
                    document.frames["SBCall_ifr"].document.getElementById("btnnew").style.display = "block";
                    document.frames["SBCall_ifr"].document.getElementById("btnBegSingCall").style.display = "block";
                    document.frames["SBCall_ifr"].document.getElementById("btnEndSingCall").style.display = "none";
                }
                break;
            case "4":
                atype = GetTextByName("Lang_SMultiStationCall", useprameters.languagedata);//多语言：多站呼叫
                if (msg.indexOf(GetTextByName("BC_RELEASE", useprameters.languagedata)) >= 0) {//多语言：对方已挂断
                    showradio();
                    var mysel = document.frames["SBCall_ifr"].document.getElementById("selBSGroup");
                    for (var ipp = 0; ipp < mysel.length; ipp++) {
                        mysel[ipp].disabled = false;
                    }
                    document.frames["SBCall_ifr"].document.getElementById("btnBegMulCall").style.display = "block";
                    document.frames["SBCall_ifr"].document.getElementById("btnEndMulCall").style.display = "none";
                }
                break;
            case "5":
                atype = GetTextByName("Lang_TheStationCall", useprameters.languagedata);//多语言：全站呼叫
                if (msg.indexOf(GetTextByName("BC_RELEASE", useprameters.languagedata)) >= 0) {//多语言：对方已挂断
                    showradio();
                    document.frames["SBCall_ifr"].document.getElementById("btnBegAllCall").style.display = "block";
                    document.frames["SBCall_ifr"].document.getElementById("btnEndAllCall").style.display = "none";
                }
                break;
            default: break;
        }

        document.frames["SBCall_ifr"].document.getElementById("divstatue").innerHTML = GetTextByName("BaseStationIdentification", useprameters.languagedata) + ":" + issi + "<br>" + GetTextByName("Lang_BaseStationCallType", useprameters.languagedata) + ":" + atype + "<br>" + msg;//多语言： 基站标识；基站呼叫类型
    } else {//没有操作窗口的话 就是地图上的基站呼叫

    }
}
//MSG: 慎密监听返回消息函数
function DLMsg(issi, report, failreason, altype) {

    writeLog("system", "CallMsg(" + report + "," + failreason + ")");
    //将消息翻译成相关语言 逻辑中就使用相关语言
    if (altype != 4) {
        report = GetTextByName(report, useprameters.languagedata);//多语言版才能使用
    }
    failreason = GetTextByName(failreason, useprameters.languagedata);//多语言版才能使用
    writeLog("system", "CallMsg(" + report + "," + failreason + ")");


    if (document.frames["DLCall_ifr"] != null || document.frames["DLCall_ifr"] != undefined) {

        if (altype == 4) {
            if (report == 0 && lastDlISSI != 0) {
                report = lastDlISSI + GetTextByName("REALEASE_AUTHORIZATION", useprameters.languagedata);//多语言：释放授权
            } else if (report != 0) {
                lastDlISSI = report;
                report = report + GetTextByName("ACCESS_AUTHORIZATION", useprameters.languagedata);//多语言：获取授权
            } else {
                report = GetTextByName("NoOneSpoke", useprameters.languagedata);//多语言：无人发言
            }
        }

        document.frames["DLCall_ifr"].document.getElementById("divstatue").innerHTML = GetTextByName("MonitoredNumber", useprameters.languagedata) + ":" + issi + "<br>" + report + "<br>" + failreason;

        if ((altype == 2) && (failreason == GetTextByName("DL_CALL_INTRUSION_START_ACK_HALFDUPLEX", useprameters.languagedata))) {//多语言：半双工
            document.frames["DLCall_ifr"].document.getElementById("btnPTT").style.display = "block";
        }
        else {
            document.frames["DLCall_ifr"].document.getElementById("btnPTT").style.display = "none";
        }
        if ((altype == 0) && (report == GetTextByName("DL_START_SUCCEED", useprameters.languagedata))) {//强插强插可见,结束按钮可见 多语言：开始成功
            document.frames["DLCall_ifr"].document.getElementById("btnQCha").style.display = "block";
            document.frames["DLCall_ifr"].document.getElementById("btnQChai").style.display = "block";
            document.frames["DLCall_ifr"].document.getElementById("trBegJT").style.display = "block";
            document.frames["DLCall_ifr"].document.getElementById("trQCQC").style.display = "block";
            document.frames["DLCall_ifr"].document.getElementById("trPJ").style.display = "none";
        }
        if ((altype == 0) && (report == GetTextByName("DL_START_ACTIVATE_SUCCEED", useprameters.languagedata))) {//多语言：激活成功
            document.frames["DLCall_ifr"].document.getElementById("btnQCha").style.display = "none";
            document.frames["DLCall_ifr"].document.getElementById("btnQChai").style.display = "none";
            document.frames["DLCall_ifr"].document.getElementById("trBegJT").style.display = "block";
            document.frames["DLCall_ifr"].document.getElementById("trQCQC").style.display = "none";
            document.frames["DLCall_ifr"].document.getElementById("trPJ").style.display = "none";

        }
        if ((altype == 0) && (report == GetTextByName("DL_START_ACTIVATE_FAILURED", useprameters.languagedata))) {//多语言：开始失败
            document.frames["DLCall_ifr"].document.getElementById("btnQCha").style.display = "none";
            document.frames["DLCall_ifr"].document.getElementById("btnQChai").style.display = "none";
            document.frames["DLCall_ifr"].document.getElementById("btnJSJT").style.display = "none";
            document.frames["DLCall_ifr"].document.getElementById("btnKSJT").style.display = "block";
            document.frames["DLCall_ifr"].document.getElementById("trBegJT").style.display = "block";
            document.frames["DLCall_ifr"].document.getElementById("trQCQC").style.display = "none";
            document.frames["DLCall_ifr"].document.getElementById("trPJ").style.display = "none";
            document.frames["DLCall_ifr"].document.getElementById("imgSelectUser").style.display = "block";
            document.frames["DLCall_ifr"].document.getElementById("txtISSIText").disabled = false;
        }
        if (altype == 1) {
            document.frames["DLCall_ifr"].document.getElementById("btnQCha").style.display = "none";
            document.frames["DLCall_ifr"].document.getElementById("btnQChai").style.display = "none";
            document.frames["DLCall_ifr"].document.getElementById("btnJSJT").style.display = "none";
            document.frames["DLCall_ifr"].document.getElementById("btnKSJT").style.display = "block";
            document.frames["DLCall_ifr"].document.getElementById("trBegJT").style.display = "block";
            document.frames["DLCall_ifr"].document.getElementById("trQCQC").style.display = "none";
            document.frames["DLCall_ifr"].document.getElementById("trPJ").style.display = "none";
            document.frames["DLCall_ifr"].document.getElementById("imgSelectUser").style.display = "block";
            document.frames["DLCall_ifr"].document.getElementById("txtISSIText").disabled = false;
            isPanalDLCall = false;
        }
    }
}
var msgtimer;//消息清除
//MSG: 呼叫消息
function CallMsg(issi, eventtype, msg, gssi, hookmethodsel) {
    changebackimg("callgif", "call.gif", eventtype, issi, msg, gssi, hookmethodsel); //转发FLASH
    //(issi, eventtype, msg, gssi, hookmethodsel)
    clearTimeout(msgtimer);
    msgtimer = setTimeout(function () {
        document.getElementById("scrollarea").innerHTML = "";

    }, 20000);
    //将消息翻译成相关语言 逻辑中就使用相关语言
    msg = GetTextByName(msg, useprameters.languagedata);//多语言版才能使用
    /*
    if (msg == GetTextByName("CC_RELEASE", useprameters.languagedata) || GetTextByName("CC_END", useprameters.languagedata))//对方挂断，呼叫结束
    {
        callPanalISSI = "";
    }
    */
    //writeLog("system", "CallMsg(" + issi + "," + eventtype + "," + msg + "," + gssi + "," + hookmethodsel + ")");
    getIssiNameLoLa(issi, eventtype, msg, gssi, hookmethodsel)

    if (msg == GetTextByName("CC_CALLREQUEST", useprameters.languagedata)) {//有呼叫请求进入

        upgrouparry(gssi, issi, eventtype, GetTextByName("Up_Call", useprameters.languagedata), "normal");//多语言：上行

    }
    else if (msg == GetTextByName("CC_CONNECTACK", useprameters.languagedata)) {//呼叫已连接

        upgrouparry(gssi, issi, eventtype, GetTextByName("Up_Call", useprameters.languagedata), "normal");//多语言：上行

    }
    else if (msg == GetTextByName("CC_RELEASE", useprameters.languagedata)) {//对方挂断

        delgrouparry(issi);
        if (eventtype.toString() == "10") {
            delgrouparry(getISSIByGssi(gssi));
        }

    }
    else if (msg == GetTextByName("CC_END", useprameters.languagedata)) {//呼叫结束

        delgrouparry(issi);
        if (eventtype.toString() == "10") {
            delgrouparry(getISSIByGssi(gssi));
        }

    }
    else if (msg == GetTextByName("CC_ALERT", useprameters.languagedata)) {//对方在振铃中

        upgrouparry(gssi, issi, eventtype, GetTextByName("Down_Call", useprameters.languagedata), "normal");//多语言：下行

    }
    else if (msg == GetTextByName("CC_CONNECT", useprameters.languagedata)) {//对方已接听

        upgrouparry(gssi, issi, eventtype, GetTextByName("Down_Call", useprameters.languagedata), "normal");//多语言：下行

    }

    SXMsg(issi, eventtype, msg, gssi, hookmethodsel);

    //操作窗口里面的组呼消息
    if (document.frames["GroupCall_ifr"] != null || document.frames["GroupCall_ifr"] != undefined) {//组呼的话 个呼叫不需要了

        if (document.frames["GroupCall_ifr"].document.getElementById("txtGIIS") == null) {
        }
        else {
            if ((document.frames["GroupCall_ifr"].document.getElementById("txtGIIS").value.trim() != "" && document.frames["GroupCall_ifr"].document.getElementById("txtGIIS").value.trim() != gssi) || document.frames["GroupCall_ifr"].document.getElementById("txtGIIS").value.trim() == "") {
            }
            else {
                var str;

                if (hookmethodsel == 0) {
                    str = GetTextByName("Automaticansweringmode", useprameters.languagedata);//多语言：自动应答模式
                }
                else if (hookmethodsel == 1) {
                    str = GetTextByName("NoAutomaticansweringmode", useprameters.languagedata);//多语言：非自动应答模式
                }
                else if (hookmethodsel == 2) {
                    str = GetTextByName("DL_REJECTED_FOR_ANY_REASON", useprameters.languagedata);//多语言：无
                }

                if (eventtype == "10") {

                    document.frames["GroupCall_ifr"].document.getElementById("divstatue").innerHTML = "ISSI:" + issi + "<br>" + GetTextByName("Type", useprameters.languagedata) + ":" + GetTextByName("GroupCall", useprameters.languagedata) + "<br>" + GetTextByName("Message", useprameters.languagedata) + ":" + msg + "<br>" + GetTextByName("answeringmode", useprameters.languagedata) + ":" + str;//多语言：类型；组呼；消息；应答模式
                    if (msg == GetTextByName("CC_CALLREQUEST", useprameters.languagedata)) {//多语言：有呼叫请求进入
                        document.frames["GroupCall_ifr"].document.getElementById("txtGIIS").value = gssi;
                    }

                }
                else if (eventtype == "11") {
                }
                else if (eventtype == "22") {
                    document.frames["GroupCall_ifr"].document.getElementById("divstatue").innerHTML = GetTextByName("CC_END", useprameters.languagedata);//多语言：呼叫结束
                }
            }
        }
    }

    //操作窗口里面的慎密监听抢占后 首台结束通话 修改神秘监听的相关按钮状态和消息内容
    if (document.frames["DLCall_ifr"] != null || document.frames["DLCall_ifr"] != undefined) {
        if (eventtype == "00" || eventtype == "01") {
            if (document.frames["DLCall_ifr"].document.getElementById("txtISSIText").value.trim() == issi || useprameters.hostISSI == issi) {
                if (msg == GetTextByName("CC_RELEASE", useprameters.languagedata)) {//多语言：对方挂断
                    if (isPanalDLCall) {
                        document.frames["DLCall_ifr"].document.getElementById("btnJSJT").style.display = "block";
                    } else {
                        document.frames["DLCall_ifr"].document.getElementById("btnJSJT").style.display = "none";
                    }
                    document.frames["DLCall_ifr"].document.getElementById("btnEndCall").style.display = "none";
                    document.frames["DLCall_ifr"].document.getElementById("btnPTT").style.display = "none";
                    document.frames["DLCall_ifr"].document.getElementById("trQCQC").style.display = "none";
                    document.frames["DLCall_ifr"].document.getElementById("trPJ").style.display = "none";
                    document.frames["DLCall_ifr"].document.getElementById("trBegJT").style.display = "block";
                    callPanalISSI = ""; //结束后需要情况呼叫状态
                    document.frames["DLCall_ifr"].document.getElementById("divstatue").innerHTML = GetTextByName("Lang_be_monitored_number", useprameters.languagedata) + ":" + document.frames["DLCall_ifr"].document.getElementById("txtISSIText").value.trim() + "<br>" + issi + GetTextByName("hangsup", useprameters.languagedata) + "<br>" + GetTextByName("InMonitoringStatus", useprameters.languagedata);//多语言：被监听的号码；挂断；处于监听状态
                }
            }
        }
        if (eventtype == "00") {
            if (useprameters.hostISSI == issi) {
                if (msg == GetTextByName("CC_GRANTED", useprameters.languagedata)) {//多语言：获取授权
                    document.frames["DLCall_ifr"].document.getElementById("divstatue").innerHTML = GetTextByName("Lang_be_monitored_number", useprameters.languagedata) + ":" + document.frames["DLCall_ifr"].document.getElementById("txtISSIText").value.trim() + "<br>" + issi + GetTextByName("CC_GRANTED", useprameters.languagedata) + "<br>" + GetTextByName("HALF_DUPLEX", useprameters.languagedata);//多语言：被监听的号码；获取授权；半双工

                }
                else if (msg == GetTextByName("CC_CEASED", useprameters.languagedata)) {//多语言：发射权已释放
                    document.frames["DLCall_ifr"].document.getElementById("divstatue").innerHTML = GetTextByName("Lang_be_monitored_number", useprameters.languagedata) + ":" + document.frames["DLCall_ifr"].document.getElementById("txtISSIText").value.trim() + "<br>" + issi + GetTextByName("CC_CEASED", useprameters.languagedata) + "<br>" + GetTextByName("HALF_DUPLEX", useprameters.languagedata);//多语言：被监听的号码；发射权已释放；半双工

                }
            }
        }

    }


    if (eventtype == "00") {
        if (msg == GetTextByName("CC_CONNECTACK", useprameters.languagedata) || msg == GetTextByName("CC_CONNECT", useprameters.languagedata)) {//多语言：呼叫已连接；对方已接听
            sceasedPTT2(issi);
        }
    }
    if (hookmethodsel == 0) {

    }
    else if (hookmethodsel == 1) {

    }
    else if (hookmethodsel == 2) {

    }
    //当操作窗口中的issi号跟上行的issi号码相同时。操作窗口优先级高于呼叫栏。
    //操作窗口里面的个呼消息 
    //处理操作窗口是否发起呼叫 当存在已经发起的呼叫 首台返回的消息则执行"条件1",对于已经发起的呼叫 调度台 或未发起的呼叫 执行“条件2”。

    if (issi == callPanalISSI) {//条件1：处理首台呼叫信息，此时 不可能是调度台issi 
        //慎密监听中的呼叫 点击强插后callPanalISSI值已经修改，因此无须判断callPanalISSI值是否等于操作窗口中的值
        //此处只要处理首台信息（主要是半双工的获取授权与释放授权） 调度台信息由其他地方处理 “标识101”与“标识102”处处理
        if (document.frames["DLCall_ifr"] != null && document.frames["DLCall_ifr"] != undefined) {
            if (eventtype == "00") {//表示单呼半双工
                if (document.frames["DLCall_ifr"].document.getElementById("txtISSIText").value.trim() == issi) {
                    if (msg == GetTextByName("CC_GRANTED", useprameters.languagedata)) {//多语言：获取授权
                        document.frames["DLCall_ifr"].document.getElementById("divstatue").innerHTML = GetTextByName("Lang_be_monitored_number", useprameters.languagedata) + ":" + document.frames["DLCall_ifr"].document.getElementById("txtISSIText").value.trim() + "<br>" + issi + GetTextByName("CC_GRANTED", useprameters.languagedata) + "<br>" + GetTextByName("HALF_DUPLEX", useprameters.languagedata);//多语言：被监听的号码；获取授权；半双工

                    }
                    else if (msg == GetTextByName("CC_CEASED", useprameters.languagedata)) {//多语言：发射权已释放
                        document.frames["DLCall_ifr"].document.getElementById("divstatue").innerHTML = GetTextByName("Lang_be_monitored_number", useprameters.languagedata) + ":" + document.frames["DLCall_ifr"].document.getElementById("txtISSIText").value.trim() + "<br>" + issi + GetTextByName("CC_CEASED", useprameters.languagedata) + "<br>" + GetTextByName("HALF_DUPLEX", useprameters.languagedata);//多语言：被监听的号码；发射权已释放；半双工

                    }
                }
                //getIssiNameLoLa(issi, eventtype, msg, gssi, hookmethodsel);
            }
        }
        //操作窗口中的单呼 
        if (document.frames["PrivateCall_ifr"] != null || document.frames["PrivateCall_ifr"] != undefined) {//个呼的话 组呼可以不需要了         
            if (document.frames["PrivateCall_ifr"].document.getElementById("txtISSIText") != null && issi == document.frames["PrivateCall_ifr"].document.getElementById("txtISSIText").value.trim()) {
                var calltype = document.frames["PrivateCall_ifr"].document.getElementById('calltype');
                var str;

                if (hookmethodsel == 0) {
                    str = GetTextByName("Automaticansweringmode", useprameters.languagedata);//多语言：自动应答模式
                }
                else if (hookmethodsel == 1) {
                    str = GetTextByName("NoAutomaticansweringmode", useprameters.languagedata);//多语言：非自动应答模式
                }
                else if (hookmethodsel == 2) {
                    str = GetTextByName("DL_REJECTED_FOR_ANY_REASON", useprameters.languagedata);//多语言：无
                }

                if (eventtype == "00") {//表示单呼半双工

                    //writeLog("system", msg);
                    document.frames["PrivateCall_ifr"].document.getElementById("divstatue").innerHTML = GetTextByName("Number", useprameters.languagedata) + ":" + issi + "<br>" + GetTextByName("Type", useprameters.languagedata) + ":" + GetTextByName("NormalHalfSingleCall", useprameters.languagedata) + "<br>" + GetTextByName("Message", useprameters.languagedata) + ":" + msg + "<br>" + GetTextByName("answeringmode", useprameters.languagedata) + ":" + str;//多语言：号码；类型；普通半双工单呼；消息；应答模式
                    if (msg == GetTextByName("CC_RELEASE", useprameters.languagedata)) {//多语言：对方挂断
                        document.frames["PrivateCall_ifr"].document.getElementById('endcall').style.display = "none";

                        callPanalISSI = "";
                        calltype[0].disabled = false;
                        calltype[1].disabled = false;
                        calltype[2].disabled = false;
                        document.frames["PrivateCall_ifr"].document.getElementById("txtISSIText").disabled = false;
                        document.frames["PrivateCall_ifr"].document.getElementById("imgSelectISSI").style.display = "block";
                        iszd = true;
                        endSC2(issi);
                    }
                    else if (msg == GetTextByName("CC_CONNECT", useprameters.languagedata) || msg == GetTextByName("CC_CONNECTACK", useprameters.languagedata)) {//多语言：对方已接听；呼叫已连接
                        document.frames["PrivateCall_ifr"].flag = true;
                        calltype.selectedIndex = 2;
                        calltype[0].disabled = true;
                        calltype[1].disabled = true;
                        calltype[2].disabled = false;
                        document.frames["PrivateCall_ifr"].document.getElementById('begincall').innerHTML = "PTT";
                        document.frames["PrivateCall_ifr"].document.getElementById('begincall').style.display = "block";
                        document.frames["PrivateCall_ifr"].document.getElementById('endcall').style.display = "block";
                    }
                }
                else if (eventtype == "01") {//表示单呼全双工
                    document.frames["PrivateCall_ifr"].document.getElementById("divstatue").innerHTML = GetTextByName("Number", useprameters.languagedata) + ":" + issi + "<br>" + GetTextByName("Type", useprameters.languagedata) + ":" + GetTextByName("NormalAllSingleCall", useprameters.languagedata) + "<br>" + GetTextByName("Message", useprameters.languagedata) + ":" + msg + "<br>" + GetTextByName("answeringmode", useprameters.languagedata) + ":" + str;//多语言：号码；类型；单呼全双工；消息；应答模式
                    if (msg == GetTextByName("CC_RELEASE", useprameters.languagedata)) {//多语言：对方挂断
                        document.frames["PrivateCall_ifr"].document.getElementById('endcall').style.display = "none";
                        document.frames["PrivateCall_ifr"].document.getElementById('begincall').style.display = "block";
                        document.frames["PrivateCall_ifr"].document.getElementById('begincall').innerHTML = GetTextByName("Called", useprameters.languagedata);//多语言：呼叫
                        callPanalISSI = "";
                        calltype[0].disabled = false;
                        calltype[1].disabled = false;
                        calltype[2].disabled = false;
                        document.frames["PrivateCall_ifr"].document.getElementById("txtISSIText").disabled = false;
                        document.frames["PrivateCall_ifr"].document.getElementById("imgSelectISSI").style.display = "block";
                        iszd = true;
                        endDC2(issi);
                    }
                    else if (msg == GetTextByName("CC_CONNECT", useprameters.languagedata) || msg == GetTextByName("CC_CONNECTACK", useprameters.languagedata)) {//多语言：对方已接听；呼叫已连接
                        document.frames["PrivateCall_ifr"].flag = true;
                        calltype.selectedIndex = 1;
                        calltype[0].disabled = true;
                        calltype[1].disabled = false;
                        calltype[2].disabled = true;
                        document.frames["PrivateCall_ifr"].document.getElementById('begincall').innerHTML = GetTextByName("Called", useprameters.languagedata);//多语言：呼叫
                        document.frames["PrivateCall_ifr"].document.getElementById('begincall').style.display = "none";
                        document.frames["PrivateCall_ifr"].document.getElementById('endcall').style.display = "block";
                    }
                }
                else if (eventtype == "22") {
                    if (iszd) {
                        iszd = false;
                        callPanalISSI = "";
                        calltype[0].disabled = false;
                        calltype[1].disabled = false;
                        calltype[2].disabled = false;
                        return;
                    }
                    callPanalISSI = "";
                    calltype[0].disabled = false;
                    calltype[1].disabled = false;
                    calltype[2].disabled = false;
                    document.frames["PrivateCall_ifr"].document.getElementById("divstatue").innerHTML = GetTextByName("CC_END", useprameters.languagedata);//多语言：呼叫结束
                    document.frames["PrivateCall_ifr"].document.getElementById("txtISSIText").disabled = false;
                    document.frames["PrivateCall_ifr"].document.getElementById("imgSelectISSI").style.display = "block";
                    iszd = false;
                }
            }
            //getIssiNameLoLa(issi, eventtype, msg, gssi, hookmethodsel);
        }

        return; //返回1：  不去处理呼叫栏中的消息了 不然要发生消息冲突
    }
    else {//条件2： 当操作窗口没发起呼叫，操作窗口打开着，是单呼上行 当上行的issi号码与操作窗口的issi号码相同 则可以接（执行“条件12”）
        if (document.frames["PrivateCall_ifr"] != null || document.frames["PrivateCall_ifr"] != undefined) {
            var str;

            if (hookmethodsel == 0) {
                str = GetTextByName("Automaticansweringmode", useprameters.languagedata);//多语言：自动应答模式
            }
            else if (hookmethodsel == 1) {
                str = GetTextByName("NoAutomaticansweringmode", useprameters.languagedata);//多语言：非自动应答模式
            }
            else if (hookmethodsel == 2) {
                str = GetTextByName("DL_REJECTED_FOR_ANY_REASON", useprameters.languagedata);//多语言：无
            }

            if (document.frames["PrivateCall_ifr"].document.getElementById("txtISSIText") != null) {
                //条件11： 处理操作窗口中调度台消息（主要是半双工）  当issi为调度台issi时调用，主要是半双工的获取授权跟释放授权消息需要处理
                //是调度台的时候还是要执行 获取授权，释放授权，
                if (issi != document.frames["PrivateCall_ifr"].document.getElementById("txtISSIText").value.trim() && useprameters.hostISSI == issi) {
                    //避免呼叫栏影响，只有当操作窗口中对应才行
                    if (callPanalISSI != "" && document.frames["PrivateCall_ifr"].document.getElementById("txtISSIText").value.trim() == callPanalISSI) {
                        if (eventtype == "00") {//半双工 

                            document.frames["PrivateCall_ifr"].document.getElementById("divstatue").innerHTML = GetTextByName("Number", useprameters.languagedata) + ":" + issi + "<br>" + GetTextByName("Type", useprameters.languagedata) + ":" + GetTextByName("NormalHalfSingleCall", useprameters.languagedata) + "<br>" + GetTextByName("Message", useprameters.languagedata) + ":" + msg + "<br>" + GetTextByName("answeringmode", useprameters.languagedata) + ":" + str;//多语言：号码;类型;普通半双工单呼;消息;应答模式
                        }
                        if (eventtype == "01") {//全双工

                            document.frames["PrivateCall_ifr"].document.getElementById("divstatue").innerHTML = GetTextByName("Number", useprameters.languagedata) + ":" + issi + "<br>" + GetTextByName("Type", useprameters.languagedata) + ":" + GetTextByName("NormalAllSingleCall", useprameters.languagedata) + "<br>" + GetTextByName("Message", useprameters.languagedata) + ":" + msg + "<br>" + GetTextByName("answeringmode", useprameters.languagedata) + ":" + str;//多语言：号码；类型；单呼全双工；消息；应答模式
                        }
                        //getIssiNameLoLa(issi, eventtype, msg, gssi, hookmethodsel);
                        return; //处理完调度台消息 也可以直接返回 
                    }
                }
                //条件12：处理上行的首台issi号码为操作窗口开打的issi时，当上行的issi等于打开着的操作窗口的issi时操作窗口处于接听状态
                if (issi == document.frames["PrivateCall_ifr"].document.getElementById("txtISSIText").value.trim()) {
                    var calltype = document.frames["PrivateCall_ifr"].document.getElementById('calltype');

                    if (msg == GetTextByName("CC_CONNECTACK", useprameters.languagedata)) {//多语言：呼叫已连接
                        callPanalISSI = issi;
                        document.frames["PrivateCall_ifr"].flag = true; //半双工 自动接的时候 会返回3次消息，第一次有呼叫请求进入 第二次呼叫已连接，第三次返回调度台消息（自动的）
                        if (eventtype == "00") {
                            document.frames["PrivateCall_ifr"].document.getElementById('begincall').innerHTML = "PTT";
                            document.frames["PrivateCall_ifr"].document.getElementById('begincall').style.display = "block";
                            document.frames["PrivateCall_ifr"].document.getElementById('endcall').style.display = "block";
                        } else if (eventtype == "01") {
                            document.frames["PrivateCall_ifr"].document.getElementById('begincall').innerHTML = GetTextByName("Called", useprameters.languagedata);//多语言：呼叫
                            document.frames["PrivateCall_ifr"].document.getElementById('begincall').style.display = "none";
                            document.frames["PrivateCall_ifr"].document.getElementById('endcall').style.display = "block";

                        }
                    }
                    else if (msg == GetTextByName("CC_CALLREQUEST", useprameters.languagedata)) {//多语言：有呼叫请求进入
                        document.frames["PrivateCall_ifr"].tochanage();
                        if (eventtype == "00") {//表示单呼半双工  呼叫类型自动选择半双工，显示半双工PTT按钮，
                            document.frames["PrivateCall_ifr"].document.getElementById("divstatue").innerHTML = GetTextByName("Number", useprameters.languagedata) + ":" + issi + "<br>" + GetTextByName("Type", useprameters.languagedata) + ":" + GetTextByName("NormalHalfSingleCall", useprameters.languagedata) + "<br>" + GetTextByName("Message", useprameters.languagedata) + ":" + msg + "<br>" + GetTextByName("answeringmode", useprameters.languagedata) + ":" + str;//多语言：号码;类型;普通半双工单呼;消息;应答模式
                            calltype.selectedIndex = 2;
                            calltype[0].disabled = true;
                            calltype[1].disabled = true;
                            calltype[2].disabled = false;
                            document.frames["PrivateCall_ifr"].document.getElementById('begincall').innerHTML = "PTT";
                            document.frames["PrivateCall_ifr"].document.getElementById('begincall').style.display = "block";
                            document.frames["PrivateCall_ifr"].document.getElementById('endcall').style.display = "block";
                        }
                        else if (eventtype == "01") {//表示单呼全双工 呼叫类型自动选择全双工，显示全双工开始按钮
                            document.frames["PrivateCall_ifr"].document.getElementById("divstatue").innerHTML = GetTextByName("Number", useprameters.languagedata) + ":" + issi + "<br>" + GetTextByName("Type", useprameters.languagedata) + ":" + GetTextByName("NormalAllSingleCall", useprameters.languagedata) + "<br>" + GetTextByName("Message", useprameters.languagedata) + ":" + msg + "<br>" + GetTextByName("answeringmode", useprameters.languagedata) + ":" + str;//多语言：号码;类型;单呼全双工;消息;应答模式
                            calltype.selectedIndex = 1;
                            calltype[0].disabled = true;
                            calltype[1].disabled = false;
                            calltype[2].disabled = true;
                            document.frames["PrivateCall_ifr"].document.getElementById('begincall').innerHTML = GetTextByName("Toanswer", useprameters.languagedata);//多语言：接听
                            document.frames["PrivateCall_ifr"].document.getElementById('begincall').style.display = "block";
                            document.frames["PrivateCall_ifr"].document.getElementById('endcall').style.display = "block";
                        }
                        document.frames["PrivateCall_ifr"].document.getElementById('begincall').className = "CALLBUTTON1";
                        document.frames["PrivateCall_ifr"].document.getElementById('endcall').className = "CALLBUTTON1";
                        document.frames["PrivateCall_ifr"].document.getElementById("txtISSIText").disabled = true;
                        document.frames["PrivateCall_ifr"].document.getElementById("imgSelectISSI").style.display = "none";
                    }
                    else if (msg == GetTextByName("CC_RELEASE", useprameters.languagedata)) {//多语言：对方挂断
                        callPanalISSI = "";
                        calltype[0].disabled = false;
                        calltype[1].disabled = false;
                        calltype[2].disabled = false;
                        if (eventtype == "00") {//表示单呼半双工
                            document.frames["PrivateCall_ifr"].document.getElementById('endcall').style.display = "none";
                            document.frames["PrivateCall_ifr"].document.getElementById("divstatue").innerHTML = GetTextByName("Number", useprameters.languagedata) + ":" + issi + "<br>" + GetTextByName("Type", useprameters.languagedata) + ":" + GetTextByName("NormalHalfSingleCall", useprameters.languagedata) + "<br>" + GetTextByName("Message", useprameters.languagedata) + ":" + msg + "<br>" + GetTextByName("answeringmode", useprameters.languagedata) + ":" + str;//多语言：号码;类型;普通半双工单呼;消息;应答模式
                        }
                        if (eventtype == "01") {

                            document.frames["PrivateCall_ifr"].document.getElementById("divstatue").innerHTML = GetTextByName("Number", useprameters.languagedata) + ":" + issi + "<br>" + GetTextByName("Type", useprameters.languagedata) + ":" + GetTextByName("NormalAllSingleCall", useprameters.languagedata) + "<br>" + GetTextByName("Message", useprameters.languagedata) + ":" + msg + "<br>" + GetTextByName("answeringmode", useprameters.languagedata) + ":" + str;//多语言：号码;类型;单呼全双工;消息;应答模式

                            document.frames["PrivateCall_ifr"].document.getElementById('endcall').style.display = "none";
                            document.frames["PrivateCall_ifr"].document.getElementById('begincall').style.display = "block";
                            document.frames["PrivateCall_ifr"].document.getElementById('begincall').innerHTML = GetTextByName("Called", useprameters.languagedata);
                        }
                        document.frames["PrivateCall_ifr"].document.getElementById("txtISSIText").disabled = false;
                        document.frames["PrivateCall_ifr"].document.getElementById("imgSelectISSI").style.display = "block";
                    }
                    if (eventtype == "22") {
                        callPanalISSI = "";
                        calltype[0].disabled = false;
                        calltype[1].disabled = false;
                        calltype[2].disabled = false;
                        document.frames["PrivateCall_ifr"].document.getElementById("divstatue").innerHTML = GetTextByName("CC_END", useprameters.languagedata);//多语言：呼叫结束
                        document.frames["PrivateCall_ifr"].document.getElementById("txtISSIText").disabled = false;
                        document.frames["PrivateCall_ifr"].document.getElementById("imgSelectISSI").style.display = "block";
                    }
                    //getIssiNameLoLa(issi, eventtype, msg, gssi, hookmethodsel);
                    return;
                }
            }
        }
    }


    if (eventtype == "00") {//半双工

        if (msg == GetTextByName("CC_CALLPROCEEDING", useprameters.languagedata)) {//多语言：呼叫正在处理中 /**单呼半双工下行**/
        }
        else if (msg == GetTextByName("CC_ALERT", useprameters.languagedata)) {//多语言：对方在振铃中 /**单呼半双工下行**/

        }
        else if (msg == GetTextByName("CC_CONNECT", useprameters.languagedata)) {//多语言：对方已接听 /**单呼半双工下行  hookmethodsel 应答模式 0：自动应答模式，1：非自动应答模式，2：无**/
            var ifrs = document.frames["ifr_callcontent"];
            if (ifrs) {
                ifrs.calltype = 1;
                ifrs.document.getElementById("singal1").innerHTML = GetTextByName("PTTMode", useprameters.languagedata);//多语言：对讲模式
            }

            switch (hookmethodsel) {
                case "0":
                    changebackimg("callgif", "Phone_30.gif", eventtype, hookmethodsel);                /**自动应答时更改电话图标，改成可以呼叫**/

                    break;
                case "1":

                    changebackimg("callgif", "call.gif", eventtype, hookmethodsel);
                    break;
                default:
                    break;
            }
        }
        else if (msg == GetTextByName("CC_RELEASE", useprameters.languagedata)) {//多语言：对方挂断  /**单呼半双工(全双工)下行**/
            if (issi == useprameters.SelectISSI[0]) {
                //delgrouparry(issi);                                                  /**上行全双工单呼挂断**/
                changebackimg("call2", GetTextByName("maincall_btn_img_src_siglecall", useprameters.languagedata), eventtype);//siglecall
            }
        }
        else if (msg == GetTextByName("CC_CALLREQUEST", useprameters.languagedata)) {//多语言：有呼叫请求进入 /**上行全双工单呼**/
            if (useprameters.SelectISSI[0] == issi && useprameters.SelectISSI.length == 1)
                UPcallChgIMG(issi, hookmethodsel);
        }
        else if (msg == GetTextByName("CC_CONNECTACK", useprameters.languagedata)) {//多语言：呼叫已连接  /**上行半双工单呼**/
            if (useprameters.SelectISSI[0] == issi && useprameters.SelectISSI.length == 1)
                UPcallChgIMG(issi, hookmethodsel);
        }
        else if (msg == GetTextByName("CC_GRANTED", useprameters.languagedata)) {//多语言：获取授权
            if (issi == useprameters.hostISSI) {
                changebackimg("callgif", "Phone_30.gif", eventtype);                            /**本调度台ISSI获得授权,更改可呼叫图标**/
            }
            else {
                changebackimg("callgif", "call.gif", eventtype);                               /**终端获得授权,更改不可呼叫图标**/
            }
            //标识101 操作窗口 慎密监听 强插 主要处理调度台获取授权与释放授权消息
            if (document.frames["DLCall_ifr"] != null && document.frames["DLCall_ifr"] != undefined) {
                if (document.frames["DLCall_ifr"].document.getElementById("txtISSIText").value.trim() == issi) {
                    document.frames["DLCall_ifr"].document.getElementById("divstatue").innerHTML = GetTextByName("Lang_be_monitored_number", useprameters.languagedata) + ":" + document.frames["DLCall_ifr"].document.getElementById("txtISSIText").value.trim() + "<br>" + issi + GetTextByName("CC_GRANTED", useprameters.languagedata) + "<br>" + GetTextByName("HALF_DUPLEX", useprameters.languagedata);//多语言：被监听的号码；获取授权；半双工
                }
            }
        }
        else if (msg == GetTextByName("CC_CEASED", useprameters.languagedata)) {//多语言：发射权已释放
            if (document.frames["DLCall_ifr"] != null && document.frames["DLCall_ifr"] != undefined) {
                if (document.frames["DLCall_ifr"].document.getElementById("txtISSIText").value.trim() == issi) {
                    document.frames["DLCall_ifr"].document.getElementById("divstatue").innerHTML = GetTextByName("Lang_be_monitored_number", useprameters.languagedata) + ":" + document.frames["DLCall_ifr"].document.getElementById("txtISSIText").value.trim() + "<br>" + issi + GetTextByName("CC_CEASED", useprameters.languagedata) + "<br>" + GetTextByName("HALF_DUPLEX", useprameters.languagedata);//多语言：被监听的号码；发射权已释放；半双工
                }
            }
        }

    }
    else if (eventtype == "01") {//全双工

        if (msg == GetTextByName("CC_CALLPROCEEDING", useprameters.languagedata), eventtype) {//多语言：呼叫正在处理中
        }
        else if (msg == GetTextByName("CC_CALLREQUEST", useprameters.languagedata), eventtype) {//多语言：有呼叫请求进入 /**上行全双工单呼**/

            if (useprameters.SelectISSI[0] == issi && useprameters.SelectISSI.length == 1)
                UPcallChgIMG(issi, hookmethodsel);

        }
        else if (msg == GetTextByName("CC_CONNECTACK", useprameters.languagedata)) {//多语言：呼叫已连接  /**单呼全双工上行接通**/
            changebackimg("callgif", "Phone_30.gif", eventtype);                            /**本调度台ISSI获得授权,更改可呼叫图标**/
        }
        else if (msg == GetTextByName("CC_CONNECT", useprameters.languagedata)) {//多语言：对方已接听  /**单呼全双工上行接通**/
            changebackimg("callgif", "Phone_30.gif", eventtype);                            /**本调度台ISSI获得授权,更改可呼叫图标**/
        }
        else if (msg == GetTextByName("CC_RELEASE", useprameters.languagedata)) {//多语言：对方挂断
            if (issi == useprameters.SelectISSI[0]) {
                //delgrouparry(issi);
                changebackimg("call2", GetTextByName("maincall_btn_img_src_siglecall", useprameters.languagedata), eventtype);//siglecall
            }
        }
        else if (msg == GetTextByName("CC_ALERT", useprameters.languagedata)) {//多语言：对方在振铃中
        }

    }
    else if (eventtype == "10") {

        if (msg == GetTextByName("CC_CONNECT", useprameters.languagedata)) {//多语言：对方已接听

        }
        else if (msg == GetTextByName("CC_GRANTED", useprameters.languagedata)) {//多语言：获取授权

            if (useprameters.SelectGSSI) {
                //changebackimg("mygroupcall", "../images/finishcall.png");
            }
            if (useprameters.bzGSSI) {
                //    changebackimg("bzgroup", "../images/finishcall.png");
            }
            if (issi == useprameters.hostISSI) {                                 /**本调度台ISSI获得授权,更改可呼叫图标**/
                changebackimg("callgif", "Phone_30.gif", eventtype)
            }
            else {
                changebackimg("callgif", "call.gif", eventtype)                              /**终端获得授权,更改不可呼叫图标**/
            }
            if (msg == GetTextByName("CC_CONNECT", useprameters.languagedata))// 多语言：对方已接听  代码有问题啊。
                changebackimg("callgif", "Phone_30.gif", eventtype);
        }
        else if (msg == GetTextByName("CC_CALLREQUEST", useprameters.languagedata)) {//多语言：有呼叫请求进入 /**上行组呼**/

        }
        else if (msg == GetTextByName("CC_RELEASE", useprameters.languagedata)) {//多语言：对方挂断 /**上行组呼不处理**/

        }
        else if (msg == GetTextByName("CC_CONNECT", useprameters.languagedata)) {//多语言：对方已接听
            changebackimg("callgif", "Phone_30.gif", eventtype);
        }

    }
    else if (eventtype == "11") {                                                  /**可能不触发**/
    }
    else if (eventtype == "22") {
        delgrouparry(useprameters.SelectISSI[0]);                                    /**移除选中存在上行呼叫的ISSI**/
        var ifrs = document.frames["ifr_callcontent"];
        if (ifrs) {
            ifrs.restbackimg();
        }
        changezhebg("call4", "-61px 0");                                            /**PTT松起状态**/
        //        useprameters.SelectGSSI = "";                                               /**选中GSSI**/
        //        useprameters.SelectISSI = [];
        //        useprameters.Selectid = []; 
        //  LayerControl.LoadDataToLayerControl(); openscales
    }

}
//MSG: 短信消息
function SMSMsg(issi, smstype, msg, id, strisconsume) {
    //过滤逗号

    msg = msg.replace(new RegExp("eastcomseparativesign", "g"), ",");

    var todbMSG = msg;

    if (smstype == "01" || smstype == "31") { //首台发送消息为空时
        var MYName = "";
        var Lo = "";
        var La = "";
        var PCId = "";
        var param = { "ISSI": issi, "gssi": "212121", "hostISSI": useprameters.hostISSI };
        jquerygetNewData_ajax("WebGis/Service/getISSSname.aspx", param, function (request) {          //获取ISSI对应的警员名称
            var _data = request;
            var mytypes = "";
            MYName = request.PCname;
            Lo = request.lo;
            La = request.la;
            PCId = request.PCid;

            //将switch改为if语句
            if (MYName == GetTextByName("Dispatch", useprameters.languagedata)) {//多语言：调度台
                var param1 = { "ISSI": issi };
                jquerygetNewData_ajax("Handlers/GetDispatchNameByISSI.ashx", param1, function (request1) {
                    MYName = request1.PCName;
                    var strMsg = "";
                    if (smstype == "31") {
                        strMsg += "[" + GetTextByName("Receive(state)", useprameters.languagedata) + "]";//多语言：接收(状态)
                        mytypes = myLang_please_input_shortMessage;
                    } else {
                        strMsg += "[" + GetTextByName("Receive(SMS)", useprameters.languagedata) + "]";//多语言：接收(短信)
                        mytypes = SMSMy;
                    }
                    strMsg += "<span oncontextmenu=javascript:rightselecttype='dispatch';rightISSI='" + issi + "' onclick=window.parent.parent.mycallfunction('Send_SMS','380',400,'&cmd=ISSI&issi=" + issi + "&name=" + encodeURI(MYName) + "')>" + MYName + "(" + issi + ")</span>：[" + LOGTimeGet() + "]";
                    RevSMS(MYName, issi, "", mytypes);
                    writeLog("sms", strMsg);
                    document.getElementById("scrollarea").innerHTML = MYName + "(" + issi + "):";

                });
            }
            else if (MYName == GetTextByName("UnkownUser", useprameters.languagedata)) {//多语言：未知用户
                //var mapcoord = _StaticObj.objGet("map").getPixelInMap({ lo: Lo, la: La });
                //lq_outInfo(mapcoord.x, mapcoord.y, "Police,0,0|" + PCId, MYName + "发来消息"); //收到短消息后，在警员头部显示
                var strMsg = "";
                if (smstype == "31") {
                    strMsg += "[" + GetTextByName("Receive(state)", useprameters.languagedata) + "]";//多语言：接收(状态)
                    mytypes = myLang_please_input_shortMessage;
                } else {
                    strMsg += "[" + GetTextByName("Receive(SMS)", useprameters.languagedata) + "]";//多语言：接收(短信)
                    mytypes = SMSMy;
                }
                strMsg += "<span onclick=window.parent.parent.mycallfunction('Send_SMS','380',400,'&cmd=ISSI&issi=" + issi + "&name=" + encodeURI(MYName) + "') >" + MYName + "(" + issi + ")</span>:";
                if (smstype == "31") {
                    strMsg += " &nbsp;<span onclick=window.parent.parent.DingWei('" + Lo + "','" + La + "','weizhi')>(" + Lo + ",&nbsp;" + La + ")</span>";
                }
                strMsg += "[" + LOGTimeGet() + "]";
                RevSMS(MYName, issi, "", mytypes);
                writeLog("sms", strMsg);

                document.getElementById("scrollarea").innerHTML = "<span>" + MYName + "(" + issi + ")</span>:";

            }
            else {
                //var mapcoord = _StaticObj.objGet("map").getPixelInMap({ lo: Lo, la: La });
                //lq_outInfo(mapcoord.x, mapcoord.y, "Police,0,0|" + PCId, MYName + "发来消息"); //收到短消息后，在警员头部显示
                var strMsg = "";
                if (smstype == "31") {
                    strMsg += "[" + GetTextByName("Receive(state)", useprameters.languagedata) + "]";//多语言：接收(状态)
                    mytypes = myLang_please_input_shortMessage;
                } else {
                    strMsg += "[" + GetTextByName("Receive(SMS)", useprameters.languagedata) + "]";//多语言：接收(短信)
                    mytypes = SMSMy;
                }
                strMsg += "<span  oncontextmenu=javascript:rightselecttype='cell';window.parent.parent.useprameters.rightselectid=" + PCId + " onclick=window.parent.parent.mycallfunction('Send_SMS','380',400,'&cmd=ISSI&issi=" + issi + "&name=" + encodeURI(MYName) + "') >" + MYName + "(" + issi + ")</span>:";
                if (smstype == "31") {
                    strMsg += " &nbsp;<span onclick=window.parent.parent.DingWei('" + Lo + "','" + La + "','weizhi')>(" + GetTextByName("Lang-Longitude", useprameters.languagedata) + ":" + Lo + ",&nbsp;&nbsp;" + GetTextByName("Lang-Latitude", useprameters.languagedata) + ":" + La + ")</span>";//多语言：经度，纬度
                }
                strMsg += "[" + LOGTimeGet() + "]";
                writeLog("sms", strMsg);
                RevSMS(MYName, issi, "", mytypes);

                document.getElementById("scrollarea").innerHTML = "<span style='cursor:hand;text-decoration:underline;' onclick=window.parent.parent.ToLoctionByISSI('" + issi + "') >" + MYName + "(" + issi + ")</span>:";

            }

        }, false, false);

    }
    else if (smstype == "1") {//表示收到的普通消息回执；有回执的 只发给用户 不发给组
        if (msg == constMsgHaveRead) {//短信已读
            todbMSG = GetTextByName(msg, useprameters.languagedata);
            var MYName = "";
            var Lo = "";
            var La = "";
            var PCId = "";
            var param = { "ISSI": issi, "gssi": "212121", "hostISSI": useprameters.hostISSI };
            jquerygetNewData_ajax("WebGis/Service/getISSSname.aspx", param, function (request) {
                var _data = request;
                MYName = request.PCname;
                Lo = request.lo;
                La = request.la;
                PCId = request.PCid;
                if (MYName == GetTextByName("Dispatch", useprameters.languagedata)) {//多语言 调度台
                    var param1 = { "ISSI": issi };
                    jquerygetNewData_ajax("Handlers/GetDispatchNameByISSI.ashx", param1, function (request1) {
                        MYName = request1.PCName;
                        var myMsg = "[" + GetTextByName("Receive(Receipt)", useprameters.languagedata) + "]<span onclick=window.parent.parent.mycallfunction('Send_SMS','380',400,'&cmd=ISSI&issi=" + issi + "&name=" + encodeURI(MYName) + "') oncontextmenu=javascript:rightselecttype='dispatch';rightISSI='" + issi + "'>" + MYName + "</span>(" + issi + "):" + GetTextByName(msg, useprameters.languagedata) + "[" + LOGTimeGet() + "]";//多语言：接收(回执)；回执
                        RevSMS(MYName, issi, GetTextByName(msg, useprameters.languagedata), myReceipt);
                        writeLog("sms", myMsg);
                        document.getElementById("scrollarea").innerHTML = MYName + "(" + issi + "):" + GetTextByName(msg, useprameters.languagedata) + " &nbsp;<span style='cursor:hand;text-decoration:underline;' onclick=window.parent.parent.mycallfunction('Send_SMS','380',400,'&cmd=ISSI&issi=" + issi + "&name=" + encodeURI(MYName) + "')>" + GetTextByName("Reply", useprameters.languagedata) + "</span>";//多语言：回执；回复

                    })
                }
                else {
                    //var mapcoord = _StaticObj.objGet("map").getPixelInMap({ lo: Lo, la: La });
                    //lq_outInfo(mapcoord.x, mapcoord.y, "Police,0,0|" + PCId, MYName + "：" + GetTextByName(GetTextByName(msg, useprameters.languagedata), useprameters.languagedata));
                    var myMsg = "";
                    if (MYName == GetTextByName("UnkownUser", useprameters.languagedata)) {//多语言：未知用户
                        myMsg = "[" + GetTextByName("Receive(Receipt)", useprameters.languagedata) + "]<span onclick=window.parent.parent.mycallfunction('Send_SMS','380',400,'&cmd=ISSI&issi=" + issi + "&name=" + encodeURI(MYName) + "') >" + MYName + "(" + issi + ")</span>:<span class='myspan' alt='" + GetTextByName(msg, useprameters.languagedata) + "'>" + GetTextByName(msg, useprameters.languagedata) + "</span>[" + LOGTimeGet() + "]";//多语言：接收(回执)；回执
                    } else {
                        myMsg = "[" + GetTextByName("Receive(Receipt)", useprameters.languagedata) + "]<span oncontextmenu=javascript:rightselecttype='cell';window.parent.parent.useprameters.rightselectid=" + PCId + "  onclick=window.parent.parent.mycallfunction('Send_SMS','380',400,'&cmd=ISSI&issi=" + issi + "&name=" + encodeURI(MYName) + "') >" + MYName + "(" + issi + ")</span>:<span class='myspan' alt='" + GetTextByName(msg, useprameters.languagedata) + "'>" + GetTextByName(msg, useprameters.languagedata) + "</span>[" + LOGTimeGet() + "]";//多语言：接收(回执)；回执
                    }
                    RevSMS(MYName, issi, GetTextByName(msg, useprameters.languagedata), myReceipt);
                    writeLog("sms", myMsg);
                    document.getElementById("scrollarea").innerHTML = "<span style='cursor:hand;text-decoration:underline;' onclick=window.parent.parent.ToLoctionByISSI('" + issi + "') >" + MYName + "(" + issi + ")</span>:" + GetTextByName(msg, useprameters.languagedata) + " &nbsp;<span style='cursor:hand;text-decoration:underline;' onclick=window.parent.parent.mycallfunction('Send_SMS','380',400,'&cmd=ISSI&issi=" + issi + "&name=" + encodeURI(MYName) + "') >" + GetTextByName("Reply", useprameters.languagedata) + "</span>";//澶氳瑷€锛氬洖鎵э紱鍥炲

                }

            }, false, false);
        }
        else {
            if (msg == constMsgSendToGroupUnCheck) {//多语言：发给组不确认
                msg = constMsgSendSucess;//多语言：发送成功
            }
            todbMSG = GetTextByName(msg, useprameters.languagedata);
            //callBackRestlt += msg + ";";
            var MYName = "";
            var Lo = "";
            var La = "";
            var PCId = "";
            var param = { "ISSI": issi, "gssi": "212121", "hostISSI": useprameters.hostISSI };
            jquerygetNewData_ajax("WebGis/Service/getISSSname.aspx", param, function (request) {
                var _data = request;
                MYName = request.PCname;
                Lo = request.lo;
                La = request.la;
                PCId = request.PCid;
                var myMsg = "[" + GetTextByName("Send(SMS)", useprameters.languagedata) + "]" + GetTextByName(msg, useprameters.languagedata) + "(<span  oncontextmenu=javascript:rightselecttype='cell';window.parent.parent.useprameters.rightselectid='" + PCId + "'   onclick=window.parent.parent.mycallfunction('Send_SMS','380',400,'&cmd=ISSI&issi=" + issi + "&name=" + encodeURI(MYName) + "') >" + MYName + "(" + issi + ")</span>)[" + LOGTimeGet() + "]";//多语言：发送(短信)
                writeLog("sms", myMsg);
            });

            var Lang_ThisDispatchSendMsgTo = GetTextByName("Lang_ThisDispatchSendMsgTo", useprameters.languagedata)
            document.getElementById("scrollarea").innerHTML = Lang_ThisDispatchSendMsgTo + "<span style='cursor:hand;text-decoration:underline;' onclick=window.parent.parent.ToLoctionByISSI('" + issi + "') >" + MYName + "</span>";


        }
    }
    else if (smstype == "0" || smstype == "3") { //表示收到的普通消息内容；表示收到的状态消息 不能进行多语言转化
        var MYName = "";
        var Lo = "";
        var La = "";
        var PCId = "";
        var param = { "ISSI": issi, "gssi": "212121", "hostISSI": useprameters.hostISSI };
        /*
             修改人：林强
               日期：2015-3-9
                  */
        //Begin
        if (smstype == "3" && msg == "紧急告警") {
            endPlay();
            doPaly();
            locationbyISSIsms(issi, '');
        }
        //end
        jquerygetNewData_ajax("WebGis/Service/getISSSname.aspx", param, function (request) {
            var _data = request;
            var mytypedyy = "";
            var myptypedy = "";
            MYName = request.PCname;
            Lo = request.lo;
            La = request.la;
            PCId = request.PCid;
            if (MYName == GetTextByName("Dispatch", useprameters.languagedata)) {//多语言：调度台
                var param1 = { "ISSI": issi };
                jquerygetNewData_ajax("Handlers/GetDispatchNameByISSI.ashx", param1, function (request1) {
                    MYName = request1.PCName;
                    var myMsg = "";

                    if (smstype == "3") {
                        myptypedy = myLang_please_input_shortMessage;
                        mytypedyy = GetTextByName("Receive(state)", useprameters.languagedata);//多语言：接收(状态)
                    } else {
                        myptypedy = SMSMy;
                        mytypedyy = GetTextByName("Receive(SMS)", useprameters.languagedata);//多语言：接收(短信)
                    }
                    myMsg += "[" + mytypedyy + "]";
                    myMsg += "<span oncontextmenu=javascript:rightselecttype='dispatch';rightISSI='" + issi + "' onclick=window.parent.parent.mycallfunction('Send_SMS','380',400,'&cmd=ISSI&issi=" + issi + "&name=" + encodeURI(MYName) + "')>" + MYName + "(" + issi + ")</span>:" + msg + "[" + LOGTimeGet() + "]";

                    writeLog("sms", myMsg);
                    /*
                    修改人：qijj
                    日期：2012-5-16
                    */
                    //Begin
                    var tempmsg = msg;
                    if (msg.length > 10) {
                        msg = msg.substring(0, 8) + "……";
                    }
                    //End
                    document.getElementById("scrollarea").innerHTML = MYName + "(" + issi + "):<span title='" + tempmsg + "' style='cursor:hand'>" + msg + "</span> &nbsp;<span style='color:red' onclick=window.parent.parent.mycallfunction('Send_SMS','380',400,'&cmd=ISSI&issi=" + issi + "&name=" + encodeURI(MYName) + "')>" + GetTextByName("Reply", useprameters.languagedata) + "</span>";

                })
            }
            else {
                //var mapcoord = _StaticObj.objGet("map").getPixelInMap({ lo: Lo, la: La });
                //lq_outInfo(mapcoord.x, mapcoord.y, "Police,0,0|" + PCId, MYName + "发来消息");
                var myMsg = "";

                if (smstype == "3") {
                    mytypedyy = GetTextByName("Receive(state)", useprameters.languagedata);//多语言：接收(状态)
                    getNewData_ajax("../../Handlers/GetUserInfo_Handler.ashx", { issi: issi }, function (msgs) {
                        var mydd = eval(msgs);
                        if (msg == GetTextByName("Emergency", useprameters.languagedata)) {
                            if (mydd[0].lo == 0 || mydd[0].la == 0) {
                                alert(GetTextByName("Log_LoLoIsZero", useprameters.languagedata));//多语言：经纬度为(0,0)请检查终端状态
                            } else {
                                issilocation(mydd[0].lo, mydd[0].la, mydd[0].id, issi);
                            }
                        }
                        var mainSWF = document.getElementById("main");
                        if (mainSWF) {
                            mainSWF.changeUserHeaderInfoByStatuesMSG(issi, msg, mydd[0].nam);
                        }
                    });
                } else {
                    myptypedy = SMSMy;
                    mytypedyy = GetTextByName("Receive(SMS)", useprameters.languagedata);;//多语言：接收(短信)
                }
                myMsg += "[" + mytypedyy + "]";
                if (MYName == GetTextByName("UnkownUser", useprameters.languagedata)) {//多语言：未知用户
                    myMsg += "<span onclick=window.parent.parent.mycallfunction('Send_SMS','380',400,'&cmd=ISSI&issi=" + issi + "&name=" + encodeURI(MYName) + "')>" + MYName + "(" + issi + ")</span>:<span class='myspan' alt='" + msg + "'>" + msg + "</span>";
                } else {
                    myMsg += "<span   oncontextmenu=javascript:rightselecttype='cell';window.parent.parent.useprameters.rightselectid=" + PCId + "   onclick=window.parent.parent.mycallfunction('Send_SMS','380',400,'&cmd=ISSI&issi=" + issi + "&name=" + encodeURI(MYName) + "') >" + MYName + "(" + issi + ")</span>:<span class='myspan' alt='" + msg + "'>" + msg + "</span>";
                }
                if (smstype == 3) {
                    myMsg += " &nbsp;<span onclick=window.parent.parent.DingWei('" + Lo + "','" + La + "','weizhi')>(" + GetTextByName("Lang-Longitude", useprameters.languagedata) + ":" + Lo + ",&nbsp;&nbsp;" + GetTextByName("Lang-Latitude", useprameters.languagedata) + ":" + La + ")</span>";//多语言：经度；纬度
                }
                myMsg += "[" + LOGTimeGet() + "]";
                writeLog("sms", myMsg);


                /*
                    修改人：qijj
                    日期：2012-5-16
                */
                //Begin
                var tempmsg = msg;
                if (msg.length > 10) {
                    msg = msg.substring(0, 10) + "……";
                }
                //End
                document.getElementById("scrollarea").innerHTML = "<span style='cursor:hand;text-decoration:underline;' onclick=window.parent.parent.ToLoctionByISSI('" + issi + "') >" + MYName + "(" + issi + ")</span>:<span title='" + tempmsg + "' style='cursor:hand'>" + msg + "</span> &nbsp;<span style='cursor:hand;text-decoration:underline;' onclick=window.parent.parent.mycallfunction('Send_SMS','380',400,'&cmd=ISSI&issi=" + issi + "&name=" + encodeURI(MYName) + "')>" + GetTextByName("Reply", useprameters.languagedata) + "</span>";

            }
            RevSMS(MYName, issi, msg, myptypedy);
        }, false, false);
    }
    else if (smstype == "2") {//表示收到的普通消息报告

        if (msg == "SM_SENT_TO_GROUP_ACK_PREVENTED") {//多语言：发给组不确认
            msg = constMsgSendSucess;//多语言：发送成功
        }
        if (msg == "GENERAL_STATUS_ACK") {
            msg = constMsgSendSucess;//多语言：发送成功
        }

        todbMSG = GetTextByName(msg, useprameters.languagedata);
        var param = { "issi": issi };
        jquerygetNewData_ajax("Handlers/GetIssiTypeByISSI.ashx", param, function (request) {
            var _data = request;

            //callBackRestlt += msg + ";";
            var MYName = _data.sname;

            /* 
            修改人：张谦 
            日期：2016-03-23
            备注：状态消息发送成功时日志窗口不提示短信发送成功的日志信息
            */
            if (msg != "GENERAL_STATUS_ACK") {
                switch (_data.stype) {
                    case "D":
                        var myMsg = "[" + GetTextByName("Send(SMS)", useprameters.languagedata) + "]" + GetTextByName(msg, useprameters.languagedata) + "(<span   oncontextmenu=javascript:rightselecttype='dispatch';rightISSI=" + issi + "   onclick=window.parent.parent.mycallfunction('Send_SMS','380',400,'" + issi + "&cmd=DISSI&name=" + encodeURI(GetTextByName("Dispatch", useprameters.languagedata)) + "[" + encodeURI(MYName) + "]') >" + GetTextByName("Dispatch", useprameters.languagedata) + "[" + MYName + "]" + "</span>)[" + LOGTimeGet() + "]";//多语言：发送(短信);调度台
                        writeLog("sms", myMsg);

                        break;
                    case "G":
                        var myMsg = "[" + GetTextByName("Send(SMS)", useprameters.languagedata) + "]" + GetTextByName(msg, useprameters.languagedata) + "(<span   oncontextmenu=javascript:rightselecttype='group';rightGSSI=" + issi + "   onclick=window.parent.parent.mycallfunction('Send_SMS','380',400,'" + issi + "&cmd=GSSI&name=" + encodeURI(MYName) + "') >" + MYName + ":" + issi + "</span>)[" + LOGTimeGet() + "]";//多语言：发送(短信)
                        writeLog("sms", myMsg);

                        break;
                    case "U":
                        var myMsg = "[" + GetTextByName("Send(SMS)", useprameters.languagedata) + "]" + GetTextByName(msg, useprameters.languagedata) + "(<span   oncontextmenu=javascript:rightselecttype='cell';window.parent.parent.useprameters.rightselectid=" + _data.pcid + "   onclick=window.parent.parent.mycallfunction('Send_SMS','380',400,'&cmd=ISSI&issi=" + issi + "&name=" + encodeURI(MYName) + "') >" + MYName + ":" + issi + "</span>)[" + LOGTimeGet() + "]";//多语言：发送(短信)
                        writeLog("sms", myMsg);

                        break;
                    default:
                        var myMsg = "[" + GetTextByName("Send(SMS)", useprameters.languagedata) + "]" + GetTextByName(msg, useprameters.languagedata) + "(<span onclick=window.parent.parent.mycallfunction('Send_SMS','380',400,'&cmd=ISSI&issi=" + issi + "&name=" + encodeURI(GetTextByName("UnkownUser", useprameters.languagedata)) + "') >" + GetTextByName("UnkownUser", useprameters.languagedata) + ":" + issi + "</span>)[" + LOGTimeGet() + "]";//多语言：发送(短信)；未知用户
                        writeLog("sms", myMsg);

                        break;
                }
            }
        })

    }
    //if (msg != GetTextByName("Emergency", useprameters.languagedata)) {
    jquerygetNewData_ajax("Handlers/SMSMsgHandler.ashx", { strisconsume: strisconsume, issi: issi, smstype: smstype, msg: todbMSG, id: id }, function (msg) { });
    //}
}
//上行方法
function SXMsg(issi, eventtype, msg, gssi, hookmethodsel) {
    //writeLog("system", issi + ":" + msg + ";eventtype:" + eventtype + ";hookmethodsel" + hookmethodsel);

    //上行操作窗口
    //修改上行操作窗口消息

    if (eventtype.toString() == "10") {//组呼
        if (document.frames["mypancallContent"].document.frames["groupcallContent"].IsExsit(gssi) && msg != GetTextByName("CC_CALLREQUEST", useprameters.languagedata)) {//多语言：有呼叫请求进入
            if (document.frames["mypancallContent"].document.frames["groupcallContent"].document.getElementById('sp_' + gssi) != null) {
                //document.frames["mypancallContent"].document.frames["groupcallContent"].document.getElementById('sp_' + gssi).innerHTML = issi + ":" + msg;
                document.frames["mypancallContent"].document.frames["groupcallContent"].ChangeMsgByGssi(gssi, issi, msg);
            }
        }
        else {
            document.frames["mypancallContent"].document.frames["groupcallContent"].msgToPanal(gssi, GetTextByName("UPCallPanel_CommGroupCall", useprameters.languagedata), msg);//多语言：普通组呼
        }
    }
    else if (eventtype.toString() == "01") { //全双工单呼

        if (msg == GetTextByName("CC_CALLREQUEST", useprameters.languagedata)) {//多语言：有呼叫请求进入

            document.frames["mypancallContent"].document.frames["singlecallContent"].msgToPanal(issi, GetTextByName("NormalAllSingleCall", useprameters.languagedata), msg);//多语言：普通全双工单呼

        }
        else if (msg == GetTextByName("CC_RELEASE", useprameters.languagedata)) {//多语言：对方挂断

            document.frames["mypancallContent"].document.frames["singlecallContent"].removeCallingtype(issi, "01");
            //改变呼叫框样式 
            if (document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('table01_' + issi) != null) {
                document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('table01_' + issi).setAttribute("class", "table3");
            }
            var mycallPanalISSI = callPanalISSI;
            var myiscallissi = document.frames["mypancallContent"].document.frames["singlecallContent"].iscallissi;
            callPanalISSI = "";
            document.frames["mypancallContent"].document.frames["singlecallContent"].iscallissi = "";
            if (document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('img01_' + issi) != null) {
                document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('img01_' + issi).src = strUpCallEndCallPicUrl;
            }
            if (document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('btnrev_' + issi) != null) {
                document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('btnrev_' + issi).disabled = false;
                document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('btnendqsg_' + issi).disabled = true;
                document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('btnclose01_' + issi).disabled = false;
                document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('btnrev_' + issi).value = GetTextByName("Called", useprameters.languagedata);//多语言：呼叫
            }
            if (hookmethodsel.toString() == "0" && document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('sp01_' + issi) != null) {//自动接听
                //document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('sp01_' + issi).innerHTML = msg;
                document.frames["mypancallContent"].document.frames["singlecallContent"].ChangeMsgByIssi('sp01', issi, msg);
            }
            if (issi.toString() == document.frames["mypancallContent"].document.frames["singlecallContent"].iscallissi.toString()) {
                if (document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('sp01_' + issi) != null) {
                    //document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('sp01_' + issi).innerHTML = msg;
                    document.frames["mypancallContent"].document.frames["singlecallContent"].ChangeMsgByIssi('sp01', issi, msg);
                }
                document.frames["mypancallContent"].document.frames["singlecallContent"].updateFlagByIssi(issi, true, "01"); //对方挂断后，设置为未读状态
            } else {
                if (document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('sp01_' + issi) != null) {
                    if (!document.frames["mypancallContent"].document.frames["singlecallContent"].findFlagByIssi(issi, "01")) {
                        document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('sp01_' + issi).innerHTML = "<span  style='color:Red'>" + GetTextByName("Call_Div_UnReceiveCall", useprameters.languagedata) + "</span>" + "[" + LOGTimeGet() + "]";//多语言：未接呼叫
                        //document.frames["mypancallContent"].document.frames["singlecallContent"].ChangeMsgByIssi('sp01', issi, "<span  style='color:Red'>" + GetTextByName("Call_Div_UnReceiveCall", useprameters.languagedata) + "</span>" + "[" + LOGTimeGet() + "]");
                        //改变呼叫框样式 
                        if (document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('table01_' + issi) != null) {
                            document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('table01_' + issi).setAttribute("class", "table2");
                        }
                        callPanalISSI = mycallPanalISSI;
                        document.frames["mypancallContent"].document.frames["singlecallContent"].iscallissi = myiscallissi;
                        document.frames["mypancallContent"].document.frames["singlecallContent"].updateFlagByIssi(issi, false, "01"); //对方挂断后，设置为未读状态
                        if (document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('img01_' + issi) != null) {
                            document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('img01_' + issi).src = strUpCallUnRevPicUrl;
                        }
                    } else {
                        //document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('sp01_' + issi).innerHTML = msg;
                        document.frames["mypancallContent"].document.frames["singlecallContent"].ChangeMsgByIssi('sp01', issi, msg);
                        document.frames["mypancallContent"].document.frames["singlecallContent"].updateFlagByIssi(issi, true, "01"); //对方挂断后，设置为未读状态
                    }
                }
            }
        }
        else if (msg == GetTextByName("CC_CALLPROCEEDING", useprameters.languagedata)) {//多语言：呼叫正在处理中

            if (document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('table01_' + issi) != null) {
                document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('table01_' + issi).setAttribute("class", "table1");
            }
            if (document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('img01_' + issi) != null) {
                document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('img01_' + issi).src = strUpCallingPicUrl;
            }
            if (document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('btnrev_' + issi) != null) {
                document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('btnrev_' + issi).disabled = true;
                document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('btnendqsg_' + issi).disabled = false;
                document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('btnclose01_' + issi).disabled = true;
            }
            if (document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('sp01_' + issi) != null) {
                //document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('sp01_' + issi).innerHTML = msg;
                document.frames["mypancallContent"].document.frames["singlecallContent"].ChangeMsgByIssi('sp01', issi, msg);
            }
        }
        else if (msg == GetTextByName("CC_CONNECTACK", useprameters.languagedata)) {//多语言：呼叫已连接
            // delgrouparry(issi);
            if (document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('img01_' + issi) != null) {
                document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('img01_' + issi).src = strUpCallingPicUrl;
            }
            if (document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('btnrev_' + issi) != null) {
                document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('btnrev_' + issi).disabled = true;
                document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('btnendqsg_' + issi).disabled = false;
                document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('btnclose01_' + issi).disabled = true;
            }
            document.frames["mypancallContent"].document.frames["singlecallContent"].addCallingType(issi, "01");
            if (document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('sp01_' + issi) != null) {
                //document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('sp01_' + issi).innerHTML = msg;
                document.frames["mypancallContent"].document.frames["singlecallContent"].ChangeMsgByIssi('sp01', issi, msg);
            }
            document.frames["mypancallContent"].EndSingCallFun2();
            callPanalISSI = issi;
            document.frames["mypancallContent"].document.frames["singlecallContent"].iscallissi = issi;
            document.frames["mypancallContent"].document.frames["singlecallContent"].updateFlagByIssi(issi, true, "01"); //对方挂断后，设置为未读状态
        }
        else {//多语言：
            if (document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('sp01_' + issi) != null) {
                //document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('sp01_' + issi).innerHTML = msg;
                document.frames["mypancallContent"].document.frames["singlecallContent"].ChangeMsgByIssi('sp01', issi, msg);
            }
        }

    }
    else if (eventtype.toString() == "00") {//半双工单呼

        if (msg == GetTextByName("CC_CALLREQUEST", useprameters.languagedata)) {//多语言：有呼叫请求进入

            document.frames["mypancallContent"].document.frames["singlecallContent"].msgToPanal(issi, GetTextByName("NormalHalfSingleCall", useprameters.languagedata), msg);//多语言：普通半双工单呼
        }
        else if (msg == GetTextByName("CC_RELEASE", useprameters.languagedata)) {//多语言：对方挂断

            document.frames["mypancallContent"].document.frames["singlecallContent"].removeCallingtype(issi, "00");
            var mycallPanalISSI = callPanalISSI;
            var myiscallissi = document.frames["mypancallContent"].document.frames["singlecallContent"].iscallissi;
            callPanalISSI = "";
            document.frames["mypancallContent"].document.frames["singlecallContent"].iscallissi = "";
            if (document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('img00_' + issi) != null) {
                document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('img00_' + issi).src = strUpCallEndCallPicUrl;
            }
            //改变呼叫框样式 
            if (document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('table00_' + issi) != null) {
                document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('table00_' + issi).setAttribute("class", "table3");
            }
            //修改PTT为开始按钮
            if (document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('btnbegptt_' + issi) != null && document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('btnptt_' + issi) != null) {
                document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('btnptt_' + issi).style.display = "none";
                document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('btnbegptt_' + issi).style.display = "block";
                document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('btnendptt_' + issi).disabled = true;
                document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('btnclose00_' + issi).disabled = false;
                document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('btnbegptt_' + issi).value = GetTextByName("Called", useprameters.languagedata);//多语言：呼叫
            }
            if (hookmethodsel.toString() == "0" && document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('sp00_' + issi) != null) {
                //document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('sp00_' + issi).innerHTML = msg;
                document.frames["mypancallContent"].document.frames["singlecallContent"].ChangeMsgByIssi('sp00', issi, msg);
            }
            if (issi.toString() == document.frames["mypancallContent"].document.frames["singlecallContent"].iscallissi.toString()) {
                if (document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('sp00_' + issi) != null) {
                    //document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('sp00_' + issi).innerHTML = issi + ":" + msg;
                    document.frames["mypancallContent"].document.frames["singlecallContent"].ChangeMsgByIssi('sp00', issi, msg);
                }
                document.frames["mypancallContent"].document.frames["singlecallContent"].updateFlagByIssi(issi, true, "00"); //对方挂断后，设置为未读状态
            }
            else {
                if (document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('sp00_' + issi) != null) {
                    if (!document.frames["mypancallContent"].document.frames["singlecallContent"].findFlagByIssi(issi, "00")) {
                        document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('sp00_' + issi).innerHTML = "<span  style='color:Red'>" + GetTextByName("Call_Div_UnReceiveCall", useprameters.languagedata) + "</span>" + "[" + LOGTimeGet() + "]";//多语言：未接呼叫
                        //document.frames["mypancallContent"].document.frames["singlecallContent"].ChangeMsgByIssi('sp00', issi, "<span  style='color:Red'>" + GetTextByName("Call_Div_UnReceiveCall", useprameters.languagedata) + "</span>" + "[" + LOGTimeGet() + "]");
                        //改变呼叫框样式 
                        if (document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('table00_' + issi) != null) {
                            document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('table00_' + issi).setAttribute("class", "table2");
                        }
                        callPanalISSI = mycallPanalISSI;
                        document.frames["mypancallContent"].document.frames["singlecallContent"].iscallissi = myiscallissi;
                        document.frames["mypancallContent"].document.frames["singlecallContent"].updateFlagByIssi(issi, false, "00"); //对方挂断后，设置为未读状态
                        if (document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('img00_' + issi) != null) {
                            document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('img00_' + issi).src = strUpCallUnRevPicUrl;
                        }
                    } else {
                        //document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('sp00_' + issi).innerHTML = msg;
                        document.frames["mypancallContent"].document.frames["singlecallContent"].ChangeMsgByIssi('sp00', issi, msg);
                        document.frames["mypancallContent"].document.frames["singlecallContent"].updateFlagByIssi(issi, true, "00"); //对方挂断后，设置为未读状态
                    }
                }
            }

        }
        else if (msg == GetTextByName("CC_CALLPROCEEDING", useprameters.languagedata)) {//多语言：呼叫正在处理中

            //改变呼叫框样式 
            if (document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('table00_' + issi) != null) {
                document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('table00_' + issi).setAttribute("class", "table1");
            }
            if (document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('img00_' + issi) != null) {
                document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('img00_' + issi).src = strUpCallingPicUrl;
            }
            if (document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('sp00_' + document.frames["mypancallContent"].document.frames["singlecallContent"].iscallissi.toString()) != null) {
                //document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('sp00_' + document.frames["mypancallContent"].document.frames["singlecallContent"].iscallissi.toString()).innerHTML = issi + ":" + msg;
                document.frames["mypancallContent"].document.frames["singlecallContent"].ChangeMsgByIssi('sp00', issi, msg);
            }
            if (document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('sp00_' + issi) != null) {
                //document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('sp00_' + issi).innerHTML = issi + ":" + msg;
                document.frames["mypancallContent"].document.frames["singlecallContent"].ChangeMsgByIssi('sp00', issi, msg);
            }

            if (document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('btnbegptt_' + issi) != null && document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('btnptt_' + issi) != null) {
                document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('btnptt_' + issi).style.display = "block";
                document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('btnbegptt_' + issi).style.display = "none";
                document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('btnendptt_' + issi).disabled = false;
                document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('btnclose00_' + issi).disabled = true;
                document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('btnbegptt_' + issi).value = GetTextByName("Called", useprameters.languagedata);//多语言：呼叫
            }
        }
        else if (msg == GetTextByName("CC_CONNECTACK", useprameters.languagedata)) {//多语言：呼叫已连接

            //  delgrouparry(issi);
            if (document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('img00_' + issi) != null) {
                document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('img00_' + issi).src = strUpCallingPicUrl;
            }
            document.frames["mypancallContent"].document.frames["singlecallContent"].addCallingType(issi, "00");
            if (document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('btnbegptt_' + issi) != null) {
                document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('btnbegptt_' + issi).style.display = "none";
                document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('btnptt_' + issi).style.display = "block";
                document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('btnclose00_' + issi).disabled = true;
            } else {
                setTimeout(
            function () {
                if (document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('btnbegptt_' + issi) != null) {
                    document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('btnbegptt_' + issi).style.display = "none";
                    document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('btnptt_' + issi).style.display = "block";
                    document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('btnclose00_' + issi).disabled = true;
                }
            }, 1000);
            }
            if (document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('sp00_' + issi) != null) {
                //document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('sp00_' + issi).innerHTML = issi + ":" + msg;
                document.frames["mypancallContent"].document.frames["singlecallContent"].ChangeMsgByIssi('sp00', issi, msg);
            }
            document.frames["mypancallContent"].EndSingCallFun2();
            callPanalISSI = issi;
            document.frames["mypancallContent"].document.frames["singlecallContent"].iscallissi = issi;
            document.frames["mypancallContent"].document.frames["singlecallContent"].updateFlagByIssi(issi, true, "00"); //对方挂断后，设置为未读状态

        }
        else {//多语言：

            if (document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('img00_' + issi) != null) {
                document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('img00_' + issi).src = strUpCallingPicUrl;
            }
            if (document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('sp00_' + document.frames["mypancallContent"].document.frames["singlecallContent"].iscallissi.toString()) != null) {
                //document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('sp00_' + document.frames["mypancallContent"].document.frames["singlecallContent"].iscallissi.toString()).innerHTML = issi + ":" + msg;
                document.frames["mypancallContent"].document.frames["singlecallContent"].ChangeMsgByIssi('sp00', issi, msg);
            }
            if (document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('sp00_' + issi) != null) {
                //document.frames["mypancallContent"].document.frames["singlecallContent"].document.getElementById('sp00_' + issi).innerHTML = issi + ":" + msg;
                document.frames["mypancallContent"].document.frames["singlecallContent"].ChangeMsgByIssi('sp00', issi, msg);
            }

        }

    }

    if (msg == GetTextByName("CC_RELEASE", useprameters.languagedata)) {//需要放在后面 等清空相关变量 多语言：对方挂断
        if (eventtype.toString() == "00" || eventtype.toString() == "01") {
            document.frames["mypancallContent"].EndSingCallFun();
        }
    }

};

function RevSMS(myname, issi, msg, type) {

    if (document.frames["SMS/SMSDetail_ifr"] != null || document.frames["SMS/SMSDetail_ifr"] != undefined) {
        document.frames["SMS/SMSDetail_ifr"].RevMSG(myname, issi, msg, type);
    }
}

//注销函数
function DeRegMsg(retValue) {
    window.open('', '_parent');
    window.close();
}
function VOLUMEMsg(type, ssi, volumenum) {
    //全部静音
    if (type == "TYPESPEAKMUTE" && volumenum == 0) {
        setisAllMute(true);
        changeallVoiveImg(true);
    }
        //全不部静音
    else if (type == "TYPESPEAKMUTE" && volumenum == 100) {
        setisAllMute(false);
        changeallVoiveImg(false);
    }
    //小组静音
    if (type == "TYPEGROUP" && volumenum == 0) {
        addmuteGroupList(ssi);
        tongbuvoiceImgByGSSI(ssi, true)
    }
    else if (type == "TYPEGROUP" && volumenum > 0 && volumenum <= 100) {
        deleteFromMuteGroupList(ssi);
        tongbuvoiceImgByGSSI(ssi, false);
    }
}
function setisAllMute(isAllMute) {
    useprameters.isAllMute = isAllMute;
}
function changeallVoiveImg(isAllMute) {
    var groupcallContent = document.frames["groupcallContent"];
    if (groupcallContent) {
        groupcallContent.changeallVoiveImg(isAllMute);
    }
}
function addmuteGroupList(GSSI) {
    useprameters.muteGroupList.push(GSSI);
}
function deleteFromMuteGroupList(GSSI) {
    for (var i = 0; i < useprameters.muteGroupList.length; i++) {
        if (useprameters.muteGroupList[i] == GSSI) {
            useprameters.muteGroupList.splice(i, 1);
            break;
        }
    }
}
function tongbuvoiceImgByGSSI(GSSI, isMute) {
    var mypancallContent = window.parent.document.frames["mypancallContent"];
    if (mypancallContent) {
        var groupcallContent = mypancallContent.document.frames["groupcallContent"];
        if (groupcallContent) {
            groupcallContent.tongbuvoiceImgByGSSI(GSSI, isMute);
        }
    }
}
//注册之后调用
function doAfterUserReg(ret) {
    if (ret == 0) {
        document.getElementById("regDiv").style.display = "none";
        useprameters.callActivexable = false;
        writeLog("system", GetTextByName("CallControlRegFailed", useprameters.languagedata));//多语言：呼叫控件注册失败
    }
    else {
        document.getElementById("regDiv").style.display = "none";
    }
}
//注册函数
function doRegX() {
    //return;
    var scactionX = document.getElementById("SCactionX");
    // var url = kdocTitle;
    var strUserName = getCookieByName('username'); //单位id
    //var entityid = getCookieByName('id'); //单位id
    useprameters.callActivexable = false;

    if (scactionX) {
        try {
            //alert(entityid);
            var ret = scactionX.DispatchUserReg(GetTextByName("WebGisTitle", useprameters.languagedata), strUserName);//多语言：eTRA GIS调度应用系统平台
            doAfterUserReg(ret);
        }
        catch (err) {
            try {
                var ret2 = scactionX.DispatchUserReg(GetTextByName("WebGisTitle", useprameters.languagedata));//多语言：eTRA GIS调度应用系统平台

                doAfterUserReg(ret2);
            }
            catch (err2) {
                alert(err2);

                try {
                    document.getElementById("regDiv").style.display = "none";
                    useprameters.callActivexable = false;

                    document.getElementById("scrollarea").innerHTML = GetTextByName("Alert_OcxUnLoadCanNotCall", useprameters.languagedata);//多语言：控件未成功加载,呼叫功能不可用


                    writeLog("system", GetTextByName("CallControlRegFailed", useprameters.languagedata));//多语言：呼叫控件注册失败
                }
                catch (er) {
                    document.getElementById("regDiv").style.display = "none";
                }
            }
        }
        finally {

            document.getElementById("regDiv").style.display = "none";
        }
    }
    //useprameters.callActivexable = true;//测试代码
}
//注册前验证函数，日志及主页面是否已加载完毕 加载完在取调用注册函数，忍耐度10秒
function regX() {
    if (isLoadLog == 'log' && isLoadMain == 'main' && isLoadSys == 'SYS') {

        doRegX();
    }
    else {

        var varNow = new Date();

        if (varNow.getYear().toString() + varNow.getMonth().toString() + varNow.getDay().toString() + varNow.getHours().toString() + varNow.getMinutes().toString() + varNow.getSeconds().toString() + varNow.getMilliseconds().toString() - begtime < 60000) {
            setTimeout(regX, 1000);
        }
        else {
            doRegX();
            document.getElementById("regDiv").style.display = "none";
        }
    }
}

window.onload = function () {

    var bgObj = document.getElementById("regDiv");
    if (bgObj != null && bgObj) {
        bgObj.style.width = document.body.offsetWidth + "px";
        bgObj.style.height = screen.height + "px";
        bgObj.style.display = "block";
    }

    kdocTitle = document.title;

    if (kdocTitle == null) {
        var t_titles = document.getElementByTagName("title")

        if (t_titles && t_titles.length > 0) {
            kdocTitle = t_titles[0];
        }
        else {
            kdocTitle = "";
        }
    }

    // var varNow = new Date();
    // begtime = varNow.getYear().toString() + varNow.getMonth().toString() + varNow.getDay().toString() + varNow.getHours().toString() + varNow.getMinutes().toString() + varNow.getSeconds().toString() + varNow.getMilliseconds().toString();

    //注册函数放在lq_newjs.js中的get_usepramater内执行，等到多国语言加载完后在执行注册
    //setTimeout(regX, 1000);
}


//添加基站组号
function AddMBSGroupId(BsgID) {
    try {
        var scactionX = document.getElementById("SCactionX");
        return scactionX.AddorDelMBSGroupId(BsgID, 0);
    } catch (ex) {
        writeLog("system", ex);
        return false;
    }
}
//删除基站组号
function DelMBSGroupId(BsgID) {
    try {
        var scactionX = document.getElementById("SCactionX");
        return scactionX.AddorDelMBSGroupId(BsgID, 1);
    } catch (ex) {
        writeLog("system", ex);
        return false;
    }
}
//添加基站组成员
function AddMBSGroupMem(BsgID, MemberID) {
    try {
        var scactionX = document.getElementById("SCactionX");
        return scactionX.AddorDelMBSGroupMem(BsgID, MemberID, 0);
    } catch (ex) {
        writeLog("system", ex);
        return false;
    }
}
//删除基站组成员
function DelMBSGroupMem(BsgID, MemberID) {
    try {
        var scactionX = document.getElementById("SCactionX");
        return scactionX.AddorDelMBSGroupMem(BsgID, MemberID, 1);
    } catch (ex) {
        writeLog("system", ex);
        return false;
    }
}
//开始基站组呼叫
function StartMBSGroupCall(BsgID) {
    var content = "";
    try {
        var scactionX = document.getElementById("SCactionX");
        WriteBSLo(GetTextByName("Lang_BegBSGroupCall", useprameters.languagedata) + "(" + BsgID + ")");//多语言：开始基站组呼叫
        //写入数据库日志
        content = "Log_BegMuitleBS_Call_Success";
        writeToDbByUserISSI(BsgID, OperateLogType.operlog, OperateLogModule.ModuleCall, OperateLogOperType.MultiBaseStation, content, OperateLogIdentityDeviceType.BaseStation);

        return scactionX.StartMBSGroupCall(BsgID);
    } catch (ex) {
        writeLog("system", ex);
        //写入数据库日志
        content = "Log_BegMuitleBS_Call_Failed";

        return false;
    } finally {
        writeToDbByUserISSI(BsgID, OperateLogType.operlog, OperateLogModule.ModuleCall, OperateLogOperType.MultiBaseStation, content, OperateLogIdentityDeviceType.BaseStation);
    }
}
//结束基站组呼叫
function EndMBSGroupCall(BsgID) {
    try {
        var scactionX = document.getElementById("SCactionX");
        WriteBSLo(GetTextByName("Lang_EndBSGroupCall", useprameters.languagedata) + "(" + BsgID + ")");//多语言：结束基站组呼叫
        //写入数据库日志
        var content = "Log_EndMuitleBS_Call_Success";
        writeToDbByUserISSI(BsgID, OperateLogType.operlog, OperateLogModule.ModuleCall, OperateLogOperType.MultiBaseStation, content, OperateLogIdentityDeviceType.BaseStation);

        return scactionX.EndMBSGroupCall(BsgID);
    } catch (ex) {
        writeLog("system", ex);
        //写入数据库日志
        var content = "Log_EndMuitleBS_Call_Failed";
        writeToDbByUserISSI(BsgID, OperateLogType.operlog, OperateLogModule.ModuleCall, OperateLogOperType.MultiBaseStation, content, OperateLogIdentityDeviceType.BaseStation);

        return false;
    }
}
//添加派接组号
function AddPatchGroupId(PatchGroupID) {
    try {
        var scactionX = document.getElementById("SCactionX");
        return scactionX.AddorDelPatchGroupId(PatchGroupID, 0);
    } catch (ex) {
        writeLog("system", ex);
        return false;
    }
}
//删除派接组号
function DelPatchGroupId(PatchGroupID) {
    try {
        var scactionX = document.getElementById("SCactionX");
        return scactionX.AddorDelPatchGroupId(PatchGroupID, 1);
    } catch (ex) {
        writeLog("system", ex);
        return false;
    }
}
//添加派接组成员
function AddPatchGroupMem(PatchGroupID, MemberID) {
    try {
        var scactionX = document.getElementById("SCactionX");
        return scactionX.AddorDelPatchGroupMem(PatchGroupID, MemberID, 0);
    } catch (ex) {
        writeLog("system", ex);
        return false;
    }
}
//删除派接组成员
function DelPatchGroupMem(PatchGroupID, MemberID) {
    try {
        var scactionX = document.getElementById("SCactionX");
        return scactionX.AddorDelPatchGroupMem(PatchGroupID, MemberID, 1);
    } catch (ex) {
        writeLog("system", ex);
        return false;
    }
}
//开始派接组呼叫
function StartPatchGroupCall(PatchGroupID) {
    var content = "";
    try {
        var scactionX = document.getElementById("SCactionX");

        //写入数据库日志
        content = "Log_BegPatch_Call_Success";

        return scactionX.StartPatchGroupCall(PatchGroupID);
    } catch (ex) {
        writeLog("system", ex);
        //写入数据库日志
        content = "Log_BegPatch_Call_Failed";

        return false;
    } finally {
        writeToDbByUserISSI(PatchGroupID, OperateLogType.operlog, OperateLogModule.ModuleCall, OperateLogOperType.PatchCall, content, OperateLogIdentityDeviceType.MobilePhone);

    }
}
//结束派接组呼叫
function EndPatchGroupCall(PatchGroupId) {
    var content = "";
    try {
        var scactionX = document.getElementById("SCactionX");
        //写入数据库日志
        content = "Log_EndPatch_Call_Success";

        return scactionX.EndorCeasedPatchGroupCall(PatchGroupId, 1);
    } catch (ex) {
        writeLog("system", ex);
        //写入数据库日志
        content = "Log_EndPatch_Call_Failed";

        return false;
    } finally {
        writeToDbByUserISSI(PatchGroupId, OperateLogType.operlog, OperateLogModule.ModuleCall, OperateLogOperType.PatchCall, content, OperateLogIdentityDeviceType.MobilePhone);

    }
}
//释放派接组呼叫授权
function CeasedPatchGroupCall(PatchGroupId) {
    try {
        var scactionX = document.getElementById("SCactionX");
        return scactionX.EndorCeasedPatchGroupCall(PatchGroupId, 0);
    } catch (ex) {
        writeLog("system", ex);
        return false;
    }
}
//添加多选组号
function AddMSGroupId(MSelGroupId) {
    try {
        var scactionX = document.getElementById("SCactionX");
        return scactionX.AddorDelMSGroupId(MSelGroupId, 0);
    } catch (ex) {
        writeLog("system", ex);
        return false;
    }
}
//删除多选组号
function DelMSGroupId(MSelGroupId) {
    try {
        var scactionX = document.getElementById("SCactionX");
        return scactionX.AddorDelMSGroupId(MSelGroupId, 1);
    } catch (ex) {
        writeLog("system", ex);
        return false;
    }
}
//添加多选组成员
function AddMSGroupMem(MSGroupId, MSGroupMemId) {
    try {
        var scactionX = document.getElementById("SCactionX");
        return scactionX.AddorDelMSGroupMem(MSGroupId, MSGroupMemId, 0);
    } catch (ex) {
        writeLog("system", ex);
        return false;
    }
}
//删除多选组成员
function DelMSGroupMem(MSGroupId, MSGroupMemId) {
    try {
        var scactionX = document.getElementById("SCactionX");
        return scactionX.AddorDelMSGroupMem(MSGroupId, MSGroupMemId, 1);
    } catch (ex) {
        writeLog("system", ex);
        return false;
    }
}
//开始多选组呼叫
function StartMSGroupCall(MSGroupID) {
    var content = "";
    try {
        //写入数据库日志
        content = "Log_BegMuSel_Call_Success";

        var scactionX = document.getElementById("SCactionX");
        return scactionX.StartMSGroupCall(MSGroupID);
    } catch (ex) {
        writeLog("system", ex);
        content = "Log_BegMuSel_Call_Failed";

        return false;
    } finally {
        writeToDbByUserISSI(MSGroupID, OperateLogType.operlog, OperateLogModule.ModuleCall, OperateLogOperType.MultiSelect, content, OperateLogIdentityDeviceType.MobilePhone);

    }
}
//结束多选组呼叫
function EndMSGroupCall(MSGroupID) {
    var content = "";
    try {
        //写入数据库日志
        content = "Log_EndMuSel_Call_Success";


        var scactionX = document.getElementById("SCactionX");
        return scactionX.EndMSGroupCall(MSGroupID);
    } catch (ex) {
        //写入数据库日志
        content = "Log_EndMuSel_Call_Failed";


        writeLog("system", ex);
        return false;
    } finally {
        writeToDbByUserISSI(MSGroupID, OperateLogType.operlog, OperateLogModule.ModuleCall, OperateLogOperType.MultiSelect, content, OperateLogIdentityDeviceType.MobilePhone);

    }
}
//摇启
function enableRadio(phone) {
    try {
        //写入数据库日志
        var content = "YaoQi";
        writeToDbByUserISSI(phone, OperateLogType.operlog, OperateLogModule.ModuleCall, OperateLogOperType.ReviceTerminal, content, OperateLogIdentityDeviceType.MobilePhone);

        var scactionX = document.getElementById("SCactionX");
        var reval = scactionX.EnableRadio(phone);
        WriteBSLo(GetTextByName("Lang_EnableRadioISSI", useprameters.languagedata) + "(ISSI:" + phone + ")");//多语言：遥启终端
        writeLog("oper", "[" + GetTextByName("YaoQi", useprameters.languagedata) + "]:" + GetTextByName("Lang_EnableRadioISSI", useprameters.languagedata) + "(ISSI:" + phone + ")" + "[" + LOGTimeGet() + "]");         /**日志：操作日志 多语言：遥启；遥启终端**/



        return reval;
    } catch (ex) {
        writeLog("system", ex);
        return false;
    }
}
//摇毙
function disableRadio(phone) {
    try {
        //写入数据库日志
        var content = "YaoBi";
        writeToDbByUserISSI(phone, OperateLogType.operlog, OperateLogModule.ModuleCall, OperateLogOperType.KillTerminal, content, OperateLogIdentityDeviceType.MobilePhone);

        var scactionX = document.getElementById("SCactionX");
        var reval = scactionX.DisableRadio(phone);
        WriteBSLo(GetTextByName("Lang_DisableRadioISSI", useprameters.languagedata) + "(ISSI:" + phone + ")");//多语言：遥毙终端
        writeLog("oper", "[" + GetTextByName("YaoBi", useprameters.languagedata) + "]:" + GetTextByName("Lang_DisableRadioISSI", useprameters.languagedata) + "(ISSI:" + phone + ")" + "[" + LOGTimeGet() + "]");         /**日志：操作日志 多语言：遥毙；遥毙终端**/


        return reval;
    } catch (ex) {
        writeLog("system", ex);
        return false;
    }
}
//发起单呼
function startDC() {
    var content = "";
    try {
        if (useprameters.SelectISSI && useprameters.SelectISSI.length == 1) {
            //写入数据库日志
            content = "Log_BegFullSigle_Success";
            var scactionX = document.getElementById("SCactionX");
            var reval = scactionX.StartDCall(useprameters.SelectISSI[0]);
            writeLog("oper", "[" + GetTextByName("SingleCALL(all)", useprameters.languagedata) + "]:" + GetTextByName("Lang_DispatchBegAllSingleCall", useprameters.languagedata) + "(ISSI:" + useprameters.SelectISSI[0] + ")" + "[" + LOGTimeGet() + "]");         /**日志：操作日志  多语言：单呼(全);调度台呼叫栏开始全双工单呼**/
            return reval;
        }
        else return false;
    } catch (ex) {
        //写入数据库日志
        content = "Log_BegFullSigle_Failed";
        writeLog("system", ex);
        return false;
    } finally {
        writeToDbByUserISSI(useprameters.SelectISSI, OperateLogType.operlog, OperateLogModule.ModuleCall, OperateLogOperType.FullDuplex, content, OperateLogIdentityDeviceType.MobilePhone);

    }
}
//控制面板里面使用
//开始单基站呼叫
function startSBCall(phone) {
    var content = "";
    try {
        var scactionX = document.getElementById("SCactionX");
        var reval = scactionX.StartSBCall(phone);
        writeLog("oper", "[" + GetTextByName("Lang_SingleStationCall", useprameters.languagedata) + "]:" + GetTextByName("Lang_DispatchBegBaseStationCall", useprameters.languagedata) + "(ISSI:" + phone + ")" + "[" + LOGTimeGet() + "]");         /**日志：操作日志 多语言：单站呼叫;调度台操作窗口开始基站呼叫**/
        WriteBSLo(GetTextByName("Lang_BegSingleBaseStationCall", useprameters.languagedata) + "(" + phone + ")");// 多语言：开始单站基站呼叫
        //写入数据库日志
        content = "Log_BegSigleBS_Call_Success";

        return reval;
    } catch (ex) {
        writeLog("system", ex);
        //写入数据库日志
        content = "Log_BegSigleBS_Call_Failed";


        return false;
    } finally {
        writeToDbByUserISSI(phone, OperateLogType.operlog, OperateLogModule.ModuleCall, OperateLogOperType.SingleBaseStation, content, OperateLogIdentityDeviceType.BaseStation);
    }
}
//结束单基站呼叫
function endSBCall(phone) {
    var content = "";
    try {
        var scactionX = document.getElementById("SCactionX");
        var reval = scactionX.EndSBCall(phone);
        writeLog("oper", "[" + GetTextByName("Lang_SingleStationCall", useprameters.languagedata) + "]:" + GetTextByName("Lang_DispatchEndBaseStationCall", useprameters.languagedata) + "(ISSI:" + phone + ")" + "[" + LOGTimeGet() + "]");         /**日志：操作日志 多语言：单站呼叫;调度台操作窗口结束基站呼叫**/
        WriteBSLo(GetTextByName("Lang_EndSingleBaseStationCall", useprameters.languagedata) + "(" + phone + ")");//多语言：单站呼叫；结束单站基站呼叫
        //写入数据库日志
        content = "Log_EndSigleBS_Call_Success";

        return reval;
    } catch (ex) {
        writeLog("system", ex);
        //写入数据库日志
        content = "Log_EndSigleBS_Call_Failed";
        return false;
    } finally {
        writeToDbByUserISSI(phone, OperateLogType.operlog, OperateLogModule.ModuleCall, OperateLogOperType.SingleBaseStation, content, OperateLogIdentityDeviceType.BaseStation);
    }
}
//开始全基站呼叫
function startAllCall() {
    var content = "";
    try {
        var scactionX = document.getElementById("SCactionX");
        var reval = scactionX.StartALLBCall();
        writeLog("oper", "[" + GetTextByName("Lang_TheStationCall", useprameters.languagedata) + "]:" + GetTextByName("Lang_DispatchCallPanelBegAllBaseStationCall", useprameters.languagedata) + "[" + LOGTimeGet() + "]");         /**日志：操作日志 多语言：调度台操作窗口开始全站呼叫 多语言：全站呼叫；调度台操作窗口开始全站呼叫**/
        WriteBSLo(GetTextByName("Lang_BegAllBaseStationCall", useprameters.languagedata));//多语言：开始全基站呼叫
        //写入数据库日志
        content = "Log_BegAllBS_Call_Success";
        return reval;
    } catch (ex) {
        //写入数据库日志
        content = "Log_BegAllBS_Call_Failed";
        writeLog("system", ex);
        return false;
    } finally {
        writeToDbByOther(OperateLogType.operlog, OperateLogModule.ModuleCall, OperateLogOperType.AllBaseStation, content, OperateLogIdentityDeviceType.BaseStation);
    }
}
//结束全基站呼叫
function endAllCall() {
    var content = "";
    try {
        var scactionX = document.getElementById("SCactionX");
        var reval = scactionX.EndALLBCall();
        writeLog("oper", "[" + GetTextByName("Lang_TheStationCall", useprameters.languagedata) + "]:" + GetTextByName("Lang_DispatchCallPanelEndAllBaseStationCall", useprameters.languagedata) + "[" + LOGTimeGet() + "]");         /**日志：操作日志 多语言：全站呼叫；调度台操作窗口结束全站呼叫**/
        WriteBSLo(GetTextByName("Lang_EndAllBaseStationCall", useprameters.languagedata));//多语言：结束全基站呼叫
        //写入数据库日志
        content = "Log_EndAllBS_Call_Success";
        return reval;
    } catch (ex) {
        writeLog("system", ex);
        //写入数据库日志
        content = "Log_EndAllBS_Call_Failed";
        return false;
    } finally {
        writeToDbByOther(OperateLogType.operlog, OperateLogModule.ModuleCall, OperateLogOperType.AllBaseStation, content, OperateLogIdentityDeviceType.BaseStation);
    }
}
//开始全双工紧急呼叫
function startppcDC(phone) {
    var content = "";
    try {
        //写入数据库日志
        content = "Log_BegQSGDH_Call_Success";
        var scactionX = document.getElementById("SCactionX");
        var reval = scactionX.StartPPCDCall(phone);
        writeLog("oper", "[" + GetTextByName("Log_EmergentAllCall", useprameters.languagedata) + "]:" + GetTextByName("Lang_DispatchCallPanelBegEmergentCall", useprameters.languagedata) + "(ISSI:" + phone + ")" + "[" + LOGTimeGet() + "]");         /**日志：操作日志 多语言：紧急单呼(全);调度台操作窗口开始紧急呼叫 **/
        PanalPPCCallISSI = phone;
        return reval;
    } catch (ex) {
        //写入数据库日志
        content = "Log_BegQSGDH_Call_Failed";
        writeLog("system", ex);
        return false;
    } finally {
        writeToDbByUserISSI(phone, OperateLogType.operlog, OperateLogModule.ModuleCall, OperateLogOperType.PPCFullDulex, content, OperateLogIdentityDeviceType.MobilePhone);
    }
}
//结束全双工紧急呼叫
function endppcDC(phone) {
    var content = "";
    try {
        //写入数据库日志
        content = "Log_EndQSGDH_Call_Success";
        var scactionX = document.getElementById("SCactionX");
        var reval = scactionX.ENDPPCDCall(phone);
        writeLog("oper", "[" + GetTextByName("Log_EmergentAllCall", useprameters.languagedata) + "]:" + GetTextByName("Lang_DispatchCallPanelEndEmergentCall", useprameters.languagedata) + "(ISSI:" + phone + ")" + "[" + LOGTimeGet() + "]");         /**日志：操作日志 多语言：紧急单呼(全);调度台操作窗口结束紧急呼叫**/
        PanalPPCCallISSI = "";
        return reval;
    } catch (ex) {
        //写入数据库日志
        content = "Log_EndQSGDH_Call_Failed";
        writeLog("system", ex);
        return false;
    } finally {
        writeToDbByUserISSI(phone, OperateLogType.operlog, OperateLogModule.ModuleCall, OperateLogOperType.PPCFullDulex, content, OperateLogIdentityDeviceType.MobilePhone);
    }
}
//开始半双工紧急呼叫
function startppcSC(phone) {
    var content = "";
    try {
        //写入数据库日志
        content = "Log_BegBSGDH_Call_Success";
        var scactionX = document.getElementById("SCactionX");
        var reval = scactionX.StartPPCSCall(phone);
        PanalPPCCallISSI = phone;
        writeLog("oper", "[" + GetTextByName("Log_EmergentHalfCall", useprameters.languagedata) + "]:" + GetTextByName("Lang_DispatchCallPanelBegEmergentCall", useprameters.languagedata) + "(ISSI:" + phone + ")" + "[" + LOGTimeGet() + "]");         /**日志：操作日志 多语言：紧急单呼(半);调度台操作窗口开始紧急呼叫 **/
        document.frames["mypancallContent"].document.frames["singlecallContent"].iscallissi = phone;
        return reval;
    } catch (ex) {
        //写入数据库日志
        content = "Log_BegBSGDH_Call_Failed";
        writeLog("system", ex);
        return false;
    } finally {
        writeToDbByUserISSI(phone, OperateLogType.operlog, OperateLogModule.ModuleCall, OperateLogOperType.PPCHalfDuplex, content, OperateLogIdentityDeviceType.MobilePhone);
    }
}
//半双工紧急呼叫获取授权
function ppcsceasedPTT(phone) {
    try {
        var scactionX = document.getElementById("SCactionX");
        var reval = scactionX.PPCSCEASEDPTT(phone);
        return reval;
    } catch (ex) {
        writeLog("system", ex);
        return false;
    }
}
//结束半双工紧急呼叫
function endppcSC(phone) {
    var content = "";
    try {
        //写入数据库日志
        content = "Log_EndBSGDH_Call_Success";
        var scactionX = document.getElementById("SCactionX");
        var reval = scactionX.ENDPPCSCall(phone);
        PanalPPCCallISSI = "";
        writeLog("oper", "[" + GetTextByName("Log_EmergentHalfCall", useprameters.languagedata) + "]:" + GetTextByName("Lang_DispatchCallPanelEndEmergentCall", useprameters.languagedata) + "(ISSI:" + phone + ")" + "[" + LOGTimeGet() + "]");         /**日志：操作日志 多语言：紧急单呼(半);调度台操作窗口结束紧急呼叫 **/
        document.frames["mypancallContent"].document.frames["singlecallContent"].iscallissi = "";
        return reval;
    } catch (ex) {
        //写入数据库日志
        content = "Log_EndBSGDH_Call_Failed";
        writeLog("system", ex);
        return false;
    } finally {
        writeToDbByUserISSI(phone, OperateLogType.operlog, OperateLogModule.ModuleCall, OperateLogOperType.PPCHalfDuplex, content, OperateLogIdentityDeviceType.MobilePhone);
    }
}
//开始组呼紧急呼叫
function startppcGC(phone) {
    var content = "";
    try {
        //写入数据库日志
        content = "Log_BegPPCGroup_Call_Success";
        var scactionX = document.getElementById("SCactionX");
        var reval = scactionX.StartPPCGCall(phone);
        writeLog("oper", "[" + GetTextByName("Log_EmergentGroupCall", useprameters.languagedata) + "]:" + GetTextByName("Lang_DispatchCallPanelBegEmergentCall", useprameters.languagedata) + "(GSSI:" + phone + ")" + "[" + LOGTimeGet() + "]");         /**日志：操作日志 多语言：紧急组呼;调度台操作窗口开始紧急呼叫**/
        PanalPPCCallISSI = phone;
        return reval;
    } catch (ex) {
        //写入数据库日志
        content = "Log_BegPPCGroup_Call_Failed";
        writeLog("system", ex);
        return false;
    } finally {
        writeToDbByUserISSI(phone, OperateLogType.operlog, OperateLogModule.ModuleCall, OperateLogOperType.PPCGroupCall, content, OperateLogIdentityDeviceType.MobilePhone);
    }
}
//半双工紧急呼叫释放授权
function ppcgceasedPTT(phone) {
    try {
        var scactionX = document.getElementById("SCactionX");
        var reval = scactionX.PPCGCEASEDPTT(phone);
        return reval;
    } catch (ex) {
        writeLog("system", ex);
        return false;
    }
}
//结束组呼紧急呼叫
function endppcGC(phone) {
    var content = "";
    try {
        //写入数据库日志
        content = "Log_EndPPCGroup_Call_Success";
        var scactionX = document.getElementById("SCactionX");
        var reval = scactionX.ENDPPCGCall(phone);
        writeLog("oper", "[" + GetTextByName("Log_EmergentGroupCall", useprameters.languagedata) + "]:" + GetTextByName("Lang_DispatchCallPanelEndEmergentCall", useprameters.languagedata) + "(GSSI:" + phone + ")" + "[" + LOGTimeGet() + "]");         /**日志：操作日志 多语言：紧急组呼;调度台操作窗口结束紧急呼叫**/
        PanalPPCCallISSI = "";
        return reval;
    } catch (ex) {
        //写入数据库日志
        content = "Log_EndPPCGroup_Call_Failed";
        writeLog("system", ex);
        return false;
    } finally {
        writeToDbByUserISSI(phone, OperateLogType.operlog, OperateLogModule.ModuleCall, OperateLogOperType.PPCGroupCall, content, OperateLogIdentityDeviceType.MobilePhone);
    }
}
//开始环境监听
function startAL(phone) {
    var content = "";
    try {
        //写入数据库日志
        content = "Log_BegAL_Success";
        var scactionX = document.getElementById("SCactionX");
        var reval = scactionX.StartAl(phone);
        if (reval == 1) {
            isPanalALCall = true;
        }
        writeLog("oper", "[" + GetTextByName("EnvironmentalMonitoring", useprameters.languagedata) + "]:" + GetTextByName("Lang_DispatchCallPanelBegEnvironmentMonitor", useprameters.languagedata) + "(ISSI:" + phone + ")" + "[" + LOGTimeGet() + "]");         /**日志：操作日志 多语言：环境监听;调度台操作窗口开始环境监听**/
        WriteBSLo(GetTextByName("Lang_BegEnvironmentMonitor", useprameters.languagedata) + "(ISSI:" + phone + ")");//多语言：境监听;开始进行环境监听
        return reval;
    } catch (ex) {
        //写入数据库日志
        content = "Log_BegAL_Failed";
        writeLog("system", ex);
        return false;
    } finally {
        writeToDbByUserISSI(phone, OperateLogType.operlog, OperateLogModule.ModuleCall, OperateLogOperType.AmbienceListening, content, OperateLogIdentityDeviceType.MobilePhone);
    }
}
//结束环境监听
function endAL(phone) {
    var content = "";
    try {
        //写入数据库日志
        content = "Log_EndAL_Success";
        var scactionX = document.getElementById("SCactionX");
        var reval = scactionX.ENDAL(phone);
        if (reval == 1) {//假如失败怎么办？
            isPanalALCall = false;
        }
        writeLog("oper", "[" + GetTextByName("EnvironmentalMonitoring", useprameters.languagedata) + "]:" + GetTextByName("Lang_DispatchCallPanelEndEnvironmentMonitor", useprameters.languagedata) + "(ISSI:" + phone + ")" + "[" + LOGTimeGet() + "]");         /**日志：操作日志 多语言：环境监听;调度台操作窗口结束环境监听**/
        WriteBSLo(GetTextByName("Lang_EndEnvironmentMonitor", useprameters.languagedata) + "(ISSI:" + phone + ")");//多语言：境监听;结束环境监听
        return reval;
    } catch (ex) {
        //写入数据库日志
        content = "Log_EndAL_Failed";
        writeLog("system", ex);
        return false;
    } finally {
        writeToDbByUserISSI(phone, OperateLogType.operlog, OperateLogModule.ModuleCall, OperateLogOperType.AmbienceListening, content, OperateLogIdentityDeviceType.MobilePhone);
    }
}
//开始慎密监听
function startDL(phone) {
    var content = "";
    try {
        //写入数据库日志
        content = "Log_BegDL_Success";
        var scactionX = document.getElementById("SCactionX");
        var reval = scactionX.StartDL(phone);
        //writeLog("system", "操作：开始慎密监听：" + phone + "|" + reval);
        writeLog("oper", "[" + GetTextByName("CloseMonitoring", useprameters.languagedata) + "]:" + GetTextByName("Lang_DispatchCallPanelBegRigorousMonitor", useprameters.languagedata) + "(ISSI:" + phone + ")" + "[" + LOGTimeGet() + "]");         /**日志：操作日志 多语言：慎密监听;调度台操作窗口开始慎密监听**/
        WriteBSLo(GetTextByName("Lang_BegRigorousMonitor", useprameters.languagedata) + "(ISSI:" + phone + ")");//多语言：开始慎密监听
        if (reval == 1) {
            isPanalDLCall = true;
        }
        return reval;
    } catch (ex) {
        //写入数据库日志
        content = "Log_BegDL_Failed";
        writeLog("system", ex);
        return false;
    }
    finally {

        writeToDbByUserISSI(phone, OperateLogType.operlog, OperateLogModule.ModuleCall, OperateLogOperType.DiscreetListening, content, OperateLogIdentityDeviceType.MobilePhone);
    }
}
//结束慎密监听
function endDL(phone) {
    var content = "";
    try {
        //写入数据库日志
        content = "Log_EndDL_Success";
        var scactionX = document.getElementById("SCactionX");
        var reval = scactionX.ENDDL(phone);
        writeLog("oper", "[" + GetTextByName("CloseMonitoring", useprameters.languagedata) + "]:" + GetTextByName("Lang_DispatchCallPanelEndRigorousMonitor", useprameters.languagedata) + "(ISSI:" + phone + ")" + "[" + LOGTimeGet() + "]");         /**日志：操作日志 多语言：慎密监听;调度台操作窗口结束慎密监听**/
        WriteBSLo(GetTextByName("Lang_EndRigorousMonitor", useprameters.languagedata) + "(ISSI:" + phone + ")");//多语言：结束慎密监听
        if (reval == 1) {
            isPanalDLCall = false;
        }
        return reval;
    } catch (ex) {
        //写入数据库日志
        content = "Log_EndDL_Failed";
        writeLog("system", ex);
        return false;
    } finally {
        writeToDbByUserISSI(phone, OperateLogType.operlog, OperateLogModule.ModuleCall, OperateLogOperType.DiscreetListening, content, OperateLogIdentityDeviceType.MobilePhone);
    }
}
//强拆
function forceRelease(phone) {
    var content = "";
    try {
        //写入数据库日志
        content = "Log_BegForceRelease_Success";
        var scactionX = document.getElementById("SCactionX");
        var reval = scactionX.ForcedRelease(phone);
        WriteBSLo(GetTextByName("Lang_BegForceReleaseForCallingISSI", useprameters.languagedata) + "(ISSI:" + phone + ")");//多语言：开始对终端正在进行的单呼进行强拆
        return reval;
    } catch (ex) {
        //写入数据库日志
        content = "Log_BegForceRelease_Failed";
        writeLog("system", ex);
        return false;
    } finally {
        writeToDbByUserISSI(phone, OperateLogType.operlog, OperateLogModule.ModuleCall, OperateLogOperType.ForcedRelease, content, OperateLogIdentityDeviceType.MobilePhone);
    }
}
//强插 强插后 呼叫状态
function startCallintrusion(phone) {
    var content = "";
    try {
        //写入数据库日志
        content = "Log_BegBreakIn_Success";
        var scactionX = document.getElementById("SCactionX");
        var reval = scactionX.Callintrusionstart(phone);
        WriteBSLo(GetTextByName("Lang_BegCallIntrusionForCallingISSI", useprameters.languagedata) + "(ISSI:" + phone + ")");//多语言：开始对终端正在进行的单呼进行强插
        callPanalISSI = phone;
        return reval;
    } catch (ex) {
        //写入数据库日志
        content = "Log_BegBreakIn_Failed";
        writeLog("system", ex);
        return false;
    } finally {
        writeToDbByUserISSI(phone, OperateLogType.operlog, OperateLogModule.ModuleCall, OperateLogOperType.BreakIn, content, OperateLogIdentityDeviceType.MobilePhone);
    }
}
function startDC2(phone) {
    var content = "";
    try {
        //写入数据库日志
        content = "Log_BegFullSigle_Success";
        var scactionX = document.getElementById("SCactionX");
        var reval = scactionX.StartDCall(phone);
        writeLog("oper", "[" + GetTextByName("SingleCALL(all)", useprameters.languagedata) + "]:" + GetTextByName("Lang_DispatchCallPanelBegAllSingleCall", useprameters.languagedata) + "(ISSI:" + phone + ")" + "[" + LOGTimeGet() + "]");         /**日志：操作日志 //多语言：单呼(全);调度台操作窗口开始全双工单呼**/
        if (reval == 1) {
            callPanalISSI = phone;
            window.parent.parent.delgrouparry(phone);

            // ifrs.restbackimg();
            document.getElementById("scrollarea").innerHTML = "";

        }
        return reval;
    } catch (ex) {
        //写入数据库日志
        content = "Log_BegFullSigle_Failed";
        writeLog("system", ex);
        return false;
    } finally {
        writeToDbByUserISSI(phone, OperateLogType.operlog, OperateLogModule.ModuleCall, OperateLogOperType.FullDuplex, content, OperateLogIdentityDeviceType.MobilePhone);
    }
}
function startSC2(phone) {
    var content = "";
    try {
        //写入数据库日志
        content = "Log_BegHalfSigle_Success";
        var scactionX = document.getElementById("SCactionX");
        var reval = scactionX.StartSCall(phone);
        writeLog("oper", "[" + GetTextByName("SingleCALL(half)", useprameters.languagedata) + "]:" + GetTextByName("Lang_DispatchCallPanelBegHalfSingleCall", useprameters.languagedata) + "(ISSI:" + phone + ")" + "[" + LOGTimeGet() + "]");         /**日志：操作日志 多语言：单呼(半);调度台操作窗口开始半双工单呼**/
        if (reval == 1) {
            callPanalISSI = phone;
            window.parent.parent.delgrouparry(phone);

            //ifrs.restbackimg();
            document.getElementById("scrollarea").innerHTML = "";

            document.frames["mypancallContent"].document.frames["singlecallContent"].iscallissi = phone;
        }
        return reval;
    } catch (ex) {
        //写入数据库日志
        content = "Log_BegHalfSigle_Failed";
        writeLog("system", ex);
        return false;
    } finally {
        writeToDbByUserISSI(phone, OperateLogType.operlog, OperateLogModule.ModuleCall, OperateLogOperType.HalfDuplex, content, OperateLogIdentityDeviceType.MobilePhone);
    }
}
function startGC2(phone) {
    var content = "";
    try {
        content = "Log_BegGroupCall_Success";
        var scactionX = document.getElementById("SCactionX");
        var reval = scactionX.StartGCall(phone);
        writeLog("oper", "[" + GetTextByName("GroupCall", useprameters.languagedata) + "]:" + GetTextByName("Lang_DispatchCallPanelBegGroupCall", useprameters.languagedata) + "(GSSI:" + phone + ")" + "[" + LOGTimeGet() + "]");         /**日志：操作日志 多语言：组呼;调度台操作窗口开始组呼**/
        return reval;
    } catch (ex) {

        content = "Log_BegGroupCall_Failed";
        writeLog("system", ex);
        return false;
    }
    finally {
        writeToDbByUserISSI(phone, OperateLogType.operlog, OperateLogModule.ModuleCall, OperateLogOperType.GroupCall, content, OperateLogIdentityDeviceType.MobilePhone);
    }
}
function gceasedPTT2(phone) {
    try {
        var scactionX = document.getElementById("SCactionX");
        var reval = scactionX.GCEASEDPTT(phone);
        writeLog("oper", "[" + GetTextByName("GroupCall", useprameters.languagedata) + "]:" + GetTextByName("Lang_DispatchCallPanelGceasedPTT", useprameters.languagedata) + "(GSSI:" + phone + ")" + "[" + LOGTimeGet() + "]");         /**日志：操作日志 多语言：组呼;调度台操作窗口释放授权**/
        return reval;
    } catch (ex) {
        writeLog("system", ex);
        return false;
    }
}
function sceasedPTT2(phone) {
    try {
        var scactionX = document.getElementById("SCactionX");
        var reval = scactionX.SCEASEDPTT(phone);
        writeLog("oper", "[" + GetTextByName("GroupCall", useprameters.languagedata) + "]:" + GetTextByName("Lang_DispatchCallPanelSceasedPTT", useprameters.languagedata) + "(GSSI:" + phone + ")" + "[" + LOGTimeGet() + "]");         /**日志：操作日志 多语言：组呼;调度台操作窗口获取授权**/
        return reval;
    } catch (ex) {
        writeLog("system", ex);
        return false;
    }
}
function endDC2(phone) {
    var content = "";
    try {
        content = "Log_EndFullSigle_Success";

        var scactionX = document.getElementById("SCactionX");
        var reval = scactionX.EndDCall(phone);
        writeLog("oper", "[" + GetTextByName("SingleCALL(all)", useprameters.languagedata) + "]:" + GetTextByName("Lang_DispatchCallPanelEndAllSingleCall", useprameters.languagedata) + "(ISSI:" + phone + ")" + "[" + LOGTimeGet() + "]");         /**日志：操作日志 多语言：单呼(全);调度台操作窗口结束全双工单呼**/
        //writeLog("system", "操作：结束强插后的呼叫：" + phone + "|" + reval);
        if (reval == 1) {
            callPanalISSI = "";
        }
        return reval;
    } catch (ex) {
        content = "Log_EndFullSigle_Failed";
        writeLog("system", ex);
        return false;
    } finally {
        writeToDbByUserISSI(phone, OperateLogType.operlog, OperateLogModule.ModuleCall, OperateLogOperType.FullDuplex, content, OperateLogIdentityDeviceType.MobilePhone);
    }
}
function endGC2(phone) {
    var content = "";
    try {
        content = "Log_EndGroupCall_Success";
        var scactionX = document.getElementById("SCactionX");
        var reval = scactionX.ENDGCall(phone);
        return reval;
    } catch (ex) {
        content = "Log_EndGroupCall_Failed";
        writeLog("system", ex);
        return false;
    } finally {
        writeToDbByUserISSI(phone, OperateLogType.operlog, OperateLogModule.ModuleCall, OperateLogOperType.GroupCall, content, OperateLogIdentityDeviceType.MobilePhone);
    }
}
function endSC2(phone) {
    var content = "";
    try {
        content = "Log_EndHalfSigle_Success";
        var scactionX = document.getElementById("SCactionX");
        var reval = scactionX.ENDSCall(phone);
        writeLog("oper", "[" + GetTextByName("SingleCALL(half)", useprameters.languagedata) + "]:" + GetTextByName("Lang_DispatchCallPanelEndHalfSingleCall", useprameters.languagedata) + "(ISSI:" + phone + ")" + "[" + LOGTimeGet() + "]");         /**日志：操作日志 多语言：单呼(半);调度台操作窗口结束半双工单呼**/

        if (reval == 1) {
            callPanalISSI = "";
            document.frames["mypancallContent"].document.frames["singlecallContent"].iscallissi = "";
        }
        return reval;
    } catch (ex) {
        content = "Log_EndHalfSigle_Failed";
        writeLog("system", ex);
        return false;
    } finally {
        writeToDbByUserISSI(phone, OperateLogType.operlog, OperateLogModule.ModuleCall, OperateLogOperType.HalfDuplex, content, OperateLogIdentityDeviceType.MobilePhone);
    }
}
function endDC() {                                                                    /**全双工单呼结束**/
    var content = "";
    try {
        content = "Log_EndFullSigle_Success";
        var reval = 0;
        if (useprameters.SelectISSI && useprameters.SelectISSI.length == 1) {
            var scactionX = document.getElementById("SCactionX");
            reval = scactionX.EndDCall(useprameters.SelectISSI[0]);
            writeLog("oper", "[" + GetTextByName("SingleCALL(all)", useprameters.languagedata) + "]:" + GetTextByName("Lang_DispatchEndAllSingleCall", useprameters.languagedata) + "(ISSI:" + useprameters.SelectISSI[0] + ")" + "[" + LOGTimeGet() + "]");         /**日志：操作日志 多语言：单呼(全);调度台呼叫栏结束全双工单呼**/
        }
        return reval;
    } catch (ex) {
        content = "Log_EndFullSigle_Failed";
        writeLog("system", ex);
        return false;
    } finally {
        writeToDbByUserISSI(useprameters.SelectISSI[0], OperateLogType.operlog, OperateLogModule.ModuleCall, OperateLogOperType.FullDuplex, content, OperateLogIdentityDeviceType.MobilePhone);
    }
}
function startSC() {
    var content = "";
    /**发起单呼半双工**/
    try {
        if (useprameters.SelectISSI && useprameters.SelectISSI.length == 1) {
            content = "Log_BegHalfSigle_Success";
            var scactionX = document.getElementById("SCactionX");
            scactionX.StartSCall(useprameters.SelectISSI[0]);
            writeLog("oper", "[" + GetTextByName("SingleCALL(half)", useprameters.languagedata) + "]:" + GetTextByName("Lang_DispatchBegHalfSingleCall", useprameters.languagedata) + "(ISSI:" + useprameters.SelectISSI[0] + ")" + "[" + LOGTimeGet() + "]");         /**日志：操作日志 多语言:单呼(半);调度台呼叫栏开始半双工单呼**/

            document.frames["mypancallContent"].document.frames["singlecallContent"].iscallissi = useprameters.SelectISSI[0];
        }
    } catch (ex) {
        content = "Log_BegHalfSigle_Failed";
        writeLog("system", ex);
        return false;
    } finally {
        writeToDbByUserISSI(useprameters.SelectISSI[0], OperateLogType.operlog, OperateLogModule.ModuleCall, OperateLogOperType.HalfDuplex, content, OperateLogIdentityDeviceType.MobilePhone);
    }
}
function endSC() {                                                                      /**结束单呼半双工**/
    var content = "";
    try {
        if (useprameters.SelectISSI && useprameters.SelectISSI.length == 1) {
            content = "Log_EndHalfSigle_Success";
            var scactionX = document.getElementById("SCactionX");
            scactionX.ENDSCall(useprameters.SelectISSI[0]);
            writeLog("oper", "[" + GetTextByName("SingleCALL(half)", useprameters.languagedata) + "]:" + GetTextByName("Lang_DispatchEndHalfSingleCall", useprameters.languagedata) + "(ISSI:" + useprameters.SelectISSI[0] + ")" + "[" + LOGTimeGet() + "]");         /**日志：操作日志 多语言：单呼(半);调度台呼叫栏结束半双工单呼**/
            document.frames["mypancallContent"].document.frames["singlecallContent"].iscallissi = "";
        }
    } catch (ex) {
        content = "Log_EndHalfSigle_Failed";
        writeLog("system", ex);
        return false;
    } finally {
        writeToDbByUserISSI(useprameters.SelectISSI[0], OperateLogType.operlog, OperateLogModule.ModuleCall, OperateLogOperType.HalfDuplex, content, OperateLogIdentityDeviceType.MobilePhone);
    }
}
function sceasedPTT() {
    try {
        if (useprameters.SelectISSI && useprameters.SelectISSI.length == 1) {
            var scactionX = document.getElementById("SCactionX");
            scactionX.SCEASEDPTT(useprameters.SelectISSI[0]);
        }
    } catch (ex) {
        writeLog("system", ex);
        return false;
    }
}


function openGPSContralResultPage() {
    if (document.frames["GPSContral/ResultList_ifr"] != null || document.frames["GPSContral/ResultList_ifr"] != undefined) {
        document.frames["GPSContral/ResultList_ifr"].tohidclosebtn();
    } else {
        var height = 250;
        if (openCount > 0)
        { height += 50; }
        if (modelCount > 0)
        { height += 55; }
        if (scCount > 0)
        { height += 60; }
        if (distancCount > 0)
        { height += 65; }
        mycallfunction('GPSContral/ResultList', 450, height, 0, 2020);
    }
}

function clear_gpscontral_run() {
    isSendingGPSControl = false;
    clearInterval(sendgpscontrolInterval);
    if (document.frames["GPSContral/ResultList_ifr"] != null || document.frames["GPSContral/ResultList_ifr"] != undefined) {
        document.frames["GPSContral/ResultList_ifr"].toshowclosebtn();
    }
}


function toWriteOpenResult() {

    if (document.frames["GPSContral/ResultList_ifr"] != null || document.frames["GPSContral/ResultList_ifr"] != undefined) {
        if ((typeof document.frames["GPSContral/ResultList_ifr"].toHTML).toString() != "undefined") {
            document.frames["GPSContral/ResultList_ifr"].toHTML(totalGPScount, haddocount, issi_gps_isEnable, openCount, cgopen, sbopen, scCount, cgsc, sbsc, modelCount, cgmodel, sbmodel, distancCount, cgdistance, sbdistance);
        }
    }
}
var sendgpscontrolInterval;
var isSendingGPSControl = false;
var cgopen = new Array();
var sbopen = new Array();
var cgmodel = new Array();  //GPS模式切换成功
var sbmodel = new Array();  //GPS模式切换失败
var cgsc = new Array(); //GPS周期和目的地设置成功
var sbsc = new Array(); //GPS周期和目的地设置失败
var cgdistance = new Array();   //GPS距离上报设置成功
var sbdistance = new Array();   //GPS距离上报设置失败
var openCount = 0;  //GPS开关设置个数
var modelCount = 0; //GPS模式设置个数
var scCount = 0;    //GPS周期和目的地设置个数
var distancCount = 0;   //GPS距离上报设置个数
var totalGPScount = 0;

var haddocount = 0;
var allshoweddocount = 0;

var Terminal_type = 0;  //终端GPS上报模式
var issi_gps_isEnable = "1";  //对终端设置开启还是关闭GPS上报功能
//返回消息时也批量处理，每一个消息来时判断，isSendingGPSEnableOrDisable为false 开始写数据库，假如为true则存放到临时变量中，等到为false时批量处理//需要轮训去处理啦 要设置一个期限跟注册一样
//GPS涓婃姤浣胯兘淇敼
//isEnable  1表示开启，0表示关闭
function sendGPSControl(users, isEnable, times, destIssi, distance, model_type, switchToAll, cycleToAll) {
    cgopen.length = 0;
    sbopen.length = 0;
    cgsc.length = 0;
    sbsc.length = 0;
    cgdistance.length = 0;
    sbdistance.length = 0;
    cgmodel.length = 0;
    sbmodel.length = 0;
    openCount = 0;
    modelCount = 0;
    scCount = 0;
    distancCount = 0;
    totalGPScount = 0;
    var LTEUsers = new Array();
    LTEUsers.length = 0;
    var notLTEUsers = new Array();
    notLTEUsers.length = 0;
    issi_gps_isEnable = isEnable;
    totalGPScount = users.length;
    openGPSContralResultPage();
    for (var i = 0; i < users.length; i++) {
        if (users[i].issitype.trim() == "LTE") {
            openCount++;
            scCount++;
            LTEUsers.push(users[i]);
        } else {
            if (distance != "") {
                distancCount++;
            }
            if (switchToAll && isEnable != "-1")
            { openCount++; }
            if (cycleToAll && times != "")
            { scCount++; }
            notLTEUsers.push(users[i]);
        }
        if (users[i].issitype.trim() == "BEIDOU")
        { modelCount++; }
    }

    var scactionX = document.getElementById("SCactionX");
    isSendingGPSControl = true;
    try {
        var mi = 0;
        var padddate = setInterval(function () {
            if (mi < users.length) {
                if (mi < LTEUsers.length) {
                    var laset = LTEUsers.length;
                    if (parseFloat(mi) + 500 < parseFloat(laset)) {
                        laset = mi + 500
                    }
                    var sendGPSParamRequestissis = "";
                    for (var fim = mi; fim < laset; fim++) {
                        sendGPSParamRequestissis += LTEUsers[fim].uissi + ",-1;";
                    }
                    window.parent.jquerygetNewData_ajax_post("Handlers/AddGPSParam.ashx", { mtype: "add", cmd: "control", open: isEnable, sendGPSParamRequestissis: sendGPSParamRequestissis }, function (msg) { });
                    window.parent.jquerygetNewData_ajax_post("Handlers/AddGPSParam.ashx", { mtype: "add", cmd: "param", dest: "-1", cycle: times, sendGPSParamRequestissis: sendGPSParamRequestissis }, function (msg) { });
                    mi = laset;
                } else {
                    if (mi - LTEUsers.length < notLTEUsers.length) {
                        var laset = notLTEUsers.length;
                        if (parseFloat(mi - LTEUsers.length) + 500 < parseFloat(laset)) {
                            laset = mi - LTEUsers.length + 500
                        }
                        if (switchToAll) {
                            var sendGPSOpenRequestISSIs = "";
                            for (var fim = mi - LTEUsers.length ; fim < laset; fim++) {
                                sendGPSOpenRequestISSIs += notLTEUsers[fim].uissi + ",-1;";
                            }
                            window.parent.jquerygetNewData_ajax_post("Handlers/AddGPSParam.ashx", { mtype: "add", cmd: "control", open: isEnable, sendGPSParamRequestissis: sendGPSOpenRequestISSIs }, function (msg) { });
                        }
                        if (cycleToAll) {
                            var sendGPSOpenRequestISSIs = "";
                            for (var fim = mi - LTEUsers.length ; fim < laset; fim++) {
                                sendGPSOpenRequestISSIs += notLTEUsers[fim].uissi + ",-1;";
                            }
                            window.parent.jquerygetNewData_ajax_post("Handlers/AddGPSParam.ashx", { mtype: "add", cmd: "param", dest: destIssi, cycle: times, sendGPSParamRequestissis: sendGPSOpenRequestISSIs }, function (msg) { });
                        }
                        if (distance == 0) {
                            for (var fim = mi - LTEUsers.length ; fim < laset; fim++) {
                                if (users[fim].issitype.toString().trim() == "PDT") {
                                    var creatDistanceISSI = notLTEUsers[fim].uissi + ",-1;";
                                    window.parent.jquerygetNewData_ajax_post("Handlers/AddGPSParam.ashx", { mtype: "add", cmd: "distance", distance: distance, sendGPSParamRequestissis: creatDistanceISSI }, function (msg) { });
                                }
                            }
                        }
                        else if (distance > 0) {
                            var sendGPSDistanceRequestISSIs = "";
                            for (var fim = mi - LTEUsers.length ; fim < laset; fim++) {
                                sendGPSDistanceRequestISSIs += notLTEUsers[fim].uissi + ",-1;";
                            }
                            window.parent.jquerygetNewData_ajax_post("Handlers/AddGPSParam.ashx", { mtype: "add", cmd: "distance", distance: distance, sendGPSParamRequestissis: sendGPSDistanceRequestISSIs }, function (msg) { });
                        }
                        for (var fim = mi - LTEUsers.length ; fim < laset; fim++) {
                            if (users[fim].issitype.toString().trim() == "BEIDOU") {
                                var creatModeISSI = notLTEUsers[fim].uissi + ",-1;";
                                window.parent.jquerygetNewData_ajax_post("Handlers/AddGPSParam.ashx", { mtype: "add", cmd: "mode", mode: Terminal_type, sendGPSParamRequestissis: creatModeISSI }, function (msg) { });
                            }
                        }
                        mi = mi + 500;
                    }
                }
            }
            else {
                clearInterval(padddate);
            }
        }, 1000)

        var i = 0;
        var issitypeID = 0;
        var hasDoIssiOpen = 0;
        var hasDoIssiPara = 0;
        var hasDoIssiModel = 0;
        var hasDoIssiDistance = 0;
        sendgpscontrolInterval = setInterval(function () {
            if (i < users.length) {
                if (users[i].issitype.trim() == "LTE") {
                    if (hasDoIssiOpen != users[i].uissi) {
                        try {
                            var retVar = scactionX.SendModifyGpsInterval(1, users[i].uissi, times, isEnable, 0, "");
                            if (retVar == 1) {
                                if (isEnable.toString() == "1") {
                                    content = "Log_GPS_Open_Success";
                                } else {
                                    content = "Log_GPS_Close_Success";
                                }
                                writeToDbByUserISSI(users[i].uissi, OperateLogType.operlog, OperateLogModule.ModuleGPS, OperateLogOperType.GPSOpen, content, OperateLogIdentityDeviceType.MobilePhone);
                                var par = "Lang_GPSCritical:" + times;
                                content = "Log_GPS_ParamEdit_Success;" + par;
                                writeToDbByUserISSI(users[i].uissi, OperateLogType.operlog, OperateLogModule.ModuleGPS, OperateLogOperType.GPSParamsEdit, content, OperateLogIdentityDeviceType.MobilePhone);
                            } else {
                                if (isEnable.toString() == "1") {
                                    content = "Log_GPS_Open_Failed";
                                } else {
                                    content = "Log_GPS_Close_Failed";
                                }
                                writeToDbByUserISSI(users[i].uissi, OperateLogType.operlog, OperateLogModule.ModuleGPS, OperateLogOperType.GPSOpen, content, OperateLogIdentityDeviceType.MobilePhone);
                                writeLog("system", Lang_GPS_Open_ContralFaild + ":" + users[i].uissi + ";");
                                var par = "Lang_GPSCritical:" + times;
                                content = "Log_GPS_ParamEdit_Failed;" + par;
                                writeLog("system", Lang_GPS_Param_ContralFaild + ":" + users[i].uissi + ";");
                                writeToDbByUserISSI(users[i].uissi, OperateLogType.operlog, OperateLogModule.ModuleGPS, OperateLogOperType.GPSParamsEdit, content, OperateLogIdentityDeviceType.MobilePhone);
                            }
                        } catch (ex) {
                            sbopen.push(users[i].uissi);
                            if (isEnable.toString() == "1") {
                                content = "Log_GPS_Open_Failed";
                            } else {
                                content = "Log_GPS_Close_Failed";
                            }
                            writeToDbByUserISSI(users[i].uissi, OperateLogType.operlog, OperateLogModule.ModuleGPS, OperateLogOperType.GPSOpen, content, OperateLogIdentityDeviceType.MobilePhone);
                            writeLog("system", Lang_GPS_Open_ContralFaild + ":" + users[i].uissi + ";");

                            sbsc.push(users[i].uissi);
                            //var par = "Lang_GPSCritical:" + mytime + ";Lang_GPSDest:" + ip + "....." + port;
                            var par = "Lang_GPSCritical:" + times;
                            content = "Log_GPS_ParamEdit_Failed;" + par;
                            writeLog("system", Lang_GPS_Param_ContralFaild + ":" + users[i].uissi + ";");
                            writeToDbByUserISSI(users[i].uissi, OperateLogType.operlog, OperateLogModule.ModuleGPS, OperateLogOperType.GPSParamsEdit, content, OperateLogIdentityDeviceType.MobilePhone);

                            var members = users[i].uissi + ",0;";
                            window.parent.jquerygetNewData_ajax("Handlers/AddGPSParam.ashx", { mtype: "update", cmd: "param", dest: destIssi, cycle: times, sendGPSParamRequestissis: members }, function (msg) {
                            });
                        } finally {
                            toWriteOpenResult();
                            if (i < users.length) {

                                haddocount++;
                            }
                            hasDoIssiOpen = users[i].uissi;
                            i++;
                        }
                    } else { hasDoIssiOpen = users[i].uissi; }
                } else {    //非LTE用户
                    if (switchToAll && isEnable != "-1" && hasDoIssiOpen != users[i].uissi)    //使能开关
                    {
                        try {
                            if (users[i].issitype.toString().trim() == "TETRA" || users[i].issitype.toString().trim() == "PDT") {
                                var retVar = scactionX.SendGPSEnableorDisableRequest(users[i].uissi, isEnable);
                            } else if (users[i].issitype.toString().trim() == "BEIDOU") {
                                if (isEnable.toString() == "1") {
                                    var retVar = scactionX.SendLocationReportingEnableDisableRequestForMultiType(3, users[i].uissi.toString(), 128, "");
                                } else {
                                    var retVar = scactionX.SendLocationReportingEnableDisableRequestForMultiType(3, users[i].uissi.toString(), 0, "");
                                }
                            }
                            if (isEnable.toString() == "1") {
                                content = "Log_GPS_Open_Success";
                            } else {
                                content = "Log_GPS_Close_Success";
                            }
                        } catch (ex) {
                            sbopen.push(users[i].uissi);
                            if (isEnable.toString() == "1") {
                                content = "Log_GPS_Open_Failed";
                            } else {
                                content = "Log_GPS_Close_Failed";
                            }
                            writeLog("system", Lang_GPS_Open_ContralFaild + ":" + users[i].uissi + ";");

                        } finally {
                            toWriteOpenResult()
                            writeToDbByUserISSI(users[i].uissi, OperateLogType.operlog, OperateLogModule.ModuleGPS, OperateLogOperType.GPSOpen, content, OperateLogIdentityDeviceType.MobilePhone);
                            hasDoIssiOpen = users[i].uissi;
                        }
                    } else { hasDoIssiOpen = users[i].uissi; }
                    if (cycleToAll && times != "")     //周期和目的地
                    {
                        var setPara = setInterval(function () {
                            if (!users || !users[i] || hasDoIssiPara == users[i].uissi)
                            { return; }
                            try {
                                var par = "";
                                if (destIssi == "") {
                                    destIssi = 16777213;
                                    par = "Lang_GPSCritical:" + times + ";Lang_GPSDest:" + "-1";
                                } else {
                                    par = "Lang_GPSCritical:" + times + ";Lang_GPSDest:" + destIssi;
                                }
                                content = "Log_GPS_ParamEdit_Success;" + par;
                                if (users[i].issitype.toString().trim() == "TETRA") {
                                    var retVar = scactionX.SendSetGPSParamRequest(users[i].uissi, parseFloat(times), parseFloat(destIssi));
                                } else if (users[i].issitype.toString().trim() == "PDT") {
                                    var retVar = scactionX.SendBasicLocationParametersRequestforPDT(users[i].uissi, parseFloat(times), 3, parseFloat(destIssi));
                                }
                                else if (users[i].issitype.toString().trim() == "BEIDOU") {
                                    var retVar = scactionX.SendBasicLocationParametersRequestForMultiType(3, users[i].uissi, times, 3, destIssi, "");
                                }
                            } catch (ex) {//溢出
                                sbsc.push(users[i].uissi);
                                content = "Log_GPS_ParamEdit_Failed;" + par;
                                writeLog("system", Lang_GPS_Param_ContralFaild + ":" + users[i].uissi + ";");
                                var members = users[i].uissi + ",0;";
                                window.parent.jquerygetNewData_ajax("Handlers/AddGPSParam.ashx", { mtype: "update", cmd: "param", dest: destIssi, cycle: times, sendGPSParamRequestissis: members }, function (msg) {
                                });
                            } finally {
                                writeToDbByUserISSI(users[i].uissi, OperateLogType.operlog, OperateLogModule.ModuleGPS, OperateLogOperType.GPSParamsEdit, content, OperateLogIdentityDeviceType.MobilePhone);
                                toWriteOpenResult();
                                hasDoIssiPara = users[i].uissi;
                            }
                            clearInterval(setPara);
                        }, 200);
                    } else { hasDoIssiPara = users[i].uissi; }
                    if (distance != "" && distance == 0 && users[i].issitype.toString().trim() == "PDT") {    //设置PDT距离为0上报方式
                        var setDistancePDT = setInterval(function () {
                            if (!users || !users[i] || hasDoIssiDistance == users[i].uissi)
                            { return; }
                            var par = "Lang_GPSDistance:" + distance;
                            try {
                                content = "Log_GPS_DistanceEdit_Success;" + par;
                                var retVar = scactionX.SendAddorModifyParametersRequestForDistance(users[i].uissi, distance);
                            } catch (ex) {//溢出
                                sbdistance.push(users[i].uissi);
                                content = "Log_GPS_DistanceEdit_Failed;" + par;
                                writeLog("system", Lang_GPS_Param_ContralFaild + ":" + users[i].uissi + ";");
                                var members = users[i].uissi + ",0;";
                                window.parent.jquerygetNewData_ajax("Handlers/AddGPSParam.ashx", { mtype: "update", cmd: "distance", distance: distance, sendGPSParamRequestissis: members }, function (msg) {
                                });
                            } finally {
                                writeToDbByUserISSI(users[i].uissi, OperateLogType.operlog, OperateLogModule.ModuleGPS, OperateLogOperType.GPSDistanceEdit, content, OperateLogIdentityDeviceType.MobilePhone);
                                toWriteOpenResult();
                                hasDoIssiDistance = users[i].uissi;
                            }
                            clearInterval(setDistancePDT);
                        }, 400);
                    } else if (distance > 0) {  //设置距离大于0时的上报
                        var setDistance = setInterval(function () {
                            if (!users || !users[i] || hasDoIssiDistance == users[i].uissi)
                            { return; }
                            var par = "Lang_GPSDistance:" + distance;
                            try {
                                content = "Log_GPS_DistanceEdit_Success;" + par;
                                var retVar = scactionX.SendAddorModifyParametersRequestForDistance(users[i].uissi, distance);
                            } catch (ex) {//溢出
                                sbdistance.push(users[i].uissi);
                                content = "Log_GPS_DistanceEdit_Failed;" + par;
                                writeLog("system", Lang_GPS_Param_ContralFaild + ":" + users[i].uissi + ";");
                                var members = users[i].uissi + ",0;";
                                window.parent.jquerygetNewData_ajax("Handlers/AddGPSParam.ashx", { mtype: "update", cmd: "distance", distance: distance, sendGPSParamRequestissis: members }, function (msg) {
                                });
                            } finally {
                                writeToDbByUserISSI(users[i].uissi, OperateLogType.operlog, OperateLogModule.ModuleGPS, OperateLogOperType.GPSDistanceEdit, content, OperateLogIdentityDeviceType.MobilePhone);
                                toWriteOpenResult();
                                hasDoIssiDistance = users[i].uissi;
                            }
                            clearInterval(setDistance);
                        }, 400);
                    } else { hasDoIssiDistance = users[i].uissi; }
                    if (model_type != "-1" && users[i].issitype == "BEIDOU") {  //设置BEIDOU上报模式
                        var setModel = setInterval(function () {
                            if (!users || !users[i] || hasDoIssiModel == users[i].uissi)
                            { return; }
                            var par = "";
                            if (model_type == 1) {
                                par = "BEIDOU";
                            } else if (model_type == 2) {
                                par = "GPS";
                            } else if (model_type == 3) {
                                par = "Lang_GPSandBEIDOU_Model";
                            }
                            try {
                                content = "Log_GPS_ModeEdit_Success;" + par;
                                var retvar = scactionX.SendLocationReportingEnableDisableRequestForMultiType(3, users[i].uissi, Terminal_type, "");
                            } catch (ex) {
                                sbmodel.push(users[i].uissi);
                                content = "Lang_GPS_mode_Failed;" + par;
                                writeLog("system", Lang_GPS_Mode_ContralFaild + ":" + users[i].uissi + ";");
                                var members = users[i].uissi + ",0;";
                                window.parent.jquerygetNewData_ajax("Handlers/AddGPSParam.ashx", { mtype: "update", cmd: "mode", mode: Terminal_type, sendGPSParamRequestissis: members }, function (msg) {
                                });
                            } finally {
                                writeToDbByUserISSI(users[i].uissi, OperateLogType.operlog, OperateLogModule.ModuleGPS, OperateLogOperType.GPSModeEdit, content, OperateLogIdentityDeviceType.MobilePhone);
                                toWriteOpenResult();
                                hasDoIssiModel = users[i].uissi;
                            }
                            var setiNum = setInterval(function () {
                                if (hasDoIssiModel == users[i].uissi && hasDoIssiDistance == users[i].uissi && hasDoIssiOpen == users[i].uissi && hasDoIssiPara == users[i].uissi) {
                                    if (i < users.length) {
                                        haddocount++;
                                    }
                                    i++;
                                    clearInterval(setiNum);
                                }
                            }, 100);
                            clearInterval(setModel);
                        }, 700);
                    } else { hasDoIssiModel = users[i].uissi; }
                }
                var checkInfo = setInterval(function () {
                    if (i >= users.length) {
                        clearInterval(checkInfo);
                        return;
                    }
                    if (hasDoIssiModel == users[i].uissi && hasDoIssiDistance == users[i].uissi && hasDoIssiOpen == users[i].uissi && hasDoIssiPara == users[i].uissi) {
                        if (i < users.length) {
                            haddocount++;
                        }
                        i++;
                        if (i >= users.length) {
                            clearInterval(checkInfo);
                            return;
                        }
                    }
                }, 100);
            } else {
                writeLog("system", GetTextByName("Lang_SendGPSControlFinished", useprameters.languagedata))//你发起的GPS上报开关指令执行完毕
                clear_gpscontral_run();
            }
        }, gpsControlSendSpace);
    } catch (exc) {
        clear_gpscontral_run();
    }
}

//function sendGPSControlOld(users, isEnable, times, destIssi, ip, port, model_type) {
//    cgopen.length = 0;
//    sbopen.length = 0;
//    cgsc.length = 0;
//    sbsc.length = 0;
//    cgmodel.length = 0;
//    sbmodel.length = 0;
//    lastMbzq = times;
//    LastMbdz = destIssi;
//    allshoweddocount = users.length;
//    haddocount = 0;
//    issi_gps_isEnable = isEnable.toString();
//    var mydestissi = new Number(destIssi);
//    var mytime = new Number(times);
//    var userscount = users.length;

//    openGPSContralResultPage();
//    var scactionX = document.getElementById("SCactionX");
//    isSendingGPSControl = true;
//    for (var i = 0; i < users.length; i++) {
//        if (users[i].issitype.toString().trim() != "BEIDOU") {
//            cgmodel.push(users[i].uissi);
//        }
//    }
//    if (model_type == 1) {
//        Terminal_type = 1;  //北斗
//    } else if (model_type == 2) {
//        Terminal_type = 3;  //GPS
//    } else if (model_type == 3) {
//        Terminal_type = 7;  //双模
//    }
//    try {
//        var mi = 0;
//        var padddate = setInterval(function () {
//            if (mi < users.length) {
//                var laset = users.length;
//                if (parseFloat(mi) + 500 < parseFloat(laset)) {
//                    laset = mi + 500
//                }
//                var sendGPSParamRequestissis = "";
//                for (var fim = mi; fim < laset; fim++) {
//                    sendGPSParamRequestissis += users[fim].uissi + ",-1;";
//                }
//                window.parent.jquerygetNewData_ajax_post("Handlers/AddGPSParam.ashx", { mtype: "add", cmd: "control", open: isEnable, sendGPSParamRequestissis: sendGPSParamRequestissis }, function (msg) {
//                });
//                //window.parent.jquerygetNewData_ajax_post("Handlers/AddGPSParam.ashx", { mtype: "add", cmd: "param", dest: destIssi, cycle: times, sendGPSParamRequestissis: sendGPSParamRequestissis }, function (msg) {
//                //});
//                for (var fim = mi; fim < laset; fim++) {
//                    if (users[fim].issitype.toString().trim() == "BEIDOU") {
//                        var creatModeISSI = users[fim].uissi + ",-1;";
//                        window.parent.jquerygetNewData_ajax_post("Handlers/AddGPSParam.ashx", { mtype: "add", cmd: "mode", mode: Terminal_type, sendGPSParamRequestissis: creatModeISSI }, function (msg) {
//                        });

//                        window.parent.jquerygetNewData_ajax_post("Handlers/AddGPSParam.ashx", { mtype: "add", cmd: "param", dest: destIssi, cycle: times, sendGPSParamRequestissis: creatModeISSI }, function (msg) {
//                        });
//                    } else if (users[fim].issitype.toString().trim() == "LTE") {
//                        var creatModeISSI = users[fim].uissi + ",1;";
//                        window.parent.jquerygetNewData_ajax_post("Handlers/AddGPSParam.ashx", { mtype: "add", cmd: "mode", mode: 3, sendGPSParamRequestissis: creatModeISSI }, function (msg) {
//                        });
//                        creatModeISSI = users[fim].uissi + ",-1;";
//                        window.parent.jquerygetNewData_ajax_post("Handlers/AddGPSParam.ashx", { mtype: "add", cmd: "param", dest: "", cycle: times, sendGPSParamRequestissis: creatModeISSI }, function (msg) {
//                        });
//                    } else {
//                        var creatModeISSI = users[fim].uissi + ",1;";
//                        window.parent.jquerygetNewData_ajax_post("Handlers/AddGPSParam.ashx", { mtype: "add", cmd: "mode", mode: 3, sendGPSParamRequestissis: creatModeISSI }, function (msg) {
//                        });
//                        creatModeISSI = users[fim].uissi + ",-1;";
//                        window.parent.jquerygetNewData_ajax_post("Handlers/AddGPSParam.ashx", { mtype: "add", cmd: "param", dest: destIssi, cycle: times, sendGPSParamRequestissis: creatModeISSI }, function (msg) {
//                        });
//                        //window.parent.jquerygetNewData_ajax_post("Handlers/AddGPSParam.ashx", { mtype: "update", cmd: "mode", mode: 3, sendGPSParamRequestissis: creatModeISSI }, function (msg) {
//                        //});
//                    }
//                }
//                mi += 500;
//            } else {
//                clearInterval(padddate);
//            }
//        }, 1000)

//        var i = 0;
//        var issitypeID = 0;
//        var hasDoIssiOpen = 0;
//        var hasDoIssiPara = 0;
//        var hasDoIssiModel = 0;
//        sendgpscontrolInterval = setInterval(function () {
//            if (i < userscount) {
//                var content = "";
//                if (users[i].issitype.toString().trim() == "TETRA") {
//                    issitypeID = 1;
//                } else if (users[i].issitype.toString().trim() == "PDT") {
//                    issitypeID = 2;
//                } else if (users[i].issitype.toString().trim() == "BEIDOU") {
//                    issitypeID = 3;
//                } else if (users[i].issitype.toString().trim() == "LTE") {
//                    issitypeID = 4;
//                } else {
//                    isSendingGPSControl = false;
//                    return;
//                }
//                if (issitypeID == 4) {
//                    if (hasDoIssiOpen != users[i].uissi) {
//                        try {
//                            var retVar = scactionX.SendModifyGpsInterval(1, users[i].uissi, mytime, isEnable, 0, "");
//                            if (retVar == 1) {
//                                if (isEnable.toString() == "1") {
//                                    content = "Log_GPS_Open_Success";
//                                } else {
//                                    content = "Log_GPS_Close_Success";
//                                }
//                                writeToDbByUserISSI(users[i].uissi, OperateLogType.operlog, OperateLogModule.ModuleGPS, OperateLogOperType.GPSOpen, content, OperateLogIdentityDeviceType.MobilePhone);

//                                //var par = "Lang_GPSCritical:" + mytime + ";Lang_GPSDest:" + ip + "....." + port;
//                                var par = "Lang_GPSCritical:" + mytime;
//                                content = "Log_GPS_ParamEdit_Success;" + par;
//                                writeToDbByUserISSI(users[i].uissi, OperateLogType.operlog, OperateLogModule.ModuleGPS, OperateLogOperType.GPSParamsEdit, content, OperateLogIdentityDeviceType.MobilePhone);


//                            } else {
//                                if (isEnable.toString() == "1") {
//                                    content = "Log_GPS_Open_Failed";
//                                } else {
//                                    content = "Log_GPS_Close_Failed";
//                                }
//                                writeToDbByUserISSI(users[i].uissi, OperateLogType.operlog, OperateLogModule.ModuleGPS, OperateLogOperType.GPSOpen, content, OperateLogIdentityDeviceType.MobilePhone);
//                                writeLog("system", Lang_GPS_Open_ContralFaild + ":" + users[i].uissi + ";");

//                                //var par = "Lang_GPSCritical:" + mytime + ";Lang_GPSDest:" + ip + "....." + port;
//                                var par = "Lang_GPSCritical:" + mytime;
//                                content = "Log_GPS_ParamEdit_Failed;" + par;
//                                writeLog("system", Lang_GPS_Param_ContralFaild + ":" + users[i].uissi + ";");
//                                writeToDbByUserISSI(users[i].uissi, OperateLogType.operlog, OperateLogModule.ModuleGPS, OperateLogOperType.GPSParamsEdit, content, OperateLogIdentityDeviceType.MobilePhone);

//                            }
//                        } catch (ex) {
//                            sbopen.push(users[i].uissi);
//                            if (isEnable.toString() == "1") {
//                                content = "Log_GPS_Open_Failed";
//                            } else {
//                                content = "Log_GPS_Close_Failed";
//                            }
//                            writeToDbByUserISSI(users[i].uissi, OperateLogType.operlog, OperateLogModule.ModuleGPS, OperateLogOperType.GPSOpen, content, OperateLogIdentityDeviceType.MobilePhone);
//                            writeLog("system", Lang_GPS_Open_ContralFaild + ":" + users[i].uissi + ";");

//                            sbsc.push(users[i].uissi);
//                            //var par = "Lang_GPSCritical:" + mytime + ";Lang_GPSDest:" + ip + "....." + port;
//                            var par = "Lang_GPSCritical:" + mytime;
//                            content = "Log_GPS_ParamEdit_Failed;" + par;
//                            writeLog("system", Lang_GPS_Param_ContralFaild + ":" + users[i].uissi + ";");
//                            writeToDbByUserISSI(users[i].uissi, OperateLogType.operlog, OperateLogModule.ModuleGPS, OperateLogOperType.GPSParamsEdit, content, OperateLogIdentityDeviceType.MobilePhone);

//                        } finally {
//                            toWriteOpenResult(userscount, i);
//                            if (i < userscount - 1) {

//                                haddocount++;
//                            }
//                            hasDoIssiOpen = users[i].uissi;
//                            i++;
//                        }
//                    }
//                } else {
//                    if (hasDoIssiOpen != users[i].uissi) {
//                        try {
//                            if (issitypeID == 1 || issitypeID == 2) {
//                                var retVar = scactionX.SendGPSEnableorDisableRequest(users[i].uissi, isEnable);
//                            } else if (issitypeID == 3) {
//                                if (isEnable.toString() == "1") {
//                                    var retVar = scactionX.SendLocationReportingEnableDisableRequestForMultiType(3, users[i].uissi.toString(), 128, "");
//                                } else {
//                                    var retVar = scactionX.SendLocationReportingEnableDisableRequestForMultiType(3, users[i].uissi.toString(), 0, "");
//                                }
//                            }
//                            if (isEnable.toString() == "1") {
//                                content = "Log_GPS_Open_Success";
//                            } else {
//                                content = "Log_GPS_Close_Success";
//                            }
//                        } catch (ex) {
//                            sbopen.push(users[i].uissi);
//                            if (isEnable.toString() == "1") {
//                                content = "Log_GPS_Open_Failed";
//                            } else {
//                                content = "Log_GPS_Close_Failed";
//                            }
//                            writeLog("system", Lang_GPS_Open_ContralFaild + ":" + users[i].uissi + ";");

//                        } finally {
//                            toWriteOpenResult(userscount, i)
//                            writeToDbByUserISSI(users[i].uissi, OperateLogType.operlog, OperateLogModule.ModuleGPS, OperateLogOperType.GPSOpen, content, OperateLogIdentityDeviceType.MobilePhone);
//                            hasDoIssiOpen = users[i].uissi;
//                        }
//                        var setPara = setTimeout(function () {
//                            if (hasDoIssiPara != users[i].uissi) {
//                                try {
//                                    var par = "Lang_GPSCritical:" + mytime + ";Lang_GPSDest:" + mydestissi;
//                                    content = "Log_GPS_ParamEdit_Success;" + par;
//                                    if (issitypeID == 1 || issitypeID == 2) {
//                                        if (issiType == '0') {//moto
//                                            var retVar = scactionX.SendSetGPSParamRequest(users[i].uissi, parseFloat(mytime), parseFloat(mydestissi));
//                                        } else if (issiType == '1') {//sepuer
//                                            if (destIssi != "-1") {
//                                                scactionX.SendSetGPSParamRequest(users[i].uissi, '-1', parseFloat(mydestissi));
//                                            }
//                                            var retVar = scactionX.SendGPSAddorModifyMaxReportIntervalRequest(users[i].uissi, parseFloat(mytime));
//                                        }
//                                    } else if (issitypeID == 3) {
//                                        var retVar = scactionX.SendBasicLocationParametersRequestForMultiType(3, users[i].uissi, mytime, 3, mydestissi, "");
//                                    }
//                                } catch (ex) {//溢出
//                                    sbsc.push(users[i].uissi);
//                                    content = "Log_GPS_ParamEdit_Failed;" + par;
//                                    writeLog("system", Lang_GPS_Param_ContralFaild + ":" + users[i].uissi + ";");
//                                    var members = users[i].uissi + ",0;";
//                                    window.parent.jquerygetNewData_ajax("Handlers/AddGPSParam.ashx", { mtype: "update", cmd: "param", dest: mydestissi, cycle: mytime, sendGPSParamRequestissis: members }, function (msg) {
//                                    });
//                                } finally {
//                                    writeToDbByUserISSI(users[i].uissi, OperateLogType.operlog, OperateLogModule.ModuleGPS, OperateLogOperType.GPSParamsEdit, content, OperateLogIdentityDeviceType.MobilePhone);
//                                    toWriteOpenResult(userscount, i);
//                                    hasDoIssiPara = users[i].uissi;
//                                }
//                                if (Terminal_type != 0 && users[i].issitype.toString().trim() == "BEIDOU") {
//                                    var setModel = setTimeout(function () {
//                                        if (hasDoIssiModel != users[i].uissi) {
//                                            var par = "";
//                                            if (model_type == 1) {
//                                                par = "BEIDOU";
//                                            } else if (model_type == 2) {
//                                                par = "GPS";
//                                            } else if (model_type == 3) {
//                                                par = "Lang_GPSandBEIDOU_Model";
//                                            }
//                                            try {
//                                                content = "Log_GPS_ModeEdit_Success;" + par;
//                                                var retvar = scactionX.SendLocationReportingEnableDisableRequestForMultiType(3, users[i].uissi, Terminal_type, "");
//                                            } catch (ex) {
//                                                sbmodel.push(users[i].uissi);
//                                                content = "Lang_GPS_mode_Failed;" + par;
//                                                writeLog("system", Lang_GPS_Mode_ContralFaild + ":" + users[i].uissi + ";");
//                                                var members = users[i].uissi + ",0;";
//                                                window.parent.jquerygetNewData_ajax("Handlers/AddGPSParam.ashx", { mtype: "update", cmd: "mode", mode: Terminal_type, sendGPSParamRequestissis: members }, function (msg) {
//                                                });
//                                            } finally {
//                                                writeToDbByUserISSI(users[i].uissi, OperateLogType.operlog, OperateLogModule.ModuleGPS, OperateLogOperType.GPSModeEdit, content, OperateLogIdentityDeviceType.MobilePhone);
//                                                toWriteOpenResult(userscount, i);
//                                                hasDoIssiModel = users[i].uissi;
//                                            }
//                                            if (i < userscount - 1) {

//                                                haddocount++;
//                                            }
//                                            i++;
//                                            clearTimeout(setModel);
//                                        }
//                                    }, 300);
//                                } else {
//                                    if (i < userscount - 1) {
//                                        haddocount++;
//                                    }
//                                    i++;
//                                }
//                                clearTimeout(setPara);
//                            }
//                        }, 500);
//                    }
//                }
//            } else {
//                writeLog("system", GetTextByName("Lang_SendGPSControlFinished", useprameters.languagedata))//你发起的GPS上报开关指令执行完毕
//                clear_gpscontral_run();
//            }
//        }, gpsControlSendSpace);
//    } catch (exc) {
//        isSendingGPSControl = false;
//    }
//}


function openGPSContralSCResultPage() {
    if (document.frames["GPSContral/ResultListSC_ifr"] != null || document.frames["GPSContral/ResultListSC_ifr"] != undefined) {
        document.frames["GPSContral/ResultListSC_ifr"].tohidclosebtn();
    } else {
        mycallfunction('GPSContral/ResultListSC', 450, 250);
    }
}

var lastMbzq = "";
var LastMbdz = "";

var sendgpsenableOrDisableArray = "";
var isdoP = false;
var mys = "";
var mys2 = "";
var sendgpsendparamArray = "";
var isdoP2 = false;

function GPSMsg(ISSI, resultCode, ctypeResponse) {
    //GPS上报开关
    //cgopen.length = 0;
    if (ctypeResponse == "GPS_LOCATION_REPORTING_ENABLE_DISABLE_RESPONSE")  //GPS使能开口
    {
        var statues = "";
        if (resultCode.toString() == "0") {//关闭成功
            statues = strClosebtn;
            cgopen.push(ISSI);
        } else if (resultCode.toString() == "1") {//开启成功
            statues = strSingle_Open;
            cgopen.push(ISSI);
        } else { statues = strFailed; sbopen.push(ISSI); }
        writeLog("system", strGPSOpen + ":" + ISSI + "(" + statues + ")");//写日志
        sendgpsenableOrDisableArray = ISSI + "," + resultCode + ";";
        window.parent.jquerygetNewData_ajax_post("Handlers/AddGPSParam.ashx", { mtype: "update", cmd: "control", open: resultCode, sendGPSParamRequestissis: sendgpsenableOrDisableArray }, function (msg) {
        });
        toWriteOpenResult()
    } else if (ctypeResponse == "GPS_BASIC_LOCATION_PARAMETERS_RESPONSE") {   //修改GPS时间间隔和目的地
        var statues = "";
        if (resultCode.toString() == "0") {
            statues = strFailed;
            sbsc.push(ISSI);
        } else if (resultCode.toString() == "1") {
            statues = strSuccess;
            cgsc.push(ISSI);
        }
        writeLog("system", strGPSParam + ":" + ISSI + "(" + statues + ")");//写日志
        sendgpsendparamArray = ISSI + "," + resultCode + ";";
        window.parent.jquerygetNewData_ajax_post("Handlers/AddGPSParam.ashx", { mtype: "update", cmd: "param", dest: '', cycle: '', sendGPSParamRequestissis: sendgpsendparamArray }, function (msg) {
        });
        toWriteOpenResult();
    } else if (ctypeResponse == "GPS_LOCATION_REPORTING_MODE_BEIDOU_RESPONSE") {//设置为北斗模式，resultCode 1表示使能 
        var statues = "";
        if (resultCode.toString() == "0") {
            statues = strFailed;
            sbmodel.push(ISSI);
            sendgpsendparamArray = ISSI + "," + resultCode + ";";
        } else if (resultCode.toString() == "1") {
            statues = strSuccess;
            cgmodel.push(ISSI);
            sendgpsendparamArray = ISSI + "," + 1 + ";";
        }
        writeLog("system", strGPSMode + ":" + ISSI + "(" + statues + ")");//写日志

        window.parent.jquerygetNewData_ajax_post("Handlers/AddGPSParam.ashx", { mtype: "update", cmd: "mode", mode: Terminal_type, sendGPSParamRequestissis: sendgpsendparamArray }, function (msg) {
        });
        toWriteOpenResult();
    } else if (ctypeResponse == "GPS_LOCATION_REPORTING_MODE_GPS_RESPONSE") {//设置为GPS模式，resultCode 3表示使能 
        var statues = "";
        if (resultCode.toString() == "0") {
            statues = strFailed;
            sbmodel.push(ISSI);
            sendgpsendparamArray = ISSI + "," + resultCode + ";";
        } else if (resultCode.toString() == "3") {
            statues = strSuccess;
            cgmodel.push(ISSI);
            sendgpsendparamArray = ISSI + "," + 1 + ";";
        }
        writeLog("system", strGPSMode + ":" + ISSI + "(" + statues + ")");//写日志

        window.parent.jquerygetNewData_ajax_post("Handlers/AddGPSParam.ashx", { mtype: "update", cmd: "mode", mode: Terminal_type, sendGPSParamRequestissis: sendgpsendparamArray }, function (msg) {
        });
        toWriteOpenResult();
    } else if (ctypeResponse == "GPS_LOCATION_REPORTING_MODE_DOUBLE_RESPONSE") {//设置为GPS和北斗双模模式，resultCode 7表示使能 
        var statues = "";
        if (resultCode.toString() == "0") {
            statues = strFailed;
            sbmodel.push(ISSI);
            sendgpsendparamArray = ISSI + "," + resultCode + ";";
        } else if (resultCode.toString() == "7") {
            statues = strSuccess;
            cgmodel.push(ISSI);
            sendgpsendparamArray = ISSI + "," + 1 + ";";
        }
        writeLog("system", strGPSMode + ":" + ISSI + "(" + statues + ")");//写日志

        window.parent.jquerygetNewData_ajax_post("Handlers/AddGPSParam.ashx", { mtype: "update", cmd: "mode", mode: Terminal_type, sendGPSParamRequestissis: sendgpsendparamArray }, function (msg) {
        });
        toWriteOpenResult();
    } else if (ctypeResponse == "LTE_GPS_SET_PARAM_ACK") {
        var statues = "";
        if (resultCode.toString() == "FAIL") {
            statues = strFailed;
            sendgpsendparamArray = ISSI + "," + 0 + ";";

            writeLog("system", strGPSOpen + ":" + ISSI + "(" + statues + ")");//写日志
            sbopen.push(ISSI);
            sendgpsenableOrDisableArray = ISSI + "," + 0 + ";";
            window.parent.jquerygetNewData_ajax_post("Handlers/AddGPSParam.ashx", { mtype: "update", cmd: "control", open: 0, sendGPSParamRequestissis: sendgpsenableOrDisableArray }, function (msg) {
            });


            sbsc.push(ISSI);
            writeLog("system", strGPSParam + ":" + ISSI + "(" + statues + ")");//写日志
            sendgpsendparamArray = ISSI + "," + 0 + ";";
            window.parent.jquerygetNewData_ajax_post("Handlers/AddGPSParam.ashx", { mtype: "update", cmd: "param", dest: '', cycle: '', sendGPSParamRequestissis: sendgpsendparamArray }, function (msg) {
            });

        } else if (resultCode.toString() == "SUCCESS") {
            statues = strSuccess;
            cgsc.push(ISSI);
            cgopen.push(ISSI);

            writeLog("system", strGPSOpen + ":" + ISSI + "(" + statues + ")");//写日志
            writeLog("system", strGPSParam + ":" + ISSI + "(" + statues + ")");//写日志
            sendgpsenableOrDisableArray = ISSI + "," + 1 + ";";
            sendgpsendparamArray = ISSI + "," + 1 + ";";
            window.parent.jquerygetNewData_ajax_post("Handlers/AddGPSParam.ashx", { mtype: "update", cmd: "control", open: 1, sendGPSParamRequestissis: sendgpsenableOrDisableArray }, function (msg) {
            });
            window.parent.jquerygetNewData_ajax_post("Handlers/AddGPSParam.ashx", { mtype: "update", cmd: "param", dest: '', cycle: '', sendGPSParamRequestissis: sendgpsendparamArray }, function (msg) {
            });
        }
        //writeLog("system", strGPSParam + ":" + ISSI + "(" + statues + ")");//写日志
        //window.parent.jquerygetNewData_ajax_post("Handlers/AddGPSParam.ashx", { mtype: "update", cmd: "param", dest: '', cycle: '', sendGPSParamRequestissis: sendgpsendparamArray }, function (msg) {
        //});
        toWriteOpenResult();
    } else if (ctypeResponse == "LTE_GPS_GET_PARAM_ACK") {
        if (LTE_Dest.length >= 1) {
            var para = resultCode.trim().split('+');
            if (para.length >= 2) {
                if (para[1].trim() == "OPEN") {
                    var open = GetTextByName("Log_GPS_Open_Success", useprameters.languagedata);
                    var cycle = para[0] + "s";
                    toWriteLTEStatues(ISSI, LTE_Dest[0], open, cycle);
                } else {
                    var close = GetTextByName("Log_GPS_Close_Success", useprameters.languagedata);
                    var cycle = para[0] + "s";
                    toWriteLTEStatues(ISSI, LTE_Dest[0], close, cycle);
                }
            }
            LTE_Dest.length = 0;
        }
    } else if (ctypeResponse == "SM_PDT_PULL_TIMEOUT") {//周期性上拉超时失败
        for (var i = 0; i < usersInfo.length; i++) {
            if (usersInfo[i].uissi.toString().trim() == ISSI.toString().trim()) {
                statues = strFailed;
                sbPullUp.push(ISSI + ",超时失败");
                writeLog("system", strPullUpOutTime + ":" + ISSI + "(" + statues + ")");//写日志
                toWritePullUpResult(allShowedDoPullUpCount, hadDoPullUpcount);
                return;
            }
        }
    } else if (ctypeResponse == "SM_PDT_ACTIVE_SUCCESS") {//激活成功
        if (!isPullUp)
        { return; }
        for (var i = 0; i < usersInfo.length; i++) {
            if (usersInfo[i].uissi.toString().trim() == ISSI.toString().trim()) {
                statues = strSuccess;
                cgPullUp.push(ISSI);
                writeLog("system", strPullUpSuccess + ":" + ISSI + "(" + statues + ")");//写日志
                toWritePullUpResult(allShowedDoPullUpCount, hadDoPullUpcount);
                return;
            }
        }
    } else if (ctypeResponse == "SM_PDT_ACTIVE_FAIL") {//激活失败
        if (!isPullUp)
        { return; }
        for (var i = 0; i < usersInfo.length; i++) {
            if (usersInfo[i].uissi.toString().trim() == ISSI.toString().trim()) {
                statues = strFailed;
                sbPullUp.push(ISSI + ",激活失败"); 
                writeLog("system", strPullUpFail + ":" + ISSI + "(" + statues + ")");//写日志
                toWritePullUpResult(allShowedDoPullUpCount, hadDoPullUpcount);
                return;
            }
        }
    } else if (ctypeResponse == "SM_PDT_UNACTIVE_SUCCESS") {//去激活成功
        if (isPullUp)
        { return; }
        for (var i = 0; i < usersInfo.length; i++) {
            if (usersInfo[i].uissi.toString().trim() == ISSI.toString().trim()) {
                statues = strSuccess;
                cgPullUp.push(ISSI);
                writeLog("system", strUnPullUpSuccess + ":" + ISSI + "(" + statues + ")");//写日志
                toWritePullUpResult(allShowedDoPullUpCount, hadDoPullUpcount);
                return;
            }
        }
    } else if (ctypeResponse == "SM_PDT_UNACTIVE_FAIL") {//去激活失败
        if (isPullUp)
        { return; }
        for (var i = 0; i < usersInfo.length; i++) {
            if (usersInfo[i].uissi.toString().trim() == ISSI.toString().trim()) {
                statues = strFailed;
                sbPullUp.push(ISSI + ",去激活失败" );
                writeLog("system", strUnPullUpFail + ":" + ISSI + "(" + statues + ")");//写日志
                toWritePullUpResult(allShowedDoPullUpCount, hadDoPullUpcount);
                return;
            }
        }
    }
        //周期上拉新方案返回字符串
    //else if (ctypeResponse == "SM_PDT_PULLACTIVE_FAIL") {                         //激活失败--0
    //    if (!isPullUp)
    //    { return; }
    //    for (var i = 0; i < usersInfo.length; i++) {
    //        if (usersInfo[i].uissi.toString().trim() == ISSI.toString().trim()) {
    //            statues = strFailed;
    //            sbPullUp.push(ISSI);
    //            writeLog("system", strPullUpFail + ":" + ISSI + "(" + statues + ")");//写日志
    //            toWritePullUpResult(allShowedDoPullUpCount, hadDoPullUpcount);
    //            return;
    //        }
    //    }
    //} else if (ctypeResponse == "SM_PDT_PULLACTIVE_ISGW_SUCCESS") {                  //网关响应成功SM_PDT_PULLACTIVE_ISGW_SUCCESS--1
    //    if (!isPullUp)
    //    { return; }
    //    for (var i = 0; i < usersInfo.length; i++) {
    //        if (usersInfo[i].uissi.toString().trim() == ISSI.toString().trim()) {
    //            statues = strSuccess;
    //            cgPullUp.push(ISSI);
    //            writeLog("system", strPullUpSuccess + ":" + ISSI + "(" + statues + ")");//写日志
    //            toWritePullUpResult(allShowedDoPullUpCount, hadDoPullUpcount);
    //            return;
    //        }
    //    }
    //} else if (ctypeResponse == "SM_PDT_PULLACTIVE_TE_SUCCESS") {                     //激活成功，终端相响应成功--2
    //    if (!isPullUp)
    //    { return; }
    //    for (var i = 0; i < usersInfo.length; i++) {
    //        if (usersInfo[i].uissi.toString().trim() == ISSI.toString().trim()) {
    //            statues = strSuccess;
    //            cgPullUp.push(ISSI);
    //            writeLog("system", strPullUpSuccess + ":" + ISSI + "(" + statues + ")");//写日志
    //            toWritePullUpResult(allShowedDoPullUpCount, hadDoPullUpcount);
    //            return;
    //        }
    //    }
    //} else if (ctypeResponse == "SM_PDT_PULLACTIVE_TIMEOUT") {                            //周期性上拉激活超时失败--3
    //    for (var i = 0; i < usersInfo.length; i++) {
    //        if (usersInfo[i].uissi.toString().trim() == ISSI.toString().trim()) {
    //            statues = strFailed;
    //            sbPullUp.push(ISSI);
    //            writeLog("system", strPullUpOutTime + ":" + ISSI + "(" + statues + ")");//写日志
    //            toWritePullUpResult(allShowedDoPullUpCount, hadDoPullUpcount);
    //            return;
    //        }
    //    }
    //} else if (ctypeResponse == "SM_PDT_PULLUNACTIVE_TIMEOUT") {                          //周期性上拉去激活超时失败--4
    //    for (var i = 0; i < usersInfo.length; i++) {
    //        if (usersInfo[i].uissi.toString().trim() == ISSI.toString().trim()) {
    //            statues = strFailed;
    //            sbPullUp.push(ISSI);
    //            writeLog("system", strPullUpOutTime + ":" + ISSI + "(" + statues + ")");//写日志
    //            toWritePullUpResult(allShowedDoPullUpCount, hadDoPullUpcount);
    //            return;
    //        }
    //    }
    //} else if (ctypeResponse == "SM_PDT_PULLUNACTIVE_SUCCESS") {                           //去激活成功--5
    //    if (isPullUp)
    //    { return; }
    //    for (var i = 0; i < usersInfo.length; i++) {
    //        if (usersInfo[i].uissi.toString().trim() == ISSI.toString().trim()) {
    //            statues = strSuccess;
    //            cgPullUp.push(ISSI);
    //            writeLog("system", strUnPullUpSuccess + ":" + ISSI + "(" + statues + ")");//写日志
    //            toWritePullUpResult(allShowedDoPullUpCount, hadDoPullUpcount);
    //            return;
    //        }
    //    }
    //} else if (ctypeResponse == "SM_PDT_PULLUNACTIVE_FAIL") {                                //去激活失败--6
    //    if (isPullUp)
    //    { return; }
    //    for (var i = 0; i < usersInfo.length; i++) {
    //        if (usersInfo[i].uissi.toString().trim() == ISSI.toString().trim()) {
    //            statues = strFailed;
    //            sbPullUp.push(ISSI);
    //            writeLog("system", strUnPullUpFail + ":" + ISSI + "(" + statues + ")");//写日志
    //            toWritePullUpResult(allShowedDoPullUpCount, hadDoPullUpcount);
    //            return;
    //        }
    //    }
        //} 
    else if (ctypeResponse == "GPS_ADD_MODIFY_TRIGGER_RESPONSE") {
        var statues = "";
        if (resultCode.toString() != "1") {
            statues = strFailed;
            sbdistance.push(ISSI);
            sendgpsendparamArray = ISSI + "," + 0 + ";";
        } else {
            statues = strSuccess;
            cgdistance.push(ISSI);
            sendgpsendparamArray = ISSI + "," + 1 + ";";
        }
        writeLog("system", strDistance + ":" + ISSI + "(" + statues + ")");//写日志

        window.parent.jquerygetNewData_ajax_post("Handlers/AddGPSParam.ashx", { mtype: "update", cmd: "distance", distance: "", sendGPSParamRequestissis: sendgpsendparamArray }, function (msg) {
        });
        toWriteOpenResult();
    }
}

function toWriteLTEStatues(issi, dest, openOrClose, circyle) {
    if (document.frames["view_info/view_LTE_GPS_info_ifr"] != null || document.frames["view_info/view_LTE_GPS_info_ifr"] != undefined) {
        if ((typeof document.frames["view_info/view_LTE_GPS_info_ifr"].toHTML).toString() != "undefined") {
            document.frames["view_info/view_LTE_GPS_info_ifr"].toHTML(issi, dest, openOrClose, circyle);
        }
    } else {
        mycallfunction('view_info/view_LTE_GPS_info', 300, 350);
        var addLTEinfo = setTimeout(function () {
            if (document.frames["view_info/view_LTE_GPS_info_ifr"] != null || document.frames["view_info/view_LTE_GPS_info_ifr"] != undefined) {
                if ((typeof document.frames["view_info/view_LTE_GPS_info_ifr"].toHTML).toString() != "undefined") {
                    document.frames["view_info/view_LTE_GPS_info_ifr"].toHTML(issi, dest, openOrClose, circyle);
                    clearInterval(addLTEinfo);
                }
            }
        }, 500);
    }
}
var LTE_Dest = new Array();
function getLTEStautes(ISSI, Dest, IsSuccedd) {
    var retvar = 0;
    LTE_Dest.length = 0;
    var GetLTEStautes_Fail = window.parent.parent.GetTextByName("GetLTEStautes_Fail", window.parent.parent.useprameters.languagedata);
    if (IsSuccedd == true) {
        LTE_Dest.push(Dest);
    } else { LTE_Dest.push(Dest + "(" + window.parent.parent.GetTextByName("Unkown", window.parent.parent.useprameters.languagedata) + ")"); }
    try {
        var scactionX = document.getElementById("SCactionX");
        retvar = scactionX.SendGetGpsParam(1, ISSI, 0, "");
    } catch (ex) {
        alert(GetLTEStautes_Fail); LTE_Dest.length = 0;
        return;
    }
    if (retvar == 0) {
        alert(GetLTEStautes_Fail); LTE_Dest.length = 0;
        return;
    }
}

//ISSIs格式：[{name:"林警官",issi:"24001",type,编组}]  林警官(24001);王警官(24002) 
function sendMsg(ISSIs, message, isConsume) {
    var vreturn = true;
    if (ISSIs.length == 1 && ISSIs[0].type == GetTextByName("Group", useprameters.languagedata)) { //当只有一个对象的时候特殊处理，不然循环发送的时候会出问题；多语言：编组
        SendGroupMsg(ISSIs[0].issi, message, isConsume);
        return vreturn;

    }
    else if (ISSIs.length == 1) {
        doSendMsg(ISSIs[0].issi, message, isConsume);
        return vreturn;
    }

    var issiLenght = ISSIs.length;
    var issiindex = 0;
    if (issiLenght > 0) {
        //循环发送 不能用for 用递归
        var sendInterval = setInterval(function () {
            if (issiindex < issiLenght) {
                if (ISSIs[issiindex].type == GetTextByName("Group", useprameters.languagedata)) {//多语言：编组
                    //代写方法1
                    SendGroupMsg(ISSIs[issiindex].issi, message, isConsume);
                }
                else {
                    doSendMsg(ISSIs[issiindex].issi, message, isConsume);
                }
                issiindex++;
            } else {
                clearInterval(sendInterval);
            }
        }, smsSendSpace);
    }
    return vreturn;
}
///代写方法1
function SendGroupMsg(gssi, msg, isconsume) {
    var scactionX = document.getElementById("SCactionX");
    try {
        var issuccess = scactionX.SendMsgToGroup(msg, gssi, isconsume);
    } catch (ex) {
        writeLog("system", ex);
        return false;
    }
    var todbMSG;
    if (issuccess == "1") {
        todbMSG = GetTextByName(constMsgSendSucess, useprameters.languagedata);
    }
    else {
        todbMSG = GetTextByName("SM_DESTINATION_NOT_REACHABLE_MESSAGE_DELIVERY_FAILED", useprameters.languagedata);
    }
    jquerygetNewData_ajax("Handlers/AddSMS.ashx", { issi: gssi, content: msg, isreturn: 0, smsid: issuccess, isgroup: 1, status: todbMSG, smsType: smsType_Commom_Msg }, function (msg) { });


}

function doSendMsg(issi, message, isConsume) {
    var vreturn = true;
    var scactionX = document.getElementById("SCactionX");
    var reVal = false;
    var content = "";
    try {
        reVal = scactionX.SendMSGToISSI(message, issi, isConsume);
        if (reVal == sendfailed) {
            content = "Log_GPS_SMSSend_Failed;Log_GPS_SMS_Content:" + message + ";Log_GPS_SMS_IsHZ:" + isConsume;
        } else {
            content = "Log_GPS_SMSSend_Success;Log_GPS_SMS_Content:" + message + ";Log_GPS_SMS_IsHZ:" + isConsume;
        }
    } catch (ex) {
        content = "Log_GPS_SMSSend_Failed;Log_GPS_SMS_Content:" + message + ";Log_GPS_SMS_IsHZ:" + isConsume;
        //alert(issi +":"+ message+"--发送失败，控件未安装");
    } finally {
        writeToDbByUserISSI(issi, OperateLogType.operlog, OperateLogModule.ModuleSMS, OperateLogOperType.CommSMSSend, content, OperateLogIdentityDeviceType.MobilePhone);

    }
    var sendfailed = GetTextByName("SM_DELIVERY_FAILED", useprameters.languagedata)
    if (reVal == sendfailed) { //(reVal == "发送失败")
        vreturn = false;
    }
    else {
        jquerygetNewData_ajax("Handlers/AddSMS.ashx", { issi: issi, content: message, isreturn: isConsume, smsid: reVal, isgroup: 0, smsType: smsType_Commom_Msg }, function (msg) { });
    }
    return vreturn;
}

function ToLoctionByISSI(issi) {
    locationbyISSI(issi, '');
}

function InvalidUserMsg(issi, firststatus, nowstatus, usertype) {
}

function sendreportnum(ISSIs, statusNum) {
    var vreturn = true;
    if (ISSIs.length == 1) { //当只有一个对象的时候特殊处理，不然循环发送的时候会出问题
        doSendStatusnum(ISSIs[0].issi, statusNum);
        return vreturn;

    }
    var issiLenght = ISSIs.length;
    var issiindex = 0;
    if (issiLenght > 0) {
        //循环发送 不能用for 用递归
        var sendInterval = setInterval(function () {
            if (issiindex < issiLenght) {
                doSendStatusnum(ISSIs[issiindex].issi, statusNum);
                issiindex++;
            } else {
                clearInterval(sendInterval);
            }
        }, smsSendSpace);
    }
    return vreturn;
}

function sendreportMsg(ISSIs, statusMsg) {
    var vreturn = true;
    if (ISSIs.length == 1) { //当只有一个对象的时候特殊处理，不然循环发送的时候会出问题
        doSendStatusMsg(ISSIs[0].issi, statusMsg);
        return vreturn;

    }
    var issiLenght = ISSIs.length;
    var issiindex = 0;
    if (issiLenght > 0) {
        //循环发送 不能用for 用递归
        var sendInterval = setInterval(function () {
            if (issiindex < issiLenght) {
                doSendStatusMsg(ISSIs[issiindex].issi, statusMsg);
                issiindex++;
            } else {
                clearInterval(sendInterval);
            }
        }, smsSendSpace);
    }
    return vreturn;
}

function doSendStatusnum(issi, statusnum) {

    var scactionX = document.getElementById("SCactionX");
    var content = "";
    try {
        var reVal = scactionX.SendSTATUSNUMToISSI(issi, statusnum);
        if (reVal == "12") {
            retrunSendStatusMsg(issi);
            content = "Log_GPS_StatuesSend_Success;Log_GPS_Statues_Content:" + statusnum
        }
        else {
            var myMsg = "[" + GetTextByName("Send(state)", useprameters.languagedata) + "]" + GetTextByName("Lang_SendStatusMsgFail", useprameters.languagedata) + "(ISSI:" + issi + ")[" + LOGTimeGet() + "]";//多语言：发送(状态);发送状态消息失败
            writeLog("sms", myMsg);
            content = "Log_GPS_StatuesSend_Failed;Log_GPS_Statues_Content:" + statusnum
        }
    } catch (ex) {
        writeLog("system", ex);
        content = "Log_GPS_StatuesSend_Failed;Log_GPS_Statues_Content:" + statusnum
        return false;
    } finally {
        writeToDbByUserISSI(issi, OperateLogType.operlog, OperateLogModule.ModuleSMS, OperateLogOperType.StatuesSMSSend, content, OperateLogIdentityDeviceType.MobilePhone);
        jquerygetNewData_ajax("Handlers/AddSMS.ashx", { issi: issi, content: "STATUS:"+statusnum, isreturn: 0, smsid: -1, isgroup: 0,smsType:smsType_Status_Msg }, function (msg) { });
    }
}

function doSendStatusMsg(issi, message) {
    var scactionX = document.getElementById("SCactionX");
    try {
        var reVal = scactionX.SendSTATUSMSGToISSI(message, issi);
        if (reVal == "12") {
            retrunSendStatusMsg(issi);
        }
        else {
            var myMsg = "[" + GetTextByName("Send(state)", useprameters.languagedata) + "]" + GetTextByName("Lang_SendStatusMsgFail", useprameters.languagedata) + "(ISSI:" + issi + ")[" + LOGTimeGet() + "]";//多语言：发送(状态);发送状态消息失败
            writeLog("sms", myMsg);
        }
    } catch (ex) {
        writeLog("system", ex);
        return false;
    }
}

function retrunSendStatusMsg(issi) {
    var param = { "issi": issi };
    jquerygetNewData_ajax("Handlers/GetIssiTypeByISSI.ashx", param, function (request) {
        var _data = request;
        var msg = GetTextByName("SendSuccess", useprameters.languagedata);//多语言：发送成功
        //callBackRestlt += msg + ";";
        var MYName = _data.sname;

        if (_data.stype == "D") {//调度台 不需要显示经纬度了
            var myMsg = "[" + GetTextByName("Send(state)", useprameters.languagedata) + "]" + msg + "(<span   oncontextmenu=javascript:rightselecttype='dispatch';rightISSI=" + issi + "   onclick=window.parent.parent.mycallfunction('Send_SMS','380',400,'" + issi + "&cmd=DISSI&name=" + encodeURI(GetTextByName("Dispatch", useprameters.languagedata)) + "[" + encodeURI(MYName) + "]') >" + MYName + "</span>)[" + LOGTimeGet() + "]";//多语言：发送(状态)；调度台
            writeLog("sms", myMsg);
        } else if (_data.stype == "G") {//组 不需要显示经纬度了
            var myMsg = "[" + GetTextByName("Send(state)", useprameters.languagedata) + "]" + msg + "(<span   oncontextmenu=javascript:rightselecttype='group';rightGSSI=" + issi + "   onclick=window.parent.parent.mycallfunction('Send_SMS','380',400,'" + issi + "&cmd=GSSI&name=" + encodeURI(MYName) + "') >" + MYName + "</span>)[" + LOGTimeGet() + "]";//多语言：发送(状态)
            writeLog("sms", myMsg);
        } else if (_data.stype == "U") {
            var myMsg = "[" + GetTextByName("Send(state)", useprameters.languagedata) + "]" + msg + "(<span   oncontextmenu=javascript:rightselecttype='cell';window.parent.parent.useprameters.rightselectid=" + _data.pcid + "   onclick=window.parent.parent.mycallfunction('Send_SMS','380',400,'&cmd=ISSI&issi=" + issi + "&name=" + encodeURI(MYName) + "') >" + MYName + "</span>)";//多语言：发送(状态)
            myMsg += " &nbsp;<span onclick=window.parent.parent.DingWei('" + _data.lo + "','" + _data.la + "','weizhi')>(" + GetTextByName("Lang-Longitude", useprameters.languagedata) + ":" + _data.lo + ",&nbsp;&nbsp;" + GetTextByName("Lang-Latitude", useprameters.languagedata) + ":" + _data.la + ")</span>";//多语言：经度；纬度
            myMsg += "[" + LOGTimeGet() + "]";
            writeLog("sms", myMsg);
        } else { //未知用户
            var myMsg = "[" + GetTextByName("Send(state)", useprameters.languagedata) + "]" + msg + "(<span onclick=window.parent.parent.mycallfunction('Send_SMS','380',400,'&cmd=ISSI&issi=" + issi + "&name=" + encodeURI(GetTextByName("UnkownUser", useprameters.languagedata)) + "') >" + MYName + "</span>)[" + LOGTimeGet() + "]";//多语言：发送(状态)；未知用户
            writeLog("sms", myMsg);
        }
        //        var ifrs = document.frames["ifr_callcontent"];
        //        ifrs.document.getElementById("scrollarea").innerHTML = "本调度台发送给<span style='cursor:hand;text-decoration:underline;' onclick=window.parent.parent.ToLoctionByISSI('" + issi + "') >" + MYName + "</span>消息";


    })
}


//写基站日志
function WriteBSLo(msg) {
    var param1 = { "ISSI": useprameters.hostISSI };
    jquerygetNewData_ajax("Handlers/GetDispatchNameByISSI.ashx", param1, function (request1) {
        MYName = request1.PCName;
        writeLog("oper", MYName + msg + "[" + LOGTimeGet() + "]");
    });
}
//被基站呼叫里面的消息调用
function mapMsgShow(issi, bctype, msg) {//msg不需要传进来了 在调用的接口以及多语言转化过了

    var atype = "";
    //if (bctype == 3) { atype = "单站呼叫"; } else if (bctype == 5) { atype = "全站呼叫"; }
    switch (bctype.toString()) {
        case "3": atype = GetTextByName("Lang_SingleStationCall", useprameters.languagedata); break;//多语言：单站呼叫
        case "4": atype = GetTextByName("Lang_SMultiStationCall", useprameters.languagedata); break;//多语言：多站呼叫
        case "5": atype = GetTextByName("Lang_TheStationCall", useprameters.languagedata); break;//多语言：全站呼叫
        default: break;
    }
    var mymsg = msg;
    jquerygetNewData_ajax("Handlers/GetBaseStationInfoByISSI.ashx", { issi: issi }, function (msgs) {
        var bsi = eval(msgs);
        if (bsi.length > 0) {
            document.getElementById("scrollarea").innerHTML = GetTextByName("StationName", useprameters.languagedata) + ":" + bsi[0].StationName + "(" + issi + ");" + atype + ";" + mymsg;//多语言：基站名称

        }
    });
}
function showradio() {
    document.frames["SBCall_ifr"].document.getElementById("rsingcall").disabled = false;
    document.frames["SBCall_ifr"].document.getElementById("rgroupcall").disabled = false;
    document.frames["SBCall_ifr"].document.getElementById("rallcall").disabled = false;
    document.frames["SBCall_ifr"].flag = false;
}
function WriteLogMsg(titleName, Content, level) {
    setTimeout(function () {
        alert(Content);
        writeLog("system", titleName + ":<span class='myspan'>" + Content + "</span>");
    }, 2000);//延迟两秒钟是为了日志窗口能够加载完
}
function changebackimg(id, img, calltype, issi, msg, gssi, hookmethodsel) {
    try {
        var map = document.getElementById("main");
        map.changezhebg(id, img, calltype, issi, msg, gssi, hookmethodsel);//调用FLASH呼叫栏
    } finally {
        return;
    }

    var ifrs = document.frames["ifr_callcontent"];                                      /**初始化单呼按钮**/
    if (ifrs) {
        ifrs.document.getElementById(id).style.backgroundImage = "url(" + img + ")";
    }
}
function changezhebg(id, myvalue) {

    var ifrs = document.frames["ifr_callcontent"];
    if (ifrs) {
        if (ifrs.document.getElementById(id) != null || ifrs.document.getElementById(id) != undefined) {
            ifrs.document.getElementById(id).style.backgroundPosition = myvalue;
        }
    }
}
function changedisply(id, isvisble) {
    var ifrs = document.frames["ifr_callcontent"];
    if (ifrs) {
        ifrs.document.getElementById(id).style.display = isvisble;
    }
}
function UPcallChgIMG(issi, hookmethodsel) {
    if (isUPCall(issi, useprameters.UPCall)) {
        var indexof = indeofgroup(issi, useprameters.UPCall);
        if (useprameters.UPCall[indexof].calltype == "ppc") {
            return;
        }

        switch (useprameters.UPCall[indexof].type) {
            case "10":
                /**上行组呼请求**/
                break;
            case "01":                                                                   /**上行全双工单呼请求**/
                changebackimg("call2", GetTextByName("maincall_btn_img_src_receivecall", useprameters.languagedata), useprameters.UPCall[indexof].type);//receivecall
                var ifrs = document.frames["ifr_callcontent"];
                if (ifrs) {
                    ifrs.document.getElementById("singal1").innerHTML = GetTextByName("TellMode", useprameters.languagedata);//多语言：电话模式
                    ifrs.calltype = 0;
                }
                break;
            case "00":                                                                   /**上行半双工单呼请求**/
                changebackimg("call2", GetTextByName("maincall_btn_img_src_receivecall", useprameters.languagedata), useprameters.UPCall[indexof].type); //receivecall 需要根据在挂机模式判断
                //                switch (hookmethodsel) {
                //                    case "0":
                //                        changebackimg("call2", "callfinish.png"); //需要根据在挂机模式判断
                //                        break;
                //                    case "1":
                //                        changebackimg("call2", "receivecall.png"); //需要根据在挂机模式判断
                //                        break;
                //                    default:
                //                        changebackimg("call2", "receivecall.png"); //需要根据在挂机模式判断
                //                        break;
                //                }

                var ifrs = document.frames["ifr_callcontent"];
                if (ifrs) {
                    ifrs.document.getElementById("singal1").innerHTML = GetTextByName("PTTMode", useprameters.languagedata);//多语言：对讲机模式
                    ifrs.calltype = 1;
                }
                break;
        }
    }
}
function getIssiNameLoLa(issi, eventtype, msg, gssi, hookmethodsel)                     /**生成插入文本**/ {
    /**操作窗口框架**/
    var PCname = "";
    var lo;
    var la;
    var GSSIname = "";
    var returnstring = "";
    document.getElementById("scrollarea").innerHTML = "";

    if (eventtype == 22) {                                                                    /**呼叫结束**/
        document.getElementById("scrollarea").innerHTML = GetTextByName("CallEnd", useprameters.languagedata);//多语言：呼叫结束

        writeLog("call", GetTextByName("CallEnd", useprameters.languagedata) + "[" + LOGTimeGet() + "]");//多语言：呼叫结束
        return;
    }
    var param = { "ISSI": issi, "gssi": gssi, "hostISSI": useprameters.hostISSI };                                                   /**获取经纬度及用户名称**/
    //    jquerygetNewData_ajax("WebGis/Service/getISSSname.aspx", param, function (request) {
    //        var _data = request;
    //        if (request) {
    //            lo = request.lo;
    //            la = request.la;
    //            PCid = request.PCid; ;
    //            PCname = request.PCname;
    //            GSSIname = request.GSSIName;

    if (eventtype == 10) {
        returnstring = GetTextByName("GroupCall", useprameters.languagedata) + "(" + gssi + "):";//多语言：组呼
        if (issi != 0) {
            returnstring += "(" + issi + ")";
        }
        returnstring += " " + msg;
    }
    if (eventtype == 00 || eventtype == 01) {
        returnstring = "(" + issi + ")";
        returnstring += ":";
        returnstring += " " + msg;

    }
    document.getElementById("scrollarea").innerHTML = returnstring;


    writeCallLog(issi, eventtype, msg, gssi, useprameters.hostISSI);
}
function getIssiNameLoLaForPPCCall(issi, eventtype, msg, gssi, hookmethodsel)                     /**生成插入文本**/ {
    /**操作窗口框架**/
    var PCname = "";
    var lo;
    var la;
    var GSSIname = "";
    var returnstring = "";
    document.getElementById("scrollarea").innerHTML = "";

    if (eventtype == 22) {                                                                               /**呼叫结束**/
        document.getElementById("scrollarea").innerHTML = GetTextByName("CallEnd", useprameters.languagedata);//多语言：呼叫结束

        writeLog("call", GetTextByName("CallEnd", useprameters.languagedata) + "[" + LOGTimeGet() + "]");
        return;
    }
    var param = { "ISSI": issi, "gssi": gssi, "hostISSI": useprameters.hostISSI };                       /**获取经纬度及用户名称**/
    //    jquerygetNewData_ajax("WebGis/Service/getISSSname.aspx", param, function (request) {
    //        var _data = request;
    //        if (request) {
    //            lo = request.lo;
    //            la = request.la;
    //            PCid = request.PCid; ;
    //            PCname = request.PCname;
    //            GSSIname = request.GSSIName;

    if (eventtype == 10) {
        returnstring = GetTextByName("GroupCall", useprameters.languagedata) + "(" + gssi + "):";//多语言：组呼
        if (issi != 0) {
            returnstring += "(" + issi + ")";
        }
        returnstring += " " + msg;
    }
    if (eventtype == 00 || eventtype == 01) {
        returnstring = "(" + issi + ")";
        returnstring += ":";
        returnstring += " " + msg;
        //操作窗口 慎密监听 强插
        //                if (document.frames["DLCall_ifr"] != null && document.frames["DLCall_ifr"] != undefined && document.frames["DLCall_ifr"].document.getElementById("txtISSIText").value == issi) {
        //                    document.frames["DLCall_ifr"].document.getElementById("divstatue").innerHTML = returnstring;
        //                }
    }
    //returnstring += issi + "(" + GSSIname + ")" + "应答:" + hookmethodsel + "呼叫:" + eventtype; 调试
    document.getElementById("scrollarea").innerHTML = returnstring;

    //            writeCallLog(issi, eventtype, msg, gssi, PCname, GSSIname, PCid);
    //        }
    //    }, false, false);

    writePPCCallLog(issi, eventtype, msg, gssi, useprameters.hostISSI);
}
function issilocation(lo, la, ci, ISSI) {
    try {
        if (useprameters.lockid != 0) {
            alert(GetTextByName("HasLockFunction", useprameters.languagedata));//多语言：存在锁定用户
            return;
        }
        if (lo != 0 && la != 0) {
            var pars = "Police,0,0" + "|" + ci + "|" + lo + "|" + la + "|" + true + "|" + ISSI;
            showlocalpic(pars);                                /**显示图标**/
            thisLocation(pars);                                   /**定位用户**/
        }
    }
    catch (e) {
        alert("issilocation" + e);
    }
}

//林强 2015-3-9
function issilocationnoalert(lo, la, ci, ISSI) {

    try {
        if (useprameters.lockid != 0) {

            return;
        }
        if (lo != 0 && la != 0) {
            var pars = "Police,0,0" + "|" + ci + "|" + lo + "|" + la + "|" + true + "|" + ISSI;
            showlocalpic(pars);                                /**显示图标**/
            thisLocation(pars);                                   /**定位用户**/
        }
    }
    catch (e) {

    }
}

//张谦
function cameraLoation(cameraNum,lo, la) {

    var isSuccess = false;
    try {
        if (lo != 0 && la != 0) {
            var mainSWF = document.getElementById("main");
            if (mainSWF) {
                isSuccess = mainSWF.callbackLocateCamera(cameraNum, parseFloat(lo), parseFloat(la));
            }
        }
    }
    catch (e) {
        alert("LayerCamerLocation" + e);
    }

}

//var rkfuncton = {
//    add1: 1,
//    add2: 2,
//    del1: 3,
//    del2: 4
//}
//var rk = "";
//function clearRunDTCZ() {
//    if (rk == rkfuncton.add1) {

//    } else if (rk == rkfuncton.add2) {

//    } else if (rk == rkfuncton.del1) {

//    } else if (rk == rkfuncton.del2) {

//    }
//}

var sendTDGFlashTime = 2000;
var singleCount = 500;
var p_run;
var cjarry = new Array();
var sbarry = new Array();
var lastISSI = 0;
var lasttootl = 0;
function clear_p_run() {
    // cjarry.length = 0;
    // sbarry.length = 0;
    //if (lastISSI > 0) {
    //    lastISSI = lastISSI - 1;
    //}
    clearInterval(p_run);
    isSendingDTCX = false;
    if (document.frames["DTGroup/ResultList_ifr"] != null || document.frames["DTGroup/ResultList_ifr"] != undefined) {
        document.frames["DTGroup/ResultList_ifr"].toshowclosebtn();
    }
}

function toWriteResult(totalcount, havedocount, dotype, gssi) {

    if (document.frames["DTGroup/ResultList_ifr"] != null || document.frames["DTGroup/ResultList_ifr"] != undefined) {
        if ((typeof document.frames["DTGroup/ResultList_ifr"].toHTML).toString() != "undefined") {
            document.frames["DTGroup/ResultList_ifr"].toHTML(totalcount, havedocount, dotype, gssi, cjarry, sbarry);
        }
    }
}
var isSendingDTCX = false;
var dcczSendTypeEnum = {
    add: 1,
    del: 0
}
var dtczSendType = "";
function SendAddMemberToDTGroup(GSSI, MemberISSIS) {
    cjarry.length = 0;
    sbarry.length = 0;
    isSendingDTCX = true;
    lastISSI = 0;
    lasttootl = MemberISSIS.length;
    dtczSendType = dcczSendTypeEnum.add;
    var i = 0;
    p_run = setInterval(function () {
        if (i < MemberISSIS.length) {

            var scactionX = document.getElementById("SCactionX");
            scactionX.AddDgnaMember(1, MemberISSIS[i], GSSI);
            writeToDbByUserISSI(MemberISSIS[i], OperateLogType.operlog, OperateLogModule.ModuleCall, OperateLogOperType.DGNA, "Lang_AddToDTCZNO;Lang_dtczxxNO:" + GSSI, OperateLogIdentityDeviceType.MobilePhone);
            toWriteResult(MemberISSIS.length, i, "add", GSSI);
            if (parseInt(i) != MemberISSIS.length - 1) {
                lastISSI++;
            }
            i++;
        } else {
            //toWriteResult(MemberISSIS.length, i - 1, "add", GSSI);

            clear_p_run()
        }

    }, sendTDGFlashTime);
}

function SendDelMemberFromDTGroup(GSSI, MemberISSIS) {
    cjarry.length = 0;
    sbarry.length = 0;
    isSendingDTCX = true;
    lastISSI = 0;
    lasttootl = MemberISSIS.length;
    dtczSendType = dcczSendTypeEnum.del;
    var i = 0;
    p_run = setInterval(function () {
        if (i < MemberISSIS.length) {

            var scactionX = document.getElementById("SCactionX");
            scactionX.DelDgnaMember(1, MemberISSIS[i], GSSI);
            writeToDbByUserISSI(MemberISSIS[i], OperateLogType.operlog, OperateLogModule.ModuleCall, OperateLogOperType.DGNA, "Lang_DelToDTCZNO;Lang_dtczxxNO:" + GSSI, OperateLogIdentityDeviceType.MobilePhone);

            toWriteResult(MemberISSIS.length, i, "del", GSSI);
            if (parseInt(i) != MemberISSIS.length - 1) {
                lastISSI++;
            }
            i++;
        } else {
            //toWriteResult(MemberISSIS.length, i - 1, "del", GSSI);

            clear_p_run();
        }

    }, sendTDGFlashTime);

}

function SendAddMemberToDTGroup2(GSSI, users) {
    //var sendDTGissis = "";//var sendissi=issi,zhuangtai;issi,zhuangtai
    //for (var mp = 0; mp < users.length; mp++) {
    //    sendDTGissis += users[mp].uissi + ",2;";

    //}
    //window.parent.jquerygetNewData_ajax_post("Handlers/ADDDTCZMember.ashx", { GSSI: GSSI, sendDTGissis: sendDTGissis }, function (msg) {

    //});
    cjarry.length = 0;
    sbarry.length = 0;
    var mi = 0;
    if (mi < users.length) {
        var laset = users.length;
        if (parseFloat(mi) + 500 < parseFloat(laset)) {
            laset = mi + 500
        }
        var sendDTGissis = "";
        for (var fim = mi; fim < laset; fim++) {
            sendDTGissis += users[fim].uissi + ",2;";
        }
        window.parent.jquerygetNewData_ajax_post("Handlers/ADDDTCZMember.ashx", { GSSI: GSSI, sendDTGissis: sendDTGissis }, function (msg) {

        });
        mi += 500;
    }
    var padddate = setInterval(function () {
        if (mi < users.length) {
            var laset = users.length;
            if (parseFloat(mi) + 500 < parseFloat(laset)) {
                laset = mi + 500
            }
            var sendDTGissis = "";
            for (var fim = mi; fim < laset; fim++) {
                sendDTGissis += users[fim].uissi + ",2;";
            }
            window.parent.jquerygetNewData_ajax_post("Handlers/ADDDTCZMember.ashx", { GSSI: GSSI, sendDTGissis: sendDTGissis }, function (msg) {

            });
            mi += 500;
        } else {
            clearInterval(padddate);
        }
    }, 5000)

    lastISSI = 0;
    lasttootl = users.length;
    dtczSendType = dcczSendTypeEnum.add;
    isSendingDTCX = true;
    var i = 0;
    p_run = setInterval(function () {
        if (i < users.length) {
            try {

                var scactionX = document.getElementById("SCactionX");
                scactionX.AddDgnaMember(1, users[i].uissi, GSSI);
            } catch (exce) {
            } finally {
                toWriteResult(users.length, i, "add", GSSI);
                writeToDbByUserISSI(users[i].uissi, OperateLogType.operlog, OperateLogModule.ModuleCall, OperateLogOperType.DGNA, "Lang_AddToDTCZNO;Lang_dtczxxNO:" + GSSI, OperateLogIdentityDeviceType.MobilePhone);
                if (parseInt(i) != users.length - 1) {
                    lastISSI++;
                }
                i++;
            }
        } else {
            //toWriteResult(users.length, i-1, "add", GSSI);

            clear_p_run();
        }

    }, sendTDGFlashTime);
}
function SendDelMemberFromDTGroup2(GSSI, MemberISSIS) {
    for (var mp = 0; mp < users.length; mp++) {//users[mp].uissi

    }
}
function DGNAMsg(id, issi, gssi, value) {
    var zt = 2;
    switch (value) {
        case "ADD_DGNA_SUCCEED":
            zt = 1;
            var scactionX = document.getElementById("SCactionX");
            scactionX.GetDgnaStatus(1, issi, gssi, 0);
            break;
        case "ADD_DGNA_FAILURE":
            zt = 0;
            break;
        case "DEL_DGNA_SUCCEED":
            zt = 2;
            var scactionX = document.getElementById("SCactionX");
            scactionX.GetDgnaStatus(1, issi, gssi, 1);
            break;
        case "DEL_DGNA_FAILURE":
            break;
        case "GET_DGNA_GROUP_STATUS_INPROGRESS":
            var scactionX = document.getElementById("SCactionX");
            if (dtczSendType == dcczSendTypeEnum.add) {
                scactionX.GetDgnaStatus(1, issi, gssi, 0);
            } else {
                scactionX.GetDgnaStatus(1, issi, gssi, 1);
            }
            break;
        case "GET_DGNA_GROUP_STATUS_SUCCEED":
            cjarry.push(issi);
            if (dtczSendType == dcczSendTypeEnum.add) {
                //if (lastISSI.trim() == issi.trim()) {
                //    toWriteResult(lasttootl, lasttootl-1, "add", gssi);
                //}
                toWriteResult(lasttootl, lastISSI, "add", gssi);
                zt = 1;
                var msg = GetTextByName("ADD_DGNA_SUCCEED", useprameters.languagedata);
                var Lang_dtczxxNO = GetTextByName("Lang_dtczxxNO", useprameters.languagedata);
                var Lang_MemberNO_DT = GetTextByName("Lang_MemberNO_DT", useprameters.languagedata);
                writeLog("system", msg + "(" + Lang_dtczxxNO + ":" + gssi + "," + Lang_MemberNO_DT + ":" + issi + ")[" + LOGTimeGet() + "]");//写日志
                window.parent.jquerygetNewData_ajax_post("Handlers/ADDDTCZMember.ashx", { GSSI: gssi, sendDTGissis: issi + "," + zt + ";" }, function (msg) {

                });
            } else if (dtczSendType == dcczSendTypeEnum.del) {
                //if (lastISSI.trim() == issi.trim()) {
                //    toWriteResult(lasttootl, lasttootl-1, "del", gssi);
                //}
                toWriteResult(lasttootl, lastISSI, "del", gssi);
                zt = 2;
                var msg = GetTextByName("DEL_DGNA_SUCCEED", useprameters.languagedata);
                var Lang_dtczxxNO = GetTextByName("Lang_dtczxxNO", useprameters.languagedata);
                var Lang_MemberNO_DT = GetTextByName("Lang_MemberNO_DT", useprameters.languagedata);
                writeLog("system", msg + "(" + Lang_dtczxxNO + ":" + gssi + "," + Lang_MemberNO_DT + ":" + issi + ")[" + LOGTimeGet() + "]");//写日志
                window.parent.jquerygetNewData_ajax_post("Handlers/ADDDTCZMember.ashx", { GSSI: gssi, sendDTGissis: issi + "," + zt + ";" }, function (msg) {

                });
            }
            break;
        case "GET_DGNA_GROUP_STATUS_FAILED":
            sbarry.push(issi);
            if (dtczSendType == dcczSendTypeEnum.add) {
                //if (lastISSI.trim() == issi.trim()) {
                //    toWriteResult(lasttootl, lasttootl-1, "add", gssi);
                //}
                toWriteResult(lasttootl, lastISSI, "add", gssi);
                zt = 0;
                var msg = GetTextByName("ADD_DGNA_FAILURE", useprameters.languagedata);
                var Lang_dtczxxNO = GetTextByName("Lang_dtczxxNO", useprameters.languagedata);
                var Lang_MemberNO_DT = GetTextByName("Lang_MemberNO_DT", useprameters.languagedata);
                writeLog("system", msg + "(" + Lang_dtczxxNO + ":" + gssi + "," + Lang_MemberNO_DT + ":" + issi + ")[" + LOGTimeGet() + "]");//写日志
                window.parent.jquerygetNewData_ajax_post("Handlers/ADDDTCZMember.ashx", { GSSI: gssi, sendDTGissis: issi + "," + zt + ";" }, function (msg) {

                });
            } else if (dtczSendType == dcczSendTypeEnum.del) {
                //if (lastISSI.trim() == issi.trim()) {
                //    toWriteResult(lasttootl, lasttootl-1, "del", gssi);
                //}
                toWriteResult(lasttootl, lastISSI, "del", gssi);
                var msg = GetTextByName("DEL_DGNA_FAILURE", useprameters.languagedata);
                var Lang_dtczxxNO = GetTextByName("Lang_dtczxxNO", useprameters.languagedata);
                var Lang_MemberNO_DT = GetTextByName("Lang_MemberNO_DT", useprameters.languagedata);
                writeLog("system", msg + "(" + Lang_dtczxxNO + ":" + gssi + "," + Lang_MemberNO_DT + ":" + issi + ")[" + LOGTimeGet() + "]");//写日志

            }
            break;
        default:;
    }

}

///立即定位
function LocateAtOnce(issi, content) {
    writeToDbByUserISSI(issi, OperateLogType.operlog, OperateLogModule.ModuleGPS, OperateLogOperType.GPSImmediateSend, content, OperateLogIdentityDeviceType.MobilePhone);
}



function openPullUpContralResultPage() {
    if (document.frames["PullUpControl/PullUpResultList_ifr"] != null || document.frames["PullUpControl/PullUpResultList_ifr"] != undefined) {
        document.frames["PullUpControl/PullUpResultList_ifr"].tohidclosebtn();
    } else {
        mycallfunction('PullUpControl/PullUpResultList', 450, 350);
    }
}
var writePullUpInterval;
function toWritePullUpResult(totalcount, asdfasd) {
    if (document.frames["PullUpControl/PullUpResultList_ifr"] != null || document.frames["PullUpControl/PullUpResultList_ifr"] != undefined || (typeof document.frames["PullUpControl/PullUpResultList_ifr"].toHTML).toString() == "undefined") {
        document.frames["PullUpControl/PullUpResultList_ifr"].toHTML(totalcount, hadDoPullUpcount, issi_pullup_isEnable, cgPullUp, sbPullUp);
        clearInterval(writePullUpInterval);
    } else {
        writePullUpInterval = setInterval(function () { toWritePullUpResult(totalcount, asdfasd); }, 100);
    }
}

var sendpullupcontrolInterval;
var cgPullUp = new Array(); //设置周期
var sbPullUp = new Array();
var cgDistancePullUp = new Array(); //设置距离
var sbDistancePullUp = new Array();
var hadDoPullUpcount = 0;
var allShowedDoPullUpCount = 0;
var issi_pullup_isEnable = "1";  //对终端设置开启还是关闭周期性上拉功能
var isSendingPullUpControl = false;
var isPullUp = true;
var usersInfo = new Array();

//isEnable  1表示开启，0表示关闭
function sendPullUpControl(users, isEnable, times, totleCycle, dest, distance) {
    cgPullUp.length = 0;
    sbPullUp.length = 0;
    allShowedDoPullUpCount = users.length;
    hadDoPullUpcount = 0;
    issi_pullup_isEnable = isEnable.toString();
    usersInfo.length = 0;
    usersInfo = users;
    if (isEnable.toString().trim() == "1") {
        isPullUp = true;
    } else {
        isPullUp = false;
    }
    // var mycounts = new Number(counts);
    var mytime = new Number(times);
    var userscount = users.length;

    openPullUpContralResultPage();
    var scactionX = document.getElementById("SCactionX");
    isSendingPullUpControl = true;
    try {
        var i = 0;
        sendpullupcontrolInterval = setInterval(function () {
            if (i < userscount) {
                var content = "";
                try {
                    var retVar;
                    //如果isPullUp为TRUE应该进行激活，否则去除激活（激活并不是去开启GPS手台开关）
                    if (isPullUp) {   //激活
                        window.parent.jquerygetNewData_ajax_post("Handlers/AddGPSPullParam.ashx", { mtype: "add", srcissi: users[i].uissi, operatetype: "1", expire: totleCycle, period: times, distance: distance, dstissi: dest, gisissi: getCookieByName("dispatchissi"), result: "0", pullstatus: "0" }, function (msg) { });  //将这个上拉的手台初始化到数据库中
                        if (dest.trim() == "") {
                            retVar = scactionX.SendPdtPullGpsActiveRequest(1, times, totleCycle, 0, 1, users[i].uissi, 0, 0, 1, distance);

                        } else {
                            retVar = scactionX.SendPdtPullGpsActiveRequest(1, times, totleCycle, 0, 1, users[i].uissi, dest, 0, 1, distance);
                        }
                    } else {    //去除激活
                        window.parent.jquerygetNewData_ajax_post("Handlers/AddGPSPullParam.ashx", { mtype: "update", srcissi: users[i].uissi, operatetype: "0", expire: totleCycle, period: times, distance: distance, dstissi: dest, gisissi: getCookieByName("dispatchissi"), result: "0", pullstatus: "0" }, function (msg) { });
                        retVar = scactionX.SendPdtPullGpsUnActiveRequest(0, 0, 0, users[i].uissi, dest, times, totleCycle, distance);
                    }
                    if (retVar == 1) { //返回1表示成功下发

                    } else {   //返回0表示下发失败
                        sbPullUp.push(users[i].uissi+"下发失败");
                    }
                } catch (ex) {
                    sbPullUp.push(users[i].uissi + "下发失败");
                    writeLog("system", Lang_PullUp_ContralFaild + ":" + users[i].uissi + ";");
                } finally {
                    toWritePullUpResult(userscount, i); 
                    if (i < userscount - 1) {
                        hadDoPullUpcount++;
                    }
                    i++;
                }
            } else {
                writeLog("system", GetTextByName("Cycle_PullUp_Complete_Finished", useprameters.languagedata))//你发起的GPS上报开关指令执行完毕
                clear_pullupcontral_run();
            }
        }, gpsControlSendSpace);
    } catch (exc) {
        isSendingPullUpControl = false;
    }
}

//周期性上拉,isEnable  1表示开启，0表示关闭
//function sendPullUpControl(users, isEnable, times, totleCycle, dest, distance) {
//    cgPullUp.length = 0;
//    sbPullUp.length = 0;
//    allShowedDoPullUpCount = users.length;
//    hadDoPullUpcount = 0;
//    issi_pullup_isEnable = isEnable.toString();
//    usersInfo.length = 0;
//    usersInfo = users;
//    if (isEnable.toString().trim() == "1") {
//        isPullUp = true;
//    } else {
//        isPullUp = false;
//    }
//    // var mycounts = new Number(counts);
//    var mytime = new Number(times);
//    var userscount = users.length;

//    openPullUpContralResultPage();
//    var scactionX = document.getElementById("SCactionX");
//    isSendingPullUpControl = true;
//    try {
//            for (var i = 0; i < userscount; i++) {
//                var content = "";
//                try {
//                    var retVar;
//                    //如果isPullUp为TRUE应该进行激活，否则去除激活（激活并不是去开启GPS手台开关）。getCookieByName("dispatchissi")    @gisissi,
//                    if (isPullUp) {       //激活
//                        window.parent.jquerygetNewData_ajax_post("Handlers/AddGPSPullParam.ashx", { mtype: "add", srcissi: users[i].uissi, operatetype: "1", expire: totleCycle, period: times, distance: distance, dstissi: dest, gisissi: getCookieByName("dispatchissi"), result: "0", pullstatus: "0" }, function (msg) { });
//                        if (dest.trim() == "") {
//                            retVar = scactionX.SendPdtPullGpsActiveRequest(1, times, totleCycle, 0, 1, users[i].uissi, 0, 0, 1, distance);
//                            //retVar = scactionX.SendPdtPullGpsRequest_New(1,  1, users[i].uissi, 0, getCookieByName("dispatchissi"), times, totleCycle, distance)
//                        } else {
//                            retVar = scactionX.SendPdtPullGpsActiveRequest(1, times, totleCycle, 0, 1, users[i].uissi, dest, 0, 1, distance);
//                            //retVar = scactionX.SendPdtPullGpsRequest_New(1,  1, users[i].uissi, dest, getCookieByName("dispatchissi"), times, totleCycle, distance)
//                        }
//                    } else {      //去除激活
//                        window.parent.jquerygetNewData_ajax_post("Handlers/AddGPSPullParam.ashx", { mtype: "update", srcissi: users[i].uissi, operatetype: "0", expire: totleCycle, period: times, distance: distance, dstissi: dest, gisissi: getCookieByName("dispatchissi"), result: "0", pullstatus: "0" }, function (msg) { });
//                        retVar = scactionX.SendPdtPullGpsUnActiveRequest(0, 0, 1, users[i].uissi, dest, times, totleCycle, distance);
//                        //retVar = scactionX.SendPdtPullGpsRequest_New(0,  1,users[i].uissi, dest, getCookieByName("dispatchissi"), times, totleCycle, distance)
//                    }
//                    if (retVar == 1) {   //返回1表示成功下发

//                    } else {     //返回0表示下发失败
//                        sbPullUp.push(users[i].uissi);
//                    }
//                } catch (ex) {
//                    sbPullUp.push(users[i].uissi);
//                    writeLog("system", Lang_PullUp_ContralFaild + ":" + users[i].uissi + ";");
//                } finally {
//                    toWritePullUpResult(userscount, i);
//                    if (i < userscount - 1) {
//                        hadDoPullUpcount++;
//                    }
//                }
//                if (i % 1 == 0)
//                    sleep(500);
//                else if (i % 50)
//                    sleep(2000);
//            }
//            writeLog("system", GetTextByName("Cycle_PullUp_Complete_Finished", useprameters.languagedata))//你发起的GPS上报开关指令执行完毕
//            //clear_pullupcontral_run();

//    } catch (exc) {
//        isSendingPullUpControl = false;
//    }
//}


function clear_pullupcontral_run() {
    isSendingPullUpControl = false;
    clearInterval(sendpullupcontrolInterval);
    if (document.frames["PullUpControl/PullUpResultList_ifr"] != null || document.frames["PullUpControl/PullUpResultList_ifr"] != undefined) {
        document.frames["PullUpControl/PullUpResultList_ifr"].toshowclosebtn();
    }
}

//休眠函数
function sleep(n) {

    var start = new Date().getTime();

    while (true) if (new Date().getTime() - start > n) break;

}

//通过cookie名获取值
function getCookieByName(cookiename) {
    var arrCookie = document.cookie.split(";");
    for (var arrCookie_i = 0; arrCookie_i < arrCookie.length; arrCookie_i++) {
        var arr = arrCookie[arrCookie_i].split("=");
        if (arr[0] == cookiename) {
            return arr[1];
        }
    }
}


