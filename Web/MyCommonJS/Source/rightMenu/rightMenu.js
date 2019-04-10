//document.oncontextmenu = function () {
//   // return false;
//}
function right_colorChange(obj, color) {
    obj.style.backgroundColor = color;
}
function createMenu(array) {
    if (!array) { return null; }
    var rightMenu = document.getElementById("rightMenu");
    if (rightMenu) {
        delObj(rightMenu);
    }
    var divContainer = document.createElement("div");
    divContainer.style.cursor = "default";
    divContainer.style.borderStyle = "solid";
    divContainer.style.borderWidth = "1px";
    divContainer.style.borderColor = "green";
    divContainer.style.fontSize = "13px";
    divContainer.style.backgroundColor = "white";
    divContainer.id = "rightMenu";
    divContainer.style.width = "70px";
    divContainer.style.position = "absolute";
    divContainer.style.zIndex = 999;
    for (var menu in array) {
        if (typeof (array[menu]) != "function") {
            var divTr = document.createElement("div");
            divTr.innerHTML = array[menu][2];
            divTr.fun = array[menu][0];
            divTr.arg = array[menu][1];
            divTr.style.margin = "2px";
            divContainer.appendChild(divTr);
            divTr.onmouseover = function () {
                right_colorChange(this, 'green');
            };
            divTr.onmouseout = function () {
                right_colorChange(this, 'white');
            };
            divTr.onclick = function () {
                this.fun(this.arg);
            };
        }
    }
    divContainer.onmouseleave = function () {
        delObj("rightMenu");
    };
    return divContainer;
}
