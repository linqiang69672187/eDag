/// <reference path="../../JQuery/jquery-1.5.2.js" />
function reconverbutton(btntype) {
    var ifrs = document.frames["ifr_callcontent"];
    if (!checkcallimg(window) && btntype == GetTextByName("Selectionof", useprameters.languagedata)) {//多语言：框选
        alert(GetTextByName("PleaseEndCalling", useprameters.languagedata));//多语言：请结束当前呼叫操作
        return;
    }

    $("#cloose").attr("src", "Images/ToolBar/rightbg/choose.png");
    $("#imgrang").attr("src", "Images/ToolBar/rightbg/ring.png");
    $("#zoomin").attr("src", "Images/ToolBar/rightbg/zoomin.png");
    $("#zoomout").attr("src", "Images/ToolBar/rightbg/zoomout.png");
    offalltutton(btntype);
}
function offalltutton(btntype) {
    var mp = document.getElementById("map");
    mp.style.cursor = "default";
    _StaticObj.objGet("Multi_Ranging").stopAll();
    _StaticObj.objGet("ZoomOutTool").switchZoom(false); //关闭缩小
    _StaticObj.objGet("ZoomInTool").switchZoom(false); //关闭放大
    var choose = _StaticObj.objGet("choose"); //关闭框选
    if (choose) { choose.turnOff("rectangle"); }
}
function toggleFlatSt(value) {
    var mp = _StaticObj.objGet("map");
    with (mp) {
        if (value == "NORMAL") {
            data.backPicSize = 200;
        }
        else {
            data.backPicSize = 200;  //地图瓦片尺寸
        }
        data.backPicType = value;
        clearBackContainer(); //清空背景
        fillBackPicsToDivMap();
    }
    $("#toggleFatSatelit").css("backgroundImage", (value == "NORMAL") ? "url(Images/satelitteanpm1.png)" : "url(Images/satelitteanpm2.png)")
}
function showlocalpic(param) {
    try{
        useprameters.localid = param.split('|')[1];
        //LayerControl.SetSourceCell(LayerControl.CellGet(param.split('|')[0], param.split('|')[1])); //获取layerCell对象
        //插旗子
        var ISSI = param.split('|')[5];
        SetSourceCell(ISSI);
        setTimeout(function () {
            useprameters.localid = "0";
            //LayerControl.ClearSourceCell();
            //清除旗帜图片
            ClearSourceCell(ISSI);
        }, 10000);
    }
    catch (e) {
        alert("showlocalpic" + e);
    }
}
function loginout() {
    var usertype = Cookies.get("usertype");
    if (usertype == 2) {
        if (!confirm(GetTextByName("BeSureexitsystem", useprameters.languagedata))) {//多语言：确定退出GIS系统吗？
            return;
        }
        execloginout();
        //window.open('', '_parent');
        //window.close();
        return;
    }

    try {
        //var ifrs = document.frames["ifr_callcontent"];
        var scactionX = document.frames['log_windows_ifr'].document.getElementById('SCactionX');
        //var map = _StaticObj.objGet("map")
        if (!checkcallimg()) {
            alert(GetTextByName("PleaseEndCalling", useprameters.languagedata));//多语言：请结束当前呼叫操作
            return;
        }
        if (callPanalISSI != "") {
            alert(GetTextByName("PleaseEndCalling", useprameters.languagedata));//多语言：请结束当前呼叫操作
            return;
        }
        if (isPanalALCall) {
            alert(GetTextByName("Pleaseendenvironmentalmonitoring", useprameters.languagedata));//多语言：请先结束环境监听
            return;
        }
        if (isPanalDLCall) {
            alert(GetTextByName("Pleaseendclosemonitoring", useprameters.languagedata));//多语言：请先结束慎密监听
            return;
        }
        if (isPanalBSCall) {
            alert(GetTextByName("Pleaseendbasestationcall", useprameters.languagedata));//多语言：请先结束基站呼叫
            return;
        }
        if (!confirm(GetTextByName("BeSureexitsystem", useprameters.languagedata))) {//多语言：确定退出GIS系统吗？
            return;
        }
        document.body.onbeforeunload = null;
        document.body.onunload = null;
        execloginout();
    } catch (ex) { 
        alert("loginout"+ex);
    }
  
//    finally {
//        var EasctcomActiveX = document.getElementById("EasctcomActiveX");
//        if (EasctcomActiveX) {
//            EasctcomActiveX.closeIE("GIS调度应用系统平台");
//        }
//    }
    } //退出本系统
    function execloginout()
    {
        try{
        var lastLoLa = "";
        var mainSWF = document.getElementById("main");
        if (mainSWF) {
            lastLoLa = mainSWF.callbackGetCurrentMapCenter();
        }
        var last_lo = lastLoLa.split(',')[0];
        var last_la = lastLoLa.split(',')[1];
        var param = {
            //last_lo: map.data.currentCenter.lo,
            //last_la: map.data.currentCenter.la
            //获取地图当前中心点
            last_lo: last_lo,
            last_la: last_la
        };
        jquerygetNewData_ajax("WebGis/Service/loginout.aspx", param, function (request) {
            
            try {
                var scactionX = document.frames['log_windows_ifr'].document.getElementById('SCactionX');
                scactionX.DispatchUserQuit();
            } catch (eses) {

            } finally {
                window.open('', '_parent');
                window.close();
            }

            setTimeout(function () {
                window.open('', '_parent');
                window.close();
            }, 1000);

        }, false, false);
        //        var EasctcomActiveX = document.getElementById("EasctcomActiveX");
        //        if (EasctcomActiveX) {
        //            EasctcomActiveX.closeIE("GIS调度应用系统平台");
        //        }

        // if (window.close()) {
        
          
        //            window.open('', '_parent');
        //            window.close(); //
        // }
        } catch (ex) {
            alert("loginout" + ex);
        }
    
    }