//线形图
function Linear() {
    this.values = {};  //横坐标序号对应值(JSON格式) values[{ 'num': '1', 'name': '大地', 'value': '6' }]value--线形纵向值 num--对应横向序号 name--横向序号对应名称
    this.strokeweight = 1;
    this.strokecolor = 'red'; //实际值
    this.filled = 'f';
    this.isTextVertical = false; //文本方向 横向--false 纵向--true
    this.textSize = 12;
    this.isTextTop = false; //文本位置（柱形上方或者下方--下方自动替代原先数字）false--下方 true--上方
    this.ovalDiameter = 5; //数据点直径大小 实际值
    this.ovalFillcolor = 'green';
    this.pointMove = false; //设置点可否移动（如果可以可触发数据变化后的事件）
    this.init = function (frame) {//输出后事件绑定
        if (this.pointMove) {
            for (var histogram_i = 0; histogram_i < this.values.length; histogram_i++) {
                var pointId = 'LineBarOval' + this.id + histogram_i;
                $(pointId).onmousedown = function () {
                    vmlmystartDragWindow($(this.id), frame.fineNum, this, 'pointColorChange');
                };
                $(pointId).onmouseup = function () {
                    vmlmystopDragWindow($(this.id), frame.fineNum, this, 'pointColorResume');
                };
                $(pointId).onmousemove = function () {
                    vmlmydragWindow($(this.id), frame.fineNum, 'y', frame, 'linemove');
                };
            }
            _vmlmydragWindowAfter.pointColorChange = function (point) {
                point.style.width = 2 * parseInt(point.style.width);
                point.style.height = 2 * parseInt(point.style.height);
            }
            _vmlmydragWindowAfter.pointColorResume = function (point) {
                point.style.width = parseInt(point.style.width) / 2;
                point.style.height = parseInt(point.style.height) / 2;
            }
            //定义拖动时折线变化事件
            _vmlmydragWindowAfter.args = this; //this.args==chart
            _vmlmydragWindowAfter.linemove = function (frame) {
                var line = $('LineBarPolyLine' + this.args.id);
                //遍历所有折线点
                var points = ""; //点集合坐标
                for (var histogram_i = 0; histogram_i < this.args.values.length; histogram_i++) {
                    //改变点位置
                    var point = $('LineBarOval' + this.args.id + histogram_i);
                    var x = parseInt(point.style.left) + parseInt(frame.fineNum * this.args.ovalDiameter / 2);
                    var y = parseInt(point.style.top) + parseInt(frame.fineNum * this.args.ovalDiameter / 2);
                    points += x + "," + y + " ";
                    if (this.args.isTextTop) { //对于文字在上方需要进行移动
                        if (this.args.values[histogram_i].name) {
                            var txt = $('LineBartxtUp' + this.args.id + histogram_i);
                            if (this.args.isTextVertical) {//纵向 利用每个折线点与文字的差计算（不是画在折线处的点）
                                txt.style.top = y - 5 * frame.fineNum - (this.args.textSize + 2) * frame.fineNum * (strlen(this.args.values[histogram_i].name) / 2);
                            }
                            else {
                                txt.style.top = y - 5 * frame.fineNum - (this.args.textSize + 2) * frame.fineNum;
                            }
                        }
                    }
                }
                line.points.value = points;
            }
        }
    }
}
//画线形图 frame--框架对象
//折线点id='LineBarOval" + chart.id + histogram_i + "'
//折线 id='LineBarPolyLine" + chart.id + "'
//上方文字 id='LineBartxtUp" + chart.id + histogram_i + "'
function drawLinear(frame, chart) {
    var newShape = document.createElement("<v:polyLine id='LineBarPolyLine" + chart.id + "' style='z-index:999' filled=" + chart.filled + " strokecolor=" + chart.strokecolor + " strokeweight=" + chart.strokeweight + "/>")
    var points = ""; //点集合坐标
    for (var histogram_i = 0; histogram_i < chart.values.length; histogram_i++) {
        var h = frame.y_minimum * frame.fineNum * chart.values[histogram_i].value / frame.y_minnum;
        var px = frame.margin * frame.fineNum * 1 + frame.x_minimum * frame.fineNum * frame.bigHorizontalNum * chart.values[histogram_i].num;
        var py = parseInt(frame.height) * frame.fineNum - frame.margin * frame.fineNum - h;
        points += px + "," + py + " ";
        //画圆点
        var ovalLeft = px - frame.fineNum * chart.ovalDiameter / 2;
        var ovalTop = py - frame.fineNum * chart.ovalDiameter / 2;
        var newOval = document.createElement("<v:oval id='LineBarOval" + chart.id + histogram_i + "' style='z-index:1000;position: absolute; left:" + ovalLeft + ";top:" + ovalTop + ";width:" + frame.fineNum * chart.ovalDiameter + ";height:" + frame.fineNum * chart.ovalDiameter + ";' fillcolor='" + chart.ovalFillcolor + "'/>");
        $(frame.id).insertBefore(newOval);
        if (chart.values[histogram_i].name) {
            if (!chart.isTextTop) {
                $('wordX' + frame.id + chart.values[histogram_i].num).childNodes[0].style.fontSize = chart.textSize;
                $('wordX' + frame.id + chart.values[histogram_i].num).childNodes[0].innerText = chart.values[histogram_i].name;
            }
            else {
                var txtSize;
                var wordPx = px - 9 * frame.fineNum;
                var wordTop;
                if (chart.isTextVertical) {
                    txtSize = chart.textSize; //设置文本框宽度 为一个文字宽度 就会自动竖着写
                    wordTop = py - 5 * frame.fineNum - (chart.textSize + 2) * frame.fineNum * (strlen(chart.values[histogram_i].name) / 2);
                }
                else {//横向文字
                    txtSize = null; //设置文本框宽度
                    wordTop = py - 5 * frame.fineNum - (chart.textSize + 2) * frame.fineNum;
                }
                //写上横坐标文字 柱形上方 纵向 英文的暂时有问题
                var newRect = document.createElement("<v:roundrect id='LineBartxtUp" + chart.id + histogram_i + "' style='z-index:1000;position: absolute; left: " + wordPx + "; top: " + wordTop + ";'></v:roundrect>");
                var newRectTextbox = document.createElement("<v:textbox style='width:" + txtSize + ";font-size:" + chart.textSize + ";'></v:textbox>");
                newRectTextbox.innerText = chart.values[histogram_i].name;
                newRect.insertBefore(newRectTextbox);
                $(frame.id).insertBefore(newRect);
            }
        }
    }
    newShape.points = points;
    $(frame.id).insertBefore(newShape); //这句话必须放最后 因为这样在获取newShape比较方便 使用this.parentNode.lastChild.id
    chart.init(frame); //输出后事件绑定
}