<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MyUpLoadExcel.aspx.cs" Inherits="Web.lqnew.opePages.UpLoad.MyUpLoadExcel" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title><%--Excel上传--%></title>
    <link rel="Stylesheet" href="_assets/css/progress.css" />
    <link rel="Stylesheet" href="_assets/css/upload.css" />
        <!---------------xzj--2018/7/20------------注销jquery防止报错------------------>
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

        var Lang_SelectFlie = objLanguages.GetTextByName("Lang_SelectFlie", objLanguages.useprameters.languagedata);
        var Lang_FileFormatErr = objLanguages.GetTextByName("Lang_FileFormatErr", objLanguages.useprameters.languagedata);
        var Lang_NameLength = objLanguages.GetTextByName("Lang_NameLength", objLanguages.useprameters.languagedata);
        var Lang_ErrorCharacter = objLanguages.GetTextByName("Lang_ErrorCharacter", objLanguages.useprameters.languagedata);


        function checkType() {
            var EntityPicFile = document.getElementById("EntityPicFile").value;

            var seat = EntityPicFile.lastIndexOf(".");
            var extension = EntityPicFile.substring(seat).toLowerCase();
            if (EntityPicFile == "") {
                alert(Lang_SelectFlie);
                return false;
            }
            //if (extension != ".xlsx" && extension != ".docx" && extension != ".doc") {
            //    alert(Lang_FileFormatErr);
            //    return false;
            //}

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
                <span id="Lang-UploadFlie"><%--文件上传--%></span></h3>
            <div>
                <div>
                    <table>
                        <tr>
                            <td id="Lang-SelectFlie">
                               <%-- 请选择要上传的文件--%>
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
                    <div id="Lang-FormatFlie"><%--格式:xlsx,doc 小于10MB--%></div>
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
    document.title = window.dialogArguments.GetTextByName("Lang-UploadFlie", window.dialogArguments.useprameters.languagedata);
</script>
