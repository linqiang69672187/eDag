/*渲染注意事项：数据库获取的ID号必须为dbo.map_CellIDGetByCI_fun(ci) 如：TwoG,MOTOROLA,GSM900|10228*/
//考虑页面重新渲染后在页面范围之外的图元下次重新渲染，清空已渲染数据即可
LayerManager.prototype.RomanceElements = {}; //渲染数据
LayerManager.prototype.RomancedCells = {}; //已渲染数据
LayerManager.prototype.cellRomance = function (layerID, cellID) {
    var romEles = this.RomanceElements;
    for (var romEle in romEles) {
        if (!romEles[romEle]) continue;
        if (romEles[romEle].romPropertyName)//means like BSC or LAC -- no use now
        {
            if (romEles[romEle].romLayerID && layerID != romEles[romEle].romLayerID) return;
            if (romEles[romEle].cells[this.CellGet(layerID, cellID)[romEles[romEle].romPropertyName]])
                this.romEleCellRomance(romEle, layerID, cellID);
        }
        else {//default romPropertyName=null means "CI"
            if (romEles[romEle].cells && romEles[romEle].cells[layerID + '|' + cellID])
                this.romEleCellRomance(romEle, layerID, cellID);
        }
    }
}
//渲染以后再修改
//LayerControl.addEventListener("OutPutLayerCells_after", LayerManager.cellRomance);
function cellRomance(args) {
    LayerControl.cellRomance(args.split('|')[0], args.split('|')[1]);
};  //define delegate cellOutPutAfter
//apply for cell outPut rom ,not direct rom
//romEleID——romEleID
//cell——layerID + "_" + cellID
LayerManager.prototype.romEleCellRomance = function (romEleID, layerID, cellID) {
    var romEles = this.RomanceElements;
    //LayerManager.IsExistInLastData 这句话的好处是可以自动更新不在当前范围内的基站渲染，但需要曾经没输出过
    if (this.isExistInRomancedCells(romEleID, layerID, cellID) || !this.IsExistInLastData(layerID, cellID))//if is exist in RomancedCells or is not in lastData;continue
    { return; }
    if (romEles[romEleID].romPropertyName) {
        var romValues = romEles[romEleID].cells[this.CellGet(layerID, cellID)[romEles[romEleID].romPropertyName]]; // { "color": "value", "opacity": "value"} //这句不需要
        if (typeof (romEles[romEleID].coverType) == "function") {
            if (romValues)//exist the cell,roamnce it
            {
                romEles[romEleID].coverType(romValues, layerID, cellID);
                //add RomancedCells
                this.addRomancedCells(romEleID, layerID, cellID);
            }
        }
        //Did not consider coverType="function" first
        switch (romEles[romEleID].coverType) {
            case "cover":
                if (romValues)//exist the cell,roamnce it
                {
                    for (var romProperty in romValues) {
                        var romProperyValue = romValues[romProperty];
                        switch (romProperty) {
                            case "opacity":
                                document.getElementById(layerID + '|' + cellID + '_vFigure').childNodes[0].opacity = romProperyValue;
                                break;
                            default:
                                document.getElementById(layerID + '|' + cellID + '_vFigure')[romProperty] = romProperyValue;
                                break;
                        }
                    }
                    //add RomancedCells
                    this.addRomancedCells(romEleID, layerID, cellID);
                }
                break;
            default: break;
        }
        return;
    }
    if (typeof (romEles[romEleID].coverType) == "function") {
        romEles[romEleID].coverType(romEles[romEleID].cells[layerID + '|' + cellID], layerID, cellID);
        //add RomancedCells
        this.addRomancedCells(romEleID, layerID, cellID);
    }
    switch (romEles[romEleID].coverType) {
        case "cover":
            var cell = document.getElementById(layerID + '|' + cellID + '_vFigure');
            for (var romProperty in romEles[romEleID].cells[layerID + '|' + cellID]) {
                var romProperyValue = romEles[romEleID].cells[layerID + '|' + cellID][romProperty];
                switch (romProperty) {
                    case "opacity":
                        cell.childNodes[0].opacity = romProperyValue;
                        break;
                    default:
                        cell[romProperty] = romProperyValue;
                        break;
                }
            }
            //add RomancedCells
            this.addRomancedCells(romEleID, layerID, cellID);
            break;
        case "transfer": //将此图元移至新图层，新图层Z-Index为最大-999（为了使得业务数据清晰可见）
            var replaceLayerID = "Rom_transfer_" + romEleID;
            var replaceLayer = document.getElementById(replaceLayerID);
            if (!replaceLayer) {
                replaceLayer = document.createElement("div");
                replaceLayer.id = replaceLayerID;
                replaceLayer.style.position = "absolute";
                replaceLayer.style.zIndex = this.map.zIndex + 5;
                document.getElementById(this.AllLayersOutSideId).appendChild(replaceLayer);
            }
            //copy from cover
            var cell = document.getElementById(layerID + '|' + cellID + '_vFigure');
            for (var romProperty in romEles[romEleID].cells[layerID + '|' + cellID]) {
                var romProperyValue = romEles[romEleID].cells[layerID + '|' + cellID][romProperty];
                switch (romProperty) {
                    case "opacity":
                        cell.childNodes[0].opacity = romProperyValue;
                        break;
                    default:
                        cell[romProperty] = romProperyValue;
                        break;
                }
            }
            replaceLayer.appendChild(cell);
            //add RomancedCells
            this.addRomancedCells(romEleID, layerID, cellID);
            break;
        default: break;
    }
}
//romEleID——romEleID
LayerManager.prototype.romEleRomance = function (romEleID) {
    for (var cell in this.RomanceElements[romEleID].cells) {
        this.romEleCellRomance(romEleID, cell.split('|')[0], cell.split('|')[1]);
    }
}
//romEle——LayerManager.RomanceElements[ele]
//don't need delete RomancedCell because of LayerManager.elementRomanceCancle got it
LayerManager.prototype.romanceCellCancle = function (romEleID, layerID, cellID) {
    var romEle = this.RomancedCells[romEleID];
    var cellMap = document.getElementById(layerID + "|" + cellID + '_vFigure');
    if (cellMap) {
        if (typeof (romEle.coverType) == "function") {
            romEle.coverType(romEle.layers[layerID][cellID], layerID, cellID, true);
        }
        switch (romEle.coverType) {
            case "cover":
                var cell = document.getElementById(layerID + "|" + cellID + '_vFigure');
                for (var romProperty in romEle.layers[layerID][cellID]) {
                    var romProperyValue = romEle.layers[layerID][cellID][romProperty];
                    switch (romProperty) {
                        case "opacity":
                            cell.childNodes[0].opacity = this.Layers.layers[layerID].opacity;
                            break;
                        default:
                            cell[romProperty] = this.Layers.layers[layerID][romProperty];
                            break;
                    }
                }
                break;
            case "transfer":
                //copy from cover
                var cell = document.getElementById(layerID + "|" + cellID + '_vFigure');
                for (var romProperty in romEle.layers[layerID][cellID]) {
                    var romProperyValue = romEle.layers[layerID][cellID][romProperty];
                    switch (romProperty) {
                        case "opacity":
                            cell.childNodes[0].opacity = this.Layers.layers[layerID].opacity;
                            break;
                        default:
                            cell[romProperty] = this.Layers.layers[layerID][romProperty];
                            break;
                    }
                }
                document.getElementById(layerID).appendChild(cell);
                break;
            default: break;
        }
    }
}
//LayerManager.RomanceElements[romEle] cancel
//ele——eleID
LayerManager.prototype.romanceEleCancle = function (ele) {
    if (!this.RomancedCells[ele]) return;
    for (var layerID in this.RomancedCells[ele].layers) {
        for (var cellID in this.RomancedCells[ele].layers[layerID]) {
            this.romanceCellCancle(ele, layerID, cellID);
        }
    }
    //delete RomancedCells
    if (this.RomancedCells[ele])
        this.RomancedCells[ele] = false;
    if (this.RomanceElements[ele])
        this.RomanceElements[ele] = false;
}
LayerManager.prototype.isExistInRomancedCells = function (eleID, layerID, cellID) {
    if (this.RomancedCells[eleID] && this.RomancedCells[eleID].layers[layerID] && this.RomancedCells[eleID].layers[layerID][cellID])
        return true;
    return false;
}
LayerManager.prototype.addRomancedCells = function (eleID, layerID, cellID) {
    if (!this.RomancedCells[eleID]) {
        this.RomancedCells[eleID] = {};
        this.RomancedCells[eleID].layers = {};
        this.RomancedCells[eleID].coverType = this.RomanceElements[eleID].coverType;
    }
    if (!this.RomancedCells[eleID].layers[layerID]) {
        this.RomancedCells[eleID].layers[layerID] = {};
    }
    if (!this.RomancedCells[eleID].layers[layerID][cellID])
        this.RomancedCells[eleID].layers[layerID][cellID] = this.RomanceElements[eleID].cells[layerID + '|' + cellID];
}
LayerManager.prototype.delRomancedCells = function (eleID, layerID, cellID) {
    if (this.RomancedCells[eleID] && this.RomancedCells[eleID].layers[layerID] && LayerManager.prototype.RomancedCells[eleID].layers[layerID][cellID])
        this.RomancedCells[eleID].layers[layerID][cellID] = false;
}
LayerManager.prototype.delRomancedLayer = function (layerID) {
    for (var ele_i in this.RomancedCells) {
        for (var layer_i in this.RomancedCells[ele_i].layers) {
            if (layerID == layer_i) {
                this.RomancedCells[ele_i].layers[layerID] = false;
            }
        }
    }
}