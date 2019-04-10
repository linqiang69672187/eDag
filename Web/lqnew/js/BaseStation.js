//存放基站信息列表
var AllBaseStationArray = new Array();
var addID = 10000;
var BSSelectID = "";
var haveCallSissi = new Array(); //基站呼叫图标数组 
function changetype(id) {
    try {
        useprameters.rightselecttype = "basestation";
        BSSelectID = id;
    } catch (err) {
        writeLog("system", "BaseStation.js changetype，error info:" + err);
    }
}
var isCall = false; //用来标记基站是否是已呼叫状态
//鼠标按下去事件
var picMouseDown = function (sissi) {
    try {
        if (useprameters.callActivexable == false) {
            return;
        }
        if (isPanalBSCall) {
            return;
        }
        if (!isCall) {
            startSBCall(sissi); //是第一次的话调用基站呼叫
            isCall = true;
        }
        var picdiv = document.getElementById("PICDIV_" + sissi);
        if (picdiv) {
            picdiv.innerHTML = "<img style='width:50px;heigth:30px;cursor:pointer' onmousedown='picMouseDown(\"" + sissi + "\")' onmouseup='picMouseUp(\"" + sissi + "\")' onmouseout='picMouseUp(\"" + sissi + "\")' src='" + GetTextByName("Lang_ImgBtn_BaseStationCall_UN", useprameters.languagedata) + "' />";
        }
    } catch (err) {
        writeLog("system", "BaseStation.js picMouseDown，error info:" + err);
    }
}
//鼠标离开事件
var picMouseUp = function (sissi) {
    try {
        if (isPanalBSCall) {
            //操作窗口中存在基站组在广播
            return;
        }
        endSBCall(sissi);
        isCall = false;
        var picdiv = document.getElementById("PICDIV_" + sissi);
        if (picdiv) {
            picdiv.innerHTML = "<img style='width:50px;heigth:30px;cursor:pointer' onmousedown='picMouseDown(\"" + sissi + "\")' onmouseup='picMouseUp(\"" + sissi + "\")' src='" + GetTextByName("Lang_ImgBtn_BaseStationCall", useprameters.languagedata) + "' />";
        }
    } catch (err) {
        writeLog("system", "BaseStation.js picMouseUp，error info:" + err);
    }
}
//单击基站 显示基站呼叫图标
var PicClick = function (x, y, sissi) {
    try {
        if (isPanalBSCall) {
            return;
        }
        if (useprameters.callActivexable == false) {
            return;
        }
        var picdiv = document.getElementById("PICDIV_" + sissi);
        if (picdiv) return;
        var mapdiv = document.getElementById("map");
        var mydiv = document.createElement("div");
        mydiv.id = "PICDIV_" + sissi;
        mydiv.style.position = "absolute";
        mydiv.style.zIndex = 1;
        mydiv.style.top = y;
        mydiv.style.left = x;
        mydiv.innerHTML = "<img style='width:50px;heigth:30px;cursor:pointer' onmousedown='picMouseDown(\"" + sissi + "\")' onmouseup='picMouseUp(\"" + sissi + "\")' onmouseout='picMouseUp(\"" + sissi + "\")' src='" + GetTextByName("Lang_ImgBtn_BaseStationCall", useprameters.languagedata) + "' />";
        mapdiv.appendChild(mydiv);

        for (var myi in haveCallSissi) {
            var myhcs = document.getElementById("PICDIV_" + haveCallSissi[myi]);
            if (myhcs) {
                removeChildSafe(myhcs);
            }
        }
        haveCallSissi.length = 0;
        haveCallSissi.push(sissi);
    } catch (err) {
        writeLog("system", "BaseStation.js PicClick，error info:" + err);
    }
}
//删除基站呼叫图标
var delCallIon = function () {
    try {
        if (haveCallSissi != null && haveCallSissi != undefined && haveCallSissi.length > 0) {
            for (var myi in haveCallSissi) {
                var myhcs = document.getElementById("PICDIV_" + haveCallSissi[myi]);
                if (myhcs) {
                    removeChildSafe(myhcs);
                }
            }
            haveCallSissi.length = 0;
        }
    } catch (err) {
        writeLog("system", "BaseStation.js delCallIon，error info:" + err);
    }
}
//画基站
var CreateBaseStation = function (BSID, ID, La, Lo, names, sissi) {
    try {
        var myP = document.getElementById("BaseStation_" + ID);
        if (myP)/**@如果要画的对象已经存在，则不再重画*/
            return;
        //庞小斌修改，将基站放在一个统一的div中
        var mapdiv = document.getElementById("map");
        var basestationdiv = document.getElementById("BaseStation");
        if (!basestationdiv) {
            basestationdiv = document.createElement("div");
            mapdiv.appendChild(basestationdiv);
            basestationdiv.id = "BaseStation";
            basestationdiv.style.zIndex = "-1";
        }
        var divTrajectory = document.createElement("div");
        basestationdiv.appendChild(divTrajectory);
        divTrajectory.id = "BaseStation_" + ID;
        divTrajectory.style.position = "absolute";
        divTrajectory.style.zIndex = 1;

        var map = _StaticObj.objGet("map");
        if (map == null) return;
        var mapcoord = map.getPixelInMap({ lo: Lo, la: La });
        divTrajectory.style.top = mapcoord.y - 15;
        divTrajectory.style.left = mapcoord.x - 15;
        var widthlevel = map.data.currentLevel;
        var gbleft = mapcoord.x + 1.5 * widthlevel;
        var gbtop = mapcoord.y - 30;

        divTrajectory.title = names;
        divTrajectory.style.width = widthlevel * 4 + "px";
        divTrajectory.style.height = widthlevel * 8 + "px";
        divTrajectory.style.cursor = "pointer";
        divTrajectory.onclick = function(){
                PicClick(gbleft,gbtop ,sissi);
        }
        divTrajectory.oncontextmenu = function () {
            changetype(BSID);
        }
        if (widthlevel > 2 && widthlevel < 5) {
            //divTrajectory.innerHTML = "<img title='" + names + "' style='width:" + widthlevel * 4 + "px;cursor:pointer' onclick='PicClick(\"" + gbleft + "\",\"" + gbtop + "\",\"" + sissi + "\")' oncontextmenu='changetype(\"" + BSID + "\");'  src='Images/BaseStation.png' />";
            //庞小斌修改，用背景显示单位图片
            divTrajectory.style.backgroundImage = "url(Images/BaseStation/" + LayerControl.map.data.currentLevel + "/BaseStation.png)";
            divTrajectory.style.backgroundRepeat = "no-repeat";
        } else
            if (widthlevel >= 5) {
                //divTrajectory.innerHTML = "<img title='" + names + "' style='width:" + widthlevel * 4 + "px;cursor:pointer' onclick='PicClick(\"" + gbleft + "\",\"" + gbtop + "\",\"" + sissi + "\")' oncontextmenu='changetype(\"" + BSID + "\");' oncontextmenu='changetype(\"" + BSID + "\");'     src='Images/BaseStation.png' />";
                if (widthlevel > 10) {
                    divTrajectory.style.backgroundImage = "url(Images/BaseStation/10" + "/BaseStation.png)";
                }
                else {
                    divTrajectory.style.backgroundImage = "url(Images/BaseStation/" + LayerControl.map.data.currentLevel + "/BaseStation.png)";
                }
                divTrajectory.style.backgroundRepeat = "no-repeat";
            }
    } catch (err) {
        writeLog("system", "BaseStation.js CreateBaseStation，error info:" + err);
    }
}
//删除基站
var DeleteBaseStation = function (ID) {
    var mainSWF = document.getElementById("main");
    if (mainSWF) {
        mainSWF.removeBaseStationFromBSLayer(ID);
    }
    //try {
    //    var myStroke = document.getElementById("BaseStation_" + ID);
    //    if (myStroke) {
    //        //庞小斌，更改移除节点方式
    //        removeChildSafe(myStroke);
    //        RemoveFromAllBaseStationArray(ID);
    //    }
    //} catch (err) {
    //    writeLog("system", "BaseStation.js DeleteBaseStation，error info:" + err);
    //}
}
var RemoveFromAllBaseStationArray = function (ID) {
    try {
        var newAllBaseStationPoint = new Array();
        for (var op in AllBaseStationArray) {
            if (AllBaseStationArray[op].divid != ID) {
                newAllBaseStationPoint.push(AllBaseStationArray[op]);
            }
        }
        AllBaseStationArray.length = 0;
        for (var pp in newAllBaseStationPoint) {
            AllBaseStationArray.push(newAllBaseStationPoint[pp]);
        }
    } catch (err) {
        writeLog("system", "BaseStation.js RemoveFromAllBaseStationArray，error info:" + err);
    }
}
//修改基站信息
var UpdateBaseStation = function (BSID, ID, La, Lo, names, sissi) {
    var mainSWF = document.getElementById("main");
    if (mainSWF) {
        mainSWF.removeBaseStationFromBSLayer(ID);
        mainSWF.addBaseStationToLayerForJS(names,ID, parseFloat(Lo), parseFloat(La));
    }
    //try {
    //    DeleteBaseStation(ID);
    //    CreateBaseStation(BSID, ID, La, Lo, names, sissi);
    //    AllBaseStationArray.push({ bsid: BSID, bsname: names, lo: Lo, la: La, divid: ID, sissi: sissi });
    //    delCallIon();
    //} catch (err) {
    //    writeLog("system", "BaseStation.js UpdateBaseStation，error info:" + err);
    //}
}
var AddBaseStation = function (ID, La, Lo, names, sissi) {
    var mainSWF = document.getElementById("main");
    if (mainSWF) {
        mainSWF.addBaseStationToLayerForJS(names,ID, parseFloat(Lo), parseFloat(La));
    }
    //try {
    //    $.ajax({
    //        type: "POST",
    //        url: "Handlers/GetBaseStationIDByDivID.ashx",
    //        data: "divid=" + ID,
    //        success: function (msg) {

    //            var a = eval(msg);
    //            CreateBaseStation(a[0].bsid, ID, La, Lo, names, sissi);
    //            AllBaseStationArray.push({ bsid: a[0].bsid, bsname: names, lo: Lo, la: La, divid: ID, sissi: sissi });
    //        }
    //    })
    //} catch (err) {
    //    writeLog("system", "BaseStation.js AddBaseStation，error info:" + err);
    //}

}

//获取基站信息
var GetBaseStation = function () {
    try {
        getNewData_ajaxStock("Handlers/GetAllBaseStation.ashx", "", function (msg) {
            if (msg) {

                var myarray = new Array();
                myarray = eval(msg);
                for (var p in myarray) {
                    AllBaseStationArray.push({ bsid: myarray[p].ID, bsname: myarray[p].StationName, lo: myarray[p].Lo, la: myarray[p].La, divid: myarray[p].DivID, sissi: myarray[p].StationISSI });
                    CreateBaseStation(myarray[p].ID, myarray[p].DivID, myarray[p].La, myarray[p].Lo, myarray[p].StationName, myarray[p].StationISSI);
                }
            }
        })
    } catch (err) {
        writeLog("system", "BaseStation.js GetBaseStation，error info:" + err);
    }
}