﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="Web.lqnew.opePages.About" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../css/lq_addedit.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/pagestyle.css" rel="stylesheet" type="text/css" />
    <script src="../js/geturl.js" type="text/javascript"></script>
    <script src="../js/dragwindow.js" type="text/javascript"></script>
    
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
                                <ul class="hor_ul">
                                    <li>
                                        <img src="../images/037.gif" /><span id="About"><%--关于--%></span></li>
                                </ul>
                            </td>
                            <td width="281" background="../images/tab_05.gif" align="right">
                                <img class="style6" style="cursor: hand;" onclick="window.parent.mycallfunction('About')"
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
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" background="../../Images/login/loginin.png">
                        <tr>
                            <td width="15" background="../images/tab_12.gif">
                                &nbsp;
                            </td>
                            <td align="center" id="dragtd">
                                <table>
                                    <tr>
                                        <td colspan="2" align="center">
                                            <div style="font-size: large; color: Blue">
                                                <%=ConfigurationManager.AppSettings["ApplicationName"].ToString()%></div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            &nbsp;
                                        </td>
                                        <td>
                                            &nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right" width="50%">
                                            <span id="GisVesion"><%--GIS版本--%></span>:
                                        </td>
                                        <td align="left">
                                            <%=ConfigurationManager.AppSettings["version"].ToString()%>
                                        </td>
                                    </tr>
                                    <%--<tr>
                                        <td align="right" width="50%">
                                            插件版本：
                                        </td>
                                        <td align="left">
                                            <%=ConfigurationManager.AppSettings["apiversion"].ToString()%>
                                        </td>
                                    </tr>--%>
                                    <tr>
                                        <td align="right">
                                            <span id="publishtime"><%--发布时间--%></span>:
                                        </td>
                                        <td align="left">
                                            <%=ConfigurationManager.AppSettings["publishtime"].ToString() %>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            &nbsp;
                                        </td>
                                        <td>
                                            &nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" align="center">
                                            <%=ConfigurationManager.AppSettings["copyright"].ToString()%>
                                        </td>
                                    </tr>
                                </table>
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
<script>
    window.parent.closeprossdiv();
    document.getElementById("GisVesion").innerHTML = window.parent.GetTextByName("GisVesion", window.parent.useprameters.languagedata);
    document.getElementById("publishtime").innerHTML = window.parent.GetTextByName("publishtime", window.parent.useprameters.languagedata);
    document.getElementById("About").innerHTML = window.parent.GetTextByName("About", window.parent.useprameters.languagedata);
    
</script>
<link href="../../CSS/lq_calloutExtender.css" rel="stylesheet" type="text/css" />