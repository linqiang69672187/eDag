var DoDrawOval = function () {
    {
        document.namespaces.add("v", "urn:schemas-microsoft-com:vml");
        this.MapID = "map";
        //this.pointArray = new Array();
    }
    this.canMove = false;
    this.isStop = false;
    this.centerX;
    this.centerY;
    this.lo1;
    this.lo2;
    this.lo3;
    this.lo4;
    this.la1;
    this.la2;
    this.la3;
    this.la4;
    this.point1;
    this.point2;
    this.point3;
    this.point4;
    this.centerlo;
    this.centerla;
    this.MapID = "map";
    this.Oval = null;
    this.stockadeid;
    this.divStyle;
    this.FillColor = "yellow";
    this.StrokeColor = "black";
    this.linestyle = "";
    this.strOpacity = 30;
    this.Title = "";
    this.UserID;
    this.BegCircle = function () {

        var mapDIv = document.getElementById(this.MapID);
        if (!mapDIv) {
            alert(GetTextByName("MapIDNotExistence", useprameters.languagedata));//多语言：地图ID不存在
            return;
        }
        if (this.isStop)
            return;
        var map = _StaticObj.objGet("map");
        map.switchDrag(false);
        var mapcoord = map.getPointByEvent();
        this.centerX = mapcoord.x;
        this.centerY = mapcoord.y;

        var varNow = new Date();
        this.stockadeid = varNow.getYear().toString() + varNow.getMonth().toString() + varNow.getDay().toString() + varNow.getHours().toString() + varNow.getMinutes().toString() + varNow.getSeconds().toString() + varNow.getMilliseconds().toString();

        this.Oval = document.createElement("v:oval");
        this.Oval.id = "Stockade_" + this.stockadeid;
        this.Oval.style.position = "absolute";
        this.Oval.style.display = "block";
        this.Oval.style.zIndex = 1;
        this.Oval.style.filter = "Alpha(Opacity=" + this.strOpacity + ")"; //自定义透明度
        this.Oval.strokecolor = this.StrokeColor; //自定义边框长度
        this.Oval.strokeweight = '1';
        this.Oval.fillcolor = this.FillColor; //自定义填充颜色
        mapDIv.appendChild(this.Oval);
        var v_stroke = document.createElement('v:stroke');
        v_stroke.dashstyle = this.linestyle;
        this.Oval.appendChild(v_stroke);

        this.isStop = true;
        this.canMove = true;
    }
    this.removeCircle = function () {
        if (this.canMove) {
            var picdiv = document.getElementById("stockadediv");
            if (picdiv) {
                picdiv.style.left = event.x + 10;
                picdiv.style.top = event.y + 10;
                picdiv.innerHTML = "<span style='color:red'>&nbsp;&nbsp;" + GetTextByName("DrawTitle", useprameters.languagedata) + "</span>";

            } else {
                //                var mapdiv = document.getElementById("map");
                var mydiv = document.createElement("div");
                mydiv.id = "stockadediv";
                mydiv.style.position = "absolute";
                mydiv.style.zIndex = 0;
                mydiv.style.top = event.y + 10;
                mydiv.style.left = event.x + 10;
                mydiv.innerHTML = "<span style='color:red'>&nbsp;&nbsp;" + GetTextByName("DrawTitle", useprameters.languagedata) + "</span>";
                document.body.appendChild(mydiv);
            }

            var map = _StaticObj.objGet("map");
            var mapcoord = map.getPointByEvent();
            var cirLength = Math.sqrt(Math.pow(parseInt(mapcoord.x) - parseInt(this.centerX), 2) + Math.pow(parseInt(mapcoord.y) - parseInt(this.centerY), 2));
            this.OvalLenght = cirLength;
            var cirCenterX = Math.abs(this.centerX - cirLength);
            var cirCenterY = Math.abs(this.centerY - cirLength);

            this.Oval.style.width = 2 * cirLength;
            this.Oval.style.height = 2 * cirLength;
            this.Oval.style.top = cirCenterY;
            this.Oval.style.left = cirCenterX;
            this.point1 = map.getLatLngByPoint({ x: cirCenterX, y: this.centerY }); //左边的点
            this.point4 = map.getLatLngByPoint({ x: this.centerX, y: cirCenterY }); //上下边的点
            this.point3 = map.getLatLngByPoint({ x: this.centerX + cirLength, y: this.centerY }); //右边的点
            this.point2 = map.getLatLngByPoint({ x: this.centerX, y: this.centerY + cirLength }); //边的点
            this.lo1 = this.point1.lo;
            this.lo2 = this.point2.lo;
            this.lo3 = this.point3.lo;
            this.lo4 = this.point4.lo;
            this.la1 = this.point1.la;
            this.la2 = this.point2.la;
            this.la3 = this.point3.la;
            this.la4 = this.point4.la;
        }
    }
    this.stopCircle = function () {

        var picdiv = document.getElementById("stockadediv");
        if (picdiv) {
            picdiv.innerHTML = "";
        }
        if (this.canMove == false)
            return;
        this.canMove = false;
        var map = _StaticObj.objGet("map");
        map.switchDrag(true);
        var centerpoint = map.getLatLngByPoint({ x: this.centerX, y: this.centerY }); //左边的点
        this.centerlo = centerpoint.lo;
        this.centerla = centerpoint.la;
        var cp1 = this.point1;
        var cp2 = this.point2;
        var cp3 = this.point3;
        var cp4 = this.point4;

        var ID = this.stockadeid;
        var vpath = "[{lo1:" + this.lo1 + ",la1:" + this.la1 + ",lo2:" + this.lo2 + ",la2:" + this.la2 + ",lo3:" + this.lo3 + ",la3:" + this.la3 + ",lo4:" + this.lo4 + ",la4:" + this.la4 + ",centerlo:" + this.centerlo + ",centerla:" + this.centerla + "}]";
        var divStyle = "[{strokecolor: \\\"" + this.StrokeColor + "\\\", opacity: \\\"" + this.strOpacity + "\\\", fillcolor: \\\"" + this.FillColor + "\\\", linestyle: \\\"" + this.linestyle + "\\\"}]";
        var mydiv = this.divStyle;
        $.ajax({
            type: "POST",
            url: "Handlers/Stockade_Handler.ashx",
            data: "cmd=add&title=" + this.Title + "&divstyle=" + divStyle + "&type=0&divid=" + this.stockadeid + "&pointarray=" + vpath + "&userid=" + this.UserID,
            success: function (msg) {
                LayerControl.refurbish();
                alert(msg);
                if (msg == GetTextByName("AddStackFailed", useprameters.languagedata)) {//多语言：电子栅栏添加失败
                    lq_hiddenvml("Stockade_" + ID);
                }
                if (msg == GetTextByName("AddStackSuccess", useprameters.languagedata)) {//多语言：电子栅栏添加成功
                    AllStockadeOvalPoint.push({ divid: ID, pa: { lo1: cp1.lo, la1: cp1.la, lo2: cp2.lo, la2: cp2.la, lo3: cp3.lo, la3: cp3.la, lo4: cp4.lo, la4: cp4.la, centerlo: centerpoint.lo, centerla: centerpoint.la }, divstyle: mydiv, type: 3 });

                    var myStroke = document.getElementById("Stockade_" + ID);
                    if (myStroke) {
                        var mapdiv = document.getElementById("map");;
                        mapdiv.removeChild(myStroke);
                    }
                    CreateOval(ID, { lo1: cp1.lo, la1: cp1.la, lo2: cp2.lo, la2: cp2.la, lo3: cp3.lo, la3: cp3.la, lo4: cp4.lo, la4: cp4.la, centerlo: centerpoint.lo, centerla: centerpoint.la }, mydiv);

                }
            }
        })
    }
}