///LanguageXMLToJson.js
///获取多语言

function GetTextByName(name, array) {
    if (array == undefined) {
        array = window.parent.useprameters.languagedata;
    }
    var array_length = array.length;
    for (var i = 0; i < array_length; i++) {
        if (name == array[i]["@name"])
            return array[i]["#text"];
    }
    return "Nodata";
}

//default.aspx开始
///下拉菜单多语言设置
function SetDefaultLang() {
    document.title = GetTextByName("WebGisTitle", useprameters.languagedata);
    if (document.getElementById("jichuxx")) {//基础信息标题
        document.getElementById("jichuxx").innerHTML += GetTextByName("Basicinformation", useprameters.languagedata);
    }
    if (document.getElementById("danweixinxiweihu")) {//单位信息标题
        document.getElementById("danweixinxiweihu").innerHTML += GetTextByName("Unitofinformationmaintenance", useprameters.languagedata);
    }
    if (document.getElementById("zhongduanxinxiweihu")) {//终端信息维护
        document.getElementById("zhongduanxinxiweihu").innerHTML += GetTextByName("Terminalinformationmaintenance", useprameters.languagedata);
    }
    if (document.getElementById("ydyhxinxiweihu")) {//用户信息维护
        document.getElementById("ydyhxinxiweihu").innerHTML += GetTextByName("Userinformationmaintenance", useprameters.languagedata);
    }
    if (document.getElementById("ddyxxwh")) {//调度用户信息维护
        document.getElementById("ddyxxwh").innerHTML += GetTextByName("Dispatcherinformationmaintenance", useprameters.languagedata);
    }
    if (document.getElementById("ddyjswh")) {//调度用户角色维护
        document.getElementById("ddyjswh").innerHTML += GetTextByName("DispatcherRolemaintenance", useprameters.languagedata);
    }
    if (document.getElementById("configuser")) {//配置用户信息维护
        document.getElementById("configuser").innerHTML += GetTextByName("configuserinformationmaintenance", useprameters.languagedata);
    }
    if (document.getElementById("ddtxxwh")) {//调度台信息维护
        document.getElementById("ddtxxwh").innerHTML += GetTextByName("Schedulinginformationmaintenance", useprameters.languagedata);
    }
    if (document.getElementById("dzzlxxwh")) {//电子栅栏信息维护
        document.getElementById("dzzlxxwh").innerHTML += GetTextByName("Electronicfenceinformationmaintenance", useprameters.languagedata);
    }
    if (document.getElementById("yhlxxxwh")) {//用户类型信息维护
        document.getElementById("yhlxxxwh").innerHTML += GetTextByName("Usertypeinformationmaintenance", useprameters.languagedata);
    }
    if (document.getElementById("jzxxwh")) {//基站信息维护
        document.getElementById("jzxxwh").innerHTML += GetTextByName("stationinformationmaintenance", useprameters.languagedata);
    }
    if (document.getElementById("bzxx")) {//编组信息维护
        document.getElementById("bzxx").innerHTML += GetTextByName("Marshallinginformation", useprameters.languagedata);
    }
    if (document.getElementById("xzxxwh")) {//小组信息维护
        document.getElementById("xzxxwh").innerHTML += GetTextByName("Groupinformationmaintenance", useprameters.languagedata);
    }
    if (document.getElementById("tbzxxwh")) {//通播组信息维护
        document.getElementById("tbzxxwh").innerHTML += GetTextByName("multicastgroupinformationmaintenance", useprameters.languagedata);
    }
    if (document.getElementById("pjzxxwh")) {//派接组信息维护
        document.getElementById("pjzxxwh").innerHTML += GetTextByName("PJgroupinformationmaintenance", useprameters.languagedata);
    }
    if (document.getElementById("jzzxxwh")) {//基站组信息维护
        document.getElementById("jzzxxwh").innerHTML += GetTextByName("JZgroupinformationmaintenance", useprameters.languagedata);
    }
    if (document.getElementById("dxzxxwh")) {//多选组信息维护
        document.getElementById("dxzxxwh").innerHTML += GetTextByName("DXgroupinformationmaintenance", useprameters.languagedata);
    }
    if (document.getElementById("myMsgSend")) {//短信群发
        document.getElementById("myMsgSend").innerHTML += GetTextByName("MultiShortmessage", useprameters.languagedata);
    }
    if (document.getElementById("ddgn")) {//调度功能
        document.getElementById("ddgn").innerHTML += GetTextByName("Schedulingfunction", useprameters.languagedata);
    }
    if (document.getElementById("hjmb")) {//操作窗口
        document.getElementById("hjmb").innerHTML += GetTextByName("Lang_Callpanel", useprameters.languagedata);
    }
    if (document.getElementById("options")) {//设置
        document.getElementById("options").innerHTML += GetTextByName("Parametersetting", useprameters.languagedata);
    }
    if (document.getElementById("helps")) {//帮助
        document.getElementById("helps").innerHTML += GetTextByName("help", useprameters.languagedata);
    }
    if (document.getElementById("helpFaq")) {//操作手册
        document.getElementById("helpFaq").innerHTML += GetTextByName("Operationmanual", useprameters.languagedata);
    }
    if (document.getElementById("about")) {//关于
        document.getElementById("about").innerHTML += GetTextByName("AboutThisplant", useprameters.languagedata);
    }
    if (document.getElementById("myloginout")) {//退出系统
        document.getElementById("myloginout").innerHTML += GetTextByName("loginout", useprameters.languagedata);
    }
    if (document.getElementById("refreshtimes")) {//刷新周期
        document.getElementById("refreshtimes").innerHTML = GetTextByName("RefreshTime", useprameters.languagedata);
    }
    if (document.getElementById("sencond")) {//秒
        document.getElementById("sencond").innerHTML = GetTextByName("Sencond", useprameters.languagedata);
    }
    if (document.getElementById("cloose")) {//框选
        document.getElementById("cloose").title = GetTextByName("Selectionof", useprameters.languagedata);
    }
    if (document.getElementById("imgrang")) {//测距
        document.getElementById("imgrang").title = GetTextByName("Distancemeasurement", useprameters.languagedata);
    }
    if (document.getElementById("zoomin")) {//缩小
        document.getElementById("zoomin").title = GetTextByName("ZoomIn", useprameters.languagedata);
    }
    if (document.getElementById("zoomout")) {//放大
        document.getElementById("zoomout").title = GetTextByName("ZoomOut", useprameters.languagedata);
    }
    if (document.getElementById("pingmiandt")) {
        document.getElementById("pingmiandt").title = GetTextByName("Switchplanemap", useprameters.languagedata);
    }
    if (document.getElementById("pingmiandt")) {
        document.getElementById("pingmiandt").innerHTML = GetTextByName("planemap", useprameters.languagedata);
    }
    if (document.getElementById("weixdt")) {
        document.getElementById("weixdt").title = GetTextByName("Switchsatellitemap", useprameters.languagedata);
    }
    if (document.getElementById("weixdt")) {
        document.getElementById("weixdt").innerHTML = GetTextByName("satellitemap", useprameters.languagedata);
    }
    if (document.getElementById("GDTXXWH")) {
        document.getElementById("GDTXXWH").innerHTML += GetTextByName("GDTXXWH", useprameters.languagedata);
    }
    if (document.getElementById("gpslist")) {
        document.getElementById("gpslist").innerHTML += GetTextByName("Lang_GPSList", useprameters.languagedata);
    } 
    if (document.getElementById("GPSPullList")) {
        document.getElementById("GPSPullList").innerHTML += GetTextByName("Lang_GPSPullList", useprameters.languagedata);
    }
    if (document.getElementById("sms_sjx")) {
        document.getElementById("sms_sjx").innerHTML += GetTextByName("Lang_DXSJX", useprameters.languagedata);
    }
    if (document.getElementById("operationlog")) {
        document.getElementById("operationlog").innerHTML += GetTextByName("Lang_OperationLog", useprameters.languagedata);
    }

    if (document.getElementById("rzxx")) {
        document.getElementById("rzxx").innerHTML += GetTextByName("Log", useprameters.languagedata);
    }
    if (document.getElementById("sysLog_Menu")) {
        document.getElementById("sysLog_Menu").innerHTML += GetTextByName("sysLog_Menu", useprameters.languagedata);
    }
    if (document.getElementById("operLog_Menu")) {
        document.getElementById("operLog_Menu").innerHTML += GetTextByName("operLog_Menu", useprameters.languagedata);
    }
    if (document.getElementById("callLog_Menu")) {
        document.getElementById("callLog_Menu").innerHTML += GetTextByName("callLog_Menu", useprameters.languagedata);
    }
    if (document.getElementById("smsLog_Menu")) {
        document.getElementById("smsLog_Menu").innerHTML += GetTextByName("smsLog_Menu", useprameters.languagedata);
    }
    if (document.getElementById("errorLog_Menu")) {
        document.getElementById("errorLog_Menu").innerHTML += GetTextByName("errorLog_Menu", useprameters.languagedata);
    }
    if (document.getElementById("dtczxx")) {
        document.getElementById("dtczxx").innerHTML += GetTextByName("dtczxx", useprameters.languagedata);
    }
    if (document.getElementById("dtczrestlt")) {
        document.getElementById("dtczrestlt").innerHTML += GetTextByName("dtczxx", useprameters.languagedata);
    }
    if (document.getElementById("logconfig")) {
        document.getElementById("logconfig").innerHTML += GetTextByName("Lang_logConfig", useprameters.languagedata);
    }
    
    //金融护卫
    if (document.getElementById("car_duty")) {
        document.getElementById("car_duty").innerHTML += GetTextByName("Lang_djbbtj", useprameters.languagedata);//单键报备统计
    }
    if (document.getElementById("Lang_djbbtj")) {
        document.getElementById("Lang_djbbtj").innerHTML += GetTextByName("Lang_djbbtj", useprameters.languagedata);//单键报备统计
    }
    if (document.getElementById("Lang_UserDeviceManage")) {
        document.getElementById("Lang_UserDeviceManage").innerHTML += GetTextByName("Lang_UserDeviceManage", useprameters.languagedata);//人员设备管理
    }

    if (document.getElementById("Lang_emergency")) {
        document.getElementById("Lang_emergency").innerHTML += GetTextByName("Lang_emergency", useprameters.languagedata);//预案管理
    }

    if (document.getElementById("procedure")) {
        document.getElementById("procedure").innerHTML += GetTextByName("Procedure", useprameters.languagedata);
    }
    if (document.getElementById("proceduretype")) {
        document.getElementById("proceduretype").innerHTML += GetTextByName("Lang_procedureType", useprameters.languagedata);
    }
    if (document.getElementById("lcyhbd")) {
        document.getElementById("lcyhbd").innerHTML += GetTextByName("Lang_lcyhbd", useprameters.languagedata);
    }
 
    if (document.getElementById("Lang_jrhw")) {//金融护卫--菜单
        document.getElementById("Lang_jrhw").innerHTML += GetTextByName("Lang_jrhw", useprameters.languagedata);
    }
    if (document.getElementById("Lang_gpstj")) {//GPS上报统计--菜单
        document.getElementById("Lang_gpstj").innerHTML += GetTextByName("Lang_gpstj", useprameters.languagedata);
    }
    if(document.getElementById("Lang_history_Car_Stat")) {//历史出车统计
        document.getElementById("Lang_history_Car_Stat").innerHTML += GetTextByName("Lang_history_Car_Stat", useprameters.languagedata);
    }
    if (document.getElementById("Lang_today_Car_Stat")) {//今日出车统计
        document.getElementById("Lang_today_Car_Stat").innerHTML += GetTextByName("Lang_today_Car_Stat", useprameters.languagedata);
    }
   
    if (document.getElementById("Lang_qwgl")) {//勤务管理
        document.getElementById("Lang_qwgl").innerHTML += GetTextByName("Lang_qwgl", useprameters.languagedata);
    }
    
    //视频监控
    if (document.getElementById("myspjk")) {
        document.getElementById("myspjk").innerHTML += GetTextByName("Lang_myspjk", useprameters.languagedata);
    }
    if (document.getElementById("jkxxwh")) {
        document.getElementById("jkxxwh").innerHTML += GetTextByName("Lang_videoinfowh", useprameters.languagedata);
    }
}