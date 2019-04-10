<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TheOpenWindow.aspx.cs"
    Inherits="Web.MyCommonJS.Source.OpenDiv.TheOpenWindow" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>无标题页</title>
    <script language="javascript" type="text/javascript">
        // <!CDATA[

        function Button1_onclick() {
            alert('gettheparm=' + window.location.search.substr(1));
        }

        // ]]>
    </script>
</head>
<body style="">
    <form id="form1" runat="server">
    <div>
        <input id="Button1" type="button" value="TheOpenWindow" onclick="return Button1_onclick()" />
        <br />
        <br />
        asfdasffffffffffffffffffffffffffffffffffffffwer42415qawearqr3r5qrfasfafasfdasfasfasfasfasf2412412313213
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        sadsasaf<br />
        asdf<br />
        as<br />
        fsaf<br />
        asdf<br />
        saf<br />
        <br />
        <asp:AdRotator ID="AdRotator1" runat="server" />
        <asp:CheckBoxList ID="CheckBoxList1" runat="server">
        </asp:CheckBoxList>
        <asp:ListBox ID="ListBox1" runat="server"></asp:ListBox>
    </div>
    </form>
</body>
</html>
