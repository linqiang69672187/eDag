function searchPolice() {
    newDivFrame("search", document.body, "", GetTextByName("searchPolice", useprameters.languagedata));//多语言:查找警员
    document.getElementById("search_ifr").src = "OpePages/LayerCellSearch.aspx";
    var div = document.getElementById("search");
    div.style.width = "800px";
    div.style.height = "350px";
    divCenter(div);
    ShowDivPage(div);
}
//查询基站定位
LayerControl_clearsign = null;
function thisLocation(param) {
    try {
        if (param.split('|')[0] == "" || param.split('|')[1] == "" || param.split('|')[2] == "" || param.split('|')[3] == "") {
            return
        }
        if (param.split('|')[2] == "0.0000000" || param.split('|')[3] == "0.0000000") {
            alert(GetTextByName("Log_LoLoIsZero", useprameters.languagedata));//多语言:经纬度为(0,0)请检查终端状态
            return;
        }
        //if (LayerControl.LayerCellLocation.apply(null, param.split('|')) == false) {
        //定位警员，移动地图
        if (LayerCellLocation(param) == false) {
            alert(GetTextByName("Alert_PointNotOnMap", useprameters.languagedata));//多语言:你定位的点不在地图范围内
            return;
        }
        else {
            //alert("LayerCellLocation_1");
        }
        //if (LayerControl.LayerControl_clearsign) {    
        //    window.clearInterval(LayerControl.LayerControl_clearsign);
        //    LayerControl.LayerControl_clearsign = null;
        //}
        //if (!LayerControl.LayerControl_clearsign) {
        //    LayerControl.LayerControl_clearsign = setTimeout(LayerControl.ClearSign, 10000);
        //}

        if (param.split('|')[4]) //不刷新search弹出框
            return;
        ShowDivPage("search");
    }
        catch(e){
            alert("thisLocation" + e);
    }
}
theIntervalFun.policePositionRefresh = function () {
    //record last police status
    return;//跳出
    theIntervalFun.lastDataStatus = {};
    var layerID = "Police,0,0";
    if (LayerControl.Data && LayerControl.Data[layerID]) {
        for (var cells = 0; cells < LayerControl.Data[layerID].length; cells++) {
            for (var cellID in LayerControl.Data[layerID][cells]) {
                if (!theIntervalFun.lastDataStatus[cellID]) {
                    theIntervalFun.lastDataStatus[cellID] = {};
                    theIntervalFun.lastDataStatus[cellID].Send_reason = LayerControl.Data[layerID][cells][cellID].Send_reason;
                }
            }
        }
    }
    //Refurbish 
    LayerControl.refurbish();
}
//点信息
function showCIMessage(ci, layerId) {
    newDivFrame("ciInfo", document.body, "", GetTextByName("PoliceInfo", useprameters.languagedata));//多语言:警员信息
   
    document.getElementById("ciInfo_ifr").src = "OpePages/CIInfoGet.aspx?ci=" + ci;
    var div = document.getElementById("ciInfo");
    div.style.width = "280px";
    div.style.height = "280px";
    div.style.display = "none";
    ShowDivPage(div, true);
}
var isChangeMap_back = true;
function makeIsChangeMap_back() {
    isChangeMap_back = true;
}
function changeMap_back() {
    if (!isChangeMap_back)
        return;
    //data
    var array = new Array();
    var temp1 = {};
    temp1[0] = function (arg) {
        command.exec("maptype", arg);
    };
    temp1[1] = 0; //arg
    temp1[2] = GetTextByName("Lang_CommonMap", useprameters.languagedata); //name  多语言:普通地图
    array.push(temp1);
    var temp2 = {};
    temp2[0] = function (arg) {
        command.exec("maptype", arg);
    };
    temp2[1] = 1;
    temp2[2] = GetTextByName("Lang_SetelateMap", useprameters.languagedata);//多语言:卫星地图
    array.push(temp2);
    //show
    var obj = createMenu(array);
    obj.style.left = event.x;
    obj.style.top = event.y;
    document.body.appendChild(obj);
};
//isShow 开启关闭参数
function isPoliceInfoShow(isShow) {
    return;
    var layerId = "Police,0,0";
    var layerMap = childGetById(layerId, layerId + '_InfoShow');
    LayerControl.Layers.layers[layerId]['funNames']['InfoShow'] = isShow == true ? true : false;
    if (isShow && LayerControl.Layers.layers[layerId]['getDataParams'].isTurnOn) {
        LayerControl.OutPutSingleLayer(layerId, "InfoShow");
    }
    if (layerMap && !isShow) {
        //庞小斌修改，更改节点移除方法
        removeChildSafe(layerMap);
    }
}
//取消轨迹回放
//id 轨迹ID
function trajectoryPlaybackCancel(id) {
    if (zoomAfter.ids)
        zoomAfter.ids[id] = null;
    if (zoomAfter.datas)
        zoomAfter.datas[id] = null;
    var obj = document.getElementById(id);
    if (obj)
        //庞小斌修改，更改节点移除方法
        removeChildSafe(obj);
}

function onload_Tools1() {
    LayerControl.addEventListener("cellOncontextmenu", showRightMenu);
    function showRightMenu(ci, layerId) {
        function initRightMenu_data(ci, layerId) {
            var array = new Array();
            var temp1 = {};
            temp1[0] = function (arg) { showCIMessage(arg.split('|')[0], arg.split('|')[1]) }; //fun
            temp1[1] = ci + "|" + layerId; //arg
            temp1[2] = GetTextByName("Lang_PointInformation", useprameters.languagedata); //name 多语言:点信息
            array.push(temp1);
            isChangeMap_back = false;
            setTimeout(makeIsChangeMap_back, 100);
            return array;
        }
        if (!ToolsData.rightClick.poi) { return; } //the poi is not changed
        //show
        var obj = createMenu(initRightMenu_data(ci, layerId));
        if (obj) {
            obj.style.left = event.x;
            obj.style.top = event.y;
            document.body.appendChild(obj);
        }
    }
}