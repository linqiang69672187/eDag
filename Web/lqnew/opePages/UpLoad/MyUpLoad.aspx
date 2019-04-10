<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MyUpLoad.aspx.cs" Inherits="Web.lqnew.opePages.UpLoad.MyUpLoad" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title><%--图片上传--%></title>
    <link rel="Stylesheet" href="_assets/css/progress.css" />
    <link rel="Stylesheet" href="_assets/css/upload.css" />
    <!--------------xzj--2018/7/19-------------------注释jquery，阻止报错--------------->
    <!--<script src="../../../JQuery/jquery-1.5.2.js" type="text/javascript"></script>-->
    <script src="../../../JS/LangueSwitch.js" type="text/javascript"></script>
    <style type="text/css">
        BODY
        {
            font-family: Arial, Sans-Serif;
            font-size: 12px;
        }
    </style>
    <base target="_self" />
    <script type="text/javascript">
        var objLanguages = window.dialogArguments;
        
        var Lang_SelectPic = objLanguages.GetTextByName("Lang_SelectPic", objLanguages.useprameters.languagedata);
        var Lang_PicFormatErr = objLanguages.GetTextByName("Lang_PicFormatErr", objLanguages.useprameters.languagedata);
        var Lang_NameLength = objLanguages.GetTextByName("Lang_NameLength", objLanguages.useprameters.languagedata);
        var Lang_ErrorCharacter = objLanguages.GetTextByName("Lang_ErrorCharacter", objLanguages.useprameters.languagedata);
       

        function checkType() {
            var EntityPicFile = document.getElementById("EntityPicFile").value;

            var seat = EntityPicFile.lastIndexOf(".");
            var extension = EntityPicFile.substring(seat).toLowerCase();

            if (EntityPicFile == "") {
                alert(Lang_SelectPic);
                return false;
            }
            if (extension != ".jpg" && extension != ".jpeg" && extension != ".gif" && extension != ".png" && extension != ".bmp") {
                alert(Lang_PicFormatErr);
                return false;
            }

            var seat2 = EntityPicFile.lastIndexOf('\\');
            var filename = EntityPicFile.substring(seat2, seat);

            if (filename.length > 32) {
                alert(Lang_NameLength);
                return false;
            }

            if (filename.indexOf('\'') > -1) {
                alert(Lang_ErrorCharacter)
                return false;
            }
        }
        function StrOver(picName) {
            if (picName == "UploadFail") {
            
            } else {
                window.returnValue = picName;
                window.close();
            }
        }
        //function onloadfun()
        //{
        //    LanguageSwitch(window.dialogArguments);
        //}
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <div class="upload" style="position: absolute; left: 7px">
            <h3>
                <span id="Lang-UploadPic"><%--图片上传--%></span></h3>
            <div>
                <div>
                    <table>
                        <tr>
                            <td id="Lang-SelectPic">
                               <%-- 请选择要上传的图片--%>
                            </td>
                            <td>
                                <asp:FileUpload Width="220px" ID="EntityPicFile" runat="server" />
                            </td>
                            <td>
                                <asp:Button ID="submitToS" Text="" runat="server" OnClientClick="return checkType()"
                                    OnClick="ImageButton_Click" /><%--上传--%>
                            </td>
                        </tr>
                    </table>
                    <div id="Lang-Format"><%--格式为png,jpg,bmp,jpeg,gif,不能大于1MB--%></div>
                </div>
            </div>
        </div>
    </div>
    </form>
</body>
</html>
<script type="text/javascript">
    //LanguageSwitch(window.dialogArguments);
    //LanguageSwitch(window);
    document.title = window.dialogArguments.GetTextByName("Lang-UploadPic", window.dialogArguments.useprameters.languagedata);
</script>
