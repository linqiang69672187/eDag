tr = null;
function geturl() {
    var str = window.location.href;
    str = str.substring(str.lastIndexOf("/") + 1)
    str = str.split(".")[0];
    return str;
}
function changeTgBg(obj, TG, n) {

    obj.style.backgroundColor = "#0D9F1B"; obj.style.color = '#ffffff';
    if (n) {
        var containsTG = obj.getElementsByTagName(TG);
        if (containsTG[n]) { containsTG[n].style.color = '#ffffff'; }
    }
}
function overchangeTgBg(obj, TG, n) {
    obj.style.backgroundColor = "#FFFFFF"; obj.style.color = '#000000';
    if (n) {
        var containsTG = obj.getElementsByTagName(TG);
        if (!containsTG[n])
            return;
        containsTG[n].style.color = '#000000';
    }
}
    String.prototype.trim = function () {
        return this.replace(/(^\s*)|(\s*$)/g, "");
    } 



