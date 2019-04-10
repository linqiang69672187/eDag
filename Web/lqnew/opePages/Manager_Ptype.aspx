<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Manager_Ptype.aspx.cs" Inherits="Web.lqnew.opePages.Manager_Ptype" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link href="../css/lq_manager.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/pagestyle.css" rel="stylesheet" type="text/css" />
    <script src="../../JQuery/jquery-1.5.2.js"></script>
    <script src="../js/geturl.js" type="text/javascript"></script>
    <script src="../js/dragwindow.js" type="text/javascript"></script>
    <script src="../js/GlobalConst.js" type="text/javascript"></script>
    <script src="../../JS/LangueSwitch.js" type="text/javascript"></script>
    <script src="../js/geturl.js" type="text/javascript"></script>
    <script src="../js/highcharts.js"></script>
    <script src="../js/MouseMenu.js"></script>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
                <tr>
                    <td height="30">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td width="15" height="30px" background="../images/tab_03.gif"></td>
                                <td background="../images/tab_05.gif">
                                    <ul class="hor_ul" id="userul" runat="server">
                                        <li>
                                            <img src="../images/311.gif" width="16" height="16" /><span id="Lang_ProcedureTypeList">流程类型列表</span></li>
                                        <li><span id="Lang_ProcedureTypeName">流程类型名称:</span><span>&nbsp;&nbsp;</span><asp:TextBox ID="txt_content" runat="server" Width="67px"></asp:TextBox></li>
                                        <li>
                                             <asp:ImageButton ID="ImageButton1" runat="server"   onmouseover="javascript:this.src=window.parent.GetTextByName('Lang_Search_un',window.parent.useprameters.languagedata);" onmouseout="javascript:this.src=window.parent.GetTextByName('Lang_Search',window.parent.useprameters.languagedata);"
                                                OnClick="ImageButton1_Click" /></li>
                                        <li>
                                            <img id="Lang_AddNew" class="style6" style="cursor: hand;" onclick="window.parent.mycallfunction('Manager_PtypeAdd',480,500)"
                                                onmouseover="javascript:this.src=window.parent.GetTextByName('Lang_AddNew_un',window.parent.useprameters.languagedata);" onmouseout="javascript:this.src=window.parent.GetTextByName('Lang_AddNew',window.parent.useprameters.languagedata);" />
                                        </li>
                                    </ul>
                                </td>
                                <td background="../images/tab_05.gif" align="right">
                                    <img class="style6" style="cursor: hand;" onclick="displaycardutymouserMenu();window.parent.mycallfunction('manager_Ptype');"
                                        onmouseover="javascript:this.src='../images/close_un.png';" onmouseout="javascript:this.src='../images/close.png';"
                                        src="../images/close.png" />
                                </td>
                                <td width="14" height="30px" background="../images/tab_07.gif"></td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td width="15" background="../images/tab_12.gif"></td>
                                <td align="left" id="dragtd">
                                    <asp:GridView ID="GridView1" runat="server" Width="99%" AutoGenerateColumns="False"
                                        DataSourceID="ObjectDataSource1" BorderWidth="0px" CellSpacing="1" BackColor="#C0DE98"
                                        BorderColor="White" BorderStyle="Ridge" AllowPaging="True" AllowSorting="True"
                                        CellPadding="0" GridLines="None" OnRowDataBound="GridView1_RowDataBound" OnRowCommand="GridView1_RowCommand"
                                        EmptyDataText="没有查询到相关数据" DataKeyNames="name">
                                        <Columns>
                                            <%--<asp:BoundField DataField="Name" HeaderText="类型名称" ItemStyle-Width="300px" ItemStyle-HorizontalAlign="Center"></asp:BoundField>--%>
                                            <asp:TemplateField SortExpression="Name" HeaderText="类型名称">
                                                <ItemTemplate>
                                                    <font style="cursor: hand;">&nbsp;&nbsp;<%# Eval("Name") %></font>
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Center" Width="200px" />
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="reserve1" HeaderText="字段1" ItemStyle-Width="200px" ItemStyle-HorizontalAlign="Center"></asp:BoundField>
                                            <asp:BoundField DataField="reserve2" HeaderText="字段2" ItemStyle-Width="200px" ItemStyle-HorizontalAlign="Center"></asp:BoundField>
                                            <asp:BoundField DataField="reserve3" HeaderText="字段3" ItemStyle-Width="200px" ItemStyle-HorizontalAlign="Center"></asp:BoundField>
                                            <asp:BoundField DataField="reserve4" HeaderText="字段4" ItemStyle-Width="200px" ItemStyle-HorizontalAlign="Center"></asp:BoundField>
                                            <asp:BoundField DataField="reserve5" HeaderText="字段5" ItemStyle-Width="200px" ItemStyle-HorizontalAlign="Center"></asp:BoundField>
                                            <asp:BoundField DataField="reserve6" HeaderText="字段6" ItemStyle-Width="200px" ItemStyle-HorizontalAlign="Center"></asp:BoundField>
                                            <asp:BoundField DataField="reserve7" HeaderText="字段7" ItemStyle-Width="200px" ItemStyle-HorizontalAlign="Center"></asp:BoundField>
                                            <asp:BoundField DataField="reserve8" HeaderText="字段8" ItemStyle-Width="200px" ItemStyle-HorizontalAlign="Center"></asp:BoundField>
                                            <asp:BoundField DataField="reserve9" HeaderText="字段9" ItemStyle-Width="200px" ItemStyle-HorizontalAlign="Center"></asp:BoundField>
                                            <asp:BoundField DataField="reserve10" HeaderText="字段10" ItemStyle-Width="200px" ItemStyle-HorizontalAlign="Center"></asp:BoundField>
                                            <asp:BoundField DataField="Remark" HeaderText="备注" ItemStyle-Width="100px" ItemStyle-HorizontalAlign="Center"></asp:BoundField>
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <font onclick="window.parent.mycallfunction('Manager_PtypeModify',550, 710,'<%#Eval("name") %>')"
                                                        style="cursor: hand;">
                                                        <img id="img_modify" runat="server" src="../images/114.gif" /><%--<font id="Lang-T-edittext">修改</font>--%></font>
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Center" Width="50px" />
                                            </asp:TemplateField>
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="ImageButton2" CommandName="MyDel" CommandArgument='<%# Eval("name") %>' runat="server">
                                                        <img id="img_del" runat="server" src="images/083.gif" />
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
                                    <img src="../images/tab_20.png" width="15" height="15" />
                                </td>
                                <td background="../images/tab_21.gif">
                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td width="25%" nowrap="nowrap"></td>
                                            <td width="75%" valign="top" class="STYLE1">
                                                <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" SortParameterName="sort"
                                                    SelectCountMethod="getallProcedurecount" SelectMethod="GetAllProcedure" TypeName="DbComponent.DTProcedureType">
                                                    <SelectParameters>
                                                        <asp:ControlParameter ControlID="txt_content" Name="textseach" PropertyName="Text" />
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
    <!--script start-->
    
    <script type="text/javascript">
        ///关闭进度条
        window.parent.closeprossdiv();

        //window.parent.parent.document.getElementById("mybkdiv").style.display = "block";

        function displaycardutymouserMenu() {
            //注释一行语句，没有mouseMenu；调用mycallfunction()关闭窗口----------------------xzj--2018/6/28------------------------------
            //window.parent.document.getElementById("mouseMenu").style.display = "none";
            window.parent.mycallfunction('manager_Ptype', 480, 500);
            //注释一行语句，没有mouseMenu；调用mycallfunction()关闭窗口----------------------xzj--2018/6/28------------------------------

            //window.parent.parent.document.getElementById("mybkdiv").style.display = "none";
        }

    </script>

</html>
