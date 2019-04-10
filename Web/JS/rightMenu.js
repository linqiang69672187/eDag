//获取警员右键菜单
function userMenuItem_user()
{
    //菜单功能文本
    var SingleCall = GetTextByName("SingleCall",useprameters.languagedata);//单呼
    var smallGroupCall = GetTextByName("smallGroupCall",useprameters.languagedata);//组呼
    var EmergencyCall = GetTextByName("EmergencyCall",useprameters.languagedata);//紧急呼叫
    var YAOQIYAOBI = GetTextByName("YAOQIYAOBI",useprameters.languagedata);//遥启遥毙
    var CloseMonitoring = GetTextByName("CloseMonitoring",useprameters.languagedata);//慎密监听
    var EnvironmentalMonitoring = GetTextByName("EnvironmentalMonitoring",useprameters.languagedata);//环境监听
    var CallService = GetTextByName("Lang_dispatchopr",useprameters.languagedata);//调度业务(一级菜单)
    var Personalmessage = GetTextByName("Lang_generalsms",useprameters.languagedata);//个人短信
    var Groupmessage = GetTextByName("Lang_groupsms",useprameters.languagedata);//小组短信
    var Statusmessage = GetTextByName("Statusmessage",useprameters.languagedata);//状态消息
    var Shortmessageservice = GetTextByName("Shortmessageservice",useprameters.languagedata);//短信业务(一级菜单)
    var RightMe_CloseDetailInfor = GetTextByName("RightMe_CloseDetailInfor",useprameters.languagedata);//关闭显示
    var rgOpenDisplay = GetTextByName("OpenDisplay",useprameters.languagedata);//开启显示
    var HistoricalTrace = GetTextByName("HistoricalTrace",useprameters.languagedata);//历史轨迹
    var Stack = GetTextByName("Stack");//电子栅栏		
    var Text_OpenRealTimeTrajectory = GetTextByName("Text_OpenRealTimeTrajectory",useprameters.languagedata);//开启实时轨迹
    var Text_CloseRealTimeTrajectory = GetTextByName("Text_CloseRealTimeTrajectory",useprameters.languagedata);//关闭实时轨迹
    var Lang_concern = GetTextByName("Lang_concern",useprameters.languagedata);//添加关注
    var Lang_unconcern = GetTextByName("Lang_unconcern",useprameters.languagedata);//取消关注
    var Lang_Lock = GetTextByName("Lang_Lock",useprameters.languagedata);//锁定
    var Lang_unlocked = GetTextByName("Lang_unlocked",useprameters.languagedata);//解锁
    var ApplicationService = GetTextByName("ApplicationService",useprameters.languagedata);//应用业务(一级菜单)
    var Lang_videoDispatch = GetTextByName("Lang_videoDispatch",useprameters.languagedata);//视频调度
    var Lang_weixingshu = GetTextByName("Lang_weixingshu",useprameters.languagedata);//卫星数量

    var divUserRightMenu = document.getElementById("contextmenu_container");
    //根据用户权限显示相应菜单功能
    if (issiStatus == 0) {    //警员终端状态为0
        if (divUserRightMenu.getElementsByTagName("ul").length == 1 && divUserRightMenu.getElementsByTagName("ul")[0].id == "nodeULStatusIs0") {
            var a = divUserRightMenu.getElementsByTagName("ul");
        }
        else {
            if (divUserRightMenu.getElementsByTagName("ul").length > 1) {
                var allUL = divUserRightMenu.getElementsByTagName("ul");
                for (var i = 0; i < allUL.length;) {
                    divUserRightMenu.removeChild(allUL[i]);
                }
            }
                var nodeUL0 = document.createElement("ul");
                nodeUL0.id = "nodeULStatusIs0"
                //添加关闭显示
                var nodeLI = document.createElement("li");
                nodeLI.className = "sub_li_1";
                var nodeA = document.createElement("a");
                nodeA.href = "#";
                nodeA.text = RightMe_CloseDetailInfor;
                nodeA.id = "RightMe_CloseDetailInfor";
                nodeLI.appendChild(nodeA);
                nodeUL0.appendChild(nodeLI);
                //添加历史轨迹
                nodeLI = document.createElement("li");
                nodeLI.className = "sub_li_1";
                nodeA = document.createElement("a");
                nodeA.href = "#";
                nodeA.text = HistoricalTrace;
                nodeA.id = "HistoricalTrace";
                nodeLI.appendChild(nodeA);
                nodeUL0.appendChild(nodeLI);

                divUserRightMenu.appendChild(nodeUL0);
        }
    }
    else {    //警员终端状态为1
        if (divUserRightMenu.getElementsByTagName("ul").length > 1 || (divUserRightMenu.getElementsByTagName("ul").length == 1 && divUserRightMenu.getElementsByTagName("ul")[0].id != "nodeULStatusIs0"))
        {
            var a = divUserRightMenu.getElementsByTagName("ul");
        }
        else
        {
            if (divUserRightMenu.getElementsByTagName("ul").length == 1) {
                var allUL = divUserRightMenu.getElementsByTagName("ul");
                divUserRightMenu.removeChild(allUL[0]);
            }
                //createBeforeNode(CallService, "CallService");
                var nodeUL = document.createElement("ul");
                var nodeLI = document.createElement("li");
                nodeLI.className = "sub_li_1";
                var nodeA = document.createElement("a");
                nodeA.href = "#";
                nodeA.text = CallService;
                nodeA.id = "CallService";
                var subNodeUL = document.createElement("ul");
                subNodeUL.className = setRightMenuClass();
                var subNodeLI = createNodeLIAndA(SingleCall, "", "SingleCall");//单呼
                subNodeUL.appendChild(subNodeLI);
                subNodeLI = createNodeLIAndA(smallGroupCall, "", "smallGroupCall");//组呼
                subNodeUL.appendChild(subNodeLI);
                subNodeLI = createNodeLIAndA(EmergencyCall, "", "EmergencyCall");//紧急呼叫
                subNodeUL.appendChild(subNodeLI);
                subNodeLI = createNodeLIAndA(YAOQIYAOBI, "", "YAOQIYAOBI"); //遥启遥毙
                subNodeUL.appendChild(subNodeLI);
                subNodeLI = createNodeLIAndA(CloseMonitoring, "", "CloseMonitoring"); //紧密监听
                subNodeUL.appendChild(subNodeLI);
                subNodeLI = createNodeLIAndA(EnvironmentalMonitoring, "", "EnvironmentalMonitoring"); //环境监听
                subNodeUL.appendChild(subNodeLI);
                nodeLI.appendChild(nodeA);
                nodeLI.appendChild(subNodeUL);
                nodeUL.appendChild(nodeLI);
                divUserRightMenu.appendChild(nodeUL);

                nodeUL = document.createElement("ul");
                nodeLI = document.createElement("li");
                nodeLI.className = "sub_li_1";
                nodeA = document.createElement("a");
                nodeA.href = "#";
                nodeA.text = Shortmessageservice;
                nodeA.id = "Shortmessageservice";
                subNodeUL = document.createElement("ul");
                subNodeUL.className = setRightMenuClass();
                //createBeforeNode(Shortmessageservice, "Shortmessageservice");
                subNodeLI = createNodeLIAndA(Personalmessage, "", "Personalmessage");//个人短信
                subNodeUL.appendChild(subNodeLI);
                subNodeLI = createNodeLIAndA(Groupmessage, "", "Groupmessage");//小组短信
                subNodeUL.appendChild(subNodeLI);
                subNodeLI = createNodeLIAndA(Statusmessage, "", "Statusmessage");//状态消息
                subNodeUL.appendChild(subNodeLI);
                nodeLI.appendChild(nodeA);
                nodeLI.appendChild(subNodeUL);
                nodeUL.appendChild(nodeLI);
                divUserRightMenu.appendChild(nodeUL);

                nodeUL = document.createElement("ul");
                nodeLI = document.createElement("li");
                nodeLI.className = "sub_li_1";
                nodeA = document.createElement("a");
                nodeA.href = "#";
                nodeA.text = ApplicationService;
                nodeA.id = "ApplicationService";
                subNodeUL = document.createElement("ul");
                subNodeUL.className = setRightMenuClass();
                //createBeforeNode(ApplicationService, "ApplicationService");

                subNodeLI = createNodeLIAndA(RightMe_CloseDetailInfor, "", "RightMe_CloseDetailInfor");//关闭显示
                subNodeUL.appendChild(subNodeLI);
                subNodeLI = createNodeLIAndA(rgOpenDisplay, "", "rgOpenDisplay");//开启显示
                subNodeUL.appendChild(subNodeLI);
                
                subNodeLI = createNodeLIAndA(Lang_concern, "", "Lang_concern"); //添加关注
                subNodeUL.appendChild(subNodeLI);
                subNodeLI = createNodeLIAndA(Lang_unconcern, "", "Lang_unconcern"); //取消关注
                subNodeUL.appendChild(subNodeLI);
                subNodeLI = createNodeLIAndA(Lang_Lock, "", "Lang_Lock");//锁定
                subNodeUL.appendChild(subNodeLI);
                subNodeLI = createNodeLIAndA(Lang_unlocked, "", "Lang_unlocked");//解锁
                subNodeUL.appendChild(subNodeLI);
                subNodeLI = createNodeLIAndA(Stack, "", "Stack");//电子栅栏
                subNodeUL.appendChild(subNodeLI);
                subNodeLI = createNodeLIAndA(HistoricalTrace, "", "HistoricalTrace"); //历史轨迹
                subNodeUL.appendChild(subNodeLI);
                subNodeLI = createNodeLIAndA(Text_OpenRealTimeTrajectory, "", "Text_OpenRealTimeTrajectory");//开启实时轨迹
                subNodeUL.appendChild(subNodeLI);
                subNodeLI = createNodeLIAndA(Text_CloseRealTimeTrajectory, "", "Text_CloseRealTimeTrajectory"); //关闭实时轨迹
                subNodeUL.appendChild(subNodeLI);
                //createNodeLIAndA(Lang_videoDispatch, "", subNodeUL); //视频调度
                //createNodeLIAndA(Lang_weixingshu, "", subNodeUL); //卫星数量
                nodeLI.appendChild(nodeA);
                nodeLI.appendChild(subNodeUL);
                nodeUL.appendChild(nodeLI);
                divUserRightMenu.appendChild(nodeUL);
                //appendChildStep();
        }
    }

}
///将右键菜单的样式更换为英文的，防止长度不够--xzj--20181122
function setRightMenuClass() {
    var rightMenuClassName = "normal_menu sub_menu";
    if (useprameters.defaultLanguage == "en-US") {
        rightMenuClassName = "en_normal_menu en_sub_menu";
    }
    return rightMenuClassName;
}
//useprameters.rightselectid和useprameters.rightselectissi为undefined,所以该页面中使用获取的inissi和id代替
var inissi; //getHDISSIByUserName（）中获取不到ol-UserLayer.js中的issi
var inarrISSI = [];//隐藏的ISSI 
//var RealTimeTrajectory = [];//开启实时轨迹的user_info.id  /*******cxy 20180712 替换全局变量，将RealTimeTrajectory替换为useprameters.realtimeTraceUserIds ********/
var issiStatus;//ISSI状态
var id;//用户ID
//根据权限显示地图右键菜单
function MapMenuIsDisplayByPower() {
    if (useprameters.GZEnable == '0')//关注列表
        document.getElementById("concernlists").parentNode.style.display = "none";
    else if (useprameters.GZEnable == '1')
        document.getElementById("concernlists").parentNode.style.display = "block";
    if (useprameters.GPSEnable == '0')//查找警员
        document.getElementById("searchPolice").parentNode.style.display = "none";
    else if (useprameters.GPSEnable == '1')
        document.getElementById("searchPolice").parentNode.style.display = "block";
    if (useprameters.GroupCallEnable == '0')//组呼
        document.getElementById("GroupCallA").parentNode.style.display = "none";
    else if (useprameters.GroupCallEnable == '1')
        document.getElementById("GroupCallA").parentNode.style.display = "block";
    if (useprameters.CXBKEnable == '0')//发布查询布控
        document.getElementById("fabuchaxunbukong").parentNode.style.display = "none";
    else if (useprameters.CXBKEnable == '1')
        document.getElementById("fabuchaxunbukong").parentNode.style.display = "block";
    if (useprameters.DTCZEnable == '0')//动态重组
        document.getElementById("Lang_DTCZ").parentNode.style.display = "none";
    else if (useprameters.DTCZEnable == '1')
        document.getElementById("Lang_DTCZ").parentNode.style.display = "block";
    if (useprameters.FSHeatMapEnable == '0')//查看历史场强热力图
        document.getElementById("showFSMap").parentNode.style.display = "none";
    else if (useprameters.FSHeatMapEnable == '1')
        document.getElementById("showFSMap").parentNode.style.display = "block";
    if (useprameters.lockid != 0) {//搜索锁定警员
        if (useprameters.lockingFunctionEnable == '0')
            document.getElementById("Lang_searchlockuser").parentNode.style.display = "none";
        else if (useprameters.lockingFunctionEnable == '1')
            document.getElementById("Lang_searchlockuser").parentNode.style.display = "block";
    }
    else {
        document.getElementById("Lang_searchlockuser").parentNode.style.display = "none";
    }
    if (typeof (useprameters.realtimeTraceUserIds) == "undefined" || useprameters.realtimeTraceUserIds == null || useprameters.realtimeTraceUserIds.length == 0) {//实时轨迹列表
        document.getElementById("RealTimeTraceList").parentNode.style.display = "none";
    }
    else {
        if (useprameters.RealTimeTraceEnable == '0')
            document.getElementById("RealTimeTraceList").parentNode.style.display = "none";
        else if (useprameters.RealTimeTraceEnable == '1')
            document.getElementById("RealTimeTraceList").parentNode.style.display = "block";
    }
        

}
//根据ISSI获取用户终端状态
function getUserStatusByISSI(issi)
{
    inissi = issi;
    var param = {
        "ISSI": issi
    };
    jquerygetNewData_ajax("Handlers/GetUserISSIStatusByISSI.ashx", param, function (request) {
        var data = request;
        id = data.id;
        issiStatus = data.issiStatus;
        userMenuItem_user();
        addMouseMenuOnClickEvent();
        getHDISSIByUserName(useprameters.usename);//获取arrISSI
    });
}
//根据userName获取HDISSI(不显示的ISSI)
function getHDISSIByUserName(userName)
{    
    var param = {
        "userName": userName
    };
    jquerygetNewData_ajax("Handlers/GetHDISSIByUserName.ashx", param, function (request)
    {
        var data = request.HDISSI;
        if (data == "") {
            inarrISSI = [];
        }
        else {
            var arr1 = new Array();
            arr1 = data.split(">");
            for (var i = 0; i < arr1.length-1; i++) {
                if (arr1[i].indexOf("<") > -1) {
                    inarrISSI[i] = arr1[i].substring(arr1[i].indexOf("<") + 1);
                }
            }
        }
        IsDisplayByPower()//根据账号权限判断显示哪些功能
      
    })
}
//根据账号权限判断警员右键显示哪些功能显示
function IsDisplayByPower()
{
    if (useprameters.PrivateCallEnable == '0' && useprameters.GroupCallEnable == '0' && useprameters.EmergencyCallEnable == '0'
        && useprameters.YQYBEnable == '0' && useprameters.CloseMonitoringEnable == '0' && useprameters.EnvironmentalMonitoringEnable == '0') {
        document.getElementById("CallService").parentNode.parentNode.style.display = "none";
    }
    else {
        if (useprameters.PrivateCallEnable == '0')//单呼
            document.getElementById("SingleCall").parentNode.style.display = "none";
        else if (useprameters.PrivateCallEnable == '1')
            document.getElementById("SingleCall").parentNode.style.display = "block";
        if (useprameters.GroupCallEnable == '0')//组呼
            document.getElementById("smallGroupCall").parentNode.style.display = "none";
        else if (useprameters.GroupCallEnable == '1')
            document.getElementById("smallGroupCall").parentNode.style.display = "block";
        if (useprameters.EmergencyCallEnable == '0')//紧急呼叫
            document.getElementById("EmergencyCall").parentNode.style.display = "none";
        else if (useprameters.EmergencyCallEnable == '1')
            document.getElementById("EmergencyCall").parentNode.style.display = "block";
        if (useprameters.YQYBEnable == '0')//遥启遥毙
            document.getElementById("YAOQIYAOBI").parentNode.style.display = "none";
        else if (useprameters.YQYBEnable == '1')
            document.getElementById("YAOQIYAOBI").parentNode.style.display = "block";
        if (useprameters.CloseMonitoringEnable == '0')//缜密监听
            document.getElementById("CloseMonitoring").parentNode.style.display = "none";
        else if (useprameters.CloseMonitoringEnable == '1')
            document.getElementById("CloseMonitoring").parentNode.style.display = "block";
        if (useprameters.EnvironmentalMonitoringEnable == '0')//环境监听
            document.getElementById("EnvironmentalMonitoring").parentNode.style.display = "none";
        else if (useprameters.EnvironmentalMonitoringEnable == '1')
            document.getElementById("EnvironmentalMonitoring").parentNode.style.display = "block";
    }
    if (useprameters.SMSEnable == '0' && useprameters.GroupSMSEnable == '0' && useprameters.Status_messageEnable == '0') {
        document.getElementById("Shortmessageservice").parentNode.parentNode.style.display = "none";
    }
    else {
        if (useprameters.SMSEnable == '0')//个人短信
            document.getElementById("Personalmessage").parentNode.style.display = "none";
        else if (useprameters.SMSEnable == '1')
            document.getElementById("Personalmessage").parentNode.style.display = "block";
        if (useprameters.GroupSMSEnable == '0')//小组短信
            document.getElementById("Groupmessage").parentNode.style.display = "none";
        else if (useprameters.GroupSMSEnable == '1')
            document.getElementById("Groupmessage").parentNode.style.display = "block";
        if (useprameters.Status_messageEnable == '0')//状态消息
            document.getElementById("Statusmessage").parentNode.style.display = "none";
        else if (useprameters.Status_messageEnable == '1')
            document.getElementById("Statusmessage").parentNode.style.display = "block";
    }
    if (useprameters.HistoricalTraceEnable == '0')//历史轨迹
        document.getElementById("HistoricalTrace").parentNode.style.display = "none";
    else if (useprameters.HistoricalTraceEnable == '1')
        document.getElementById("HistoricalTrace").parentNode.style.display = "block";
    if (useprameters.StackEnable == '0')//电子栅栏
        document.getElementById("Stack").parentNode.style.display = "none";
    else if (useprameters.StackEnable == '1')
        document.getElementById("Stack").parentNode.style.display = "block";

    //判断锁定开启关闭
    if (useprameters.lockingFunctionEnable == '0') {
        document.getElementById("Lang_Lock").parentNode.style.display = "none";
        document.getElementById("Lang_unlocked").parentNode.style.display = "none";
    }
    else if (useprameters.lockingFunctionEnable == '1') {
        if (useprameters.lockid == id) {
            document.getElementById("Lang_Lock").parentNode.style.display = "none";
            document.getElementById("Lang_unlocked").parentNode.style.display = "block";
        }
        else {
            document.getElementById("Lang_Lock").parentNode.style.display = "block";
            document.getElementById("Lang_unlocked").parentNode.style.display = "none";
        }
    }

    //判断显示开启关闭
    if (useprameters.DisplayEnable == '0') {
        document.getElementById("RightMe_CloseDetailInfor").parentNode.style.display = "none";
        document.getElementById("rgOpenDisplay").parentNode.style.display = "none";
    }
    else if (useprameters.DisplayEnable == '1') {
        document.getElementById("RightMe_CloseDetailInfor").parentNode.style.display = "block";
        document.getElementById("rgOpenDisplay").parentNode.style.display = "none";
        if (typeof (inarrISSI) == "undefined" || inarrISSI == null || inarrISSI.length == 0) {

        }
        else if (inarrISSI.length != 0) {
            var i = inarrISSI.length;
            while (i--) {
                if (inarrISSI[i] == inissi) {
                    document.getElementById("RightMe_CloseDetailInfor").parentNode.style.display = "none";
                    document.getElementById("rgOpenDisplay").parentNode.style.display = "block";
                    break;
                }
            }
        }
    }
    //判断关注开启关闭
    if (useprameters.GZEnable == '0') {
        document.getElementById("Lang_unconcern").parentNode.style.display = "none";
        document.getElementById("Lang_concern").parentNode.style.display = "none";
    }
    else if (useprameters.GZEnable == '1') {
        document.getElementById("Lang_unconcern").parentNode.style.display = "none";
        document.getElementById("Lang_concern").parentNode.style.display = "block";
        if (typeof (useprameters.concernusers_array) == "undefined" || useprameters.concernusers_array == null || useprameters.concernusers_array.length == 0) {

        }
        else if (useprameters.concernusers_array.length != 0) {
            var i = useprameters.concernusers_array.length;
            while (i--) {
                if (useprameters.concernusers_array[i] == id) {
                    document.getElementById("Lang_unconcern").parentNode.style.display = "block";
                    document.getElementById("Lang_concern").parentNode.style.display = "none";
                    break;
                }
            }
        }
    }
    //判断实时轨迹开启关闭
    if (useprameters.RealTimeTraceEnable == '0') {
        document.getElementById("Text_CloseRealTimeTrajectory").parentNode.style.display = "none";
        document.getElementById("Text_OpenRealTimeTrajectory").parentNode.style.display = "none";
    }
    else if (useprameters.RealTimeTraceEnable == '1') {
        document.getElementById("Text_CloseRealTimeTrajectory").parentNode.style.display = "none";
        document.getElementById("Text_OpenRealTimeTrajectory").parentNode.style.display = "block";
        if (typeof (useprameters.realtimeTraceUserIds) == "undefined" || useprameters.realtimeTraceUserIds == null || useprameters.realtimeTraceUserIds.length == 0) {

        }
        else if (useprameters.realtimeTraceUserIds.length != 0) {
            var i = useprameters.realtimeTraceUserIds.length;
            while (i--) {
                if (useprameters.realtimeTraceUserIds[i] == id) {
                    document.getElementById("Text_CloseRealTimeTrajectory").parentNode.style.display = "block";
                    document.getElementById("Text_OpenRealTimeTrajectory").parentNode.style.display = "none";
                    break;
                }
            }
        }
    }
}
//不用
function createBeforeNode(text, id) {
    nodeUL = document.createElement("ul");
    nodeLI = document.createElement("li");
    nodeLI.className = "sub_li_1";
    nodeA = document.createElement("a");
    nodeA.href = "#";
    nodeA.text = text;
    nodeA.id = id;
    subNodeUL = document.createElement("ul");
   subNodeUL.className = setRightMenuClass();
}
//创建A标签
function createNodeLIAndA(text,href,id)
{
    var subNodeLI = document.createElement("LI");

    var subNodeA= document.createElement("a");
    subNodeA.text = text;
    subNodeA.id = id;
    if (href != "" && href != null && href != undefined) {
        subNodeA.href = href;
    }
    else {
        subNodeA.href = "#";
    }
    subNodeA.style.display = "block";
    subNodeA.style.width = "100%";
    subNodeLI.appendChild(subNodeA);
    return subNodeLI;
}
//不用
function appendChildStep()
{
    nodeLI.appendChild(nodeA);
    nodeLI.appendChild(subNodeUL);
    nodeUL.appendChild(nodeLI);
    divUserRightMenu.appendChild(nodeUL);
}
function addMouseMenuOnClickEvent()
{   //单呼
    document.getElementById("SingleCall").onclick = function () {
        document.getElementById("contextmenu_container").parentNode.style.display = "none";
        if (useprameters.callActivexable == false) {
            alert(GetTextByName("checkcallcontrolregister", useprameters.languagedata));
            return;
        }
        mycallfunction('PrivateCall', 380, 580, "&type=UID&myid=" + id, 1999)
    }
    //组呼
    document.getElementById("smallGroupCall").onclick = function () {
        document.getElementById("contextmenu_container").parentNode.style.display = "none";
        if (useprameters.callActivexable == false) {
            alert(GetTextByName("checkcallcontrolregister", useprameters.languagedata));
            return;
        }
        mycallfunction('GroupCall', 450, 370, "&type=UID&myid=" + id, 1999);
    }
    //紧急呼叫
    document.getElementById("EmergencyCall").onclick = function () {
        document.getElementById("contextmenu_container").parentNode.style.display = "none";
        if (useprameters.callActivexable == false) {
            alert(GetTextByName("checkcallcontrolregister", useprameters.languagedata));
            return;
        }
        mycallfunction('PPCCall', 450, 370, "&type=UID&myid=" + id, 1999);
    }
    //遥启遥毙
    document.getElementById("YAOQIYAOBI").onclick = function () {
        document.getElementById("contextmenu_container").parentNode.style.display = "none";
        if (useprameters.callActivexable == false) {
            alert(GetTextByName("checkcallcontrolregister", useprameters.languagedata));
            return;
        }
        mycallfunction('EnableDisableRadio', 450, 370, "&type=UID&myid=" + id, 1999);
    }
    //紧密监听
    document.getElementById("CloseMonitoring").onclick = function () {
        document.getElementById("contextmenu_container").parentNode.style.display = "none";
        if (useprameters.callActivexable == false) {
            alert(GetTextByName("checkcallcontrolregister", useprameters.languagedata));
            return;
        }
        mycallfunction('DLCall', 450, 370, "&type=UID&myid=" + id, 1999);
    }
    //环境监听
    document.getElementById("EnvironmentalMonitoring").onclick = function () {
        document.getElementById("contextmenu_container").parentNode.style.display = "none";
        if (useprameters.callActivexable == false) {
            alert(GetTextByName("checkcallcontrolregister", useprameters.languagedata));
            return;
        }
        mycallfunction('ALCall', 450, 370, "&type=UID&myid=" + id, 1999);
    }
    //个人短信
    document.getElementById("Personalmessage").onclick = function () {
        document.getElementById("contextmenu_container").parentNode.style.display = "none";
        if (useprameters.callActivexable == false) {
            alert(GetTextByName("checkcallcontrolregister", useprameters.languagedata));//checkcallcontrolregister
            return;
        }
        mycallfunction('Send_SMS', 450, 370, id, 1999);
    }
    //小组短信
    document.getElementById("Groupmessage").onclick = function () {
        document.getElementById("contextmenu_container").parentNode.style.display = "none";
        if (useprameters.callActivexable == false) {
            alert(GetTextByName("checkcallcontrolregister", useprameters.languagedata));//checkcallcontrolregister
            return;
        };
        mycallfunction('Send_SMS', 450, 370, id + "&cmd=G", 1999);
    }
    //状态消息
    document.getElementById("Statusmessage").onclick = function () {
        document.getElementById("contextmenu_container").parentNode.style.display = "none";
        if (useprameters.callActivexable == false) {
            alert(GetTextByName("checkcallcontrolregister", useprameters.languagedata));//checkcallcontrolregister
            return;
        }
        mycallfunction('Send_StatusMS', 450, 370, id, 1999);
    }
    //关闭显示ok
    document.getElementById("RightMe_CloseDetailInfor").onclick = function () {
        document.getElementById("contextmenu_container").parentNode.style.display = "none";
        var param={
            "ISSI": inissi,
            "ISHD": 1
        };
        jquerygetNewData_ajax("lqnew/opePages/policelists_Isdisplay.aspx", param, function (request) {
            var data = request;
            if (data.result == "success") {
                var i = inarrISSI.length;
                while (i--)
                {
                    if (inarrISSI[i] == inissi)
                        break;
                }
                if (i == -1) {
                    inarrISSI.push(inissi);
                    delSelectUserVar(id, inissi);                   
                    checkDisplayImg(id, false);
                    hidPerUser(id,"1");
                    
                }
            }
        });
    }
    //开启显示ok
    document.getElementById("rgOpenDisplay").onclick = function () {
        document.getElementById("contextmenu_container").parentNode.style.display = "none";
        var param = {
            "ISSI": inissi,
            "ISHD": 0
        };
        jquerygetNewData_ajax("lqnew/opePages/policelists_Isdisplay.aspx", param, function (request) {
            var data = request;          
            if (data.result == "success") {
                var i = inarrISSI.length;
                while (i--) {
                    if (inarrISSI[i] == inissi) {
                        inarrISSI.splice(i, 1);
                        useprameters.Selectid.push(id);
                        useprameters.SelectISSI.push(inissi);
                        checkDisplayImg(id, true);
                        hidPerUser(id, "0");
                        break;
                    }
                }
            }
        });
    }
    //添加关注ok
    document.getElementById("Lang_concern").onclick = function () {
        document.getElementById("contextmenu_container").parentNode.style.display = "none";
        Addusertoconcernlist(id, "map");//useprameters.rightselectid未获取到 使用改文件获取的id
    }
    //取消关注ok
    document.getElementById("Lang_unconcern").onclick = function () {
        document.getElementById("contextmenu_container").parentNode.style.display = "none";
        Deleteuserfromconcernlist(id, "map");
    }
    //锁定ok
    document.getElementById("Lang_Lock").onclick = function () {
        document.getElementById("contextmenu_container").parentNode.style.display = "none";
        lock_it(id);
    }
    //解锁ok
    document.getElementById("Lang_unlocked").onclick = function () {
        document.getElementById("contextmenu_container").parentNode.style.display = "none";
        lock_it(id);
    }
    //电子栅栏ok
    document.getElementById("Stack").onclick = function () {
        document.getElementById("contextmenu_container").parentNode.style.display = "none";
        mycallfunction('path_selectcolor', 450, 370, id, 1999);
    }
    //历史轨迹ok
    document.getElementById("HistoricalTrace").onclick = function () {
        document.getElementById("contextmenu_container").parentNode.style.display = "none";
        mycallfunction('SubmitToHistory', 450, 370, id, 1999);
        
    }
    //点击关闭图标关闭实时轨迹后按钮会有disabled属性，导致按钮不可用----------------------------xzj--2018/7/9--------------------------------
    document.getElementById("Text_OpenRealTimeTrajectory").disabled = false;
    //开启实时轨迹ok
    document.getElementById("Text_OpenRealTimeTrajectory").onclick = function () {
        document.getElementById("contextmenu_container").parentNode.style.display = "none";
        mycallfunction('manager_selectcolor', 440, 354, id + "&ISSI=" + inissi, 1999);
          //注释，放在点击确定按钮之后-----------------xzj--2018/8/2-----------------
        //var i = useprameters.realtimeTraceUserIds.length;
        //while (i--)
        //{
        //    if (useprameters.realtimeTraceUserIds[i] == id)
        //        break;
        //}
        //if (i == -1) {
        //    useprameters.realtimeTraceUserIds.push(id);
        //}
    }
    //关闭实时轨迹ok
    document.getElementById("Text_CloseRealTimeTrajectory").onclick = function () {
        document.getElementById("contextmenu_container").parentNode.style.display = "none";
        removeIdTorealtimeTraceUserIds(id,true);
        writeLogForRealTraceClose(inissi);
        var i = useprameters.realtimeTraceUserIds.length;
        while (i--)
        {
            if (useprameters.realtimeTraceUserIds[i] == id) {
                useprameters.realtimeTraceUserIds.splice(i, 1);
                break;
            }
        }
    }
}
//点击关闭图标未开启实时轨迹后删除存入的id--------------------xzj--2018/7/9-----------------------------------------------------------------
function cancelOpenRealTimeTrajectory(id) {
    var i = useprameters.realtimeTraceUserIds.length;
    while (i--) {
        if (useprameters.realtimeTraceUserIds[i] == id) {
            useprameters.realtimeTraceUserIds.splice(i, 1);
            break;
        }
    }
}
//地图右键查询布控，添加鼠标监听事件-------------------------------xzj--2018/4/26------------------------------------------------------
function rectselectBut() {
    (map.getViewport()).addEventListener("mousedown", begainDraw);
    (map.getViewport()).addEventListener("mouseup", unBegainDraw);
    //(map.getView()).on("change:resolution", sbegainDraw);
    //(map.getViewport()).addEventListener("mousewheel", sbegainDraw);
    //(map.getViewport()).addEventListener("mouseup", sbegainDraw);
}
var pixel;//鼠标点击像素
var coordinate;//鼠标点击坐标
var kmNumber;
var pixelCircle;//变换后的像素
var coordinateCircle//变换后的坐标
var radius;//转换前后的x坐标差为半径
var circleLayer//查询布控画圆图层
var IsDrawCircle=0 //判断是否已经画图 0没画 1画


function begainDraw(event) {//mousedown监听事件
    if (event.button == 0) {
        //pixel = map.getEventPixel(event);
        coordinate = map.getEventCoordinate(event);
		//var lonlat = ol.proj.transform(coordinate, 'EPSG:3857', 'EPSG:4326');

        kmNumber = useprameters.CKBKKilometres;

       //取消注释，由gistype确定------------------------xzj--2018/7/20-----------------------------------------
        radius = kmNumber * 1000;

        map.removeLayer(circleLayer);
        circleLayer = new ol.layer.Vector({
            source: new ol.source.Vector()
        });
        var circle = new ol.Feature({
            geometry: new ol.geom.Circle(coordinate, radius)
        });
        circle.setStyle(new ol.style.Style({
                stroke: new ol.style.Stroke({
                    color: 'rgba(255,106,106,0.2)',
                    size: 2
                }),
                fill: new ol.style.Fill({
                    color: 'rgba(255,106,106,0.2)'
                })
            })
        )
        circleLayer.getSource().addFeature(circle);
        map.addLayer(circleLayer);

        IsDrawCircle = 1;
    }
    else {
        (map.getViewport()).removeEventListener("mousedown", begainDraw);
        (map.getViewport()).removeEventListener("mouseup", unBegainDraw);
        //(map.getView()).un("change:resolution", sbegainDraw);
        //(map.getViewport()).removeEventListener("mousewheel", sbegainDraw);
        //(map.getViewport()).removeEventListener("mouseup", sbegainDraw);
    }
}
function unBegainDraw(event) {//mouseup监听事件
    var startCoordinates = ol.proj.transform([coordinate[0] - radius, coordinate[1] + radius], 'EPSG:3857', 'EPSG:4326');
    var endCoordinates = ol.proj.transform([coordinate[0] + radius, coordinate[1] - radius], 'EPSG:3857', 'EPSG:4326');
        //移除监听事件-----------------------------------------xzj--2018/5/3---------------------------------------------------------------------
        (map.getViewport()).removeEventListener("mousedown", begainDraw);
        (map.getViewport()).removeEventListener("mouseup", unBegainDraw);
        myrectangle([Math.min(startCoordinates[0], endCoordinates[0]), Math.max(startCoordinates[0], endCoordinates[0]), Math.min(startCoordinates[1], endCoordinates[1]), Math.max(startCoordinates[1], endCoordinates[1])]);
    }
function sbegainDraw() {
    if (IsDrawCircle == 1) {
        kmNumber = useprameters.CKBKKilometres;
       //取消注释，由gistype确定------------------------xzj--2018/7/20-----------------------------------------
        coordinateCircle = [coordinate[0] + (kmNumber * 1000), coordinate[1] + (kmNumber * 1000)];
        pixel = map.getPixelFromCoordinate(coordinate);
        pixelCircle = map.getPixelFromCoordinate(coordinateCircle);
        radius = pixelCircle[0] - pixel[0];
        map.removeLayer(circleLayer);
        circleLayer = new ol.layer.Vector({
            source: new ol.source.Vector()
        });
        var circle = new ol.Feature({
            geometry: new ol.geom.Circle(coordinate, radius)
        });
        circle.setStyle(new ol.style.Style({
            stroke: new ol.style.Stroke({
                color: 'rgba(255,106,106,0.2)',
                size: 2
            }),
            fill: new ol.style.Fill({
                color: 'rgba(255,106,106,0.2)'
            })
        })
        )
        circleLayer.getSource().addFeature(circle);
        map.addLayer(circleLayer);
        IsDrawCircle = 1;
    }
}