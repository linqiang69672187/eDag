//ajax调用防止出现返回缓存数据
function TimeGet() {
    var myDate = new Date();
    return "_hours:" + myDate.getHours() + "_minutes:" + myDate.getMinutes() + "_seconds:" + myDate.getSeconds() + "_milliseconds:" + myDate.getMilliseconds();
}
function TimeGet1() {
    var myDate = new Date();
    return  "_seconds:" + myDate.getSeconds() + "_milliseconds:" + myDate.getMilliseconds();
}
//获取系统日期
function GetDate() {
    var myDate = new Date();
    var data = "";
    data += myDate.getYear() + "-";
    data += (myDate.getMonth() + 1) + "-";
    data += myDate.getDate();
    return data;
}
//获取系统小时
function GetHour() {
    var myDate = new Date();
    myDate.getHours();
}
//参数日期参数获取日期格式
function GetmyDate(myDate) {
    var data = "";
    data += myDate.getYear() + "-";
    data += (myDate.getMonth() + 1) + "-";
    data += myDate.getDate();
    return data;
}
var _stsetInterval = window.setInterval;
L.setInterval = function (fRef, mDelay) {
    if (typeof fRef == 'function') {
        var argu = Array.prototype.slice.call(arguments, 2); //截取除前两位的所有参数
        var f = (function () { fRef.apply(null, argu); }); //传入除前两位的所有参数
        return _stsetInterval(f, mDelay);
    }
    return _stsetInterval(fRef, mDelay);
}
var _stsetTimeout = window.setTimeout;
L.setTimeout = function (fRef, mDelay) {
    if (typeof fRef == 'function') {
        var argu = Array.prototype.slice.call(arguments, 2);
        var f = (function () { fRef.apply(null, argu); });
        return _stsetTimeout(f, mDelay);
    }
    return _stsetTimeout(fRef, mDelay);
}
//添加定时器到页面,在状态栏显示时间倒数
//private
function time_theIntervalFun(param) {
    addDelegate(theIntervalFun, param);
    var div1 = document.getElementById("Div1");
    div1.innerHTML = GetTextByName("Title_Welcome", useprameters.languagedata) + " [" + useprameters.usename + "]&nbsp;&nbsp;&nbsp;&nbsp;";//多语言：欢迎您
    div1.title = GetTextByName("Lang_LoginTime", useprameters.languagedata) + ":" + useprameters.logintime + "\r" + GetTextByName("Lang_GPSOnlineCount", useprameters.languagedata) + ":" + useprameters.onlineuse + "\r" + GetTextByName("Lang_CountTime", useprameters.languagedata) + ":" + useprameters.GPSUpdatetime + "\r" + GetTextByName("Lang_etraConnectStatus", useprameters.languagedata) + ":" + useprameters.eTramsg;//多语言：登录时间；GPS在线数；GPS统计时间；eTRA连接状态

}
function titleTimeReciprocal() {
     //  document.title = "距离下次刷新时间：" + (theIntervalFun._titleTimeReciprocalTimeSurplus / 1000) + "秒";
    theIntervalFun._titleTimeReciprocalTimeSurplus = theIntervalFun._titleTimeReciprocalTimeSurplus - 1000;
}
//public
var theIntervalFun = new _theIntervalFun(); //用来添加到定时器的函数
function _theIntervalFun() {
    this._titleTimeReciprocal = null;
    this._titleTimeReciprocalTimeSurplus = null;
    this.status = function (time) {
        theIntervalFun._titleTimeReciprocalTimeSurplus = time;
        if (theIntervalFun._titleTimeReciprocal) {
            window.clearInterval(theIntervalFun._titleTimeReciprocal);
            theIntervalFun._titleTimeReciprocal = null;
        }
        titleTimeReciprocal();
        theIntervalFun._titleTimeReciprocal = setInterval(titleTimeReciprocal, 1000);
    }
    this.stop = function (isExec) {
        if (isExec == "stop") {
            if (theIntervalFun._titleTimeReciprocal) {
                window.clearInterval(theIntervalFun._titleTimeReciprocal);
                theIntervalFun._titleTimeReciprocal = null;
                theIntervalFun._titleTimeReciprocalTimeSurplus = null;
                //                document.title = "距离下次刷新时间：已停止。";
            }
        }
    }
}
var time_Timing = null;
//function setTiming(time) {
//    theIntervalFun.status(time); //读秒定时
//    time_Timing = setInterval(time_theIntervalFun, time); //执行函数定时
//}
//function stopTiming() {
//    if (time_Timing) {
//        theIntervalFun.stop("stop");
//        window.clearInterval(time_Timing);
//    }
//}
function setTiming(time) {
    time_Timing = setInterval(refurbishdata, time); //执行函数定时
}
function stopTiming() {
    window.clearInterval(time_Timing);    
}
function refurbishdata() {
    //调用flex地图刷新函数
    try{
        var mainSWF = document.getElementById("main");
        if (mainSWF) {
            mainSWF.callBackSendRefresh();
        }
    }
    catch(e){
        //alert("refurbishdata" + e);
    }
}