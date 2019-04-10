<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="edit_role.aspx.cs" Inherits="Web.lqnew.opePages.edit_role" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link href="../css/lq_addedit.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/pagestyle.css" rel="stylesheet" type="text/css" />
    <script src="../js/geturl.js" type="text/javascript"></script>
    <script src="../js/dragwindow.js" type="text/javascript"></script>
    <script src="../../JQuery/jquery-1.5.2.js" type="text/javascript"></script>
    <script src="../../LangJS/managerGroup_langjs.js" type="text/javascript"></script>

    <style type="text/css">
        .box {
            width: 117px;
        }
    </style>
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
                                                <div style="width: 150px; height: 23px;">
                                                    <div style="margin-left: 30px; font-size: 14px; font-weight: bold; color: #006633; padding-top: 5px;">
                                                        <span id="Dispatcher" runat="server"></span>
                                                    </div>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="style3" align="right" style="width: 90px;">&nbsp;</td>
                                            <td align="left" class="style3">
                                                <asp:CheckBoxList CellSpacing="10" ID="chkListPower" runat="server" RepeatLayout="Flow" RepeatColumns="4" RepeatDirection="Horizontal">
                                                </asp:CheckBoxList>
                                            </td>
                                        </tr>
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
<link href="../../CSS/lq_calloutExtender.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
    window.parent.closeprossdiv();
    var image1 = window.document.getElementById("cancel");
    var srouce1 = window.parent.parent.GetTextByName("Lang-Cancel", window.parent.parent.useprameters.languagedata);
    image1.setAttribute("src", srouce1);
    var CXBKxgqx = window.parent.parent.GetTextByName("CXBKxgqxbnqx", window.parent.parent.useprameters.languagedata);
    function check(obj) {
        var chkText = obj.parentElement.children[1].innerText;
        //alert(chkText);
        var isCxbk = 0;
        if (obj.checked && (chkText == "查询布控" || chkText == "Arrangement")) {
            var chx = document.getElementById("<%=chkListPower.ClientID %>").getElementsByTagName("input");
            for (var i = 0; i < chx.length; i++) {
                if (chx[i].type == "checkbox") {
                    if (chx[i].parentElement.children[1].innerText == "个短消息" || chx[i].parentElement.children[1].innerText == "Personal SMS") {
                        chx[i].checked = true;
                    }
                    if (chx[i].parentElement.children[1].innerText == "GPS控制" || chx[i].parentElement.children[1].innerText == "GPS Control") {
                        chx[i].checked = true;
                    }
                    if (chx[i].parentElement.children[1].innerText == "动态重组" || chx[i].parentElement.children[1].innerText == "Dynamic Reorganization") {
                        chx[i].checked = true;
                    }
                }
            }
        }
        else {

            var chx = document.getElementById("<%=chkListPower.ClientID %>").getElementsByTagName("input");
            for (var i = 0; i < chx.length; i++) {
                if (chx[i].parentElement.children[1].innerText == "查询布控" || chx[i].parentElement.children[1].innerText == "Arrangement") {
                    if (chx[i].checked) {
                        isCxbk = 1;
                        break;
                    }
                }
            }
            for (var i = 0; i < chx.length; i++) {
                if (isCxbk == 1) {
                    if(!chx[i].checked &&(chx[i].parentElement.children[1].innerText == "个短消息" || chx[i].parentElement.children[1].innerText == "Personal SMS")) {
                        chx[i].checked = true;
                        alert(CXBKxgqx);
                    }
                    if (!chx[i].checked &&(chx[i].parentElement.children[1].innerText == "GPS控制" || chx[i].parentElement.children[1].innerText == "GPS Control")) {
                        chx[i].checked = true;
                        alert(CXBKxgqx);
                    }
                    if (!chx[i].checked &&(chx[i].parentElement.children[1].innerText == "动态重组" || chx[i].parentElement.children[1].innerText == "Dynamic Reorganization")) {
                        chx[i].checked = true;
                        alert(CXBKxgqx);
                    }
                }
                else {

                }
            }
        }

    }

</script>

