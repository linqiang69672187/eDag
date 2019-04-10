<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="mztreeResPermission.aspx.cs" Inherits="Web.lqnew.opePages.mztreeResPermission"%>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
 <base target="_self" />
    <title></title>
    <script src="../../JQuery/jquery-1.5.2.js" type="text/javascript"></script>
    <script src="../../MyCommonJS/ajax.js"></script>
        <script src="mztreeviewJS/jsframework.js"></script>
  
        <script src="../js/mark.js" type="text/javascript"></script>
    <script src="../js/Cookie.js" type="text/javascript"></script>
    <script src="../js/MouseMenu.js" type="text/javascript"></script>
    <script src="../js/MouseMenuEvent.js" type="text/javascript"></script>
    <script src="../../JS/LangueSwitch.js" type="text/javascript"></script>
    <script>
        function getpolicebyentityandtype(objtype,entityid,typeid) {

        }
    </script>
</head>
<body style="width:1000px">
    <script type="text/javascript">
        window.onload = function () {
            try {
                window.parent.hideUsertreeProcessImg()
            }
            catch (e) { }
            //获取调度台所载单位id,定义为全局变量
            dispatchentityid = Cookies.get("id");
            //dispatchentityid = 1;
            //隐藏单位列表
            var entityTreediv = document.getElementById("entityTree");
            entityTreediv.style.display = "none";
            a.expand(1);
            var enroot = a.getNodeById("entityroot");
            if (enroot != null) {
                //a.expand("entityroot");
                enroot.expandAll();
                
                a.expand("entity" + dispatchentityid);
            }
            
            //a.expand("entity" + dispatchentityid);
            
            //显示单位列表
            entityTreediv.style.display = "block";            
            policelists_div_default = document.getElementById();
            
        }
        document.oncontextmenu = function () {
            
            return false;
        }
    </script>
    <div id="entityTree" style="width:100%">
<%--     <input type="button" value="expandall" onclick="a.expandAll('entity1')"/>
        <input type="button" value="collapseAll" onclick="a.collapseAll('entity1')" />--%>
<%--        <input type="button" value="expand" onclick="a.expand(1)"/>
    <input type="button" value="focus" onclick="a.focus('entity6')"/>--%>
        <script type="text/javascript" >
            //createmztree_entity
            //多语言化
            //单位列表
            var entitylist = window.parent.parent.parent.GetTextByName("Lang_entitylist", window.parent.parent.parent.useprameters.languagedata);
                var data = {};
                data["-1_1"] = "text:" + entitylist + ";isCheckbox:false;display:none;url:javascript\:";
                var xmlstr_EntityandType = '<%=strEntityandType%>';
                Using("System.Web.UI.WebControls.MzTreeView");
                var a = new MzTreeView();
                a.dataSource = data;
                a.loadXmlDataString(xmlstr_EntityandType, 1);
                a.wordLine = true;
                a.showLines = true;
                a.autoSort = false;
                a.useCheckbox = true
                a.canOperate = true;
                document.write(a.render());

                MzDataNode.prototype.DTO = function (DataNodeClass, sourceIndex) {
                    var C = DataNodeClass || MzDataNode, $ = this.$$caller, d = $.divider, n = new C, s;
                    n.$$caller = this.$$caller; s = $.dataSource[n.sourceIndex = sourceIndex];
                    n.id = sourceIndex.substr(sourceIndex.indexOf(d) + d.length);
                    n.hasChildNodes(); n.text = s.getAttribute("text");
                    n.parentNode = this; $.nodes[n.index] = n; n.path = this.path + d + n.id;
                    $.dataSource[sourceIndex] = s.setAttribute("index_" + $.hashCode, n.index);
                    if (s.getAttribute("isCheckbox") == "true") {
                        n.hasCheckbox = true;
                    }
                    else {
                        n.hasCheckbox = false;
                    }
                    n.checkStatus = -1;
                    var s_childrenids = s.getAttribute("childrenids");
                    if (s_childrenids != null && s_childrenids != "") {
                        n.childrenids = s_childrenids;
                    }
                    return n;
                };
             //private: single node build to HTML
             MzTreeNode.prototype.render = function (last) {
                 var $ = this.$$caller, s = $.dataSource[this.sourceIndex], target, data, url;
                 var icon = s.getAttribute("icon");
                 if (!(target = s.getAttribute("target"))) target = $.getDefaultTarget();
                 var hint = $.showToolTip ? s.getAttribute("hint") || this.text : "";
                 if (!(url = s.getAttribute("url")))
                     url = $.getDefaultUrl();
                 if (data = s.getAttribute("data")) url += (url.indexOf("?") == -1 ? "?" : "&") + data;
                 var p = s;
                 var id = this.index, s = "";
                 var isRoot = this.parentNode == $.rootNode;

                 if (isRoot && $.convertRootIcon && !icon) icon = "root";
                 if (!isRoot) this.childPrefix = this.parentNode.childPrefix + (last ? ",ll" : ",l4");
                 if (!icon || typeof (MzTreeView.icons.collapse[icon]) == "undefined")
                     this.icon = this.hasChild ? "folder" : "file"; else this.icon = icon;
                 this.line = this.hasChild ? (last ? "pm2" : "pm1") : (last ? "l2" : "l1");
                 if (!$.showLines) this.line = this.hasChild ? "pm3" : "ll";

                 if (p.getAttribute("display") == "none") { s += "<div><table border='0' cellpadding='0' cellspacing='0' style='display: none;'>"; }
                 else {
                     s += "<div><table border='0' cellpadding='0' cellspacing='0'>";
                 }
                  s += "<tr title='" + hint + "'><td>"; if (MzTreeNode.htmlChildPrefix)
                          s += MzTreeNode.htmlChildPrefix + "</td><td>";
                 if (!isRoot)
                     s += "<img border='0' id='" + $.index + "_expand_" + id + "' src='" +
                          (this.hasChild ? MzTreeView.icons.collapse[this.line].src :
                          MzTreeView.icons.line[this.line].src) + "'>"; if ($.showNodeIcon)
                              s += "<img border='0' id='" + $.index + "_icon_" + id + "' src='" +
                                   MzTreeView.icons.collapse[this.icon].src + "'>";
                 if ($.useCheckbox) {
                     if (this.hasCheckbox) {
                         s += "<img border='0' id='" + $.index + "_checkbox_" + id + "' src='" + MzTreeView.icons.line["c" + (this.checked ? 1 : 0)].src + "'>";
                         
                     }
                 }
                 s += "</td><td style='padding-left: 3px' nowrap='true'><a href='" + url +
           "' target='" + target + "' id='" + $.index + "_link_" + id + "' class='MzTreeView'";
                 if (p.getAttribute("color")) {
                     s += "style='color:" + p.getAttribute("color") + "'";
                 }
                 s += ">" + this.text + "</a></td>";
                 if (p.getAttribute("hasTerminal") == "true") {
                     s += "<td><img id='" + $.index + "_terminal_" + id + "' src='" + MzTreeView.icons.terminal["t1"].src + "'></td>";
                 }
                 if (p.getAttribute("isMouseMenu") == "true") {
                     s += "<td style='padding-left: 10px'><img id='" + $.index + "_mouseMenu_" + id + "' src='" + MzTreeView.icons.mouseMenu["m1"].src + "'></td>";
                 }
                 if(this.id.replace(/[^a-z,A-Z]/ig, "") == "entity"){
                     s += "<td class='onlinedevice' entityID='" + this.childrenids + "'></td>";
                 }
                 if (this.id.replace(/[^a-z,A-Z]/ig, "") == "zhishuuser") {
                     s += "<td class='onlinedevice' entityID='[" + this.id.replace(/[^0-9]/ig, "") + "]'></td>";
                 }
                 s += "</tr></table><div ";

                 if (isRoot && this.text == "") s = "<div><div ";
                 s += "id='" + $.index + "_tree_" + id + "' style='display: none;'></div></div>";

                 return s;
             };
                //节点单击事件
                MzTreeView.prototype.clickHandle = function (e) {
                    e = window.event || e; var B;
                    e = e.srcElement || e.target;
                    if (B = (e.id && 0 == e.id.indexOf(this.index + "_"))) {
                        var n = this.currentNode = this.nodes[e.id.substr(e.id.lastIndexOf("_") + 1)];
                    }
                    switch (e.tagName) {
                        case "IMG":
                            if (B) {
                                if (e.id.indexOf(this.index + "_expand_") == 0) {
                                    n.expanded ? n.collapse() : n.expand();
                                }
                                else if (e.id.indexOf(this.index + "_icon_") == 0) {
                                    n.focus();
                                }
                                    //click checkbox
                                else if (e.id.indexOf(this.index + "_checkbox_") == 0) {
                                    //设置checkbox、获取选中单位id
                                    check_upcheck_getids(n,this);
                                }
                                else if (e.id.indexOf(this.index + "_mouseMenu_") == 0) {

                                }
                            }
                            break;
                            //click entity
                        case "A":
                            if (B) {
                                n.focus();
                                this.dispatchEvent(new System.Event("onclick"));
                                //获取警员
                                if (n.id != 1) {
                                    displaypolicelists(n);
                                }
                            }
                            break;
                        default:
                            if (System.ns) e = e.parentNode;
                            break;
                    }
                };
                //private: onTreeDoubleClick
                MzTreeView.prototype.dblClickHandle = function (e) {
                    e = window.event || e; e = e.srcElement || e.target;
                    if ((e.tagName == "A" || e.tagName == "IMG") && e.id && e.id.indexOf(this.index + "_checkbox_") != 0 && e.id.indexOf(this.index + "_expand_") != 0) {
                        e = this.nodes[e.id.substr(e.id.lastIndexOf("_") + 1)];
                        e.expanded ? e.collapse() : e.expand();
                        this.currentNode = e; this.dispatchEvent(new System.Event("ondblclick"));
                    }
                };
                //expandAll
                MzTreeNode.prototype.expandAll = function () {
                    if (this.hasChild && !this.expanded) this.expand();
                    var this_childNodes_length = this.childNodes.length;
                    for (var x = this.$$caller.index, i = 0; i < this_childNodes_length; i++) {
                        var node = this.childNodes[i];
                        //不展开直属
                        //if (node.id.replace(/[^a-z,A-Z]/ig, "") != "zhishuuser" && node.hasChild){
                        //展开所有
                        if (node.hasChild) {
                            setTimeout("Instance('" + x + "').nodes['" + node.index + "'].expandAll()", 1);
                        }
                    }
                };
                //private: check checkbox
                MzTreeNode.prototype.check = function (checked) {
                    var me = this, mtv = me.$$caller, mc = me.childNodes;
                    var chk;
                    if (chk = document.getElementById(mtv.index + "_checkbox_" + me.index)) {
                        chk.src = MzTreeView.icons.line["c" + ((me.checked = (checked == true)) ? 1 : 0)].src;
                    }
                    me.checkStatus = (checked == true) ? 1 : 0;
                    var nodetype = me.id.replace(/[^a-z,A-Z]/ig, "");
                    var str = 0;
                    str++;
                    
                        var mc_length = mc.length;
                        for (var i = 0; i < mc_length; i++) {
                            str = str + mc[i].check(checked);
                        }
                   
                    return str;
                };
                //private: set checkbox status on childNode has checked
                MzTreeNode.prototype.upCheck = function () {
                    var str = 1;
                    var node = this, mtv = node.$$caller, chk;
                    var node_parentnode = node.parentNode;
                    // && node_parentnode.hasCheckbox
                    if (node_parentnode) {
                        var node_parentnode_childNodes = node_parentnode.childNodes;
                        var node_parentNode_childNodes_length = node_parentnode_childNodes.length;
                        for (var i = 0; i < node_parentNode_childNodes_length; i++) {
                            if (node_parentnode_childNodes[i].checkStatus == 2 || node_parentnode_childNodes[i].checked != node.checked) {
                                while (node = node.parentNode) {
                                    str++;
                                    node.checked = false;
                                    node.checkStatus = 2;
                                    if (chk = document.getElementById(mtv.index + "_checkbox_" + node.index))
                                        chk.src = MzTreeView.icons.line["c2"].src;
                                }
                                return str;
                            }
                        }
                        node_parentnode.checked = this.checked;
                        node_parentnode.checkStatus = this.checked ? 1 : 0;
                        if (chk = document.getElementById(mtv.index + "_checkbox_" + node_parentnode.index)) {
                            chk.src = MzTreeView.icons.line["c" + (node_parentnode.checked ? 1 : 0)].src;
                        }
                        str++;
                        str = str + node_parentnode.upCheck();
                    }
                    
                    return str;
                };
                //expandById
                MzTreeView.prototype.expandById = function (id) {
                    var n; if (n = this.getNodeById(id)) n.expandById();
                };
                MzTreeNode.prototype.expandById = function () {
                    if (this.hasChild && !this.expanded) this.expand();                 
                    var parent_node = this.parentNode;
                    while (parent_node) {
                        parent_node.expand();
                        parent_node = parent_node.parentNode;
                    }
                };
                //public: getNode (has Builded) by sourceId
                MzData.prototype.getNodeById = function (id) {
                    if (id == this.rootId && this.rootNode.virgin) return this.rootNode;
                    var _ = this.get__(), d = this.dividerEncoding;
                    var reg = new RegExp("([^" + _ + d + "]+" + d + id + ")(" + _ + "|$)");
                    if (reg.test(this.indexes)) {
                        var s = RegExp.$1;
                        if (s = this.dataSource[s].getAttribute("index_" + this.hashCode))
                            return this.nodes[s];
                        else { System._alert("The node isn't initialized!"); return null; }
                    }
                    return null;
                };
                //获取选中单位id
                MzTreeView.prototype.getselectedentityids = function (id) {
                    var n; if (n = this.getNodeById(id)) {
                        var str = n.getselectedentityids();
                    }
                    return str;
                };   
                MzTreeNode.prototype.getselectedentityids = function () {
                    var selectedentityids = {};
                    selectedentityids.alone = "";
                    selectedentityids.cycle = "";
                    selectedentityids.usertype = "";
                    var me = this;
                        var mc = me.childNodes;
                        var me_childNodes_length = me.childNodes.length;
                        for (var i = 0; i < me_childNodes_length; i++) {
                            var child_Node = mc[i];
                            var nodetype_getentity = child_Node.id.replace(/[^a-z,A-Z]/ig, "");
                            if (nodetype_getentity == "zhishuuser" && child_Node.id != "zhishuuserroot" && child_Node.hasCheckbox && child_Node.checked) {
                                selectedentityids.alone += child_Node.id.replace(/[^0-9]/ig, "") + ",";
                            }
                            else if (nodetype_getentity == "zhishuuser" && (child_Node.checkStatus == 2 || (!child_Node.hasCheckbox) && child_Node.checked))
                            {
                                var child_usertype = child_Node.childNodes;
                                var child_usertype_length = child_usertype.length;
                                for (var j = 0; j < child_usertype_length;j++){
                                    var child_usertype_node = child_usertype[j];
                                    if (child_usertype_node.hasCheckbox && child_usertype_node.checked) {
                                        selectedentityids.usertype += child_Node.id.replace(/[^0-9]/ig, "") +":"+child_usertype_node.id.replace(/[^0-9]/ig, "") + ";";
                                    }
                                }
                            }
                            else if (nodetype_getentity == "entity" && child_Node.hasCheckbox &&  child_Node.checked) {
                                selectedentityids.cycle += child_Node.id.replace(/[^0-9]/ig, "") + ",";
                            }
                            else if (nodetype_getentity == "entity" && (child_Node.checkStatus == 2 || (!child_Node.hasCheckbox && child_Node.checked))) {
                                var return_selectedentityids = child_Node.getselectedentityids();
                                if (return_selectedentityids.alone != "") {
                                    selectedentityids.alone += return_selectedentityids.alone;
                                }
                                if (return_selectedentityids.cycle != "") {
                                    selectedentityids.cycle += return_selectedentityids.cycle;
                                }
                                if (return_selectedentityids.usertype != "") {
                                    selectedentityids.usertype += return_selectedentityids.usertype;
                                }
                            }
                        }
                    return selectedentityids;
                };                
                //click checkbox
                function check_upcheck_getids(n, mztreeobj) {

                    /**      检查特殊状态警员         **/
                    if (n.checked == true) {
                        var exIds = checkcall();
                        if (exIds != "0") {  //有特殊警员的情况

                            jquerygetNewData_ajax("getentityidsbyuserids.aspx", { userids: exIds }, function (msg) {
                                var entitys = ","+n.get("childrenids")+",";

                                for (var i = 0; i < msg.length; i++) {
                                    if (entitys.indexOf("["+msg[i]["Entity_ID"]+"]") >= 0) {
                                        alert(window.parent.parent.parent.GetTextByName("Lang_checkboxinerr", window.parent.parent.parent.useprameters.languagedata));
                                        return;
                                    }

                                }
                                CheckChildBox(n, mztreeobj); //更改CHECKBOX状态

                            });
                        }
                        else {
                            CheckChildBox(n, mztreeobj);//更改CHECKBOX状态
                        }

                    }
                    else {
                        CheckChildBox(n, mztreeobj);//更改CHECKBOX状态
                    }
                }

                function CheckChildBox(n, mztreeobj) {
                    //点击单位，checkbox联动，记录选中单位id
                    var value_img = n.id.replace(/[^0-9]/ig, "");
                    var type_img = n.id.replace(/[^a-z,A-Z]/ig, "");
                    var check_num = n.check(!n.checked);
                    var up_num = n.upCheck();
                    //alert(check_num + "+" + up_num);
                    //选中单位id
                    var SelectedEntity = "";
                    //单位全选
                    var entityroot = mztreeobj.getNodeById("entityroot");
                    var dispatchEntity_checkStatus = entityroot.checkStatus;
                    if (entityroot.hasCheckbox && dispatchEntity_checkStatus == 1) {
                        SelectedEntity = "";
                    }
                        //本调度台下单位全没选
                    else if (dispatchEntity_checkStatus == 0) {
                        SelectedEntity = "none";
                    }
                        //调度台根级单位部分选中
                    else if (dispatchEntity_checkStatus == 2 || (!entityroot.hasCheckbox && dispatchEntity_checkStatus == 1)) {
                        if (check_num >= 1 && up_num >= 1) {
                            var ids = mztreeobj.getselectedentityids("entityroot");
                            //alert("ids=" + ids);
                            if (ids!=null) {
                                SelectedEntity = ids.alone+"/"+ids.cycle+"/"+ids.usertype;
                            }
                            else {

                            }
                        }
                    }
                    //获取警员数据
                    var mainSWF = window.parent.parent.parent.document.getElementById("main");
                    if (mainSWF) {
                        mainSWF.callbackSendrefresh_post(SelectedEntity);
                    }

                    //alert("SelectedEntity=" + SelectedEntity);
                    //document.cookie = "SelectedEntity=" + SelectedEntity;
                    //alert(Cookies.get("SelectedEntity"));
                    //window.parent.parent.parent._StaticObj.objGet("LayerControl").refurbish_Post("SelectedEntity=" + SelectedEntity);

                }


                //click entity
                function displaypolicelists(n) {
                    displaypolicelistsdiv();
                    window.parent.parent.parent.frames["policelists"].getpolices(n);
                    if (policelists_div_default && policelists_div_default.style.display == "none") {
                        policelists_div_default.style.display = "block";
                    }
                   

                }
                function displaypolicelistsdiv(){
                    var policelistsdiv = window.parent.parent.parent.document.getElementById("policelistsdiv");
                    if(policelistsdiv){
                        policelistsdiv.style.display = "block";
                    }
                    var grouplistsdiv = window.parent.parent.parent.document.getElementById("grouplistsdiv");
                    if (grouplistsdiv) {
                        grouplistsdiv.style.display = "none";
                    }
                    var dispatchlistsdiv = window.parent.parent.parent.document.getElementById("dispatchlistsdiv");
                    if (dispatchlistsdiv) {
                        dispatchlistsdiv.style.display = "none";
                    }
                }
        </script>
        </div>

    <script type="text/javascript">
        function myrefresh() {
            var myDate = new Date();
            var myHours = myDate.getHours();
            if (myHours < 10) {
                myHours = "0" + myHours;
            }

            var myMin = myDate.getMinutes();
            if (myMin < 10) {
                myMin = "0" + myMin;
            }

            window.parent.parent.parent.useprameters.GPSUpdatetime = myDate.getFullYear() + "-" + (parseInt(myDate.getMonth()) + 1) + "-" + myDate.getDate() + "  " + myHours + ":" + myMin;//多语言：年、月、日
            window.parent.parent.parent.getNewData_ajaxGpstotal("WebGis/Service/Entity_DeviceStatus.aspx", "", function (devices) {
                window.parent.parent.parent.useprameters.onlineuse = 0;
                $(".onlinedevice").each(function () {
                    var online = 0;
                    var total = 0;
                    for (var i = 0; i < devices[0].length; i++) {
                        if (this.entityID.indexOf("[" + devices[0][i]["EntityID"] + "]") >= 0) {
                            total += parseInt(devices[0][i]["Total"]);
                            online += parseInt(devices[0][i]["Online"]);
                        }
                    }
                    window.parent.parent.parent.useprameters.onlineuse = (window.parent.parent.parent.useprameters.onlineuse < online) ? online : window.parent.parent.parent.useprameters.onlineuse;
                    this.innerHTML = "[" + online + "/" + total + "]";

                });
                //var elems = getElementsByClassName(document, "a", "onlineuse");
                //for (var i = 0; i < elems.length; i++) {
                //    setTimeout(function () { elems[i].style.visibility = "hidden"; }, 100);

                //}
                nowdevicescount = 0;
                offdevicescount = 0;
                alldevices = []
                alldevices = alldevices.concat(devices[1], lastdevices);
                alldevices = unique(alldevices);  //所有在线及下线终端
                onlinedevices = devices[1];
                ChangeDevices();//更改现在终端

            });
        }

        var nowdevicescount = 0;
        var offdevicescount = 0;
        var alldevices = []; //所有终端
        var lastdevices = [];//上次在线终端
        var onlinedevices = [];//在线终端

        function unique(data) {
            data = data || [];
            var a = {};
            for (var i = 0; i < data.length; i++) {
                var v = data[i];
                if (typeof (a[v]) == 'undefined') {
                    a[v] = 1;
                }
            };
            data.length = 0;
            for (var i in a) {
                data[data.length] = i;
            }
            return data;
        }

        function ChangeDevices() {

            var newonline = 0;
            var newoffline = 0;
            var alldeviceslength = alldevices.length;
            for (var i = 0; i < alldevices.length && i < 101; i++) {
                if (alldeviceslength == 0)
                    return;
                for (var de = 0; de < lastdevices.length ; de++) {
                    if (lastdevices[de] == alldevices[i])  //是上次在线终端
                    {
                        newonline = 1;
                        break;
                    }
                }

                if (newonline == 0) {    //是本次上线终端
                    var obj = document.getElementById('onlineuse' + alldevices[nowdevicescount + i]);
                    if (obj) {
                        obj.style.visibility = "visible";
                    }
                }     

                if (i + nowdevicescount >= alldevices.length) {
                    Changeoffdevices();
                    return;
                }
            }
            nowdevicescount += 100;
            setTimeout(function () {
                ChangeDevices();
            }, 10);
        }

        function Changeoffdevices() {

            var newoffline = 0;
            for (var i = 0; i < alldevices.length && i < 101; i++) {

                for (var de = 0; de < onlinedevices.length ; de++) {
                    if (onlinedevices[de] == alldevices[i])  //本次在线终端
                    {
                        newoffline = 1;
                        break;
                    }
                }

                if (newoffline == 0)       //是本次下线终端
                {
                    var obj = document.getElementById('onlineuse' + alldevices[offdevicescount + i]);
                    if (obj) {
                        obj.style.visibility = "hidden";
                    }
                }

                if (i + offdevicescount >= alldevices.length) {
                    lastdevices = onlinedevices;
                    return;
                }
            }
            offdevicescount += 100;
            setTimeout(function () {
                Changeoffdevices();
            }, 10)
        }

        //  ID = setInterval("myrefresh()", 60000 * window.parent.parent.parent.useprameters.device_timeout);
        ID = setInterval("myrefresh()", 600000);
        function cleartimer() {
            window.clearInterval(ID);
        }
        function resettimer(time) {
            cleartimer();
            ID = setInterval("myrefresh()", time * 1000 * 600);
        }
        document.body.onscroll = function () {
            //alert($(window).scrollTop());
        }
        function setrightvalue(id) {
            window.parent.parent.parent.useprameters.rightselectid = id;
            rightselecttype = 'cell';
        }

        function isinentity(entity, entityID) {//返回元素是否在数组中
            for (var i = 0; i < array.length; i++) {
                if (element == array[i])
                    return true;
            }
            return false;
        }
        function deviceovertime(date) {
            var timestr = new Date().format("yyyy/MM/dd hh:mm:ss").toLocaleString();
            if (dateDiff("M", date, timestr) > window.parent.parent.parent.useprameters.device_timeout) {
                return false;
            }
            else {
                return true;
            }
        }

        Date.prototype.format = function (format) {
            var o =
                {
                    "M+": this.getMonth() + 1, //month
                    "d+": this.getDate(), //day
                    "h+": this.getHours(), //hour
                    "m+": this.getMinutes(), //minute
                    "s+": this.getSeconds(), //second
                    "q+": Math.floor((this.getMonth() + 3) / 3), //quarter
                    "S": this.getMilliseconds() //millisecond
                }
            if (/(y+)/.test(format))
                format = format.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
            for (var k in o)
                if (new RegExp("(" + k + ")").test(format))
                    format = format.replace(RegExp.$1, RegExp.$1.length == 1 ? o[k] : ("00" + o[k]).substr(("" + o[k]).length));
            return format;
        }

        function dateDiff(interval, date1, date2) {
            var objInterval = { 'D': 1000 * 60 * 60 * 24, 'H': 1000 * 60 * 60, 'M': 1000 * 60, 'S': 1000, 'T': 1 };
            interval = interval.toUpperCase();
            var dt1 = Date.parse(date1.replace(/-/g, '/'));
            var dt2 = Date.parse(date2.replace(/-/g, '/'));
            try {
                return Math.round((dt2 - dt1) / eval('(objInterval.' + interval + ')'));
            } catch (e) {
                return e.message;
            }
        }
        //myrefresh();
        setTimeout(myrefresh, 60000);

        function getElementsByClassName(oElm, strTagName, strClassName) {
            var arrElements = (strTagName == "*" && oElm.all) ? oElm.all :
                oElm.getElementsByTagName(strTagName);
            var arrReturnElements = new Array();
            strClassName = strClassName.replace(/\-/g, "\\-");
            var oRegExp = new RegExp("(^|\\s)" + strClassName + "(\\s|$)");
            var oElement;
            for (var i = 0; i < arrElements.length; i++) {
                oElement = arrElements[i];
                if (oRegExp.test(oElement.className)) {
                    arrReturnElements.push(oElement);
                }
            }
            return (arrReturnElements);
        }
    </script>
    <script type="text/javascript">
        function checkcall() {
            
            var userids = "";
            var mainSWF = window.parent.parent.parent.document.getElementById("main");
            if (mainSWF) {
                userids = mainSWF.callbackCheckCall();
            }
            return userids;

            //是否有单呼
            if ($(window.parent.parent.parent.document.getElementById('ifr_callcontent_ifr').contentWindow.document.getElementById('call2')).css("backgroundImage").indexOf("callfinish.png") > 0 || $(window.parent.parent.parent.document.getElementById('ifr_callcontent_ifr').contentWindow.document.getElementById('call2')).css("backgroundImage").indexOf("receivecall.png") > 0) {
                userids += window.parent.parent.parent.useprameters.Selectid + ",";
            }
            var nowtrace = window.parent.parent.parent.useprameters.nowtrace;
            var nowtrace_length = nowtrace.length;
            if (nowtrace_length > 0) {
                for (var i = 0; i < nowtrace_length; i++) {
                    userids += nowtrace[i].item.split('|')[0] + ",";
                }
            }
            if (window.parent.parent.parent.useprameters.lockid != 0) {
                userids += window.parent.parent.parent.useprameters.lockid + ",";
            }
            userids += 0;
            return userids;
        }
   
        function hasCalluser(entityids, childrenids) {
            var entityids_length = entityids.length;
            for (var i = 0; i < entityids_length; i++) {

            }
        }
    </script>
</body>
</html>
