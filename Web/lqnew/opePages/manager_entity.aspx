<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="manager_entity.aspx.cs"
    Inherits="Web.lqnew.opePages.manager_entity" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">    
    <title></title>
    <meta http-equiv="Cache-Control" content="no-cache,no-store, must-revalidate">
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="expires" content="0">
    <link href="../css/lq_manager.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/pagestyle.css" rel="stylesheet" type="text/css" />
    <script src="../js/geturl.js" type="text/javascript"></script>
    <script src="../js/dragwindow.js" type="text/javascript"></script>
    <script src="../../JS/LangueSwitch.js" type="text/javascript"></script>
    <script type="text/javascript">
        var Lang_ConfirmDelete = window.parent.GetTextByName("Lang_ConfirmDelete", window.parent.useprameters.languagedata);
        var Lang_Info = window.parent.GetTextByName("Lang_Info", window.parent.useprameters.languagedata);

        function myDW(lo, la) {
            if (lo == "0.0000000" || la == "0.0000000" || lo == 0 || la == 0 || lo == "" || la == "") {
                alert(window.parent.GetTextByName("Alert_EntityUnLoLa", window.parent.useprameters.languagedata));
            }
            else {
                window.parent.psLayerManager.locatePoliceStation([lo, la]);
                //window.parent.mycallfunction('manager_entity', 693, 354);
            }
        }
        function chekdel(obj) {

            if (confirm(Lang_ConfirmDelete + '[' + obj.parentElement.parentElement.getElementsByTagName('font')[0].innerText.trim() + ']' + Lang_Info + '?')) {
                //注释------------------xzj--2018/6/29-----------------------
                //window.parent.visiablebg();
                //注释------------------xzj--2018/6/29-----------------------
                return true;
            }

            return false;
        }
    </script>
</head>
<body>
    <form id="form1" runat="server" autocomplete="false">
        <div>
            <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
                <tr>
                    <td height="30">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td width="15" height="32">
                                    <img src="../images/tab_03.png" width="15" height="32" />
                                </td>
                                <td width="1161" background="../images/tab_05.gif">
                                    <ul class="hor_ul">
                                        <li>
                                            <img src="../images/311.gif" width="16" height="16" /><span id="Lang-EntityList">单位列表</span></li>
                                        <li>
                                            <asp:DropDownList ID="DropDownList1" runat="server" AppendDataBoundItems="True" DataSourceID="ObjectDataSource2"
                                                DataTextField="name" DataValueField="id">
                                                <asp:ListItem Value="0">选择上级单位</asp:ListItem>
                                            </asp:DropDownList>
                                            <asp:ObjectDataSource ID="ObjectDataSource2" runat="server" SelectMethod="GetAllEntityInfo"
                                                TypeName="DbComponent.Entity">
                                                <SelectParameters>
                                                    <asp:CookieParameter CookieName="id" Name="id" Type="Int32" />
                                                </SelectParameters>
                                            </asp:ObjectDataSource>
                                        </li>
                                        <li><span id="Lang-EntityName">单位名称</span><span>&nbsp;&nbsp;</span><asp:TextBox ID="TextBox1" runat="server" Width="80px"></asp:TextBox></li>
                                        <li>
                                            <asp:ImageButton ID="Lang_Search" runat="server" OnClick="ImageButton1_Click" /></li>
                                        <li>
                                            <asp:Label ID="Label1" runat="server"><img id="Lang_AddNew"   style="cursor:pointer;"onclick="window.parent.mycallfunction('add_entity',518, 417)" onmouseover="javascript:this.src=window.parent.GetTextByName('Lang_AddNew_un',window.parent.useprameters.languagedata);" onmouseout="javascript:this.src=window.parent.GetTextByName('Lang_AddNew',window.parent.useprameters.languagedata);"  /></asp:Label></li>
                                        <li>
                                            <!---------------xzj--2018/6/29-------------窗口高度由800改为566-->
                                            <img id="Lang_AddEntityBatch" class="style6" style="cursor: pointer; " onclick="window.parent.mycallfunction('UserChangeEntity1',800, 566)" onmouseover="javascript:this.src=window.parent.GetTextByName('Lang_AddEntityBatch_un',window.parent.useprameters.languagedata);" onmouseout="javascript:this.src=window.parent.GetTextByName('Lang_AddEntityBatch',window.parent.useprameters.languagedata);" />
                                            <!---------------xzj--2018/6/29-------------窗口高度由800改为566-->
                                        </li>
                                    </ul>
                                </td>
                                <td width="50" background="../images/tab_05.gif" align="right">
                                    <img class="style6" style="cursor: pointer;" onclick="window.parent.mycallfunction('manager_entity',693, 354)"
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
                                <td width="15" background="../images/tab_12.gif">&nbsp;
                                </td>
                                <td align="center" id="dragtd">
                                    <asp:GridView ID="GridView1" runat="server" Width="99%" AutoGenerateColumns="False"
                                        DataSourceID="ObjectDataSource1" BorderWidth="0px" CellSpacing="1" BackColor="#C0DE98"
                                        BorderColor="White" BorderStyle="Ridge" AllowPaging="True" AllowSorting="True"
                                        CellPadding="0" GridLines="None" OnRowDataBound="GridView1_RowDataBound" OnRowCommand="GridView1_RowCommand"
                                        EmptyDataText="<%--没有查询到相关数据！--%>">
                                        <Columns>
                                            <asp:TemplateField HeaderText="<%--单位名称--%>" SortExpression="Name" ItemStyle-Width="180px">
                                                <ItemTemplate>
                                                    <font onclick="window.parent.mycallfunction('view_info/viewpage',328, 342,'<%#Eval("id") %>')"
                                                        style="cursor: hand;">
                                                        <%# Eval("Name") %></font>
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Left" />
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="ParentID" HeaderText="<%--上级单位--%>" SortExpression="ParentID" ItemStyle-Width="180px">
                                                <ItemStyle HorizontalAlign="Left" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="Depth" HeaderText="<%--级别--%>" SortExpression="Depth" NullDisplayText="lang-Depth">
                                                <ItemStyle Width="30px" />
                                            </asp:BoundField>
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <img id="img_location" title="<%= Ryu666.Components.ResourceManager.GetString("Lang_Location") %>" alt="loction" src="../../images/xz.gif" onclick="myDW('<%#Eval("Lo") %>', '<%#Eval("La") %>')" style="cursor: pointer;" />
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Center" Width="50px" />
                                            </asp:TemplateField>
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <font onclick="window.parent.mycallfunction('edit_entity',518, 442,'<%#Eval("id") %>')"
                                                        style="cursor: hand;">
                                                        <img id="img_modify" runat="server" src="../images/114.gif" /><%--<font id="Lang_modify">修改</font>--%></font>
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Center" Width="50px" />
                                            </asp:TemplateField>
                                            <asp:TemplateField ItemStyle-Width="200px">
                                                <ItemTemplate>
                                                    <font onclick="window.parent.mycallfunction('add_entity',518, 417,'<%#Eval("id") %>,<%#Eval("Depth") %>')"
                                                        style="cursor: pointer;">
                                                        <img id="img_add" src="../images/001.gif" runat="server" /><%--<font id="Lang_Add_SubordinateUnit">新增下级单位></font>--%></font>
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Center" Width="50px" />
                                            </asp:TemplateField>
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="ImageButton2" CommandName="MyDel" CommandArgument='<%# Eval("id") %>'
                                                        OnClientClick="javascript:return chekdel(this);"
                                                        runat="server">
                                                        <img id="img_del" runat="server" src="images/083.gif" /><%--<font id="Lang_Delete" color="black">删除</font>--%>
                                                    </asp:LinkButton>
                                                </ItemTemplate>
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
                                <td width="14" background="../images/tab_16.gif">&nbsp;
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
                                            <td width="25%" nowrap="nowrap">&nbsp;
                                            </td>
                                            <td width="75%" valign="top" class="STYLE1">
                                                <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" SortParameterName="sort"
                                                    SelectCountMethod="getallentitycount" SelectMethod="AllEntityInfo" TypeName="DbComponent.Entity">
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
<script type="text/javascript">
    window.parent.closeprossdiv();
    window.parent.hiddenbg();
</script>
