<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HistoryPlayer.aspx.cs" Inherits="Web.HistoryPlayer" %>

<%--cxy-20180723添加时间轴功能--%>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>

    <link href="CSS/Default.css" rel="stylesheet" type="text/css" />
    <link href="CSS/lq_style.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" href="pro_dropdown_2/pro_dropdown_2.css" />

    <script src="JS/OpenLayers/ol-debug.js" type="text/javascript"></script>
    <script src="JS/OpenLayers/ol-View.js"></script>
    <script src="JS/OpenLayers/ol-StreetMapLayer.js"></script>
   <script type="text/javascript" src="JS/OpenLayers/ol-HistroyMap.js"></script>
    <script type="text/javascript" src="JS/OpenLayers/ol-HistroyUserLayer.js"></script>
    <script type="text/javascript" src="JS/OpenLayers/ol-CoordinateBiasedAlgorithm.js"></script>
    <script type="text/javascript" src="JS/OpenLayers/proj4/proj4.js"></script>
    <script type="text/javascript" src="lqnew/js/LOG.js"></script>


    <script src="JS/map.js" type="text/javascript"></script>
    <script src="JS/EzMapAPI.js" type="text/javascript"></script>
    <script src="JQuery/jquery-1.5.2.js" type="text/javascript"></script>
<%--  <script src="MyCommonJS/addAll.js" type="text/javascript"></script>--%>
    <script src="MyCommonJS/ajax.js" type="text/javascript"></script>

<%--    <script src="WebGis/js/AddAll.js" type="text/javascript"></script>--%>
<%--    <script src="JS/HistoryAdd.js" type="text/javascript"></script>--%>
    <script src="lqnew/js/GlobalVar.js" type="text/javascript"></script>
    <script src="lqnew/js/LanuageXmlToJson.js" type="text/javascript"></script>

     <style type="text/css" >
       html, body, #map, #form1 {
            margin: 0;
            padding: 0;
            width: 100%;
            height: 100%;
            display:block;
            text-align:left;
            
        }
     </style>
   
  
    <script type="text/javascript">

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

        function hideTimeDiv(){
            $("#timeDiv").hide();
            $("#openTimeDiv").show();
        }

        function showTimeDiv(){
            $("#openTimeDiv").hide();
            $("#timeDiv").show();
        }


        $(function(){

            $("#showAll").click(function () {
                loadEvent.Display();

            })


            $("#restart").click(function () {
                onclick = window.location.reload();
          
            })



            $("#closeDiv").click(function () {

                window.HideDivMB();
            });


            $("#closeTimeDiv").click(function () {

                window.hideTimeDiv();
            });

            $("#openTimeDiv").click(function () {

                window.showTimeDiv();
            });
            
        })


     </script>





</head>
<body style="font-size:12px; font-family:Arial">
      <div id="map"></div>

       <div id="divMB" class="" style="float: right; height: 100px; position:fixed; right: 0px; z-index: 100; bottom: 0px; width: 250px; display:block">
           
  <form id="form1" runat="server">
  <div>
        <table>
       
            <tr>
                <td width="40%" id="playbegintime">
                    <%--播放开始时间--%>
                </td>
                <td colspan="2">                                                         
                    <input type="text" disabled="disabled" style="width: 120px; height: 13px" id="begTime" readonly="readonly" /> 
                </td>
            </tr>
            <tr>
                <td width="40%" id="playendtime">
                    <%--播放结束时间--%>
                </td>
                <td colspan="2">
  
                    <input type="text" disabled="disabled" style="width: 120px; height: 13px" id="endTime" readonly="readonly" />
                </td>
            </tr>

               <tr id="tr_btn"  style="word-break:keep-all">
                <td align="left">
 <span id="showAll" style=" cursor:pointer; border:1px solid #999999;"><%--快速显示所有轨迹--%></span>
                </td>

                <td align="left" colspan="2">
                    <table width="100%">
                        <tr>
                            <td width="40%" align="center">
                                <span id="restart" style=" display:block; border:1px solid #999999; cursor: pointer;"><%--重新开始--%></span>
                            </td>
                             <td width="20%" align="center">
                                <%--停止--%>
                                 </td>

                            <td align="left" width="40%">
                                <span style="cursor: pointer" id="closeDiv"><img src="WebGis/images/icon_goright.gif" /></span>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>


            </table>

      </div>
      </form>
      
    </div>

        <div onclick="showDivMB()" id="openMB" style="text-align: center; line-height: 22px; float: right; height: 22px; position: absolute; right: 0px; z-index: 100; bottom: 75px; width: 22px; background-color: White; border: 1px solid; display: none">
              <table>
            <tr>
                <td align="center">
                    <img src="WebGis/images/icon_goleft.gif" />
                </td>
            </tr>
        </table>
    </div>

    <div id="openTimeDiv" style="text-align: center; line-height: 20px; float: left; height: 20px; position: absolute; left: 2px; z-index: 100; bottom: 23px; width: 20px; background-color: White; display: none">
         <span><img src="WebGis/images/icon_goright.gif" /></span>
    </div>

    <div id="timeDiv" class="" style="float:left; height: 60px; position:fixed; left: 0px; z-index: 100; bottom: 20px; width: auto;border:1px solid;padding:2px;">
      <label for="times">  
      <span id="timelineName"><%--时间轴:   --%></span>
      <input id="times" type="range" min="0" max="24" step="1" value="0" >  
    </label>
        <div disabled="disabled" id="stop-animation" align=center style="display:inline;border:1px solid; width:80px;cursor: pointer;color:#999999;"  onclick='endAnimation()'><%--重置--%></div> 
        <div id="start-animation" align=center style="display:inline;border:1px solid; width:80px;cursor: pointer;"  onclick='startAnimation()'><%--开始--%></div>
        <div style="display:block;margin-top:-20px;" cursor: pointer" id="closeTimeDiv" ><span><img src="WebGis/images/icon_goleft.gif" /></span></div>
    </div>


        <div id="listPanel" style="float: right; height: 500px; position: absolute; left: 0px; z-index: 100; top: 0px; width: 320px; background-color: White; border: 1px solid;">
        <table width="318px" id="divTtable" style="border-bottom: #000 1px solid; cursor: pointer;">
            <tr>
                <td style="width: 20px">
                    <div id="divClo">
                        <img src="WebGis/images/icon_goleft.gif" onclick="ClosePageDiv()" />
                    </div>
                    <div id="divOpen" style="display: none">
                        <img src="WebGis/images/icon_goright.gif" onclick="OpenPageDiv()" />
                    </div>
                </td>
                <td id="divTtable1"></td>
            </tr>
        </table>
        <div id="divTable" style="width: 320px; height: 475px; overflow: hidden;">
        </div>
    </div>





          <script type="text/javascript">

         
              var useprameters={};
              useprameters.currentLevel=7;
              var loadEvent;

              //获取系统初始化参数配置
              function get_usepramater() { 
                  var param = {
                      "id": "0"
                  };
                  jquerygetNewData_ajax("WebGis/Service/get_useparameter.aspx", param, function (request) {
                      var data = request;
                      //var map = _StaticObj.objGet("map");
                      //if (useprameters.lockid != "0" && map.data.currentLevel > 2) { //防止未锁定或者地图小于2级时刷新
                      //    alert("dsds");
                      //    map.clearBackContainer();
                      //}
              
                      if (data != null) {
                   
                          //useprameters.lockid = (data.lo != "" && data.la != "" && data.lo != "0" && data.la != "0") ? data.lockid : 0;             //锁定警员
                          useprameters.lo = data.lo;
                 
                          useprameters.la = data.la;
                          useprameters.last_lo = data.last_lo;
                          useprameters.last_la = data.last_la;
                          useprameters.device_timeout = data.device_timeout;               //终端超时时间
                          useprameters.hide_timeout_device = data.hide_timeout_device;     //不显示超时终端
                          useprameters.refresh_map_interval = data.refresh_map_interval;
                          useprameters.usename = data.usename;
                          useprameters.useentity = data.entity;
                          useprameters.displayinfo = (data.displayinfo == "True");
                          useprameters.languagedata = data.lanuage.root.resource;          //多语言配置
                          useprameters.scnSliceCount = data.scnSliceCount;
                          useprameters.theCountToMoHu = data.theCountToMoHu;
                          useprameters.Emapurl = data.Emapurl;                     //地图地址
                          useprameters.deviation_lo = data.deviation_lo;
                          useprameters.deviation_la = data.deviation_la;
                          useprameters.maxLevel = data.maxLevel;      //最大层数
                          useprameters.minLevel=data.minLevel;        //最小层数
                          useprameters.currentLevel = data.currentLevel;
                          useprameters.maptype = data.maptype;                   //地图图片类型
                          useprameters.mapsize = data.mapsize;                   //地图图片尺寸
                          useprameters.deviation_lo_Hybrid = data.deviation_lo_Hybrid;
                          useprameters.deviation_la_Hybrid = data.deviation_la_Hybrid;
            
                          useprameters.GISTYPE = data.GISTYPE;                           //地图类型PGIS/WEBGIS
            
                          useprameters.PGIS_deviation_lo = data.PGIS_deviation_lo;        //PGIS偏差经度
                          useprameters.PGIS_deviation_la = data.PGIS_deviation_la;        //PGIS偏差纬度
                          useprameters.PGIS_API = data.PGIS_API;      //PGIS普通地图路径

                          useprameters.PGIS_Center_lo = data.PGIS_Center_lo;                 //PGIS中心点经度
                          useprameters.PGIS_Center_la = data.PGIS_Center_la;                 //PGIS中心点纬度
                          useprameters.PGIS_Normal_index = data.PGIS_Normal_index;                 //PGIS地图索引
                          useprameters.PGIS_HYBRID_index = data.PGIS_HYBRID_index;                 //PGIS地图索引
                          useprameters.OriginLo = data.OriginLo;                        //起始经度
                          useprameters.OriginLa = data.OriginLa;                        //起始纬度
                          // HisLoadMap();
                          ShowAllHitory(1);
                      }

                  }, false, false);

                  
              }


  


              var AllResultArry=new Array();                                       /**@存放所有点*/
              var pageIndex = 1;                                                   /**@第几页**/
              var resultCount=0;                                                   /**@记录条数**/
              var totalResultCount=0;                                              /**@所有轨迹总条数*/
              var pages=0;                                                         /**@总的页数 所有轨迹数/每页显示的条数 totalResultCount/limit */

              var firstLoad=0;                                                     /**@第一次轨迹全部加载 totalResultCount/limit */

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
              var ISSI='<%=Request["ISSI"]%>'; //xzj--20181120                     /**@被播放轨迹的用户ISSI**/
              var usertype='<%=Request["usertype"] %>';  
            
        
              document.getElementById("begTime").value=BegHistoryTime;
              document.getElementById("endTime").value = EndHistoryTime;



              /**@从数据库获取数据 userID:用户ID，begtime:开始时间，endtime:结束时间  分页*/
              var GetHistoryData = function (userID, begtime, endtime) {
                  var arrAll=new Array();
           
                  $.ajax({
                      type: "POST",
                      url: "Handlers/GetGisHistoryByUserID.ashx",
                      data: "PlayGHz="+PlayGHz+"&UserID=" + userID + "&limit=" + limit + "&pageIndex=" + pageIndex + "&BegTime=" + begtime + "&EndTime=" + endtime,
                      success: function (msg) {
                   
                          arrPoint = eval(msg); //将json转化为数组

                          //var mian= document.getElementById("main");
                          var style={color:varcolor,linewidth:selectWidth,linestyle:selectLine};
                          //main.getData(arrPoint,style);

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
                              var mytable = "<table style=' width:200px'>";
                              mytable += "<tr>";
                              mytable += "<td colspan=2 style='width:180px'>"
                   
                              mytable+=GetTextByName("Page", useprameters.languagedata)+pageIndex+"/"+pages+"&nbsp;&nbsp;&nbsp;&nbsp;";//页
                              if(pageIndex==pages)
                              {
                                  mytable+=GetTextByName("Article", useprameters.languagedata)+(parseInt(limit*(pageIndex-1))+1)+"~"+totalResultCount+"/"+totalResultCount;
                              }else{
                                  mytable+=GetTextByName("Article", useprameters.languagedata)+(parseInt(limit*(pageIndex-1))+1)+"~"+limit*pageIndex+"/"+totalResultCount;
                              }
                              mytable+="</td>";

                              mytable+="<td align=center colspan=1>";
                              if(pageIndex!=1){
                                  mytable += "<div id=\"PerPageDiv\" style=\"width:60px;border-bottom:1px solid; border-top:1px solid;border-left:1px solid; border-right:1px solid;cursor: pointer;\"  onclick='PrePage()'>"+ GetTextByName("PlayPrePage", useprameters.languagedata)+"</div>";
                              }
                              mytable+="</td>";

                              mytable+="<td align=center colspan=1>";
                              if(pageIndex!=pages){    
                              mytable += "<div id=\"NextPageDiv\" align=center style=\"border-bottom:1px solid; border-top:1px solid;border-left:1px solid;width:60px; border-right:1px solid;cursor: pointer;\"  onclick='NextPage()'>"+Lang_play_next_page+"</div>";
                              }
                              mytable+="</td>";

                              

                              mytable += "</tr>";
                              mytable += "<tr>";
                              mytable += "<td colspan=2>"+ GetTextByName("Username", useprameters.languagedata)+":<b>"+ PCname+"</b></td>";
                              mytable += "<td colspan=2>"+ GetTextByName("Lang_terminal_identification", useprameters.languagedata)+":<b>"+ ISSI+"</b></td>";//xzj--20181120
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

                                  if(t<resultCount-1)
                                  {
                                      mytable += "<span id='"+arrPoint[t].SendTime+"' onclick='DomFirst("+arrPoint[t].lo+","+arrPoint[t].la+","+arrPoint[t+1].lo+","+arrPoint[t+1].la+",\""+arrPoint[t].SendTime+"\")' style='color:#F00; cursor:pointer'>"+ GetTextByName("Location", useprameters.languagedata)+"</span>";
                                  }
                                  if(t==resultCount-1)
                                  {
                                      mytable += "<span id='"+arrPoint[t].SendTime+"' onclick='DomFirst("+arrPoint[t].lo+","+arrPoint[t].la+","+arrPoint[t].lo+","+arrPoint[t].la+",\""+arrPoint[t].SendTime+"\")' style='color:#F00; cursor:pointer'>"+ GetTextByName("Location", useprameters.languagedata)+"</span>";
                                  }
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

                          }
                          //else{
                        
                          //    if(pageIndex>1){
                          //        var mytable = "<table width=260px>";
                          //        mytable += "<tr>";
                          //        mytable += "<td align=center><div style=\"color:red\">"+ GetTextByName("PlayOver", useprameters.languagedata)+"</div></td>";
                          //        mytable += "</tr>";
                          //        mytable += "<tr>";
                          //        mytable += "<td align=center><div id=\"PerPageDiv\" style=\"width:80px;border-bottom:1px solid; border-top:1px solid;border-left:1px solid; border-right:1px solid;cursor: pointer;\"  onclick='PrePage()'>"+ GetTextByName("PlayPrePage", useprameters.languagedata)+"</div></td>";
                          //        mytable += "</tr>";
                          //        mytable += "</table>";
                          //        $("#divTable").html(mytable);
                          //    }
                          //    else{
                          //        var mytable = "<table width=260px>";
                          //        mytable += "<tr>";
                          //        mytable += "<td align=center><div style=\"color:red\">"+ GetTextByName("NOTraceRecord", useprameters.languagedata)+"</div></td>";
                          //        mytable += "</tr>";
                          //        mytable += "</table>";
                          //        $("#divTable").html(mytable);
                          //    }
                  
                          //}
                    
                      },
                      error: function () {
                          alert(GetTextByName("LoadTraceDataFail", useprameters.languagedata));
                      }
                  })
              }




              //显示所有历史轨迹
              function ShowAllHitory(judge) {
                  var arrAll=new Array();
                  var TypeArr=new Array();
                  var TimeArr=new Array();
                  //stopFlag = true;
                  $.ajax({
                      type: "POST",
                      url: "Handlers/GetAllResult.ashx",
                      data: "PlayGHz="+PlayGHz+"&UserID=" + HistoryUserID + "&BegTime=" + BegHistoryTime + "&EndTime=" + EndHistoryTime,
                      success: function (msg) {
                  
                          if (msg=="[]"){
                              alert(GetTextByName("NOTraceRecord", useprameters.languagedata));
                              return;
                          }     
                        
                          arrAll=eval(msg);
                          for(i=0;i<arrAll.length;i++)
                          {
                              TypeArr.push(Conversion(arrAll[i].lo,arrAll[i].la));
                              TimeArr.push(arrAll[i].SendTime);
                              
                          }
                          
                          useprameters.PGIS_Center_lo = arrAll[0].lo;                 //PGIS中心点经度
                          useprameters.PGIS_Center_la = arrAll[0].la;                 //PGIS中心点纬度

                          //var SBeginTime =BegHistoryTime.replace("-", "/").replace("-", "/");  

                          //var Sdate=new Date(Date.parse(StrBeginTime))



                          //var EBeginTime =EndHistoryTime.replace("-", "/").replace("-", "/");  

                          //var Edate=new Date(Date.parse(EtrBeginTime))

                        
                          //var c= Sdate.getHours()-Edate.getHours();
                          //aler(c);

                          HisLoadMap();//加载地图层
                          //速度，经纬度数组，警员类型，线颜色，线宽度,判断
                  
                          

                          loadEvent = LoadEvents(freshTime,TypeArr,TimeArr,usertype,varcolor,selectWidth,judge)//加载画图层
                  
                      }
                  });
                  //i = AllResultArry.length - 1;
                  //isPlay=false;
              }








              /**@下一页*/
              function NextPage() {

                  if (pageIndex == pages) {
                      pageIndex = pages;
               
                  } else {
                      pageIndex = pageIndex + 1;
              
                  }
                  //getResultTotalCount(HistoryUserID,BegHistoryTime,EndHistoryTime);
                  GetHistoryData(HistoryUserID, BegHistoryTime, EndHistoryTime);
              }

              //if (document.attachEvent) {
              //    window.attachEvent("onload", onload_default);
              //}
              //if (document.addEventListener) {
              //    window.addEventListener("load", onload_default, false);
              //}

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


              //var _move = false;
              //var _x,_y;
              //function onload_default() { 
 
              //    document.getElementById('divTtable1').onmousedown=function(event){
              //        event = event ? event : window.event;
              //        var which = navigator.userAgent.indexOf('MSIE') > 1 ? event.button == 1 ? 1 : 0 : event.which == 1 ? 1 : 0 ;
            
              //        if(which) {
              //            _move = true;
              //            _x = event.clientX - parseInt(document.getElementById('listPanel').style.left);  
              //            _y = event.clientY - parseInt(document.getElementById('listPanel').style.top); 
              //        } 
              //    }

              //    get_usepramater();
           
              //    getlanguage();
            
              //    //初始化
               
              //    /**@获取用户坐标信息 存放到全局数组中 过半秒后再执行*/
           

            
              //}
              //前一页
              function PrePage() {
                  //isShowAllClick=false;
                  if (pageIndex == 1) {
                      pageIndex = 1;
               
                  } else {
                      pageIndex = pageIndex - 1;
              
                  }
                  //havePlayPoint.length = 0; //从新播放 需要将存放已经播放的数组清空
                  //var map = _StaticObj.objGet("map");
                  //map.clearMap();
                  //map.fillBackPicsToDivMap();
                  //i = 0; //从新播放 需要将数组下标置为0
                  //stopFlag = false;

                  //getResultTotalCount(HistoryUserID,BegHistoryTime,EndHistoryTime);

                  //window.document.frames["ihistoryop"].showNextPage();
                  //getResultTotalCount(HistoryUserID,BegHistoryTime,EndHistoryTime);
                  GetHistoryData(HistoryUserID, BegHistoryTime, EndHistoryTime);
              }




              function InitInfo()
              {
                  window.setTimeout(function(){
                      if(gettotaltime){
                          /**@初始化开始时间跟结束时间*/
                          //window.frames["ihistoryop"].document.getElementById("begTime").value = BegHistoryTime;
                          //window.frames["ihistoryop"].document.getElementById("endTime").value = EndHistoryTime;
                          //window.frames["ihistoryop"].document.getElementById("SelTime").value = freshTime;
                          //window.frames["ihistoryop"].document.getElementById("tr_btn").style.display = "inline";
                        
                          GetHistoryData(HistoryUserID, BegHistoryTime, EndHistoryTime);
                      }
                      else
                      {
                          InitInfo();
                      }
                  },5000)
              }
      

              //加载左侧列表
              function initData(){
       
                  getResultTotalCount(HistoryUserID,BegHistoryTime,EndHistoryTime);
                  //document.getElementById("ihistoryop").src="HistroyOper.aspx";
                  //window.frames["ihistoryop"].document.getElementById("begTime").value = BegHistoryTime;
                  //window.frames["ihistoryop"].document.getElementById("endTime").value = EndHistoryTime;
              }

              //初始化时间轴
              function initTimeLine(){
                  var timeRange = (new Date(Date.parse(EndHistoryTime.replace(/-/g,  "/")))).getHours() - (new Date(Date.parse(BegHistoryTime.replace(/-/g,  "/")))).getHours() + 1;
                  $("#times").attr("max",timeRange.toString());
              }


              //定位
              function DomFirst(lo,la,loAfter,laAfter,times){

                  document.getElementById(times).style.display="none";
                  document.getElementById('d'+times).style.display="block";


                  var direction = getDirection(lo,la, loAfter, laAfter);
                   
                  //运动的点
                  var MarsPoint = new ol.Feature({
                      type: 'MarsPoint',
                      geometry: new ol.geom.Point(ol.proj.transform([lo, la], 'EPSG:4326', 'EPSG:3857'))
                  });

                  var Marstyles = new ol.style.Style({
                      //image: new ol.style.Circle({
                      //    radius: 12,
                      //    snapToPixel: false,
                      //    fill: new ol.style.Fill({ color: 'red' }),//点的样式
                      //    stroke: new ol.style.Stroke({
                      //        color: 'white', width: 2
                      //    })
                      //})

                      image: new ol.style.Icon({
                          src:"/Images/arrows/sign"+direction+".png",
                      })
                  })


                  MarsPoint.setId(times);
                  MarsPoint.setStyle(Marstyles);
         
                  userLayer.getSource().addFeature(MarsPoint);


              }

              //用数字表示方向值,逆时针方向 0 1 2 3 4 5 6 7 
              function getDirection(lo,la,loAfter,laAfter)
              {
                  var direction ;
                  if((loAfter-lo>0)&&(Math.abs(laAfter-la)<0.0001))
                  {
                      direction = 0;
                  }
                  if((loAfter-lo>0)&&(laAfter-la>0))
                  {
                      direction = 1;
                  }
                  if((laAfter-la>0)&&(Math.abs(loAfter-lo)<0.0001))
                  {
                      direction = 2;
                  }
                  if((loAfter-lo< 0)&&(laAfter-la>0))
                  {
                      direction = 3;
                  }
                  if((loAfter-lo<0)&&(Math.abs(laAfter-la)<0.0001))
                  {
                      direction = 4;
                  }
                  if((loAfter-lo<0)&&(laAfter-la<0))
                  {
                      direction = 5;
                  }
                  if(Math.abs(loAfter-lo)<0.0001 && laAfter-la<0)
                  {
                      direction = 6;
                  }
                  if((loAfter - lo >0)&&(laAfter - la <-0))
                  {
                      direction = 7;
                  }
                  return direction;
				
              }


              /**@取消定位*/
              function DomDispose(times)
              {  
                  document.getElementById(times).style.display="block";              /**@交换两个按钮显示状态*/
                  document.getElementById('d'+times).style.display="none";
                  //var p=Date.parse(times).toString()
                  var feature = userLayer.getSource().getFeatureById(times);
                  userLayer.getSource().removeFeature(feature);
     
              }



              initData();

              initTimeLine();

              get_usepramater();
             
              

              

              //获取文字
              var ifr_callcontent=null;
              var Lang_play_next_page=null;


              function getlanguage() {
                  var param = {
                      "id": "0"
                  };
                  jquerygetNewData_ajax("WebGis/Service/LanuageXmlToJson.aspx", param, function (request) {
                      if (request != null) {
                          langdata = request.root.resource;
                      }
          
                      Lang_play_next_page= GetTextByName("Lang_play_next_page", langdata);


                      document.getElementById("playbegintime").innerHTML = window.GetTextByName("playbegintime", langdata);
                      document.getElementById("playendtime").innerHTML = window.GetTextByName("playendtime", langdata);
                      //document.getElementById("playintervaltime").innerHTML = window.GetTextByName("playintervaltime", langdata);
                      document.getElementById("showAll").innerHTML = window.GetTextByName("quickviewtrace", langdata);
                      document.getElementById("restart").innerHTML = window.GetTextByName("restart", langdata);
                      document.getElementById("timelineName").innerHTML = window.GetTextByName("timeline", langdata);
                      document.getElementById("stop-animation").innerHTML = window.GetTextByName("play_reset", langdata);
                      document.getElementById("start-animation").innerHTML = window.GetTextByName("play_start", langdata);


                      //document.getElementById("stop").innerHTML = window.GetTextByName("stop", langdata);
                
                      //document.getElementById("Continues").innerHTML = window.GetTextByName("Continues", langdata);
                      //document.getElementById("Lang_0.1second").innerHTML = window.GetTextByName("Lang_0.1second", langdata);
                      //document.getElementById("Lang_0.2second").innerHTML = window.GetTextByName("Lang_0.2second", langdata);
                      //document.getElementById("Lang_0.3second").innerHTML = window.GetTextByName("Lang_0.3second", langdata);
                      //document.getElementById("Lang_0.4second").innerHTML = window.GetTextByName("Lang_0.4second", langdata);
                      //document.getElementById("Lang_0.5second").innerHTML = window.GetTextByName("Lang_0.5second", langdata);
                      //document.getElementById("Lang_1second").innerHTML = window.GetTextByName("Lang_1second", langdata);
                      //document.getElementById("Lang_2second").innerHTML = window.GetTextByName("Lang_2second", langdata);
                      //document.getElementById("Lang_3second").innerHTML = window.GetTextByName("Lang_3second", langdata);
                      //document.getElementById("Lang_4second").innerHTML = window.GetTextByName("Lang_4second", langdata);
                      //document.getElementById("Lang_5second").innerHTML = window.GetTextByName("Lang_5second", langdata);

                  }, false, false);
              }



              getlanguage();





              //时间按钮事件
              function startAnimation()
              {
                  
                  //var strBeginTime= "2017-01-11".replace("-", "/").replace("-", "/");
                  
                  var i=0;
                  i=i++;

                  var timesInput = document.getElementById('times');


                  var strBeginTime =BegHistoryTime.replace("-", "/").replace("-", "/");  

                  var date=new Date(Date.parse(strBeginTime))

                  var year = date.getFullYear();  
                  var month = date.getMonth()+1; 
                  var date1 = date.getDate();  
                  
                  var hour = date.getHours()+parseInt(timesInput.value);   
                  var minutes = date.getMinutes();   
                  var second = date.getSeconds(); 

                  if(month<10){month="0"+month;}

                  if(date1<10) { date1="0"+date1;}

                  if(hour<10) {hour="0"+hour;}

                  if(minutes<10) {minutes="0"+minutes;}

                  if(second<10) {second="0"+second;}


                  var timefull =year+"-"+month+"-"+date1+" "+hour+":"+minutes+":"+second;
       

                  EndHistoryTime =timefull;

                  loadEvent.setEndHistoryTime(EndHistoryTime);
                  //ShowAllHitory(2);
                  loadEvent.startAnimation();

             
              }

              function endAnimation(){
                  loadEvent.endAnimation();
                  
              }

          </script>
</body>
</html>
