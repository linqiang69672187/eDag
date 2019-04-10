var tools = new Tools();
function Tools(data) {
    this.data = data;
    this.toolDataInit; //fun
    this.init = function () {
        this.move(document.getElementById('move'));
    },
    this.move = function (obj) {
        document.getElementById(LayerControl.map.data.mapDiv.id).style.cursor = this.click(obj) == true ? "move" : "default";
    },
    this.zoomin = function (obj) {
        document.getElementById(LayerControl.map.data.mapDiv.id).style.cursor = this.click(obj) == true ? "crosshair" : "default";
    },
    this.zoomout = function (obj) {
        document.getElementById(LayerControl.map.data.mapDiv.id).style.cursor = this.click(obj) == true ? "crosshair" : "default";
    },
    this.countdis = function (obj) {
        document.getElementById(LayerControl.map.data.mapDiv.id).style.cursor = this.click(obj) == true ? "default" : "default";
    },
    this.longLatInfo = function (obj) {
        document.getElementById(LayerControl.map.data.mapDiv.id).style.cursor = this.click(obj) == true ? "default" : "default";
    },
    this.poi = function (obj) {
       // document.getElementById(LayerControl.map.data.mapDiv.id).style.cursor = this.click(obj) == true ? "default" : "default";
    },
    //private
    this.click = function (obj) {
        if (typeof (obj) == "string")
        { obj = document.getElementById(obj); }
        if (obj) {
            if (obj.src.indexOf('_un') == -1) {//click down
                this.downObj(obj);
                return true;
            }
            else {//click up
                this.upObj(obj);
                return false;
            }
        }
    },
    this.upObj = function (obj) {
        obj.src = obj.src.slice(0, -7) + obj.src.slice(-4); //set current obj img up
        this.data[obj.event_type][obj.id] = false; //set current obj down false
        this.data[obj.event_type].lastClickObjID = null; //set lastobj id null
    },
    this.downObj = function (obj) {
        obj.src = obj.src.slice(0, -4) + '_un' + obj.src.slice(-4); //set current obj img down
        this.data[obj.event_type][obj.id] = true; //set current obj down true
        var _lastClickObjID = this.data[obj.event_type].lastClickObjID;
        if (_lastClickObjID) {
            var _lastClickObj = document.getElementById(_lastClickObjID);
            _lastClickObj.src = _lastClickObj.src.slice(0, -7) + _lastClickObj.src.slice(-4); //set last obj img up
            this.data[obj.event_type][_lastClickObjID] = false; //set last obj down false
        }
        this.data[obj.event_type].lastClickObjID = obj.id; //set lastobj id
    }
}
tools.data = ToolsData = {
    "onmousedown_drag": { "lastClickObjID": null, "move": true, "zoomin": false, "zoomout": false }, //move=id onmousedown_drag=event_type
    "doubleClick": { "lastClickObjID": null, "longLatInfo": false, "countdis": false },
    "click": { "lastClickObjID": null, "switchAnalyze": false, "ciSingleFre": false, "checkOut": false, "checkIn": false },
    "rightClick": { "poi": false }
}
window.addEventListener("onload", toolInit);
function toolInit() {
    tools.poi(document.getElementById('poi'));
}