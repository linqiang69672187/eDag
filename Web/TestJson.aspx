<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TestJson.aspx.cs" Inherits="Web.TestJson" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <script type="text/javascript" src="/lqnew/js/pdtcode.js">
    </script>
    <script type="text/javascript">
        //var bzBHC = group_id_to_marks_bz("16515084");
        //alert(bzBHC);
        //var bzID = group_marks_to_id_bz(bzBHC);
        //alert(bzID);
        //"80020911";
        var zjID = gourpidTopdt_zj("9018202");
        alert(zjID);
        var zjBHC = grouppdtToId_zj(zjID);
        alert(zjBHC);
        //"57190001"
    </script>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
        </div>
    </form>
</body>
</html>
