function isinarray(element, array) {//返回元素是否在数组中
    for (var i = 0; i < array.length; i++) {
        if (element == array[i]) {
            return true;
        }
    }
    return false;
}

function indeofarray(element, array) {  //返回元素在数组索引
    for (var i = 0; i < array.length; i++) {
        if (element == array[i]) {
            return i;
        }
    }
    return -1;
}
function isUPCall(issi, array) {
    for (var i = 0; i < array.length; i++) {
        if (issi == array[i].ISSI) {
            return true;
        }
    }
    return false;
}

function upgrouparry(gssi, issi, eventtype, drict, calltype) {
    var groupcalltemp = {};
    groupcalltemp.GSSI = gssi;
    groupcalltemp.ISSI = issi;
    groupcalltemp.type = eventtype;
    groupcalltemp.drict = drict;
    if (calltype != undefined) {
        groupcalltemp.calltype = calltype;
    } else {
        groupcalltemp.calltyp = "";
    }
    if (!isUPCall(groupcalltemp.ISSI, useprameters.UPCall)) {
        useprameters.UPCall.push(groupcalltemp); //存入上行呼叫列表
        //添加警员呼叫图标
        addCallStateImgISSI(issi, eventtype, drict);
      //  LayerControl.LoadDataToLayerControl();
    }
}
function getISSIByGssi(Gssi) {
    var issi = "";
    for (var i = 0; i < useprameters.UPCall.length; i++) {
        if (useprameters.UPCall[i].GSSI == Gssi) {
            issi = useprameters.UPCall[i].ISSI;
            break;
        }
    }
    return issi;
}
function delgrouparry(issi) {
    if (!isUPCall(issi, useprameters.UPCall)) {
        return;
    }
    var i = indeofgroup(issi, useprameters.UPCall);
    useprameters.UPCall.splice(i, 1);
    //移除警员上的呼叫图标
    removeCallStateImgISSI(issi);

    //var ul = document.getElementById("bztp_call_" + issi);
    //if (ul) {
    //    removeChildSafe(ul);
    //}
    //呼叫图标
   // LayerControl.LoadDataToLayerControl();
}

function indeofgroup(element, array) {  //返回元素在数组索引
    for (var i = 0; i < array.length; i++) {
        if (element == array[i].ISSI) {
            return i;
        }
    }
}

function getpictype(value, values) {
    for (var i = 0; i < values.length; i++) {
        if (value == values[i].name) {
            return values[i].loc;
        }
    }
}