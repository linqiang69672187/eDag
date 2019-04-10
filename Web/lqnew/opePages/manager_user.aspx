<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="manager_user.aspx.cs" Inherits="Web.lqnew.opePages.manager_user" %>

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
    <script src="../../LangJS/managerGroup_langjs.js"></script>
    <style type="text/css">
        
    </style>
    <script type="text/javascript">       
        function DarewithDisplay(CI, issi, username) {
            var Lang_user_is_nodisplay_and_whether_to_open_and_locat = window.parent.GetTextByName("Lang_user_is_nodisplay_and_whether_to_open_and_locat", window.parent.useprameters.languagedata)
            if (confirm(Lang_user_is_nodisplay_and_whether_to_open_and_locat)) {
                window.parent.jquerygetNewData_ajax("../../Handlers/OpenHDHandler.ashx", { issi: issi, username: username }, function (msg) {
                    window.parent.locationbyUseid(CI);
                    window.parent.mycallfunction('manager_user');
                })

            }
           
        }
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
                                            <img src="../images/311.gif" width="16" height="16" /><span class="Langtxt" id="UserinfoTable"></span></li>
                                        <li>
                                            <asp:DropDownList ID="DropDownList1" runat="server" AppendDataBoundItems="True" DataSourceID="ObjectDataSource2"
                                                DataTextField="name" DataValueField="id">
                                                <asp:ListItem Value="0"></asp:ListItem>
                                            </asp:DropDownList>
                                            <asp:ObjectDataSource ID="ObjectDataSource2" runat="server" SelectMethod="GetAllEntityInfo"
                                                TypeName="DbComponent.Entity">
                                                <SelectParameters>
                                                    <asp:CookieParameter CookieName="id" Name="id" Type="Int32" />
                                                </SelectParameters>
                                            </asp:ObjectDataSource>
                                        </li>
                                        <li>
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
                                                OnClick="ImageButton1_Click"  OnClientClick="setHidExternal('0');" /></li>
                                        <li>
                                            <!---------------------------xzj--2018/6/28--修改onclick()调用函数的高度参数为380------------------>
                                            <img id="Lang_AddNew" class="style6" style="cursor: pointer;"  onclick="window.parent.mycallfunction('add_user',471, 380)"
                                                onmouseover="javascript:this.src=window.parent.GetTextByName('Lang_AddNew_un',window.parent.useprameters.languagedata);" onmouseout="javascript:this.src=window.parent.GetTextByName('Lang_AddNew',window.parent.useprameters.languagedata);" /></li>
                                            <!---------------------------xzj--2018/6/28--修改onclick()调用函数的高度参数为380------------------>
                                         <li>
                                            <asp:ImageButton ID="Lang_ExternalUser" runat="server" onmouseover="javascript:this.src=window.parent.GetTextByName('Lang_ExternalUser',window.parent.useprameters.languagedata);"
                                                onmouseout="javascript:this.src=window.parent.GetTextByName('Lang_ExternalUser',window.parent.useprameters.languagedata);"
                                                OnClick="ImageButton2_Click"  OnClientClick="setHidExternal('1');"  /></li>
                                    </ul>
                                     <asp:HiddenField ID="hidExternal" Value="0" runat="server" />
                                </td>
                                <td width="50" background="../images/tab_05.gif" align="right">
                                    <img class="style6" style="cursor: hand;" onclick="window.parent.mycallfunction(geturl(),693, 354)"
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
                                        DataKeyNames="id,type,ISSI" OnSelectedIndexChanged="GridView1_SelectedIndexChanged">
                                        <Columns>
                                            <asp:TemplateField Visible ="false">
                                                <ItemTemplate>
                                                    <asp:ImageButton ID="imgLocation" CausesValidation="False" CommandName="choose" ImageUrl="~/images/xz.gif"
                                                        CommandArgument='<%# "Police,0,0|"+ Eval("ID")+"|"+Eval("Longitude")+"|"+Eval("Latitude") +"|"+Eval("IsDisplay")+"|"+Eval("ISSI") %>'
                                                        runat="server" ToolTip='<%# "Police,0,0|"+ Eval("ID")+"|"+Eval("Longitude")+"|"+Eval("Latitude") +"|"+Eval("IsDisplay")+"|"+Eval("ISSI") %>' />
                                                </ItemTemplate>
                                                <ItemStyle Width="30px" />
                                            </asp:TemplateField>
                                            <asp:TemplateField SortExpression="Nam">
                                                <ItemTemplate>
                                                    <font onclick="window.parent.mycallfunction('view_info/view_user',418, 415,'<%#Eval("id") %>');"
                                                        style="cursor: hand;">&nbsp;&nbsp;<%# Eval("Nam") %></font>
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Left" Width="80px" />
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="Num">
                                                <ItemStyle HorizontalAlign="Left" Width="60px" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="ISSI" SortExpression="ISSI">
                                                <ItemStyle HorizontalAlign="Center" Width="60px" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="Entity_ID" SortExpression="Entity_ID">
                                                <ItemStyle HorizontalAlign="Left" />
                                            </asp:BoundField>
                                          <%--  <asp:TemplateField>
                                                <ItemTemplate>
                                                </ItemTemplate>
                                                <ItemStyle Width="30px" HorizontalAlign="Center" />
                                            </asp:TemplateField>--%>

                                      <asp:TemplateField HeaderText="Image">  
                                     <ItemTemplate> 
                                    <asp:Image ID="Image1" runat="server"  Height="30px" Width="30px" 
                                     ImageUrl='<%# "UpLoad/ReadImage.aspx?name="+ Eval("name")+"&type="+Eval("Itype") %>'/> 
                                
                                     </ItemTemplate>
                                    <ItemStyle Width="30px" HorizontalAlign="Center" /> 
                                    </asp:TemplateField>

                                             <asp:BoundField DataField="Telephone" SortExpression="Telephone">
                                                <ItemStyle HorizontalAlign="Left" Width="125px"/>
                                            </asp:BoundField>
                                             <asp:BoundField DataField="Position" SortExpression="Position">
                                                <ItemStyle HorizontalAlign="Left" Width="85px"   />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="IsExternal" HtmlEncode="false">
                                                <ItemStyle HorizontalAlign="Center" />
                                            </asp:BoundField>
                                            <asp:TemplateField Visible ="false">
                                                <ItemTemplate>
                                                    <asp:ImageButton ID="ImageButton1" runat="server" />
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Center" Width="30px" />
                                            </asp:TemplateField>
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <!---------------------------xzj--2018/6/28--修改onclick()调用函数的高度参数为380------------------>
                                                    <font onclick="window.parent.mycallfunction('edit_user',471, 380,'<%#Eval("id") %>')"                       
                                                        style="cursor: pointer;">
                                                    <!---------------------------xzj--2018/6/28--修改onclick()调用函数的高度参数为380------------------>
                                                        <img id="img_modify" runat="server" src="../images/114.gif" /><%--<span  class="Langtxt"   id="Modify" ></span>--%></font>
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Center" Width="50px" />
                                            </asp:TemplateField>
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="ImageButton2" CommandName="MyDel" CommandArgument='<%# Eval("id") %>'
                                                        runat="server">
                                                        <img id="img_del" runat="server" src="images/083.gif" /><%--<font color="black"><span  class="Langtxt"   id="Delete" ></span></font>--%>
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
                                                    SelectCountMethod="getallIIScount" SelectMethod="AllUSERInfo" TypeName="DbComponent.userinfo">
                                                    <SelectParameters>
                                                        <asp:ControlParameter ControlID="DropDownList1" Name="selectcondition" PropertyName="SelectedValue" />
                                                        <asp:ControlParameter ControlID="DropDownList2" Name="selecttype" PropertyName="SelectedValue" />
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
<script language="javascript">
    function geturl() {
        //        var str = window.location.href;
        //        str = str.substring(str.lastIndexOf("/") + 1)
        //        str = str.split(".")[0];
        //        return str;
        return "manager_user";
    }
    window.parent.lq_changeheight(geturl(), document.body.clientHeight);
    function mousd() {
        window.parent.mystartDragWindow(window.parent.document.getElementById("manager_user"));
    }
</script>
</html>
<script>
    window.parent.closeprossdiv();
   

   //window.document.getElementById("Lang_AddNew").src = window.parent.GetTextByName('Lang_AddNew', window.parent.useprameters.languagedata);

</script>
