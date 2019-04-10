//缩放操作工具父类
function ZoomTool(map) {
    this.data = {
        map: map,
        iTurnOn: false,
        draw: new Draw(map)
    }
    //开关缩放工具
    this.switchZoom = function (iOn) {
        this.data.iTurnOn = iOn;
        if (iOn) {
            this.data.draw.turnOnDraw("rectangle");
            this.data.draw.addEventListener("getRectRange", this.zoom, this);
        }
        else {
            this.data.draw.turnOffDraw("rectangle");
            this.data.draw.removeEventListener("getRectRange", this.zoom);
            //删除地图移动事件，再此onmousedown会再添加 
            this.data.map.data.objMoving.remove_mouseMove_mouseupEvent();
        }
    }
    //缩放级别并定位接口
    this.zoom = function () {
    }
    //定位
    this.location = function (range) {
        var latLng = {
            lo: (range.latLng.minLo + range.latLng.maxLo) / 2,
            la: (range.latLng.minLa + range.latLng.maxLa) / 2
        };
        this.data.map.moveTo(latLng);
        $("#zoomin").attr("src", "Images/ToolBar/rightbg/zoomin.png"); //林强修改
        $("#zoomout").attr("src", "Images/ToolBar/rightbg/zoomout.png"); //林强修改
    }
    this.location2 = function (lo, la) {

        writeLog("system", lo + "|" + la);
        this.data.map.moveTo({ lo: lo, la: la });

        $("#zoomin").attr("src", "Images/ToolBar/rightbg/zoomin.png"); //林强修改
        $("#zoomout").attr("src", "Images/ToolBar/rightbg/zoomout.png"); //林强修改
    }
}
//放大操作工具
function ZoomInTool(map) {
    ZoomTool.call(this, map);
    this.zoom = function (ths, range) {
        with (ths.data.map) {
            //zoomEvent
            if (map.data.currentLevel < 9) {//林强
                zoomToLevel(data.currentLevel + 2); //林强
            }
            else {
                zoomToLevel(10); //林强
            }
            //需对拉框放大后范围进行校验

            if (range.latLng.minLo > hz_map_region.RDLng || range.latLng.maxLo < hz_map_region.minLng || range.latLng.minLa > hz_map_region.maxLat || range.latLng.maxLa < hz_map_region.RDLat) {
                writeLog("system", GetTextByName("Text_YouZoonRangNotInMapSysAutoTheCenterOfMap", useprameters.languagedata));//多语言 你放大的点在地图范围外，系统将自动给你跳转到地图中心点

                ths.location2((parseFloat(hz_map_region.RDLng) + parseFloat(hz_map_region.minLng)) / 2, (parseFloat(hz_map_region.maxLat) + parseFloat(hz_map_region.RDLat)) / 2);
            } else {
                //location
                ths.location(range);

            }
            _StaticObj.objGet("ZoomInTool").switchZoom(false); //林强修改
        }
    }
    {//init
        _StaticObj.add(this, "ZoomInTool");
    }
}
//缩小操作工具
function ZoomOutTool(map) {
    ZoomTool.call(this, map);
    this.zoom = function (ths, range) {
        with (ths.data.map) {

            //zoomEvent
            if (map.data.currentLevel > 2) {//林强
                zoomToLevel(data.currentLevel - 2); //林强
            }
            else {//林强
                zoomToLevel(data.currentLevel - 1); //林强
            }
      
            //location
            ths.location(range);
            _StaticObj.objGet("ZoomOutTool").switchZoom(false); //林强修改


        }
    }
    {//init
        _StaticObj.add(this, "ZoomOutTool");
    }
}