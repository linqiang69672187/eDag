<%@ Page Language="C#" AutoEventWireup="true" EnableViewState="false" CodeBehind="group_tree.aspx.cs" Inherits="Web.lqnew.opePages.group_tree" %>


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
            scrollbar-darkshadow-Color: #9D9D9D;
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
            <asp:TreeView ID="TreeView1" runat="server" ShowLines="True" CssClass="tree"
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
        MouseMenu(window.parent.parent.parent, "a", "groupmouseMenu");
        try{
            window.parent.hideGrouptreeProcessImg()
        }
        catch(e){}
    }
    function setrightvalue(id, type) {
        //rightGSSI = id;
        window.parent.parent.parent.useprameters.rightselectid = id;
        rightselecttype = 'group';
        righttype = type;
    }
    //声音
    var openVoice = window.parent.parent.parent.GetTextByName("Lang_openVoice", window.parent.parent.parent.useprameters.languagedata);
    var mute = window.parent.parent.parent.GetTextByName("Lang_mute", window.parent.parent.parent.useprameters.languagedata);
    function setRightclickMenu(GSSI) {
        var Lang_volumeControl = window.parent.parent.parent.document.getElementById("Lang_volumeControl");
        if (IsMutebydispatcher(GSSI)) {
            Lang_volumeControl.innerHTML = openVoice;
        }
        else {
            Lang_volumeControl.innerHTML = mute;
        }
    }
    function IsMutebydispatcher(GSSI) {
        var ismute = false;
        for (var i = 0; i < window.parent.parent.parent.useprameters.muteGroupList.length; i++) {
            if (GSSI == window.parent.parent.parent.useprameters.muteGroupList[i]) {
                ismute = true;
                break;
            }
        }
        return ismute;
    }
</script>
</html>
