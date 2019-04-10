//选择矢量可标记语言类,做功能细分
//取消上面的思考，否者需要做成类似JQuery对元素的操作形式，否者改变(访问)元素属性等显得比较麻烦(不同语言可能方式不同)，还是直接生成想要的矢量图吧
function VML() {
    //创建或者修改椭圆
    //data--{fillColor:value,with:value}
    this.createOval = function (data, v_oval) {
        v_oval = v_oval || document.createElement("v:Oval");
        this.setVMLProperty(data, v_oval);
        return v_oval;
    }
    //创建或者修改矩形
    //data--{fillColor:value,sideLength:value}
    this.createRectangle = function (data, v_rect) {
        v_rect = v_rect || document.createElement("v:Rect");
        this.setVMLProperty(data, v_rect);
        return v_rect;
    }
    //创建或者修改线条
    //data--{from:{x:value,y:value},to:{x:value,y:value},color:value,arrowhead:true/false}
    this.createLine = function (data, v_line) {
        v_line = v_line || document.createElement("v:Line");
        if (data.from)
            v_line.from = data.from.x + "," + data.from.y;
        if (data.to)
            v_line.to = data.to.x + "," + data.to.y;
        if (data.color)
            v_line.strokecolor = data.color;
        if (data.EndArrow) {//添加尾部箭头
            if (!v_line.stroke) {
                var v_stroke = document.createElement("v:stroke");
                v_stroke.EndArrow = data.EndArrow;
                v_line.appendChild(v_stroke);
            }
            else {
                v_line.stroke.EndArrow = data.EndArrow;
            }
        }
        v_line.style.position = "absolute";
        return v_line;
    }
    this.setVMLProperty = function (data, vmlObj) {
        if (data.strokecolor)
            vmlObj.strokecolor = data.strokecolor;
        if (data.fillColor)
            vmlObj.fillcolor = data.fillColor;
        if (data.sideLength) {
            data.width = data.sideLength;
            data.height = data.sideLength;
        }
        if (data.opacity != undefined) {//添加尾部箭头<v:stroke opacity="50%"/> undefined防止为0
            if (!vmlObj.fill) {
                var v_fill = document.createElement("v:fill");
                v_fill.opacity = data.opacity;
                vmlObj.appendChild(v_fill);
            }
            else {
                vmlObj.fill.opacity = data.opacity;
            }
        }
        if (data.linestyle != undefined) {
            if (!vmlObj.stroke) {
                var vstroke = document.createElement("v:stroke");
                vstroke.dashstyle = data.linestyle;
                vmlObj.appendChild(vstroke);
            }
            else {
                vmlObj.stroke.dashstyle = data.linestyle;
            }
        }
        if (useprameters.vmlname)
            vmlObj.id = useprameters.vmlname; //林强修改
        if (data.width)
            vmlObj.style.width = data.width + "px";
        if (data.height)
            vmlObj.style.height = data.height + "px";
        if (data.left)
            vmlObj.style.left = data.left + "px";
        if (data.top)
            vmlObj.style.top = data.top + "px";
        vmlObj.style.position = "absolute";
        vmlObj.style.zIndex = 5;
    }
    {//init
        document.namespaces.add("v", "urn:schemas-microsoft-com:vml");
    }
}