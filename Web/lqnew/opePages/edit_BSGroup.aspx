<%@ Page Language="C#" AutoEventWireup="true" ValidateRequest="false" CodeBehind="edit_BSGroup.aspx.cs"
    Inherits="Web.lqnew.opePages.edit_BSGroup" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link href="../css/lq_addedit.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/pagestyle.css" rel="stylesheet" type="text/css" />
    <script src="../js/geturl.js" type="text/javascript"></script>
    <script src="../js/dragwindow.js" type="text/javascript"></script>
    <script src="../../JQuery/jquery-1.5.2.js" type="text/javascript"></script>
    <script src="../../LangJS/managerGroup_langjs.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
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
                                    <ul class="hor_ul">
                                        <li>
                                            <img src="../images/037.gif" /><span class="Langtxt" id="Modify"></span></li>
                                    </ul>
                                </td>
                                <td width="281" background="../images/tab_05.gif" align="right">
                                    <img class="style6" style="cursor: hand;" onclick="window.parent.mycallfunction(geturl())"
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
                                <td align="center">
                                    <table class="style1" cellspacing="1" id="dragtd">
                                        <tr>
                                            <td colspan="2" align="left" style="background-image: url(../images/add_entity_infobg.png); height: 33;">
                                                <div style="background-image: url(../images/add_entity_info.png); width: 130px; height: 23px;">
                                                    <div style="margin-left: 29px; font-size: 14px; font-weight: bold; color: #006633; padding-top: 5px;">
                                                        <span class="Langtxt" id="JZgroupinformation"></span>
                                                    </div>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="style3" align="right" style="width: 75px;">
                                                <span class="Langtxt" id="Lang_Stationgroupname"></span>&nbsp;&nbsp;
                                            </td>
                                            <td class="style3" align="left">
                                                <asp:TextBox ValidationGroup="sub1" ID="TextBox1" runat="server" Width="135px"></asp:TextBox>
                                                <font color="red">*</font>
                                                <asp:RegularExpressionValidator ValidationGroup="sub1" ID="validateEntityLength" runat="server" Display="None"
                                                    ControlToValidate="TextBox1"></asp:RegularExpressionValidator>
                                                <cc1:ValidatorCalloutExtender ID="ValidatorCalloutExtender2" runat="server" TargetControlID="validateEntityLength"
                                                    Width="210px" HighlightCssClass="cssValidatorCalloutHighlight">
                                                    <Animations>
                                                <OnShow>
                                                    <Sequence>
                                                        <HideAction Visible="true" />
                                                        <FadeIn />
                                                    </Sequence>
                                                </OnShow>
                                                <OnHide>
                                                    <Sequence>
                                                        <FadeOut Duration=".4" />
                                                        <HideAction Visible="false" />
                                                        <StyleAction Attribute="display" Value="none"/>
                                                    </Sequence>
                                                </OnHide>
                                                    </Animations>
                                                </cc1:ValidatorCalloutExtender>
                                                <asp:RequiredFieldValidator ValidationGroup="sub1" ID="RequiredFieldValidator1" runat="server" ControlToValidate="TextBox1"
                                                    Display="None"></asp:RequiredFieldValidator>
                                                <cc1:ValidatorCalloutExtender ID="vceTxtName" runat="server" TargetControlID="RequiredFieldValidator1"
                                                    Width="210px" HighlightCssClass="cssValidatorCalloutHighlight">
                                                    <Animations>
                                                <OnShow>
                                                    <Sequence>
                                                        <HideAction Visible="true" />
                                                        <FadeIn />
                                                    </Sequence>
                                                </OnShow>
                                                <OnHide>
                                                    <Sequence>
                                                        <FadeOut Duration=".4" />
                                                        <HideAction Visible="false" />
                                                        <%-- 如果没有使用这个动画，则会因为外显型对话框验证器扩展器会位在其他网页项目的上，
                                                             因而无法点选先前外显型对话框验证器扩展器所在位置的网页项目。
                                                             事实上，我们可以省略上面那道设置。 --%>
                                                        <StyleAction Attribute="display" Value="none"/>
                                                    </Sequence>
                                                </OnHide>
                                                    </Animations>
                                                </cc1:ValidatorCalloutExtender>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="style3" align="right">
                                                <span class="Langtxt" id="Lang_Subordinateunits"></span>&nbsp;&nbsp;
                                            </td>
                                            <td align="left">
                                                <asp:HiddenField ID="HiddenField2" runat="server" />
                                                <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="style3" align="right">
                                                <span class="Langtxt" id="Members"></span>&nbsp;&nbsp;
                                            </td>
                                            <td align="left">
                                                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                                    <ContentTemplate>
                                                        <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
                                                            <tr>
                                                                <td>
                                                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                                        <tr>
                                                                            <td width="9" background="images/tab_12.gif">&nbsp;
                                                                            </td>
                                                                            <td bgcolor="#f3ffe3">
                                                                                <asp:UpdateProgress AssociatedUpdatePanelID="UpdatePanel1" ID="UpdateProgress1" runat="server">
                                                                                    <ProgressTemplate>
                                                                                        <img src="../../Images/ProgressBar/05043123.gif" /><span class="Langtxt" id="IsInbusy"></span>....
                                                                                    </ProgressTemplate>
                                                                                </asp:UpdateProgress>
                                                                                <asp:GridView ValidationGroup="sub2" ID="GridView1" runat="server" Width="99%" AutoGenerateColumns="False"
                                                                                    DataSourceID="ObjectDataSource1" BorderWidth="0px" CellSpacing="1" BackColor="#C0DE98"
                                                                                    BorderColor="White" BorderStyle="Ridge" AllowPaging="True" AllowSorting="True"
                                                                                    CellPadding="0" GridLines="None" PageSize="5" OnRowCommand="GridView1_RowCommand"
                                                                                    OnRowDataBound="GridView1_RowDataBound">
                                                                                    <Columns>
                                                                                        <asp:TemplateField>
                                                                                            <ItemTemplate>
                                                                                                <asp:ImageButton ID="ImageButton7" CommandName="AddSM" CommandArgument='<%# Eval("StationISSI")+","+Eval("StationName")+","+Eval("SwitchID") %>'
                                                                                                    ImageUrl="../images/check_off.png" runat="server" />
                                                                                            </ItemTemplate>
                                                                                            <ItemStyle Width="20px" HorizontalAlign="Center" />
                                                                                        </asp:TemplateField>
                                                                                        <asp:BoundField DataField="StationName" SortExpression="StationName">
                                                                                            <ItemStyle HorizontalAlign="Left" />
                                                                                        </asp:BoundField>
                                                                                        <asp:BoundField DataField="StationISSI" SortExpression="StationISSI">
                                                                                            <ItemStyle HorizontalAlign="Center" Width="60px" />
                                                                                        </asp:BoundField>
                                                                                        <asp:BoundField DataField="SwitchID"  SortExpression="SwitchID"><%--xzj--20181217--添加交换--%>
                                                                                        <ItemStyle HorizontalAlign="right" Width="60px" />
                                                                                    </asp:BoundField>
                                                                                    </Columns>
                                                                                    <FooterStyle BackColor="#C6C3C6" ForeColor="Black" />
                                                                                    <HeaderStyle CssClass="gridheadcss" Font-Bold="True" />
                                                                                    <PagerStyle CssClass="PagerStyle" />
                                                                                    <RowStyle BackColor="#FFFFFF" Height="22px" ForeColor="Black" />
                                                                                    <SelectedRowStyle BackColor="#9471DE" Font-Bold="True" ForeColor="White" />
                                                                                </asp:GridView>
                                                                                <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" SortParameterName="sort"
                                                                                    SelectCountMethod="getAllBaseStationCount" SelectMethod="GetAllBaseStation" TypeName="DbComponent.BaseStationDao">
                                                                                    <SelectParameters>
                                                                                    </SelectParameters>
                                                                                </asp:ObjectDataSource>
                                                                            </td>
                                                                            <td width="9" background="images/tab_16.gif">&nbsp;
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td height="15">
                                                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                                        <tr>
                                                                            <td width="15" height="29">
                                                                                <img src="images/tab_20.gif" width="15" height="29" />
                                                                            </td>
                                                                            <td background="images/tab_21.gif">
                                                                                <asp:Label ID="Label2" runat="server" OnLoad="Label2_Load"><img src="../images/viewinfo_bg.png" /><span class="Langtxt" id="MMembersgroup" ></span>…</asp:Label>
                                                                                <asp:DropDownList ID="DropDownList5" runat="server" Height="16px" Visible="False">
                                                                                    <asp:ListItem Value="0"></asp:ListItem>
                                                                                </asp:DropDownList>
                                                                            </td>
                                                                            <td width="14">
                                                                                <img src="images/tab_22.gif" width="14" height="29" />
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </ContentTemplate>
                                                </asp:UpdatePanel>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td width="14" background="../images/tab_16.gif">&nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td width="15" background="../images/tab_12.gif">&nbsp;
                                </td>
                                <td align="center" height="30">
                                    <asp:ImageButton ValidationGroup="sub1" ID="ImageButton1" runat="server"
                                        OnClick="ImageButton1_Click" />&nbsp;&nbsp;&nbsp;
                                <img id="Lang-Cancel" src=""  style="cursor: pointer;" onclick="window.parent.mycallfunction(geturl())" />
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
                                            <td width="75%" valign="top" class="STYLE1">&nbsp;
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

<script>

    var image1 = window.document.getElementById("Lang-Cancel");
    var srouce1 = window.parent.parent.GetTextByName("Lang-Cancel", window.parent.parent.useprameters.languagedata);
    image1.setAttribute("src", srouce1);

    window.parent.closeprossdiv();

</script>
<link href="../../CSS/lq_calloutExtender.css" rel="stylesheet" type="text/css" />
