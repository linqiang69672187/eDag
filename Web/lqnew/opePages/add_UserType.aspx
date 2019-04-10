<%@ Page Language="C#" AutoEventWireup="true"  ValidateRequest="false" CodeBehind="add_UserType.aspx.cs" Inherits="Web.lqnew.opePages.add_UserType" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link href="../css/lq_addedit.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/pagestyle.css" rel="stylesheet" type="text/css" />
    <script src="../js/geturl.js" type="text/javascript"></script>
    <script src="../js/dragwindow.js" type="text/javascript"></script>
    <script src="../../JQuery/jquery-1.5.2.js" type="text/javascript"></script>
    <script src="../../LangJS/managerGroup_langjs.js"></script>
    <script type="text/javascript">
        function uploadImage() {
            //window.parent.mycallfunction('UpLoad/UploadDemo', 450, 400, '23&type=23');
            var fileName = window.showModalDialog("UpLoad/UploadDemo.aspx?id=23&type=23", "", "help:no;status:no;dialogWidth=465px;dialogHeight=120px");
            if (fileName !=window.parent.GetTextByName("Uploadfailed") && fileName != undefined) {
                window.document.getElementById("mypic").src = "UpLoad/Uploads/" + fileName;
                window.document.getElementById("<%=HidPic.ClientID %>").value = "UpLoad/Uploads/" + fileName;
                alert(window.parent.GetTextByName("UploadSuccess"));
            } else {
                //alert("上传失败");
            }
        }
        function selPic() {
            window.parent.document.getElementById("mybkdiv").style.zIndex = 1998;
            window.parent.mycallfunction("SelUserTypePic", 594, 800, "&filename=" + window.document.getElementById("<%=hidNormal.ClientID %>").value + "&ifr=add_UserType_ifr", 2000);
        }
        function afterSel(dirName) {         
            window.document.getElementById("imgNormal").src = "UpLoad/usertypepic/" + dirName + "/3.png";
            window.document.getElementById("<%=hidNormal.ClientID %>").value = dirName;

        }
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
                                        <img src="../images/001.gif" /><span class="Langtxt" id="Lang_Add" ></span></li>
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
                            <td width="15" background="../images/tab_12.gif">
                                &nbsp;
                            </td>
                            <td align="center">
                                <table class="style1" cellspacing="1" id="dragtd">
                                    <tr>
                                        <td colspan="2" align="left" style="background-image: url(../images/add_entity_infobg.png);
                                            height: 33;">
                                            <div style="background-image: url(../images/add_entity_info.png); width: 109px; height: 23px;">
                                                <div style="margin-left: 30px; font-size: 14px; font-weight: bold; color: #006633;
                                                    padding-top: 5px;">
                                                    <span class="Langtxt" id="Usertype" ></span></div>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="style3" align="right" style="width: 90px;">
                                            <span class="Langtxt" id="typeName" ></span>&nbsp;&nbsp;
                                        </td>
                                        <td align="left" class="style3">
                                            <asp:TextBox ID="txtTypeName" runat="server" Width="100px"></asp:TextBox>
                                            <font color="red">*</font>
                                             <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ErrorMessage="不能为空" runat="server" ControlToValidate="txtTypeName"
                                                Display="None"></asp:RequiredFieldValidator>
                                            <cc1:ValidatorCalloutExtender ID="Validatorcalloutextender3" runat="server" TargetControlID="RequiredFieldValidator1"
                                                Width="200px" HighlightCssClass="cssValidatorCalloutHighlight">
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
                                                        <%-- 如果没有使用这个动画，则会因为外显型对话框验证器扩展器会位在其他网页项目的上，
                                                             因而无法点选先前外显型对话框验证器扩展器所在位置的网页项目。
                                                             事实上，我们可以省略上面那道设置。 --%>
                                                        <StyleAction Attribute="display" Value="none"/>
                                                    </Sequence>
                                                </OnHide>
                                                </Animations>
                                            </cc1:ValidatorCalloutExtender>
                                             <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" Display="None"
                                                ControlToValidate="txtTypeName" ValidationExpression="^[\u4e00-\u9fa5a-zA-Z\s]{2,20}$"></asp:RegularExpressionValidator>
                                                <cc1:ValidatorCalloutExtender ID="vceTxtName" runat="server" TargetControlID="RegularExpressionValidator1"
                                                    Width="200px" HighlightCssClass="cssValidatorCalloutHighlight">
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
                                        <td class="style3" align="right" style="width: 90px;">
                                            <span style="color: Red; cursor: pointer" onclick="selPic()"><span class="Langtxt" id="xuanzetubiao"></span>&nbsp;&nbsp;
                                        </td>
                                        <td align="left" class="style3">
                                            <table>
                                             
                                                <tr>
                                                   <%-- <td>
                                                        <span class="Langtxt" id="bzczttb"></span>
                                                    </td>--%>
                                                    <td>
                                                        <img id="imgNormal" src="<%--UpLoad/usertypepic/警察/3.png--%>" style="width: 15px; height: 25px" />
                                                    </td>
                                                </tr>
                                              <%--   <tr>
                                                    <td>
                                                        选中状态图标
                                                    </td>
                                                    <td>
                                                        <img runat="server" id="imgSelStatus" src="UpLoad/usertypepic/警察/4.png" style="width: 15px;
                                                            height: 25px" />
                                                    </td>
                                                </tr>--%>
                                            </table>
                                            <asp:HiddenField ID="hidNormal" runat="server" Value="" />
                                          
                                        <%--     <asp:HiddenField ID="hidSelStatus" runat="server" Value="警察" />--%>
                                        </td>
                                    </tr>
                                    <tr style="display: none">
                                        <td class="style3" align="right" style="width: 90px;">
                                            <span class="Langtxt" id="Icon"></span>&nbsp;&nbsp;
                                        </td>
                                        <td align="left" class="style3">
                                            <img id="mypic" src="../images/type_img_person.png" style="width: 20px; height: 20px" />
                                            <asp:HiddenField ID="HidPic" runat="server" Value="../images/type_img_person.png" />
                                            <span style="color: Red; cursor: pointer" onclick="uploadImage()"><span class="Langtxt" id="Lang-UpdateIcon"></span></span>&nbsp;&nbsp;<span class="Langtxt" id="Lang_upload_info"></span>
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
                                <asp:ImageButton ID="ImageButton1"  runat="server"
                                    OnClick="ImageButton1_Click" />&nbsp;&nbsp;&nbsp;
                                <!---------------------------xzj--2018/6/28--将imgid改为id,cursor属性值改为pointer------------------>
                                <img  style="cursor: pointer;" onclick="window.parent.mycallfunction(geturl())"
                                    id="Lang-Cancel" />
                                <!---------------------------xzj--2018/6/28--将imgid改为id------------------>
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
<script>

    window.parent.closeprossdiv();   
    image = window.document.getElementById("imgNormal");
    srouce = window.parent.parent.GetTextByName("Lang_usertypepicturepath_3", window.parent.parent.useprameters.languagedata);
    image.setAttribute("src", srouce);
    //给图片添加src-----------------------------xzj--2018/6/28----------------------
    window.document.getElementById("Lang-Cancel").src = window.parent.GetTextByName('Lang-Cancel', window.parent.useprameters.languagedata);
    //给图片添加src-----------------------------xzj--2018/6/28----------------------
</script>
