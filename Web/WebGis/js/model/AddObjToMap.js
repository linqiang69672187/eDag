//专门用来添加对象到地图
function AddObjToMap(map) {
    this.data = {
        map: null,
        domItems: { "id": "this is the obj" }
    }
    this.add = function (obj) {
        this.data.map.data.mapDiv.appendChild(obj); //add to map
    }
    this.del = function (obj) {
        if (obj) {
            //庞小斌修改，更改节点移除方法
            removeChildSafe(obj);
        }
    }
    this.addWithZoom = function (obj) { //添加obj并跟随缩放显示
        this.add(obj);
        if (obj.id && this.data.domItems[obj.id]) {
            this.data.domItems[obj.id] = obj; //add to domItems
            var latLng = this.data.map.getLatLngByPoint({ x: obj.style.left, y: obj.style.top });
        }
    }
    this.delWithZoom = function (obj) { //删除obj并删除跟随缩放显示
        this.del(obj);
        if (obj.id && this.data.domItems[obj.id]) {
            delete this.data.domItems[obj.id];
        }
    }
    {//init
        function zoomToLevel_after(ths) {
            for (var item_i in ths.data.domItems) {
                var obj = ths.data.domItems[item_i];
                if (typeof (obj) == "object") {
                    //将obj latLng重新计算得出pixel重新输出
                    ths.add(obj);
                }
            }
        }
        this.data.map = map;
        //添加缩放事件前删除所有对象与缩放事件后添加所有对象
        map.addEventListener("zoomToLevel_after", zoomToLevel_after, this);
    }
}
//添加addObjToMap属性
//Map.prototype.data.addObjToMap = new AddObjToMap(Map.prototype);