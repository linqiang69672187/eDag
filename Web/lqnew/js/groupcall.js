function GetGSSIbyISSI(issi) //根据ISSI查询所属GSSI
{
    if (issi) {
        var param = { "ISSI": issi };
        jquerygetNewData_ajax("WebGis/Service/GetGSSIbyID.aspx", param, function (request) {
            if (request) {
                useprameters.SelectGSSI = request.GSSI;
                // changezhebg("call2", "0 0");  
                // startGC();
                if (request.GSSI != GetTextByName("Nodata", useprameters.languagedata)) {//多语言：无
                    var parama = { "GSSI": request.GSSI };
                    jquerygetNewData_ajax("WebGis/Service/GetGSSINameByGSSI.aspx", parama, function (requesta) {
                        useprameters.SelectGSSIName = requesta.GSSIName;
                        var ifrs = document.frames["ifr_callcontent"];
                        ifrs.innerhtmltoele("group1", useprameters.SelectGSSIName);
                        ifrs.innerhtmltoele("group2", useprameters.SelectGSSI);
                    }, false, false);
                }
                else {
                    var ifrs = document.frames["ifr_callcontent"];
                    ifrs.innerhtmltoele("group1", GetTextByName("Nodata", useprameters.languagedata));//多语言：无
                    ifrs.innerhtmltoele("group2", GetTextByName("Nodata", useprameters.languagedata));//多语言：无
                }
            }
        }, false, false);
    }
}
function GetGSSIbyIssiAndStartGC(issi) //根据ISSI查询所属GSSI并发起呼叫
{
    if (issi) {
        var param = { "ISSI": issi };
        jquerygetNewData_ajax("WebGis/Service/GetGSSIbyID.aspx", param, function (request) {
            if (request) {
                 useprameters.SelectGSSI = request.GSSI;
                 startGC();
            }
         }, false, false);
    }
}
function startGC() {
    var gssi = useprameters.SelectGSSI || useprameters.bzGSSI;
    if (gssi) {
        var isEncryption = "0";//xzj--20190320--添加呼叫加密参数
        if (useprameters.CallEncryption.indexOf("Group") >= 0) {
            isEncryption = "1";
        }
        var scactionX = document.frames['log_windows_ifr'].document.getElementById('SCactionX');
        try
        {
            scactionX.StartGCall(gssi, isEncryption);
            writeLog("oper", "[" + GetTextByName("GroupCall", useprameters.languagedata) + "]:" + GetTextByName("DispatchStatrCall", useprameters.languagedata) + "GSSI(" + gssi + ")" + GetTextByName("Called", useprameters.languagedata) + "[" + LOGTimeGet() + "]");         /**日志：操作日志 多语言：组呼，调度台呼叫栏开始，呼叫**/
        }
        catch (err) {
            setTimeout(startGC, 100);
        }
    }
}
function endGC() {
    var gssi =  useprameters.SelectGSSI || useprameters.bzGSSI;
    if (gssi) {
        var scactionX = document.frames['log_windows_ifr'].document.getElementById('SCactionX');
        scactionX.ENDGCall(gssi);
    }
}
function gceasedPTT() { //释放组呼PTT
    var gssi = useprameters.SelectGSSI || useprameters.bzGSSI;
    if (gssi) {
        var scactionX = document.frames['log_windows_ifr'].document.getElementById('SCactionX');
        try {
            scactionX.gceasedPTT(gssi);
            writeLog("oper", "[" + GetTextByName("GroupCall", useprameters.languagedata) + "]:" + GetTextByName("DispatchStatrCall", useprameters.languagedata) + "GSSI(" + gssi + ")" + GetTextByName("Called", useprameters.languagedata) + "[" + LOGTimeGet() + "]");         /**日志：操作日志 多语言：组呼，调度台呼叫栏释放，呼叫**/

        }
        catch (err) {
            setTimeout(gceasedPTT, 100);
        }
      
    }
}
function setGroupCallGSSI(gssi) {
    useprameters.SelectGSSI = gssi;
}
function removeGroupCallGSSI() {//陈孝银添加---20180628
    useprameters.SelectGSSI = "";
}