//地图核心类
//先拖动主地图再拖动鹰眼再拖动主地图时会有问题,因为拖动主地图会删除缓冲类别列表事件，而是中心点不一致(可以考虑在主地图拖动时检查缓冲列表，如果存在则取消拖动效果，不过这样可能会带来体验性下降的结果)；或者采用google map的方式，鹰眼与主地图时时同步（即主地图拖动停止缓冲时，鹰眼也停止）
function Map() {
    BaseListener.apply(this);
    this.data = {
        //public
        id: "map",
        mapDiv: null, //HTML div map container
        maxLevel: 10,
        minLevel: 1,
        currentLevel: null,
        currentCenter: null, //{"lo":value,"la":value}
        iBufferMove: true, //拖动后的缓冲效果
        iDesignateMoveBuffer: true, //指定位置移动时的缓冲效果 不能=false 或则同上全部=false
        scale: null, //比例尺 米/像素(meter/pixel)
        //private
        addObjToMap: new AddObjToMap(this),
        zIndex: 10, //z坐标位置
        backPicContainer: null, //背景图容器 大小跟mapDiv一样
        preloadImg: "./WebGis/images/preloadImg.png", //预加载图片
        objMoving: null, //地图移动类
        moveAcceleration: null, //拖动后缓冲类
        errorBackMapUrl: "./WebGis/images/preloadImg.png", //底图错误指向图片
        picsCurrentNum: null, //当前级别google横向图片数
        R: null, //当前级别地图半径,
        rate: null, //当前级别地图宽度,即当前级别地图直径 google地图 图片高宽度为 256px 第一级别为两张图片宽度
        initCenter: null, //缩放初始中心点 用来定位图片相对mapDiv左上角位置(解决拖动后加载图片时极小可能出现的中心点不同步问题)
        initLevel: null, //初始级别
        lastPics: null, //上次视野切片组
        currentPics: null, //当前视野切片组
        bufferMoveStopTime: 200, //拖动后缓冲时间 unit--ms
        bufferDesignateMoveStopTime: 100, //指定移动缓冲时间 unit--ms
        iSetSize: false, //是否设置过mapDiv尺寸
        wheelSpaceTime:1000, //滚轮事件时间间隔,即在一定时间范围内只让事件发生一次 unit--mm
        iAllowWheel: true, //是否产生滚轮后缩放效果
        leastBufferMoveSpeed: 200, //缓冲最低初始速度
        queue: new Queue(), //队列--用于连续拖动鹰眼时主地图位移会有误差，故放入队列中逐个执行        designateMoveBufferInQueueEventTypeName": "mainMapMoveAcceleration", //指定位置缓冲类在队列中的事件类编名称
        earthPerimeter: 35008548, //unit--meter 貌似不准确，配合测距、比例尺等所以调整下
        currentPixelBound: null, //当前视野范围（在大地图中，非in mapDiv）
        deviationPixel: { x: null, y: null }, //根据偏移经纬度计算当前切片偏移坐标
        mapid: null,
        movedistance: 0,
        isFirstload:true
    }
    //-----------------------------------public-----------------------------------
    this.switchDrag = function (iOpen) {//拖动开关
        if (iOpen) {
            this.data.objMoving.turnOnMove();
        }
        else {
            this.data.objMoving.turnOffMove();
        }
    }
    this.init = function () {
        _StaticObj.add(this, this.data.id);
        document.documentElement.style.backgroundImage = "url('" + this.data.preloadImg + "')"; //设置页面背景
        document.documentElement.style.overflow = "hidden"; //如遇到需要页面滚动条的情况再说
        this.data.mapDiv.zIndex = this.data.zIndex;
        this.data.mapDiv.style.left = "0px"; //必须设置，否者初始化时切片位置会有偏差
        this.data.mapDiv.style.top = "0px";
        this.data.initLevel = this.data.currentLevel;
        if (this.data.mapDiv.style.width || this.data.mapDiv.style.height) {//在外部已经被设置过
            this.data.iSetSize = true;
        }
        this.mapDivSizeSet();
         this.data.initCenter = this.data.currentCenter;
        //this.data.currentCenter = this.data.initCenter;
        this.reSetByCurrentLevel();
        this.fillBackPicsToDivMap();
        var objMoving = new ObjMoving();
        this.data.objMoving = objMoving;
        objMoving.data.captureObj = this.data.mapDiv; //用来选中的对象
        objMoving.data.moveObj = this.data.mapDiv; //指定对象拖动
        objMoving.data.otherParam = this; //将Map对象传入
        objMoving.data.iCutDisArray = true; //记录截断数据

        objMoving.addEventListener("stopMove", stopMove, objMoving.data.captureObj);
        objMoving.addEventListener("startMove", removeLastPic, this); //开始拖动时删除上次切片
        objMoving.addEventListener("startMove", this.rectifyCenter, this); //在拖动开始时停止缓冲移动并纠正中心点
        this.addEventListener("zoomToLevel_before", this.rectifyCenter, this); //在缩放前停止缓冲移动并纠正中心点
        function delEventTypeFromQueue(mapCls) {
            mapCls.data.queue.delEventType(mapCls.data.designateMoveBufferInQueueEventTypeName);
        }
        objMoving.addEventListener("startMove", delEventTypeFromQueue, this); //开始拖动时删除[队列]中指定位置缓冲类别
        this.addEventListener("zoomToLevel_before", delEventTypeFromQueue, this); //开始缩放时删除[队列]中指定位置缓冲类别
        objMoving.init();
        function removeLastPic(mapCls) {
            mapCls.removeLastPic();
        }
        function stopMove(mapDiv) {//拖动停止后处理，如果开启缓冲效果，就执行缓冲   
            //writeLog("call", "stopMove开始");
            mapDiv.ObjMoving.data.otherParam.data.movedistance = Math.sqrt(mapDiv.ObjMoving.data.movedX * mapDiv.ObjMoving.data.movedX + mapDiv.ObjMoving.data.movedY * mapDiv.ObjMoving.data.movedY);
            var bufferDis = { x: 0, y: 0 }; //expect buffer distance 
            if (mapDiv.ObjMoving.data.otherParam.data.iBufferMove) {
                var moveAcceleration = new MoveAcceleration();
                mapDiv.ObjMoving.data.otherParam.data.moveAcceleration = moveAcceleration;
                moveAcceleration.data.obj = mapDiv;
                //计算缓冲初始速度=截断最后两段的平均速度
                var cutDisArrayLength = mapDiv.ObjMoving.data.cutDisArray.length;
                if (cutDisArrayLength) {//拖动截断为0个时，取消缓冲
                    cutDisArrayLength = cutDisArrayLength > 1 ? cutDisArrayLength : 2;
                    var timeSpace = mapDiv.ObjMoving.data.endTime.getTime() - mapDiv.ObjMoving.data.cutDisArray[cutDisArrayLength - 2].time.getTime(); //unit--ms
                    var distance = { x: mapDiv.ObjMoving.data.movedX - mapDiv.ObjMoving.data.cutDisArray[cutDisArrayLength - 2].moved.x, y: mapDiv.ObjMoving.data.movedY - mapDiv.ObjMoving.data.cutDisArray[cutDisArrayLength - 2].moved.y };
                    moveAcceleration.data.v0 = { x: Math.round(distance.x / (timeSpace / 1000)), y: Math.round(distance.y / (timeSpace / 1000)) };
                    if (Math.abs(moveAcceleration.data.v0.x) >= mapDiv.ObjMoving.data.otherParam.data.leastBufferMoveSpeed || Math.abs(moveAcceleration.data.v0.y) >= mapDiv.ObjMoving.data.otherParam.data.leastBufferMoveSpeed) {//低于此初始速度无缓冲效果
                        moveAcceleration.data.stopTime = mapDiv.ObjMoving.data.otherParam.data.bufferMoveStopTime; // v0 / a;unit--mm 0.3秒时停止移动
                        moveAcceleration.data.a = moveAcceleration.formula.a.call(moveAcceleration, { x: 0, y: 0 });
                        bufferDis = moveAcceleration.formula.s.call(moveAcceleration, moveAcceleration.data.stopTime);
                        //计算中心点
                        var oldCurrentPixel = mapDiv.ObjMoving.data.otherParam.getPixel(mapDiv.ObjMoving.data.otherParam.data.currentCenter);
                    }
                }
            }
         
            var oldCurrentPixel = mapDiv.ObjMoving.data.otherParam.getPixel(mapDiv.ObjMoving.data.otherParam.data.currentCenter);
            if (mapDiv.ObjMoving.data.otherParam.data.iBufferMove) {
                //缓冲前先重置中心点到拖动位置
                mapDiv.ObjMoving.data.otherParam.data.currentCenter = mapDiv.ObjMoving.data.otherParam.getLatLng({ "x": oldCurrentPixel.x - mapDiv.ObjMoving.data.movedX, "y": oldCurrentPixel.y - mapDiv.ObjMoving.data.movedY });
            }
            //中心点偏移与拖动偏移相反
            var currentCenter = mapDiv.ObjMoving.data.otherParam.getLatLng({ "x": oldCurrentPixel.x - mapDiv.ObjMoving.data.movedX - bufferDis.x, "y": oldCurrentPixel.y - mapDiv.ObjMoving.data.movedY - bufferDis.y });
            //执行指定位置移动
          
            mapDiv.ObjMoving.data.otherParam.moveTo.call(mapDiv.ObjMoving.data.otherParam, currentCenter, mapDiv.ObjMoving.data.otherParam.data.bufferMoveStopTime, mapDiv.ObjMoving.data.otherParam.data.iBufferMove);
            //            if (currentCenter.la > hz_map_region.maxLat || currentCenter.la < hz_map_region.RDLat || currentCenter.lo > hz_map_region.RDLng || currentCenter.lo < hz_map_region.minLng) {
            //                mapDiv.ObjMoving.data.otherParam.moveTo(mapDiv.ObjMoving.data.otherParam.data.initCenter);
            //          }

            // writeLog("call", "stopMove结束");

        }
        //add wheel event
        if (document.addEventListener) {
            this.data.mapDiv.addEventListener("DOMMouseScroll", this.mouseWheel, false); //firefox
            this.data.mapDiv.addEventListener("mousewheel", this.mouseWheel, false); //Chrome 
        }
        if (document.attachEvent) {
            this.data.mapDiv.attachEvent("onmousewheel", this.mouseWheel); //IE
        }
        this.data.mapDiv.mapCls = this;

    }
    //获取当前经纬度视野范围
    //currentBound 做私有时才使用
    this.currentLatLngBoundGet = function (currentBound) {
        currentBound = currentBound || this.data.currentPixelBound;
        //左上角经纬度(最小经度，最大纬度)(最小横坐标，最小纵坐标)
        var leftTopLatLng = this.getLatLng({ x: currentBound.minX, y: currentBound.minY });
        //右下角经纬度(最大经度，最小纬度)(最大横坐标，最大纵坐标)
        var rightBottomLatLng = this.getLatLng({ x: currentBound.maxX, y: currentBound.maxY });
        return { minLo: leftTopLatLng.lo, maxLa: leftTopLatLng.la, maxLo: rightBottomLatLng.lo, minLa: rightBottomLatLng.la };
    }
    this.clearBackContainer = function () {//删除背景切片层
        if (this.data.backPicContainer) {
            //庞小斌，更改移除节点方式
            removeChildSafe(this.data.backPicContainer);
            this.data.backPicContainer = null;
        }
    }
    this.clearMap = function () {//删除mapDiv地图下所有层
        var i = this.data.mapDiv.childNodes.length
        for (var n = 0; n < i; n++) {
            var node = this.data.mapDiv.firstChild;
            //庞小斌，更改移除节点方式
            if (node.nodeName != "polyline") {
                removeChildSafe(node);
            }
        }

        this.data.backPicContainer = null;
    }
    //iReload做私有时才使用
    this.zoomToLevel = function (level, iReload) { //缩放到指定级别
        if ((level == this.data.currentLevel && !iReload) || level > this.data.maxLevel || level < this.data.minLevel)
            return;
        this.execEventListener("zoomToLevel_before");
       this.data.initCenter = this.data.currentCenter;
        //this.data.currentCenter = this.data.initCenter;
        this.data.mapDiv.style.left = "0px";
        this.data.mapDiv.style.top = "0px";
        this.data.currentLevel = level;
        this.data.lastPics = null; //也可省略，因为不存在的图片不会进行删除
        this.clearMap();
        this.reSetByCurrentLevel();
        this.fillBackPicsToDivMap();
        this.execEventListener("zoomToLevel_after");
    }
    this.reload = function () {
        this.mapDivSizeSet();
        this.zoomToLevel(this.data.currentLevel, true);
    }
    //杨德军修改：获取地图返回
    this.mapRangs = function () {
        return { maxlo: hz_map_region.RDLng, minlo: hz_map_region.minLng, maxla: hz_map_region.maxLat, minla: hz_map_region.RDLat }
    }

    //移动到经纬度
    //latLng--{"la":value,"lo":value}
    //bufferDesignateMoveStopTime 缓冲时间 私有才使用
    //iBufferMove 是否缓冲 私有才使用
    this.moveTo = function (latLng, bufferDesignateMoveStopTime, iBufferMove, isloaddata, islockmove, isloadmap) {

        if (window.isNaN(latLng.lo) || window.isNaN(latLng.la)) {
            return;
        }
        //杨德军修改，当经纬度超出地图范围后
        if (latLng.lo < hz_map_region.minLng || latLng.lo > hz_map_region.RDLng || latLng.la < hz_map_region.RDLat || latLng.la > hz_map_region.maxLat) {
            return false;
        }
        if (useprameters.lockpcmove == true && useprameters.lockid != 0 && islockmove != true)
            return;
        //  writeLog("call", "moveTo开始");
        if (iBufferMove == undefined) {
            iBufferMove = this.data.iDesignateMoveBuffer;
        }
        if (iBufferMove) {//缓冲移动效果
            bufferDesignateMoveStopTime = bufferDesignateMoveStopTime ? bufferDesignateMoveStopTime : this.data.bufferDesignateMoveStopTime;
            function _removeLastPic(mapCls) {
                mapCls.removeLastPic.call(mapCls);
            }
            function _updateCenter_fillBackPics(mapCls, moveAccelerationCls) {
                mapCls.data.currentCenter = moveAccelerationCls.data.currentCenter;
                mapCls.fillBackPicsToDivMap.call(mapCls);
            }
            function _stepToNextMoveAcceleration(queueCls, eventType) {//缓冲结束时跳转至下一个缓冲
                queueCls.stepToNext(eventType);
            }
            function initMoveAcceleration(queueCls, eventType) {
                queueCls.getFirstQueue(eventType).startEventParam.init(); //moveAcceleration.init()
            }
            var vt = { x: 0, y: 0 };
            var moveAcceleration = new MoveAcceleration();
            this.data.moveAcceleration = moveAcceleration;
            moveAcceleration.data.pointInit = this.getPixel(this.data.initCenter);
            moveAcceleration.data.currentCenter = latLng;
            moveAcceleration.data.pointCurrentCenter = this.getPixel(latLng);
            moveAcceleration.data.obj = this.data.mapDiv;
            moveAcceleration.data.stopTime = bufferDesignateMoveStopTime;
            //中心点偏移与拖动偏移相反
            var eventType = this.data.designateMoveBufferInQueueEventTypeName;
            //获取队列中最后一个数据对象的中心点,如果没有就获取主地图上次中心点
            var lastMoveAcceleration = this.data.queue.getLastQueue(eventType);
            moveAcceleration.data.pointLast = lastMoveAcceleration ? lastMoveAcceleration.startEventParam.data.pointCurrentCenter : this.getPixel(this.data.currentCenter);
            //计算缓冲参数
            var S = { x: moveAcceleration.data.pointLast.x - moveAcceleration.data.pointCurrentCenter.x, y: moveAcceleration.data.pointLast.y - moveAcceleration.data.pointCurrentCenter.y };
            moveAcceleration.data.v0 = moveAcceleration.formula.v0.call(moveAcceleration, S, vt); //由S、vt、t推出v0
            moveAcceleration.data.a = moveAcceleration.formula.a.call(moveAcceleration, vt); //由v0、t、vt推出a

            moveAcceleration.addEventListener("stopMove", _removeLastPic, this, moveAcceleration); //删除上次切片
            moveAcceleration.addEventListener("startMove", _updateCenter_fillBackPics, this, moveAcceleration); //更新中心点与填充切片
            moveAcceleration.addEventListener("stopMove", _stepToNextMoveAcceleration, this.data.queue, eventType);
            //连续拖动鹰眼时主地图位移会有误差，故放入队列中逐个执行
            //或者考虑与初始位置对比进行移动，同思手工拖动主地图的情况
            this.data.queue.addEvent(eventType, moveAcceleration.startMove, moveAcceleration);
            this.data.queue.addEventListener("stepToNext", initMoveAcceleration, this.data.queue, eventType); //进入下一事件前初始化缓冲类(赋值主地图位置信息到类)
            if (!this.data.queue.iExecuting(eventType)) {//队列中无在执行的事件，就开始执行
                moveAcceleration.init();
                this.data.queue.execEvent(eventType);
            }
        }
        else {
            if (!window.isNaN(latLng.lo) && !window.isNaN(latLng.la)) { //林强修改防止currentCenter为空
                //try {
                var pointInit = this.getPixel(this.data.initCenter); //获取相对于本地图片左上角位置的坐标
                var pointLast = this.getPixel(this.data.currentCenter);
                this.data.currentCenter = latLng;
                var pointCurrent = this.getPixel(latLng);
                //当前mapDiv绝对位置=初始位置(0)与当前位置的偏移值
                var mapLeft = pointInit.x - pointCurrent.x;
                var mapTop = pointInit.y - pointCurrent.y;
                this.data.mapDiv.style.left = mapLeft + "px";
                this.data.mapDiv.style.top = mapTop + "px";
                this.removeLastPic.call(this); //移动结束时删除上次切片。这里可以直接跟在切片填充之后，因为不会有缓冲的效果，位移不会在拖动结束后变化
                this.fillBackPicsToDivMap(isloaddata);
                //  }
                // catch (err) {
                //     alert(err);
                //    return;
                //  }

            }
            else {
                alert(GetTextByName("Alert_Map_ArgmentErrorToIgnoreThisDrag", useprameters.languagedata));
            }



        }
        //writeLog("call", "moveTo结束");
        if (!isloadmap)
            this.execEventListener("moveTo");
    }
    this.getPixelInMap = function (latLng) { //获取相对于地图容器mapDiv的位置(即)，计算了两次（如果知道椭圆知识的话，可以优化为一次）
        var mapDivPosition = this.getMapDivPixelInBigMap();
        var point = this.getPixel(latLng);
        var pointInMapDiv = { x: point.x - mapDivPosition.x, y: point.y - mapDivPosition.y }
        return pointInMapDiv;
    }
    this.getLatLngByPoint = function (pointInMapDiv) {//通过在mapDiv中位置获取经纬度
        var mapDivPosition = this.getMapDivPixelInBigMap();
        var point = { x: pointInMapDiv.x + mapDivPosition.x, y: pointInMapDiv.y + mapDivPosition.y }
        return this.getLatLng(point);
    }
    //页面点击事件获取经纬度
    //return {lo:value,la:value}
    this.getLatLngByEvent = function (ev) {
        ev = ev || window.event;
        var pointInMapDiv = this.getPointByEvent(ev);
        return this.getLatLngByPoint(pointInMapDiv);
    }
    //页面点击事件获取在mapDiv中的pixel位置
    //return {x:value,y:value}
    this.getPointByEvent = function (ev) {
        ev = ev || window.event;
        //鼠标在窗口的位置
        var pointInWindow = Math.evPoint(ev);

        var pointInMapDiv = { x: pointInWindow.x - (this.getPixel(this.data.initCenter).x - this.getPixel(this.data.currentCenter).x), y: pointInWindow.y - (this.getPixel(this.data.initCenter).y - this.getPixel(this.data.currentCenter).y) }; //点在mapDiv中的位置
        return pointInMapDiv;
    }
    //-----------------------------------private-----------------------------------
    this.getMapDivPixelInBigMap = function () { //获取mapDiv在大地图中的实际位置
        var pointCenter = this.getPixel(this.data.initCenter);
        return { x: pointCenter.x - parseInt(this.data.mapDiv.style.width) / 2, y: pointCenter.y - parseInt(this.data.mapDiv.style.height) / 2 }
    }
    //纠正缓冲时插入停止事件造成的中心点偏移
    this.rectifyCenter = function (mapCls) {
        if (mapCls.data.queue.iExistType(mapCls.data.designateMoveBufferInQueueEventTypeName)) {//缓冲区有事件
            //下次开始拖动的时候需要停止缓冲计时器
            mapCls.data.moveAcceleration.stopMove.call(mapCls.data.moveAcceleration, true);
            //纠正中心点,提前停止拖动后需要回调未移动的距离
            if (mapCls.data.moveAcceleration.data.time == mapCls.data.moveAcceleration.data.stopTime) return;
            var s_stop_fact = mapCls.data.moveAcceleration.formula.s.call(mapCls.data.moveAcceleration, mapCls.data.moveAcceleration.data.time);
            var s_stop_expect = mapCls.data.moveAcceleration.formula.s.call(mapCls.data.moveAcceleration, mapCls.data.moveAcceleration.data.stopTime);

            var oldCurrentPixel = mapCls.getPixel(mapCls.data.currentCenter);
            //中心点位移与地图位移相反
            mapCls.data.currentCenter = mapCls.getLatLng({ "x": oldCurrentPixel.x + s_stop_expect.x - s_stop_fact.x, "y": oldCurrentPixel.y + s_stop_expect.y - s_stop_fact.y });
        }
    }
    this.mapDivSizeSet = function () {
        if (!this.data.mapDiv.style.width || !this.data.iSetSize) {
            this.data.mapDiv.style.width = document.documentElement.clientWidth + "px";
        }
        if (!this.data.mapDiv.style.height || !this.data.iSetSize) {
            this.data.mapDiv.style.height = document.documentElement.clientHeight + "px";
        }
    }
    this.reSetByCurrentLevel = function () { //根据当前级别重置参数
        this.data.currentWidth = this.data.firstLevelWidth * Math.pow(2, this.data.currentLevel - 1);//用截图定义google第一级尺寸来计算，周长
        this.data.R = this.data.currentWidth / (Math.PI * 2);
        //scale 比例尺
        this.data.scale = this.data.earthPerimeter / this.data.currentWidth;
        //this.data.deviationPixel 设置当前级别切片偏移坐标（以当前级别初始中心点做参照点，为了统一pixel偏移值）
        var picsCurrentNum = this.data.firstLevelPicCount * Math.pow(this.data.levelZoomMultiple, this.data.currentLevel - 1); //本地级别横向图片数，非google上图片数
        var center = { "lo": this.data.initCenter.lo, "la": this.data.initCenter.la };
        var currentBound = this.currentPixelBoundGet(center);
        var centerDeviationed = { "lo": this.data.initCenter.lo - this.data.deviation_lo, "la": this.data.initCenter.la - this.data.deviation_la }; //对中心点进行反方向平移 获取地图平移反方向位置的图片，这样平移后才能跟界面吻合
        var currentDeviationedPixelBound = this.currentPixelBoundGet(centerDeviationed);
        this.data.deviationPixel = { x: currentDeviationedPixelBound.minX - currentBound.minX, y: currentDeviationedPixelBound.minY - currentBound.minY };
    }
    //获取当前视野的坐标范围
    this.currentPixelBoundGet = function (center) {//return {"minX":value,"maxX":value,"minY":value,"maxY":value}
        var currentCenter = this.data.currentCenter;
        if (center) {//if exist inport center,set new currentCenter
            currentCenter = center;
        }
        var centerPixel = this.getPixel(currentCenter);
        var minX = centerPixel.x - parseInt(this.data.mapDiv.style.width) / 2;
        var maxX = centerPixel.x + parseInt(this.data.mapDiv.style.width) / 2;
        var minY = centerPixel.y - parseInt(this.data.mapDiv.style.height) / 2;
        var maxY = centerPixel.y + parseInt(this.data.mapDiv.style.height) / 2;
        return { "minX": minX, "maxX": maxX, "minY": minY, "maxY": maxY };
    }
    this.fillBackPicsToDivMap = function (isloaddata) {//填充图片到mapDiv//林强修改
        var pics = this.backPicsGet();
        if (!this.data.backPicContainer) {
            //背景容器大小不应设置成跟模型直径一样大小
            var backPicContainer = document.createElement("div");
            backPicContainer.style.position = "absolute";
            backPicContainer.id = "backPicContainer";
            backPicContainer.onclick = function () {
                var map = _StaticObj.objGet("map");
                if (map.data.movedistance > 5) {
                   
                    return;
                }
                try {//防止历史轨迹中无对象
                    if ($(document.getElementById('ifr_callcontent_ifr').contentWindow.document.getElementById('call2')).css("backgroundImage").indexOf("callfinish.png") > 0 || $(document.getElementById('ifr_callcontent_ifr').contentWindow.document.getElementById('call2')).css("backgroundImage").indexOf("receivecall.png") > 0) {
                        alert(GetTextByName("PleaseEndCalling", useprameters.languagedata));//多语言：请结束当前呼叫操作
                        return;
                    }
                } catch (exce) { 
                
                }
                try {
                    var ifrs = ifr_callcontent;
                    if (ifrs == null || ifrs == undefined) { return; }
                    try {
                        if (!ifrs.checkcallimg()) {
                            return;
                        }
                    }
                    catch (e) {
                    }
                    ifrs.document.getElementById("leftinfodivgroup").style.display = 'none';
                }catch(ex){}
                if (!event.ctrlKey) {
                    for (var i = 0; i < useprameters.SelectISSI.length; i++) {
                       // writeLog("oper", "[" + GetTextByName("UnSelected", useprameters.languagedata) + "]:ISSI(" + useprameters.SelectISSI[i] + ")" + GetTextByName("use", useprameters.languagedata) + "ID(" + useprameters.Selectid[i] + ")" + "[" + LOGTimeGet() + "]");         /**日志：操作日志多语言 取消选中，用户**/
                    }
                    useprameters.SelectISSI = []; //清空选中ISSI
                    useprameters.Selectid = []; //清空选中警员
                    useprameters.HidedisplayISSI = [];
                    $("li[id ^= bztp_select_]").remove(); //移除选中
                }

                delBaseSelect();
                LayerControl.refurbish();
            }
            backPicContainer.oncontextmenu = function () {
                useprameters.rightselecttype = "map";
            }
            backPicContainer.style.zIndex = 0;
            this.data.mapDiv.appendChild(backPicContainer);
            this.data.backPicContainer = backPicContainer;
        }
        var pointCenter = this.getPixel(this.data.initCenter);
        this.data.lastPics = this.data.currentPics;
        this.data.currentPics = pics;
        for (var pic_i in pics) {

            if (!document.getElementById(this.picIdGet.call(this, pics[pic_i]))) {
                var imgPic = document.createElement("div");
                imgPic.id = this.picIdGet.call(this, pics[pic_i]);
                imgPic.style.backgroundImage = "url(" + this.data.preloadImg + ")";
                imgPic.row = pics[pic_i].row;
                imgPic.column = pics[pic_i].column;
                imgPic.style.width = this.data.backPicSize + "px";
                imgPic.style.height = this.data.backPicSize + "px";
                if (this.data.mapid != 'historyRecords2' && imgPic.id.indexOf("hawkeye") < 0 && !this.data.isFirstload)
                    imgPic.style.display = "none";
                imgPic.style.position = "absolute";
                //在backPicContainer中的位置 加上当前偏移像素
                imgPic.style.left = pics[pic_i].column * this.data.backPicSize - pointCenter.x + this.data.mapDiv.clientWidth / 2 - pics[pic_i].deviation_x + "px"; //减去mapdiv拖动中心点位置偏移的部分
                imgPic.style.top = pics[pic_i].row * this.data.backPicSize - pointCenter.y + this.data.mapDiv.clientHeight / 2 - pics[pic_i].deviation_y + "px";
                imgPic.errorImgUrl = this.data.errorBackMapUrl;
                imgPic.onerror = this.backMapError;
                imgPic.map = this;
                this.backMapLoad.call(imgPic);
                //                if (imgPic.complete) {//缓存中已经存在 直接加载图片
                //                    this.backMapLoad.call(imgPic);
                //                }
                //                else {//预加载好图片后 加载正确图片
                //                    imgPic.onload = this.backMapLoad;
                //                }
                this.data.backPicContainer.appendChild(imgPic);

            }
        }
        if (!isloaddata) {
            this.execEventListener("fillBackPicsToDivMap"); //public
        }
    }
    this.backMapLoad = function () {
        this.onload = null;
        this.style.backgroundImage = "url(" + this.map.imgPicPath.call(this.map, this.row, this.column)+")";
    }
    this.backMapError = function () {
        this.src = this.errorImgUrl;
    }
    //获取图片编号数组,从零开始编号,可在实际显示时进行编号转换
    this.backPicsGet = function () {
        var picsCurrentNum = this.data.firstLevelPicCount * Math.pow(this.data.levelZoomMultiple, this.data.currentLevel - 1); //本地级别横向图片数，非google上图片数
        var center = { "lo": this.data.currentCenter.lo, "la": this.data.currentCenter.la };
        var currentBound = this.currentPixelBoundGet(center);
        this.data.currentPixelBound = currentBound; //设置当前pixel视野范围，未加入偏移值
        var centerDeviationed = { "lo": this.data.currentCenter.lo - this.data.deviation_lo, "la": this.data.currentCenter.la - this.data.deviation_la }; //对中心点进行反方向平移 获取地图平移反方向位置的图片，这样平移后才能跟界面吻合
        //get currentDeviationedPixelBound
        var currentDeviationedPixelBound = this.currentPixelBoundGet(centerDeviationed);
        //get pics
        var minx = currentDeviationedPixelBound.minX > 0 ? currentDeviationedPixelBound.minX : 0;
        var miny = currentDeviationedPixelBound.minY > 0 ? currentDeviationedPixelBound.minY : 0;
        var maxx = currentDeviationedPixelBound.maxX > 0 ? currentDeviationedPixelBound.maxX : 0;
        var maxy = currentDeviationedPixelBound.maxY > 0 ? currentDeviationedPixelBound.maxY : 0;
        var tiles = {}; //[{"row":value,"column":value}][{"row":value,"column":value}]
        var rowFrom = parseInt(miny / this.data.backPicSize);
        rowFrom = rowFrom < 0 ? 0 : rowFrom;
        var rowTo = Math.ceil(maxy / this.data.backPicSize);
        rowTo = rowTo > picsCurrentNum ? picsCurrentNum : rowTo;
        var columnFrom = parseInt(minx / this.data.backPicSize);
        columnFrom = columnFrom < 0 ? 0 : columnFrom;
        var columnTo = Math.ceil(maxx / this.data.backPicSize);
        columnTo = columnTo > picsCurrentNum ? picsCurrentNum : columnTo;
        for (var rows = rowFrom; rows < rowTo; rows++) {
            for (var columns = columnFrom; columns < columnTo; columns++) {
                tiles[rows + "," + columns] = { "row": rows, "column": columns, "deviation_x": this.data.deviationPixel.x, "deviation_y": this.data.deviationPixel.y };
            }
        }
        return tiles;
    }
    //墨卡托投影,获取相对于地球模型左上角的坐标return{"lo":value,"la":value}
    //latLng--{"la":value,"lo":value}
    //85.05112877980659<la<85.05112877980659
    //-180<lo<180
    this.fromLatLngToPixel = function (latLng) {
       var x = this.data.R * DegreeToRad(+latLng.lo + 180); //子午起始线到点的地图横向距离 +180是因为整圈是360,而实际经度范围为-180 到 180
        //地图高度/2 - 点到赤道距离（可了解椭球知识）
       var y = this.data.currentWidth / 2 - this.data.R * Math.log(Math.tan(Math.PI / 4 + (DegreeToRad(latLng.la)) / 2));
       return { "x": Math.round(x), "y": Math.round(y) };
    }
    //反墨卡托投影,return{ "x": value, "y": value }
    //point--{"x":value,"y":value}
    this.fromPixelToLatLng = function (point) {
       var lng = point.x / this.data.R;
       var lat = Math.PI / 2 - 2 * Math.atan(Math.exp(-(this.data.currentWidth / 2 - +point.y) / this.data.R));
       return { "lo": RadToRegree(lng) - 180, "la": RadToRegree(lat) };
    }



    this.getPixel = function (latLng) {//获取相对于本地图片左上角位置的坐标 接口
    }
    this.getLatLng = function (point) {//获取经纬度 接口
    }
    //删除缓存图片,防止内存增加
    this.removeLastPic = function () {
        if (this.data.lastPics) {
            for (var pic_i in this.data.lastPics) {
                var pic = document.getElementById(this.picIdGet.call(this, this.data.lastPics[pic_i]));
                if (!this.data.currentPics[pic_i] && pic) {
                    //庞小斌，更改移除节点方式
                    removeChildSafe(pic);
                }
            }
        }
    }
    //获取切片ID 
    //pic--{row:value,column:value,others:value}
    this.picIdGet = function (pic) {
        return this.data.mapDiv.id + "|" + pic.row + "," + pic.column;
    }
    this.closeBufferMove = function () {
        this.data.iBufferMove = false;
    }
    this.mouseWheel = function (ev) {
        function setIAllowWheelTrue(mapCls) {
            mapCls.data.iAllowWheel = true;
        }
        ev = ev || window.event;
        //find mapDiv
        var obj = ev.target || ev.srcElement;
        if (!obj.mapCls) {
            while (obj = obj.offsetParent) {
                if (obj.mapCls) { break; }
            }
        }
        //控制一定时间范围内只能缩放一次
        if (!obj.mapCls.data.iAllowWheel) return;
        obj.mapCls.data.iAllowWheel = false;
        L.setTimeout(setIAllowWheelTrue, obj.mapCls.data.wheelSpaceTime, obj.mapCls);
        //zoomToLevel
        var iWheelPlus;
        if (ev.wheelDelta) {//IE/Opera/Chrome 
            iWheelPlus = ev.wheelDelta > 0 ? 1 : 0; // ev.wheelDelta / 112 
        }
        else if (ev.detail) {//Firefox 
            iWheelPlus = ev.detail < 0 ? 1 : 0; //ev.detail / 3 
        }
        if (iWheelPlus) { //zoomIn
            obj.mapCls.zoomToLevel(obj.mapCls.data.currentLevel + 1);
        }
        else { //zoomOut
            obj.mapCls.zoomToLevel(obj.mapCls.data.currentLevel - 1);
        }
    }
}
//核心已经条件：
//当前模型直径（地球周长）
//图片左上角对应的经纬度
//每级缩放比例