<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="manager_Emergency.aspx.cs" Inherits="Web.lqnew.opePages.manager_Emergency" %>

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
    <script src="../../JS/LangueSwitch.js"type="text/javascript"></script>
    <style type="text/css">
        
    </style>
    <script type="text/javascript">
        var Lang_EmergencyDelete = window.parent.GetTextByName("Lang_EmergencyDelete", window.parent.useprameters.languagedata);
        var Lang_Info = window.parent.GetTextByName("Lang_Info", window.parent.useprameters.languagedata);
        function chekdel(obj) {

            if (confirm(Lang_EmergencyDelete+ '?')) {
          
                return true;
            }
            return false;
        }

        $(document).ready(function () {
            LanguageSwitch(window.parent);

              })
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
                                <td style="width:auto;" background="../images/tab_05.gif">
                                    <ul class="hor_ul" id="userul" runat="server">
                                        <li>
                                            <img src="../images/311.gif" width="16" height="16" />&nbsp;&nbsp;<span id="Lang_emergency"></span>
                                        </li>
                                        <li>
                                         <asp:TextBox ID="TextBox1" runat="server" Width="67px"></asp:TextBox>
                                        </li>
                                        <li style="width:auto;">
                                            <asp:DropDownList ID="DropDownList2" runat="server" style="height:18px;margin-top:2px">
                                             
                                            </asp:DropDownList>
                                        </li>
                                        <li>
                                            <asp:ImageButton ID="ImageButton3" runat="server"
                                                OnClick="ImageButton1_Click" />
                                         </li>
                                        <li>
                                            <asp:Label ID="Label1" runat="server"><img id="Lang_AddNew"   style="cursor:pointer;"onclick="window.parent.mycallfunction('manager_EmergencyAdd',518, 417)" onmouseover="javascript:this.src=window.parent.GetTextByName('Lang_AddNew_un',window.parent.useprameters.languagedata);" onmouseout="javascript:this.src=window.parent.GetTextByName('Lang_AddNew',window.parent.useprameters.languagedata);"  /></asp:Label>

                                        </li>
                                 
                                    </ul>
                                </td>
                                <td  background="../images/tab_05.gif">
                                    <div style="text-align: left; float: left; width: 10%; padding-top:2px;"></div>
                                </td>
                                <td background="../images/tab_05.gif" align="right">
                                    <img class="style6" style="cursor: hand;" onclick="window.parent.mycallfunction('manager_Emergency',900, 370)"
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
                                        DataKeyNames="id" OnSelectedIndexChanged="GridView1_SelectedIndexChanged">
                                        <Columns>
                                           <asp:BoundField DataField="id" SortExpression="id">
                                                <ItemStyle HorizontalAlign="center" Width="50px" />
                                            </asp:BoundField>
                                             <asp:BoundField DataField="Name" SortExpression="Name">
                                                <ItemStyle HorizontalAlign="center" Width="50px"/>
                                            </asp:BoundField>
                                            <asp:BoundField DataField="PlanType" SortExpression="PlanType">
                                                <ItemStyle HorizontalAlign="center" Width="50px" />
                                            </asp:BoundField>
                                      

                                            <asp:BoundField DataField="CreateDate">
                                                <ItemStyle HorizontalAlign="center" Width="50px" />
                                            </asp:BoundField>

                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="ImageButton1" CommandName="Query"  CommandArgument='<%# Eval("id")+","+Eval("FileName") %>'
                                                        runat="server">
                                                        <img id="img_Query" runat="server" src="../images/114.gif" /><%--<font id="Lang_Query" color="black">查询</font>--%>
                                                    </asp:LinkButton>
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Center" Width="50px" />
                                            </asp:TemplateField>

                                              <asp:TemplateField>
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="ImageButton2" CommandName="MyDel" CommandArgument='<%# Eval("id")+","+Eval("FileName") %>'
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
                                                    SelectCountMethod="getAllUSEREmergency" SelectMethod="AllUSEREmergency" TypeName="DbComponent.userinfo">
                                                    <SelectParameters>
                                                        <asp:ControlParameter ControlID="DropDownList2" Name="selecttype" PropertyName="SelectedItem.Text" />
                                                        <asp:ControlParameter ControlID="TextBox1" Name="textseach" PropertyName="Text" />
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
<script language="javascript">

    window.parent.lq_changeheight(geturl(), document.body.clientHeight);

</script>
</html>
<script>
    window.parent.closeprossdiv();
</script>
