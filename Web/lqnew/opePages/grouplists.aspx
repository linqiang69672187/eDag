<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="grouplists.aspx.cs" Inherits="Web.lqnew.opePages.grouplists" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
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
        function getResPermissionEntityIdsByUserId(loginUserId) {

            var url = "../../Handlers/resPermissions/getResPermissionEntityIdsByUserIdForPolicelist.ashx";
            jquerygetNewData_ajax(url, { loginUserId: loginUserId }, function (msg) {
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
                    
                    <input id="searchtextinput" type="text" value="" style="width: 100px" />
                    <%--<input id="Lang_searchpresent" type="button" value="搜本单位" title="在选中的单位中搜索" onclick="searchpresententity()"/><br />--%>

                    <input id="Lang_searchall" type="button" style="margin-left: 0px" value="<%--搜全站--%>" title="<%--在本调度台所有的下属单位中搜索--%>" onclick="searchallentity()" />
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
                            <th id="Lang_GroupName" style="width: 50px"><%--组名--%></th>  
                            <th id="groupbz" style="width: 49px"><%--组号--%></th>
                            <th id="Lang_Unit_1" style="width: 38px"><%--单位--%></th>    
                            <th id="Lang_Operate" style="width: 45px"><%--操作--%></th>
                        </tr>
                    </table>
                </div>
                <div id="policetree" style="width: 99%; height: 414px; overflow: auto; margin-top: 1px; margin-left: 1px; display: none">
                    <table id="policetable" style="display: none">
                    </table>
                </div>
                <script type="text/javascript">

                    var groupbz = window.parent.GetTextByName("groupbz", window.parent.useprameters.languagedata);
                    window.document.getElementById("groupbz").innerHTML = groupbz;

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
                                event.returnValue = false;
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
                        //var searchtype = document.getElementById("searchselect").value;
                        var searchtext = document.getElementById("searchtextinput").value;
                        if (searchtext != "" && searchtext.indexOf('\'') == -1) {

                            Displayprocessbar();
                            createpolicetable_ajax("search", searchtext, "");
                        }
                        else {
                            //请输入搜索内容
                            var pleaseinput = window.parent.GetTextByName("Lang_pleaseinput", window.parent.useprameters.languagedata);
                            alert(pleaseinput);
                        }
                    }
                    function setrightvalue(id, type) {
                        //rightGSSI = id;
                        window.parent.useprameters.rightselectid = id;
                        rightselecttype = 'group';
                        righttype = type;
                    }
                    //声音
                    var openVoice = window.parent.GetTextByName("Lang_openVoice", window.parent.useprameters.languagedata);
                    var mute = window.parent.GetTextByName("Lang_mute", window.parent.useprameters.languagedata);
                    function setRightclickMenu(GSSI) {
                        var Lang_volumeControl = window.parent.document.getElementById("Lang_volumeControl");
                        if (IsMutebydispatcher(GSSI)) {
                            Lang_volumeControl.innerHTML = openVoice;
                        }
                        else {
                            Lang_volumeControl.innerHTML = mute;
                        }
                    }
                    function IsMutebydispatcher(GSSI) {
                        var ismute = false;
                        for (var i = 0; i < window.parent.useprameters.muteGroupList.length; i++) {
                            if (GSSI == window.parent.useprameters.muteGroupList[i]) {
                                ismute = true;
                                break;
                            }
                        }
                        return ismute;
                    }
                    function getGroup(entityId,entityName,clickItemType) {
                        presententityid = entityId;
                        presententityname = entityName;
                        createpolicetable_ajax("",entityId, clickItemType);
                    }
                    function createpolicetable_ajax(type, value, clickItemType) {
                        jquerygetNewData_ajax("grouplistdata.aspx", { type: type, value: value, clickItemType: clickItemType }, function (msg) {
                            try {
                                //processbar
                                Hideprocessbar();

                                //判断权限
                                if (type == "search") {
                                    var police = eval(msg);
                                    if (police.length == 0) {
                                        nodata_ajax(type, "");
                                    }
                                    else {
                                        var policeInResPermission = [];
                                        for (var i = 0; i < police.length; i++) {
                                            if (isSearchResultPoliceInResPermission(police[i])) {
                                                policeInResPermission.push(police[i]);
                                            }
                                        }
                                        if (policeInResPermission.length == 0) {
                                            nodataInResPermission_ajax(type, "");
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
                                        nodata_ajax(type, "");
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

                                policetd_Nam.innerHTML = Allpolices[i + indexstep].uname;
                                policetd_Nam.title = Allpolices[i + indexstep].uname;
                                policetd_Nam.id = "Nam_" + Allpolices[i + indexstep].id;
                                policetd_Nam.style.width = "50px";
                                policetd_Nam.style.textAlign = "center";
                                
                                policetr.appendChild(policetd_Nam);
                                
                                //GSSI
                                var policetd_ISSI = document.createElement("td");
                                policetd_ISSI.innerHTML = Allpolices[i + indexstep].GSSI;
                                policetd_ISSI.style.width = "49px";
                                policetd_ISSI.style.textAlign = "center";
                                policetr.appendChild(policetd_ISSI);
                                //entity
                                var policetd_type = document.createElement("td");
                                policetd_type.innerHTML = Allpolices[i + indexstep].EntityName;
                                policetd_type.style.width = "38px";
                                policetd_type.style.textAlign = "center";
                                policetr.appendChild(policetd_type);
                                
                                //操作
                                var policetd_operate = document.createElement("td");
                                policetd_operate.id = "operate_" + Allpolices[i + indexstep].id;
                                policetd_operate.CI = Allpolices[i + indexstep].GSSI;
                                                                                                
                                policetd_operate.style.width = "45px";
                                if (Allpolices[i + indexstep].GSSI != "") {
                                    policetd_operate.innerHTML = "<img src='../img/treebutton2.gif'/>";
                                    policetd_operate.onclick = function () {
                                        setrightvalue(this.CI, "group");
                                      //  setRightclickMenu(this.CI);
                                       // MouseMenu_onclick(window.parent, "groupmouseMenu");
                                        var obj = window.parent
                                        var mainSWF = obj.document.getElementById("main");
                                        if (mainSWF) {
                                            mainSWF.webRightClickHandler_Groupdp("group", this.CI, event.screenX + 60, event.screenY - 122);
                                        }

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
                            //该单位没有数据
                            var Lang_info_nodatebyclick = window.parent.GetTextByName("Lang_hasnodata", window.parent.useprameters.languagedata);
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
                        hidegrouplistsdiv();
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
                        try {
                            for (var i = 0; i < ResPermissionEntityIds.EntityIds.length; i++) {
                                if (police.Entity_ID == ResPermissionEntityIds.EntityIds[i]) {
                                    isIn = true;
                                    return isIn;
                                }
                            }
                            for (var j = 0; j < ResPermissionEntityIds.usertypes.length; j++) {
                                if (police.Entity_ID == ResPermissionEntityIds.usertypes[j].entityId) {
                                    //for (var k = 0; k < ResPermissionEntityIds.usertypes[j].usertypeIds.length; k++) {
                                    //    if (police.usertypeId == ResPermissionEntityIds.usertypes[j].usertypeIds[k]) {
                                    //        isIn = true;
                                    //        return isIn;
                                    //    }
                                    //}
                                    isIn = true;
                                    return isIn;
                                }
                            }
                        }
                        catch (e) { }
                        return isIn;
                    }
                    function hidegrouplistsdiv() {
                        var grouplists_div = window.parent.document.getElementById("grouplistsdiv");
                        if (grouplists_div) {
                            grouplists_div.style.display = "none";
                        }
                    }
                </script>
            </div>
        </div>
    </form>
    <script type="text/javascript">
        document.oncontextmenu = function () {
            window.parent.document.getElementById("mouseMenu").style.display = "none";
            return false;
        }
        
    </script>
</body>
</html>