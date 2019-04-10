<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="select_color.aspx.cs" Inherits="Web.lqnew.opePages.select_color" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<script src="../../JQuery/jquery-1.5.2.js" type="text/javascript"></script>
<script src="../iColorPicker.js" type="text/javascript"></script>
    <title></title>
    <style type="text/css">
        .style1{
            width: 76px;
            height: 23px;
            margin-top:20px;
        }
        body{margin:0;}
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
 <input class="iColorPicker" onclick="iColorShow('color1','icp_color1')" href="javascript:void(null)" id="color1" style="background-color: #fff467;" type="text" value="#fff467"/><img class="style1" src="../images/add_ok.png" onclick="selectcolor()" /></div>
    </form>
</body>
</html>
<script>
    function selectcolor() {
        var color = $("#color1").text;


    }
</script>
