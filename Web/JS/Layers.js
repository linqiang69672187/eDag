function initLayers() {
    for (var layer in LayerControl.Layers.layers) {
        LayerControl.Layers.layers[layer].LayerID = layer;
        LayerControl.Layers.layers[layer].zoomLevel = 3;
        LayerControl.Layers.layers[layer].url = basePath + 'Images/Police.png';
        LayerControl.Layers.layers[layer].offset_x = -20;
        LayerControl.Layers.layers[layer].offset_y = -92;
        LayerControl.Layers.layers[layer].zIndex = 2;
        LayerControl.Layers.layers[layer].width = 40;
        LayerControl.Layers.layers[layer].height = 92;
        LayerControl.Layers.layers[layer].isReSizeToLevel = true; //是否随级别调整大小，最后一层为实际大小
        switch (LayerControl.Layers.layers[layer].getDataParams.layerType) {
            case "Police":
                LayerControl.Layers.layers[layer].figure = LayerControl.LayerType.Image;
                LayerControl.Layers.layers[layer].vectorCls = LayerControl.LayerVectorCls.ImageModel; //画图类
                LayerControl.Layers.layers[layer].funNames = { "OutputLayerCell": true, "InfoShow": true}//这里可以自行添加函数如ImageModel.prototype.InfoShow
                LayerControl.Layers.layers[layer].getDataParams.isTurnOn = true;
                break;
        }
    }
}