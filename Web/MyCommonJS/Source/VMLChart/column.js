//柱形图
function Histogram() {
    this.values = {};
    //横坐标序号对应值(JSON格式) values[{ 'num': '1', 'name': '大地', 'value': '6',color:'red' }]value--柱形纵向值 num--对应横向序号 color--填充颜色 name--横向序号对应名称
    this.width = 15;
    this.isTextVertical = false;
    //文本方向 横向--false 纵向--true
    this.textSize = 12;
    this.DynamicStepNum = 1;
    this.textPosition = {
        "value": 1, "bottom": 1, "inHistogram": 2, "upHistogram": 3
    };
    this.dynamicType = {
        //动态类型
        "none": false, //静态
        "devolution": "devolution", //逐个推出
        "together": "together"//一起推出
    };
    this.isDynamic = this.dynamicType.none;
    //是否动态显示
}
//画柱形图 frame--框架对象
function drawHistogram(frame, histogram) {
    for (var histogram_i = 0; histogram_i < histogram.values.length; histogram_i++) {
        if (!histogram.isDynamic) {
            drawHistogramBar(histogram_i, frame, histogram);
            drawHistogramWord(histogram_i, frame, histogram);
        }
        else {
            drawHistogramWord(histogram_i, frame, histogram, 0);
            drawHistogramBar(histogram_i, frame, histogram, 0);
        }
    }
    if (histogram.isDynamic) {
        if (histogram.isDynamic == 'devolution') columnDynamic_devolution(0, 1, frame, histogram);
        else if (histogram.isDynamic == 'together') columnDynamic_together(0, frame, histogram);
    }
}
//输出柱形
//frame--框架 histogram--柱形图 num--位置 0开始 valu--数值（存在则取这个）
function drawHistogramBar(num, frame, histogram, valu) {
    if (valu != 0 && !valu) {
        value = histogram.values[num].value;
    }
    else {
        value = valu;
    }
    var h = frame.y_minimum * frame.fineNum * value / frame.y_minnum;
    var px = frame.margin * frame.fineNum * 1 + frame.x_minimum * frame.fineNum * frame.bigHorizontalNum * histogram.values[num].num;
    var py = parseInt(frame.height) * frame.fineNum - frame.margin * frame.fineNum - h;
    //柱形图
    var newShape = document.createElement("<v:rect id='ColumnRect" + histogram.id + num + "' style='position:absolute;left:" + px + ";top:" + py + ";WIDTH:" + histogram.width * frame.fineNum + ";HEIGHT:" + h + "px;z-index:999' fillcolor='" + histogram.values[num].color + "'></v:rect>")
    document.getElementById(frame.id).insertBefore(newShape);
}
//输出文本
function drawHistogramWord(num, frame, histogram, valu) {
    if (histogram.values[num].name) {
        if (valu != 0 && !valu) {
            value = histogram.values[num].value;
        }
        else {
            value = valu;
        }
        var h = frame.y_minimum * frame.fineNum * value / frame.y_minnum;
        var px = frame.margin * frame.fineNum * 1 + frame.x_minimum * frame.fineNum * frame.bigHorizontalNum * histogram.values[num].num;
        var py = parseInt(frame.height) * frame.fineNum - frame.margin * frame.fineNum - h;
        var wordTop;
        switch (histogram.textPosition.value) { //对于文字在上方需要进行移动
            case histogram.textPosition.bottom:
                {
                    document.getElementById('wordX' + frame.id + num).childNodes[0].style.fontSize = histogram.textSize;
                    document.getElementById('wordX' + frame.id + num).childNodes[0].innerText = histogram.values[num].name;
                    break;
                }
            case histogram.textPosition.inHistogram:
                {
                    if (histogram.isTextVertical) {
                        var wordHeight = (histogram.textSize + 2) * frame.fineNum * Math.ceil(strLEN(histogram.values[num].name) / 2);
                        if (h >= wordHeight) {
                            wordTop = py - 5 * frame.fineNum;
                        }
                        else {//当字的高度超过柱形时，避免文字超出框体外
                            wordTop = topGetByHeight(frame, wordHeight + 5 * frame.fineNum);
                        }
                    }
                    break;
                }
            case histogram.textPosition.upHistogram:
                {
                    if (histogram.isTextVertical) {
                        var wordHeight = (histogram.textSize + 2) * frame.fineNum * Math.ceil(strLEN(histogram.values[num].name) / 2);
                        if (topGetByHeight(frame, h + wordHeight + 5 * frame.fineNum) > 0) {
                            wordTop = py - 5 * frame.fineNum - wordHeight;
                        }
                        else {//当字的高度超过顶部时，避免文字超出框体外
                            wordTop = 0;
                        }
                    }
                    break;
                }
        }
        var txtSize;
        var wordPx = px - 9 * frame.fineNum;
        if (histogram.isTextVertical) {
            txtSize = histogram.textSize; //设置文本框宽度 为一个文字宽度 就会自动竖着写
        }
        else {//横向文字
            txtSize = null; //设置文本框宽度
            wordTop = py - 5 * frame.fineNum - (histogram.textSize + 2) * frame.fineNum;
        }
        //写上横坐标文字 柱形上方 纵向 英文的暂时有问题
        var newRect = document.createElement("<v:roundrect id='ColumntxtUp" + histogram.id + num + "' style='z-index:1000;position: absolute; left: " + wordPx + "; top: " + wordTop + ";'></v:roundrect>");
        var newRectTextbox = document.createElement("<v:textbox style=' word-wrap: break-word; word-break: normal;width:" + txtSize + ";font-size:" + histogram.textSize + ";'></v:textbox>");
        newRectTextbox.innerText = histogram.values[num].name;
        newRect.insertBefore(newRectTextbox);
        document.getElementById(frame.id).insertBefore(newRect);
    }
}
//设置文本位置
function setHistogramWordPosition(num, value, frame, histogram) {
    switch (histogram.textPosition.value) { //对于文字在上方需要进行移动
        case histogram.textPosition.bottom:
            {
                break;
            }
        case histogram.textPosition.inHistogram:
            {
                var txt = $('ColumntxtUp' + histogram.id + num);
                var h = frame.y_minimum * frame.fineNum * value / frame.y_minnum;
                var py = parseInt(frame.height) * frame.fineNum - frame.margin * frame.fineNum - h;
                if (histogram.values[num].name) {
                    if (histogram.isTextVertical) {
                        var wordHeight = (histogram.textSize + 2) * frame.fineNum * Math.ceil(strLEN(histogram.values[num].name) / 2);
                        if (h >= wordHeight) {
                            txt.style.top = py - 5 * frame.fineNum;
                        }
                        else {//当字的高度超过柱形时，避免文字超出框体外
                            txt.style.top = topGetByHeight(frame, wordHeight + 5 * frame.fineNum);
                        }
                    }
                    else {
                        txt.style.top = py - 5 * frame.fineNum - (histogram.textSize + 2) * frame.fineNum;
                    }
                }
                break;
            }
        case histogram.textPosition.upHistogram:
            {
                var txt = $('ColumntxtUp' + histogram.id + num);
                var h = frame.y_minimum * frame.fineNum * value / frame.y_minnum;
                var py = parseInt(frame.height) * frame.fineNum - frame.margin * frame.fineNum - h;
                if (histogram.values[num].name) {
                    if (histogram.isTextVertical) {
                        var wordHeight = (histogram.textSize + 2) * frame.fineNum * Math.ceil(strLEN(histogram.values[num].name) / 2);
                        if (topGetByHeight(frame, h + wordHeight + 5 * frame.fineNum) > 0) {
                            txt.style.top = py - 5 * frame.fineNum - wordHeight;
                        }
                        else {//当字的高度超过顶部时，避免文字超出框体外
                            txt.style.top = 0;
                        }
                    }
                    else {
                        txt.style.top = py - 5 * frame.fineNum - (histogram.textSize + 2) * frame.fineNum;
                    }
                }
                break;
            }
    }
}
//设置柱形高度
function setHistogramHeigth(num, value, frame, histogram) {
    var line = $('ColumnRect' + histogram.id + num);
    var h = frame.y_minimum * frame.fineNum * value / frame.y_minnum;
    var py = parseInt(frame.height) * frame.fineNum - frame.margin * frame.fineNum - h;
    line.style.top = py;
    line.style.height = h;
}
//逐个推出 动态图
function columnDynamic_devolution(num, value, frame, histogram) {
    if (num < histogram.values.length) {
        if (value <= parseInt(histogram.values[num].value)) {
            setHistogramHeigth(num, value, frame, histogram);
            setHistogramWordPosition(num, value, frame, histogram);
            value++;
            setTimeout(columnDynamic_devolution, 10, num, value, frame, histogram);
        }
        else {
            num++;
            value = 1;
            setTimeout(columnDynamic_devolution, 10, num, value, frame, histogram);
        }
    }
}
//一起推出 动态图
function columnDynamic_together(value, frame, histogram) {
    for (var num = 0; num < histogram.values.length; num++) {
        if (value <= parseInt(histogram.values[num].value)) {
            setHistogramHeigth(num, value, frame, histogram);
            setHistogramWordPosition(num, value, frame, histogram);
        }
    }
    value += histogram.DynamicStepNum;
    setTimeout(columnDynamic_together, 10, value, frame, histogram);
}