<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MapBackPicUpLoad.aspx.cs" Inherits="Web.lqnew.opePages.UpLoad.MapBackPicUpLoad" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title><%--图片上传--%></title>
    <link rel="Stylesheet" href="_assets/css/progress.css" />
    <link rel="Stylesheet" href="_assets/css/upload.css" />
    <!---------------xzj--2018/7/20------------注销jquery防止报错------------------>
    <!--<script src="../../../JQuery/jquery-1.5.2.js" type="text/javascript"></script>-->
    <script src="../../../JS/LangueSwitch.js"></script>
    <style type="text/css">
        BODY
        {
            font-family: Arial, Sans-Serif;
            font-size: 12px;
        }
    </style>
    <base target="_self"></base>
    <script type="text/javascript">
        function checkType() {
            var EntityPicFile = document.getElementById("EntityPicFile").value;
            var seat = EntityPicFile.lastIndexOf(".");
            var extension = EntityPicFile.substring(seat).toLowerCase();
            var Lang_SelectPic = window.dialogArguments.GetTextByName("Lang_SelectPic", window.dialogArguments.useprameters.languagedata);
            var Lang_PicFormatErr = window.dialogArguments.GetTextByName("Lang_PicFormatErr", window.dialogArguments.useprameters.languagedata);
            var Lang_NameLength = window.dialogArguments.GetTextByName("Lang_NameLength", window.dialogArguments.useprameters.languagedata);
            var Lang_ErrorCharacter = window.dialogArguments.GetTextByName("Lang_ErrorCharacter", window.dialogArguments.useprameters.languagedata);
            //var Uploadfailed = window.dialogArguments.GetTextByName("Uploadfailed", window.dialogArguments.useprameters.languagedata);

            if (EntityPicFile == "") {
                alert(Lang_SelectPic);//("请选择需要上传的图片");
                return false;
            }
            if (extension != ".jpg" && extension != ".jpeg" && extension != ".gif" && extension != ".png" && extension != ".bmp") {
                alert(Lang_PicFormatErr);//("图片格式不准确");
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
            var Uploadfailed = window.dialogArguments.GetTextByName("Uploadfailed", window.dialogArguments.useprameters.languagedata);
            if (picName == Uploadfailed) {//"上传失败"
            
            } else {
                window.returnValue = picName;
                window.close();
            }
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <div class="upload" style="position: absolute; left: 7px">
            <h3 id="Lang-UploadPic">
                <%--图片上传--%></h3>
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
                                    OnClick="ImageButton_Click" /> <%--上传--%>
                            </td>
                        </tr>
                    </table>
                   <span id="Lang_upload_info"><%--格式：jpg,jpeg,gif,png,bmp 小于1MB--%></span> 
                </div>
            </div>
        </div>
    </div>
    </form>
</body>
</html>
<script type="text/javascript">
    LanguageSwitch(window.dialogArguments);
    document.title = window.dialogArguments.GetTextByName("Lang-UploadPic", window.dialogArguments.useprameters.languagedata);


</script>
 
