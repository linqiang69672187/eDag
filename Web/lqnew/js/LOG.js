/// <reference path="../../JQuery/jquery-1.5.2.js" />
function writeLog(iframe, string) {
    try {
     //   var mainmap = document.getElementById("main");
    //    mainmap.showinfo(string);
        var logpage = document.frames["log_windows_ifr"].document.frames[iframe];
        var logtable = logpage.document.getElementById("log");
        if (logpage && logtable) {
            var logtr1 = logtable.firstChild.childNodes[49];
            var logtr2 = logtable.firstChild.childNodes[48];
            if (logtr1) {
                //彻底移除节点，回收内存
                removeChildSafe(logtr1);
                logtr1 = null;
            }
            if (logtr2) {
                removeChildSafe(logtr2);
                logtr2 = null;
            }
        }
        //创建tr和td
        if (logtable && logtable.firstChild) {
            var logtradd1 = document.createElement('tr');
            var logtdadd1 = document.createElement('td');

            if (logtable.firstChild.childNodes.length == 0) {
                logtable.appendChild(logtradd1);
            }
            else {
                logtable.firstChild.insertBefore(logtradd1, logtable.firstChild.firstChild);
            }
            logtradd1.appendChild(logtdadd1);
            logtdadd1.style.height = "1px";
            logtdadd1.style.backgroundImage = "url(backgline.gif)";

            var logtradd2 = document.createElement('tr');
            var logtdadd2 = document.createElement('td');

            logtable.insertBefore(logtradd2, logtradd1);
            logtradd2.appendChild(logtdadd2);
            logtdadd2.innerHTML = string;
        }
       
    }
    catch (e) {
    }
    logpage = null;
    logtable = null;
}
function flexwriteLogmiltlang(iframe,miltlang)
{
    writeLog(iframe, GetTextByName(miltlang,useprameters.languagedata) + "[" + LOGTimeGet() + "]");
}
function clearLOG() {
    $("#eTRALOG").html("");
}
function writeCallLog(issi, eventtype, msg, gssi, PCname, GSSIname, PCid) {
    var returnstring = "";
    if (eventtype == 10) {
        returnstring = "[" + GetTextByName("GroupCall", useprameters.languagedata) + "]<span title='" + gssi + "'  oncontextmenu=javascript:rightselecttype='group';rightGSSI='" + gssi + "' onclick=callgroupFunction('" + gssi + "')>" + gssi + "</span>:";//多语言：组呼
        if (issi != 0) {
            //            switch (PCname) {
            //                case "调度台":
            //                    returnstring += "<span title='" + issi + "' oncontextmenu=javascript:rightselecttype='dispatch';rightISSI='" + issi + "' onclick=calldispatchFunction('" + issi + "') >" + PCname + "</span>";
            //                    break;
            //                default:
            returnstring += (issi == useprameters.hostISSI) ? "<span title='" + issi + "' style='color:red;text-decoration:none;' >" + GetTextByName("Log_Local", useprameters.languagedata) + "</span>" : "<span title='" + issi + "'   onclick=callfunction('" + issi + "');  >" + issi + "</span>";//多语言：本机
            //          break;
            //    }

        }
        returnstring += msg;
    }
    if (eventtype == 00 || eventtype == 01) {
        var calltp = "";
        if (eventtype == 00) {
            calltp = "[" + GetTextByName("SingleCALL(half)", useprameters.languagedata) + "]";// 多语言：单呼(半)
        }
        else {
            calltp = "[" + GetTextByName("SingleCALL(all)", useprameters.languagedata) + "]";//多语言：单呼(全)
        }
        //        switch (PCname) {
        //            case "调度台":
        //                returnstring = calltp+"<span title='" + issi + "' oncontextmenu=javascript:rightselecttype='dispatch';rightISSI='" + issi + "' onclick=calldispatchFunction('" + issi + "') >" + PCname + "</span>";
        //                break;
        //            default:
        returnstring = (issi == useprameters.hostISSI) ? calltp + "<span title='" + issi + "' >" + GetTextByName("Log_Local", useprameters.languagedata) + "</span>" : calltp + "<span title='" + issi + "'    onclick=callfunction('" + issi + "');  >" + issi + "</span>";
        //       break;
        //    }

        returnstring += ":";
        returnstring += " " + msg;
    }
    writeLog("call", returnstring + "[" + LOGTimeGet() + "]");         /**写入呼叫窗口 **/
    returnstring = null;
}

function writePPCCallLog(issi, eventtype, msg, gssi, PCname, GSSIname, PCid) {
    var returnstring = "";
    if (eventtype == 10) {
        returnstring = "[" + GetTextByName("Log_EmergentGroupCall", useprameters.languagedata) + "]<span title='" + gssi + "'  oncontextmenu=javascript:rightselecttype='group';rightGSSI='" + gssi + "' onclick=callgroupFunction('" + gssi + "')>" + gssi + "</span>:";//多语言：紧急组呼
        if (issi != 0) {
            //            switch (PCname) {
            //                case "调度台":
            //                    returnstring += "<span title='" + issi + "' oncontextmenu=javascript:rightselecttype='dispatch';rightISSI='" + issi + "' onclick=calldispatchFunction('" + issi + "') >" + PCname + "</span>";
            //                    break;
            //                default:
            returnstring += (issi == useprameters.hostISSI) ? "<span title='" + issi + "' style='color:red;text-decoration:none;' >" + GetTextByName("Log_Local", useprameters.languagedata) + "</span>" : "<span title='" + issi + "'   onclick=callfunction('" + issi + "');  >" + issi + "</span>";//多语言：本机
            //          break;
            //    }

        }
        returnstring += msg;
    }
    if (eventtype == 00 || eventtype == 01) {
        var calltp = "";
        if (eventtype == 00) {
            calltp = "[" + GetTextByName("Log_EmergentHalfCall", useprameters.languagedata) + "]";
        }
        else {
            calltp = "[" + GetTextByName("Log_EmergentAllCall", useprameters.languagedata) + "]";
        }
        //        switch (PCname) {
        //            case "调度台":
        //                returnstring = calltp+"<span title='" + issi + "' oncontextmenu=javascript:rightselecttype='dispatch';rightISSI='" + issi + "' onclick=calldispatchFunction('" + issi + "') >" + PCname + "</span>";
        //                break;
        //            default:
        returnstring = (issi == useprameters.hostISSI) ? calltp + "<span title='" + issi + "' >" + GetTextByName("Log_Local", useprameters.languagedata) + "</span>" : calltp + "<span title='" + issi + "'    onclick=callfunction('" + issi + "');  >" + issi + "</span>";//多语言：本机
        //       break;
        //    }

        returnstring += ":";
        returnstring += " " + msg;
    }
    writeLog("call", returnstring + "[" + LOGTimeGet() + "]");         /**写入呼叫窗口 **/
    returnstring = null;
}

function LOGTimeGet() {
    var myDate = new Date();
    return checkTime(myDate.getHours()) + ":" + checkTime(myDate.getMinutes()) + ":" + checkTime(myDate.getSeconds());
    myDate = null;
}
function checkTime(i) {
    if (i < 10)
    { i = "0" + i }
    return i
}


function locationbyISSI(issi,gssi) {
    var param = { "ISSI": issi, "gssi": gssi, "hostISSI": useprameters.hostISSI};                                                   /**获取经纬度及用户名称**/
    jquerygetNewData_ajax("WebGis/Service/getISSSname.aspx", param, function (request) {
        var _data = request;
        if (request) {
            lo = request.lo;
            la = request.la;
            PCid = request.PCid;
            PCname = request.PCname;
            GSSIname = request.GSSIName;
            issilocation(lo, la, PCid,issi);                          /**定位该警员经纬度**/
        }
    });
}

function locationbyISSIsms(issi, gssi) {
    var param = { "ISSI": issi, "gssi": gssi, "hostISSI": useprameters.hostISSI };                                                   /**获取经纬度及用户名称**/
    jquerygetNewData_ajax("WebGis/Service/getISSSname.aspx", param, function (request) {
        var _data = request;
        if (request) {
            lo = request.lo;
            la = request.la;
            PCid = request.PCid;
            PCname = request.PCname;
            GSSIname = request.GSSIName;
            issilocationnoalert(lo, la, PCid,issi);                          /**定位该警员经纬度**/
        }
    });
}

function locationbyUseid(id) {
    var param = { "id": id };
    useprameters.id = id;
    var ISSI = "";
    jquerygetNewData_ajax("WebGis/Service/getlola_byID.aspx", param, function (request) {
        var _data = request;
        if (request) {
            lo = request.lo;
            la = request.la;
            ISSI = request.ISSI;
            if (lo == 0 || la == 0) {
                alert(GetTextByName("Log_LoLoIsZero", useprameters.languagedata));//多语言：经纬度为(0,0)请检查终端状态
            }
            issilocation(lo, la, id, ISSI);                          /**定位该警员经纬度**/
        }
    });
}


