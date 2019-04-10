//选择功能，包括单击单选、ctrl多选、框选多选、椭圆多选、不规则多选
function Choose(map, layerManager) {
    BaseListener.apply(this);
    this.data = {
        map: map,
        layerManager: layerManager,
        chooseTypeFlag: {
            single: false, //单选
            ctrl_multiterm: false, //ctrl多选
            rectangle_multiterm: false, //框选多选
            oval_multiterm: false, //椭圆多选
            polygon_multiterm: false//不规则多选
        },
        chooseType: {
            single: "single", //单选
            ctrl_multiterm: "ctrl", //ctrl多选
            rectangle_multiterm: "rectangle", //框选多选
            oval_multiterm: "oval", //椭圆多选
            polygon_multiterm: "polygon"//不规则多选
        },
        chooseObjs: {}, //objID: obj 被选中的对象ID键列表
        draw: new Draw(map)
    }
    //开启指定选择类别，同时关闭其它
    //chooseType--this.chooseType.single
    this.turnOn = function (_chooseType) {
        with (this.data) {
            chooseTypeFlag[_chooseType] = true;
            switch (_chooseType) {
                case chooseType.single: this.turnOnSingle();
                    break;
                case chooseType.ctrl_multiterm: this.turnOnCtrl_multiterm();
                    break;
                case chooseType.rectangle_multiterm: this.turnOnRectangle_multiterm();
                    break;
                case chooseType.oval_multiterm: this.turnOnOval_multiterm();
                    break;
                case chooseType.polygon_multiterm: this.turnOnPolygon_multiterm();
                    break;
                default: break;
            }
        }
        this.execEventListener("turnOn", _chooseType);
    }
    this.turnOff = function (_chooseType) {
        with (this.data) {
            chooseTypeFlag[_chooseType] = false;
            switch (_chooseType) {
                case chooseType.single: this.turnOffSingle();
                    break;
                case chooseType.ctrl_multiterm: this.turnCtrl_multiterm();
                    break;
                case chooseType.rectangle_multiterm: this.turnOffRectangle_multiterm();
                    break;
                case chooseType.oval_multiterm: this.turnOffOval_multiterm();
                    break;
                case chooseType.polygon_multiterm: this.turnOffPolygon_multiterm();
                    break;
                default: break;
            }
        }
        this.execEventListener("turnOff", _chooseType);
    }
    //暂时无用
    this.turnOffAll = function () {
        for (var chooseType_i in this.data.chooseType) {
            this.data.chooseTypeFlag[this.data.chooseType[chooseType_i]] = false;
        }
    }
    this.addData = function (ID, obj) {
        this.data.chooseObjs[ID] = obj;
    }
    this.delData = function (ID) {
        delete this.data.chooseObjs[ID];
    }
    this.delAllData = function () {
        this.data.chooseObjs = {};
    }
    this.turnOnSingle = function () { //开启单选事件
        this.data.layerManager.addEventListener("cell_onclick", this.cell_onclick, this);
        this.data.layerManager.addEventListener("cell_oncontextmenu", this.cell_oncontextmenu, this);
    }
    this.turnOffSingle = function () {
        this.data.layerManager.removeEventListener("cell_onclick", this.cell_onclick);
        this.data.layerManager.removeEventListener("cell_oncontextmenu", this.cell_oncontextmenu);
    }
    this.cell_onclick = function (ths, ci, layerID, obj) {//图元单击处理函数
        with (ths.data) {
            if (!chooseTypeFlag[chooseType.single]) return; //图元单击事件未启用
            ths.execEventListener("cell_onclick", ci, layerID, obj);
        }
    }

    this.cell_oncontextmenu = function (ths, ci, layerID, obj) {//图元单击处理函数
        with (ths.data) {
            if (!chooseTypeFlag[chooseType.single]) return; //图元单击事件未启用
            ths.execEventListener("cell_oncontextmenu", ci, layerID, obj);
        }
    }



    this.turnOnRectangle_multiterm = function () { //开启框选事件
        this.data.draw.turnOnDraw(this.data.draw.data.drawTypeName.rectangle);
        this.data.draw.addEventListener("getRectRange", this.rectangleEnd, this);
    }
    this.turnOffRectangle_multiterm = function () {
        this.data.draw.turnOffDraw(this.data.draw.data.drawTypeName.rectangle);
        this.data.draw.removeEventListener("getRectRange", this.rectangleEnd);
    }
    this.rectangleEnd = function (ths, range) {
        //可在这里添加默认图层事件ths.data.layerManager
        //返回被选中的图元ID 循环遍历所有图元
        var selected = new Array();
        with (ths.data.layerManager) {
            for (var layerID in Data) {
                for (var cells = 0; cells < Data[layerID].length; cells++) {
                    for (var cellID in Data[layerID][cells]) {
                        var la = Data[layerID][cells][cellID].Latitude;
                        var lo = Data[layerID][cells][cellID].Longitude;
                        if (la && lo && la > range.latLng.minLa && la < range.latLng.maxLa && lo > range.latLng.minLo && lo < range.latLng.maxLo) {
                            selected.push(Data[layerID][cells][cellID]);
                        }
                    }
                }
            }
        }
        ths.execEventListener("rectangleEnd", selected, range);
    }
    this.turnOnOval_multiterm = function () { //开启圈选事件
        this.data.draw.turnOnDraw(this.data.draw.data.drawTypeName.oval);
        this.data.draw.addEventListener("getOvalRange", this.ovalEnd, this);
    }
    this.turnOffOval_multiterm = function () {
        this.data.draw.turnOffDraw(this.data.draw.data.drawTypeName.oval);
        this.data.draw.removeEventListener("getOvalRange", this.ovalEnd);
    }
    this.ovalEnd = function (ths, range) {
        //可在这里添加默认图层事件ths.data.layerManager
        //返回被选中的图元ID 循环遍历所有图元
        var selected = new Array();
        with (ths.data.layerManager) {
            for (var layerID in Data) {
                for (var cells = 0; cells < Data[layerID].length; cells++) {
                    for (var cellID in Data[layerID][cells]) {
                        var la = Data[layerID][cells][cellID].Latitude;
                        var lo = Data[layerID][cells][cellID].Longitude;
                        //判断是否在椭圆范围内
                        var point = ths.data.map.getPixelInMap({ lo: lo, la: la });
                        if (Math.pow(point.x - range.center.pixel.x, 2) / Math.pow(range.a, 2) + Math.pow(point.y - range.center.pixel.y, 2) / Math.pow(range.b, 2) <= 1) {//isInOval
                            selected.push(Data[layerID][cells][cellID]);
                        }
                    }
                }
            }
        }
        ths.execEventListener("ovalEnd", selected, range);
    }
    this.turnOnPolygon_multiterm = function () { //开启圈选事件
        this.data.draw.turnOnDraw(this.data.draw.data.drawTypeName.polygon);
        this.data.draw.addEventListener("getPolygonRange", this.polygonEnd, this);
    }
    this.turnOffPolygon_multiterm = function () {
        this.data.draw.turnOffDraw(this.data.draw.data.drawTypeName.polygon);
        this.data.draw.removeEventListener("getPolygonRange", this.polygonEnd);
    }
    this.polygonEnd = function (ths, range) {
        //可在这里添加默认图层事件ths.data.layerManager
        //返回被选中的图元ID 循环遍历所有图元
        var selected = new Array();
        with (ths.data.layerManager) {
            for (var layerID in Data) {
                for (var cells = 0; cells < Data[layerID].length; cells++) {
                    for (var cellID in Data[layerID][cells]) {
                        var la = Data[layerID][cells][cellID].Latitude;
                        var lo = Data[layerID][cells][cellID].Longitude;
                        //判断是否在多边形范围内
                    }
                }
            }
        }
        ths.execEventListener("polygonEnd", selected, range);
    }
}