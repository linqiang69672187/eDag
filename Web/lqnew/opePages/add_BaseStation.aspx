<%@ Page Language="C#" AutoEventWireup="true" ValidateRequest="false" CodeBehind="add_BaseStation.aspx.cs"
    Inherits="Web.lqnew.opePages.add_BaseStation" %>

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
                                        <img src="../images/001.gif" /><span class="Langtxt" id="add"></span></li>
                                </ul>
                            </td>
                            <td width="281" background="../images/tab_05.gif" align="right">
                                <!---------------------------xzj--2018/6/28--注释原来的，新的将onclick的CloseJWD()函数去掉,cursor属性值改为pointer------------------>
                                <!--<img class="style6" style="cursor: hand;" onclick="window.parent.CloseJWD();window.parent.mycallfunction(geturl())"
                                    onmouseover="javascript:this.src='../images/close_un.png';" onmouseout="javascript:this.src='../images/close.png';"
                                    src="../images/close.png" />-->
                                <img class="style6" style="cursor: pointer;" onclick="window.parent.mycallfunction(geturl())"
                                    onmouseover="javascript:this.src='../images/close_un.png';" onmouseout="javascript:this.src='../images/close.png';"
                                    src="../images/close.png" />
                                <!---------------------------xzj--2018/6/28--注释原来的，新的将onclick的CloseJWD()函数去掉,cursor属性值改为pointer------------------>
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
                                            <div style="background-image: url(../images/add_entity_info.png); width: 109px; height: 23px;">
                                                <div style="margin-left: 41px; font-size: 14px; font-weight: bold; color: #006633;
                                                    padding-top: 5px;">
                                                    <span class="Langtxt" id="stationinformation"></span></div>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr><%--xzj--20181215--交换--%>
                                        <td class="style3" align="right" style="width: 90px;">
                                            <span class="Langtxt" id="switchID"></span>&nbsp;&nbsp;
                                        </td>
                                        <td align="left" class="style3">
                                            <asp:TextBox ID="txtSwitch" runat="server" Width="150px"></asp:TextBox><span style="color:red" class="Langtxt" id="spanSwitchHint"></span>
                                            <asp:RegularExpressionValidator id="revSwitch" ControlToValidate="txtSwitch" ValidationExpression="^25[0-5]|2[0-4]\d|1\d\d|[1-9]\d|[0-9]$" ErrorMessage="请输入正整数" Display="None" runat="server" />
                                             <cc1:ValidatorCalloutExtender ID="vceSwitch" runat="server" TargetControlID="revSwitch"
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
                                        <td class="style3" align="right" style="width: 90px;">
                                            <span class="Langtxt" id="StationName"></span>&nbsp;&nbsp;
                                        </td>
                                        <td align="left" class="style3">
                                            <asp:TextBox ID="txtBaseStation" runat="server" Width="150px"></asp:TextBox><font
                                                color="red">*</font>
                                                 <asp:RegularExpressionValidator ID="validateEntityLength" runat="server" Display="None"
                                                ControlToValidate="txtBaseStation" ></asp:RegularExpressionValidator>
                                                <cc1:ValidatorCalloutExtender ID="ValidatorCalloutExtender2" runat="server" TargetControlID="validateEntityLength"
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
                                            <asp:RequiredFieldValidator ID="rfvBaseStationName" runat="server" ControlToValidate="txtBaseStation"
                                                Display="None"></asp:RequiredFieldValidator>
                                            <cc1:ValidatorCalloutExtender ID="Validatorcalloutextender3" runat="server" TargetControlID="rfvBaseStationName"
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
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="style3" align="right" style="width: 90px;">
                                            <span class="Langtxt" id="BaseStationIdentification"></span>&nbsp;&nbsp;
                                        </td>
                                        <td align="left" class="style3">
                                            <asp:TextBox ID="txtBaseISSI" runat="server" Width="150px"></asp:TextBox><font color="red">*</font><span class="Langtxt" id="arrang"></span>1~1280
                                            <asp:RangeValidator ID="BSNValidator" runat="server" ControlToValidate="txtBaseISSI" Type="Integer" MaximumValue="1280" MinimumValue="1" Display="None" ></asp:RangeValidator>
                                            <cc1:ValidatorCalloutExtender ID="Validatorcalloutextender5" runat="server" TargetControlID="BSNValidator"
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
                                            <asp:RequiredFieldValidator ID="rfvBaseStationISSI" runat="server" ControlToValidate="txtBaseISSI"
                                                Display="None"></asp:RequiredFieldValidator>
                                            <cc1:ValidatorCalloutExtender ID="Validatorcalloutextender4" runat="server" TargetControlID="rfvBaseStationISSI"
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
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="style3" align="right" style="width: 90px;">
                                           <span class="Langtxt" id="UnderGroundBS"></span>&nbsp;&nbsp;
                                        </td>
                                        <td align="left" class="style3">
                                            <asp:RadioButtonList ID="radIsUnderGround" RepeatDirection="Horizontal" runat="server">
                                                <asp:ListItem Value="1">是</asp:ListItem>
                                                <asp:ListItem Value="0">否</asp:ListItem>
                                            </asp:RadioButtonList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="style3" align="right">
                                            <span class="Langtxt" id="GetJWD"></span>&nbsp;&nbsp;
                                        </td>
                                        <td align="left">
                                            <div onclick="window.parent.GetJWD()"> 
                                                <!--------------------------xzj--2018/6/29-------------将cursor属性值改为pointer-->
                                                <span class="Langtxt" id="Lang-Click"></span> <font id="Lang_Get" class="Langtxt" style="cursor: pointer" color="blue"></font><span class="Langtxt" id="Lang_Sit"></span></div>
                                                <!--------------------------xzj--2018/6/29-------------将cursor属性值改为pointer-->
                                            <div id="divstatue">
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="style3" align="right" style="width: 90px;">
                                            <span class="Langtxt" id="jzjd"></span>&nbsp;&nbsp;
                                        </td>
                                        <td align="left" class="style3">
                                            <asp:TextBox ID="txtLo" runat="server"  Width="150px"></asp:TextBox><font color="red">*</font>
                                             <asp:RangeValidator ID="rbtxtLo" ControlToValidate="txtLo" runat="server" Type="Double" MaximumValue=180 MinimumValue=-180 Display="None"></asp:RangeValidator>
                                            <cc1:ValidatorCalloutExtender ID="Validatorcalloutextender8" runat="server" TargetControlID="rbtxtLo"
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
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtLo"
                                                Display="None"></asp:RequiredFieldValidator>
                                            <cc1:ValidatorCalloutExtender ID="Validatorcalloutextender6" runat="server" TargetControlID="RequiredFieldValidator1"
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
                                            
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="style3" align="right" style="width: 90px;">
                                            <span class="Langtxt" id="jzwd"></span>&nbsp;&nbsp;
                                        </td>
                                        <td align="left" class="style3">
                                            <asp:TextBox ID="txtLa" runat="server"  Width="150px"></asp:TextBox><font color="red">*</font>
                                             <asp:RangeValidator ID="RangeValidator1" ControlToValidate="txtLa" runat="server" Type="Double" MaximumValue=90 MinimumValue=-90 Display="None"></asp:RangeValidator>
                                            <cc1:ValidatorCalloutExtender ID="Validatorcalloutextender9" runat="server" TargetControlID="RangeValidator1"
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
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtLa"
                                                Display="None"></asp:RequiredFieldValidator>
                                            <cc1:ValidatorCalloutExtender ID="Validatorcalloutextender7" runat="server" TargetControlID="RequiredFieldValidator2"
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
                                <!---------------------------xzj--2018/6/28--注释原来的，新的将imgid改为id,cursor属性值改为pointer,去掉onclick中CloseJWD()函数------------------>
                                <!--<img  style="cursor: hand;" onclick="window.parent.CloseJWD();window.parent.mycallfunction(geturl())"
                                    imgid="Lang-Cancel" />-->
                                <img  style="cursor: pointer;" onclick="window.parent.mycallfunction(geturl())"
                                    id="Lang-Cancel" />
                                <!---------------------------xzj--2018/6/28--注释原来的，新的将imgid改为id,cursor属性值改为pointer,去掉onclick中CloseJWD()函数------------------>
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
<link href="../../CSS/lq_calloutExtender.css" rel="stylesheet" type="text/css" />
<script>    window.parent.closeprossdiv();
    //给图片添加src-----------------------------xzj--2018/6/28----------------------
    window.document.getElementById("Lang-Cancel").src = window.parent.GetTextByName('Lang-Cancel', window.parent.useprameters.languagedata);
    //给图片添加src-----------------------------xzj--2018/6/28----------------------
</script>
