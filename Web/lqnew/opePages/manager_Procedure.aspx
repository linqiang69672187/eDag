<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="manager_Procedure.aspx.cs"
    Inherits="Web.lqnew.opePages.manager_Procedure" %>

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
                                        <img src="../images/311.gif" width="16" height="16" /><span id="Lang_ProcedureList">流程列表</span></li>
                                    <li><span id="Lang_procedurename">流程名称:</span><span>&nbsp;&nbsp;</span><asp:TextBox ID="txt_procedurename" runat="server" Width="67px"></asp:TextBox></li>
                                    <li>
                                        <asp:ImageButton ID="ImageButton1" runat="server"   onmouseover="javascript:this.src=window.parent.GetTextByName('Lang_Search_un',window.parent.useprameters.languagedata);" onmouseout="javascript:this.src=window.parent.GetTextByName('Lang_Search',window.parent.useprameters.languagedata);"
                                                OnClick="ImageButton1_Click" />
                                    </li>
                                    <li>
                                        <img id="Lang_AddNew" class="style6" style="cursor: hand;" onclick="window.parent.mycallfunction('Manage_ProcedureAdd',480,500)"
                                           onmouseover="javascript:this.src=window.parent.GetTextByName('Lang_AddNew_un',window.parent.useprameters.languagedata);" onmouseout="javascript:this.src=window.parent.GetTextByName('Lang_AddNew',window.parent.useprameters.languagedata);"/>
                                    </li>
                                </ul>
                            </td>
                            <td width="50" background="../images/tab_05.gif" align="right">
                                <img class="style6" style="cursor: hand;" onclick="window.parent.mycallfunction('manager_Procedure',480,500)"
                                    onmouseover="javascript:this.src='../images/close_un.png';" onmouseout="javascript:this.src='../images/close.png';"
                                    src="../images/close.png" />
                            </td>
                            <td width="14" >
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
                                        <asp:TemplateField SortExpression="Name" HeaderText="流程名称">
                                                <ItemTemplate>
                                                       <font onclick="window.parent.mycallfunction('ShowProToPtype',400, 500,'<%#Eval("id") %>&Name=<%# Eval("Name") %>')" style="cursor: hand;">
                                                            <%# Eval("Name") %>
                                                       </font>
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Center" Width="200px" />
                                            </asp:TemplateField>
                                        <asp:BoundField DataField="Ptype" HeaderText="流程类型" ItemStyle-Width="100px" ItemStyle-HorizontalAlign="Center">
                                        </asp:BoundField>
                                        <asp:BoundField DataField="Lifetime" HeaderText="周期(天)" ItemStyle-Width="100px" ItemStyle-HorizontalAlign="Center">
                                        </asp:BoundField>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:LinkButton ID="ImageButton2" CommandName="MyDel" CommandArgument='<%# Eval("id") %>' runat="server">
                                                <img id="img_del" runat="server" src="images/083.gif"  /></asp:LinkButton></ItemTemplate>
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
                                                SelectCountMethod="getallProcedurecount" SelectMethod="GetAllProcedure" TypeName="DbComponent.DTProcedureDao">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="txt_procedurename" Name="textseach" PropertyName="Text" />
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
<script>    window.parent.closeprossdiv();</script>
