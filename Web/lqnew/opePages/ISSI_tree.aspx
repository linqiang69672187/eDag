<%@ Page Language="C#" AutoEventWireup="true" EnableViewState="false" CodeBehind="ISSI_tree.aspx.cs"
    Inherits="Web.lqnew.opePages.ISSI_tree" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style>
        .tree td div
        {
            height: 20px !important;
        }

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
            scrollbar-darkshadow-color: #9D9D9D;
        }
    </style>
    <script src="../../JQuery/jquery-1.5.2.js" type="text/javascript"></script>
    <script src="../../JS/jquery-smartMenu3.js" type="text/javascript"></script>
    <script src="../js/GlobalConst.js" type="text/javascript"></script>
    <script src="../js/MouseMenu.js" type="text/javascript"></script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:TreeView ID="TreeView1" EnableViewState="false"  runat="server" ShowLines="True" CssClass="tree" ExpandDepth="1"
                NodeStyle-Width="100%" PopulateNodesFromClient="False" LineImagesFolder="~/TreeLineImages"
                Font-Size="12px" ForeColor="Black" NodeIndent="5" CollapseImageToolTip="" ExpandImageToolTip="">
            </asp:TreeView>
        </div>
    </form>
</body>
</html>
<script type="text/javascript">
    function backcolor(obj) {
        obj.style.backgroundColor = "transparent";
        obj.style.color = "#000000";
    }
    function changebgcolor(obj) {
        obj.style.backgroundColor = "#0d9e1b";
        obj.style.color = "#ffffff";
    }

    //鼠标点击事件
    window.onload = function () {
        MouseMenu(window.parent.parent.parent,"a", "policemouseMenu");
    }
    function setrightvalue(id) {
        window.parent.parent.parent.useprameters.rightselectid = id;
        rightselecttype = 'cell';
    }
   
</script>
