<%@ Page Language="C#" AutoEventWireup="true"  ValidateRequest="false" CodeBehind="add_PjGroup.aspx.cs" ValidateRequest="false"
    Inherits="Web.lqnew.opePages.add_PjGroup" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <style type="text/css">
        #multiinput
        {
            font-size: 12px;
            border: 1px #000 solid;
            font-weight: 700;
            height: 105px;
            width: 300px;
            overflow-y: auto;
        }
        span
        {
            color: Blue;
            cursor: hand;
        }
        
        #multiinput a:hover
        {
            background-color: #eee;
            cursor: text;
        }
    </style>
    <link href="../css/lq_addedit.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/pagestyle.css" rel="stylesheet" type="text/css" />
    <script src="../../JQuery/jquery-1.5.2.js" type="text/javascript"></script>
    <script src="../js/geturl.js" type="text/javascript"></script>
    <script src="../js/dragwindow.js" type="text/javascript"></script>
    <script src="../../LangJS/managerGroup_langjs.js"></script>
    <script type="text/javascript">
        var UserID = '<%=Request["id"] %>';
        var SendMsgIssiArray = new Array();
        var SendMsgIssiString = "";
        var flags = false;

        function faterdo(retrunissis) {
            var gssis = "";
            for (var i = 0; i < retrunissis.length; i++) {

                gssis += retrunissis[i].gname + "(" + retrunissis[i].gissi + ");";
            }

            //            var strRestule = "";
            //            for (var i = 0; i < results.length; i++) {
            //                strRestule += results[i] + ";";
            //            }
            if (gssis.length > 0) {
                gssis = gssis.substring(0, gssis.length - 1);
            }
            SendMsgIssiString = "";
            SendMsgIssiArray.length = 0;
            SendMsgIssiString = gssis;
            // alert(SendMsgIssiString);
            showTitle();

        }

        //每一次显示前 清空重新生成
        function showTitle() {
            SendMsgIssiArray.length = 0;
            var strRes = "";
            var arrMyIssi = SendMsgIssiString.split(";");

            if (SendMsgIssiString != "") {
                for (var i = 0; i < arrMyIssi.length; i++) {
                    if (arrMyIssi[i] != "") {
                        SendMsgIssiArray.push(arrMyIssi[i]);
                        strRes += arrMyIssi[i] + "<span style='cursor:hand' onclick=\"DeleteArray('" + arrMyIssi[i] + "')\"><img class='style6' onmouseover=\"javascript:this.src='../images/close_un.png';\" onmouseout=\"javascript:this.src='../images/close.png';\" src=\"../images/close.png\" /></span> &nbsp;&nbsp;"
                    }
                }
            } else {

            }

            //$("#txtISSI").val(strRes);
            if (strRes == "")
                strRes = "&nbsp;";
            $("#multiinput").html(strRes);
            $("#txtISSIValue").val(SendMsgIssiString);
        }

        function DeleteArray(str) {
            SendMsgIssiString = "";
            for (var i = 0; i < SendMsgIssiArray.length; i++) {
                if (SendMsgIssiArray[i] != str && SendMsgIssiArray[i] != "") {
                    SendMsgIssiString += SendMsgIssiArray[i] + ";";
                }
            }
            SendMsgIssiString = SendMsgIssiString.substring(0, SendMsgIssiString.length - 1);
            showTitle();
        }

        $(document).ready(function () {
            SendMsgIssiString = $("#txtISSIValue").val();
            showTitle();
            //选择ISSI
            $("#imgSelectISSI").click(function () {
                flags = true;

                window.parent.visiablebg();
                window.parent.mycallfunction('AddPJDXGroupMember/add_Member', 635, 514, '0&ifr=add_PjGroup_ifr&issi=' + SendMsgIssiString, 2001);
            })


        })
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
                                        <img src="../images/001.gif" /><span class="Langtxt" id="add" ></span></li>
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
                                            <div style="background-image: url(../images/add_entity_info.png); width: 109px; height: 23px;">
                                                <div style="margin-left: 29px; font-size: 14px; font-weight: bold; color: #006633;
                                                    padding-top: 5px;">
                                                    <span class="Langtxt" id="PJgroupinformation" ></span></div>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="style3" align="right" style="width: 90px;">
                                            <span class="Langtxt" id="PJgroupname" ></span>&nbsp;&nbsp;
                                        </td>
                                        <td align="left" class="style3">
                                            <asp:TextBox ID="txtPJZName" runat="server" Width="150px"></asp:TextBox><font color="red">*</font>
                                            <asp:RequiredFieldValidator ID="rfvBaseStationName" runat="server" ControlToValidate="txtPJZName"
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
                                                    
                                                        <StyleAction Attribute="display" Value="none"/>
                                                    </Sequence>
                                                </OnHide>
                                                </Animations>
                                            </cc1:ValidatorCalloutExtender>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="style3" align="right">
                                             <span class="Langtxt" id="Subordinateunits" ></span>&nbsp;&nbsp;
                                        </td>
                                        <td align="left" class="style3">
                                            <asp:DropDownList ID="DropDownList1" runat="server" AppendDataBoundItems="True" DataSourceID="ObjectDataSource2"
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
                                            <div id="divIssiTitle">
                                                <span class="Langtxt" id="Membersgroup" ></span>&nbsp;&nbsp;</div>
                                        </td>
                                        <td align="left">
                                        <table><tr><td> <div style="display: none">
                                                <textarea type="text" id="txtISSI" style="height: 100%; width: 90%" rows="3" runat="server"></textarea><input
                                                    type="text" id="txtISSIValue" runat="server" /><input type="text" id="txtISSIText"
                                                        runat="server" /></div>
                                            <div id="multiinput">
                                                &nbsp; <a id="t"></a>
                                            </div>&nbsp;</td><td> <img src="../images/btn_add.png" id="imgSelectISSI" onmouseover="javascript:this.src='../images/btn_add_un.png';"
                                                    onmouseout="javascript:this.src='../images/btn_add.png';" /></td></tr></table>
                                           
                                           
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
                                <asp:ImageButton ID="ImageButton1" ImageUrl="../images/add_ok.png" runat="server"
                                    OnClick="ImageButton1_Click" />&nbsp;&nbsp;&nbsp;
                                <img  style="cursor: hand;" onclick="window.parent.CloseJWD();window.parent.mycallfunction(geturl())"
                                    src="../images/add_cancel.png" />
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
<script>    window.parent.closeprossdiv();</script>
