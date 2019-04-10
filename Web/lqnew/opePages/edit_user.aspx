<%@ Page Language="C#" AutoEventWireup="true" ValidateRequest="false" CodeBehind="edit_user.aspx.cs"
    Inherits="Web.lqnew.opePages.edit_user" %>


<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link href="../css/lq_addedit.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/pagestyle.css" rel="stylesheet" type="text/css" />
    <script src="../js/geturl.js" type="text/javascript"></script>
    <script src="../js/dragwindow.js" type="text/javascript"></script>
    <%--    <script src="../js/manageStopSelectSubmit.js" type="text/javascript"></script>--%>
    <script src="../../JQuery/jquery-1.5.2.js"></script>
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
                                                <div style="background-image: url(../images/add_entity_info.png); width: 120px; height: 23px;">
                                                    <div style="margin-left: 28px; font-size: 14px; font-weight: bold; color: #006633; padding-top: 5px;">
                                                        <span class="Langtxt" id="yidongyonghu"></span>
                                                    </div>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="style3" align="right" style="width: 95px;">
                                                <span class="Langtxt" id="Type"></span>&nbsp;&nbsp;
                                            </td>
                                            <td class="style3" align="left">
                                                <asp:DropDownList ID="DropDownList2" runat="server" Width="120px">
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="style3" align="right">
                                                <span class="Langtxt" id="Subordinateunits"></span>&nbsp;&nbsp;
                                            </td>
                                            <td align="left" class="style3">
                                                <asp:DropDownList ID="DropDownList1" runat="server" Width="120px" AppendDataBoundItems="True"
                                                    DataSourceID="ObjectDataSource2" DataTextField="name" DataValueField="id">
                                                </asp:DropDownList>
                                                <asp:ObjectDataSource ID="ObjectDataSource2" runat="server" SelectMethod="GetAllEntityInfo"
                                                    TypeName="DbComponent.Entity">
                                                    <SelectParameters>
                                                        <asp:CookieParameter CookieName="id" Name="id" Type="Int32" />
                                                    </SelectParameters>
                                                </asp:ObjectDataSource>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="style3" align="right">
                                                <span class="Langtxt" id="Name"></span>&nbsp;&nbsp;
                                            </td>
                                            <td align="left">
                                                <asp:TextBox ID="TextBox1" runat="server" Width="120px"></asp:TextBox><font color="red">*</font>
                                                <asp:RegularExpressionValidator ID="validateEntityLength" runat="server" Display="None"
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
                                                <asp:RequiredFieldValidator ControlToValidate="TextBox1" ID="RequiredFieldValidator1"
                                                    runat="server" Display="None"></asp:RequiredFieldValidator>
                                                <cc1:ValidatorCalloutExtender ID="Validatorcalloutextender1" runat="server" TargetControlID="RequiredFieldValidator1"
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
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="style3" align="right">
                                                <span class="Langtxt" id="Serialnumber"></span>&nbsp;&nbsp;
                                            </td>
                                            <td align="left">
                                                <asp:TextBox ID="TextBox2" runat="server" Width="120px"></asp:TextBox>
                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" Display="None" ControlToValidate="TextBox2"></asp:RegularExpressionValidator>
                                                <cc1:ValidatorCalloutExtender ID="ValidatorCalloutExtender4" runat="server" TargetControlID="RegularExpressionValidator1"
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
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="style3" align="right">
                                                <span class="Langtxt" id="syzdbs"></span>&nbsp;&nbsp;
                                            </td>
                                            <td align="left">
                                                <asp:TextBox ID="TextBox4" runat="server" Width="120px"></asp:TextBox>
                                                <cc1:AutoCompleteExtender ID="okw_AutoCompleteExtender" runat="server" DelimiterCharacters=""
                                                    Enabled="True" ServicePath="../webservice/autocomplete_txt.asmx" TargetControlID="TextBox4"
                                                    ServiceMethod="GetData" MinimumPrefixLength="1">
                                                </cc1:AutoCompleteExtender>
                                                <asp:CustomValidator ID="CustomValidator1" runat="server" ControlToValidate="TextBox4"
                                                    Display="None" OnServerValidate="CustomValidator1_ServerValidate"></asp:CustomValidator>
                                                <cc1:ValidatorCalloutExtender ID="Validatorcalloutextender3" runat="server" TargetControlID="CustomValidator1"
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
                                            <span class="Langtxt" id="Lang_telephone" >手机</span>&nbsp;&nbsp;
                                        </td>
                                        <td align="left">
                                            <asp:TextBox ID="txtMobile" runat="server" Width="120px"></asp:TextBox>
                                         <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" Display="None"  ControlToValidate="txtMobile" ></asp:RegularExpressionValidator>
                                                <cc1:ValidatorCalloutExtender ID="ValidatorCalloutExtender6" runat="server" TargetControlID="RegularExpressionValidator2"
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
                                        </td>
                                    </tr>
                                    <tr>
                                       <td class="style3" align="right">
                                            <span class="Langtxt" id="Lang_position" >职务</span>&nbsp;&nbsp;
                                        </td>
                                        <td align="left">
                                            <asp:TextBox ID="txtPosition" runat="server" Width="120px"></asp:TextBox>
                                         <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" Display="None"  ControlToValidate="txtPosition" ></asp:RegularExpressionValidator>
                                                <cc1:ValidatorCalloutExtender ID="ValidatorCalloutExtender7" runat="server" TargetControlID="RegularExpressionValidator3"
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
                                        </td>
                                    </tr>
                                        <tr style="display: none">
                                            <td class="style3" align="right">
                                                <span class="Langtxt" id="Lang_realTimeDisplay"></span>&nbsp;&nbsp;
                                            </td>
                                            <td align="left">
                                                <asp:RadioButtonList ID="RadioButtonList1" runat="server" RepeatDirection="Horizontal">
                                                    <asp:ListItem Selected="True" Value="True"><span class="Langtxt" id="Lang_Yes"></span></asp:ListItem>
                                                    <asp:ListItem Value="False"><span class="Langtxt" id="Lang_No"></span></asp:ListItem>
                                                </asp:RadioButtonList>
                                                <asp:HiddenField ID="oldissi" runat="server" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="style3" align="right">
                                                <span class="Langtxt" id="Remark"></span>&nbsp;&nbsp;
                                            </td>
                                            <td align="left">

                                                <asp:TextBox runat="server" ID="txtBZ" Width="200px" Height="90px" TextMode="MultiLine"></asp:TextBox>
                                                <asp:RegularExpressionValidator ID="ValidatorBZ" runat="server" Display="None"
                                                    ControlToValidate="txtBZ"></asp:RegularExpressionValidator>
                                                <cc1:ValidatorCalloutExtender ID="ValidatorCalloutExtender5" runat="server" TargetControlID="ValidatorBZ"
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
                                        OnClick="ImageButton1_Click" />&nbsp;&nbsp;&nbsp;
                                <img style="cursor: pointer;" onclick="window.parent.mycallfunction(geturl())"
                                    id="cancel" runat="server" />
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
