﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CIInfoGet.aspx.cs" Inherits="Web.OpePages.CIInfoGet" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script type="text/javascript">
        window.onload = function () {
            window.document.body.onselectstart = function () {
                return false;
            }
        }

    </script>
</head>
<body style='background: #eff3fb'>
    <form id="form1" runat="server">
    <asp:Label ID="lblCIInfo" runat="server"></asp:Label>
    </form>
</body>

</html>
