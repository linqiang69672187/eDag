<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="oper_log.aspx.cs" Inherits="Web.lqnew.logwindow.oper_log" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style>
    body{background-color:transparent;font-size:12px;margin:0px;scrollbar-face-color:#DEDEDE;
 scrollbar-base-color:#F5F5F5;
 scrollbar-arrow-color:black;
 scrollbar-track-color:#F5F5F5;
 scrollbar-shadow-color:#EBF5FF;
 scrollbar-highlight-color:#F5F5F5;
 scrollbar-3dlight-color:#C3C3C3;
 scrollbar-darkshadow-Color:#9D9D9D; }
 table{font-size:12px;}
 span{cursor:hand;text-decoration:underline;color:Blue;}
  li {
            line-height:22px;background-image:url(backgline.gif);background-position-y:bottom;background-repeat:repeat-x;
        }
    </style>

</head>

<body>
    <script >
        var CallMsg = new Array();
        function GetCallMsg() {
            return CallMsg;
        }
</script>
    <form id="form1" runat="server">
    <div  id="scrolldiv1" style="overflow:auto;height:103px;width:295px">
        <table id="log">

        </table>
    </div>
    </form>
</body>
</html>
