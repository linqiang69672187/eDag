//鹰眼类
//map--主地图类
function Hawkeye(map) {
    BaseListener.apply(this);
    this.data = {
        "id": null,
        "hawkeyeMap": null, //鹰眼对象div
        "width": 150, //鹰眼所见视野大小 unit--px
        "height": 120,
        "level": 12, //固定缩放级别
        "map": map,
        //private
        "hawkeyeMapContainer": null
    }
    //默认外貌，可扩展接口this.feature()，通过Hawkeye.prototype.feature的方式
    this.featureDefalut = function () {
        var divFeature = document.createElement("div");
        divFeature.style.position = "absolute";
        divFeature.id = "mydivFeature";
        divFeature.style.right = "0px";
        divFeature.style.bottom = "0px";
        divFeature.style.zIndex = 22;
        divFeature.style.borderWidth = "0px";
        divFeature.style.backgroundColor = "white";
        divFeature.style.width = this.data.width + "px";
        divFeature.style.height = this.data.height + "px";
        return divFeature;
    }
    //定义包含鹰眼的外貌
    this.create = function () {//创建鹰眼DIV
        var divContainer = document.createElement("div");
        divContainer.style.position = "absolute";
        divContainer.style.backgroundColor = "white";
        divContainer.style.overflow = "hidden";
        divContainer.style.zIndex = 3;
        divContainer.style.width = this.data.width + "px";
        divContainer.style.height = this.data.height + "px";

        //用来拖动的div
        var divHawkeyeMap = document.createElement("div");
        divHawkeyeMap.id = this.data.id != null ? this.data.id : "hawkeye";
        divHawkeyeMap.style.width = this.data.width + "px";
        divHawkeyeMap.style.height = this.data.height + "px";
        divContainer.appendChild(divHawkeyeMap);
        var feature = this.feature == undefined ? this.featureDefalut() : this.feature();
        feature.appendChild(divContainer);
        this.data.id = divHawkeyeMap.id;
        this.data.hawkeyeMap = divHawkeyeMap;
        return feature;
    }
    this.addToMap = function () {//开启鹰眼
        //添加鹰眼原件到页面
        var divHawkeye = this.create();
        this.data.hawkeyeMapContainer = divHawkeye;
        document.body.appendChild(divHawkeye);
        _StaticObj.add(this, this.data.id);

        //声明鹰眼地图类
        var mapHawkeye = eval("new " + this.data.map.data.clsName + "()");
        mapHawkeye.data.mapDiv = this.data.hawkeyeMap;
        mapHawkeye.data.currentLevel = this.data.level != null ? this.data.level : map.data.currentLevel;
        mapHawkeye.data.currentCenter = map.data.currentCenter;
        mapHawkeye.data.backPicPath = map.data.backPicPath;
        mapHawkeye.data.maxLevel = map.data.maxLevel;
        mapHawkeye.data.minLevel = map.data.minLevel;
        mapHawkeye.data.deviation_lo = map.data.deviation_lo == undefined ? 0 : map.data.deviation_lo;
        mapHawkeye.data.deviation_la = map.data.deviation_la == undefined ? 0 : map.data.deviation_la;
        mapHawkeye.data.initCenter = map.data.initCenter;
        mapHawkeye.data.iBufferMove = false; //取消拖动后缓冲效果
        mapHawkeye.data.iDesignateMoveBuffer = false; //取消拖动后缓冲效果
        mapHawkeye.reSetByCurrentLevel();
        //往鹰眼中添加地图
        mapHawkeye.fillBackPicsToDivMap();

        //手动拖动：添加与主地图同步移动事件，此事件必须在主地图stopMove之后(需要重置地图中心点)注册,因为移动类中execEventListener的执行顺序是按照先添加先执行的原则
        //        map.data.objMoving.addEventListener("stopMove", mapHawkeyeMove, map, mapHawkeye); //在大地图拖动结束开始同步移动
        //指定移动：moveto
        //        map.addEventListener("moveTo", mapHawkeyeMove, map, mapHawkeye);
        map.addEventListener("fillBackPicsToDivMap", mapHawkeyeMove, map, mapHawkeye); //这个切片填充事件已经包含以上两个事件
        function mapHawkeyeMove(mapCls, mapHawkeye) { //鹰眼同步移动
            mapHawkeye.moveTo.call(mapHawkeye, mapCls.data.currentCenter);
        }

        //鹰眼拖动后同步主地图
        var objMoving = new ObjMoving();
        mapHawkeye.data.objMoving = objMoving;
        objMoving.data.captureObj = mapHawkeye.data.mapDiv; //用来选中的对象
        objMoving.data.moveObj = mapHawkeye.data.mapDiv; //指定对象拖动
        objMoving.data.otherParam = mapHawkeye; //将鹰眼对象传入
        objMoving.init();
        objMoving.addEventListener("startMove", this.startMove, this);
        objMoving.addEventListener("stopMove", mapHawkeyeStopMove, map, mapHawkeye);
        objMoving.addEventListener("stopMove", this.stopMove, this);
        function mapHawkeyeStopMove(mapCls, mapHawkeye) {
            //鹰眼中心点偏移与拖动偏移相反
            var mapHawkeyeLastPixel = mapHawkeye.getPixelInMap(mapHawkeye.data.currentCenter); //鹰眼上次中心点
            var mapHawkeyeMovedCurrentCenter = mapHawkeye.getLatLngByPoint({ x: mapHawkeyeLastPixel.x - mapHawkeye.data.objMoving.data.movedX, y: mapHawkeyeLastPixel.y - mapHawkeye.data.objMoving.data.movedY }); //鹰眼拖动后本次中心点
            //定位主地图与鹰眼
            mapCls.moveTo.call(mapCls, mapHawkeyeMovedCurrentCenter);
            mapHawkeye.moveTo.call(mapHawkeye, mapHawkeyeMovedCurrentCenter);
        }
    }
    this.startMove = function (ths) {
        ths = ths || this;
        ths.execEventListener("startMove");
    }
    this.stopMove = function (ths) {
        ths = ths || this;
        ths.execEventListener("stopMove");
    }
    this.removeToMap = function () {//删除鹰眼
        if (this.data.hawkeyeMapContainer)
            this.data.hawkeyeMapContainer.parentNode.removeChild(this.data.hawkeyeMapContainer);
    }
}