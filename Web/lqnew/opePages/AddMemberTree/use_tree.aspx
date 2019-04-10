<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="use_tree.aspx.cs" Inherits="Web.lqnew.opePages.AddMemberTree.use_tree" %>


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
<script type="text/javascript">
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

        window.parent.parent.selectData(eid, utid, Request.QueryString("type"), entityName, typeName);
    }
</script>
</html>
