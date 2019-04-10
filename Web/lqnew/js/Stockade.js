var AllStockadePoint = new Array(); /**@用来存放全局的电子栅栏信息，不规则多边形跟矩形，用于地图放大缩小等用*/
var AllStockadeOvalPoint = new Array(); /**@用来存放全局的电子栅栏信息，圆形，用于地图放大缩小等用*/

ReLoadStockade = function () {
    try {

        for (var i = 0; i < AllStockadePoint.length; i++) {
            var myStroke = document.getElementById("Stockade_" + AllStockadePoint[i].divid);
            if (myStroke) {
                //庞小斌，更改移除节点方式
                removeChildSafe(myStroke);
            }
        }
        for (var i = 0; i < AllStockadeOvalPoint.length; i++) {
            var myStroke = document.getElementById("Stockade_" + AllStockadeOvalPoint[i].divid);
            if (myStroke) {
                removeChildSafe(myStroke);
            }
        }
        //GetStockAdeInit();
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
    } catch (err) {
        writeLog("system", "stockade.js ReLoadStockade()，error info:" + err);
    }
}

/**@初始化的时候画出电子栅栏椭圆轨迹*/
CreateOval = function (id, data, divStyle) {
    try {

        var myP = document.getElementById("Stockade_" + id);
        if (myP) return;
        var mapdiv = document.getElementById("map");
        if (mapdiv == null)
            return;
        var divTrajectory = document.createElement("v:oval");
        mapdiv.appendChild(divTrajectory);
        divTrajectory.id = "Stockade_" + id;
        divTrajectory.name = "Stockade_1";
        divTrajectory.stroked = "true";
        divTrajectory.style.zIndex = 1;
        divTrajectory.style.position = "absolute";
        if (!divTrajectory.fill) {
            var v_fill = document.createElement("v:fill");
            v_fill.opacity = divStyle.opacity / 100;
            divTrajectory.appendChild(v_fill);
        }
        else {
            divTrajectory.fill.opacity = divStyle.opacity / 100;
        }
        //divTrajectory.style.filter = "Alpha(Opacity=" + divStyle.opacity + ")"; //自定义透明度
        var v_stroke = document.createElement('v:stroke');
        v_stroke.dashstyle = divStyle.linestyle;
        divTrajectory.appendChild(v_stroke);

        divTrajectory.fillcolor = divStyle.fillcolor; //自定义颜色
        divTrajectory.strokecolor = divStyle.strokecolor;
        divTrajectory.ondblclick = function () {
            window.parent.mycallfunction('edit_Stackade', 434, 445, id);
        }

        var map = _StaticObj.objGet("map");
        if (map == null) return;
        var px1 = map.getPixelInMap({ lo: data.lo1, la: data.la1 }); //左边点的xy坐标
        var px2 = map.getPixelInMap({ lo: data.lo2, la: data.la2 }); //上边点的xy坐标
        var px3 = map.getPixelInMap({ lo: data.lo3, la: data.la3 }); //上边点的xy坐标
        var px4 = map.getPixelInMap({ lo: data.lo4, la: data.la4 }); //上边点的xy坐标
        if (px1 != null || px2 != null || px3 != null || px4 != null) {
            divTrajectory.style.width = px3.x - px1.x + "px";
            divTrajectory.style.height = px2.y - px4.y + "px";
            divTrajectory.style.top = px4.y + "px";
            divTrajectory.style.left = px1.x + "px";

            var obj = document.getElementById(id + "deldiv");
            if (obj) {
                obj.style.left = px1.x;
                obj.style.top = px1.y;
                return;
            }else {
                var delDiv = document.createElement("div");
                mapdiv.appendChild(delDiv);
                delDiv.style.position = "absolute";
                delDiv.id = id + "deldiv";
                delDiv.style.zIndex = 5;
                delDiv.style.left = px1.x;
                delDiv.style.top = px1.y;
                var innerimg = document.createElement("img");
                innerimg.src = 'lqnew/images/close.png';
                innerimg.onclick = function () {
                    if (confirm(GetTextByName("BeSureCloseTheStock", useprameters.languagedata))) {//多语言：确定需要删除此电子栅栏吗？
                        delPolyDZSL2(id);
                        removeChildSafe(delDiv);
                    }
                }
                innerimg.onmouseover = function () {
                    return function (divTrajectory) {
                        innerimg.src = 'lqnew/images/close_un.png';
                        StrockadeLineShow(divTrajectory);
                    } (divTrajectory);
                }
                innerimg.onmouseout = function () {
                    innerimg.src = 'lqnew/images/close.png';
                    divTrajectory.strokecolor = divStyle.strokecolor
                    clearInterval(setTimes);
                }
                delDiv.appendChild(innerimg);

            }


        }
    } catch (err) {
        writeLog("system", "stockade.js CreateOval.function，error info:" + err);
    }
}
function delPolyDZSL2(id) {
    try {
        var dp = new DrawPolygon();
        dp.RemoveStroke(id);
        dp.RemoveFromAllStockadePoint(id);
//        jquerygetNewData_ajax("Handlers/Stockade_Handler.ashx", { cmd: "delbydivid", id: id }, function (msg) {
//            writeLog("oper", "[电子栅栏]：" + msg + "[" + LOGTimeGet() + "]");
//            alert(msg);
//        });
        $.ajax({
            type: "POST",
            url: "Handlers/Stockade_Handler.ashx",
            data: { cmd: "delbydivid", id: id },
            success: function (msg) {
                writeLog("oper", "[" + GetTextByName("Stack", useprameters.languagedata) + "]:" + msg + "[" + LOGTimeGet() + "]");//多语言：电子栅栏
                alert(msg);
            }
        });
    } catch (errr) {
        writeLog("system", "stockade.js delPolyDZSL2.function，error info:" + errr);
    }
}
//用来闪烁电子栅栏
var setTimes = "";
function StrockadeLineShow(divTrajectory) {
    divTrajectory.strokecolor = "#ee1d24";
    setTimes = setInterval(function () {
        if (divTrajectory.strokecolor != "#ee1d24") {
            divTrajectory.strokecolor = "#ee1d24";
        } else {
            divTrajectory.strokecolor = "#000000"
        }
    },500);
}
/**@初始化的时候画出电子栅栏矩形多边形轨迹*/
CreateOldPolygon = function (id, data, divStyle) {
    try {
        var myP = document.getElementById("Stockade_" + id);
        if (myP)/**@如果要画的对象已经存在，则不再重画*/
            return;
        var mapdiv = document.getElementById("map");
        var divTrajectory = document.createElement("v:polyline");
        divTrajectory.id = "Stockade_" + id;
        divTrajectory.name = "Stockade_1";
        divTrajectory.stroked = "true";
        divTrajectory.style.position = "absolute";
        divTrajectory.style.zIndex = 1;
        divTrajectory.ondblclick = function () {
            window.parent.mycallfunction('edit_Stackade', 434, 445, id);
        }
        //divTrajectory.style.dashstyle = divStyle.linestyle;
        var v_stroke = document.createElement('v:stroke');
        v_stroke.dashstyle = divStyle.linestyle;
        //v_stroke.Weight = 0.1;
        divTrajectory.appendChild(v_stroke);
        divTrajectory.filled = "true";

        //divTrajectory.style.filter = "Alpha(Opacity=" + divStyle.opacity + ")"; //自定义透明度
        divTrajectory.fillcolor = divStyle.fillcolor; //自定义颜色
        divTrajectory.strokecolor = divStyle.strokecolor;
        var data_i;
        var points = "";
        var map = _StaticObj.objGet("map");
        if (map == null) return;
        for (data_i = 0; data_i < data.length; data_i++) {
            var mapcoord = map.getPixelInMap({ lo: data[data_i].lo, la: data[data_i].la });
            points += mapcoord.x + "," + mapcoord.y + " ";
        }

        if (data.length > 0) {
            var mapcoord = map.getPixelInMap({ lo: data[0].lo, la: data[0].la });
            if (mapcoord != null) {
                points += mapcoord.x + "," + mapcoord.y + " ";
                delX = mapcoord.x;
                delY = mapcoord.y;
            }
        }
        divTrajectory.points = points.slice(0, -1);
        var delX = "";
        var delY = "";
        if (data.length > 1) {
            var mapcoord = map.getPixelInMap({ lo: data[data.length - 1].lo, la: data[data.length - 1].la });
            if (mapcoord != null) {
                delX = mapcoord.x;
                delY = mapcoord.y;
            }
        }
        mapdiv.appendChild(divTrajectory);
        if (!divTrajectory.fill) {
            var v_fill = document.createElement("v:fill");
            v_fill.opacity = divStyle.opacity / 100;
            divTrajectory.appendChild(v_fill);
        }
        else {
            divTrajectory.fill.opacity = divStyle.opacity / 100;
        }

        var obj = document.getElementById(id + "deldiv");
        if (obj) {
            obj.style.left = delX;
            obj.style.top = delY;
            return;
        }
        else {
            var delDiv = document.createElement("div");

            delDiv.id = id + "deldiv";
            delDiv.style.position = "absolute";
            delDiv.style.zIndex = 5;
            delDiv.style.left = delX;
            delDiv.style.top = delY;
            mapdiv.appendChild(delDiv);
            var innerimg = document.createElement("img");
            innerimg.src = 'lqnew/images/close.png';
            innerimg.onclick = function () {
                if (confirm(GetTextByName("BeSureCloseTheStock", useprameters.languagedata))) {//多语言：确定需要删除此电子栅栏吗？
                    delPolyDZSL2(id);
                    removeChildSafe(delDiv);
                }
            }

            innerimg.onmouseover = function () {
                return function (divTrajectory) {
                    innerimg.src = 'lqnew/images/close_un.png';
                    StrockadeLineShow(divTrajectory);
                } (divTrajectory);
            }
            innerimg.onmouseout = function () {
                innerimg.src = 'lqnew/images/close.png';
                divTrajectory.strokecolor = divStyle.strokecolor
                clearInterval(setTimes);
            }
            delDiv.appendChild(innerimg);
        }

    } catch (err) {

        //writeLog("system", "stockade.js CreateOldPolygon.function，error info:" + err);
    }
};
/**@页面加载的时候获取电子栅栏相应的坐标,删除电子栅栏后，必须重新调用此方法，来重新画图，或者后面修改显示或不显示时也必须重新调用此方法*/
GetStockAdeInit = function () {
    try {
        /*    getNewData_ajaxStock("Handlers/GetStockade_Handler.ashx", "", function (msg) {
       
        })*/

        AllStockadePoint.length = 0;
        AllStockadeOvalPoint.length = 0;
        jquerygetNewData_ajax("Handlers/GetStockade_Handler.ashx", "", function (msg) {
            if (msg) {
            
                var myarray = new Array();
                // AllStockadePoint = eval(msg);
                myarray = eval(msg);
                for (var p in myarray) {
                    try {
                        var type = myarray[p].type;
                        var divid = myarray[p].divid;

                        var myds = new Array();
                        myds = eval(myarray[p].divstyle);
                        var divstyle = myds[0];
                        var mypa = new Array();
                        mypa = eval(myarray[p].pa);

                        if (type == 2) {
                            myarray[p].divstyle = divstyle;
                            AllStockadePoint.push(myarray[p]);
                            CreateOldPolygon(divid, mypa, divstyle);
                        }
                        if (type == 1) {
                            var pas = new Array();
                            pas.push({ lo: mypa[0].minLo, la: mypa[0].minLa });
                            pas.push({ lo: mypa[0].maxLo, la: mypa[0].minLa });
                            pas.push({ lo: mypa[0].maxLo, la: mypa[0].maxLa });
                            pas.push({ lo: mypa[0].minLo, la: mypa[0].maxLa });
                            AllStockadePoint.push({ divid: divid, pa: pas, type: 1, divstyle: divstyle });
                            CreateOldPolygon(divid, pas, divstyle);
                        }
                        if (type == 3 || type == 0) {
                            AllStockadeOvalPoint.push({ divid: divid, pa: mypa[0], divstyle: divstyle, type: 3 });
                            CreateOval(divid, mypa[0], divstyle);

                        }
                    } catch (exx) {
                        continue;
                    }
                }
                
                setInterval(IsInStockade, fenceFreshTime); /**@每隔多少时间去检查是否有警员越界*/
            }
        });

    } catch (err) {
        writeLog("system", "stockade.js GetStockAdeInit.funtion，error info:" + err);
    }
};
/**@判断被划在电子栅栏中的警员是否越界*/
IsInStockade = function () {
    try {
     
        if (!refUserFlag) {//调度台用户关联成功后才能进行电子栅栏消息提醒 界面没加载完
            return;
        }

        //**@当客户端保存的电子栅栏数量为0的时候 不去判断是否越界
        if (AllStockadePoint.length <= 0 && AllStockadeOvalPoint.length <= 0) {
            //return;
        }
        /*@这个 可能会跟警员显示冲突*/


        getNewData_ajaxStock("Handlers/GetIsInStockadeList.ashx", "", function (msg) {
            if (msg) {

                var myarray = new Array();
                myarray = eval(msg);
              
                var p = 0;
                var doisinstockade = setInterval(function () {
                    if (myarray.length > p) {
                        var lo = myarray[p].lo;
                        var loginname = myarray[p].LoginName;
                        var la = myarray[p].la;
                        var userid = myarray[p].userid;
                        var Nam = myarray[p].Nam;
                        var userinstockid = myarray[p].userinstockid;
                        var issi = myarray[p].issi;
                        var createtime = myarray[p].createtime;
                        var title = myarray[p].title;
                        var mytype = myarray[p].type;
                        var laststatus = myarray[p].laststatus; //10表示 越界没有警报 11表示越界已经警报 20表示返回界限没警告 21表示返回界限已经警报
                        var mypa = new Array();
                        mypa = eval(myarray[p].pa);
                        //@根据类型来判断

                        if (mytype == 2) {//不规则多边形
                            if (!IsPtInPoly(lo, la, mypa)) {

                                writeLog("system", Nam + "(" + issi + ")" + GetTextByName("Beyond", useprameters.languagedata) + "[" + loginname + "]" + GetTextByName("In", useprameters.languagedata) + "[" + createtime +"]"+ GetTextByName("DelineationStock", useprameters.languagedata) + "[" + title + "]  [" + LOGTimeGet() + "]");//多语言：越出了；在；划定的电子栅栏
                                if (laststatus != "11") { //发送越界警告 并将laststatus改为11
                                    var myarr = new Array();
                                    myarr.push({ name: Nam, issi: issi, type: GetTextByName("use", useprameters.languagedata) });//多语言：用户
                                    if (useprameters.callActivexable) {
                                        sendMsg(myarr, GetTextByName("Beyond", useprameters.languagedata) +"["+ loginname +"]"+ GetTextByName("In", useprameters.languagedata) +"["+ createtime+"]" + GetTextByName("DelineationStock", useprameters.languagedata) + "[" + title + "]!", 0);//多语言:越过了；在；划定的电子栅栏
                                    }
                                    jquerygetNewData_ajax("Handlers/UpdateLastStatus.ashx", { id: userinstockid, status: "11" }, function (msg) { })
                                }
                            }
                            else {
                                if (laststatus != "21") {//修改状态+警报 laststatus改为21 并警报
                                    var myarr = new Array();
                                    myarr.push({ name: Nam, issi: issi, type: GetTextByName("use", useprameters.languagedata) });//多语言：用户
                                    if (useprameters.callActivexable) {
                                        sendMsg(myarr, GetTextByName("ToEnter", useprameters.languagedata) + "[" + loginname + "]" + GetTextByName("In", useprameters.languagedata) + "[" + createtime+"]" + GetTextByName("DelineationStock", useprameters.languagedata) + "[" + title + "]!", 0);//多语言：进入了；在；划定的电子栅栏
                                    }
                                    writeLog("system", Nam + "(" + issi + ")" + GetTextByName("ToEnter", useprameters.languagedata) + "[" + loginname + "]" + GetTextByName("In", useprameters.languagedata) + "[" + createtime +"]"+ GetTextByName("DelineationStock", useprameters.languagedata) + "[" + title + "],[" + LOGTimeGet() + "]");//多语言：进入了；在；划定的电子栅栏
                                    jquerygetNewData_ajax("Handlers/UpdateLastStatus.ashx", { id: userinstockid, status: "21" }, function (msg) { })
                                }
                            }
                        }
                        if (mytype == 1) {//矩形
                            
                            if (!IsPtInRectangle({ lo: lo, la: la }, mypa[0])) {

                                writeLog("system", Nam + "(" + issi + ")" + GetTextByName("Beyond", useprameters.languagedata) + "[" + loginname + "]" + GetTextByName("In", useprameters.languagedata) + "[" + createtime +"]"+ GetTextByName("DelineationStock", useprameters.languagedata) + "[" + title + "] [" + LOGTimeGet() + "]");//多语言：越出了；在；划定的
                                if (laststatus != "11") { //发送越界警告 并将laststatus改为11
                                    var myarr = new Array();
                                    myarr.push({ name: Nam, issi: issi, type: GetTextByName("use", useprameters.languagedata) });//多语言：用户
                                    if (useprameters.callActivexable) {
                                        sendMsg(myarr, GetTextByName("Beyond", useprameters.languagedata) + "[" + loginname + "]" + GetTextByName("In", useprameters.languagedata) + "[" + createtime +"]"+ GetTextByName("DelineationStock", useprameters.languagedata) + "[" + title + "]!", 0);//多语言：越过了；在；划定的
                                    }
                                    jquerygetNewData_ajax("Handlers/UpdateLastStatus.ashx", { id: userinstockid, status: "11" }, function (msg) { })
                                }
                            }
                            else {
                                if (laststatus != "21") {//修改状态+警报 laststatus改为21 并警报
                                    var myarr = new Array();
                                    myarr.push({ name: Nam, issi: issi, type: GetTextByName("use", useprameters.languagedata) });//多语言：用户
                                    writeLog("system", Nam + "(" + issi + ")" + GetTextByName("ToEnter", useprameters.languagedata) + loginname + GetTextByName("In", useprameters.languagedata) + createtime + GetTextByName("DelineationStock", useprameters.languagedata) + "[" + title + "],[" + LOGTimeGet() + "]");//多语言：进入了；在；划定的电子栅栏
                                    if (useprameters.callActivexable) {
                                        sendMsg(myarr, GetTextByName("ToEnter", useprameters.languagedata) + "[" + loginname + "]" + GetTextByName("In", useprameters.languagedata) + "[" + createtime +"]"+ GetTextByName("DelineationStock", useprameters.languagedata) + "[" + title + "]!", 0);//多语言：进入了;在;划定的
                                    }
                                    jquerygetNewData_ajax("Handlers/UpdateLastStatus.ashx", { id: userinstockid, status: "21" }, function (msg) { })
                                };

                            }
                        }
                        if (mytype == 3 || mytype == 0) {//椭圆 

                            if (!IsPtInOval({ lo: lo, la: la }, mypa[0])) {

                                writeLog("system", Nam + "(" + issi + ")" + GetTextByName("Beyond", useprameters.languagedata) + "[" + loginname + "]" + GetTextByName("In", useprameters.languagedata) + "[" + createtime +"]"+ GetTextByName("DelineationStock", useprameters.languagedata) + "[" + title + "]  [" + LOGTimeGet() + "]");//多语言：越出了；在；划定的
                                if (laststatus != "11") { //发送越界警告 并将laststatus改为11

                                    var myarr = new Array();
                                    myarr.push({ name: Nam, issi: issi, type: GetTextByName("use", useprameters.languagedata) });//多语言：用户
                                    if (useprameters.callActivexable) {
                                        sendMsg(myarr, GetTextByName("Beyond", useprameters.languagedata) + "[" + loginname + "]" + GetTextByName("In", useprameters.languagedata) + "[" + createtime +"]"+ GetTextByName("DelineationStock", useprameters.languagedata) + "[" + title + "]!", 0);//多语言：越过了；在；划定的
                                    }

                                    jquerygetNewData_ajax("Handlers/UpdateLastStatus.ashx", { id: userinstockid, status: "11" }, function (msg) { });
                                }
                            }
                            else {
                                if (laststatus != "21") {//修改状态+警报 laststatus改为21 并警报
                                    var myarr = new Array();
                                    myarr.push({ name: Nam, issi: issi, type: GetTextByName("use", useprameters.languagedata) });//多语言：用户
                                    writeLog("system", Nam + "(" + issi + ")" + GetTextByName("ToEnter", useprameters.languagedata) + "[" + loginname + "]" + GetTextByName("In", useprameters.languagedata) + "[" + createtime +"]"+ GetTextByName("DelineationStock", useprameters.languagedata) + "[" + title + "],[" + LOGTimeGet() + "]");//多语言：进入了，在，划定的电子栅栏
                                    if (useprameters.callActivexable) {
                                        sendMsg(myarr, GetTextByName("ToEnter", useprameters.languagedata) + "[" + loginname + "]" + GetTextByName("In", useprameters.languagedata) + "[" + createtime +"]"+ GetTextByName("DelineationStock", useprameters.languagedata) + "[" + title + "]!", 0);//多语言：进入了，在，划定的电子栅栏
                                    }

                                    jquerygetNewData_ajax("Handlers/UpdateLastStatus.ashx", { id: userinstockid, status: "21" }, function (msg) { });
                                }

                            }
                        }
                        if (mytype == 4) {//圆 

                            if (!isPtInCrile({ lo: lo, la: la }, mypa[0])) {

                                writeLog("system", Nam + "(" + issi + ")" + GetTextByName("Beyond", useprameters.languagedata) + "[" + loginname + "]" + GetTextByName("In", useprameters.languagedata) + "[" + createtime + "]" + GetTextByName("DelineationStock", useprameters.languagedata) + "[" + title + "]  [" + LOGTimeGet() + "]");//多语言：越出了；在；划定的
                                if (laststatus != "11") { //发送越界警告 并将laststatus改为11

                                    var myarr = new Array();
                                    myarr.push({ name: Nam, issi: issi, type: GetTextByName("use", useprameters.languagedata) });//多语言：用户
                                    if (useprameters.callActivexable) {
                                        sendMsg(myarr, GetTextByName("Beyond", useprameters.languagedata) + "[" + loginname + "]" + GetTextByName("In", useprameters.languagedata) + "[" + createtime + "]" + GetTextByName("DelineationStock", useprameters.languagedata) + "[" + title + "]!", 0);//多语言：越过了；在；划定的
                                    }

                                    jquerygetNewData_ajax("Handlers/UpdateLastStatus.ashx", { id: userinstockid, status: "11" }, function (msg) { });
                                }
                            }
                            else {
                                if (laststatus != "21") {//修改状态+警报 laststatus改为21 并警报
                                    var myarr = new Array();
                                    myarr.push({ name: Nam, issi: issi, type: GetTextByName("use", useprameters.languagedata) });//多语言：用户
                                    writeLog("system", Nam + "(" + issi + ")" + GetTextByName("ToEnter", useprameters.languagedata) + "[" + loginname + "]" + GetTextByName("In", useprameters.languagedata) + "[" + createtime + "]" + GetTextByName("DelineationStock", useprameters.languagedata) + "[" + title + "],[" + LOGTimeGet() + "]");//多语言：进入了，在，划定的电子栅栏
                                    if (useprameters.callActivexable) {
                                        sendMsg(myarr, GetTextByName("ToEnter", useprameters.languagedata) + "[" + loginname + "]" + GetTextByName("In", useprameters.languagedata) + "[" + createtime + "]" + GetTextByName("DelineationStock", useprameters.languagedata) + "[" + title + "]!", 0);//多语言：进入了，在，划定的电子栅栏
                                    }

                                    jquerygetNewData_ajax("Handlers/UpdateLastStatus.ashx", { id: userinstockid, status: "21" }, function (msg) { });
                                }

                            }
                        }
                        p++;
                    } else {
                        clearInterval(doisinstockade);
                    }

                }, 5);

                
            }
        });
        loadDZZL()

    } catch (err) {
        writeLog("system", "stockade.js IsInStockade.function，error info:" + err);
    }
}
/**@无用的方法，本来想用画*/
var CreateStrokeByPath = function (ID, data) {
    try {
        var mapDIv = document.getElementById("map");
        if (!mapDIv) {
            alert(GetTextByName("MapIDNotExistence", useprameters.languagedata));//多语言：地图ID不存在
            return;
        }
        var Path = "";
        var map = _StaticObj.objGet("map");
        for (data_i = 0; data_i < data.length; data_i++) {
            if (data_i == 0) {
                var mapcoord = map.getPixelInMap({ lo: data[data_i].lo, la: data[data_i].la });
                Path = " m" + mapcoord.x + "," + mapcoord.y + "l";
                //Path += mapcoord.x + "," + mapcoord.y + ",";
            } else if (data_i == data.length - 1) {
                var mapcoord = map.getPixelInMap({ lo: data[data_i].lo, la: data[data_i].la });
                Path += mapcoord.x + "," + mapcoord.y + "x e";
            } else {
                var mapcoord = map.getPixelInMap({ lo: data[data_i].lo, la: data[data_i].la });
                Path += mapcoord.x + "," + mapcoord.y + ",";
            }
        }
        alert(Path);
        var myStrokePath = document.createElement("v:shape");
        myStrokePath.id = "Stockade_" + ID;
        myStrokePath.path = Path.slice(0, -1);
        myStrokePath.filled = 'true';
        myStrokePath.style.position = "absolute";
        myStrokePath.style.zIndex = 1;
        myStrokePath.style.width = "100";
        myStrokePath.style.height = "100";
        myStrokePath.style.filter = "Alpha(Opacity=30)";
        myStrokePath.strokecolor = 'black';
        myStrokePath.strokeweight = '1';
        myStrokePath.coordsize = '100,100';
        myStrokePath.fillcolor = 'yellow';
        mapDIv.appendChild(myStrokePath);
    } catch (err) {
        writeLog("system", "stockade.js CreateStrokeByPath.function，error info:" + err);
    }
}

function DingWeiStockade(lo, la) {
    try {
        if (useprameters.lockid != 0) {
            alert(GetTextByName("HasLockFunction", useprameters.languagedata));//多语言：存在锁定用户
            return;
        }
        if (lo == "0.0000000" || la == "0.0000000") {
            alert(GetTextByName("JWDfanwei", useprameters.languagedata));//多语言：经纬度范围错误
            return;
        }
        var mainSWF = document.getElementById("main");
        if (mainSWF) {
            isSuccess = mainSWF.callbackLocate(parseFloat(lo), parseFloat(la));
           
        }
    } catch (err) {
        writeLog("system", "stockade.js DingWeiStockade.funcion，error info:" + err);
    }
}
/**@加亮电子栅栏,并移动到此*/
function jl(ID, mytype, arrpoint) {
    try {
        var myp = eval(arrpoint);
        var map = _StaticObj.objGet("map");
        if (mytype == '1') { //矩形
            // map.moveTo({ lo: (myp[0].maxLo + myp[0].minLo) / 2, la: (myp[0].maxLa + myp[0].minLa) / 2 });
            DingWeiStockade(myp[0].minLo, myp[0].maxLa);

        }
        if (mytype == '2') {
            //map.moveTo({ lo: myp[0].lo, la: myp[0].la });
            DingWeiStockade(myp[0].lo, myp[0].la);
        }
        if (mytype == '3' || mytype == '4') {//椭圆
            //map.moveTo({ lo: (myp[0].lo1 + myp[0].lo3) / 2, la: (myp[0].la2 + myp[0].la4) / 2 });
            DingWeiStockade(myp[0].lo1, myp[0].la1);
        }
       
       
    } catch (err) {
        writeLog("system", "stockade.js jl.function，error info:" + err);
    }
}
/**@隐藏电子栅栏，电子栅栏列表操作，这个只是不规则多边形、矩形*/
function HideThisStockadePoint(DivID) {
    try {
//        jquerygetNewData_ajax("Handlers/ShowOrHideStockade_Handler.ashx", { cmd: "hide", divid: DivID }, function (msg) {
//            if (msg == "true") {
//                var dp = new DrawPolygon();
//                dp.RemoveStroke(DivID);
//                dp.RemoveFromAllStockadePoint(DivID);
//                alert("隐藏成功");
//            } else alert("隐藏失败");
//        });
        $.ajax({
            type: "POST",
            url: "Handlers/ShowOrHideStockade_Handler.ashx",
            data: "cmd=hide&divid=" + DivID,
            success: function (msg) {
                if (msg == "true") {
                    var dp = new DrawPolygon();
                    dp.RemoveStroke(DivID);
                    dp.RemoveFromAllStockadePoint(DivID);

                    var delDiv = document.getElementById(DivID + "deldiv");
                    if (delDiv) {
                        removeChildSafe(delDiv);
                    }

                    alert(GetTextByName("HiddenSuccess", useprameters.languagedata));//多语言：隐藏成功
                } else {
                    alert(GetTextByName("HiddenFailed", useprameters.languagedata));//多语言：隐藏失败
                }
            }
        });
    } catch (err) {
        writeLog("system", "stockade.js HideThisStockadePoint.function，error info:" + err);
    }
}
/**@显示电子栅栏，电子栅栏列表操作*/
function ShowThisStockadePoint(DivID) {
    try {
        jquerygetNewData_ajax("Handlers/ShowStockade_Handler.ashx", { divid: DivID }, function (msg) {
            var myarray = new Array();
            // AllStockadePoint = eval(msg);
            myarray = eval(msg);
            for (var p in myarray) {
                // debugger
                var type = myarray[p].type;
                var divid = myarray[p].divid;
                var myds = new Array();
                myds = eval(myarray[p].divstyle);
                var divstyle = myds[0];

                var mypa = new Array();
                mypa = eval(myarray[p].pa);

                if (type == 2) {
                    myarray[p].divstyle = divstyle;
                    AllStockadePoint.push(myarray[p]);
                    CreateOldPolygon(divid, mypa, divstyle);
                }
                if (type == 1) {
                    var pas = new Array();
                    pas.push({ lo: mypa[0].minLo, la: mypa[0].minLa });
                    pas.push({ lo: mypa[0].maxLo, la: mypa[0].minLa });
                    pas.push({ lo: mypa[0].maxLo, la: mypa[0].maxLa });
                    pas.push({ lo: mypa[0].minLo, la: mypa[0].maxLa });
                    AllStockadePoint.push({ divid: divid, pa: pas, type: 1, divstyle: divstyle });
                    CreateOldPolygon(divid, pas, divstyle);
                }
                if (type == 3 || type == 0) {
                    AllStockadeOvalPoint.push({ divid: divid, pa: mypa[0], divstyle: divstyle, type: 3 });
                    CreateOval(divid, mypa[0], divstyle);

                }
            }
        });

    } catch (err) {
        writeLog("system", "stockade.js ShowThisStockadePoint.function，error info:" + err);
    }
}