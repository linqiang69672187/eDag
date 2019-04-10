<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="manager_ISSI.aspx.cs" Inherits="Web.lqnew.opePages.manager_ISSI" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="../../JS/LangueSwitch.js" type="text/javascript"></script>
    <link href="../css/lq_manager.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/pagestyle.css" rel="stylesheet" type="text/css" />
    <script src="../js/geturl.js" type="text/javascript"></script>
    <script src="../js/dragwindow.js" type="text/javascript"></script>
    <script src="../../JQuery/jquery-1.5.2.js" type="text/javascript"></script>
    <script src="../js/manageStopSelectSubmit.js" type="text/javascript"></script>
    <script type="text/javascript">
        function setHidExternal(val) {

            document.getElementById("hidExternal").value = val;
            //alert(document.getElementById("hidExternal").value);
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
                                    <img src="../images/tab_03.png" width="15" height="32" />
                                </td>
                                <td width="1101" background="../images/tab_05.gif">
                                    <ul class="hor_ul" id="userul" runat="server">
                                        <li>
                                            <img src="../images/311.gif" width="16" height="16" /><span id="Lang_ISSIList">终端列表</span></li>
                                        <li>
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
                                        <li><span id="Lang_terminal_identification">终端号码</span><span>&nbsp;&nbsp;</span><asp:TextBox ID="TextBox1" runat="server" Width="67px"></asp:TextBox></li>
                                        <%--javascript:this.src='../images/btn_search_un.png';--%>
                                        <%--javascript:this.src='../images/btn_search.png';--%>
                                        <li>
                                            <asp:ImageButton ID="Lang_Search2" runat="server" onmouseover="javascript:this.src=window.parent.GetTextByName('Lang_Search2',window.parent.useprameters.languagedata);"
                                                onmouseout="javascript:this.src=window.parent.GetTextByName('Lang_Search2_un',window.parent.useprameters.languagedata);"
                                                OnClick="ImageButton1_Click"  OnClientClick="setHidExternal('0');" /></li>
                                        <li>
                                            <img id="Lang_AddNew" class="style6" style="cursor: pointer;" onclick="window.parent.mycallfunction('add_ISSI',484, 710)"
                                                onmouseover="javascript:this.src=window.parent.GetTextByName('Lang_AddNew_un',window.parent.useprameters.languagedata);" onmouseout="javascript:this.src=window.parent.GetTextByName('Lang_AddNew',window.parent.useprameters.languagedata);" /></li>
                                        <li>
                                            <img id="Lang_btn_pladd" class="style6" style="cursor: pointer; margin-top: -2px;" onclick="window.parent.mycallfunction('add_ISSIs',484, 842)"
                                                onmouseover="javascript:this.src=window.parent.GetTextByName('Lang_btn_pladd_un',window.parent.useprameters.languagedata);" onmouseout="javascript:this.src=window.parent.GetTextByName('Lang_btn_pladd',window.parent.useprameters.languagedata);" /></li>
                                      <li>
                                            <asp:ImageButton ID="Lang_ExternalTerminal" runat="server" onmouseover="javascript:this.src=window.parent.GetTextByName('Lang_ExternalTerminal',window.parent.useprameters.languagedata);"
                                                onmouseout="javascript:this.src=window.parent.GetTextByName('Lang_ExternalTerminal',window.parent.useprameters.languagedata);"
                                                OnClick="ImageButton2_Click"  OnClientClick="setHidExternal('1');"  /></li>
                                    </ul>
                                   
                                </td>
                                <td width="50" background="../images/tab_05.gif" align="right">
                                    <img style="cursor: pointer;" onclick="window.parent.mycallfunction('manager_ISSI',693, 702)"
                                        onmouseover="javascript:this.src='../images/close_un.png';" onmouseout="javascript:this.src='../images/close.png';"
                                        src="../images/close.png" />
                                </td>
                                <td width="14">
                                    <img src="../images/tab_07.png" width="14" height="32" /> <asp:HiddenField ID="hidExternal" Value="0" runat="server" />
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
                                        EmptyDataText="没有查询到相关数据！" DataKeyNames="id,GSSIS">
                                        <Columns>
                                            <asp:TemplateField HeaderText="终端号码" SortExpression="ISSI">
                                                <ItemTemplate>
                                                    <!--------xzj--2018/7/10----------修改oncick中函数的高度参数为584-->
                                                    <font onclick="window.parent.mycallfunction('view_info/view_ISSI',418, 584,'<%#Eval("id") %>')"
                                                        style="cursor: pointer; width: 60px">&nbsp;&nbsp;<%# Eval("ISSI") %></font>
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Left" Width="60px" />
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="typeName" HeaderText="终端类型" SortExpression="typeName">
                                                <ItemStyle HorizontalAlign="Left" Width="60px" />
                                            </asp:BoundField>
                                            
                                            <asp:BoundField DataField="Entity_ID" HeaderText="所属单位" SortExpression="Entity_ID">
                                                <ItemStyle HorizontalAlign="Left" Width="120px" />
                                            </asp:BoundField>
                                            <asp:TemplateField HeaderText="驻留组">
                                                <HeaderStyle Wrap="False" />
                                                <ItemStyle HorizontalAlign="left" Width="140px" Wrap="False" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="扫描组">
                                                <HeaderStyle Wrap="False" />
                                                <ItemStyle HorizontalAlign="left" Width="140px" Wrap="False" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="通播组">
                                                <HeaderStyle Wrap="False" />
                                                <ItemStyle HorizontalAlign="left" Width="140px" Wrap="False" />
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="IsExternal" HeaderText="外系统">
                                                <ItemStyle HorizontalAlign="Center" />
                                            </asp:BoundField>
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <font onclick="window.parent.mycallfunction('edit_ISSI',484, 760,'<%#Eval("id") %>')"<%--xzj--20181213--将高度由710设置为760--%>
                                                        style="cursor: hand;">
                                                        <img id="img_modify" runat="server" src="../images/114.gif" /><%--<font id="Lang-T-edittext">修改</font>--%></font>
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Center" Width="50px" />
                                            </asp:TemplateField>
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="ImageButton2" CommandName="MyDel" CommandArgument='<%# Eval("id") %>'
                                                        OnClientClick="javascript:return confirm(window.parent.GetTextByName('Lang_ConfirmDeleteISSI', window.parent.useprameters.languagedata)+'['+this.parentElement.parentElement.getElementsByTagName('font')[0].innerText.trim()+']'+window.parent.GetTextByName('Lang_Info', window.parent.useprameters.languagedata)+'?')"
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
                                                    SelectCountMethod="getallIIScount" SelectMethod="AllISSIInfo" TypeName="DbComponent.ISSI">
                                                    <SelectParameters>
                                                        <asp:ControlParameter ControlID="DropDownList1" Name="selectcondition" PropertyName="SelectedValue" />
                                                        <asp:ControlParameter ControlID="TextBox1" Name="textseach" PropertyName="Text" />
                                                        <asp:CookieParameter CookieName="id" Name="id" Type="Int32" />
                                                        <asp:QueryStringParameter QueryStringField="id" Name="stringid" Type="String" />
                                                        <asp:ControlParameter ControlID="hidExternal" Name="isExternal" PropertyName="Value" />
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
