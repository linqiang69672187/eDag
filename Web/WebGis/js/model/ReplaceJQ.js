//替换fadeTo(),显示地图图片
function DisplayMap() {
    var MapDivs = document.getElementsByTagName("div");
    for (var i = 0; i < MapDivs.length; i++) {
        if (MapDivs[i].id.substring(0, 3) == "map") {
            MapDivs[i].style.display = "block";
        }
    }
}