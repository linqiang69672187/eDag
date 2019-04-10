<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Error.aspx.cs" Inherits="Web.Error" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script type="text/javascript">
        function funtext() {
            document.getElementsByName("usertypepic").length;
            for (var i = 0; i < document.getElementsByName("usertypepic").length; i++) {
                if (document.getElementsByName("usertypepic")[i].checked) {
                    alert(document.getElementsByName("usertypepic")[i].value);
                    return;
                }
            }
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
  
    <input type="button" value="获取选中图标组" onclick="funtext()" />
    </div>
    </form>
</body>
</html>

