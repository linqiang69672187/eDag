
function createSynTreeWithoutResource() {
    try
    {
    var serverIP = getCookieByName('videoIp');
    //alert(serverIP);
    var addresstreeJson = "{'updateTime':null,'addressTreeName':null,'isDefault':0,'addressTreeId':'b8c42daf-1d0d-11e3-8cad-1c6f65a8ee8a','description':null,'createTime':null}";
    var data;
    data = '<?xml version="1.0" encoding="utf-8"?>';
    data = data + '<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">';
    data = data + '<soap:Body>';
    data = data + '<' + 'createSynTreeWithoutResource' + ' xmlns="http://web.videoclues.zhvmp.jp.com">';
    data = data + '<username>' + 'eastcom' + '</username>';
    data = data + '<password>' + '123456' + '</password>';
    data = data + '<addresstreeJson>' + addresstreeJson + '</addresstreeJson>';
    data = data + '</' + 'createSynTreeWithoutResource' + '>';
    data = data + '</soap:Body>';
    data = data + '</soap:Envelope>';

    var xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
    var URL = 'http://' + serverIP + ':8080/zhvmp/services/PublicInterfaceService?wsdl';
    //添加异步onreadystatechange函数--xzj--2018/9/11
    xmlhttp.onreadystatechange=function(){
        if(xmlhttp.readyState ==4){
            if((xmlhttp.status >= 200 && xmlhttp.status < 300) || xmlhttp.status == 304){
                var str = xmlhttp.responseXML.text;
                //alert(str);
                var result = eval("(" + xmlhttp.responseXML.text + ")");
                if (result.result == "SUCCESS") {
                    //var addressObj = result;
                    //var mainSWF = window.document.getElementById("main");
                    //if (mainSWF) {
                    //    mainSWF.buildCamerTree(addressObj);
                    //}
                    addCameraZTree(result.data);//添加监控树形---update--2018/9/5
                    document.getElementById("Monitorlefttree").style.display = "inline-block";
                    //var str = getAddressList(addressObj);
                    //var tbodyHtml = "<tbody>" + getAddressList(addressObj) + "</tbody>";
                    //$("#addressTable").find('tbody').remove().end().append(tbodyHtml);
                }
                else {
                    alert(result.message);
                }
            }
        }
    }

    xmlhttp.Open("POST", URL, true);
    xmlhttp.SetRequestHeader('Content-Type', 'text/xml; charset=utf-8');
    xmlhttp.SetRequestHeader('SOAPAction', 'http://web.videoclues.zhvmp.jp.com/' + 'createSynTreeWithoutResource');
    xmlhttp.Send(data);
}
catch (e)
{
    
}
}

var arrAllCameraJson=null;
function StringgetAllCameraForJson() {
    try{
    var serverIP = getCookieByName('videoIp');
    var data;
    data = '<?xml version="1.0" encoding="utf-8"?>';
    data = data + '<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">';
    data = data + '<soap:Body>';
    data = data + '<' + 'getAllCameraByAccountNameForJson ' + ' xmlns="http://web.videoclues.zhvmp.jp.com">';
    data = data + '<username>' + 'eastcom' + '</username>';
    data = data + '<password>' + '123456' + '</password>';
    data = data + '<accountname>' + 'eastcom' + '</accountname>';

    data = data + '</' + 'getAllCameraByAccountNameForJson ' + '>';
    data = data + '</soap:Body>';
    data = data + '</soap:Envelope>';
    var xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
    // var URL = 'http://localhost:7426/WebGis/Service/CamerTree/createSynTreeWithoutResource.aspx';
    var URL = 'http://' + serverIP + ':8080/zhvmp/services/PublicInterfaceService?wsdl';

    //添加异步onreadystatechange函数--xzj--2018/9/11
    xmlhttp.onreadystatechange=function(){
        if(xmlhttp.readyState ==4){
            if((xmlhttp.status >= 200 && xmlhttp.status < 300) || xmlhttp.status == 304){
                var str = xmlhttp.responseXML.text;
                //alert(str);
                var result = eval("(" + xmlhttp.responseXML.text + ")");
                arrAllCameraJson = result;
                if (arrAllCameraJson != null) {
                    cameraLayerManager.LoadCameras();
                    document.getElementById("cameraManageLi").style.display = "inline-block";
                }
            }
        }
    }

    xmlhttp.Open("POST", URL, true);
    xmlhttp.SetRequestHeader('Content-Type', 'text/xml; charset=utf-8');
    xmlhttp.SetRequestHeader('SOAPAction', 'http://web.videoclues.zhvmp.jp.com/' + 'getAllCameraByAccountNameForJson');
    xmlhttp.Send(data);
    }
    catch (e)
    {
       
    }
}

//添加监控ztree
var cameraZNode = [];
function addCameraZTree(cameraData) {//--update--2018/9/5
    var cameraSetting = {        //zTree 插件配置
        data: {
            simpleData: {
                enable: true,
                idKey: "id",
                pIdKey: "pId",
                name: "name",
                rootPId: 0
            }
        },
        callback: {
            onClick: addCameraNode
        }
    };
    var cameraJson = cameraData;
    var startNode = { "id": cameraJson.detailId, "pId": "0", "name": cameraJson.nodeDimenName, "isLeaf": cameraJson.isLeaf, "treeId": cameraJson.treeId };
    cameraZNode.push(startNode);//根节点

    addNode(cameraJson)
    $.fn.zTree.init($("#treeDemo2"), cameraSetting, cameraZNode);
}
function addNode(cameraJson) {//添加子节点
    var pId = cameraJson.detailId
    var nextNodeJson = cameraJson.nextNodes
    if (nextNodeJson) {
        for (var i = 0; i < nextNodeJson.length; i++) {
            var id = nextNodeJson[i].detailId;
            var name = nextNodeJson[i].nodeDimenName;
            var isLeaf = nextNodeJson[i].isLeaf;
            var treeId = nextNodeJson[i].treeId;
            var arr = { "id": id, "pId": pId, "name": name, "isLeaf": isLeaf, "treeId": treeId };
            cameraZNode.push(arr)
            if (nextNodeJson[i].nextNodes) {
                addNode(nextNodeJson[i]);
            }
        }
    }
}
function addCameraNode(event, treeId, treeNode) {//叶子节点点击事件
    if (typeof (treeNode.isLeaf) != "undefined") {//判断是否打开监控列表
        displaycameralistsdiv();
        window.frames['cameralists'].Displayprocessbar();
        window.frames['cameralists'].GetAllCamera();
    }
    if (treeNode.isLeaf) {//判断是否加载为叶子节点，是则加载摄像
        queryCameraList(treeNode.id, treeNode.isLeaf, treeNode.treeId);
        var treeObj = $.fn.zTree.getZTreeObj("treeDemo2");
        treeNode.isLeaf = false;
        treeObj.updateNode(treeNode);
    }
    if (treeNode.isCamera) {//判断是否为监控，是则打开视频播放
        VideoCallFuction("", "", treeNode.id, treeNode.name, "400", "300", "false", "99", "false",
            "PlayWindow/play.html?deviceName=" +
            treeNode.name + "&deviceNum=" + treeNode.id + "&realm=" + treeNode.realm + "&cameraNum=" + treeNode.cameraNum + "&latitude=" +
            treeNode.latitude + "&longitude=" + treeNode.longitude + "&cameraIP=" + treeNode.cameraIP)
    }
}
//queryCameraList("9088808d49466a19014955c2546702ea", "true", "b8c42daf-1d0d-11e3-8cad-1c6f65a8ee8a");
function queryCameraList(detailId, isLeaf, treeId) {
    try{
    var serverIP = getCookieByName('videoIp');
    //{"detailId":"b246a278-b8af-11e3-89c9-50e549243bea","isLeaf":"true","nodeSuperDimenId":"","nodeDimenName":"朝阳所 (42/50, 84%)",
    //"nodedimensionId":"a9b0760c-b8ad-11e3-89c9-50e549243bea","isSearchShow":"false",
    //"superDetailId":"9dd12878-b8ae-11e3-89c9-50e549243bea","hasResource":"true","treeId":"b8c42daf-1d0d-11e3-8cad-1c6f65a8ee8a","nodeType":"地址","belongAddressId":""}
    //var treeNodeJson = "{'detailId':"+obj.detailId+",'isLeaf':"+obj.isLeaf+",'nodeSuperDimenId':"+obj.nodeSuperDimenId+
    //					",'nodedimensionId':"+obj.nodedimensionId+",'isSearchShow':"+obj.isSearchShow+",'superDetailId':"+obj.superDetailId+
    //					",'hasResource':"+obj.hasResource+",'treeId':"+obj.treeId+",'nodeType':"+obj.nodeType+",'belongAddressId':"+obj.belongAddressId+"}";
    var treeNodeJson = "{'detailId':'" + detailId + "','isLeaf':'" + isLeaf + "','nodeSuperDimenId':'','nodedimensionId':'','isSearchShow':'','superDetailId':'','hasResource':'','treeId':'" + treeId + "','nodeType':'','belongAddressId':''}";
    var data;
    data = '<?xml version="1.0" encoding="utf-8"?>';
    data = data + '<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">';
    data = data + '<soap:Body>';
    data = data + '<' + 'createAsyTreeWithPermsionOnSynTree' + ' xmlns="http://web.videoclues.zhvmp.jp.com">';
    data = data + '<username>' + 'eastcom' + '</username>';
    data = data + '<password>' + '123456' + '</password>';
    data = data + '<_treeNodeJson>' + treeNodeJson + '</_treeNodeJson>';
    data = data + '</' + 'createAsyTreeWithPermsionOnSynTree' + '>';
    data = data + '</soap:Body>';
    data = data + '</soap:Envelope>';

    var xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
    var URL = 'http://' + serverIP + ':8080/zhvmp/services/PublicInterfaceService?wsdl';
    xmlhttp.Open("POST", URL, false);
    xmlhttp.SetRequestHeader('Content-Type', 'text/xml; charset=utf-8');
    xmlhttp.SetRequestHeader('SOAPAction', 'http://web.videoclues.zhvmp.jp.com/' + 'createAsyTreeWithPermsionOnSynTree');
    xmlhttp.Send(data);

    var str = xmlhttp.responseXML.text;
    var result = eval("(" + xmlhttp.responseXML.text + ")");
    if (result.result == "SUCCESS") {
        var cameraObj = result.data;
        var cameraArr = cameraObj.resources;
        var str1 = '{\"data\":[';
        //deviceName deviceNum parentDeviceNum encodeRealm
        for (var i = 0; i < cameraArr.length; i++) {
            var temp;
            if (i == cameraArr.length - 1) {
                var temp = '{\"devicename\":\"' + cameraArr[i].deviceName + '\",\"deviceNum\":\"' + cameraArr[i].parentDeviceNum + '\",\"realm\":\"' + cameraArr[i].encodeRealm + '\",\"cameraNum\":\"' + cameraArr[i].deviceNum + '\",\"latitude\":\"' + cameraArr[i].latitude + '\",\"longitude\":\"' + cameraArr[i].longitude + '\",\"cameraIP\":\"' + cameraArr[i].cameraIP + '\",\"cameraType\":\"' + cameraArr[i].cameraType + '\",\"isCamera\":true}';
            }
            else {
                var temp = '{\"devicename\":\"' + cameraArr[i].deviceName + '\",\"deviceNum\":\"' + cameraArr[i].parentDeviceNum + '\",\"realm\":\"' + cameraArr[i].encodeRealm + '\",\"cameraNum\":\"' + cameraArr[i].deviceNum + '\",\"latitude\":\"' + cameraArr[i].latitude + '\",\"longitude\":\"' + cameraArr[i].longitude + '\",\"cameraIP\":\"' + cameraArr[i].cameraIP + '\",\"cameraType\":\"' + cameraArr[i].cameraType + '\",\"isCamera\":true},';

            }
            str1 += temp;
        }
        str1 = str1 + "]}";

        if (cameraArr.length == 0) {
            alert("该地址节点下没有资源");
        }
        else {
            var str2 = eval("(" + str1 + ")");
            //var addressObj = str2.data;
            //var mainSWF = window.document.getElementById("main");
            //if (mainSWF) {
            //    mainSWF.buildNodeTree(addressObj);
            //}
            var camera = str2.data;
            var treeObj = $.fn.zTree.getZTreeObj("treeDemo2");
            var parentNode = treeObj.getNodesByParam("id", detailId, null);
            var cameraNode = [];
            for (var i = 0; i < camera.length; i++) {
                cameraNode.push({
                    "id": camera[i].deviceNum, "pId": detailId, "name": camera[i].devicename, "isCamera": camera[i].isCamera, "realm": camera[i].realm,
                    "cameraNum": camera[i].cameraNum, "longitude": camera[i].longitude, "latitude": camera[i].latitude, "cameraIP": camera[i].cameraIP,
                    "cameraType": camera[i].cameraType
                });
            }
            treeObj.addNodes(parentNode[0], cameraNode);
        }
        //alert(str);
    }
    else {
        alert(result.message);
    }

    //nodejd.@belongAddressId = arr[i].deviceNum; 
    //nodejd.@nodeDimenName= arr[i].devicename;  		 
    //nodejd.@deviceNum= arr[i].deviceNum; 	 
    //nodejd.@cameraNum = arr[i].cameraNum; 
    //nodejd.@realm = arr[i].realm; 
    //nodejd.@isCamera= arr[i].isCamera;  //isCamera
    //nodejd.@latitude=arr[i].latitude;
    //nodejd.@longitude=arr[i].longitude;
    //nodejd.@cameraIP=arr[i].cameraIP;
    //nodejd.@cameraType=arr[i].cameraType;
    }
    catch (e)
    {
        
    }
}



function lqopen_newVideoDrownFrame(eventX, eventY, id, cameraname, father, frameSrc, width, height, isdrag) {//增加eventX，eventY鼠标点击位置 add by xuhj  20151105
    if (typeof (father) == "string") {
        father = document.getElementById(father);
    }
    if (!document.getElementById(id)) {
        /** var frame = document.createElement("iframe");

        frame.id = id + "_ifr";
        frame.name = (id == "ifr_callcontent") ? id : id + "_ifr";
        frame.src = frameSrc;
        frame.width = (id == "ifr_callcontent") ? width : "100%";
        frame.frameBorder = "no";
        frame.allowTransparency = "true";
        frame.scrolling = "no";
        frame.style.height = height;
        var div = document.createElement("div");

        div.className = "opendivwindow";
        div.id = id;
        div.style.position = "absolute";
        div.style.cursor = "move";
        div.style.overflow = "hidden";

        //根据浏览器像素调整底部呼叫窗口的位置（id == "ifr_callcontent"）庞小斌修改
        div.style.width = width;
        if (id == "ifr_callcontent") {
            div.style.marginBottom = 0;
            div.style.marginLeft = parseInt(document.body.offsetWidth / 2) - parseInt(width / 2);
        }

        div.style.height = height;
        div.style.backgroundColor = "transparent";
        div.style.zIndex = 50;
        div.attachEvent("click", function () {
            //alert();
        })
        if (isdrag != false) {
            div.onmousedown = function () { mystartDragWindow(this); this.style.border = "solid 3px transparent"; cgzindex(this); };
            div.onmouseup = function () { mystopDragWindow(this); this.style.border = "0px"; };
            div.onmousemove = function () { mydragWindow(this) };
        }
        father.appendChild(div);
        
        
        //cgzindex(div);
        div = null;
        frame = null;*/
        var obj = {
            cameraDiv_id: "cameraDiv_" + id,
            eventX: eventX,
            eventY: eventY,
            title: cameraname,
            frameWidth: 390,//内部iframe宽度
            frameHeight: 215,//内部iframe高度
            frameSrc: frameSrc

        }
        setDiv(id, obj);


        new Drag("cameraDiv_" + id, { limit: true });
    }
}

//###################################add by xuhj start##########################################

//数组储存已打开视频窗口id
var openedIdArray = new Array();
Array.prototype.in_array = function (e) {
    for (i = 0; i < this.length; i++) {
        if (this[i] == e)
            return true;
    }
    return false;
};

Array.prototype.indexOf = function (val) {
    for (var i = 0; i < this.length; i++) {
        if (this[i] == val) return i;
    }
    return -1;
};

Array.prototype.remove = function (val) {
    var index = this.indexOf(val);
    if (index > -1) {
        this.splice(index, 1);
    }
};


/**
 * 
 * 打开div的位置
 * pt{
 * bindX:bindX,  //边界x
 * bindY:bindY,		//边界y
 * eventX:eventX,	//点击x
 * eventY:eventY,	//点击y
 * }
 * 
 *  el:element  //可移动div
 *  
 *  
 *  return top,left
 */

function openDiv_bind(el, pt) {
    var top = pt.eventY;
    var left = pt.eventX;
    var xDistance = pt.bindX - pt.eventX;
    var yDistance = pt.bindY - pt.eventY;
    if (xDistance < el.offsetWidth && yDistance < el.offsetHeight) {
        //alert(top+"右下角"+left);
        left = left - el.offsetWidth - 8;
        top = top - el.offsetHeight - 5;
    } else if (xDistance < el.offsetWidth) {
        //alert(top+"右上角"+left);
        left = left - el.offsetWidth - 8;
        top = top + 5;
    } else if (yDistance < el.offsetHeight) {
        //alert(top+"左下角"+left);
        left = left + 8;
        top = top - el.offsetHeight - 5;
    } else {
        //alert(xDistance+"正常"+el.offsetWidth);
        left = left + 8;
        top = top + 5;
    }
    return { 'top': top, 'left': left };
}
//###############################创建并设定div的参数#################start

/**
 * id:打开的div的id="cameraDiv_"+id
 * obj:带入所有需要的参数格式如下：
 * {
 * cameraDiv_id:"cameraDiv_"+id,
 * title:value,
 * frameWidth:value,
 * frameHeight:value,
 * frameSrc:url,
 * ...
 * }
 */

var theBody;
var div;
var zIndex_i = 99;//全局变量，储存z-index最大值
function setDiv(id, obj) {
    /*防止重复打开*/

    if (openedIdArray.in_array("cameraDiv_" + id)) {
        div = document.getElementById("cameraDiv_" + id);
        var bindX = document.body.clientWidth;//html.clientTop || body.clientTop || 0;
        var bindY = document.body.clientHeight;//html.clientLeft || body.clientLeft || 0;
        var pt = {
            bindX: bindX,  //边界x
            bindY: bindY,		//边界y
            eventX: obj.eventX || (theBody.clientWidth / 2),	//点击x
            eventY: obj.eventY || (theBody.clientHeight / 2)	//点击y
        }
        var tempPos = openDiv_bind(div, pt);
        div.style.left = tempPos.left + "px";//obj.eventX  + "px";
        div.style.top = tempPos.top + "px";//obj.eventY  + "px";
        div.style.zIndex = zIndex_i++;//变为最上层
        return;
    }
    openedIdArray.push("cameraDiv_" + id);//存储打开的divId

    var newLeft, newTop, newWidth, newHeight;
    theBody = document.body;
    div = document.createElement("div");
    div.id = "cameraDiv_" + id;
    div.style.position = "absolute";
    div.style.backgroundColor = "#E5E5E5";
    //Div.style.cssText ="";
    div.style.padding = "2px 1px 2px 2px";
    div.style.overflow = "hidden";
    div.style.zIndex = zIndex_i++;

    //设定打开的大小和位置
    Function()
    {
        //e = event || window.event;
        //alert(e.offsetX);
        newWidth = obj.frameWidth + "px";
        newHeight = (obj.frameHeight + 43) + "px";//top和bottom  50px；
        newLeft = theBody.clientWidth / 2 + "px";
        newTop = theBody.clientHeight / 2 + "px";

        div.style.width = newWidth;
        div.style.height = newHeight;
        div.style.left = newLeft;
        div.style.top = newTop;
    }
    div = setChild(div, obj);
    theBody.appendChild(div);
}
/**
 * 绘制打开的div
 */
function setChild(div, obj) {
    //标题
    var topDiv = document.createElement("div");
    topDiv.style.cssText = "left: 1px; top: 1px;right:1px; width: 99.9%; height: 25px; position: absolute; background: url(/swf/assets/images/playwindow_top.png) no-repeat ; vertical-align: middle; z-index: 5";
    topDiv.style.cursor = "move";
    topDiv.innerHTML = '<div style="width:99.9%; height:25px;position: absolute;display:block;z-index:2;background:#B9D1EA;filter:alpha(Opacity=1);-moz-opacity:0.5;opacity: 0.1;"></div>'
			+ '<div style="z-index:1;"><span style="top: 5px; left:30px; font-size: 12px;disabled;font-weight: bold;text-align:left; color: red; position: relative;" >' + obj.title + '</span></div>';
    div.appendChild(topDiv);

    //关闭按钮
    var closeDiv = document.createElement("div");
    closeDiv.style.cssText = "right: 2px; top : 3px; width: 53px; height: 17px; position: absolute;  text-align: center; vertical-align: middle; cursor: pointer; z-index: 7";
    //closeDiv.onclick=function() {eCloseDiv(this);};
    closeDiv.innerHTML = '<div  style="position:absolute;top:0px;left:0px;z-index:9;">'
						+ '<iframe frameborder="0" marginheight="0px" marginwidth="0px" style="width:53px;height:18px;"  scrolling="no" src="/swf/frameDiv.html?iframeId=' + obj.cameraDiv_id +'" ></iframe></div>';
    /**+'<div style="position:absolute;top:0px;left:0px;z-index:8;">'
    +'<img width="17px" height="17px" onclick="eCloseDiv(this.parentNode.parentNode)" title="关闭" src="assets/images/playwindow_close.png"></img></div>';*/
    div.appendChild(closeDiv);

    //内容
    var contentDiv = document.createElement("div");
    contentDiv.style.cssText = "left: 2px; right:3px; top: 24px; width: 99.9%; position: absolute; overflow: hidden";
    contentDiv.style.height = (obj.frameHeight + 1) + "px";
    contentDiv.id = "aa_" + obj.cameraDiv_id;
    div.appendChild(contentDiv);

    //add frame;
    //var frame = document.createElement("iframe");
    var frameSrc = obj.frameSrc;
    //frame.src = frameSrc;
    contentDiv.innerHTML =
	'<div style="width:99.9%; height:' + obj.frameHeight + 'px;position: absolute;display:none;z-index:2;background:#B9D1EA;filter:alpha(Opacity=80);-moz-opacity:0.5;opacity: 0.5;"></div>'
	+ '<div style="width:99.8%; height:' + obj.frameHeight + 'px;position: absolute;"><iframe id="frame_' + obj.cameraDiv_id + '" name="playFrame" width="100%" height="' + obj.frameHeight
			+ 'px" marginwidth="0" marginheight="0" hspace="0" vspace="0" frameborder="0" scrolling="no" src="' + frameSrc + '"> </iframe></div>';//frame;

    //底部
    var bottomDiv = document.createElement("div");
    bottomDiv.style.cssText = "left: 1px;right:1px; bottom: 1px; width: 100%; height: 22px; position: absolute; background: url(/swf/assets/images/playwindow_bottom.png) no-repeat ; vertical-align: middle; z-index: 5";
    //bottomDiv.id = "bottomDiv";
    div.appendChild(bottomDiv);

    //摄像头控制按钮
    var controlDiv = document.createElement("div");
    var controlLeft = (div.style.width.replace("px", "") / 2 - 35);
    controlDiv.id = "controlDiv_" + obj.cameraDiv_id;
    controlDiv.style.cssText = "left:" + controlLeft + "px;bottom : 4px; width: 70px; height: 19px; position: absolute;  text-align: center; vertical-align: middle; cursor: pointer; z-index: 7;display:none;";
    //closeDiv.onclick=function() {eCloseDiv(this);};
    controlDiv.innerHTML = '<div  style="position:absolute;top:1px;left:0px;z-index:9;">'
						+ '<iframe frameborder="0" marginheight="0px" marginwidth="0px" style="width:70px;height:19px;"  scrolling="no" src="/swf/frameDiv_CameraControl.html?iframeId=' + obj.cameraDiv_id + '" ></iframe></div>';
    /**+'<div style="position:absolute;top:0px;left:0px;z-index:8;">'
    +'<img width="17px" height="17px" onclick="eCloseDiv(this.parentNode.parentNode)" title="关闭" src="assets/images/playwindow_close.png"></img></div>';*/
    div.appendChild(controlDiv);

    return div;
}


//关闭DIV
function eCloseDiv(objId) {
   
    var obj = window.document.getElementById("frame_" + objId).contentWindow;
    //alert(obj);
    obj.stop();
    if (objId) {
        var objDiv = document.getElementById(objId);
        openedIdArray.remove(objId);//关闭后删去divid
        objDiv.parentNode.removeChild(objDiv);
        objDiv = null;

    }
}
//放大DIV
function enlargeDiv(objId) {

    var obj = window.document.getElementById("frame_" + objId).contentWindow;
    //alert(obj);
    obj.enlarge();

}
//缩小DIV
function shrinkDiv(objId) {

    var obj = window.document.getElementById("frame_" + objId).contentWindow;
    //alert(obj);
    obj.shrink();

}

//摄像头控制
function CameraControlDiv(objId, direct) {

    alert(direct);
    var obj = window.document.getElementById("frame_" + objId).contentWindow;
    //alert(obj);
    obj.requestControl(direct);
}

//###############################创建并设定div的参数#################end
/**
 *  
 **************div拖动方法***********
 * 
 * */
var getCoords = function (el) {
    var box = el.getBoundingClientRect(),
    doc = el.ownerDocument,
    body = doc.body,
    html = doc.documentElement,
    clientTop = html.clientTop || body.clientTop || 0,
    clientLeft = html.clientLeft || body.clientLeft || 0,
    top = box.top + (self.pageYOffset || html.scrollTop || body.scrollTop) - clientTop,
    left = box.left + (self.pageXOffset || html.scrollLeft || body.scrollLeft) - clientLeft
    return { 'top': top, 'left': left };
};
var Drag = function (id) {
    var el = document.getElementById(id),
    options = arguments[1] || {},
    container = options.container || document.documentElement,
    limit = false || options.limit,
    lockX = false || options.lockX,
    lockY = false || options.lockY;
    el.style.position = "absolute";
    var drag = function (e) {
        e = e || window.event;
        el.style.cursor = "pointer";
        !+"\v1" ? document.selection.empty() : window.getSelection().removeAllRanges();
        var _left = e.clientX - el.offset_x,
        _top = e.clientY - el.offset_y;
        if (limit) {
            var _right = _left + el.offsetWidth,
            _bottom = _top + el.offsetHeight,
            _cCoords = getCoords(container),
            _cLeft = _cCoords.left,
            _cTop = _cCoords.top,
            _cRight = _cLeft + container.clientWidth,
            _cBottom = _cTop + container.clientHeight;
            _left = Math.max(_left, _cLeft);
            _top = Math.max(_top, _cTop);
            if (_right > _cRight) {
                _left = _cRight - el.offsetWidth;
            }
            if (_bottom > _cBottom) {
                _top = _cBottom - el.offsetHeight;
            }
        }
        if (lockX) {
            _left = el.lockX;
        }
        if (lockY) {
            _top = el.lockY;
        }
        el.style.left = _left + "px";
        el.style.top = _top + "px";
        //el.innerHTML = parseInt(el.style.left,10)+ " x "+parseInt(el.style.top,10);
    }

    var dragend = function () {
        el.childNodes[2].childNodes[0].style.display = "none";//拖动时鼠标离开title栏至iframe失效问题；
        document.onmouseup = null;
        document.onmousemove = null;
        zIndex_i = el.style.zIndex;
    }

    var dragstart = function (e) {
        el.childNodes[2].childNodes[0].style.display = "block";//拖动时鼠标离开title栏至iframe失效问题；
        e = e || window.event;
        if (lockX) {
            el.lockX = getCoords(el).left;
        }
        if (lockY) {
            el.lockY = getCoords(el).top;
        }
        if (/a/[-1] == 'a') {
            el.offset_x = e.layerX
            el.offset_y = e.layerY
        } else {
            el.offset_x = e.offsetX
            el.offset_y = e.offsetY
        }
        document.onmouseup = dragend;
        document.onmousemove = drag;
        el.style.zIndex = ++Drag.z;
        return false;
    }
    Drag.z = zIndex_i;//999;
    el.onmousedown = dragstart;
}


//###########################################add by xuhj end############################################





function VideoCallFuction(eventX, eventY, calltype, cameraname, width, height, lq_id, zindex, newwindows, src) {//增加eventX，eventY鼠标点击位置 add by xuhj  20151105
    var div = document.getElementById(calltype);
    var ifr = document.getElementById(calltype + "_ifr");
    if (!newwindows) {
        var hrsrc = "lqnew/opePages/" + calltype + ".aspx?time=1";
    }
    else {
        var hrsrc = "lqnew/opePages/" + calltype + ".aspx?time=" + TimeGet();
    }
    if (src) {
        hrsrc = src;
    }
    if (!div) {
        //  creatprossdiv();
        // checkOpen(calltype);
        if (!lq_id) { lqopen_newVideoDrownFrame(eventX, eventY, calltype, cameraname, document.body, hrsrc, width, height); }
        else { lqopen_newVideoDrownFrame(eventX, eventY, calltype, cameraname, document.body, hrsrc + "&id=" + lq_id, width, height); }

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

function lqdivCenter(div) {
    div.style.left = (parseFloat(document.body.offsetWidth) - parseFloat(div.style.width)) / 2 + "px";
    div.style.top = (parseFloat(window.screen.availHeight) - parseFloat(div.style.height)) / 2 + "px";
}

