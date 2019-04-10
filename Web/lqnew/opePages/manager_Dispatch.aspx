<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="manager_Dispatch.aspx.cs"
    Inherits="Web.lqnew.opePages.manager_Dispatch" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../css/lq_manager.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/pagestyle.css" rel="stylesheet" type="text/css" />
    <script src="../js/geturl.js" type="text/javascript"></script>
    <script src="../js/dragwindow.js" type="text/javascript"></script>
    <script src="../../JQuery/jquery-1.5.2.js" type="text/javascript"></script>
    <script src="../js/manageStopSelectSubmit.js" type="text/javascript"></script>
      <script src="../../JS/LangueSwitch.js" type="text/javascript"></script>
    <script type="text/javascript"
	src="../js/resPermissions/json/json2.js"></script>
    <script src="../js/Cookie.js" type="text/javascript"></script>
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
                                <img src="../images/tab_03.png" width="15" height="32" />
                            </td>
                            <td width="1101" background="../images/tab_05.gif">
                                <ul class="hor_ul" id="userul" runat="server">
                                    <li>
                                        <img src="../images/311.gif" width="16" height="16" /><span id="Lang_DispatchList">调度台列表</span></li>
                                    <li style="display: none">
                                        <asp:DropDownList ID="DropDownList1" runat="server" AppendDataBoundItems="True" DataSourceID="ObjectDataSource2"
                                            DataTextField="name" DataValueField="id">
                                            <asp:ListItem Value="0">选择所属单位</asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:ObjectDataSource ID="ObjectDataSource2" runat="server" SelectMethod="GetAllEntityInfo"
                                            TypeName="DbComponent.Entity">
                                            <SelectParameters>
                                                <asp:CookieParameter CookieName="id" Name="id" Type="Int32" />
                                            </SelectParameters>
                                        </asp:ObjectDataSource>
                                    </li>
                                    <li><span id="Lang_Schedulinguseid">调度用户标识:</span><span>&nbsp;&nbsp;</span><asp:TextBox ID="TextBox1" runat="server" Width="67px"></asp:TextBox></li>
                                    <li>
                                        <asp:ImageButton ID="Lang_Search" runat="server" onmouseover="javascript:this.src=window.parent.GetTextByName('Lang_Search_un',window.parent.useprameters.languagedata);"
                                            onmouseout="javascript:this.src=window.parent.GetTextByName('Lang_Search',window.parent.useprameters.languagedata);"  OnClick="ImageButton1_Click" /></li>
                                    <li>
                                        <img id="Lang_AddNew" class="style6" style="cursor: hand;" onclick="window.parent.mycallfunction('add_Dispatch',434, 422)"
                                           onmouseover="javascript:this.src=window.parent.GetTextByName('Lang_AddNew_un',window.parent.useprameters.languagedata);" onmouseout="javascript:this.src=window.parent.GetTextByName('Lang_AddNew',window.parent.useprameters.languagedata);"
                                             /></li>
                                </ul>
                            </td>
                            <td width="50" background="../images/tab_05.gif" align="right">
                                <img class="style6" style="cursor: hand;" onclick="window.parent.mycallfunction('manager_Dispatch',693, 354)"
                                    onmouseover="javascript:this.src='../images/close_un.png';" onmouseout="javascript:this.src='../images/close.png';"
                                    src="../images/close.png" />
                            </td>
                            <td width="14">
                                <img src="../images/tab_07.png" width="14" height="32" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td width="15" background="../images/tab_12.gif">
                                &nbsp;
                            </td>
                            <td align="center" id="dragtd">
                                <asp:GridView ID="GridView1" runat="server" Width="99%" AutoGenerateColumns="False"
                                    DataSourceID="ObjectDataSource1" BorderWidth="0px" CellSpacing="1" BackColor="#C0DE98"
                                    BorderColor="White" BorderStyle="Ridge" AllowPaging="True" AllowSorting="True"
                                    CellPadding="0" GridLines="None" OnRowDataBound="GridView1_RowDataBound" OnRowCommand="GridView1_RowCommand"
                                    EmptyDataText="没有查询到相关数据" DataKeyNames="id">
                                    <Columns>
                                        <asp:TemplateField HeaderText="调度用户标识">
                                            <ItemTemplate>
                                                <font onclick="window.parent.mycallfunction('view_info/view_dispatich',318, 242,'<%#Eval("id") %>')"
                                                    style="cursor: pointer;">&nbsp;&nbsp;<%# Eval("ISSI") %></font>
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Left" Width="80px" />
                                        </asp:TemplateField>
                                        <%-- <asp:BoundField DataField="Name" HeaderText="所属单位" >
                                            <ItemStyle HorizontalAlign="Left" />
                                        </asp:BoundField>--%>
                                        <asp:BoundField DataField="IPAddress" HeaderText="ip地址" ItemStyle-Width="100px">
                                            <ItemStyle HorizontalAlign="Left" />
                                        </asp:BoundField>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <font onclick="window.parent.mycallfunction('edit_Dispatch',434, 445,'<%#Eval("id") %>')"
                                                    style="cursor: pointer;">
                                                    <img id="img_modify" runat="server" src="../images/114.gif" /></font></ItemTemplate>
                                            <ItemStyle HorizontalAlign="Center" Width="50px" />
                                        </asp:TemplateField>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:LinkButton ID="ImageButton2" CommandName="MyDel" CommandArgument='<%# Eval("id") %>'
                                                   
                                                    runat="server"><img id="img_del" runat="server" src="images/083.gif"  /></asp:LinkButton></ItemTemplate>
                                            <ItemStyle HorizontalAlign="Center" Width="50px" />
                                        </asp:TemplateField>
                                        
                                    </Columns>
                                    <FooterStyle BackColor="#C6C3C6" ForeColor="Black" />
                                    <HeaderStyle CssClass="gridheadcss" Font-Bold="True" />
                                    <PagerStyle CssClass="PagerStyle" />
                                    <RowStyle BackColor="#FFFFFF" Height="22px" ForeColor="Black" />
                                    <SelectedRowStyle BackColor="#9471DE" Font-Bold="True" ForeColor="White" />
                                </asp:GridView>
                            </td>
                            <td width="14" background="../images/tab_16.gif">
                                &nbsp;
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td height="15">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td width="15" height="15">
                                <img src="../images/tab_20.png" width="15" height="15" />
                            </td>
                            <td background="../images/tab_21.gif">
                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td width="25%" nowrap="nowrap">
                                            &nbsp;
                                        </td>
                                        <td width="75%" valign="top" class="STYLE1">
                                            <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" SortParameterName="sort"
                                                SelectCountMethod="getallIIScount" SelectMethod="GetAllDsipatch" TypeName="DbComponent.DispatchInfoDao">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="DropDownList1" Name="selectcondition" PropertyName="SelectedValue" />
                                                    <asp:ControlParameter ControlID="TextBox1" Name="textseach" PropertyName="Text" />
                                                    <asp:CookieParameter CookieName="id" Name="id" Type="Int32" />
                                                    <asp:QueryStringParameter QueryStringField="id" Name="stringid" Type="String" />
                                                </SelectParameters>
                                            </asp:ObjectDataSource>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td width="14">
                                <img src="../images/tab_22.png" width="14" height="15" />
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
<script>    window.parent.closeprossdiv();
    
</script>
