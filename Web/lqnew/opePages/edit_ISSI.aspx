<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="edit_ISSI.aspx.cs" Inherits="Web.lqnew.opePages.edit_ISSI" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link href="../css/lq_addedit.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/pagestyle.css" rel="stylesheet" type="text/css" />
    <script src="../js/geturl.js" type="text/javascript"></script>
    <script src="../js/dragwindow.js" type="text/javascript"></script>
    <script src="../../JQuery/jquery-1.5.2.js"></script>
    <script src="../../LangJS/managerGroup_langjs.js"></script>
    <script src="/lqnew/js/CommValidator.js" type="text/javascript"></script>
    <script type="text/javascript">
        //提交验证
        function checkTellRule() {
            var result = true;
            //验证厂家与型号
            if (getByteLen($("#txtFactury").val()) > 30) {
                $("#yzFactury").html(window.parent.GetTextByName("FactoryStrLenthLimit30", window.parent.useprameters.languagedata));
                $("#yzFactury").show();
                result = false;
            }
            else {
                $("#yzFactury").hide();
            }
            if (getByteLen($("#txtModel").val()) > 15) {
                $("#yzModel").html(window.parent.GetTextByName("ModeLenthLimit15", window.parent.useprameters.languagedata));
                $("#yzModel").show();
                result = false;
            }
            else {
                $("#yzModel").hide();
            }

            return result;
        }

    </script>
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
                                    <img class="style6" style="cursor: hand;" onclick="window.parent.mycallfunction('edit_ISSI')"
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
                                                <div style="background-image: url(../images/add_entity_info.png); width: 132px; height: 23px;">
                                                    <div style="margin-left: 28px; font-size: 14px; font-weight: bold; color: #006633; padding-top: 5px;">
                                                        <span class="Langtxt" id="Terminalinformation"></span>
                                                    </div>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="style3" align="right" style="width: 60px;">
                                                <span class="Langtxt" id="Lang_terminal_identification"></span>&nbsp;&nbsp;
                                            </td>
                                            <td class="style3" align="left">
                                                <asp:TextBox ID="TextBox1" ReadOnly="true" runat="server" Width="120px"></asp:TextBox>
                                                <font color="red">*</font><span class="Langtxt" id="Lang_ISSSIdRange2"></span>
                                                <asp:RangeValidator ID="rvTxtISSI" runat="server" ControlToValidate="TextBox1" MinimumValue="1" MaximumValue="9999999999999999" Type="Double" Display="None"></asp:RangeValidator>
                                                
                                                <cc1:ValidatorCalloutExtender ID="ValidatorCalloutExtender2" runat="server" TargetControlID="rvTxtISSI"
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

                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TextBox1" ErrorMessage="<b>终端号码不能为空</b>" Display="None"></asp:RequiredFieldValidator>
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
                                                <asp:CustomValidator ID="CustomValidator1" runat="server" ControlToValidate="TextBox1"
                                                    Display="None" OnServerValidate="CustomValidator1_ServerValidate"></asp:CustomValidator>
                                                <cc1:ValidatorCalloutExtender ID="Validatorcalloutextender1" runat="server" TargetControlID="CustomValidator1"
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
                                                <span class="Langtxt" id="Lang_TerminalType"></span>&nbsp;&nbsp;
                                            </td>
                                            <td align="left" class="style3">
                                                <asp:HiddenField ID="HiddenField_TerminalTypeKey" runat="server" />
                                                <asp:Label ID="Label_TerminalType" runat="server"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr id="tr_ipAddress" style="display:none">
                                            <td class="style3" align="right">
                                                <span class="Langtxt" id="Lang_ipAddress"></span>&nbsp;&nbsp;
                                            </td>
                                            <td align="left" class="style3">
                                                <asp:Label ID="Label_ipAddress" runat="server"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="style3" align="right">
                                                <span class="Langtxt" id="Subordinateunits"></span>&nbsp;&nbsp;
                                            </td>
                                            <td align="left" class="style3">
                                                <asp:Label ID="Label1" runat="server"></asp:Label>
                                                &nbsp;&nbsp;&nbsp;&nbsp;<asp:CheckBox ID="chkIsExternal" runat="server" Text="外系统" />
                                            </td>
                                        </tr>
                                       <tr>
                                             <td class="auto-style2" align="right">
                                                <span class="Langtxt" id="Lang_factory">厂家：</span>&nbsp;&nbsp;
                                            <%--厂家：--%>
                                            </td>
                                            <td class="style3" align="left">
                                                <input type="text" id="txtFactury" runat="server" Width="120px"/>
                                                <span id="yzFactury" style="display:none;color:red;" >DDD</span>                                
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="auto-style2" align="right">
                                                <span class="Langtxt" id="Lang_mobilemode">型号：</span>&nbsp;&nbsp;
                                            <%--型号：--%>
                                            </td>
                                            <td class="style3" align="left">
                                                <input type="text" id="txtModel" runat="server" Width="120px"/>
                                                <span id="yzModel" style="display:none;color:red;" >DDD</span>                                
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="style3" align="right">
                                                <span class="Langtxt" id="Remark"></span>&nbsp;&nbsp;
                                            </td>
                                            <td align="left">
                                                <asp:TextBox ID="txtBZ" runat="server" Width="190px" TextMode="MultiLine"></asp:TextBox>
                                                <asp:RegularExpressionValidator ID="ValidatorBZ" runat="server" Display="None"
                                                    ControlToValidate="txtBZ"></asp:RegularExpressionValidator>
                                                <cc1:ValidatorCalloutExtender ID="ValidatorCalloutExtender3" runat="server" TargetControlID="ValidatorBZ"
                                                    Width="150px" HighlightCssClass="cssValidatorCalloutHighlight">
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
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="style3" align="right">
                                                <span class="Langtxt" id="Lang_zhuliuzu"></span>&nbsp;&nbsp;
                                            </td>
                                            <td align="left">
                                                <asp:DropDownList ID="DropDownList2" AppendDataBoundItems="true" runat="server">
                                                    <asp:ListItem Selected="True" Value="0"></asp:ListItem>
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="style3" valign="top" align="right">
                                                <span class="Langtxt" id="Lang_saomiaozu"></span>&nbsp;&nbsp;
                                            </td>
                                            <td align="left">
                                                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                                    <ContentTemplate>
                                                        <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
                                                            <tr>
                                                                <td height="30">
                                                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                                        <tr>
                                                                            <td width="15" height="30">
                                                                                <img src="images/tab_03.gif" width="15" height="30" />
                                                                            </td>
                                                                            <td background="images/tab_05.gif">
                                                                                <ul class="hor_ul">
                                                                                    <li>
                                                                                        <asp:DropDownList ID="DropDownList3" runat="server" AppendDataBoundItems="True" DataSourceID="ObjectDataSource3"
                                                                                            DataTextField="name" DataValueField="id">
                                                                                            <asp:ListItem Value="0"></asp:ListItem>
                                                                                        </asp:DropDownList>
                                                                                        <asp:ObjectDataSource ID="ObjectDataSource3" runat="server" SelectMethod="GetAllEntityInfo"
                                                                                            TypeName="DbComponent.Entity">
                                                                                            <SelectParameters>
                                                                                                <asp:CookieParameter CookieName="id" Name="id" Type="Int32" />
                                                                                            </SelectParameters>
                                                                                        </asp:ObjectDataSource>
                                                                                    </li>
                                                                                    <li>
                                                                                        <asp:DropDownList ID="DropDownList4" runat="server">
                                                                                            <asp:ListItem Value="Group_name"></asp:ListItem>
                                                                                            <asp:ListItem Value="GSSI"></asp:ListItem>
                                                                                        </asp:DropDownList>
                                                                                    </li>
                                                                                    <li>
                                                                                        <asp:TextBox ID="TextBox2" runat="server" Width="65px"></asp:TextBox></li>
                                                                                    <li>
                                                                                        <asp:ImageButton ID="ImageButton6" runat="server" OnClick="ImageButton6_Click" onmouseover="javascript:this.src=window.parent.GetTextByName('Lang_Search_un',window.parent.useprameters.languagedata);" onmouseout="javascript:this.src=window.parent.GetTextByName('Lang_Search',window.parent.useprameters.languagedata);"/></li>
                                                                                </ul>
                                                                            </td>
                                                                            <td width="14">
                                                                                <img src="images/tab_07.gif" width="14" height="30" />
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                                        <tr>
                                                                            <td width="9" background="images/tab_12.gif">&nbsp;
                                                                            </td>
                                                                            <td bgcolor="#f3ffe3">
                                                                                <asp:UpdateProgress AssociatedUpdatePanelID="UpdatePanel1" ID="UpdateProgress1" runat="server">
                                                                                    <ProgressTemplate>
                                                                                        <img src="../../Images/ProgressBar/05043123.gif" />
                                                                                        <span class="Langtxt" id="Lang_UnderOperate"></span>....
                                                                                    </ProgressTemplate>
                                                                                </asp:UpdateProgress>
                                                                                <asp:GridView ID="GridView1" runat="server" Width="99%" AutoGenerateColumns="False"
                                                                                    DataSourceID="ObjectDataSource1" BorderWidth="0px" CellSpacing="1" BackColor="#C0DE98"
                                                                                    BorderColor="White" BorderStyle="Ridge" AllowPaging="True" AllowSorting="True"
                                                                                    CellPadding="0" GridLines="None" PageSize="5" OnRowCommand="GridView1_RowCommand"
                                                                                    OnRowDataBound="GridView1_RowDataBound">
                                                                                    <Columns>
                                                                                        <asp:TemplateField>
                                                                                            <ItemTemplate>
                                                                                                <asp:ImageButton ID="ImageButton7" CommandName="AddSM" CommandArgument='<%# Eval("GSSI")+","+Eval("Group_name") %>'
                                                                                                    ImageUrl="../images/check_off.png" runat="server" />
                                                                                            </ItemTemplate>
                                                                                            <ItemStyle Width="20px" HorizontalAlign="Center" />
                                                                                        </asp:TemplateField>
                                                                                        <asp:BoundField DataField="Group_name" SortExpression="Group_name">
                                                                                            <ItemStyle HorizontalAlign="Left" />
                                                                                        </asp:BoundField>
                                                                                        <asp:BoundField DataField="GSSI" SortExpression="GSSI">
                                                                                            <ItemStyle HorizontalAlign="Center" Width="60px" />
                                                                                        </asp:BoundField>
                                                                                    </Columns>
                                                                                    <FooterStyle BackColor="#C6C3C6" ForeColor="Black" />
                                                                                    <HeaderStyle CssClass="gridheadcss" Font-Bold="True" />
                                                                                    <PagerStyle CssClass="PagerStyle" />
                                                                                    <RowStyle BackColor="#FFFFFF" Height="22px" ForeColor="Black" />
                                                                                    <SelectedRowStyle BackColor="#9471DE" Font-Bold="True" ForeColor="White" />
                                                                                </asp:GridView>
                                                                                <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" SortParameterName="sort"
                                                                                    SelectCountMethod="AllGroupInfocount" SelectMethod="AllGroupInfo" TypeName="DbComponent.group">
                                                                                    <SelectParameters>
                                                                                        <asp:Parameter DefaultValue="0" Name="grouptype" Type="Int32" />
                                                                                        <asp:ControlParameter ControlID="DropDownList3" Name="Entity_ID" PropertyName="SelectedValue" />
                                                                                        <asp:ControlParameter ControlID="DropDownList4" Name="selectcondition" PropertyName="SelectedValue" />
                                                                                        <asp:ControlParameter ControlID="TextBox2" Name="textseach" PropertyName="Text" />
                                                                                        <asp:CookieParameter CookieName="id" Name="id" Type="Int32" />
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
                                                                                <asp:Label ID="Label2" Visible="true" runat="server" OnLoad="Label2_Load"><img src="../images/viewinfo_bg.png" /><span class="Langtxt" id="Lang_saomiaozuBelong" ></span>…</asp:Label>
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
                                        <tr>
                                            <td class="style3" valign="top" align="right">
                                                <span class="Langtxt" id="Lang_multicastgroupBelong"></span>&nbsp;&nbsp;
                                            </td>
                                            <td align="left">
                                                <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                                    <ContentTemplate>
                                                        <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
                                                            <tr>
                                                                <td height="30">
                                                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                                        <tr>
                                                                            <td width="15" height="30">
                                                                                <img src="images/tab_03.gif" width="15" height="30" />
                                                                            </td>
                                                                            <td background="images/tab_05.gif">
                                                                                <ul class="hor_ul">
                                                                                    <li>
                                                                                        <asp:DropDownList ID="DropDownList6" runat="server" AppendDataBoundItems="True" DataSourceID="ObjectDataSource3"
                                                                                            DataTextField="name" DataValueField="id">
                                                                                            <asp:ListItem Value="0"></asp:ListItem>
                                                                                        </asp:DropDownList>
                                                                                    </li>
                                                                                    <li>
                                                                                        <asp:DropDownList ID="DropDownList7" runat="server">
                                                                                            <asp:ListItem Value="Group_name"></asp:ListItem>
                                                                                            <asp:ListItem Value="GSSI"></asp:ListItem>
                                                                                        </asp:DropDownList>
                                                                                    </li>
                                                                                    <li>
                                                                                        <asp:TextBox ID="TextBox3" runat="server" Width="65px"></asp:TextBox></li>
                                                                                    <li>
                                                                                        <asp:ImageButton ID="ImageButton8" runat="server" OnClick="ImageButton8_Click" onmouseover="javascript:this.src=window.parent.GetTextByName('Lang_Search_un',window.parent.useprameters.languagedata);" onmouseout="javascript:this.src=window.parent.GetTextByName('Lang_Search',window.parent.useprameters.languagedata);"/></li>
                                                                                </ul>
                                                                            </td>
                                                                            <td width="14">
                                                                                <img src="images/tab_07.gif" width="14" height="30" />
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                                        <tr>
                                                                            <td width="9" background="images/tab_12.gif">&nbsp;
                                                                            </td>
                                                                            <td bgcolor="#f3ffe3">
                                                                                <asp:UpdateProgress AssociatedUpdatePanelID="UpdatePanel2" ID="UpdateProgress2" runat="server">
                                                                                    <ProgressTemplate>
                                                                                        <img src="../../Images/ProgressBar/05043123.gif" /><span id="Lang_UnderOperate0" class="Langtxt"></span>....
                                                                                    </ProgressTemplate>
                                                                                </asp:UpdateProgress>
                                                                                <asp:GridView ID="GridView2" runat="server" Width="99%" AutoGenerateColumns="False"
                                                                                    DataSourceID="ObjectDataSource5" BorderWidth="0px" CellSpacing="1" BackColor="#C0DE98"
                                                                                    BorderColor="White" BorderStyle="Ridge" AllowPaging="True" AllowSorting="True"
                                                                                    CellPadding="0" GridLines="None" PageSize="5" OnRowCommand="GridView2_RowCommand"
                                                                                    OnRowDataBound="GridView2_RowDataBound">
                                                                                    <Columns>
                                                                                        <asp:TemplateField>
                                                                                            <ItemTemplate>
                                                                                                <asp:ImageButton ID="ImageButton9" CommandName="AddSM" CommandArgument='<%# Eval("GSSI")+","+Eval("Group_name") %>'
                                                                                                    ImageUrl="../images/check_off.png" runat="server" />
                                                                                            </ItemTemplate>
                                                                                            <ItemStyle Width="20px" HorizontalAlign="Center" />
                                                                                        </asp:TemplateField>
                                                                                        <asp:BoundField DataField="Group_name" SortExpression="Group_name">
                                                                                            <ItemStyle HorizontalAlign="Left" />
                                                                                        </asp:BoundField>
                                                                                        <asp:BoundField DataField="GSSI" HeaderText="GSSI" SortExpression="GSSI">
                                                                                            <ItemStyle HorizontalAlign="Center" Width="60px" />
                                                                                        </asp:BoundField>
                                                                                    </Columns>
                                                                                    <FooterStyle BackColor="#C6C3C6" ForeColor="Black" />
                                                                                    <HeaderStyle CssClass="gridheadcss" Font-Bold="True" />
                                                                                    <PagerStyle CssClass="PagerStyle" />
                                                                                    <RowStyle BackColor="#FFFFFF" Height="22px" ForeColor="Black" />
                                                                                    <SelectedRowStyle BackColor="#9471DE" Font-Bold="True" ForeColor="White" />
                                                                                </asp:GridView>
                                                                                <asp:ObjectDataSource ID="ObjectDataSource5" runat="server" EnablePaging="true" SortParameterName="sort"
                                                                                    SelectCountMethod="AllGroupInfocount" SelectMethod="AllGroupInfo" TypeName="DbComponent.group">
                                                                                    <SelectParameters>
                                                                                        <asp:Parameter DefaultValue="1" Name="grouptype" Type="Int32" />
                                                                                        <asp:ControlParameter ControlID="DropDownList6" Name="Entity_ID" PropertyName="SelectedValue" />
                                                                                        <asp:ControlParameter ControlID="DropDownList7" Name="selectcondition" PropertyName="SelectedValue" />
                                                                                        <asp:ControlParameter ControlID="TextBox3" Name="textseach" PropertyName="Text" />
                                                                                        <asp:CookieParameter CookieName="id" Name="id" Type="Int32" />
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
                                                                                <asp:Label ID="Label3" Visible="true" runat="server" OnLoad="Label3_Load"><img 
                src="../images/viewinfo_bg.png" /><span class="Langtxt" id="Lang_multicastgroup" ></span>…</asp:Label>
                                                                                <asp:DropDownList ID="DropDownList8" runat="server" Height="16px" Visible="False">
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
                                    <asp:ImageButton ID="ImageButton1" runat="server"
                                        OnClick="ImageButton1_Click" OnClientClick="return checkTellRule();" />&nbsp;&nbsp;&nbsp;
                                <img id="cancel" runat="server"  style="cursor: pointer;" onclick="window.parent.mycallfunction('edit_ISSI')" />
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

    window.parent.closeprossdiv();
    var image1 = window.document.getElementById("cancel");
    var srouce1 = window.parent.parent.GetTextByName("Lang-Cancel", window.parent.parent.useprameters.languagedata);
    image1.setAttribute("src", srouce1);

</script>
<link href="../../CSS/lq_calloutExtender.css" rel="stylesheet" type="text/css" />
