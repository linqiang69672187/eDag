<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="edit_entity.aspx.cs" Inherits="Web.lqnew.opePages.edit_entity" %>


<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <meta http-equiv="Cache-Control" content="no-cache,no-store, must-revalidate">
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="expires" content="0">
     <script src="../../JQuery/jquery-1.5.2.js" type="text/javascript"></script>
    <script src="../../JS/LangueSwitch.js" type="text/javascript"></script>
    <link href="../css/lq_addedit.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/pagestyle.css" rel="stylesheet" type="text/css" />
    <script src="../js/geturl.js" type="text/javascript"></script>
    <script src="../js/dragwindow.js" type="text/javascript"></script>
     <script src="../js/CommValidator.js" type="text/javascript"></script>
    <script src="../js/GlobalVar.js" type="text/javascript"></script>
    <script type="text/javascript">
        var LangUploadSucc = window.parent.parent.GetTextByName("LangUploadSucc", window.parent.parent.useprameters.languagedata);

        function callBackFun(a) {
            alert(a.lo + "|" + a.la);
        }
        function uploadImage() {
            //window.parent.mycallfunction('UpLoad/UploadDemo', 450, 400, '23&type=23');
            var fileName = window.showModalDialog("UpLoad/MyUpLoad.aspx?id=23&type=23", window.parent, "help:no;status:no;dialogWidth=465px;dialogHeight=120px");
            if (fileName != "UploadFail" && fileName != undefined) {
                var picname = fileName.substr(0,fileName.lastIndexOf("."));
                window.document.getElementById("mypic").src = "UpLoad/Uploads/" + picname + "/" + fileName + "?p=" + GetRandomNum(1, 1000000);
                window.document.getElementById("<%=HidPic.ClientID %>").value = "lqnew/opePages/UpLoad/Uploads/" + picname + "/" + fileName;
                alert(LangUploadSucc);
            } else {
                //alert("上传失败");
            }
        }
        function checkEntityName() {
            if (!checkUnNomal($("#TextBox1").val())) {
                return true;
            } else
                alert(window.parent.GetTextByName("dwmcbhtszf", window.parent.useprameters.languagedata));//dwmcbhtszf单位名称包含特殊字符
            return false;
        }
    </script>
</head>
<body onload="defaultOnload()">
    <form id="form1" runat="server">
        <div>
            <asp:ScriptManager ID="ScriptManager1" runat="server">
            </asp:ScriptManager>
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
                                            <img src="../images/037.gif" /><span id="Lang_modify"> <%--修 改--%></span></li>
                                    </ul>
                                </td>
                                <td width="281" background="../images/tab_05.gif" align="right">
                                    <!---------------------------xzj--2018/6/28--注释原来的，新的删除了onclick调用的CloseJWD（）函数------------------>
                                    <!--<img class="style6" style="cursor: hand;" onclick="window.parent.CloseJWD();window.parent.mycallfunction('edit_entity',418, 342)"
                                        onmouseover="javascript:this.src='../images/close_un.png';" onmouseout="javascript:this.src='../images/close.png';"
                                        src="../images/close.png" />-->
                                    <img class="style6" style="cursor: hand;" onclick="window.parent.mycallfunction('edit_entity',418, 342)"
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
                                <td width="15" background="../images/tab_12.gif">&nbsp;
                                </td>
                                <td align="center">
                                    <table class="style1" cellspacing="1" id="dragtd" runat="server">
                                        <tr>
                                            <td colspan="2" align="left" style="background-image: url(../images/add_entity_infobg.png); height: 33;">
                                                <div style="background-image: url(../images/add_entity_info.png); width: 109px; height: 23px;">
                                                    <div id="Lang-EntityInfo" style="margin-left: 34px; font-size: 14px; font-weight: bold; color: #006633; padding-top: 5px;">
                                                        <%--单位信息--%>
                                                    </div>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="style3" align="right" style="width: 90px;">
                                                <span id="Lang_EntityName"></span>&nbsp;&nbsp;
                                                <%--单位名称：--%>
                                            </td>
                                            <td class="style3" align="left">
                                                <asp:TextBox ID="TextBox1" runat="server" Width="150px"></asp:TextBox>
                                                <asp:RegularExpressionValidator ID="validateEntityLength" runat="server" Display="None"
                                                    ControlToValidate="TextBox1"></asp:RegularExpressionValidator>
                                                <cc1:ValidatorCalloutExtender ID="ValidatorCalloutExtender2" runat="server" TargetControlID="validateEntityLength"
                                                    Width="210px" HighlightCssClass="cssValidatorCalloutHighlight">
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

                                                <font color="red">*</font>
                                                <asp:RequiredFieldValidator ID="rfvTxtName" runat="server" Display="None" ControlToValidate="TextBox1" />
                                                <cc1:ValidatorCalloutExtender ID="vceTxtName" runat="server" TargetControlID="rfvTxtName"
                                                    Width="210px" HighlightCssClass="cssValidatorCalloutHighlight">
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
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="style3" align="right">
                                                <span id="LangParentEntity"></span>&nbsp;&nbsp;
                                                <%--所属上级单位：--%>
                                            </td>
                                            <td align="left">&nbsp;
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="style3" align="right">
                                                <span id="Lang_SelfDepth"></span>&nbsp;&nbsp;
                                                <%--所属级别：--%>
                                            </td>
                                            <td align="left">&nbsp;
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="style3" align="right">
                                                <span id="Lang_GetLoLa"></span>&nbsp;&nbsp;
                                                <%--经纬度获取：--%>
                                            </td>
                                            <td align="left">
                                                <div onclick="window.parent.GetJWD()">
                                                    <span id="Lang-Click"><%--点击--%></span> <font id="Lang_Get" style="cursor: pointer" color="blue"><%--获取--%></font><span id="Lang_Sit"><%--按钮，双击地图上需要获取经纬度的位置--%></span>
                                                </div>
                                                <div id="divstatue">
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="style3" valign="center" align="right">
                                                <span id="Lang_Longitude"></span>&nbsp;&nbsp;
                                                <%-- 经度：--%>
                                            </td>
                                            <td align="left">
                                                <asp:TextBox ID="txtLo" runat="server" Width="150px"></asp:TextBox>
                                                <asp:RangeValidator ID="rbtxtLo" ControlToValidate="txtLo" runat="server" Type="Double"
                                                    MaximumValue="180" MinimumValue="-180" ErrorMessage="<b><%--经度范围为-180到180--%></b>" Display="None"></asp:RangeValidator>
                                                <cc1:ValidatorCalloutExtender ID="Validatorcalloutextender3" runat="server" TargetControlID="rbtxtLo"
                                                    Width="210px" HighlightCssClass="cssValidatorCalloutHighlight">
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
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="style3" valign="center" align="right">
                                                <span id="Lang_Latitude"></span>&nbsp;&nbsp;
                                                <%-- 纬度：--%>
                                            </td>
                                            <td align="left">
                                                <asp:TextBox ID="txtLa" runat="server" Width="150px"></asp:TextBox>
                                                <asp:RangeValidator ID="RangeValidator1" ControlToValidate="txtLa" runat="server"
                                                    Type="Double" MaximumValue="90" MinimumValue="-90" ErrorMessage="<b><%--纬度范围为-90到90--%></b>"
                                                    Display="None"></asp:RangeValidator>
                                                <cc1:ValidatorCalloutExtender ID="Validatorcalloutextender4" runat="server" TargetControlID="RangeValidator1"
                                                    Width="210px" HighlightCssClass="cssValidatorCalloutHighlight">
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
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="style3" valign="middle" align="right">
                                                <span id="Lang_Icon"></span>&nbsp;&nbsp;
                                                <%-- 图标：--%>
                                            </td>
                                            <td align="left" valign="middle" class="style3">
                                                <img id="mypic" runat="server" src="" style="width: 15px; height: 15px" />
                                                <asp:HiddenField ID="HidPic" runat="server" Value="" />
                                                <span id="Lang-UpdateIcon" style="color: Red; cursor: pointer" onclick="uploadImage()"><%--上传图标--%></span>&nbsp;&nbsp;<span id="Lang-Format">格式为png,jpg,bmp,jpeg,gif,不能大于1MB</span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="style3" align="right">
                                                <span id="Lang_Remark"></span>&nbsp;&nbsp;
                                                <%-- 备注：--%>
                                            </td>
                                            <td align="left">
                                                <%-- <FCKeditorV2:FCKeditor ID="FCKeditor1" ToolbarSet="Basic" runat="server">
                        </FCKeditorV2:FCKeditor>--%>
                                                <asp:TextBox runat="server" ID="txtBZ" Width="250px" Height="90px" TextMode="MultiLine"></asp:TextBox>
                                                <asp:RegularExpressionValidator ID="ValidatorBZ" runat="server" Display="None"
                                                    ControlToValidate="txtBZ"></asp:RegularExpressionValidator>
                                                <cc1:ValidatorCalloutExtender ID="ValidatorCalloutExtender1" runat="server" TargetControlID="ValidatorBZ"
                                                    Width="150px" HighlightCssClass="cssValidatorCalloutHighlight">
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
                                    </table>
                                </td>
                                <td width="14" background="../images/tab_16.gif">&nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td width="15" background="../images/tab_12.gif">&nbsp;
                                </td>
                                <td align="center" height="30">
                                    <asp:ImageButton ID="LangConfirm" ImageUrl="../images/edit_entity.png" runat="server"
                                        OnClick="ImageButton1_Click" />&nbsp;&nbsp;&nbsp;
                                    <!---------------------------xzj--2018/6/28--注释原来的，新的删除了onclick调用的CloseJWD（）函数------------------>
                                    <!--<img id="Lang-Cancel"  style="cursor: pointer;" onclick="window.parent.CloseJWD();window.parent.mycallfunction('edit_entity',418, 342)"
                                    src="../images/add_cancel.png" />-->
                                    <img id="Lang-Cancel"  style="cursor: pointer;" onclick="window.parent.mycallfunction('edit_entity',418, 342)"
                                    src="../images/add_cancel.png" />
                                    <!---------------------------xzj--2018/6/28--注释原来的，新的删除了onclick调用的CloseJWD（）函数------------------>
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
<script type="text/javascript">
    window.parent.closeprossdiv();
    //窗口拖动的onload()被defaultOnload()取代，将代码放进defaultOnload()中------------xzj--2018/6/29--------------------------
    var dragEnable = 'True';
    function dragdiv() {
        var div1 = window.parent.document.getElementById(geturl());
        window.parent.windowDivOnClick(div1);
        if (div1 && event.button == 0 && dragEnable == 'True') {
            window.parent.mystartDragWindow(div1, null, event);
            div1.style.border = "solid 0px transparent";
            window.parent.cgzindex(div1);

        }
    }
    function mydragWindow() {
        var div1 = window.parent.document.getElementById(geturl());
        if (div1 && event.button == 0 && dragEnable == 'True') {
            window.parent.mydragWindow(div1, event);
        }
    }

    function mystopDragWindow() {
        var div1 = window.parent.document.getElementById(geturl());
        if (div1 && event.button == 0 && dragEnable == 'True') {
            window.parent.mystopDragWindow(div1); div1.style.border = "0px";
        }
    }
    //窗口拖动的onload()被defaultOnload()取代，将代码放进defaultOnload()中------------xzj--2018/6/29--------------------------
    function defaultOnload() {
        var EntityNameTextBox = document.getElementById("TextBox1");
        EntityNameTextBox.onblur = function () {
            var EntityName = $("#TextBox1").val();
            if (EntityName != "") {
                checkEntityName();
            }
        };
        //窗口拖动的onload()被defaultOnload()取代，将代码放进defaultOnload()中------------xzj--2018/6/29--------------------------
        document.body.onclick = function () {
            //alert();
            //var div2 = window.parent.document.getElementById(geturl());
            //window.parent.windowDivOnClick(div2);
        }
        document.body.onmousedown = function () {
            var div2 = window.parent.document.getElementById(geturl());

            window.parent.windowDivOnClick(div2);
            dragdiv();
        }
        document.body.onmousemove = function () { mydragWindow(); }
        document.body.onmouseup = function () { mystopDragWindow(); }
        document.body.oncontextmenu = function () { return false; }
        var arrayelement = ["input", "a", "select", "li", "font", "textarea"];
        for (n = 0; n < arrayelement.length; n++) {
            var inputs = document.getElementsByTagName(arrayelement[n]);
            for (i = 0; i < inputs.length; i++) {
                inputs[i].onmouseout = function () {
                    dragEnable = 'True';
                }
                inputs[i].onmouseover = function () {
                    dragEnable = 'False';
                }
            }
        }
        var table = document.getElementById("dragtd");
        table.onmouseout = function () {
            dragEnable = 'True';
        }

        table.onmouseover = function () {
            dragEnable = 'False';
        }
        //窗口拖动的onload()被defaultOnload()取代，将代码放进defaultOnload()中------------xzj--2018/6/29--------------------------
    }
</script>
<style type="text/css">
    .ajax__validatorcallout_error_message_cell
    {
        font-size: 12px;
    }
</style>
