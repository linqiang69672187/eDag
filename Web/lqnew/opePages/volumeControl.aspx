<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="volumeControl.aspx.cs" Inherits="Web.lqnew.opePages.volumeControl" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link href="../css/lq_addedit.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/pagestyle.css" rel="stylesheet" type="text/css" />
    <script src="../js/geturl.js" type="text/javascript"></script>
    <link href="../css/btn.css" rel="stylesheet" type="text/css" />
    <script src="../../JQuery/jquery-1.5.2.js" type="text/javascript"></script>
    <script src="../../JS/LangueSwitch.js" type="text/javascript"></script>
    <script src="../js/StringPrototypeFunction.js" type="text/javascript"></script>
    <script src="../js/CommValidator.js" type="text/javascript"></script>
    <style type="text/css">
        .typelist {
            border: solid;
            border: 1px 1px 1px 1px;
            filter: alpha(opacity:0);
            visibility: hidden;
            position: absolute;
            z-index: 1;
        }

        .noselect {
            border-top: #eee 1px solid;
            padding-left: 2px;
            background: #fff;
            width: 100%;
            color: #000;
        }

        .isselect {
            border-top: #047 1px solid;
            padding-left: 2px;
            background: #058;
            width: 100%;
            color: #fe0;
        }

        .CALLBUTTON {
            visibility: visible;
        }

        .CALLBUTTON1 {
            visibility: visible;
            border-right: #7b9ebd 1px solid;
            padding-right: 2px;
            border-top: #7b9ebd 1px solid;
            padding-left: 2px;
            font-size: 12px;
            filter: progid:DXImageTransform.Microsoft.Gradient(GradientType=0, StartColorStr=#ffffff, EndColorStr=#3C9562);
            border-left: #7b9ebd 1px solid;
            cursor: pointer;
            color: black;
            padding-top: 2px;
            border-bottom: #7b9ebd 1px solid;
            width: 60px;
            height: 25px;
        }

        .mytable {
            background-color: #C0DE98;
            border-color: White;
            border-width: 0px;
            border-style: Ridge;
        }
    </style>
    </head>
<body>
    <form id="form1" runat="server">
        
        <div id="backgroundCover" style="display:none;width:100%;height:100%;overflow:hidden;z-index:100;background-color:gray;opacity:0.2"></div>
    <div>
            <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
                <tr>
                    <td height="30">
                        <div id="divdrag">
                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <!----xzj--2018/7/11-----------------------添加style="display:block"-->
                                    <td width="15" height="32" style="display:block">
                                        <img alt="" src="../images/tab_03.png" width="15" height="32" />
                                    </td>
                                    <td width="1101" background="../images/tab_05.gif">
                                        <ul class="hor_ul">
                                            <li>
                                                <span id="Lang_volumeControl"></span></li>
                                        </ul>
                                        <div id="processdiv" style="display:none;z-index:1000;margin-left:200px"><img src='../../Images/ProgressBar/05043112.gif' /></div>
                                    </td>
                                    <td width="281" background="../images/tab_05.gif" align="right">
                                        <img alt="" class="style6" style="cursor: pointer;" onclick="CloseWindow()" onmouseover="javascript:this.src='../images/close_un.png';"
                                            onmouseout="javascript:this.src='../images/close.png';" src="../images/close.png" />
                                    </td>
                                    <!----xzj--2018/7/11-----------------------添加height="32" style="display:block"-->
                                    <td width="14" height="32" style="display:block">
                                        <img alt="" src="../images/tab_07.png" width="14" height="32" />
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td width="15" background="../images/tab_12.gif">&nbsp;
                                </td>
                                <td id="nodragtd" align="center">
                                    <table class="style1" cellspacing="1" id="dragtd">
                                        <tr>
                                            <td class="style3" align="right" style="width: 100px; height: 450px">
                                                <div>
                                                    <%--小组列表:--%><span id="Lang_groupmember"></span><span>&nbsp;&nbsp</span>
                                                </div>
                                            </td>
                                            <td class="style3" align="left" valign="top">
                                                <select id="searchselect" style="width: 80px; height: 20px">
                                                    <option id="groupbz1" value="GSSI"><%--小组标识--%></option>
                                                    <option id="Lang_GroupName_searchoption" value="GNam"><%--小组名称--%></option>                        
                        
                    </select>                                                
                                 <input type="text" id="searchText" runat="server" /><input onclick="addMemberToSelectGSSIs()" type="button" id="Lang-Add" />
                                                <input type="hidden" id="hiduserinfo" runat="server" />
                   <div id="pagediv" >
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
                                                <%--<option value="1"></option>--%>
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
                                        <td id="Lang_groupnum"><%--条数--%></td>
                                        <td id="totalcounts" colspan="2"></td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </div>
                <div id="Resultdiv" style="display:none;z-index:1000">
                    <table><tr><td id="Lang_HaveDoingCount"></td><td id="haveDoneCount" style="cursor:pointer;color:red" onclick="paintResultAll()"></td><td id="Lang_HaveDoingSUCEESSCount"></td><td id="successCount" style="cursor:pointer;color:red" onclick="paintResultSuccess()"></td><td id="Lang_HaveDoingFailedCount"></td><td id="failedCount" style="cursor:pointer;color:red" onclick="paintResultfail()"></td></tr></table>
                </div>
<div id="policetitlediv" style="width: 99%; margin-top: 2px; margin-left: 1px; text-align: center; ">
                    <table cellspacing="1" cellpadding="0" id="GridView1" style="background-color: #C0DE98; border-color: White; border-width: 0px; border-style: Ridge; width: 400px;">
                        <tr class="gridheadcss" style="font-weight: bold;">
                            <th id="Lang-T-GroupNametext" style="width: 110px"><%--小组名称--%></th>                  
                            <th id="groupbz" style="width: 110px"><%--小组标识--%></th>                     
                            <th id="Lang_voice" style="width: 50px"><%--小组音量--%></th>
                            <th id="Lang_OpeResult" style="width: 60px"><%--执行结果--%></th>                         
                            <th id="Lang_Operate" style="width: 70px"><%--操作--%></th>
                        </tr>
                    </table>
                </div>
                   <div id="div_selectGSSIList" style="width: 405px; height: 310px; background-color: azure;overflow:auto;position:absolute"></div>
                                            </td>
                                            <td align="left" style="width: 80px;">

                                                <img alt="" src="<%--../images/chooseMember0.png--%>" id="imgSelectUser" onclick="OnAddMember()" onmouseover="<%--javascript:this.src='../images/chooseMember_un.png';--%>"
                                                    onmouseout="<%--javascript:this.src='../images/chooseMember0.png';--%>" />&nbsp;                                            
                                            </td>
                                        </tr>

                                        <tr>
                                            <td><span id="Lang_volumeControl"><%--音量控制--%></span></td>
                                            <td align="left" style="width: 100px" colspan="2">
                                                <span id="Lang_openVoice"><%--开启声音--%></span><asp:RadioButton ID="RadioButton_loud" runat="server"
                    GroupName="Radiogroup" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <span id="Lang_mute"><%--静音--%></span><asp:RadioButton ID="RadioButton_mute" runat="server"
                    GroupName="Radiogroup" />                                                
                                            </td>
                                        </tr>
                                                                                                  
                                        <tr>
                                            <td class="style3" align="center" colspan="3">
                                                <table>
                                                    <tr>
                                                        <td>
                                                            <input class="CALLBUTTON1" onclick="excute()" type="button" id="Lang_apply" /><%--确定--%>                                                            
                                                        </td>
                                                        <td>
                                                            <input class="CALLBUTTON1" onclick="clearList()" type="button" id="Lang_clear"/><%--清除--%>                                                           
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td align="center">
                                                            <span style="color: red" id="span_result"></span>
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
                                    <img alt="" src="../images/tab_20.png" width="15" height="15" />
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
                                    <img alt="" src="../images/tab_22.png" width="14" height="15" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </div>
    </form>
    <script type="text/javascript">
        var image = window.document.getElementById("imgSelectUser");
        var srouce = "../" + window.parent.parent.GetTextByName("Lang_chooseMemberPNG", window.parent.parent.useprameters.languagedata);
        image.setAttribute("src", srouce);        
        var strpath = "../" + window.parent.parent.GetTextByName("Lang_chooseMemberPNG", window.parent.parent.useprameters.languagedata);
        var strpathmove = "../" + window.parent.parent.GetTextByName("Lang_chooseMemberPNG_un", window.parent.parent.useprameters.languagedata);
        image.onmousemove = function () { this.src = strpathmove }//"javascript:this.src='../../images/btn_add_un.png'";// onmouse_move();
        image.onmouseout = function () { this.src = strpath }//"javascript:this.src='../../images/btn_add.png'";//  onmouse_out();
        var Lang_ThisRecordHasAdd = window.parent.GetTextByName("Lang_ThisRecordHasAdd", window.parent.useprameters.languagedata);
        var Lang_nodata = window.parent.GetTextByName("Lang_nodata", window.parent.useprameters.languagedata);
        var Delete = window.parent.GetTextByName("Delete", window.parent.useprameters.languagedata);
        var Operationfails = window.parent.GetTextByName("Operationfails", window.parent.useprameters.languagedata);//操作失败
        var Callcontrolisnotavailable = window.parent.parent.GetTextByName("Callcontrolisnotavailable", window.parent.parent.useprameters.languagedata);//请检查呼叫控件是否正确安装
        var pleaseinput = window.parent.GetTextByName("Lang_pleaseinput", window.parent.useprameters.languagedata);
        var pleaseinput = window.parent.GetTextByName("Lang_pleaseinput", window.parent.useprameters.languagedata);
        var pleaseselectcontroltype = window.parent.GetTextByName("pleaseselectcontroltype", window.parent.useprameters.languagedata);
        var listisblank = window.parent.GetTextByName("listisblank", window.parent.useprameters.languagedata);
        var checkcallcontrolregister = window.parent.GetTextByName("checkcallcontrolregister", window.parent.useprameters.languagedata);
        var groupbz = window.parent.GetTextByName("groupbz", window.parent.useprameters.languagedata);
        var SelectGSSIs = new Array();
        var paintData = new Array();
        var successGSSIs = new Array();
        var failGSSIs = new Array();
        var eachpagenum = 50;
        var policenum = 0;
        var pagenum = 0;
        var presentpage = 0;        
        window.document.getElementById("groupbz").innerHTML = groupbz;
        window.document.getElementById("groupbz1").innerHTML = groupbz;

        function OnAddMember() {
            window.parent.mycallfunction('AddMemberTree/add_Member', 650, 514, '0&ifr=volumeControl_ifr&selectcount=1000&type=group&selfclose=1', 2001);
        }

        var groupname = "";
        var GSSI = "";
        function addMemberToSelectGSSIs() {
             groupname = "";
             GSSI = "";
            var searchselect = document.getElementById("searchselect");
            if (document.getElementById("searchText").value == "") {
                //请输入搜索内容               
                alert(pleaseinput);
                return;
            }
            if (searchselect.value == "GSSI") {
                GSSI = document.getElementById("searchText").value;
                for (var i = 0; i < SelectGSSIs.length; i++) {
                    if (SelectGSSIs[i].GSSI == GSSI) {
                        alert(Lang_ThisRecordHasAdd);
                        return;
                    }
                }
            }
            else if (searchselect.value == "GNam") {
                groupname = document.getElementById("searchText").value;
            }

            $.ajax({
                type: "POST",
                url: "../../Handlers/GetGroupInfo_Handler2.ashx",
                data: "GSSI=" + GSSI + "&groupname=" + groupname,
                success: function (msg) {
                    var searchGroupInfo = eval(msg);
                    if (searchGroupInfo[0].groupname == "undefined") {
                        alert(Lang_nodata);//Lang_nodata
                        return;
                    }
                    //判断是否已添加到列表
                    if (groupname!="") {
                        for (var i = 0; i < SelectGSSIs.length; i++) {
                            if (SelectGSSIs[i].GSSI == searchGroupInfo[0].GSSI) {
                                alert(Lang_ThisRecordHasAdd);
                                return;
                            }
                        }
                    }
                    //添加成员
                    addSelectGSSIs(searchGroupInfo[0].GSSI,searchGroupInfo[0].groupname,searchGroupInfo[0].groupentityname,"",-1);
                    setPaintDataAndPageinfo(SelectGSSIs);
                    displaypresentpage();
                }
            });
        }
        function setPaintDataAndPageinfo(data) {
            paintData = data;
            policenum = paintData.length;
            pagenum = Math.ceil(policenum / eachpagenum);
            presentpage = 1;
        }
        //添加成员
        function addSelectGSSIs(GSSI, groupname, groupentityname, type, isOpeSuccess) {
            SelectGSSIs.push({ GSSI: GSSI, groupname: groupname, groupentityname: groupentityname, type: type,isOpeSuccess:isOpeSuccess });
        }
        function displaypresentpage()
        {            
            createpagetables();
            displaypresentpageItems();            
        }
        function clearExsitGSSITable() {
            document.getElementById("div_selectGSSIList").innerHTML = "";
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
                if (pagenum==0 || presentpage == pagenum) {
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
                if (pagenum == 0 || presentpage == pagenum) {
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
                if (policenum == 0) {
                    //页数                         
                    document.getElementById("totalpages").innerHTML = 0 + "/" + 0;
                    //条数
                    document.getElementById("totalcounts").innerHTML = 0 + "-" + 0 + "/" + 0;
                }
                else {
                    //页数                         
                    document.getElementById("totalpages").innerHTML = presentpage + "/" + pagenum;
                    //条数
                    if (presentpage != pagenum) {
                        document.getElementById("totalcounts").innerHTML = ((presentpage - 1) * eachpagenum + 1) + "-" + presentpage * eachpagenum + "/" + policenum;
                    }
                    else {
                        document.getElementById("totalcounts").innerHTML = ((presentpage - 1) * eachpagenum + 1) + "-" + policenum + "/" + policenum;
                    }
                }
                //转到
                var pageselect = document.getElementById("pageselect");
                if (pagenum!=0 && pagenum != pageselect.childNodes.length) {
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
                    displaypresentpage();
                }
            }
            catch (e) {
                //alert("createpage" + e);
            }
        }
        function firstpage() {
            if (presentpage != 1) {
                presentpage = 1;
                displaypresentpage();
            }
        }
        function prepage() {
            if (presentpage > 1) {
                presentpage--;
                displaypresentpage();
            }
        }
        function nextpage() {
            if (presentpage < pagenum) {
                presentpage++;
                displaypresentpage();
            }
        }
        function lastpage() {
            if (presentpage != pagenum) {
                presentpage = pagenum;
                displaypresentpage();
            }
        }
        function displaypresentpageItems() {
            clearExsitGSSITable();
            creatGSSItable();
        }
        function creatGSSItable() {
            try {
                var policetable = document.createElement("table");
                policetable.id = "GSSItable";
                policetable.style.marginTop = "0px";
                policetable.style.textAlign = "center";
                policetable.style.position = "absolute";
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
                    policetr.id = paintData[i + indexstep].GSSI;
                    policetr.style.backgroundColor = "white";
                    policetr.onmouseover = function () {
                        this.style.backgroundColor = "green";
                    }
                    policetr.onmouseout = function () {
                        this.style.backgroundColor = "white";
                    }
                    //Nam
                    var policetd_Nam = document.createElement("td");
                    policetd_Nam.innerHTML = "(" + paintData[i + indexstep].groupname + ")";
                    policetd_Nam.title = paintData[i + indexstep].groupname;
                    policetd_Nam.id = "groupName_" + paintData[i + indexstep].GSSI;
                    policetd_Nam.style.width = "110px";
                    policetd_Nam.style.textAlign = "center";
                    policetr.appendChild(policetd_Nam);
                    //GSSI
                    var policetd_ISSI = document.createElement("td");
                    policetd_ISSI.innerHTML = paintData[i + indexstep].GSSI;
                    policetd_ISSI.style.width = "110px";
                    policetd_ISSI.style.textAlign = "center";                    
                    policetr.appendChild(policetd_ISSI);
                                
                    //voice_picture
                    var policetd_voice_picture = document.createElement("td");
                    policetd_voice_picture.id = "voicetd_" + paintData[i + indexstep].GSSI;
                    policetd_voice_picture.style.width = "40px";
                    policetd_voice_picture.style.cursor = "hand";
                    
                        if (isMute(paintData[i + indexstep].GSSI)) {                            
                            policetd_voice_picture.innerHTML = "<img id='voiceImg_" + paintData[i + indexstep].GSSI + "' src='../img/mute.png'/>";
                            var hasMuted = window.parent.GetTextByName("Lang_hasMuted", window.parent.useprameters.languagedata);  
                        }
                        else {                            
                            policetd_voice_picture.innerHTML = "<img id='voiceImg_" + paintData[i + indexstep].GSSI + "' src='../img/loud.png'/>";
                            var hasLouded = window.parent.GetTextByName("Lang_hasLouded", window.parent.useprameters.languagedata);   
                        }
                        policetd_voice_picture.onclick = function () {
                            changeVoiceAndPictureAndVarByClickone(this.id.split('_')[1]);
                        }
                    policetr.appendChild(policetd_voice_picture);
                    
                    //isOpeSuccess
                    var policetdIsOpeSuccess = document.createElement("td");
                    policetdIsOpeSuccess.id = "isOpeSuccess_" + paintData[i + indexstep].GSSI;
                    policetdIsOpeSuccess.style.width = "60px";
                    if (paintData[i + indexstep].isOpeSuccess == true) {
                        policetdIsOpeSuccess.innerHTML = "<img id='isOpeSuccessImg_" + paintData[i + indexstep].GSSI + "' src='../images/isinviewyes.png'/>";
                        var success = window.parent.GetTextByName("OperationSuccessful", window.parent.useprameters.languagedata);
                        policetdIsOpeSuccess.title = success;
                    }
                    else if (paintData[i + indexstep].isOpeSuccess == false) {
                        policetdIsOpeSuccess.innerHTML = "<img id='isOpeSuccessImg_" + paintData[i + indexstep].GSSI + "' src='../images/isinviewno.png'/>";
                        var fail = window.parent.GetTextByName("Operationfails", window.parent.useprameters.languagedata);
                        policetdIsOpeSuccess.title = fail;
                    }
                    else {
                        policetdIsOpeSuccess.innerHTML = "";
                    }
                    
                    policetr.appendChild(policetdIsOpeSuccess);
                    
                    //操作
                    var policetd_operate = document.createElement("td");
                    policetd_operate.id = "operate_" + paintData[i + indexstep].GSSI;                    
                    policetd_operate.style.width = "60px";
                    policetd_operate.innerHTML = "<span style='cursor:pointer;;color:red'>" + Delete + "</span>";
                    policetd_operate.onclick = function () {
                        deleteThisLine(this.id.split('_')[1]);
                    }

                    policetr.appendChild(policetd_operate);

                    policetable.appendChild(policetr);
                }
                var policetree = document.getElementById("div_selectGSSIList");
                policetree.appendChild(policetable);
                policetree.style.display = "block";
            }
            catch (e) {
                //alert("creatpolicetable" + e);
            }
        }
        function deleteThisLine(GSSI) {
            var isOpeSuccessTd = document.getElementById("isOpeSuccessImg_" + GSSI);
            if (isOpeSuccessTd && isOpeSuccessTd.src.indexOf("yes")>0) {
                delFromPaintData(GSSI);
                delFromSelectGSSIs(GSSI);
                delFromSuccessGSSIs(GSSI);
                setPaintDataAndPageinfo(paintData);
                changeResultCountByDelete(true);
                displaypresentpage();
            }
            else if (isOpeSuccessTd && isOpeSuccessTd.src.indexOf("no") > 0) {
                delFromPaintData(GSSI);
                delFromSelectGSSIs(GSSI);
                delFromFailGSSIs(GSSI);
                setPaintDataAndPageinfo(paintData);
                changeResultCountByDelete(false);
                displaypresentpage();
            }
            else {
                delFromPaintData(GSSI);
                delFromSelectGSSIs(GSSI);
                setPaintDataAndPageinfo(paintData);
                displaypresentpage();
            }
        }
        function isMute(GSSI) {
            var mute = false;
            for (var i = 0; i < window.parent.useprameters.muteGroupList.length; i++) {
                if (GSSI == window.parent.useprameters.muteGroupList[i]) {
                    mute = true;
                    break;
                }
            }
            return mute;
        }
        function changeVoiceAndPictureAndVarByClickone(GSSI) {
            if (isMute(GSSI)) {
                loudVoiceAndPictureAndVarByClickone(GSSI);
            }
            else {
                muteVoiceAndPictureAndVarByClickone(GSSI)
            }
        }
        function loudVoiceAndPictureAndVarByClickone(GSSI) {
            //打开声音
            var scactionX = window.parent.frames['log_windows_ifr'].document.getElementById('SCactionX');
            if (scactionX) {
                if (window.parent.useprameters.callActivexable) {
                    var reVal = changeVoiceByGroupISSI(GSSI, 100);
                    if (reVal == 1) {
                        changePictureByGSSI(GSSI, false);
                        removeFromMuteGroupList(GSSI);
                    }
                    else if (reVal == 0) {
                        alert(Operationfails);
                    }
                }
                else {
                    alert(checkcallcontrolregister);
                }
            }
            else {
                alert(checkcallcontrolregister);
            }
        }
        function loudVoiceAndPictureAndVar(GSSI) {
            //打开声音
            try {
                var reVal = -1;
                reVal = changeVoiceByGroupISSI(GSSI, 100);
                if (reVal == 1) {
                    changePictureByGSSI(GSSI, false);
                    removeFromMuteGroupList(GSSI);
                    
                }
                else if (reVal == 0) {
                    
                }
            }
            catch (e) {
                reVal = 0;
            }
            return reVal;
        }
        function muteVoiceAndPictureAndVarByClickone(GSSI) {
            //关闭声音
            var scactionX = window.parent.frames['log_windows_ifr'].document.getElementById('SCactionX');
            if (scactionX) {
                if (window.parent.useprameters.callActivexable) {
                var reVal = changeVoiceByGroupISSI(GSSI, 0);
                if (reVal == 1) {
                    changePictureByGSSI(GSSI, true);
                    addToMuteGroupList(GSSI);
                }
                else if (reVal == 0) {
                    alert(Operationfails);
                }
                }
                else {
                    alert(checkcallcontrolregister);
                }
            }
            else {
                alert(checkcallcontrolregister);
            }
        }
        function muteVoiceAndPictureAndVar(GSSI) {
            //关闭声音
            try{
                var reVal = -1;
                reVal = changeVoiceByGroupISSI(GSSI, 0);
                if (reVal == 1) {
                    changePictureByGSSI(GSSI, true);
                    addToMuteGroupList(GSSI);
                    
                }
                else if (reVal == 0) {
                    
                }
            }
            catch (e) {
                reVal = 0;
            }
            return reVal;
        }
        function changeVoiceByGroupISSI(issi, voice) {
            $.ajax({
                type: "POST",
                url: "LogView/Add_volumeControlLog.aspx",
                data: "GSSI=" + issi + "&voice=" + voice,
                success: function (msg) {
                   
                }
            });
            var reVal = -1;
            var scactionX = window.parent.frames['log_windows_ifr'].document.getElementById('SCactionX');
            if (scactionX) {
                if (window.parent.useprameters.callActivexable) {
                    try {
                        if (voice == 0) {
                            //关闭声音
                            reVal = scactionX.VolumeControl(4, issi, 0);
                        }
                        else if (voice > 0 && voice <= 100) {
                            //打开声音 
                            reVal = scactionX.VolumeControl(4, issi, 100);
                        }
                    }
                    catch (ex) {
                        reVal = 0;

                    }
                }
            }
            return reVal;
        }
        function changePictureByGSSI(GSSI, isMute) {
            var voiceImgGSSI = document.getElementById("voiceImg_" + GSSI)
            if(voiceImgGSSI){
                if (isMute) {                
                    voiceImgGSSI.src = "../img/mute.png";
                }
                else {
                    voiceImgGSSI.src = "../img/loud.png";
                }
            }
        }
        function removeFromMuteGroupList(GSSI) {
            for (var i = 0; i < window.parent.useprameters.muteGroupList.length; i++) {
                if (GSSI == window.parent.useprameters.muteGroupList[i]) {
                    window.parent.useprameters.muteGroupList.splice(i,1);
                }
            }
        }
        function addToMuteGroupList(GSSI) {            
            if (isNotInList(GSSI, window.parent.useprameters.muteGroupList)) {
                window.parent.useprameters.muteGroupList.push(GSSI);
            }
        }
        function isNotIn(GSSI,listObj) {
            var isNotIn = true;
            for (var i = 0; i < listObj.length; i++) {
                if (GSSI == listObj[i].GSSI) {
                    isNotIn = false;
                    break;
                }
            }
            return isNotIn;
        }
        function isNotInList(GSSI, list) {
            var isNotIn = true;
            for (var i = 0; i < list.length; i++) {
                if (GSSI == list[i]) {
                    isNotIn = false;
                    break;
                }
            }
            return isNotIn;
        }
        function addToSuccessGSSIs(listItem) {
            if (isNotIn(listItem.GSSI, successGSSIs)) {
                successGSSIs.push(listItem);
            }
        }
        function addToFailGSSIs(listItem) {
            if (isNotIn(listItem.GSSI, failGSSIs)) {
                failGSSIs.push(listItem);
            }
        }
        function delFromPaintData(GSSI) {
            for (var i = 0; i < paintData.length; i++) {
                if (GSSI == paintData[i].GSSI) {
                    paintData.splice(i, 1);
                    break;
                }
            }
        }
        function delFromSelectGSSIs(GSSI) {
                for (var i = 0; i < SelectGSSIs.length; i++) {
                    if (GSSI == SelectGSSIs[i].GSSI) {
                        SelectGSSIs.splice(i, 1);
                        break;
                    }
                }
            }
        function delFromSuccessGSSIs(GSSI) {
                for (var i = 0; i < successGSSIs.length; i++) {
                    if (GSSI == successGSSIs[i].GSSI) {
                        successGSSIs.splice(i, 1);
                        break;
                    }
                }
            }
        function delFromFailGSSIs(GSSI) {
                for (var i = 0; i < failGSSIs.length; i++) {
                    if (GSSI == failGSSIs[i].GSSI) {
                        failGSSIs.splice(i, 1);
                        break;
                    }
                }
            }
        function faterdo(retrunissis) {
            SelectGSSIs.length = 0;
            for (var i = 0; i < retrunissis.length; i++) {
                addSelectGSSIs(retrunissis[i].uissi, retrunissis[i].uname, "", retrunissis[i].utype, -1);
            }
            setPaintDataAndPageinfo(SelectGSSIs);
            displaypresentpage();
        }
        function excute() {
            var scactionX = window.parent.frames['log_windows_ifr'].document.getElementById('SCactionX');
            if (scactionX) {
                if (window.parent.useprameters.callActivexable) {
                    var RadioButton_loud = document.getElementById("RadioButton_loud");
                    var RadioButton_mute = document.getElementById("RadioButton_mute");
                    if (RadioButton_loud.checked == false && RadioButton_mute.checked == false) {
                        alert(pleaseselectcontroltype);
                        return;
                    }
                    if (paintData.length == 0) {
                        alert(listisblank);
                        return;
                    }
                    displayCoverAndProcessbar();
                    disableResultDiv();
                    displayResultdiv();
                    setTimeout(excuteChangeGroupListVoice,1);
                    
                }
                else {
                    alert(checkcallcontrolregister);
                }
            }
            else {
                alert(Callcontrolisnotavailable);
            }
        }
        function excuteChangeGroupListVoice() {
            //开启声音

            clearResultCount();
            var RadioButton_loud = document.getElementById("RadioButton_loud");
            var RadioButton_mute = document.getElementById("RadioButton_mute");
            if (RadioButton_loud.checked == true) {
                excuteLoud();
            }
            else if (RadioButton_mute.checked == true) {
                excuteMute();
            }
            hideCoverAndProcessbar();
            enableResultDiv();
        }

        function clearList() {
            try{                
                SelectGSSIs.length = 0;
                paintData.length = 0;
                successGSSIs.length = 0;
                failGSSIs.length = 0;
                hideResultdiv();
                clearPageTable();
                setPaintDataAndPageinfo(SelectGSSIs);
                displaypresentpage();     
            }
            catch (e) { }
        }
        function clearPageTable() {
            var pageselect = document.getElementById("pageselect");
            if (pageselect) {
                pageselect.innerHTML = "";
            }
        }
        function displayCoverAndProcessbar() {
            document.getElementById("backgroundCover").style.display = "block";
            document.getElementById("processdiv").style.display = "block";
        }
        function hideCoverAndProcessbar() {
            document.getElementById("backgroundCover").style.display = "none";
            document.getElementById("processdiv").style.display = "none";
        }
        function hideProcess() {
            document.getElementById("processdiv").style.display = "none";
        }
        function hideResultdiv() {
            document.getElementById("Resultdiv").style.display = "none";
        }
        function displayResultdiv() {
            document.getElementById("Resultdiv").style.display = "block";
        }
        function disableResultDiv() {
            document.getElementById("Resultdiv").disabled = true;
        }
        function enableResultDiv() {
            document.getElementById("Resultdiv").disabled = false;
        }
        function setSelectGSSIsIsOpeSuccess(GSSI, isOpeSuccess){
            for (var i = 0; i < SelectGSSIs.length; i++) {
                if (GSSI == SelectGSSIs[i].GSSI) {
                    SelectGSSIs[i].isOpeSuccess = isOpeSuccess;
                    break;
                }
            }
        }
        function changeResultCountByDelete(isOpeSuccess) {
            var haveDoneCount = document.getElementById("haveDoneCount");
            var successCount = document.getElementById("successCount");
            var failedCount = document.getElementById("failedCount");
            if (haveDoneCount) {
                haveDoneCount.innerHTML = (parseInt(haveDoneCount.innerText.split('/')[0]) - 1).toString() + "/" + paintData.length;
            }
            if (isOpeSuccess) {                
                if (successCount) {
                    successCount.innerText = parseInt(successCount.innerText) - 1;
                }
            }
            else {                
                if (failedCount) {
                    failedCount.innerText = parseInt(failedCount.innerText) - 1;
                }
            }
        }
        function changeResultCount(excutedNum,isOpeSuccess) {
            var haveDoneCount = document.getElementById("haveDoneCount");
            haveDoneCount.innerHTML = excutedNum + "/" + paintData.length;
            if (isOpeSuccess) {
                var successCount = document.getElementById("successCount");
                successCount.innerText =parseInt(successCount.innerText) + 1;
            }
            else {
                var failedCount = document.getElementById("failedCount");
                failedCount.innerText = parseInt(failedCount.innerText) + 1;
            }
        }
        function clearResultCount() {
            var haveDoneCount = document.getElementById("haveDoneCount");
            haveDoneCount.innerHTML = 0 / 0;

            var successCount = document.getElementById("successCount");
            successCount.innerHTML = 0;

            var failedCount = document.getElementById("failedCount");
            failedCount.innerHTML = 0;
        }
        function excuteLoud(){
            for (var i = 0; i < paintData.length; i++) {
                var reVal = loudVoiceAndPictureAndVar(paintData[i].GSSI);
                if (reVal == 1) {
                    paintData[i].isOpeSuccess = true;
                    setSelectGSSIsIsOpeSuccess(paintData[i].GSSI, true);
                    addToSuccessGSSIs(paintData[i]);
                    changeResultCount(i + 1, true);
                    setIsOpeSuccessPicture(paintData[i].GSSI,true);
                }
                else {
                    paintData[i].isOpeSuccess = false;
                    setSelectGSSIsIsOpeSuccess(paintData[i].GSSI, false);
                    addToFailGSSIs(paintData[i]);
                    changeResultCount(i + 1, false);
                    setIsOpeSuccessPicture(paintData[i].GSSI, false);
                }
            }
        }
        function excuteMute() {
            for (var i = 0; i < paintData.length; i++) {
                var reVal = muteVoiceAndPictureAndVar(paintData[i].GSSI);
                if (reVal == 1) {
                    paintData[i].isOpeSuccess = true;
                    setSelectGSSIsIsOpeSuccess(paintData[i].GSSI, true);
                    addToSuccessGSSIs(paintData[i]);
                    changeResultCount(i + 1, true);
                    setIsOpeSuccessPicture(paintData[i].GSSI, true);
                }
                else {
                    paintData[i].isOpeSuccess = false;
                    setSelectGSSIsIsOpeSuccess(paintData[i].GSSI, false);
                    addToFailGSSIs(paintData[i]);
                    changeResultCount(i + 1, false);
                    setIsOpeSuccessPicture(paintData[i].GSSI, false);
                }
            }
        }
        function paintResultAll(){
            setPaintDataAndPageinfo(SelectGSSIs);
            displaypresentpage();
        }
        function paintResultSuccess() {
            setPaintDataAndPageinfo(successGSSIs);
            displaypresentpage();
        }
        function paintResultfail() {
            setPaintDataAndPageinfo(failGSSIs);
            displaypresentpage();
        }
        function CloseWindow() {                       
            window.parent.document.frames["mypancallContent"].document.frames["groupcallContent"].tongbumuteGroupListtothispagepicture();
            hideCoverAndProcessbar();
            window.parent.mycallfunction('volumeControl');
        }
        document.onkeypress = function () {
            var search_input = document.getElementById("searchText");
            if (search_input) {
                if (event.keyCode == 13 && document.activeElement.id == "searchText") {
                    if (search_input.value != "") {
                        var search_button = document.getElementById("Lang-Add");
                        if (search_button) {
                            search_button.click();
                        }
                    }
                    event.returnValue = false;
                }
            }
        }
        function setIsOpeSuccessPicture(GSSI,isSuccess) {
            var IsOpeSuccessPicture = document.getElementById("isOpeSuccess_" + GSSI);
            if (IsOpeSuccessPicture && isSuccess) {
                IsOpeSuccessPicture.innerHTML = "<img id='isOpeSuccessImg_" + GSSI +"' src='../images/isinviewyes.png'/>";
            }
            else if (IsOpeSuccessPicture && !isSuccess) {
                IsOpeSuccessPicture.innerHTML = "<img id='isOpeSuccessImg_" + GSSI + "' src='../images/isinviewno.png'/>";
            }
        }
            window.onload = function () {
                LanguageSwitch(window.parent);
                window.parent.closeprossdiv();
                document.body.onmousedown = function () {
                    dragdiv();
                }
                document.body.onmousemove = function () { mydragWindow(); }
                document.body.onmouseup = function () { mystopDragWindow(); }
                document.body.oncontextmenu = function () { return false; }

                var arrayelement = ["input", "a", "li", "font", "textarea"];
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
                var nodragobj = document.getElementById("nodragtd");
                if (nodragobj) {
                    nodragobj.onmouseout = function () {
                        dragEnable = 'True';
                    }
                    nodragobj.onmouseover = function () {
                        dragEnable = 'False';
                    }
                }

            }
            var dragEnable = 'True';
            function dragdiv() {
                var div1 = window.parent.document.getElementById(geturl());
                if (div1 && event.button == 0 && dragEnable == 'True') {
                    window.parent.mystartDragWindow(div1, null, event); div1.style.border = "solid 0px transparent"; window.parent.cgzindex(div1);

                }
            }
            function mydragWindow() {
                var div1 = window.parent.document.getElementById(geturl());
                if (div1) {
                    window.parent.mydragWindow(div1, event);
                }
            }
            function mystopDragWindow() {
                var div1 = window.parent.document.getElementById(geturl());
                if (div1) {
                    window.parent.mystopDragWindow(div1); div1.style.border = "0px";
                }
            }
    </script>
</body>
</html>