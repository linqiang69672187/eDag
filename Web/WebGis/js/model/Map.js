function ZheJiangMap() {//最大级别10
    Map.apply(this);
    this.data.clsName = "ZheJiangMap";
    this.data.name = "DIYZheJiang";
    this.data.firstLevelPicCount = 2; //第一级别横向图片数 用来避免获取不存在的图片编号
    this.data.firstLevelWidth = 262144; //第一级别模型直径,对应google第9级javascript:alert(Math.pow(2,9)*256);
    this.data.levelZoomMultiple = 2; //每级缩放倍数
    this.data.backPicSize = 200;
    this.data.backPicType = "NORMAL"; //or SATELLITE
    this.data.backPicPath = "http://10.8.52.241:8081/";
    this.data.maxLa = 30.4486737; //左上角经纬度,可省略,主要用于生成map杭州.js
    this.data.minLo = 119.9143982;
    this.data.deviation_lo =-0.00469276;  //底图经纬度偏移量
    this.data.deviation_la = 0.002302505;
    this.data.initCenter = { "lo": 120.1521899, "la": 30.2733004 };
    this.data.currentCenter = this.data.initCenter;
    this.getPixel = function (latLng) {//获取相对于本地图片左上角位置的坐标
        var point = this.fromLatLngToPixel(latLng);
        var mapx = point.x - Math.round(hz_map_region.LDzooms[this.data.currentLevel - 1].px);
        var mapy = point.y - Math.round(hz_map_region.LDzooms[this.data.currentLevel - 1].py);
        return { "x": mapx, "y": mapy };
    }

    this.getLatLng = function (point) {
        var x = Math.round(point.x) + Math.round(hz_map_region.LDzooms[this.data.currentLevel - 1].px);
        var y = Math.round(point.y) + Math.round(hz_map_region.LDzooms[this.data.currentLevel - 1].py);
        return this.fromPixelToLatLng({ "x": x, "y": y });
    }
    this.imgPicPath = function (row, column) {
        return this.data.backPicPath + this.data.backPicType + "/" + this.data.currentLevel + "/" + (parseInt(row) + 1) + "_" + (parseInt(column) + 1) + ".png";
    }
}
function EduShiMap() {//最大级别10,最小级别7
    Map.apply(this);
    this.data.clsName = "EduShiMap";
    this.data.name = "EduShi";
    this.data.firstLevelPicCount = 2000;
    this.data.firstLevelWidth = 262144; //google 第10层
    this.data.levelZoomMultiple = 2;
    this.data.backPicSize = 256;
    this.data.backPicPath = "http://cpic2.edushi.com/cn/hz/zh-chs/mappic/";
    this.data.maxLa = 30.3067626;
    this.data.minLo = 120.0354623;
    this.data.deviation_lo = -0.00519276;  //底图经纬度偏移量
    this.data.deviation_la = 0.002502505;
    this.getPixel = function (latLng) {//获取相对于本地图片左上角位置的坐标
        var point = this.fromLatLngToPixel(latLng);
        var mapx = point.x - Math.round(edushiHZMap_region.LDzooms[this.data.currentLevel - 1].px);
        var mapy = point.y - Math.round(edushiHZMap_region.LDzooms[this.data.currentLevel - 1].py);
        return { "x": mapx, "y": mapy };
    }
    this.getLatLng = function (point) {
        var x = Math.round(point.x) + Math.round(edushiHZMap_region.LDzooms[this.data.currentLevel - 1].px);
        var y = Math.round(point.y) + Math.round(edushiHZMap_region.LDzooms[this.data.currentLevel - 1].py);
        return this.fromPixelToLatLng({ "x": x, "y": y });
    }
    this.imgPicPath = function (row, column) {//edushi 横向纵向是颠倒的,最后一级别文件夹编号是0,得知第一级别是9
        return this.data.backPicPath + "png" + (10 - this.data.currentLevel) + "/" + column + "," + row + ".png";
    }
}
function Bing() {//最大级别24,有效图片最大级别18
    Map.apply(this);
    this.data.clsName = "Bing";
    this.data.name = "Bing";
    this.data.firstLevelPicCount = 2;
    this.data.firstLevelWidth = 512; //google 第1层 256*2
    this.data.levelZoomMultiple = 2;
    this.data.backPicSize = 256;
    this.data.maxLa = null;
    this.data.minLo = null;
    this.data.deviation_lo = 0;  //底图经纬度偏移量
    this.data.deviation_la = 0;
    this.getPixel = function (latLng) {//获取相对于本地图片0,0编号(左上角)位置的坐标
        var point = this.fromLatLngToPixel(latLng);
        return { "x": point.x, "y": point.y };
    }
    this.getLatLng = function (point) {
        return this.fromPixelToLatLng({ "x": point.x, "y": point.y });
    }
    this.imgPicPath = function (row, column) {//edushi 横向纵向是颠倒的,最后一级别文件夹编号是0,得知第一级别是9
        //图片路径 举例：r3.tiles.Ditu.Live.Com/tiles/r132121030303.png?g=68
        var r = (column % 2) + (row % 2) * 2;
        var path = "http://r" + r + ".tiles.Ditu.Live.Com/tiles/";
        if (this.data.currentLevel == 1) {
            code = parseInt(column) + (row % 2) * 2;
            code = code.toString(10);
        }
        else {
            //codeColumn 与列编号相关值
            var codeColumn = parseInt(column);
            codeColumn = codeColumn.toString(2);
            var codeRow = parseInt(row);
            codeRow = codeRow.toString(2);
            var code = "";
            if (this.data.currentLevel > 16) { //运算超过整型最大值
                var column_i = codeColumn.length - 1;
                for (column_i = codeColumn.length - 1, row_i = codeRow.length - 1; column_i > -1 && row_i > -1; column_i--, row_i--) {
                    var temp_Num = parseInt(codeColumn.substring(column_i, column_i + 1)) + parseInt(codeRow.substring(row_i, row_i + 1)) * 2;
                    code = temp_Num.toString(10) + code;
                }
                for (var temp_column_i = column_i; temp_column_i > -1; temp_column_i--) {
                    code = codeColumn.substring(temp_column_i, temp_column_i + 1) + code;
                }
            }
            else {
                codeColumn = parseInt(codeColumn);
                //codeRow 与行编号相关值
                codeRow = parseInt(codeRow) * 2;
                code = codeColumn + codeRow;
            }
            code = code.toString(10);
            var codeLength = code.length;
            if (code.length < this.data.currentLevel) {
                for (var lackZero = 0; lackZero < this.data.currentLevel - codeLength; lackZero++) {
                    code = "0" + code;
                }
            }
        }
        return path + "r" + code + ".png?g=68";
        //日本的
        //ecn.t1.tiles.virtualearth.net/tiles/r13201?g=637&mkt=ja-jp&lbl=l1&stl=h&shading=hill&n=z
    }
}