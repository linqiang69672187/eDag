<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="policelists.aspx.cs" Inherits="Web.lqnew.opePages.policelists" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link href="../css/lq_manager.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/pagestyle.css" rel="stylesheet" type="text/css" />
    <script src="../../MyCommonJS/ajax.js"></script>

    <script src="../js/mark.js" type="text/javascript"></script>
    <script src="../js/Cookie.js" type="text/javascript"></script>
    <script src="../js/MouseMenu.js" type="text/javascript"></script>
    <script src="../js/MouseMenuEvent.js" type="text/javascript"></script>
    <script src="../../JS/LangueSwitch.js" type="text/javascript"></script>
    <script src="../js/lq_newjs.js" type="text/javascript"></script>
    <style>
        .mytable {
            background-color: #C0DE98;
            border-color: White;
            border-width: 0px;
            border-style: Ridge;
            width: 307px;
        }
        
        .button-blue {
            height:20px;
            text-align:center;
            border-radius:5px;
            border:1px solid #000000;
            box-shadow:inset 0px 5px 4px #808492;
            background-color:#003D53;
            color:white;
        }
    </style>
</head>
<body style="font-size: 12px">
    <script type="text/javascript">
        //获取登陆用户的权限
        var ResPermissionEntityIds = {};
        window.onload = function () {
            //获取调度台所载单位id,定义为全局变量
            dispatchentityid = Cookies.get("id");
            //dispatchentityid = 1;

            //多语言化
            //search
            var Lang_searchpresent_value = window.parent.GetTextByName("Lang_searchpresent_value", window.parent.useprameters.languagedata);
            var Lang_searchpresent_title = window.parent.GetTextByName("Lang_searchpresent_title", window.parent.useprameters.languagedata);
            var Lang_searchpresent_input = document.getElementById("Lang_searchpresent");
            if (Lang_searchpresent_input) {
                Lang_searchpresent_input.value = Lang_searchpresent_value;
                Lang_searchpresent_input.title = Lang_searchpresent_title;
            }

            var Lang_searchall_value = window.parent.GetTextByName("Lang_searchall_value", window.parent.useprameters.languagedata);
            var Lang_searchall_title = window.parent.GetTextByName("Lang_searchall_title", window.parent.useprameters.languagedata);
            document.getElementById("Lang_searchall").value = Lang_searchall_value;
            document.getElementById("Lang_searchall").title = Lang_searchall_title;
            //鼠标点击事件                        
            //MouseMenu(window.parent, "img", "policemouseMenu");

            //获取登陆用户的权限            
            var loginUserId = Cookies.get("loginUserId");
            getResPermissionEntityIdsByUserId(loginUserId);
        }
        function getResPermissionEntityIdsByUserId(loginUserId)
        {
            
            var url= "../../Handlers/resPermissions/getResPermissionEntityIdsByUserIdForPolicelist.ashx";
            jquerygetNewData_ajax(url, { loginUserId: loginUserId}, function (msg) {
                try {
                    ResPermissionEntityIds = eval(msg);
                }
                catch (e) {
                    //alert("createpolicetable_ajax" + e);
                }
            });
            
        }
        function SeachToDivHeigth() {
            window.document.getElementById("policetree").style.height = "438px";

        }
        function CleckEntityToDivHeigth() {
            window.document.getElementById("policetree").style.height = "414px";
        }
        //
        window.onerror = killErrors;
        function killErrors() {
            return true;
        }
        

    </script>
    <form id="form1" runat="server">
        <div>
            <div id="processbar" style="width: 130px; position: absolute; margin-top: 28px; margin-left: 100px; z-index: 3000; font-size: large; display: none; color: red">
                <span id="Lang_loading"><%--加载中--%></span>......
            </div>
            <div id="closeimg" style="width: 14px; position: absolute; right: 0px; margin-top: 0px; z-index: 3000; cursor: hand" onclick="closepolicelists();">
                <img src="../img/infowindow_close.gif" />
            </div>
            <div id="policewindow">
                <div id="search" style="display: none">
                    <select id="searchselect"><%--<option id="Lang_all_searchoption" value="All"><%--全部--%></option>--%><option id="Lang_name_searchoption" value="Nam"><%--姓名--%></option>
                        <option id="Lang_number_searchoption" value="Num"><%--编号--%></option>
                        <option id="Lang_terminal_identification" value="ISSI"><%--终端号--%></option>
                    </select><input id="searchtextinput" type="text" value="" style="width: 100px;margin-left:3px;" />
                    <%--<input id="Lang_searchpresent" type="button" value="搜本单位" title="在选中的单位中搜索" onclick="searchpresententity()"/><br />--%>

                    <input id="Lang_searchall" type="button" class="button-blue" style="margin-left: 0px" value="<%--搜全站--%>" title="<%--在本调度台所有的下属单位中搜索--%>" onclick="searchallentity()" />
                </div>
                <div id="searchinfo" style="display: none"></div>
                <div id="pagediv" style="display: none">
                    <table id="pagetable">
                        <tr>
                            <td>
                                <table>
                                    <tr>
                                        <td id="Lang_firstpage" style="width: 50px"><%--首页--%></td>
                                        <td id="Lang_prepage" style="width: 50px"><%--上一页--%></td>
                                        <td id="Lang_nextpage" style="width: 50px"><%--下一页--%></td>
                                        <td id="Lang_lastpage" style="width: 50px"><%--尾页--%></td>
                                        <td>
                                            <select id="pageselect">
                                                <option value="1">1</option>
                                            </select></td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <table>
                                    <tr>
                                        <td id="Lang_pagenum"><%--页数--%></td>
                                        <td id="totalpages"></td>
                                        <td></td>
                                        <td id="Lang_policenum"><%--条数--%></td>
                                        <td id="totalcounts" colspan="2"></td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </div>
                <div id="presententitydiv" style="margin-top: 2px; display: none">
                    <table>
                        <tr>
                            <td id="Lang_Unit"><%--单位--%></td>
                            <td>:</td>
                            <td id="presententitytd"></td>
                        </tr>
                    </table>
                </div>
                <div id="policetitlediv" style="width: 99%; margin-top: 2px; margin-left: 1px; text-align: center; display: none;">
                    <table cellspacing="1" cellpadding="0" id="GridView1" style="background-color: #C0DE98; border-color: White; border-width: 0px; border-style: Ridge; width: 307px;">
                        <tr class="gridheadcss" style="font-weight: bold;">
                            <th id="Lang_name" style="width: 50px"><%--姓名--%></th>
                            <th id="Th1" style="width: 13px"><%--姓名--%></th>
                            <th id="Lang_ISSI" style="width: 49px"><%--终端号--%></th>
                            <th id="Lang_style" style="width: 38px"><%--类型--%></th>
                            <th id="Lang_Isdisplay" style="width: 4px"><%--显示--%></th>
                            <th id="Lang_Location" style="width: 40px"><%--定位--%></th>
                            <th id="Lang_Operate" style="width: 45px"><%--操作--%></th>

                        </tr>
                    </table>
                </div>
                <div id="policetree" style="width: 99%; height: 414px; overflow: auto; margin-top: 1px; margin-left: 1px; display: none">
                    <table id="policetable" style="display: none">
                    </table>
                </div>
                <script type="text/javascript">
                    document.onkeypress = function () {
                        var search_input = document.getElementById("searchtextinput");
                        if (search_input) {
                            if (event.keyCode == 13 && document.activeElement.id == "searchtextinput") {
                                if (search_input.value != "") {
                                    var search_button = document.getElementById("Lang_searchall");
                                    if (search_button) {
                                        search_button.click();

                                    }
                                }
                                return false;//yuchenchao2018724ie11兼容
                            }
                        }
                    }
                    function searchpresententity() {
                        var searchtype = document.getElementById("searchselect").value;
                        var searchtext = document.getElementById("searchtextinput").value;
                        if (searchtext != "") {

                            var searchinentityid = document.getElementById("presententitytd").CI;
                            Displayprocessbar();

                            createpolicetable_ajax("search", searchtype + "/" + searchtext, searchinentityid);
                        }
                        else {
                            //请输入搜索内容
                            var pleaseinput = window.parent.GetTextByName("Lang_pleaseinput", window.parent.useprameters.languagedata);
                            alert(pleaseinput);
                            return;
                        }
                    }
                    function searchallentity() {
                        var searchtype = document.getElementById("searchselect").value;
                        var searchtext = document.getElementById("searchtextinput").value;
                        if (searchtext != "" && searchtext.indexOf('\'') == -1) {

                            Displayprocessbar();
                            createpolicetable_ajax("search", searchtype + "/" + searchtext, "");
                        }
                        else {
                            //请输入搜索内容
                            var pleaseinput = window.parent.GetTextByName("Lang_pleaseinput", window.parent.useprameters.languagedata);
                            alert(pleaseinput);
                        }
                    }
                    function setrightvalue(id, issi, terminalType,status) {
                        window.parent.useprameters.rightselectid = id;
                        window.parent.useprameters.rightselectissi = issi;
                        window.parent.useprameters.rightselectTerminalType = terminalType;
                        window.parent.useprameters.rightselectTerminalIsValide = status;
                        rightselecttype = 'cell';
                    }
                    function getpolices(text,id) {
                        presententityname = text;
                        presententityid = id;

                        /***
                        var value = n.id.replace(/[^0-9]/ig, "");
                        var type = n.id.replace(/[^a-z,A-Z]/ig, "");
                        var usertype_entityid = "";
                        if (type == "usertype") { usertype_entityid = n.sourceIndex.split("_")[0].replace(/[^0-9]/ig, ""); var value = n.text; }
                        //var iframe_policeusers = document.getElementById("policeusers").src = "policetree.aspx?objtype=" + type + "&value=" + value + "&usertype_entityid=" + usertype_entityid;

                        if (n.id != 1) {
                            //判断点击单位是否为调度台下属单位
                            //if (n.path.indexOf("_entity" + dispatchentityid + "_") >= 0 || n.path.substr(n.path.lastIndexOf("_")) == "_entity" + dispatchentityid)
                                //判断点击单位是否在自己权限里
                                if (n.hasCheckbox)
                            {
                                if (type == "entity") {
                                    presententityname = n.text;
                                    presententityid = n.id.replace(/[^0-9]/ig, "");
                                }
                                if (type == "zhishuuser") {
                                    presententityname = n.parentNode.text;
                                    presententityid = n.parentNode.id.replace(/[^0-9]/ig, "");
                                }
                                if (type == "usertype") {
                                    presententityname = n.parentNode.parentNode.text;
                                    presententityid = n.parentNode.parentNode.id.replace(/[^0-9]/ig, "");
                                }
                                //processbar
                                Displayprocessbar();
                                //getdata
                                createpolicetable_ajax(type, value, usertype_entityid);
                            }
                            else {
                                notselfbrance();
                            }
                        }
                        **/
                    }
                    function createpolicetable_ajax(type, value, usertype_entityid) {
                        jquerygetNewData_ajax("policetree.aspx", { objtype: type, value: value, usertype_entityid: usertype_entityid }, function (msg) {
                            try {
                                //processbar
                                Hideprocessbar();

                                //判断权限
                                if (type == "search") {
                                    var police = eval(msg);
                                    if (police.length == 0) {
                                        nodata_ajax(type, usertype_entityid);
                                    }
                                    else {
                                        var policeInResPermission = [];
                                        for (var i = 0; i < police.length; i++) {
                                            if (isSearchResultPoliceInResPermission(police[i])) {
                                                policeInResPermission.push(police[i]);
                                            }
                                        }
                                        if (policeInResPermission.length == 0) {
                                            nodataInResPermission_ajax(type, usertype_entityid);
                                        }
                                        else {
                                            Allpolices = policeInResPermission;
                                            
                                                //有返回数据
                                           
                                                eachpagenum = 50;
                                                policenum = Allpolices.length;
                                                pagenum = Math.ceil(policenum / eachpagenum);
                                                presentpage = 1;
                                                value_type = type;
                                                displaypresentpagepolices();
                                            
                                        }
                                    }
                                }
                                else {
                                    Allpolices = eval(msg);

                                    //无返回结果
                                    if (Allpolices.length == 0) {
                                        nodata_ajax(type, usertype_entityid);
                                    }
                                        //有返回数据
                                    else {

                                        eachpagenum = 50;
                                        policenum = Allpolices.length;
                                        pagenum = Math.ceil(policenum / eachpagenum);
                                        presentpage = 1;
                                        value_type = type;
                                        displaypresentpagepolices();
                                    }
                                }
                            }
                            catch (e) {
                                //alert("createpolicetable_ajax" + e);
                            }
                        });
                    }
                    function displaypresentpagepolices() {
                        if (value_type == "search") {
                            hidepresententitydiv();
                            deletepolicedivcontenttables();
                            hidesearchinfo_div();
                            displaypolicewindow();
                            displaypolicetitlediv();
                            creatpolicetable();
                            createpagetables();
                            displaysearchdiv();
                            checklock();
                            SeachToDivHeigth();
                        }
                        else {
                            clearsearchtext();
                            deletepolicedivcontenttables();
                            hidesearchinfo_div();
                            displaypolicewindow();
                            createentitybelongtable();
                            displaypolicetitlediv();
                            creatpolicetable();
                            createpagetables();
                            displaysearchdiv();
                            checklock();
                            CleckEntityToDivHeigth();
                        }
                    }
                    function creatpolicetable() {
                        try {
                            var policetable = document.createElement("table");
                            policetable.id = "GridView1";
                            policetable.style.marginTop = "0px";
                            policetable.style.textAlign = "center";
                            policetable.cellPadding = "0";
                            policetable.cellSpacing = "1";
                            policetable.className = "mytable";
                            //判断是否是最后一页
                            if (presentpage == pagenum) {
                                var trnum = policenum - (pagenum - 1) * eachpagenum;
                            }
                            else {
                                var trnum = policenum > eachpagenum ? eachpagenum : policenum;
                            }
                            var indexstep = (presentpage - 1) * eachpagenum;
                            for (var i = 0; i < trnum; i++) {
                                var policetr = document.createElement("tr");
                                policetr.id = Allpolices[i + indexstep].id;
                                policetr.style.backgroundColor = "white";
                                policetr.onmouseover = function () {
                                    this.style.backgroundColor = "green";
                                }
                                policetr.onmouseout = function () {
                                    this.style.backgroundColor = "white";
                                }
                                //Nam
                                var policetd_Nam = document.createElement("td");

                                policetd_Nam.innerHTML = Allpolices[i + indexstep].Nam;
                                policetd_Nam.title = Allpolices[i + indexstep].Nam;
                                policetd_Nam.id = "Nam_" + Allpolices[i + indexstep].id;
                                policetd_Nam.style.width = "50px";
                                policetd_Nam.style.textAlign = "center";
                                policetd_Nam.style.cursor = "hand";
                                policetd_Nam.onclick = function () {
                                    window.parent.mycallfunction('view_info/view_user', 418, 415, this.id.split('_')[1]);//xzj--20190325--修改高度342改为415
                                }
                                policetr.appendChild(policetd_Nam);
                                //shoutai_picture
                                var policetd_shoutaipicture = document.createElement("td");
                                policetd_shoutaipicture.id = "picture_" + Allpolices[i + indexstep].ISSI;
                                policetd_shoutaipicture.style.width = "13px";
                                if (Allpolices[i + indexstep].isonline == "True" && Allpolices[i + indexstep].ISSI != "") {
                                    policetd_shoutaipicture.innerHTML = "<img src='../img/treebutton_on_15.gif'/>";
                                    var Lang_online = window.parent.GetTextByName("Lang_online", window.parent.useprameters.languagedata);
                                    policetd_shoutaipicture.title = Lang_online;
                                }
                                else if (Allpolices[i + indexstep].isonline == "False" && Allpolices[i + indexstep].ISSI != "") {
                                    policetd_shoutaipicture.innerHTML = "<img src='../img/treebutton_off_15.gif'/>";
                                    var Lang_unonline = window.parent.GetTextByName("Lang_unonline", window.parent.useprameters.languagedata);
                                    policetd_shoutaipicture.title = Lang_unonline;
                                }
                                policetr.appendChild(policetd_shoutaipicture);
                                //ISSI
                                var policetd_ISSI = document.createElement("td");
                                policetd_ISSI.innerHTML = Allpolices[i + indexstep].ISSI;
                                policetd_ISSI.style.width = "49px";
                                policetd_ISSI.style.textAlign = "center";
                                policetr.appendChild(policetd_ISSI);
                                //type
                                var policetd_type = document.createElement("td");
                                policetd_type.innerHTML = Allpolices[i + indexstep].type;
                                policetd_type.style.width = "38px";
                                policetd_type.style.textAlign = "center";
                                policetr.appendChild(policetd_type);
                                //isdisplay
                                var policetdIsDisplay = document.createElement("td");
                                policetdIsDisplay.id = "Isdisplay_" + Allpolices[i + indexstep].id;
                                policetdIsDisplay.CI = Allpolices[i + indexstep].ISSI;
                                policetdIsDisplay.style.width = "40px";
                                if (window.parent.useprameters.DisplayEnable == "1") {
                                    policetdIsDisplay.style.cursor = "hand";
                                    if (Allpolices[i + indexstep].IsDisplay == 'True' && Allpolices[i + indexstep].ISSI != "") {
                                        policetdIsDisplay.innerHTML = "<img src='../images/isinviewyes.png'/>";
                                        policetdIsDisplay.onclick = function () {
                                            if (window.parent.useprameters.lockid == this.id.split('_')[1]) {
                                                alert(window.parent.GetTextByName("PoliceLockUnHidden", window.parent.useprameters.languagedata));//多语言： 锁定状态禁止隐藏
                                                return;
                                            }
                                            changevisible(this.id, this.CI);
                                        }
                                    }
                                    else if (Allpolices[i + indexstep].IsDisplay == 'False' && Allpolices[i + indexstep].ISSI != "") {
                                        policetdIsDisplay.innerHTML = "<img src='../images/isinviewno.png'/>";
                                        policetdIsDisplay.onclick = function () {
                                            changevisible(this.id);

                                        }
                                    }
                                }
                                policetr.appendChild(policetdIsDisplay);
                                //定位
                                var policetd_locate = document.createElement("td");
                                policetd_locate.id = "Locate_" + Allpolices[i + indexstep].id;
                                policetdIsDisplay.CI = Allpolices[i + indexstep].ISSI;
                                policetd_locate.style.width = "40px";
                                if (Allpolices[i + indexstep].ISSI != "" && window.parent.useprameters.GPSEnable == "1") {
                                    policetd_locate.style.cursor = "hand";
                                    policetd_locate.innerHTML = "<img src='../../images/xz.gif'/>";
                                    policetd_locate.onclick = function () {
                                        var Isdisplay_td = document.getElementById("Isdisplay_" + this.id.split('_')[1]);
                                        var IsDisplay = Isdisplay_td.innerHTML.indexOf("isinviewyes");
                                        if (IsDisplay >= 0) {
                                            window.parent.locationbyUseid(this.id.split('_')[1]);
                                        }
                                        else {
                                            var hasHide = window.parent.GetTextByName("Lang_hasHide", window.parent.useprameters.languagedata);;
                                            alert(hasHide);
                                        }
                                    }
                                }
                                policetr.appendChild(policetd_locate);
                                //操作
                                var policetd_operate = document.createElement("td");
                                policetd_operate.id = "operate_" + Allpolices[i + indexstep].id;
                                policetd_operate.CI = Allpolices[i + indexstep].ISSI;
                                policetd_operate.terminalType = Allpolices[i + indexstep].terminalType;
                                policetd_operate.status = Allpolices[i + indexstep].status;
                                //policetd_operate.class = "hasLeftmenu";
                                policetd_operate.style.width = "45px";
                                if (Allpolices[i + indexstep].ISSI != "") {
                                    policetd_operate.innerHTML = "<img src='../img/treebutton2.gif'/>";
                                    policetd_operate.onclick = function () {
                                        //修改onclick事件------------------------------xzj--2018/4/18-------------------------
                                        window.parent.getUserStatusByISSI(this.CI);

                                        var hh = screen.availHeight - window.parent.document.documentElement.clientHeight;
                                        hh = hh > 0 ? hh : 0;
                                        window.parent.document.getElementById("contextmenu_container2").parentNode.style.display = "none";
                                        window.parent.document.getElementById("contextmenu_container").parentNode.style.display = "block";
                                        //window.parent.document.getElementById("contextmenu_container").parentNode.style.position = "static";
                                        window.parent.document.getElementById("contextmenu_container").parentNode.style.left = event.screenX + 40 + "px";
                                        window.parent.document.getElementById("contextmenu_container").parentNode.style.top = event.screenY - hh + "px";
                                        //window.parent.document.getElementById("contextmenu_container").style.display = "block";

                                        //setrightvalue(this.id.split('_')[1], this.CI, this.terminalType, this.status);
                                        //var obj = window.parent
                                        //var mainSWF = obj.document.getElementById("main");
                                        //if (mainSWF) {

                                        //    var id = this.id.split('_')[1];
                                        //    var trace = IsOpenRealtimeTracebydispatcher(obj, id);
                                        //    var lock = (obj.useprameters.lockid == id);
                                        //    var terminalType = this.terminalType;
                                        //    var concerned = Isconcernedbydispatcher(obj, id);
                                        //    var Isdisplay_td = document.getElementById("Isdisplay_" + id);
                                        //    var IsDisplay = Isdisplay_td.innerHTML.indexOf("isinviewyes") > 0;
                                           
                                        //    //alert("documentElement.clientHeight:" + window.parent.document.documentElement.clientHeight);
                                        //    //alert("screen.availHeight:" + screen.availHeight);
                                        //    var hh = screen.availHeight - window.parent.document.documentElement.clientHeight;
                                        //    hh = hh > 0 ? hh : 0;

                                        //    mainSWF.webRightClickHandler_user(trace, lock, id, this.CI, concerned, this.status, IsDisplay, event.screenX + 40, event.screenY-hh);
                                        //}
                                       // MouseMenu_onclick(window.parent, "policemouseMenu");
                                    }
                                }
                                policetr.appendChild(policetd_operate);

                                policetable.appendChild(policetr);
                            }
                            var policetree = document.getElementById("policetree");
                            policetree.appendChild(policetable);
                            policetree.style.display = "block";
                        }
                        catch (e) {
                            //alert("creatpolicetable" + e);
                        }
                    }
                    function createentitybelongtable() {
                        var presententity_td = document.getElementById("presententitytd");
                        presententity_td.innerHTML = presententityname;
                        presententity_td.CI = presententityid;
                        var presententity_div = document.getElementById("presententitydiv");
                        presententity_div.style.display = "block";
                    }
                    function hideentitybelongtable() {
                        var presententity_div = document.getElementById("presententitydiv");
                        if (presententity_div) {
                            presententity_div.style.display = "none";
                        }
                    }
                    function displaypolicetitlediv() {
                        document.getElementById("policetitlediv").style.display = "block";
                    }
                    function displaysearchdiv() {
                        document.getElementById("search").style.display = "block";
                    }
                    function displaypolicewindow() {
                        document.getElementById("policewindow").style.display = "block";
                    }
                    function createpagetables() {
                        try {
                            //if (policenum > eachpagenum) {
                            //首页
                            if (presentpage == 1) {
                                document.getElementById("Lang_firstpage").style.color = "gray";
                            }
                            else {
                                var firstpagetd = document.getElementById("Lang_firstpage");
                                firstpagetd.style.color = "black";
                                firstpagetd.style.cursor = "hand";
                                firstpagetd.onclick = function () {
                                    firstpage();
                                }
                            }
                            //上一页
                            if (presentpage == 1) {
                                document.getElementById("Lang_prepage").style.color = "gray";
                            }
                            else {
                                var prepagetd = document.getElementById("Lang_prepage");
                                prepagetd.style.color = "black";
                                prepagetd.style.cursor = "hand";
                                prepagetd.onclick = function () {
                                    prepage();
                                }
                            }
                            //下一页
                            if (presentpage == pagenum) {
                                document.getElementById("Lang_nextpage").style.color = "gray";
                            }
                            else {
                                var nextpagetd = document.getElementById("Lang_nextpage");
                                nextpagetd.style.color = "black";
                                nextpagetd.style.cursor = "hand";
                                nextpagetd.onclick = function () {
                                    nextpage();
                                }
                            }
                            //尾页
                            if (presentpage == pagenum) {
                                document.getElementById("Lang_lastpage").style.color = "gray";
                            }
                            else {
                                var lastpagetd = document.getElementById("Lang_lastpage");
                                lastpagetd.style.color = "black";
                                lastpagetd.style.cursor = "hand";
                                lastpagetd.onclick = function () {
                                    lastpage();
                                }
                            }
                            //页数                         
                            document.getElementById("totalpages").innerHTML = presentpage + "/" + pagenum;
                            //条数
                            if (presentpage != pagenum) {
                                document.getElementById("totalcounts").innerHTML = ((presentpage - 1) * eachpagenum + 1) + "-" + presentpage * eachpagenum + "/" + policenum;
                            }
                            else {
                                document.getElementById("totalcounts").innerHTML = ((presentpage - 1) * eachpagenum + 1) + "-" + policenum + "/" + policenum;
                            }
                            //转到
                            var pageselect = document.getElementById("pageselect");
                            if (pagenum != pageselect.children.length) {
                                pageselect.innerHTML = "";
                                for (var n = 1; n <= pagenum; n++) {
                                    var pageoption = document.createElement("option");
                                    pageoption.value = n;
                                    pageoption.innerHTML = n;
                                    pageselect.appendChild(pageoption);
                                }
                            }
                            pageselect.value = presentpage;
                            pageselect.onchange = function () {
                                presentpage = pageselect.value;
                                displaypresentpagepolices();
                            }
                            //显示pagetable
                            document.getElementById("pagetable").style.display = "block";
                            displaypagediv();
                            //}
                            // else {
                            //    hidepagediv();
                            //}
                        }
                        catch (e) {
                            //alert("createpage" + e);
                        }
                    }
                    function deletepolicedivcontenttables() {
                        try {
                            var policetree = document.getElementById("policetree");
                            policetree.innerHTML = "";
                        }
                        catch (e) {
                            //alert("deletepolicedivcontenttables" + e);
                        }
                    }
                    function firstpage() {
                        if (presentpage != 1) {
                            presentpage = 1;
                            displaypresentpagepolices();
                        }
                    }
                    function prepage() {
                        if (presentpage > 1) {
                            presentpage--;
                            displaypresentpagepolices();
                        }
                    }
                    function nextpage() {
                        if (presentpage < pagenum) {
                            presentpage++;
                            displaypresentpagepolices();
                        }
                    }
                    function lastpage() {
                        if (presentpage != pagenum) {
                            presentpage = pagenum;
                            displaypresentpagepolices();
                        }
                    }
                    function notselfbrance() {
                        deletepolicedivcontenttables();
                        //隐藏前面的div 
                        hidefrontdivs();
                        //清空数据
                        Allpolices = "";
                        eachpagenum = 0;
                        policenum = 0;
                        pagenum = 0;
                        presentpage = 0;
                        //该单位不是您的下级单位，你不能查看该单位的警员
                        //var Lang_notselfentity = window.parent.GetTextByName("Lang_notselfentity", window.parent.useprameters.languagedata);
                        //没有该单位的权限
                        var Lang_hasNoResPermission = window.parent.GetTextByName("Lang_hasNoResPermission", window.parent.useprameters.languagedata);
                        var info_notselfbrance = Lang_hasNoResPermission;
                        var div_notselfbrance = document.createElement("div");
                        div_notselfbrance.innerHTML = info_notselfbrance;
                        div_notselfbrance.style.color = "red";
                        document.getElementById("policetree").appendChild(div_notselfbrance);

                        displaysearchdiv();
                        policetree.style.display = "block";
                        displaypolicewindow();
                    }
                    function hidefrontdivs() {
                        //隐藏前面的div       
                        document.getElementById("searchinfo").style.display = "none";
                        document.getElementById("pagediv").style.display = "none";
                        document.getElementById("presententitydiv").style.display = "none";
                        document.getElementById("policetitlediv").style.display = "none";
                    }
                    function nodata_ajax(type, usertype_entityid) {
                        //搜索
                        if (type == "search") {
                            //搜全部单位
                            hidefrontdivs();
                            var searchinfodiv = document.getElementById("searchinfo");
                            searchinfodiv.style.color = "red";
                            if (usertype_entityid == "") {
                                //没有匹配项
                                deletepolicedivcontenttables();
                                var Lang_nodata = window.parent.GetTextByName("Lang_nodata", window.parent.useprameters.languagedata);
                                searchinfodiv.innerHTML = Lang_nodata;
                            }
                                //搜本单位
                            else {
                                //没有匹配项，请尝试在全部单位中搜索
                                deletepolicedivcontenttables();
                                var Lang_searchall = window.parent.GetTextByName("Lang_searchall", window.parent.useprameters.languagedata);
                                searchinfodiv.innerHTML = Lang_searchall;
                            }
                            searchinfodiv.style.display = "block";
                        }
                            //点击
                        else {
                            hidefrontdivs();
                            deletepolicedivcontenttables();
                            //该单位没有警员
                            var Lang_info_nodatebyclick = window.parent.GetTextByName("Lang_info_nodatebyclick", window.parent.useprameters.languagedata);
                            var div_nodatebyclick = document.createElement("div");
                            div_nodatebyclick.innerHTML = Lang_info_nodatebyclick;
                            div_nodatebyclick.style.color = "red";
                            var policetree = document.getElementById("policetree");
                            policetree.appendChild(div_nodatebyclick);
                            displaysearchdiv();
                            createentitybelongtable();
                            displaypresententitydiv();
                            policetree.style.display = "block";
                            displaypolicewindow();
                        }
                    }
                    function nodataInResPermission_ajax(type, usertype_entityid) {
                        //搜索
                        if (type == "search") {
                            //搜全部单位
                            hidefrontdivs();
                            var searchinfodiv = document.getElementById("searchinfo");
                            searchinfodiv.style.color = "red";
                            if (usertype_entityid == "") {
                                //没有匹配项
                                deletepolicedivcontenttables();
                                var Lang_nodataInResPermission = window.parent.GetTextByName("Lang_nodataInResPermission", window.parent.useprameters.languagedata);
                                searchinfodiv.innerHTML = Lang_nodataInResPermission;
                            }
                                //搜本单位
                            else {
                                //没有匹配项，请尝试在全部单位中搜索
                                deletepolicedivcontenttables();
                                var Lang_searchall = window.parent.GetTextByName("Lang_searchall", window.parent.useprameters.languagedata);
                                searchinfodiv.innerHTML = Lang_searchall;
                            }
                            searchinfodiv.style.display = "block";
                        }
                    }

                    function Hideprocessbar() {
                        var processbar = document.getElementById("processbar");
                        if (processbar) {
                            processbar.style.display = "none";
                        }
                    }
                    function Displayprocessbar() {
                 
                        var processbar = document.getElementById("processbar");
                        if (processbar) {
                            processbar.style.display = "block";
                        }
                    }
                    function closepolicelists() {
                        window.parent.hidepolicelistsdiv();
                        hidefrontdivs();
                        deletepolicedivcontenttables();
                        hideMenubar();
                    }
                    function hidepagediv() {
                        var page_div = document.getElementById("pagediv");
                        if (page_div) {
                            page_div.style.display = "none";
                        }
                    }
                    function displaypagediv() {
                        var page_div = document.getElementById("pagediv");
                        if (page_div) {
                            page_div.style.display = "block";
                        }
                    }
                    function displaypresententitydiv() {
                        var presententity_div = document.getElementById("presententitydiv");
                        if (presententity_div) {
                            presententity_div.style.display = "block";
                        }
                    }
                    function hidepresententitydiv() {
                        var presententity_div = document.getElementById("presententitydiv");
                        if (presententity_div) {
                            presententity_div.style.display = "none";
                        }
                    }
                    function changevisible(td_id, ISSI) {
                        try {
                            var isdisplay_td = document.getElementById(td_id);
                            if (isdisplay_td) {
                                if (isdisplay_td.innerHTML.indexOf("isinviewyes") > 0) {
                                  
                                    displayorhide_police_ajax(isdisplay_td.CI, "1", td_id);
                                   
                                    window.parent.changevis('hidden', isdisplay_td.CI);
                                    checkDisplayImg(td_id.split('_')[1], false);
                                    for (var i = 0; i < Allpolices.length; i++)
                                    {
                                        if (Allpolices[i].ISSI == ISSI)
                                        {
                                            Allpolices[i].IsDisplay = false;
                                        }
                                    }
                                }
                                else if (isdisplay_td.innerHTML.indexOf("isinviewno") > 0) {
                                    displayorhide_police_ajax(isdisplay_td.CI, "0", td_id);
                                    
                                    window.parent.changevis('visable', isdisplay_td.CI);
                                    checkDisplayImg(td_id.split('_')[1], true);
                                    for (var i = 0; i < Allpolices.length; i++)
                                    {
                                        if (Allpolices[i].ISSI == ISSI)
                                        {
                                            Allpolices[i].IsDisplay = true;
                                        }
                                    }
                                }
                            }
                        }
                        catch (e) {
                            //alert("changevisible" + e);
                        }
                    }
                    function displayorhide_police_ajax(ISSI, ISHD, td_id) {
                        jquerygetNewData_ajax("policelists_Isdisplay.aspx", { ISSI: ISSI, ISHD: ISHD }, function (msg) {
                            try {
                                //返回success
                                //alert(msg.result);
                                window.parent.document.getElementById("contextmenu_container").parentNode.style.display = "none";
                                if (msg.result == "success") {
                                   
                                    if (ISHD == "1") {
                                        var i = window.parent.inarrISSI.length;
                                        while (i--) {
                                            if (window.parent.inarrISSI[i] == ISSI)
                                                break;
                                        }
                                        if (i == -1) {
                                            window.parent.inarrISSI.push(ISSI);
                                            window.parent.delSelectUserVar(td_id.replace("Isdisplay_", ""), ISSI);
                                            //checkDisplayImg(id, false);
                                            window.parent.hidPerUser(td_id.replace("Isdisplay_", ""), ISHD);

                                        }
                                    }
                                    else {
                                        var i = window.parent.inarrISSI.length;
                                        while (i--) {
                                            if (window.parent.inarrISSI[i] == ISSI) {
                                                window.parent.inarrISSI.splice(i, 1);
                                                //window.parent.useprameters.Selectid.push(td_id.replace("Isdisplay_", ""));
                                                //window.parent.useprameters.SelectISSI.push(ISSI);
                                                //checkDisplayImg(id, true);
                                                window.parent.hidPerUser(td_id.replace("Isdisplay_", ""), "0");
                                                break;
                                            }
                                        }

                                    }
                                   
                                    //}
                                }
                                    //返回fail
                                else if (msg.result == "fail") {
                                    displayorhide_police_ajax(ISSI, ISHD, td_id);
                                }
                            }
                            catch (e) {
                                //alert("displayorhide_police_ajax" + e);
                            }
                        });
                    }
                    function hidepolice(td_id, ISSI) {
                        var isdisplaytd_isdiaplay = document.getElementById(td_id);
                        if (isdisplaytd_isdiaplay) {
                            isdisplaytd_isdiaplay.innerHTML = "<img src='../images/isinviewno.png'/>";
                        }
                        
                    }
                    function hidesearchinfo_div() {
                        var searchinfo_div = document.getElementById("searchinfo");
                        if (searchinfo_div) {
                            searchinfo_div.innerHTML = "";
                            searchinfo_div.style.display = "none";
                        }
                    }
                    function clearsearchtext() {
                        try {
                            var searchtext_input = document.getElementById("searchtextinput");
                            if (searchtext_input) {
                                searchtext_input.value = "";
                            }
                        }
                        catch (e) {
                            //alert("clearsearchtext" + e);
                        }
                    }
                    function isSearchResultPoliceInResPermission(police) {
                        var isIn = false;
                        try{
                            for (var i = 0; i < ResPermissionEntityIds.EntityIds.length; i++) {
                                if (police.Entity_ID == ResPermissionEntityIds.EntityIds[i]) {
                                    isIn = true;
                                    return isIn;
                                }
                            }
                            for (var j = 0; j < ResPermissionEntityIds.usertypes.length; j++) {
                                if (police.Entity_ID == ResPermissionEntityIds.usertypes[j].entityId) {
                                    for (var k = 0; k < ResPermissionEntityIds.usertypes[j].usertypeIds.length; k++)                                 {
                                        if (police.usertypeId == ResPermissionEntityIds.usertypes[j].usertypeIds[k])                                     {
                                            isIn = true;
                                            return isIn;
                                        }
                                    }
                                }
                            }
                        }
                        catch (e) { }
                        return isIn;
                    }
                </script>
            </div>
        </div>
    </form>
    <script type="text/javascript">
        //点击其他地方关闭菜单---------------------------------xzj--2018/4/19----------------------------------------------
        document.onclick = function () {
            window.parent.document.getElementById("contextmenu_container2").parentNode.style.display = "none";
            var evt = event.srcElement ? event.srcElement : event.target;
            if ((evt.id.indexOf("operate") == -1) && (evt.parentNode == null || evt.parentNode.id.indexOf("operate") == -1)) {
                window.parent.document.getElementById("contextmenu_container").parentNode.style.display = "none";
            }
        };
        //右键关闭菜单，屏蔽浏览器右键菜单---------------------------------xzj--2018/4/19----------------------------------------------
        document.oncontextmenu = function () {
            //window.parent.document.getElementById("mouseMenu").style.display = "none";
            //return false;
            window.parent.document.getElementById("contextmenu_container2").parentNode.style.display = "none";
            window.parent.document.getElementById("contextmenu_container").parentNode.style.display = "none";
            return false;

        }
        function checklock() {
            try {
                var id = window.parent.useprameters.lockid;
                if (id == 0) {
                    var lock_img = document.getElementById("lock_img");
                    if (lock_img) {
                        removeChildSafe(lock_img);
                    }
                }
                else {
                    var last_lock_img = document.getElementById("lock_img");
                    if (last_lock_img) {
                        removeChildSafe(last_lock_img);
                    }
                    var Nam_td_lockit = document.getElementById("Nam_" + id);
                    if (Nam_td_lockit) {
                        Nam_td_lockit.innerHTML += "<img id='lock_img' src='../img/picbz.png'   />";//锁定
                    }
                }
            }
            catch (e) {
                //alert("checklock"+e);
            }
        }
    </script>
</body>
</html>
