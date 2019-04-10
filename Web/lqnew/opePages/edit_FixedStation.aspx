<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="edit_FixedStation.aspx.cs" Inherits="Web.lqnew.opePages.edit_FixedStation" %>

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
        .auto-style1
        {
            height: 22px;
            width: 100px;
        }
    </style>
    <script type="text/javascript">
        function getlola() {
            window.parent.GetJWD();
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
        <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" SelectMethod="GetAllEntityInfo" TypeName="DbComponent.Entity">
            <SelectParameters>
                <asp:CookieParameter CookieName="id" Name="id" Type="Int32" />
            </SelectParameters>
        </asp:ObjectDataSource>
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
                                <img class="style6" style="cursor: hand;" onclick="window.parent.CloseJWD();window.parent.mycallfunction(geturl())"
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
                            <td align="center">
                                <table class="style1" cellspacing="1" id="dragtd">
                                    <tr>
                                        <td colspan="2" align="left" style="background-image: url(../images/add_entity_infobg.png);
                                            height: 33;">
                                            <div style="background-image: url('../images/add_entity_info.png'); width: 124px; height: 23px;">
                                                <div style="margin-left: 27px; font-size: 14px; font-weight: bold; color: #006633;
                                                    padding-top: 5px;">
                                                    <span class="Langtxt" id="GDTXX"></span></div>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="style3" align="right" style="width: 100px;">
                                            <span class="Langtxt" id="GDTBZ"></span>：
                                        </td>
                                        <td align="left" class="style3">
                                            <asp:TextBox ID="txtFSISSI" runat="server" Width="150px"></asp:TextBox>
                                                 <font color="red">*</font>   
                                                 <asp:RangeValidator ID="RVFSISSI" runat="server" ControlToValidate="txtFSISSI" MaximumValue="99999999999999" MinimumValue="0"></asp:RangeValidator>
                    
                                                <asp:RequiredFieldValidator ID="rfvFSISSI" runat="server" ControlToValidate="txtFSISSI" Display="None"></asp:RequiredFieldValidator>
                                            <cc1:ValidatorCalloutExtender ID="Validatorcalloutextender3" runat="server" TargetControlID="rfvFSISSI" Width="150" HighlightCssClass="cssValidatorCalloutHighlight">
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
                                        <td class="style3" align="right" style="width: 100px;">
                                            <span class="Langtxt" id="Subordinateunits"></span>：
                                        </td>
                                        <td align="left" class="style3">
                                            <asp:DropDownList ID="DropDownList1" runat="server" AppendDataBoundItems="True" DataSourceID="ObjectDataSource1"
                                                DataTextField="Name" DataValueField="id">
                                                <asp:ListItem Value="0"></asp:ListItem>
                                            </asp:DropDownList>
                                            <font color="red">*</font>      
                                            
                                            </td>
                                    </tr>
                                    <tr>
                                        <td class="auto-style1" align="right">
                                            <span class="Langtxt" id="zhuliuzu"></span>：
                                        </td>
                                        <td align="left" class="style3">
                                            <asp:TextBox ID="txtFSGSSIS" runat="server" Width="150px"></asp:TextBox>
                                            <font color="red">*</font>
                                            <asp:RequiredFieldValidator ID="rfvFSGSSIS" runat="server" ControlToValidate="txtFSGSSIS" Display="None"></asp:RequiredFieldValidator>
                                        </td>
                                  </tr>
                                     <tr>
                                        <td class="style3" align="right">
                                            <span class="Langtxt" id="GetJWD"></span>：
                                        </td>
                                        <td align="left">
                                            <div onclick="getlola()">
                                                <span class="Langtxt" id="Lang-Click"></span> <font id="Lang_Get" class="Langtxt" style="cursor: hand" color="blue"></font><span class="Langtxt" id="Lang_Sit"></span></div>
                                            <div id="divstatue">
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="style3" align="right" style="width: 100px;">
                                            <span class="Langtxt" id="gdtjd"></span>：
                                        </td>
                                        <td align="left" class="style3">
                                            <asp:TextBox ID="txtLo" runat="server" Width="150px"></asp:TextBox><font color="red">*</font>
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
                                                        <StyleAction Attribute="display" Value="none"/>
                                                    </Sequence>
                                                </OnHide>
                                                </Animations>
                                            </cc1:ValidatorCalloutExtender>
                                           
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="style3" align="right" style="width: 100px;">
                                           <span class="Langtxt" id="gdtwd"></span>：
                                        </td>
                                        <td align="left" class="style3">
                                            <asp:TextBox ID="txtLa" runat="server" Width="150px"></asp:TextBox><font color="red">*</font>
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
                                <img class="style4" style="cursor: pointer;" onclick="window.parent.CloseJWD();window.parent.mycallfunction(geturl())"
                                    imgid="Lang-Cancel" />
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
                                        <td width="25%" nowrap="nowrap" >
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
<script>    window.parent.closeprossdiv();</script>
