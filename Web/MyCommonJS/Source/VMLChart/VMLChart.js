//自动生成图表 同时应在返回图形对象到页面(未处理) 如Frame对象 与 Histogram对象
//type ChartType图表类型
//values 图表数据JSON 格式
//divID 被填充div id
//isShow 是否显示
function SetDefault(type, values, divID, isShow) {
    switch (type) {
        case ChartType.Column: //柱状图 根据图形类型与数据自动创建图表
            {
                SetDefaultFrame(divID, values);
                var chart = new Histogram();
                chart.id = 'Column_Frame_' + divID;
                chart.textPosition.value = chart.textPosition.upHistogram;
                chart.isDynamic = chart.dynamicType.none;
                chart.values = values;
                eval('Column_Frame_' + divID + '=chart');
                if (isShow) {
                    ShowDefault(ChartType.Column, values, divID, 'Frame_' + divID, chart);
                }
                break;
            }
        case ChartType.Linear: //线性图
            {
                SetDefaultFrame(divID, values);
                var chart = new Linear();
                chart.id = 'Linear_Frame_' + divID;
                chart.values = values;
                chart.pointMove = true;
                chart.isTextTop = true;
                chart.isTextVertical = false;
                eval('Linear_Frame_' + divID + '=chart');
                if (isShow) {
                    ShowDefault(ChartType.Linear, values, divID, 'Frame_' + divID, chart);
                }
                break;
            }
    }
}
function SetDefaultFrame(divID, values) {
    var frame = new Frame();
    frame.id = 'Frame_' + divID;
    frame.defaultWH = true;
    frame.values = values;
    eval('Frame_' + divID + '=frame');
}
//frameID--图表对象 chartID--图表对象 根据图形类型与数据自动创建图表
function ShowDefault(type, values, divID, frame, chart) {
    switch (type) {
        case ChartType.Column: //柱状图 根据图形类型与数据自动创建图表
            {
                drawFrame(frame, divID);
                drawHistogram(frame, chart);
                break;
            }
        case ChartType.Linear: //线性图
            {
                drawFrame(frame, divID);
                drawLinear(frame, chart);
                break;
            }
    }
}
var ChartType = {
    "Column": "Column",
    "Linear": "Linear"
}
//图形框架
function Frame() {
    this.id;
    this.width = 500;
    this.height = 300;
    this.y_minimum = 10; //纵向最小刻度宽度
    this.x_minimum = null; //横向最小刻度宽度(自动计算)
    this.y_minnum = null; //纵向最小刻度数值（自动计算）
    this.x_minnum = 1; //横向大刻度数值
    this.margin = 20; //图形与外变宽边距 实际值
    this.opa = 0; //预留
    this.fineNum = 10; //精细度，用来表示单位刻度的coordsize值（内部参数）
    this.virtualScale = "#babbae";
    this.bigVerticalNum = 5; //纵向大刻度为几个小刻度
    this.bigHorizontalNum = 3; //横向大刻度为几个小刻度
    this.isShowGrid = true; //是否显示网格
    this.defaultWH = false; //是否让系统自动设置比例尺
    this.values; //数据
    this.makeScale = function () {//根据高宽度设置比例（主要设置y_minnum--可改变纵向最大值 与 x_minimun--可改变横向最小刻度宽度）
        if (!this.x_minimun) {
            this.x_minimum = Math.ceil((parseInt(this.width) - this.margin * 2) / (this.bigHorizontalNum * (this.values.length + 1)));
        }
        if (!this.y_minnum) {
            var flby = parseInt(this.height) * this.fineNum - this.margin * this.fineNum; //框架的左下点位纵坐标
            var heigthNum = parseInt((flby - this.margin * this.fineNum) / (this.y_minimum * this.fineNum)); //纵线小刻度个数
            var maxValue;
            var _values = [];
            for (var values_i = 0; values_i < this.values.length; values_i++) {
                _values.push(this.values[values_i].value);
            }
            maxValue = Math.max.apply(null, _values);
            minValue = Math.min.apply(null, _values);
            var y_minnumTemp = maxValue / heigthNum;
            if (y_minnumTemp < 1) {
                var temp_minnum = y_minnumTemp;
                var temp_minnum_powerNum = CountPow(temp_minnum); //最大值*10的几次方才大于1
                y_minnumTemp = Math.ceil(temp_minnum * Math.pow(10, temp_minnum_powerNum)) / Math.pow(10, temp_minnum_powerNum);
            }
            else {
                y_minnumTemp = Math.ceil(maxValue / heigthNum);
            }
            this.y_minnum = y_minnumTemp;
        }
    }
}
//图表框架
function drawFrame(frame, divId) {
    //画框架
    if (frame.defaultWH) {
        frame.makeScale();
    }
    var flby = parseInt(frame.height) * frame.fineNum - frame.margin * frame.fineNum; //框架的左下点位纵坐标
    var frtx = parseInt(frame.width) * frame.fineNum - frame.margin * frame.fineNum; //框架的右上点位横坐标
    var newGroup = document.createElement("<v:group id='" + frame.id + "' style='width: " + parseInt(frame.width) + "; height: " + parseInt(frame.height) + "' coordsize='" + parseInt(frame.width) * frame.fineNum + "," + parseInt(frame.height) * frame.fineNum + "'></v:group>");

    var newLine = document.createElement("<v:line from='" + frame.margin * frame.fineNum + "," + frame.margin * frame.fineNum + "' to='" + frame.margin * frame.fineNum + "," + flby + "' style='z-index: 999; position: absolute' strokeweight='1pt'></v:line>");
    var newStroke = document.createElement("<v:stroke startarrow='classic'>");
    newLine.insertBefore(newStroke);
    newGroup.insertBefore(newLine);

    var newLine = document.createElement("<v:line from='" + frame.margin * frame.fineNum + "," + flby + "' to='" + frtx + "," + flby + "' style='z-index: 8; position: absolute' strokeweight='1pt'></v:line>");
    var newStroke = document.createElement("<v:stroke endarrow='classic'>");
    newLine.insertBefore(newStroke);
    newGroup.insertBefore(newLine);

    var newRect = document.createElement("<v:rect style='width: " + parseInt(frame.width) * frame.fineNum + "; height: " + parseInt(frame.height) * frame.fineNum + "' fillcolor='white' strokecolor='black'></v:rect>");
    newGroup.insertBefore(newRect);

    document.getElementById(divId).appendChild(newGroup);
    var count = 0; //画横坐标（纵向线）
    var i = 0;
    while (frame.margin * frame.fineNum * 1 + frame.x_minimum * i * frame.fineNum < frtx) {
        var px = frame.margin * frame.fineNum * 1 + frame.x_minimum * i * frame.fineNum;
        var newLine;
        if ((frame.isShowGrid || count % frame.bigHorizontalNum == 0) && count != 0) {//显示网格 x y轴不画线
            newLine = document.createElement("<v:line from='" + px + " " + frame.margin * frame.fineNum + "' to='" + px + " " + flby + "' style='position:absolute;z-index:998'></v:line>");
            document.getElementById(frame.id).insertBefore(newLine);
            if (count % frame.bigHorizontalNum != 0) {//虚线
                var newStroke = document.createElement("<v:stroke dashstyle='dot' color='" + frame.virtualScale + "'/>");
                newLine.insertBefore(newStroke);
            }
            else {//实线
                var newStroke = document.createElement("<v:stroke color='" + frame.virtualScale + "'>");
                newLine.insertBefore(newStroke);
            }
        }
        if (count % frame.bigHorizontalNum == 0 && count / frame.bigHorizontalNum <= frame.values.length) {
            //写上横坐标刻度数字
            var wordPx = px - 10 * frame.fineNum;
            var wordTop = flby - 2 * frame.fineNum;
            var newRect = document.createElement("<v:roundrect id='wordX" + frame.id + count / frame.bigHorizontalNum + "' style='position: absolute; left: " + wordPx + "; top: " + wordTop + ";'></v:roundrect>");
            var newRectTextbox = document.createElement("<v:textbox style='font-size:12;'></v:textbox>");
            newRectTextbox.innerText = count * frame.x_minnum / frame.bigHorizontalNum; //默认为数字
            newRect.insertBefore(newRectTextbox);
            document.getElementById(frame.id).insertBefore(newRect);
        }
        count++, i++;
    }
    count = 0; //画纵坐标（横向线）
    i = 0;
    while (flby - frame.y_minimum * i * frame.fineNum > frame.margin * frame.fineNum) {
        var py = flby - frame.y_minimum * i * frame.fineNum;
        var newLine;
        if ((frame.isShowGrid || count % frame.bigVerticalNum == 0) && count != 0) {//显示网格
            newLine = document.createElement("<v:line from='" + frame.margin * frame.fineNum + " " + py + "' to='" + frtx + " " + py + "' style='position:absolute;z-index:998'></v:line>");
            document.getElementById(frame.id).insertBefore(newLine);
            if (count % frame.bigVerticalNum != 0) {//虚线
                var newStroke = document.createElement("<v:stroke dashstyle='dot' color='" + frame.virtualScale + "'/>");
                newLine.insertBefore(newStroke);
            }
            else {//实线
                var newStroke = document.createElement("<v:stroke color='" + frame.virtualScale + "'/>");
                newLine.insertBefore(newStroke);
            }
        }
        if (count % frame.bigVerticalNum == 0) {
            //写上纵坐标刻度数字
            var wordPy = py - frame.y_minimum * frame.fineNum;
            var wordLeft = frame.margin * frame.fineNum - 28 * frame.fineNum;
            var newRect = document.createElement("<v:roundrect style='position: absolute; top: " + wordPy + "; left: " + wordLeft + ";'></v:roundrect>");
            var newRectTextbox = document.createElement("<v:textbox style='font-size:12;'></v:textbox>");
            var num = count * frame.y_minnum;
            if (parseInt(num) < num)//有浮点
            {
                var temp = CountPow(frame.y_minnum);
                num = num.toFixed(temp);
            }
            newRectTextbox.innerText = num; //默认为数字
            newRect.insertBefore(newRectTextbox);
            document.getElementById(frame.id).insertBefore(newRect);
        }
        count++, i++;
    }
}
//通过值获取所在图中top值
function topGetByValue(frame, value) {
    var h = frame.y_minimum * frame.fineNum * value / frame.y_minnum;
    return parseInt(frame.height) * frame.fineNum - frame.margin * frame.fineNum - h;
}
//通过高度获取所在图中top值
function topGetByHeight(frame, height) {
    return parseInt(frame.height) * frame.fineNum - frame.margin * frame.fineNum - height;
}
var vmlwin_isMoving;
var vmlwin_space_x;
var vmlwin_space_y;
//开始拖动
function vmlmystartDragWindow(obj, fineNum, args, funNames) {
    if (event.button == 1) {// && event.srcElement.tagName.toUpperCase() == "DIV"
        obj.setCapture();
        var cur_window = obj;
        vmlwin_space_x = window.event.clientX - parseInt(obj.style.left) / fineNum;
        vmlwin_space_y = window.event.clientY - parseInt(obj.style.top) / fineNum;
        vmlwin_isMoving = true;
        //触发事件
        for (var i in _vmlmydragWindowAfter) {
            if (typeof (_vmlmydragWindowAfter[i]) == "function" && funNames.indexOf(i) >= 0) {
                _vmlmydragWindowAfter[i](args);
            }
        }
    }
}
//拖动
//obj--点 fineNum--vml精细度 x_yOney--只对x或y轴拉动 line--改变的对象
//包括执行的funNames名称 用, 隔开
function vmlmydragWindow(obj, fineNum, x_yOney, args, funNames) {
    if (vmlwin_isMoving) {
        var cur_window = obj;
        if (x_yOney == 'x') {
            cur_window.style.left = (window.event.clientX - vmlwin_space_x) * fineNum;
        }
        else if (x_yOney == 'y') {
            cur_window.style.top = (window.event.clientY - vmlwin_space_y) * fineNum;
        }
        else {
            cur_window.style.left = (window.event.clientX - vmlwin_space_x) * fineNum;
            cur_window.style.top = (window.event.clientY - vmlwin_space_y) * fineNum;
        }
        //触发事件
        for (var i in _vmlmydragWindowAfter) {
            if (typeof (_vmlmydragWindowAfter[i]) == "function" && funNames.indexOf(i) >= 0) {
                _vmlmydragWindowAfter[i](args);
            }
        }
    }
}
//结束拖动
function vmlmystopDragWindow(obj, fineNum, args, funNames) {
    obj.releaseCapture();
    vmlwin_isMoving = false;
    //触发事件
    for (var i in _vmlmydragWindowAfter) {
        if (typeof (_vmlmydragWindowAfter[i]) == "function" && funNames.indexOf(i) >= 0) {
            _vmlmydragWindowAfter[i](args);
        }
    }
}
//在拖动中的事件
var _vmlmydragWindowAfter = new vmlmydragWindowAfter();
function vmlmydragWindowAfter(outargs) {//外部参数带入
    this.args; //可通过正外部定义内部参数来在内部使用的目的 当然可以自行增加其它参数
}
var win_isResize;
var win_space_x_Resize;
var win_space_y_Resize;
var win_min_xResize = 500;
var win_min_yResize = 500;
//开始调整大小
function startResizeWindow(obj) {
    if (event.button == 1) {
        obj.setCapture();
        win_isResize = true;
        var cur_window = obj.parentNode;
        originalCur_windowBorderStyle = cur_window.style.borderStyle; //边框成虚线
        cur_window.style.borderStyle = 'dashed';
        win_space_x_Resize = window.event.clientX - parseInt(cur_window.style.width); //不变值
        win_space_y_Resize = window.event.clientY - parseInt(cur_window.style.height); //不变值
    }
}
//调整大小
function resizeWindow(obj) {
    if (win_isResize) {
        var width = window.event.clientX - win_space_x_Resize;
        var heigth = window.event.clientY - win_space_y_Resize;
        var _obj = obj.parentNode;
        if (width <= win_min_xResize) {
            _obj.style.width = win_min_xResize;
        }
        else {
            _obj.style.width = width;
        }
        if (heigth <= win_min_yResize) {
            _obj.style.height = win_min_yResize;

        }
        else {
            _obj.style.height = heigth;
        }
    }
}
//结束调整
function stopResizeWindow(obj, funNames) {
    obj.releaseCapture();
    win_isResize = false;
    obj.parentNode.style.borderStyle = originalCur_windowBorderStyle; //恢复边框
    for (var i in resizeWindow_EventAfter) {
        if (typeof (resizeWindow_EventAfter[i]) == "function" && funNames.indexOf(i) >= 0) {
            resizeWindow_EventAfter[i](obj);
        }
    }
}
//事件处理后函数
var _resizeWindow_EventAfter = new resizeWindow_EventAfter();
function resizeWindow_EventAfter(outargs) {//外部参数带入
    this.args; //可通过正外部定义内部参数来在内部使用的目的 当然可以自行增加其它参数
}
var win_isMove;
var win_space_x_Move;
var win_space_y_Move;
var win_min_xMove = 0; //减去宽度
var win_min_yMove = 0;
//开始拖动
function multiStartDragWindow(captureObj, moveObj) {
    if (event.button == 1) {// && event.srcElement.tagName.toUpperCase() == "DIV"
        captureObj.setCapture();
        if (!moveObj) {
            moveObj = captureObj;
        }
        var cur_window = moveObj;
        win_space_x_Move = window.event.clientX - parseInt(cur_window.offsetLeft);
        win_space_y_Move = window.event.clientY - parseInt(cur_window.offsetTop);
        win_isMove = true;
    }
}
//拖动
//unMin 否是有最小值
function multiDragWindow(captureObj, unMin, moveObj) {
    if (win_isMove) {
        if (!moveObj) {
            moveObj = captureObj;
        }
        var cur_window = moveObj;
        var left = window.event.clientX - win_space_x_Move;
        var top = window.event.clientY - win_space_y_Move;
        if (!unMin && left <= win_min_xMove) {
            cur_window.style.left = win_min_xMove;
        }
        else {
            cur_window.style.left = left;
        }
        if (!unMin && top <= win_min_yMove) {
            cur_window.style.top = win_min_yMove;
        }
        else {
            cur_window.style.top = top;
        }
    }
}
//结束拖动
function multiStopDragWindow(captureObj) {
    captureObj.releaseCapture();
    win_isMove = false;
}