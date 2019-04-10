var vml_word_fontSize = 12;
var vml_word_filter = "alpha(opacity=10)";
var vml_word_color = "black"; //#00ccff
var vml_font_family = "幼圆";
var vml_word_filter_CI = "glow(color=green,Strength=2)";
var vml_OnlickFlag = 0;
function click(obj) {
    if (!vml_OnlickFlag) {
        lastEvent_x = event.x;
        lastEvent_y = event.y;
        setTimeout(exe_click_dblclick, 300, obj);
    }
    vml_OnlickFlag++;
}
function exe_click_dblclick(obj) {
    if (vml_OnlickFlag == 1) {
        addDelegate(cellOnclick, obj.ci, obj.layerID);
    }
    else if (vml_OnlickFlag == 2) {
        addDelegate(cellOndblclick, obj.ci, obj.layerID);
    }
    vml_OnlickFlag = 0;
}
function menuRight(arg) {
    alert(arg);
}
function onclick() {
    click(this);
}
function ondblclick() {
    click(this);
}
//不要通过=function(){}的方式，这样会造成内存泄漏
function addVMLEvent(obj) {
    obj.onclick = cellMouseEvent.click;
    obj.ondblclick = cellMouseEvent.dblclick;
    obj.oncontextmenu = cellMouseEvent.contextmenu;
}
//通用文字输出类 可用于Site_Name显示
function WordModel(layerCell, layer, property) {
    if (layerCell[property]) {
        var coord = new Coordinate(layerCell.Longitude, layerCell.Latitude);
        var mapcoord = coord.getMapCoord(coord);
        layerCell.x = mapcoord.x;
        layerCell.y = mapcoord.y;
        var word = document.createElement('div');
        //庞小斌修改，创建节点后立刻append
        layer.appendChild(word);
        word.id = layerCell.LayerID + "|" + layerCell.ID + '|' + property;
        word.style.left = layerCell.x;
        word.style.top = layerCell.y + 5;
        word.style.backgroundColor = "#FFFFFF";
        word.style.position = "absolute";
        word.style.color = vml_word_color;
        word.style.fontSize = vml_word_fontSize;
        word.style.filter = vml_word_filter;
        word.style.fontFamily = vml_font_family;
        word.style.wordBreak = "keep-all";
        word.style.fontWeight = "normal";
        word.innerHTML = layerCell[property];
    }
}
//Image输出类
//layer要添加到的图层div
function ImageModel() {
    BaseListener.apply(this);
    this.WordOutPut = function (layerCell, layer) {
        WordModel(layerCell, layer);
    };
    //属性
    this.OutputLayerCell = function (layerCell, layer) {
        var mapcoord = LayerControl.map.getPixelInMap({ lo: layerCell.Longitude, la: layerCell.Latitude });
        layerCell.x = mapcoord.x;
        layerCell.y = mapcoord.y;
        var isareadyin = false;
        ////庞小斌修改，去除.each方法，直接获取当前警员节点
        var policeitem = document.getElementById(layerCell.LayerID + "|" + layerCell.ID + '_vFigure');
        if (policeitem) {
           
             
            policeitem.style.backgroundImage = "url(" + layerCell.url + ")";
            policeitem.style.backgroundRepeat = "no-repeat";
            //庞小斌修改，判断警员位置是否改变
            var policeitem_left = policeitem.style.left;
            var policeitem_left_length = policeitem_left.length;
            var policeitem_left_num = policeitem_left.substr(0, policeitem_left_length - 2);
            var policeitem_top = policeitem.style.top;
            var policeitem_top_length = policeitem_top.length;
            var policeitem_top_num = policeitem_top.substr(0, policeitem_top_length - 2);
            var curr_maxLevel = LayerControl.map.data.currentLevel / LayerControl.map.data.maxLevel;
            if (Math.abs(layerCell.x + layerCell.offset_x * curr_maxLevel - policeitem_left_num) > 1 || Math.abs(layerCell.y + layerCell.offset_y * curr_maxLevel - policeitem_top_num) > 1 || policeitem.style.backgroundImage.indexOf(layerCell.url) < 0)
            {
                var police_left = layerCell.x + layerCell.offset_x * curr_maxLevel;
                var police_top = layerCell.y + layerCell.offset_y * curr_maxLevel;

                policeitem.style.left = police_left;
                policeitem.style.top = police_top;
                //$(policeitem).animate({ left: police_left, top: police_top}, 300, function () {

                //});
                //移动警员备注节点
                var policebztpitem = document.getElementById("bztp_" + layerCell.ID);
                if (policebztpitem) {
                    //var mp = _StaticObj.objGet("map");
                    var left = mapcoord.x + curr_maxLevel * 25 - 2;
                    var top = mapcoord.y - curr_maxLevel * 90

                    policebztpitem.style.left = left;
                    policebztpitem.style.top = top;
                    //$(policebztpitem).animate({ left: left, top: top }, 300, function () {

                    //});
                }
            }
            isareadyin = true;
            return false;
        }
        policeitem = null;

        if (isareadyin) {
            return;
        }

          //根据每个警员的tag值 判断是否创建div 并添加到图层上
        
            var img = document.createElement('div');
            //庞小斌修改，创建节点后立刻append
            if (!isareadyin) {
                layer.appendChild(img);
            }
            img.id = layerCell.LayerID + "|" + layerCell.ID + '_vFigure';
            var AdjustPercent = 1;
            if (layerCell.isReSizeToLevel) {//根据级别调整图片大小
                AdjustPercent = LayerControl.map.data.currentLevel / LayerControl.map.data.maxLevel;
                img.style.width = layerCell.width * AdjustPercent;
                img.style.height = layerCell.height * AdjustPercent;
            }
            var offset_x = 0;
            var offset_y = 0;
            if (layerCell.offset_x) { offset_x = layerCell.offset_x * AdjustPercent; }
            if (layerCell.offset_y) { offset_y = layerCell.offset_y * AdjustPercent; }
            img.style.left = layerCell.x + offset_x;
            img.ISSI = layerCell.ISSI; //林强修改
            img.style.top = layerCell.y + offset_y;
            img.style.position = "absolute";
            if (useprameters.movecellID == layerCell.ID) {
                img.style.zIndex = 1;
            }
            img.ci = layerCell.ID;
            img.style.backgroundImage = "url(" + layerCell.url + ")";
            img.style.backgroundRepeat = "no-repeat";
            img.layerID = layerCell.LayerID;
            img.title = layerCell.Info;
            img.onmouseover = function () {
                cellzindexmax(this);
            }
            this.execEventListener("OutputLayerCell", img);
            mapcoord = null;
            img = null;
        
    };
}

function delcelloutputcell(layerCell, layer) {
    var mapcoord = LayerControl.map.getPixelInMap({ lo: layerCell.Longitude, la: layerCell.Latitude });
    layerCell.x = mapcoord.x;
    layerCell.y = mapcoord.y;
    var img = document.createElement('div');
    img.id = layerCell.LayerID + "|" + layerCell.ID + '_vFigure';
    var AdjustPercent = 1;

    if (layerCell.isReSizeToLevel) {//根据级别调整图片大小
        AdjustPercent = LayerControl.map.data.currentLevel / LayerControl.map.data.maxLevel;
        img.style.width = layerCell.width * AdjustPercent;
        img.style.height = layerCell.height * AdjustPercent;
    }
    var offset_x = 0;
    var offset_y = 0;
    if (layerCell.offset_x) { offset_x = layerCell.offset_x * AdjustPercent; }
    if (layerCell.offset_y) { offset_y = layerCell.offset_y * AdjustPercent; }
    img.style.left = layerCell.x + offset_x;
    img.ISSI = layerCell.ISSI; //林强修改
    img.style.top = layerCell.y + offset_y;
    img.style.position = "absolute";
    if (useprameters.movecellID == layerCell.ID) {
        img.style.zIndex = 1;
    }
    img.ci = layerCell.ID;
    img.style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(src='" + layerCell.url + "', sizingMethod='scale')";
    img.layerID = layerCell.LayerID;
    img.title = layerCell.Info;
    img.onmouseover = function () {
        cellzindexmax(this);
    }

        layer.appendChild(img);

    this.execEventListener("OutputLayerCell", img);
    mapcoord = null;
    img = null;
    layer = null;
}


/**memery leak**/
function cellzindexmax(obj, id) {
    var maxdiv = document.getElementById("Police,0,0|" + useprameters.movecellID + "_vFigure");
    if (maxdiv) {
        maxdiv.style.zIndex = 0;
    }
    obj.style.zIndex = 1;
    useprameters.movecellID = obj.ci;
}
ImageModel.prototype.InfoShow = function (layerCell, layer, acticon) {
    if (isinarray(layerCell.ISSI, useprameters.HidedisplayISSI) || !useprameters.displayinfo)
       return;
    var word = document.getElementById(layerCell.LayerID + "|" + layerCell.ID + '_ID');
    if (word) {
        var AdjustPercent = 1;
        if (layerCell.isReSizeToLevel && LayerControl.map.data.currentLevel != LayerControl.map.data.maxLevel) {//根据级别调整图片大小
            AdjustPercent = LayerControl.map.data.currentLevel / LayerControl.map.data.maxLevel;
        }
        var offset_x = 0;
        var offset_y = 0;
        var mapcoord = LayerControl.map.getPixelInMap({ lo: layerCell.Longitude, la: layerCell.Latitude });
        layerCell.x = mapcoord.x;
        layerCell.y = mapcoord.y;
        if (layerCell.offset_x) { offset_x = layerCell.offset_x * AdjustPercent }
        if (layerCell.offset_y) { offset_y = layerCell.offset_y * AdjustPercent }
        word.style.left = layerCell.x + offset_x - strlen(layerCell['Info']) * vml_word_fontSize / 4 + 20;
        word.style.top = layerCell.y + offset_y - vml_word_fontSize - 15;
        if (acticon == 'click') {
            word.style.filter = '';
            return;
        }
        else {
            word.style.filter = vml_word_filter;
            return;
        }

    }
    if (typeof (layer) == "object")
    { }
    else if (typeof (layer) == "string") {
        layer = childGetById(layer);
    }
    if (layerCell['Info']) {
        var mapcoord = LayerControl.map.getPixelInMap({ lo: layerCell.Longitude, la: layerCell.Latitude });
        layerCell.x = mapcoord.x;
        layerCell.y = mapcoord.y;
        var x = layerCell.x;
        var y = layerCell.y;
        var r = layerCell.r;
        word = document.createElement('div');
        word.id = layerCell.LayerID + "|" + layerCell.ID + '_ID';
        if (acticon == 'click') {
            word.Name = "clickINFO";
        }
        var AdjustPercent = 1;
        if (layerCell.isReSizeToLevel && LayerControl.map.data.currentLevel != LayerControl.map.data.maxLevel) {//根据级别调整图片大小
            AdjustPercent = LayerControl.map.data.currentLevel / LayerControl.map.data.maxLevel;
        }
        var offset_x = 0;
        var offset_y = 0;
        if (layerCell.offset_x) { offset_x = layerCell.offset_x * AdjustPercent }
        if (layerCell.offset_y) { offset_y = layerCell.offset_y * AdjustPercent }
        word.style.left = layerCell.x + offset_x - strlen(layerCell['Info']) * vml_word_fontSize / 4 + 20;
        word.style.top = layerCell.y + offset_y - vml_word_fontSize - 15;
        word.style.position = "absolute";
        word.style.color = vml_word_color;
        word.style.fontSize = vml_word_fontSize;
        word.style.backgroundColor = "#FFFFFF";
        word.style.width = "120px";
        word.style.height = "22px";
        word.style.verticalAlign = "middle";
        word.style.lineHeight = "22px";
        word.style.border = "1px solid black";
        word.style.wordBreak = "keep-all";
        word.style.fontWeight = 'normal';
        word.style.textAlign = "center";
        word.style.zIndex = 3;
        if (acticon != 'click') {
            word.style.filter = vml_word_filter;
            word.onmouseover = function () {
                this.style.filter = "";
            }
            word.onmouseout = function () {
                this.style.filter = vml_word_filter;
            }
        }
        word.innerHTML = layerCell['Info'].concat("");
        if (!layer) {
            var map = document.getElementById("map");
            layer = document.createElement("div");
            layer.id = "clickInfoDIV";
            map.appendChild(layer);
        }
        if (layer) {
            layer.appendChild(word);

        }

    }
};

//扇形输出类
//layer要添加到的图层div
//fillcolor 填充颜色,strokecolor 边线颜色,opa 填充透明度,r 半径,zj 张开角度,qj 方向角度
function SectorModel() {
    this.OutputLayerCell = function (layerCell, layer) {
        var coord = new Coordinate(layerCell.Longitude, layerCell.Latitude);
        var mapcoord = coord.getMapCoord(coord);
        layerCell.x = mapcoord.x;
        layerCell.y = mapcoord.y;

        var qj = -layerCell.qj + 90;
        var zj = layerCell.zj;
        qj = qj - zj / 2;
        var x = layerCell.x;
        var y = layerCell.y;
        if (!layerCell.IsZoom) {//是否跟随图层缩放变化半径
            r = layerCell.r;
        }
        if (Math.abs(qj) > 360) {
            var absqj = Math.abs(qj);
            var tq = Math.floor(absqj / 360);
            var temp = absqj - 360 * tq;
            if (qj < 0) {
                qj = -temp;
            } else {
                qj = temp;
            }
        }
        if (Math.abs(layerCell.qj) == 360)//draw circle
        {
            var v_oval = document.createElement('v:oval');
            v_oval.ci = layerCell.ID;
            v_oval.id = layerCell.LayerID + "|" + layerCell.ID + '_vFigure';
            v_oval.style.position = "absolute";
            v_oval.style.width = r / 2;
            v_oval.style.height = r / 2;
            v_oval.style.left = layerCell.x - r / 4;
            v_oval.style.top = layerCell.y - r / 4;
            v_oval.fillcolor = layerCell.fillcolor;
            v_oval.strokecolor = layerCell.strokecolor;
            v_oval.layerID = layerCell.LayerID;
            addVMLEvent(v_oval);
            var v_fill = document.createElement('v:fill');
            v_fill.opacity = layerCell.opacity;
            v_oval.appendChild(v_fill);

            layer.appendChild(v_oval);
            return;
        }
        var ltype = layerCell.line;
        var arg = 1 << 16;
        var x0 = r;
        var y0 = r;
        var p4 = arg * qj + "," + arg * zj;

        var v_shape = document.createElement('v:shape');
        v_shape.ci = layerCell.ID;
        v_shape.layerID = layerCell.LayerID;
        v_shape.id = layerCell.LayerID + "|" + layerCell.ID + '_vFigure';
        v_shape.style.position = 'absolute';
        v_shape.style.left = x - r;
        v_shape.style.top = y - r;
        v_shape.style.width = 2 * r;
        v_shape.style.height = 2 * r;
        v_shape.path = "m" + x0 + ',' + y0 + " ae" + x0 + "," + y0 + "," + r + "," + r + "," + p4 + " xe"; //center (x,y) size(w,h) start-angle, end-angle(就是角度大小). Draw a segment of an ellipse as describes using these parameters. A straight line is drawn from the current point to the start point of the segment.
        v_shape.coordsize = 2 * r + ',' + 2 * r;
        v_shape.fillcolor = layerCell.fillcolor; //layerCell.fcolor
        v_shape.stroked = "t";
        v_shape.strokecolor = layerCell.strokecolor; //边线颜色
        addVMLEvent(v_shape);
        var v_fill = document.createElement('v:fill');
        v_fill.opacity = layerCell.opacity; //颜色透明度，undefine 则不能显示颜色
        v_shape.appendChild(v_fill);

        layer.appendChild(v_shape);
    };
}
SectorModel.prototype.CIShow = function (layerCell, layer) {
    if (typeof (layer) == "object")
    { }
    else if (typeof (layer) == "string") {
        layer = childGetById(layer);
    }
    if (layerCell['ID']) {
        var coord = new Coordinate(layerCell.Longitude, layerCell.Latitude);
        var mapcoord = coord.getMapCoord(coord);
        layerCell.x = mapcoord.x;
        layerCell.y = mapcoord.y;
        var x = layerCell.x;
        var y = layerCell.y;
        var r = layerCell.r;
        var lx;
        var ly;
        if (Math.abs(layerCell.qj) == 360)//draw circle
        {
            lx = x;
            ly = y;
        }
        else {
            lx = x + Math.round(r * Math.sin(ConvertRad(layerCell.qj))) / 0.8 - layerCell.ID.length * 2;
            ly = y - Math.round(r * Math.cos(ConvertRad(layerCell.qj))) / 0.8 - layerCell.ID.length * 2;
        }
        var word = document.createElement('div');
        word.id = layerCell.LayerID + "|" + layerCell.ID + '_ID';
        word.style.left = lx;
        word.style.top = ly;
        word.style.position = "absolute";
        word.style.color = vml_word_color;
        word.style.fontSize = vml_word_fontSize;
        word.style.filter = vml_word_filter_CI;
        word.style.fontFamily = vml_font_family;
        word.style.fontWeight = 'normal';
        word.innerHTML = layerCell['ID'];
        layer.appendChild(word);
    }
};
SectorModel.prototype.SiteNameShow = function (layerCell, layer) {
    if (typeof (layer) == "object")
    { }
    else if (typeof (layer) == "string") {
        layer = childGetById(layer);
    }
    WordModel(layerCell, layer, 'site_name');
};
function ConvertRad(qj) {
    return qj / 180 * Math.PI;
}

function LineModel() {
    this.OutputLayerCell = function (layerCell, layer) {
        var coord = new Coordinate(layerCell.Longitude, layerCell.Latitude);
        var mapcoord = coord.getMapCoord(coord);
        layerCell.x = mapcoord.x;
        layerCell.y = mapcoord.y;

        var qj = -layerCell.qj + 90;
        var zj = layerCell.zj;
        qj = qj - zj / 2;
        var x = layerCell.x;
        var y = layerCell.y;
        if (!layerCell.IsZoom) {//是否跟随图层缩放变化半径
            r = layerCell.r;
        }
        if (Math.abs(qj) > 360) {
            var absqj = Math.abs(qj);
            var tq = Math.floor(absqj / 360);
            var temp = absqj - 360 * tq;
            if (qj < 0) {
                qj = -temp;
            } else {
                qj = temp;
            }
        }
        if (Math.abs(layerCell.qj) == 360)//draw circle
        {
            var v_oval = document.createElement('v:oval');
            v_oval.ci = layerCell.ID;
            v_oval.layerID = layerCell.LayerID;
            v_oval.id = layerCell.LayerID + "|" + layerCell.ID + '_vFigure';
            v_oval.style.position = "absolute";
            v_oval.style.width = r;
            v_oval.style.height = r;
            v_oval.style.left = layerCell.x - r;
            v_oval.style.top = layerCell.y - r;
            v_oval.fillcolor = layerCell.fillcolor;
            v_oval.strokecolor = layerCell.strokecolor;
            addVMLEvent(v_oval);
            var v_fill = document.createElement('v:fill');
            v_fill.opacity = layerCell.opacity;
            v_oval.appendChild(v_fill);

            layer.appendChild(v_oval);
            return;
        }
        var ltype = layerCell.line;
        var arg = 1 << 16;
        var x0 = r;
        var y0 = r;
        var p4 = arg * (qj + qj + zj) / 2 + "," + arg * 0;
        var v_shape = document.createElement('v:shape');
        v_shape.id = layerCell.LayerID + "|" + layerCell.ID + '_vFigure';
        v_shape.ci = layerCell.ID;
        v_shape.layerID = layerCell.LayerID;
        v_shape.style.position = 'absolute';
        v_shape.style.left = x - r;
        v_shape.style.top = y - r;
        v_shape.style.width = 2 * r;
        v_shape.style.height = 2 * r;
        v_shape.path = "m" + x0 + ',' + y0 + " ae" + x0 + "," + y0 + "," + r + "," + r + "," + p4 + " xe";
        v_shape.coordsize = 2 * r + ',' + 2 * r;
        v_shape.fillcolor = layerCell.fillcolor;
        v_shape.stroked = "t";
        v_shape.strokecolor = layerCell.strokecolor; //边线颜色
        addVMLEvent(v_shape);
        var v_fill = document.createElement('v:fill');
        v_fill.opacity = layerCell.opacity; //颜色透明度，undefine 则不能显示颜色
        v_shape.appendChild(v_fill);

        layer.appendChild(v_shape);
    };
}
LineModel.prototype.CIShow = function (layerCell, layer) { SectorModel.prototype.CIShow(layerCell, layer); }
LineModel.prototype.SiteNameShow = function (layerCell, layer) { SectorModel.prototype.SiteNameShow(layerCell, layer); }

//多边形输出类
function RegionModel() {
    this.OutputLayerCell = function (layerCell, layer) {
        layerCell.coords = layerCell.qj;
        var temp = new Array();
        ss = layerCell.coords.split(",");
        for (var i = 0; i < ss.length; i = i + 2) {
            var coord = new Coordinate(ss[i], ss[i + 1]);
            var mapcoord = coord.getMapCoord();
            temp.push(mapcoord.x);
            temp.push(mapcoord.y);
        }
        layerCell.points = temp;
        if (!layerCell.line)
            layerCell.line = 1;

        var ltype = layerCell.line;
        var pits = layerCell.points;
        var x = 0;
        var y = 0;
        var o = pits.length / 2;
        for (i = 0; i < pits.length; i = i + 2) {
            x = x + parseInt(pits[i]);
        }
        for (i = 1; i < pits.length; i = i + 2) {
            y = y + parseInt(pits[i]);
        }
        x = x / o;
        y = y / o - 6;
        var temp = pits + "," + pits[0] + "," + pits[1];

        var v_polyline = document.createElement('v:polyline');
        v_polyline.id = layerCell.LayerID + "|" + layerCell.ID + '_vFigure';
        v_polyline.layerID = layerCell.LayerID;
        v_polyline.style.position = 'absolute';
        v_polyline.fillcolor = layerCell.fillcolor;
        v_polyline.stroked = "t";
        v_polyline.filled = "t";
        v_polyline.points = temp;
        v_polyline.strokecolor = layerCell.strokecolor;

        var v_fill = document.createElement('v:fill');
        v_fill.opacity = layerCell.opacity;
        v_polyline.appendChild(v_fill);

        if (ltype.line == 0) {
            var v_stroke = document.createElement('v:stroke');
            v_stroke.opacity = "1";
            v_stroke.dashstyle = "longDashDotDot";
            v_polyline.appendChild(v_stroke);
        }
        else {
            var v_stroke = document.createElement('v:stroke');
            v_stroke.opacity = "1";
            v_stroke.dashstyle = "solid";
            v_polyline.appendChild(v_stroke);
        }
        layer.appendChild(v_polyline);
    };
}