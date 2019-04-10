//测距类，效果为模仿google earth与edushi
function Ranging(map, multi_Ranging_index) {
    BaseListener.apply(this);
    this.data = {
        id: "Ranging",
        map: map,
        idPrefix: "Ranging_point_", //id前缀
        zIndex: 19,
        points: new Array(), //点集合 cell--{id:value,latLng:value,disToFirstNode:value,disToFrontNode:value,cellContainter:value} cellContainter--包含每组元素中的div对象
        vectorLanguageCls: new VML(), //矢量画图类 默认为VML
        //小方块可控属性
        rectFillColor: "blue", //填充颜色
        rectSideLength: 3, //边长
        //线可控属性
        lineArrowhead: true, //是否包含箭头
        lineColor: "red", //线颜色
        //距离文本div可控属性
        fontSize: 12,
        fontBackGroundColor: "white",
        fontBorderColor: "black",
        //提示文本可控属性
        promptingBackGroundColor: "yellow",
        //private
        rangingContainerDiv: {}, //测距点容器 {ths:null,promptingContainerDiv:{ths:null,line:null,disText:null,promptingText:null}} promptingContainerDiv--提示信息容器 line--线条 disText--距离信息 promptingText--操作提示文本 ths--对象本身
        iTurnOn: false, //开启测距标识
        iShowPrompting: true, //开启信息显示
        multi_Ranging_index: multi_Ranging_index//所在队列位置
    }
    //核心部分
    this.addNodeToData = function (pixel) {
        var point = {
            latLng: map.getLatLngByPoint(pixel),
            disToFirstNode: null,
            disToFrontNode: null
        };
        this.data.points.push(point);
        point.disToFrontNode = this.getDisToFrontNode(this.getLastNodeIndex() - 1, this.getLastNodeIndex());
        point.disToFirstNode = this.getDisToFirstNode(this.getLastNodeIndex());
        point.id = this.data.idPrefix + this.data.points.length.toString();
    }
    this.delNodeToData = function (nodeIndex) {
        if (this.iExistPoint_node(nodeIndex)) {
            this.data.points.splice(nodeIndex, 1);
        }
    }
    this.iExistPoint = function () {
        if (this.data.points) {
            return true;
        }
        return false;
    }
    this.iExistPoint_node = function (nodeIndex) {
        nodeIndex = nodeIndex || 0;
        if (this.iExistPoint() && this.data.points[nodeIndex]) {
            return true;
        }
        return false;
    }
    //获取点到点的距离,起始截止位置调换距离不变
    //return unit--meter(米)
    this.getDisToFrontNode = function (startNodeIndex, endNodeIndex) {
        if (startNodeIndex < 0 || endNodeIndex < 0) {
            return 0;
        }
        else {
            var pixelStart = this.data.map.getPixelInMap(this.data.points[startNodeIndex].latLng);
            var pixelEnd = this.data.map.getPixelInMap(this.data.points[endNodeIndex].latLng);
            return this.getDisBetweenPoint(pixelStart, pixelEnd);
        }
    }
    this.getDisBetweenPoint = function (pixelStart, pixelEnd) {
        var dis_x = Math.abs(pixelStart.x - pixelEnd.x);
        var dis_y = Math.abs(pixelStart.y - pixelEnd.y);
        return Math.sqrt(Math.pow(dis_x, 2) + Math.pow(dis_y, 2)) * this.data.map.data.scale;
    }
    this.getDisToFirstNode = function (nodeIndex) {
        var dis = 0;
        if (this.iExistPoint()) {
            for (var node_i = 0; node_i <= nodeIndex; node_i++) {
                dis = dis + this.getNodeByIndex(node_i).disToFrontNode;
            }
        }
        return dis;
    }
    this.getDisPointToFirstNode = function (pixel) {
        var lastNode = this.getNodeByIndex(this.getLastNodeIndex());
        var disToFirstNode = lastNode.disToFirstNode;
        var disEventToLastNode = this.getDisBetweenPoint(this.data.map.getPixelInMap(lastNode.latLng), pixel);
        return disToFirstNode + disEventToLastNode;
    }
    this.getLastNodeIndex = function () {
        if (this.data.points) {
            return this.data.points.length - 1;
        }
        return false;
    }
    this.getNodeByIndex = function (nodeIndex) {
        if (this.iExistPoint()) {
            return this.data.points[nodeIndex];
        }
        return false;
    }
    this.addNodeToMap = function (nodeIndex) {
        nodeIndex = nodeIndex || 0;
        var node = this.getNodeByIndex(nodeIndex);
        if (node) {
            var vec = this.data.vectorLanguageCls; //矢量图类
            //add rangingContainerDiv
            this.createRangingContainerDiv();
            //add cellContainterDiv
            var cellContainter = document.createElement("div");
            this.data.rangingContainerDiv.ths.appendChild(cellContainter);
            node.cellContainter = cellContainter;
            var pixel = this.data.map.getPixelInMap(node.latLng);
            //add point
            var rect = vec.createRectangle({ strokecolor: this.data.rectFillColor, fillColor: this.data.rectFillColor, sideLength: this.data.rectSideLength });
            var rectSideLength = 5; //边长
            rect.style.width = rectSideLength + "px";
            rect.style.height = rectSideLength + "px";
            rect.style.left = (pixel.x - rectSideLength / 2) + "px";
            rect.style.top = (pixel.y - rectSideLength / 2) + "px";
            cellContainter.appendChild(rect);
            //add distance number
            var data = {
                text: Number(this.getDisToFirstNode(nodeIndex)).toFixed(2) + "m",
                pixel: pixel,
                backgroundColor: this.data.fontBackGroundColor,
                borderColor: this.data.fontBorderColor,
                fontSize: this.data.fontSize
            }
            cellContainter.appendChild(this.createTextDiv(data));
            //add line ,if first node return(haven't line)
            if (nodeIndex == 0) {
                return;
            }
            var frontNode = this.getNodeByIndex(nodeIndex - 1);
            var pixelFrontNode = this.data.map.getPixelInMap(frontNode.latLng);
            var data = {
                from: { x: pixelFrontNode.x, y: pixelFrontNode.y },
                to: { x: pixel.x, y: pixel.y },
                color: this.data.lineColor,
                EndArrow: this.data.lineArrowhead ? "Classic" : null
            };
            var line = vec.createLine(data);
            cellContainter.appendChild(line);
        }
    }
    this.delNodeToMap = function (nodeIndex) {
        nodeIndex = nodeIndex || 0;
        //del
        var node = this.getNodeByIndex(nodeIndex);
        if (node) {
            var cellContainter = node.cellContainter;
            if (cellContainter) {
                //庞小斌修改，移除测距div
                removeChildSafe(cellContainter);
            }
        }
        if (nodeIndex == 0) {//最后一个点时，删除线跟距离文本
            var line = this.data.rangingContainerDiv.promptingContainerDiv.line;
            var disText = this.data.rangingContainerDiv.promptingContainerDiv.disText;
            if (line) {
                //庞小斌修改，移除测距div
                removeChildSafe(line);
                this.data.rangingContainerDiv.promptingContainerDiv.line = null;
            }
            if (disText) {
                //庞小斌修改，移除测距div
                removeChildSafe(disText);
                this.data.rangingContainerDiv.promptingContainerDiv.disText = null;
            }
        }
    }
    this.addNode = function (ev) {
        document.Ranging.execEventListener("addNode_before", ev);
        //document.Ranging==this
        if (document.Ranging.data.iTurnOn) {
            ev = ev || window.event;
            if (!Math.iLeftButton(ev)) {
                return;
            }
            var pixel = document.Ranging.data.map.getPointByEvent(ev);
            document.Ranging.addNodeToData(pixel);
            document.Ranging.addNodeToMap(document.Ranging.getLastNodeIndex());
        }
        document.Ranging.execEventListener("addNode_after", ev);
    }
    this.delNode = function (ev) {
        //document.Ranging==this
        ev = ev || window.event;
        if (!Math.iRightButton(ev)) {
            return;
        }
        var index = document.Ranging.getLastNodeIndex();
        if (index !== false) {
            document.Ranging.delNodeToMap(index);
            document.Ranging.delNodeToData(index);
            document.Ranging.createPrompting();

   
        }
    }
    this.set_iTurnOn = function (isTurn, objThis) {//切换是否开启标识
        if (objThis) {
            objThis.data.iTurnOn = isTurn;
        }
        else {
            this.data.iTurnOn = isTurn;
        }
    }
    this.turnOn = function () { //开启测距
        this.set_iTurnOn(true);
        document.Ranging = this;
        if (document.attachEvent) {
            this.data.map.data.mapDiv.attachEvent("onmouseup", this.addNode); //添加节点事件，在[事件2]之后，因为[事件2]在mapDiv onmouseup中（先于此事件添加）
            this.data.map.data.mapDiv.attachEvent("oncontextmenu", this.delNode); //右击删除事件
            this.data.map.data.mapDiv.attachEvent("ondblclick", this.finish); //双击结束测量
            document.attachEvent("onmousemove", this.createPrompting); //拖动时添加提示信息
        }
        else {
            this.data.map.data.mapDiv.addEventListener("mouseup", this.addNode, false);
            this.data.map.data.mapDiv.addEventListener("contextmenu", this.delNode, false);
            this.data.map.data.mapDiv.addEventListener("dblclick", this.finish, false);
            document.addEventListener("mousemove", this.createPrompting, false); //拖动时添加提示信息
        }
        this.data.map.data.objMoving.addEventListener("moving", this.set_iTurnOn, false, this); //拖动时禁用测距添加事件
        this.data.map.data.objMoving.addEventListener("stopMove", this.set_iTurnOn, true, this); //事件2：拖动结束时启用测距添加事件
        this.data.map.addEventListener2("zoomToLevel_before", this.removeAllToMap, this, "ranging_zoomToLevel_before" + this.data.multi_Ranging_index); //添加缩放前删除页面测距元素
        this.data.map.addEventListener2("zoomToLevel_after", this.addAllToMap, this, "ranging_zoomToLevel_after" + this.data.multi_Ranging_index); //添加缩放后添加页面测距元素
        this.data.map.data.objMoving.addEventListener("moving", this.setIShowPrompting, false, this); //拖动时取消提示信息更新
        this.data.map.data.objMoving.addEventListener("stopMove", this.setIShowPrompting, true, this); //拖动结束时启用提示信息更新
    }
    this.turnOffExceptZoomEvent = function () { //关闭测距所有事件除了缩放后的输出事件
        this.set_iTurnOn(false);
        document.Ranging = null;
        if (document.attachEvent) {
            this.data.map.data.mapDiv.detachEvent("onmouseup", this.addNode);
            this.data.map.data.mapDiv.detachEvent("oncontextmenu", this.delNode);
            this.data.map.data.mapDiv.detachEvent("ondblclick", this.finish);
            document.detachEvent("onmousemove", this.createPrompting);
        }
        else {
            this.data.map.data.mapDiv.removeEventListener("mouseup", this.addNode, false);
            this.data.map.data.mapDiv.removeEventListener("contextmenu", this.delNode, false);
            this.data.map.data.mapDiv.removeEventListener("dblclick", this.finish, false);
            document.removeEventListener("mousemove", this.createPrompting, false);
        }
        this.data.map.data.objMoving.removeEventListener("moving", this.set_iTurnOn);
        this.data.map.data.objMoving.removeEventListener("stopMove", this.set_iTurnOn);
        this.data.map.data.objMoving.removeEventListener("moving", this.setIShowPrompting);
        this.data.map.data.objMoving.removeEventListener("stopMove", this.setIShowPrompting);
    }
    this.turnOffZoomEvent = function () { //只关闭测距缩放后的输出事件
        this.data.map.removeEventListener2("zoomToLevel_before", this.removeAllToMap, "ranging_zoomToLevel_before" + this.data.multi_Ranging_index);
        this.data.map.removeEventListener2("zoomToLevel_after", this.addAllToMap, "ranging_zoomToLevel_after" + this.data.multi_Ranging_index);
    }
    this.turnOff = function () { //关闭测距
        this.execEventListener("turnOff");
        this.set_iTurnOn(false);
        document.Ranging = null;
        if (document.attachEvent) {
            this.data.map.data.mapDiv.detachEvent("onmouseup", this.addNode);
            this.data.map.data.mapDiv.detachEvent("oncontextmenu", this.delNode);
            this.data.map.data.mapDiv.detachEvent("ondblclick", this.finish);
            document.detachEvent("onmousemove", this.createPrompting);
        }
        else {
            this.data.map.data.mapDiv.removeEventListener("mouseup", this.addNode, false);
            this.data.map.data.mapDiv.removeEventListener("contextmenu", this.delNode, false);
            this.data.map.data.mapDiv.removeEventListener("dblclick", this.finish, false);
            document.removeEventListener("mousemove", this.createPrompting, false);
        }
        this.data.map.data.objMoving.removeEventListener("moving", this.set_iTurnOn);
        this.data.map.data.objMoving.removeEventListener("stopMove", this.set_iTurnOn);
        this.data.map.removeEventListener2("zoomToLevel_before", this.removeAllToMap, "ranging_zoomToLevel_before" + this.data.multi_Ranging_index);
        this.data.map.removeEventListener2("zoomToLevel_after", this.addAllToMap, "ranging_zoomToLevel_after" + this.data.multi_Ranging_index);
        this.data.map.data.objMoving.removeEventListener("moving", this.setIShowPrompting);
        this.data.map.data.objMoving.removeEventListener("stopMove", this.setIShowPrompting);
    }
    this.removeAllToMap = function (objThis) {
        objThis = objThis || this;
        if (objThis.data.rangingContainerDiv.ths) {
            //庞小斌修改，移除测距div
            removeChildSafe(objThis.data.rangingContainerDiv.ths);

            objThis.data.rangingContainerDiv = {};
        }
    }
    this.removeAllData = function (objThis) {
        objThis = objThis || this;
        if (objThis.iExistPoint()) {
            objThis.data.points = new Array();
        }
    }
    //结束测量并显示关闭按钮
    this.finish = function (ths) {
        ths = document.Ranging;
        if (!ths) return;
        //添加关闭按钮
        ths.addCloseBtn.call(ths);
        //添加缩放显示关闭按钮
        ths.data.map.addEventListener2("zoomToLevel_after", ths.addCloseBtn, ths, "ranging_zoomToLevel_after_addCloseBtn" + ths.data.multi_Ranging_index);
        //移除测距中除缩放的所有事件
        ths.turnOffExceptZoomEvent.call(ths);
        ths.execEventListener("finish", ths);
        document.Ranging = null;
        var mp = document.getElementById("map"); //林强修改
        mp.style.cursor = "default"; //林强修改
        try {
            writeLog("oper", "[" + GetTextByName("Distancemeasurement", useprameters.languagedata) + "]:" + GetTextByName("Log_EndDistancemeasurement", useprameters.languagedata) + "[" + LOGTimeGet() + "]");         /**日志：操作日志 多语言：测距，结束测距 **/
        }
        catch (ess) {
        
        }
        $("#imgrang").attr("src", "Images/ToolBar/rightbg/ring.png"); //林强修改
    }
    //结束时添加关闭按钮到末尾节点
    this.addCloseBtn = function (ths) {//删除提示内容 给最后一个节点添加一个div内容改为[关闭]且带关闭事件功能
        //添加关闭按钮 添加缩放事件后的添加该按钮事件
        ths = ths || this;
        with (ths) {
            if (!data.rangingContainerDiv.promptingContainerDiv) {
                ths.createPromptingContainerDiv();
            }
            var pDiv = data.rangingContainerDiv.promptingContainerDiv;
            if (pDiv && pDiv.ths) {
                //delete promptingContainerDiv
                pDiv.ths.parentNode.removeChild(pDiv.ths);
                //add close div
                var node = getNodeByIndex.call(ths, (getLastNodeIndex.call(ths)));

                 try {
                    var pixel = data.map.getPixelInMap(node.latLng);
                  }
                catch (e) {
                    return;
                  }

                var _data = {
                    text: GetTextByName("Text_ClickToClose", useprameters.languagedata),//点击关闭
                    pixel: { x: pixel.x, y: pixel.y - 15 }, //位置
                    backgroundColor: data.promptingBackGroundColor,
                    borderColor: data.fontBorderColor,
                    fontSize: data.fontSize
                }
                var closeDiv = createTextDiv(_data);
                closeDiv.style.cursor = "hand";
                closeDiv.onclick = pDivClick;
                closeDiv.isClose = true;
                closeDiv.ranging = ths;
                data.rangingContainerDiv.ths.appendChild(closeDiv);
                function pDivClick() {
                    var cj = document.getElementById("imgrang");
                    if (cj.src.indexOf("Images/ToolBar/rightbg/ring_un.png") > 0) {
                        return;
                    }
                    //点击关闭按钮时 1、移除该测距DOM  2、移除测距中缩放事件 3、删除该测距数据 4、移除缩放事件后添加该按钮事件
                    with (this.ranging) {
                        removeAllToMap();
                        removeAllData();
                        turnOff();
                        //关闭缩放显示关闭按钮
                        data.map.removeEventListener2("zoomToLevel_after", this.ranging.addCloseBtn, "ranging_zoomToLevel_after_addCloseBtn" + data.multi_Ranging_index);
                        this.ranging.execEventListener("closeBtnClick", this.ranging); //执行关闭按钮后事件
                        //multi_Ranging.data.rangings.splice(inMulti_Ranging_index, 1);
                        return false;
                    }
                }
            }
        }
    }
    this.addAllToMap = function (objThis) {
        objThis = objThis || this;
        if (objThis.iExistPoint()) {
            var length = objThis.getLastNodeIndex();
            for (var node_i = 0; node_i <= length; node_i++) {
                objThis.addNodeToMap(node_i);
            }
        }
    }
    this.createRangingContainerDiv = function () {
        if (!this.data.rangingContainerDiv.ths) {//add rangingContainerToMap
            var rangingContainerDiv = document.createElement("div");
            rangingContainerDiv.style.position = "absolute";
            rangingContainerDiv.style.zIndex = this.data.zIndex;
            this.data.map.data.addObjToMap.add(rangingContainerDiv);
            this.data.rangingContainerDiv.ths = rangingContainerDiv;
        }
        return this.data.rangingContainerDiv.ths;
    }
    this.createPromptingContainerDiv = function () {
        this.createRangingContainerDiv();
        if (!this.data.rangingContainerDiv.promptingContainerDiv) {
            var promptingContainerDiv = document.createElement("div");
            this.data.rangingContainerDiv.ths.appendChild(promptingContainerDiv);
            this.data.rangingContainerDiv.promptingContainerDiv = {};
            this.data.rangingContainerDiv.promptingContainerDiv.ths = promptingContainerDiv;
        }
        return this.data.rangingContainerDiv.promptingContainerDiv;
    }
    //提示信息 包括线 距离文本 操作提示文本 也加到rangingContainerDiv中
    this.createPrompting = function (ev) {
        ev = ev || window.event;
        var ranging = document.Ranging;
        if (!ranging || !ranging.data.iShowPrompting) {
            return;
        }
        //add rangingContainerToMap
        ranging.createPromptingContainerDiv();
        var pixel = ranging.data.map.getPointByEvent(ev);
        //line
        var nodeIndex = ranging.getLastNodeIndex();
        if (nodeIndex >= 0) {//有了第一个节点时
            var frontNode = ranging.getNodeByIndex(nodeIndex);
            var pixelFrontNode = ranging.data.map.getPixelInMap(frontNode.latLng);
            var data = {
                from: { x: pixelFrontNode.x, y: pixelFrontNode.y },
                to: { x: pixel.x, y: pixel.y },
                color: ranging.data.lineColor,
                EndArrow: ranging.data.lineArrowhead ? "Classic" : null
            };
            var line = ranging.data.vectorLanguageCls.createLine(data, document.Ranging.data.rangingContainerDiv.promptingContainerDiv.line);
            if (!ranging.data.rangingContainerDiv.promptingContainerDiv.line) {
                ranging.data.rangingContainerDiv.promptingContainerDiv.ths.appendChild(line);
                ranging.data.rangingContainerDiv.promptingContainerDiv.line = line;
            }
            //distance number
            var data = {
                text: Number(ranging.getDisPointToFirstNode(pixel)).toFixed(2) + "m",
                pixel: { x: pixel.x + 10, y: pixel.y - 10 },
                backgroundColor: ranging.data.fontBackGroundColor,
                borderColor: ranging.data.fontBorderColor,
                fontSize: ranging.data.fontSize
            }
            var disText = ranging.createTextDiv(data, document.Ranging.data.rangingContainerDiv.promptingContainerDiv.disText);
            if (!document.Ranging.data.rangingContainerDiv.promptingContainerDiv.disText) {
                document.Ranging.data.rangingContainerDiv.promptingContainerDiv.ths.appendChild(disText);
                document.Ranging.data.rangingContainerDiv.promptingContainerDiv.disText = disText;
            }
        }
        //prompting text
        var data = {
            text: GetTextByName("Text_LeftKeyToMesRightToCanelDoubClickToOver", useprameters.languagedata),//多语言：左键测量，右键撤销，双击结束测量。
            pixel: { x: pixel.x + 10, y: pixel.y + 15 },
            backgroundColor: ranging.data.promptingBackGroundColor,
            borderColor: ranging.data.fontBorderColor,
            fontSize: ranging.data.fontSize
        }
        var promptingText = ranging.createTextDiv(data, document.Ranging.data.rangingContainerDiv.promptingContainerDiv.promptingText);
        if (!document.Ranging.data.rangingContainerDiv.promptingContainerDiv.promptingText) {
            document.Ranging.data.rangingContainerDiv.promptingContainerDiv.ths.appendChild(promptingText);
            document.Ranging.data.rangingContainerDiv.promptingContainerDiv.promptingText = promptingText;
        }
    }
    this.createTextDiv = function (data, textDiv) {
        textDiv = textDiv || document.createElement("div");
        if (data.text)
            textDiv.innerHTML = data.text;
        textDiv.style.position = "absolute";
        if (data.pixel) {
            textDiv.style.left = data.pixel.x + "px";
            textDiv.style.top = data.pixel.y + "px";
        }
        if (data.backgroundColor)
            textDiv.style.backgroundColor = data.backgroundColor;
        if (data.borderColor)
            textDiv.style.borderColor = data.borderColor;
        if (data.fontSize) {
            textDiv.style.fontSize = data.fontSize + "px";
        }
        textDiv.style.borderStyle = "solid";
        textDiv.style.borderWidth = "1px";
        textDiv.style.padding = "1px";
        textDiv.style.whiteSpace = "nowrap"; //不换行
        return textDiv;
    }
    //画轨迹（杨德军 2011-06-03）
    this.createHistoryTextDiv = function (data, imagWidth,imagHeigth,textDiv) {
        textDiv = textDiv || document.createElement("div");
        if (data.text)
            textDiv.innerHTML = data.text;
        textDiv.style.position = "absolute";
        if (data.pixel) {
            textDiv.style.left = data.pixel.x - imagWidth/2 + "px";
            textDiv.style.top = data.pixel.y - imagHeigth-10 + "px";
        }
//        if (data.backgroundColor)
//            textDiv.style.backgroundColor = data.backgroundColor;
//        if (data.borderColor)
//            textDiv.style.borderColor = data.borderColor;
        if (data.fontSize) {
            textDiv.style.fontSize = data.fontSize + "px";
        }
        //textDiv.style.borderStyle = "solid";
        //textDiv.style.borderWidth = "1px";
        //textDiv.style.padding = "1px";
        textDiv.style.whiteSpace = "nowrap"; //不换行
        return textDiv;
    }
    //画点到地图中，（杨德军 2011-06-02）
    this.addMyNodeToMap = function (MyLatLng) {
        nodeIndex = 0;

        var vec = this.data.vectorLanguageCls; //矢量图类
        //add rangingContainerDiv
        this.createRangingContainerDiv();
        //add cellContainterDiv
        var cellContainter = document.createElement("div");
        this.data.rangingContainerDiv.ths.appendChild(cellContainter);
        //node.cellContainter = cellContainter;
        var pixel = this.data.map.getPixelInMap(MyLatLng);
        //this.addNodeToData(pixel);
        //add point
        var rect = vec.createRectangle({ strokecolor: this.data.rectFillColor, fillColor: this.data.rectFillColor, sideLength: this.data.rectSideLength });
        var rectSideLength = 5; //边长
        rect.style.width = rectSideLength + "px";
        rect.style.height = rectSideLength + "px";
        rect.style.left = (pixel.x - rectSideLength / 2) + "px";
        rect.style.top = (pixel.y - rectSideLength / 2) + "px";
        cellContainter.appendChild(rect);
        
//        var data = {
//            text: "<img src='Images/脚印2.gif' width='26px' height='30px' />",
//            pixel: pixel,
//            backgroundColor: this.data.fontBackGroundColor,
//            borderColor: this.data.fontBorderColor,
//            fontSize: this.data.fontSize
//        }
//        cellContainter.appendChild(this.createHistoryTextDiv(data,26,30));
        
    }

    //画点到数据库中，（杨德军 2011-06-02）
    this.addMyFirstNodeToMap = function (MyLatLng) {
        nodeIndex = 0;

        var vec = this.data.vectorLanguageCls; //矢量图类
        //add rangingContainerDiv
        this.createRangingContainerDiv();
        //add cellContainterDiv
        var cellContainter = document.createElement("div");
        this.data.rangingContainerDiv.ths.appendChild(cellContainter);
        //node.cellContainter = cellContainter;
        var pixel = this.data.map.getPixelInMap(MyLatLng);
        //this.addNodeToData(pixel);
        //add point
        var rect = vec.createRectangle({ strokecolor: this.data.rectFillColor, fillColor: this.data.rectFillColor, sideLength: this.data.rectSideLength });
        var rectSideLength = 1; //边长
        rect.style.width = rectSideLength + "px";
        rect.style.height = rectSideLength + "px";
        rect.style.left = (pixel.x - rectSideLength / 2) + "px";
        rect.style.top = (pixel.y - rectSideLength / 2) + "px";
        cellContainter.appendChild(rect);
        //add distance number
        var data = {
            text: "<div>&nbsp;</div><img src='Images/Police_EmergencyCall.gif' width='25px' height='45px' />",
            pixel: pixel,
            backgroundColor: this.data.fontBackGroundColor,
            borderColor: this.data.fontBorderColor,
            fontSize: this.data.fontSize
        }
        cellContainter.appendChild(this.createHistoryTextDiv(data,30,45));


    }
    this.DDToMap = function (MyLatLng) {
        nodeIndex = 0;

        var vec = this.data.vectorLanguageCls; //矢量图类
        //add rangingContainerDiv
        this.createRangingContainerDiv();
        //add cellContainterDiv
        var cellContainter = document.createElement("div");
        this.data.rangingContainerDiv.ths.appendChild(cellContainter);
        //node.cellContainter = cellContainter;
        var pixel = this.data.map.getPixelInMap(MyLatLng);
        //this.addNodeToData(pixel);
        //add point
        var rect = vec.createRectangle({ strokecolor: this.data.rectFillColor, fillColor: this.data.rectFillColor, sideLength: this.data.rectSideLength });
        var rectSideLength = 1; //边长
        rect.style.width = rectSideLength + "px";
        rect.style.height = rectSideLength + "px";
        rect.style.left = (pixel.x - rectSideLength / 2) + "px";
        rect.style.top = (pixel.y - rectSideLength / 2) + "px";
        cellContainter.appendChild(rect);
        //add distance number
        var data = {
            text: "<div style='color:#600;'>" + MyLatLng.SendTime + "</div><img src='Images/Police.png' width='25px' height='45px' />",
            pixel: pixel,
            backgroundColor: this.data.fontBackGroundColor,
            borderColor: this.data.fontBorderColor,
            fontSize: this.data.fontSize
        }
        cellContainter.appendChild(this.createHistoryTextDiv(data, 30, 45));


    }
    //设置是否更新提示信息
    this.setIShowPrompting = function (iShowPrompting, ths) {
        ths = ths || this;
        ths.data.iShowPrompting = iShowPrompting;
    }
    {//init
        _StaticObj.add(this, this.data.id);
    }
}