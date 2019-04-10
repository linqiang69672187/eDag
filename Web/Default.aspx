<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Web.Default" EnableViewState="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta http-equiv="Cache-Control" content="no-cache,no-store, must-revalidate" />
    <meta http-equiv="pragma" content="no-cache" />
    <meta http-equiv="expires" content="0" />
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
        html, body {
            height: 100%;
            overflow: hidden;
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

        #policemouseMenu, #groupmouseMenu, #dispatchmouseMenu {
            position: absolute;
            top: -9999px;
            left: -9999px;
            z-index: 22;
        }

            #policemouseMenu ul, #groupmouseMenu ul, #dispatchmouseMenu ul {
                float: left;
                border: 1px solid #979797;
                background: #f1f1f1 url(Images/line.png) 24px 0 repeat-y;
                padding: 2px;
                box-shadow: 2px 2px 2px rgba(0,0,0,.6);
            }

                #policemouseMenu ul li, #groupmouseMenu ul li, #dispatchmouseMenu ul li {
                    float: left;
                    clear: both;
                    height: 24px;
                    cursor: pointer;
                    line-height: 24px;
                    white-space: nowrap;
                    padding: 0 30px;
                }

                    #policemouseMenu ul li.sub, #groupmouseMenu ul li.sub, #dispatchmouseMenu ul li.sub {
                        background-repeat: no-repeat;
                        background-position: right 9px;
                        background-image: url(Images/arrow.png);
                    }

                    #policemouseMenu ul li.active, #groupmouseMenu ul li.active, #dispatchmouseMenu ul li.active {
                        background-color: #f1f3f6;
                        border-radius: 3px;
                        border: 1px solid #aecff7;
                        height: 22px;
                        line-height: 22px;
                        background-position: right -8px;
                        padding: 0 29px;
                    }

                #policemouseMenu ul ul, #groupmouseMenu ul ul, #dispatchmouseMenu ul ul {
                    display: none;
                    position: absolute;
                }
                  #MSN
        {
            position: absolute;
            z-index: 99;
            width: 320px;
            height: 20px;
            bottom:5px;
            left: 40px;
            font-size: 12px;
            color: White;
            background-color:black;
        }

            #MSN ul
            {
                margin-top: 5px;
                text-align: center;
                list-style: none;
            }

        #scrollarea
        {
            margin-left: 5px;
            width: 320px;
            text-align: left;
        }
    </style>
    <link href="CSS/Default.css" rel="stylesheet" type="text/css" />
    <link href="CSS/lq_style.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="css/smartMenu.css" type="text/css" />
    <script src="lqnew/js/StringPrototypeFunction.js" type="text/javascript"></script>
    <link rel="stylesheet" type="text/css" href="pro_dropdown_2/pro_dropdown_2.css" />
    <script src="lqnew/js/GlobalVar.js" type="text/javascript"></script>
    <script src="MyCommonJS/addAll.js" type="text/javascript"></script>
    <script src="WebGis/js/AddAll.js" type="text/javascript"></script>
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
    <script type="text/javascript">
        var randno = 1000;
        function getInitLoLa() {
            var map = _StaticObj.objGet("map");
            return { initLo: map.data.initCenter.lo, initLa: map.data.initCenter.la }
        }

        if (document.attachEvent) {
            window.attachEvent("onload", onload_default);
        }
        if (document.addEventListener) {
            window.addEventListener("load", onload_default, false);
        }
        // han depei add: get must display ID in mohu  
        function get_must_display_user() {  //获取在模糊显示算法中必须显示的警员ID或者ＩＳＳＩ
            var must_display = new Array();
            must_display[0] = new Array();
            must_display[1] = new Array();
            must_display[0].push(useprameters.lockid);
            must_display[0].push(useprameters.id);
            for (var i = 0; i < useprameters.Selectid.length; i++) {
                must_display[0].push(useprameters.Selectid[i]);
            }

            for (var i = 0; i < useprameters.nowtrace.length; i++) {
                must_display[0].push(useprameters.nowtrace[i].item.split('|')[0]);
            }
            for (var i = 0; i < useprameters.SelectISSI.length; i++) {
                must_display[1].push(useprameters.SelectISSI[i]);
            }

            return must_display;
        }
        //----------------------------------------------------
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
        function onload_default() {
           
            //setTimeout(function () {
            //setInterval(function () {
            //    CallMsg(24001, 10, "获取授权", 10011700, 1);

            //}, 2)
            //}, 27020);
            //setTimeout(function () {
            //    setInterval(function () {
            //        CallMsg(24001, 10, "发射权已释放", 10011700, 1);
            //    }, 2)
            //}, 25000);

            // alert(getCookieByName('hostip'));
            //            var activex = document.getElementById("EasctcomActiveX");
            //            try {
            //                activex.test();
            //            }
            //            catch (e) {
            //                alert("请安装按钮控件");
            //            }           
                        
            //庞小斌修改，登陆时加载警员
            setTimeout("LayerControl.refurbish()", 2000);

            document.onselectstart = function (event) { return false; };
            var map = new ZheJiangMap();
            map.data.mapDiv = document.getElementById("map");
            map.data.currentLevel = 7;

            map.data.maxLevel = 10;
            map.data.minLevel = 1;
            map.init();
            var multi_Ranging = new Multi_Ranging(_StaticObj.objGet("map")); //添加测距
            //导航栏
            var nav = new Navigator(map);
            nav.addToMap();
            //鹰眼
            var hawkeye = new Hawkeye(map);
            hawkeye.data.level = 4;
            hawkeye.data.id = "hawkeye";
            hawkeye.addToMap();
            //图层
            LayerControl = new LayerManager(map);
            //添加单击事件
            var zoomInTool = new ZoomInTool(_StaticObj.objGet("map"));
            var zoomOutTool = new ZoomOutTool(_StaticObj.objGet("map"));
            var choose = new Choose(map, LayerControl, { strokecolor: "red", opacity: "0.5" });
            choose.turnOn("single");

            choose.addEventListener("cell_onclick", function (ci, layerID, obj) {
                var ifrs = ifr_callcontent;
                if ($(document.getElementById('ifr_callcontent_ifr').contentWindow.document.getElementById('call2')).css("backgroundImage").indexOf(GetTextByName("maincall_btn_img_name_callfinish", useprameters.languagedata)) > 0 || $(document.getElementById('ifr_callcontent_ifr').contentWindow.document.getElementById('call2')).css("backgroundImage").indexOf(GetTextByName("maincall_btn_img_name_receivecall", useprameters.languagedata)) > 0) {//callfinish;receivecall
                    alert(GetTextByName("PleaseEndCalling", useprameters.languagedata));//多语言:请结束当前呼叫操作
                    return;
                }
                var layercell = LayerControl.CellGet(layerID, ci);
                if (event.ctrlKey) {
                    if (isinarray(layercell.ID, useprameters.Selectid)) {
                        useprameters.SelectISSI.splice(indeofarray(layercell.ISSI, useprameters.SelectISSI), 1);
                        useprameters.Selectid.splice(indeofarray(ci, useprameters.Selectid), 1);
                        $("#bztp_select_" + ci).remove();
                        writeLog("oper", "[" + GetTextByName("UnSelected", useprameters.languagedata) + "]:ISSI(" + layercell.ISSI + ")" + GetTextByName("use", useprameters.languagedata) + "ID(" + ci + ")" + "[" + LOGTimeGet() + "]");         /**日志:操作日志 **/
                    }
                    else {
                        useprameters.SelectISSI.push(layercell.ISSI);
                        useprameters.Selectid.push(ci);
                        writeLog("oper", "[" + GetTextByName("UnSelected", useprameters.languagedata) + "]:ISSI(" + layercell.ISSI + ")" + GetTextByName("use", useprameters.languagedata) + "ID(" + ci + ")" + "[" + LOGTimeGet() + "]");         /**日志:操作日志 **/
                    }
                }
                else {
                    changebackimg("call2", GetTextByName("maincall_btn_img_src_siglecall", useprameters.languagedata));//siglecall
                    for (var i = 0; i < useprameters.SelectISSI.length; i++) {
                        // writeLog("oper", "[" + GetTextByName("UnSelected", useprameters.languagedata) + "]:ISSI(" + useprameters.SelectISSI[i] + ")" + GetTextByName("use", useprameters.languagedata) + "ID(" + useprameters.Selectid[i] + ")" + "[" + LOGTimeGet() + "]");         /**日志:操作日志 **/
                    }
                    useprameters.SelectISSI = []; //清空选中ISSI
                    useprameters.Selectid = []; //清空选中警员

                    $("li[id ^= bztp_select_]").remove(); //移除选中
                    useprameters.HidedisplayISSI = [];
                    useprameters.Selectid.push(ci);
                    useprameters.SelectISSI.push(layercell.ISSI);
                    writeLog("oper", "[" + GetTextByName("Selected", useprameters.languagedata) + "]:ISSI(" + layercell.ISSI + ")" + GetTextByName("use", useprameters.languagedata) + "ID(" + ci + ")" + "[" + LOGTimeGet() + "]");         /**日志:操作日志 **/
                    var ifrs = document.frames["ifr_callcontent"];
                    ifrs.closebg("click"); //更改呼叫栏的样式
                    ifrs.document.getElementById("scrollarea").innerHTML = GetTextByName("Selected", useprameters.languagedata) + ":" + layercell['Info'];
                    ifrs.innerhtmltoele("singal1", GetTextByName("Def_SelectCallMode", useprameters.languagedata));//多语言:选择呼叫模式
                    ifrs.innerhtmltoele("singal2", layercell.ISSI);
                    ifrs.innerhtmltoele("singal3", layercell['Info'].split("(")[0]);
                    UPcallChgIMG(layercell.ISSI); //判断该警员是否存在上行呼叫请求（组呼、单呼全半双工）
                    GetGSSIbyISSI(useprameters.SelectISSI[0]);
                    writeLog("system", GetTextByName("Selected", useprameters.languagedata) + GetTextByName("Operater", useprameters.languagedata) + ":" + layercell['Info'] + "[" + LOGTimeGet() + "]");//多语言:选中操作
                }
                //庞小斌修改，点击警员时刷新警员数据，生成选中图标
                LayerControl.setIGetData(true, LayerControl);
                _StaticObj.objGet("LayerControl").LoadDataToLayerControl(); //重载警员数据
            });
            choose.addEventListener("cell_oncontextmenu", function (ci, layerID, obj) {
                cellinitRightMenu_data(ci, layerID);
            });
            showLayer();
            get_usepramater(); //获取用户初始化配置参数

            //界面刷新时清除SelectedEntity的Cookie,庞小斌修改
            var lastselectentty = Cookies.get("SelectedEntity");
            if (lastselectentty != null)
            { document.cookie = "SelectedEntity=" + ""; }

            LayerControl.LoadDataToLayerControl();
            //setTiming(5000);
            //lq_opentree(); //打开树形 放到资源文件加载完后在打开
            //openPPCPanl();//打开上行操作窗口
            initkeydown(); //键盘空格响应
            //lqopen_newDrownFrame("log_windows", document.body, "lqnew/logwindow/mian.aspx", 305, 125, false); //打开日志窗口 放到资源文件加载完后
            //lqopen_newDrownFrame("ifr_callcontent", document.body, "lqnew/callwindow/miancall.aspx", 399, 92, false); //打开日志窗口 放到资源文件加载完后
            //            document.getElementById("map").onclick = function () {
            //                delObj("rightMenu"); //移除右键菜单
            //            };

            window.iOnResize = true;
            setTimeout(makeWindowOnresize, 500); //兼容IE7以下浏览器 防止打开页面就执行
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
                        //调度用户才绘制基站和单位
                        if (Cookies.get("usertype") == 1) {
                            DelCreate();
                            ReCreate();
                        }
                        var bzmenu = document.getElementById("bzmenu");
                        if (bzmenu) {
                            bzmenu.style.left = (parseFloat(document.body.offsetWidth) - parseFloat(400)) / 2 + 140;
                        }
                    }
                    //庞小斌修改，根据浏览器大小调整底部呼叫窗口的位置
                    Resizeifr_callcontent();
                }
            }
            map.addEventListener("fillBackPicsToDivMap", function () {
                //庞小斌修改，去掉fadeTo();
                DisplayMap();

                setTimeout(function () { var map = _StaticObj.objGet("map"); map.data.isFirstload = false; map = null; }, 5000);
            });
            map.addEventListener("moveTo", function () {
                if (Cookies.get("usertype") == 1) {
                    //庞小斌修改，拖动地图后加载警员
                    LayerControl.refurbish();
                    //庞小斌修改，拖动到地图时显示当前界面单位和基站、所有电子栅栏
                    ReCreate();
                }

                setTimeout(function () {
                    var map = _StaticObj.objGet("map");
                    if ($("#map div[id^=map]").length < 10) {
                        map.moveTo(map.data.initCenter, null, null, null, null, true);
                        useprameters.IsreloadMapin = true;
                        map.mapDivSizeSet();
                        map.clearBackContainer();
                        map.fillBackPicsToDivMap();
                    }
                }, 1000);
            });


            $("#map").dblclick(function () {
                //庞小斌添加 双击地图放大
                if (!isGetJWD) {
                    if (event.ctrlKey) {
                        //_StaticObj.objGet("ZoomOutTool").switchZoom(true);
                    }
                    else {
                        //_StaticObj.objGet("ZoomInTool").switchZoom(true);
                        //if (_StaticObj.objGet("map").data.currentLevel < 9) {//林强
                        //    zoomToLevel(_StaticObj.objGet("map").currentLevel + 2); //林强
                        //}
                        //else {
                        //    zoomToLevel(10); //林强
                        //}
                    }
                    return;
                }
                var map = _StaticObj.objGet("map");
                var a = map.getLatLngByEvent(event);
                var myla = a.la;
                var mylo = a.lo;
                myla = getnum(parseFloat(myla), 7);
                mylo = getnum(parseFloat(mylo), 7);
                if (document.frames["edit_entity_ifr"] != null || document.frames["edit_entity_ifr"] != undefined) {
                    document.frames["edit_entity_ifr"].document.getElementById("txtLa").value = myla;
                    document.frames["edit_entity_ifr"].document.getElementById("txtLo").value = mylo;
                }
                if (document.frames["add_entity_ifr"] != null || document.frames["add_entity_ifr"] != undefined) {
                    document.frames["add_entity_ifr"].document.getElementById("txtLa").value = myla;
                    document.frames["add_entity_ifr"].document.getElementById("txtLo").value = mylo;
                }
                if (document.frames["add_BaseStation_ifr"] != null || document.frames["add_BaseStation_ifr"] != undefined) {
                    document.frames["add_BaseStation_ifr"].document.getElementById("txtLa").value = myla;
                    document.frames["add_BaseStation_ifr"].document.getElementById("txtLo").value = mylo;
                }
                if (document.frames["edit_BaseStation_ifr"] != null || document.frames["edit_BaseStation_ifr"] != undefined) {
                    document.frames["edit_BaseStation_ifr"].document.getElementById("txtLa").value = myla;
                    document.frames["edit_BaseStation_ifr"].document.getElementById("txtLo").value = mylo;
                }
                if (document.frames["edit_FixedStation_ifr"] != null || document.frames["edit_FixedStation_ifr"] != undefined) {
                    document.frames["edit_FixedStation_ifr"].document.getElementById("txtLa").value = myla;
                    document.frames["edit_FixedStation_ifr"].document.getElementById("txtLo").value = mylo;
                }
                if (document.frames["add_FixedStation_ifr"] != null || document.frames["add_FixedStation_ifr"] != undefined) {
                    document.frames["add_FixedStation_ifr"].document.getElementById("txtLa").value = myla;
                    document.frames["add_FixedStation_ifr"].document.getElementById("txtLo").value = mylo;
                }
                //isGetJWD = false;
            });
            map.addEventListener("zoomToLevel_after", function () {
                isBegStackadeSel = false;
                //调度用户加载警员、基站、单位
                if (Cookies.get("usertype") == 1) {
                    //庞小斌修改，滚动地图后加载警员
                    LayerControl.refurbish();
                    //庞小斌修改，滚动到地图时显示当前界面单位和基站、所有电子栅栏
                    ReCreate();
                }

                haveCallSissi.length = 0;
                var picdiv = document.getElementById("stockadediv");
                if (picdiv) {
                    removeChildSafe(picdiv);
                }
                //定位图片的放大缩小
                try {
                    for (var i = 0; i < dwList.data.length; i++) {
                        createDWHTML(dwList.data[i].lo, dwList.data[i].la, dwList.data[i].type);
                    }
                } catch (Err) {
                    alert(Err);
                }
            });

            setTimeout(GetStockAdeInit, 1000); /**@获取电子栅栏初始值放在调度台关联成功后*/
            setTimeout(GetBaseStation, 1000); /**@获取基站初始值*/
            setTimeout(GetPoliceStation, 1000); /**@获取单位初始值*/

            //setTimeout(function () {
            //    call.text = GetTextByName("CallService", useprameters.languagedata);//呼叫业务
            //    call.data[0].text = GetTextByName("SingleCall", useprameters.languagedata);//单呼

            //}, 10000);

            //自定义右键上下文

            //生成关注页面
            creatconcernlistwindow();
        }

        //地铁图层测试
        function showLayer() {
            LayerControl.Layers = {
                "layers": {
                    "Police,0,0": { "getDataParams": { "isTurnOn": true, "layerType": "Police", "manufactoryId": "0", "site_type": "0" } }
                }
            };
            {
                initLayers();
            }
            LayerControl.addEventListener("OutPutLayerCells_before", function (cellID, layerCell) {
                //removemark('map', 'ul');   /**清空用户图标**/
                layerCell.Send_reason = layerCell.Send_reason.replace(/(^\s*|\s*$)/g, '');
                if (layerCell.Send_reason == "(2)Emergency_condition") {//多语言:紧急呼叫
                    if (LayerControl.map.data.currentLevel > 10) {
                        layerCell.url = basePath + 'lqnew/opePages/UpLoad/tempusertypepic/' + layerCell.type + '/10' + '/2.png?p=' + randno;
                    }
                    else {
                        layerCell.url = basePath + 'lqnew/opePages/UpLoad/tempusertypepic/' + layerCell.type + '/' + LayerControl.map.data.currentLevel + '/2.png?p=' + randno;
                    }
                }//下面 多语言:非法；未注册；直通模式；关机
                else if (layerCell.Send_reason == GetTextByName("Illegal", useprameters.languagedata) || layerCell.Send_reason == GetTextByName("UNLogin", useprameters.languagedata) || layerCell.Send_reason == "(8)DMO_ON" || layerCell.Send_reason == "(1)powered_OFF" || parseInt(layerCell.dbdatediff) > parseInt(useprameters.device_timeout)) {
                    if (LayerControl.map.data.currentLevel > 10) {
                        layerCell.url = basePath + 'lqnew/opePages/UpLoad/tempusertypepic/' + layerCell.type + '/10' + '/3.png?p=' + randno;
                    }
                    else {
                        layerCell.url = basePath + 'lqnew/opePages/UpLoad/tempusertypepic/' + layerCell.type + '/' + LayerControl.map.data.currentLevel + '/3.png?p=' + randno;
                    }
                }
                else//正常
                    if (LayerControl.map.data.currentLevel > 10) {
                        layerCell.url = basePath + 'lqnew/opePages/UpLoad/tempusertypepic/' + layerCell.type + '/10' + '/1.png?p=' + randno;
                    }
                    else {
                        layerCell.url = basePath + 'lqnew/opePages/UpLoad/tempusertypepic/' + layerCell.type + '/' + LayerControl.map.data.currentLevel + '/1.png?p=' + randno;
                    }
            });

            LayerControl.addEventListener("OutPutLayerallCells_after", function (cellID, layerCells) {
                removeChildSafe(document.getElementById("clickInfoDIV"));
                var ispcin = false;
                var map = _StaticObj.objGet("map");
                var clickInfoDIV = document.getElementById("clickInfoDIV"); /**移除点击产生的提示框**/
                if (clickInfoDIV) {
                    var ul = clickInfoDIV.getElementsByTagName("div");
                    var lilength = ul.length;
                    for (var i = 0; i <= lilength; i++) {
                        if (ul[i]) {
                            removeChildSafe(ul[i]);

                        }
                    }
                }
                //                var justpecent = map.data.currentLevel / map.data.maxLevel;

            });

            LayerControl.addEventListener("OutPutallLayerCells_In", function (data) {
                try {
                    var ispcin = false;
                    var datalength = data.length;
                    for (var i = 0; i < datalength; i++) {
                        for (var cell in data[i]) {
                            if (useprameters.lockid == cell) { //判断锁定跟踪ID

                                ispcin = true;
                            }
                        }
                    }
                    if (!ispcin && useprameters.lockid != 0) {//锁定警员不在当前区域
                        movelockpc();
                    }
                }
                catch (e) {
                }
            });

            LayerControl.addEventListener("OutPutLayerCells_after", function (cellID, layerCell) {
                var map = _StaticObj.objGet("map");
                var justpecent = map.data.currentLevel / map.data.maxLevel;
                ImageModel.prototype.InfoShow(layerCell, document.getElementById("clickInfoDIV"), 'hidden'); //复位标题
                if (useprameters.lockid == layerCell.ID) { //判断锁定跟踪ID
                    lockpc(useprameters.lockid, layerCell, justpecent);
                    ispcin = true;
                }
                for (var selectid in useprameters.Selectid) {
                    if (useprameters.Selectid[selectid] == layerCell.ID) { //判断选中
                        selectpc(useprameters.Selectid[selectid], layerCell, justpecent);
                        ImageModel.prototype.InfoShow(layerCell, document.getElementById("clickInfoDIV"), 'click');
                    }
                }
                for (var callissi in useprameters.UPCall) {
                    if (useprameters.UPCall[callissi].ISSI == layerCell.ISSI) { //判断ISSI是否存在上行呼叫(组呼，单呼(全双工，半双工))
                        callStateISSI(useprameters.UPCall[callissi].ISSI, layerCell, useprameters.UPCall[callissi].type, justpecent, useprameters.UPCall[callissi].drict);
                    }
                }
                for (var concernid in useprameters.concernusers_array) {
                    if (useprameters.concernusers_array[concernid] == layerCell.ID) { //判断是否关注
                        concernpc(useprameters.concernusers_array[concernid], layerCell, justpecent);
                        ImageModel.prototype.InfoShow(layerCell, document.getElementById("clickInfoDIV"), 'click');
                    }
                }
                if (useprameters.localid == layerCell.ID) { //判断定位标识
                    setTimeout(LayerControl.SetSourceCell(layerCell), 500);
                }

                if (theIntervalFun.lastDataStatus) {
                    var lastCell = theIntervalFun.lastDataStatus[cellID.split('|')[1]];
                    if (lastCell) {
                        if (lastCell.Send_reason.trim() != layerCell.Send_reason) {//终端状态变化提示窗口
                            var mapcoord = _StaticObj.objGet("map").getPixelInMap({ lo: layerCell.Longitude, la: layerCell.Latitude });
                            //lq_outInfo(mapcoord.x, mapcoord.y, cellID, layerCell.Send_reason);
                            lq_outInfo(mapcoord.x, mapcoord.y, cellID, GetTextByName(layerCell.Send_reason, useprameters.languagedata));

                        }
                    }

                }
            });

        }


        function cj(obj) {
            if (isBegStackadeSel) {
                return;
            }
            if (isBegSendMsgSel) {
                return;
            }
            var cj = document.getElementById("imgrang");
            if (cj.src.indexOf("Images/ToolBar/rightbg/ring_un.png") > 0) {
                alert(GetTextByName("PleaseEndRang", useprameters.languagedata));//多语言:请结束当前测距状态
                return;
            }
            writeLog("oper", "[" + GetTextByName("Distancemeasurement", useprameters.languagedata) + "]:" + GetTextByName("Start", useprameters.languagedata) + GetTextByName("Distancemeasurement", useprameters.languagedata) + "[" + LOGTimeGet() + "]");         /**日志:操作日志 多语言:测距；开始；测距 **/
            reconverbutton(GetTextByName("Distancemeasurement", useprameters.languagedata));//多语言:测距
            ismyrectangleSel = false;
            var mp = document.getElementById("map");
            mp.style.cursor = "url(\"tool07.cur\")";
            obj.src = "Images/ToolBar/rightbg/ring_un.png";
            _StaticObj.objGet("Multi_Ranging").addRanging();
        }
        cellinitRightMenu_data = function (ci, layerId) {
            useprameters.rightselectid = ci;
            useprameters.rightselecttype = "cell";
        }
        function locktext(ci) {
            if (useprameters.lockid == ci) {
                return GetTextByName("UnLockFunction", useprameters.languagedata);//多语言 关闭锁定
            }
            return GetTextByName("LockFunction", useprameters.languagedata);//多语言 开启锁定
        }
        function tracetext(ci) {
            if (istracein(ci)) {
                return GetTextByName("Text_CloseRealTimeTrajectory", useprameters.languagedata);//多语言:关闭实时轨迹
            }
            return GetTextByName("Text_OpenRealTimeTrajectory", useprameters.languagedata);//多语言:开启实时轨迹
        }
        function isLocked(id) {
            if (useprameters.lockid == id) {
                return true;
            }
            else return false;
        }
        function lock_it(id) {
            jquerygetNewData_ajax("Handlers/IsHDISSI.ashx", { id: id }, function (msg) {

                if (msg.result == "True") {
                    alert(GetTextByName("Alert_UseIsHideNotLockOrUnLock", useprameters.languagedata));//多语言:改移动用户已被隐藏，不能锁定与解锁操作
                    return;
                }

                if (useprameters.lockid != id && useprameters.lockid != 0) {
                    if (!confirm(GetTextByName("Confirm_AfterLockToUnLockLastOne", useprameters.languagedata))) {//多语言:锁定该用户后，将解锁上个用户\r确定该操作？
                        return;
                    }
                }
                if (useprameters.lockid != 0) {
                    var ul = document.getElementById("bztp_lock_" + useprameters.lockid);
                    writeLog("oper", "[" + GetTextByName("Log_traceMode", useprameters.languagedata) + "]:" + GetTextByName("Closebtn", useprameters.languagedata) + GetTextByName("use", useprameters.languagedata) + "ID(" + useprameters.lockid + ")" + GetTextByName("Single_S", useprameters.languagedata) + GetTextByName("Log_traceMode", useprameters.languagedata) + "[" + LOGTimeGet() + "]");         /**日志:操作日志 多语言:跟踪模式；关闭；用户;的；跟踪模式**/
                    if (ul) { removeChildSafe(ul); } //移除锁定图标
                }
                if (useprameters.lockid == id) {
                    useprameters.lockid = 0//如果没锁定时候，存入O
                }
                else {
                    useprameters.lockid = id;
                    writeLog("oper", "[" + GetTextByName("Log_traceMode", useprameters.languagedata) + "]:" + GetTextByName("Single_Open", useprameters.languagedata) + GetTextByName("use", useprameters.languagedata) + "ID(" + useprameters.lockid + ")" + GetTextByName("Single_S", useprameters.languagedata) + GetTextByName("Log_traceMode", useprameters.languagedata) + "[" + LOGTimeGet() + "]");         /**日志:操作日志 多语言:跟踪模式；开启；用户;的；跟踪模式 **/

                };
                //框选列表生成锁定图标
                var ifrs = document.frames["select_user_ifr"];
                if (ifrs) {
                    ifrs.checklock(); //锁定图标
                }
                //关注列表生成锁定图标
                var ifrs_concernlistframe = document.frames["concernlist_ifr"];
                if (ifrs_concernlistframe) {
                    ifrs_concernlistframe.checklock(); //锁定图标
                }
                //警员列表生成锁定图标
                var ifrs_policelists = document.frames["policelists"];
                if (ifrs_policelists) {
                    ifrs_policelists.checklock(); //锁定图标
                }

                set_uselockid(useprameters.lockid); //在服务器上存入，ID
                LayerControl.setIGetData(true, LayerControl);
                _StaticObj.objGet("LayerControl").LoadDataToLayerControl(); //重载警员数据

            });
        }
        function createMenu(array) { //创建右键菜单
            if (!array) { return null; }
            var rightMenu = document.getElementById("rightMenu");
            if (rightMenu) {
                delObj(rightMenu);
            }
            try {
                var divContainer = document.createElement("div");
                divContainer.style.cursor = "default";
                divContainer.style.borderStyle = "solid";
                divContainer.style.borderWidth = "1px";
                divContainer.style.borderColor = "green";
                divContainer.style.fontSize = "13px";
                divContainer.style.backgroundColor = "white";
                divContainer.id = "rightMenu";
                divContainer.style.width = "90px";
                divContainer.style.position = "absolute";
                divContainer.style.zIndex = 9999;
                for (var menu in array) {
                    if (typeof (array[menu]) != "function") {
                        var divTr = document.createElement("div");
                        divTr.innerHTML = array[menu][2];
                        divTr.fun = array[menu][0];
                        divTr.arg = array[menu][1];
                        divTr.style.margin = "2px";
                        divContainer.appendChild(divTr);
                        divTr.onmouseover = function () {
                            right_colorChange(this, 'green');
                            this.style.color = 'white';
                        };
                        divTr.onmouseout = function () {
                            right_colorChange(this, 'white');
                            this.style.color = 'black';
                        };
                        divTr.onclick = function () {
                            this.fun(this.arg);
                            delObj("rightMenu");
                            var ifrs = document.frames["ifr_callcontent"];
                            if (ifrs.document.getElementById("rightMenu")) {
                                ifrs.delObj("rightMenu");
                            }
                        };
                    }

                }
                divContainer.onmouseleave = function () {

                };
                return divContainer;
            }
            catch (err) {
            }
        }


    </script>
    <script src="pro_dropdown_2/stuHover.js" type="text/javascript"></script>
</head>
<body onselectstart="return false">
    <form id="form1" runat="server" style="overflow: hidden">
        <div id="map" style="position: absolute; cursor: pointer;">
        </div>
        <%--顶部工具栏--%>
        <div class="tool_div" style="float: left; height: 35px; position: absolute; left: 0px; z-index: 100; top: 0px; width: 100%">
            <ul id="nav">
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
                        onmouseout="javascript:this.style.backgroundImage='';" id="jichuxx">
                        <img src="Images/ToolBar/jcxx.png" />&nbsp;
                    </div>
                    <ul class="sub" style="width: 160px;">
                        <li><a href="#GIS" onclick="mycallfunction('manager_entity',693, 354)" style="width: 160px" id="danweixinxiweihu">
                            <span style="background: url(Images/ToolBar/toolbar_bgx.png) no-repeat 0px 0; width: 16px; height: 16px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></a></li>
                        <li><a href="#GIS" onclick="mycallfunction('manager_ISSI',880, 354)" style="width: 160px" id="zhongduanxinxiweihu">
                            <span style="background: url(Images/ToolBar/toolbar_bgx.png) no-repeat 0px 0; width: 16px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></a></li>
                        <li><a href="#GIS" onclick="mycallfunction('manager_user',710, 370)" style="width: 160px" id="ydyhxinxiweihu">
                            <span style="background: url(Images/ToolBar/toolbar_bgx.png) no-repeat 0px 0; width: 16px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></a></li>
                        <li><a href="#GIS" onclick="mycallfunction('manager_login',618, 354)" style="width: 160px" id="ddyxxwh">
                            <span style="background: url(Images/ToolBar/toolbar_bgx.png) no-repeat 0px 0; width: 16px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></a></li>
                        <%--配置用户管理--%>
                        <li><a href="#GIS" onclick="mycallfunction('manager_configuser',618, 354)" style="width: 160px" id="configuser">
                            <span style="background: url(Images/ToolBar/toolbar_bgx.png) no-repeat 0px 0; width: 16px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></a></li>
                        <li style="display: none"><a href="#GIS" onclick="mycallfunction('FixedStation',618, 354)" style="width: 160px" id="GDTXXWH">
                            <span style="background: url(Images/ToolBar/toolbar_bgx.png) no-repeat 0px 0; width: 16px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></a></li>

                        <li style="<%                           
                            DbComponent.Entity entity = new DbComponent.Entity(); int entity_depth = entity.GetEntityIndex(int.Parse(Request.Cookies["id"].Value)); if (entity_depth != 0 && entity_depth != -1)
                            {
                                %>display: none<%
                                
                            }
           
                    
                    %>"><a href="#GIS" onclick="mycallfunction('manager_Dispatch',650, 354)" style="width: 160px" id="ddtxxwh">
                        <span style="background: url(Images/ToolBar/toolbar_bgx.png) no-repeat 0px 0; width: 16px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></a></li>
                        //manager_Stackade
                        <%--<li><a href="#GIS" onclick="mycallfunction('manager_Stackade',600, 354)" style="width: 160px" id="dzzlxxwh">
                            <span style="background: url(Images/ToolBar/toolbar_bgx.png) no-repeat -0px 0; width: 16px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></a></li>--%>

                        <li style="<%            

                            if (entity_depth != 0 && entity_depth != -1)
                            {
                                %>display: none<%
                                
                            }           
                    
                    %>"><a href="#GIS" onclick="mycallfunction('manager_UserType',550, 354)" style="width: 160px;" id="yhlxxxwh">
                        <span style="background: url(Images/ToolBar/toolbar_bgx.png) no-repeat -0px 0; width: 16px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></a></li>
                        <li style="<%
                     
                            if (entity_depth != 0 && entity_depth != -1)
                            {
                                %>display: none<%
                                
                            }
           
                    
                    %>"><a href="#GIS" onclick="mycallfunction('manager_BaseStation',550, 354)" style="width: 160px;" id="jzxxwh">
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
                    <ul class="sub" style="width: 160px;" >
                        <li><a href="#GIS" onclick="mycallfunction('DispatchFunc',450,804)" style="width: 160px" id="hjmb" >
                            <span style="background: url(Images/ToolBar/toolbar_bgx.png) no-repeat 0px 0; width: 16px; height: 16px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></a></li>
                        <li><a href="#GIS" onclick="mycallfunction('SearchGpsStatues',950,904)" style="width: 160px" id="gpslist">
                            <span style="background: url(Images/ToolBar/toolbar_bgx.png) no-repeat 0px 0; width: 16px; height: 16px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></a></li>
                        <li><a href="#GIS" onclick="mycallfunction('SMS/SMSList',878,475)" style="width: 160px" id="sms_sjx">
                            <span style="background: url(Images/ToolBar/toolbar_bgx.png) no-repeat 0px 0; width: 16px; height: 16px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></a></li>
                     <li ><a href="#GIS" onclick="mycallfunction('LogView/OperationLog',1024,550)" style="width: 160px" id="operationlog">
                            <span style="background: url(Images/ToolBar/toolbar_bgx.png) no-repeat 0px 0; width: 16px; height: 16px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></a></li>
                    
                    </ul>

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
                    <div id="options" onclick="openoption(this)" style="cursor: pointer; width: 90px; height: 35px; text-align: left; line-height: 30px; margin-top: 2px; padding-left: 4px;"
                        onclick="">
                        <img src="Images/option.png" />&nbsp;
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

        <%--右侧工具--%>
        <div class="tool_div" style="float: left; width: 44px; position: absolute; right: 2px; top: 40px;">
            <ul id="toolba2">
                <li class="top" style="width: 44px; height: 21px; overflow: hidden;">
                    <img src="Images/ToolBar/rightbg/bg_top.png" onclick="switchrighttool()" /></li>
                <li id="too1bali1" class="top" style="<%                     
                    if (int.Parse(Request.Cookies["usertype"].Value) == 2)
                    {
                                %>display: none<%
                                
                    }
                    else
                    { 
                                %>display: block<%
                    }                   
                    %>; background-image: url(Images/ToolBar/rightbg/bg.png); width: 44px; text-align: center; height: 40px; padding-top: 5px;">
                    <img id='cloose' onclick="myrectangle(this)" src="Images/ToolBar/rightbg/choose.png" /></li>
                <li id="too1bali2" class="top" style="background-image: url(Images/ToolBar/rightbg/bg.png); width: 44px; text-align: center; height: 40px;">
                    <img id='imgrang' onclick="cj(this)" src="Images/ToolBar/rightbg/ring.png" /></li>
                <li id="too1bali3" class="top" style="background-image: url(Images/ToolBar/rightbg/bg.png); width: 44px; text-align: center; height: 40px;">
                    <img id='zoomin' onclick="switchZoomInTool(true,this)" src="Images/ToolBar/rightbg/zoomin.png" /></li>
                <li id="too1bali4" class="top" style="background-image: url(Images/ToolBar/rightbg/bg.png); width: 44px; text-align: center; height: 40px;">
                    <img id='zoomout' onclick="switchZoomOutTool(true,this)" src="Images/ToolBar/rightbg/zoomout.png" /></li>
                <li id="too1bali5" class="top" style="background-image: url(Images/ToolBar/rightbg/bg.png); width: 44px; text-align: center; height: 165px;"></li>
                <li class="top" style="width: 44px; height: 4px; background-image: url(Images/ToolBar/rightbg/bg_down.png); overflow: hidden;"></li>
            </ul>
        </div>
        <div id="UpCallPanl" align="right" style="z-index: 10; position: absolute; top: 400px; right: 0px; width: 323px; height: 230px; overflow: hidden; display: block">
            <iframe id="mypancallContent" name="mypancallContent" src="" width="100%" allowtransparency="true"
                scrolling="no" style="padding-bottom: 0px;" frameborder="0" height="300px"></iframe>
        </div>

        <%--地图卫星图切换--%>
        <div id="toggleFatSatelit" style="height: 25px; cursor: pointer; background-image: url(Images/satelitteanpm1.png);">
            <ul>
                <li id="pingmiandt" style="width: 33px;" onclick="toggleFlatSt('NORMAL')"></li>
                <li style="width: 100px;"
                    id="weixdt" onclick="toggleFlatSt('HYBRID')"></li>
            </ul>
        </div>
        <%--底部背景--%>
        <div id="divbootombar">
        </div>
        <%--鹰眼开始--%>
        <div id="diveageyetop" onclick="movehawkeye();">
            <img src="lqnew/logwindow/pic/haykeye_buttondown.gif" style="cursor: pointer" />
        </div>
        <div id="diveageye" onclick="movehawkeye();">
        </div>
        <div id="diveageyeleft">
        </div>
        <%--底部呼叫工具栏--%>
        <%--遮罩背景--%>
        <div id="bgDiv" style="display: none">
        </div>
        <div id="mybkdiv" style="display: none">
            <p id="mydivp">
            </p>
        </div>
        <div id="regDiv"></div>
        <%--实时轨迹--%>
        <div id="nowtrace">
        </div>
        <%--编组按钮--%>
        <div id="bzmenu">
        </div>
        <%--呼叫控件--%>
        <%--<object classid="clsid:C9C49299-69B6-4080-8747-8801C8397B3B" style="display: none;"
            id="SCactionX">
        </object>--%>
        <%--呼叫消息--%>
        <div id="MSN"><ul><li id="scrollarea">您1111好这里呈现出vsdsdfsdfsds 士大夫士大夫士大夫</li></ul></div>
        <%-- 声音播放--%>
        <object id="mhplayer" style="display: none" classid='CLSID:6BF52A52-394A-11d3-B153-00C04F79FAA6' width="0"
            height="0" type="application/x-oleobject">
            <param name='AutoStart' value='false' />
            <param name='Enabled' value='true' />
            <param name="volume" value="5000" />
        </object>
        <%--    <object classid="clsid:3c34c856-7a75-4e5d-96f5-639dff5cf9ea" style="display: none;"
        id="EasctcomActiveX">
    </object>--%>
        <%--日志--%>
        <div id="mouseMenu" runat="server">
            <div id="policemouseMenu" style="z-index: 56">
                <ul>
                    <li id="Lang_selecteduser" runat="server" style="display: none"><%--选中用户SelectUser--%></li>
                    <li id="Lang_dispatchopr" runat="server"></li>
                    <li id="Lang_ApplicationService" runat="server">
                        <%--应用业务--%>
            
                    </li>
                    <li id="Lang_smsopr" runat="server">
                        <%--短信功能--%>
            
                    </li>
                </ul>
            </div>
            <div id="groupmouseMenu" runat="server" style="z-index: 56">
                <ul runat="server">
                    <li id="Lang_smallGroupCall" runat="server"><%--小组呼叫--%></li>
                    <li id="Lang_groupgroupsms" runat="server"><%--小组短信--%></li>
                    <li id="Lang_groupstatussms" runat="server"><%--状态消息--%></li>
                </ul>
            </div>
            <div id="dispatchmouseMenu" runat="server" style="z-index: 56">
                <ul>
                    <li id="Lang_dispatchsinglecall" runat="server"><%--单呼--%></li>
                    <li id="Lang_dispatchsms" runat="server"><%--短信--%></li>
                    <li id="Lang_dispatchstatussms" runat="server"><%--状态消息--%></li>
                </ul>
            </div>

            <script type="text/javascript">
                MouseMenuEvent();//加载警员右键新的菜单事件
            </script>
        </div>

    </form>
    <form target="select_user_ifr" method="post" id="submit_selectUser" action="lqnew/opePages/select_user.aspx">
        <input type="hidden" id="hidsid" name="hidsid" value="" />
    </form>

    <form target="SendGPSEnableOrDisable_ifr" method="post" id="SendGPSEnableOrDisableFrom" action="lqnew/opePages/SendGPSEnableOrDisable.aspx">
        <input type="hidden" id="sendgpshidsids" name="sendgpshidsids" value="" />
    </form>
    <form target="Send_SMS_ifr" method="post" id="Send_SMSFrom" action="lqnew/opePages/Send_SMS.aspx">
        <input type="hidden" id="sid" name="sid" value="" />
    </form>
    <form target="SendGPSContral_ifr" method="post" id="SendGPSContralFrom" action="lqnew/opePages/SendGPSContral.aspx">
        <input type="hidden" id="sendgpscontralhidsids" name="sendgpscontralhidsids" value="" />
    </form>

    <%--左侧树形进度条--%>
    <%--<div id="processbar" style="width:130px; position:absolute; margin-top:150px;margin-left:50px;z-index:3000;font-size:large;display:none;color:red">
                <span>加载中</span>......
            </div>--%>
    <div id="policelistsdiv" style="position: absolute; width: 330px; height: 550px; margin-left: 204px; margin-top: 43px; border: solid; border-color: gray; border-width: 1px; display: none; z-index: 20">
        <iframe id="policelists" style="width: 330px; height: 550px;" frameborder="0" src="lqnew/opePages/policelists.aspx"></iframe>
        <script type="text/javascript">
            function hidepolicelistsdiv() {
                var policelists_div = document.getElementById("policelistsdiv");
                if (policelists_div) {
                    policelists_div.style.display = "none";
                }
            }
            function displaypolicelistsdiv() {
                var policelists_div = document.getElementById("policelistsdiv");
                if (policelists_div) {
                    policelists_div.style.display = "block";
                }
            }
        </script>
    </div>
    <div class="opendivwindow" id="concernlist" style="position: absolute; width: 550px; height: 550px; left: 400px; top: 100px; display: none; z-index: 20">
        <iframe name="concernlist_ifr" id="concernlist_ifr"  width="100%" allowtransparency="true"
                scrolling="no" style="padding-bottom: 0px; height:460px" frameborder="0" src="" ></iframe>
        </div>
</body>
</html>
<script type="text/javascript">
    function creatconcernlistwindow() {
        window.document.getElementById("concernlist_ifr").src = "lqnew/opePages/concernlist.aspx";
        var concerndiv = window.document.getElementById("concernlist");
        concerndiv.onmousedown = function () { mystartDragWindow(this); this.style.border = "solid 3px transparent"; cgzindex(this); };
        concerndiv.onmouseup = function () { mystopDragWindow(this); this.style.border = "0px"; };
        concerndiv.onmousemove = function () { mydragWindow(this) };

        return;

        var concerndiv = document.createElement("div");
        var ifr = document.createElement("iframe");
        concerndiv.id = "concernlist";
        //concerndiv.className = "opendivwindow";
        concerndiv.style.display = "none";
        concerndiv.style.position = "absolute";
        concerndiv.style.width = "550px";
        concerndiv.style.height = "460px";        
        concerndiv.style.zIndex = "50";
        concerndiv.style.overflow = "hidden";
        concerndiv.onmousedown = function () { mystartDragWindow(this); this.style.border = "solid 3px transparent"; cgzindex(this); };
        concerndiv.onmouseup = function () { mystopDragWindow(this); this.style.border = "0px"; };
        concerndiv.onmousemove = function () { mydragWindow(this) };
        concerndiv.style.left = "180";
        concerndiv.style.top = "110";
        ifr.id = "concernlist_ifr";
        ifr.name = "concernlist_ifr";
        ifr.style.width = "550px";
        ifr.style.height = "460px";
        ifr.allowtransparency = "true";
        ifr.scrolling="no" ;
        ifr.style.paddingBottom = "0px";
        ifr.frameborder = "0";        
        //ifr.src = "lqnew/opePages/concernlist.aspx";
        //concerndiv.appendChild(ifr);
        //document.body.appendChild(ifr);
    }
    function hideconcernlistdiv() {
        var policelists_div = document.getElementById("concernlist");
        if (policelists_div) {
            policelists_div.style.display = "none";
        }
    }
    function displayconcernlistdiv() {
        var policelists_div = document.getElementById("concernlist");
        if (policelists_div) {
            policelists_div.style.display = "block";
        }
    }
</script>
