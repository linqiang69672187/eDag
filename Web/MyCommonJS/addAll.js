//add js_src to page
function includesrcipt(src) {
    var HTMLCode = "<script language='javascript' src='" + src + "'>" + "<\/script>";
    document.write(HTMLCode);
}

//get current Project UrlPath 只能适用于配置网站，不能是虚拟目录
function currentBasePathGet() {
    var strFullPath = window.document.location.href;
    var strPath = window.document.location.pathname;
    var pos = strFullPath.indexOf(strPath);
    var prePath = strFullPath.substring(0, pos + 1);
    //var postPath = strPath.substring(0, strPath.substr(1).indexOf('/') + 1);
    return prePath; //+"publish/";
}
window.L = {}; //公共库命名空间
var basePath = currentBasePathGet();
//not include jquery-1.4.2.js、Prototype.js
includesrcipt(basePath + "JQuery/jquery-1.5.2.js");
includesrcipt(basePath + 'MyCommonJS/Math.js');
includesrcipt(basePath + 'MyCommonJS/shorteningEvent.js');
includesrcipt(basePath + 'MyCommonJS/shorteningGetVar.js');
includesrcipt(basePath + 'MyCommonJS/time.js');
includesrcipt(basePath + 'MyCommonJS/validate.js');
includesrcipt(basePath + 'MyCommonJS/JSON/json2.js'); //reference App_JS/temp.js  JSON.stringify(data)
includesrcipt(basePath + 'MyCommonJS/JSON/json_sans_eval.js'); //reference App_JS/temp.js  jsonParse(JSONString)
includesrcipt(basePath + 'MyCommonJS/ajax.js');
//includesrcipt(basePath + 'MyCommonJS/Source/calendar/WdatePicker.js');
//includesrcipt(basePath + 'MyCommonJS/Source/getColors/chooseColor.js');
