//-警员右键菜单事件        
//选中用户
function MouseMenuEvent() {
   
        //var selecteduser = document.getElementById("Lang_selecteduser");
        //selecteduser.onclick = function () {
        //    if ($(document.getElementById('ifr_callcontent_ifr').contentWindow.document.getElementById('call2')).css("backgroundImage").indexOf("callfinish.png") > 0 || $(document.getElementById('ifr_callcontent_ifr').contentWindow.document.getElementById('call2')).css("backgroundImage").indexOf("receivecall.png") > 0) {
        //        alert(GetTextByName("PleaseEndCalling", useprameters.languagedata));//请结束当前呼叫
        //        return;
        //    }

        //    $("li[id ^= bztp_select_]", document).remove(); //移除选中
        //    useprameters.SelectISSI = []; //清空选中ISSI
        //    useprameters.Selectid = []; //清空选中警员
        //    useprameters.HidedisplayISSI = [];
        //    useprameters.SelectISSI.push(useprameters.rightselectissi);
        //    useprameters.Selectid.push(useprameters.rightselectid);
        //    LayerControl.refurbish();
        //    var layercell = LayerControl.CellGet("Police,0,0", useprameters.rightselectid);
        //    var Lang_user_is_nodisplay = GetTextByName("Lang_user_is_nodisplay", useprameters.languagedata);
        //    //选中;用户

        //    writeLog("oper", "[" + GetTextByName("Selected", useprameters.languagedata) + "]:ISSI(" + useprameters.rightselectissi + ")" + GetTextByName("use", useprameters.languagedata) + "ID:(" + useprameters.rightselectid + ")" + "[" + LOGTimeGet() + "]");         /**日志:操作日志 **/
        //    var ifrs = document.frames["ifr_callcontent"];
        //    ifrs.closebg("click"); //更改呼叫栏的样式

        //    if (layercell) {
        //        ifrs.document.getElementById("scrollarea").innerHTML = GetTextByName("Selected", useprameters.languagedata) + ":" + layercell['Info'];//选中
        //        ifrs.innerhtmltoele("singal3", layercell['Info'].split("(")[0]);
        //        ifrs.innerhtmltoele("singal1", GetTextByName("Def_SelectCallMode", useprameters.languagedata));//选择呼叫模式
        //        ifrs.innerhtmltoele("singal2", layercell.ISSI);

        //        UPcallChgIMG(layercell.ISSI); //判断该警员是否存在上行呼叫请求（组呼、单呼全半双工）
        //        GetGSSIbyISSI(useprameters.rightselectissi);
        //        writeLog("system", GetTextByName("selectOper", useprameters.languagedata) + ":" + layercell['Info'] + "[" + LOGTimeGet() + "]");//选中操作
        //    }
        //    else { alert(Lang_user_is_nodisplay); }
    // }

        //调度业务
               //单呼
        var policemouseMenu = document.getElementById("policemouseMenu");
        var policemouseMenu_ul = policemouseMenu.getElementsByTagName("ul")[0];
        var policemouseMenu_ul_lis = policemouseMenu_ul.getElementsByTagName("li");
        var dispatchopr_ul = policemouseMenu_ul_lis[1].getElementsByTagName("ul")[0];
        var dispatchopr_ul_lis = dispatchopr_ul.getElementsByTagName("li");
        var dispatchopr_ul_lis_len = dispatchopr_ul_lis.length;
        for (var i = 0;i < dispatchopr_ul_lis_len;i++) {
            if (dispatchopr_ul_lis[i].id == "Lang_singlecall") {
                dispatchopr_ul_lis[i].onclick = function () {
                    if (useprameters.callActivexable == false) {
                        alert(GetTextByName("Alert_OcxUnLoad", useprameters.languagedata));
                        return;
                    }
                    if (callPanalISSI != "") {
                        alert(GetTextByName("HassingleCallTobeClose", useprameters.languagedata));//已发起一个单呼，请先结束
                        return;
                    }

                    //var ifrs = document.frames["ifr_callcontent"];
                    if (!checkcallimg(window)) {
                        alert(GetTextByName("HassingleCallTobeClose", useprameters.languagedata));//已发起一个单呼，请先结束
                        return;
                    }
                    if (document.frames["PrivateCall"] != null || document.frames["PrivateCall"] != undefined) {
                        mycallfunction('PrivateCall', 380, 280, 0, 1999);
                    }

                    mycallfunction('PrivateCall', 380, 500, "&type=UID&myid=" + useprameters.rightselectid, 1999);
                    document.getElementById("mouseMenu").style.display = "none";
                }
            }
            if (dispatchopr_ul_lis[i].id == "Lang_groupcall") {
                //组呼
                dispatchopr_ul_lis[i].onclick = function () {
                    if (useprameters.callActivexable == false) {
                        alert(GetTextByName("Alert_OcxUnLoad", useprameters.languagedata));
                        return;
                    }
                    mycallfunction('GroupCall', 380, 500, "&type=UID&myid=" + useprameters.rightselectid, 1999);
                    document.getElementById("mouseMenu").style.display = "none";
                }
            }
            //紧急呼叫
            if (dispatchopr_ul_lis[i].id == "Lang_EmergencyCall") {
                dispatchopr_ul_lis[i].onclick = function () {
                    if (useprameters.callActivexable == false) {
                        alert(GetTextByName("Alert_OcxUnLoad", useprameters.languagedata));
                        return;
                    }
                    mycallfunction('PPCCall', 450, 370, "&type=UID&myid=" + useprameters.rightselectid, 1999);
                    document.getElementById("mouseMenu").style.display = "none";
                }
            }
            //遥启遥毙
            if (dispatchopr_ul_lis[i].id == "Lang_YAOQIYAOBI") {
                dispatchopr_ul_lis[i].onclick = function () {
                    if (useprameters.callActivexable == false) {
                        alert(GetTextByName("Alert_OcxUnLoad", useprameters.languagedata));
                        return;
                    }
                    mycallfunction('EnableDisableRadio', 450, 370, "&type=UID&myid=" + useprameters.rightselectid, 1999);
                    document.getElementById("mouseMenu").style.display = "none";
                }
            }
            //慎密监听
            if (dispatchopr_ul_lis[i].id == "Lang_CloseMonitoring") {
                dispatchopr_ul_lis[i].onclick = function () {
                    if (useprameters.callActivexable == false) {
                        alert(GetTextByName("Alert_OcxUnLoad", useprameters.languagedata));
                        return;
                    }
                    mycallfunction('DLCall', 450, 370, "&type=UID&myid=" + useprameters.rightselectid, 1999);
                    document.getElementById("mouseMenu").style.display = "none";
                }
            }
            //环境监听
            if (dispatchopr_ul_lis[i].id == "Lang_EnvironmentalMonitoring") {
                dispatchopr_ul_lis[i].onclick = function () {
                    if (useprameters.callActivexable == false) {
                        alert(GetTextByName("Alert_OcxUnLoad", useprameters.languagedata));
                        return;
                    }
                    mycallfunction('ALCall', 450, 370, "&type=UID&myid=" + useprameters.rightselectid, 1999);
                    document.getElementById("mouseMenu").style.display = "none";
                }
            }

        }
    //应用业务    
        var ApplicationService = document.getElementById("Lang_ApplicationService");
        var ApplicationService_ul = ApplicationService.getElementsByTagName("ul")[0];
        var ApplicationService_ul_lis = ApplicationService_ul.getElementsByTagName("li");
        var ApplicationService_ul_lis_len = ApplicationService_ul_lis.length;
        for (var jh = 0; jh < ApplicationService_ul_lis_len; jh++) {
            if (ApplicationService_ul_lis[jh].id == "Lang_Location") {
                ApplicationService_ul_lis[jh].onclick = function () {
                    locationbyUseid(useprameters.rightselectid);
                    document.getElementById("mouseMenu").style.display = "none";
                }
            }
            //实时轨迹
            if (ApplicationService_ul_lis[jh] && ApplicationService_ul_lis[jh].id == "Text_OpenRealTimeTrajectory") {
                ApplicationService_ul_lis[jh].onclick = function () {                    
                    //实时轨迹
                    var openRealtimeTrace = GetTextByName("Text_OpenRealTimeTrajectory", useprameters.languagedata);
                    var closeRealtimeTrace = GetTextByName("Text_CloseRealTimeTrajectory", useprameters.languagedata);
                    if (event.srcElement.innerHTML == openRealtimeTrace) {
                        event.srcElement.innerHTML = closeRealtimeTrace;
                        mycallfunction('manager_selectcolor', 440, 354, useprameters.rightselectid + "&ISSI=" + useprameters.rightselectissi, 1999);
                        addIdTorealtimeTraceUserIds(useprameters.rightselectid);
                        document.getElementById("mouseMenu").style.display = "none";
                        return;
                    }
                    if (event.srcElement.innerHTML == closeRealtimeTrace) {
                        event.srcElement.innerHTML = openRealtimeTrace;
                        closePerRealtimeTrace(useprameters.rightselectissi,useprameters.rightselectid);
                        removeIdTorealtimeTraceUserIds(useprameters.rightselectid,true);
                        document.getElementById("mouseMenu").style.display = "none";
                        return;
                    }
                }
            }
            //历史轨迹
            if (ApplicationService_ul_lis[jh] && ApplicationService_ul_lis[jh].id == "Lang_HistoricalTrace") {            
                ApplicationService_ul_lis[jh].onclick = function () {                    
                    mycallfunction('SubmitToHistory', 450, 370, useprameters.rightselectid, 1999);
                    document.getElementById("mouseMenu").style.display = "none";
                }
            }
            //电子栅栏
            if (ApplicationService_ul_lis[jh] && ApplicationService_ul_lis[jh].id == "Lang_Stack") {
            
                ApplicationService_ul_lis[jh].onclick = function () {
                    
                    mycallfunction('path_selectcolor', 450, 370, useprameters.rightselectid, 1999);
                    document.getElementById("mouseMenu").style.display = "none";
                }
            }

            if (ApplicationService_ul_lis[jh] && ApplicationService_ul_lis[jh].id == "locked") {
                ApplicationService_ul_lis[jh].onclick = function () {
                    //锁定
                    var locked = GetTextByName("Lang_Lock", useprameters.languagedata);
                    var unlocked = GetTextByName("Lang_unlocked", useprameters.languagedata);
                    if (event.srcElement.innerHTML == locked) {
                        event.srcElement.innerHTML = unlocked;
                        lock_it(useprameters.rightselectid);
                        document.getElementById("mouseMenu").style.display = "none";
                        return;
                    }
                    if (event.srcElement.innerHTML == unlocked) {
                        event.srcElement.innerHTML = locked;
                        lock_it(useprameters.rightselectid);
                        document.getElementById("mouseMenu").style.display = "none";
                        return;
                    }
                }        
            }
            if (ApplicationService_ul_lis[jh].id == "Lang_concern") {
                ApplicationService_ul_lis[jh].onclick = function () {
                    //关注
                    var concern = GetTextByName("Lang_concern", useprameters.languagedata);
                    var unconcern = GetTextByName("Lang_unconcern", useprameters.languagedata);
                    if (event.srcElement.innerHTML == concern) {
                        event.srcElement.innerHTML = unconcern;
                        Addusertoconcernlist(useprameters.rightselectid);
                        document.getElementById("mouseMenu").style.display = "none";
                        return;
                    }
                    if (event.srcElement.innerHTML == unconcern) {
                        event.srcElement.innerHTML = concern;
                        Deleteuserfromconcernlist(useprameters.rightselectid);
                        document.getElementById("mouseMenu").style.display = "none";
                        return;
                    }
                }
            }
            //视频调度
            if (ApplicationService_ul_lis[jh] && ApplicationService_ul_lis[jh].id == "Lang_videoDispatch") {
                ApplicationService_ul_lis[jh].onclick = function () {
                    if (useprameters.callActivexable == false) {
                        //alert(GetTextByName("Alert_OcxUnLoad", useprameters.languagedata));
                        //return;
                    }
                    mycallfunction('viewLTECamera', 550, 570,1999);
                    document.getElementById("mouseMenu").style.display = "none";
                }
            }
            //卫星数
            if (ApplicationService_ul_lis[jh] && ApplicationService_ul_lis[jh].id == "Lang_Weixingshu") {
                ApplicationService_ul_lis[jh].onclick = function () {
                    if (useprameters.callActivexable == false) {
                        //alert(GetTextByName("Alert_OcxUnLoad", useprameters.languagedata));
                        //return;
                    }
                    
                    document.getElementById("mouseMenu").style.display = "none";
                }
            }
        }
        //无效终端应用业务    
        var ApplicationService_invalide = document.getElementById("Lang_ApplicationService_invalide");
        var ApplicationService_invalide_ul = ApplicationService_invalide.getElementsByTagName("ul")[0];
        var ApplicationService_invalide_ul_lis = ApplicationService_invalide_ul.getElementsByTagName("li");
        var ApplicationService_invalide_ul_lis_len = ApplicationService_invalide_ul_lis.length;
        for (var jh = 0; jh < ApplicationService_invalide_ul_lis_len; jh++) {
            if (ApplicationService_invalide_ul_lis[jh] && ApplicationService_invalide_ul_lis[jh].id == "Lang_HistoricalTrace_invalide") {
                ApplicationService_invalide_ul_lis[jh].onclick = function () {
                    mycallfunction('SubmitToHistory', 450, 370, useprameters.rightselectid, 1999);
                    document.getElementById("mouseMenu").style.display = "none";
                }
            }
        }
    //个人短信
        var smsopr = document.getElementById("Lang_smsopr");
        var smsopr_ul = smsopr.getElementsByTagName("ul")[0];
        var smsopr_ul_lis = smsopr_ul.getElementsByTagName("li");
        var smsopr_ul_lis_len = smsopr_ul_lis.length;
        for (var k = 0; k < smsopr_ul_lis_len; k++) {
            if (smsopr_ul_lis[k].id == "Lang_generalsms") {
                smsopr_ul_lis[k].onclick = function () {
                    if (useprameters.callActivexable == false) {
                        alert(GetTextByName("checkcallcontrolregister", useprameters.languagedata));//checkcallcontrolregister
                        return;
                    }
                    mycallfunction('Send_SMS', 380, 400, useprameters.rightselectid, 1999);
                    document.getElementById("mouseMenu").style.display = "none";
                }
            }
            if (smsopr_ul_lis[k].id == "Lang_groupsms") {
                //小组短信
                smsopr_ul_lis[k].onclick = function () {
                    if (useprameters.callActivexable == false) {
                        alert(GetTextByName("checkcallcontrolregister", useprameters.languagedata));//checkcallcontrolregister
                        return;
                    };
                    mycallfunction('Send_SMS', 380, 400, useprameters.rightselectid + "&cmd=G", 1999);
                    document.getElementById("mouseMenu").style.display = "none";
                }
            }
            //状态信息
            if (smsopr_ul_lis[k].id == "Lang_Status_message") {
                smsopr_ul_lis[k].onclick = function () {
                    if (useprameters.callActivexable == false) {
                        alert(GetTextByName("checkcallcontrolregister", useprameters.languagedata));//checkcallcontrolregister
                        return;
                    }
                    mycallfunction('Send_StatusMS', 380, 400, useprameters.rightselectid, 1999);
                    document.getElementById("mouseMenu").style.display = "none";
                }
            }
        }
        //<%--小组右键菜单事件--%>
        //组呼
        document.getElementById("Lang_smallGroupCall").onclick = function () {
            if (useprameters.callActivexable == false) {
                alert(GetTextByName("checkcallcontrolregister", useprameters.languagedata));//checkcallcontrolregister
                return;
            }
            mycallfunction('GroupCall', 380, 500, '&type=GSSI&myid=' + useprameters.rightselectid, 1999);
        }
        //小组短信
        document.getElementById("Lang_groupgroupsms").onclick = function ()
        {
            if (useprameters.callActivexable == false) {
                alert(GetTextByName("checkcallcontrolregister", useprameters.languagedata));//checkcallcontrolregister
                return;
            }
            mycallfunction('Send_SMS', 380, 400, useprameters.rightselectid + '&cmd=GSSI', 1999);
        }
        //状态信息
        document.getElementById("Lang_groupstatussms").onclick = function () {
            if (useprameters.callActivexable == false) {
                alert(GetTextByName("checkcallcontrolregister", useprameters.languagedata));//checkcallcontrolregister
                return;
            };
            mycallfunction('Send_StatusMS', 380, 400, useprameters.rightselectid + '&cmd=GSSI', 1999);
        }
    //声音控制
        document.getElementById("Lang_volumeControl").onclick = function () {
            if (useprameters.callActivexable == false) {
                alert(GetTextByName("checkcallcontrolregister", useprameters.languagedata));//checkcallcontrolregister
                return;
            }
            //声音
            var openVoice = GetTextByName("Lang_openVoice", useprameters.languagedata);
            var mute = GetTextByName("Lang_mute", useprameters.languagedata);
            if (event.srcElement.innerHTML == openVoice) {                
                var reVal = changeVoiceByGroupISSI(useprameters.rightselectid, 100);
                if (reVal == 1) {
                    removeFromMuteGroupList(useprameters.rightselectid);
                    document.frames["mypancallContent"].document.frames["groupcallContent"].tongbuvoiceImgByGSSI(useprameters.rightselectid,false);
                    event.srcElement.innerHTML = mute;
                }
                else{
                    var Operationfails = GetTextByName("Operationfails", useprameters.languagedata);//操作失败
                    alert(Operationfails);
                }
                document.getElementById("mouseMenu").style.display = "none";
                return;
            }
            else if (event.srcElement.innerHTML == mute) {                
                var reVal = changeVoiceByGroupISSI(useprameters.rightselectid, 0);
                if (reVal == 1) {
                    addToMuteGroupList(useprameters.rightselectid);
                    document.frames["mypancallContent"].document.frames["groupcallContent"].tongbuvoiceImgByGSSI(useprameters.rightselectid, true);
                    event.srcElement.innerHTML = openVoice;
                }
                else {
                    var Operationfails = GetTextByName("Operationfails", useprameters.languagedata);//操作失败
                    alert(Operationfails);
                }
                document.getElementById("mouseMenu").style.display = "none";
                return;
            }
        }
        //<%--调度台右键菜单事件--%>
        //单呼
        document.getElementById("Lang_dispatchsinglecall").onclick = function () {
            if (useprameters.callActivexable == false) {
                alert(GetTextByName("checkcallcontrolregister", useprameters.languagedata));//checkcallcontrolregister
                return;
            }
            mycallfunction('PrivateCall', 380, 500, '&type=Dispatch&myid=' + useprameters.rightselectid, 1999);
        }
        //短信
        document.getElementById("Lang_dispatchsms").onclick = function () {
            if (useprameters.callActivexable == false) {
                alert(GetTextByName("checkcallcontrolregister", useprameters.languagedata));//checkcallcontrolregister
                return
            };
            mycallfunction('Send_SMS', 380, 400, useprameters.rightselectid + '&cmd=DISSI', 1999);
        }
        //状态信息
        document.getElementById("Lang_dispatchstatussms").onclick = function () {
            if (useprameters.callActivexable == false) {
                alert(GetTextByName("checkcallcontrolregister", useprameters.languagedata));//checkcallcontrolregister
                return;
            };
            mycallfunction('Send_StatusMS', 380, 400, useprameters.rightselectid + '&cmd=DISSI', 1999);
        }
        //金融护卫
        document.getElementById("LiCarSingleCall").onclick = function () {
            if (useprameters.callActivexable == false) {
                alert(GetTextByName("checkcallcontrolregister", useprameters.languagedata));//checkcallcontrolregister
                return;
            };
            mycallfunction('PrivateCall', 380, 500, '&type=ISSI&myid=' + car_duty_issi_selected, 1999);
            document.getElementById("mouseMenu").style.display = "none";
        }
        document.getElementById("LiCarSMS").onclick = function () {
            if (useprameters.callActivexable == false) {
                alert(GetTextByName("checkcallcontrolregister", useprameters.languagedata));//checkcallcontrolregister
                return;
            };
            mycallfunction('Send_SMS', 380, 400, car_duty_uid_selected, 1999);
            document.getElementById("mouseMenu").style.display = "none";
        }
        document.getElementById("LiCarLocate").onclick = function () {
            locationbyUseid(car_duty_uid_selected);
            document.getElementById("mouseMenu").style.display = "none";
            //定位
        }
}
function closePerRealtimeTrace(issi, id) {
    try{
        var mainSWF = document.getElementById("main");
        if (mainSWF) {       
            mainSWF.callbackCloseRealtimetrace(issi, id);
        }
    }
    catch (e) {

    }
}
function addIdTorealtimeTraceUserIds(id) {
    var isIn = isInRealtimeTraceUserIds(id, useprameters.realtimeTraceUserIds);
    if (!isIn) {
        useprameters.realtimeTraceUserIds.push(id);
    }
}
function isInRealtimeTraceUserIds(id, Ids) {
    for (var i = 0; i < Ids.length; i++) {
        if (Ids[i] == id) {
            return true;
        }
    }
    return false;
}
function removeIdTorealtimeTraceUserIds(id,isRemoveData) {
    var Ids = useprameters.realtimeTraceUserIds;
    for (var i = 0; i < Ids.length; i++) {
        if (Ids[i] == id) {
            RemoveRealtimeTrace_line(id, isRemoveData);
            if (isRemoveData) {
                useprameters.realtimeTraceUserIds.splice(i, 1);
                RealTimeTraceArray.forEach(function (val, j) {
                    if (val.id == id) {
                        RealTimeTraceArray.splice(j, 1);
                    }
                });
            }
        }
    }
}
function changeVoiceByGroupISSI(issi, voice) {
    var reVal = -1;
    var scactionX = document.frames['log_windows_ifr'].document.getElementById('SCactionX');
    if (scactionX) {
        if (useprameters.callActivexable) {
            try {
                if (voice == 0) {
                    //关闭声音
                    reVal = scactionX.VolumeControl(4, issi, 0);
                }
                else if (voice > 0 && voice <= 100) {
                    //打开声音 
                    reVal = scactionX.VolumeControl(4, issi, 100);
                }
            }
            catch (ex) {
                reVal = 0;

            }
        }
        else {
            alert(GetTextByName("checkcallcontrolregister", useprameters.languagedata));
        }
    }
    else {
        alert(GetTextByName("Callcontrolisnotavailable", useprameters.languagedata));
    }    
    return reVal;
}
function removeFromMuteGroupList(GSSI) {
    for (var i = 0; i < useprameters.muteGroupList.length; i++) {
        if (GSSI == useprameters.muteGroupList[i]) {
            useprameters.muteGroupList.splice(i, 1);
            break;
        }
    }
}
function addToMuteGroupList(GSSI) {
    if (isNotinMuteGroupList(GSSI)) {
        useprameters.muteGroupList.push(GSSI);
    }
}
function isNotinMuteGroupList(GSSI) {
        var isNotIn = true;
        for (var i = 0; i < useprameters.muteGroupList.length; i++) {
            if (GSSI == useprameters.muteGroupList[i]) {
                isNotIn = false;
                break;
            }
        }
        return isNotIn;    
}