<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="NewPicGroup.aspx.cs"
    Inherits="Web.lqnew.opePages.NewPicGroup" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../css/lq_manager.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/pagestyle.css" rel="stylesheet" type="text/css" />
    <script src="../js/geturl.js" type="text/javascript"></script>
    <script src="../js/dragwindow.js" type="text/javascript"></script>
    <script src="../js/CommValidator.js" type="text/javascript"></script>
    <script type="text/javascript">
        Request = {
            QueryString: function (item) {
                var svalue = location.search.match(new RegExp("[\?\&]" + item + "=([^\&]*)(\&?)", "i"));
                return svalue ? svalue[1] : svalue;
            }
        }

        function checkType() {
            if (document.getElementById("txtPicGroupName").value == "") {
                alert(window.parent.GetTextByName("Lang_PicGroupNameIsNotNull", window.parent.useprameters.languagedata));//多语言：图标组名称不能为空
                return false;
            }
            if (document.getElementById("txtPicGroupName").value.length > 10) {
                alert(window.parent.GetTextByName("Lang_PicGroupNameLengthNotBigTenC", window.parent.useprameters.languagedata));//多语言：图片组名称长度不得大于10个字符
                return false;
            }
            if (checkUnNomal(document.getElementById("txtPicGroupName").value)) {
                alert(window.parent.GetTextByName("Lang_PicGroupNameIsContentSpecialC", window.parent.useprameters.languagedata));//多语言：图片组名称含特殊字符
                return false;
            }
            var NormalFile = document.getElementById("NormalFile").value;         
            var UnNormalFile = document.getElementById("UnNormalFile").value;
           
            var seat = NormalFile.lastIndexOf(".");
            var extension = NormalFile.substring(seat).toLowerCase();
            if (NormalFile == "") {
                alert(window.parent.GetTextByName("PleaseChooseNormalPic", window.parent.useprameters.languagedata));//多语言：请选择需要上传的正常状态图标
                return false;
            }         
            if (UnNormalFile == "") {
                alert(window.parent.GetTextByName("PleaseChooseUnNormalPic", window.parent.useprameters.languagedata));//多语言：请选择需要上传的不正常状态图标
                return false;
            }
          

            if (extension != ".jpg" && extension != ".jpeg" && extension != ".gif" && extension != ".png" && extension != ".bmp") {
                alert(window.parent.GetTextByName("NormalPicIsWrong", window.parent.useprameters.languagedata));//多语言：正常状态图标格式不准确
                return false;
            }
           
            seat = UnNormalFile.lastIndexOf(".");
            extension = UnNormalFile.substring(seat).toLowerCase();
            if (extension != ".jpg" && extension != ".jpeg" && extension != ".gif" && extension != ".png" && extension != ".bmp") {
                alert(window.parent.GetTextByName("UnNormalPicIsWrong", window.parent.useprameters.languagedata));//多语言：不正常状态图标格式不准确
                return false;
            }

         
            return true;
        }
        function onCLose() {
            window.parent.document.getElementById("mybkdiv").style.zIndex = 1998;
            window.parent.mycallfunction('NewPicGroup', 654, 354);
        }
    </script>
</head>
<body>
    <form id="form1"  runat="server">
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
                                        <img src="../images/311.gif" width="16" height="16" /><span id="NewUseTypePicGroup"><%--新建用户类型图标组--%></span></li>
                                </ul>
                            </td>
                            <td width="281" background="../images/tab_05.gif" align="right">
                                <img class="style6" style="cursor: hand;" onclick="onCLose()"
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
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="white">
                        <tr style="height:150px">
                            <td width="15" background="../images/tab_12.gif">
                                &nbsp;
                            </td>
                            <td align="center" id="dragtd">
                                <table>
                                <tr>
                                <td align="right" ><%--图标组名称--%><span id="PicGroupName"></span><span>&nbsp;&nbsp;</span></td>
                                 <td align="left"><asp:TextBox ID="txtPicGroupName" ViewStateMode="Disabled" runat="server"></asp:TextBox><font color="red">*</font>
</td>
                                </tr>
                                <tr>
                                <td align="right" ><%--正常状态图标--%><span id="zczttb"></span><span>&nbsp;&nbsp;</span></td>
                                 <td align="left"><asp:FileUpload ID="NormalFile" runat="server" /> <span id="spants1"><%--格式：jpg,jpeg,gif,png,bmp 小于1MB--%></span>
</td>
                                </tr>
                             
                                 <tr>
                                <td align="right" ><%--不正常状态图标--%><span id="bzczttb"></span><span>&nbsp;&nbsp;</span></td>
                                 <td align="left"><asp:FileUpload ID="UnNormalFile" runat="server" /> <span id="spants3"><%--格式：jpg,jpeg,gif,png,bmp 小于1MB--%></span>
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
                            <td align="center">
                                <asp:ImageButton ID="submitToS"  ImageUrl="../images/add_ok.png"  runat="server" 
                                 OnClientClick="return checkType()"    onclick="ImageButton_Click" />
                               
                                 &nbsp;&nbsp;&nbsp;
                                <img id="img_add_cancel" class="style4" style="cursor: hand;" onclick="onCLose()"
                                    src="../images/add_cancel.png" />
                                 &nbsp;&nbsp;&nbsp;
                               
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
    window.document.getElementById("PicGroupName").innerHTML = window.parent.GetTextByName("PicGroupName", window.parent.useprameters.languagedata);
    window.document.getElementById("zczttb").innerHTML = window.parent.GetTextByName("zczttb", window.parent.useprameters.languagedata);
    window.document.getElementById("bzczttb").innerHTML = window.parent.GetTextByName("bzczttb", window.parent.useprameters.languagedata);
    window.document.getElementById("spants1").innerHTML = window.parent.GetTextByName("Lang_upload_info", window.parent.useprameters.languagedata);
    window.document.getElementById("spants3").innerHTML = window.parent.GetTextByName("Lang_upload_info", window.parent.useprameters.languagedata);
    
    window.document.getElementById("NewUseTypePicGroup").innerHTML = window.parent.GetTextByName("NewUseTypePicGroup", window.parent.useprameters.languagedata);
    window.document.getElementById("img_add_cancel").src = window.parent.GetTextByName("Lang-Cancel", window.parent.useprameters.languagedata);
   
</script>
