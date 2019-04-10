<%@ Page Language="C#" AutoEventWireup="true" ValidateRequest="false" CodeBehind="UserChangeEntity1.aspx.cs" Inherits="Web.lqnew.opePages.UserChangeEntity1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head10" runat="server">
    <title></title>
    <script src="../../JQuery/jquery-1.5.2.js" type="text/javascript"></script>
    <link href="../css/lq_addedit.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/pagestyle.css" rel="stylesheet" type="text/css" />
    <script src="../js/geturl.js" type="text/javascript"></script>
    <script src="../js/dragwindow.js" type="text/javascript"></script>
    <script src="../js/CommValidator.js" type="text/javascript"></script>
     <script src="../js/GlobalVar.js" type="text/javascript"></script>
</head>
<!---------------------------xzj--2018/6/28--添加body的style------------------>
<body style="background-color:rgba(255,255,255,1)">
<!---------------------------xzj--2018/6/28--添加body的style------------------>
    <form id="form10" runat="server">
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
                               
                            </td>
                            <td width="281" background="../images/tab_05.gif" align="right">
                                <!---------------------------xzj--2018/6/28--注释原来的，新的删除了onclick调用的CloseJWD（）函数------------------>
                                <!--<img class="style6" style="cursor: hand;" onclick="window.parent.CloseJWD();window.parent.mycallfunction('UserChangeEntity1',418, 317)"
                                    onmouseover="javascript:this.src='../images/close_un.png';" onmouseout="javascript:this.src='../images/close.png';"
                                    src="../images/close.png" />-->
                                <img class="style6" style="cursor: hand;" onclick="window.parent.mycallfunction('UserChangeEntity1',418, 317)"
                                    onmouseover="javascript:this.src='../images/close_un.png';" onmouseout="javascript:this.src='../images/close.png';"
                                    src="../images/close.png" />
                                <!---------------------------xzj--2018/6/28--注释原来的，新的删除了onclick调用的CloseJWD（）函数------------------>
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
                            <td width="15px" background="../images/tab_12.gif">
                                &nbsp;
                            </td>
                            <td align="center"  id="dragtd">
                                <iframe src="../../UserChangEntity/UserChangeEntity.aspx" style=" width:778px; height:515px"></iframe>
                            </td>
                            <td width="14px" background="../images/tab_16.gif">
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


    window.parent.closeprossdiv();</script>
<link href="../../CSS/lq_calloutExtender.css" rel="stylesheet" type="text/css" />
