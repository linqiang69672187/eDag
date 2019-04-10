<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="add_Member.aspx.cs" Inherits="Web.lqnew.opePages.AddMemberTree.add_Member" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title><%--接收号码--%></title>
    <link href="../../css/lq_manager.css" rel="stylesheet" />
    <link href="../../../CSS/pagestyle.css" rel="stylesheet" />
    <style type="text/css">
        body, .style1
        {
            background-color: transparent;
            margin: 0px;
            font-size: 12px;
            scrollbar-face-color: #DEDEDE;
            scrollbar-base-color: #F5F5F5;
            scrollbar-arrow-color: black;
            scrollbar-track-color: #F5F5F5;
            scrollbar-shadow-color: #EBF5FF;
            scrollbar-highlight-color: #F5F5F5;
            scrollbar-3dlight-color: #C3C3C3;
            scrollbar-darkshadow-Color: #9D9D9D;
        }

        .style2
        {
            width: 10px;
        }

        .bg1
        {
            background-image: url('../../view_infoimg/images/bg_02.png');
            background-repeat: repeat-x;
            vertical-align: top;
        }

        .bg2
        {
            background-image: url('../../view_infoimg/images/bg_10.png');
            background-repeat: repeat-x;
        }

        .bg3
        {
            background-image: url('../../view_infoimg/images/bg_05.png');
            background-repeat: repeat-y;
        }

        .bg4
        {
            background-image: url('../../view_infoimg/images/bg_06.png');
        }

        .bg5
        {
            background-image: url('../../view_infoimg/images/bg_07.png');
            background-repeat: repeat-y;
        }

        #divClose
        {
            width: 33px;
            height: 16px;
            position: relative;
            border: 0px;
            float: right;
            margin-top: 1px;
            background-image: url('../../view_infoimg/images/minidict_03.png');
            cursor: hand;
        }

        .gridheadcss th
        {
            background-image: url(../images/tab_14.gif);
            height: 25px;
        }

        #GridView1
        {
            margin-top: 3px;
            font-size: 12px;
        }

        .td1td
        {
            background-color: #FFFFFF;
            text-align: right;
        }

        .divgrd
        {
            margin: 2 0 2 0;
            overflow: auto;
            height: 365px;
        }

        #tags
        {
            width: 99px;
        }

        .style3
        {
            width: 37px;
        }
    </style>
    
    <script src="../../../JQuery/jquery-1.5.2(ture).js" type="text/javascript"></script>
    <script src="../../../JQuery/jquery-ui-autocomplete.js" type="text/javascript"></script>
    <link href="../../../CSS/jquery-ui-1.8.14.custom.css" rel="stylesheet" type="text/css" />
    <script src="../../../JS/LangueSwitch.js"></script>
    <script type="text/javascript">
        document.onkeypress = function () {

        }
    </script>
    <script type="text/javascript">
        var CheckUsersJson = {};
        var SelectCount = 0;
        var CheckUsers = new Array();
        function AddCheckUser(uname, uissi, utype, id, issitype) {
            SelectCount++
            //document.getElementById("span_count").innerHTML = SelectCount;
            CheckUsersJson[uissi] = { uname: uname, uissi: uissi, utype: utype, id: id, issitype:issitype };
        }
        function removeCheckUsers(uissi) {
           
            SelectCount--;
            //document.getElementById("span_count").innerHTML = SelectCount;
            window.document.getElementById("chk_selectall").checked = false;
          
            //CheckUsersJson[uissi] = undefined;
            delete CheckUsersJson[uissi];
        }

        function changeSelthisPageAll() {
            if (currentPage <= 0) {
                return;
            }
            var endi = 0;
            if (isLastPage(currentPage) && currentPage > 0) {
                endi = totalCounts;
            } else {
                endi = (currentPage - 1) * everypagecount + everypagecount;
            }
            var begi = (currentPage - 1) * everypagecount;
            var bool = true;
            for (var i = begi; i < endi; i++) {
                if (SelectUserIlists[i].ucheck == "0") {
                    bool = false;
                    break;
                }
            }

            if (bool) {

                window.document.getElementById("selthisPageAll").checked = "checked";
            } else {
                window.document.getElementById("selthisPageAll").checked = false;
            }

        }
        function changeSelAll() {
            if (SelectUserIlists.length == 0) {
                window.document.getElementById("chk_selectall").checked = false;
                return;
            }
           
            var bool = true;
            for (var i = 0; i < SelectUserIlists.length; i++) {
                if (SelectUserIlists[i].ucheck == "0") {
                    bool = false;
                    break;
                }
            }

            if (bool) {

                window.document.getElementById("chk_selectall").checked = "checked";
            } else {
                window.document.getElementById("chk_selectall").checked = false;
            }
        }
        //全选本单位或本类型
        function onclickSelectAll(obj) {
            if (currentPage <= 0) {
                return;
            }
            var endi = 0;
            if (isLastPage(currentPage) && currentPage > 0) {
                endi = totalCounts;
            } else {
                endi = (currentPage - 1) * everypagecount + everypagecount;
            }
            var begi = (currentPage - 1) * everypagecount;
            
            if (obj.checked) {//选中
                for (var i = 0; i < SelectUserIlists.length; i++) {
                    if (SelectUserIlists[i].ucheck == "0") {//判断是否选中了 防止重复添加
                        AddCheckUser(SelectUserIlists[i].uname, SelectUserIlists[i].uissi, SelectUserIlists[i].utype, SelectUserIlists[i].id, SelectUserIlists[i].issitype);
                        SelectUserIlists[i].ucheck = "1";
                    }
                }
                
            } else {
                for (var i = 0; i < SelectUserIlists.length; i++) {
                    removeCheckUsers(SelectUserIlists[i].uissi);
                    SelectUserIlists[i].ucheck = "0"
                }
            }
            for (var i = begi; i < endi; i++) {
                window.document.getElementById("checkbox_" + i).checked = obj.checked;
            }
            window.document.getElementById("selthisPageAll").checked = obj.checked;
            document.getElementById("span_count").innerHTML = SelectCount;
        }
        //全选本页
        function onclickSelctThisPageAll(obj) {
            if (currentPage <= 0) {
                return;
            }
            var endi = 0;
            if (isLastPage(currentPage) && currentPage > 0) {
                endi = totalCounts;
            } else {
                endi = (currentPage - 1) * everypagecount + everypagecount;
            }
            var begi = (currentPage - 1) * everypagecount;
            if (obj.checked) {
                for (var i = begi; i < endi; i++) {
                    window.document.getElementById("checkbox_" + i).checked = "checked";
                    if (SelectUserIlists[i].ucheck == "0") {//判断是否选中了 防止重复添加
                        AddCheckUser(SelectUserIlists[i].uname, SelectUserIlists[i].uissi, SelectUserIlists[i].utype, SelectUserIlists[i].id, SelectUserIlists[i].issitype);
                        SelectUserIlists[i].ucheck = "1";
                        changeSelAll();
                    }
                }

            } else {
                for (var i = begi; i < endi; i++) {
                    window.document.getElementById("checkbox_" + i).checked = obj.checked;
                    removeCheckUsers(SelectUserIlists[i].uissi);
                    SelectUserIlists[i].ucheck = "0"
                }
            }
            document.getElementById("span_count").innerHTML = SelectCount;
        }

        function onclickCheckBoxp(obj, uname, utype, i,id, issitype) {
            if (obj.checked) {
                if (SelectUserIlists[i].ucheck == "0") {//判断是否选中了 防止重复添加
                    AddCheckUser(uname, obj.value, utype,id, issitype);
                    SelectUserIlists[i].ucheck = "1";
                    changeSelAll();
                }
            } else {
                removeCheckUsers(obj.value);
                SelectUserIlists[i].ucheck = "0"
            }
            try {
                changeSelthisPageAll();
            } catch (ex) {

            }
            document.getElementById("span_count").innerHTML = SelectCount;
        }

        var SelectUserIlists = new Array();
        var everypagecount = 100;
        var currentPage = 1;
        var totalPage = 1;
        var totalCounts = 0;
        var Lang_Illegal_terminal_identification = window.parent.parent.GetTextByName("Lang_Illegal_terminal_identification", window.parent.parent.useprameters.languagedata);
        var Delete = window.parent.parent.GetTextByName("Delete", window.parent.parent.useprameters.languagedata);
        var Lang_SendZLIsSendingPleaseSeeSysLogWindow = window.parent.parent.GetTextByName("Lang_SendZLIsSendingPleaseSeeSysLogWindow", window.parent.parent.useprameters.languagedata);
        var Lang_SearchResultList = window.parent.parent.GetTextByName("Lang_SearchResultList", window.parent.parent.useprameters.languagedata);
        var Lang_CheckedResultList = window.parent.parent.GetTextByName("Lang_CheckedResultList", window.parent.parent.useprameters.languagedata);
        //添加成员
        function addSelectUsers(uname, uissi, utype, ucheck,id, issitype) {
            SelectUserIlists.push({ uname: uname, uissi: uissi, utype: utype, ucheck: ucheck,id:id, issitype:issitype });
        }
        //移除成员
        function removeSelectUsers(uissi) {
            for (var i = 0; i < SelectUserIlists.length; i++) {
                if (SelectUserIlists[i].uissi == uissi) {
                    SelectUserIlists.splice(i, 1);
                    break;
                }
            }
        }

        function reroadpagetitle() {
            totalCounts = SelectUserIlists.length;
            if (totalCounts % everypagecount == 0) {
                totalPage = parseInt(totalCounts / everypagecount);
            } else {
                totalPage = parseInt(totalCounts / everypagecount + 1);
            }
            if (currentPage > totalPage) {
                currentPage = totalPage;
            }

            var sel = document.getElementById("sel_page");
            if (sel.length != totalPage) {
                sel.length = 0;
                for (var i = 1; i <= totalPage; i++) {
                    var option = document.createElement("option");
                    option.value = i;
                    option.text = i;
                    sel.add(option);
                }
            }
            sel.value = currentPage;

            document.getElementById("span_currentPage").innerHTML = currentPage;
            document.getElementById("span_totalpage").innerHTML = totalPage;
            document.getElementById("span_total").innerHTML = totalCounts;



        }


        function renderTable() {
            isFirstPage();
            var strResult = "<table style='font-size:12px;width:100%'>";

            var ii = 0;
            if (isLastPage(currentPage) && currentPage > 0) {
                ii = totalCounts;
                document.getElementById("span_currentact").innerHTML = (currentPage - 1) * everypagecount+1 + "~" + totalCounts;
            } else if (currentPage <= 0) {
                document.getElementById("span_currentact").innerHTML = 0 + "~" + currentPage * everypagecount;

            } else {
                ii = (currentPage - 1) * everypagecount + everypagecount;
                document.getElementById("span_currentact").innerHTML = (currentPage - 1) * everypagecount+1 + "~" + currentPage * everypagecount;
            }

            if (currentPage > 0) {
                for (var i = (currentPage - 1) * everypagecount; i < ii; i++) {
                    var strcheck = "";

                    if (CheckUsersJson[SelectUserIlists[i].uissi] != undefined) {
                        SelectUserIlists[i].ucheck = "1";
                        strcheck = " checked = 'checked'";
                    }

                    if (Request.QueryString("type").trim() == "user") {
                        window.document.getElementById("ISSI_Type_show").style.display = "inline";
                        window.document.getElementById("ISSI_Type_show").style.width = "100px";
                        strResult += "<tr><td align='center' style='width:60px'><input id='checkbox_" + i + "' type='checkbox' " + strcheck + " onclick='onclickCheckBoxp(this,\"" + SelectUserIlists[i].uname + "\",\"" + SelectUserIlists[i].utype + "\",\"" + i + "\",\"" + SelectUserIlists[i].id + "\",\"" + SelectUserIlists[i].issitype + "\")' value='" + SelectUserIlists[i].uissi + "' /></td><td align='center' style='width:100px'>" + SelectUserIlists[i].uname + "</td><td align='center' style='width:100px'>" + SelectUserIlists[i].uissi + "</td><td align='center' style='width:100px'>" + SelectUserIlists[i].utype + "</td><td align='center' style='width:100px'>" + SelectUserIlists[i].issitype + "</td></tr>";
                    } else if (SelectUserIlists[i].uissi != 0 && SelectUserIlists[i].uissi != "") {//20171128虞晨超 添加if（）内的条件，当终端号码为0或空时不显示
                        window.document.getElementById("ISSI_Type_show").style.display = "none";
                        window.document.getElementById("ISSI_Type_show").style.width = "0px";
                        strResult += "<tr><td align='center' style='width:60px'><input id='checkbox_" + i + "' type='checkbox' " + strcheck + " onclick='onclickCheckBoxp(this,\"" + SelectUserIlists[i].uname + "\",\"" + SelectUserIlists[i].utype + "\",\"" + i + "\",\"" + SelectUserIlists[i].id + "\",\"" + SelectUserIlists[i].issitype + "\")' value='" + SelectUserIlists[i].uissi + "' /></td><td align='center' style='width:100px'>" + SelectUserIlists[i].uname + "</td><td align='center' style='width:100px'>" + SelectUserIlists[i].uissi + "</td><td align='center' style='width:100px'>" + SelectUserIlists[i].utype + "</td></tr>";
                    }
                }
            }
            strResult += "</table>";

            window.document.getElementById("div_selectUserList").innerHTML = strResult;
        }
        function isFirstPage() {
            if (currentPage <= 1) {
                window.document.getElementById("Lang_FirstPage").className = "YangdjPageStyleUnClick";
                window.document.getElementById("Lang_PrePage").className = "YangdjPageStyleUnClick";
            } else {
                window.document.getElementById("Lang_FirstPage").className = "YangdjPageStyle";
                window.document.getElementById("Lang_PrePage").className = "YangdjPageStyle";
            }
        }
        //判断是否为最后一页
        function isLastPage(currentPage) {
            if (currentPage >= totalPage) {
               
                window.document.getElementById("Lang_play_next_page").className = "YangdjPageStyleUnClick";
                window.document.getElementById("Lang_LastPage").className = "YangdjPageStyleUnClick";
                
                return true;
            } else {
                window.document.getElementById("Lang_play_next_page").className = "YangdjPageStyle";
                window.document.getElementById("Lang_LastPage").className = "YangdjPageStyle";
                return false;
            }
        }
        function nextPage() {
            if (totalPage <= currentPage) {
                return;
            }
            currentPage++;
            reroadpagetitle();
            renderTable();
            document.getElementById("sel_page").value = currentPage;
            changeSelthisPageAll();
        }
        function prePage() {
            if (currentPage <= 1) {
                return;
            }
            currentPage--;
            reroadpagetitle();
            renderTable();
            document.getElementById("sel_page").value = currentPage;
            changeSelthisPageAll();
        }
        function firstPage() {
            if (currentPage == 1) {
                return;
            }
            currentPage = 1;
            reroadpagetitle();
            renderTable();
            document.getElementById("sel_page").value = currentPage;
            changeSelthisPageAll();
        }
        function lastPage() {
            if (currentPage == totalPage) {
                return;
            }
            currentPage = totalPage;
            reroadpagetitle();
            renderTable();
            document.getElementById("sel_page").value = currentPage;
            changeSelthisPageAll();
        }
        function tzpage() {

            var sel = document.getElementById("sel_page").value;

            if (sel == currentPage) {
                return;
            }
            currentPage = sel;
            reroadpagetitle();
            renderTable();
            document.getElementById("sel_page").value = currentPage;
            changeSelthisPageAll();
        }




        function onpresskey() {
            if (event.keyCode == 13) {

            }
        }
        function Divover(str) {
            var div1 = document.getElementById("divClose");
            if (str == "on") { div1.style.backgroundPosition = "66 0"; }
            else { div1.style.backgroundPosition = "0 0"; }
        }

        document.oncontextmenu = new Function("event.returnValue=false;"); //禁止右键功能,单击右键将无任何反应
        document.onselectstart = new Function("event.returnValue=false;"); //禁止先择,也就是无法复制
        Request = {
            QueryString: function (item) {
                var svalue = location.search.match(new RegExp("[\?\&]" + item + "=([^\&]*)(\&?)", "i"));
                return svalue ? svalue[1] : svalue;
            }
        }
        function onmouse_move() {
            //varstrpathmove = "../" + window.parent.parent.GetTextByName("Lang_AddNew_un", window.parent.parent.useprameters.languagedata);
            this.src = "../../images/btn_add_un.png";
            return false;

        }
        function onmouse_out() {
            this.src = "../../images/btn_add.png";
            return false;
        }

        function selectData(entityid, typeid, mtype,entityName,typeName) {

            var param = { entityid: entityid, typeid: typeid, mtype: mtype };
            window.parent.parent.parent.jquerygetNewData_ajax("../../../Handlers/GetUserOrGroupOrDispatchListByEntityidAndUsertypeID.ashx", param, function (request) {
                SelectUserIlists = eval(request);
                for (var i = 0; i < SelectUserIlists.length; i++) {
                    if (CheckUsersJson[SelectUserIlists[i].uissi] != undefined) {
                        SelectUserIlists[i].ucheck = "1";
                    }
                }
                currentPage = 1;
                totalCounts = SelectUserIlists.length;
                reroadpagetitle();
                renderTable();
                changeSelthisPageAll();
                changeSelAll();
                var r = entityName;
                if (typeName != undefined) {
                    r += "(" + typeName+")";
                }

                selEntityTitle(r);
            }, false, false);
        }
        //xzj--20190218--添加基站短信
        function selectBaseStationData(bsType, typeName) {
            var param = { bsType: bsType };
            window.parent.parent.parent.jquerygetNewData_ajax("../../../Handlers/GetBaseStationForTree.ashx", param, function (request) {
                SelectUserIlists = eval(request);
                for (var i = 0; i < SelectUserIlists.length; i++) {
                    if (CheckUsersJson[SelectUserIlists[i].uissi] != undefined) {
                        SelectUserIlists[i].ucheck = "1";
                    }
                }
                currentPage = 1;
                totalCounts = SelectUserIlists.length;
                reroadpagetitle();
                renderTable();
                changeSelthisPageAll();
                changeSelAll();
                var r = "";
                if (typeName != undefined) {
                    r += "(" + typeName + ")";
                }

                selEntityTitle(r);
            }, false, false);
        }

        function closethispage() {
            if (Request.QueryString("selfclose") != undefined) {
                window.parent.hiddenbg2();
            }
            window.parent.lq_closeANDremovediv('AddMemberTree/add_Member', 'bgDiv');
        }

        var myCheckUsers = new Array();
        function sendok() {
            myCheckUsers.length = 0;
            if (Request.QueryString("selectcount") != "-1" && SelectCount > parseInt(Request.QueryString("selectcount"))) {
                alert(window.parent.parent.GetTextByName("Lang_SelectMemberOverSet", window.parent.parent.useprameters.languagedata) + "(" + Request.QueryString("selectcount") + ")");
                return;
            } else {
                var ifr = Request.QueryString("ifr")
                var sendMsgwindo = window.parent.document.frames[ifr];

                if (sendMsgwindo) {
                    for (var i in CheckUsersJson) {
                        if (CheckUsersJson[i] != undefined) {
                            myCheckUsers.push(CheckUsersJson[i]);
                        }
                    }

                    hasNullTypeUser = false;
                    //hasLTEUser = false;
                    checkUser_HasLTEOrNoType();
                    sendMsgwindo.faterdo(myCheckUsers);
                    closethispage();
                }
            }
        }


        var hasNullTypeUser = false;
        //var hasLTEUser = false;
        function checkUser_HasLTEOrNoType()
        {
            var type = Request.QueryString("type");
            if (type.trim() != "user") {
                return;
            }
            for (var i = 0; i < myCheckUsers.length; i++) {
                if (myCheckUsers[i].issitype.toString().trim() == "" || myCheckUsers[i].issitype.toString().trim() == null || myCheckUsers[i].issitype.toString().trim() == undefined) {
                    hasNullTypeUser = true;
                    myCheckUsers.splice(i, 1);
                    checkUser_HasLTEOrNoType();
                    return;
                }
                //if (myCheckUsers[i].issitype.toString().trim() == "LTE") {
                //    hasLTEUser = true;
                //    myCheckUsers.splice(i, 1);
                //    checkUser_HasLTEOrNoType();
                //    return;
                //}
            }
            if (hasNullTypeUser) {
                var Lang_remove_user_no_type = window.parent.parent.GetTextByName("Lang_remove_user_no_type", window.parent.parent.useprameters.languagedata);
                alert(Lang_remove_user_no_type);
            }
            //if (hasLTEUser) {
            //    var Lang_Remove_LTE_user = window.parent.parent.GetTextByName("Lang_Remove_LTE_user", window.parent.parent.useprameters.languagedata);
            //    alert(Lang_Remove_LTE_user);
            //}
        }

        var dragEnable = 'True';
        function dragdiv() {
            var div1 = window.parent.document.getElementById('AddMemberTree/add_Member');
            if (div1 && event.button == 0 && dragEnable == 'True') {
                window.parent.mystartDragWindow(div1, null, event); div1.style.border = "solid 3px transparent"; window.parent.cgzindex(div1);

            }
        }
        function mydragWindow() {
            var div1 = window.parent.document.getElementById('AddMemberTree/add_Member');
            if (div1) {
                window.parent.mydragWindow(div1, event);
            }
        }

        function mystopDragWindow() {
            var div1 = window.parent.document.getElementById('AddMemberTree/add_Member');
            if (div1) {
                window.parent.mystopDragWindow(div1); div1.style.border = "0px";
            }
        }

        window.onload = function () {

            window.document.getElementById("divClose").style.display = "inline";
            window.document.getElementById("add_okPNG").style.display = "inline";
            window.document.getElementById("cancelbutton").style.display = "inline";

            window.parent.parent.document.getElementById("mybkdiv").style.zIndex = 2000;
            window.parent.parent.document.getElementById("mybkdiv").style.display = "block";
            document.body.onmousedown = function () { dragdiv(); }
            document.body.onmousemove = function () { mydragWindow(); }
            document.body.onmouseup = function () { mystopDragWindow(); }
            document.body.oncontextmenu = function () { return false; }
            document.body.oncontextmenu = function () { return false; }
            var arrayelement = ["input", "a", "select", "li", "font", "textarea","option"];
            for (n = 0; n < arrayelement.length; n++) {
                var inputs = document.getElementsByTagName(arrayelement[n]);
                for (i = 0; i < inputs.length; i++) {
                    inputs[i].onmouseout = function () {
                        dragEnable = 'True';
                    }
                    inputs[i].onmouseover = function () {
                        dragEnable = 'False';
                    }
                    inputs[i].onmousedown = function () {
                        dragEnable = 'False';
                    }
                    inputs[i].onmouseup = function () {
                        dragEnable = 'False';
                    }
                }
            }
            var table = document.getElementById("dragtd");
            table.onmouseout = function () {
                dragEnable = 'True';
            }

            table.onmouseover = function () {
                dragEnable = 'False';
            }
            var tbdiv = document.getElementById("tbtbz");
            if (tbdiv) {
                tbdiv.onmouseout = function () {
                    dragEnable = 'True';
                }
                tbdiv.onmouseover = function () {
                    dragEnable = 'False';
                }
            }
            var ifr = Request.QueryString("ifr")
            var sendMsgwindo = window.parent.document.frames[ifr];
            SelectUserIlists.length = 0;
   
            if (sendMsgwindo) {
                if (ifr == "volumeControl_ifr") {
                    for (var i = 0; i < sendMsgwindo.SelectGSSIs.length; i++) {
                        addSelectUsers(sendMsgwindo.SelectGSSIs[i].groupname, sendMsgwindo.SelectGSSIs[i].GSSI, sendMsgwindo.SelectGSSIs[i].type, "1", "", "");
                        AddCheckUser(sendMsgwindo.SelectGSSIs[i].groupname, sendMsgwindo.SelectGSSIs[i].GSSI, sendMsgwindo.SelectGSSIs[i].type, "", "");
                    }
                }
                else {
                    for (var i = 0; i < sendMsgwindo.SelectUsers.length; i++) {
                        var uid = "0";
                        if (sendMsgwindo.SelectUsers[i].id != undefined) {
                            uid = sendMsgwindo.SelectUsers[i].id;
                        }
                        if (sendMsgwindo.SelectUsers[i].issitype == null || sendMsgwindo.SelectUsers[i].issitype == "") {
                            sendMsgwindo.SelectUsers[i].issitype = "TETRA";
                        }
                        addSelectUsers(sendMsgwindo.SelectUsers[i].uname, sendMsgwindo.SelectUsers[i].uissi, sendMsgwindo.SelectUsers[i].utype, "1", uid, sendMsgwindo.SelectUsers[i].issitype);
                        AddCheckUser(sendMsgwindo.SelectUsers[i].uname, sendMsgwindo.SelectUsers[i].uissi, sendMsgwindo.SelectUsers[i].utype, uid, sendMsgwindo.SelectUsers[i].issitype);
                    }
                }
                document.getElementById("span_count").innerHTML = SelectCount;
                reroadpagetitle();
                renderTable();
                changeSelthisPageAll();
                changeSelAll();
                selEntityTitle(Lang_CheckedResultList);
            }
     
            window.document.getElementById("smstree").src = "mian_tree.aspx?type=" + Request.QueryString("type");

        }
        document.onkeypress = function () {
            if (event.keyCode == 13) {
                event.keyCode = 0;
                event.returnValue = false;
                searchMemberOnServer();
            }
        }
        function searchMemberOnServer() {
            var type = Request.QueryString("type");
            window.document.getElementById("smstree").src = "mian_tree.aspx?type=" + type;
            var txtCondtion = window.document.getElementById("txtCondtion").value;

            var param = { txtCondtion: txtCondtion, mtype: type };
            window.parent.parent.parent.jquerygetNewData_ajax("../../../Handlers/SearchUserOrGroupOrDispatchList.ashx", param, function (request) {
                SelectUserIlists = eval(request);
                for (var i = 0; i < SelectUserIlists.length; i++) {
                    if (CheckUsersJson[SelectUserIlists[i].uissi] != undefined) {
                        SelectUserIlists[i].ucheck = "1";
                    }
                }
                currentPage = 1;
                totalCounts = SelectUserIlists.length;
                reroadpagetitle();
                renderTable();
                changeSelthisPageAll();
                changeSelAll();
                selEntityTitle(Lang_SearchResultList);
            }, false, false);

        }
        
        function showAllSelect() {
            var type = Request.QueryString("type");
            window.document.getElementById("smstree").src = "mian_tree.aspx?type=" + type;

            SelectUserIlists.length = 0;

            for (var i in CheckUsersJson) {
                if (CheckUsersJson[i] != undefined) {
                    addSelectUsers(CheckUsersJson[i].uname, CheckUsersJson[i].uissi, CheckUsersJson[i].utype, "1",CheckUsersJson[i].id, CheckUsersJson[i].issitype);
                }
            }
            
            currentPage = 1;
            totalCounts = SelectUserIlists.length;
            reroadpagetitle();
            renderTable();
            
            window.document.getElementById("selthisPageAll").checked = "checked";
           
            window.document.getElementById("chk_selectall").checked = "checked";
            selEntityTitle(Lang_CheckedResultList);
        }
        function selEntityTitle(title) {
            window.document.getElementById("selEntityTitle").innerHTML = title;
        }
    </script>
    <script src="../../js/geturl.js" type="text/javascript"></script>
</head>
<body>
    <form id="form1" runat="server">

        <table class="style1" cellpadding="0" cellspacing="0">
            <tr style="height: 5px;">
                <td class="style2">
                    <img src="../../view_infoimg/images/bg_01.png" /></td>
                <td class="bg1">
                    <div id="divClose" style="display: none" onmouseover="Divover('on')" onclick="closethispage()" onmouseout="Divover('out')"></div>
                </td>
                <td class="style2">
                    <img src="../../view_infoimg/images/bg_04.png" /></td>
            </tr>
            <tr>
                <td class="bg3">&nbsp;
                </td>
                <td class="bg4" id="dragtd">
                    <table cellpadding="0" cellspacing="0" class="style3">
                        <tr>
                            <td>
                                <table id="tb1" align="center" bgcolor="#c0de98" runat="server" border="0" cellpadding="0" cellspacing="1" width="190px">
                                    <tr>
                                        <td align="left" class="td1td">
                                            <table width="190px" border="0" cellspacing="3">
                                                <tr>
                                                    <td align="left">
                                                        <iframe id="smstree" name="smstree" src="" width="190px" allowtransparency="true" style="padding-top: 0px" frameborder="0" height="425px" scrolling="no"></iframe>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </td> 
                            <td>&nbsp;<br />
                                <br />
                                &nbsp;</td>
                            <td>
                                <table id="Table1" align="center" bgcolor="#c0de98" runat="server" border="0" cellpadding="0" cellspacing="1" width="420px" height="435px">
                                    <tr>
                                        <td align="left" valign="top" class="td1td" id="dragtd">
                                            <table style="width: 400px; font-size: 12px">
                                                <tr>
                                                    <td align="left" colspan="1">
                                                        
                                                        </td>
                                                    <td align="right" colspan="4">
                                                         
                                                       <%-- <span id="btnShowALLCheck" style="cursor:pointer"></span>--%>
                                                        <input id="txtCondtion" type="text" />
                                                        <img id="btnSearch" style="cursor:pointer" onclick="searchMemberOnServer()" />
                                                    </td>

                                                </tr>
                                                <tr>
                                                    <td align="left" colspan="2">
                                                         <span style="color:red" id="selEntityTitle"></span>
                                                        </td>
                                                     
                                                    <td align="right" colspan="3">
                                                      
                                                        <span id="span_selectcount"></span>(<span onclick="showAllSelect()" style="color:red;cursor:pointer;text-decoration:underline" id="span_count"></span>)&nbsp;&nbsp;&nbsp;&nbsp;<span style="cursor:pointer;text-decoration:underline;display:none" id="btnShowALLCheck" onclick="showAllSelect()"></span>
                                                      <span id="Lang_SelectAll"></span><input id="chk_selectall" type="checkbox" onclick="onclickSelectAll(this)" />
                                                          </td>
                                                </tr>
                                                <tr>
                                                     <td align="left" colspan="3"> 
                                                         <span onclick="firstPage()" class="YangdjPageStyle" id="Lang_FirstPage">首页</span>&nbsp;&nbsp;<span onclick="prePage()" class="YangdjPageStyle" id="Lang_PrePage">上一页</span>&nbsp;&nbsp;<span onclick="nextPage()" class="YangdjPageStyle" id="Lang_play_next_page">下一页</span>&nbsp;&nbsp;<span onclick="lastPage()" class="YangdjPageStyle" id="Lang_LastPage">尾页</span>
                                                        <select onchange="tzpage()" id="sel_page"></select>
                                                         </td>
                                                    <td align="right" colspan="2"> <span id="span_page"></span><span id="span_currentPage"></span>/<span id="span_totalpage"></span>&nbsp;&nbsp;&nbsp;<span id="span_Article"></span><span id="span_currentact"></span>/<span id="span_total"></span></td>
                                                </tr>
                                                <tr class="gridheadcss">
                                                    <th align="center" style="width: 60px; background-color: ActiveBorder" >
                                                        <input type="checkbox" id="selthisPageAll" onclick="onclickSelctThisPageAll(this)" />
                                                        
                                                    </th>
                                                    <th align="center" style="width: 100px; background-color: ActiveBorder"><b><span style="cursor: pointer;font-size:14px;color:darkgreen" id="Lang_Name">名称</span></b></th>
                                                    <th align="center" style="width: 100px; background-color: ActiveBorder"><b><span style="cursor: pointer;font-size:14px;color:darkgreen" id="Lang_terminal_identification">终端号码</span></b></th>
                                                    <th align="center" style="width: 100px; background-color: ActiveBorder"><b><span style="cursor: pointer;font-size:14px;color:darkgreen" id="Lang_style">用户类型</span></b></th>
                                                    <th align="center" style="width: 100px; background-color: ActiveBorder" id="ISSI_Type_show"><b><span style="cursor: pointer;font-size:14px;color:darkgreen" id="Lang_TerminalType">终端类型</span></b></th>
                                                </tr>

                                            </table>
                                            <div id="div_selectUserList" style="position: relative; font-size: 12px; top: 2px; width: 400px; height: 320px; background-color: azure; overflow-y: scroll"></div>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" align="left" height="35px">
                                <img id="add_okPNG" style="margin-top: 3px; cursor: hand; display: none" onclick="sendok()" />&nbsp;
                     <img id="cancelbutton" style="margin-top: 3px; cursor: hand; display: none" onclick="closethispage()" /></td>
                        </tr>
                    </table>

                </td>
                <td class="bg5">&nbsp;</td>
            </tr>

            <tr style="height: 5px;">
                <td>
                    <img src="../../view_infoimg/images/bg_09.png" /></td>
                <td class="bg2"></td>
                <td>
                    <img src="../../view_infoimg/images/bg_11.png" /></td>
            </tr>
        </table>
    </form>
</body>

</html>
<script>
    window.parent.closeprossdiv();
    LanguageSwitch(window.parent.parent);
    var image1 = window.document.getElementById("add_okPNG");
    var srouce1 = "../" + window.parent.parent.GetTextByName("Lang_edit_entity", window.parent.parent.useprameters.languagedata);
    image1.setAttribute("src", srouce1);


    var image1 = window.document.getElementById("cancelbutton");
    var srouce1 = "../" + window.parent.parent.GetTextByName("Lang-Cancel", window.parent.parent.useprameters.languagedata);
    image1.setAttribute("src", srouce1);
    window.document.title = window.parent.parent.GetTextByName("Lang_recieve_number", window.parent.parent.useprameters.languagedata);

    var btnSearch = window.document.getElementById("btnSearch");
    var srouce12 = "../" + window.parent.parent.GetTextByName("Lang_Search", window.parent.parent.useprameters.languagedata);
    btnSearch.setAttribute("src", srouce12);

    
    window.document.getElementById("span_selectcount").innerHTML = window.parent.parent.GetTextByName("Lang_Youselected", window.parent.parent.useprameters.languagedata);
    window.document.getElementById("btnShowALLCheck").innerHTML = window.parent.parent.GetTextByName("Lang_ShowALLCheck", window.parent.parent.useprameters.languagedata);
</script>
