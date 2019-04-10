<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LayerCellSearch.aspx.cs"
    Theme="Theme0129" Inherits="Web.LayerCellSearch" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <base target="_self">
    <style type="text/css">
        .clear
        {
            margin: 0;
        }
        .noBord
        {
            border-width: 0px;
        }
    </style>
    <script type="text/javascript">
        window.onload = function () {
            //            document.getElementById("txtNum").focus();
        }
    </script>
</head>
<body class="clear">
    <form id="form1" runat="server">
    <div style="float: left;">
        单位：<asp:DropDownList ID="ddlCompany" runat="server">
        </asp:DropDownList>
    </div>
    <div style="float: left; margin-left: 10px;">
        姓名：<asp:TextBox ID="txtName" Width="80" runat="server"></asp:TextBox>
    </div>
    <div style="float: left; margin-left: 10px;">
        警号：<asp:TextBox ID="txtNum" Width="80" runat="server"></asp:TextBox></div>
    <div style="float: left; margin-left: 10px;">
        ISSI：<asp:TextBox ID="txtISSI" Width="80" runat="server"></asp:TextBox></div>
    <asp:Button ID="Button1" runat="server" CssClass="btn1" OnClick="Button1_Click" Text="开始查询" />
    <br>
    <asp:GridView ID="GVSearch" runat="server" OnRowCommand="GridView1_RowCommand" AutoGenerateColumns="false">
        <RowStyle BackColor="#EFF3FB" />
        <Columns>
            <asp:TemplateField HeaderText="定位" ShowHeader="False">
                <ItemTemplate>
                    <asp:ImageButton ID="imgLocation" CausesValidation="False" CommandName="choose" ImageUrl="~/images/xz.gif"
                        CommandArgument='<%# "Police,0,0|"+ Eval("ID")+"|"+Eval("经度")+"|"+Eval("纬度") %>'
                        runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="姓名" HeaderText="姓名" ReadOnly="True" SortExpression="姓名" />
            <asp:BoundField DataField="警号" HeaderText="警号" ReadOnly="True" SortExpression="警号" />
            <asp:BoundField DataField="单位" HeaderText="单位" ReadOnly="True" SortExpression="单位" />
            <asp:BoundField DataField="ISSI" HeaderText="ISSI" ReadOnly="True" SortExpression="ISSI" />
            <asp:BoundField DataField="经度" HeaderText="经度" ReadOnly="True" SortExpression="经度" />
            <asp:BoundField DataField="纬度" HeaderText="纬度" ReadOnly="True" SortExpression="纬度" />
            <asp:BoundField DataField="加入结果" HeaderText="加入结果" ReadOnly="True" SortExpression="加入结果" />
        </Columns>
        <PagerStyle HorizontalAlign="Center" CssClass="noBord" />
    </asp:GridView>
    </form>
</body>
</html>
