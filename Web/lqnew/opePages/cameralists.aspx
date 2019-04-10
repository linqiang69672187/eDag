<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="cameralists.aspx.cs" Inherits="Web.lqnew.opePages.cameralists" %>

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
    </style>
</head>
<body style="font-size: 12px">
    <script type="text/javascript">

        window.onload = function () {

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
            // var Lang_searchall_title = window.parent.GetTextByName("Lang_searchall_title", window.parent.useprameters.languagedata);
            document.getElementById("Lang_searchall").value = Lang_searchall_value;
            document.getElementById("Lang_videoinfoName1").innerHTML = window.parent.GetTextByName("Lang_videoinfoName", window.parent.useprameters.languagedata);
            document.getElementById("Lang_videoinfoNum1").innerHTML = window.parent.GetTextByName("Lang_videoinfoNum", window.parent.useprameters.languagedata);
            //document.getElementById("Lang_searchall").title = Lang_searchall_title;
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
            <div id="camerawindow">
                <div id="search" style="display: block">
                    <select id="searchselect">
                        <%--<option id="Lang_all_searchoption" value="All"><%--全部--%></option>--%>
                        <option id="Lang_videoinfoName" value="Nam"><%--监控名称--%></option>
                        <option id="Lang_videoinfoNum" value="Num"><%--监控编号--%></option>
                    </select><input id="searchtextinput" type="text" value="" style="width: 100px" />
                    <%--<input id="Lang_searchpresent" type="button" value="搜本单位" title="在选中的单位中搜索" onclick="searchpresententity()"/><br />--%>

                    <input id="Lang_searchall" type="button" style="margin-left: 0px" value="<%--搜全站--%>" onclick="searchallentity()" />
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
                    <table cellspacing="1" cellpadding="0" id="GridView1" style="background-color: #C0DE98; border-color: White; border-width: 0px; border-style: Ridge; width: 398px;">
                        <tr class="gridheadcss" style="font-weight: bold;">
                            <th id="Lang_videoinfoNum1" style="width: 128px"><%--摄像机编号--%></th>
                            <th id="Lang_videoinfoName1" style="width: 120px"><%--名称--%></th>
                            <th id="Lang_style" style="width: 50px"><%--类型--%></th>
                            <th id="Lang_videoplay" style="width: 50px"><%--播放--%></th>
                            <th id="Lang_Location" style="width: 50px"><%--定位--%></th>

                        </tr>
                    </table>
                </div>
                <div id="policetree" style="width: 99%; height: 414px; overflow: auto; margin-top: 1px; margin-left: 1px; display: none">
                    <table id="policetable" style="display: none; width: 398px;">
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

                    function createpolicetable_ajax(type, value, usertype_entityid) {
                        try {
                            //processbar
                            Hideprocessbar();

                            //判断权限
                            if (type == "search") {
                                //var police = eval(msg);
                                //if (police.length == 0) {
                                Allpolices.length = 0;
                                var searArr = value.split('/');
                                var searStr = searArr[1];

                                if (searArr[0] == "Nam") {
                                    for (var i = 0; i < allCameraObj.length; i++) {

                                        if (allCameraObj[i].cameraName.indexOf(searStr) != -1) {
                                            Allpolices.push(allCameraObj[i]);
                                        }
                                    }
                                }
                                else {

                                    for (var i = 0; i < allCameraObj.length; i++) {

                                        if (allCameraObj[i].cameraDeviceNum.indexOf(searStr) != -1) {
                                            Allpolices.push(allCameraObj[i]);
                                        }
                                    }
                                }

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
                            else {

                                Allpolices = allCameraObj.slice(0);

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
                            policetable.style.width = "398px";
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
                                policetr.id = Allpolices[i + indexstep].cameraID;
                                policetr.style.backgroundColor = "white";
                                policetr.onmouseover = function () {
                                    this.style.backgroundColor = "green";
                                }
                                policetr.onmouseout = function () {
                                    this.style.backgroundColor = "white";
                                }
                                //cameraDeviceNum
                                var policetd_Nam = document.createElement("td");

                                policetd_Nam.innerHTML = Allpolices[i + indexstep].cameraDeviceNum;
                                policetd_Nam.title = Allpolices[i + indexstep].cameraDeviceNum;
                                policetd_Nam.id = "Nam_" + Allpolices[i + indexstep].cameraID;
                                policetd_Nam.style.width = "128px";
                                policetd_Nam.style.textAlign = "center";

                                policetr.appendChild(policetd_Nam);

                                var policetd_ISSI = document.createElement("td");
                                policetd_ISSI.innerHTML = Allpolices[i + indexstep].cameraName;
                                policetd_ISSI.style.width = "120px";
                                policetd_ISSI.style.textAlign = "center";
                                policetr.appendChild(policetd_ISSI);
                                //cameraTypeName
                                var policetd_type = document.createElement("td");
                                policetd_type.innerHTML = Allpolices[i + indexstep].cameraTypeName;
                                policetd_type.style.width = "50px";
                                policetd_type.style.textAlign = "center";
                                policetr.appendChild(policetd_type);
                                //play
                                var policetdIsDisplay = document.createElement("td");
                                policetdIsDisplay.id = "Isdisplay_" + Allpolices[i + indexstep].cameraID;
                                //policetdIsDisplay.CI = Allpolices[i + indexstep].cameraDeviceNum;
                                policetdIsDisplay.style.width = "50px";
                                policetdIsDisplay.style.cursor = "pointer";//xzj--2018090
                                
                                policetdIsDisplay.innerHTML = window.parent.GetTextByName("Lang_videoplay", window.parent.useprameters.languagedata);
                                //	ExternalInterface.call("VideoCallFuction","","",deviceNum,deviceName,"400","300","false","99","false",_Url+"/PlayWindow/play.html?deviceName="+deviceName+"&deviceNum="+deviceNum+"&realm="+realm+"&cameraNum="+cameraNum+"&latitude="+latitude+"&longitude="+longitude+"&cameraIP="+cameraIP);
                                policetdIsDisplay.style.cursor = "hand";
                                policetdIsDisplay.devicenum = Allpolices[i + indexstep].encoderDeviceNum;
                                policetdIsDisplay.devicename = Allpolices[i + indexstep].cameraName;
                                policetdIsDisplay.realm = Allpolices[i + indexstep].realm;
                                policetdIsDisplay.cameranum = Allpolices[i + indexstep].cameraDeviceNum;
                                policetdIsDisplay.lat = Allpolices[i + indexstep].latitude;
                                policetdIsDisplay.lon = Allpolices[i + indexstep].longitude;
                                policetdIsDisplay.cameraip = "";
                                policetdIsDisplay.onclick = function () {
                                    //var devicenum = Allpolices[i + indexstep].encoderDeviceNum;
                                    //var devicename = Allpolices[i + indexstep].cameraName;
                                    //var realm = Allpolices[i + indexstep].realm;
                                    //var cameranum = Allpolices[i + indexstep].cameraDeviceNum;
                                    //var lat = Allpolices[i + indexstep].latitude;
                                    //var lon = Allpolices[i + indexstep].longitude;
                                    //var cameraip = "";
                                    //alert(this.devicename);
                                    //alert(this.devicenum);
                                    //alert(this.realm);
                                    //alert(this.lat);
                                    //alert(this.lon);
                                    //alert(this.cameraip);
                                    //alert(this.cameranum);

                                    window.parent.VideoCallFuction("", "", this.devicenum, this.devicename, "400", "300", "false", "99", "false", "/PlayWindow/play.html?deviceName=" + this.devicename + "&deviceNum=" + this.devicenum + "&realm=" + this.realm + "&cameraNum=" + this.cameranum + "&latitude=" + this.lat + "&longitude=" + this.lon + "&cameraIP=" + this.cameraip);
                                }
                                policetr.appendChild(policetdIsDisplay);
                                //定位
                                var policetd_locate = document.createElement("td");
                                policetd_locate.id = "Locate_" + Allpolices[i + indexstep].cameraID;
                                //policetdIsDisplay.CI = Allpolices[i + indexstep].cameraDeviceNum;
                                policetd_locate.style.cursor = "pointer";
                                policetd_locate.style.width = "50px";
                                policetd_locate.innerHTML = window.parent.GetTextByName("Lang_Location", window.parent.useprameters.languagedata);
                                policetd_locate.cameranum = Allpolices[i + indexstep].cameraDeviceNum;
                                policetd_locate.lat = Allpolices[i + indexstep].latitude;
                                policetd_locate.lon = Allpolices[i + indexstep].longitude;
                                policetd_locate.onclick = function () {
                                    if (this.lon == "" || this.lat == "" || this.lat < -90 || this.lat > 90) {//经纬度错误
                                        var alertMessage = window.parent.GetTextByName("Lang_monitoringIsWrongLonLat");
                                        alert(alertMessage);
                                    }
                                    else if (this.cameranum == "") {//无监控编号
                                        var alertMessage = window.parent.GetTextByName("Lang_monitoringIsWrongCameraNum");
                                        alert(alertMessage);
                                    }
                                    else {
                                        window.parent.locateCameraByLonLat(this.lon, this.lat);
                                    }
                                }

                                policetr.appendChild(policetd_locate);


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
                    function displaypolicetitlediv() {
                        document.getElementById("policetitlediv").style.display = "block";
                    }
                    function displaysearchdiv() {
                        document.getElementById("search").style.display = "block";
                    }
                    function displaypolicewindow() {
                        document.getElementById("camerawindow").style.display = "block";
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
                            //该单位没有警员
                            var Lang_info_nodatebyclick = window.parent.GetTextByName("Lang_info_nodatebyclick", window.parent.useprameters.languagedata);
                            var div_nodatebyclick = document.createElement("div");
                            div_nodatebyclick.innerHTML = Lang_info_nodatebyclick;
                            div_nodatebyclick.style.color = "red";
                            var policetree = document.getElementById("policetree");
                            policetree.appendChild(div_nodatebyclick);
                            displaysearchdiv();
                            displaypresententitydiv();
                            policetree.style.display = "block";
                            displaypolicewindow();
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
                        window.parent.hidecameralistsdiv();
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

                </script>
            </div>
        </div>
    </form>
    <script type="text/javascript">

        var allCameraObj;
        var Allpolices = new Array();
        function GetAllCamera() {

            var result = window.parent.arrAllCameraJson;
            allCameraObj = result.data;
            //for (var i = 0; i < cameraObj.length; i++) {
            //    //alert(cameraObj[i].cameraName);
            //}
            createpolicetable_ajax("", "", "");
        }


        document.oncontextmenu = function () {
            window.parent.document.getElementById("mouseMenu").style.display = "none";
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
