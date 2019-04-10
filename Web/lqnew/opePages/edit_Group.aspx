<%@ Page Language="C#" AutoEventWireup="true" ValidateRequest="false" CodeBehind="edit_Group.aspx.cs"
    Inherits="Web.lqnew.opePages.edit_Group" %>

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
                                    <img class="style6" style="cursor: hand;" onclick="window.parent.mycallfunction('edit_Group',258,235)"
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
                                                <div style="background-image: url(../images/add_entity_info.png); width: 119px; height: 23px;">
                                                    <div style="margin-left: 27px; font-size: 14px; font-weight: bold; color: #006633; padding-top: 5px;">
                                                        <span class="Langtxt" id="GroupInfo"></span>
                                                    </div>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="style3" align="right" style="width: 84px;">
                                                <span class="Langtxt" id="Lang-T-GroupNametext"></span>&nbsp;&nbsp;
                                            </td>
                                            <td class="style3" align="left">
                                                <asp:TextBox ID="TextBox1" runat="server" Width="120px"></asp:TextBox>
                                                <font color="red">*</font>
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
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TextBox1"
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
                                            <td class="style3" align="right" style="width: 64px;"><span class="Langtxt" id="Lang_GroupType"></span>&nbsp;&nbsp;</td>
                                            <td class="style3" align="left">
                                                <asp:Label ID="grouptype" runat="server" CssClass="style3"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="style3" align="right" style="width: 64px;">
                                                <span class="Langtxt" id="groupbz"></span>&nbsp;&nbsp;
                                            </td>
                                            <td class="style3" align="left">
                                                <asp:TextBox ID="TextBox4" ReadOnly="true" runat="server" Width="120px"></asp:TextBox>
                                                <asp:HiddenField ID="oldGSSI" runat="server" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="style3" align="right">
                                                <span id="externalSys"></span>&nbsp;&nbsp;</td>
                                            <td align="left">
                                                &nbsp;<asp:CheckBox ID="chkExternal" runat="server" /></td>
                                        </tr>
                                        <tr>
                                            <td class="style3" align="right">
                                                <span class="Langtxt" id="Subordinateunits"></span>&nbsp;&nbsp;
                                            </td>
                                            <td align="left">
                                                <asp:HiddenField ID="HiddenField1" runat="server" />
                                                <asp:HiddenField ID="HiddenField2" runat="server" />
                                                <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr style="display: none">
                                            <td class="style3" align="right">：
                                            </td>
                                            <td align="left">
                                                <asp:RadioButtonList ID="RadioButtonList1" runat="server" RepeatDirection="Horizontal">
                                                    <asp:ListItem Value="True"></asp:ListItem>
                                                    <asp:ListItem Value="False" Selected="True"></asp:ListItem>
                                                </asp:RadioButtonList>
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
                                <!---------------------------xzj--2018/6/28--将id改为id,cursor属性值改为pointer------------------>
                                <img id="Lang-Cancel"  style="cursor: pointer;" onclick="window.parent.mycallfunction('edit_Group',258,235)" />
                                <!---------------------------xzj--2018/6/28--将id改为id,cursor属性值改为pointer------------------>
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
<script type="text/javascript">
    window.parent.closeprossdiv();
    document.getElementById("externalSys").innerHTML = window.parent.GetTextByName("external_system", window.parent.useprameters.languagedata);
    //给图片添加src-----------------------------xzj--2018/6/28----------------------
    window.document.getElementById("Lang-Cancel").src = window.parent.GetTextByName('Lang-Cancel', window.parent.useprameters.languagedata);
    //给图片添加src-----------------------------xzj--2018/6/28----------------------
</script>
<link href="../../CSS/lq_calloutExtender.css" rel="stylesheet" type="text/css" />
