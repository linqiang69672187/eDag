/// <reference path="LogModule.js" />

function flexAlert(content) {
    alert(content);
}

function getnum(f, c) {
    var t = Math.pow(10, c);
    return Math.round(f * t) / t;
}


function delEventOverDZSL() {

}
function overDzzl() {
   
    isBegStackadeSel = false;
}
function delDZZL() {
    removeDZZL();
}
//开始电子栅栏
function begDZSL(ids, type, selStyle, mytitle) {

    switch (type) {
        case "polygon": //多边形
            var mian = document.getElementById("main");
            mian.drawPolyLine(ids, selStyle, mytitle);
            break;
        case "rect": //矩形
            var mian = document.getElementById("main");
            mian.drowDZZL(ids, selStyle, mytitle);
            //DrawRectangle(ids, selStyle, mytitle);
            break;
        case "oval": //圆形
            var mian = document.getElementById("main");
            mian.drawCircle(ids, selStyle, mytitle);
            break;
        case "ellipse": //椭圆
            var mian = document.getElementById("main");
            mian.drawElipse(ids, selStyle, mytitle);
            break;
        default: break;
    }
}
/**@删除不规则多边形的电子栅栏*/
function delPolyDZSL(id) {
    var dp = new DrawPolygon();
    dp.RemoveStroke(id);
    dp.RemoveFromAllStockadePoint(id);

    var delDiv = document.getElementById(id + "deldiv");
    if (delDiv) {
        //庞小斌，更改移除节点方式
        removeChildSafe(delDiv);
    }
}

var dwList = new List(); //用来存放定位后红旗的信息，定位时将信息添加到此变量中，时间到后将移除相应信息，主要是为地图缩放服务
function createDWHTML(lo, la, type) {

    var map = _StaticObj.objGet("map");
    var mapdiv = document.getElementById("map");
    var showpicDiv = document.createElement("div");
    showpicDiv.id = "show" + lo;
    showpicDiv.style.position = "absolute";
    showpicDiv.style.zIndex = 3;
    var mapcoord = map.getPixelInMap({ lo: lo, la: la });

    if (type == "weizhi") {
        showpicDiv.innerHTML = "<img src='Images/local_dw.png' style:'width:10px;height:10px'/>";
        showpicDiv.style.top = mapcoord.y - 40;
        showpicDiv.style.left = mapcoord.x - 25;
    } else {
        showpicDiv.innerHTML = "<img src='Images/local_dw.png' style:'width:15px;height:15px'/>";
        showpicDiv.style.top = mapcoord.y - 40;
        showpicDiv.style.left = mapcoord.x - 25;
    }
    mapdiv.appendChild(showpicDiv);
}
//根据经纬度定位
function DingWei(lo, la, type) {
    if (useprameters.lockid != 0) {
        alert(GetTextByName("HasLockFunction", useprameters.languagedata));//多语言：存在锁定用户
        return;
    }
    if (lo == "0.0000000" || la == "0.0000000" || lo == 0 || la == 0) {
        switch (type) {
            case "treeentity": alert(GetTextByName("Alert_EntityUnLoLa", useprameters.languagedata)); break;//多语言：单位经纬度为0或未配置
            case "entity": alert(GetTextByName("Alert_EntityUnLoLa", useprameters.languagedata)); break;//多语言：单位经纬度为0或未配置
            case "basestation": alert(GetTextByName("Alert_BaseStationUnLoLa", useprameters.languagedata)); break;//多语言：基站经纬度为0或未配置
            default: break;
        }
        //alert("无其位置信息");
        return;
    }

    var mainSWF = document.getElementById("main");
    if (mainSWF) {
        isSuccess = mainSWF.callbackLocate(parseFloat(lo), parseFloat(la));
        if (isSuccess == false) {
            alert(GetTextByName("Alert_PointNotOnMap", useprameters.languagedata));//多语言：你定位的点不在地图范围内
            return;
        }

    }
}

var isGetJWD = false; //是否获取经纬度
//开启获取经纬度
function GetJWD() {
    isGetJWD = true;
    //注释调用flash，增加鼠标双击监听事件--------------xzj--2018/6/29--------------------------------
    //var mian = document.getElementById("main");
    //mian.addSP2();
    (map.getViewport()).addEventListener("dblclick", getLola);
    //注释调用flash，增加鼠标双击监听事件--------------xzj--2018/6/29--------------------------------
}
//关闭获取经纬度
function CloseJWD() {
    isGetJWD = false;

    var mian = document.getElementById("main");
    mian.removeSP2();
}
function getJWD() {
    return isGetJWD;
}
//获取经纬度----------------------xzj--2018/6/29----------------------------------------
function getLola(event) {
    var coordinate = map.getEventCoordinate(event);
    var lola = ol.proj.transform(coordinate, 'EPSG:3857', 'EPSG:4326');
    console.log(lola);
    setLoLa(lola[0], lola[1]);
}
//获取经纬度----------------------xzj--2018/6/29----------------------------------------
function setLoLa(lo, la) {
    var myla = la;
    var mylo = lo;
    myla = getnum(parseFloat(myla), 7);
    mylo = getnum(parseFloat(mylo), 7);
    if (document.frames["edit_entity_ifr"] != null || document.frames["edit_entity_ifr"] != undefined) {
        document.frames["edit_entity_ifr"].document.getElementById("txtLa").value = myla;
        document.frames["edit_entity_ifr"].document.getElementById("txtLo").value = mylo;
    }
    if (document.frames["add_entity_ifr"] != null || document.frames["add_entity_ifr"] != undefined) {
        document.frames["add_entity_ifr"].document.getElementById("txtLa").value = myla;
        document.frames["add_entity_ifr"].document.getElementById("txtLo").value = mylo;
    }
    if (document.frames["add_BaseStation_ifr"] != null || document.frames["add_BaseStation_ifr"] != undefined) {
        document.frames["add_BaseStation_ifr"].document.getElementById("txtLa").value = myla;
        document.frames["add_BaseStation_ifr"].document.getElementById("txtLo").value = mylo;
    }
    if (document.frames["edit_BaseStation_ifr"] != null || document.frames["edit_BaseStation_ifr"] != undefined) {
        document.frames["edit_BaseStation_ifr"].document.getElementById("txtLa").value = myla;
        document.frames["edit_BaseStation_ifr"].document.getElementById("txtLo").value = mylo;
    }
    if (document.frames["edit_FixedStation_ifr"] != null || document.frames["edit_FixedStation_ifr"] != undefined) {
        document.frames["edit_FixedStation_ifr"].document.getElementById("txtLa").value = myla;
        document.frames["edit_FixedStation_ifr"].document.getElementById("txtLo").value = mylo;
    }
    if (document.frames["add_FixedStation_ifr"] != null || document.frames["add_FixedStation_ifr"] != undefined) {
        document.frames["add_FixedStation_ifr"].document.getElementById("txtLa").value = myla;
        document.frames["add_FixedStation_ifr"].document.getElementById("txtLo").value = mylo;
    }
    //注销双击监听事件----------------------xzj--2018/6/29----------------------------------------
    (map.getViewport()).removeEventListener("dblclick", getLola);
    //注销双击监听事件----------------------xzj--2018/6/29----------------------------------------
}

//在地图上删除已经画的点
function DelCreate() {
    for (var bs in AllBaseStationArray) {
        var myStroke = document.getElementById("BaseStation_" + AllBaseStationArray[bs].divid);
        if (myStroke) {
            removeChildSafe(myStroke);
        }
    }
    for (var e in AllStockadePoint) {
        var myStroke = document.getElementById("Stockade_" + AllStockadePoint[e].divid);
        if (myStroke) {
            removeChildSafe(myStroke);
        }
    }
    for (var pe in AllStockadeOvalPoint) {
        var myStroke = document.getElementById("Stockade_" + AllStockadeOvalPoint[pe].divid);
        if (myStroke) {
            removeChildSafe(myStroke);
        }
    }
    for (var myp in AllPoliceStaionArray) {
        var myStroke = document.getElementById("PoliceStation_" + AllPoliceStaionArray[myp].divid);
        if (myStroke) {
            removeChildSafe(myStroke);
        }
    }

}
function ReCreate() {
    for (var e in AllStockadePoint) {
        var mypa = new Array();
        mypa = eval(AllStockadePoint[e].pa);
        var ctype = AllStockadePoint[e].type;
        if (ctype == 2 || ctype == 1) {
            CreateOldPolygon(AllStockadePoint[e].divid, mypa, AllStockadePoint[e].divstyle);
        }
    }
    for (var pe in AllStockadeOvalPoint) {
        var mypa = new Array();
        mypa = eval(AllStockadeOvalPoint[pe].pa);
        CreateOval(AllStockadeOvalPoint[pe].divid, mypa, AllStockadeOvalPoint[pe].divstyle);
    }

    //只绘制当前界面的单位和基站
    for (var bs in AllBaseStationArray) {
        var minLo = LayerControl.CurrentBound.minLo;
        var maxLo = LayerControl.CurrentBound.maxLo;
        var maxLa = LayerControl.CurrentBound.maxLa;
        var minLa = LayerControl.CurrentBound.minLa;
        if (AllBaseStationArray[bs].la > minLa && AllBaseStationArray[bs].la < maxLa && AllBaseStationArray[bs].lo > minLo && AllBaseStationArray[bs].lo < maxLo) {
            CreateBaseStation(AllBaseStationArray[bs].bsid, AllBaseStationArray[bs].divid, AllBaseStationArray[bs].la, AllBaseStationArray[bs].lo, AllBaseStationArray[bs].bsname, AllBaseStationArray[bs].sissi);
        }
        minLo = null;
        maxLo = null;
        maxLa = null;
        minLa = null;
        bs = null;
    }
    for (var myp in AllPoliceStaionArray) {
        var minLo = LayerControl.CurrentBound.minLo;
        var maxLo = LayerControl.CurrentBound.maxLo;
        var maxLa = LayerControl.CurrentBound.maxLa;
        var minLa = LayerControl.CurrentBound.minLa;
        if (AllPoliceStaionArray[myp].la > minLa && AllPoliceStaionArray[myp].la < maxLa && AllPoliceStaionArray[myp].lo > minLo && AllPoliceStaionArray[myp].lo < maxLo) {
            CreatePoliceStation(AllPoliceStaionArray[myp].psid, AllPoliceStaionArray[myp].divid, AllPoliceStaionArray[myp].la, AllPoliceStaionArray[myp].lo, AllPoliceStaionArray[myp].psname, AllPoliceStaionArray[myp].picurl);
        }
        minLo = null;
        maxLo = null;
        maxLa = null;
        minLa = null;
        myp = null;
    }
}
function delBaseSelect() {
    if (haveCallSissi != null && haveCallSissi != undefined && haveCallSissi.length > 0) {
        for (var myi in haveCallSissi) {
            var myhcs = document.getElementById("PICDIV_" + haveCallSissi[myi]);
            if (myhcs) {
                removeChildSafe(myhcs);
            }
        }
        haveCallSissi.length = 0;
    }
}

///查看历史轨迹
function writeLogForHistoricalTrace(ISSI) {
    writeToDbByUserISSI(ISSI, OperateLogType.operlog, OperateLogModule.ModuleApplication, OperateLogOperType.HistoricalTrajectory, "Text_historicalTrajectory", OperateLogIdentityDeviceType.MobilePhone);
}

///开启实时轨迹
function writeLogForRealTraceClose(ISSI) {
    writeToDbByUserISSI(ISSI, OperateLogType.operlog, OperateLogModule.ModuleApplication, OperateLogOperType.RealTimeTrajectory, "Text_CloseRealTimeTrajectory", OperateLogIdentityDeviceType.MobilePhone);
}
function writeLogForRealTraceOpen(ISSI) {
    writeToDbByUserISSI(ISSI, OperateLogType.operlog, OperateLogModule.ModuleApplication, OperateLogOperType.RealTimeTrajectory, "Text_OpenRealTimeTrajectory", OperateLogIdentityDeviceType.MobilePhone);
}

function WriteDebugLog(logmsg) {
    if (isWriteDebugLog == 0) {
        return;
    }
    if (isWriteDebugLog == 1) {
        window.parent.jquerygetNewData_ajax_post("Handlers/WriteDebugLog.ashx", { logmsg: logmsg }, function (msg) {

        });
    }
}