<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Upload.aspx.cs" Inherits="Web.Demo.Upload" %>
<HTML><title>上传图片</title> 
<BODY bgcolor="#FFFFFF"> 
<FORM ENCTYPE="multipart/form-data" RUNAT="server" ID="Form1"> 
<TABLE RUNAT="server" WIDTH="700" ALIGN="left" ID="Table1" cellpadding="0" cellspacing="0" border="0"> 
<TR> 
<TD>上传图片(选择你要上传的图片)</TD> 
<TD> 
<INPUT TYPE="file" ID="UP_FILE" RUNAT="server" STYLE="Width:320" ACCEPT="text/*" NAME="UP_FILE"> 
</TD> 
</TR> 
<TR> 
<TD> 
    格式：jpg,jpeg,gif,bmp小于1MB</TD> 
<TD> 
    &nbsp;</TD> 
</TR> 
<TR> 
<TD> <asp:Label RUNAT="server" ID="txtMessage" FORECOLOR="red" MAINTAINSTATE="false" /> 
</TD> 
<TD> 
<asp:Button RUNAT="server" WIDTH="239" onCLICK="Button_Submit" TEXT="Upload Image" /> 
</TD> 
</TR> 
</TABLE> 
</FORM> 
</BODY> 
</HTML> 


