var callPanalISSI = ""; //全局变量 操作窗口中正在呼叫的ISSI号码

var isPanalALCall = false; //操作窗口中是否有环境监听

var isPanalDLCall = false; //操作窗口中是否有慎密监听

var isPanalBSCall = false; //操作窗口中是否有基站类呼叫了

var isBegSendMsgSel = false; //是否开始短信框选用户了

var isBegStackadeSel = false; //是否开始电子栅栏画图了

var PanalPPCCallISSI = ""; //全局变量，操作窗口中正在紧急呼叫的ISSI号码

var GetRandomNum = function (Min, Max) {
//    var Range = Max - Min;
//    var Rand = Math.random();
    //    return (Min + Math.round(Rand * Range));
//    var guid = "";
//    for (var i = 1; i <= 32; i++) {
//        var n = Math.floor(Math.random() * 16.0).toString(16);
//        guid += n;
//        if ((i == 8) || (i == 12) || (i == 16) || (i == 20))
//            guid += "-";
//    }
//    return guid;    
    var varNow = new Date();

    return varNow.getYear().toString() + varNow.getMonth().toString() + varNow.getDay().toString() + varNow.getHours().toString() + varNow.getMinutes().toString() + varNow.getSeconds().toString() + varNow.getMilliseconds().toString();

}   
