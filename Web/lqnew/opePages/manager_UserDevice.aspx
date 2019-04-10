<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="manager_UserDevice.aspx.cs" Inherits="Web.lqnew.opePages.manager_UserDevice" %>

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
    <script src="../../JS/LangueSwitch.js"type="text/javascript"></script>
    <style type="text/css">
        .button-blue {
            height:22px;
            text-align:center;
            border-radius:5px;
            border:1px solid #000000;
            box-shadow:inset 1px 5px 5px 1px #647e98;
            background-color:#084a64;
            color:white;
        }
    </style>
    <script type="text/javascript">
        
        function exportExcel2() {

            //alert(unitId);
            //alert(unitName);
            //alert(searchTypeId);
            //alert(searchTypeName);
            //alert(key);
            var count = 0;
            count = "<%=GridView1.PageCount%>";
            var var_Lang_nodatetoexport = window.parent.GetTextByName("Lang_nodatetoexport", window.parent.useprameters.languagedata);
            if (count == 0) {
                alert(var_Lang_nodatetoexport);
            }
            else {
                window.location = "../../Handlers/UserDeviceToExcel.ashx?unitId=" + unitId + "&unitName=" + unitName + "&searchTypeId=" + searchTypeId + "&searchTypeName=" + searchTypeName + "&key=" + key;
            }
        }


        var unitId = "";
        var unitName = "";
        var searchTypeId = "";
        var searchTypeName = "";
        var key = "";
        $(document).ready(function () {
            LanguageSwitch(window.parent);
            unitId = $("#<%=DropDownList1.ClientID%> option:selected").val();
            unitName = $("#<%=DropDownList1.ClientID%> option:selected").text();
            searchTypeId = $("#<%=DropDownList2.ClientID%> option:selected").val();
            searchTypeName = $("#<%=DropDownList2.ClientID%> option:selected").text();
            key = escape($("#<%=TextBox1.ClientID%>").val());

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
                                            <img src="../images/311.gif" width="16" height="16" />&nbsp;&nbsp;<span id="Lang_UserDeviceManage"></span></li>
                                        <li>
                                            <asp:DropDownList ID="DropDownList1" runat="server" AppendDataBoundItems="True" DataSourceID="ObjectDataSource2"
                                                DataTextField="name" DataValueField="id">
                                                <asp:ListItem Value="0"></asp:ListItem>
                                            </asp:DropDownList>
                                            <asp:ObjectDataSource ID="ObjectDataSource2" runat="server" SelectMethod="GetAllEntityInfoByPermissions"
                                                TypeName="DbComponent.Entity">
                                                <SelectParameters>
                                                </SelectParameters>
                                            </asp:ObjectDataSource>
                                        </li>
                                        <li style="width:auto;">
                                            <asp:DropDownList ID="DropDownList2" runat="server">
                                                <asp:ListItem Selected="True" Value="Nam"></asp:ListItem>
                                                <asp:ListItem Value="Num"></asp:ListItem>
                                                <asp:ListItem Value="ISSI"></asp:ListItem>
                                            </asp:DropDownList>
                                        </li>
                                        <li>
                                            <asp:TextBox ID="TextBox1" runat="server" Width="67px"></asp:TextBox></li>
                                        <li>
                                            <asp:ImageButton ID="ImageButton1" runat="server"
                                                OnClick="ImageButton1_Click" /></li>
                                        <li> <input onclick="exportExcel2()" type="button"  class="Langtxt button-blue" style=" margin-left: 150px" id="Lang_ExportToExcel" value="导出到Excel" />
                                            </li>
                                    </ul>
                                </td>
                                <td  background="../images/tab_05.gif">
                                    <div style="text-align: left; float: left; width: 10%; padding-top:2px;"></div>
                                </td>
                                <td background="../images/tab_05.gif" align="right">
                                    <img class="style6" style="cursor: hand;" onclick="window.parent.mycallfunction('manager_UserDevice',900, 370)"
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
                                        CellPadding="0" GridLines="None" OnRowDataBound="GridView1_RowDataBound"
                                        DataKeyNames="id,type,ISSI" OnSelectedIndexChanged="GridView1_SelectedIndexChanged">
                                        <Columns>
                                           <asp:BoundField DataField="id" SortExpression="id">
                                                <ItemStyle HorizontalAlign="center" Width="50px" />
                                            </asp:BoundField>
                                             <asp:BoundField DataField="PName" SortExpression="PName">
                                                <ItemStyle HorizontalAlign="Left" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="UName" SortExpression="UName">
                                                <ItemStyle HorizontalAlign="Left" />
                                            </asp:BoundField>
                                            <asp:TemplateField SortExpression="Nam">
                                                <ItemTemplate>
                                                    &nbsp;&nbsp;<%# Eval("Nam") %>
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Left" Width="80px" />
                                            </asp:TemplateField> 
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                </ItemTemplate>
                                                <ItemStyle Width="40px" HorizontalAlign="Center" />
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="Num">
                                                <ItemStyle HorizontalAlign="Left" Width="70px" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="ISSI" SortExpression="ISSI">
                                                <ItemStyle HorizontalAlign="Center" Width="70px" />
                                            </asp:BoundField>
                                            
                                           
                                             <asp:BoundField DataField="Telephone" SortExpression="Telephone">
                                                <ItemStyle HorizontalAlign="Left" Width="125px"/>
                                            </asp:BoundField>
                                             <asp:BoundField DataField="Position" SortExpression="Position">
                                                <ItemStyle HorizontalAlign="Left" Width="85px"   />
                                            </asp:BoundField>
                                             <asp:BoundField DataField="Productmodel" SortExpression="ParentId">
                                                <ItemStyle HorizontalAlign="Left" Width="80px"/>
                                            </asp:BoundField>
                                             <asp:BoundField DataField="Manufacturers" SortExpression="ParentId">
                                                <ItemStyle HorizontalAlign="Left" Width="120px"/>
                                            </asp:BoundField>

                                            
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
                                                    SelectCountMethod="getAllUSERDeviceCount" SelectMethod="AllUSERDeviceInfo" TypeName="DbComponent.userinfo">
                                                    <SelectParameters>
                                                        <asp:ControlParameter ControlID="DropDownList1" Name="selectcondition" PropertyName="SelectedValue" />
                                                        <asp:ControlParameter ControlID="DropDownList2" Name="selecttype" PropertyName="SelectedValue" />
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
