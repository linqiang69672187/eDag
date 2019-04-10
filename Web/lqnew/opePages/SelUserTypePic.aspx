<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SelUserTypePic.aspx.cs"
    Inherits="Web.lqnew.opePages.SelUserTypePic" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../css/lq_addedit.css" rel="stylesheet" type="text/css" />
    <script src="../../JQuery/jquery-1.5.2.js" type="text/javascript"></script>
    <script src="../js/geturl.js" type="text/javascript"></script>
    <script src="../js/dragwindow.js" type="text/javascript"></script>
    <script src="../../MyCommonJS/ajax.js" type="text/javascript"></script>
    <script type="text/javascript">
        Request = {
            QueryString: function (item) {
                var svalue = location.search.match(new RegExp("[\?\&]" + item + "=([^\&]*)(\&?)", "i"));
                return svalue ? svalue[1] : svalue;
            }
        }
        function SelPic() {
            document.getElementsByName("usertypepic").length;
            for (var i = 0; i < document.getElementsByName("usertypepic").length; i++) {
                if (document.getElementsByName("usertypepic")[i].checked) {
                    //alert(document.getElementsByName("usertypepic")[i].value);
                    var ifr = Request.QueryString("ifr");
                    window.parent.hiddenbg2();
                    window.parent.frames[ifr].afterSel(document.getElementsByName("usertypepic")[i].value);
                    window.parent.mycallfunction('SelUserTypePic', 654, 354);
                    return;
                }
            }
            alert(window.parent.GetTextByName("Lang_PleastChoosePicGroup", window.parent.useprameters.languagedata));//多语言：请选择图片组
        }
        function AfterNewPicGoup(groupname) {
            var ifr = Request.QueryString("ifr")
            window.parent.frames[ifr].afterSel(groupname);
            window.parent.mycallfunction('SelUserTypePic', 654, 354);
        }
        function newPicGroup() {
            window.parent.document.getElementById("mybkdiv").style.zIndex = 2001;
            window.parent.mycallfunction('NewPicGroup', 594, 245, '&ifr=SelUserTypePic_ifr', 2002)
        }

        $(document).ready(function () {
            window.parent.visiablebg2();
        });
        function OnClose() {
            window.parent.hiddenbg2();
            window.parent.mycallfunction('SelUserTypePic', 654, 354);

        }
        function deletePic(strname) {//判断该用户类型是否被使用
            if (confirm(window.parent.GetTextByName("Lang_SureToDeleteThisUserType", window.parent.useprameters.languagedata) + "[" + strname + "]?")) {//多语言：确定需要删除该用户类型吗

                if (strname == window.parent.GetTextByName("Lang_Policeman", window.parent.useprameters.languagedata) || strname == window.parent.GetTextByName("Lang_Motorcycle", window.parent.useprameters.languagedata) || strname == window.parent.GetTextByName("Lang_PoliceCar", window.parent.useprameters.languagedata) || strname == window.parent.GetTextByName("Lang_AuxiliaryPoliceOfficer", window.parent.useprameters.languagedata)) {//多语言：警察；摩托车；警车；辅警
                    alert(window.parent.GetTextByName("Lang_ThisPicIsSystemNotToDelete", window.parent.useprameters.languagedata));//多语言：此图标为系统默认图标，不能删除
                    return;
                }

                if (strname == Request.QueryString("filename")) {
                    alert(window.parent.GetTextByName("Lang_ThisPicHavingSelectNotToDelete", window.parent.useprameters.languagedata));//多语言：此图标已被选，不能删除
                    return;
                }
                jquerygetNewData_ajax("../../Handlers/DeleteTypePic.ashx", { picname: strname }, function (msg) {
                    alert(eval(msg).message);
                    if (eval(msg).message == window.parent.GetTextByName("Lang_AlertDeleteSucess", window.parent.useprameters.languagedata)) {//多语言：删除成功
                        window.location.reload();
                    }
                });
                //alert(strname);

            }
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
                                            <img src="../images/311.gif" width="16" height="16" /><span id="spanUserTypeToSelect">用户类型图标选择</span></li>
                                    </ul>
                                </td>
                                <td width="281" background="../images/tab_05.gif" align="right">
                                    <img class="style6" style="cursor: hand;" onclick="OnClose()"
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
                        <table id="dragtd" width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="white">
                            <tr style="height: 600px">
                                <td width="15" background="../images/tab_12.gif">&nbsp;
                                </td>
                                <td align="center" id="dragtd">
                                    <div style="height: 580px; overflow: auto">
                                        <asp:Label runat="server" ID="labUserTypePic"></asp:Label>
                                    </div>
                                </td>
                                <td width="14" background="../images/tab_16.gif">&nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td width="15" background="../images/tab_12.gif">&nbsp;
                                </td>
                                <td align="center">

                                    <img id="img_add_ok"  style="cursor: pointer;" onclick="SelPic()"
                                        src="../images/add_ok.png" />
                                    &nbsp;&nbsp;&nbsp;
                                <img id="img_add_cancel"  style="cursor: pointer;" onclick="OnClose()"
                                    src="../images/add_cancel.png" />
                                    &nbsp;&nbsp;&nbsp;
                               <%-- <span style="color:Red" onclick="newPicGroup()">新建图片组</span>--%>
                                    <img id="img_add_new"  style="cursor: pointer;" onclick="newPicGroup()"
                                        src="../images/btn_add.png" />
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
                                            <td width="75%" valign="top" class="STYLE1"></td>
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

    window.document.getElementById("spanUserTypeToSelect").innerHTML = window.parent.GetTextByName("spanUserTypeToSelect", window.parent.useprameters.languagedata);
    window.document.getElementById("img_add_ok").src = window.parent.GetTextByName("LangConfirm", window.parent.useprameters.languagedata);
    window.document.getElementById("img_add_cancel").src = window.parent.GetTextByName("Lang-Cancel", window.parent.useprameters.languagedata);
    window.document.getElementById("img_add_new").src = window.parent.GetTextByName("Lang_Img_NewUserType", window.parent.useprameters.languagedata);
</script>
