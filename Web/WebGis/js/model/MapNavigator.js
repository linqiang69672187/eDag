//待做：地图最小级别 
//找到地图底层缩放事件 添加SynchroMap_toBar同步函数 到 init
//map Navigator
function Navigator(map) {
    //放大 缩小
    this.data =
    {
        "map": map, //地图类

        //style
        "moveImgWidth": 18, //px
        "moveImgHeight": 18, //px
        "zoomImgHeight": 18, //px
        "zoomLevelImgHeight": 12, //px 级别背景图片高度
        "zoomLevelBarHeightPosition": 5, //px 级别背景图片滑块所在纵向位置
        "leftMoveUrl": "WebGis/images/icon_goleft.gif",
        "topMoveUrl": "WebGis/images/icon_goup.gif",
        "rightMoveUrl": "WebGis/images/icon_goright.gif",
        "bottomMoveUrl": "WebGis/images/icon_godown.gif",
        "centerUrl": "WebGis/images/icon_default.gif",
        "move_padding": 2, //px
        "barUrl": "WebGis/images/slider.gif", //用来拖动的滑块
        "levelUrl": "WebGis/images/zoom_bar.gif", //级别背景图片
        "zoomInUrl": "WebGis/images/icon_zoomin.gif", //放大
        "zoomOutUrl": "WebGis/images/icon_zoomout.gif", //缩小
        "containerPaddinLeft": 5, //px
        "containerPaddinTop": 10, //px
        "divBottomMarginTop": 10, //px

        //html Obj
        "imgSliderBar": null//滑块元素
    }
    this.addToMap = function () {
        var divContainer = document.createElement("div");
        divContainer.appendChild(this.create());
        //divContainer.style.backgroundImage = "url(/Images/ToolBar/divNavigator_Back.png)";
        divContainer.style.paddingLeft = this.data.containerPaddinLeft + "px";
        divContainer.style.paddingTop = this.data.containerPaddinTop + "px";
        divContainer.style.position = "absolute";
        divContainer.style.zIndex = this.data.map.data.zIndex + 10;// 林强
        divContainer.style.right = "-43px";
        divContainer.style.top = "150px";
        divContainer.style.width = "94px";
        divContainer.style.height = "200px";
        divContainer.style.backgroundRepeat = "no-repeat";
        document.body.appendChild(divContainer);
    }



    this.create = function () {
        //move button
        var divContainer = document.createElement("div");
        // divContainer.style.fontSize = "0px";
        // var divTop = document.createElement("div"); //top left right bottom move button
        // var divTop_top = document.createElement("div"); //top button
        //  var imgTop_top = document.createElement("img");
        // imgTop_top.style.marginLeft = this.data.moveImgWidth + this.data.move_padding + "px";
        // imgTop_top.src = this.data.topMoveUrl;
        // imgTop_top.style.cursor = "hand";
        // imgTop_top.onmousedown = this.topMoveEventAdd;
        //  divTop_top.appendChild(imgTop_top);

        // var divTop_center = document.createElement("div"); //center three button
        //  var imgTop_centerLeft = document.createElement("img");
        //  imgTop_centerLeft.style.marginTop = this.data.move_padding + "px";
        //  imgTop_centerLeft.style.marginBottom = this.data.move_padding + "px";
        //  imgTop_centerLeft.src = this.data.leftMoveUrl;
        // imgTop_centerLeft.style.cursor = "hand";
        // imgTop_centerLeft.onmousedown = this.leftMoveEventAdd;
        // var imgTop_centerCenter = document.createElement("img");
        //  imgTop_centerCenter.id = "imgTop_centerCenter";
        // imgTop_centerCenter.src = this.data.centerUrl;
        // imgTop_centerCenter.style.margin = this.data.move_padding + "px";
        //imgTop_centerCenter.style.cursor = "hand";
        // imgTop_centerCenter.onmousedown = this.centerMoveEventAdd;
        // var imgTop_centerRight = document.createElement("img");
        // imgTop_centerRight.style.marginTop = this.data.move_padding + "px";
        //imgTop_centerRight.style.marginBottom = this.data.move_padding + "px";
        // imgTop_centerRight.src = this.data.rightMoveUrl;
        // imgTop_centerRight.style.cursor = "hand";
        // imgTop_centerRight.onmousedown = this.rightMoveEventAdd;
        // divTop_center.appendChild(imgTop_centerLeft);
        // divTop_center.appendChild(imgTop_centerCenter);
        // divTop_center.appendChild(imgTop_centerRight);

        // var divTop_bottom = document.createElement("div"); //bottom button
        //   var imgTop_bottom = document.createElement("img");
        // imgTop_bottom.style.marginLeft = this.data.moveImgWidth + this.data.move_padding + "px";
        //imgTop_bottom.src = this.data.bottomMoveUrl;
        //imgTop_bottom.style.cursor = "hand";
        // imgTop_bottom.onmousedown = this.bottomMoveEventAdd;
        // divTop_bottom.appendChild(imgTop_bottom);

        //  divTop.appendChild(divTop_top);
        // divTop.appendChild(divTop_center);
        // divTop.appendChild(divTop_bottom);
        // divContainer.appendChild(divTop);

        //zoomBar
        var divBottom = document.createElement("div");
        divBottom.style.position = "absolute";
        divBottom.id = "mymapnavigator"; //林强修gia
        divBottom.style.left = this.data.moveImgWidth + this.data.move_padding + this.data.containerPaddinLeft + "px";
        var usertype = Cookies.get("usertype");
        if (usertype == 1) {
            divBottom.style.top = this.data.containerPaddinTop + this.data.move_padding * 2 + this.data.moveImgHeight * 3 + this.data.divBottomMarginTop + "px"; //zoomin
        }
        else {
            divBottom.style.top = this.data.containerPaddinTop + this.data.move_padding * 2 + this.data.moveImgHeight * 3 + this.data.divBottomMarginTop - 45 + "px"; //zoomin
        }
        divBottom.style.width = "1px";
        var imgZoomIn = document.createElement("img");
        imgZoomIn.src = this.data.zoomInUrl;
        imgZoomIn.style.cursor = "hand";
        imgZoomIn.onmousedown = this.zoomInEventAdd;
        imgZoomIn._navigator = this;
        divBottom.appendChild(imgZoomIn);

        var imgSliderBar = document.createElement("img"); //barSlider
        imgSliderBar.src = this.data.barUrl;
        imgSliderBar.style.position = "absolute";
        imgSliderBar.style.left = "0px";
        imgSliderBar.style.top = this.zoomBarPostion() + "px";
        imgSliderBar.style.cursor = "hand";
        this.data.imgSliderBar = imgSliderBar;
        divBottom.appendChild(imgSliderBar);
        this.zoomBarEventAdd(imgSliderBar);

        for (var zoom_bar_i = this.data.map.data.maxLevel; zoom_bar_i > 0; zoom_bar_i--) {//levelZoom
            var imgZoomBar = document.createElement("img");
            imgZoomBar.src = this.data.levelUrl;
            if (zoom_bar_i < this.data.map.data.minLevel || zoom_bar_i > this.data.map.data.maxLevel) {
                imgZoomBar.style.filter = "alpha(opacity=20)";
                imgZoomBar.style.cursor = "not-allowed";
            }
            else {
                imgZoomBar.style.cursor = "hand";
                imgZoomBar.level = zoom_bar_i;
                imgZoomBar._navigator = this;
                imgZoomBar.imgSliderBar = imgSliderBar;
                imgZoomBar.onmousedown = this.levelZoomEvent;
            }
            divBottom.appendChild(imgZoomBar);
        }
        var imgZoomOut = document.createElement("img"); //zoomout
        imgZoomOut.src = this.data.zoomOutUrl;
        imgZoomOut.style.cursor = "hand";
        imgZoomOut.onmousedown = this.zoomOutEventAdd;
        imgZoomOut._navigator = this;
        divBottom.appendChild(imgZoomOut);

        divContainer.appendChild(divBottom);
        return divContainer;
    }
    this.zoomToLevel = function (level) {//缩放到指定级别
        if (!this.isLevelAvailable(level)) { return; }
        var obj = this.data.map;
        if (!obj.data.iAllowWheel) return;
        obj.data.iAllowWheel = false;
        L.setTimeout(setIAllowWheelTrue, obj.data.wheelSpaceTime, obj);
        function setIAllowWheelTrue(mapCls) {
            mapCls.data.iAllowWheel = true;
        }

        this.data.map.zoomToLevel(level);
        this.SynchroMap_toBar();
    }
    //其它移动事件 最好考虑做成是平均速度移动 再最好考虑一边移动一边加载图片
    this.others = function () { }
    ///private
    this.SynchroMap_toBar = function () { //同步地图信息到导航栏 包括当前级别、最大级别、最小级别
        if (this.data.imgSliderBar)//首次加载不存在
            this.data.imgSliderBar.style.top = this.zoomBarPostion(this.data.map.data.currentLevel) + "px";
    }
    //缩放前判断事件
    this.isLevelAvailable = function (level) {//这里应该是先将级别设置后再进行缩放，就不会出现缩放到不准缩放的级别了
        if (level <= this.data.map.data.maxLevel && level >= this.data.map.data.minLevel)
            return true;
        else
            return false;
    }
    this.zoomBarPostion = function (level) { //top 通过级别 获取滑块所在div的 高度位置
        if (!level) level = this.data.map.data.currentLevel;
        if (level > this.data.map.data.maxLevel)
            level = this.data.map.data.maxLevel;
        if (level < this.data.map.data.minLevel)
            level = this.data.map.data.minLevel;
        return (this.data.map.data.maxLevel - level) * this.data.zoomLevelImgHeight + this.data.zoomLevelBarHeightPosition + this.data.zoomImgHeight;
    }
    //imgSliderBar--滑块
    //currentHeight--当前滑块top位置 或鼠标距离上级div top位置
    this.levelGetByImgSliderBarTop = function (currentHeight) { //通过滑块所在位置高度获取级别 并执行缩放
        for (var level_i = this.data.map.data.maxLevel; level_i >= this.data.map.data.minLevel; level_i--) {//对比找出滑块位置的最近级别    
            var distance = currentHeight - this.zoomBarPostion(level_i);
            if (distance < this.data.zoomLevelImgHeight) {//小于一个滑片背景的高度
                var resultLevel;
                var resultTop;
                if (distance > this.data.zoomLevelImgHeight / 2) {//定位到下面的位置
                    resultLevel = level_i - 1;
                    resultTop = this.zoomBarPostion(level_i - 1);
                }
                else {
                    resultLevel = level_i;
                    resultTop = this.zoomBarPostion(level_i);
                }
                return resultLevel;
                break;
            }
        }
    }
    //导航栏元素事件 非Navigator对象事件
    this.levelZoomEvent = function (ev) { //直接点击级别位置缩放
        ev = ev || window.event;
        //event.offsetY 到最近上个元素的距离 这里指鼠标位置到上个最近元素的距离
        //alert(event.offsetY); return;
        var currentHeight;
        if (this.level == this._navigator.data.map.data.maxLevel) {//click event level
            currentHeight = this._navigator.data.zoomImgHeight + Math.evPoint(ev).y - Math.offsetGet(this).y;
        }
        else {
            currentHeight = (this._navigator.data.map.data.maxLevel - this.level) * this._navigator.data.zoomLevelImgHeight + this._navigator.data.zoomImgHeight + Math.evPoint(ev).y - Math.offsetGet(this).y;
        }
        var level = this._navigator.levelGetByImgSliderBarTop.call(this._navigator, currentHeight);
        if (level != this._navigator.data.currentLevel)
            this._navigator.zoomToLevel(level);
    }
    this.latestLevelGet = function (mcveCls) {//滑块拖动后缩放
        var _navigator = mcveCls.data.otherParam;
        var currentHeight = parseInt(_navigator.data.imgSliderBar.style.top);
        var level = _navigator.levelGetByImgSliderBarTop.call(_navigator, currentHeight);
        if (level != _navigator.data.currentLevel)
            _navigator.zoomToLevel(level);
    }
    this.zoomBarEventAdd = function (obj) { //add event to zoomBar
        var _objMoving = new ObjMoving();
        _objMoving.data.captureObj = obj;
        _objMoving.data.moveObj = obj;
        _objMoving.data.min = this.zoomBarPostion(this.data.map.data.maxLevel);
        _objMoving.data.max = this.zoomBarPostion(this.data.map.data.minLevel);
        _objMoving.data.isY = 2;
        _objMoving.data.otherParam = this;
        //add stopMoveAfter event 用来结束拖动后重定位滑块
        _objMoving.addEventListener("stopMove", this.latestLevelGet, _objMoving);
        _objMoving.init();
    }
    this.topMoveEventAdd = function () {
        var movedPixel = { x: 0, y: -500 };
        Map.prototype.movedByPixel.call(map, movedPixel);
    }
    this.leftMoveEventAdd = function () {
        var movedPixel = { x: -500, y: 0 };
        Map.prototype.movedByPixel.call(map, movedPixel);
    }
    this.rightMoveEventAdd = function () {
        var movedPixel = { x: 500, y: 0 };
        Map.prototype.movedByPixel.call(map, movedPixel);
    }
    this.bottomMoveEventAdd = function () {
        var movedPixel = { x: 0, y: 500 };
        Map.prototype.movedByPixel.call(map, movedPixel);
    }
    this.centerMoveEventAdd = function () {
        with (map) {
            zoomToLevel(data.initLevel);
            moveTo(data.initCenter);
        }
    }
    this.zoomInEventAdd = function () {
        this._navigator.zoomToLevel.call(this._navigator, this._navigator.data.map.data.currentLevel + 1);
    }
    this.zoomOutEventAdd = function () {
        this._navigator.zoomToLevel.call(this._navigator, this._navigator.data.map.data.currentLevel - 1);
    }
    {//init
        map.addEventListener("zoomToLevel_after", function (navigator) {//找到地图底层缩放事件 添加SynchroMap_toBar同步函数
            navigator.SynchroMap_toBar();
        }, this);
        Map.prototype.movedByPixel = function (movedPixel) {
            with (this) {
                var centerPixel = getPixelInMap(data.currentCenter);
                var centerPixelMoved = { x: centerPixel.x + movedPixel.x, y: centerPixel.y + movedPixel.y };
                var centerMoved = getLatLngByPoint(centerPixelMoved);
                moveTo(centerMoved);
            }
        }
    }
}