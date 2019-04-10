//此JS为了更方便的执行JS事件
//连接两个数组并剔除相同项,返回数组
function concatDistinct(ary1, ary2) {
    var retAry = new Array();
    Array.prototype.push.apply(retAry, ary2); //copy ary2 to retAry
    for (var ary1_i = 0; ary1_i < ary1.length; ary1_i++) {
        for (var retAry_i = 0; retAry_i < retAry.length; retAry_i++) {
            if (retAry[retAry_i] == ary1[ary1_i]) {//retAry has exist
                break;
            }
            if (retAry_i == retAry.length - 1) {//add ary1 to retAry
                retAry.push(ary1[ary1_i]);
            }
        }
    }
    return retAry;
}
function delObj(obj) {
    if (typeof (obj) == "string") {
        obj = document.getElementById(obj);
    }
    if (obj) {
        //庞小斌修改，更改节点移除方法
        removeChildSafe(obj);
    }
}
//openWindow,add a frame in div to page,and show div
//XHTML 1.0(不支持VML) is different from HTML 4.0
function newDivFrame(id, father, frameSrc, headText, src, headBackUrl, closeEventName) {
    if (typeof (father) == "string") {
        father = document.getElementById(father);
    }
    if (!src) {
        src = "MyCommonJS/Source/openDiv/infowindow_close.gif";
    }
    if (!headBackUrl) {
        headBackUrl = "Images/bgbj.gif";
    }
    if (closeEventName) {
        closeEventName = "window.parent." + closeEventName + "();";
    }
    else {
        closeEventName = "";
    }
    if (!document.getElementById(id)) {
        //create div
        var frame = document.createElement("iframe");
        frame.id = id + "_ifr";
        frame.src = frameSrc;
        frame.width = "100%";
        frame.height = "100%";
        frame.scrolling = "no";
        frame.frameBorder = "no";

        var div = document.createElement("div");
        div.id = id;
        div.style.zIndex = "2";
        div.style.backgroundImage = "url(" + headBackUrl + ")";
        div.classname = "div_iframe";
        div.style.position = "absolute";
        div.style.cursor = "move";
        div.style.overflow = "hidden";
        //div.style.border = "solid 1px #999999";
        div.style.display = "none";
        //add drag event
        div.onmousedown = function () { oldmystartDragWindow(this) };
        div.onmouseup = function () { mystopDragWindow(this) };
        div.onmousemove = function () { oldmydragWindow(this) };
        if (headText) {
            div.innerHTML = "<div style='width: 100%; background-image: url(" + headBackUrl + ");'><div style='width: 90%; text-align: center; float: left;'><span style='font-size: 14px;'>" + headText + "</span></div><div style='right: 2px; position: absolute;'><img id='img_" + id + "'" + " src='" + src + "' onclick=ShowDivPage('" + id + "');" + closeEventName + " style='margin: 2px;cursor: default;' runat='server' /></div></div>"
        }
        else {
            div.innerHTML = "<div style='width: 100%; background-image: url(" + headBackUrl + ");'><div style='right: 2px; position: absolute;'><img id='img_" + id + "'" + " src='" + src + "' onclick=ShowDivPage('" + id + "');" + closeEventName + " style='margin: 2px;cursor: default;' runat='server' /></div></div>"
        }
        if (closeEventName)
        { }
        div.appendChild(frame);
        father.appendChild(div);
    }
}
///------------------------------已过时 新项目不再续用
var mywin_isMoving = false; //是否拖动
var mywin_space_x;
var mywin_space_y;
var win_isMoving;
/**
* 开始拖动
*/
function oldmystartDragWindow(obj, moveObj) {
    if (event.button == 1) {// && event.srcElement.tagName.toUpperCase() == "DIV"
        obj.setCapture();
        var cur_window;
        if (moveObj)
            cur_window = moveObj;
        else
            cur_window = obj;
        win_space_x = window.event.clientX - parseInt(cur_window.offsetLeft);
        win_space_y = window.event.clientY - parseInt(cur_window.offsetTop);
        win_isMoving = true;
    }
}
/**
* 拖动
*/
function oldmydragWindow(obj) {
    if (win_isMoving) {
        var cur_window = obj;
        cur_window.style.left = window.event.clientX - win_space_x + "px";
        cur_window.style.top = window.event.clientY - win_space_y + "px";
    }
}

function mystartDragWindow(obj, moveObj, myevent) {
    var newevent = myevent || event;
    if (newevent.button == 0) {// && event.srcElement.tagName.toUpperCase() == "DIV"
        obj.setCapture();
        var cur_window;
        if (moveObj)
            cur_window = moveObj;
        else
            cur_window = obj;
        win_space_x = newevent.clientX   //- parseInt(cur_window.offsetLeft);
        win_space_y = newevent.clientY  // - parseInt(cur_window.offsetTop);
        win_isMoving = true;
    }
}
/**
* 拖动
*/
function mydragWindow(obj, myevent) {
    var newevent = myevent || event;
    if (win_isMoving) {
        var cur_window = obj;
        cur_window.style.left = newevent.clientX - win_space_x + "px";

        if (parseFloat(cur_window.style.top) < 35) {
            win_isMoving = false;
            cur_window.style.top = "35px";

        }
        else {
            cur_window.style.top = newevent.clientY - win_space_y + "px";
        }
    }
}
/**
* 结束拖动
*/

function mystopDragWindow(obj) {
    obj.releaseCapture();
    win_isMoving = false;
}

//设置div位置居中
function divCenter(div) {
    div.style.left = (parseFloat(document.documentElement.clientWidth) - parseFloat(div.style.width)) / 2;
    div.style.top = (parseFloat(document.documentElement.clientHeight) - parseFloat(div.style.height)) / 2;
}
//设置元素所有子元素disabled,可适用与不同tr设置
function isTrDisabled(isTrue, obj) {
    if (obj.disabled != undefined)
        obj.disabled = isTrue;
    else
        return;
    if (obj.childNodes) {
        for (var obj_i = 0; obj_i < obj.childNodes.length; obj_i++) {
            isTrDisabled(isTrue, obj.childNodes[obj_i]);
        }
    }
}
//通过获取相同name chk集合来进行全选，可用于DataGrid全选/取消   2010/1/8
function isSelectAll_bychk_name(chkAllobj, chk_name) {
    for (var chk_i = 0; chk_i < document.getElementsByName(chk_name).length; chk_i++) {
        document.getElementsByName(chk_name)[chk_i].checked = $(chkAllobj.id).checked;
    }
}
//取消chk所有选择
function clear_rdoListChoise(obj_id) {
    var rdo_len = document.getElementById(obj_id).getElementsByTagName('input').length;
    var selValue = 0;
    for (var i = 0; i < rdo_len; i++) {
        var child_id = obj_id + "_" + i.toString();
        if (document.getElementById(child_id).checked) //注意checked不能写成Checked，要不然不成功
        {
            document.getElementById(child_id).checked = false;
            break;
        }
    }
}
//通过获取包含 chk集合来进行全选，可用于DataGrid全选/取消 2010/6/7
function isSelectAll_byFatherId(chkAllobj, fatherId) {
    var chks = document.getElementById(fatherId).getElementsByTagName('input');
    for (var chks_i = 0; chks_i < chks.length; chks_i++) {
        if (typeof (chks[chks_i] == 'checkbox')) {
            chks[chks_i].checked = chkAllobj.checked;
        }
    }
}
//chkList全选/取消  2010/1/6
function isSelectAll(obj_id) {
    var i = 0;
    for (var cbl_market_i = 0; cbl_market_i < $(obj_id).getElementsByTagName('input').length; cbl_market_i++) {
        if ($(obj_id).getElementsByTagName('input')[cbl_market_i].checked) {
            i++;
        }
    }
    if (i == $(obj_id).getElementsByTagName('input').length) {
        for (var cbl_market_i = 0; cbl_market_i < $(obj_id).getElementsByTagName('input').length; cbl_market_i++) {
            if ($(obj_id).getElementsByTagName('input')[cbl_market_i].checked) {
                $(obj_id).getElementsByTagName('input')[cbl_market_i].checked = false;
            }
        }
    }
    else {
        for (var cbl_market_i = 0; cbl_market_i < $(obj_id).getElementsByTagName('input').length; cbl_market_i++) {
            if (!$(obj_id).getElementsByTagName('input')[cbl_market_i].checked) {
                $(obj_id).getElementsByTagName('input')[cbl_market_i].checked = true;
            }
        }
    }
}
var lastEvent_x = false; //用来考虑事件丢失后还能定位的情况，如使用setTimeout后执行ShowDivPage
var lastEvent_y = false;
//显示隐藏DIV 此函数可用于弹出页面的情况 详见 2010/1/8
//isRight 是否显示在右下角
//是否是对visibility进行控制，而非display
function ShowDivPage(div, isRight, isVisibility) {
    if (typeof (div) == "string") {
        div = document.getElementById(div);
    }
    if (div) {
        if (div.style.display == 'none') {
            if (isRight) {
                var x;
                var y;
                if (lastEvent_x && lastEvent_y) {
                    x = lastEvent_x;
                    y = lastEvent_y + 20;
                    lastEvent_x = false;
                    lastEvent_y = false;
                }
                else {
                    x = event.clientX - 160;
                    y = event.clientY;
                }

                div.style.left = x;
                div.style.top = y;
            }
            if (isVisibility) {
                div.style.visibility = "visible";
            }
            else {
                div.style.display = "block";
            }
        }
        else {
            if (isVisibility) {
                div.style.visibility = "hidden";
            }
            else {
                div.style.display = "none";
            }
        }
    }
}
//添加委托处理函数
function addDelegate(delegate, param) {
    for (var i in delegate) {
        if (typeof (delegate[i]) == "function") {
            var arrParam = Array.prototype.slice.call(arguments, 1);
            delegate[i].apply(this, arrParam);
        }
    }
}
Math.evPoint = function (ev) {
    ev = ev || window.event;
    return {
        "x": parseInt(ev.clientX == undefined ? ev.pageX : ev.clientX),
        "y": parseInt(ev.clientY == undefined ? ev.pageY : ev.clientY)
    }
}
//添加事件监听器基础类
function BaseListener() {
    this.listener = {
        "eventName": {}
    }
    //funName--如对象函数体相同可特意区别的如用对象id（重载addEventListener专门针对函数体相同的情况区分）
    this.addEventListener2 = function (eventName, fun, param, funName) {//事件名称,监听器函数
        if (!this.listener[eventName]) {
            this.listener[eventName] = {};
        }
        var funKey = fun;
        if (funName != undefined) {
            funKey = funName;
        }
        if (!this.listener[eventName][funKey]) {
            this.listener[eventName][funKey] = {};
        }
        this.listener[eventName][funKey].fun = fun;
        this.listener[eventName][funKey].param = Array.prototype.slice.call(arguments, 2);
    }
    //增加监听器
    //eventName--添加到的事件名称,fun--函数体,param--参数
    this.addEventListener = function (eventName, fun, param, fun2) {//事件名称,监听器函数
        if (!this.listener[eventName]) {
            this.listener[eventName] = {};
        }
        if (!this.listener[eventName][fun]) {
            this.listener[eventName][fun] = {};
        }
        this.listener[eventName][fun].fun = fun;
        this.listener[eventName][fun].param = Array.prototype.slice.call(arguments, 2);
    }
    this.removeEventListener2 = function (eventName, fun, funName) {
        var funKey = fun;
        if (funName != undefined) {
            funKey = funName;
        }
        if (this.listener[eventName]) {
            delete this.listener[eventName][fun];
        }
    }
    this.removeEventListener = function (eventName, fun) {
        if (this.listener[eventName]) {
            delete this.listener[eventName][fun];
        }
    }
    //在类函数中添加该函数
    //param--执行事件传入的参数 在所有参数最后面
    this.execEventListener = function (eventName, param) {
        var paramFromExec = Array.prototype.slice.call(arguments, 1);
        for (var fun_i in this.listener[eventName]) {
            var funObj = this.listener[eventName][fun_i];
            if (funObj.fun && typeof (funObj.fun) == "function") {
                var _param = funObj.param === undefined ? new Array() : funObj.param;
                if (paramFromExec) {
                    _param = _param.concat(paramFromExec);
                }
                funObj.fun.apply(null, _param);
            }
        }
    }
}
//拖动对象 支持只x轴或者y轴拖动
function ObjMoving() {
    BaseListener.apply(this);
    this.data = {
        "captureObj": null, //用来选中的对象
        "moveObj": null, //指定对象拖动
        "min": null,
        "max": null,
        "isY": 0, //是否只在y轴拖动--2 ;x--1,0--随意拖动
        "otherParam": null, //自定义参数
        "movedX": null, //移动的距离
        "movedY": null,
        "startTime": null, //开始拖动时间 new Date()
        "iCutDisArray": false, //是否开启记录截断数据记录功能
        "cutDisArray": new Array(), //[{ moved: { x: null, y: null }, time: null}] 每隔相同距离记录离初始偏移位置与时间点
        "endTime": null,
        "iEnable": true//设置false可使该拖动失效
    }
    this.privateData = {//private
        "isMoving": false,
        "win_space_x": null,
        "win_space_y": null,
        "init_clientX": null,
        "init_clientY": null,
        "numberOfPixel_cutDis": 3, //每个截段多少个像素 必须>1
        "indexOfPixel_cutDis": 1//所在当前截段数据中的像素
    }
    this.init = function () {
        this.data.captureObj.ObjMoving = this;
        this.data.captureObj.style.position = "absolute";
        this.data.captureObj.onmousedown = this.startMove; //覆盖事件方式，this指针就是DOM本身，否者用添加方式的话则是document
    }
    this.document_onmousemove = function (ev) {
        if (document.ObjMoving && document.ObjMoving.moving) {
            document.ObjMoving.moving.call(document.ObjMoving, ev);
        }
    }
    this.startMove = function (ev) {

        //writeLog("startMove开始");
        //IE中这里返回会产生问题
        //init movedDis
        var cj = document.getElementById("cloose");

        if (useprameters.lockid != 0 || useprameters.IsloadMapin || cj.src.indexOf("Images/ToolBar/rightbg/choose_un.png") > 0 || isBegSendMsgSel == true || isBegStackadeSel == true)
            return;
        useprameters.IsloadMapin = true;

        //庞小斌修改，减少地图停顿时间
        setTimeout(function () { useprameters.IsloadMapin = false }, 200);

        this.ObjMoving.data.movedX = 0;
        this.ObjMoving.data.movedY = 0;
        if (this.ObjMoving.data.iCutDisArray) {
            this.ObjMoving.data.cutDisArray = new Array(); //重置截断数据
        }
        ev = ev || window.event;
        if (!Math.iLeftButton(ev)) {
            return;
        }
        if (this.ObjMoving.data.captureObj.setCapture) {
            this.ObjMoving.data.captureObj.setCapture();
        }
        if (this.ObjMoving.data.iEnable)//这里的iEnable只起到禁止其它事件的作用
        {
            this.ObjMoving.execEventListener("startMove");
        }
        if (!this.ObjMoving.data.moveObj) {
            this.ObjMoving.data.moveObj = this.ObjMoving.data.captureObj;
        }
        this.ObjMoving.privateData.init_clientX = Math.evPoint(ev).x;
        this.ObjMoving.privateData.init_clientY = Math.evPoint(ev).y;
        this.ObjMoving.privateData.win_space_x = Math.evPoint(ev).x - parseInt(this.ObjMoving.data.moveObj.offsetLeft);
        this.ObjMoving.privateData.win_space_y = Math.evPoint(ev).y - parseInt(this.ObjMoving.data.moveObj.offsetTop);
        this.ObjMoving.privateData.isMoving = true;
        document.ObjMoving = this.ObjMoving;
        if (document.attachEvent) {
            document.attachEvent("onmousemove", this.ObjMoving.document_onmousemove);
            document.attachEvent("onmouseup", this.ObjMoving.stopMove);
        }
        if (document.addEventListener) {
            document.addEventListener("mousemove", this.ObjMoving.document_onmousemove, false);
            document.addEventListener("mouseup", this.ObjMoving.stopMove, false);
        }
        document.ObjMoving.data.startTime = new Date();
        return false; //取消其它事件,防止事件冲突
        //writeLog("startMove结束");
    }
    this.moving = function (ev) {
        if (useprameters.lockpcmove == true && useprameters.lockid != 0)
            return;
        //writeLog("moving开始");
        if (!this.data.iEnable) {
            if (this.data.captureObj.releaseCapture) {
                this.data.captureObj.releaseCapture();
            }
            return false;
        }
        if (!this.privateData.isMoving) return false;

        //庞小斌修改，开始拖动时隐藏警员级其他元素
        hideitemsonmap();

        ev = ev || window.event;
        this.execEventListener("moving", ev);
        var left = Math.evPoint(ev).x - this.privateData.win_space_x;
        var top = Math.evPoint(ev).y - this.privateData.win_space_y;
        if (this.data.min && top < this.data.min) top = this.data.min;
        if (this.data.max && top > this.data.max) top = this.data.max;
        if (this.data.isY == 2) {
            this.data.moveObj.style.top = top + "px";
        }
        else if (this.data.isY == 1) {
            this.data.moveObj.style.left = left + "px";
        }
        else {
            this.data.moveObj.style.top = top + "px";
            this.data.moveObj.style.left = left + "px";
        }
        this.data.movedX = Math.evPoint(ev).x - this.privateData.init_clientX;
        this.data.movedY = Math.evPoint(ev).y - this.privateData.init_clientY;

        //每隔相同距离记录偏移位置与间隔时间
        if (this.data.iCutDisArray) {
            if (this.privateData.indexOfPixel_cutDis % this.privateData.numberOfPixel_cutDis == 1)//在截断开始位置记录数据
            {
                var currentDisData = { moved: { x: this.data.movedX, y: this.data.movedY }, time: new Date() };
                this.data.cutDisArray.push(currentDisData);
            }
            if (this.privateData.indexOfPixel_cutDis % this.privateData.numberOfPixel_cutDis == 0)//在截断结束位置重置记点器
            {
                this.privateData.indexOfPixel_cutDis = 1;
            }
            else {//不是结束位置就+1
                this.privateData.indexOfPixel_cutDis = this.privateData.indexOfPixel_cutDis + 1;
            }
        }
        // writeLog("moving结束");
        return false;
    }
    this.remove_mouseMove_mouseupEvent = function () {
        if (!document.ObjMoving) return;
        if (document.detachEvent && document.ObjMoving.document_onmousemove && document.ObjMoving.stopMove) {
            document.detachEvent("onmousemove", document.ObjMoving.document_onmousemove);
            document.detachEvent("onmouseup", document.ObjMoving.stopMove);
        }
        if (document.removeEventListener) {
            document.removeEventListener("mousemove", document.ObjMoving.document_onmousemove, false);
            document.removeEventListener("mouseup", document.ObjMoving.stopMove, false);
        }
    }
    this.stopMove = function (ev) {
        document.ObjMoving = document.ObjMoving || this.ObjMoving; //处理可能出现的document.ObjMoving不存在情况，暂时不知道为什么
        if (!document.ObjMoving || !document.ObjMoving.data || !document.ObjMoving.data.iEnable) return false;
        if (!document.ObjMoving.privateData.isMoving) return false;
        ev = ev || window.event;
        if (!Math.iLeftButton(ev)) {
            return false;
        }
        if (document.ObjMoving.data.captureObj.releaseCapture) {
            document.ObjMoving.data.captureObj.releaseCapture();
        }
        document.ObjMoving.privateData.isMoving = false;
        if (document.detachEvent) {
            document.detachEvent("onmousemove", document.ObjMoving.document_onmousemove);
            document.detachEvent("onmouseup", document.ObjMoving.stopMove);
        }
        if (document.removeEventListener) {
            document.removeEventListener("mousemove", document.ObjMoving.document_onmousemove, false);
            document.removeEventListener("mouseup", document.ObjMoving.stopMove, false);
        }
        document.ObjMoving.data.endTime = new Date();
        if (!document.ObjMoving.data.movedX && !document.ObjMoving.data.movedY) {
            document.ObjMoving.data.movedX = 0;
            document.ObjMoving.data.movedY = 0;
        }
        try {
            
            //隐藏鼠标点击菜单
            if (document.getElementById("mouseMenu") != undefined) {
                document.getElementById("mouseMenu").style.display = "none";
            }
        }
        catch (e) { //alert("MoveXY" + e);
        }
        document.ObjMoving.execEventListener("stopMove");
        document.ObjMoving = null;
        //庞小斌修改，结束拖动时显示警员及其他元素
        displayitemsonmap();
        
        return false;
    }
    this.turnOnMove = function () {
        this.data.iEnable = true;
    }
    this.turnOffMove = function () {
        this.data.iEnable = false;
    }
}
//加速度移动类
function MoveAcceleration() {
    BaseListener.apply(this);
    this.data = {
        "obj": null,
        "s0": { x: null, y: null }, //初始位置
        "v0": { x: null, y: null }, //初始速度 unit--像素/s
        "a": { x: null, y: null }, //加速度 unit 像素/(s的平方)
        "timeSpace": 10, //位移时间间隔 unit--mm
        "startMoveInterval": null, //
        "iStop": true, //运动状态 
        "stopTime": null, //停止运动时间 unit--ms 必须是timeSpace的倍数
        "time": 0//当前时间点 unit--ms
    }
    this.formula = {
        "s": function (t) {//根据时间点获取位置 由v0、a、t推出S unit--ms
            //time单位这里转换为s 除以1000
            var s_x = this.data.v0.x * t / 1000 + this.data.a.x * Math.pow(t / 1000, 2) / 2;
            var s_y = this.data.v0.y * t / 1000 + this.data.a.y * Math.pow(t / 1000, 2) / 2;
            return { x: +s_x, y: +s_y };
        },
        "a": function (vt) {//根据Vt获取加速度 由v0、t、vt推出a Vt--{x:value,y:value}
            var a_x = (vt.x - this.data.v0.x) / (this.data.stopTime / 1000);
            var a_y = (vt.y - this.data.v0.y) / (this.data.stopTime / 1000);
            return { x: +a_x, y: +a_y };
        },
        "v0": function (S, vt) {//根据运行路程获取初始速度 由S、vt、t推出 S--{x:value,y:value} vt--{x:value,y:value}
            var v0_x = (2 * S.x / (this.data.stopTime / 1000)) - vt.x;
            var v0_y = (2 * S.y / (this.data.stopTime / 1000)) - vt.y;
            return { x: +v0_x, y: +v0_y };
        }
    }
    this.init = function () {
        this.data.s0.x = this.data.obj.style.left == "" ? parseInt(this.data.obj.offsetLeft) : parseInt(this.data.obj.style.left);
        this.data.s0.y = this.data.obj.style.top == "" ? parseInt(this.data.obj.offsetTop) : parseInt(this.data.obj.style.top);
    }
    this.startMove = function () {
        this.data.iStop = false;
        this.execEventListener("startMove");
        if (this.data.iStop) return;
        this.data.startMoveInterval = L.setInterval(this.positionSetByTime, this.data.timeSpace, this);
    }
    this.positionSetByTime = function (cls, time) {
        var ths = cls || this; //赋值 类
        if (time) {
            time = time;
        }
        else {//时间递增
            ths.data.time = +ths.data.time + ths.data.timeSpace;
            time = ths.data.time;
        }
        try {
            var distance = ths.formula.s.call(ths, time);
            ths.data.obj.style.left = parseInt(ths.data.s0.x) + distance.x + "px";
            ths.data.obj.style.top = parseInt(ths.data.s0.y) + distance.y + "px";
            if (ths.data.time == ths.data.stopTime) {
                ths.stopMove();
            }
            ths.execEventListener("positionSetByTime");
        }
        catch (err) {
        }


    }
    this.stopMove = function (iNoEventListener) {
        this.data.iStop = true;
        if (this.data.startMoveInterval) {
            window.clearInterval(this.data.startMoveInterval);
        }
        if (!iNoEventListener) {//为了处理不需要执行添加的事件的情况
            this.execEventListener("stopMove");
        }
    }
}
//队列类--将定时事件放入队列逐个执行(执行完后直接删除该事件)，必须在每个事件结束时指向下个开始事件、以及删除该事件(即execEvent)
function Queue() {
    BaseListener.apply(this);
    this.data = {
        queue: { type: { data: new Array(), iExecuting: false } }//type.data--{ startEvent: startEvent, startEventParam: startEventParam } startEventParam--this 替代函数内部this
    }
    this.addEvent = function (type, startEvent, startEventParam) {
        if (!this.data.queue[type]) {
            this.data.queue[type] = { data: new Array(), iExecuting: false };
        }
        this.data.queue[type].data.push({ startEvent: startEvent, startEventParam: startEventParam });
        this.execEventListener("addEvent");
    }
    this.delEvent = function (type, queue_i) {
        if (!this.iExistType(type)) return;
        queue_i = queue_i || 0;
        this.data.queue[type].data.splice(queue_i, 1);
        if (this.data.queue[type].data.length == 0) {//无该类别事件时，删除该类别
            delete this.data.queue[type];
        }
        else if (!this.data.queue[type].data[queue_i]) {//考虑开始执行位置非0时，数组长度并非为零
            this.stop(type);
        }
        this.execEventListener("delEvent");
    }
    this.delEventType = function (type) {
        if (this.iExistType(type)) {
            delete this.data.queue[type];
        }
    }
    this.execEvent = function (type, queue_i) {//执行事件
        if (this.iExecuting(type) || !this.iExistType(type)) {//在执行或不存在该类事件 
            return;
        }
        this.data.queue[type].iExecuting = true;
        queue_i = queue_i || 0;
        if (!this.data.queue[type].data[queue_i]) return; //到队列尾部时，停止继续执行
        //exec
        this.data.queue[type].data[queue_i].startEvent.call(this.data.queue[type].data[queue_i].startEventParam);
        this.execEventListener("execEvent");
    }
    this.stop = function (type) { //执行到队列末尾事件
        if (this.data.queue[type]) {
            this.data.queue[type].iExecuting = false;
        }
    }
    this.stepToNext = function (type) {//跳转到队列下一事件
        this.stop(type); //停止当前事件
        this.delEvent(type); //先删除再跳转到下一事件,因为删除后当前事件指针才会指向下一个;
        if (this.iExistType(type)) {//队列中还有待执行的事件，就开始执行
            this.execEventListener("stepToNext");
            this.execEvent(type);
        }
    }
    this.iExecuting = function (type) {//判断是否已经在执行
        if (this.iExistType(type) && this.data.queue[type].iExecuting) {
            return true;
        }
        return false;
    }
    this.iExistType = function (type) {//判断是否存在该类事件
        if (!this.data.queue[type]) {
            return false;
        }
        return true;
    }
    this.iExistNextEvent = function () {
        if (this.iExistType(type) && this.data.queue[type].iExecuting) {
            return true;
        }
        return false;
    }
    this.getLastQueue = function (type) { //获取队列中最后一个对象
        if (this.iExistType(type)) {
            var index = this.data.queue[type].data.length - 1;
            return this.data.queue[type].data[index];
        }
        else {
            return false;
        }
    }
    this.getFirstQueue = function (type) { //获取队列中第一个对象
        if (this.iExistType(type)) {
            return this.data.queue[type].data[0];
        }
        else {
            return false;
        }
    }
}
Math.iLeftButton = function (ev) {
    ev = ev || window.event;
    if (navigator.appName == "Microsoft Internet Explorer") {
        //　　微软的标准值如下：
        //　　* 左键 1
        //　　* 中键 4
        //　　* 右键 0
        if (ev.button == 1) {
            return true;
        }
    }
    else {
        //    W3C的标准值
        //　　* 左键 0
        //　　* 中键 1
        //　　* 右键 2
        if (ev.button == 0) {
            return true;
        }
    }
    return false;
}
Math.iRightButton = function (ev) {
    ev = ev || window.event;
    if (navigator.appName == "Microsoft Internet Explorer") {
        //　　微软的标准值如下：
        //　　* 左键 1
        //　　* 中键 4
        //　　* 右键 0
        if (ev.button == 0) {
            return true;
        }
    }
    else {
        //    W3C的标准值
        //　　* 左键 0
        //　　* 中键 1
        //　　* 右键 2
        if (ev.button == 2) {
            return true;
        }
    }
    return false;
}
Math.iMiddleButton = function (ev) {
    ev = ev || window.event;
    if (navigator.appName == "Microsoft Internet Explorer") {
        //　　微软的标准值如下：
        //　　* 左键 1
        //　　* 中键 4
        //　　* 右键 0
        if (ev.button == 4) {
            return true;
        }
    }
    else {
        //    W3C的标准值
        //　　* 左键 0
        //　　* 中键 1
        //　　* 右键 2
        if (ev.button == 1) {
            return true;
        }
    }
    return false;
}
//鼠标事件
function MouseEvent() {
    BaseListener.apply(this);
    this.click = function (ev) {//左键
        ev = ev || window.event;
        ev.srcElement.MouseEventCls.execEventListener("click", ev);
    }
    this.dblclick = function (ev) {//双击
        ev = ev || window.event;
        ev.srcElement.MouseEventCls.execEventListener("dblclick", ev);
    }
    this.contextmenu = function (ev) {//右键
        ev = ev || window.event;
        ev.srcElement.MouseEventCls.execEventListener("contextmenu", ev);

    }
    this.addAllEvent = function (obj) {
        if (obj.attachEvent) {
            obj.MouseEventCls = this;
            obj.attachEvent("onclick", this.click);
            obj.attachEvent("ondblclick", this.dblclick);
            obj.attachEvent("oncontextmenu", this.contextmenu);
        }
        if (obj.addEventListener) {
            obj.MouseEventCls = this;
            obj.addEventListener("click", this.click);
            obj.addEventListener("dblclick", this.dblclick);
            obj.addEventListener("contextmenu", this.contextmenu);
        }
    }
}
function hideitemsonmap() {
    var policesdiv = document.getElementById("Police,0,0_OutputLayerCell");
    if (policesdiv) {
        policesdiv.style.display = "none";
    }
    var PoliceStation = document.getElementById("PoliceStation");
    if (PoliceStation) {
        PoliceStation.style.display = "none";
    }
    var BaseStation = document.getElementById("BaseStation");
    if (BaseStation) {
        BaseStation.style.display = "none";
    }
}
function displayitemsonmap(){
    var policesdiv = document.getElementById("Police,0,0_OutputLayerCell");
    if (policesdiv) {
        policesdiv.style.display = "block";
    }
    var PoliceStation = document.getElementById("PoliceStation");
    if (PoliceStation) {
        PoliceStation.style.display = "block";
    }
    var BaseStation = document.getElementById("BaseStation");
    if (BaseStation) {
        BaseStation.style.display = "block";
    }
}