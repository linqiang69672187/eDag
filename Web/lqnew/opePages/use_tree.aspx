<%@ Page Language="C#" AutoEventWireup="true" MaintainScrollPositionOnPostback="true"
    EnableViewState="true" CodeBehind="use_tree.aspx.cs" Inherits="Web.lqnew.opePages.use_tree" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style>
        .tree td div
        {
            height: 20px !important;
        }

        body
        {
            background-color: transparent;
            margin: 0px;
            scrollbar-face-color: #DEDEDE;
            scrollbar-base-color: #F5F5F5;
            scrollbar-arrow-color: black;
            scrollbar-track-color: #F5F5F5;
            scrollbar-shadow-color: #EBF5FF;
            scrollbar-highlight-color: #F5F5F5;
            scrollbar-3dlight-color: #C3C3C3;
            scrollbar-darkshadow-color: #9D9D9D;
            color: #CCCCCC;
        }

        #tableFrameTitle ul
        {
        }

            #tableFrameTitle ul li
            {
                background: gray;
                text-align: center;
                color: #fff;
            }

        /* 表格内容*/
        #tableCase ul
        {
        }

            #tableCase ul li
            {
            }

        /* 单个表格特定样式*/
        .tableCaseThree
        {
            color: #329A02;
        }

        .tableCaseFive
        {
            color: #f00;
        }

        .tableCaseSeven
        {
            color: #f00;
        }

        .style1
        {
            width: 131px;
            height: 25px;
        }

        .style2
        {
            width: 31px;
            height: 20px;
        }
        #usertreebg
        {
            width: 100%;
            display: none;
            position: absolute;
            vertical-align: middle;
            line-height: 100px;
            z-index: 2000;
        }
    </style>
    <script src="../../JQuery/jquery-1.5.2.js" type="text/javascript"></script>

    <script src="../js/GlobalVar.js" type="text/javascript"></script>
    <script src="../js/GlobalConst.js" type="text/javascript"></script>
    <script src="../../WebGis/js/model/LayerManager.js" type="text/javascript"></script>
        <script src="../js/mark.js" type="text/javascript"></script>
    <script src="../js/Cookie.js" type="text/javascript"></script>
    <script src="../js/MouseMenu.js" type="text/javascript"></script>
    <script src="../js/MouseMenuEvent.js" type="text/javascript"></script>
    <script src="../../JS/LangueSwitch.js" type="text/javascript"></script>
    <script type="text/javascript">
        // 点击复选框时触发事件

        function postBackByObject() {
            var o = window.event.srcElement;
            if (o.tagName == "INPUT" && o.type == "checkbox") {
                Displayprocessbar();
                __doPostBack("UpdatePanel1", "");
            }
        }
        function FindCheckBox(EntityId, inde) {
            //var YellowNodes = "";
            var EntityIds = EntityId.split(",");
            var EntitySpan = document.getElementsByTagName("SPAN");
            for (var i = 0; i < EntitySpan.length; i++) {
                for (var j = 0; j < EntityIds.length - 1; j++) {
                    if (EntitySpan[i].selID == EntityIds[j]) {
                        var EntityCheckBox = EntitySpan[i].previousSibling.parentNode.previousSibling;
                        if (EntityCheckBox != null && (EntityCheckBox.tagName == "INPUT" && EntityCheckBox.type == "checkbox")) {
                            if (inde == "Yes") {
                                EntityCheckBox.style.backgroundColor = "yellow";
                                //YellowNodes += EntityIds[j] + ",";
                            }
                            else {
                                EntityCheckBox.style.backgroundColor = "white";
                            }
                        }
                    }
                }
            }
            if (inde == "Yes") {
                //document.cookie = "YellowNodes=" + YellowNodes;
            }
            EntitySpan = null;
            EntityCheckBox = null;
        }
        function RememberLastYellowCheckBox(ThisYellowId, ThisWhiteEntityId) {
            var LastYellowNode;
            LastYellowNode = Cookies.get("YellowNodes");
            if (LastYellowNode == null || LastYellowNode == ThisYellowId) {
                return;
            }
            if (ThisWhiteEntityId != "") {
                var ThisWhiteEntityIds;
                ThisWhiteEntityIds = ThisWhiteEntityId.split(",");
            }
            var LastYellowNodes = LastYellowNode.split(",");
            var EntitySpan = document.getElementsByTagName("SPAN");
            for (var i = 0; i < EntitySpan.length; i++) {
                for (var j = 0; j < LastYellowNodes.length - 1; j++) {
                    var IsChange = 0;
                    if (ThisWhiteEntityId != "") {
                        IsChange = YellowNodeIsChanged(LastYellowNodes, ThisWhiteEntityIds);
                    }
                    if (IsChange == 0) {
                        if (EntitySpan[i].selID == LastYellowNodes[j]) {
                            var EntityCheckBox = EntitySpan[i].previousSibling.parentNode.previousSibling;
                            if (EntityCheckBox != null && (EntityCheckBox.tagName == "INPUT" && EntityCheckBox.type == "checkbox")) {
                                EntityCheckBox.style.backgroundColor = "yellow";
                            }
                        }
                    }
                }
            }
            EntitySpan = null;
            EntityCheckBox = null;
        }
        function YellowNodeIsChanged(LastYellowNodes, ThisWhiteEntityIds) {
            var IsChange = 0;
            for (var k = 0; k < LastYellowNodes.length - 1; k++) {
                for (var s = 0; s < ThisWhiteEntityIds.length - 1; s++) {
                    if (LastYellowNodes[k] == ThisWhiteEntityIds[s]) {
                        IsChange = 1;
                        return IsChange;
                    }
                }
            }
            return IsChange;
        }
        function GetYellowCheckBox() {
            var YellowNodes = "";
            var EntityCheckBox = document.getElementsByTagName("INPUT");
            for (var i = 0; i < EntityCheckBox.length; i++) {
                if (EntityCheckBox[i].type == "checkbox") {
                    if (EntityCheckBox[i].checked == true) {
                        continue;
                    }
                    else {
                        if (EntityCheckBox[i].style.backgroundColor == "yellow") {
                            YellowNodes += EntityCheckBox[i].nextSibling.lastChild.selID + ",";
                        }
                    }
                }
            }
            document.cookie = "YellowNodes=" + YellowNodes;
            EntityCheckBox = null;
        }
        function SetCookieNone() {
            document.cookie = "YellowNodes=" + "";
        }
        function Hideprocessbar() {
            var processbar = window.parent.parent.parent.document.getElementById("processbar");
            if (processbar) {
                processbar.style.display = "none";
            }
            var usertreebg = document.getElementById("usertreebg");
            if (usertreebg) {
                usertreebg.style.display = "none";
            }
        }
        function Displayprocessbar() {
            var processbar = window.parent.parent.parent.document.getElementById("processbar");
            if (processbar) {
                processbar.style.display = "block";
            }
            var usertreebg = document.getElementById("usertreebg");
            if (usertreebg) {
                usertreebg.style.height = document.body.scrollHeight;
                usertreebg.style.display = "block";
            }
        }
</script>
</head>
<body>    
    <form id="form1" runat="server">
        <div>
            <div id="usertreebg" style="background-color:#CDCBCC;"></div>
        <div>
            <%--<asp:UpdateProgress ID="UpdateProgress1" AssociatedUpdatePanelID="UpdatePanel1" runat="server"></asp:UpdateProgress>--%>
            <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
            <asp:UpdatePanel ID="UpdatePanel1" OnLoad="UpdatePanel1_Load" runat="server">
                <ContentTemplate>
            <asp:TreeView ID="TreeView_Police" runat="server" ShowLines="True" CssClass="tree" NodeStyle-Width="100%"
            PopulateNodesFromClient="False" LineImagesFolder="~/TreeLineImages" Font-Size="12px"
            ForeColor="Black" NodeIndent="5" CollapseImageToolTip="" ExpandImageToolTip=""
            ExpandDepth="1" OnTreeNodeCheckChanged="TreeView_Police_TreeNodeCheckChnaged">
        </asp:TreeView>
                    </ContentTemplate>
            </asp:UpdatePanel>
        </div>
            </div>
    </form>
</body>
<script type="text/javascript">
    //鼠标点击事件
    //window.onload = function () {          
    //    MouseMenu(window.parent.parent.parent, "a", "policemouseMenu");
    //}
   
    function backcolor(obj) {
        obj.style.backgroundColor = "transparent";
        obj.style.color = "#000000";
    }
    function changebgcolor(obj) {
        obj.style.backgroundColor = "#0d9e1b";
        obj.style.color = "#ffffff";
    }
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

        window.parent.parent.parent.useprameters.GPSUpdatetime = myDate.getFullYear() + "-"  + (parseInt(myDate.getMonth()) + 1) + "-" + myDate.getDate() + "  " + myHours + ":" + myMin;//多语言：年、月、日
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
            alldevices =[]
            alldevices=alldevices.concat(devices[1], lastdevices);
            alldevices = unique(alldevices);  //所有在线及下线终端
            onlinedevices = devices[1];  
            ChangeDevices();//更改现在终端
            
            ChangeDevices();
           
        });
    }

    var nowdevicescount = 0; 
    var offdevicescount = 0;
    var alldevices=[]; //所有终端
    var lastdevices=[];//上次在线终端
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
     
        var newonline = 0 ;
        var newoffline = 0;
        for (var i = 0; i < alldevices.length && i < 101; i++) {

            for (var de = 0; de < lastdevices.length ; de++) {
                if (lastdevices[de]== alldevices[i])  //是上次在线终端
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
    ID = setInterval("myrefresh()",600000);
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
    var lastid = 0;
    function GetDevicestatus(id) {
       
        //if (id != lastid) {
        //    HiddenDevicestatus(lastid);
        //}
        //lastid = id;
        //window.parent.parent.parent.getNewData_ajaxGpstotal("WebGis/Service/getdevicestatus_useid.aspx", { id: id }, function (devices) {
           
        //    if (!devices)
        //        return;
        //    if (devices.value > 0) {
        //        var obj = document.getElementById('onlineuse' + devices.id);
        //        if (obj) {
        //            obj.style.visibility = "visible";
        //        }
        //    }
        // });
    }
    function HiddenDevicestatus(id) {
        //var obj = document.getElementById('onlineuse' + id);
        //if (obj) {
        //    obj.style.visibility = "hidden";
        //}
    }
</script>
</html>
