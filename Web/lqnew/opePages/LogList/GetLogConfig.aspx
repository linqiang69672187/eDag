<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GetLogConfig.aspx.cs" Inherits="Web.GetLogConfig" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <script src="../../../JQuery/jquery-1.5.2.js"></script>
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

        #GridView1, #GridView12
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
    <script src="../../../JS/LangueSwitch.js"></script>
    <script type="text/javascript">
        var Lang_SZCG = window.parent.GetTextByName("Lang_setoptionsucess", window.parent.useprameters.languagedata);
        var Lang_SZSB = window.parent.GetTextByName("Operationfails", window.parent.useprameters.languagedata);
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


        function closethispage() {
            if (Request.QueryString("selfclose") != undefined) {
                window.parent.hiddenbg2();
            }
            window.parent.lq_closeANDremovediv('LogList/GetLogConfig', 'bgDiv');
        }


        var dragEnable = 'True';
        function dragdiv() {
            var div1 = window.parent.document.getElementById('LogList/GetLogConfig');
            if (div1 && event.button == 0 && dragEnable == 'True') {
                window.parent.mystartDragWindow(div1, null, event); div1.style.border = "solid 0px transparent"; window.parent.cgzindex(div1);

            }
        }
        function mydragWindow() {
            var div1 = window.parent.document.getElementById('LogList/GetLogConfig');
            if (div1) {
                window.parent.mydragWindow(div1, event);
            }
        }

        function mystopDragWindow() {
            var div1 = window.parent.document.getElementById('LogList/GetLogConfig');
            if (div1) {
                window.parent.mystopDragWindow(div1); div1.style.border = "0px";
            }
        }
        window.onload = function () {
            
             document.onmousedown = function () {
                 var div1 = window.parent.document.getElementById('LogList/GetLogConfig');
                 window.parent.windowDivOnClick(div1);
             }
             document.getElementById("derppp").onmousedown = function () { dragdiv(); }
             document.getElementById("derppp").onmousemove = function () { mydragWindow(); }
             document.getElementById("derppp").onmouseup = function () { mystopDragWindow(); }
             document.body.oncontextmenu = function () { return false; }
             document.body.oncontextmenu = function () { return false; }
             var arrayelement = ["input", "a", "select", "li", "font", "textarea", "option"];
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

         }

        ///全选
        function selectAll() {
            var checklist = document.getElementsByTagName("input");
            for (var i = 0; i < checklist.length; i++) {
                if (checklist[i].type == "checkbox") {
                    checklist[i].checked = true;
                }
            }
        }
        
        ///全选该节点下所有子节点
        function selectChildAll(obj) {
            var checklist = document.getElementsByTagName("input");
            for (var i = 0; i < checklist.length; i++) {
                if (checklist[i].type == "checkbox") {

                    if (checklist[i].id.indexOf(obj.id.substr(10, obj.id.length - 10)) >= 0) {
                        checklist[i].checked = true;
                    }
                    if (obj.id.substr(10, obj.id.length - 10).indexOf(checklist[i].id) >= 0) {
                        checklist[i].checked = true;
                    }

                }
            }
        }
        
        ///取消该节点下所有子节点
        function cancelChildAll(obj) {
            var checklist = document.getElementsByTagName("input");
            for (var i = 0; i < checklist.length; i++) {
                if (checklist[i].type == "checkbox") {

                    if (checklist[i].id.indexOf(obj.id.substr(10, obj.id.length - 10)) >= 0) {
                        checklist[i].checked = false;
                    }

                }
            }
        }

        //设置节点是否选中
        function cb_Click(obj) {

            if (!obj.checked) {
                var checklist = document.getElementsByTagName("input");
                for (var i = 0; i < checklist.length; i++) {
                    if (checklist[i].type == "checkbox") {

                        if (checklist[i].id.indexOf(obj.id) >= 0) {
                            checklist[i].checked = obj.checked;
                            //alert(objid + "   " + checklist[i].id);
                        }

                    }
                }
            } else {

                var checklist = document.getElementsByTagName("input");
                for (var i = 0; i < checklist.length; i++) {
                    if (checklist[i].type == "checkbox") {

                        if (obj.id.indexOf(checklist[i].id) >= 0) {
                            checklist[i].checked = obj.checked;
                            //alert(objid + "   " + checklist[i].id);
                        }

                    }
                }
            }

        }

        ///保存所选节点，传入Array数组，Ajax传值至SaveLogConfig页面保存
        function sava() {
            var array = new Array();
            var result = "";

            var checklist = document.getElementsByTagName("input");
            for (var i = 0; i < checklist.length; i++) {
                if (checklist[i].type == "checkbox" && checklist[i].checked) {

                    var list = checklist[i].id.split('_');
                    for (var p in list) {
                        if (!findFromArray(list[p], array)) {
                            array.push(list[p]);
                            result += list[p] + ";";
                        }
                    }
                }
            }
            $.ajax({
                type: "POST",
                url: "SavaLogConfig.aspx",
                data: { result: result },
                success: function (msg) {
                    if (msg == "1") {
                        alert(Lang_SZCG);
                    } else {
                        alert(Lang_SZSB);
                    }
                    location.reload();
                }
            });

        }

        function findFromArray(value, array) {
            var flag = false;
            for (var i in array) {
                if (array[i] == value) {
                    flag = true;
                }
            }
            return flag;
        }
    </script>
</head>
<body>
  
      <form id="form2" runat="server">

        <table class="style1" style="width:450px" cellpadding="0" cellspacing="0">
            <tr style="height: 25px;" id="derppp">
                <td background="../../images/tab_03.png">
                   </td>
                 <td background="../../images/tab_05.gif">
                    <div id="divClose" style="display:block" onmouseover="Divover('on')" onclick="closethispage()" onmouseout="Divover('out')"></div>
                </td>
                <td background="../../images/tab_07.png"></td>
            </tr>
            <tr>
                <td width="15" background="../../images/tab_12.gif">&nbsp;
                                </td>
                <td class="bg4" id="dragtd">
                    <div style="height:600px;overflow:auto">
                    <asp:Label id="lbContent" runat="server"></asp:Label>
                    </div>
                    <table style="width:100%">
                        <tr>
                            <td style="text-align:center">
                                   <input type="button" id="btn_save" value="保存" onclick="sava()" />
                            </td>
                        </tr>
                    </table>
                    

                </td>
                 <td width="14" background="../../images/tab_16.gif">&nbsp;
                                </td>
            </tr>

            <tr style="height: 15px;">
                <td>
                    <img src="../../images/tab_20.png" width="15" height="15" /></td>
                <td background="../../images/tab_21.gif">
                                  
                                </td>
                <td>
                      <img src="../../images/tab_22.png" width="14" height="15" /></td>
            </tr>
        </table>
    </form>
</body>
</html>
<script>
    window.parent.closeprossdiv(); 
    document.getElementById("btn_save").value = window.parent.GetTextByName("Lang_Submit", window.parent.useprameters.languagedata);
</script>
