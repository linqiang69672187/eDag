var strSuccess = "";
var strFailed = "";
var strSingle_Open = "";
var strClosebtn = "";
var strGPSOpen = "";
var strGPSParam = "";
var SMSMy = "";
var myLang_please_input_shortMessage = "";
var myReceipt = "";
var Lang_GPS_Param_ContralFaild = "";
var Lang_GPS_Open_ContralFaild = "";
var Lang_GPS_Mode_ContralFaild = "";
var strGPSMode = "";
var strPullUpSuccess = "";
var strPullUpFail = "";
var strUnPullUpSuccess = "";
var strUnPullUpFail = "";
var strPullUpOutTime = "";
var Lang_PullUp_ContralFaild = "";
var strDistance = "";
var intervalLoadUser;

function RenderToLeftMen() {
    var call = {
        text: GetTextByName("CallService", useprameters.languagedata),//呼叫业务
        data: [
    [{
        text: GetTextByName("SingleCall", useprameters.languagedata),//多语言：单呼
        func: function () {
            if (useprameters.callActivexable == false) {
                alert(GetTextByName("checkcallcontrolregister", useprameters.languagedata));//checkcallcontrolregister
                return;
            };
            if (callPanalISSI != "") {
                alert(GetTextByName("HassingleCallTobeClose", useprameters.languagedata));
                return;
            };//多语言：已发起一个单呼，请先结束
            //var ifrs = document.frames["ifr_callcontent"];
            if (!checkcallimg(window)) {
                alert(GetTextByName("HassingleCallTobeClose", useprameters.languagedata));//多语言：已发起一个单呼，请先结束
                return;
            }
            if (document.frames["PrivateCall"] != null || document.frames["PrivateCall"] != undefined) {
                mycallfunction('PrivateCall', 380, 280);
            }
            mycallfunction('PrivateCall', 380, 500, "&type=UID&myid=" + useprameters.rightselectid, 1999);
        }
    }, {
        text: GetTextByName("smallGroupCall", useprameters.languagedata),//多语言：小组呼叫
        func: function () {
            if (useprameters.callActivexable == false) {
                alert(GetTextByName("checkcallcontrolregister", useprameters.languagedata));//checkcallcontrolregister
                return;
            };
            mycallfunction('GroupCall', 380, 500, "&type=UID&myid=" + useprameters.rightselectid, 1999);
        }
    },
                {
                    text: GetTextByName("EmergencyCall", useprameters.languagedata),//多语言：紧急呼叫
                    func: function () {
                        if (useprameters.callActivexable == false) {
                            alert(GetTextByName("checkcallcontrolregister", useprameters.languagedata));//checkcallcontrolregister
                            return;
                        };
                        if (callPanalISSI != "") { alert(GetTextByName("HassingleCallTobeClose", useprameters.languagedata)); return };//多语言：已发起一个单呼，请先结束
                        //var ifrs = document.frames["ifr_callcontent"];
                        if (!checkcallimg(window)) {
                            alert(GetTextByName("HassingleCallTobeClose", useprameters.languagedata));//多语言：已发起一个单呼，请先结束
                            return;
                        }
                        mycallfunction('PPCCall', 380, 500, "&type=UID&myid=" + useprameters.rightselectid, 1999);
                    }
                },
    {
        text: GetTextByName("YAOQIYAOBI", useprameters.languagedata),//多语言：遥启遥毙
        func: function () {
            if (useprameters.callActivexable == false) {
                alert(GetTextByName("checkcallcontrolregister", useprameters.languagedata));//checkcallcontrolregister
                return;
            };
            mycallfunction('EnableDisableRadio', 380, 500, "&type=UID&myid=" + useprameters.rightselectid, 1999);
        }
    }
    ,
    {
        text: GetTextByName("CloseMonitoring", useprameters.languagedata),//多语言：慎密监听
        func: function () {

            if (useprameters.callActivexable == false) {
                alert(GetTextByName("checkcallcontrolregister", useprameters.languagedata));//checkcallcontrolregister
                return;
            };
            if (isPanalDLCall) {
                alert(GetTextByName("RightMeHavingSMJT", useprameters.languagedata));//多语言：已慎密监听用户，请先结束
                return;
            }
            if (document.frames["DLCall"] != null || document.frames["DLCall"] != undefined) {
                mycallfunction('DLCall', 380, 280, 0, 1999);
            }
            mycallfunction('DLCall', 380, 500, "&type=UID&myid=" + useprameters.rightselectid, 1999);
        }
    }
    ,
    {
        text: GetTextByName("EnvironmentalMonitoring", useprameters.languagedata),//多语言：EnvironmentalMonitoring环境监听
        func: function () {
            if (useprameters.callActivexable == false) {
                alert(GetTextByName("checkcallcontrolregister", useprameters.languagedata));//checkcallcontrolregister
                return;
            };
            if (isPanalALCall) {
                alert(GetTextByName("RightMe_havingHJJT", useprameters.languagedata));//多语言：已环境监听
                return;
            }
            if (document.frames["ALCall"] != null || document.frames["ALCall"] != undefined) {
                mycallfunction('ALCall', 380, 280, 0, 1999);
            }
            mycallfunction('ALCall', 380, 500, "&type=UID&myid=" + useprameters.rightselectid, 1999);
        }
    }
    ]
        ]
    },
               sms = {
                   text: GetTextByName("Shortmessageservice", useprameters.languagedata),//多语言：短信业务
                   data: [
           [{
               text: GetTextByName("Personalmessage", useprameters.languagedata),//多语言：个人短信
               func: function () {
                   if (useprameters.callActivexable == false) { alert(GetTextByName("Alert_OcxUnLoad", useprameters.languagedata)); return };

                   mycallfunction('Send_SMS', 380, 400, useprameters.rightselectid, 1999);
               }
           }, {
               text: GetTextByName("Groupmessage", useprameters.languagedata),//多语言：组短信
               func: function () {
                   if (useprameters.callActivexable == false) { alert(GetTextByName("Alert_OcxUnLoad", useprameters.languagedata)); return };//多语言：控件未加载，短信功能不可用
                   mycallfunction('Send_SMS', 380, 400, useprameters.rightselectid + "&cmd=G", 1999)
               }
           }, {
               text: GetTextByName("Statusmessage", useprameters.languagedata),//多语言：状态消息Statusmessage
               func: function () {
                   if (useprameters.callActivexable == false) { alert(GetTextByName("Alert_OcxUnLoad", useprameters.languagedata)); return };
                   mycallfunction('Send_StatusMS', 380, 400, useprameters.rightselectid, 1999);
               }
           }]
                   ]
               },
       apllication_addconcern = {
           text: GetTextByName("ApplicationService", useprameters.languagedata),//多语言：ApplicationService 应用业务
           data: [
           [{
               text: GetTextByName("DetailedInformation", useprameters.languagedata),//多语言：详细信息
               func: function () {
                   showCIMessage(useprameters.rightselectid);
               }
           },
           {
               text: GetTextByName("RightMe_CloseDetailInfor", useprameters.languagedata),//多语言：关闭显示
               func: function () {
                   lq_outinfomation(useprameters.rightselectid, GetTextByName("Alert_CHeckCloseShow", useprameters.languagedata))//Alert_CHeckCloseShow提示,※确定关闭该移动用户的实时显示功能吗？,※关闭后此用户将在地图上不进行显示,※可在【基础信息→移动用户信息维护】开启
               }
           }, {
               text: GetTextByName("RealTimeTrace", useprameters.languagedata),//多语言：实时轨迹RealTimeTrace
               func: function () {
                   trayceit('Police,0,0', useprameters.rightselectid);
               }
           }, {
               text: GetTextByName("HistoricalTrace", useprameters.languagedata),//多语言：历史轨迹
               func: function () {
                   mycallfunction('SubmitToHistory', 380, 370, useprameters.rightselectid, 1999)
               }
           },
            {
                text: GetTextByName("Stack", useprameters.languagedata),//多语言：电子栅栏
                func: function () {
                    if (isBegSendMsgSel) {
                        alert(GetTextByName("ToEndSMSMultiSend", useprameters.languagedata));//多语言：ToEndSMSMultiSend请先完成短信群发功能
                        return;
                    }
                    if (ismyrectangleSel) {
                        alert(GetTextByName("Alert_PleaseOverKX", useprameters.languagedata));//多语言：请先完成框选
                        return;
                    }
                    var cj = document.getElementById("imgrang");

                    if (cj.src.indexOf("Images/ToolBar/rightbg/ring_un.png") > 0) {
                        alert(GetTextByName("PleaseEndRang", useprameters.languagedata));//多语言：PleaseEndRang 请先完成测距状态
                        return;
                    }
                    mycallfunction('path_selectcolor', 450, 370, useprameters.rightselectid, 1999)
                }
            },
           {
               text: GetTextByName("LockFunction", useprameters.languagedata),//多语言：开启锁定 
               text: GetTextByName("UnLockFunction", useprameters.languagedata),//关闭锁定
               func: function () {
                   lock_it(useprameters.rightselectid);
               }
           },
           {
               text: GetTextByName("Lang_concern", useprameters.languagedata),//多语言：添加关注                
               func: function () {
                   Addusertoconcernlist(useprameters.rightselectid);
               }
           }]
           ]
       };
    apllication_deleteconcern = {
        text: GetTextByName("ApplicationService", useprameters.languagedata),//多语言：ApplicationService 应用业务
        data: [
        [{
            text: GetTextByName("DetailedInformation", useprameters.languagedata),//多语言：详细信息
            func: function () {
                showCIMessage(useprameters.rightselectid);
            }
        },
        {
            text: GetTextByName("RightMe_CloseDetailInfor", useprameters.languagedata),//多语言：关闭显示
            func: function () {
                lq_outinfomation(useprameters.rightselectid, GetTextByName("Alert_CHeckCloseShow", useprameters.languagedata))//Alert_CHeckCloseShow提示,※确定关闭该移动用户的实时显示功能吗？,※关闭后此用户将在地图上不进行显示,※可在【基础信息→移动用户信息维护】开启
            }
        }, {
            text: GetTextByName("RealTimeTrace", useprameters.languagedata),//多语言：实时轨迹RealTimeTrace
            func: function () {
                trayceit('Police,0,0', useprameters.rightselectid);
            }
        }, {
            text: GetTextByName("HistoricalTrace", useprameters.languagedata),//多语言：历史轨迹
            func: function () {
                mycallfunction('SubmitToHistory', 380, 370, useprameters.rightselectid, 1999)
            }
        },
         {
             text: GetTextByName("Stack", useprameters.languagedata),//多语言：电子栅栏
             func: function () {
                 if (isBegSendMsgSel) {
                     alert(GetTextByName("ToEndSMSMultiSend", useprameters.languagedata));//多语言：ToEndSMSMultiSend请先完成短信群发功能
                     return;
                 }
                 if (ismyrectangleSel) {
                     alert(GetTextByName("Alert_PleaseOverKX", useprameters.languagedata));//多语言：请先完成框选
                     return;
                 }
                 var cj = document.getElementById("imgrang");

                 if (cj.src.indexOf("Images/ToolBar/rightbg/ring_un.png") > 0) {
                     alert(GetTextByName("PleaseEndRang", useprameters.languagedata));//多语言：PleaseEndRang 请先完成测距状态
                     return;
                 }
                 mycallfunction('path_selectcolor', 450, 370, useprameters.rightselectid, 1999)
             }
         },
        {
            text: GetTextByName("LockFunction", useprameters.languagedata),//多语言：开启锁定 
            text: GetTextByName("UnLockFunction", useprameters.languagedata),//关闭锁定
            func: function () {
                lock_it(useprameters.rightselectid);
            }
        },
        {
            text: GetTextByName("Lang_unconcern", useprameters.languagedata),//取消关注
            func: function () {
                Deleteuserfromconcernlist(useprameters.rightselectid);
            }
        }]
        ]
    };
    var basestationdata = [{
        text: GetTextByName("StationCall", useprameters.languagedata),//多语言：基站呼叫
        func: function () {
            if (useprameters.callActivexable) {
                if (isPanalBSCall) {
                    alert(GetTextByName("Alert_BaseStationCalling", useprameters.languagedata));//多语言：已发起一个基站呼叫
                    return;
                }

                mycallfunction('SBCall', 380, 500, "&bsid=" + BSSelectID, 1999);
            }
            else {
                alert(GetTextByName("Alert_OcxUnLoadCanNotCall", useprameters.languagedata));//多语言：控件未加载
            }

        }
    }, {
        text: GetTextByName("Alert_EditBaseStation", useprameters.languagedata),//多语言：修改记录
        func: function () {
            mycallfunction('edit_BaseStation', 434, 240, BSSelectID);

        }

    }];

    var rightmenu = [{
        text: GetTextByName("Lang_Callpanel", useprameters.languagedata),//多语言：call panel
        func: function () {
            mycallfunction('DispatchFunc', 450, 804);
        }
    }, {
        text: GetTextByName("Selectionof", useprameters.languagedata),//多语言：框选
        func: function () {
            document.getElementById("cloose").click();
        }
    }, {
        text: GetTextByName("Lang_searchlockuser", useprameters.languagedata),//多语言：搜索锁定警员
        func: function () {
            mycallfunction('LockkByCtrlPanl', 350, 220, 0, 1999);
        }
    }, {
        text: GetTextByName("concernlists", useprameters.languagedata),//多语言：框选
        func: function () {
            openconcernlist();
        }
    }];

    var rightmenu_nolockuser = [{
        text: GetTextByName("Lang_Callpanel", useprameters.languagedata),//多语言：call panel
        func: function () {
            mycallfunction('DispatchFunc', 450, 804);
        }
    }, {
        text: GetTextByName("Selectionof", useprameters.languagedata),//多语言：框选
        func: function () {
            document.getElementById("cloose").click();
        }
    }, {
        text: GetTextByName("concernlists", useprameters.languagedata),//多语言：框选
        func: function () {
            openconcernlist();
        }
    }];
    var mailMenuData = [];

    $("div").smartMenu(mailMenuData, {
        name: "mail",
        afterShow: function () { },
        beforeShow: function () {
            $("#smartMenu_mail", window.parent.parent.document).remove();
            if (useprameters.rightselecttype == undefined) {
                if (haveCallSissi != null && haveCallSissi != undefined && haveCallSissi.length > 0) {
                    for (var myi in haveCallSissi) {
                        var myhcs = document.getElementById("PICDIV_" + haveCallSissi[myi]);
                        if (myhcs) {
                            var mapdiv = document.getElementById("map");
                            mapdiv.removeChild(myhcs);
                        }
                    }
                    haveCallSissi.length = 0;
                }
            }
            if (useprameters.rightselecttype == "map") {
                //全是粗体
                mailMenuData.length = 0;
                var imgrang_img = document.getElementById("imgrang");
                if (imgrang_img && imgrang_img.src.indexOf("ring_un") == -1) {
                    if (useprameters.lockid != 0) {
                        mailMenuData[0] = rightmenu;
                    }
                    else {
                        mailMenuData[0] = rightmenu_nolockuser;
                    }
                }
                delBaseSelect();

            } else if (useprameters.rightselecttype == "cell") {
                //全是正常
                mailMenuData.length = 0;
                mailMenuData[0] = [call, sms];
                if (Isconcernedbythisdispatcher(useprameters.rightselectid)) {
                    mailMenuData[1] = [apllication_deleteconcern];
                }
                else {
                    mailMenuData[1] = [apllication_addconcern];
                }
                useprameters.rightselecttype = null;
            } else if (useprameters.rightselecttype == "basestation") {
                mailMenuData.length = 0;
                mailMenuData[0] = basestationdata;
                useprameters.rightselecttype = null;
            } else {
                //混杂
                mailMenuData.length = 0;
            }
        }
    });
}



function openPPCPanl() {
    mycallfunction("ppcPanl", 320, 280);  //新建DIV
    var div = document.getElementById("ppcPanl");
    if (div) {
        div.style.left = "0px";

        div.style.top = "490px";
    }
}

function lq_colseOutInfo(cellID) {
    //关闭
    var obj = document.getElementById(cellID);
    if (obj) {
        removeChildSafe(obj)
    }
}
function lqmouseover(obj) { //显示警员状态
    var Policestatus = GetTextByName("Policestatus", useprameters.languagedata)
    //lq_newDrownFrame("pcstatusinfo", document.body, "", "警员状态");
    lq_newDrownFrame("pcstatusinfo", document.body, "", Policestatus);
    var randomnumber = Math.floor(Math.random() * 100000) //定义随机变量防止页面缓存
    document.getElementById("pcstatusinfo_ifr").src = "lqnew/OpePages/pc_status.aspx?ci=" + obj.ci + "&rd=" + randomnumber;
    var div = document.getElementById("pcstatusinfo");
    //document.frames["pcstatusinfo_ifr"].location.reload(true);
    div.style.width = "300px";
    div.style.height = "20px";
    div.style.display = "none";
    div.style.left = event.x;
    div.style.top = event.y;

    ShowDivPage(div);
}
function onmouseout(obj) {//隐藏警员状态
    document.getElementById("pcstatusinfo").style.display = "none";
}
function settimeini(itime) {//修改刷新时间
    //stopTiming();
    //setTiming(itime);

    //调用flex定时器
    try {
        if (isLoadLog == 'log' && isLoadMain == 'main' && isLoadSys == 'SYS') {
            intervalLoadUser = null;
            var refresh_map_interval = useprameters.refresh_map_interval * 1000;
            intervalLoadUser = window.setInterval(reloadMapInfo, refresh_map_interval);//cxy-20180802
        }
        else {
            setTimeout(function () { settimeini(itime); }, 5000);
        }
    }
    catch (e) {
        setTimeout(function () { settimeini(itime); }, 5000);
    }
}
function cgtime(itime) {//修改刷新时间
    try {
        if (intervalLoadUser) {
            clearInterval(intervalLoadUser);
            intervalLoadUser = window.setInterval(reloadMapInfo, itime);
        }
    }
    catch (e) {
        setTimeout(function () { cgtime(itime); }, 5000);
    }
}


/**打开设置窗口**/
function openoption(obj) {
    obj.style.backgroundImage = "url(Images/ToolBar/toolbar_bg1.png)";
    obj.style.backgroundRepeat = "no-repeat";
    //visiablebg();
    mycallfunction("Function/option", 600, 800, 0, 2001);
}

function retoptionbg() {
    var obj = document.getElementById("options");
    obj.style.backgroundImage = "";
}

function lq_newDrownFrame(id, father, frameSrc, headText, src, headBackUrl, closeEventName) {
    if (typeof (father) == "string") {
        father = document.getElementById(father);
    }
    if (!src) {
        src = "MyCommonJS/Source/openDiv/infowindow_close.gif";
    }
    if (!headBackUrl) {
        headBackUrl = "Images/bgbj.gif";
    }
    if (closeEventName) {
        closeEventName = "window.parent." + closeEventName + "();";
    }
    else {
        closeEventName = "";
    }
    if (!document.getElementById(id)) {
        var frame = document.createElement("iframe");
        frame.id = id + "_ifr";
        frame.src = frameSrc;
        frame.width = "100%";
        frame.height = "100%";
        frame.allowTransparency = "true";
        frame.frameBorder = "no";
        if (frame.id != "pcstatusinfo_ifr") {
            frame.style.paddingBottom = "41px";
            frame.scrolling = "no";
        }
        else {
            frame.scrolling = "no";
        }
        var div = document.createElement("div");
        div.id = id;
        div.style.position = "absolute";
        div.style.overflow = "hidden";
        div.style.display = "none";
        if (closeEventName)
        { }
        div.appendChild(frame);
        father.appendChild(div);
    }
}


function mycallfunction(calltype, width, height, lq_id, zindex, newwindows) {
    var div = document.getElementById(calltype);
    var ifr = document.getElementById(calltype + "_ifr");
    if (!newwindows) {
        var hrsrc = "lqnew/opePages/" + calltype + ".aspx?time=1";
    }
    else {
        var hrsrc = "lqnew/opePages/" + calltype + ".aspx?time=" + TimeGet();
    }
    if (!div) {
        creatprossdiv();
        checkOpen(calltype);
        if (!lq_id)
        { lqopen_newDrownFrame(calltype, document.body, hrsrc, width, height); }
        else { lqopen_newDrownFrame(calltype, document.body, hrsrc + "&id=" + lq_id, width, height); }

    }
    else {
        ifr.src = "about:blank";
        //移除iframe节点的事件
        try {
            var removeiframecont = ifr.contentWindow;
            removeevent(removeiframecont.document.body);
            removeiframecont.document.write('');
            removeiframecont.close();
            removeiframecont = null;
        }
        catch (ex) { alert(ex); }
        removeChildSafe(div);
        ifr = null;
        div = null;
    }
    var div = document.getElementById(calltype);
    if (div) { lqdivCenter(div); if (zindex) { div.style.zIndex = zindex; } }
    //以下防止页面resize，引起地图重载
    iOnResize = false;
    setTimeout(reSetiOnresize, 500);
    function reSetiOnresize() {
        iOnResize = true;
    }
}

function checkOpen(divid) {
    setTimeout(function () {
        if (!document.getElementById(divid + "_ifr")) {
            closeprossdiv();
            hiddenbg2();
        }
    }, 1000);
}
function creatprossdiv() {
    var div = document.getElementById("progressidv");
    if (div) {
        div.style.display = "block";
    }
    else {
        var div = document.createElement("progressidv");
        div.id = "progressidv";
        div.style.position = "absolute";
        div.style.cursor = "move";
        div.style.overflow = "hidden";
        div.style.width = "136px";
        div.style.height = "13px";
        div.style.display = "block";
        div.style.zIndex = 999;
        div.innerHTML = "<img src='Images/ProgressBar/05043112.gif' />";
        document.body.appendChild(div);
        lqdivCenter(div);
    }
}
function closeprossdiv() {
    var div = document.getElementById("progressidv");
    if (div) {
        div.style.display = "none";
    }
}
///修改左侧树结构点击ISSI号，出现警员信息窗口位置问题
function lqopen_newUserFrame(id, father, frameSrc, width, height, isdrag) {
    if (typeof (father) == "string") {
        father = document.getElementById(father);

    }
    if (!document.getElementById(id)) {
        var frame = document.createElement("iframe");
        frame.id = id + "_ifr";

        frame.name = (id == "ifr_callcontent") ? id : id + "_ifr";
        frame.src = frameSrc;
        frame.width = (id == "ifr_callcontent") ? width : "100%";
        frame.frameBorder = "no";
        frame.allowTransparency = "true";
        frame.scrolling = "no";
        frame.style.height = height;
        var div = document.createElement("div");
        div.id = id;
        div.style.position = "absolute";
        div.style.left = "200px";
        div.style.top = "50px";
        div.style.cursor = "move";
        div.style.overflow = "hidden";
        div.style.width = (id == "ifr_callcontent") ? "100%" : width;
        div.style.height = height;
        div.style.backgroundColor = "transparent";
        div.style.zIndex = 50;
        div.className = "opendivwindow";

        if (isdrag != false) {
            div.onmousedown = function () { mystartDragWindow(this); this.style.border = "solid 3px transparent"; cgzindex(this); };
            div.onmouseup = function () { mystopDragWindow(this); this.style.border = "0px"; };
            div.onmousemove = function () { mydragWindow(this) };
        }
        father.appendChild(div);
        div.appendChild(frame);
        cgzindex(div);
        div = null;
        frame = null;


    }
}
function windowDivOnClick(divNameEle) {
    return;//xzj--20181122--取消弹框点击下层转为上层，防止列表页面数据量少显示很短但实际高度仍较大，导致透明部分挡住新增页面，新增页面能看见却不能点击
    var backdiv = document.getElementById("mybkdiv");
    var bgDiv = document.getElementById("bgDiv");
    //alert(backdiv.style.display);
    if (backdiv.style.display == "none" && bgDiv.style.display == "none") {


        if (divNameEle) {
            if (divNameEle.style.zindex == 40) {
                return;
            }
        }

        var divs = window.document.getElementsByTagName("div");
        if (divs) {
            for (var i = 0; i < divs.length; i++) {
                if (divs[i].className == 'opendivwindow') {
                    divs[i].style.zIndex = 21;
                }
            }
        }
        if (divNameEle) {
            divNameEle.style.zIndex = 40;
        }
    }
}
function lqopen_newDrownFrame(id, father, frameSrc, width, height, isdrag) {
    if (typeof (father) == "string") {
        father = document.getElementById(father);
    }
    if (!document.getElementById(id)) {
        var frame = document.createElement("iframe");

        frame.id = id + "_ifr";
        frame.name = (id == "ifr_callcontent") ? id : id + "_ifr";
        frame.src = frameSrc;
        frame.width = width
        frame.frameBorder = "no";
        frame.allowTransparency = "true";
        frame.scrolling = "no";
        frame.height = height;
        var div = document.createElement("div");

        div.className = "opendivwindow";
        div.id = id;
        div.style.position = "absolute";
        div.style.cursor = "move";
        div.style.overflow = "hidden";
        //根据浏览器像素调整底部呼叫窗口的位置（id == "ifr_callcontent"）庞小斌修改
        div.style.width = width + "px";
        if (id == "ifr_callcontent") {
            div.style.marginBottom = 0;
            div.style.marginLeft = parseInt(document.body.offsetWidth / 2) - parseInt(width / 2);
        }
        if (id != "log_windows")
        {
            div.style.left = (parseInt(document.body.offsetWidth / 2) - parseInt(width / 2))+"px";
            div.style.top = (parseInt(document.body.offsetHeight / 2) - parseInt(height / 2)) + "px";
        }
        div.style.height = height + "px";
        div.style.backgroundColor = "transparent";
        div.style.zIndex = 50;
        //div.attachEvent("click", function () {
            //alert();
        //})
        if (isdrag != false) {
            div.onmousedown = function () { mystartDragWindow(this); this.style.border = "solid 3px transparent"; cgzindex(this); };
            div.onmouseup = function () { mystopDragWindow(this); this.style.border = "0px"; };
            div.onmousemove = function () { mydragWindow(this) };
        }
        father.appendChild(div);
        div.appendChild(frame);
        cgzindex(div);
        div = null;
        frame = null;


    }
}
//庞小斌修改，根据浏览器大小调整底部呼叫窗口的位置
function Resizeifr_callcontent() {
    var ifr_callcontent_div = document.getElementById("ifr_callcontent");
    if (ifr_callcontent_div) {
        ifr_callcontent_div.style.marginLeft = parseInt(document.body.offsetWidth / 2) - 200;
    }
    ifr_callcontent_div = null;
}

function cgzindex(obj) {
    return;//xzj--20181122--取消弹框点击下层转为上层，防止列表页面数据量少显示很短但实际高度仍较大，导致透明部分挡住新增页面，新增页面能看见却不能点击
    var mid = ["add_entity", "add_Group", "add_ISSI", "add_login", "add_TBGroup", "add_user", "addgrouplist", "edit_entity", "edit_Group", "edit_ISSI", "edit_login", "edit_TBGroup", "edit_user", "manager_entity", "manager_Group", "manager_ISSI", "manager_login", "manager_TBGroup", "manager_user", "view_info/view_group", "view_info/view_ISSI", "view_info/view_login", "view_info/view_TBgroup", "view_info/view_user", "view_info/viewpage", "volumeControl"];
    for (var i in mid) {
        if (document.getElementById(mid[i]) && document.getElementById(mid[i]) != obj) {
            if (document.getElementById(mid[i]).style.zIndex >= obj.style.zIndex) {
                obj.style.zIndex = document.getElementById(mid[i]).style.zIndex + 1;
            }

        }
    }
}
function lq_changeifr(name) {

    var ifr = document.getElementById(name + "_ifr")
    if (ifr) {
        ifr.src = "lqnew/opePages/" + name + ".aspx?time=" + TimeGet();
    }
}
function lq_changeheight(name, height) {
    var div = document.getElementById(name)
    var ifr = document.getElementById(name + "_ifr")
    if (div && ifr) { ifr.style.height = height; div.style.height = height + 6; }
}
function change(div) {
    var div = document.getElementById(div);
    if (div) {
        var i = 0;
        var initwidth = parseInt(div.style.width.split("px")[0]);
        var initheight = parseInt(div.style.height.split("px")[0]);
        div.style.width = 0 + "px";
        div.style.height = 0 + "px";

        popChange(div, i, initwidth, initheight);
    }
}
//让DIV层大小循环增大
function popChange(div, i, initwidth, initheight) {
    //(i * i * 1.5 < initwidth) ? div.style.width = i * i * 1.5 + "px" : div.style.width = initwidth + "px";
    //(i * i * 1.5 < initheight) ? div.style.height = i * i * 1.5 + "px" : div.style.height = initheight + "px";

    div.style.width = initwidth + "px";
    div.style.height = initheight + "px"
    lqdivCenter(div);
    // if (div.style.width == initwidth + "px" && div.style.height == initheight + "px") { return; }
    // else
    // { i++; var param = settimeoutparm(div, i, initwidth, initheight); setTimeout(param, 5); lqdivCenter(div); }
}
function settimeoutparm(div, i, initwidth, initheight) {
    return (function () { popChange(div, i, initwidth, initheight) });
}
function lq_outinfomation(id, txt) {
    if (useprameters.lockid == id) {
        alert(GetTextByName("PoliceLockUnHidden", useprameters.languagedata));//多语言： 锁定状态禁止隐藏
        return;
    }
    visiablebg()//显示遮罩
    mycallfunction("Function/calloutinfo", 400, 100, id + "&txt=" + txt, 2001);
}

function visiablebg() {
    var bgObj = document.getElementById("bgDiv");
    bgObj.style.width = document.body.offsetWidth + "px";
    bgObj.style.height = screen.height + "px";
    bgObj.style.display = "block";
}
function hiddenbg() {
    var bgObj = document.getElementById("bgDiv");
    bgObj.style.display = "none";
}

function visiablebg2() {
    var bgObj = document.getElementById("mybkdiv");
    bgObj.style.width = document.body.offsetWidth + "px";
    bgObj.style.height = screen.height + "px";
    bgObj.style.display = "block";
}
function hiddenbg2() {
    var bgObj = document.getElementById("mybkdiv");
    bgObj.style.display = "none";
}

function lq_closeANDremovediv(id, bgdivstring) {
    window.document.getElementById("mybkdiv").style.zIndex = 1998;
    var bgObj = document.getElementById(bgdivstring);
    var div = document.getElementById(id);
    var ifr = document.getElementById(id + "_ifr");
    if (bgObj) { bgObj.style.width = "0px"; bgObj.style.height = "0px"; bgObj.style.display = "none"; }
    if (ifr) {
        ifr.src = "about:blank";
        //庞小斌修改，移除iframe
        try {
            var iframecont = ifr.contentWindow;
            //移除iframe节点的事件
            removeevent(iframecont.document.body);
            iframecont.document.write('');
            iframecont.close();
            iframecont = null;
        }
        catch (e) { alert("lq_closeANDremovediv" + e); }
    }
    if (div) {
        removeChildSafe(div);
        div = null;
        ifr = null;
    }
}
function lq_removeimgpc(parantstring, dmostring) {
    var div = document.getElementById(parantstring);
    var childDMO = document.getElementById(dmostring);
    removeChildSafe(childDMO);
}
function lq_opennewdiv(divid, width, ifr_src, zindex, myparams, divposition) {
    creatprossdiv();
    var div = document.getElementById(divid);
    var ifr = document.getElementById(divid + "_ifr");
    var ifr_src = ifr_src + "?time=1" + myparams;
    if (!div) {
        lqopen_newDrownFrame(divid, document.body, ifr_src, width, 600, true);

    }
    else {
        ifr.src = ifr_src;
    }
    div = document.getElementById(divid);
    switch (divposition) {
        case 'TopRight':
            div.style.right = "55px";
            div.style.top = "37px";
            break;
        case 'TopLEFT':
            div.style.left = "5px";
            div.style.top = "37px";
        default:
            break;
    }

}
function lq_hiddenvml(id) { var vml = document.getElementById(id); if (vml) { delObj(vml); } }
function CreatedivORnewopen(divid, lq_id, width, heigt) {
    var div = document.getElementById(divid);
    var ifr = document.getElementById(divid + "_ifr");
    if (div && ifr) {
        ifr.src = "lqnew/opePages/" + divid + ".aspx?time=" + TimeGet() + "&id=" + lq_id;
        div.style.width = width;
        div.style.height = heigt;
    }
    else {
        lqopen_newUserFrame(divid, document.body, "lqnew/opePages/" + divid + ".aspx?time=" + TimeGet() + "&id=" + lq_id, width, heigt)
        // lqopen_newDrownFrame(divid, document.body, "lqnew/opePages/" + divid + ".aspx?time=" + TimeGet() + "&id=" + lq_id, width, heigt);
    }
}
function lq_outInfo(x, y, cellID, Send_reason) {
    var div = document.createElement("div");
    var outputly = document.getElementById("map");
    var mycellID = cellID + "_vFigure";
    var img = document.getElementById(mycellID);

    if (!img) return;
    div.id = cellID + "statusinfo";
    div.style.position = "absolute";
    div.style.textAlign = "center";
    div.style.overflow = "hidden";
    div.style.border = "1px dashed gray";
    div.style.paddingTop = "2px";
    div.style.color = "#000000";
    div.style.fontSize = "12px";
    div.style.backgroundColor = "#ffc";
    div.style.width = "120px";
    div.style.height = "20px";
    AdjustPercent = LayerControl.map.data.currentLevel / LayerControl.map.data.maxLevel;
    div.style.left = x - AdjustPercent * 40 - 25;
    div.style.top = y - AdjustPercent * 92 - 26;
    div.style.zIndex = "2";
    div.innerHTML = Send_reason;
    outputly.appendChild(div);
    L.setTimeout(lq_colseOutInfo, 2000, div.id);
}
function stockadeShow(x, y, cellID, Send_reason) {
    var div = document.createElement("div");
    var outputly = document.getElementById("map");
    var mycellID = cellID + "_vFigure";
    var img = document.getElementById(mycellID);

    if (!img) return;
    div.id = cellID + "statusinfo";
    div.style.position = "absolute";
    div.style.textAlign = "center";
    div.style.overflow = "hidden";
    div.style.border = "1px dashed gray";
    div.style.paddingTop = "2px";
    div.style.color = "red";
    div.style.fontSize = "12px";
    div.style.backgroundColor = "#ffc";
    div.style.width = "180px";
    div.style.height = "30px";
    AdjustPercent = LayerControl.map.data.currentLevel / LayerControl.map.data.maxLevel;
    div.style.left = x - AdjustPercent * 40 - 25 - 30;
    div.style.top = y - AdjustPercent * 92 - 26 - 10;
    div.style.zIndex = "2";
    div.innerHTML = Send_reason;
    outputly.appendChild(div);
    L.setTimeout(lq_colseOutInfo, 5000, div.id);
}
function lq_colseOutInfo(cellID) {
    //关闭
    var obj = document.getElementById(cellID);
    if (obj)
        removeChildSafe(obj);
}
var isSelUserFoSmsFlag = false;
var userparametersSelectid = "";
function sendMsgToSelect(obj) {


    if (isBegStackadeSel) {
        return;
    }
    if (ismyrectangleSel) {
        return;
    }
    if (!useprameters.callActivexable) {
        alert(GetTextByName("SendSMSCannotUse", useprameters.languagedata));//多语言：短信群发功能不可用
        return;
    }
    var cj = document.getElementById("imgrang");

    if (cj.src.indexOf("Images/ToolBar/rightbg/ring_un.png") > 0) {
        alert(GetTextByName("PleaseEndRang", useprameters.languagedata));//多语言：请结束当前测距状态
        return;
    }

    var choose = new Choose(_StaticObj.objGet("map"), LayerControl);
    if (isSelUserFoSmsFlag) {
        obj.style.backgroundImage = "";
        isSelUserFoSmsFlag = false;
        isBegSendMsgSel = false;
        choose.turnOff("rectangle");
        return;
    }
    //obj.src = "Images/ToolBar/toolbar_bg1.png";
    obj.style.backgroundImage = "url(Images/ToolBar/toolbar_bg1.png)";
    obj.style.backgroundRepeat = "no-repeat";
    delObj("myrectangle_choose2");
    //useprameters.Selectid = []; //清空选中警员
    //useprameters.SelectISSI = []; //清空选中ISSI
    userparametersSelectid = useprameters.Selectid;
    choose.turnOn("rectangle");
    isSelUserFoSmsFlag = true;
    isBegSendMsgSel = true;
    useprameters.vmlname = "myrectangle_choose2";
    choose.addEventListener("rectangleEnd", function (selected, range) {
        isSelUserFoSmsFlag = false;
        //SelBound = "&Bound=" + range.latLng.minLo + ',' + range.latLng.maxLo + ',' + range.latLng.minLa + ',' + range.latLng.maxLa;
        var sid = "&sid=";
        obj.style.backgroundImage = "";
        //obj.src = "Images/ToolBar/toolbar_bg1.png";
        choose.turnOff("rectangle");
        useprameters.vmlname = "";
        for (var select in selected) {

            sid += selected[select].ID + ";";
        }
        sid = sid.substring(0, sid.length - 1);
        //lq_opennewdiv('selectuser', 600, 'lqnew/opePages/select_user.aspx', 0, sid, 'TopRight');
        isBegSendMsgSel = false;
        mycallfunction('Send_SMS', 380, 325, sid);
        lq_hiddenvml('myrectangle_choose2')
        useprameters.Selectid = userparametersSelectid;
        //LayerControl.refurbish();
    });

}
var ismyrectangleSel = false;
function myrectangle(range) {//框选
    //框选不要清除选择的警员
        //useprameters.Selectid = []; //清空选中警员
        //useprameters.SelectISSI = []; //清空选中ISSI
        useprameters.HidedisplayISSI = []; //清空隐藏ISSI
        SelBound = range;
            // range.latLng.minLo + ',' + range.latLng.maxLo + ',' + range.latLng.minLa + ',' + range.latLng.maxLa;
        var sid = "";  
        useprameters.vmlname = "";

        window.document.getElementById("hidsid").value = SelBound;
        window.document.getElementById("hidisHideOfflineUser").value = useprameters.isHideOfflineUserBySelect;
        window.document.getElementById("device_timeout").value = useprameters.device_timeout;
        ismyrectangleSel = false;
        lq_opennewdiv('select_user', 650, 'lqnew/opePages/select_user.aspx', 0, "", 'TopLEFT');
        submit_selectUser.submit();
}

function movehawkeye() {
    if (jQuery("#diveageyetop").css("bottom") == "123px") {
        jQuery("#diveageyetop").animate({ bottom: -20 }, 500, function () {
            jQuery("#diveageyetop").html("<img src='lqnew/logwindow/pic/haykeye_buttonup.gif' style='cursor: hand' />").animate({ bottom: 4 }, 500);
        });
        jQuery("#diveageye").animate({ bottom: 0 }, 500);
        jQuery("#diveageyeleft,#mydivFeature").fadeOut(500);

    }
    else {
        jQuery("#diveageyetop").animate({ bottom: 123 }, 500, function () {
            jQuery("#diveageyetop").html("<img src='lqnew/logwindow/pic/haykeye_buttondown.gif' style='cursor: hand' />");
        });
        jQuery("#diveageye").animate({ bottom: 120 }, 500);
        jQuery("#diveageyeleft,#mydivFeature").fadeIn({ bottom: 0 }, 500);
    }


}
function switchZoomInTool(iszoom, obj) {
    if (isBegStackadeSel) {
        return;
    }
    if (isBegSendMsgSel) {
        return;
    }
    var cj = document.getElementById("imgrang");
    if (cj.src.indexOf("Images/ToolBar/rightbg/ring_un.png") > 0) {
        alert(GetTextByName("PleaseEndRang", useprameters.languagedata));//多语言：请结束当前测距状态
        return;
    }

    if (_StaticObj.objGet("map").data.currentLevel == 10) {
        alert(GetTextByName("MapCannotZoomIn", useprameters.languagedata));//多语言：当前地图不能再放大
        return;
    }
    ismyrectangleSel = false;
    reconverbutton(GetTextByName("ZoomIn", useprameters.languagedata));//多语言：放大
    obj.src = "Images/ToolBar/rightbg/zoomin_un.png";
    _StaticObj.objGet("ZoomInTool").switchZoom(iszoom);

}
function switchZoomOutTool(iszoom, obj) {

    if (isBegStackadeSel) {
        return;
    }
    if (isBegSendMsgSel) {
        return;
    }
    var cj = document.getElementById("imgrang");
    if (cj.src.indexOf("Images/ToolBar/rightbg/ring_un.png") > 0) {
        alert(GetTextByName("PleaseEndRang", useprameters.languagedata));//多语言：请结束当前测距状态
        return;
    }
    if (_StaticObj.objGet("map").data.currentLevel == 1) {
        alert(GetTextByName("MapCannotZoomOut", useprameters.languagedata));//多语言：当前地图不能再缩小
        return;
    }
    ismyrectangleSel = false;
    reconverbutton(GetTextByName("ZoomOut", useprameters.languagedata));//多语言：缩小
    obj.src = "Images/ToolBar/rightbg/zoomout_un.png";
    _StaticObj.objGet("ZoomOutTool").switchZoom(iszoom);
}
function openleftwindowpc(event, obj, id, urlcase) {           //打开左侧警员弹出框事件，对象，ID,页面类型
    $("#leftinfodivpc,#leftinfodivissi,#leftinfodivgroup,#leftinfodivDispatch").hide();
    $("#leftinfodivpc").show();
    $("#leftinfodivpc").attr("valueid", id);
    $("#leftinfodivpc").css("display", "block");
    $("#leftinfodivpc").css("top", event.y + $("#leftinfodivpc").height() - 5);
}
function openleftwindowissi(event, obj, id, urlcase) {           //打开左侧设备弹出框事件，对象，ID,页面类型
    $("#leftinfodivpc,#leftinfodivissi,#leftinfodivgroup,#leftinfodivDispatch").hide();
    $("#leftinfodivissi").show();
    $("#leftinfodivissi").attr("valueid", id + "&cmd=I");
    $("#leftinfodivissi").css("display", "block");
    $("#leftinfodivissi").css("top", event.y + $("#leftinfodivissi").height() - 5);
}
function openleftwindowgroup(event, obj, id, urlcase) {           //打开左侧编组弹出框事件，对象，ID,页面类型
    $("#leftinfodivpc,#leftinfodivissi,#leftinfodivgroup,#leftinfodivDispatch").hide();
    $("#leftinfodivgroup").show();
    $("#leftinfodivgroup").attr("valueid", id + "&cmd=GR");
    $("#leftinfodivgroup").css("display", "block");
    $("#leftinfodivgroup").css("top", event.y + $("#leftinfodivgroup").height() + 40);
}
function openleftwindowDispatch(event, obj, id, urlcase) {
    $("#leftinfodivpc,#leftinfodivissi,#leftinfodivgroup,#leftinfodivDispatch").hide();
    $("#leftinfodivDispatch").show();
    $("#leftinfodivDispatch").attr("valueid", id + "&cmd=D");
    $("#leftinfodivDispatch").css("display", "block");
    $("#leftinfodivDispatch").css("top", event.y + $("#leftinfodivDispatch").height() + 40);
}


function switchrighttool() {//右侧地图按钮状态切换
    if (jQuery("#too1bali2 img").css("display") != "none") {
        jQuery("#mymapnavigator").hide();
        jQuery("#too1bali5").animate({ height: 0 }, 150, function () {
            jQuery("#too1bali4").animate({ height: 0 }, 50, function () {
                jQuery("#too1bali4 img").hide();
                jQuery("#too1bali3").animate({ height: 0 }, 50, function () {
                    jQuery("#too1bali3 img").hide();
                    jQuery("#too1bali2").animate({ height: 0 }, 50, function () {
                        jQuery("#too1bali2 img").hide();
                        jQuery("#too1bali1").animate({ height: 0 }, 50, function () { jQuery("#too1bali1 img").hide(); });
                    });
                });
            });
        });
    }
    else {
        jQuery("#too1bali1").animate({ height: 45 }, 50, function () {
            var usertype = Cookies.get("usertype");
            if (usertype == 1) {
                jQuery("#too1bali1 img,#too1bali1").show();
            }
            jQuery("#too1bali2").animate({ height: 40 }, 50, function () {
                jQuery("#too1bali2 img").show();
                jQuery("#too1bali3").animate({ height: 40 }, 50, function () {
                    jQuery("#too1bali3 img").show();
                    jQuery("#too1bali4").animate({ height: 40 }, 50, function () {
                        jQuery("#too1bali4 img").show();
                        jQuery("#too1bali5").animate({ height: 155 }, 150);
                        jQuery("#mymapnavigator").show();
                    })
                });
            });
        });
    }
}

function get_usepramater() { //获取系统初始化参数配置

    var param = {
        "id": "0"
    };
    jquerygetNewData_ajax("WebGis/Service/get_useparameter.aspx", param, function (request) {
        var data = request;
        var map = _StaticObj.objGet("map");
        if (useprameters.lockid != "0" && map.data.currentLevel > 2) { //防止未锁定或者地图小于2级时刷新
            map.clearBackContainer();
        }
        if (data != null) {

            useprameters.defaultLanguage = data.defaultLanguage;
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
            useprameters.deviation_lo_Hybrid = data.deviation_lo_Hybrid;
            useprameters.deviation_la_Hybrid = data.deviation_la_Hybrid;
            useprameters.maxLevel = data.maxLevel;
            useprameters.minLevel = data.minLevel;         //最小图层
            useprameters.currentLevel = data.currentLevel;
            useprameters.maptype = data.maptype;                   //地图图片类型
            useprameters.mapsize = data.mapsize;                   //地图图片尺寸



            
            useprameters.isHideOfflineUserBySelect = data.isHideOfflineUserBySelect; //框选时是否隐藏不在线警员          
            useprameters.Illegal = GetTextByName("Illegal", useprameters.languagedata);
            useprameters.UNLogin = GetTextByName("UNLogin", useprameters.languagedata);
            useprameters.GISTYPE = data.GISTYPE;                           //地图类型PGIS/WEBGIS
            useprameters.TimeInterval = data.TimeInterval;
            useprameters.UnnormalDistance = data.UnnormalDistance;
            useprameters.PGIS_deviation_lo = data.PGIS_deviation_lo;        //PGIS偏差经度
            useprameters.PGIS_deviation_la = data.PGIS_deviation_la;        //PGIS偏差纬度
            useprameters.PGIS_API = data.PGIS_API;      //PGIS普通地图路径
            useprameters.PGIS_Center_lo = data.PGIS_Center_lo;                     //PGIS中心点经度
            useprameters.PGIS_Center_la = data.PGIS_Center_la;                      //PGIS中心点纬度
            useprameters.PGIS_Normal_index = data.PGIS_Normal_index;                 //PGIS地图索引
            useprameters.PGIS_HYBRID_index = data.PGIS_HYBRID_index;                 //PGIS地图索引
            useprameters.BaseStationLayer = data.BaseStationLayer;                //聚合点范围的直径
            useprameters.voiceType = parseInt(data.voiceType);                    //语音类型

            useprameters.PrivateCallEnable = data.PrivateCallEnable;                                 //私密呼叫是否启用
            useprameters.GPSEnable =data.GPSEnable;                                         //是否查看警员位置
            useprameters.GroupCallEnable = data.GroupCallEnable;                                  //小组呼叫是否启用
            useprameters.BaseStationCallEnable = data.BaseStationCallEnable;                            //基站呼叫是否启用  
            useprameters.YQYBEnable = data.YQYBEnable;                                       //遥启遥毙是否启用  
            useprameters.PJCallEnable = data.PJCallEnable;                                     //派接组是否启用  
            useprameters.DXCallEnable = data.DXCallEnable;                                     //多选组是否启用 
            useprameters.CloseMonitoringEnable = data.CloseMonitoringEnable;                            //慎密监听是否启用 
            useprameters.EnvironmentalMonitoringEnable = data.EnvironmentalMonitoringEnable;                     //环境监听是否启用 
            useprameters.EmergencyCallEnable = data.EmergencyCallEnable;                               //紧急是否启用 
            useprameters.GPS_ControlEnable = data.GPS_ControlEnable;                                 //GPS控制是否启用 
            useprameters.DTCZEnable = data.DTCZEnable;                                         //动态重组是否启用 
            useprameters.volumeControlEnable = data.volumeControlEnable;                                //音量控制是否启用 
            useprameters.SMSEnable = data.SMSEnable;                                          //短消息是否启用
            useprameters.GroupSMSEnable = data.GroupSMSEnable;                                     //组短消息是否启用
            useprameters.Status_messageEnable = data.Status_messageEnable;                               //状态消息是否启用 
            useprameters.HistoricalTraceEnable = data.HistoricalTraceEnable;                               //历史轨迹是否启用 
            useprameters.RealTimeTraceEnable = data.RealTimeTraceEnable;                                 //实时轨迹是否启用 
            useprameters.lockingFunctionEnable = data.lockingFunctionEnable;                               //锁定功能是否启用 
            useprameters.StackEnable = data.StackEnable;                                         //电子栅栏是否启用 
            useprameters.DisplayEnable = data.DisplayEnable;                                       //显示开启功能是否启用 
            useprameters.PullUp_ControlEnable = data.PullUp_ControlEnable;                                //周期性上拉是否启用 
            useprameters.GZEnable = data.GZEnable;                                            //关注是否启用
            useprameters.CallOCXEnable = data.CallOCXEnable;                                       //控件是否启用
            useprameters.CXBKEnable = data.CXBKEnable;                                          //查询布控是否启用
            useprameters.CKBKKilometres = data.CKBKKilometres;                              //布控公里数
            useprameters.GroupShortKey = data.GroupShortKey;                                //组快捷键
            useprameters.entityinformation = data.entityinformation;                        //读取entityinformation
            useprameters.LoginRole = data.LoginRole;                                        //权限角色
            useprameters.DSSEnable = data.DSSEnable             ;                           //辅助决策
            useprameters.VideoCommandEnable = data.VideoCommandEnable;                      //可视指挥
            useprameters.Bubble_information = data.Bubble_information;                      //头部气泡
            useprameters.FSHeatMapEnable = data.FSHeatMapEnable;                            //查看历史场强


            useprameters.OriginLo = data.OriginLo;                   //原点坐标
            useprameters.OriginLa = data.OriginLa;                    //原点坐标


            if (useprameters.GPS_ControlEnable == 0) { $("#gpslist").parent().remove(); }  //菜单栏GPS控制菜单项
            if (useprameters.SMSEnable == 0 || useprameters.GroupSMSEnable == 0) { $("#sms_sjx").parent().remove(); }//菜单栏短信
            if (useprameters.DTCZEnable == 0) { $("#dtczrestlt").parent().remove(); } //菜单栏动态重组
      

            //警员头部显示字段
            useprameters.userHeadInfo = data.userHeadInfo;
            //警员状态消息
            useprameters.userHeadInfo_StatuesMode = data.headerInfo_status_mode;
            //警员头部显示字段开关
            useprameters.IsOpenUserHeaderInfo = data.IsOpenUserHeaderInfo;

            //cxy-20180730-基站图层参数，包括基站图层是否聚合、聚合距离、聚合半径
            useprameters.IsBaseStationLayerCluster = data.IsBaseStationLayerCluster;
            useprameters.BaseStationClusterDistance = data.BaseStationClusterDistance;
            useprameters.BaseStationClusterRaduis = data.BaseStationClusterRaduis;

            //cxy-20180810-场强参数
            useprameters.FieldStrength = data.FieldStrength;
            //xzj-20180822-摄像头图层参数，包括摄像头图层是否聚合、聚合距离、聚合半径
            useprameters.IsCameraLayerCluster = data.IsCameraLayerCluster;
            useprameters.CameraClusterDistance = data.CameraClusterDistance;
            useprameters.CameraClusterRaduis = data.CameraClusterRaduis;
            //xzj--20190320--添加呼叫加密参数
            useprameters.CallEncryption = data.CallEncryption;
            //xzj--20180823--根据账号类型是否显示右侧工具栏和地图切换
            if (Cookies.get("usertype")!=null) {
                if (Cookies.get("usertype")==1) {
                    $("#weixinpingmian").show();
                    $("#rightToolbar").show();
                }
            }

            var usertype = Cookies.get("usertype");
            //loadmapswf(); //加载map Flash
            try {

                if (usertype == 1) {
                   
                    //打开上行操作窗口
                    if (window.document.getElementById("mypancallContent")) {
                        if (window.parent.useprameters.PrivateCallEnable == 1 && window.parent.useprameters.GroupCallEnable == 1) {
                            $("#mypancallContent").attr("src", "lqnew/opePages/ppcPanl.aspx");
                        } else {
                            $("#UpCallPanl").remove();
                        }
                        //window.document.getElementById("mypancallContent").src = "lqnew/opePages/ppcPanl.aspx";
                    }
                  // inigrouplists();
                  // inidispatchlists();

                    lqopen_newDrownFrame("log_windows", document.body, "lqnew/logwindow/mian.aspx", 315, 120, false); //打开日志窗口
                    //  lqopen_newDrownFrame("ifr_callcontent", document.body, "lqnew/callwindow/miancall.aspx", 399, 92, false); //打开日志窗口

                    //RenderToLeftMen()//给主页警员右键菜单渲染
                }
                else {
                    window.document.getElementById("UpCallPanl").style.display = "none";
                    var p = window.document.createElement("div");
                    p.id = "ifr_callcontent";
                }
                SetDefaultLang();         //设置主页面的多语言标签   
                Menu_qwglDisplay();       //开启或关闭“勤务管理菜单”
              
                Menu_pullupDisplay()        //开启或关闭GPS上拉
                window.document.getElementById("policelists").src = "lqnew/opePages/policelists.aspx";
                window.document.getElementById("cameralists").src = "lqnew/opePages/cameralists.aspx";

                strSuccess = GetTextByName("Success", useprameters.languagedata);
                strFailed = GetTextByName("Failed", useprameters.languagedata);
                strSingle_Open = GetTextByName("Single_Open", useprameters.languagedata);
                strClosebtn = GetTextByName("Closebtn", useprameters.languagedata);
                strGPSOpen = GetTextByName("Lang_GPSEnableOrDisable", useprameters.languagedata);
                strGPSParam = GetTextByName("Lang_GPSParamReuqest", useprameters.languagedata);
                SMSMy = GetTextByName("SMS", useprameters.languagedata);
                myLang_please_input_shortMessage = GetTextByName("Statusmessage", useprameters.languagedata);
                myReceipt = GetTextByName("Receipt", useprameters.languagedata);
                Lang_GPS_Param_ContralFaild = GetTextByName("Lang_GPS_Param_ContralFaild", useprameters.languagedata);
                Lang_GPS_Open_ContralFaild = GetTextByName("Lang_GPS_Open_ContralFaild", useprameters.languagedata);
                Lang_GPS_Mode_ContralFaild = GetTextByName("Lang_GPS_Mode_ContralFaild", useprameters.languagedata);
                strGPSMode = GetTextByName("Lang_GPS_Mode_Modify", useprameters.languagedata);
                strPullUpWGSuccess = GetTextByName("Active_Gateway_response_success", useprameters.languagedata);  //激活网关响应成功
                strPullUpSuccess = GetTextByName("Active_Terminal_response_success", useprameters.languagedata);   //激活终端响应成功
                strPullUpFail = GetTextByName("Active_Fail_to_active", useprameters.languagedata);   //激活响应失败
                strUnPullUpFail = GetTextByName("Unactive_response_fail", useprameters.languagedata);   //去激活响应失败
                strUnPullUpSuccess = GetTextByName("Unactive_response_success", useprameters.languagedata);   //去激活响应成功
                strPullUpOutTime = GetTextByName("Active_Terminal_response_timeout", useprameters.languagedata);   //激活终端响应超时
                strUnPullUpOutTime = GetTextByName("Unactive_Gateway_response_timeout", useprameters.languagedata);    //去激活网关响应超时
                Lang_PullUp_ContralFaild = window.parent.parent.GetTextByName("Lang_PullUp_Control_Fail", window.parent.parent.useprameters.languagedata);
                strDistance = GetTextByName("Lang_GPS_Distance_Modify", useprameters.languagedata);

                 //添加标签文字20180903
                 $("#Userlefttree").text(GetTextByName("use"));//用户
                 $("#Monitorlefttree").text(GetTextByName("Lang_monitor"));//监控
                 $("#concernlists").text(GetTextByName("concernlists"));//关注列表
                 $("#searchPolice").text(GetTextByName("searchPolice"));//查找警员
                 $("#GroupCallA").text(GetTextByName("GroupCall"));//组呼
                 $("#fabuchaxunbukong").text(GetTextByName("fabuchaxunbukong"));//发布查询布控
                 $("#Lang_DTCZ").text(GetTextByName("Lang_DTCZ"));//动态重组
                 $("#Lang_searchlockuser").text(GetTextByName("Lang_searchlockuser")); //搜索锁定警员
                 $("#RealTimeTraceList").text(GetTextByName("RealTimeTraceList"));//实时轨迹列表
                 $("#Ssinglecall").text(GetTextByName("Lang_TellMode"));//电话模式
                 $("#Spptcall").text(GetTextByName("Lang_PTTMode"));//对讲模式
                 $("#showFSMap").text(GetTextByName("FSHeatMap"));//查看场强热力图
                 if (useprameters.defaultLanguage == "en-US") {//修改英文版的右键菜单样式--xzj--20181122
                    $("#contextmenu_container2").attr("class", "en_normal_menu");
                    $("#contextmenu_container").attr("class", "en_contextmenu");
                }
                 //xzj--20181130--中英文
                 $("#pingmian").text(GetTextByName("controlPlaneMap"));//平面              
                 $("#weixin").text(GetTextByName("controlSatellitemap"));//卫星
                 $("#lblControlBS").text(GetTextByName("Station"));//基站
                 $("#lblControlUnit").text(GetTextByName("Unit"));//单位
                 $("#lblControlUser").text(GetTextByName("use"));//用户
                 $("#lblControlCamrea").text(GetTextByName("Lang_monitor"));//监控
                 if (useprameters.defaultLanguage == "en-US") {//修改英文版的平面卫星切换按钮样式--xzj--20181130
                     $("#pingmian").css({
                         "font-size": "10px",
                         "margin-top": "5px",
                         "margin-left": "20px"
                     });
                     $("#weixin").css({
                         "font-size": "10px",
                         "margin-top": "5px",
                         "margin-left": "7px"
                     });
                     $("#layershowimg").css({
                         "margin-right": "5px"
                     });
                     $("#liControlUnit").css({
                         "margin-left": "20px"
                     });
                     $("#cameraManageLi").css({
                         "margin-left": "10px"
                     })
                 }
                
            }
            catch (ex) {
                alert("language xml err" + ex);
            }
            var div1 = document.getElementById("Div1");
            div1.innerHTML = " [" + useprameters.usename + "]&nbsp;&nbsp;&nbsp;&nbsp;";//Title_Welcome 多语言：欢迎您
            if (usertype == 1 && useprameters.CallOCXEnable == 1) {
                setTimeout(regX, 3000); //用来注册

            } else {
                //document.getElementById("regDiv").style.display = "none";
            }
            var myDate = new Date();
            var myHours = myDate.getHours();
            if (myHours < 10) {
                myHours = "0" + myHours;
            }

            var myMin = myDate.getMinutes();
            if (myMin < 10) {
                myMin = "0" + myMin;
            }

            //useprameters.logintime = myDate.getFullYear() + GetTextByName("Title_Year", useprameters.languagedata) + (parseInt(myDate.getMonth()) + 1) + GetTextByName("Title_Month", useprameters.languagedata) + myDate.getDate() + GetTextByName("Title_Day", useprameters.languagedata) + myHours + ":" + myMin;//多语言:年；月；日
            useprameters.logintime = myDate.getFullYear() + "-" + (parseInt(myDate.getMonth()) + 1) + "-" + myDate.getDate() + " " + myHours + ":" + myMin;//多语言:年；月；日

            useprameters.GPSUpdatetime = useprameters.logintime;            
            if (usertype == 1) {
                setdevice_timeout_flex(useprameters.device_timeout);
                sethide_timeout_device_flex(useprameters.hide_timeout_device);
                setuserHeadInfo_flex(useprameters.userHeadInfo);
                setuserHeadInfo_mode_flex(useprameters.userHeadInfo_StatuesMode);
                var refreshtime = document.getElementById("refreshtime");
                refreshtime.value = useprameters.refresh_map_interval;
                if (!isNaN(parseInt(useprameters.refresh_map_interval))) {
                    settimeini(useprameters.refresh_map_interval * 1000);
                }
            }
            //if (useprameters.lo != "" && useprameters.la != "" && LayerControl.iGetData && useprameters.la != "0" && useprameters.lo != "0") {
            //    useprameters.lockpcmove = true;

            //    map.moveTo({ "lo": useprameters.lo, "la": useprameters.la }, undefined, undefined, undefined, true);

            //    map.data.currentLevel = map.data.currentLevel;
            //    setTimeout(function () { useprameters.lockpcmove = false; }, 1000);
            //    return;

            //}
            //if (useprameters.last_lo != "" && useprameters.last_lo != "" && useprameters.la != "0" && useprameters.lo != "0") {

            //    map.moveTo({ "lo": useprameters.last_lo, "la": useprameters.last_la }, undefined, undefined, undefined, true);

            //}

        
            setTimeout(function () { isPoliceInfoShow((data.displayinfo == "True")) }, 2000);
            //登录之后判断是否有锁定
            if (data.lo != "" && data.la != "" && data.lo != "0" && data.la != "0" && data.lockid != 0) {       
                lock_it(data.lockid);
            }
            else{
                useprameters.lockid = 0;
            }
            //useprameters.lockid = (data.lo != "" && data.la != "" && data.lo != "0" && data.la != "0") ? data.lockid : 0;             //锁定警员
            LoadMap();
        }

    }, false, false);
    
}
//开启或关闭“勤务管理菜单”
function Menu_qwglDisplay() {
    var usertype = Cookies.get("usertype");
    if (usertype == 1 && useprameters.DSSEnable == "1") {
        window.parent.document.getElementById("Menu_qwgl").style.display = "block";
    } else if (usertype == 1 && useprameters.LoginRole == "0") {
        window.parent.document.getElementById("Menu_qwgl").style.display = "block";
    }
    else {
        window.parent.document.getElementById("Menu_qwgl").style.display = "none";;
    }
}

//2018.1.8虞晨超开启或关闭GPS上拉
function Menu_pullupDisplay() {
    if (document.getElementById("GPSPullList") && useprameters.PullUp_ControlEnable == "0") {
        document.getElementById("GPSPullList").parentNode.style.display = "none";
    }
}

function loadmapswf() {

    var swfVersionStr = "11.1.0";

    var xiSwfUrlStr = "playerProductInstall.swf";
    var flashvars = {};
    var params = {};
    params.wmode = "transparent";
    params.quality = "high";
    params.bgcolor = "#ffffff";
    params.allowscriptaccess = "always";
    params.allowfullscreen = "true";
    var attributes = {};
    attributes.id = "main";
    attributes.name = "main";
    attributes.align = "middle";
    var url = "SWF/main.swf";


    swfobject.embedSWF(
            url, "flashContent",
            "100%", "100%",
            swfVersionStr, xiSwfUrlStr,
            flashvars, params, attributes);
    swfobject.createCSS("#flashContent", "display:block;text-align:left;");
}

function updateuseprameter() {
    var param = {
        "id": "0"
    };
    jquerygetNewData_ajax("WebGis/Service/get_useparameter.aspx", param, function (request) {
        var data = request;
        if (data != null) {
            useprameters.device_timeout = data.device_timeout;               //终端超时时间
            useprameters.hide_timeout_device = data.hide_timeout_device;     //不显示超时终端
            useprameters.refresh_map_interval = data.refresh_map_interval;
            useprameters.usename = data.usename;
            useprameters.useentity = data.entity;

            setdevice_timeout_flex(useprameters.device_timeout);
            sethide_timeout_device_flex(useprameters.hide_timeout_device);
        }
    }, false, false);
}

function movelockpc() { //获取系统初始化参数配置
    var map = _StaticObj.objGet("map");

    if (map.data.currentLevel <= 2)
        return;
    var param = {
        "id": "0"
    };
    jquerygetNewData_ajax("WebGis/Service/get_useparameter.aspx", param, function (request) {
        var data = request;

        if (data != null) {
            useprameters.lockid = (data.lo != "" && data.la != "" && data.lo != "0" && data.la != "0") ? data.lockid : 0;             //锁定警员
            useprameters.lo = data.lo;
            useprameters.la = data.la;
            //杨德军修改：当经纬度超出地图范围时 不移动
            if (useprameters.lo > map.mapRangs().minlo && useprameters.lo < map.mapRangs().maxlo && useprameters.la > map.mapRangs().minla && useprameters.la < map.mapRangs().maxla) {
            } else {
                if (useprameters.lo != "" && useprameters.la != "") {
                    writeLog("system", GetTextByName("Log_YouLockISSI", useprameters.languagedata) + "[" + data.ISSI + "]" + GetTextByName("Log_OutOfMap", useprameters.languagedata) + "[" + LOGTimeGet() + "]");//多语言：你锁定的终端;在地图范围外，等你解除该终端后才能拖动地图
                    return;
                }
            }

            if (useprameters.lockid != "0" && map.data.currentLevel > 2) { //防止未锁定或者地图小于2级时刷新
                map.clearBackContainer();
            }

            if (isNaN(data.refresh_map_interval)) {
                cgtime(data.refresh_map_interval * 1000);
            }
            else {
                cgtime(5000);
            }
            isPoliceInfoShow((data.displayinfo == "True"));
            if (useprameters.lo != "" && useprameters.la != "" && LayerControl.iGetData && useprameters.la != "0" && useprameters.lo != "0") {

                useprameters.lockpcmove = true;
                map.moveTo({ "lo": useprameters.lo, "la": useprameters.la }, undefined, undefined, undefined, true);
                map.data.currentLevel = map.data.currentLevel;
                setTimeout(function () { useprameters.lockpcmove = false; }, 1000);

                return;

            }


        }

    }, false, false);
}


//获取用户初始化参数
function set_uselockid(id) {
    var param = {
        "id": id
    };
    jquerygetNewData_ajax("WebGis/Service/uselockid.aspx", param, function (request) {
        var data = request;

    }, false, false);
} //获取用户初始化参数
function changvisable(id) {
    if (useprameters.lockid == id) {
        alert(GetTextByName("PoliceLockUnHidden", useprameters.languagedata)); return;//多语言：锁定状态禁止隐藏
    }
    theIntervalFun.policePositionRefresh()
}
function reloadtree() {
    //    var trees = ["usetree", "issitree", "grouptree", "dispatchtree"];
    //    for (var h = 0; h < trees.length; h++)
    //    {
    //     document.frames["mian_ifr"].document.frames["miantree"].document.frames[trees[h]].document.location.reload(true);

    //    }
    //document.frames["mian_ifr"].document.frames["usetree"].src = "../opePages/use_tree.aspx?time=" + TimeGet;
    //    var trees = ["use_tree", "issi_tree", "group_tree", "dispatch_tree"];
    //        for (var h = 0; h < trees.length; h++) {
    //            document.frames["mian_ifr"].document.frames["miantree"].document.getElementById(trees[h]).src = null;
    //            document.frames["mian_ifr"].document.frames["miantree"].document.getElementById(trees[h]).src = "../opePages/" + trees[h] + ".aspx?time=" + TimeGet();
    //        }
    return;

}
function updatecallgroup() {
    var callcontent = document.frames["ifr_callcontent"];
    if (callcontent) {
        callcontent.GetGrouparray();
    }
}
function changevis(type, issi) {
    if (type == "hidden") {
        writeLog("oper", "[" + GetTextByName("DeviceDisplay", useprameters.languagedata) + "]:" + GetTextByName("Hidden", useprameters.languagedata) + "ISSI(" + issi + ")" + GetTextByName("Single_S", useprameters.languagedata) + GetTextByName("Terminal", useprameters.languagedata) + "[" + LOGTimeGet() + "]");         /**日志：操作日志 终端显示；隐藏；的；终端**/
    }
    else {
        writeLog("oper", "[" + GetTextByName("DeviceDisplay", useprameters.languagedata) + "]:" + GetTextByName("OpenDisplay", useprameters.languagedata) + "ISSI(" + issi + ")" + GetTextByName("Single_S", useprameters.languagedata) + GetTextByName("Terminal", useprameters.languagedata) + "[" + LOGTimeGet() + "]");         /**日志：操作日志 多语言：终端显示；开启显示；的；终端**/
    }
}
function deviceuse(id, issi) {
    writeLog("oper", "[" + GetTextByName("DeviceUse", useprameters.languagedata) + "]:" + GetTextByName("usename", useprameters.languagedata) + "(" + id + ")" + GetTextByName("UseISSIIs", useprameters.languagedata) + "(" + issi + ")" + "[" + LOGTimeGet() + "]");         /**日志：操作日志 终端使用；将；用户名 **/
}

function openRealTimeTraceUserList() {
    if (window.document.getElementById("realTimeTraceUserList")) {
        var ifr = document.getElementById("realTimeTraceUserList_ifr");
        ifr.src = "lqnew/opePages/realTimeTraceUserList.aspx?time=" + TimeGet();
        var realTraceList_div = window.document.getElementById("realTimeTraceUserList");
        if (realTraceList_div) {
            realTraceList_div.style.display = "block";
        }
    } else {
        var realUserString = "";
        //if (realTimeTraceUserArrary.length > 0) {
        //    for (var i = 0; i < realTimeTraceUserArrary.length; i++) {
        //        if (i != realTimeTraceUserArrary.length - 1) {
        //            realUserString += realTimeTraceUserArrary[i] + ":";
        //        } else realUserString += realTimeTraceUserArrary[i];
        //    }
        //}
        if (useprameters.realtimeTraceUserIds.length > 0) {
            for (var i = 0; i < useprameters.realtimeTraceUserIds.length; i++) {
                if (i != useprameters.realtimeTraceUserIds.length - 1) {
                    realUserString += useprameters.realtimeTraceUserIds[i] + ":";
                } else realUserString += useprameters.realtimeTraceUserIds[i];
            }
        }
    }
    mycallfunction('realTimeTraceUserList', 600, 480, "&userId=" + realUserString, 1999);
}

function openconcernlist() {
    if (window.document.getElementById("concernlist")) {
        var ifr = document.getElementById("concernlist_ifr");
        ifr.src = "lqnew/opePages/concernlist.aspx?time=" + TimeGet();
        displayconcernlistdiv();
    } else {
        mycallfunction('concernlist', 600, 450);
    }
}
function Addusertoconcernlist(id, source) {
    var concernids = useprameters.concernusers_string + ";" + id;
    execupdateconcernids("add", concernids, id, source);
}
function Deleteuserfromconcernlist(id, source) {
    var concernids = removeidfromconcernids(id);
    execupdateconcernids("del", concernids, id, source);
}
function execupdateconcernids(type, ids, id, source) {
    jquerygetNewData_ajax_post("lqnew/opePages/concernids_add.aspx", { concernids: ids }, function (msg) {
        try {
            if (msg.msg.toString() == "True") {
                var ifr = document.getElementById("concernlist_ifr");
                ifr.src = "lqnew/opePages/concernlist.aspx?time=" + TimeGet();
                if (type == "del") {
                    //deleteconcernpic(id);             
                    removeConcernUsersFlag(id);
                }
                else if (type == "add") {
                    addConcernUsersFlag(id,0);
                }
            }
            else {
                var operatefail = GetTextByName("operateconcernfail", useprameters.languagedata);
                alert(operatefail);
            }
        }
        catch (e) {
            alert("execupdateconcernids" + e);
        }
    });
}
function removeidfromconcernids(id) {
    var tempstring = "";
    var concernusers_array = useprameters.concernusers_array;
    if (concernusers_array.length != 0) {
        for (var i = 0; i < concernusers_array.length; i++) {
            if (concernusers_array[i] != id && concernusers_array[i] != "") {
                tempstring += concernusers_array[i] + ";";
            }
        }
        tempstring = tempstring.substring(0, tempstring.lastIndexOf(';'));
        return tempstring;
    }
    else {

    }
}
function Isconcernedbythisdispatcher(id) {
    var concernusers_array = useprameters.concernusers_array;
    var concernids_length = concernusers_array.length;
    if (concernids_length != 0) {
        for (var i = 0; i < concernids_length; i++) {
            if (concernusers_array[i] == id) {
                return true;
            }
        }
        return false;
    }
    else {
        return false;
    }
}
function deleteconcernpic(id) {
    var li = document.getElementById("bztp_concern_" + id);
    if (li) {
        removeChildSafe(li);
    }
}
function hideMenubar() {
    //window.parent.document.getElementById("mouseMenu").style.display = "none";
}
function setSelectUserVar(selectIdArray, selectISSIArray) {
    useprameters.Selectid = selectIdArray;
    useprameters.SelectISSI = selectISSIArray;
}
function delSelectUserVar(userId, userIssi) {
    for (var i = 0; i < useprameters.Selectid.length; i++) {
        if (useprameters.Selectid[i] == userId)
            useprameters.Selectid.splice(i, 1);
    }
    for (var j = 0; j < useprameters.SelectISSI.length; j++) {
        if (useprameters.SelectISSI[j] == userIssi)
            useprameters.SelectISSI.splice(j, 1);
    }
}
function LayerCellLocation(param) {
    try{
        var par = param.split('|');
        var lo = par[2];
        var la = par[3];
        var id = par[1];
        var ISSI = par[5];
        var isSuccess = false;
        var mainSWF = document.getElementById("main");    
        if (mainSWF) {
            isSuccess = mainSWF.callbackLocatePerUser(id,ISSI,parseFloat( lo),parseFloat(la));
            
        }
        return isSuccess;
    }
    catch (e) {
        alert("LayerCellLocation" + e);
    }
}
LayerControl_clearsign = null;  //定时删除定位后图标
function SetSourceCell(ISSI) {
    try{
        var mainSWF = document.getElementById("main");
        if (mainSWF) {
            mainSWF.callbackAddPerUserFlag(ISSI);
        }
    }
    catch(e){
        alert("SetSourceCell" + e);
    }
}
function ClearSourceCell(ISSI) {
    try{
    var mainSWF = document.getElementById("main");
    if (mainSWF) {
        mainSWF.callbackRemovePerUserFlag(ISSI);
    }
    }
    catch (e) {
        alert("ClearSourceCell" + e);
    }
}
function addCallStateImgISSI(ISSI, type, drict) {//添加警员上行呼叫图标
    var mainSWF = document.getElementById("main");
    if (mainSWF) {
    switch (type) {
        case "10": //上行组呼
            
                mainSWF.AddUPCallImgtt(ISSI, "groupcall","");
            
            //imgsrc = "lqnew/images/groupcall.png";
            
            break;
        case "01": //上行全双工单呼 多语言：上行
            if (drict == GetTextByName("UpCall", useprameters.languagedata)) {
                mainSWF.AddUPCallImgtt(ISSI, "singleCall_all", "up");
                
            }
            else {
                mainSWF.AddUPCallImgtt(ISSI, "singleCall_all", "down");
            }
            mainSWF.callbackAddSingleCallVarByISSI(ISSI, "singleCall_all");
            //imgsrc = (drict == GetTextByName("UpCall", useprameters.languagedata)) ? "lqnew/images/singlecall_all.png" : "lqnew/images/singlecall_all_down.png";
            
            break;
        case "00": //上行半双工单呼 多语言：上行
            if (drict == GetTextByName("UpCall", useprameters.languagedata)) {
                mainSWF.AddUPCallImgtt(ISSI, "singleCall_half", "up");
            }
            else {
                mainSWF.AddUPCallImgtt(ISSI, "singleCall_half", "down");
            }
            mainSWF.callbackAddSingleCallVarByISSI(ISSI, "singleCall_half");
            //imgsrc = (drict == GetTextByName("UpCall", useprameters.languagedata)) ? "lqnew/images/singlecall_half.png" : "lqnew/images/singlecall_half_down.png";
            
            break;
    }
    }
}
function removeCallStateImgISSI(ISSI) {//移除警员呼叫图标
    var mainSWF = document.getElementById("main");
    if (mainSWF) {
        mainSWF.callbackRemoveCallImg(ISSI);
        mainSWF.callbackRemoveSingleCallVarByISSI(ISSI);
    }
}
//启用呼叫栏
function ChangeCallbannerEnable() {
    try {
        //var mainSWF = document.getElementById("main");
        //if (mainSWF) {
        //    mainSWF.callbackChangeCallbannerEnable(isEnable);
        //}
        //else {
        //    setTimeout(function () { ChangeCallbannerEnable(isEnable); }, 2000);
        //}
        if (document.getElementById("NoCall")) {
            document.getElementById("NoCall").style.display = "none";
            showEnabledCallPanleImg();//显示可用的图标
            initWaterRipple();//加载水纹效果
        }
    }
    catch (e) {
        //setTimeout(function () { ChangeCallbannerEnable(isEnable); }, 2000);
    }
}
function lock_it(id) {
    var param = { "id": id };
    jquerygetNewData_ajax("WebGis/Service/getlola_byID.aspx", param, function (request) {
        
        if (request) {
            var lo = request.lo;
            var la = request.la;

            if (lo == 0 || la == 0) {
                alert(GetTextByName("Lang_latitude_and_longitude_null_could_not_be_locked", useprameters.languagedata));//多语言：经纬度为(0,0)请检查终端状态
            }
            else {
                lockuser(id);
            }
        }
    });

}
function lockuser(id) {
    if (useprameters.lockid != 0 && useprameters.lockid == id) {
        //调用flex函数去除锁定图标
        removeLockUsersFlag();
        //addorDelLockPicFlex(id, "unlock");
        checklockallpages();
        set_uselockid(useprameters.lockid); //在服务器上存入，ID
        return;
    }
    jquerygetNewData_ajax("Handlers/CannotLockUser.ashx", { id: id }, function (msg) {

        if (msg.result == "True") {//登陆用户已将选中用户隐藏，不能锁定。
            alert(GetTextByName("Alert_UseIsHideNotLockOrUnLock", useprameters.languagedata));//多语言:改移动用户已被隐藏，不能锁定与解锁操作
            return;
        }
         if (msg.value == 0 && useprameters.hide_timeout_device=="True") {//参数设置中，已选择“隐藏不在线用户”，且被选中的用户不在线，说明此用户不显示在地图上，不能被锁定。
             alert(GetTextByName("Alert_UseIsOfflineAndNotShownCannotLock", useprameters.languagedata));
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
            //调用flex函数去除锁定图标
            removeLockUsersFlag();
            //addorDelLockPicFlex(id, "unlock");
        }
        else {
            writeLog("oper", "[" + GetTextByName("Log_traceMode", useprameters.languagedata) + "]:" + GetTextByName("Single_Open", useprameters.languagedata) + GetTextByName("use", useprameters.languagedata) + "ID(" + id + ")" + GetTextByName("Single_S", useprameters.languagedata) + GetTextByName("Log_traceMode", useprameters.languagedata) + "[" + LOGTimeGet() + "]");         /**日志:操作日志 多语言:跟踪模式；开启；用户;的；跟踪模式 **/
            //调用flex函数添加锁定图标
            addLockUserFlag(id);
            //addorDelLockPicFlex(id, "lock");
        };
        checklockallpages();


        set_uselockid(useprameters.lockid); //在服务器上存入，ID

    });
}
function addorDelLockPicFlex(id,lockorunlock) {
    jquerygetNewData_ajax("WebGis/Service/getISSIById.aspx", { id: id }, function (msg) {
        var ISSI = msg;

        lockUserFlex(id, ISSI, lockorunlock);
    });
}

//获取类型路径
function getTypePictureLoadPath()
{
    return;
    var param = {
        "id": "0"
    };
    jquerygetNewData_ajax("WebGis/Service/getTypePictureLoadPath.aspx", param, function (request) {
        useprameters.typeset = eval(request);
      
    });   
}


function lockUserFlex(id,ISSI,lockorunlock){
    try {
            var mainSWF = document.getElementById("main");
    if (mainSWF) {
        mainSWF.callbackLockOrUnlockuser(id, ISSI, lockorunlock);
    }
    else {
        setTimeout(function () { lockUserFlex(id,ISSI,lockorunlock); }, 1000);
    }
}
        catch (e) {
            setTimeout(function () { lockUserFlex(id,ISSI,lockorunlock); }, 1000);
        }
}
function setLockUservarFromFlex(id) {
    useprameters.lockid = id;
}
function getCookieByName(id)
{
    var cookieValue = "";
    cookieValue = Cookies.get("id");
    return cookieValue;
}
function searchPoliceByMapRightMenu() {
    displaypolicelistsdiv();
    var policelistifr = document.frames["policelists"];
    if (policelistifr) {
        policelistifr.document.getElementById("search").style.display = "block";
        policelistifr.document.getElementById("searchtextinput").value = "";
    }
}



function setdevice_timeout_flex(time) {
    try {
        var mainSWF = document.getElementById("main");
        if (mainSWF) {
            mainSWF.callbackSetdevice_timeout(time);
        }
        else {
            setTimeout(function () { setdevice_timeout_flex(time); }, 1000);
        }
    }
    catch (e) {
        setTimeout(function () { setdevice_timeout_flex(time); }, 1000);
    }
}
function sethide_timeout_device_flex(isHide) {
    try {
        var mainSWF = document.getElementById("main");
        if (mainSWF) {
            var hide = false;
            if (isHide == "False") {
                hide = false;
            }
            else if (isHide == "True") {
                hide = true;
            }
            mainSWF.callbackSetHide_timeout_device(hide);
        }
        else {
            setTimeout(function () { sethide_timeout_device_flex(isHide); }, 1000);
        }
    }
    catch (e) {
        setTimeout(function () { sethide_timeout_device_flex(isHide); }, 1000);
    }
}
function setuserHeadInfo_flex(selectedUserHeadInfo) {
    try {
        if (selectedUserHeadInfo == "" || selectedUserHeadInfo == null) {
            selectedUserHeadInfo = "name";
        }
        var mainSWF = document.getElementById("main");
        if (mainSWF) {            
            mainSWF.callbackSetUserHeadInfo(selectedUserHeadInfo);
        }
        else {
            setTimeout(function () { setuserHeadInfo_flex(selectedUserHeadInfo); }, 1000);
        }
    }
    catch (e) {
        setTimeout(function () { setuserHeadInfo_flex(selectedUserHeadInfo); }, 1000);
    }
}
function setuserHeadInfo_mode_flex(selectedUserHeadInfo_StatuesMode) {
    try {
        if (selectedUserHeadInfo_StatuesMode == "" || selectedUserHeadInfo_StatuesMode == null) {
            selectedUserHeadInfo_StatuesMode = "name";
        }
        var mainSWF = document.getElementById("main");
        if (mainSWF) {
            mainSWF.changeUserHeaderInfo_StatuesMode(selectedUserHeadInfo_StatuesMode);
        }
        else {
            setTimeout(function () { setuserHeadInfo_mode_flex(selectedUserHeadInfo_StatuesMode); }, 1000);
        }
    }
    catch (e) {
        setTimeout(function () { setuserHeadInfo_mode_flex(selectedUserHeadInfo_StatuesMode); }, 1000);
    }
}
function setVoiceType(voiceType) {
    try {
        useprameters.voiceType = voiceType;
        var scactionX = document.frames['log_windows_ifr'].document.getElementById('SCactionX');
        if (scactionX) {
            if (useprameters.callActivexable) {
                var reVal = scactionX.SetVoiceType(voiceType);
            }
        }
    }
    catch (e) { }
}
function checklockallpages()
{
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

    //实时轨迹列表生成锁定图标
    var ifrs_realtimelists = document.frames["realTimeTraceUserList_ifr"];
    if (ifrs_realtimelists) {
        ifrs_realtimelists.checklock(); //锁定图标
    }
    
}

function colorCodeToFlashColor(code) {
    var flashCode = "";
    switch (code.toString()) {
        case "1": flashCode = "000000"; break;
        case "2": flashCode = "ff0033"; break;
        case "3": flashCode = "0000FF"; break;
        case "4": flashCode = "33FF33"; break;
        case "5": flashCode = "FFFF00"; break;
        case "6": flashCode = ""; break;
        case "7": flashCode = ""; break;

    }
    return flashCode;
}
function colorCodeToHtmlColor(code) {
    var htmlCode = "";
    switch (code.toString()) {
        case "1": htmlCode = "#000"; break;
        case "2": htmlCode = "#f00"; break;
        case "3": htmlCode = "#00f"; break;
        case "4": htmlCode = "#0f0"; break;
        case "5": htmlCode = "#ff0"; break;
        case "6": htmlCode = ""; break;
        case "7": htmlCode = ""; break;

    }
    return htmlCode;
}

function loadColorOption(sel) {
    var Lang_Color_Black = GetTextByName("Lang_Color_Black", useprameters.languagedata);
    var Lang_Color_Red = GetTextByName("Lang_Color_Red", useprameters.languagedata);
    var Lang_Color_Blue = GetTextByName("Lang_Color_Blue", useprameters.languagedata);
    var Lang_Color_Green = GetTextByName("Lang_Color_Green", useprameters.languagedata);
    var Lang_Color_Yellow = GetTextByName("Lang_Color_Yellow", useprameters.languagedata);
    var arr = [Lang_Color_Black, Lang_Color_Red, Lang_Color_Blue, Lang_Color_Green, Lang_Color_Yellow];

   
    if (sel) {
        for (var i = 0; i < arr.length; i++) {
            var option = document.createElement("option");
            option.value = i+1;
            option.innerHTML = arr[i];
            sel.appendChild(option);
        }
    }
}

function getcallActivexable()
{
    return useprameters.callActivexable;
}
function checkDisplayImg(id,isDisplay) {
    try {
        if (window.parent != null) {
            obj = window.parent;
        }
        else {
            obj = window;
        }
        //polistlist
        var ifr1 = obj.document.frames['policelists'];
        if(ifr1){
            var td_img1 = ifr1.document.getElementById("Isdisplay_" + id);
            if (td_img1)
            {
                if (isDisplay) {
                    td_img1.innerHTML = "<img src='../images/isinviewyes.png'/>";
                }
                else {
                    td_img1.innerHTML = "<img src='../images/isinviewno.png'/>";
                }
            }
        }
        //concernlist
        var ifr2 = obj.document.frames['concernlist_ifr'];
        if (ifr2) {
            var td_img2 = ifr2.document.getElementById("Isdisplay_" + id);
            if (td_img2) {
                if (isDisplay) {
                    td_img2.innerHTML = "<img src='../images/isinviewyes.png'/>";
                }
                else {
                    td_img2.innerHTML = "<img src='../images/isinviewno.png'/>";
                }
            }
        }
        //select_user
        var ifr3 = obj.document.frames['select_user_ifr'];
        if (ifr3) {
            var td_img3 = ifr3.document.getElementById("Isdisplay_" + id);
            if (td_img3) {
                if (isDisplay) {
                    td_img3.innerHTML = "<img src='../images/isinviewyes.png'/>";
                }
                else {
                    td_img3.innerHTML = "<img src='../images/isinviewno.png'/>";
                }
            }
        }
        var ifr4 = obj.document.frames['realTimeTraceUserList_ifr'];
        if (ifr4)
        {
            var td_img4 = ifr4.document.getElementById("Isdisplay_" + id);
            if (td_img4) {
                if (isDisplay) {
                    td_img4.innerHTML = "<img src='../images/isinviewyes.png'/>";
                }
                else {
                    td_img4.innerHTML = "<img src='../images/isinviewno.png'/>";
                }
            }
        }
    }
    catch(e){}
}


var isSelVideoFlag = false;
function videoToSelect(obj) {
    var choose = new Choose(_StaticObj.objGet("map"), LayerControl);
    if (isSelVideoFlag) {
        obj.style.backgroundImage = "";
        isSelVideoFlag = false;
        choose.turnOff("rectangle");
        return;
    }

    obj.style.backgroundImage = "url(Images/ToolBar/toolbar_bg1.png)";
    obj.style.backgroundRepeat = "no-repeat";
    delObj("myrectangle_choose2_video");
    choose.turnOn("rectangle");
    isSelVideoFlag = true;

    useprameters.vmlname = "myrectangle_choose2_video";
    choose.addEventListener("rectangleEnd", function (selected, range) {
        isSelVideoFlag = false;
        var SelBound = range.latLng.minLo + ',' + range.latLng.maxLo + ',' + range.latLng.minLa + ',' + range.latLng.maxLa;

        obj.style.backgroundImage = "";

        choose.turnOff("rectangle");
        useprameters.vmlname = "";
        lq_hiddenvml('myrectangle_choose2_video')

        window.open("Video/PlayMuilVideo.aspx?bound=" + SelBound, "pcccc", "height=768px,width=1024px,top=0,left=0,toolbar=no,menubar=no, scrollbars=no, resizable=no,  location=no, status=yes ");


    });

}

//按键触发组呼叫
function onKeyDownGroupCall(value) {

    var usertype = Cookies.get("usertype");
    if (usertype == 2)
        return;

    //alert("current key "+value);
    var groupkey = useprameters.GroupShortKey;
    var key = new Array(); //定义一数组 

    key = groupkey.split(";"); //字符分割 
    //alert(key[0]);
    //alert(key[1]);
    //alert(key[2]);
    //alert(key[3]);
    //alert(key[4]);
    //alert(key[5]);
    //alert(key[6]);
    //alert(key[7]);
    //alert(key[8]);
    //alert(key[9]);
    var groupNum=0;
    for (var i=0; i < key.length; i++) {
        if (i == value) {
            groupNum = key[i];
            break;
        }
    }

    //alert(groupNum);
    if (groupNum > 0) {
        setGroupCallGSSI(groupNum);
        var isEncryption = "0";//xzj--20190320--添加呼叫加密参数
        if (useprameters.CallEncryption.indexOf("Single") >= 0) {
            isEncryption = "1";
        }
        var result = startGC2(groupNum, isEncryption);
        if (result == 1) {
            var obj = window.frames["mypancallContent"].document.frames["groupcallContent"].document.getElementById("btnGroupEndCall_" + groupNum);
            if (obj)
                obj.disabled = false;
        }
    }
    else {
        alert(GetTextByName("Lang_keyNull", useprameters.languagedata));
    }
}



function stopDefault(e) {
    //如果提供了事件对象，则这是一个非IE浏览器   
    if (e && e.preventDefault) {
        //阻止默认浏览器动作(W3C)  
        e.preventDefault();
    } else {
        //IE中阻止函数器默认动作的方式   
        window.event.returnValue = false;
    }
    return false;
}

function mainSwfFocus() {

    var mainSWF = document.getElementById("main");
    //alert(mainSWF);
    if (mainSWF) {
        mainSWF.mainSwfFocus();
    }
}
//checkbox图层控制---------------xzj--20180815
function layershowCheckBoxClick(e) {//xzj--20180815
    if (e.target.checked) {
        if (e.target.id == "Radio0") {
            bsLayerManager.setVisible(true);
        }
        else if (e.target.id == "Radio1") {
            psLayerManager.setVisible(true);
        }
        else if (e.target.id == "Radio2") {
            getLayerById(map, "user").setVisible(true);
            fsLayerManager.setVisible(true);
        }
        else if (e.target.id == "Checkbox1") {
            cameraLayerManager.setVisible(true);
            
        }
    }
    else {
        if (e.target.id == "Radio0") {
            bsLayerManager.setVisible(false);
        }
        else if (e.target.id == "Radio1") {
            psLayerManager.setVisible(false);
        }
        else if (e.target.id == "Radio2") {
            getLayerById(map, "user").setVisible(false);
            fsLayerManager.setVisible(false);
        }
        else if (e.target.id == "Checkbox1") {
            cameraLayerManager.setVisible(false);
        }
        }
}
//打开关闭监控列表
function hidecameralistsdiv() {
    var policelists_div = document.getElementById("cameralistsdiv");
    if (policelists_div) {
        policelists_div.style.display = "none";
    }
}
function displaycameralistsdiv() {
    var policelists_div = document.getElementById("cameralistsdiv");
    if (policelists_div) {
        policelists_div.style.display = "block";
    }
}
//添加监控定位
function locateCameraByLonLat(lon, lat) {
    if (!cameraLayerManager.getVisible()) {
        var alertMessage = GetTextByName("Lang_monitoringIsNotShownOnTheMap");
        alert(alertMessage);
        return
    }
    var coord = ol.proj.transform([parseFloat(lon), parseFloat(lat)], 'EPSG:4326', 'EPSG:3857');
    mapLocateEvent.locate(coord, 5000);
}
//根据分号截取pgis地图url字符串
function getWmtsUrl(mapUrl, index) {
    if (mapUrl.split(";")[index] != null) {
        return mapUrl.split(";")[index];
    }
}

