/// <reference path="../../JQuery/jquery-1.5.2.js" />
function removemark(parentstring, nodestring) {
    var mapdiv = document.getElementById(parentstring);
    if (!mapdiv)
        return;
    var ul = mapdiv.getElementsByTagName(nodestring);
    var lilength = ul.length;
    for (var i = 0; i <= lilength; i++) {
        if (ul[i]) {
            var li = ul[i].parentNode.removeChild(ul[i]);
            li = null;
        }
    }
    ul = null;
    mapdiv = null;
    CollectGarbage();
}

window.recycler = (function () { var t = document.createElement('div'); t.id = "recycler"; return t; })();
function removeChildSafe(el) {
    if (!el) { return; }
    removeevent(el);                //移除接节点上的事件
    if (el && window.recycler) {
        window.recycler.appendChild(el);
        window.recycler.innerHTML = "";
    }
}
//移除事件
function removeevent(el) {
    if (!el) { return; }

    if (el.childNodes.length > 0) {
        for (var i = 0; i < el.childNodes.length; i++) {
            removeevent(el.childNodes[i]);
        }
    }

    //去除IMG标签src
    if (el.tagName == "IMG") {
        el.src = "../../";
    }
    if (el.onclick) {
        el.onclick = null;
    }
    if (el.ondblclick) {
        el.ondblclick = null;
    }
    if (el.oncontextmenu) {
        el.oncontextmenu = null;
    }
    if (el.onmousedown) {
        el.onmousedown = null;
    }
    if (el.onmouseup) {
        el.onmouseup = null;
    }
    if (el.onmousemove) {
        el.onmousemove = null;
    }
    if (el.onmouseover) {
        el.onmouseover = null;
    }
    if (el.onmouseout) {
        el.onmouseout = null;
    }
    if (el.onmouseleave) {
        el.onmouseleave = null;
    }
    if (el.onkeypress) {
        el.onkeypress = null;
    }
    if (el.onload) {
        el.onload = null;
    }
    if (el.onunload) {
        el.onunload = null;
    }
    if (el.onbeforeunload) {
        el.onbeforeunload = null;
    }
    if (el.onselectstart) {
        el.onselectstart = null;
    }
    if (el.onerror) {
        el.onerror = null;
    }
    if (el.onchange) {
        el.onchange = null;
    }
    if (el.onkeydown) {
        el.onkeydown = null;
    }
    if (el.onkeyup) {
        el.onkeyup = null;
    }
    if (el.onmousewheel) {
        el.onmousewheel = null;
    }
    if (el.onfocus) {
        el.onfocus = null;
    }
    if (el.onFocus) {
        el.onFocus = null;
    }
    if (el.onblur) {
        el.onblur = null;
    }
}

function lockpc(id, layerCell, justpecent) {
    var img = document.getElementById("Police,0,0|" + id + "_vFigure");
    var mp = _StaticObj.objGet("map");
    var mapcoord = mp.getPixelInMap({ lo: layerCell.Longitude, la: layerCell.Latitude })
    var left = mapcoord.x + (mp.data.currentLevel / mp.data.maxLevel) * 25-2;
    var top = mapcoord.y - (mp.data.currentLevel / mp.data.maxLevel) * 90;
    if (img) {
        var ul = document.getElementById("bztp_" + id);
        if (!ul) {
            //创建bztp div
            var bztp = document.getElementById("bztp");
            if (!bztp) {
                var bztp = document.createElement("div");
                var map = document.getElementById("map");
                map.appendChild(bztp);
                bztp.id = "bztp";
            }
            ul = document.createElement("ul");
            bztp.appendChild(ul);
            ul.id = "bztp_" + id;
            ul.style.listStyleType = "none";
            ul.style.position = "absolute";
            ul.style.top = img.style.top;
            ul.style.left = left;
            ul.style.width = "30" * justpecent;
            ul.style.zIndex = "1";
            var li = document.getElementById("bztp_lock_" + id);
            if (!li) {
                var li = document.createElement("li");
                ul.appendChild(li);
                li.id = "bztp_lock_" + id;                
                if (LayerControl.map.data.currentLevel > 10) {
                    li.style.backgroundImage = "url(lqnew/images/lockbzpic/10" + "/lockbzpic.png)";
                }
                else {
                    li.style.backgroundImage = "url(lqnew/images/lockbzpic/" + LayerControl.map.data.currentLevel + "/lockbzpic.png)";
                }
                li.style.backgroundRepeat = "no-repeat";
                li.title = GetTextByName("RightButtonCancelLock", useprameters.languagedata);
                li.style.width = "30" * justpecent;
                li.style.height = "30" * justpecent;
            }
            else {
                //庞小斌修改，滚动地图时执行的方法
                if (LayerControl.map.data.currentLevel != LayerControl.map.data.lastLevel) {
                    li.style.width = "30" * justpecent;
                    li.style.height = "30" * justpecent;
                }
            }
        }
        else {
            var li = document.getElementById("bztp_lock_" + id);
            if (!li) {
                var li = document.createElement("li");
                ul.appendChild(li);
                li.id = "bztp_lock_" + id;
                if (LayerControl.map.data.currentLevel > 10) {
                    li.style.backgroundImage = "url(lqnew/images/lockbzpic/10" + "/lockbzpic.png)";
                }
                else {
                    li.style.backgroundImage = "url(lqnew/images/lockbzpic/" + LayerControl.map.data.currentLevel + "/lockbzpic.png)";
                }
                li.style.backgroundRepeat = "no-repeat";
                li.title = GetTextByName("RightButtonCancelLock", useprameters.languagedata);
                li.style.width = "30" * justpecent;
                li.style.height = "30" * justpecent;
            }
            else {
                //庞小斌修改，滚动地图时执行的方法
                if (LayerControl.map.data.currentLevel != LayerControl.map.data.lastLevel) {
                    li.style.width = "30" * justpecent;
                    li.style.height = "30" * justpecent;
                }
            }
            if (ul.style.display == "none") {
                ul.style.display = "block";
            }
        }
    }
}

function selectpc(id, layerCell, justpecent) {
    try {
        var mp = _StaticObj.objGet("map");
        var mapcoord = mp.getPixelInMap({ lo: layerCell.Longitude, la: layerCell.Latitude });
        var left = mapcoord.x + (mp.data.currentLevel / mp.data.maxLevel)*25-2;
        var top = mapcoord.y - (mp.data.currentLevel / mp.data.maxLevel) * 90;
        var img = document.getElementById("Police,0,0|" + id + "_vFigure");
        if (img) {
            var ul = document.getElementById("bztp_" + id);
            if (!ul) {      
                var bztp = document.getElementById("bztp");
                if (!bztp) {
                    var bztp = document.createElement("div");
                    var map = document.getElementById("map");
                    map.appendChild(bztp);
                    bztp.id = "bztp";
                }

                var ul = document.createElement("ul");
                bztp.appendChild(ul);
                ul.id = "bztp_" + id;
                ul.style.listStyleType = "none";
                ul.style.position = "absolute";
                ul.style.top = top;
                ul.style.left = left;
                ul.style.zIndex = "1";
                ul.style.width = "30" * justpecent;
                var li = document.getElementById("bztp_select_" + id);
                if (!li) {
                    var li = document.createElement("li");
                    ul.appendChild(li);
                    li.id = "bztp_select_" + id;                    
                    if (LayerControl.map.data.currentLevel > 10) {
                        li.style.backgroundImage = "url(lqnew/images/selectover/10" + "/selectover.png)";
                    }
                else{
                    li.style.backgroundImage = "url(lqnew/images/selectover/" + LayerControl.map.data.currentLevel + "/selectover.png)";
                }
                    li.style.backgroundRepeat = "no-repeat";
                    li.title = GetTextByName("Text_SelectUser", useprameters.languagedata);
                    li.style.width = "30" * justpecent;
                    li.style.height = "30" * justpecent;
                    //li.onclick = function () { };
                }
                else {
                        li.style.width = "30" * justpecent;
                        li.style.height = "30" * justpecent;
                }
            }
            else {
                var li = document.getElementById("bztp_select_" + id);
                if (!li) {
                    var li = document.createElement("li");
                    ul.appendChild(li);
                    li.id = "bztp_select_" + id;
                    if (LayerControl.map.data.currentLevel > 10) {
                        li.style.backgroundImage = "url(lqnew/images/selectover/10" + "/selectover.png)";
                    }
                    else {
                        li.style.backgroundImage = "url(lqnew/images/selectover/" + LayerControl.map.data.currentLevel + "/selectover.png)";
                    }
                    li.style.backgroundRepeat = "no-repeat";
                    li.title = GetTextByName("Text_SelectUser", useprameters.languagedata);
                    li.style.width = "30" * justpecent;
                    li.style.height = "30" * justpecent;
                    //li.onclick = function () { };                    
                }
                else {                    
                        li.style.width = "30" * justpecent;
                        li.style.height = "30" * justpecent;
                }
                if (ul.style.display == "none") {
                    ul.style.display = "block";
                }
            }
        }
    }
    catch (e) {
        alert("selectpc" + e);
    }
}

function concernpc(id, layerCell, justpecent) {
    try{
        var img = document.getElementById("Police,0,0|" + id + "_vFigure");
        var mp = _StaticObj.objGet("map");
        var mapcoord = mp.getPixelInMap({ lo: layerCell.Longitude, la: layerCell.Latitude })
        var left = mapcoord.x + (mp.data.currentLevel / mp.data.maxLevel) * 25 - 2;
        var top = mapcoord.y - (mp.data.currentLevel / mp.data.maxLevel) * 90;
        if (img) {
            var ul = document.getElementById("bztp_" + id);
            if (!ul) {
                //创建bztp div
                var bztp = document.getElementById("bztp");
                if (!bztp) {
                    var bztp = document.createElement("div");
                    var map = document.getElementById("map");
                    map.appendChild(bztp);
                    bztp.id = "bztp";
                }
                ul = document.createElement("ul");
                bztp.appendChild(ul);
                ul.id = "bztp_" + id;
                ul.style.listStyleType = "none";
                ul.style.position = "absolute";
                ul.style.top = img.style.top;
                ul.style.left = left;
                ul.style.width = "30" * justpecent;
                ul.style.zIndex = "1";
                var li = document.getElementById("bztp_lock_" + id);
                if (!li) {
                    var li = document.createElement("li");
                    ul.appendChild(li);
                    li.id = "bztp_concern_" + id;
                    if (LayerControl.map.data.currentLevel > 10) {
                        li.style.backgroundImage = "url(lqnew/images/concernpic/10" + "/concernpic.png)";
                    }
                    else {
                        li.style.backgroundImage = "url(lqnew/images/concernpic/" + LayerControl.map.data.currentLevel + "/concernpic.png)";
                    }
                    li.style.backgroundRepeat = "no-repeat";
                    li.title = GetTextByName("RightButtonCancelLock", useprameters.languagedata);
                    li.style.width = "30" * justpecent;
                    li.style.height = "30" * justpecent;
                }
                else {
                    //庞小斌修改，滚动地图时执行的方法
                    if (LayerControl.map.data.currentLevel != LayerControl.map.data.lastLevel) {
                        li.style.width = "30" * justpecent;
                        li.style.height = "30" * justpecent;
                    }
                }
            }
            else {
                var li = document.getElementById("bztp_concern_" + id);
                if (!li) {
                    var li = document.createElement("li");
                    ul.appendChild(li);
                    li.id = "bztp_concern_" + id;
                    if (LayerControl.map.data.currentLevel > 10) {
                        li.style.backgroundImage = "url(lqnew/images/concernpic/10" + "/concernpic.png)";
                    }
                    else {
                        li.style.backgroundImage = "url(lqnew/images/concernpic/" + LayerControl.map.data.currentLevel + "/concernpic.png)";
                    }
                    li.style.backgroundRepeat = "no-repeat";
                    li.title = GetTextByName("RightButtonCancelLock", useprameters.languagedata);
                    li.style.width = "30" * justpecent;
                    li.style.height = "30" * justpecent;
                }
                else {
                    //庞小斌修改，滚动地图时执行的方法
                    if (LayerControl.map.data.currentLevel != LayerControl.map.data.lastLevel) {
                        li.style.width = "30" * justpecent;
                        li.style.height = "30" * justpecent;
                    }
                }
                if (ul.style.display == "none") {
                    ul.style.display = "block";
                }
            }
        }
    }
    catch (e) {
        alert("concernpc"+e);
    }
}

function callStateISSI(ISSI, layerCell, type, justpecent, drict) {//添加警员上行呼叫图标
    var img = document.getElementById("Police,0,0|" + layerCell.ID + "_vFigure");
    var mp = _StaticObj.objGet("map");
    var mapcoord = mp.getPixelInMap({ lo: layerCell.Longitude, la: layerCell.Latitude })
    var left = mapcoord.x + (mp.data.currentLevel - mp.data.maxLevel) * 5 - 10;
    var top = mapcoord.y - (mp.data.currentLevel / mp.data.maxLevel) * 90
    if (img) {
        var ul = document.getElementById("bztp_" + layerCell.ID)
        if (!ul) {
            ul = document.createElement("ul");
            ul.id = "bztp_" + layerCell.ID;
            ul.style.listStyleType = "none";
            ul.style.position = "absolute";
            ul.style.top = img.style.top;
            ul.style.zIndex = "1";
            var mapcoord = mp.getPixelInMap({ lo: layerCell.Longitude, la: layerCell.Latitude })
            ul.style.left = mapcoord.x + (mp.data.currentLevel - mp.data.maxLevel) * 5 - 10;
            ul.style.width = "30" * justpecent;
            var li = document.getElementById("bztp_call_" + ISSI) || document.createElement("li");
            li.id = "bztp_call_" + ISSI;
            li.style.width = "30" * justpecent;
            li.style.height = "30" * justpecent;
            var imgsrc;
            switch (type) {
                case "10": //上行组呼
                    imgsrc = "lqnew/images/groupcall.png";
                    li.title = GetTextByName("InCalling", useprameters.languagedata);//多语言：正在通话中..
                    break;
                case "01": //上行全双工单呼 多语言：上行
                    imgsrc = (drict == GetTextByName("UpCall", useprameters.languagedata)) ? "lqnew/images/singlecall_all.png" : "lqnew/images/singlecall_all_down.png";
                    li.title = GetTextByName("InCalling", useprameters.languagedata);//多语言：正在通话中..
                    break;
                case "00": //上行半双工单呼 多语言：上行
                    imgsrc = (drict == GetTextByName("UpCall", useprameters.languagedata)) ? "lqnew/images/singlecall_half.png" : "lqnew/images/singlecall_half_down.png";
                    li.title = GetTextByName("InCalling", useprameters.languagedata);//多语言：正在通话中..
                    break;

            }

            li.style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(src='" + imgsrc + "', sizingMethod='scale')";
            li.onclick = function () { };
            ul.appendChild(li);
            var map = document.getElementById("map");
            map.appendChild(ul);
            map = null;
            li = null;

        }
        else {
            var li = document.getElementById("bztp_call_" + ISSI) || document.createElement("li");
            li.id = "bztp_call_" + ISSI;
            li.style.width = "30" * justpecent;
            li.style.height = "30" * justpecent;
            var imgsrc;
            switch (type) {
                case "10": //上行组呼
                    imgsrc = "lqnew/images/groupcall.png";
                    li.title = GetTextByName("InCalling", useprameters.languagedata);//多语言：正在通话中..
                    break;
                case "01": //上行全双工单呼 多语言：上行
                    imgsrc = (drict == GetTextByName("UpCall", useprameters.languagedata)) ? "lqnew/images/singlecall_all.png" : "lqnew/images/singlecall_all_down.png";
                    li.title = GetTextByName("InCalling", useprameters.languagedata);//多语言：正在通话中..
                    break;
                case "00": //上行半双工单呼 多语言：上行
                    imgsrc = (drict == GetTextByName("UpCall", useprameters.languagedata)) ? "lqnew/images/singlecall_half.png" : "lqnew/images/singlecall_half_down.png";
                    li.title = GetTextByName("InCalling", useprameters.languagedata);//多语言：正在通话中..
                    break;

            }

            li.style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(src='" + imgsrc + "', sizingMethod='scale')";
            li.onclick = function () { };
            ul.appendChild(li);
            //               $("#bztp_" + layerCell.ID).each(function () {
            //                   $(this).animate({ left: left, top: top }, 500);
            //              });
        }
        ul = null;
    }
}
