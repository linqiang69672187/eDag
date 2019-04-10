<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Unittree.aspx.cs" Inherits="Web.lqnew.opePages.LogView.Unittree" %>


<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style>
        body
        {
            background-color:none;
            margin: 0px;
            scrollbar-face-color: #DEDEDE;
            scrollbar-base-color: #F5F5F5;
            scrollbar-arrow-color: black;
            scrollbar-track-color: #F5F5F5;
            scrollbar-shadow-color: #EBF5FF;
            scrollbar-highlight-color: #F5F5F5;
            scrollbar-3dlight-color: #C3C3C3;
            scrollbar-darkshadow-Color: #9D9D9D;
        }

         .bg1 {
            background-image: url('../../view_infoimg/images/bg_02.png');
            background-repeat: repeat-x;
            vertical-align: top;
        }

        .bg2 {
            background-image: url('../../view_infoimg/images/bg_10.png');
            background-repeat: repeat-x;
        }

        .bg3 {
            background-image: url('../../view_infoimg/images/bg_05.png');
            background-repeat: repeat-y;
        }

        .bg4 {
            background-image: url('../../view_infoimg/images/bg_06.png');
        }

        .bg5 {
            background-image: url('../../view_infoimg/images/bg_07.png');
            background-repeat: repeat-y;
        }

        .bg11 {
            background-image: url('../../view_infoimg/images/bg_01.png');
            background-repeat: repeat-x;
        }

        .bg12 {
            background-image: url('../../view_infoimg/images/bg_04.png');
        }

        .bg21 {
            background-image: url('../../view_infoimg/images/bg_09.png');
            background-repeat:repeat-y;
        }

        .bg22 {
            background-image: url('../../view_infoimg/images/bg_11.png');
        }

        #divClose {
            width: 33px;
            height: 16px;
            position: relative;
            border: 0px;
            float: right;
            margin-top: 1px;
            background-image: url('../../view_infoimg/images/minidict_03.png');
            cursor: hand;
        }

         .style3 {
            width: 37px;
        }

        .auto-style1 {
            background-image: url('../../view_infoimg/images/bg_04.png');
            width: 10px;
        }

        .auto-style2 {
            background-image: url('../../view_infoimg/images/bg_07.png');
            background-repeat: repeat-y;
            width: 10px;
        }

        .auto-style3 {
            background-image: url('../../view_infoimg/images/bg_11.png');
            width: 10px;
        }
       
        .auto-style5 {
            background-image: url('../../view_infoimg/images/bg_05.png');
            background-repeat: repeat-y;
            width: 10px;
        }
        .auto-style6 {
            background-image: url('../../view_infoimg/images/bg_09.png');
            background-repeat: repeat-y;
            width: 10px;
        }
        .auto-style7 {
            width: 10px;
        }
       
    </style>

</head>
<body>
    <form id="form1" runat="server">
         <table cellpadding="0" cellspacing="0" frame="void" style="border-collapse: collapse; height: 229px; width: 232px;">
            <tr style="height: 5px;" id="derppp">
                <td class="auto-style7">
                    <img src="../../view_infoimg/images/bg_01.png" /></td>
                <td class="bg1">
                    <div id="divClose" onmouseover="Divover('on')" onclick="closethispage()" onmouseout="Divover('out')"></div>
                </td>
                <td class="auto-style1"></td>
            </tr>
            <tr>
                <td class="auto-style5"></td>
                <td>
                    <div style="overflow:auto;width:200px;height:190px">
                    <asp:TreeView ID="TreeView1" EnableViewState="false" runat="server" ShowLines="True" CssClass="tree"
                        ExpandDepth="1" NodeStyle-Width="100%" PopulateNodesFromClient="False" LineImagesFolder="~/TreeLineImages"
                        Font-Size="12px" ForeColor="Black" NodeIndent="5" CollapseImageToolTip="" ExpandImageToolTip="">
                    </asp:TreeView>
                    </div>
                </td>
                <td class="auto-style2"></td>
            </tr>
            <tr style="height: 5px;">
                <td class="auto-style6"></td>
                <td class="bg2"></td>
                <td class="auto-style3"></td>
            </tr>
        </table>
    </form>
</body>
<script type="text/javascript">
    window.parent.closeprossdiv();
    //window.parent.document.getElementById("mybkdiv").style.display = "block";

    Request = {
        QueryString: function (item) {
            var svalue = location.search.match(new RegExp("[\?\&]" + item + "=([^\&]*)(\&?)", "i"));
            return svalue ? svalue[1] : svalue;
        }
    }
    document.oncontextmenu = new Function("event.returnValue=false;"); //禁止右键功能,单击右键将无任何反应
    document.onselectstart = new Function("event.returnValue=false;"); //禁止先择,也就是无法复制
    var myid = '';

    function nodeClick(obj,eid,utid,entityName,typeName) {
        obj.style.color = "red";
        if (document.getElementById(myid) && obj.id != myid) {
            document.getElementById(myid).style.color = "black";
        }
        myid = obj.id;

        var ifr = Request.QueryString("ifr")
        var callback = window.parent.document.frames[ifr];
      
        if (callback) {
            ///调用父窗体SelectData方法
            callback.selectData(eid, entityName);
        }
       
        closethispage();
    }

    function closethispage() {
        if (Request.QueryString("selfclose") != undefined) {
            window.parent.hiddenbg2();
        }
        window.parent.lq_closeANDremovediv('LogView/Unittree', 'bgDiv');
    }

    //分页代码--结束
    //窗体拖动
    function Divover(str) {
        var div1 = document.getElementById("divClose");
        if (str == "on") { div1.style.backgroundPosition = "66 0"; }
        else { div1.style.backgroundPosition = "0 0"; }
    }

    var dragEnable = 'True';
    function dragdiv() {
        var div1 = window.parent.document.getElementById('LogView/Unittree');
        if (div1 && event.button == 0 && dragEnable == 'True') {
            window.parent.mystartDragWindow(div1, null, event); div1.style.border = "solid 0px transparent"; window.parent.cgzindex(div1);
        }
    }

    function mydragWindow() {
        var div1 = window.parent.document.getElementById('LogView/Unittree');
        if (div1) {
            window.parent.mydragWindow(div1, event);
        }
    }

    function mystopDragWindow() {
        var div1 = window.parent.document.getElementById('LogView/Unittree');
        if (div1) {
            window.parent.mystopDragWindow(div1); div1.style.border = "0px";
        }
    }

    document.getElementById("derppp").onmousedown = function () { dragdiv(); }
    document.getElementById("derppp").onmousemove = function () { mydragWindow(); }
    document.getElementById("derppp").onmouseup = function () { mystopDragWindow(); }

   
</script>
</html>
