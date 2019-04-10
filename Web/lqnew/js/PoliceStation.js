var AllPoliceStaionArray = new Array();
//添加单位
var AddPoliceStation = function (DivID, La, Lo, names, picurl) {
    var mainSWF = document.getElementById("main");
    if (mainSWF) {
        mainSWF.addUnitToLayerForJs(names,DivID, picurl, parseFloat(Lo), parseFloat(La));
    }
    //try {
    //    $.ajax({
    //        type: "POST",
    //        url: "Handlers/GetPoliceStationIdByDivID_Handler.ashx",
    //        data: "divid=" + DivID,
    //        success: function (msg) {
    //            var a = eval(msg);
    //            CreatePoliceStation(msg, DivID, La, Lo, names, picurl);
    //            AllPoliceStaionArray.push({ psid: msg, psname: names, lo: Lo, la: La, divid: DivID, picurl: picurl });
    //        }
    //    })
    //} catch (err) {
    //    writeLog("system", "PoliceStation.js AddPoliceStation，error info:" + err);
    //}
}

//修改单位信息
var UpdatePoliceStation = function (ID, DivID, La, Lo, names, picurl) {
    var mainSWF = document.getElementById("main");
    if (mainSWF) {
        mainSWF.removeUnitFromUnitLayer(DivID);
        mainSWF.addUnitToLayerForJs(names,DivID, picurl, parseFloat(Lo), parseFloat(La));
    }
    //try {
    //    DeletePoliceStation(DivID);
    //    CreatePoliceStation(ID, DivID, La, Lo, names, picurl);
    //    AllPoliceStaionArray.push({ psid: ID, psname: names, lo: Lo, la: La, divid: DivID, picurl: picurl });
    //} catch (err) {
    //    writeLog("system", "PoliceStation.js UpdatePoliceStation，error info:" + err);
    //}
}

//删除单位
var DeletePoliceStation = function (DivID) {
    var mainSWF = document.getElementById("main");
    if (mainSWF) {
        mainSWF.removeUnitFromUnitLayer(DivID);
    }
    //try {
    //    var myStroke = document.getElementById("PoliceStation_" + DivID);
    //    if (myStroke) {
    //        //庞小斌，更改移除节点方式
    //        removeChildSafe(myStroke);
    //        RemoveFromAllPoliceStationArray(DivID);
    //    }
    //} catch (err) {
    //    writeLog("system", "PoliceStation.js DeletePoliceStation,error info:" + err);
    //}
}
//将单位重数组中移除
var RemoveFromAllPoliceStationArray = function (DivID) {
    try {
        var newAllPoliceStationPoint = new Array();
        for (var op in AllPoliceStaionArray) {
            if (AllPoliceStaionArray[op].divid != DivID) {
                newAllPoliceStationPoint.push(AllPoliceStaionArray[op]);
            }
        }
        AllPoliceStaionArray.length = 0;
        for (var pp in newAllPoliceStationPoint) {
            AllPoliceStaionArray.push(newAllPoliceStationPoint[pp]);
        }
    } catch (err) {
        writeLog("system", "PoliceStation.js RemoveFromAllPoliceStationArray,error info:" + err);
    }
}

//画单位
var CreatePoliceStation = function (PSID, DivID, La, Lo, names, picurl) {
    try {
        var myP = document.getElementById("PoliceStation_" + DivID);
        if (myP)/**@如果要画的对象已经存在，则不再重画*/
            return;
        var mapdiv = document.getElementById("map");
        //庞小斌修改，将单位放在一个统一的policestation div中
        var mapdiv = document.getElementById("map");
        var policestationdiv = document.getElementById("PoliceStation");
        if (!policestationdiv) {
            policestationdiv = document.createElement("div");
            mapdiv.appendChild(policestationdiv);
            policestationdiv.id = "PoliceStation";
        }
        var divTrajectory = document.createElement("div");
        policestationdiv.appendChild(divTrajectory);
        divTrajectory.id = "PoliceStation_" + DivID;
        divTrajectory.style.position = "absolute";
        divTrajectory.style.zIndex = 1;
        divTrajectory.title = names;
        var map = _StaticObj.objGet("map");
        if (map == null) return;
        var mapcoord = map.getPixelInMap({ lo: Lo, la: La });
        divTrajectory.style.top = mapcoord.y - 15;
        divTrajectory.style.left = mapcoord.x - 15;
        divTrajectory.style.cursor = "pointer";
        divTrajectory.ondblclick = function (){
                window.mycallfunction("view_info/viewpage",434, 240,PSID);
            }
        var widthlevel = map.data.currentLevel;
        var picpath = picurl.substr(0,picurl.lastIndexOf("/"));
        var filename = picurl.substring(picurl.lastIndexOf("/") + 1);
        if (widthlevel > 2 && widthlevel < 5) {
            divTrajectory.style.width = widthlevel * 4;
            divTrajectory.style.height = widthlevel * 4;
            //divTrajectory.innerHTML = "<img title='" + names + "' style='width:" + widthlevel * 3 + "px;cursor:pointer'  ondblclick='window.mycallfunction(\"view_info/viewpage\",434, 240,\"" + PSID + "\")'    src='" + picurl + "?p=" + GetRandomNum(1, 1000000) + "' />";
            //庞小斌修改，用背景显示单位图片
            divTrajectory.style.backgroundImage = "url("+picpath + "/" + LayerControl.map.data.currentLevel + "/" + filename +")";
            divTrajectory.style.backgroundRepeat = "no-repeat";
        }
        else
            if (widthlevel >= 5) {
                divTrajectory.style.width = widthlevel * 4;
                divTrajectory.style.height = widthlevel * 4;
                //divTrajectory.innerHTML = "<img title='" + names + "' style='width:" + widthlevel * 3 + "px;cursor:pointer'  ondblclick='window.mycallfunction(\"view_info/viewpage\",434, 240,\"" + PSID + "\")'    src='" + picurl + "?p=" + GetRandomNum(1, 1000000) + "' />";
                //庞小斌修改，用背景显示单位图片
                if (widthlevel > 10) {
                    divTrajectory.style.backgroundImage = "url(" + picpath + "/10" + "/" + filename + ")";
                }
                else {
                    divTrajectory.style.backgroundImage = "url(" + picpath + "/" + LayerControl.map.data.currentLevel + "/" + filename + ")";

                }
                divTrajectory.style.backgroundRepeat = "no-repeat";
            }
    } catch (err) {
        writeLog("system", "PoliceStation.js CreatePoliceStation，error info:" + err);
    }
}

//获取单位信息
var GetPoliceStation = function () {
    try {
        jquerygetNewData_ajax("Handlers/GetAllPoliceStation.ashx", {}, function (msg) {
            
            var myarray = new Array();
            myarray = eval(msg);
            for (var p in myarray) {
                AllPoliceStaionArray.push({ psid: myarray[p].ID, psname: myarray[p].policename, lo: myarray[p].Lo, la: myarray[p].La, divid: myarray[p].DivID, picurl: myarray[p].picurl });
                CreatePoliceStation(myarray[p].ID, myarray[p].DivID, myarray[p].La, myarray[p].Lo, myarray[p].policename, myarray[p].picurl);
            }
        });
        //$.ajax({
        //    type: "POST",
        //    url: "Handlers/GetAllPoliceStation.ashx",
        //    data: "",
        //    success: function (msg) {
        //        var myarray = new Array();
        //        myarray = eval(msg);
        //        for (var p in myarray) {
        //            AllPoliceStaionArray.push({ psid: myarray[p].ID, psname: myarray[p].policename, lo: myarray[p].Lo, la: myarray[p].La, divid: myarray[p].DivID, picurl: myarray[p].picurl });
        //            CreatePoliceStation(myarray[p].ID, myarray[p].DivID, myarray[p].La, myarray[p].Lo, myarray[p].policename, myarray[p].picurl);
        //        }
        //    }
        //});
    } catch (err) {
        writeLog("system", "PoliceStation.js GetPoliceStation，error info:" + err);
    }
}