<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="OpenDiv.aspx.cs" Inherits="Web.MyCommonJS.Source.OpenDiv.OpenDiv" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>无标题页</title>
    <script src="../../shorteningEvent.js" type="text/javascript"></script>
    <script type="text/javascript">
        function Button1_onclick() {
            newDivFrame("isfd", "body", "TheOpenWindow.aspx", "XXOO");
            document.getElementById("isfd").style.width = "300px";
            document.getElementById("isfd").style.height = "400px";
            ShowDivPage("isfd");
            //ShowDivPage("id")
        }
    </script>
    <style type="text/css">
        div
        {
            margin: 0px;
            padding: 0px;
        }
    </style>
</head>
<body id="body">
    <%--可修改的参数
div 的id 长宽
头部背景
ifame的id--%>
    <form id="form1" runat="server">
    <input id="Button1" type="button" value="button" onclick="Button1_onclick();" />
    <div id='id' style="position: absolute; cursor: move; border: solid 1px #999999;
        display: none; overflow: hidden;" onmousedown="mystartDragWindow(this)" onmouseup="mystopDragWindow(this)"
        onmousemove="mydragWindow(this)" runat="server">
        <div width: 100%; background-image: url(Images/bgbj.gif);>
            <div style="width: 100%; background-image: url(../../../Images/bgbj.gif); text-align: center;
                float: left;">
                <span style="font-size: 14px;">性能渲染</span></div>
            <div style="right: 2px; position: absolute;">
                <img id="img" src="infowindow_close.gif" onclick="$('id').style.display='none'" style="cursor: default;
                    : 2px;" runat="server" />
            </div>
        </div>
        <iframe id="ifr" scrolling="no" style="width: 100%; height: 100%" src='TheOpenWindow.aspx'>
        </iframe>
        <%--这里iframe高度等于div_id_height - div_img--%>
    </div>
    </form>
</body>
</html>
