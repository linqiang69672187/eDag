// 引用其他脚本文件  2010/1/6
function include(src) {
    HTMLCode = '<script language="javascript" src="' + src + '"></script>';
    document.write(HTMLCode);
}
var result;
var classResult;

xmlHttp1 = createHttp();
xmlHttp2 = createHttp();
xmlHttp3 = createHttp();
xmlHttp4 = createHttp(); //GPS在线统计
function getNewData_ajax(url, pars, func, IsNotasynchronous, noProgressBar) {
    //sendback(url, pars, func, xmlHttp1, "gis");
    var newxmlhttp = createHttp();
    sendback(url, pars, func, newxmlhttp, "gis");
    newxmlhttp = null;
}
function getNewData_ajax_Post(url, pars, func, SelectedEntity, IsNotasynchronous, noProgressBar) {
    var newxmlhttp = createHttp();
    sendback_Post(url, pars, func, newxmlhttp, "gis", SelectedEntity);
    newxmlhttp = null;
}
function getNewData_ajaxStock(url, pars, func, IsNotasynchronous, noProgressBar) {

    sendback(url, pars, func, xmlHttp2, "jquery");
}
function getNewData_ajaxtrace(url, pars, func, IsNotasynchronous, noProgressBar) {
    jquerygetNewData_ajax(url, pars, func, IsNotasynchronous, noProgressBar)
   // sendback(url, pars, func, xmlHttp3, "trace");
}

function getNewData_ajaxGpstotal(url, pars, func, IsNotasynchronous, noProgressBar) {

    sendback(url, pars, func, xmlHttp4, "GPSTotal");
}

function jquerygetNewData_ajax(url, pars, func, IsNotasynchronous, noProgressBar) {

    var newxmlhttp = createHttp();
    sendback(url, pars, func, newxmlhttp, "new");
    newxmlhttp = null;
}
function jquerygetNewData_ajax_post(url, pars, func, IsNotasynchronous, noProgressBar) {

    var newxmlhttp = createHttp();
    sendback_Post2(url, pars, func, newxmlhttp, "new");
    newxmlhttp = null;
}

function jquerygetNewData_ajax_pullup(url, pars, func, IsNotasynchronous, noProgressBar) {

    var newxmlhttp = createHttp();
    sendback2(url, pars, func, newxmlhttp, "new");
    newxmlhttp = null;
}

function LLHSuccesschange(func, xmlHttp, type) {
    if (xmlHttp.readyState == 4) {
        if (xmlHttp.status == 200) {
            result = xmlHttp.responseText
            if (result != '') {
                classResult = eval('(' + result + ')');     
            }
            if (type == "gis") {
                //庞小斌修改，去除.each方法
                var mapdiv = document.getElementById("Police,0,0_OutputLayerCell");
                if (mapdiv) {
                    var policedivs = mapdiv.childNodes;
                    var policedivs_length = policedivs.length;
                    var deletenums = 0;
                    for (var i = 0; i < policedivs_length; i++) {
                        if (policedivs[i - deletenums].id.indexOf("_vFigure") > -1) {
                            if (result != '') {
                                if (!isinGIS(policedivs[i - deletenums].ci, classResult)) {
                                    //庞小斌修改，去除fadeout()方法    
                                    var ul = document.getElementById("bztp_" + policedivs[i - deletenums].ci)
                                    if (ul && useprameters.lockid != policedivs[i - deletenums].ci) {
                                        removeChildSafe(ul);
                                        ul = null;
                                    }
                                    removeChildSafe(policedivs[i - deletenums]);
                                    deletenums++;
                                }
                            }
                        }
                    }
                    policedivs = null;
                }
                mapdiv = null;
            }
            if (result != '') {
                func(classResult);
            }
        }
        if (type == "new" || type == "gis") {
            delete xmlHttp["onreadystatechange"];
            xmlHttp.abort();
            xmlHttp = null
        }
    }
}

function sendback2(url, pars, func, xmlHttp, type) {
    try {
        url = url.concat('?L=1');
        for (var o in pars) {
            url = url.concat('&').concat(o).concat('=').concat(escape(pars[o]));
        }
        // if (type == "gis" && xmlHttp.readyState != 0 && xmlHttp.readyState != 4)
        //     return;
        xmlHttp.open("GET", url, false);
        xmlHttp.onreadystatechange = function () {
            try {
                LLHSuccesschange(func, xmlHttp, type);

            }
            catch (e) {
            }
        }
        xmlHttp.setRequestHeader("Content-Type", "application/json");
        xmlHttp.setRequestHeader("Cache-Control", "no-cache"); //用get方式，得加上，这样就不会缓存
        xmlHttp.setRequestHeader("If-Modified-Since", "0");
        xmlHttp.send(null);
        //创建XMLHttpRequest对象
    }
    catch (e) {

    }
}
function sendback(url, pars, func, xmlHttp, type) {
    try {
        url = url.concat('?L=1');
        for (var o in pars) {
            url = url.concat('&').concat(o).concat('=').concat(escape(pars[o]));
        }
    // if (type == "gis" && xmlHttp.readyState != 0 && xmlHttp.readyState != 4)
       //     return;
        xmlHttp.open("GET", url, true);
        xmlHttp.onreadystatechange = function () {
            try {
                LLHSuccesschange(func, xmlHttp, type);

            }
            catch (e) {
            }
        }
        xmlHttp.setRequestHeader("Content-Type", "application/json");
        xmlHttp.setRequestHeader("Cache-Control", "no-cache"); //用get方式，得加上，这样就不会缓存
        xmlHttp.setRequestHeader("If-Modified-Since", "0");
        xmlHttp.send(null);
        //创建XMLHttpRequest对象
    }
    catch (e) {

    }
}
function sendback_Post2(url, pars, func, xmlHttp, type) {
    try {
        url = url.concat('?L=1');
        var p = 'L=1';
        for (var o in pars) {
            p = p.concat('&').concat(o).concat('=').concat(escape(pars[o]));
        }
        if (type == "gis" && xmlHttp.readyState != 0 && xmlHttp.readyState != 4)
            return;
        xmlHttp.open("POST", url, true);
        xmlHttp.onreadystatechange = function () {
            try {
                LLHSuccesschange(func, xmlHttp, type);

            }
            catch (e) {
            }
        }
        xmlHttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        xmlHttp.send(p);
        //创建XMLHttpRequest对象
    }
    catch (e) {

    }
}


function sendback_Post(url, pars, func, xmlHttp, type, SelectedEntity) {
    try {
        url = url.concat('?L=1');
        for (var o in pars) {
            url = url.concat('&').concat(o).concat('=').concat(escape(pars[o]));
        }
        if (type == "gis" && xmlHttp.readyState != 0 && xmlHttp.readyState != 4)
            return;
        xmlHttp.open("POST", url, true);
        xmlHttp.onreadystatechange = function () {
            try {
                LLHSuccesschange(func, xmlHttp, type);

            }
            catch (e) {
            }
        }
        xmlHttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        xmlHttp.send(SelectedEntity);
        //创建XMLHttpRequest对象
    }
    catch (e) {

    }
}
function createHttp() {
    try {
        xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
    }
    catch (e) {
        try {
            xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
        }
        catch (e2) {
            xmlHttp = false;
        }
    }
    if (!xmlHttp && typeof XMLHttpRequest != 'undefined') {
        xmlHttp = new XMLHttpRequest();
    }
    return xmlHttp;
}

//function jquerygetNewData_ajax(url, pars, func, IsNotasynchronous, noProgressBar) {
//   $.ajax({
//      url: url, //请求地址
//      global: false, //是否触发全局ajax事件
//      type: "GET", //请求方式
//     async: true, //异步请求
//     data: pars, //JSON格式 自动转换为 &id=value&
//     cache: false, //不能浏览器缓存中加载信息
//       dataType: "json", //返回数据类型
//       success: function (data, textStatus) {
//          func(data, textStatus);
//       },  
//  complete: function (XHR, TS) { XHR = null } 
//   })
//}


function showProgressBar(isShow) {
    if (isShow && !document.getElementById("showProgressBar")) {
        var img = document.createElement("img");
        img.id = "showProgressBar";
        img.src = basePath + "Images/ProgressBar/05043120.gif";
        img.style.position = "absolute";
        img.style.zIndex = "1000";
        img.style.left = document.body.offsetWidth / 2 + "px";
        img.style.top = document.body.offsetHeight / 2 + "px";
        document.body.appendChild(img);
    }
}
function closeProgressBar() {
    var showProgressBar = document.getElementById("showProgressBar")
    if (showProgressBar) {        
        //庞小斌修改，更改移除方法
        removeChildSafe(showProgressBar);
    }
    showProgressBar = null;
}
function isinGIS(string, result) {
    if (!result["Police,0,0"]) {
        return false;
    }
    for (var i = 0; i < result["Police,0,0"].length; i++) {
        if (result["Police,0,0"][i][string]) {
            return true;
        }
    }
    return false;
}