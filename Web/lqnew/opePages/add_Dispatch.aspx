<%@ Page Language="C#" AutoEventWireup="true"  ValidateRequest="false" CodeBehind="add_Dispatch.aspx.cs" Inherits="Web.lqnew.opePages.add_Dispatch" %>

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
    <style type="text/css">
        .style6 td
        {
            background-color: transparent;
        }
        .auto-style1 {
            height: 22px;
            width: 100px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
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
                                        <img src="../images/001.gif" /><span class="Langtxt" id="Lang-Add" ></span></li>
                                </ul>
                            </td>
                            <td width="281" background="../images/tab_05.gif" align="right">
                                <img style="cursor: hand;" onclick="window.parent.mycallfunction('add_Dispatch')"
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
                            <td width="15" background="../images/tab_12.gif">
                                &nbsp;
                            </td>
                            <td align="center"  id="dragtd">
                                <table class="style1" cellspacing="1">
                                    <tr>
                                        <td colspan="2" align="left" style="background-image: url(../images/add_entity_infobg.png);
                                            height: 33;">
                                            <div style="background-image: url(../images/add_entity_info.png); width: 130px; height: 23px;">
                                                <div style="margin-left: 28px; font-size: 14px; font-weight: bold; color: #006633;
                                                    padding-top: 5px;">
                                                    <span class="Langtxt" id="Schedulinginformation" ></span>
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="auto-style1" align="right">
                                            <span class="Langtxt" id="Schedulinguseid" ></span>&nbsp;&nbsp;
                                        </td>
                                        <td class="style3" align="left">
                                            <asp:TextBox ID="TextBox1" runat="server" Width="120px"></asp:TextBox>
                                            <font color="red">*</font><span class="Langtxt" id="Lang_ISSSIdRange"></span>
                                            <asp:RequiredFieldValidator ID="rfvBaseStationName" runat="server" ControlToValidate="TextBox1"
                                               Display="None"></asp:RequiredFieldValidator>
                                            <cc1:ValidatorCalloutExtender ID="Validatorcalloutextender5" runat="server" TargetControlID="rfvBaseStationName"
                                                Width="150" HighlightCssClass="cssValidatorCalloutHighlight">
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
                                            <asp:RangeValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TextBox1"
                                                Type="Integer" MaximumValue="80699999" MinimumValue="1" Display="None"></asp:RangeValidator>
                                            <cc1:ValidatorCalloutExtender ID="vceTxtName" runat="server" TargetControlID="RequiredFieldValidator1"
                                                Width="180px" HighlightCssClass="cssValidatorCalloutHighlight">
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
                                    <tr style="display:none">
                                        <td class="style3" align="right">
                                            <span class="Langtxt" id="Lang_Subordinateunits" ></span>&nbsp;&nbsp;
                                        </td>
                                        <td align="left" class="style3">
                                            <asp:DropDownList ID="DropDownList1" Width="120px" runat="server" AppendDataBoundItems="True" DataSourceID="ObjectDataSource2"
                                                DataTextField="name" DataValueField="id">
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
                                            <span class="Langtxt" id="IPaddress" ></span>&nbsp;&nbsp;
                                        </td>
                                        <td align="left">
                                            <asp:TextBox ID="txtIpAddress" runat="server" Width="120px"></asp:TextBox>
                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtIpAddress"
                                                ValidationExpression="^(0|[1-9]\d?|[0-1]\d{2}|2[0-4]\d|25[0-5])\.(0|[1-9]\d?|[0-1]\d{2}|2[0-4]\d|25[0-5])\.(0|[1-9]\d?|[0-1]\d{2}|2[0-4]\d|25[0-5])\.(0|[1-9]\d?|[0-1]\d{2}|2[0-4]\d|25[0-5])$"
                                                Display="None"></asp:RegularExpressionValidator>
                                            <cc1:ValidatorCalloutExtender ID="Validatorcalloutextender2" runat="server" TargetControlID="RegularExpressionValidator1"
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
                                </table>
                            </td>
                            <td width="14" background="../images/tab_16.gif">
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td width="15" background="../images/tab_12.gif">
                                &nbsp;
                            </td>
                            <td align="center" height="30">
                                <asp:ImageButton ID="ImageButton1" runat="server"
                                    OnClick="ImageButton1_Click" />&nbsp;&nbsp;&nbsp;
                                <!---------------------------xzj--2018/6/28--将imgid改为id,cursor属性值改为pointer------------------>
                                <img id="Lang-Cancel" style="cursor: pointer;" onclick="window.parent.mycallfunction('add_Dispatch')" />
                                <!---------------------------xzj--2018/6/28--将imgid改为id,cursor属性值改为pointer------------------>
                            </td>
                            <td width="14" background="../images/tab_16.gif">
                                &nbsp;
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
                                        <td width="25%" nowrap="nowrap">
                                            &nbsp;
                                        </td>
                                        <td width="75%" valign="top" class="STYLE1">
                                            &nbsp;
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
    //给图片添加src-----------------------------xzj--2018/6/28----------------------
    window.document.getElementById("Lang-Cancel").src = window.parent.GetTextByName('Lang-Cancel', window.parent.useprameters.languagedata);
    //给图片添加src-----------------------------xzj--2018/6/28----------------------
</script>
<link href="../../CSS/lq_calloutExtender.css" rel="stylesheet" type="text/css" />
