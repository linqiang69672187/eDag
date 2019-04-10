<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="add_Member.aspx.cs" Inherits="Web.lqnew.opePages.AddGroupCallMember.add_Member" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title><%--接收号码--%></title>
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
    <script src="../../../JQuery/jquery-1.5.2.js" type="text/javascript"></script>
    <script src="../../../JQuery/jquery-ui-autocomplete.js" type="text/javascript"></script>
    <link href="../../../CSS/jquery-ui-1.8.14.custom.css" rel="stylesheet" type="text/css" />
    <script language="javascript">
        function Divover(str) {
            var div1 = document.getElementById("divClose");
            if (str == "on") { div1.style.backgroundPosition = "66 0"; }
            else { div1.style.backgroundPosition = "0 0"; }
        }
        function insertr(data, action) {
            for (data_i = 0; data_i < data.length; data_i++) {
                var entity = data[data_i]["entity"];
                var ISSI = data[data_i]["ISSI"];
                if (ISSI == "") {
                    continue;
                }
                var name = data[data_i]["name"];
                var SQLType = data[data_i]["SQLType"];
                var type = data[data_i]["type"];
                var id = data[data_i]["id"];
                if (action == "add") {
                    createtr(entity, ISSI, name, SQLType, type, id);
                }
                else {
                    removetr(ISSI);
                }
            }
            window.document.getElementById("divClose").style.display = "inline";
            window.document.getElementById("add_okPNG").style.display = "inline";
            window.document.getElementById("cancelbutton").style.display = "inline";
        }
        function createtr(entity, issi, name, SQLType, type, id) {
            var tr = document.getElementById(issi);
            if (tr) {
                return;
            }
            $("#GridView1").prepend("<tr id=" + issi + " onmouseover='changeTgBg(this,&#39;font&#39;)' onmouseout='overchangeTgBg(this,&#39;font&#39;)' style='background-color:White;height:22px;'><td align='left'>&nbsp;" + entity + "</td><td align='center' style='white-space:nowrap;'>" + type + "</td><td align='center'  style='white-space:nowrap;cursor:hand;padding:4px;'>" + issi + "</td><td align='center'  style='white-space:nowrap;cursor:hand;padding:4px;'>" + name + "</td><td align='center' ><img src='../../images/010.gif' onmouseout=javascript:dragEnable='True' onmouseover=javascript:dragEnable='False' onclick=removetr('" + issi + "') style='cursor:hand;' /></td></tr>");
            //         $(window.frames["smstree"].frames["smsusetree"].document).find("#div" + issi).append("<img style='margin-left: 3px' id=img" + issi + " src='../../images/1311402216_yes.png' />");
            //         $(window.frames["smstree"].frames["smsISSItree"].document).find("#div" + issi).append("<img style='margin-left: 3px' id=img" + issi + " src='../../images/1311402216_yes.png' />");
            $(window.frames["smstree"].frames["smsgrouptree"].document).find("#div" + issi).append("<img style='margin-left: 3px' id=img" + issi + " src='../../images/1311402216_yes.png' />");
            //         $(window.frames["smstree"].frames["smsdispatchtree"].document).find("#div" + issi).append("<img style='margin-left: 3px' id=img" + issi + " src='../../images/1311402216_yes.png' />");

        }
        function removetr(id) {
            $("#" + id).remove();
            //         $(window.frames["smstree"].frames["smsusetree"].document).find("#img" + id).remove();
            //         $(window.frames["smstree"].frames["smsISSItree"].document).find("#img" + id).remove();
            $(window.frames["smstree"].frames["smsgrouptree"].document).find("#img" + id).remove();
            //$(window.frames["smstree"].frames["smsdispatchtree"].document).find("#img" + id).remove();
        }
        var availableTags;
        var param = { "id": 0 };
        window.parent.parent.parent.jquerygetNewData_ajax("../../../WebGis/Service/GetGSSIISSIbysokiet.aspx", param, function (request) {
            availableTags = request;
        }, false, false);

        $(document).ready(function () {
            $("#tags").autocomplete({
                source: availableTags
            });
        });

        function Insertissi() {
            //验证issi是否为数字
            var reg = "^[0-9]*[1-9][0-9]*$";
            var Lang_ISSI_nember_is_1to80699999 = window.parent.parent.GetTextByName("Lang_ISSI_nember_is_1to80699999", window.dialogArguments.useprameters.languagedata);
            var Lang_please_input_ISSI_number = window.parent.parent.GetTextByName("Lang_please_input_ISSI_number", window.dialogArguments.useprameters.languagedata);

            //alert(document.getElementById("tags").value.match(reg));
            if (document.getElementById("tags").value.match(reg) == null || document.getElementById("tags").value < 1 || document.getElementById("tags").value > 80699999) {
                alert(Lang_ISSI_nember_is_1to80699999);//("ISSI号码为1到80699999");
                return;
            }
            if (document.getElementById("tags").value == "") {
                alert(Lang_please_input_ISSI_number);//('请输入ISSI或GSSI');
                return;
            }
            var param = { "id": document.getElementById("tags").value };
            window.parent.parent.parent.jquerygetNewData_ajax("../../../WebGis/Service/getvaluebyISSIGSSI.aspx", param, function (request) {
                insertr(request, "add");
            }, false, false);
        }
        document.oncontextmenu = new Function("event.returnValue=false;"); //禁止右键功能,单击右键将无任何反应
        document.onselectstart = new Function("event.returnValue=false;"); //禁止先择,也就是无法复制

        Request = {
            QueryString: function (item) {
                var svalue = location.search.match(new RegExp("[\?\&]" + item + "=([^\&]*)(\&?)", "i"));
                return svalue ? svalue[1] : svalue;
            }
        }


        function sendok() {
            var tbl = document.getElementById('GridView1');
            var retrunissis = "";
            var OnlySelectOneRecord = window.parent.parent.GetTextByName("OnlySelectOneRecord", window.parent.parent.useprameters.languagedata);

            if (tbl.rows.length > 1) {
                alert(OnlySelectOneRecord);//("只能选择一条记录");
                return;
            } else {
                for (var i = 0; i < tbl.rows.length; i++) {
                    retrunissis = tbl.rows[i].cells[2].innerHTML;
                }
            }

            var ifr = Request.QueryString("ifr")
            var sendMsgwindo = window.parent.document.frames[ifr];

            if (sendMsgwindo) {
                sendMsgwindo.faterdo(retrunissis);
                window.parent.lq_closeANDremovediv('AddGroupCallMember/add_Member', 'bgDiv');
            }
        }
        var dragEnable = 'True';
        function dragdiv() {
            var div1 = window.parent.document.getElementById('AddGroupCallMember/add_Member');
            if (div1 && event.button == 0 && dragEnable == 'True') {
                window.parent.mystartDragWindow(div1, null, event); div1.style.border = "solid 3px transparent"; window.parent.cgzindex(div1);

            }
        }
        function mydragWindow() {
            var div1 = window.parent.document.getElementById('AddGroupCallMember/add_Member');
            if (div1) {
                window.parent.mydragWindow(div1, event);
            }
        }

        function mystopDragWindow() {
            var div1 = window.parent.document.getElementById('AddGroupCallMember/add_Member');
            if (div1) {
                window.parent.mystopDragWindow(div1); div1.style.border = "0px";
            }
        }

        window.onload = function () {
            window.parent.parent.document.getElementById("mybkdiv").style.zIndex = 2000;
            window.parent.parent.document.getElementById("mybkdiv").style.display = "block";
            document.body.onmousedown = function () { dragdiv(); }
            document.body.onmousemove = function () { mydragWindow(); }
            document.body.onmouseup = function () { mystopDragWindow(); }
            document.body.oncontextmenu = function () { return false; }
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
            var param = { "issi": Request.QueryString("issi") };
            window.parent.parent.parent.jquerygetNewData_ajax("../../../WebGis/Service/getvaluebyISSIGSSIs.aspx", param, function (request) {

                insertr(request, "add");
            }, false, false);
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
                    <div id="divClose" style="display: none" onmouseover="Divover('on')" onclick="window.parent.lq_closeANDremovediv('AddGroupCallMember/add_Member','bgDiv')" onmouseout="Divover('out')"></div>
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
                                                        <iframe name="smstree" src="mian_tree.aspx" width="190px" allowtransparency="true" style="padding-top: 0px" frameborder="0" height="425px" scrolling="no"></iframe>
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
                                <table id="Table1" align="center" bgcolor="#c0de98" runat="server" border="0" cellpadding="0" cellspacing="1" width="200px">
                                    <tr>
                                        <td align="left" class="td1td">
                                            <table width="400px" border="0" cellspacing="3">
                                                <tr>
                                                    <td align="left" valign="top" height="425px">
                                                        <table align="center" border="0" cellpadding="0" cellspacing="0" width="100%" style="font-size: 12px;">
                                                            <tr>
                                                                <td height="30">
                                                                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                                                        <tr>
                                                                            <td height="30" width="15">
                                                                                <img height="30" src="../images/tab_03.gif" width="15" /></td>
                                                                            <td background="../images/tab_05.gif" style="font-size: 12px;">&nbsp;</td>
                                                                            <td width="14">
                                                                                <img height="30" src="../images/tab_07.gif" width="14" /></td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                                                        <tr>
                                                                            <td background="../images/tab_12.gif" width="9">&nbsp;</td>
                                                                            <td bgcolor="#f3ffe3">
                                                                                <div class="divgrd" id="tbtbz">
                                                                                    <table cellspacing="1" cellpadding="0" style="background-color: #C0DE98; border-color: White; border-width: 0px; border-style: Ridge; width: 99%;">

                                                                                        <tr class="gridheadcss" style="font-weight: bold; font-size: 12px;">
                                                                                            <th scope="col" id="Unit"><%--单位--%></th>
                                                                                            <th scope="col" style="white-space: nowrap; width: 40px;" id="Type"><%--类型--%></th>
                                                                                            <th scope="col" style="white-space: nowrap; width: 60px;">ISSI/GSSI</th>
                                                                                            <th scope="col" style="white-space: nowrap; width: 60px;" id="Username"><%--姓名--%></th>
                                                                                            <th scope="col" width="20px">&nbsp;</th>
                                                                                        </tr>
                                                                                        <tbody id="GridView1">
                                                                                        </tbody>
                                                                                    </table>


                                                                                </div>
                                                                            </td>
                                                                            <td background="../images/tab_16.gif" width="9">&nbsp;</td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td height="15">
                                                                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                                                        <tr>
                                                                            <td height="29" width="15">
                                                                                <img height="29" src="../images/tab_20.gif" width="15" /></td>
                                                                            <td background="../images/tab_21.gif">&nbsp;</td>
                                                                            <td width="14">
                                                                                <img height="29" src="../images/tab_22.gif" width="14" /></td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" align="left" height="35px">
                                <img id="add_okPNG" style="margin-top: 3px; cursor: hand; display: none" src="<%--../../images/edit_entity.png--%>" onclick="sendok()" />&nbsp;
                     <img id="cancelbutton" style="margin-top: 3px; cursor: hand; display: none" src="<%--../../images/add_cancel.png--%>" onclick="window.parent.lq_closeANDremovediv('AddGroupCallMember/add_Member','bgDiv')" /></td>
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
    var image1 = window.document.getElementById("add_okPNG");
    var srouce1 = "../" + window.parent.parent.GetTextByName("Lang_edit_entity", window.parent.parent.useprameters.languagedata);
    image1.setAttribute("src", srouce1);
    var image1 = window.document.getElementById("cancelbutton");
    var srouce1 = "../" + window.parent.parent.GetTextByName("Lang-Cancel", window.parent.parent.useprameters.languagedata);
    image1.setAttribute("src", srouce1);
    window.document.title = window.parent.parent.GetTextByName("Lang_recieve_number", window.parent.parent.useprameters.languagedata);
    window.document.getElementById("Unit").innerHTML = window.parent.parent.GetTextByName("Unit", window.parent.parent.useprameters.languagedata);
    window.document.getElementById("Type").innerHTML = window.parent.parent.GetTextByName("Type", window.parent.parent.useprameters.languagedata);
    window.document.getElementById("Username").innerHTML = window.parent.parent.GetTextByName("Username", window.parent.parent.useprameters.languagedata);
    // document.title = window.parent.parent.GetTextByName("Lang_recieve_number", window.parent.parent.useprameters.languagedata);
</script>
