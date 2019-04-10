/**@杨德军*/
/// <reference path="../../JQuery/jquery-1.5.2.js" />


var DrawPolygon = function () {
    {
        document.namespaces.add("v", "urn:schemas-microsoft-com:vml");
        this.MapID = "map";
    }
    this.MapID;
    this.Title;
    this.FillColor = "yellow";
    this.StrokeColor = "black";
    this.linestyle = "";
    this.strOpacity = 30;
    this.PolyPath = 'm0,0 l0,0';
    this.pointArray = new Array();
    this.isBeg = false;
    this.Working = false;
    this.poly1 = null;
    this.oldvalue = "";
    this.oldx = 0;
    this.oldy = 0;
    this.xx;
    this.yy;
    this.UserID;
    this.stockadeid;
    this.RemoveStroke = function (ID) {
        var myStroke = document.getElementById("Stockade_" + ID);
        if (myStroke) {
            var mapdiv = document.getElementById(this.MapID);
            mapdiv.removeChild(myStroke);
            this.pointArray.length = 0;
        }
    }
    this.RemoveFromAllStockadePoint = function (divid) {
        var newAllStockadeOvalPoint = new Array();
        for (var op in AllStockadeOvalPoint) {
            if (AllStockadeOvalPoint[op].divid != divid) {
                newAllStockadeOvalPoint.push(AllStockadeOvalPoint[op]);
            }
        }
        AllStockadeOvalPoint.length = 0;
        for (var pp in newAllStockadeOvalPoint) {
            AllStockadeOvalPoint.push(newAllStockadeOvalPoint[pp]);
        }

        var newAllStockadePoint = new Array();
        for (var ps in AllStockadePoint) {
            if (AllStockadePoint[ps].divid != divid) {
                newAllStockadePoint.push(AllStockadePoint[ps]);
            }
        }
        AllStockadePoint.length = 0;
        for (var pp in newAllStockadePoint) {
            AllStockadePoint.push(newAllStockadePoint[pp]);
        }
    }
    this.divMousedown = function (ID) {
        try {
            if (!this.isBeg)
                return;

            if (!this.Working)//第一次点击鼠标
            {
                this.pointArray.length = 0;
                var mapDIv = document.getElementById(this.MapID);
                if (!mapDIv) {
                    alert(GetTextByName("MapIDNotExistence", useprameters.languagedata));//多语言：地图ID不存在
                    return;
                }
                var varNow = new Date();

                this.stockadeid = varNow.getYear().toString() + varNow.getMonth().toString() + varNow.getDay().toString() + varNow.getHours().toString() + varNow.getMinutes().toString() + varNow.getSeconds().toString() + varNow.getMilliseconds().toString();

                var map = _StaticObj.objGet("map");
                var mapcoord = map.getPointByEvent();
                this.xx = mapcoord.x;
                this.yy = mapcoord.y;

                this.poly1 = document.createElement("v:shape");
                this.poly1.id = "Stockade_" + this.stockadeid;
                this.poly1.path = this.PolyPath;
                var myID = this.stockadeid; /**@内部函数里面不能直接访问this.xxx*/
                this.poly1.ondblclick = function () {
                  
                }
                this.poly1.filled = 'true';
                this.poly1.style.position = "absolute";
                this.poly1.style.zIndex = 1;
                this.poly1.style.left = this.xx;
                this.poly1.style.top = this.yy;
                this.poly1.style.width = "100";
                this.poly1.style.height = "100";
                this.poly1.style.filter = "Alpha(Opacity=" + this.strOpacity + ")"; //自定义透明度
                this.poly1.strokecolor = this.StrokeColor; //自定义边框长度
                this.poly1.strokeweight = '1';
                this.poly1.coordsize = '100,100';
                this.poly1.fillcolor = this.FillColor; //自定义填充颜色
                mapDIv.appendChild(this.poly1);
                var v_stroke = document.createElement('v:stroke');
                v_stroke.dashstyle = this.linestyle;
                this.poly1.appendChild(v_stroke);

                this.oldvalue = this.poly1.path.value.replace("e", "");
                this.oldx = this.xx;
                this.oldy = this.yy;
                this.Working = true;

                var myLatLng = map.getLatLngByEvent();
                this.pointArray.push({ lo: myLatLng.lo, la: myLatLng.la });
            }
            else {
                var map = _StaticObj.objGet("map");
                var myLatLng = map.getLatLngByEvent();
                if (this.poly1 != null) {
                    this.oldvalue = this.poly1.path.value.replace(" e", "");
                    this.pointArray.push({ lo: myLatLng.lo, la: myLatLng.la });
                }

            }
        } catch (err) {
            this.isBeg = false;
        }
    }
    this.divMouseMove = function () {
        try {
            if (!this.isBeg)
                return;
            var map = _StaticObj.objGet("map");
            var mapcoord = map.getPointByEvent();
            this.tempx = mapcoord.x;
            this.tempy = mapcoord.y;
            if (this.poly1 != null) {

                this.poly1.path = this.oldvalue + "," + (this.tempx - this.oldx) + "," + (this.tempy - this.oldy);
                this.poly1.path = this.poly1.path.value.replace(",0,0,", ",0,").replace(",0 e", "e");
            }


            var picdiv = document.getElementById("stockadediv");
            if (picdiv) {
                picdiv.style.left = event.x + 10;
                picdiv.style.top = event.y + 10;
                picdiv.innerHTML = "<span style='color:red'>&nbsp;&nbsp;" + GetTextByName("DrawPolygonTitle", useprameters.languagedata) + "</span>";//多语言：点击左键继续画多边形,点击右键结束画多边形,开始后不得缩放地图

            } else {
                //                var mapdiv = document.getElementById("map");
                var mydiv = document.createElement("div");
                mydiv.id = "stockadediv";
                mydiv.style.position = "absolute";
                mydiv.style.zIndex = 0;
                mydiv.style.top = event.y + 10;
                mydiv.style.left = event.x + 10;
                mydiv.innerHTML = "<span style='color:red'>&nbsp;&nbsp;" + GetTextByName("DrawPolygonTitle", useprameters.languagedata) + "</span>";//多语言：点击左键继续画多边形,点击右键结束画多边形,开始后不得缩放地图
                document.body.appendChild(mydiv);
            }
        } catch (err) {
            this.isBeg = false;
        }
    }
    this.divMouseUp = function () {
        if (!this.isBeg)
            return;
        if (event.button == 2) {
            var picdiv = document.getElementById("stockadediv");
            if (picdiv) {
                picdiv.innerHTML = "";
            }
            if (this.pointArray.length < 3) {
                alert(GetTextByName("Mustbegreater2Line", useprameters.languagedata));//多语言：必须大于2条边
                return;
            }
            var picdiv = document.getElementById("stockadediv");
            if (picdiv) {
                document.body.removeChild(picdiv);
            }
            this.poly1.path = this.oldvalue + "x e";
            var polypath = this.oldvalue + "x e";
            this.Working = false;
            this.poly1 = null;
            this.isBeg = false;

            /**@双击右键时，将数据保存到数据库*/
            var strpointarray = "";
            strpointarray += "[";
            for (var k in this.pointArray) {
                strpointarray += "{lo:" + this.pointArray[k].lo + ",la:" + this.pointArray[k].la + "},";
            }
            if (strpointarray.length > 0) {
                strpointarray = strpointarray.substring(0, strpointarray.length - 1);
            }
            strpointarray += "]";
            var tt = this.stockadeid;
            var pa = this.pointArray;
            var divStyle = "[{strokecolor: \\\"" + this.StrokeColor + "\\\", opacity: \\\"" + this.strOpacity + "\\\", fillcolor: \\\"" + this.FillColor + "\\\", linestyle: \\\"" + this.linestyle + "\\\"}]";
            var mysc = this.StrokeColor;
            var myop = this.strOpacity;
            var myfc = this.FillColor;
            var myls = this.linestyle;
            var DivID = this.stockadeid;
            isBegStackadeSel = false;

            $.ajax({
                type: "POST",
                url: "Handlers/Stockade_Handler.ashx",
                data: "cmd=add&title=" + this.Title + "&type=2&divstyle=" + divStyle + "&divid=" + this.stockadeid + "&pointarray=" + strpointarray + "&userid=" + this.UserID,
                success: function (msg) {
                    writeLog("oper", "[" + GetTextByName("Stack", useprameters.languagedata) + "]:" + msg + "[" + LOGTimeGet() + "]");//多语言：电子栅栏
                    alert(msg);
                    if (msg == GetTextByName("AddStackFailed", useprameters.languagedata)) {//多语言：电子栅栏添加失败
                        var d = new DrawPolygon();
                        d.RemoveStroke(tt);
                    }
                    if (msg == GetTextByName("AddStackSuccess", useprameters.languagedata)) {//多语言：电子栅栏添加成功
                        AllStockadePoint.push({ divid: tt, pa: pa, type: 2, divstyle: { strokecolor: mysc, opacity: myop, fillcolor: myfc, linestyle: myls } });
                        var myStroke = document.getElementById("Stockade_" + tt);
                        if (myStroke) {
                            var mapdiv = document.getElementById("map");;
                            mapdiv.removeChild(myStroke);
                        }
                        CreateOldPolygon(tt, pa, { strokecolor: mysc, opacity: myop, fillcolor: myfc, linestyle: myls });
                        isBegStackadeSel = false;
                       
                    }
                }
            })

        }
    }

}


function DelRectangle(ID) {
    var d = new DrawPolygon();
    d.RemoveFromAllStockadePoint(ID);
    lq_hiddenvml("Stockade_" + ID);

    var delDiv = document.getElementById(ID + "deldiv");
    if (delDiv) {
        var mapdiv = document.getElementById("map");
        mapdiv.removeChild(delDiv);
    }

}
function DrawRectangle(UserID, divStyle, mytitle) {
    var myStyle = "[{strokecolor: \\\"" + divStyle.strokecolor + "\\\", opacity: \\\"" + divStyle.opacity + "\\\", fillcolor: \\\"" + divStyle.fillcolor + "\\\", linestyle: \\\"" + divStyle.linestyle + "\\\"}]";
    var varNow = new Date();
    var ID = varNow.getYear().toString() + varNow.getMonth().toString() + varNow.getDay().toString() + varNow.getHours().toString() + varNow.getMinutes().toString() + varNow.getSeconds().toString() + varNow.getMilliseconds().toString();

    var choose = new Choose(_StaticObj.objGet("map"), LayerControl, { strokecolor: divStyle.strokecolor, opacity: divStyle.opacity / 100, fillcolor: divStyle.fillcolor, linestyle: divStyle.linestyle });

    choose.data.opacity = divStyle.opacity;
    choose.data.strokecolor = divStyle.strokecolor;
    choose.turnOn("rectangle");
    useprameters.vmlname = "Stockade_" + ID;
    choose.addEventListener("rectangleEnd", function (selected, range) {
        var rectPath = "[{minLo:" + range.latLng.minLo + ",maxLo:" + range.latLng.maxLo + ",minLa:" + range.latLng.minLa + ",maxLa:" + range.latLng.maxLa + "}]";
        var picdiv = document.getElementById("stockadediv"); //删除画好的提示
        if (picdiv) {
            document.body.removeChild(picdiv);
        }
        //alert(rectPath);
        choose.turnOff("rectangle");
        $.ajax({
            type: "POST",
            url: "Handlers/Stockade_Handler.ashx",
            data: "cmd=add&title=" + mytitle + "&divstyle=" + myStyle + "&type=1&divid=" + ID + "&pointarray=" + rectPath + "&userid=" + UserID,
            success: function (msg) {
                alert(msg);
                writeLog("oper", "[" + GetTextByName("Stack", useprameters.languagedata) + "]:" + msg + "[" + LOGTimeGet() + "]");//多语言：电子栅栏
                LayerControl.refurbish();
                if (msg == GetTextByName("AddStackFailed", useprameters.languagedata)) {//多语言：电子栅栏添加失败
                    lq_hiddenvml("Stockade_" + ID);
                }
                if (msg == GetTextByName("AddStackSuccess", useprameters.languagedata)) {//多语言：电子栅栏添加成功
                    var pas = new Array();
                    pas.push({ lo: range.latLng.minLo, la: range.latLng.minLa });
                    pas.push({ lo: range.latLng.maxLo, la: range.latLng.minLa });
                    pas.push({ lo: range.latLng.maxLo, la: range.latLng.maxLa });
                    pas.push({ lo: range.latLng.minLo, la: range.latLng.maxLa });

                    AllStockadePoint.push({ divid: ID, pa: pas, type: 1, divstyle: divStyle });
                    var myStroke = document.getElementById("Stockade_" + ID);
                    if (myStroke) {
                        var mapdiv = document.getElementById("map");;
                        mapdiv.removeChild(myStroke);
                    }
                    CreateOldPolygon(ID, pas, divStyle);
                    isBegStackadeSel = false;
                    
                }
            }
        })
    });
}

function DrawOval(UserID, divStyle, mytitle) {
    var myStyle = "[{strokecolor: \\\"" + divStyle.strokecolor + "\\\", opacity: \\\"" + divStyle.opacity + "\\\", fillcolor: \\\"" + divStyle.fillcolor + "\\\", linestyle: \\\"" + divStyle.linestyle + "\\\"}]";
    var varNow = new Date();
    var ID = varNow.getYear().toString() + varNow.getMonth().toString() + varNow.getDay().toString() + varNow.getHours().toString() + varNow.getMinutes().toString() + varNow.getSeconds().toString() + varNow.getMilliseconds().toString();

    var choose = new Choose(_StaticObj.objGet("map"), LayerControl, { strokecolor: divStyle.strokecolor, opacity: divStyle.opacity / 100, fillcolor: divStyle.fillcolor, linestyle: divStyle.linestyle });

    choose.data.opacity = divStyle.opacity;
    choose.data.strokecolor = divStyle.strokecolor;
    choose.turnOn("oval");
    useprameters.vmlname = "Stockade_" + ID;
    choose.addEventListener("ovalEnd", function (ths, range) {
        var picdiv = document.getElementById("stockadediv"); //删除画好的提示
        if (picdiv) {
            document.body.removeChild(picdiv);
        }
        var po1x = range.center.pixel.x - range.a;
        var po1y = range.center.pixel.y;
        var po2x = range.center.pixel.x;
        var po2y = range.center.pixel.y + range.b;
        var po3x = range.center.pixel.x + range.a;
        var po3y = range.center.pixel.y;
        var po4x = range.center.pixel.x;
        var po4y = range.center.pixel.y - range.b;

        var map = _StaticObj.objGet("map");
        var cp1 = map.getLatLngByPoint({ x: po1x, y: po1y });
        var cp2 = map.getLatLngByPoint({ x: po2x, y: po2y });
        var cp3 = map.getLatLngByPoint({ x: po3x, y: po3y });
        var cp4 = map.getLatLngByPoint({ x: po4x, y: po4y });

        var vpath = "[{lo1:" + cp1.lo + ",la1:" + cp1.la + ",lo2:" + cp2.lo + ",la2:" + cp2.la + ",lo3:" + cp3.lo + ",la3:" + cp3.la + ",lo4:" + cp4.lo + ",la4:" + cp4.la + ",centerlo:" + range.center.latLng.lo + ",centerla:" + range.center.latLng.la + "}]";
        choose.turnOff("oval");
        $.ajax({
            type: "POST",
            url: "Handlers/Stockade_Handler.ashx",
            data: "cmd=add&title=" + mytitle + "&divstyle=" + myStyle + "&type=3&divid=" + ID + "&pointarray=" + vpath + "&userid=" + UserID,
            success: function (msg) {
                LayerControl.refurbish();
                alert(msg);
                writeLog("oper", "[" + GetTextByName("Stack", useprameters.languagedata) + "]:" + msg + "[" + LOGTimeGet() + "]");//多语言：电子栅栏
                if (msg == GetTextByName("AddStackFailed", useprameters.languagedata)) {//多语言：电子栅栏添加失败
                    lq_hiddenvml("Stockade_" + ID);
                }
                if (msg == GetTextByName("AddStackSuccess", useprameters.languagedata)) {//多语言：电子栅栏添加成功
                    AllStockadeOvalPoint.push({ divid: ID, pa: { lo1: cp1.lo, la1: cp1.la, lo2: cp2.lo, la2: cp2.la, lo3: cp3.lo, la3: cp3.la, lo4: cp4.lo, la4: cp4.la, centerlo: range.center.latLng.lo, centerla: range.center.latLng.la }, divstyle: divStyle, type: 3 });

                    var myStroke = document.getElementById("Stockade_" + ID);
                    if (myStroke) {
                        var mapdiv = document.getElementById("map");;
                        mapdiv.removeChild(myStroke);
                    }
                    CreateOval(ID, { lo1: cp1.lo, la1: cp1.la, lo2: cp2.lo, la2: cp2.la, lo3: cp3.lo, la3: cp3.la, lo4: cp4.lo, la4: cp4.la, centerlo: range.center.latLng.lo, centerla: range.center.latLng.la }, divStyle);
                    isBegStackadeSel = false;
                  
                }
            }
        })

    });
}
