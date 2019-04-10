<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ISSI_tree.aspx.cs" Inherits="Web.lqnew.opePages.AddPPCCallMember.ISSI_tree" %>


<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style>
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
            scrollbar-darkshadow-Color: #9D9D9D;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div style="width: 250px">
            <asp:TreeView ID="TreeView1" EnableViewState="false" runat="server" ShowLines="True" CssClass="tree"
                ExpandDepth="1"
                NodeStyle-Width="100%"
                PopulateNodesFromClient="False" LineImagesFolder="~/TreeLineImages"
                Font-Size="12px" ForeColor="Black" NodeIndent="5" CollapseImageToolTip=""
                ExpandImageToolTip="">
            </asp:TreeView>
        </div>
    </form>
</body>
</html>
<script type="text/javascript">
    function backcolor(obj) {
        if (!obj.contains(event.toElement)) {
            var img = document.getElementById("imgaddmeb");
            if (img) {
                obj.removeChild(img);
            }
            img = null;
            var img = document.getElementById("imgremmeb");
            if (img) {
                obj.removeChild(img);
            }
            img = null;
        }
    }
    function changebgcolor(obj, id, type, treedepth) {
        if (!obj.contains(event.fromElement)) {
            var div = document.getElementById("imgaddmeb") || document.createElement("img");
            div.style.marginLeft = "3px";
            div.style.cursor = "hand";
            div.id = "imgaddmeb";
            div.onclick = function () {
                SelectMember(id, type, treedepth, "add");
            };
            div.src = '../images/addmember.gif';
            obj.appendChild(div);

            var div = document.getElementById("imgremmeb") || document.createElement("img");
            div.id = "imgremmeb";
            div.style.cursor = "hand";
            div.style.marginLeft = "5px";
            div.style.marginBottom = "4px";
            div.onclick = function () {
                SelectMember(id, type, treedepth, "del");
            };
            div.src = '../images/removemember.gif';
            obj.appendChild(div);
        }

    }
    function SelectMember(id, type, treedepth, action) {
        var Lang_Terminal = window.parent.parent.parent.GetTextByName("Lang_Terminal", window.parent.parent.parent.useprameters.languagedata);
        var param = { "id": id, "type": encodeURIComponent(type), "treedepth": treedepth, "url": encodeURIComponent(Lang_Terminal) };//终端
        window.parent.parent.parent.jquerygetNewData_ajax("../../../WebGis/Service/SelectMember.aspx", param, function (request) {
            window.parent.parent.insertr(request, action);
            request = null;
        }, false, false);
    }
    document.oncontextmenu = new Function("event.returnValue=false;"); //禁止右键功能,单击右键将无任何反应
    document.onselectstart = new Function("event.returnValue=false;"); //禁止先择,也就是无法复制
    window.onload = function () {

    }
</script>
