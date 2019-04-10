var getOffset = {
    top: function (obj) {
        return obj.offsetTop + (obj.offsetParent ? arguments.callee(obj.offsetParent) : 0)
    },
    left: function (obj) {
        return obj.offsetLeft + (obj.offsetParent ? arguments.callee(obj.offsetParent) : 0)
    }
};
function MouseMenu(obj, tagname, rightMenu) {
    try {
        var oMenu = obj.document.getElementById(rightMenu);
        var aUl = oMenu.getElementsByTagName("ul");
        var aLi = oMenu.getElementsByTagName("li");

        var i = 0;
        var maxWidth = maxHeight = 0;
        var aDoc = [obj.document.documentElement.offsetWidth, obj.document.documentElement.offsetHeight];
        //锁定
        var locked = obj.GetTextByName("Lang_Lock", obj.useprameters.languagedata);//锁定
        var unlocked = obj.GetTextByName("Lang_unlocked", obj.useprameters.languagedata);//解锁
        //关注
        var concern = obj.GetTextByName("Lang_concern", obj.useprameters.languagedata);
        var unconcern = obj.GetTextByName("Lang_unconcern", obj.useprameters.languagedata);
        
        oMenu.style.display = "none";

        for (var i = 0; i < aLi.length; i++) {
            //锁定项，判断当前警员的锁定状态
            if (aLi[i].id == "locked") {
                if (obj.useprameters.lockid == obj.useprameters.rightselectid) {
                    aLi[i].innerHTML = unlocked;
                }
                else {
                    aLi[i].innerHTML = locked;
                }
            }
            //判断当前警员的关注状态
            if (aLi[i].id == "Lang_concern") {                
                if (Isconcernedbydispatcher(obj,obj.useprameters.rightselectid)) {
                    aLi[i].innerHTML = unconcern;
                }
                else {
                    aLi[i].innerHTML = concern;
                }
            }

            //为含有子菜单的li加上箭头
            aLi[i].getElementsByTagName("ul")[0] && (aLi[i].className = "sub");
        }

        //自定义右键菜单     
        var elm = getElementsByClassName(document, tagname, "hasleftmenu");

        for (var j = 0; j < elm.length; j++) {
            oElement = elm[j];
            oElement.onclick = function (event) {
                MouseMenu_onclick(obj, rightMenu);
            };
        }
        oMenu.onmouseleave = function () {
            HideRightMenu(obj, rightMenu);
        };
        //点击隐藏菜单
        document.oncontextmenu = function () {
            oMenu.style.display = "none";
            return false;
        }

    }
    catch (e) {
        alert("MouseMenu" + e);
    }
}
function MouseMenu_onclick(obj, rightMenu) {
    var showTimer = hideTimer = null;
    var aDoc = [obj.document.documentElement.offsetWidth, obj.document.documentElement.offsetHeight];
    var locked = obj.GetTextByName("Lang_Lock", obj.useprameters.languagedata);//锁定
    var unlocked = obj.GetTextByName("Lang_unlocked", obj.useprameters.languagedata);//解锁
    //关注
    var concern = obj.GetTextByName("Lang_concern", obj.useprameters.languagedata);
    var unconcern = obj.GetTextByName("Lang_unconcern", obj.useprameters.languagedata);
    //实时轨迹
    var openRealtimeTrace = obj.GetTextByName("Text_OpenRealTimeTrajectory", obj.useprameters.languagedata);
    var closeRealtimeTrace = obj.GetTextByName("Text_CloseRealTimeTrajectory", obj.useprameters.languagedata);

    obj.document.getElementById("mouseMenu").style.display = "block";
    if (rightMenu != "policemouseMenu") {
        obj.document.getElementById("policemouseMenu").style.display = "none";
    }
    if (rightMenu != "groupmouseMenu") {
        obj.document.getElementById("groupmouseMenu").style.display = "none";
    }
    if (rightMenu != "dispatchmouseMenu") {
        obj.document.getElementById("dispatchmouseMenu").style.display = "none";
    }
    if (rightMenu != "carDutyMenu") {
        obj.document.getElementById("carDutyMenu").style.display = "none";
    }
    var all_li;
    if (rightMenu == "policemouseMenu" && obj.useprameters.rightselectTerminalIsValide == "0") {
        all_li = obj.document.getElementById(rightMenu + "_invalide").getElementsByTagName("li");
    }
    else {
        all_li = obj.document.getElementById(rightMenu).getElementsByTagName("li");
    }
    for (var i = 0; i < all_li.length; i++) {
        //鼠标移入
        all_li[i].onmouseover = function () {
            var oThis = this;
            var oUl = oThis.getElementsByTagName("ul");

            //鼠标移入样式
            oThis.className += " active";

            //显示子菜单
            if (oUl[0]) {
                clearTimeout(hideTimer);
                showTimer = setTimeout(function () {
                    for (var m = 0; m < oThis.parentNode.children.length; m++) {
                        oThis.parentNode.children[m].getElementsByTagName("ul")[0] &&
                        (oThis.parentNode.children[m].getElementsByTagName("ul")[0].style.display = "none");
                    }
                    oUl[0].style.display = "block";
                    oUl[0].style.top = (oThis.offsetTop) + "px";
                    oUl[0].style.left = (oThis.offsetWidth + 5) + "px";
                    setWidth(oUl[0]);

                    //最大显示范围     
                    maxWidth = aDoc[0] - oUl[0].offsetWidth;
                    maxHeight = aDoc[1] - oUl[0].offsetHeight;

                    //防止溢出
                    maxWidth < getOffset.left(oUl[0]) && (oUl[0].style.left = -oUl[0].clientWidth + "px");
                    maxHeight < getOffset.top(oUl[0]) && (oUl[0].style.top = -oUl[0].clientHeight + oThis.offsetTop + oThis.clientHeight + "px");
                }, 100);
            }
        }
        //鼠标移出 
        all_li[i].onmouseout = function () {
            var oThis = this;
            var oUl = oThis.getElementsByTagName("ul");
            //鼠标移出样式
            oThis.className = oThis.className.replace(/\s?active/, "");

            clearTimeout(showTimer);
            hideTimer = setTimeout(function () {
                for (i = 0; i < oThis.parentNode.children.length; i++) {
                    oThis.parentNode.children[i].getElementsByTagName("ul")[0] &&
                    (oThis.parentNode.children[i].getElementsByTagName("ul")[0].style.display = "none");
                }
            }, 300);
        }
        if (all_li[i].id == "locked") {
            if (obj.useprameters.lockid == obj.useprameters.rightselectid) {
                all_li[i].innerHTML = unlocked;
            }
            else {
                all_li[i].innerHTML = locked;
            }
        }
        //判断当前警员的关注状态
        if (all_li[i].id == "Lang_concern") {
            if (Isconcernedbydispatcher(obj, obj.useprameters.rightselectid)) {
                all_li[i].innerHTML = unconcern;
            }
            else {
                all_li[i].innerHTML = concern;
            }
        }
        //判断当前警员的实时轨迹状态
        if (all_li[i].id == "Text_OpenRealTimeTrajectory") {
            if (IsOpenRealtimeTracebydispatcher(obj, obj.useprameters.rightselectid)) {
                all_li[i].innerHTML = closeRealtimeTrace;
            }
            else {
                all_li[i].innerHTML = openRealtimeTrace;
            }
        }
        //判断当前警员的终端类型,确定是否显示视频调度
        if (all_li[i].id == "Lang_videoDispatch") {
            if (obj.useprameters.rightselectTerminalType == "LTE") {
                all_li[i].style.display = "none";
            }
            else {
                all_li[i].style.display = "none";
            }
        }
        //判断当前警员的终端类型,确定是否显示卫星数
        if (all_li[i].id == "Lang_weixingshu") {
            if (obj.useprameters.rightselectTerminalType == "BEIDOU") {
                all_li[i].style.display = "none";
            }
            else {
                all_li[i].style.display = "none";
            }
        }
    }
    var oMenu;
    if (rightMenu == "policemouseMenu" && obj.useprameters.rightselectTerminalIsValide == "0") {
        obj.document.getElementById("policemouseMenu").style.display = "none";
        oMenu = obj.document.getElementById(rightMenu + "_invalide");
    }
    else {
        obj.document.getElementById("policemouseMenu_invalide").style.display = "none";
        oMenu = obj.document.getElementById(rightMenu);
    }
    var aUl = oMenu.getElementsByTagName("ul");
    var event = event || window.event;
    oMenu.style.display = "block";
    if (rightMenu == "policemouseMenu" || rightMenu == "carDutyMenu") {
        //oMenu.style.left =480 + "px";
        oMenu.style.left = (event.screenX + 5) + "px";
        oMenu.style.top = (event.screenY - 118) + "px";
    }
    else {
        oMenu.style.left = (event.screenX + 2) + "px";
        oMenu.style.top = (event.clientY + 50) + "px";
    }


    setWidth(aUl[0]);

    //最大显示范围
    maxWidth = aDoc[0] - oMenu.offsetWidth;
    maxHeight = aDoc[1] - oMenu.offsetHeight;

    //防止菜单溢出
    //oMenu.offsetTop > maxHeight && (oMenu.style.top = maxHeight + "px");
    //oMenu.offsetLeft > maxWidth && (oMenu.style.left = maxWidth + "px");
    return false;
}

//取li中最大的宽度, 并赋给同级所有li 
function setWidth(obj) {
    maxWidth = 0;
    for (i = 0; i < obj.children.length; i++) {
        var oLi = obj.children[i];
        var iWidth = oLi.clientWidth - parseInt(oLi.currentStyle ? oLi.currentStyle["paddingLeft"] : getComputedStyle(oLi, null)["paddingLeft"]) * 2
        if (iWidth > maxWidth) maxWidth = iWidth;
    }
    for (i = 0; i < obj.children.length; i++) obj.children[i].style.width = maxWidth + "px";
}

function getElementsByClassName(oElm, strTagName, strClassName) {
    var arrElements = (strTagName == "*" && oElm.all) ? oElm.all :
        oElm.getElementsByTagName(strTagName);
    var arrReturnElements = new Array();
    strClassName = strClassName.replace(/\-/g, "\\-");
    var oRegExp = new RegExp("(^|\\s)" + strClassName + "(\\s|$)");
    var oElement;
    for (var i = 0; i < arrElements.length; i++) {
        oElement = arrElements[i];
        if (oRegExp.test(oElement.className)) {
            arrReturnElements.push(oElement);
        }
    }
    return (arrReturnElements);
}
function HideRightMenu(obj, rightMenu) {
    //obj.document.getElementById(rightMenu).style.display = "none";
    window.parent.map.removeLayer(window.parent.circleLayer);
    window.parent.IsDrawCircle = 0;
    (window.parent.map.getView()).un("change:resolution", window.parent.sbegainDraw);
    //(window.parent.map.getViewport()).removeEventListener("mousewheel", window.parent.sbegainDraw);
    (window.parent.map.getViewport()).removeEventListener("mouseup", window.parent.sbegainDraw);
    window.parent.document.getElementById("contextmenu_container2").parentNode.style.display = "none";
    window.parent.document.getElementById("contextmenu_container").parentNode.style.display = "none";
}





function Isconcernedbydispatcher(obj,id)
{
    var concernusers_array = obj.useprameters.concernusers_array;
    var concernids_length = concernusers_array.length;
    if (concernids_length != 0) {
        for (var i = 0; i < concernids_length; i++) {
            if (concernusers_array[i] == id) {
                return true;
            }
        }
        return false;
    }
    else {
        return false;
    }
}

function IsOpenRealtimeTracebydispatcher(obj, id) {
    var realtimeTraceUserIds = obj.useprameters.realtimeTraceUserIds;
    var concernids_length = realtimeTraceUserIds.length;
    if (concernids_length != 0) {
        for (var i = 0; i < concernids_length; i++) {
            if (realtimeTraceUserIds[i] == id) {
                return true;
            }
        }
        return false;
    }
    else {
        return false;
    }
}