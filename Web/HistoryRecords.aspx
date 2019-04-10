<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HistoryRecords.aspx.cs"
    Inherits="Web.HistoryRecords" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link href="CSS/Default.css" rel="stylesheet" type="text/css" />
    <link href="CSS/lq_style.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" href="pro_dropdown_2/pro_dropdown_2.css" />
    <script src="JQuery/jquery-1.5.2.js" type="text/javascript"></script>
    <script src="MyCommonJS/addAll.js" type="text/javascript"></script>
    <script src="WebGis/js/AddAll.js" type="text/javascript"></script>
    <script src="JS/HistoryAdd.js" type="text/javascript"></script>
    <script src="lqnew/js/GlobalVar.js" type="text/javascript"></script>
    <script src="lqnew/js/LanuageXmlToJson.js" type="text/javascript"></script>
    <script type="text/javascript">
        /**@打印轨迹*/
        function trajectoryPlayback(id, data, color, lineweight, linestyle) {
          
            var step_i=1;

            if(data.length<=2500){
                step_i=1;
            }else if(data.length>2500&&data.length<=5000){
                step_i=2;
            }else if(data.length>5000&&data.length<=7500){
                step_i=3;
            }else if(data.length>7500&&data.length<=10000){
                step_i=4;
            }else if(data.length>10000){
                step_i=5;
            }

            var mapdiv = document.getElementById("map");
            var trac = document.getElementById(id);
            if (trac){ 
                var data_i;
                var points = "";
                var map = _StaticObj.objGet("map");
                for (data_i = 0; data_i < data.length; data_i+=step_i) {
                    try{
                        if (parseFloat(data[data_i]["lo"] )>parseFloat( map.mapRangs().minlo )&& parseFloat(data[data_i]["lo"]) <parseFloat( map.mapRangs().maxlo) && parseFloat(data[data_i]["la"]) > parseFloat(map.mapRangs().minla) && parseFloat(data[data_i]["la"]) < parseFloat(map.mapRangs().maxla)) {//只打印地图范围内的

                            var mapcoord = map.getPixelInMap({ lo: data[data_i]["lo"], la: data[data_i]["la"] });
                            points += mapcoord.x + "," + mapcoord.y + " ";
                        }
                    }catch(exc){
                    }
                }
                trac.points = points.slice(0, -1);
                //mapdiv.removeChild(trac);
            }else
            {
                var divTrajectory = document.createElement("v:polyline");
                divTrajectory.id = id;
                divTrajectory.name = "firstTrajectory1";
                divTrajectory.style.zIndex = 1;
                divTrajectory.stroked = "true";
                divTrajectory.style.position = "absolute";
                divTrajectory.filled = "false";
                divTrajectory.strokecolor = color; //线条颜色
                var v_stroke = document.createElement('v:stroke');
                v_stroke.opacity = "1";
                v_stroke.StartArrow = "Oval";
                v_stroke.EndArrow = "Classic"
                v_stroke.dashstyle = linestyle;
                v_stroke.Weight = lineweight;
                divTrajectory.appendChild(v_stroke);
                var v_fill = document.createElement('v:fill');
                v_fill.opacity = 0;
                divTrajectory.appendChild(v_fill);
                var data_i;
                var points = "";
                var map = _StaticObj.objGet("map");
                for (data_i = 0; data_i < data.length; data_i+=step_i) {
                    try{
                        if (parseFloat( data[data_i]["lo"]) > parseFloat(map.mapRangs().minlo) && parseFloat(data[data_i]["lo"]) < parseFloat(map.mapRangs().maxlo) && parseFloat(data[data_i]["la"]) > parseFloat(map.mapRangs().minla) && parseFloat(data[data_i]["la"]) < parseFloat(map.mapRangs().maxla)) {//只打印地图范围内的
                            var mapcoord = map.getPixelInMap({ lo: data[data_i]["lo"], la: data[data_i]["la"] });
                            points += mapcoord.x + "," + mapcoord.y + " ";
                        }
                    }catch(ex)
                    {
            
                    }
                }
                divTrajectory.points = points.slice(0, -1);
                mapdiv.appendChild(divTrajectory);
            }
        }
        /**@点击定位时触发的方法*/
        function DomFirst(lo,la,times){
            window.event.cancelBubble = true;
            document.getElementById(times).style.display="none";
            document.getElementById('d'+times).style.display="block";

            DoM(lo,la,times);
            var map = _StaticObj.objGet("map");
            var Alert_PointNotOnMap=null;

            var param = {
                "id": "0"
            };
            jquerygetNewData_ajax("WebGis/Service/LanuageXmlToJson.aspx", param, function (request) {
                if (request != null) {
                    langdata = request.root.resource;
                }              
                Alert_PointNotOnMap = GetTextByName("Alert_PointNotOnMap", langdata);
            }, false, false);

            if(map.moveTo({la:la,lo:lo})==false){
                alert(Alert_PointNotOnMap);                                    //alert("你定位的点不在地图范围内");
            }
        }
        /**@取消定位*/
        function DomDispose(times)
        {
            document.getElementById(times).style.display="block";              /**@交换两个按钮显示状态*/
            document.getElementById('d'+times).style.display="none";
            var myArr = new Array();                                           /**@用来临时存放已经定位显示的点*/
            for(var j in HasPrintAarry)
            {
                myArr.push(HasPrintAarry[j]);
            }
            HasPrintAarry.length=0;
            for(var o in myArr)                                                /**@将需要去掉定位的信息从数组中排除*/
            { 
                if(times!=myArr[o].SendTime)
                    HasPrintAarry.push(myArr[o]);
            }
            if(isShowAllClick)                                                /**@假如是快速显示轨迹的，则为了马上达到效果，再次重绘，否则下一次刷新重绘*/
            {
                ShowAllHitory();
            } 
            if((i%limit==0&&i>0)||i==totalResultCount){
                var map = _StaticObj.objGet("map");
                var ranging = new Ranging(map);
                map.clearMap(); 
                map.fillBackPicsToDivMap();
                var ranging = new Ranging(map);
                trajectoryPlayback('historyTrajectory0',havePlayPoint,varcolor,selectWidth ,selectLine);/**@打印以前的轨迹*/
                ranging.addMyFirstNodeToMap(AllResultArry[i-1]); //打印当前节点。图标不一样
                if(HasPrintAarry.length>0){ //重新绘制
                    for(var v in HasPrintAarry){
                        ranging.DDToMap(HasPrintAarry[v]);
                    }
                };
            }
        }
        /**@在地图上显示需要被定位的点。*/
        function DoM(lo,la,times){
            window.event.cancelBubble = true;
            var map = _StaticObj.objGet("map");
            var ranging = new Ranging(map);
            ranging.DDToMap({la:la,lo:lo,SendTime:times});
            HasPrintAarry.push({la:la,lo:lo,SendTime:times});
        }

        function closeallTrace() {
            layerControl.isDrawtrace = false;
            for (var i = 0; i <= 1; i++) {
                $("#historyTrajectory" + i).remove();
            }
        }
        function stopmoveTrace() {
            setTimeout(function () {
                layerControl.isDrawtrace = true;
                if(isShowAllClick||i==totalResultCount-1||i==totalResultCount)
                {
                    ShowAllHitory()
                }else(GJHF());
            }, 200);

        }

        var HasPrintAarry=new Array();                                       /**@重绘已经打印的点*/
        var AllResultArry=new Array();                                       /**@存放所有点*/
        var NextHavePoint=new Array();
        var layerControl;
        var isShowAll=false;
        var isPlay=false;                                                    /**@是否在播放中**/
        var isNext=false;                                                    /**@是否按了下一页**/
        var stopFlag = false;                                                /**@是否停止状态**/
        var arrPoint = new Array();                                          /**@放从数据库出去来的轨迹信息**/
        var myInterval;                                                      /**@window.Interval的句柄**/
        var pageIndex = 1;                                                   /**@第几页**/
        var resultCount=0;                                                   /**@记录条数**/
        var isShowAllClick=false;                                            /**@是否点击显示所有按钮**/ 
        var totalResultCount=0;                                              /**@所有轨迹总条数*/
        var pages=0;                                                         /**@总的页数 所有轨迹数/每页显示的条数 totalResultCount/limit */
        /******以下从其他页面传过来**********/
        var freshTime = <%=Request["freshTime"] %>;                          /**@播放轨迹速度 默认为1秒**/
        var limit = <%=Request["limit"] %>;                                  /**@每页显示条数**/
        var BegHistoryTime = '<%=Request["BegHistoryTime"] %>';              /**@轨迹开始时间**/
        var EndHistoryTime = '<%=Request["EndHistoryTime"] %>';              /**@轨迹结束时间**/
        var PlayGHz = '<%=Request["PlayGHz"] %>';                            /**@播放密度**/
        var HistoryUserID='<%=Request["UserID"] %>';                         /**@用户ID**/
        var ZDGZ='<%=Request["ZDGZ"] %>';                                    /**@是否自动跟踪**/
        var AutoPlay='<%=Request["AutoPlay"] %>';                            /**@是否自动播放下一页历史轨迹**/
        var selectLine='<%=Request["selectLine"] %>';                        /**@划线的类型，点线等等**/
        var selectWidth='<%=Request["selectWidth"] %>';                      /**@选择线的宽度**/
        var varcolor="#"+'<%=Request["varcolor"] %>';                        /**@选择线的颜色**/
        var isNowCount=0;
        var PCname='<%=Request["PCname"] %>';                                /**@被播放轨迹的用户名**/
        /**@更改是否自动跟踪*/
        function ChanageZdgz(va){
            ZDGZ=va;
        }
        /**@更改是否自动播放*/
        function ChanageAutoPlay(va){
            AutoPlay=va;
            if(resultCount<limit)
            {
                //window.frames["ihistoryop"].document.getElementById("cbAutoPlay").checked = false;
                return;
            }
            if(isPlay==false&&AutoPlay=="true")
            {
                if(pages<pageIndex)
                    NextPage();
            }
        }

        /**@更改每页显示条数*/
        function SelLimitChanage() {
            pageIndex = 1; //返回到第一页
            limit = window.frames["ihistoryop"].document.getElementById("SelLimit").value;
        }

        /**@停止播放。点击停止的时候调用此函数*/
        function stopPlay() {
            stopFlag = true;
        }
        /**@继续播放。点击继续的时候调用此函数*/
        function continuePlay() {
            stopFlag = false;
        }
        /**@更改时间，选择完播放速度的时候调用此函数*/
        function ChangeTime(times) {
            freshTime = times;
            isNowCount=0;
            GJHF();
        }
        /**@更改频率*/
        function ChanageHZ(hz)
        {
            PlayGHz=hz;
            pageIndex = 1;
            havePlayPoint.length = 0; //从新播放 需要将存放已经播放的数组清空
            var map = _StaticObj.objGet("map");
            map.clearMap();
            map.fillBackPicsToDivMap();
            i = 0; //从新播放 需要将数组下标置为0
            stopFlag = false;
            GetHistoryData(HistoryUserID, window.frames["ihistoryop"].document.getElementById("begTime").value, window.frames["ihistoryop"].document.getElementById("endTime").value);
            //GJHF();
        }

        /**@从数据库获取数据 userID:用户ID，begtime:开始时间，endtime:结束时间*/
        var GetHistoryData = function (userID, begtime, endtime) {
            var arrAll=new Array();
            //var d=new Date();
            //document.getElementById("scrollarea").innerHTML+="<br>开始分页历史估计时间:"+d.toLocaleTimeString()+":" +d.getMilliseconds();
            $.ajax({
                type: "POST",
                url: "Handlers/GetGisHistoryByUserID.ashx",
                data: "PlayGHz="+PlayGHz+"&UserID=" + userID + "&limit=" + limit + "&pageIndex=" + pageIndex + "&BegTime=" + begtime + "&EndTime=" + endtime,
                success: function (msg) {
                    //var d2=new Date();
                    //document.getElementById("scrollarea").innerHTML+="<br>分页取完数据时间:"+d2.toLocaleTimeString()+":" +d2.getMilliseconds();
                    arrPoint = eval(msg); //将json转化为数组
                    if(arrPoint==undefined){
                        return;
                    }
                    if(arrPoint.length==undefined){
                        return;
                    }
                    for(var k in arrPoint){
                        AllResultArry.push(arrPoint[k]);
                    }

                    resultCount=arrPoint.length;
                
                    if(resultCount>0)
                    {
                        var mytable = "<table style=' width:300px'>";
                        mytable += "<tr>";
                        mytable += "<td colspan=2 style='width:180px'>"
                   
                        mytable+=GetTextByName("Page", useprameters.languagedata)+pageIndex+"/"+pages+"&nbsp;&nbsp;&nbsp;&nbsp;";
                        if(pageIndex==pages)
                        {
                            mytable+=GetTextByName("Article", useprameters.languagedata)+(parseInt(limit*(pageIndex-1))+1)+"~"+totalResultCount+"/"+totalResultCount;
                        }else{
                            mytable+=GetTextByName("Article", useprameters.languagedata)+(parseInt(limit*(pageIndex-1))+1)+"~"+limit*pageIndex+"/"+totalResultCount;
                        }
                        mytable+="</td>";
                        mytable+="<td align=left colspan=2>";
                        //mytable+="<td >";
                        //mytable+="<table><tr>";
                        //mytable+="<td>&nbsp;";
                        //if(pageIndex>1){
                        //                        mytable += "<div id=\"PerPageDiv\" style=\"border-bottom:1px solid; border-top:1px solid;border-left:1px solid; border-right:1px solid;cursor: pointer;\"  onclick='PrePage()'>播放上一页</div>";
                        //}
                        //mytable+="</td>";
                        //mytable+="<td align=left  colspan=2>"
                        if(limit==resultCount){
                        
                            // mytable += "<div id=\"NextPageDiv\" style=\"border-bottom:1px solid; border-top:1px solid;border-left:1px solid; border-right:1px solid;cursor: pointer;\"  onclick='NextPage()'>播放下一页</div>";
                            mytable += "<div id=\"NextPageDiv\" align=center style=\"border-bottom:1px solid; border-top:1px solid;border-left:1px solid;width:60px; border-right:1px solid;cursor: pointer;\"  onclick='NextPage()'>"+Lang_play_next_page+"</div>";
                        }
                        // mytable+="</td></tr></table>"
                        mytable+="</td>";
                        mytable += "</tr>";
                        mytable += "<tr>";
                        mytable += "<td colspan=3>"+ GetTextByName("Username", useprameters.languagedata)+":<b>"+ PCname+"</b></td>";
                        mytable += "</tr>";
                        mytable += "<tr>";
                        mytable += "<td style='width:45px' align=center>"+ GetTextByName("Operater", useprameters.languagedata)+"</td>";
                        mytable += "<td style='width:85px' align=left>"+ GetTextByName("Time", useprameters.languagedata)+"</td>";
                        mytable += "<td style='width:85px' align=left>"+ GetTextByName("Longitude", useprameters.languagedata)+"</td>";
                        mytable += "<td style='width:85px' align=left>"+ GetTextByName("Latitude", useprameters.languagedata)+"</td>";
                       
                        mytable += "</tr>";
                        mytable += "<tr>";
                        mytable += "<td colspan=4>";
                        mytable += "<div style=\"width: 318px; height: 408px; overflow: scroll;\">";
                        mytable += "<table style=' width:300px'>";
                        for (var t = 0; t < resultCount; t++) {

                            mytable += "<tr>";
                            mytable += "<td style='width:40px' align=center>";
                            mytable += "<span id='"+arrPoint[t].SendTime+"' onclick='DomFirst("+arrPoint[t].lo+","+arrPoint[t].la+",\""+arrPoint[t].SendTime+"\")' style='color:#F00; cursor:pointer'>"+ GetTextByName("Location", useprameters.languagedata)+"</span>";
                            mytable += "<span id='d"+arrPoint[t].SendTime+"' onclick='DomDispose(\""+arrPoint[t].SendTime+"\")' style='display:none;color:#30F; cursor:pointer'>"+ GetTextByName("ButtonCancel", useprameters.languagedata)+"</span>";
                            mytable += "</td>";
                            mytable += "<td style='width:120px' align=center>";
                            mytable += arrPoint[t].SendTime;
                            mytable += "</td>";
                            mytable += "<td style='width:70px' align=center>";
                            mytable += arrPoint[t].lo;
                            mytable += "</td>";
                            mytable += "<td style='width:70px' align=center>";
                            mytable += arrPoint[t].la;
                            mytable += "</td>";
                            
                            mytable += "</tr>";
                        }
                        mytable += "</table>";
                        mytable += "</div>";
                   
                        mytable += "</td>";
                        mytable += "</tr>";
                        mytable += "</table>";
                        $("#divTable").html(mytable);
                        GJHF();
                    }else{
                        
                        if(pageIndex>1){
                            var mytable = "<table width=260px>";
                            mytable += "<tr>";
                            mytable += "<td align=center><div style=\"color:red\">"+ GetTextByName("PlayOver", useprameters.languagedata)+"</div></td>";
                            mytable += "</tr>";
                            mytable += "<tr>";
                            mytable += "<td align=center><div id=\"PerPageDiv\" style=\"width:80px;border-bottom:1px solid; border-top:1px solid;border-left:1px solid; border-right:1px solid;cursor: pointer;\"  onclick='PrePage()'>"+ GetTextByName("PlayPrePage", useprameters.languagedata)+"</div></td>";
                            mytable += "</tr>";
                            mytable += "</table>";
                            $("#divTable").html(mytable);
                        }
                        else{
                            var mytable = "<table width=260px>";
                            mytable += "<tr>";
                            mytable += "<td align=center><div style=\"color:red\">"+ GetTextByName("NOTraceRecord", useprameters.languagedata)+"</div></td>";
                            mytable += "</tr>";
                            mytable += "</table>";
                            $("#divTable").html(mytable);
                        }
                  
                    }
                    //var d1=new Date();
                    //document.getElementById("scrollarea").innerHTML+="<br>分页渲染完界面时间:"+d1.toLocaleTimeString()+":" +d1.getMilliseconds();
                },
                error: function () {
                    alert(GetTextByName("LoadTraceDataFail", useprameters.languagedata));
                }
            })
        }

        /**@以下为轨迹回放************************************************************************************/
        var i = 0;                                 /**数组下标**/
        var havePlayPoint = new Array();           /**已经打印的轨迹**/
        /**@轨迹回放*/
        var GJHF = function () {
            var map = _StaticObj.objGet("map");
            clearInterval(myInterval);
            myInterval = window.setInterval(function () {
                if(layerControl.isDrawtrace==false){
                    return;
                };
                debugger
                if (stopFlag) {
                    // map.switchDrag(true); //bug，在禁用的时候拖动地图事件会传递到下次打开的时候
                    return;
                };
                if (i < AllResultArry.length) {
                    if(i==0){//修改为 第一次的时候定位
                        map.moveTo(AllResultArry[i]);
                    };
                    if(ZDGZ=="true"){
                        if(AllResultArry[i].lo>layerControl.CurrentBound.minLo&&AllResultArry[i].lo<layerControl.CurrentBound.maxLo&&AllResultArry[i].la<layerControl.CurrentBound.maxLa&&AllResultArry[i].la>layerControl.CurrentBound.minLa){}else{
                            map.moveTo(AllResultArry[i]);
                        };
                    };
                    map.clearMap(); /**@每打印一个点，把当前点加入到数组havePlayPoint中，在打印点之前，把以前打印的点都清空，并重新打印（主要是换点的图片【个人感觉这样效率很低，最好只从新打印上一个点即可，但不知道怎么做】）*/
                    map.fillBackPicsToDivMap();
                    var ranging = new Ranging(map);
                    isNowCount++;
                    havePlayPoint.push(AllResultArry[i]);
                    trajectoryPlayback('historyTrajectory0',havePlayPoint,varcolor,selectWidth ,selectLine);/**@打印以前的轨迹*/
                    ranging.addMyFirstNodeToMap(AllResultArry[i]); //打印当前节点。图标不一样
                    havePlayPoint.push(AllResultArry[i]); //打印完后，把当前打印的点加入到数组havePlayPoint
                    if(HasPrintAarry.length>0){ //重新绘制
                        for(var v in HasPrintAarry){
                            ranging.DDToMap(HasPrintAarry[v]);
                        }
                    };
                    //lastLoLa = arrPoint[i];
                    i++;
                    isPlay=true;
                } else {
                    if(AutoPlay=='true'){
                        if(pages<pageIndex)
                            NextPage();
                    };
                    isPlay=false;
                    clearInterval(myInterval); //清楚刷新句柄 减小不必要的负担
                    map.switchDrag(true); //是拖动
                    window.document.frames["ihistoryop"].showRrestart(); //当所有点打完后重新开始
                }
            }, freshTime);
        }
        
        /// <summary>
        /// 显示所有历史轨迹
        /// </summary>
        function ShowAllHitory() {
            if(!isShowAllClick){
                HasPrintAarry.length=0;//显示所有的时候，将前面定位的也取消，不过可能不太合理
            }
            isShowAllClick=true;
            havePlayPoint.length = 0; //显示所有 则先清空数组havePlayPoint，在将所有点都加入到havePlayPoint中 并从新加载地图并从新打印所有点
            var map = _StaticObj.objGet("map");
            var ranging = new Ranging(map);
            map.clearMap();
            map.fillBackPicsToDivMap();
            stopFlag = true;
            var arrAll=new Array();
            //var d=new Date();
        

            // document.getElementById("scrollarea").innerHTML+="<br>开始所有历史估计时间:"+d.toLocaleTimeString()+":" +d.getMilliseconds();
            $.ajax({
                type: "POST",
                url: "Handlers/GetAllResult.ashx",
                data: "PlayGHz="+PlayGHz+"&UserID=" + HistoryUserID + "&BegTime=" + BegHistoryTime + "&EndTime=" + EndHistoryTime,
                success: function (msg) {
                    //var d1=new Date();
                    //document.getElementById("scrollarea").innerHTML+="<br>取完数据时间："+d1.toLocaleTimeString()+":" +d1.getMilliseconds();
                    arrAll=eval(msg);
                    trajectoryPlayback('historyTrajectory1',arrAll,varcolor,selectWidth ,selectLine);
                    if(arrAll.length>0){ /**@重新绘制*/
                        if(HasPrintAarry.length>0){
                            for(var v in HasPrintAarry){
                                ranging.DDToMap(HasPrintAarry[v]);
                            }
                        };
                        ranging.addMyFirstNodeToMap(arrAll[arrAll.length-1]);
                        if(!isShowAll){

                            var mytable = "<table width=300px>";
                            mytable += "<tr>";
                            mytable += "<td colspan=3>"+ GetTextByName("Username", useprameters.languagedata)+":<b>"+ PCname+"</b></td>";
                            mytable += "</tr>";
                            mytable += "<tr>";
                            mytable += "<td width=40px align=center>"+ GetTextByName("Operater", useprameters.languagedata)+"</td>";
                            mytable += "<td width=120px align=center>"+ GetTextByName("Time", useprameters.languagedata)+"</td>";
                            mytable += "<td width=70px align=center>"+ GetTextByName("Longitude", useprameters.languagedata)+"</td>";
                            mytable += "<td width=70px align=center>"+ GetTextByName("Latitude", useprameters.languagedata)+"</td>";
                       
                            mytable += "</tr>";
                            mytable += "<tr>";
                            mytable += "<td colspan=4>";
                            mytable += "<div style=\"width: 318px; height: 433px; overflow: scroll;\">";
                            mytable += "<table id='Tbody1' style=' width:300px'>";
                            mytable += "</table>";
                            mytable += "</div>";
                            mytable += "</td>";
                            mytable += "</tr>";
                            mytable += "</table>";
                            $("#divTable").html(mytable);

                            var i=0;
                            var vcounts=arrAll.length;
                            var tttt=  setInterval(function(){
                                if(i<vcounts){
                                    funLoadTable(arrAll,i,vcounts);
                                    i+=10;
                                }else
                                {
                                    clearInterval(tttt);
                                }
                            },10);

                            //for (var t = 0; t < arrAll.length; t++) {
                      
                            //    var mytr="";
                            //    mytr += "<tr>";
                            //    mytr += "<td style='width:40px' align=center>";
                            //    mytr += "<span id='"+arrAll[t].SendTime+"' onclick='DomFirst("+arrAll[t].lo+","+arrAll[t].la+",\""+arrAll[t].SendTime+"\")' style='color:#F00; cursor:pointer'>"+ GetTextByName("Location", useprameters.languagedata)+"</span>";
                            //    mytr += "<span id='d"+arrAll[t].SendTime+"' onclick='DomDispose(\""+arrAll[t].SendTime+"\")' style='display:none;color:#30F; cursor:pointer'>"+ GetTextByName("ButtonCancel", useprameters.languagedata)+"</span>";
                            //    mytr += "</td>";
                            //    mytr += "<td style='width:120px' align=center>";
                            //    mytr += arrAll[t].SendTime;
                            //    mytr += "</td>";
                            //    mytr += "<td style='width:70px' align=center>";
                            //    mytr += arrAll[t].lo;
                            //    mytr += "</td>";
                            //    mytr += "<td style='width:70px' align=center>";
                            //    mytr += arrAll[t].la;
                            //    mytr += "</td>";
                            
                            //    mytr += "</tr>";

                            //    $("#Tbody1").prepend(mytr);
                            //}

                   
                            //var d2=new Date();
                            //document.getElementById("scrollarea").innerHTML+="<br>渲染界面时间："+d2.toLocaleTimeString()+":" +d2.getMilliseconds();
                            isShowAll=true;
                        }
                    };
                }
            });
            i = AllResultArry.length - 1;
            isPlay=false;
        }
        function funLoadTable(arrAll,t,vcounts){
            var mytr="";
            var p=t+10;
            for (var i = t; i < p; i++) {
                if(p<vcounts){
                    mytr += "<tr>";
                    mytr += "<td style='width:40px' align=center>";
                    mytr += "<span id='"+arrAll[i].SendTime+"' onclick='DomFirst("+arrAll[i].lo+","+arrAll[i].la+",\""+arrAll[i].SendTime+"\")' style='color:#F00; cursor:pointer'>"+ GetTextByName("Location", useprameters.languagedata)+"</span>";
                    mytr += "<span id='d"+arrAll[i].SendTime+"' onclick='DomDispose(\""+arrAll[i].SendTime+"\")' style='display:none;color:#30F; cursor:pointer'>"+ GetTextByName("ButtonCancel", useprameters.languagedata)+"</span>";
                    mytr += "</td>";
                    mytr += "<td style='width:120px' align=center>";
                    mytr += arrAll[i].SendTime;
                    mytr += "</td>";
                    mytr += "<td style='width:70px' align=center>";
                    mytr += arrAll[i].lo;
                    mytr += "</td>";
                    mytr += "<td style='width:70px' align=center>";
                    mytr += arrAll[i].la;
                    mytr += "</td>";
                    mytr += "</tr>";
                }
            }

            $("#Tbody1").prepend(mytr);
       
        }
        
        /**@重新播放历史轨迹*/
        function reStartHistory() {
            isShowAllClick=false;
            pageIndex = 1;
            havePlayPoint.length = 0; //从新播放 需要将存放已经播放的数组清空
            var map = _StaticObj.objGet("map");
            map.clearMap();
            map.fillBackPicsToDivMap();
            i = 0; //从新播放 需要将数组下标置为0
            stopFlag = false;
            GetHistoryData(HistoryUserID, window.frames["ihistoryop"].document.getElementById("begTime").value, window.frames["ihistoryop"].document.getElementById("endTime").value);
        }

        $(document).ready(function () {
            $("#restart").click(function () {
                ShowAllHitory();
            })
        })
        /**@下一页*/
        function NextPage() {
            HasPrintAarry.length=0;//播放下一页的时候，将前面定位的也取消，不过可能不太合理，但是不取消 以后就没机会取消了
            isShowAllClick=false;
            pageIndex = pageIndex + 1;
            for(var y=i;y<AllResultArry.length;y++)   /**@点击下一页，将前面所有的都画出来，也就是将还没打印的轨迹，也加入到答应的列表*/
            {
                havePlayPoint.push(AllResultArry[y]);
            }
            i=AllResultArry.length;                   /**@下一次回放 就从这里开始*/

            // havePlayPoint.length = 0; //从新播放 需要将存放已经播放的数组清空
            var map = _StaticObj.objGet("map");
            map.clearMap();
            map.fillBackPicsToDivMap();
            //i = 0; //从新播放 需要将数组下标置为0
            isNext = true;
            stopFlag = false;
            GetHistoryData(HistoryUserID, window.frames["ihistoryop"].document.getElementById("begTime").value, window.frames["ihistoryop"].document.getElementById("endTime").value);
            // window.document.frames["ihistoryop"].showNextPage();
        }
        /**@上一页*/
        function PrePage() {
            isShowAllClick=false;
            if (pageIndex <= 1) {
                pageIndex = 1;
               
            } else {
                pageIndex = pageIndex - 1;
              
            }
            if (pageIndex == 1) {
                $("#PerPageDiv").hide();
            } else {
                $("#PerPageDiv").show();
            }
            havePlayPoint.length = 0; //从新播放 需要将存放已经播放的数组清空
            var map = _StaticObj.objGet("map");
            map.clearMap();
            map.fillBackPicsToDivMap();
            i = 0; //从新播放 需要将数组下标置为0
            stopFlag = false;
            GetHistoryData(HistoryUserID, window.frames["ihistoryop"].document.getElementById("begTime").value, window.frames["ihistoryop"].document.getElementById("endTime").value);
            window.document.frames["ihistoryop"].showNextPage();
        }

        var useprameters = {};
        useprameters.lockid = 0;
        useprameters.nowtrace = [];

        if (document.attachEvent) {
            window.attachEvent("onload", onload_default);
        }
        if (document.addEventListener) {
            window.addEventListener("load", onload_default, false);
        }

        var gettotaltime=false;
        function getResultTotalCount(userID, begtime, endtime)
        {
            $.ajax({
                type: "POST",
                url: "Handlers/getHistoryTotalCount.ashx",
                data: "PlayGHz="+PlayGHz+"&UserID=" + userID + "&BegTime=" + begtime + "&EndTime=" + endtime,
                success: function (msg) {
                    totalResultCount=msg;
                    if(totalResultCount%limit==0){
                        pages=totalResultCount/limit;
                    }
                    else{
                        pages=parseInt(totalResultCount/limit)+1;
                    }
                    gettotaltime=true;
                    InitInfo();
                }
            })
        }
        var _move = false;
        var _x,_y;
        function onload_default() { 
 
            document.getElementById('divTtable1').onmousedown=function(event){
                event = event ? event : window.event;
                var which = navigator.userAgent.indexOf('MSIE') > 1 ? event.button == 1 ? 1 : 0 : event.which == 1 ? 1 : 0 ;
            
                if(which) {
                    _move = true;
                    _x = event.clientX - parseInt(document.getElementById('listPanel').style.left);  
                    _y = event.clientY - parseInt(document.getElementById('listPanel').style.top); 
                }
            }

            getResultTotalCount(HistoryUserID,BegHistoryTime,EndHistoryTime);
            var map = new ZheJiangMap();
            map.data.mapDiv = document.getElementById("map");
            map.data.currentLevel = 5;
            ///  map.data.currentCenter = { "lo": 120.1521899, "la": 30.2733004 };
            map.data.maxLevel = 10;
            map.data.minLevel = 1;

            map.data.mapid = "historyRecords2";
            map.data.iDesignateMoveBuffer=false;
            map.init();
            layerControl = new LayerManager(map);
            layerControl.isrelockpc = false;
            var multi_Ranging = new Multi_Ranging(_StaticObj.objGet("map")); //添加测距
            window.iOnResize = true;
            setTimeout(makeWindowOnresize, 500); //兼容IE7以下浏览器 防止打开页面就执行
            getlanguage();
            function makeWindowOnresize() {
                window.onresize = function () {
                    //兼容IE7以下浏览器 限制500ms内只能执行一次(内部代码包含设置 position="absolute" 会触发onresize事件,有时添加dom元素也会)
                    if (iOnResize) {
                        iOnResize = false;
                        var map = _StaticObj.objGet("map");
                        map.mapDivSizeSet();
                        map.clearBackContainer();
                        map.fillBackPicsToDivMap();
                        //map.reload();
                        setTimeout(reSetiOnresize, 500);
                        function reSetiOnresize() {
                            iOnResize = true;
                        }
                    }
                }
            };
            //初始化
            window.frames["ihistoryop"].document.getElementById("begTime").value = BegHistoryTime;
            window.frames["ihistoryop"].document.getElementById("endTime").value = EndHistoryTime;
            /**@获取用户坐标信息 存放到全局数组中 过半秒后再执行*/
            window.setTimeout(function () {
                //此方法放到读取总条数函数中处理
                //InitInfo();
            }, 500);

            map.addEventListener("fillBackPicsToDivMap",function(){
    
            });

            map.addEventListener("zoomToLevel_after", function () {
                var ranging = new Ranging(map);
                if(isShowAllClick){
                    ShowAllHitory();
                }
                /**@每页的最后一个点 重绘轨迹*/
                if((i==totalResultCount-1||i==totalResultCount||i%limit==0)&&!isShowAllClick){
                    trajectoryPlayback('historyTrajectory0',havePlayPoint,varcolor,selectWidth ,selectLine);/**@打印以前的轨迹*/
                    if(havePlayPoint[havePlayPoint.length-1]!=undefined){
                        ranging.addMyFirstNodeToMap(havePlayPoint[havePlayPoint.length-1]);
                    }
                    /**@地图比例尺改变，重新打印已经打过的点*/
                    if(HasPrintAarry.length>0){
                        for(var v in HasPrintAarry){
                            ranging.DDToMap(HasPrintAarry[v]);
                        }
                    };
                }
            });
        }
        function InitInfo()
        {
            window.setTimeout(function(){
                if(gettotaltime){
                    /**@初始化开始时间跟结束时间*/
                    window.frames["ihistoryop"].document.getElementById("begTime").value = BegHistoryTime;
                    window.frames["ihistoryop"].document.getElementById("endTime").value = EndHistoryTime;
                    window.frames["ihistoryop"].document.getElementById("SelTime").value = freshTime;
                    GetHistoryData(HistoryUserID, window.frames["ihistoryop"].document.getElementById("begTime").value, window.frames["ihistoryop"].document.getElementById("endTime").value);
                }
                else
                {
                    InitInfo();
                }
            },500)
        }
        function closebl() {
            var listPanel = document.getElementById("listPanel");
            if (listPanel.style.left == "0px") {
                $("#listPanel,#div1").animate({ left: -193 }, 500, function () {
                    $("#opSideBar span").html("<img id='bgimg'  style='margin-top:210px;' src='/lqnew/img/out.gif' />");
                });
            }
            else {
                $("#listPanel,#div1").animate({ left: 0 }, 500, function () {
                    $("#opSideBar span").html("<img id='bgimg'  style='margin-top:210px;' src='/lqnew/img/in.gif' />");
                });
            }
        }
        function ClosePageDiv() {
            $("#listPanel").animate({ width: '+22px', height: '22px' }, 10);
            $("#divTable").hide();
            $("#divOpen").show();
            $("#divClo").hide();
            $("#divTtable").css("border-bottom"," #000 0px solid").css("cursor","pointer");
            $("#listPanel").css("left",0);
            $("#listPanel").css("top",0);
        }
        function OpenPageDiv() {
            $("#listPanel").animate({ width: '320px', height: '500px' }, 10);
            $("#divTable").show();
            $("#divClo").show();
            $("#divOpen").hide();
            $("#divTtable").css("border-bottom"," #000 1px solid").css("cursor","pointer");
            $("#listPanel").css("left",0);
            $("#listPanel").css("top",0);
        }
        function HideDivMB(){
            $("#divMB").hide();
            $("#openMB").show();
        }
        function showDivMB()
        {
            $("#divMB").show();
            $("#openMB").hide();
        }
        /**@测距*/
        function cj(obj) {
            //reconverbutton("测距");
            var mp = document.getElementById("map");
            mp.style.cursor = "url(\"tool07.cur\")";
            obj.src = "Images/ToolBar/rightbg/ring_un.png";
            _StaticObj.objGet("Multi_Ranging").addRanging();
        }
        document.onmousemove=function(event){
            event = event ? event : window.event;
            if(_move) {
       
                var x = event.clientX - _x;
                var y = event.clientY - _y;
                document.getElementById('listPanel').style.left = x+'px';
                document.getElementById('listPanel').style.top = y+'px';
            }
        }
        var ifr_callcontent=null;
        var Lang_play_next_page=null;
        document.onmouseup=function(){ _move = false; }
        useprameters.IsloadMapin=false;

        function redo(){
   
        }
        function getlanguage() {
            var param = {
                "id": "0"
            };
            jquerygetNewData_ajax("WebGis/Service/LanuageXmlToJson.aspx", param, function (request) {
                if (request != null) {
                    useprameters.languagedata = request.root.resource;
                }
                var data= $.parseJSON(useprameters.languagedata);
                document.title = GetTextByName("WebGisTitleTrace", useprameters.languagedata);
                Lang_play_next_page= GetTextByName("Lang_play_next_page", useprameters.languagedata);
                document.getElementById("pingmiandt").title = GetTextByName("Switchplanemap", useprameters.languagedata);
                document.getElementById("pingmiandt").innerHTML = GetTextByName("planemap", useprameters.languagedata);
                document.getElementById("weixdt").title = GetTextByName("Switchsatellitemap", useprameters.languagedata);
                document.getElementById("weixdt").innerHTML = GetTextByName("satellitemap", useprameters.languagedata);
                document.getElementById("imgrang").title = GetTextByName("Distancemeasurement", useprameters.languagedata);

            }, false, false);
        }
        
    
    </script>
</head>
<body onselectstart="return false" oncontextmenu="return false" >
    <form id="form1" runat="server" style="overflow: hidden">
        <img style="display: none" id="cloose" src="" />
        <div id="toggleFatSatelit" style="height: 25px; cursor: pointer; background-image: url(Images/satelitteanpm1.png);">
            <ul>
                <li style="width: 33px;" id="pingmiandt" onclick="javascript:redo();toggleFlatSt('NORMAL')"></li>
                <li id="weixdt" onclick="javascript:redo();toggleFlatSt('HYBRID')"></li>
            </ul>
        </div>
        <div id="map" style="position: static; cursor: pointer;">
        </div>
        <div id="divMB" class="" style="float: right; height: 100px; position: absolute; right: 0px; z-index: 100; bottom: 0; width: 250px;">
            <iframe height="180px" id="ihistoryop" name="ihistoryop" src="HistroyOper.aspx"></iframe>
        </div>
        <div style="float: right; height: 100px; position: absolute; right: 0px; z-index: 100; top: 0; width: 40px; display: block">
            <img id='imgrang' onclick="cj(this)" src="Images/ToolBar/rightbg/ring.png" />
        </div>
        <div onclick="showDivMB()" id="openMB" style="text-align: center; line-height: 22px; float: right; height: 22px; position: absolute; right: 0px; z-index: 100; bottom: 75px; width: 22px; background-color: White; border-bottom: 1px solid; border-top: 1px solid; border-left: 1px solid; border-right: 1px solid; display: none">
            <table>
                <tr>
                    <td align="center">
                        <img src="WebGis/images/icon_goleft.gif" />
                    </td>
                </tr>
            </table>
        </div>
        <div id="listPanel" style="float: right; height: 500px; position: absolute; left: 0px; z-index: 100; top: 0px; width: 320px; background-color: White; border-bottom: 1px solid; border-top: 1px solid; border-left: 1px solid; border-right: 1px solid;">
            <table width="318px" id="divTtable" style="border-bottom: #000 1px solid; cursor: pointer;">
                <tr>
                    <td style="width:20px">
                        <div id="divClo">
                            <img src="WebGis/images/icon_goleft.gif" onclick="ClosePageDiv()" />
                        </div>
                        <div id="divOpen" style="display: none">
                            <img src="WebGis/images/icon_goright.gif" onclick="OpenPageDiv()" />
                        </div>
                    </td>
                    <td id="divTtable1" ></td>
                </tr>
            </table>
            <div id="divTable" style="width: 320px; height: 475px; overflow: hidden;">
            </div>
        </div>
        <div id="scrollarea" style="display: none; float: right; height: 200px; position: absolute; left: 0px; z-index: 100; bottom: 0px; width: 320px; background-color: White; border-bottom: 1px solid; border-top: 1px solid; border-left: 1px solid; border-right: 1px solid; overflow: scroll">
        </div>
    </form>
</body>
</html>
