<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="main.aspx.cs" Inherits="Web.main" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <style type="text/css">
        v\:* {
            behavior: url(#default#VML);
            position: absolute;
        }

        o\:* {
            behavior: url(#default#VML);
        }

        v\:shape {
            behavior: url(#default#VML);
        }
    </style>
    <%--邮件菜单样式--%>
    <style type="text/css">
        /*html, body {
            height: 100%;
            overflow: hidden;
        }*/
        html, body, #map, #form1 {
            margin: 0;
            padding: 0;
            width: 100%;
            height: 100%;
        }

        body, div, ul, li {
            margin: 0;
            padding: 0;
        }

        body {
            font: 12px/1.5 \5fae\8f6f\96c5\9ed1;
        }

        ul {
            list-style-type: none;
        }

        #policemouseMenu, #policemouseMenu_invalide, #groupmouseMenu, #dispatchmouseMenu, #carDutyMenu {
            position: absolute;
            top: -9999px;
            left: -9999px;
            z-index: 22;
        }

            #policemouseMenu ul, #policemouseMenu_invalide ul, #groupmouseMenu ul, #dispatchmouseMenu ul, #carDutyMenu ul {
                float: left;
                border: 1px solid #979797;
                background: #f1f1f1 url(Images/line.png) 24px 0 repeat-y;
                padding: 2px;
                box-shadow: 2px 2px 2px rgba(0,0,0,.6);
            }

                #policemouseMenu ul li, #policemouseMenu_invalide ul li, #groupmouseMenu ul li, #dispatchmouseMenu ul li, #carDutyMenu ul li {
                    float: left;
                    clear: both;
                    height: 24px;
                    cursor: pointer;
                    line-height: 24px;
                    white-space: nowrap;
                    padding: 0 30px;
                }

                    #policemouseMenu ul li.sub, #policemouseMenu_invalide ul li.sub, #groupmouseMenu ul li.sub, #dispatchmouseMenu ul li.sub, #carDutyMenu ul li.sub {
                        background-repeat: no-repeat;
                        background-position: right 9px;
                        background-image: url(Images/arrow.png);
                    }

                    #policemouseMenu ul li.active, #policemouseMenu_invalide ul li.active, #groupmouseMenu ul li.active, #dispatchmouseMenu ul li.active, #carDutyMenu ul li.active {
                        background-color: #f1f3f6;
                        border-radius: 3px;
                        border: 1px solid #aecff7;
                        height: 22px;
                        line-height: 22px;
                        background-position: right -8px;
                        padding: 0 29px;
                    }

                #policemouseMenu ul ul, #policemouseMenu_invalide ul ul, #groupmouseMenu ul ul, #dispatchmouseMenu ul ul, #carDutyMenu ul ul {
                    display: none;
                    position: absolute;
                }

        #MSN {
            position: absolute;
            z-index: 99;
            width: 320px;
            height: 20px;
            bottom: 5px;
            font-size: 12px;
            color: White;
        }

            #MSN ul {
                margin-top: 5px;
                text-align: center;
                list-style: none;
            }

        #scrollarea {
            margin-left: 5px;
            width: 320px;
            text-align: left;
        }

        .img1 {
            transform: rotate(0deg);
            transition: All 0.4s ease-in-out;
            animation: circle 2s; /*匀速 循环*/
        }

        .img2 {
            transition: All 0.4s ease-in-out;
            transform: rotate(180deg);
            animation: circle 2s; /*匀速 循环*/
        }

        @keyframes circle {

            0% {
                transform: rotate(0deg);
            }

            100% {
                transform: rotate(-180deg);
            }
        }


        .open {
            transform: rotate(-180deg);
            -ms-transform: rotate(-180deg); /* IE 9 */
            -moz-transform: rotate(-180deg); /* Firefox */
            -webkit-transform: rotate(-180deg); /* Safari and Chrome */
            -o-transform: rotate(-180deg); /* Opera */
        }
         .rotate {/*陈孝银20180627*/
            transform:rotate(-90deg);
            transition:transform 1s
        }

/*设置缩放控件ZoomToExtent的样式，将其放到导航条下方
        */
#map .ol-zoom .ol-zoom-in {
    margin-top: 60px;
    width:2em;
    height:2em
}
#map .ol-zoom .ol-zoom-out {
    margin-top: 210px;
    width:2em;
    height:2em
}

#map .ol-zoomslider {
    background-color: transparent;
    top: 12.62em;
    right:0.75em;
    height:218px;
}

#map .ol-touch .ol-zoom .ol-zoom-out {
    margin-top: 212px;
}

#map .ol-touch .ol-zoomslider {
    top: 2.75em;
}

#map .ol-zoom-in.ol-has-tooltip:hover [role=tooltip],
#map .ol-zoom-in.ol-has-tooltip:focus [role=tooltip] {
    top: 3px;
}

#map .ol-zoom-out.ol-has-tooltip:hover [role=tooltip],
#map .ol-zoom-out.ol-has-tooltip:focus [role=tooltip] {
    top: 232px;
}

#map .ol-zoom-extent {
    top: 280px;
}
#ol-ranging {
background:url(Images/ring.png) 0 0 no-repeat
        }
#ol-BoxSelection {
background:url(Images/choose.png) 0 0 no-repeat
        }
#ol-BoxSelection:hover {
background:url(Images/choose_un.png) 0 0 no-repeat
        }
#BoxSelection-type {
    background-color:rgba(0,60,136,0.5);
    top:117px; 
    right:50px; 
    width:60px;
    height:28px; 
    position:absolute;
    background-position:center center;
    border-radius:3px;
        z-index:999
        }
#BoxSelection-type img {
                width:22px;
                height:22px;
                text-align: center;  
                display:block;
                margin:0 auto
        }
#BoxSelection-type img:hover {
                width:24px;
                height:24px;
                text-align: center;  
                display:block;
                margin:0 auto
        }
#BoxSelection-type1 {
    position:relative;
    top:3px;
    left:5px;
    float:left;
           }
#BoxSelection-type2 {
    position:relative;
    top:3px;
    right:5px;
    float:right;
           }
#mouse-position {
    background-color:rgba(255,255,255,0.8);
    top:147px; 
    right:50px; 
    width:60px;
    height:20px; 
    position:absolute;
    background-position:center center;
    border-radius:3px;
    z-index:999;
    display:none;
        }
.layershow_ul li{
display:inline-block;
margin-left:25px;
margin-top:32px
}
.layershow_ul {
color:#fff;
display:inline-block
}
#yonghujiankong ul {
color:#fff;
display:inline-block
}
#yonghujiankong li{
display:inline-block;
width:30px;
}
#Userlefttree:hover
{
    color:	#00FF00
}
#Monitorlefttree:hover
{
    color:	#00FF00
}
    </style>

    <link href="CSS/OpenLayers/ol.css" rel="stylesheet" />
    <link href="CSS/OpenLayers/ol-control.css" rel="stylesheet" />
    <link href="lqnew/js/resPermissions/jquery-easyui-1.4.1/themes/bootstrap/easyui.css" rel="stylesheet" />
    <link href="lqnew/js/resPermissions/jquery-easyui-1.4.1/themes/icon.css" rel="stylesheet" />

    <script src="JS/OpenLayers/ol-debug.js" type="text/javascript"></script>
    <%-- <script src="JS/Video-test1.js" type="text/javascript"></script>--%>
    <link href="CSS/Default.css" rel="stylesheet" type="text/css" />
    <link href="CSS/lq_style.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="css/smartMenu.css" type="text/css" />
    <script src="lqnew/js/StringPrototypeFunction.js" type="text/javascript"></script>
    <link rel="stylesheet" type="text/css" href="pro_dropdown_2/pro_dropdown_2.css" />
    <script src="lqnew/js/GlobalVar.js" type="text/javascript"></script>
    <script src="MyCommonJS/addAll.js" type="text/javascript"></script>
    <script src="JS/addAll.js" type="text/javascript"></script>
    <script src="lqnew/js/PointIn.js" type="text/javascript"></script>
    <script src="lqnew/js/Stockade.js" type="text/javascript"></script>
    <script src="lqnew/js/DrawPolygon.js" type="text/javascript"></script>
    <script src="lqnew/js/BaseStation.js" type="text/javascript"></script>
    <script src="lqnew/js/PoliceStation.js" type="text/javascript"></script>
    <script src="lqnew/js/List.js" type="text/javascript"></script>
    <script src="lqnew/js/DefaultJS.js" type="text/javascript"></script>
    <script src="lqnew/js/DrawOval.js" type="text/javascript"></script>
    <script src="lqnew/js/PlayerJS.js" type="text/javascript"></script>
    <script src="lqnew/js/GlobalConst.js" type="text/javascript"></script>
    <script src="WebGis/js/model/ReplaceJQ.js" type="text/javascript"></script>
    <script src="../lqnew/js/Cookie.js" type="text/javascript"></script>
    <script src="../lqnew/js/MouseMenuEvent.js" type="text/javascript"></script>
    <script src="../js/MouseMenu.js" type="text/javascript"></script>
    <script src="JS/LangueSwitch.js" type="text/javascript"></script>
    <script src="../lqnew/js/Dragobj.js" type="text/javascript"></script>
    <script src="lqnew/js/LogModule.js" type="text/javascript"></script>
    <script type="text/javascript" src="SWF/swfobject.js"></script>
    <script src="JS/map.js" type="text/javascript"></script>
    <script src="JS/EzMapAPI.js" type="text/javascript"></script>
    <script src="JS/video.js" type="text/javascript"></script>
     <!--------------------------------------xzj--2018/4/12--------------------------------------------------------- -->
    <script src="JS/rightMenu.js" type="text/javascript"></script>
    <!--左侧树 -->
    <link rel="stylesheet" href="CSS/zTree/zTreeStyle/zTreeStyle.css" type="text/css" />
    <!--左侧树 -->
    <script type="text/javascript">
        var car_duty_issi_selected = "";
        var car_duty_uid_selected = "";
        function getInitLoLa() {

            return { initLo: '0', initLa: '0' }
        }



        function getLatLngByPoint(point) {
            var mian = document.getElementById("main");
            return mian.PxToLalo(point.x, point.y);
        }

        function bodyonclickTest() {

            if (isGetJWD) {
                var e = window.event;
                var point = { x: e.clientX, y: e.clientY };

                this.xx = getLatLngByPoint(point).lo;
                this.yy = getLatLngByPoint(point).la;
                alert(xx);
                alert(yy);
            }
        }
        function test2() {
            var mian = document.getElementById("main");
            mian.rectselectBut();
        }

        function getCookieByName(cookname) {
            var cookieValue = "";
            var strCookies = document.cookie;
            var strArray = document.cookie.split(';');
            for (var i = 0; i < strArray.length; i++) {
                var vl = strArray[i].split('=');
                if (vl[0].replace(" ", "") == cookname.replace(" ", "")) {
                    cookieValue = vl[1];
                    break;
                }
            }
            return cookieValue;
        }
        //地图右键菜单中关注列表的iframe------------------------xzj--2018/4/9--------------------------
        function creatconcernlistwindow() {
            window.document.getElementById("concernlist_ifr").src = "lqnew/opePages/concernlist.aspx";
            var concerndiv = window.document.getElementById("concernlist");
            concerndiv.onmousedown = function () { mystartDragWindow(this); this.style.border = "solid 3px transparent"; cgzindex(this); };
            concerndiv.onmouseup = function () { mystopDragWindow(this); this.style.border = "0px"; };
            concerndiv.onmousemove = function () { mydragWindow(this) };
        }
        //隐藏右键菜单中关注列表的iframe------------------------xzj--2018/4/9--------------------------
        function hideconcernlistdiv() {
            var policelists_div = document.getElementById("concernlist");
            if (policelists_div) {
                policelists_div.style.display = "none";
            }
        }
        //显示右键菜单中关注列表的iframe------------------------xzj--2018/4/9--------------------------
        function displayconcernlistdiv() {
            document.getElementById("contextmenu_container2").parentNode.style.display = "none";
            var policelists_div = document.getElementById("concernlist");
            if (policelists_div) {
                policelists_div.style.display = "block";
            }
        }
        //隐藏右键菜单中查找警员的iframe------------------------xzj--2018/4/9--------------------------
        function hidepolicelistsdiv() {
            var policelists_div = document.getElementById("policelistsdiv");
            if (policelists_div) {
                policelists_div.style.display = "none";
            }
        }
        //显示右键菜单中查找警员的iframe------------------------xzj--2018/4/9--------------------------
        function displaypolicelistsdiv() {
            document.getElementById("contextmenu_container2").parentNode.style.display = "none";
            var policelists_div = document.getElementById("policelistsdiv");
            if (policelists_div) {
                policelists_div.style.display = "block";
            }
            var grouplists_div = document.getElementById("grouplistsdiv");
            if (grouplists_div) {
                grouplists_div.style.display = "none";
            }
            var dispatchlists_div = document.getElementById("dispatchlistsdiv");
            if (dispatchlists_div) {
                dispatchlists_div.style.display = "none";
            }
        }
        //右键菜单中组呼---------------------------------xzj--2018/4/24-------------------------------------------
        function displayCallPane() {
            document.getElementById("contextmenu_container2").parentNode.style.display = "none";
            if (useprameters.callActivexable == false) {
                alert(GetTextByName("checkcallcontrolregister", useprameters.languagedata));
                return;
            }
            mycallfunction('GroupCall', 380, 300, 0, 1999);
        }
        //右键菜单中搜索锁定警员-------------------------------------xzj--2018/4/25---------------------------------------------------
        function displayLockUser() {
            document.getElementById("contextmenu_container2").parentNode.style.display = "none";
            mycallfunction('LockkByCtrlPanl', 350, 220, 0, 1999);
        }
        //右键菜单中查询布控-------------------------------------xzj(没做)--2018/4/25---------------------------------------------------
        function displayCXBK() {
            document.getElementById("contextmenu_container2").parentNode.style.display = "none";
            if (useprameters.callActivexable == false) {
                alert(GetTextByName("checkcallcontrolregister", useprameters.languagedata));
                return;
            }
            rectselectBut();
        }
        //右键菜单中动态重组-------------------------------------xzj--2018/4/25---------------------------------------------------
        function displayDTCZ() {
            document.getElementById("contextmenu_container2").parentNode.style.display = "none";
            if (useprameters.callActivexable == false) {
                alert(GetTextByName("checkcallcontrolregister", useprameters.languagedata));
                return;
            }
            var sid = "";
            for (var i = 0; i < useprameters.Selectid.length; i++) {
                sid += useprameters.Selectid[i] + ";";
            }
            document.getElementById("senddtczhidsids").value = sid;
            mycallfunction('SendDTCZ', 580, 700, '', 1999);
            if (window.parent.document.getElementById('SendDTCZ'))//20181119--xzj
            {
                SendDTCZFrom.submit();
            }
        }
        //右键菜单中实时轨迹列表-------------------------------------xzj--2018/4/25---------------------------------------------------
        function displayRealTimeTraceList() {
            document.getElementById("contextmenu_container2").parentNode.style.display = "none";
            openRealTimeTraceUserList();//没用传入的参数，而是根据useprameters.realtimeTraceUserIds
        }
        //查看场强
        function showFSHeatMap() {
            document.getElementById("contextmenu_container2").parentNode.style.display = "none";
            heatMapManager.open();
        }
        function Page_Onload() {

            window.ondblclick = function () {
                bodyonclickTest();
            }

            //getTypePictureLoadPath();//获取警员类型图片路径

            //MouseMenuEvent();//加载警员右键新的菜单事件

            creatconcernlistwindow();//地图右键菜单中关注列表的iframe
            //document.getElementById("MSN").style.left = (document.body.offsetWidth - 494) / 2;

            //document.documentElement.style.backgroundImage = "url('./lqnew/opepages/upload/ReadImage.aspx?name=MapBackPic&type=MapBackPic')"; //设置页面背景
            //setTimeout(GetStockAdeInit, 1000); /**@获取电子栅栏初始值放在调度台关联成功后*/

            //var videoCommandEnableInterval = setInterval(function () {
            //    if (useprameters.VideoCommandEnable != undefined) {
            //        if (useprameters.VideoCommandEnable == '1') {
            //            var head = document.getElementsByTagName('head')[0];
            //            var script = document.createElement('script');
            //            script.type = 'text/javascript';
            //            script.src = 'js/video.js';
            //            head.appendChild(script);
            //            clearInterval(videoCommandEnableInterval);
            //        }
            //        else {
            //            clearInterval(videoCommandEnableInterval);
            //        }
            //    }

            //}, 200)

        }
        //function drowDZZL() {
        //var mian = document.getElementById("main");
        // mian.drowDZZL();
        //}
    </script>
</head>
<body onload="Page_Onload()">
    <form id="form1" runat="server">
        <div id="userHead" style="display: block;">
            <img id="preview" src="" style="display: none;" />
        </div>
        <div class="tool_div" style="float: left; height: 35px; position: absolute; left: 0px; z-index: 100; top: 0px; width: 100%">
            <ul id="nav">
                <li class="top" style="<%  
                    if (Request.Cookies["usertype"] == null)
                    {
                        Response.Redirect("login.html");
                    }
                    if (int.Parse(Request.Cookies["usertype"].Value) == 1)
                    {
                                %>display: none<%
                                
                    }
                    else
                    { 
                                %>display: block<%
                    }                   
                    %>">
                    <div style="cursor: pointer; width: 90px; height: 35px; text-align: left; line-height: 30px; margin-top: 2px; background-repeat: no-repeat; padding-left: 4px;"
                        onmouseover="javascript:this.style.backgroundImage='url(Images/ToolBar/toolbar_bg1.png)';"
                        onmouseout="javascript:this.style.backgroundImage='';" id="jichuxx">
                        <img src="Images/ToolBar/jcxx.png" />&nbsp;
                    </div>
                    <ul class="sub" style="width: 160px;">
                        <li><a href="#GIS" onclick="mycallfunction('manager_entity',693, 354)" style="width: 160px" id="danweixinxiweihu">
                            <span style="background: url(Images/ToolBar/toolbar_bgx.png) no-repeat 0px 0; width: 16px; height: 16px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></a></li>
                        <li><a href="#GIS" onclick="mycallfunction('manager_ISSI',880, 354)" style="width: 160px" id="zhongduanxinxiweihu">
                            <span style="background: url(Images/ToolBar/toolbar_bgx.png) no-repeat 0px 0; width: 16px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></a></li>
                       <!---------------------------xzj--2018/6/28--修改onclick()调用函数的高度参数为430------------------>
                        <li><a href="#GIS" onclick="mycallfunction('manager_user',900, 430)" style="width: 160px" id="ydyhxinxiweihu">
                        <!---------------------------xzj--2018/6/28--修改onclick()调用函数的高度参数为430------------------>
                            <span style="background: url(Images/ToolBar/toolbar_bgx.png) no-repeat 0px 0; width: 16px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></a></li>
                        <li><a href="#GIS" onclick="mycallfunction('manager_login',700, 354)" style="width: 160px" id="ddyxxwh">
                            <span style="background: url(Images/ToolBar/toolbar_bgx.png) no-repeat 0px 0; width: 16px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></a></li>
                        <li><a href="#GIS" onclick="mycallfunction('manager_role',700, 354)" style="width: 160px" id="ddyjswh">
                            <span style="background: url(Images/ToolBar/toolbar_bgx.png) no-repeat 0px 0; width: 16px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></a></li>
                        <li><a href="#GIS" onclick="mycallfunction('manager_Procedure',480,500)" style="width: 160px" id="procedure">
                            <span style="background: url(Images/ToolBar/toolbar_bgx.png) no-repeat 0px 0; width: 16px; height: 16px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></a>
                        </li>
                        <li><a href="#GIS" onclick="mycallfunction('manager_Ptype',800,500)" style="width: 160px" id="proceduretype">
                            <span style="background: url(Images/ToolBar/toolbar_bgx.png) no-repeat 0px 0; width: 16px; height: 16px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></a>
                        </li>
                        <%--配置用户管理--%>
                        <li><a href="#GIS" onclick="mycallfunction('manager_configuser',618, 354)" style="width: 160px" id="configuser">
                            <span style="background: url(Images/ToolBar/toolbar_bgx.png) no-repeat 0px 0; width: 16px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></a></li>
                        <li style="display: none"><a href="#GIS" onclick="mycallfunction('FixedStation',618, 354)" style="width: 160px" id="GDTXXWH">
                            <span style="background: url(Images/ToolBar/toolbar_bgx.png) no-repeat 0px 0; width: 16px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></a></li>
                        <li><a href="#GIS" onclick="mycallfunction('manageUserDutyList',750, 550)" style="width: 160px" id="lcyhbd">
                            <span style="background: url(Images/ToolBar/toolbar_bgx.png) no-repeat 0px 0; width: 16px; height: 16px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></a></li>

                        <li style="<%                           
                            DbComponent.Entity entity = new DbComponent.Entity(); int entity_depth = entity.GetEntityIndex(int.Parse(Request.Cookies["id"].Value)); if (entity_depth != 0 && entity_depth != -1)
                            {
                                %>display: none<%
                                
                            }%>"><a href="#GIS" onclick="mycallfunction('manager_Dispatch',650, 354)" style="width: 160px" id="ddtxxwh">
                                <span style="background: url(Images/ToolBar/toolbar_bgx.png) no-repeat 0px 0; width: 16px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></a></li>

                        <%--<li><a href="#GIS" onclick="mycallfunction('manager_Stackade',600, 354)" style="width: 160px" id="dzzlxxwh">
                            <span style="background: url(Images/ToolBar/toolbar_bgx.png) no-repeat -0px 0; width: 16px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></a></li>--%>

                        <li style="<% 
                            if (entity_depth != 0 && entity_depth != -1)
                            {
                                %>display: none<%
                                
                            }%>">
                            <!-------------xzj--2018/7/19----------------------将onclick调用的函数width参数改为420-->
                            <a href="#GIS" onclick="mycallfunction('manager_UserType',550, 420,null,null,1)" style="width: 160px;" id="yhlxxxwh">
                                <span style="background: url(Images/ToolBar/toolbar_bgx.png) no-repeat -0px 0; width: 16px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></a></li>
                        <li style="<%
                            if (entity_depth != 0 && entity_depth != -1)
                            {
                                %>display: none<%
                            } %>"><a href="#GIS" onclick="mycallfunction('manager_BaseStation',550, 354)" style="width: 160px;" id="jzxxwh">
                                <span style="background: url(Images/ToolBar/toolbar_bgx.png) no-repeat -0px 0; width: 16px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></a></li>

                        <%--   <li style="<%
                     
                              if (entity_depth != 0 && entity_depth != -1)
                            {
                                %>display: none<%
                                
                            }
           
                    
                    %>"><a href="#GIS" onclick="mycallfunction('manager_Video',550, 354)" style="width: 160px;" id="jkxxwh">
                        <span style="background: url(Images/ToolBar/toolbar_bgx.png) no-repeat -0px 0; width: 16px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></a></li>--%>
                    </ul>
                </li>
                <li class="top" style="<%                     
                    if (int.Parse(Request.Cookies["usertype"].Value) == 1)
                    {
                                %>display: none<%
                    }
                    else
                    { 
                                %>display: block<%
                    }                   
                    %>">
                    <div style="cursor: pointer; width: 90px; height: 35px; text-align: left; line-height: 30px; margin-top: 2px; background-repeat: no-repeat; padding-left: 4px;"
                        onmouseover="javascript:this.style.backgroundImage='url(Images/ToolBar/toolbar_bg1.png)';"
                        onmouseout="javascript:this.style.backgroundImage='';" id="bzxx">
                        <img src="Images/ToolBar/group.png" />
                    </div>
                    <ul class="sub" style="width: 160px;">
                        <li><a href="#GIS" onclick="mycallfunction('manager_Group',774,354)" style="width: 160px" id="xzxxwh">
                            <span style="background: url(Images/ToolBar/toolbar_bgx.png) no-repeat 0px 0; width: 16px; height: 16px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></a></li>
                        <li><a href="#GIS" onclick="mycallfunction('manager_TBGroup',774,354)" style="width: 160px" id="tbzxxwh">
                            <span style="background: url(Images/ToolBar/toolbar_bgx.png) no-repeat 0px 0; width: 16px; height: 16px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></a></li>
                        <li style="display: block"><a href="#GIS" onclick="mycallfunction('manager_PJGroup',774,354)"
                            style="width: 160px" id="pjzxxwh"><span style="background: url(Images/ToolBar/toolbar_bgx.png) no-repeat 0px 0; width: 16px; height: 16px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></a></li>
                        <li style="display: block"><a href="#GIS" onclick="mycallfunction('manager_DXGroup',774,354)"
                            style="width: 160px" id="dxzxxwh"><span style="background: url(Images/ToolBar/toolbar_bgx.png) no-repeat 0px 0; width: 16px; height: 16px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></a></li>
                        <li><a href="#GIS" onclick="mycallfunction('manager_BSGroup',774,354)" style="width: 160px" id="jzzxxwh">
                            <span style="background: url(Images/ToolBar/toolbar_bgx.png) no-repeat 0px 0; width: 16px; height: 16px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></a></li>
                        <li><a href="#GIS" onclick="mycallfunction('manager_DTGroup',550, 354)" style="width: 160px;" id="dtczxx">
                            <span style="background: url(Images/ToolBar/toolbar_bgx.png) no-repeat -0px 0; width: 16px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></a></li>

                    </ul>
                </li>
                <li class="top" style="<%                     
                    if (int.Parse(Request.Cookies["usertype"].Value) == 1)
                    {
                                %>display: none<%
                                
                    }
                    else
                    { 
                                %>display: none<%
                    }                   
                    %>">
                    <div style="cursor: pointer; width: 90px; height: 35px; text-align: left; line-height: 30px; margin-top: 2px; background-repeat: no-repeat; padding-left: 4px;"
                        onmouseover="javascript:this.style.backgroundImage='url(Images/ToolBar/toolbar_bg1.png)';"
                        onmouseout="javascript:this.style.backgroundImage='';" id="rzxx">
                        <img src="Images/ToolBar/group.png" />
                    </div>
                    <ul class="sub" style="width: 160px;">
                        <li><a href="#GIS" onclick="mycallfunction('manager_Group',774,354)" style="width: 160px" id="sysLog_Menu">
                            <span style="background: url(Images/ToolBar/toolbar_bgx.png) no-repeat 0px 0; width: 16px; height: 16px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></a></li>
                        <li><a href="#GIS" onclick="mycallfunction('manager_TBGroup',774,354)" style="width: 160px" id="operLog_Menu">
                            <span style="background: url(Images/ToolBar/toolbar_bgx.png) no-repeat 0px 0; width: 16px; height: 16px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></a></li>
                        <li style="display: block"><a href="#GIS" onclick="mycallfunction('manager_PJGroup',774,354)"
                            style="width: 160px" id="callLog_Menu"><span style="background: url(Images/ToolBar/toolbar_bgx.png) no-repeat 0px 0; width: 16px; height: 16px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></a></li>
                        <li style="display: block"><a href="#GIS" onclick="mycallfunction('manager_DXGroup',774,354)"
                            style="width: 160px" id="smsLog_Menu"><span style="background: url(Images/ToolBar/toolbar_bgx.png) no-repeat 0px 0; width: 16px; height: 16px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></a></li>
                        <li><a href="#GIS" onclick="mycallfunction('LogList/ErrorList',774,354)" style="width: 160px" id="errorLog_Menu">
                            <span style="background: url(Images/ToolBar/toolbar_bgx.png) no-repeat 0px 0; width: 16px; height: 16px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></a></li>
                    </ul>
                </li>
                <li style="display: none" class="top">
                    <div id="myMsgSend" style="cursor: pointer; width: 90px; height: 35px; text-align: left; line-height: 30px; margin-top: 2px; padding-left: 4px;"
                        onclick="javascript:var ifrs = document.frames['ifr_callcontent']; sendMsgToSelect(this);">
                        <img src="Images/Msg.png" />&nbsp;
                    </div>
                </li>
                <li class="top" style="<%                     
                    if (int.Parse(Request.Cookies["usertype"].Value) == 2)
                    {
                                %>display: none<%
                                
                    }
                    else
                    { 
                                %>display: block<%
                    }                   
                    %>">
                    <div style="cursor: pointer; width: 90px; height: 35px; text-align: left; line-height: 30px; margin-top: 2px; background-repeat: no-repeat; padding-left: 4px;"
                        onmouseover="javascript:this.style.backgroundImage='url(Images/ToolBar/toolbar_bg1.png)';"
                        onmouseout="javascript:this.style.backgroundImage='';" id="ddgn">
                        <img src="Images/ToolBar/e0.png" />
                    </div>
                    <ul class="sub" style="width: 160px;">
                        <li><a href="#GIS" onclick="mycallfunction('DispatchFunc',450,600)" style="width: 160px" id="hjmb">
                            <span style="background: url(Images/ToolBar/toolbar_bgx.png) no-repeat 0px 0; width: 16px; height: 16px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></a></li>
                        <li><a href="#GIS" onclick="mycallfunction('SearchGpsStatues',900,550)" style="width: 160px" id="gpslist">
                            <span style="background: url(Images/ToolBar/toolbar_bgx.png) no-repeat 0px 0; width: 16px; height: 16px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></a></li>
                        <li><a href="#GIS" onclick="mycallfunction('SearchGpsPullStatues',950,550)" style="width: 160px" id="GPSPullList">
                            <span style="background: url(Images/ToolBar/toolbar_bgx.png) no-repeat 0px 0; width: 16px; height: 16px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></a></li>
                        <li><a href="#GIS" onclick="mycallfunction('SMS/SMSList',908,505)" style="width: 160px" id="sms_sjx">
                            <span style="background: url(Images/ToolBar/toolbar_bgx.png) no-repeat 0px 0; width: 16px; height: 16px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></a></li>
                        <li><a href="#GIS" onclick="mycallfunction('LogView/OperationLog',900,432)" style="width: 160px" id="operationlog">
                            <span style="background: url(Images/ToolBar/toolbar_bgx.png) no-repeat 0px 0; width: 16px; height: 16px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></a></li>
                        <li><a href="#GIS" onclick="mycallfunction('DTGroup/DTGroupList',900,550)" style="width: 160px" id="dtczrestlt">
                            <span style="background: url(Images/ToolBar/toolbar_bgx.png) no-repeat 0px 0; width: 16px; height: 16px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></a></li>

                    </ul>

                </li>
                <%--<li style="<%            

                     if (System.Configuration.ConfigurationManager.AppSettings["versionType"].ToString() == "1")
                            {
                                %>display: none<%
                                
                            }           
                    
                    %>" class="top"> 
                    <div id="myspjk" style="cursor: pointer; width: 90px; height: 35px; text-align: left; line-height: 30px; margin-top: 2px; padding-left: 4px;"
                        onclick="javascript:var ifrs = document.frames['ifr_callcontent']; videoToSelect(this);">
                        <img style="width:20px;height:20px" src="Images/VideoPic/Video.png" />&nbsp;
                    </div>
                </li>--%>
                <li class="top" style="<%                     
                    if (int.Parse(Request.Cookies["usertype"].Value) == 2)
                    {
                                %>display: none<%
                                
                    }
                    else
                    { 
                                %>display: block<%
                    }                   
                    %>">
                    <div id="options" onclick="openoption(this)" style="cursor: pointer; width: 90px; height: 35px; text-align: left; line-height: 30px; margin-top: 2px; padding-left: 4px;"
                        onclick="">
                        <img src="Images/option.png" />&nbsp;
                    </div>
                </li>

                <li class="top" style="display: none" id="Menu_qwgl">
                    <div style="cursor: pointer; width: 100px; height: 35px; text-align: left; line-height: 30px; margin-top: 2px; background-repeat: no-repeat; padding-left: 4px;"
                        onmouseover="javascript:this.style.backgroundImage='url(Images/ToolBar/toolbar_bg1.png)';"
                        onmouseout="javascript:this.style.backgroundImage='';" id="Lang_qwgl">
                        <img src="Images/ToolBar/e0.png" />
                    </div>
                    <ul class="sub" style="width: 160px;">
                        <li><a href="#GIS" onclick="mycallfunction('GPSRecords',700,900)" style="width: 160px" id="Lang_gpstj">
                            <span style="background: url(Images/ToolBar/toolbar_bgx.png) no-repeat 0px 0; width: 16px; height: 16px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
                        </a>

                        </li>
                        <%--  <li ><a href="#GIS" onclick="mycallfunction('manage_CarDuty',1000,1004)" style="width: 160px" id="car_duty">
                            <span style="background: url(Images/ToolBar/toolbar_bgx.png) no-repeat 0px 0; width: 16px; height: 16px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
                            </a>

                        </li>--%>
                        <li><a href="#GIS" onclick="mycallfunction('manage_Attendance',1000,550)" style="width: 160px" id="Lang_djbbtj">
                            <span style="background: url(Images/ToolBar/toolbar_bgx.png) no-repeat 0px 0; width: 16px; height: 16px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
                        </a>

                        </li>
                        <li><a href="#GIS" onclick="mycallfunction('manager_UserDevice',1000,550,null,null,1)" style="width: 160px" id="Lang_UserDeviceManage">
                            <span style="background: url(Images/ToolBar/toolbar_bgx.png) no-repeat 0px 0; width: 16px; height: 16px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
                        </a>

                        </li>

                        <%--预案管理--%>
                        <li><a href="#GIS" onclick="mycallfunction('manager_Emergency',1000,550,null,null,1)" style="width: 160px" id="Lang_emergency">
                            <span style="background: url(Images/ToolBar/toolbar_bgx.png) no-repeat 0px 0; width: 16px; height: 16px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
                        </a>

                        </li>




                    </ul>

                </li>
                <li class="top" style="<%                     
                    if (int.Parse(Request.Cookies["usertype"].Value) == 1)
                    {
                                %>display: none<%
                                
                    }
                    else
                    { 
                                %>display: block<%} %>">
                    <div id="logconfig" onclick="mycallfunction('LogList/GetLogConfig',450,804)" style="cursor: pointer; width: 90px; height: 35px; text-align: left; line-height: 30px; margin-top: 2px; padding-left: 4px;">
                        <%--<img src="Images/ToolBar/e0.png" />--%>
                        <img src="Images/option.png" />
                    </div>
                </li>
                <li class="top">
                    <div style="cursor: pointer; width: 90px; height: 35px; text-align: left; line-height: 30px; margin-top: 2px; background-repeat: no-repeat; padding-left: 4px;"
                        onmouseover="javascript:this.style.backgroundImage='url(Images/ToolBar/toolbar_bg1.png)';"
                        onmouseout="javascript:this.style.backgroundImage='';" id="helps">
                        <img src="Images/ToolBar/e0.png" />
                    </div>
                    <ul class="sub" style="width: 160px;">
                        <li><a href="<%
                     
                                if (ConfigurationManager.AppSettings["defaultLanguage"].ToString() == "zh-CN")
                                {
                                %>eTRA GIS_HELP/help.html<%
                                
                                }
                                else
                                { 
                                %>eTRA GIS_HELP_En/help.html<%
                                }
           
                    
                    %>"
                            target="_blank" style="width: 160px" id="helpFaq"><span
                                style="background: url(Images/ToolBar/toolbar_bgx.png) no-repeat 0px 0; width: 16px; height: 16px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></a></li>
                        <li><a href="#GIS" onclick="mycallfunction('About',450,190)" style="width: 160px" id="about"><span
                            style="background: url(Images/ToolBar/toolbar_bgx.png) no-repeat 0px 0; width: 16px; height: 16px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></a></li>
                    </ul>
                </li>
                <li class="top">
                    <div id="myloginout" style="cursor: pointer; width: 90px; height: 35px; text-align: left; line-height: 30px; margin-top: 2px; padding-left: 4px;"
                        onclick="loginout();">
                        <img src="Images/ToolBar/mytree.png" />&nbsp;
                    </div>
                </li>
                <li style="<%                     
                    if (int.Parse(Request.Cookies["usertype"].Value) == 2)
                    {
                                %>display: none<%
                                
                    }
                    else
                    { 
                                %>display: block<%
                    }                   
                    %>; float: right; margin-top: 8px; margin-right: 5px; cursor: pointer;"><span id="refreshtimes"></span>
                    <select onchange="cgtime(this.value*1000)" id="refreshtime">
                        <%--<option value="1">1</option>--%>
                        <option value="10">10</option>
                        <option value="30">30</option>
                        <option value="60">60</option>

                    </select>
                    <span id="sencond"></span>
                </li>
                <li class="top" style="float: right;">
                    <div id="Div1" style="float: right; cursor: pointer; height: 35px; text-align: left; line-height: 30px; margin-top: 5px; padding-right: 4px;">
                        &nbsp;
                    </div>
                </li>
                <li class="top" style="float: right;">
                    <div id="Div2" style="float: right; cursor: pointer; height: 35px; text-align: left; line-height: 30px; margin-top: 5px; padding-right: 4px;">
                        &nbsp;<asp:Label ID="lbEntityInformation" runat="server" Text=""></asp:Label>
                    </div>
                </li>
            </ul>
        </div>
        <div id="UpCallPanl" align="right" style="z-index: 10; position: absolute; top: 400px; right: 0px; width: 323px; height: 250px; overflow: hidden; display: block">
            <iframe id="mypancallContent" name="mypancallContent" src="" width="100%" allowtransparency="true"
                scrolling="no" style="padding-bottom: 0px;" frameborder="0" height="300px"></iframe>
        </div>
        <div id="zTree" align="right" style="z-index: 10; position: absolute; top: 50px; left: 0px; width: 205px; height: 445px; overflow: hidden; display: <%                     
            if (int.Parse(Request.Cookies["usertype"].Value) == 1)
            {
                                %>block<%
                                
                    }
                    else
                    { 
                                %>none<%
                    }                   
                    %>">
            <div class="content_wrap" style="float: left; width: 183px; height: 445px; background-image: url(TreeLineImages/tree_bg1.png)">
                <div id="yonghujiankong" style="color: #fff; margin: 3px 2px 0 10px; position: relative; text-align: left">
                    <ul>
                        <li id="Userlefttree" style=" font-size:12px;cursor:pointer;margin-right:5px"><%--用户--%></li>
                        <li id="Monitorlefttree"style=" font-size:13px;cursor:pointer;display:none"><%--监控--%></li>
                    </ul>
                </div>
                <div class="zTreeDemoBackground left">
                    <ul id="treeDemo" class="ztree" style="width:175px;height:405px;overflow:auto; margin-top:3px; "></ul>
                    <ul id="treeDemo2" class="ztree" style="width:175px;height:405px;overflow:auto; margin-top:3px;display:none;"></ul>
                </div>
            </div>
            <div style="float: right; width: 22px; height: 445px; background-image: url(TreeLineImages/tree_bg3.png)">
                <img class="img1" style="position: relative; top: 210px;" src="TreeLineImages/out_un.png" alt="Alternate Text" />
            </div>
        </div>
                <div id="mouseMenu" runat="server">
            <div id="policemouseMenu" style="z-index: 56">
                <ul>
                    <li id="Lang_selecteduser" runat="server" style="display: none"><%--选中用户SelectUser--%></li>
                    <li id="Lang_dispatchopr" runat="server"></li>

                    <li id="Lang_smsopr" runat="server">
                        <%--短信功能--%>
            
                    </li>
                    <li id="Lang_ApplicationService" runat="server">
                        <%--应用业务--%>
            
                    </li>
                </ul>
            </div>
            <div id="policemouseMenu_invalide" runat="server" style="z-index: 60">
                <ul id="Ul2" runat="server">
                    <li id="Lang_ApplicationService_invalide" runat="server">
                        <%--应用业务--%>
                        
                    </li>                                        
                </ul>
            </div>
            <div id="groupmouseMenu" runat="server" style="z-index: 56">
                <ul id="Ul1" runat="server">
                    <li id="Lang_smallGroupCall" runat="server"><%--小组呼叫--%></li>
                    <li id="Lang_groupgroupsms" runat="server"><%--小组短信--%></li>
                    <li id="Lang_groupstatussms" runat="server"><%--状态消息--%></li>
                    <li id="Lang_volumeControl" runat="server"><%--音量控制--%></li>
                </ul>
            </div>
            <div id="dispatchmouseMenu" runat="server" style="z-index: 56">
                <ul>
                    <li id="Lang_dispatchsinglecall" runat="server"><%--单呼--%></li>
                    <li id="Lang_dispatchsms" runat="server"><%--短信--%></li>
                    <li id="Lang_dispatchstatussms" runat="server" style="display: none"><%--状态消息--%></li>
                </ul>
            </div>
            <div id="carDutyMenu" runat="server" style="z-index: 60">
               <ul>
                    <li id="LiCarSingleCall" runat="server"></li>
                    <li id="LiCarSMS" runat="server"></li>
                    <li id="LiCarLocate" runat="server"></li>
                </ul>
            </div>
        </div>
        <%--呼叫消息--%>
        <%   if (int.Parse(Request.Cookies["usertype"].Value) == 1) {%>
        <div id="MSN"style="width:330PX; left:50%;margin-left:-160PX;"><ul><li style="text-align:center;width:100%" id="scrollarea" ></li></ul></div>
        <%} %>
        <%--摄像头搜索--%>
        <div id="cameralistsdiv" style="position: absolute; width: 420px; height: 550px; margin-left: 204px; margin-top: 43px; border: solid; border-color: gray; border-width: 1px; display: none; z-index: 20">
            <iframe id="cameralists" style="width: 420px; height: 550px;background-color:#fff;border:1px solid #000" src="lqnew/opePages/cameralists.aspx"></iframe>
        </div>
        <div id="policelistsdiv" style="position: absolute; background-color: white; width: 330px; height: 550px; margin-left: 204px; margin-top: 43px; border: solid; border-color: #054164; border-width: 3px; display: none; z-index: 20;padding:2px;">
            <iframe id="policelists" style="width: 330px; height: 550px; border:0px;" src="lqnew/opePages/policelists.aspx'"></iframe>
        </div>
        <%--地图右键菜单关注列表------------------------xzj--2018/4/9----------------------------%>
        <div class="opendivwindow" id="concernlist" style="position: absolute; width: 550px; height: 550px; left: 400px; top: 100px; display: none; z-index: 20">
        <iframe name="concernlist_ifr" id="concernlist_ifr"  width="100%" allowtransparency="true"
                scrolling="no" style="padding-bottom: 0px; height:460px" frameborder="0" src="" ></iframe>
        </div>
        <div id="contextmenu_container" class="contextmenu">
           <%-- <ul>
                <li class="sub_li_1"><a href="#GIS">调度业务</a>
                    <ul class="sub_menu_1">
                        <li><a href="#GIS">单呼</a></li>
                        <li><a href="#GIS">单呼</a></li>
                        <li><a href="#GIS">单呼</a></li>
                        <li><a href="#GIS">单呼</a></li>
                        <li><a href="#GIS">单呼</a></li>
                        <li><a href="#GIS">单呼</a></li>
                    </ul>
                </li>
                <li class="sub_li_1"><a href="#GIS">短信业务</a>
                    <ul class="sub_menu_1">
                        <li><a href="#GIS">单呼</a></li>
                        <li><a href="#GIS">单呼</a></li>
                        <li><a href="#GIS">单呼</a></li>
                    </ul>
                </li>
                <li class="sub_li_1"><a href="#GIS">应用业务</a>
                    <ul class="sub_menu_1">
                        <li><a href="#GIS">单呼</a></li>
                        <li><a href="#GIS">单呼</a></li>
                        <li><a href="#GIS">单呼</a></li>
                        <li><a href="#GIS">单呼</a></li>
                        <li><a href="#GIS">单呼</a></li>
                        <li><a href="#GIS">单呼</a></li>
                    </ul>
                </li>
            </ul>--%>
        </div>
         <!------------xzj--2018/7/10------------------添加style，隐藏div-->
        <div id="contextmenu_container2" class="normal_menu" style="display:none">
            <ul>
                 <%--添加onclick事件------------------------xzj--2018/4/9----------------------------%>
                 <li><a id="concernlists"  href="#" onclick="openconcernlist()"><%--关注列表--%></a></li>
                 <li><a id="searchPolice" href="#" onclick="searchPoliceByMapRightMenu()"><%--查找警员--%></a></li>
                 <li><a id="GroupCallA" href="#" onclick="displayCallPane()"><%--组呼--%></a></li>
                 <li><a id="fabuchaxunbukong" href="#" onclick="displayCXBK()"><%--发布查询布控--%></a></li>
                 <li><a id="Lang_DTCZ" href="#" onclick="displayDTCZ()"><%--动态重组--%></a></li>
                 <li><a id="Lang_searchlockuser" href="#" onclick="displayLockUser()"><%--搜索锁定警员--%></a></li>
                 <li><a id="RealTimeTraceList" href="#" onclick="displayRealTimeTraceList()"><%--实时轨迹列表--%></a></li>
                 <li><a id="showFSMap" href="#" onclick="showFSHeatMap()"><%--查看场强热力图--%></a></li>
            </ul>
        </div>
        <div id="Callbottomimg" style="margin-left:100px; width:5px;height:5px; z-index: 10; position: fixed;left:50%;_position: absolute; bottom:0px; display: none;background-image:url(Images/PPT_up.png);background-size:cover;background-repeat: no-repeat">
            <img style=" margin-top:15px;display: none;margin-left:2px;" src="Images/1.gif" alt="Alternate Text" />
        </div>
         <div id="contextmenu_container3" class="call_menu" style="margin-left:-75px; width:120px;height:auto; z-index: 130; position: fixed;left:50%;_position: absolute; bottom:100px; display: none;">
        </div>
        <div id="contextmenu_container4" class="call_menu" style="margin-left:75px; width:120px;height:auto; z-index: 130; position: fixed;left:50%;_position: absolute; bottom:100px; display: none;">
            <ul>
                <li><a href="#" id="Ssinglecall" onclick="Ssinglecall()" style="display:block;"><%--电话模式--%></a></li>
                <li><a href="#" id="Spptcall" onclick="Spttcall()" style="display:block;"><%--对讲模式--%></a></li>
            </ul>
        </div>
        <div id="CallImg" >

        </div>
        <div id="BoxSelection-type" style="display:none">
            <div id="BoxSelection-type1">
                <img  src="Images/BoxSelection-type1.png" alt="Alternate Text" />
            </div>            
            <div id="BoxSelection-type2">
                <img  src="Images/BoxSelection-type2.png" alt="Alternate Text" />
            </div>
        </div>
        <!--右侧工具栏2018.8.8虞晨超-->
        <div id="rightToolbar" style="width:44px;top:80px; right:2px;position:absolute; z-index:999;display:none">
            <div style="background:url(Images/bg_top.png) 0 0 no-repeat; height:21px; "></div>
            <div id="right_toolbar" style="background:url(Images/bg.png);height:142px;padding-top:2px;">
                <div id="ol-ranging" style=" background:url(Images/ring.png) 0 0 no-repeat ;  margin: auto; margin-top:4px; margin-bottom:2px;  width: 33px; height: 33px;"></div>
                <div id="ol-BoxSelection" style=" background:url(Images/choose.png) 0 0 no-repeat ;  margin: auto;margin-top:2px; margin-bottom:2px; width: 33px; height: 33px;"></div>
                <div id="zoomin" style=" background:url(Images/zoomin.png) 0 0 no-repeat ;  margin: auto;margin-top:2px; margin-bottom:2px; width: 33px; height: 33px;"></div>
                <div id="zoomout" style=" background:url(Images/zoomout.png) 0 0 no-repeat ;  margin: auto;margin-top:2px; margin-bottom:4px; width: 33px; height: 33px;"></div>
            </div>
            <div style="background:url(Images/bg_down.png) 0 0 no-repeat; height:4px;"></div>
            
        </div>
        <div id="weixinpingmian" style="background:url(Images/satelitteanpm1.png) 0 0 no-repeat; height:25px; width:120px;background-size:120px 25px;position:absolute; z-index:999; right:70px;top:80px;color:#fff;display:none">
            <div id="pingmian" style="margin:3px 5px 3px 25px; float:left;cursor:pointer">平面</div>
            <div id="weixin" style="margin:3px 0px 3px 15px; float:left;cursor:pointer">
                卫星
            </div>
            <div id="layershowimg" style="float:right;cursor:pointer; margin:6px 10px 6px 0px; background-image:url(Images/jcxx.png); width:15px; height:14px;">
                
            </div>
        </div>
        <div id="layershow" style="width:181px;height:131px;background:url(Images/layercontrol_bg.png) 0 0 no-repeat; display:none;position:absolute;top:105px;right:55px;z-index:100">
            <ul class="layershow_ul">
                <li>
                    <input type="checkbox" name="" id="Radio0" onclick="layershowCheckBoxClick(event)" checked="checked"/>
                    <label for="" id="lblControlBS">基站</label>
                </li>
                <li id="liControlUnit">
                    <input type="checkbox" name="" id="Radio1" onclick="layershowCheckBoxClick(event)" checked="checked"/>
                    <label for="" id="lblControlUnit">单位</label>
                </li>
                <li>
                    <input type="checkbox" name="" id="Radio2" onclick="layershowCheckBoxClick(event)" checked="checked"/>
                    <label for="" id="lblControlUser">用户</label>
                </li>
                                <li id="cameraManageLi" style="display:none">
                    <input type="checkbox" name="" id="Checkbox1" onclick="layershowCheckBoxClick(event)" />
                    <label for="" id="lblControlCamrea">监控</label>
                </li>
            </ul>
        </div>
        <div id="map" style="height: 100%; border: solid;"></div>
        <div id="mouse-position"></div>
        <div id="popup" class="ol-popup" style="display:none;">
            <a href="#GIS" id="popup-closer" class="ol-popup-closer"></a>
            <div id="popup-content"></div>
        </div>
        <%   if (int.Parse(Request.Cookies["usertype"].Value) == 1) {%>
        <div id="divbootombar">
        </div><%} %>
        <div id="bgDiv" style="display: none; width: 100%; height: 100%">
        </div>
        <div id="mybkdiv" style="display: none; width: 100%; height: 100%">
            <p id="mydivp">
            </p>
        </div>
       <%   if (int.Parse(Request.Cookies["usertype"].Value) == 1) {%>
        <div id="NoCall" style="z-index: 120; position: fixed;left:50%;margin-left: -170px;_position: absolute; bottom:0px; display: block;width: 340px; height: 100px; background-color:white;opacity:0"></div>
        <div id="NewCall" style="z-index: 1; position: fixed;left:0; bottom:0px; display: block;">
            <div id="newBanner" style="z-index: 10; position: fixed;_position: absolute;left:50%;margin-left: -170px; bottom:0px; width: 340px; height: 35px; display: block;background-image:url(Images/newbanner_bg_disabled.png);background-repeat:no-repeat">
            </div>
            <div id="toprightIcon1" style="z-index:12; position:fixed; float:left;left:50%;bottom:72px;margin-left:-45px;width:10px;height:10px;display:block;background-image:url(Images/toprightIcon_disabled.png);background-repeat:no-repeat"></div>
            <div id="TeamCall" style="z-index: 11; position: fixed;_position: absolute; float:left;left:50%;bottom:25px; margin-left: -91px; width: 62px; height: 63px; display: block; background-image:url(Images/groupcall_disabled.png);background-repeat: no-repeat"></div>
            
            <div id="Calling" style="z-index: 11; position:fixed;_position: absolute;float:left;left:50%;bottom:25px; margin-left: 29px;width: 62px; height: 63px; display: block; background-image:url(Images/callbackground_disabled.png);background-repeat: no-repeat">
                <div id="toprightIcon2" style="z-index:12; position:fixed; float:right;right:50%;bottom:72px;margin-right:-85px;width:10px;height:10px;display:block;background-image:url(Images/toprightIcon_disabled.png);background-repeat:no-repeat"></div>
                <div id="phoneIcon" style="z-index:12; position:fixed; float:right;right:50%;bottom:37px;margin-right:-77px;width:35px;height:30px;display:block;background-image:url(Images/Phone.png);background-repeat:no-repeat"></div>
                <div id="recivecallIcon" style="z-index:12; position:fixed; float:right;right:50%;bottom:59px;margin-right:-82px;width:45px;height:22px;display:block;background-image:url(Images/recivecall.png);background-repeat:no-repeat"></div>
            </div>
        </div>
        <%} %>
    </form>
             <form target="select_user_ifr" method="post" id="Form2" action="lqnew/opePages/select_user.aspx">
        <input type="hidden" id="Hidden1" name="hidsid" value="" />
        <input type="hidden" id="Hidden2" name="hidisHideOfflineUser" value="" />
               <input type="hidden" id="Hidden3" name="device_timeout" value="" />
    </form>

    <form target="SendGPSEnableOrDisable_ifr" method="post" id="SendGPSEnableOrDisableFrom" action="lqnew/opePages/SendGPSEnableOrDisable.aspx">
        <input type="hidden" id="sendgpshidsids" name="sendgpshidsids" value="" />
    </form>
    <form target="Send_SMS_ifr" method="post" id="Send_SMSFrom" action="lqnew/opePages/Send_SMS.aspx?cmd=SEND">
        <input type="hidden" id="sid" name="sid" value="" />
    </form>
    <form target="SendGPSContral_ifr" method="post" id="SendGPSContralFrom" action="lqnew/opePages/SendGPSContral.aspx">
        <input type="hidden" id="sendgpscontralhidsids" name="sendgpscontralhidsids" value="" />
    </form>
        <form target="circleLocation_ifr" method="post" id="SendGPSPullContralFrom" action="lqnew/opePages/circleLocation.aspx">
        <input type="hidden" id="sendgpspullcontralhidsids" name="sendgpspullcontralhidsids" value="" />
    </form>
        <form target="SendDTCZ_ifr" method="post" id="SendDTCZFrom" action="lqnew/opePages/SendDTCZ.aspx">
        <input type="hidden" id="senddtczhidsids" name="senddtczhidsids" value="" />
    </form>
        <div id="regDiv"></div>

        <%-- 声音播放--%>
        <object id="mhplayer" style="display: none" classid='CLSID:6BF52A52-394A-11d3-B153-00C04F79FAA6' width="0"
            height="0" type="application/x-oleobject">
            <param name='AutoStart' value='false' />
            <param name='Enabled' value='true' />
            <param name="volume" value="5000" />
        </object>

           <form target="select_user_ifr" method="post" id="submit_selectUser" action="lqnew/opePages/select_user.aspx">
        <input type="hidden" id="hidsid" name="hidsid" value="" />
        <input type="hidden" id="hidisHideOfflineUser" name="hidisHideOfflineUser" value="" />
               <input type="hidden" id="device_timeout" name="device_timeout" value="" />
    </form>
    <script type="text/javascript">

        get_usepramater(); //获取用户初始化配置参数
        var calltype = 3;//0全双工，1半双工，2组呼，3无
        //添加鼠标按下隐藏右键菜单事件--------------------------------xzj--2018/4/19-----------------------------------------//陈孝银修改20180627

        $(function () {
            document.onmouseup = function () {
                $("#contextmenu_container")[0].parentNode.style.display = "none";
                $("#contextmenu_container3")[0].style.display = "none";
                $("#contextmenu_container4")[0].style.display = "none";
                $("#carDutyMenu")[0].style.display = "none";//点击地图隐藏单件报备的菜单--xzj--2018/8/4
                $("#CallImg")[0].style.display = "none";
            }
            document.onkeydown = function () {//空格开始ppt
                if (window.useprameters.keyiIsUP == true && event.keyCode == 32) {
                    window.useprameters.keyiIsUP = false;
                    callBottomDownAnimate();
                    pttD(); //调用PTT
                }
                if (event.keyCode >= 96 && event.keyCode <= 105) {//陈孝银--20180706---快捷键组呼开始
                    window.useprameters.keyiIsUP = false;
                    window.onKeyDownGroupCall(event.keyCode - 96);
                }
                //设置动多选状态-------zhangq--2018/07/05
                if (window.useprameters.multiSel == false && event.keyCode == 17) {
                    window.useprameters.multiSel = true;
                }
            }
            document.onkeyup = function () {//空间释放ppt
                if (window.useprameters.keyiIsUP == false && event.keyCode == 32) {
                    window.useprameters.keyiIsUP = true;
                    callBottomUpAnimate();
                    pttU(); //释放PTT
                }
                if (event.keyCode >= 96 && event.keyCode <= 105) {//陈孝银--20180706---快捷键组呼释放
                    window.useprameters.keyiIsUP = true;
                    window.gceasedPTT();//释放组呼授权
                }
                //设置动多选状态-------zhangq--2018/07/05
                if (window.useprameters.multiSel == true && event.keyCode == 17) {
                    window.useprameters.multiSel = false;
                }
            }

            //监听scrollarea文字变化，当呼叫挂断时，判读哪一步被挂断，并执行动画效果
            $("#scrollarea").bind("DOMSubtreeModified", function (e) {
                var scrollareaTxt = $("#scrollarea").text();
                if (scrollareaTxt.indexOf(GetTextByName("CC_RELEASE", useprameters.languagedata)) > 0) {//呼叫挂断
                    if (calltype == 1 || calltype == 2) {
                        callBottomStopAnimate();
                    }
                    if (calltype == 0 || calltype == 1) {
                        singleCallStopAnimate();
                    }
                    calltype = 3;
                }
                if (scrollareaTxt.indexOf(GetTextByName("CC_CEASED", useprameters.languagedata)) > 0) {//发射权已释放
                    if (calltype == 0) {
                        callBottomStartAnimate();//开启图片动画
                        calltype = 1;
                    }
                }
            });

            $("#TeamCall").click(function () {
                if (calltype == 3) {
                    $("#contextmenu_container3").css("display", "block");

                } else {
                    stopScall();//停止组呼
                }
            });
            $("#Calling").click(function () {
                if (calltype == 3) {
                    $("#contextmenu_container4").css("display", "block");
                } else {
                    stopScall();//停止单呼
                }
            });
            $("#Callbottomimg").mousedown(function () {
                callBottomDownAnimate();
                pttD(); //调用PTT
            });
            $("#Callbottomimg").mouseup(function () {
                callBottomUpAnimate();
                pttU() //释放PTT
            });

            initGroupArray();//初始化组呼列表
        });



        function callBottomDownAnimate() {
            $("#Callbottomimg").css("background-image", "url(Images/PPT.png)");
            $("#Callbottomimg img").css("display", "block");

        }

        function callBottomUpAnimate() {
            $("#Callbottomimg").css("background-image", "url(Images/PPT_up.png)");
            $("#Callbottomimg img").css("display", "none");

        }

        //添加呼叫栏功能------------------cxy--20180626------------------------
        function createMenu(array) { //创建右键菜单
            if (!array) { return null; }
            var callulContainer = document.getElementById("callrightUl") || document.createElement("ul");
            for (var menu in array) {
                if (typeof (array[menu]) != "function") {
                    var liContainer = document.createElement("li");
                    var aContainer = document.createElement("a");
                    aContainer.innerHTML = array[menu][2];
                    aContainer.title = array[menu][1];
                    aContainer.name = array[menu][2];
                    aContainer.fun = array[menu][0];
                    aContainer.href = "#";
                    aContainer.style.display = "block";
                    liContainer.appendChild(aContainer);
                    aContainer.onmouseup = function () {
                        this.fun(this.title, this.name);
                    }
                    callulContainer.appendChild(liContainer);

                }
            }
            return callulContainer;
        }


        function creatGroupMenu(obj) { //创建编组窗口
            var array = new Array();

            for (var group in obj) {
                var temp1 = {};
                temp1[0] = function (title, name) {//组呼菜单事件
                    callBottomStartAnimate();
                    teamCallStartAnimate();
                    window.setGroupCallGSSI(title);
                    window.startGC();
                    calltype = 2;
                    //alert(title + "-" + name);
                };
                if (obj[group].GSSI != undefined) {                //fun
                    temp1[1] = obj[group].GSSI; //arg
                    temp1[2] = obj[group].groupname; //name
                    array.push(temp1);
                }
            }

            var removemenu = document.getElementById("callrightUl");
            if (removemenu) {
                window.removeChildSafe(removemenu);
            }
            var obj = createMenu(array);
            var bzmenu = document.getElementById("contextmenu_container3");
            bzmenu.style.left = (parseFloat(window.document.body.offsetWidth) - parseFloat(document.offsetWidth)) / 2 + 140;
            bzmenu.appendChild(obj);
        }

        function initGroupArray() {//获取全组GSSI列表
            jquerygetNewData_ajax("../WebGis/Service/GetGrouparraybyentiyID.aspx", null, function (request) {
                var _data = request;
                window.useprameters.Grouparray = request;
                creatGroupMenu(request); //生成编组列表
            }, false, false);
        }

        //ppt按住
        function pttD() {
            if (calltype == 1) {//callfinish
                window.startSC();
                return;
            } //企图获取单呼授权
            if (window.useprameters.SelectGSSI != "") {
                window.startGC();
                return;
            } //企图获取组呼授权
            alert(window.GetTextByName("PTTUnuseable", window.useprameters.languagedata));//PTTUnuseable PPT不可用
        }

        //ppt松开
        function pttU() {
            if (calltype == 1) {//callfinish
                window.sceasedPTT();//释放单呼授权
                return;
            }
            window.gceasedPTT();//释放组呼授权
            return;
        }

        function singleCallStartAnimate() {//单呼开始动画
            $("#recivecallIcon").addClass("rotate");
            $("#recivecallIcon").animate({ bottom: "47px" });
            $("#phoneIcon").animate({ bottom: "-20px", opacity: 1 }, 1000, function () {
                if ($("#recivecallIcon").hasClass("rotate")) {
                    $(this).css({ display: "none" });
                }
            });
            $("#toprightIcon2").css({ display: "none" });
        }

        function singleCallStopAnimate() {//单呼停止动画
            $("#phoneIcon").css({ display: "block" });
            $("#phoneIcon").animate({ bottom: "37px" });
            $("#recivecallIcon").removeClass("rotate");
            $("#recivecallIcon").animate({ bottom: "59px" });
            $("#toprightIcon2").css({ display: "block" });
        }

        function teamCallStartAnimate() {//组呼开始动画
            $("#toprightIcon1").css({ display: "none" });
            /*后续...*/
        }

        function teamCallStopAnimate() {//组呼停止动画
            $("#toprightIcon1").css({ display: "block" });
            /*后续...*/
        }

        function callBottomStartAnimate() {
            $("#Callbottomimg").css({ display: "block" });
            $("#Callbottomimg").animate({ width: "135px", height: "105px", bottom: "10px", marginLeft: "200px" });
        }

        function callBottomStopAnimate() {
            $("#Callbottomimg").animate({ width: "5px", height: "5px", bottom: "0px", marginLeft: "100px" }, 1000, function () {
                $("#Callbottomimg").css({ display: "none" });
            });
        }

        function Ssinglecall()//开始全双工单呼
        {
            if (window.useprameters.eTramsg == window.GetTextByName("LINK_DISCONNECT", window.useprameters.languagedata) || window.useprameters.callActivexable == false) {//链路断开
                alert(window.GetTextByName("Callcontrolisnotavailable", window.useprameters.languagedata));//呼叫控件不可用
                window.writeLog("oper", "[" + window.GetTextByName("SingleCALL(all)", window.useprameters.languagedata) + "]:" + window.GetTextByName("Callcontrolisnotavailable", window.useprameters.languagedata) + "[" + window.LOGTimeGet() + "]");         /**日志：操作日志 **/
                //单呼(全);呼叫控件不可用
                return;
            }

            if (window.useprameters.Selectid.length < 1) {//请选中一个用户
                alert(window.GetTextByName("ToSelectUser", window.useprameters.languagedata));
                window.writeLog("oper", "[" + window.GetTextByName("SingleCALL(all)", window.useprameters.languagedata) + "]:" + window.GetTextByName("ToSelectUser", window.useprameters.languagedata) + "[" + window.LOGTimeGet() + "]");         /**日志：操作日志 **/
                return;
            }

            //操作窗口已发起呼叫 
            if (window.callPanalISSI != "" || window.ppcCallingIssi != "") {
                alert(window.GetTextByName("HasCallingPleaseWaiting", window.useprameters.languagedata));//
                window.writeLog("oper", "[" + window.GetTextByName("SingleCALL(all)", window.useprameters.languagedata) + "]:" + window.GetTextByName("HasCallingPleaseWaiting", window.useprameters.languagedata) + "[" + window.LOGTimeGet() + "]");         /**日志：操作日志 **/
                return;
            }

            if (window.document.frames["PrivateCall"] != null || window.document.frames["PrivateCall"] != undefined) {
                window.mycallfunction('PrivateCall', 380, 280);
            }

            singleCallStartAnimate();//开启按钮动画
            calltype = 0;
            window.startDC();
        }

        function Spttcall() {//开始半双工单呼
            //操作窗口已发起呼叫 
            if (window.callPanalISSI != "" || window.ppcCallingIssi != "") {
                alert(window.GetTextByName("HasCallingPleaseWaiting", window.useprameters.languagedata));//已发起一个呼叫，请结束后再发起
                window.writeLog("oper", "[" + window.GetTextByName("SingleCALL(half)", window.useprameters.languagedata) + "]:" + window.GetTextByName("HasCallingPleaseWaiting", window.parent.useprameters.languagedata) + "[" + window.parent.LOGTimeGet() + "]");         /**日志：操作日志 **/
                //SingleCALL(half)[单呼(半)]
                return;
            }

            if (window.useprameters.Selectid.length < 1) {//请选中一个用户
                alert(window.GetTextByName("ToSelectUser", window.useprameters.languagedata));
                window.writeLog("oper", "[" + window.GetTextByName("SingleCALL(half)", window.useprameters.languagedata) + "]:" + window.GetTextByName("ToSelectUser", window.useprameters.languagedata) + "[" + window.LOGTimeGet() + "]");         /**日志：操作日志 **/
                return;
            }

            if (window.document.frames["PrivateCall"] != null || window.document.frames["PrivateCall"] != undefined) {
                window.mycallfunction('PrivateCall', 380, 280);
            }
            callBottomStartAnimate();//开启图片动画
            singleCallStartAnimate();//开启按钮动画
            calltype = 1;
            window.startSC();
        }

        function stopScall() {

            switch (calltype) {
                case 0:
                    window.endDC(); //调用全双工单呼结束
                    singleCallStopAnimate();
                    break;
                case 1:
                    window.endSC(); //调用半双工单呼结束
                    singleCallStopAnimate();
                    callBottomStopAnimate();
                    break;
                case 2:
                    window.endGC();//调用组呼结束
                    removeGroupCallGSSI();//移除标签
                    callBottomStopAnimate();
                    teamCallStopAnimate();
            }
            calltype = 3;
            return;
        }

        var initWaterRipple = function () {
            //水纹效果设置
            var settings = {
                image: 'Images/newbanner_bg.png',//背景图片
                rippleRadius: 1,//水纹半径
                width: 360,//宽
                height: 36,//高
                delay: 1,//延迟效果，1表示1秒
                auto: false//是否自动泛起水纹

            };

            //初始化
            $('#newBanner').waterRippleEffect(settings);

            //鼠标点击
            $('#newBanner').click(function (e) {

                var mouseX = e.pageX - $(this).offset().left;
                var mouseY = e.pageY - $(this).offset().top;

                $('#newBanner').waterRippleEffect("disturb", mouseX, mouseY);

            });

            //鼠标移动
            $('#newBanner').mousemove(function (e) {

                var mouseX = e.pageX - $(this).offset().left;
                var mouseY = e.pageY - $(this).offset().top;

                $('#newBanner').waterRippleEffect("disturb", mouseX, mouseY);

            });


        };

        function CallbannerEnable() {
            var nocallDiv = document.getElementById("NoCall");
            if (nocallDiv) {
                if (nocallDiv.style.display == "none") {
                    return;
                }
                nocallDiv.style.display = "none";
                showEnabledCallPanleImg();//显示可用的图标
                initWaterRipple();//加载水纹效果
            }
        }

        //控价加载成功，显示所有可用图标
        function showEnabledCallPanleImg() {
            $("#newBanner").css("background-image", "url(Images/newbanner_bg.png)");
            $("#TeamCall").css("background-image", "url(Images/groupcall.png)");
            $("#Calling").css("background-image", "url(Images/callbackground.png)");
            $("#toprightIcon1").css("background-image", "url(Images/toprightIcon.png)");
            $("#toprightIcon2").css("background-image", "url(Images/toprightIcon.png)");
        }
        //***************************END**********************

       
        window.isLoadMain = "main";

        document.getElementById("LiCarSingleCall").onclick = function () {
            if (useprameters.callActivexable == false) {
                alert(GetTextByName("checkcallcontrolregister", useprameters.languagedata));//checkcallcontrolregister
                document.getElementById("carDutyMenu").style.display = "none";
                return;
            };
            mycallfunction('PrivateCall', 380, 500, '&type=ISSI&myid=' + car_duty_issi_selected, 1999);
            document.getElementById("mouseMenu").style.display = "none";
        }
        document.getElementById("LiCarSMS").onclick = function () {
            if (useprameters.callActivexable == false) {
                alert(GetTextByName("checkcallcontrolregister", useprameters.languagedata));//checkcallcontrolregister
                document.getElementById("carDutyMenu").style.display = "none";
                return;
            };
            mycallfunction('Send_SMS', 380, 400, car_duty_uid_selected, 1999);
            document.getElementById("mouseMenu").style.display = "none";
        }
        document.getElementById("LiCarLocate").onclick = function () {
            locationbyUseid(car_duty_uid_selected);
            document.getElementById("mouseMenu").style.display = "none";
            //定位
        }
        //2018-8-13yuchenchao 右侧工具栏
        $("#pingmian").click(function () {
            $("#weixinpingmian").css("background-image", "url(Images/satelitteanpm1.png)");//xzj--2018110--去除.png后面的/
            getLayerById(map, "satelliteLayer").setVisible(false);
            getLayerById(map, "offlineMapLayer").setVisible(true);
        })
        $("#weixin").click(function () {
            $("#weixinpingmian").css("background-image", "url(Images/satelitteanpm2.png)");//xzj--2018110--去除.png后面的/
            getLayerById(map, "satelliteLayer").setVisible(true);
            getLayerById(map, "offlineMapLayer").setVisible(false);
        })
        $("#layershowimg").click(function () {
            $("#layershow").toggle();
        })


        $("#Userlefttree").click(function () {
            $("#treeDemo").css("display", "block")
            $("#treeDemo2").css("display", "none")
            $("#Userlefttree").css("font-size", "12px")
            $("#Monitorlefttree").css("font-size", "13px")
        })
        $("#Monitorlefttree").click(function () {
            $("#treeDemo").css("display", "none")
            $("#treeDemo2").css("display", "block")
            $("#Monitorlefttree").css("font-size", "12px")
            $("#Userlefttree").css("font-size", "13px")
        })
    </script>

</body>
</html>
