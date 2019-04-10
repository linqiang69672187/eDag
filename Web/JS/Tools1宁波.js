function showSearhPage() {
    newDivFrame("search", document.body, "", "小区查找");
    document.getElementById("search_ifr").src = "OpePages/LayerCellSearch.aspx";
    var div = document.getElementById("search");
    div.style.width = "800px";
    div.style.height = "350px";
    divCenter(div);
    ShowDivPage(div);
}
//查询基站定位
function thisLocation(param) {
    LayerControl.LayerCellLocation.apply(null, param.split('|'));
    if (LayerControl.LayerControl_clearsign) {
        window.clearInterval(LayerControl.LayerControl_clearsign);
        LayerControl.LayerControl_clearsign = null;
    }
    if (!LayerControl.LayerControl_clearsign) {
        LayerControl.LayerControl_clearsign = setTimeout(LayerControl.ClearSign, 5000);
    }
    ShowDivPage("search");
}
function showKpi() {
    newDivFrame("kpi", document.body, "OpePages/KpiThemeStettings.aspx", "性能渲染");
    var div = document.getElementById("kpi");
    div.style.width = "380px";
    div.style.height = "420px";
    ShowDivPage(div, true);
}
//频率规划
function progra_onchange(id) {
    addDelegate(cancelOtherSingleChoose, id);
    if (document.getElementById(id).checked) {
        switch (document.getElementById(id).value) {
            case "single":
                $("map_" + LayerControl.mapModel.getId()).style.cursor = "move";
                newDivFrame("single", document.body, "", "单频点检查");
                document.getElementById("single_ifr").src = "OpePages/Single.aspx";
                var div = document.getElementById("single");
                div.style.width = "370px";
                div.style.height = "45px";
                divCenter(div);
                div.style.display = "";
                break;
            case "ci":
                $("map_" + LayerControl.mapModel.getId()).style.cursor = "default";
                cellOnclick.funName = "showCISameLP";
                break;
            case "checkOut":
                $("map_" + LayerControl.mapModel.getId()).style.cursor = "default";
                cellOnclick.funName = "CIcheckOut";
                break;
            case "checkIn":
                $("map_" + LayerControl.mapModel.getId()).style.cursor = "default";
                cellOnclick.funName = "CIcheckIn";
                break;
        }
    }
}
function ToolOnload() {
    //显示小区同邻频页面
    cellOnclick.showCISameLP = function (ci, layerID) {
        if (cellOnclick.funName != "showCISameLP") return;
        newDivFrame("CISameLP", document.body, "OpePages/CISameLP.aspx", "小区同邻频");
        var div = document.getElementById("CISameLP");
        div.style.display = "none";
        div.style.width = "170px";
        div.style.height = "160px";
        document.getElementById("CISameLP_ifr").src = "OpePages/CISameLP.aspx?ci=" + ci + "&layerID=" + layerID;
        ShowDivPage(div, true);
    }
    cellOnclick.CIcheckOut = function (ci, layerID) {
        if (cellOnclick.funName != "CIcheckOut") return;
        jquerygetNewData_ajax("OpePages/CIcheckOut.aspx", "ci=" + ci + "&layerID=" + layerID, function (request) {
            LayerControl.SetSourceCell(LayerControl.CellGet(layerID, ci));
            window.prograSingle(request.responseText);
        });
        var cutData =
            {
                "red": "邻小区",
                "#A6A600": "源小区"
            }
        window.newDivCutline(cutData, "切出");
    }
    cellOnclick.CIcheckIn = function (ci, layerID) {
        if (cellOnclick.funName != "CIcheckIn") return;
        jquerygetNewData_ajax("OpePages/CIcheckIn.aspx", "ci=" + ci + "&layerID=" + layerID, function (request) {
            LayerControl.SetSourceCell(LayerControl.CellGet(layerID, ci));
            window.prograSingle(request.responseText);
        });
        var cutData =
            {
                "purple": "切入小区",
                "#A6A600": "源小区"
            }
        window.newDivCutline(cutData, "切入");
    }
    cellOnclick.SwitchAnalyze = function (ci, layerID) {
        if (cellOnclick.funName != "SwitchAnalyze") return;
        jquerygetNewData_ajax("OpePages/SwitchAnalyze.aspx", "CI=" + ci + "&layerID=" + layerID + "&ddlCompany=" + window.frames["SwitchAnalyze_ifr"].ddlCompany() + "&ddlSwitchAnalyzeType=" + window.frames["SwitchAnalyze_ifr"].ddlKpiType() + "&data=" + window.frames["SwitchAnalyze_ifr"].data() + "&hour=" + window.frames["SwitchAnalyze_ifr"].hour(), function (request) {
            if (!request.responseText)
                return;
            if (LayerControl.RomanceElements.SwitchAnalyze)
                LayerControl.romanceEleCancle("SwitchAnalyze");
            LayerControl.SetSourceCell(LayerControl.CellGet(layerID, ci));
            LayerControl.RomanceElements.SwitchAnalyze = {};
            LayerControl.RomanceElements.SwitchAnalyze.coverType = new_cover;
            LayerControl.RomanceElements.SwitchAnalyze.cells = jsonParse(request.responseText);
            LayerControl.romEleRomance("SwitchAnalyze");
        });
    }
    //SwitchAnalyze Romance
    function new_cover(cell_rom, layerID, cellID, isCancle) {
        var cellID_map = layerID + '|' + cellID + '_vFigure';
        var cell = document.getElementById(cellID_map);
        if (isCancle) {
            for (var romProperty in cell_rom) {
                var romProperyValue = cell_rom[romProperty];
                switch (romProperty) {
                    case "opacity":
                        cell.childNodes[0].opacity = LayerControl.Layers.layers[layerID].opacity;
                        break;
                    case "value":
                        var node_SwitchAnalyze = document.getElementById(cellID_map + "_SwitchAnalyze");
                        node_SwitchAnalyze.parentNode.removeChild(node_SwitchAnalyze);
                    default:
                        document.getElementById(cellID_map)[romProperty] = LayerControl.Layers.layers[layerID][romProperty];
                        break;
                }
            }
            document.getElementById(layerID).appendChild(cell);
            return;
        }
        var layerCell = LayerControl.CellGet(layerID, cellID);
        var replaceLayerID = "Rom_transfer_SwitchAnalyze";
        var replaceLayer = document.getElementById(replaceLayerID);
        if (!replaceLayer) {
            replaceLayer = document.createElement("div");
            replaceLayer.id = replaceLayerID;
            replaceLayer.style.position = "absolute";
            replaceLayer.style.zIndex = LayerControl.zIndexMax;
            document.getElementById(LayerControl.AllLayersOutSideId).appendChild(replaceLayer);
        }
        for (var romProperty in cell_rom) {
            var romProperyValue = cell_rom[romProperty];
            switch (romProperty) {
                case "opacity":
                    cell.childNodes[0].opacity = romProperyValue;
                    break;
                case "value":
                    var coord = new Coordinate(layerCell.Longitude, layerCell.Latitude);
                    var mapcoord = coord.getMapCoord(coord);
                    layerCell.x = mapcoord.x;
                    layerCell.y = mapcoord.y;
                    var x = layerCell.x;
                    var y = layerCell.y;
                    var r = layerCell.r;

                    var lx = x + Math.round(1.5 * r * Math.sin(ConvertRad(layerCell.qj))) / 1.2 - layerCell.ID.length * 2;
                    var ly = y - Math.round(1.5 * r * Math.cos(ConvertRad(layerCell.qj))) / 1.2 - layerCell.ID.length * 2;

                    var word = document.createElement('div');
                    word.id = cellID_map + "_SwitchAnalyze";
                    word.style.left = lx;
                    word.style.top = ly;
                    word.style.position = "absolute";
                    word.style.color = "red";
                    word.style.fontSize = 13;
                    word.style.zIndex = LayerControl.zIndexMax + 1;
                    word.style.filter = vml_word_filter;
                    word.style.fontWeight = "lighter";
                    word.innerHTML = romProperyValue;
                    replaceLayer.appendChild(word);
                    break;
                default:
                    cell[romProperty] = romProperyValue;
                    break;
            }
        }
        replaceLayer.appendChild(cell);
    }
}
//频率规划-单频检查 也可用于频率规划其它渲染
function prograSingle(romEleCells) {
    if (!romEleCells)
        return;
    if (LayerControl.RomanceElements.progra)
        LayerControl.romanceEleCancle("progra");
    LayerControl.RomanceElements.progra = {};
    LayerControl.RomanceElements.progra.coverType = "transfer";
    LayerControl.RomanceElements.progra.cells = jsonParse(romEleCells);
    LayerControl.romEleRomance("progra");
}
function closePrograWindows() {
    if (document.getElementById("CISameLP"))
        document.getElementById("CISameLP").style.display = "none";
    if (document.getElementById("single"))
        document.getElementById("single").style.display = "none";
}
function cancelOther(obj_id, selValue) {
    var rdo_len = document.getElementById(obj_id).getElementsByTagName('input').length;
    for (var i = 0; i < rdo_len; i++) {
        var child_id = obj_id + "_" + i.toString();
        if (document.getElementById(obj_id).getElementsByTagName('input')[i].value != selValue && i < 4) {//not include BSC and TDRM
            document.getElementById(child_id).checked = false;
        }
    }
    return selValue;
}
//show Cutline, in Default.css got css
function newDivCutline(cutData, headText) {
    var id = cutlineId;
    if (!headText)
        headText = "图例";
    var cutLine = document.getElementById(id);
    if (cutLine) {
        cutLine.parentNode.removeChild(cutLine);
    }
    if (!document.getElementById(id)) {
        var div = document.createElement("div");
        div.style.padding = "0px";
        div.style.width = "120px";
        div.style.right = "0px";
        div.style.top = "0px";
        div.style.zIndex = 999;
        div.style.backgroundColor = "White";
        div.id = id;
        div.style.position = "absolute";
        div.style.cursor = "move";
        div.style.border = "solid 1px #999999";
        div.onmousedown = function () { mystartDragWindow(this) };
        div.onmouseup = function () { mystopDragWindow(this) };
        div.onmousemove = function () { mydragWindow(this) };
        div.innerHTML = "<div style='height:18px;width: 100%; background-image: url(Images/bgbj.gif);'><div style='width: 90%; text-align: center;vertical-align:middle; float: left;'><span style='font-size: 13px;'>" + headText + "</span></div><div style='right: 2px; position: absolute;'><img id='img' src='MyCommonJS/Source/openDiv/infowindow_close.gif' onclick=ShowDivPage('" + id + "') style='margin: 2px;cursor: default;' runat='server' /></div></div>";

        var div_containerColor = document.createElement("div");
        div_containerColor.id = "containerColor";
        var div_containerColorText = document.createElement("div");
        div_containerColorText.id = "containerColorText";
        var colorCount = 0;
        for (var color in cutData) {
            colorCount++;
            var div_color = document.createElement("div");
            div_color.style.backgroundColor = color;
            div_containerColor.appendChild(div_color);

            var div_Text = document.createElement("div");
            div_Text.style.fontSize = "12px";
            div_Text.style.verticalAlign = "middle";
            div_Text.innerHTML = cutData[color];
            div_containerColorText.appendChild(div_Text);
        }
        div.appendChild(div_containerColor);
        div.appendChild(div_containerColorText);
        document.body.appendChild(div);
    }
}
function switchAnalyzeChange() {
    var div = document.getElementById("SwitchAnalyze");
    if (div.style.display == "block") {
        $("map_" + LayerControl.mapModel.getId()).style.cursor = "default";
        cellOnclick.funName = "SwitchAnalyze";
        document.getElementById("imgSwitchAnalyze").src = "Images/ToolBar/qhfx_un.png";
    }
    else {
        $("map_" + LayerControl.mapModel.getId()).style.cursor = "move";
        cellOnclick.funName = "";
        document.getElementById("imgSwitchAnalyze").src = "Images/ToolBar/qhfx.png";
        newDivFrameClose = function () {
        }
    }
}
function switchAnalyze() {
    addDelegate(cancelOtherSingleChoose);
    newDivFrame("SwitchAnalyze", document.body, "OpePages/SwitchAnalyze.aspx", "切换分析", "", "", "switchAnalyzeChange");
    var div = document.getElementById("SwitchAnalyze");
    div.style.width = "250px";
    div.style.height = "350px";
    ShowDivPage(div, true);
    switchAnalyzeChange();
}
function BSC_LAC_Show(id) {
    newDivFrame("BSC_LAC", document.body, "OpePages/BSC_LAC_Cover.aspx", "BSC_LAC覆盖");
    var div = document.getElementById("BSC_LAC");
    div.style.display = "none";
    div.style.width = "520px";
    div.style.height = "60px";
    if (document.getElementById(id).checked) {
        ShowDivPage(div, true);
    }
}
function BSC_LAC_Cover_deleteLayers() {
    LayerControl.layerTurnParmaChanged("Simulate_2G,,", false);
    LayerControl.refurbish("Simulate_2G,,", true);
    LayerControl.layerTurnParmaChanged("Simulate_3G,,", false);
    LayerControl.refurbish("Simulate_3G,,", true);
}
function BSC_LAC_Cover(BSC_LAC, fill_border, simulateName) {
    BSC_LAC_Cover_deleteLayers();

    LayerControl.Layers.layers[simulateName + ",,"]['getDataParams']['isTurnOn'] = true;
    outPutLayerBefore.BSC_LAC_Cover = function () {
        cellOutPutBefore.cutData = {};
    }

    cellOutPutBefore.BSC_LAC = BSC_LAC;
    cellOutPutBefore.cutData = {}; // {"red": "同频点","green": "邻频点"}
    cellOutPutBefore.fill_border = fill_border;
    cellOutPutBefore.simulateName = simulateName;
    cellOutPutBefore.BSC_LAC_Cover = function (layerCellID, layerCell) {
        if (layerCellID.split('|')[0] == cellOutPutBefore.simulateName + ",,") {
            var cell = layerCell;
            if (!cellOutPutBefore.cutData[cell[cellOutPutBefore.BSC_LAC]]) {//declare newDivCutline data
                cellOutPutBefore.cutData[cell[cellOutPutBefore.BSC_LAC]] = cell[cellOutPutBefore.BSC_LAC.slice(0, -6)];
                if (cellOutPutBefore.cutData) {
                    newDivCutlineBSC_LAC(cellOutPutBefore.cutData, cellOutPutBefore.simulateName.slice(-2) + cellOutPutBefore.BSC_LAC.slice(0, -6) + "覆盖", cellOutPutBefore.BSC_LAC, simulateName, cellOutPutBefore.fill_border);
                }
            }

            var simulateParamName = cellOutPutBefore.BSC_LAC.slice(0, -6) + "Names" + cellOutPutBefore.simulateName.slice(-3);
            if (!LAC_BSC_CIs[simulateParamName])
                LAC_BSC_CIs[simulateParamName] = {};
            if (!LAC_BSC_CIs[simulateParamName][cell[cellOutPutBefore.BSC_LAC.slice(0, -6)]])
                LAC_BSC_CIs[simulateParamName][cell[cellOutPutBefore.BSC_LAC.slice(0, -6)]] = {};
            LAC_BSC_CIs[simulateParamName][cell[cellOutPutBefore.BSC_LAC.slice(0, -6)]][layerCellID] = true;

            //fill color //chk is checked
            if (simulateParam[simulateParamName][cell[cellOutPutBefore.BSC_LAC.slice(0, -6)]] == 2) {
                cell[cellOutPutBefore.fill_border] = cell[cellOutPutBefore.BSC_LAC];
                if (cellOutPutBefore.fill_border == "fillcolor")
                    cell.opacity = 0.6;
            }
        }
    }
    LayerControl.refurbish(simulateName + ",,");
    LayerControl.layerTurnParmaChanged(simulateName + ",,", true);
}
var cutlineId = "_cutline";
//show Cutline, in Default.css got css
function newDivCutlineBSC_LAC(cutData, headText, BSCorLAC, TwoGorThreeG, fill_border) {
    var id = cutlineId;
    if (!headText)
        headText = "图例";
    var cutLine = document.getElementById(id);
    if (cutLine) {
        cutLine.parentNode.removeChild(cutLine);
    }
    if (!document.getElementById(id)) {
        var div = document.createElement("div");
        div.style.padding = "0px";
        div.style.width = "150px";
        div.style.right = "0px";
        div.style.top = "0px";
        div.style.backgroundColor = "White";
        div.style.zIndex = 999;
        div.id = id;
        div.style.position = "absolute";
        div.style.cursor = "move";
        div.style.border = "solid 1px #999999";
        div.onmousedown = function () { mystartDragWindow(this) };
        div.onmouseup = function () { mystopDragWindow(this) };
        div.onmousemove = function () { mydragWindow(this) };
        div.innerHTML = "<div style='height:18px;width: 100%; background-image: url(Images/bgbj.gif);'><div style='width: 90%; text-align: center;vertical-align:middle; float: left;'><span style='font-size: 13px;'>" + headText + "</span></div><div style='right: 2px; position: absolute;'><input TwoGorThreeG='" + TwoGorThreeG + "' BSCorLAC='" + BSCorLAC + "' type='checkbox' onclick='simulateChkAllClick(this)' checked=true style='margin: 1px;cursor: default;'></input><img id='img' src='MyCommonJS/Source/openDiv/infowindow_close.gif' onclick=ShowDivPage('" + id + "') style='margin: 2px;cursor: default;'/></div></div>";

        var div_containerColor = document.createElement("div");
        div_containerColor.id = "containerColor";
        var div_containerColorText = document.createElement("div");
        div_containerColorText.id = "containerColorText";
        var div_containerColorChecked = document.createElement("div");
        div_containerColorChecked.id = "containerColorChecked";
        var colorCount = 0;
        for (var color in cutData) {
            colorCount++;
            var div_color = document.createElement("div");
            div_color.style.backgroundColor = color;
            div_containerColor.appendChild(div_color);

            var div_text = document.createElement("div");
            div_text.style.fontSize = "12px";
            div_text.style.verticalAlign = "middle";
            div_text.innerHTML = cutData[color];
            div_containerColorText.appendChild(div_text);

            var div_chk = document.createElement("div");
            var chk = document.createElement("input");
            chk.simulateParamName = BSCorLAC.slice(0, -6) + "Names" + TwoGorThreeG.slice(-3);
            chk.bsc_lacName = cutData[color];
            chk.type = "checkbox";
            chk.style.cursor = "Default";
            chk.num = colorCount;
            chk.bsc_lacColor = color;
            chk.fill_border = fill_border;

            chk.onclick = function () {
                simulateParam[this.simulateParamName][this.bsc_lacName] = this.checked == true ? 2 : 1;
                for (var id in LAC_BSC_CIs[this.simulateParamName][this.bsc_lacName]) {
                    var simObj = document.getElementById(id + '_vFigure');
                    if (simObj) {
                        simObj[this.fill_border] = this.checked == true ? this.bsc_lacColor : LayerControl.Layers.layers["Simulate" + this.simulateParamName.slice(-3) + ",,"][this.fill_border];
                        if (this.fill_border == "fillcolor")
                            simObj.childNodes[0].opacity = this.checked == true ? 0.6 : LayerControl.Layers.layers["Simulate" + this.simulateParamName.slice(-3) + ",,"].opacity;
                    }
                }
            }
            div_chk.appendChild(chk);
            div_containerColorChecked.appendChild(div_chk);
            //add to simulateParam
            if (!simulateParam[BSCorLAC.slice(0, -6) + "Names" + TwoGorThreeG.slice(-3)][cutData[color]]) {
                simulateParam[BSCorLAC.slice(0, -6) + "Names" + TwoGorThreeG.slice(-3)][cutData[color]] = 2;
            }
            chk.checked = simulateParam[BSCorLAC.slice(0, -6) + "Names" + TwoGorThreeG.slice(-3)][cutData[color]] == 2 ? true : false;
        }
        div.appendChild(div_containerColor);
        div.appendChild(div_containerColorText);
        div.appendChild(div_containerColorChecked);
        document.body.appendChild(div);
    }
}
//用来记录 覆盖值对应的CI列表
var LAC_BSC_CIs = {};
LAC_BSC_CIs.BSCNames_2G = {}; //LAC_BSC_CIs.BSCNames_2G[BSCName][ci] = true
LAC_BSC_CIs.LACNames_2G = {};
LAC_BSC_CIs.BSCNames_3G = {};
LAC_BSC_CIs.LACNames_3G = {};
//用来记录 覆盖值是否显示
var simulateParam = {}; //simulateParamName==BSCNames_2G or LACNames_2G or BSCNames_3G or LACNames_3G
simulateParam.BSCNames_2G = {}; //simulateParam.BSCNames_2G[BSCName] == 2 : 1  ----- 2 = true; 1 = false
simulateParam.LACNames_2G = {};
simulateParam.BSCNames_3G = {};
simulateParam.LACNames_3G = {};
function simulateChkAllClick(chkAll) {
    for (var bsc_lacName in simulateParam[chkAll.BSCorLAC.slice(0, -6) + "Names" + chkAll.TwoGorThreeG.slice(-3)]) {
        simulateParam[chkAll.BSCorLAC.slice(0, -6) + "Names" + chkAll.TwoGorThreeG.slice(-3)][bsc_lacName] = chkAll.checked == true ? 2 : 1;
    }
    isSelectAll_byFatherId(chkAll, "_cutline");
    //重新输出覆盖图层
    LayerControl.refurbish(chkAll.TwoGorThreeG + ",,");
}
//点信息
function showCIMessage(ci, layerId) {
    newDivFrame("ciInfo", document.body, "", "小区信息");
    document.getElementById("ciInfo_ifr").src = "OpePages/CIInfoGet.aspx?ci=" + ci;
    var div = document.getElementById("ciInfo");
    div.style.width = "250px";
    div.style.height = "260px";
    div.style.display = "none";
    ShowDivPage(div, true);
    LayerControl.SetSourceCell(LayerControl.CellGet(layerId, ci));
}
function show_yxfq() {
    ShowDivPage("yxfq", true);
}
//返回Rdo选择的序号
function rtn_rdoListIndex(obj_id) {
    var rdo_len = document.getElementById(obj_id).cells.length;
    var selIndex = 0;
    for (var i = 0; i < rdo_len; i++) {
        var child_id = obj_id + "_" + i.toString();

        if (document.getElementById(child_id).checked) //注意checked不能写成Checked，要不然不成功
        {
            selIndex = i;
            break;
        }
    }
    return selIndex;
}
//返回Rdo选择的值
function rtn_rdoListValue(obj_id) {
    var rdo_len = document.getElementById(obj_id).getElementsByTagName('input').length;
    var selValue = -1;
    for (var i = 0; i < rdo_len; i++) {
        var child_id = obj_id + "_" + i.toString();

        if (document.getElementById(child_id).checked) //注意checked不能写成Checked，要不然不成功
        {
            selValue = document.getElementById(obj_id).getElementsByTagName('input')[i].value;
            break;
        }
    }
    return selValue;
}
function rdo_onchange(obj_id) {
    document.getElementById('div_rdo_hotGroup').style.visibility = "hidden";
    document.getElementById("div_rdo_hotGroup").style.display = "none";
    document.getElementById('div_cbl_market').style.visibility = "hidden";
    document.getElementById("div_cbl_market").style.display = "none";
    document.getElementById('div_Button1').style.visibility = "hidden";
    document.getElementById("div_Button1").style.display = "none";
    if (rtn_rdoListIndex(obj_id) == 0) {
        document.getElementById('div_rdo_hotGroup').style.visibility = "visible";
        document.getElementById("div_rdo_hotGroup").style.display = "block";
    }
    else {
        document.getElementById('div_cbl_market').style.visibility = "visible";
        document.getElementById("div_cbl_market").style.display = "block";
        document.getElementById('div_Button1').style.visibility = "visible";
        document.getElementById("div_Button1").style.display = "block";
    }
}
function buildSubmitClient() {
    //直接进行告警渲染
    var selIndex = rtn_rdoListIndex('RadioButtonList1');
    var area = areaGet();
    var ishot = hotGet();
    clearSelect();
    if (selIndex == 0) {
        romance_hot('isEnabled', 1, 'and');
        romance_hot('GroupNumber', ishot, '');
    }
    else {
        clear_rdoListChoise('rdo_hotGroup');
        var i = 0;
        for (var cbl_market_i = 0; cbl_market_i < document.getElementById('cbl_market').getElementsByTagName('input').length; cbl_market_i++) {
            if (document.getElementById('cbl_market').getElementsByTagName('input')[cbl_market_i].checked) {
                if (i == 0) {
                    romance_company('县市', document.getElementById('cbl_market').getElementsByTagName('LABEL')[cbl_market_i].innerHTML, '');
                }
                else {
                    romance_company('县市', document.getElementById('cbl_market').getElementsByTagName('LABEL')[cbl_market_i].innerHTML, 'or');
                }
                i++;
            }
        }
        if (i == document.getElementById('cbl_market').getElementsByTagName('input').length) {
            clear_rdoListChoise('rdo_hotGroup');
        }
    }
    $('yxfq').style.display = 'none';
    //停止计时器 重新开始
    stopTiming();
    hardwareAlarm(true);
    if (selIndex == 0) {
        freeRomance();
        theIntervalFun.freeRomance = function () {//开启信道扫描刷新
            freeRomance(true);
        }
        //定位
        jquerygetNewData_ajax("BigScreen/hotLocation.aspx?time=" + TimeGet(), 'ishot=' + escape(ishot.toString()), function (request) {
            var values = request.responseText.toString();
            if (values) {
                var _location = jsonParse(values);
                LayerControl.LayerCellLocation(null, null, _location.lo, _location.la);
            }
            else {
                alert("当前无热点小区。");
            }
        }, true);
    }
    else {
        LayerControl.romanceEleCancle("freeRomance");
        theIntervalFun.freeRomance = null; //关闭信道扫描刷新
    }
    setTiming(60000);
    setTimeout("parent.frames['right'].refurbish()", 2000);
    LayerControl.refurbish();
}
function hardwareAlarm_Romance(cell_rom, layerID, cellID, isCancle) {
    var cellID_map = layerID + '|' + cellID + '_vFigure';
    var siteID_word = layerID + '|' + convertCellid_toSiteid(cellID) + '_vFigure' + "_hardwareAlarm";
    var cell = document.getElementById(cellID_map);
    if (isCancle) {
        for (var romProperty in cell_rom) {
            var romProperyValue = cell_rom[romProperty];
            switch (romProperty) {
                case "opacity":
                    cell.childNodes[0].opacity = LayerControl.Layers.layers[layerID].opacity;
                    break;
                case "Battery_SupportTime":
                    break;
                case "HandicraftPower":
                    break;
                case "minutes":
                    var node_SwitchAnalyze = document.getElementById(siteID_word);
                    delObj(node_SwitchAnalyze);
                    break;
                default:
                    document.getElementById(cellID_map)[romProperty] = LayerControl.Layers.layers[layerID][romProperty];
                    break;
            }
        }
        document.getElementById(layerID).appendChild(cell);
        return;
    }
    var layerCell = LayerControl.CellGet(layerID, cellID);
    if (!layerCell) return;
    var replaceLayerID = "Rom_transfer_hardwareAlarm";
    var replaceLayer = document.getElementById(replaceLayerID);
    if (!replaceLayer) {
        replaceLayer = document.createElement("div");
        replaceLayer.id = replaceLayerID;
        replaceLayer.style.position = "absolute";
        replaceLayer.style.zIndex = LayerControl.zIndexMax;
        var AllLayersOutSide = document.getElementById(LayerControl.AllLayersOutSideId);
        if (AllLayersOutSide)//防止出现缩放前渲染时 在缩放时删除此图层
            document.getElementById(LayerControl.AllLayersOutSideId).appendChild(replaceLayer);
        else
            return;
    }
    for (var romProperty in cell_rom) {
        var romProperyValue = cell_rom[romProperty];
        switch (romProperty) {
            case "opacity":
                cell.childNodes[0].opacity = romProperyValue;
                break;
            case "Battery_SupportTime":
                break;
            case "HandicraftPower": //是否已发电
                break;
            case "minutes":
                if (cell_rom["fillcolor"] != "#ff00ff") break; //非市电告警
                var coord = new Coordinate(layerCell.Longitude, layerCell.Latitude);
                var mapcoord = coord.getMapCoord(coord);
                layerCell.x = mapcoord.x;
                layerCell.y = mapcoord.y;
                var x = layerCell.x;
                var y = layerCell.y;
                var r = layerCell.r;
                var lx;
                var ly;
                if (layerCell.figure == "SectorModel") {
                    lx = layerCell.x + Math.round(r * Math.sin(ConvertRad(layerCell.qj))) / 1.618;
                    ly = layerCell.y - Math.round(r * Math.cos(ConvertRad(layerCell.qj))) / 1.618;
                }
                else {
                    lx = layerCell.x;
                    ly = layerCell.y;
                }
                var word = document.createElement('div');
                word.id = siteID_word;
                word.style.left = lx;
                word.style.top = ly;
                word.style.position = "absolute";
                word.style.color = "green";
                word.style.fontSize = 13;
                word.style.zIndex = LayerControl.zIndexMax + 1;
                var color = "green";
                var width = 20;
                var value = 0;
                if (parseFloat(cell_rom["minutes"]) > parseFloat(cell_rom["Battery_SupportTime"])) {
                    value = 0;
                }
                else {
                    value = width * (parseFloat(cell_rom["Battery_SupportTime"]) - parseFloat(cell_rom["minutes"])) / parseFloat(cell_rom["Battery_SupportTime"]);
                }
                var rect1 = document.createElement("v:Rect");
                rect1.style.position = "absolute";
                rect1.style.width = width + "px";
                rect1.style.height = "5px";
                rect1.fillcolor = "white";
                rect1.strokecolor = "#ff00ff";
                word.appendChild(rect1);
                if (!document.getElementById(siteID_word))//同个基站只渲染一个小区
                {
                    var rect2 = document.createElement("v:Rect");
                    rect2.style.position = "absolute";
                    rect2.style.width = value + "px";
                    rect2.style.height = "5px";
                    rect2.fillcolor = color;
                    word.appendChild(rect2);
                    var text = document.createElement("div");
                    text.innerText = parseFloat(cell_rom["Battery_SupportTime"]) - parseFloat(cell_rom["minutes"]) + "分钟";
                    text.style.position = "absolute";
                    text.style.left = "0px";
                    text.style.top = "5px";
                    word.appendChild(text);
                    replaceLayer.appendChild(word);
                    if (cell_rom["HandicraftPower"] == "1") {//已发电
                        var textFD = document.createElement("div");
                        textFD.innerText = "已发电";
                        textFD.style.position = "absolute";
                        textFD.style.top = "-12px";
                        textFD.style.fontSize = "10px";
                        word.appendChild(textFD);
                        replaceLayer.appendChild(word);
                    }
                }
                break;
            default:
                cell[romProperty] = romProperyValue;
                break;
        }
    }
    replaceLayer.appendChild(cell);
}
function hardwareAlarm(isRoma) {
    if (LayerControl.RomanceElements.hardwareAlarm)
        LayerControl.romanceEleCancle("hardwareAlarm");
    LayerControl.RomanceElements.hardwareAlarm = {};
    LayerControl.RomanceElements.hardwareAlarm.coverType = hardwareAlarm_Romance;
    var cells = hardwareAlarmData(areaGet(), hotGet());
    var attrValue = "";
    jquerygetNewData_ajax("BigScreen/Ajax_AlarmData.aspx?time=" + TimeGet(), 'area=' + escape(area.toString()) + '&ishot=' + escape(ishot.toString()), function (request) {
        attrValue = request.responseText.toString();
        if (attrValue != "" && attrValue != "{}") {
            LayerControl.RomanceElements.hardwareAlarm.cells = jsonParse(attrValue);
            LayerControl.romEleRomance("hardwareAlarm");
        }
    });
}
function hardwareAlarmData(area, ishot) {
}
function hotGet() {
    var selIndex = rtn_rdoListIndex('RadioButtonList1');
    if (selIndex == 0) {
        ishot = rtn_rdoListValue('rdo_hotGroup');
    }
    else {
        ishot = "-1";
    }
    return ishot;
}
function areaGet() {
    var selIndex = rtn_rdoListIndex('RadioButtonList1');
    if (selIndex == 0) {
        area = "-1";
    }
    else {
        area = "";
        var i = 0;
        for (var cbl_market_i = 0; cbl_market_i < document.getElementById('cbl_market').getElementsByTagName('input').length; cbl_market_i++) {
            if (document.getElementById('cbl_market').getElementsByTagName('input')[cbl_market_i].checked) {
                i++;
                area += "'" + document.getElementById('cbl_market').getElementsByTagName('LABEL')[cbl_market_i].innerHTML + "',";
            }
        }
        if (i != 0) {
            area = area.substring(0, area.length - 1);
        }
    }
    return area;
}
theIntervalFun.hardwareAlarm = function () {
    hardwareAlarm(true);
    machineAlarm();
}
function machineAlarm() {
    if (LayerControl.RomanceElements.machine)
        LayerControl.romanceEleCancle("machine");
    LayerControl.RomanceElements.machine = {};
    LayerControl.RomanceElements.machine.coverType = "transfer";
    var attrValue = "";
    jquerygetNewData_ajax("BigScreen/MachineAlarmData.aspx?time=" + TimeGet(), '', function (request) {
        attrValue = request.responseText.toString();
        if (attrValue != "" && attrValue != "{}") {
            LayerControl.RomanceElements.machine.cells = jsonParse(attrValue);
            LayerControl.romEleRomance("machine");
        }
    });
}
function show_hotManage() {
    newDivFrame("HotCellMag", document.body, "", "热点管理");
    document.getElementById("HotCellMag_ifr").src = "BigScreen/HotCellMag.aspx";
    var div = document.getElementById("HotCellMag");
    div.style.width = "550px";
    div.style.height = "450px";
    divCenter(div);
    ShowDivPage(div);
}
function showSendMessage() {
    newDivFrame("SendMessage", document.body, "", "短信发送");
    document.getElementById("SendMessage_ifr").src = "BigScreen/SendMessage.aspx?time=" + TimeGet();
    var div = document.getElementById("SendMessage");
    div.style.width = "620px";
    div.style.height = "550px";
    divCenter(div);
    ShowDivPage(div);
}
function showCapability(ci, layerId) {
    newDivFrame("capability", document.body, "", "性能指标");
    document.getElementById("capability_ifr").src = "OpePages/CIInfoGet.aspx?ci=" + ci + "&isCapability=true&time=" + TimeGet();
    var div = document.getElementById("capability");
    div.style.width = "250px";
    div.style.height = "140px";
    div.style.display = "none";
    ShowDivPage(div, true);
    LayerControl.SetSourceCell(LayerControl.CellGet(layerId, ci));
}
function showSendMessage_phonesManage() {
    newDivFrame("SendMessage_phones", document.body, "", "通讯录管理");
    document.getElementById("SendMessage_phones_ifr").src = "BigScreen/SendMessage_phonesManage.aspx?time=" + TimeGet();
    var div = document.getElementById("SendMessage_phones");
    div.style.width = "400px";
    div.style.height = "400px";
    div.style.display = "none";
    divCenter(div);
    ShowDivPage(div);
}
function showArea() {
    newDivFrame("showAreaMap", document.body, "", false, false, false, "makeBackDisable");
    document.getElementById("showAreaMap_ifr").src = "BigScreen/AreaMap.aspx?time=" + TimeGet();
    //document.getElementById("showAreaMap_ifr").allowtransparency = "true";
    //document.getElementById("showAreaMap_ifr").style.backgroundColor = "#6c6c6c"; 为什么不管用 只能在页面设置
    document.getElementById("showAreaMap_ifr").style.filter = "alpha(opacity=90)";
    var div = document.getElementById("showAreaMap");
    div.style.width = "750px";
    div.style.height = "600px";
    div.style.zIndex = "1002";
    divCenter(div);
    ShowDivPage(div);
    makeBackDisable();
}
function makeBackDisable(openObj) {
    newCoverDiv("divCover", 0, 0, document.body.offsetWidth, document.body.offsetHeight);
    //生成捞空的div覆盖层
    //    newCoverDiv("divCover_top", 0, 0, document.body.offsetWidth, parseFloat(openObj.style.top));
    //    newCoverDiv("divCover_left", 0, parseFloat(openObj.style.top), parseFloat(openObj.style.left), document.body.offsetHeight - parseFloat(openObj.style.top));
    //    newCoverDiv("divCover_right", parseFloat(openObj.style.left) + parseFloat(openObj.style.width), parseFloat(openObj.style.top), parseFloat(openObj.style.left), document.body.offsetHeight - parseFloat(openObj.style.top));
    //    newCoverDiv("divCover_bottom", parseFloat(openObj.style.left), parseFloat(openObj.style.top) + parseFloat(openObj.style.height), parseFloat(openObj.style.width), document.body.offsetHeight - parseFloat(openObj.style.top) - parseFloat(openObj.style.height));
}
//生成div覆盖层
function newCoverDiv(id, left, top, width, height) {
    if (left < 0)
        left = 0;
    if (top < 0)
        top = 0;
    if (width < 0)
        width = 0;
    if (height < 0)
        height = 0;
    var divCover = document.getElementById(id);
    if (divCover) {
        delObj(divCover);
        return;
    }
    divCover = document.createElement("div");
    divCover.id = id;
    divCover.style.backgroundColor = "#6C6C6C";
    divCover.style.width = width + "px";
    divCover.style.height = height + "px";
    divCover.style.filter = "alpha(opacity=90)";
    divCover.style.position = "absolute";
    divCover.style.left = left + "px";
    divCover.style.top = top + "px";
    divCover.style.zIndex = "1001";
    document.body.appendChild(divCover);
}
//手工发电
function handicraftPower(cellID, layerID) {
    jquerygetNewData_ajax("BigScreen/handicraftPower.aspx?time=" + TimeGet(), 'ci=' + cellID, function (request) {
        if (request.responseText == "true") {
            hardwareAlarm(true);
            alert("发电成功!");
        }
    });
}