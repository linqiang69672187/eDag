﻿//在地图上画矩形、椭圆、多边形 同时只能开启一种选择
function Draw(map) {
    BaseListener.apply(this);
    this.data = {
        map: map,
        drawType: null, //
        drawTypeName: { rectangle: "rectangle", oval: "oval", polygon: "polygon" },
        vectorLanguageCls: new VML(), //矢量画图类 默认为VML
        drawObj: null //画好的HTML DOM {ths:obj,data:value}
    }
    this.turnOnDraw = function (drawTypeName) {
        document.Draw = this;
        this.data.drawType = drawTypeName;
        this.addEventListenerToDocument("mousedown", this.beginDrawWithMouse);
        with (this) {
            //关闭地图拖动
            if (data.drawType != data.drawTypeName.polygon) {//stop map move if is not polygon
                data.map.data.objMoving.turnOffMove(); //在mapDiv的mousedown之后，这样可以避免IE中在mousedown中取消的问题
            }
        }
    }
    this.turnOffDraw = function (_drawTypeName) {
        with (this.data) {
            //开启地图移动
            if (drawType != drawTypeName.polygon) {
                map.data.objMoving.turnOnMove();
            }
            document.Draw = null;
            drawType = null;
            this.removeEventListenerToDocument("mousedown", this.beginDrawWithMouse);
            switch (_drawTypeName) {
                case drawTypeName.rectangle:
                    this.removeEventListenerToDocument("mousemove", this.drawRectangleFollowMouse);
                    this.removeEventListenerToDocument("mouseup", this.getRectRange);
                    break;
                case drawTypeName.oval:
                    this.removeEventListenerToDocument("mousemove", this.drawOvalFollowMouse);
                    this.removeEventListenerToDocument("mouseup", this.getOvalRange);
                    break;
                case drawTypeName.polygon:
                    this.removeEventListenerToDocument("mousemove", this.drawPolygonFollowMouse);
                    this.removeEventListenerToDocument("mouseup", this.getPolygonOvalRange);
                    break;
            }
        }
    }
    this.addEventListenerToDocument = function (addToEvent, fun) {
        if (document.attachEvent) {
            document.attachEvent("on" + addToEvent, fun);
        }
        if (document.addEventListener) {
            document.addEventListener(addToEvent, fun, false);
        }
    }
    this.removeEventListenerToDocument = function (removeToEvent, fun) {
        if (document.detachEvent) {
            document.detachEvent("on" + removeToEvent, fun);
        }
        if (document.removeEventListener) {
            document.removeEventListener(removeToEvent, fun, false);
        }
    }
    this.beginDrawWithMouse = function (ev) { //开启跟随鼠标位置画
        ev = ev || window.event;
        if (document.Draw) {//林强
            with (document.Draw) {
                var initPosition = data.map.getPointByEvent.call(data.map, ev);
                if (!data.drawObj) {
                    data.drawObj = { data: { initPosition: initPosition }, ths: null }; //set init position
                }
                else {//已经存在就重画初始位置
                    data.drawObj.data.initPosition = initPosition;
                }
                switch (data.drawType) {
                    case data.drawTypeName.rectangle:
                        addEventListenerToDocument("mousemove", drawRectangleFollowMouse);
                        addEventListenerToDocument("mouseup", getRectRange);
                        break;
                    case data.drawTypeName.oval:
                        addEventListenerToDocument("mousemove", drawOvalFollowMouse);
                        addEventListenerToDocument("mouseup", getOvalRange);
                        break;
                    case data.drawTypeName.polygon:
                        addEventListenerToDocument("mousemove", drawPolygonFollowMouse);
                        addEventListenerToDocument("mouseup", 计算多边形范围);
                        break;
                }
            }
        }
    }
    this.drawRectangleFollowMouse = function (ev) {//跟随鼠标位置画
        ev = ev || window.event;
        if (document.Draw) {//林强
            with (document.Draw.data) {
                if (!drawObj) return;
                var positionCurrent = map.getPointByEvent.call(map, ev);
                var width = Math.abs(positionCurrent.x - drawObj.data.initPosition.x);
                var height = Math.abs(positionCurrent.y - drawObj.data.initPosition.y);
                //左上角位置
                var leftTopPosition = { x: positionCurrent.x > drawObj.data.initPosition.x ? drawObj.data.initPosition.x : positionCurrent.x, y: positionCurrent.y > drawObj.data.initPosition.y ? drawObj.data.initPosition.y : positionCurrent.y };
                var rectData = { opacity: 0.5, strokecolor: "red", left: leftTopPosition.x, top: leftTopPosition.y, width: width, height: height };
                drawObj.data.rectData = rectData;
                if (!drawObj.ths) {//ths 空的时候，表示还未画，就添加一个矩形到地图
                    drawObj.ths = vectorLanguageCls.createRectangle(rectData);
                    map.data.addObjToMap.add(drawObj.ths);
                }
                else {
                    vectorLanguageCls.createRectangle(rectData, drawObj.ths);
                }
            }
        }
    }
    this.getRectRange = function () { //返回矩形范围
        if (document.Draw != null) {
            with (document.Draw) {
                var range = false;
                if (!data.drawObj) return range;
                if (data.drawObj.data.rectData) {
                    var rect = data.drawObj.data.rectData;
                    var leftTopPoint = { x: rect.left, y: rect.top };
                    var rightBottomPoint = { x: rect.left + rect.width, y: rect.top + rect.height };
                    var leftTopLatLng = data.map.getLatLngByPoint(leftTopPoint);
                    var rightBottomLatLng = data.map.getLatLngByPoint(rightBottomPoint);
                    range = {
                        pixel: { minX: leftTopPoint.x, minY: leftTopPoint.y, maxX: rightBottomPoint.x, maxY: rightBottomPoint.y },
                        latLng: { minLo: leftTopLatLng.lo, maxLa: leftTopLatLng.la, maxLo: rightBottomLatLng.lo, minLa: rightBottomLatLng.la }
                    };
                    execEventListener("getRectRange", range);
                }
                removeEventListenerToDocument("mousemove", drawRectangleFollowMouse);
                removeEventListenerToDocument("mouseup", getRectRange);
                //删除框图
                if (data.drawObj.ths)
                  //  data.drawObj.ths.parentNode.removeChild(data.drawObj.ths);//林强修改
                data.drawObj = null;
                return range;
            }
        }
    }
    this.drawOvalFollowMouse = function (ev) {//跟随鼠标位置画
        ev = ev || window.event;
        if (document.Draw) {//林强
            with (document.Draw.data) {
                if (!drawObj) return;
                var positionCurrent = map.getPointByEvent.call(map, ev);
                var width = Math.abs(positionCurrent.x - drawObj.data.initPosition.x);
                var height = Math.abs(positionCurrent.y - drawObj.data.initPosition.y);
                //左上角位置
                var leftTopPosition = { x: positionCurrent.x > drawObj.data.initPosition.x ? drawObj.data.initPosition.x : positionCurrent.x, y: positionCurrent.y > drawObj.data.initPosition.y ? drawObj.data.initPosition.y : positionCurrent.y };
                var ovalData = { opacity: 0.5, strokecolor: "red", left: leftTopPosition.x, top: leftTopPosition.y, width: width, height: height };
                drawObj.data.ovalData = ovalData;
                if (!drawObj.ths) {//ths 空的时候，表示还未画，就添加一个矩形到地图
                    drawObj.ths = vectorLanguageCls.createOval(ovalData);
                    map.data.addObjToMap.add(drawObj.ths);
                }
                else {
                    vectorLanguageCls.createOval(ovalData, drawObj.ths);
                }
            }
        }
    }
    this.getOvalRange = function () { //返回椭圆范围
        with (document.Draw) {
            var range = false;
            if (!data.drawObj) return range;
            if (data.drawObj.data.ovalData) {
                var oval = data.drawObj.data.ovalData;
                var centerPixel = { x: oval.left + oval.width / 2, y: oval.top + oval.height / 2 };
                var centerLatLng = data.map.getLatLngByPoint(centerPixel);
                range = {
                    center: { pixel: centerPixel, latLng: centerLatLng },
                    a: oval.width / 2, //x轴半轴长
                    b: oval.height / 2 //y轴半轴长
                };
                execEventListener("getOvalRange", range);
            }
            removeEventListenerToDocument("mousemove", drawOvalFollowMouse);
            removeEventListenerToDocument("mouseup", getOvalRange);
            //删除圈图
            if (data.drawObj.ths)
                data.drawObj.ths.parentNode.removeChild(data.drawObj.ths);
            data.drawObj = null;
            return range;
        }
    }
    this.isInPolygon = function (pixel) { //判断点是否在多边形内

    }
}