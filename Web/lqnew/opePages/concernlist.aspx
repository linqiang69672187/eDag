<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="concernlist.aspx.cs" Inherits="Web.lqnew.opePages.concernlist" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link href="../css/lq_addedit.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/pagestyle.css" rel="stylesheet" type="text/css" />
    <script src="../js/mark.js" type="text/javascript"></script>
    <script src="../js/Cookie.js" type="text/javascript"></script>
    <script src="../js/MouseMenu.js" type="text/javascript"></script>
    <script src="../js/MouseMenuEvent.js" type="text/javascript"></script>
    <script src="../../JS/LangueSwitch.js" type="text/javascript"></script>
    <script src="../js/lq_newjs.js" type="text/javascript"></script>
    <script src="../../MyCommonJS/ajax.js" type="text/javascript"></script>
    <script src="../js/geturl.js" type="text/javascript"></script>
    <style>
        .mytable {
            background-color: #C0DE98;
            border-color: White;
            border-width: 0px;
            border-style: Ridge;
        }

        .bodycss {
            background-color: transparent;
        }
        
        .button-blue {
            height:22px;
            text-align:center;
            border-radius:5px;
            border:1px solid #000000;
            box-shadow:inset 0px 5px 4px #0A7182;
            background-color:#084B66;
            color:white;
        }
    </style>
</head>

<body style="height: 450px" class="bodycss">

    <div id="concernwindow" style="position: absolute;">
        <table width="100%" style="background-color: white" border="0" align="center" cellpadding="0" cellspacing="0">
            <tr>
                <td height="30">
                    <table id="headtable" width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr style="height: 20px">
                            <td width="15" height="20px">
                                <img src="../images/tab_03.png" width="15" height="32" /></td>
                            <td width="1101" background="../images/tab_05.gif"></td>
                            <td width="281" background="../images/tab_05.gif" align="right">
                                <img class="style6" style="cursor: pointer;" onclick="closeconcernlists();" onmouseover="javascript:this.src='../images/close_un.png';" onmouseout="javascript:this.src='../images/close.png';" src="../images/close.png" /></td>
                            <td width="14">
                                <img src="../images/tab_07.png" width="14" height="32" /></td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td id="nodragtd">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td width="15" background="../images/tab_12.gif">&nbsp;
                            </td>
                            <td align="center">
                                <table cellspacing="1">

                                    <tr>
                                        <td>
                                            <table>
                                                <tr>
                                                    <td>
                                                        <div id="policewindow">
                                                            <div id="search" style="display: none;">
                                                                <select id="searchselect">
                                                                    <%--<option id="Lang_all_searchoption" value="All"><全部</option>--%><option id="Lang_name_searchoption" value="Nam"><%--姓名--%></option>
                                                                    <option id="Lang_number_searchoption" value="Num"><%--编号--%></option>
                                                                    <option id="Lang_ISSI_searchoption" value="ISSI"><%--终端号--%></option>
                                                                </select>
                                                                <input id="searchtextinput" type="text" value="" style="width: 150px" />
                                                                <img src="../images/close.png" onmouseover="javascript:this.src='../images/close_un.png';" onmouseout="javascript:this.src='../images/close.png';" style="position: absolute; margin-left: -20px; cursor: hand;" onclick="clearsearchtextandrepaint()" />
                                                                <input id="Lang_searchinresult" class="button-blue" type="button" style="margin-left: 1px" value="<%--在结果中搜索--%>" title="<%--在框选结果中搜索--%>" onclick="searchinresult()" />
                                                                <input id="Lang_searchlockuser" class="button-blue" type="button" style="margin-left: 1px" value="<%--搜索锁定用户--%>" title="<%--搜索锁定用户--%>" onclick="searchlockuser()" />
                                                            </div>
                                                            <div id="searchinfo" style="display: none"></div>
                                                            <div id="pagediv" style="display: none">
                                                                <table id="pagetable">
                                                                    <tr>
                                                                        <td>
                                                                            <table>
                                                                                <tr>
                                                                                    <td id="Lang_firstpage" style="width: 50px"><%--首页--%></td>
                                                                                    <td id="Lang_prepage" style="width: 65px"><%--上一页--%></td>
                                                                                    <td id="Lang_nextpage"><%--下一页--%></td>
                                                                                    <td id="Lang_lastpage"><%--尾页--%></td>
                                                                                    <td>
                                                                                        <select id="pageselect">
                                                                                            <option value="1">1</option>
                                                                                        </select></td>
                                                                                </tr>
                                                                            </table>
                                                                        </td>
                                                                        <td style="text-align: right">
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
                                                            <div id="policetitlediv" style="margin-top: 1px; margin-left: 1px; margin-right: 20px; text-align: center; display: none;">
                                                                <table cellspacing="1" cellpadding="0" id="GridView1" style="background-color: #C0DE98; border-color: White; border-width: 0px; border-style: Ridge;">
                                                                    <tr class="gridheadcss" style="font-weight: bold;">
                                                                        <th id="Lang_name" style="width: 80px"><%--姓名--%></th>
                                                                        <th id="Lang_Serialnumber" style="width: 80px"><%--编号--%></th>
                                                                        <th id="Lang_ISSI" style="width: 80px"><%--终端号--%></th>
                                                                        <th id="Lang_Subordinateunits" style="width: 150px"><%--单位--%></th>
                                                                        <th id="Lang_style" style="width: 100px"><%--类型--%></th>
                                                                        <th id="Lang_Isdisplay" style="width: 50px"><%--显示--%></th>
                                                                        <th id="Lang_Location" style="width: 50px"><%--定位--%></th>
                                                                        <th id="Lang_Operate" style="width: 50px"><%--操作--%></th>

                                                                    </tr>
                                                                </table>
                                                            </div>

                                                            <div id="policetree" style="width: 99%; height: 313px; overflow-y: scroll; margin-top: 1px; margin-left: 1px; display: none">
                                                                <table id="policetable" style="display: none">
                                                                </table>
                                                            </div>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td width="14" background="../images/tab_16.gif">&nbsp;
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td height="15">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td width="15" height="15">
                                <img src="../images/tab_20.png" width="15" height="15" />
                            </td>
                            <td background="../images/tab_21.gif">
                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td width="25%" nowrap="nowrap">&nbsp;
                                        </td>
                                        <td width="75%" valign="top" class="STYLE1">&nbsp;
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td width="14">
                                <img src="../images/tab_22.png" width="14" height="15" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>

    <script type="text/javascript">
        document.onkeypress = function () {
            var search_input = document.getElementById("searchtextinput");
            if (search_input) {
                if (event.keyCode == 13 && document.activeElement.id == "searchtextinput") {
                    if (search_input.value != "") {
                        var search_button = document.getElementById("Lang_searchinresult");
                        if (search_button) {
                            search_button.click();
                        }
                    }
                    event.returnValue = false;
                }
            }
        }

        var dragEnable = 'True';
        function dragdiv() {
            var div1 = window.parent.document.getElementById("concernlist");
            window.parent.windowDivOnClick(div1);
            if (div1 && event.button == 0 && dragEnable == 'True') {
                window.parent.mystartDragWindow(div1, null, event); div1.style.border = "solid 0px transparent"; window.parent.cgzindex(div1);

            }
        }
        function mydragWindow() {
            var div1 = window.parent.document.getElementById("concernlist");
            if (div1 && event.button == 0 && dragEnable == 'True') {
                window.parent.mydragWindow(div1, event);
            }
        }

        function mystopDragWindow() {
            var div1 = window.parent.document.getElementById("concernlist");
            if (div1 && event.button == 0 && dragEnable == 'True') {
                window.parent.mystopDragWindow(div1); div1.style.border = "0px";
            }
        }


        window.onload = function () {
            Allpolices = eval('<%=allconcernusers_json%>');
             eachpagenum = 30;
             paintpolices = Allpolices;
             paintpolicestable();
             displayorhidesearchlockuserdiv();
             //给搜索输入框添加内容改变事件
             var searchtextobj = document.getElementById("searchtextinput");
            //addEvent改为addEventListener----------------xzj--2018/4/9-------------------------------------
             searchtextobj.addEventListener("propertychange", function (o) {
                 if (o.propertyName == "value") {
                     onsearchinputchange(searchtextobj);
                 }
             }, false);

             var concernusers_string = "<%=concernids_string%>";
             window.parent.useprameters.concernusers_string = concernusers_string;
             concernusers_string_to_array(concernusers_string);
             //window.parent.LayerControl.refurbish();

             document.body.onmousedown = function () {
                 //-----------------main页面暂时没加此标签 --------xzj--2018/4/9--------------------------------------------------------------------
                 //window.parent.document.getElementById("policemouseMenu").style.display = "none";
                 dragdiv();
             }
             document.body.onmousemove = function () { mydragWindow(); }
             document.body.onmouseup = function () { mystopDragWindow(); }
             document.body.oncontextmenu = function () { return false; }

             var arrayelement = ["input", "a", "select", "li", "font", "textarea"];
             for (n = 0; n < arrayelement.length; n++) {
                 var inputs = document.getElementsByTagName(arrayelement[n]);
                 for (i = 0; i < inputs.length; i++) {
                     inputs[i].onmouseout = function () {
                         dragEnable = 'True';
                     }
                     inputs[i].onmouseover = function () {
                         dragEnable = 'False';
                     }
                 }
             }
             var table = document.getElementById("nodragtd");
             table.onmouseout = function () {
                 dragEnable = 'True';
             }
             table.onmouseover = function () {
                 dragEnable = 'False';
             }

         }
         function paintpolicestable() {
             policenum = paintpolices.length;
             pagenum = Math.ceil(policenum / eachpagenum);
             presentpage = 1;
             //有返回数据
             if (policenum > 0) {
                 displaypresentpagepolices();
             }
                 //无返回数据
             else {
                 nodata();
             }
         }
         function displaypresentpagepolices() {
             deletepolicedivcontenttables();
             hidesearchinfo_div();
             displaypolicewindow();
             displaypolicetitlediv();
             creatpolicetable();
             createpagetables();
             displaysearchdiv();
             checklock();

         }
         function creatpolicetable() {
             try {
                 var policetable = document.createElement("table");
                 policetable.id = "policetable";
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
                     policetr.id = paintpolices[i + indexstep].id;
                     policetr.style.backgroundColor = "white";
                     policetr.onmouseover = function () {
                         this.style.backgroundColor = "green";
                     }
                     policetr.onmouseout = function () {
                         this.style.backgroundColor = "white";
                     }
                     //Nam
                     var policetd_Nam = document.createElement("td");
                     policetd_Nam.innerHTML = paintpolices[i + indexstep].Nam;
                     policetd_Nam.title = paintpolices[i + indexstep].Nam;
                     policetd_Nam.id = "Nam_" + paintpolices[i + indexstep].id;
                     policetd_Nam.style.width = "80px";
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
                     //Num
                     var policetd_Num = document.createElement("td");
                     policetd_Num.innerHTML = paintpolices[i + indexstep].Num;
                     policetd_Num.id = "Num_" + paintpolices[i + indexstep].id;
                     policetd_Num.style.width = "80px";
                     policetd_Num.style.textAlign = "center";
                     policetr.appendChild(policetd_Num);
                     //ISSI
                     var policetd_ISSI = document.createElement("td");
                     policetd_ISSI.innerHTML = paintpolices[i + indexstep].ISSI;
                     policetd_ISSI.style.width = "80px";
                     policetd_ISSI.style.textAlign = "center";
                     policetr.appendChild(policetd_ISSI);
                     //Entity
                     var policetd_Entity = document.createElement("td");
                     policetd_Entity.innerHTML = paintpolices[i + indexstep].Name;
                     policetd_Entity.id = "Entity_" + paintpolices[i + indexstep].id;
                     policetd_Entity.style.width = "150px";
                     policetd_Entity.style.textAlign = "center";
                     policetr.appendChild(policetd_Entity);
                     //type
                     var policetd_type = document.createElement("td");
                     policetd_type.innerHTML = paintpolices[i + indexstep].type;
                     policetd_type.style.width = "100px";
                     policetd_type.style.textAlign = "center";
                     policetr.appendChild(policetd_type);
                     //isdisplay
                     var policetdIsDisplay = document.createElement("td");
                     policetdIsDisplay.id = "Isdisplay_" + paintpolices[i + indexstep].id;
                     policetdIsDisplay.CI = paintpolices[i + indexstep].ISSI;
                     policetdIsDisplay.style.width = "50px";
                     if (window.parent.useprameters.DisplayEnable == 1) {
                         policetdIsDisplay.style.cursor = "hand";
                         if (paintpolices[i + indexstep].IsDisplay == 'True' && paintpolices[i + indexstep].ISSI != "") {
                             policetdIsDisplay.innerHTML = "<img src='../images/isinviewyes.png'/>";
                             policetdIsDisplay.onclick = function () {
                                 if (window.parent.useprameters.lockid == this.id.split('_')[1]) {
                                     alert(window.parent.GetTextByName("PoliceLockUnHidden", window.parent.useprameters.languagedata));//多语言： 锁定状态禁止隐藏
                                     return;
                                 }
                                 changevisible(this.id, this.CI);

                             }
                         }
                         else if (paintpolices[i + indexstep].IsDisplay == 'False' && paintpolices[i + indexstep].ISSI != "") {
                             policetdIsDisplay.innerHTML = "<img src='../images/isinviewno.png'/>";
                             policetdIsDisplay.onclick = function () {
                                 changevisible(this.id);

                             }
                         }
                     }

                     policetr.appendChild(policetdIsDisplay);
                     //定位
                     var policetd_locate = document.createElement("td");
                     policetd_locate.id = "Locate_" + paintpolices[i + indexstep].id;
                     policetd_locate.style.width = "50px";
                     if (paintpolices[i + indexstep].ISSI != "" && window.parent.useprameters.GPSEnable == 1) {
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
                     policetd_operate.id = "operate_" + paintpolices[i + indexstep].id;
                     policetd_operate.CI = paintpolices[i + indexstep].ISSI;
                     policetd_operate.terminalType = paintpolices[i + indexstep].terminalType;
                     policetd_operate.status = paintpolices[i + indexstep].status;
                     //policetd_operate.class = "hasLeftmenu";
                     policetd_operate.style.width = "50px";
                     if (paintpolices[i + indexstep].ISSI != "") {
                         //policetd_operate.innerHTML = "<img src='../img/treebutton2.gif'/>";
                         //policetd_operate.onclick = function () {
                         //    setrightvalue(this.id.split('_')[1], this.CI, this.terminalType, this.status);
                         //    MouseMenu_onclick(window.parent, "policemouseMenu");
                         //}
                         //统一用户右键菜单为swf方式
                         policetd_operate.innerHTML = "<img src='../img/treebutton2.gif'/>";
                         policetd_operate.onclick = function () {
                             //修改onclick事件------------------------------xzj--2018/4/18-------------------------
                             window.parent.getUserStatusByISSI(this.CI);

                             var hh = screen.availHeight - window.parent.document.documentElement.clientHeight;
                             hh = hh > 0 ? hh : 0;
                             window.parent.document.getElementById("contextmenu_container2").parentNode.style.display = "none";
                             window.parent.document.getElementById("contextmenu_container").parentNode.style.display = "block";
                             window.parent.document.getElementById("contextmenu_container").parentNode.style.left = event.screenX + 40 + "px";
                             window.parent.document.getElementById("contextmenu_container").parentNode.style.top = event.screenY - hh + "px";
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

                             //    mainSWF.webRightClickHandler_user(trace, lock, id, this.CI, concerned, this.status, IsDisplay, event.screenX + 40, event.screenY - hh);
                             //}
                             //// MouseMenu_onclick(window.parent, "policemouseMenu");
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
                 //else {
                 //   hidepagediv();
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
         function displaypolicetitlediv() {
             document.getElementById("policetitlediv").style.display = "block";
         }
         function displaysearchdiv() {
             document.getElementById("search").style.display = "block";
         }
         function close_selectuser() {
             hideselectuserdiv();
             hidefrontdivs();
             deletepolicedivcontenttables();
         }
         function displaypolicewindow() {
             document.getElementById("policewindow").style.display = "block";
         }
         function changevisible(td_id, ISSI) {
             try {
                 var isdisplay_td = document.getElementById(td_id);
                 if (isdisplay_td) {
                     if (isdisplay_td.innerHTML.indexOf("isinviewyes") > 0) {

                         displayorhide_police_ajax(isdisplay_td.CI, "1", td_id);
                         
                         window.parent.changevis('hidden', isdisplay_td.CI);
                         checkDisplayImg(td_id.split('_')[1], false);
                     }
                     else if (isdisplay_td.innerHTML.indexOf("isinviewno") > 0) {
                         displayorhide_police_ajax(isdisplay_td.CI, "0", td_id);
                        
                         window.parent.changevis('visable', isdisplay_td.CI);
                         checkDisplayImg(td_id.split('_')[1], true);
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
             //var hide_police = window.parent.document.getElementById("Police,0,0|" + td_id.split('_')[1] + "_vFigure");
             //if (hide_police) {
             //    removeChildSafe(hide_police);
             //}

             //在地图上删除隐藏的警员
             var mainSWF = window.parent.document.getElementById("main");
             if (mainSWF) {
                 mainSWF.removePerUser(ISSI);
             }
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
         function hidesearchinfo_div() {
             var searchinfo_div = document.getElementById("searchinfo");
             if (searchinfo_div) {
                 searchinfo_div.innerHTML = "";
                 searchinfo_div.style.display = "none";
             }
         }
         function clearsearchtextandrepaint() {
             try {
                 var searchtext_input = document.getElementById("searchtextinput");
                 if (searchtext_input && searchtext_input.value != "") {
                     searchtext_input.value = "";
                     paintpolices = Allpolices;
                     paintpolicestable();
                 }
             }
             catch (e) {
                 //alert("clearsearchtextandrepaint" + e)
             }
         }
         function searchinresult() {
             var searchresult = new Array();
             var searchtext = document.getElementById("searchtextinput").value;
             if (searchtext != "") {
                 var searchitem = document.getElementById("searchselect").value;
                 var allpolicenum = Allpolices.length;
                 for (var i = 0; i < allpolicenum; i++) {
                     if (searchitem == "Nam") {
                         if (Allpolices[i].Nam.indexOf(searchtext) > -1) {
                             searchresult.push(Allpolices[i]);
                         }
                     }
                     if (searchitem == "Num") {
                         if (Allpolices[i].Num.indexOf(searchtext) > -1) {
                             searchresult.push(Allpolices[i]);
                         }
                     }
                     if (searchitem == "ISSI") {
                         if (Allpolices[i].ISSI.indexOf(searchtext) > -1) {
                             searchresult.push(Allpolices[i]);
                         }
                     }
                 }
                 //有搜素结果
                 if (searchresult.length > 0) {
                     paintpolices = searchresult;
                     paintpolicestable();
                 }
                     //无匹配
                 else {
                     nosearchdata();
                 }
             }
             else {
                 //请输入搜索内容
                 var pleaseinput = window.parent.GetTextByName("Lang_pleaseinput", window.parent.useprameters.languagedata);
                 alert(pleaseinput);
             }
         }
         function searchlockuser() {
             var search_lockuser = new Array();
             var allpolicenum = Allpolices.length;
             var lockuserid = window.parent.useprameters.lockid;
             for (var i = 0; i < allpolicenum; i++) {
                 if (Allpolices[i].id == lockuserid) {
                     search_lockuser.push(Allpolices[i]);
                     break;
                 }
             }
             //有搜素结果
             if (search_lockuser.length > 0) {
                 paintpolices = search_lockuser;
                 paintpolicestable();
                 var searchtext_input = document.getElementById("searchtextinput");
                 if (searchtext_input) {
                     searchtext_input.value = search_lockuser[0].Nam;
                 }
                 var searchtype_select = document.getElementById("searchselect");
                 if (searchtype_select) {
                     searchtype_select.value = "Nam";
                 }
             }
         }
         function nodata() {
             var searchinfo_div = document.getElementById("searchinfo");
             if (searchinfo_div) {
                 var Lang_nodata = window.parent.GetTextByName("Lang_nodata", window.parent.useprameters.languagedata);
                 searchinfo_div.innerHTML = Lang_nodata;
                 searchinfo_div.style.display = "block";
             }
             else {
                 var info_div = document.createElement("div");
                 info_div.id = "searchinfo";
                 var Lang_nodata = window.parent.GetTextByName("Lang_nodata", window.parent.useprameters.languagedata);
                 info_div.innerHTML = Lang_nodata;
                 info_div.style.display = "block";
             }
         }
         function nosearchdata() {
             deletepolicedivcontenttables();
             hidepagediv();
             var policetree_div = document.getElementById("policetree");
             if (policetree_div) {
                 var searchinfo_div = document.createElement("span");
                 policetree_div.appendChild(searchinfo_div);
                 var Lang_nodata = window.parent.GetTextByName("SearchHaveNoData", window.parent.useprameters.languagedata);
                 searchinfo_div.innerHTML = Lang_nodata;
                 searchinfo_div.style.color = "red";
                 policetree_div.style.display = "block";
             }
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
                 displayorhidesearchlockuserdiv();
             }
             catch (e) {
                 //alert("checklock" + e);
             }
         }
         function displayorhidesearchlockuserdiv() {
             var id = window.parent.useprameters.lockid;
             var searchlockuser_div = document.getElementById("Lang_searchlockuser");
             if (id != 0) {
                 if (searchlockuser_div) {
                     searchlockuser_div.style.display = "inline";
                 }
             }
             else {
                 if (searchlockuser_div) {
                     searchlockuser_div.style.display = "none";
                 }
             }
         }
         function setrightvalue(id, issi, terminalType, status) {
             window.parent.useprameters.rightselectid = id;
             window.parent.useprameters.rightselectissi = issi;
             window.parent.useprameters.rightselectTerminalType = terminalType;
             window.parent.useprameters.rightselectTerminalIsValide = status;
             rightselecttype = 'cell';
         }
         function hidefrontdivs() {
             //隐藏前面的div       
             document.getElementById("searchinfo").style.display = "none";
             document.getElementById("pagediv").style.display = "none";
             document.getElementById("policetitlediv").style.display = "none";
         }
         function onsearchinputchange(searchobj) {
             if (searchobj.value == "") {
                 paintpolices = Allpolices;
                 paintpolicestable();
             }
         }
         function closeconcernlists() {
             window.parent.hideconcernlistdiv();
             hidefrontdivs();
             deletepolicedivcontenttables();
             hideMenubar();
         }
         function concernusers_string_to_array(concernids) {
             window.parent.useprameters.concernusers_array = concernids.split(";");
         }
    </script>
</body>
<script type="text/javascript">
    window.parent.closeprossdiv();
    //点击其他地方关闭菜单---------------------------------xzj--2018/5/3----------------------------------------------
    document.onclick = function () {
        window.parent.document.getElementById("contextmenu_container2").parentNode.style.display = "none";
        var evt = event.srcElement ? event.srcElement : event.target;
        if ((evt.id == undefined || evt.id.indexOf("operate") == -1) && (evt.parentNode == null || evt.parentNode.id == undefined || evt.parentNode.id.indexOf("operate") == -1)) {
            window.parent.document.getElementById("contextmenu_container").parentNode.style.display = "none";
        }
    };
    //右键关闭菜单，屏蔽浏览器右键菜单---------------------------------xzj--2018/5/3----------------------------------------------
    document.oncontextmenu = function () {
        //hideMenubar();
        //return false;
        window.parent.document.getElementById("contextmenu_container2").parentNode.style.display = "none";
        window.parent.document.getElementById("contextmenu_container").parentNode.style.display = "none";
        return false;
    }
    //-----------------main页面暂时没加此标签 --------xzj--2018/4/9--------------------------------------------------------------------
    //window.parent.document.getElementById("policemouseMenu").style.display = "none";
    LanguageSwitch(window.parent);
</script>
</html>
