var isBrowser = function (vision) {
    if (typeof vision == 'undefiend')
        return false;
    vision = vision.toUpperCase();
    var isIE = !!window.ActiveXObject;
    var isIE6 = isIE && !window.XMLHttpRequest;
    var isIE8 = isIE && !!document.documentMode;
    var isIE7 = isIE && !isIE6 && !isIE8;
    if (isIE) {
        if (isIE6) {
            return vision === 'IE6';
        } else if (isIE8) {
            return vision === 'IE8';
        } else if (isIE7) {
            return vision === 'IE7';
        }
        else if (isIE9) {
            return vision === 'IE9';
        }
        else if (isIE10) {
            return vision === 'IE10';
        }

    }
    else {
        return vision === 'FF';
    }
}

window.onbeforeunload = function () {
    if (document.body) {
        if (event.clientX > document.body.clientWidth && event.clientY < 0 || event.altKey) {
            //  window.event.returnValue = "建议使用系统退出按钮！";
        }
    }
}

//$(document).ready(function () {
//   


//});
var useprameters = {};

useprameters.lockid = 0;
useprameters.nowtrace = []; //轨迹样式，条数
useprameters.Selectid = []; //选中警员ID
useprameters.SelectISSI = []; //选中ISSI
useprameters.SelectGSSI; //选中GSSI
useprameters.UPCall = [];
useprameters.vmlname; //轨迹线名称
useprameters.hostISSI; //本调度台ISSI
useprameters.callActivexable //是否能呼叫
useprameters.lockpcmove = false; //锁定警员是否正在移动状态
useprameters.keyiIsUP = true; //空格键状态
useprameters.multiSel = false;
useprameters.HidedisplayISSI = []; //隐藏ISSI
useprameters.device_timeout = 5;
useprameters.hide_timeout_device = false;//是否隐藏不在线终端
useprameters.refresh_map_interval = 10;
useprameters.movecellID = 0; //鼠标到移动用户上时的警员ID
useprameters.eTramsg = "";
useprameters.dispName = "";
useprameters.usename = "";
useprameters.useentity = "";
useprameters.onlineuse = 0;
useprameters.IsloadMapin = false;
useprameters.IsreloadMapin = false;
useprameters.languagedata = [];
useprameters.concernusers_string = "";
useprameters.concernusers_array =[];
useprameters.isHideOfflineUserBySelect = "True"; //框选时是否隐藏不在线警员
useprameters.realtimeTraceUserIds = [];
useprameters.rightselectTerminalType = "";
useprameters.rightselectTerminalIsValide = "1";
useprameters.userHeadInfo = "";
useprameters.isHideClosedisplayUserBySelect = "False"; //框选时是否展示隐藏警员
useprameters.userHeadInfo_StatuesMode="";
useprameters.muteGroupList = new Array();//存放静音的GSSI
useprameters.isAllMute = false;
useprameters.voiceType = 1;
useprameters.IsOpenUserHeaderInfo = ""; //用户头顶信息显示开关
useprameters.Bubble_information = "";//气泡信息



function HidedisplayISSI(ISSI) {
    if (isinarray(ISSI, useprameters.HidedisplayISSI))
        return;
    useprameters.HidedisplayISSI.push(ISSI);
}
function setuseparameter(device_timeout, hide_timeout_device, refresh_map_interval, isdisplayinfo, userHeadInfo, userHeadInfo_statueMode, voiceType, IsOpenUserHeaderinfo, Kilometres, GroupShortKey, UsermessageKey, CallEncryption) {
    try {
        useprameters.CallEncryption = CallEncryption;//xzj--20190320--添加呼叫加密参数修改
        useprameters.device_timeout = device_timeout;
        useprameters.hide_timeout_device = hide_timeout_device;
        useprameters.refresh_map_interval = refresh_map_interval;
        //isPoliceInfoShow((isdisplayinfo == "True"));
        useprameters.displayinfo = (isdisplayinfo == "True");
        useprameters.userHeadInfo = userHeadInfo;
        useprameters.userHeadInfo_StatuesMode = userHeadInfo_statueMode;
        useprameters.IsOpenUserHeaderInfo = IsOpenUserHeaderinfo;
        useprameters.CKBKKilometres = Kilometres;
        useprameters.GroupShortKey = GroupShortKey;
        useprameters.Bubble_information = UsermessageKey;//气泡信息
  
        //setdevice_timeout_flex(useprameters.device_timeout);
        //sethide_timeout_device_flex(useprameters.hide_timeout_device);
        sethide_timeout_device(useprameters.hide_timeout_device);

        //setuserHeadInfo_flex(useprameters.userHeadInfo);
        //setuserHeadInfo_mode_flex(useprameters.userHeadInfo_StatuesMode);

        //设置语音类型
        setVoiceType(voiceType);
        var isHideOfflineTerminal = "";
        if (hide_timeout_device == "True") {
            isHideOfflineTerminal = GetTextByName("Lang_Yes", useprameters.languagedata);
        }
        else {
            isHideOfflineTerminal = GetTextByName("Lang_No", useprameters.languagedata);
        }
//xzj--20190320--添加呼叫加密参数设置日志
var callEncryptionArr = CallEncryption.split('|');
var callEnctyptionMsg="";
for (var i = 0; i < callEncryptionArr.length; i++)
{
    if (callEncryptionArr[i]=="Single")
    {
        callEnctyptionMsg += GetTextByName("SingleCall", useprameters.languagedata);
        continue;
    }
    if (callEncryptionArr[i] == "Group") {
        if (callEnctyptionMsg != "")
        {
            callEnctyptionMsg += ",";
        }
        callEnctyptionMsg += GetTextByName("smallGroupCall", useprameters.languagedata);
        continue;
    }
}
if (callEnctyptionMsg == "")
{
    callEnctyptionMsg = GetTextByName("Lang-None", useprameters.languagedata)
}
//多语言：参数设置；终端超时；分；隐藏不在线终端；地图刷新时间；秒；显示详细信息;查询布控公里数
writeLog("oper", "[" + GetTextByName("Parametersetting", useprameters.languagedata) + "]:" + GetTextByName("DeviceOverTime", useprameters.languagedata) + "(" + device_timeout + GetTextByName("Minute", useprameters.languagedata) + ")," + GetTextByName("HiddenOfflineDevice", useprameters.languagedata) + "(" + isHideOfflineTerminal + ")," + GetTextByName("MapFreshTime", useprameters.languagedata) + "(" + refresh_map_interval + GetTextByName("Sencond", useprameters.languagedata) + ")," + GetTextByName("ViewInfo", useprameters.languagedata) + "(" + isdisplayinfo + ")[" + LOGTimeGet() + "]" + "," + GetTextByName("CXBKkms", useprameters.languagedata) + "(" + Kilometres + GetTextByName("Kilometre", useprameters.languagedata) + ")" + "," + GetTextByName("callEncryption", useprameters.languagedata) + "(" + callEnctyptionMsg + ")");         /**日志：操作日志 **/

        var refreshtime = document.getElementById("refreshtime");
        refreshtime.value = refresh_map_interval;
       
    }
    catch (e) {
        alert("setuseparameter" + e);
    }
    }