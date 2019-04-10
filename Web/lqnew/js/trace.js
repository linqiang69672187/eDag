/// <reference path="../../JQuery/jquery-1.5.2.js" />
function trayceit(layerID, ci, isopencolorpic) {
    if (istracein(ci)) {
        var i = indeofarraytrac(ci);
        var trac = document.getElementById("firstTrajectory" + ci);
        removeChildSafe(trac);
        var trac_other;
        var trac_other_1;
        for (var j = 0; j < 500; j++)
        {
            trac_other = document.getElementById("firstTrajectory" + ci + j + "shixian");
            if (trac_other)
            {
                removeChildSafe(trac_other);
            }
            trac_other_1 = document.getElementById("firstTrajectory" + ci + j + "xuxian");
            if (trac_other_1) {
                removeChildSafe(trac_other_1);

            }
        }
        useprameters.nowtrace.splice(i, 1);
        var layerCell = LayerControl.CellGet("Police,0,0", ci);
        var ifrs = document.frames["select_user_ifr"];
        if (ifrs) {
            ifrs.checkbz(); //框选后图标
        }
        //writeLog("oper", "[实时轨迹]：关闭ISSI(" + layerCell.ISSI + ")的实时轨迹" + "[" + LOGTimeGet() + "]");         /**日志：操作日志 **/
        return;
    }
    if (isopencolorpic != false) {
        var layerCell = LayerControl.CellGet(layerID, ci);
        opencolorpic(ci, layerCell.Send_time);
    }
}
function closeceit(layerID, ci, isopencolorpic) {
    if (useprameters.lockid == ci)
        return;
    if (istracein(ci)) {
        var i = indeofarraytrac(ci);
        $("#firstTrajectory" + ci).remove();
        useprameters.nowtrace.splice(i, 1);
        return;
    }
}

function closeallTrace() {
    LayerControl.isDrawtrace = false;
    for (var i = 0; i < useprameters.nowtrace.length; i++) {
        $("#firstTrajectory" + useprameters.nowtrace[i].item.split('|')[0]).remove();
    }
}
function stopmoveTrace() {
    setTimeout(function () {
        LayerControl.isDrawtrace = true;
        for (var i = 0; i < useprameters.nowtrace.length; i++) {

            ajaxgettrace();
        }
    }, 200);
}

//计算两条直线的夹角(直线转换成向量p0,p1)------------------------------------------------------------------------------------------------------------------
function calculateAngle(s1, s2) {
    var s = s1.x * s2.x + s1.y * s2.y; //x1 * x2 + y1 * y2
    var result;
    var moda = Math.sqrt(s1.x * s1.x + s1.y * s1.y); //Math.sqrt(x1 * x1 + y1 * y1); 
    var modb = Math.sqrt(s2.x * s2.x + s2.y * s2.y); //Math.sqrt(x2 * x2 + y2 * y2);
    if (s / (moda * modb) > 1 || s / (moda * modb) < -1) return 0;
    else result = Math.acos(s / (moda * modb));
    return result;
}

//------------------------------------------------------------------------------------------------------------

//-----------------------------------------------------------------------------------------------------handepei
function rad(d) {
    return d * Math.PI / 180.0;
}

function GetValue(lat1, lng1, lat2, lng2)//lat 维度 lng经度
{
    var radLat1 = rad(lat1);
    var radLat2 = rad(lat2);
    var a = radLat1 - radLat2;
    var b = rad(lng1) - rad(lng2);
    var s = 2 * Math.asin(Math.sqrt(Math.pow(Math.sin(a / 2), 2) + Math.cos(radLat1) * Math.cos(radLat2) * Math.pow(Math.sin(b / 2), 2)));
    s = s * 6378.137;
    s = Math.round(s * 10000) / 10000;
    return s;
}

//------------------------------------------------------------------------------------------------------------------------handepei

function getPostPointByUseId(id) {
    var param = { "id": id };
    var lola = {};
    jquerygetNewData_ajax("WebGis/Service/getlola_byID.aspx", param, function (request) {
        var _data = request;
        if (request) {
            lola.lo = request.lo;
            lola.la = request.la;
            //            if (lo == "0" || la == "0")
            //            {
            //                alert('经纬度为(0,0)请检查终端状态');
            //            }
            // issilocation(lo, la, id);                          /**定位该警员经纬度**/
        }
    });
    return lola;
}
//计算终端上报的时间差
function GetDateDiff(startTime, endTime, diffType) {
    //将xxxx-xx-xx的时间格式，转换为 xxxx/xx/xx的格式   
    startTime = startTime.replace(/\-/g, "/");
    endTime = endTime.replace(/\-/g, "/");
    //将计算间隔类性字符转换为小写  
    diffType = diffType.toLowerCase();
    var sTime = new Date(startTime);      //开始时间  
    var eTime = new Date(endTime);  //结束时间  
    //作为除数的数字  
    var divNum = 1;
    switch (diffType) {
        case "second": divNum = 1000;
            break;
        case "minute": divNum = 1000 * 60;
            break;
        case "hour": divNum = 1000 * 3600;
            break;
        case "day": divNum = 1000 * 3600 * 24;
            break;
        default:
            break;
    }
    return parseInt((eTime.getTime() - sTime.getTime()) / parseInt(divNum));
}
var flag = 0;
var flagCopy = 0;
var number = 0;
function ajaxgettrace() {
    var ids = "";
    for (var i = 0; i < useprameters.nowtrace.length; i++) {
        ids += (i == 0) ? "'" + useprameters.nowtrace[i].item.split('|')[0] + "'" : ",'" + useprameters.nowtrace[i].item.split('|')[0] + "'";
    }
    var param = { "ids": ids };
    getNewData_ajaxtrace("WebGis/Service/GetTrace_byid.aspx", param, function (request) {
        var _data = request;
        var x0, y0, x1, y1, x2, y2;
        var x, y;
        var point0 = { x: 0, y: 0 };
        var point1 = { x: 0, y: 0 };
        var point2 = { x: 0, y: 0 };
        var v;
        var s;
        var ss, s01, s02, s12;
        var i = 0;
        var mapcoord;
        var map = _StaticObj.objGet("map");
        var timeout_interval = window.parent.TimeOut_Interval;  //GPS 上报时间超过该值 用虚线表示
        var distance_max = window.parent.Distance_Mas;
        for (var n = 0; n < _data.length; n++) {
            for (var h = 0; h < useprameters.nowtrace.length; h++) {
                if (_data[n].id == useprameters.nowtrace[h].item.split('|')[0] && _data[n].Position_err != "Unknow_PosErr" && _data[n].Position_err != "Lost_determine_pos" && _data[n].la != 0) {
                    if (useprameters.nowtrace[h].lola.length == 0) {
                        var lola = {};
                        lola.lo = _data[n].lo;
                        lola.la = _data[n].la;
                        lola.send_time = _data[n].send_time;
                        lola.tag = 0;
                        lola.flag = 0;
                        useprameters.nowtrace[h].lola.push(lola);
                    }
                    if (_data[n].lo == useprameters.nowtrace[h].lola[useprameters.nowtrace[h].lola.length - 1].lo && _data[n].la == useprameters.nowtrace[h].lola[useprameters.nowtrace[h].lola.length - 1].la) {
                        var Point;
                        Point = useprameters.nowtrace[h].lola[useprameters.nowtrace[h].lola.length - 1];
                        Point.send_time = _data[n].send_time;
                        useprameters.nowtrace[h].lola.pop();
                        useprameters.nowtrace[h].lola.push(Point);
                    }
                    else {
                        if (_data[n].lo != useprameters.nowtrace[h].lola[useprameters.nowtrace[h].lola.length - 1].lo || _data[n].la != useprameters.nowtrace[h].lola[useprameters.nowtrace[h].lola.length - 1].la) {
                            if (hz_map_region.minLng < _data[n].lo && hz_map_region.RDLng > _data[n].lo && hz_map_region.RDLat < _data[n].la && hz_map_region.maxLat > _data[n].la) { //判断是否超出范围
                                // 添加实现对每两个点之间的时间判断
                                var priPoint = {};
                                priPoint.send_time = useprameters.nowtrace[h].lola[useprameters.nowtrace[h].lola.length - 1].send_time;
                                priPoint.lo = useprameters.nowtrace[h].lola[useprameters.nowtrace[h].lola.length - 1].lo;
                                priPoint.la = useprameters.nowtrace[h].lola[useprameters.nowtrace[h].lola.length - 1].la;
                                priPoint.flag = useprameters.nowtrace[h].lola[useprameters.nowtrace[h].lola.length - 1].flag;
                                priPoint.tag = useprameters.nowtrace[h].lola[useprameters.nowtrace[h].lola.length - 1].tag;
                                var lola = {};
                                lola.lo = _data[n].lo;
                                lola.la = _data[n].la;
                                lola.send_time = _data[n].send_time;
                                lola.tag = 0;                            //现阶段标识为虚线或者实线的点：tag=0表示为实线点，tag=1为虚线点
                                lola.flag = 0;                          //标识是否为人为修正添加的点：flag=0表示原来的点，flag=1表示修复之后人工添加的点
                                                         
                                var beginTime = new Date(Date.parse(priPoint.send_time.replace(/\-/g, "/")));
                                var endTime = new Date(Date.parse(lola.send_time.replace(/\-/g, "/")));
                                var timeout = GetDateDiff(beginTime, endTime, "second");
                                number++;
                                if (timeout > timeout_interval)//此处的时间差用来界定终端长时间未上报GPS信息的点。
                                {     //人工制造长时间未上报GPS的点    if (useprameters.nowtrace[h].lola.length != 0 && useprameters.nowtrace[h].lola.length % 5 == 0)                                 
                                    useprameters.nowtrace[h].lola.pop();
                                    priPoint.tag = 1;
                                    useprameters.nowtrace[h].lola.push(priPoint);
                                    lola.tag = 1;
                                }                               
                                //轨迹线修复算法-----------------------------------------------------------------
                                if (useprameters.nowtrace[h].lola.length > 3) {//目前该版本去掉轨迹修复
                                    var lola1 = {};
                                    var lola2 = {};
                                    lola1.lo = useprameters.nowtrace[h].lola[useprameters.nowtrace[h].lola.length - 1].lo;
                                    lola1.la = useprameters.nowtrace[h].lola[useprameters.nowtrace[h].lola.length - 1].la;
                                    lola1.tag = useprameters.nowtrace[h].lola[useprameters.nowtrace[h].lola.length - 1].tag
                                    lola1.flag = useprameters.nowtrace[h].lola[useprameters.nowtrace[h].lola.length - 1].flag;
                                    lola1.send_time = useprameters.nowtrace[h].lola[useprameters.nowtrace[h].lola.length - 1].send_time;
                                    lola2.lo = useprameters.nowtrace[h].lola[useprameters.nowtrace[h].lola.length - 2].lo;
                                    lola2.la = useprameters.nowtrace[h].lola[useprameters.nowtrace[h].lola.length - 2].la;
                                    lola2.tag = useprameters.nowtrace[h].lola[useprameters.nowtrace[h].lola.length - 2].tag
                                    lola2.flag = useprameters.nowtrace[h].lola[useprameters.nowtrace[h].lola.length - 2].flag;
                                    lola2.send_time = useprameters.nowtrace[h].lola[useprameters.nowtrace[h].lola.length - 2].send_time;
                                    s01 = GetValue(lola.la, lola.lo, lola1.la, lola1.lo); //下一个点到倒数第一个点的距离
                                    s02 = GetValue(lola.la, lola.lo, lola2.la, lola2.lo);

                                    if ((s02 > distance_max || s01 > distance_max) && (endTime - beginTime) < 30000) {   //根据最新加入数组中得当前点lola与倒数第二个和第三个点的距离，判断点lola是否是异常点，如是则修复。
                                        lola = lola1;
                                        useprameters.nowtrace[h].lola.pop();
                                    }

                                }

                                if (useprameters.nowtrace[h].lola.length == 500) {
                                    useprameters.nowtrace[h].lola.splice(0, 1);
                                }
                                useprameters.nowtrace[h].lola.push(lola);
                            }
                        }
                    }
                    //modify version
                    trajectoryPlayback("firstTrajectory" + useprameters.nowtrace[h].item.split('|')[0], useprameters.nowtrace[h].lola, useprameters.nowtrace[h].item.split('|')[1], useprameters.nowtrace[h].item.split('|')[2], useprameters.nowtrace[h].item.split('|')[3]);
                    CollectGarbage();                 
                    continue;
                }
            }
        }
    }, false, false);

}

function opencolorpic(id, sendtime) {
    // mycallfunction('manager_selectcolor', 440, 354, id + "&sendtime=" + sendtime, 998, false);
    mycallfunction('manager_selectcolor', 440, 354, id, 998, false);
    //$("#nowtrace").css("left", event.x).css("top", event.y).show();
}
function selectcolortrace(id, color, lineweight, linestyle, lineint,ISSI)
{ 
    PeruserRealtimeTrace_ISSI(id, ISSI, color, lineweight);
    addIdTorealtimeTraceUserIds(id);
    writeLogForRealTraceOpen(ISSI);
    return;


    var valuearry = [];
    if (istracein(id)) return;
    var layerCell = LayerControl.CellGet("Police,0,0", id);
    var tracvalue = {};
    tracvalue.item = id + "|" + color + "|" + lineweight + "|" + linestyle + "|" + layerCell.Info + "|" + lineint;
    tracvalue.lola = [];
    var lola = {};
    lola.lo = layerCell.Longitude;
    lola.la = layerCell.Latitude;
    lola.tag = 0;
    lola.flag = 0;
    lola.send_time = layerCell.Send_time;
    tracvalue.lola.push(lola);
    useprameters.nowtrace.push(tracvalue);
    var ifrs = document.frames["select_user_ifr"];
    if (ifrs) {
        ifrs.checkbz(); //框选后图标
    }

    $("#manager_selectcolor").remove();
}
function selectcolortrace2(id, color, lineweight, linestyle, lineint,ISSI) { //颜色选择后调用画轨迹
    //var color_flex = color.replace("#", "0x");
    //var mainSWF = document.getElementById("main");
    //if (mainSWF) {
    //    //mainSWF.callbackPeruserRealtimeTrace_ISSI(ISSI, 0x7a0026, 2);
    //    mainSWF.callbackPeruserRealtimeTrace_ISSI(ISSI, color_flex, lineweight);        
    //}
    //写入变量
    PeruserRealtimeTrace_ISSI(id, ISSI, color, lineweight);
    addIdTorealtimeTraceUserIds(id);
    writeLogForRealTraceOpen(ISSI);
    return;


    var valuearry = [];
    if (istracein(id)) return;
    var layerCell = LayerControl.CellGet("Police,0,0", id);
    var tracvalue = {};
    //tracvalue.item = id + "|" + sendtime + "|" + color + "|" + lineweight + "|" + linestyle + "|" + layerCell.Info + "|" + lineint;
    tracvalue.item = id + "|" + color + "|" + lineweight + "|" + linestyle + "|" + layerCell.Info + "|" + lineint;
    tracvalue.lola = [];
    useprameters.nowtrace.push(tracvalue);
    // useprameters.nowtrace.push(id + "|" + sendtime + "|" + color + "|" + lineweight + "|" + linestyle + "|" + layerCell.Info + "|" + lineint); //存入临时数据变量
    // ajaxgettrace(id, sendtime, color, lineweight, linestyle, layerCell.Info, lineint);
    // writeLog("oper", "[实时轨迹]：开启ISSI(" + layerCell.ISSI + ")的实时轨迹" + "[" + LOGTimeGet() + "]");         /**日志：操作日志 **/
    var ifrs = document.frames["select_user_ifr"];
    if (ifrs) {
        ifrs.checkbz(); //框选后图标
    }
    var manager_selectcolor = $("#RtTrackByCtrlPanl").remove();

}

function istracein(id) {
    for (var i = 0; i < useprameters.nowtrace.length; i++) {
        if (id == useprameters.nowtrace[i].item.split('|')[0])
            return true;
    }
    return false;
}

function indeofarraytrac(id) {
    for (var i = 0; i < useprameters.nowtrace.length; i++) {
        if (id == useprameters.nowtrace[i].item.split('|')[0])
            return i;
    }
}

function trajectoryPlayback_NoModifyVersion(id, data, color, lineweight, linestyle) {
    var mapdiv = document.getElementById("map");
    var divTrajectory;
    var trac = document.getElementById(id);
    if (!trac) {
        divTrajectory = document.createElement("v:polyline");
        divTrajectory.id = id;
        divTrajectory.name = "firstTrajectory1";
        divTrajectory.stroked = "true";
        divTrajectory.style.position = "absolute";
        divTrajectory.filled = "false";
        divTrajectory.strokecolor = color; //线条颜色
        var v_stroke = document.createElement('v:stroke');
        v_stroke.opacity = "1";
        v_stroke.StartArrow = "";// "Oval";
        v_stroke.EndArrow = "Classic"
        v_stroke.dashstyle = linestyle;
        v_stroke.Weight = lineweight;
        divTrajectory.appendChild(v_stroke);
    }
    else {
        divTrajectory = trac;
    }
    var data_i;
    var points = "";
    var map = _StaticObj.objGet("map");
    for (data_i = 0; data_i < data.length; data_i++) {
        var mapcoord = map.getPixelInMap({ lo: data[data_i]["lo"], la: data[data_i]["la"] });
        points += mapcoord.x + "," + mapcoord.y + " ";
    }
    if (divTrajectory.points) {
        divTrajectory.points.value = points.slice(0, -1);
    }
    else {
        divTrajectory.points = points.slice(0, -1);
    }
    mapdiv.appendChild(divTrajectory);
    mapdiv = null;
    trac = null;
    divTrajectory = null
    v_stroke = null;
    map = null;
    data_i = null;
    points = null;
    CollectGarbage();
}
function trajectoryPlayback_shixian(id, data, color, lineweight, linestyle) {
    var mapdiv = document.getElementById("map");
    var divTrajectory;
    var trac = document.getElementById(id);
    if (!trac) {
        divTrajectory = document.createElement("v:polyline");
        divTrajectory.id = id;
        divTrajectory.name = "firstTrajectory1";
        divTrajectory.stroked = "true";
        divTrajectory.style.position = "absolute";
        divTrajectory.filled = "false";
        divTrajectory.strokecolor = color; //线条颜色
        var v_stroke = document.createElement('v:stroke');
        v_stroke.opacity = "1";
        v_stroke.StartArrow = "";// "Oval";
        v_stroke.EndArrow = "Classic"
        v_stroke.dashstyle = linestyle;
        v_stroke.Weight = lineweight;
        divTrajectory.appendChild(v_stroke);
    }
    else {
        divTrajectory = trac;
    }
    var data_i;
    var points = "";
    var map = _StaticObj.objGet("map");
    for (data_i = 0; data_i < data.length; data_i++) {
        var mapcoord = map.getPixelInMap({ lo: data[data_i]["lo"], la: data[data_i]["la"] });
        points += mapcoord.x + "," + mapcoord.y + " ";
    }
    if (divTrajectory.points) {
        divTrajectory.points.value = points.slice(0, -1);
    }
    else {
        divTrajectory.points = points.slice(0, -1);
    }
    mapdiv.appendChild(divTrajectory);
    mapdiv = null;
    trac = null;
    divTrajectory = null
    v_stroke = null;
    map = null;
    data_i = null;
    points = null;
    CollectGarbage();
}
//如果所有点皆为超长时间上报的点，则直接使用虚线将所有点画出
function trajectoryPlayback_xuxian(id, data, color, lineweight, linestyle) {
    var mapdiv = document.getElementById("map");
    var trac = document.getElementById(id);
    if (trac) removeChildSafe(trac);
    var divTrajectory = document.createElement("v:polyline");
    divTrajectory.id = id;
    divTrajectory.name = "firstTrajectory1";
    divTrajectory.stroked = "true";
    divTrajectory.style.position = "absolute";
    divTrajectory.filled = "false";
    divTrajectory.strokecolor = color; //线条颜色
    var v_stroke_dot = document.createElement('v:stroke');
    v_stroke_dot.opacity = "1";
    v_stroke_dot.StartArrow = "Oval";
    v_stroke_dot.EndArrow = "Classic"
    v_stroke_dot.dashstyle = "Dash";
    v_stroke_dot.Weight = lineweight;
    divTrajectory.appendChild(v_stroke_dot);
    var data_i;
    var points = "";
    var map = _StaticObj.objGet("map");
    for (data_i = 0; data_i < data.length; data_i++) {
        var mapcoord = map.getPixelInMap({ lo: data[data_i]["lo"], la: data[data_i]["la"] });
        points += mapcoord.x + "," + mapcoord.y + " ";
    }
    divTrajectory.points = points.slice(0, -1);
    mapdiv.appendChild(divTrajectory);
    mapdiv = null;
    trac = null;
    divTrajectory = null
    v_stroke_dot = null;
    map = null;
    data_i = null;
    points = null;
    CollectGarbage();
}
//如果超长时间上报的点，分散在数组中，也即 实线和虚线交替出现的情况，则使用分段方法进行画线，该函数实现实线的画法
function trajectoryPlayback_shixian_fenduan(id, data, color, lineweight, linestyle, mapdiv, i) {
    var trac = document.getElementById(id + i);
    var divTrajectory;
    if (!trac) {
        divTrajectory = document.createElement("v:polyline");
        divTrajectory.id = id + i;
        divTrajectory.name = "firstTrajectory1";
        divTrajectory.stroked = "true";
        divTrajectory.style.position = "absolute";
        divTrajectory.filled = "false";
        divTrajectory.strokecolor = color; //线条颜色
        var v_stroke = document.createElement('v:stroke');
        v_stroke.opacity = "1";
        v_stroke.StartArrow = "";// "Oval";
        v_stroke.EndArrow = "Classic"
        v_stroke.dashstyle = linestyle;
        v_stroke.Weight = lineweight;
        divTrajectory.appendChild(v_stroke);
    }
    else {
        divTrajectory = trac;
    }
    var data_i;
    var points = "";
    var map = _StaticObj.objGet("map");
    for (data_i = 0; data_i < data.length; data_i++) {
        var mapcoord = map.getPixelInMap({ lo: data[data_i]["lo"], la: data[data_i]["la"] });
        points += mapcoord.x + "," + mapcoord.y + " ";
    }
    if (divTrajectory.points) {
        divTrajectory.points.value = points.slice(0, -1);
    }
    else {
        divTrajectory.points = points.slice(0, -1);
    }
    mapdiv.appendChild(divTrajectory);
    mapdiv = null;
    trac = null;
    divTrajectory = null
    v_stroke = null;
    map = null;
    data_i = null;
    points = null;
    CollectGarbage();
}
//如果超长时间上报的点，分散在数组中，也即 实线和虚线交替出现的情况，则使用分段方法进行画线，该函数实现虚线的画法
function trajectoryPlayback_xuxian_fenduan(id, data, color, lineweight, linestyle, mapdiv, i) {
    var trac = document.getElementById(id + i);
    var divTrajectory;
    if (!trac) {
        divTrajectory = document.createElement("v:polyline");
        divTrajectory.id = id + i;
        divTrajectory.name = "firstTrajectory1";
        divTrajectory.stroked = "true";
        divTrajectory.style.position = "absolute";
        divTrajectory.filled = "false";
        divTrajectory.strokecolor = color; //线条颜色
        var v_stroke = document.createElement('v:stroke');
        v_stroke.opacity = "1";
        v_stroke.StartArrow = "";// "Oval";
        v_stroke.EndArrow = "Classic"
        v_stroke.dashstyle = "Dash";
        v_stroke.Weight = lineweight;
        divTrajectory.appendChild(v_stroke);
    }
    else {
        divTrajectory = trac;
    }
    var data_i;
    var points = "";
    var map = _StaticObj.objGet("map");
    for (data_i = 0; data_i < data.length; data_i++) {
        var mapcoord = map.getPixelInMap({ lo: data[data_i]["lo"], la: data[data_i]["la"] });
        points += mapcoord.x + "," + mapcoord.y + " ";
    }
    if (divTrajectory.points) {
        divTrajectory.points.value = points.slice(0, -1);
    }
    else {
        divTrajectory.points = points.slice(0, -1);
    }
    mapdiv.appendChild(divTrajectory);
    mapdiv = null;
    trac = null;
    divTrajectory = null
    v_stroke = null;
    map = null;
    data_i = null;
    points = null;
    CollectGarbage();
}
//---------------------------------------------------------------------------------
// 对轨迹线 进行修改，修改依据是，如果两个GPS点之间上报的时间差大于某个设定的值，则在这两点之间用虚线表示。
function trajectoryPlayback(id, data, color, lineweight, linestyle) {
    var last;
    if (data.length != 500) {
        trajectoryPlaybackNot500(id, data, color, lineweight, linestyle)
    }
    else {
        var trac = document.getElementById(id);
        if (trac) removeChildSafe(trac);
        trajectoryPlayback500(id, data, color, lineweight, linestyle)
    }
}
var stations_total = 0;
function trajectoryPlaybackNot500(id, data, color, lineweight, linestyle) {
    var stations = [];
    for (var t = 0; t < data.length; t++) {
        if (data[t]["tag"] == 1) {
            stations.push(t);
        }
    }

    if (stations.length == 0) {
        trajectoryPlayback_shixian(id, data, color, lineweight, linestyle);
    }
    else {
        var mapdiv = document.getElementById("map");
        var line_station_shixian_sets = [];
        var flag_station_shixian = {};
        var line_station_xuxian_sets = [];
        var flag_station_xuxian = {};
        var first = 0;
        for (var i = 0 ; i < stations.length;) {
            var flag_station_shixian = {};
            var flag_station_xuxian = {};
            var flag = 0;
            flag_station_shixian.begin = first;
            if (stations[stations.length - 1] < (data.length - 1) && i == stations.length - 1) {
                flag_station_shixian.end = data.length - 1;
            }
            else {
                if (i == 0) {
                    flag_station_shixian.end = stations[i];
                }
                if (i + 1 < stations.length && i != 0) {
                    flag_station_shixian.end = stations[i + 1];
                    flag = 1;
                }
                if (i + 1 == stations.length) {
                    flag_station_shixian.end = stations[i];
                }
            }
            var n;
            var k = 0;
            if (flag_station_shixian.begin != flag_station_shixian.end) {
                line_station_shixian_sets.push(flag_station_shixian);
            }
            for (n = i + 1; n < stations.length; n++) {
                if (stations[n] - stations[n - 1] == 1)
                    k++;
                else {
                    break;
                }
            }
            if (k != 0) {
                i = i + k;
            }
            else i = i + 1;
            if (i < stations.length) {
                if (flag == 1 && (i + 1) < stations.length) {
                    first = stations[i + 1];
                    i = i + 1;
                }
                else first = stations[i];
                flag = 0;
                flag_station_xuxian.begin = flag_station_shixian.end;
                flag_station_xuxian.end = first;
                if (flag_station_xuxian.begin != flag_station_xuxian.end) {
                    line_station_xuxian_sets.push(flag_station_xuxian);
                }
            }
            flag_station_xuxian = null;
            flag_station_shixian = null;
        }
        for (var k = 0; k < line_station_shixian_sets.length; k++) {
            var data_set = [];
            for (var m = line_station_shixian_sets[k].begin; m <= line_station_shixian_sets[k].end; m++) {
                data_set.push(data[m]);
            }
            trajectoryPlayback_shixian_fenduan(id, data_set, color, lineweight, linestyle, mapdiv, k + "shixian");
        }
        for (var k = 0; k < line_station_xuxian_sets.length; k++) {
            var data_set = [];
            for (var m = line_station_xuxian_sets[k].begin; m <= line_station_xuxian_sets[k].end; m++) {
                data_set.push(data[m]);
            }
            trajectoryPlayback_xuxian_fenduan(id, data_set, color, lineweight, linestyle, mapdiv, k + "xuxian");
        }
        mapdiv = null;
    }
}

function trajectoryPlayback500(id, data, color, lineweight, linestyle) {
    var i = 0;
    var stations = [];
    var tag = [];
    var flag = 0;
    for (var t = 0; t < data.length; t++) {
        if (data[t]["tag"] == 1) {
            stations.push(t);
        }
    }
    if (stations.length == 1 || stations.length == 0) {
        trajectoryPlayback_shixian(id, data, color, lineweight, linestyle);
        flag = 1;
    }
    if (stations.length % 2 != 0) {
        data[stations[0]].tag = 0;
        stations.splice(0, 1);
    }
    if (flag == 0) {
        var mapdiv = document.getElementById("map");
        var line_station_shixian_sets = [];
        var flag_station_shixian = {};
        var line_station_xuxian_sets = [];
        var flag_station_xuxian = {};
        var first = 0;
        for (var i = 0 ; i < stations.length;) {
            var flag_station_shixian = {};
            var flag_station_xuxian = {};
            var flag = 0;
            flag_station_shixian.begin = first;
            if (stations[stations.length - 1] < (data.length - 1) && i == stations.length - 1) {
                flag_station_shixian.end = data.length - 1;
            }
            else {
                if (i == 0) {
                    flag_station_shixian.end = stations[i];
                }
                if (i + 1 < stations.length && i != 0) {
                    flag_station_shixian.end = stations[i + 1];
                    flag = 1;
                }
                if (i + 1 == stations.length) {
                    flag_station_shixian.end = stations[i];
                }
            }
            var n;
            var k = 0;
            if (flag_station_shixian.begin != flag_station_shixian.end) {
                line_station_shixian_sets.push(flag_station_shixian);
            }
            for (n = i + 1; n < stations.length; n++) {
                if (stations[n] - stations[n - 1] == 1)
                    k++;
                else {
                    break;
                }

            }
            if (k != 0) {
                i = i + k;
            }
            else i = i + 1;
            if (i < stations.length) {
                if (flag == 1 && (i + 1) < stations.length) {
                    first = stations[i + 1];
                    i = i + 1;
                }
                else first = stations[i];
                flag = 0;
                flag_station_xuxian.begin = flag_station_shixian.end;
                flag_station_xuxian.end = first;
                if (flag_station_xuxian.begin != flag_station_xuxian.end) {
                    line_station_xuxian_sets.push(flag_station_xuxian);
                }
            }
            flag_station_xuxian = null;
            flag_station_shixian = null;
        }
        for (var k = 0; k < line_station_shixian_sets.length; k++) {
            var data_set = [];
            for (var m = line_station_shixian_sets[k].begin; m <= line_station_shixian_sets[k].end; m++) {
                data_set.push(data[m]);
            }
            trajectoryPlayback_shixian_fenduan(id, data_set, color, lineweight, linestyle, mapdiv, k + "shixian");
        }
        for (var k = 0; k < line_station_xuxian_sets.length; k++) {
            var data_set = [];
            for (var m = line_station_xuxian_sets[k].begin; m <= line_station_xuxian_sets[k].end; m++) {
                data_set.push(data[m]);
            }
            trajectoryPlayback_xuxian_fenduan(id, data_set, color, lineweight, linestyle, mapdiv, k + "xuxian");
        }
    }
    mapdiv = null;

}








