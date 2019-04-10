//图层管理器

//注意控制不要多次获取数据
function LayerManager(map) {
    BaseListener.apply(this);
    //public
    var layerData;

    this.id = "LayerControl";
    this.map = map;
    this.AllLayersOutSideId = "LayersOutSide";
    this.AjaxURL = "WebGis/Service/LayerControl.aspx";
    this.LayerControlID = String;
    this.zIndexMax = 20;
    this.Layers = {};  //include getDataParams
    this.Listeners = new Array();  //监听器数组
    this.vectorLanguageCls = new VML();  //矢量画图类 默认为VML
    this.isrelockpc = true;
    this.isDrawtrace = true;
    this.CellSetTimeout;
    this.LayerType = {
        'Circle': 'CircleModel', //圆形
        'Oval': 'OvalModel', //椭圆
        'Sector': 'SectorModel', //扇形
        'Diamond': 'DiamondModel', //菱形
        'Sharp6': 'Sharp6Model', //6边形
        'OrientArrow': 'OrientArrowModel', //方向箭头
        'Region': 'RegionModel', //多边形
        'Image': 'ImageModel', //Image
        'Rectangle': 'RectangleModel', //矩形
        'Line': 'LineModel'//线形
    };
    this.LayerVectorCls = {//画图类
        //        CircleModel: new CircleModel(),
        //        SectorModel: new SectorModel(),
        //        DiamondModel: new DiamondModel(),
        //        Sharp6Model: new Sharp6Model(),
        //        OrientArrowModel: new OrientArrowModel(),
        //        OvalModel: new OvalModel(),
        //        RectangleModel: new RectangleModel(),
        ImageModel: new ImageModel()
        //        LineModel: new LineModel()
    }
    this.Data = {};  //图层数据 "layerID": [{ "cell": null }, { "cell": null}]
    this.LastData = {};  //上次图层数据
    this.romancedCells = {};  //已经渲染过的图元id
    this.MapClickCells = new Array();  //09-09-11 保存选中的图元
    this.LastZoom = "";
    this.CurrentZoom = "";
    this.LastBound = "";
    this.CurrentBound = "";
    this.OldLayers = new Array();  //paintMap 后保留的图层
    this.iGetData = true;  //启用关闭获取数据标识
    this.BeImageFrontZoomNum = 3;
    this.SelectArray = new Array();  //获取数据的选择数组数据
    this.Gray = false;  //把底图变灰色
    this.LayerControl_clearsign = null;  //定时删除定位后图标
    //private
    this.CellMouseEvent = new MouseEvent(); //鼠标事件类
    //09-9-11 添加图元选择监听器
    this.AddListener = function (fun) {
        this.Listeners.push(fun);
    }
    this.DelListener = function (fun) {
        for (var lis_i = 0; lis_i < this.Listeners.length; lis_i++) {
            if (this.Listeners[lis_i].toLocaleString == fun.toLocaleString) {
                this.Listeners.splice(lis_i, 1);
            }
        }
    }
    this.FirePropertyChange = function () {
        for (var lis_i = 0; lis_i < this.Listeners.length; lis_i++) {
            this.Listeners[lis_i](this.MapClickCells);
        }
    }
    //将屏幕经纬度转换成字符串传送到服务器端的数据
    this.get_string_must_display_police = function () {
        var display_user = new Array();
        var mian = document.getElementById("main");
       
        //display_user = get_must_display_user();
        display_user = mian.getALLMustDisplayPolices();
      
        var string_display_user = "";
        for (var i in display_user)
            for (var j in display_user[i]) {
                string_display_user = string_display_user + "|" + display_user[i][j];
            }
        return string_display_user;
    }
    //加载图层数据，用于拖到或缩放后使用
    this.LoadDataToLayerControl = function (layerManager) {
    
        layerManager = layerManager || this;
        if (!layerManager.iGetData)//防止多次获取非当前数据的情况
        {
            return;
        }

        var t1 = new Date();
        layerManager.CurrentBound = layerManager.map.currentLatLngBoundGet();
        layerManager.CurrentZoom = layerManager.map.data.currentLevel;
        layerManager.Layers.bound = layerManager.CurrentBound.minLo + ',' + layerManager.CurrentBound.maxLo + ',' + layerManager.CurrentBound.minLa + ',' + layerManager.CurrentBound.maxLa;
        var zoomlevel = layerManager.map.data.currentLevel;
        var _layers = "";
        for (var layer in layerManager.Layers.layers) {
            if (layerManager.Layers.layers[layer]['getDataParams']) {
                if (zoomlevel >= layerManager.Layers.layers[layer].zoomLevel && layerManager.Layers.layers[layer]['getDataParams']['isTurnOn']) {
                    _layers += layerManager.Layers.layers[layer]['getDataParams']['layerType'] + "," + layerManager.Layers.layers[layer]['getDataParams']['manufactoryId'] + ',' + layerManager.Layers.layers[layer]['getDataParams']['site_type'] + '|';
                }
            }
        }
        if (_layers != '') {
            _layers = _layers.substring(0, _layers.length - 1); //cut last '|'
        }
        var tc1 = new Date();
        var myDate = new Date();
        layerManager.selectGet();
        var bss = ""; //bss == bound|select|storedProcedures
        if (layerManager.Layers.bound)
            bss = bss.concat(layerManager.Layers.bound).concat('|');
        else
            bss = bss.concat('|');
        if (layerManager.Layers.select)
            bss = bss.concat(layerManager.Layers.select).concat('|');
        else
            bss = bss.concat('|');
        if (layerManager.Layers.StoredProcedures) {
            bss = bss.concat(layerManager.Layers.StoredProcedures);
        }
        else
            bss = bss.concat('|');
        /**新增参数终端[是否隐藏不在线超时终端/超时时间]**/
        bss = bss.concat(useprameters.hide_timeout_device).concat('|').concat(useprameters.device_timeout);
        var must_display_user = layerManager.get_string_must_display_police();

        var param = {
            func: "LoadDataToLayerControl",
            layers: _layers,
            bss: bss,
            must_display_user: must_display_user,
            other: layerManager.Layers.other, //其它参数
            maxla: layerManager.CurrentBound.maxLa,
            maxlo: layerManager.CurrentBound.maxLo,
            minla: layerManager.CurrentBound.minLa,
            minlo: layerManager.CurrentBound.minLo
        };
        getNewData_ajax(layerManager.AjaxURL, param, function (request) {

            if (!request["Police,0,0"]) {
                return;
            }
            var tc2 = new Date();
            cSharp = (tc2.getTime() - tc1.getTime()) / 1000;
            layerManager.Data = request;      
            //writeLog("system", layerManager.Data["Police,0,0"].length + TimeGet1() + "LV:" + LayerControl.map.data.currentLevel);
            layerManager.OutPutLayer(); //输出警员图层
            // 这里加上渲染等函数
            var t2 = new Date();
            AllTime = (t2.getTime() - t1.getTime()) / 1000;
            layerManager.LastZoom = layerManager.CurrentZoom;
            layerManager.LastBound = layerManager.CurrentBound;
            tc1 = null;
            tc2 = null;
            t2 = null;
            request = null;
        }, false, false);
    }
    this.LoadDataToLayerControl_Post = function (SelectedEntity, layerManager) {

        layerManager = layerManager || this;
        if (!layerManager.iGetData)//防止多次获取非当前数据的情况
        {
            return;
        }
        var t1 = new Date();
        layerManager.CurrentBound = layerManager.map.currentLatLngBoundGet();
        layerManager.CurrentZoom = layerManager.map.data.currentLevel;
        layerManager.Layers.bound = layerManager.CurrentBound.minLo + ',' + layerManager.CurrentBound.maxLo + ',' + layerManager.CurrentBound.minLa + ',' + layerManager.CurrentBound.maxLa;
        var zoomlevel = layerManager.map.data.currentLevel;
        var _layers = "";
        for (var layer in layerManager.Layers.layers) {
            if (layerManager.Layers.layers[layer]['getDataParams']) {
                if (zoomlevel >= layerManager.Layers.layers[layer].zoomLevel && layerManager.Layers.layers[layer]['getDataParams']['isTurnOn']) {
                    _layers += layerManager.Layers.layers[layer]['getDataParams']['layerType'] + "," + layerManager.Layers.layers[layer]['getDataParams']['manufactoryId'] + ',' + layerManager.Layers.layers[layer]['getDataParams']['site_type'] + '|';
                }
            }
        }
        if (_layers != '') {
            _layers = _layers.substring(0, _layers.length - 1); //cut last '|'
        }
        var tc1 = new Date();
        var myDate = new Date();
        layerManager.selectGet();
        var bss = ""; //bss == bound|select|storedProcedures
        if (layerManager.Layers.bound)
            bss = bss.concat(layerManager.Layers.bound).concat('|');
        else
            bss = bss.concat('|');
        if (layerManager.Layers.select)
            bss = bss.concat(layerManager.Layers.select).concat('|');
        else
            bss = bss.concat('|');
        if (layerManager.Layers.StoredProcedures) {
            bss = bss.concat(layerManager.Layers.StoredProcedures);
        }
        else
            bss = bss.concat('|');
        /**新增参数终端[是否隐藏不在线超时终端/超时时间]**/
        bss = bss.concat(useprameters.hide_timeout_device).concat('|').concat(useprameters.device_timeout);
        var must_display_user = layerManager.get_string_must_display_police();

        var param = {
            func: "LoadDataToLayerControl",
            layers: _layers,
            bss: bss,
            must_display_user: must_display_user,
            other: layerManager.Layers.other, //其它参数
            maxla: layerManager.CurrentBound.maxLa,
            maxlo: layerManager.CurrentBound.maxLo,
            minla: layerManager.CurrentBound.minLa,
            minlo: layerManager.CurrentBound.minLo
        };
        getNewData_ajax_Post(layerManager.AjaxURL, param, function (request) {
            var tc2 = new Date();
            cSharp = (tc2.getTime() - tc1.getTime()) / 1000;
            layerManager.Data = request;
            layerManager.OutPutLayer(); //输出警员图层
            // 这里加上渲染等函数
            var t2 = new Date();
            AllTime = (t2.getTime() - t1.getTime()) / 1000;
            layerManager.LastZoom = layerManager.CurrentZoom;
            layerManager.LastBound = layerManager.CurrentBound;
            tc1 = null;
            tc2 = null;
            t2 = null;
            request = null;
        }, SelectedEntity, false, false);
    }
    //09-10-20 取消选择语句
    this.CancelSelectByAttrName = function (attrName) {
        for (var selecti = 0; selecti < this.SelectArray.length; selecti++) {
            if (this.SelectArray[selecti]['id'] == attrName) {
                this.SelectArray.splice(selecti, 1);
                selecti--;
            }
        }
    }
    this.selectGet = function () {
        var select = ""; //选择语句
        if (this.SelectArray.length > 0) {
            var typeIndex = 0; //默认为零，如果是0则加上and连接
            for (var seli = 0; seli < this.SelectArray.length; seli++) {
                if (seli != 0) {
                    if (this.SelectArray[seli - 1]['type'] == this.SelectArray[seli]['type']) {
                        typeIndex = 1;
                    }
                    else {
                        typeIndex = 0;
                    }
                }
                if (seli == 0)//第一次一定要加上'('
                {
                    select += "(" + this.SelectArray[seli]['select'];
                }
                else if (typeIndex == 0) {
                    //15:42 2010/10/9 加上 and_or判断
                    var and_or = "and";
                    if (this.SelectArray[seli]['and_or'])
                        and_or = this.SelectArray[seli]['and_or'];
                    select += ") " + and_or + " (" + this.SelectArray[seli]['select'];
                }
                else {
                    select += this.SelectArray[seli]['select'];
                }
            }
            if (select.length > 0) {
                select += ")";
            }
        }
        this.Layers.select = select;
    }
    this.SingleLayerDataGet = function (layerId) {
        var bss = ""; //bss == bound|select|storedProcedures
        if (this.Layers.bound)
            bss += this.Layers.bound + '|';
        else
            bss += '|';
        if (this.Layers.select)
            bss += this.Layers.select + '|';
        else
            bss += '|';
        if (this.Layers.StoredProcedures)
            bss += this.Layers.StoredProcedures;
        getNewData_ajax(this.AjaxURL, 'time=' + TimeGet() + '&func=LoadDataToLayerControl&layers=' + escape(layerId) + '&bss=' + escape(bss), function (request) {
            layerData = jsonParse(request.responseText);
            for (var layer in layerData)
                this.Data[layer] = layerData[layer];
        }, true);
    }

    //    cellsNum 图元组索引
    //    layer 图层id
    //    _OutPutFunArr输出函数组 [[fun1,divLayer1],[fun2,divLayer2]] fun1执行函数 divLayer 地图图层对象组
    //    OutPutFun 如输出函数名为null 则为OutPutLayer启动 否则为单一图层输出（全部输出）

    this.OutPutLayerCells = function (objOutPutLayerCell, layer, _OutPutFunArr, OutPutFun, cellsNum, data) {
        var layermager = data;
        try {
            if (!cellsNum) {
                cellsNum = 0;
            }

            //if (!layermager.iGetData) {//监测到用户进行拖动或放大，取消本次输出
            //    return;
            //}
            if (!layermager.Data[layer] || !layermager.Data[layer][cellsNum])
                return;

            //庞小斌修改，修改之前先隐藏警员div，以此减少界面重排版次数
            var policediv = document.getElementById("Police,0,0_OutputLayerCell");
            if (policediv && policediv.style.display != "none") {
                policediv.style.display = "none";    //庞小斌修改，修改之前先隐藏警员div，以此减少界面重排版次数
            }

            //  while (cellsNum < layermager.Data[layer].length) {
            var layerCells = layermager.Data[layer][cellsNum];
            for (var cell in layerCells) {
                //copy the layer properties to layerCell
                for (var property in layermager.Layers.layers[layer]) {
                    layerCells[cell][property] = layermager.Layers.layers[layer][property];
                }
                layermager.execEventListener("OutPutLayerCells_before", layer + "|" + cell, layerCells[cell]);

                for (var _OutPutFunArr_i = 0; _OutPutFunArr_i < _OutPutFunArr.length; _OutPutFunArr_i++) {

                    if (OutPutFun || !layermager.IsExistInLastData(layer, cell)) { //不在LastData中 才输出 缩放后需清除lastData OutPutFun != "OutputLayerCell"表示输出单一图层其它如文本图层时需要全部输出

                        {
                            if (_OutPutFunArr_i == 0) {
                                layermager.execEventListener("OutPutLayerCells_In", layer + "|" + cell, layerCells[cell]);

                            }
                            _OutPutFunArr[_OutPutFunArr_i][0].call(objOutPutLayerCell, layerCells[cell], _OutPutFunArr[_OutPutFunArr_i][1]);

                        }
                    }
                }
                layermager.AddExistCell(layer, cell);
                try {
                    layermager.execEventListener("OutPutLayerCells_after", layer + "|" + cell, layerCells[cell], layer);
                }
                catch (e) {
                    //alert("2" + e);
                }
            }
            // cellsNum++;
            layermager.execEventListener("OutPutLayerallCells_after", layer + "|" + layerCells, layerCells, layer);
            //  if (cellsNum < layermager.Data[layer].length) {
            //  layermager.CellSetTimeout=L.setTimeout(layermager.OutPutLayerCells, 1 / 100, objOutPutLayerCell, layer, _OutPutFunArr, OutPutFun, cellsNum, layermager);
            // setTimeout(layermager.OutPutLayerCells(objOutPutLayerCell, layer, _OutPutFunArr, OutPutFun, cellsNum), 1/100);

            // }
            //    }

            //庞小斌修改，修改之后显示警员div
            if (policediv && policediv.style.display == "none") {
                policediv.style.display = "block";    //庞小斌修改，修改之后显示警员div
            }
        }
        catch (ex) {
            //alert("OutPutLayerCells" + ex);
        }

    }


    //2010/6/9
    //09-11-25 单个图层输出,并且在10ms间隔后输出下一批图元（为了界面上能显示出已经输出的图元，然后接着输出）
    //OutPutFun =null 为输出所有  否则为指定
    this.OutPutSingleLayer = function (layer, OutPutFun) {//OutPutFun指定输出函数名 null为默认OutputLayerCell函数
        if (!this.Data[layer])
            return;
        this.execEventListener("OutPutSingleLayer_before");
        //set objOutPutLayerCell
        var objOutPutLayerCell = this.Layers.layers[layer].vectorCls;
        var isFrontImage = false;
        var isSector = false;
        if (this.Layers.layers[layer].figure == this.LayerType.Sector) {
            isSector = true;
        }
        if (this.map.data.currentLevel < this.BeImageFrontZoomNum)//is <8 level
        {   //小于8级别的扇形用图片代替
            objOutPutLayerCell = eval("new " + this.LayerType.Image + "()");
            isFrontImage = true;
        }

        //先生成该图层div到最外图层
        if (!childGetById(this.AllLayersOutSideId, layer)) {
            var divLayer = document.createElement("div"); //DivLay
            divLayer.id = layer;
            if (this.Layers.layers[layer].zIndex) {
                divLayer.style.zIndex = this.Layers.layers[layer].zIndex;
            }
            divLayer.style.position = "absolute"; //zIndex needs
            document.getElementById(this.AllLayersOutSideId).appendChild(divLayer);
        }

        //set _OutPutFunArr
        var _OutPutFunArr = new Array(); //在输出时执行的函数
        if (!OutPutFun) {//all funs
            if (this.Layers.layers[layer].funNames) {
                for (var funName in this.Layers.layers[layer].funNames) {
                    if (this.Layers.layers[layer].funNames[funName]) {
                        var funTemp = eval("objOutPutLayerCell." + funName);
                        if (funTemp) {
                            this.AddLayer(layer, layer + '_' + funName);
                            var tempArr = new Array();
                            tempArr.push(funTemp);
                            tempArr.push(childGetById(layer, layer + '_' + funName));
                            _OutPutFunArr.push(tempArr);
                        }
                    }
                }
            }
        }
        else {//only one fun
            var funTemp = eval("objOutPutLayerCell." + OutPutFun);
            if (funTemp) {
                this.AddLayer(layer, layer + '_' + OutPutFun);
                var tempArr = new Array();
                tempArr.push(funTemp); //appointment
                tempArr.push(childGetById(layer, layer + '_' + OutPutFun));
                _OutPutFunArr.push(tempArr);
            }
        }
        var datalength = this.Data[layer].length;

        for (var i = 0; i < datalength; i++) {
            L.setTimeout(this.OutPutLayerCells, 1 / 100, objOutPutLayerCell, layer, _OutPutFunArr, OutPutFun, i, this)
            //this.OutPutLayerCells(objOutPutLayerCell, layer, _OutPutFunArr, OutPutFun);
        }
        this.execEventListener("OutPutallLayerCells_In", this.Data[layer]);
    }
    this.AddLayer = function (toLayerID, addLayerID) {
        var divaddLayer = document.createElement("div");
        if (!childGetById(toLayerID, addLayerID)) {
            divaddLayer.id = addLayerID;
            if (divaddLayer.id.indexOf("OutputLayerCell") > -1) {//基站图需要置顶

            }
            document.getElementById(toLayerID).appendChild(divaddLayer);
        }
    }
    //09-09-05 输出图层数据到地图 isAllPut是否只输出不在视野范围内的（拖动时）
    this.OutPutLayer = function () {
        this.execEventListener("OutPutLayer_before");
        //生成最外图层（包含所有图层）
        if (!document.getElementById(this.AllLayersOutSideId)) {
            var divLayer = document.createElement("div");
            divLayer.id = this.AllLayersOutSideId;
            this.map.data.mapDiv.appendChild(divLayer);
        }
        //判断是否需要画轨迹
        if (this.isDrawtrace) {
            for (var i = 0; i < useprameters.nowtrace.length; i++) {
                ajaxgettrace();
            }
        }
        for (var layer in this.Data) {
            this.OutPutSingleLayer(layer, null); //OutPutFun指定输出函数名 null为默认OutputLayerCell函数
        }
        if (!this.isrelockpc) return;
        if (useprameters.lockid != 0 && useprameters.lockid != null && this.Data["Police,0,0"] == undefined) {
            movelockpc();
        }

        var myrectangle_choose = document.getElementById("myrectangle_choose"); //判断框选是否还存在
        if (!myrectangle_choose)
            delObj("select_user"); //删除选框  

    }
    //2010/6/10 判断图元是否在已输出图元中
    this.IsExistInLastData = function (layer, cell) {
        if (this.LastData[layer])
            return this.LastData[layer][cell];
        return false;
    }
    this.AddExistCell = function (layer, cell) {
        if (this.LastData[layer])
            this.LastData[layer][cell] = true;
        else {
            this.LastData[layer] = {};
            this.LastData[layer][cell] = true;
        }
    }
    this.DelExistCell = function (layer, cell) {
        if (this.LastData[layer]) {
            this.LastData[layer][cell] = false;
        }
    }
    this.CellGet = function (layerID, cellID) {
        if (this.Data[layerID]) {
            for (var cells = 0; cells < this.Data[layerID].length; cells++) {
                if (this.Data[layerID][cells][cellID])
                    return this.Data[layerID][cells][cellID];
            }
        }
        return false;
    }
    //09-08-25 单图元定位 //取消如右功能，图元直接变色 暂时不能使其它图元复原
    this.LayerCellLocation = function (layerID, cellID, longitude, latitude) {
        //define ShowSign cellOutPutAfter
        //        cellOutPutAfter.signCellID = layerID + "|" + cellID;
        var map = _StaticObj.objGet("map"); //林强修改

        var zoomlevel = map.data.currentLevel; //林强修改
        if (zoomlevel < this.BeImageFrontZoomNum)
            zoomlevel = this.BeImageFrontZoomNum;
        map.zoomToLevel(zoomlevel); //林强修改
        return map.moveTo({ "lo": longitude, "la": latitude }); //林强修改
    }
    this.SetSourceCell = function (layerCell) {
        this.ClearSourceCell();
        if (layerCell) {
            var cell = document.getElementById(layerCell.LayerID + "|" + layerCell.ID + "_vFigure");
            if (cell) {
                //2010/10/18 加上换图片功能 _un
                if (cell.nodeName == "IMG") {
                    //                    cell.src = cell.src.slice(0, -4) + "_un" + cell.src.slice(-4);
                    //                    this.LastSourceCell = layerCell;
                    //                    return;
                }
                else {//vml
                    //                    cell.childNodes[0].opacity = 1;
                    //                    cell["fillcolor"] = "#A6A600"; //源小区填充色
                }
            }
            this.ShowSign(layerCell);
            this.LastSourceCell = layerCell;
        }
    }
    this.ClearSourceCell = function () {
        if (this.LastSourceCell) {
            var lastCell = document.getElementById(this.LastSourceCell.LayerID + "|" + this.LastSourceCell.ID + "_vFigure");
            if (lastCell) {
                if (lastCell.nodeName == "IMG") {
                    if (lastCell.src.slice(-7, -4) == "_un") {
                        //                        lastCell.src = lastCell.src.slice(0, -7) + lastCell.src.slice(-4);
                        //                        return;
                    }
                }
                else {//vml
                    //                    lastCell.childNodes[0].opacity = this.Layers.layers[this.LastSourceCell.LayerID].opacity;
                    //                    lastCell["fillcolor"] = this.Layers.layers[this.LastSourceCell.LayerID]["fillcolor"];
                }
            }
            this.ClearSign();
        }
    }
    //only one sign in map
    this.ShowSign = function (layerCell) {
        //        cellOutPutAfter.signCellID = layerCell.LayerID + "|" + layerCell.ID; //用于重新输出时生成定位标记
        var id = "map_sign";
        var oldImg = document.getElementById(id);
        if (oldImg && oldImg.cellID == layerCell.LayerID + "|" + layerCell.ID)
            return;
        var img = document.createElement("img");
        img.style.width = "24px";
        img.style.height = "24px";
        img.src = basePath + "Images/local_dw.png";
        var mapcoord = _StaticObj.objGet("map").getPixelInMap({ "lo": layerCell.Longitude, "la": layerCell.Latitude })
        img.id = id;
        img.cellID = layerCell.LayerID + "|" + layerCell.ID;
        img.style.position = "absolute";
        if (layerCell.figure == this.LayerType.Sector) {
            if (Math.abs(layerCell.qj) != 360) {
                img.style.left = mapcoord.x + Math.round(layerCell.r * Math.sin(ConvertRad(layerCell.qj))) / 1.5 - 12;
                img.style.top = mapcoord.y - Math.round(layerCell.r * Math.cos(ConvertRad(layerCell.qj))) / 1.5 - 24;
            }
            else {
                img.style.left = mapcoord.x - 12;
                img.style.top = mapcoord.y - 24;
            }
        }
        else {
            img.style.left = mapcoord.x - 12;
            img.style.top = mapcoord.y - 24;
        }
        img.style.zIndex = "3";
        if (oldImg) {
            // oldImg.parentNode.removeChild(oldImg);
            removeChildSafe(oldImg);
        }
        var outSideLayer = document.getElementById(this.AllLayersOutSideId);
        outSideLayer.appendChild(img);
    }
    this.ClearSign = function () {
        var id = "map_sign";
        var oldImg = document.getElementById(id);
        if (oldImg) {
            // oldImg.parentNode.removeChild(oldImg);
            removeChildSafe(oldImg);
        }
        //        cellOutPutAfter.signCellID = null;
    }
    //同步图层管理器
    this.layerTurnParmaChanged = function (layerID, isTurnOn) {
        var chkLayer = document.getElementById("layersManagement_" + layerID + "_chkIsShow");
        if (chkLayer)
            chkLayer.checked = isTurnOn;
        this.Layers.layers[layerID].getDataParams.isTurnOn = isTurnOn;
    }
    //refurbish SingleLayer
    this.refurbish = function (layerID, isDelete) {
        if (!layerID) {
            var AllLayersOutSide = document.getElementById(this.AllLayersOutSideId);
            if (AllLayersOutSide) {
                //AllLayersOutSide.parentNode.removeChild(AllLayersOutSide);
                //removeChildSafe(AllLayersOutSide);
                this.LastData = {};
                this.RomancedCells = {};
            }
            AllLayersOutSide = null;
            if (!isDelete)
                this.LoadDataToLayerControl();
        }
        else {
            var layerMap = childGetById(this.AllLayersOutSideId, layerID);
            if (layerMap)
                //layerMap.parentNode.removeChild(layerMap);
                removeChildSafe(layerMap);
            this.LastData[layerID] = {};
            this.delRomancedLayer(layerID);
            if (!isDelete) {
                this.SingleLayerDataGet(layerID);
                this.OutPutSingleLayer(layerID, null);
            }
        }
    }
    //refurbish SingleLayer
    this.refurbish_Post = function (SelectedEntity, layerID, isDelete) {
        if (!layerID) {
            var AllLayersOutSide = document.getElementById(this.AllLayersOutSideId);
            if (AllLayersOutSide) {
                //AllLayersOutSide.parentNode.removeChild(AllLayersOutSide);
                //removeChildSafe(AllLayersOutSide);
                this.LastData = {};
                this.RomancedCells = {};
            }
            AllLayersOutSide = null;
            if (!isDelete)
                this.LoadDataToLayerControl_Post(SelectedEntity);
        }
        else {
            var layerMap = childGetById(this.AllLayersOutSideId, layerID);
            if (layerMap)
                //layerMap.parentNode.removeChild(layerMap);
                removeChildSafe(layerMap);
            this.LastData[layerID] = {};
            this.delRomancedLayer(layerID);
            if (!isDelete) {
                this.SingleLayerDataGet(layerID);
                this.OutPutSingleLayer(layerID, null);
            }
        }
    }
    this.layerIDGetbyCompanyName = function (company) { //return array
        var layers = {}; //{"layerID1":true,"layerID2":true}
        for (var layer in this.Layers.layers) {
            if (this.Layers.layers[layer].getDataParams.manufactoryId == company) {
                layers[layer] = true;
            }
        }
        return layers;
    }
    this.clearLastData = function (ths) {
        ths = ths || this;
        ths.LastData = {};
        ths.RomancedCells = {};
    }
    //设置当前在获取的数据次数,必须是0才需要去后台获取数据或者输出数据
    this.setIGetData = function (iGetData, ths) {
        ths = ths || this;
        ths.iGetData = iGetData;
    }
    this.cell_onclick = function (ci, layerID, obj, ev) {//图元单击事件 private
        this.execEventListener("cell_onclick", ci, layerID, obj, ev);
    }
    this.cell_ondblclick = function (ci, layerID, obj, ev) {//图元双击事件 public
        this.execEventListener("cell_ondblclick", ci, layerID, obj, ev);
    }
    this.cell_oncontextmenu = function (ci, layerID, obj, ev) {//图元右击事件 public
        this.execEventListener("cell_oncontextmenu", ci, layerID, obj, ev);
    }
    {//init

        _StaticObj.add(this, this.id);
        //防止多次加载数据与输出图元

        this.map.addEventListener("zoomToLevel_before", this.setIGetData, false, this); //缩放前关闭数据获取
        this.map.data.objMoving.addEventListener("startMove", this.setIGetData, false, this); //拖动前缩放关闭数据获取
        var hawkeye = _StaticObj.objGet("hawkeye");
        if (hawkeye) {
            hawkeye.addEventListener("startMove", this.setIGetData, false, this); //鹰眼拖动前缩放关闭数据获取
            hawkeye.addEventListener("stopMove", this.setIGetData, true, this); //鹰眼拖动后启用数据获取
        }
        this.map.addEventListener("fillBackPicsToDivMap", this.setIGetData, true, this); //填充切片后启用数据获取

        //缩放前 清空已输出数据
        this.map.addEventListener("zoomToLevel_before", this.clearLastData, this);
        ///添加图元单击、双击、右击事件
        function addMouseEvent(ths, obj) {
            ths.CellMouseEvent.addAllEvent(obj);
        }
        function onclick(ths, ev) {
            with (ev.srcElement) {
                ths.cell_onclick(ci, layerID, ev.srcElement, ev);
            }
        }
        function ondblclick(ths, ev) {
            with (ev.srcElement) {
                ths.cell_ondblclick(ci, layerID, ev.srcElement, ev);
            }
        }
        function oncontextmenu(ths, ev) {
            with (ev.srcElement) {
                ths.cell_oncontextmenu(ci, layerID, ev.srcElement, ev);
            }
        }
        this.CellMouseEvent.addEventListener("click", onclick, this); //添加单击事件
        this.CellMouseEvent.addEventListener("dblclick", ondblclick, this); //添加双击事件
        this.CellMouseEvent.addEventListener("contextmenu", oncontextmenu, this); //添加右键事件
        for (var LayerVectorCls_i in this.LayerVectorCls) { //通过图元输出事件给图元添加鼠标事件
            this.LayerVectorCls[LayerVectorCls_i].addEventListener("OutputLayerCell", addMouseEvent, this);
        }
    }
}