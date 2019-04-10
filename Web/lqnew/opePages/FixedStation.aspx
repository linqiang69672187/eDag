<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FixedStation.aspx.cs" Inherits="Web.lqnew.opePages.FixedStation" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link href="../css/lq_manager.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/pagestyle.css" rel="stylesheet" type="text/css" />
    <script src="../js/geturl.js" type="text/javascript"></script>
    <script src="../js/dragwindow.js" type="text/javascript"></script>
    <script src="../../JQuery/jquery-1.5.2.js" type="text/javascript"></script>
    <script src="../js/manageStopSelectSubmit.js" type="text/javascript"></script>
    <script src="../../LangJS/managerGroup_langjs.js"></script>
    <style type="text/css">
        .auto-style1
        {
            width: 842px;
        }
    </style>
    <script type="text/javascript">
        function myDW(lo, la) {
            window.parent.DingWei(lo, la, 'FixedStation');
            window.parent.mycallfunction('FixedStation', 693, 354);
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
                <tr>
                    <td height="30">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td width="15" height="32">
                                    <img alt="" src="../images/tab_03.png" width="15" height="32" />
                                </td>
                                <td width="1101" background="../images/tab_05.gif">
                                    <ul class="hor_ul" id="userul" runat="server">
                                        <li>
                                            <img alt="" src="../images/311.gif" width="16" height="16" /><span  class="Langtxt"   id="GDTXXWH" ></span></li>
                                        <li>
                                            <asp:DropDownList ID="DropDownList1" runat="server" AppendDataBoundItems="True" DataSourceID="ObjectDataSource2"
                                                DataTextField="Name" DataValueField="id">
                                                <asp:ListItem Value="0"></asp:ListItem>
                                            </asp:DropDownList>
                                            <asp:ObjectDataSource ID="ObjectDataSource2" runat="server" SelectMethod="GetAllFixedStation"
                                                TypeName="DbComponent.FS_Info.FixedStation">
                                            </asp:ObjectDataSource>
                                        </li>
                                        <li><span  class="Langtxt"   id="Identification" ></span>：<asp:TextBox ID="TextBox1" runat="server" Width="67px"></asp:TextBox></li>
                                        <li>
                                            <asp:ImageButton ID="ImageButton1" runat="server" onmouseover="javascript:this.src='../images/btn_search_un.png';"
                                                onmouseout="javascript:this.src='../images/btn_search.png';" ImageUrl="../images/btn_search.png" OnClick="ImageButton1_Click" /></li>
                                        <li>
                                            <img alt="" class="style6" style="cursor: pointer;" onclick="window.parent.mycallfunction('add_FixedStation',484, 702)"
                                                onmouseover="javascript:this.src='../images/../images/btn_add_un.png';" onmouseout="javascript:this.src='../images/btn_add.png';"
                                                src="../images/btn_add.png" /></li>
                                    </ul>
                                </td>
                                <td width="281" background="../images/tab_05.gif" align="right">
                                    <img alt="" style="cursor: pointer;" onclick="window.parent.mycallfunction('FixedStation',693, 354)"
                                        onmouseover="javascript:this.src='../images/close_un.png';" onmouseout="javascript:this.src='../images/close.png';"
                                        src="../images/close.png" />
                                </td>
                                <td width="14">
                                    <img alt="" src="../images/tab_07.png" width="14" height="32" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td width="15" background="../images/tab_12.gif">&nbsp;
                                </td>
                                <td align="center" id="dragtd" class="auto-style1">
                                    <asp:GridView ID="GridView1" runat="server" Width="99%" AutoGenerateColumns="False"
                                        DataSourceID="ObjectDataSource1" BorderWidth="0px" CellSpacing="1" BackColor="#C0DE98"
                                        BorderColor="White" BorderStyle="Ridge" AllowPaging="True" AllowSorting="True"
                                        CellPadding="0" GridLines="None" OnRowDataBound="GridView1_RowDataBound" OnRowCommand="GridView1_RowCommand"
                                         DataKeyNames="id,Name,StationISSI">
                                        <Columns>
                                            <asp:TemplateField  SortExpression="StationISSI">
                                                <ItemTemplate>
                                                    <font onclick="window.parent.mycallfunction('view_info/view_FixedStation',418, 342,'<%#Eval("id") %>')"
                                                        style="cursor: pointer; width: 60px">&nbsp;&nbsp;<%# Eval("StationISSI") %></font>
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Left" Width="120px" />
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="Name" >
                                                <ItemStyle HorizontalAlign="Left" Width="150px" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="GSSIS"  SortExpression="GSSIS">
                                                <ItemStyle HorizontalAlign="Left" Width="150px" />
                                            </asp:BoundField>
                                            <asp:TemplateField>
                                            <ItemTemplate>
                                                <font onclick="myDW('<%#Eval("Lo") %>', '<%#Eval("La") %>')" style="cursor: pointer;"><span  class="Lang"   langid="Lang_Location" ></span></font></ItemTemplate>
                                            <ItemStyle HorizontalAlign="Center" Width="50px" />
                                        </asp:TemplateField>
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <font onclick="window.parent.mycallfunction('edit_FixedStation',484, 702,'<%#Eval("id") %>')"
                                                        style="cursor: pointer;">
                                                        <img alt="" src="../images/114.gif" /><span  class="Langtxt"   id="Modify" ></span></font>
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Center" Width="100px" />
                                            </asp:TemplateField>
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="ImageButton2" CommandName="MyDel" CommandArgument='<%# Eval("id") %>'
                                                        runat="server"><img alt="" src="images/083.gif" /><font color="black"><span  class="Langtxt"   id="Delete" ></span></font></asp:LinkButton>
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Center" Width="100px" />
                                            </asp:TemplateField>
                                        </Columns>
                                        <FooterStyle BackColor="#C6C3C6" ForeColor="Black" />
                                        <HeaderStyle CssClass="gridheadcss" Font-Bold="True" />
                                        <PagerStyle CssClass="PagerStyle" />
                                        <RowStyle BackColor="#FFFFFF" Height="22px" ForeColor="Black" />
                                        <SelectedRowStyle BackColor="#9471DE" Font-Bold="True" ForeColor="White" />
                                    </asp:GridView>
                                </td>
                                <td width="14" background="../images/tab_16.gif"></td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td height="15">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td width="15" height="15">
                                    <img alt="" src="../images/tab_20.png" width="15" height="15" />
                                </td>
                                <td background="../images/tab_21.gif">
                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td width="25%" nowrap="nowrap">&nbsp;
                                            </td>
                                            <td width="75%" valign="top" class="STYLE1">
                                                <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="True" SortParameterName="sort"
                                                    SelectCountMethod="getAllFixedStationCount" SelectMethod="GetAllFixedStation" TypeName="DbComponent.FS_Info.FixedStation">
                                                    <SelectParameters>
                                                        <asp:ControlParameter ControlID="DropDownList1" Name="selectcondition" PropertyName="SelectedValue" />
                                                        <asp:ControlParameter ControlID="TextBox1" Name="textseach" PropertyName="Text" />
                                                        <asp:CookieParameter CookieName="id" Name="id" Type="Int32" />
                                                    </SelectParameters>
                                                </asp:ObjectDataSource>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td width="14">
                                    <img alt="" src="../images/tab_22.png" width="14" height="15" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
<script>    window.parent.closeprossdiv();</script>
