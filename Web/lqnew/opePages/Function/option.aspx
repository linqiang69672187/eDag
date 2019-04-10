<%@ Page Language="C#" ValidateRequest="false " AutoEventWireup="true" CodeBehind="option.aspx.cs"
    Inherits="Web.lqnew.opePages.Function.Option" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server" id="Head1">
    <title></title>
    <script src="../../../lqnew/js/lq_new.js" type="text/javascript"></script>
    <script src="../../../lqnew/js/Rediocall.js" type="text/javascript"></script>
    <script src="../../js/GlobalVar.js" type="text/javascript"></script>
    <script src="../../../LangJS/option.js" type="text/javascript"></script>
    <script src="../../../JS/LangueSwitch.js" type="text/javascript"></script>
    <script src="/JQuery/jquery-1.5.2.js" type="text/javascript"></script>
    <script type="text/javascript">
        function Divover(obj, str) {
            var div1 = obj;
            div1.style.backgroundPosition = str;
        }
        function UploadPic() {

            var fileName = window.showModalDialog("../UpLoad/MapBackPicUpLoad.aspx?id=23&type=23&name=MapBackPic", window.parent.parent, "help:no;status:no;dialogWidth=465px;dialogHeight=120px");
            var Uploadfailed = window.parent.parent.GetTextByName("Uploadfailed", window.parent.parent.useprameters.languagedata);
            if (fileName != Uploadfailed && fileName != undefined) {
                alert(window.parent.parent.GetTextByName("load_success_and_picture_valid", window.parent.parent.useprameters.languagedata));
                document.getElementById("TabContainer1_TabPanel1_mapbackpic").src = "../UpLoad/ReadImage.aspx?name=MapBackPic&type=MapBackPic&p=" + GetRandomNum(1, 1000000);

            } else {
            }
        }



    </script>
   
    <style type="text/css">
        body {
            margin: 0px;
            background-color: transparent;
            font-size: 12px;
        }

        table {
            background-color: #FFFFFF;
        }

        .style1 {
            width: 100%;
        }

        .style2 {
            width: 7px;
            height: 19px;
        }

        .style3 {
            width: 7px;
            height: 34px;
        }

        .bg1 {
            background: url('../images/CallOutInfo_07.png') repeat-y;
        }

        .bg2 {
            background: url('../images/CallOutInfo_02.png') repeat-x;
        }

        .bg3 {
            background: url('../images/CallOutInfo_10.png') repeat-y;
        }

        .bg4 {
            background: url('../images/CallOutInfo_13.png') repeat-x;
        }

        #divClose {
            width: 33px;
            height: 16px;
            position: relative;
            border: 0px;
            float: right;
            margin-top: 1px;
            background-image: url('../../view_infoimg/images/minidict_03.png');
            cursor: hand;
        }

        #info_title {
            float: left;
            padding-top: 2px;
            height: 16px;
            font-weight: bold;
        }

        #btn1, #btn2 {
            width: 46px;
            height: 20px;
            float: right;
            margin-right: 20px;
            background: url('../../images/outinfo_button.png') no-repeat 0 0;
            text-align: center;
            vertical-align: middle;
            line-height: 22px;
            cursor: hand;
        }

        .style4 {
            background: url('../images/CallOutInfo_02.png') repeat-x;
            height: 19px;
        }

        #TabContainer1 {
            margin: 5px;
        }

        .titlefont {
            font-weight: bold;
            color: #25892d;
            height: 60px; width:120px;
        }
        .titlefont1 {
            font-weight: bold;
            color: #25892d;
            height: 30px;
        }
        a {
            color: Black;
            text-decoration: none;
        }
        .errfont {
             color: red;
        }
        #Lang_userHeadInfo_main td {white-space: nowrap
}
        .bsHeadInfoCheckBox
        {
            margin-left:30px;
        }
    </style>

</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
         <script type="text/javascript">

             function checkOption() {
                 var result;

                 var tempBKDistance = $("#<%=txtBKDistance.ClientID%>").val().trim();

                 var temp0 = $("#<%=txtKey0.ClientID%>").val().trim();
                 var temp1 = $("#<%=txtKey1.ClientID%>").val().trim();
                 var temp2 = $("#<%=txtKey2.ClientID%>").val().trim();
                 var temp3 = $("#<%=txtKey3.ClientID%>").val().trim();
                 var temp4 = $("#<%=txtKey4.ClientID%>").val().trim();
                 var temp5 = $("#<%=txtKey5.ClientID%>").val().trim();
                 var temp6 = $("#<%=txtKey6.ClientID%>").val().trim();
                 var temp7 = $("#<%=txtKey7.ClientID%>").val().trim();
                 var temp8 = $("#<%=txtKey8.ClientID%>").val().trim();
                 var temp9 = $("#<%=txtKey9.ClientID%>").val().trim();
                 var myreg = /^[0-9]*[1-9][0-9]*$/;

                 var userHeadInfoCheckCount = 0;
                 var userHeadInfo = this.document.getElementById("<%=userHeadInfoList.ClientID%>");
                 var chks = userHeadInfo.getElementsByTagName("input");
                 for (var i = 0; i < chks.length; i++) {
                     if (chks[i] != null && chks[i].type == 'checkbox' && chks[i].checked)
                     { userHeadInfoCheckCount++ }

                 }


                 if (userHeadInfoCheckCount == 0) {
                     var ctrl = $find("TabContainer1");
                     var tabpanel = ctrl.get_tabs()[1];
                     ctrl.set_activeTab(tabpanel);
                     $("#userHeadInfoYz").html(window.parent.GetTextByName("UserHeadInfoMustChooseOneItem", window.parent.useprameters.languagedata));
                     $("#<%=userHeadInfoList.ClientID%>").focus();
                     $("#trUserHeadInfo").show();
                     result = false;
                     return result;
                 }
                 else if (userHeadInfoCheckCount > 2) {
                     var ctrl = $find("TabContainer1");
                     var tabpanel = ctrl.get_tabs()[1];
                     ctrl.set_activeTab(tabpanel);
                     $("#userHeadInfoYz").html(window.parent.GetTextByName("UserHeadInfoMostChooseTwoItem", window.parent.useprameters.languagedata));
                     $("#<%=userHeadInfoList.ClientID%>").focus();
                     $("#trUserHeadInfo").show();
                     result = false;
                     return result;
                 }
                 else {
                     $("#trUserHeadInfo").hide();
                     $("#userHeadInfoYz").html(null);
                 }

             if (!myreg.test(tempBKDistance)) {

                 var ctrl = $find("TabContainer1");
                 var tabpanel = ctrl.get_tabs()[2];
                 ctrl.set_activeTab(tabpanel);
                 $("#cxbkYz").html(window.parent.GetTextByName("IllegalNum", window.parent.useprameters.languagedata));
                 $("#<%=txtBKDistance.ClientID%>").focus();
                     result = false;
                     return result;
                 }

                 if (tempBKDistance > 1000) {

                     var ctrl = $find("TabContainer1");
                     var tabpanel = ctrl.get_tabs()[2];
                     ctrl.set_activeTab(tabpanel);
                     $("#cxbkYz").html(window.parent.GetTextByName("CXBKRange", window.parent.useprameters.languagedata));
                     $("#<%=txtBKDistance.ClientID%>").focus();
                     result = false;
                     return result;
                 }

                 if (temp0 != null && temp0 != "" && !myreg.test(temp0)) {
                     var ctrl = $find("TabContainer1");
                     var tabpanel = ctrl.get_tabs()[3];
                     ctrl.set_activeTab(tabpanel);
                     $("#keyYZ").html(window.parent.GetTextByName("Lang_key0Error", window.parent.useprameters.languagedata));
                     $("#<%=txtKey0.ClientID%>").focus();
                     result = false;
                     return result;
                 }
                 if (temp1 != null && temp1 != "" && !myreg.test(temp1)) {

                     var ctrl = $find("TabContainer1");
                     var tabpanel = ctrl.get_tabs()[3];
                     ctrl.set_activeTab(tabpanel);
                     $("#keyYZ").html(window.parent.GetTextByName("Lang_key1Error", window.parent.useprameters.languagedata));
                     $("#<%=txtKey1.ClientID%>").focus();
                     result = false;
                     return result;
                 }
                 if (temp2 != null && temp2 != "" && !myreg.test(temp2)) {

                     var ctrl = $find("TabContainer1");
                     var tabpanel = ctrl.get_tabs()[3];
                     ctrl.set_activeTab(tabpanel);
                     $("#keyYZ").html(window.parent.GetTextByName("Lang_key2Error", window.parent.useprameters.languagedata));
                     $("#<%=txtKey2.ClientID%>").focus();
                     result = false;
                     return result;
                 }
                 if (temp3 != null && temp3 != "" && !myreg.test(temp3)) {

                     var ctrl = $find("TabContainer1");
                     var tabpanel = ctrl.get_tabs()[3];
                     ctrl.set_activeTab(tabpanel);
                     $("#keyYZ").html(window.parent.GetTextByName("Lang_key3Error", window.parent.useprameters.languagedata));
                     $("#<%=txtKey3.ClientID%>").focus();
                     result = false;
                     return result;
                 }
                 if (temp4 != null && temp4 != "" && !myreg.test(temp4)) {

                     var ctrl = $find("TabContainer1");
                     var tabpanel = ctrl.get_tabs()[3];
                     ctrl.set_activeTab(tabpanel);
                     $("#keyYZ").html(window.parent.GetTextByName("Lang_key4Error", window.parent.useprameters.languagedata));
                     $("#<%=txtKey4.ClientID%>").focus();
                     result = false;
                     return result;
                 }
                 if (temp5 != null && temp5 != "" && !myreg.test(temp5)) {

                     var ctrl = $find("TabContainer1");
                     var tabpanel = ctrl.get_tabs()[3];
                     ctrl.set_activeTab(tabpanel);
                     $("#keyYZ").html(window.parent.GetTextByName("Lang_key5Error", window.parent.useprameters.languagedata));
                     $("#<%=txtKey5.ClientID%>").focus();
                     result = false;
                     return result;
                 }
                 if (temp6 != null && temp6 != "" && !myreg.test(temp6)) {

                     var ctrl = $find("TabContainer1");
                     var tabpanel = ctrl.get_tabs()[3];
                     ctrl.set_activeTab(tabpanel);
                     $("#keyYZ").html(window.parent.GetTextByName("Lang_key6Error", window.parent.useprameters.languagedata));
                     $("#<%=txtKey6.ClientID%>").focus();
                     result = false;
                     return result;
                 }
                 if (temp7 != null && temp7 != "" && !myreg.test(temp7)) {

                     var ctrl = $find("TabContainer1");
                     var tabpanel = ctrl.get_tabs()[3];
                     ctrl.set_activeTab(tabpanel);
                     $("#keyYZ").html(window.parent.GetTextByName("Lang_key7Error", window.parent.useprameters.languagedata));
                     $("#<%=txtKey7.ClientID%>").focus();
                     result = false;
                     return result;
                 }
                 if (temp8 != null && temp8 != "" && !myreg.test(temp8)) {

                     var ctrl = $find("TabContainer1");
                     var tabpanel = ctrl.get_tabs()[3];
                     ctrl.set_activeTab(tabpanel);
                     $("#keyYZ").html(window.parent.GetTextByName("Lang_key8Error", window.parent.useprameters.languagedata));
                     $("#<%=txtKey8.ClientID%>").focus();
                     result = false;
                     return result;
                 }
                 if (temp9 != null && temp9 != "" && !myreg.test(temp9)) {

                     var ctrl = $find("TabContainer1");
                     var tabpanel = ctrl.get_tabs()[3];
                     ctrl.set_activeTab(tabpanel);
                     $("#keyYZ").html(window.parent.GetTextByName("Lang_key9Error", window.parent.useprameters.languagedata));
                     $("#<%=txtKey9.ClientID%>").focus();
                     result = false;
                     return result;
                 }
                 return result;
             }

            </script>
        <div>
            <table cellpadding="0" cellspacing="0" class="style1">
                <tr>
                    <td class="style2">
                        <img src="../images/CallOutInfo_01.png" />
                    </td>
                    <td class="style4">
                        <div id="info_title" runat="server">
                        </div>
                        <div id="divClose" onmouseover="Divover(this,'66 0')" onclick="window.parent.retoptionbg();window.parent.lq_closeANDremovediv('Function/option','bgDiv');"
                            onmouseout="Divover(this,'0 0')">
                        </div>
                    </td>
                    <td class="style2">
                        <img src="../images/CallOutInfo_04.png" />
                    </td>
                </tr>
                <tr>
                    <td class="bg1">&nbsp;
                         </td>
                    <td id="dragtd">
                        <cc1:TabContainer ID="TabContainer1" runat="server" ActiveTabIndex="0">
                            <cc1:TabPanel runat="server" HeaderText="TabPanel1" ID="TabPanel1">
                                <ContentTemplate>
                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td id="ToBesureSave" colspan="2" class="titlefont"></td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">
                                                <img src="../images/sr.gif" />
                                            </td>
                                        </tr>

                                        <tr>
                                            <td id="Hidden" class="titlefont"></td>
                                            <td>

                                                <asp:CheckBox ID="CheckBox2" runat="server" />
                                                <asp:CheckBox ID="BSHeadInfoCheckBox" runat="server" CssClass="bsHeadInfoCheckBox"/>

                                            </td>

                                        </tr>

                                                                                <tr>
                                            <td colspan="2">
                                                <img src="../images/sr.gif" />
                                            </td>
                                        </tr>
                                        <tr><%--xzj--20190320--添加呼叫加密参数--%>
                                            <td id="callEncryption" class="titlefont"></td>
                                                <td>
                                                    <asp:CheckBoxList ID="cblCallEncryption" RepeatDirection="Horizontal" runat="server">
                                                        <asp:ListItem Value="Single"></asp:ListItem>
                                                        <asp:ListItem Value="Group" ></asp:ListItem>
                                                    </asp:CheckBoxList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2">
                                                    <img src="../images/sr.gif" />
                                                </td>
                                            </tr>

                                           <tr>
                                            <td id="PoliceType" class="titlefont"></td>
                                            <td>
                                              <asp:DropDownList ID="PoliceTypeList" runat="server">
                                                    <asp:ListItem></asp:ListItem>
                                                    <asp:ListItem></asp:ListItem>
                                                    <asp:ListItem></asp:ListItem>
                                                </asp:DropDownList>
                                            </td>

                                        </tr>
                                        <%--cxy-20180730-基站是否聚合显示配置信息--%>
                                        <tr>
                                            <td colspan="2">
                                                <img src="../images/sr.gif" />
                                            </td>
                                        </tr>

                                        <tr>
                                            <td id="ClusterType" class="titlefont"></td>
                                            <td>
                                                <asp:RadioButton ID="isCluster" GroupName="IsCluster" runat="server" />
                                                <asp:RadioButton ID="notCluster" GroupName="IsCluster" runat="server" />
                                            </td>

                                        </tr>

                                        <tr>
                                            <td colspan="2">
                                                <img src="../images/sr.gif" />
                                            </td>
                                        </tr>

                                        <tr>
                                            <td id="MapFresh" class="titlefont"></td>
                                            <td>
                                                <asp:DropDownList ID="DropDownList1" runat="server">
                                                    <asp:ListItem Selected="True" Value="10">10</asp:ListItem>
                                                    <asp:ListItem Value="30">30</asp:ListItem>
                                                    <asp:ListItem Value="60">60</asp:ListItem>
                                                </asp:DropDownList>

                                                <span id="Sencond"></span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">
                                                <img src="../images/sr.gif" />
                                            </td>
                                        </tr>
                                        <tr style="display: none">
                                            <td id="Info" class="titlefont"></td>
                                            <td>
                                                <asp:CheckBox ID="viewinfo" runat="server" />

                                                <span id="Display"></span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">
                                                <img src="../images/sr.gif" />
                                            </td>
                                        </tr>

                                        <tr>
                                            <td id="MapBackgroundPicture" class="titlefont"></td>
                                            <td>
                                                <img id="mapbackpic" runat="server" style="width: 15px; height: 15px" />

                                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span id="Upload" style="color: Red; cursor: pointer" onclick="UploadPic()"></span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">
                                                <img src="../images/sr.gif" />
                                            </td>
                                        </tr>
                                    </table>

                                </ContentTemplate>

                            </cc1:TabPanel>
                            <cc1:TabPanel runat="server" HeaderText="TabPanel2" ID="TabPanel2">
                                <ContentTemplate>
                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td id="ToBesureSave2" colspan="2" class="titlefont"></td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">
                                                <img src="../images/sr.gif" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td id="Terminalsettings" class="titlefont"></td>
                                            <td>
                                                <span id="DeviceOverTime"></span>
                                                <asp:DropDownList ID="DropDownList2" runat="server">
                                                    <asp:ListItem>5</asp:ListItem>
                                                    <asp:ListItem>10</asp:ListItem>
                                                    <asp:ListItem Selected="True">15</asp:ListItem>
                                                    <asp:ListItem>30</asp:ListItem>
                                                    <asp:ListItem>60</asp:ListItem>
                                                </asp:DropDownList>

                                                <span id="minute"></span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">
                                                <img src="../images/sr.gif" />
                                            </td>
                                        </tr>
                                  

                                        <tr>














                                            <td id="Bubble_usermessage" class="titlefont"></td>
                                             <td>
                                               
                                                <asp:CheckBoxList ID="usermessage" RepeatDirection="Horizontal" RepeatColumns="5" runat="server">
                                                    <asp:ListItem Value="Unit">Unit</asp:ListItem>
                                                    <asp:ListItem Value="Longitude">Longitude</asp:ListItem>
                                                    <asp:ListItem Value="Latitude">Latitude</asp:ListItem>
                                                    <asp:ListItem Value="GPSStatus">GPSStatus</asp:ListItem>
                                                    <asp:ListItem Value="SendMSGTIME">SendMSGTIME</asp:ListItem>

                                                    <asp:ListItem Value="telephone">telephone</asp:ListItem>
                                                    <asp:ListItem Value="position">position</asp:ListItem>
                                                    <asp:ListItem Value="Remark">Remark</asp:ListItem>
                                                   <asp:ListItem Value="TerminalType">TerminalType</asp:ListItem>
                                                   <asp:ListItem Value="Battery">battery</asp:ListItem><%--xzj--20181224--添加场强信息--手台电量--%>

                                                   <asp:ListItem Value="MsRssi">msRssi</asp:ListItem><%--手台场强--%>
                                                  <asp:ListItem Value="UlRssi">ulRssi</asp:ListItem><%--上行场强--%>
                                                </asp:CheckBoxList>
                                            </td>
                                        </tr>

                                        <tr>
                                            <td colspan="2">
                                                <img src="../images/sr.gif" />
                                            </td>
                                        </tr>

                                       <tr>
                                            <td id="Lang_userHeadInfo" class="titlefont"></td>
                                               <td id="Lang_userHeadInfo_main">

                                               
                                                <asp:CheckBoxList ID="userHeadInfoList" RepeatDirection="Horizontal" runat="server">
                                                    <asp:ListItem Value="name">name</asp:ListItem>
                                                    <asp:ListItem Value="ISSI">ISSI</asp:ListItem>
                                                    <asp:ListItem Value="Num">Num</asp:ListItem>
                                                    <asp:ListItem Value="Unit">Unit</asp:ListItem>
                                                    <asp:ListItem Value="TerminalType">TerminalType</asp:ListItem>
                                                </asp:CheckBoxList>
                                            </td>
                                        </tr>
                                        <%--cxy-20180809-添加场强控制--%>
                                        <tr>
                                            <td colspan="2">
                                                <img src="../images/sr.gif" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td id="Lang_fieldStrength" class="titlefont"></td>
                                               <td id="Lang_fieldStrength_main">

                                               
                                                <asp:CheckBoxList ID="fieldStrengthList" RepeatDirection="Horizontal" runat="server">
                                                    <asp:ListItem Value="energy"></asp:ListItem>
                                                    <asp:ListItem Value="signalup"></asp:ListItem>
                                                    <asp:ListItem Value="signaldown"></asp:ListItem>
                                                </asp:CheckBoxList>
                                            </td>
                                        </tr>

                                        <tr>
                                            <td colspan="2">
                                                <img src="../images/sr.gif" />
                                            </td>
                                        </tr>
                                         <tr id="trUserHeadInfo" style="display:none;">
                                            <td id="Td1"></td>
                                            <td>
                                               <span  class="errfont" id="userHeadInfoYz"></span> 
                                            </td>
                                        </tr>
                                        <tr>
                                            <td id="Lang_OpenUserHeaderInfo" class="titlefont"></td>
                                            <td>
                                                <asp:RadioButtonList ID="UserHeaderInfoSwitch" runat="server" RepeatDirection="Horizontal">
                                                    <asp:ListItem Value="open"></asp:ListItem>
                                                    <asp:ListItem Value="close"></asp:ListItem>
                                                </asp:RadioButtonList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">
                                                <img src="../images/sr.gif" />
                                            </td>
                                        </tr>
                                        <tr style="display:none;">
                                            <td id="Lang_UserHeaderInfo_StatuesMSG" class="titlefont"></td>
                                            <td>
                                                <asp:CheckBox ID="Mode_name" runat="server" />

                                                <asp:CheckBox ID="Mode_ISSI" runat="server" />

                                            </td>
                                        </tr>
                                        <tr style="display:none;">
                                            <td colspan="2">
                                                <img src="../images/sr.gif" />
                                            </td>
                                        </tr>

                                        <tr>
                                            <td id="Lang_voiceType" class="titlefont"></td>
                                            <td>
                                                <asp:RadioButtonList ID="voiceType" runat="server" RepeatDirection="Horizontal">
                                                    <asp:ListItem Value="1">TETRA</asp:ListItem>
                                                    <asp:ListItem Value="2">LTE</asp:ListItem>
                                                    <asp:ListItem Value="3">PDT</asp:ListItem>
                                                </asp:RadioButtonList>

                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">
                                                <img src="../images/sr.gif" />
                                            </td>
                                        </tr>
                                    </table>
                                </ContentTemplate>
                            </cc1:TabPanel>

                            <cc1:TabPanel ID="TabPanel3" runat="server" HeaderText="TabPanel3">
                                <ContentTemplate>
                                    <table style="width: 100%;">
                                        <tr style="height: 25px;">
                                            <td class="titlefont" style="width: 20%">&nbsp;<span id="Kilometres"></span></td>
                                            <td colspan="2">&nbsp<asp:TextBox ID="txtBKDistance" runat="server" Width="83px"></asp:TextBox>
                                                <span id="KilometresUnit"></span></td>
                                        </tr>
                                        <tr style="height: 20px;">
                                            <td>&nbsp;</td>
                                            <td colspan="2" style="vertical-align: text-top; text-align: left;">
                                                                                  <span  class="errfont" id="cxbkYz"></span>       </td>
                                        </tr>
                                        <tr>
                                            <td>&nbsp;</td>
                                            <td>&nbsp;</td>
                                            <td>&nbsp;</td>
                                        </tr>
                                    </table>

                                </ContentTemplate>
                            </cc1:TabPanel>
                           
                            <cc1:TabPanel ID="TabPanel4" runat="server">
                                <ContentTemplate>
                                    <table style="width: 100%;">
                                         <tr style="height: 15px;">
                                           <td>&nbsp;</td>
                                           
                                        </tr>
                                        <tr style="height: 25px;">
                                            <td class="titlefont1" style="width: 15%;padding-left:15px;">&nbsp;<span id="Lang_key0">键"0"</span></td>
                                            <td>&nbsp<asp:TextBox ID="txtKey0" runat="server" Width="93px"></asp:TextBox>
                                                </td>
                                            <td class="titlefont1" style="width: 15%">&nbsp;<span id="Lang_key1">键"1"</span></td>
                                            <td>&nbsp<asp:TextBox ID="txtKey1" runat="server" Width="93px"></asp:TextBox>
                                                </td>
                                        </tr>
                                        <tr style="height: 25px;">
                                          <td class="titlefont1" style="width: 15%;padding-left:15px;">&nbsp;<span id="Lang_key2">键"2"</span></td>
                                            <td>&nbsp<asp:TextBox ID="txtKey2" runat="server" Width="93px"></asp:TextBox>
                                                </td>
                                            <td class="titlefont1" style="width: 15%">&nbsp;<span id="Lang_key3">键"3"</span></td>
                                            <td>&nbsp<asp:TextBox ID="txtKey3" runat="server" Width="93px"></asp:TextBox>
                                               </td>
                                        </tr>
                                        <tr style="height: 25px;">
                                            <td class="titlefont1" style="width: 15%;padding-left:15px;">&nbsp;<span id="Lang_key4">键"4"</span></td>
                                            <td>&nbsp<asp:TextBox ID="txtKey4" runat="server" Width="93px"></asp:TextBox>
                                                <span id="Span6"></span></td>
                                            <td class="titlefont1" style="width: 15%">&nbsp;<span id="Lang_key5">键"5"</span></td>
                                            <td>&nbsp<asp:TextBox ID="txtKey5" runat="server" Width="93px"></asp:TextBox>
                                                <span id="Span14"></span></td>
                                        </tr>
                                        <tr style="height: 25px;">
                                          <td class="titlefont1" style="width: 15%;padding-left:15px;">&nbsp;<span id="Lang_key6">键"6"</span></td>
                                            <td>&nbsp<asp:TextBox ID="txtKey6" runat="server" Width="93px"></asp:TextBox>
                                                </td>
                                            <td class="titlefont1" style="width: 15%">&nbsp;<span id="Lang_key7">键"7"</span></td>
                                            <td>&nbsp<asp:TextBox ID="txtKey7" runat="server" Width="93px"></asp:TextBox>
                                                </td>
                                        </tr>
                                        <tr style="height: 25px;">
                                           <td class="titlefont1" style="width: 15%;padding-left:15px;">&nbsp;<span id="Lang_key8">键"8"</span></td>
                                            <td>&nbsp<asp:TextBox ID="txtKey8" runat="server" Width="93px"></asp:TextBox>
                                               </td>
                                            <td class="titlefont1" style="width: 15%">&nbsp;<span id="Lang_key9">键"9"</span></td>
                                            <td>&nbsp<asp:TextBox ID="txtKey9" runat="server" Width="93px"></asp:TextBox>
                                                </td>
                                        </tr>
                                         <tr style="height: 25px;">
                                           <td class="titlefont1" style="width: 10%">&nbsp;</td>
                                            <td style="width:100%;" colspan="3"><span class="errfont" id="keyYZ"></span></td>
                                           
                                        </tr>
                                         <tr style="height: 25px;">
                                           <td class="titlefont1" style="width: 10%">&nbsp;</td>
                                            <td style="width:100%;" colspan="3"></td>
                                           
                                        </tr>
                                    </table>

                                </ContentTemplate>
                            </cc1:TabPanel>

                        </cc1:TabContainer>
                    </td>
                    <td class="bg3">&nbsp;
                    </td>
                </tr>
                <tr>
                    <td class="style3">
                        <img src="../images/CallOutInfo_12.png" />
                    </td>
                    <td class="bg4" align="right">
                        <div id="btn1" onmouseover="Divover(this,'-47 -0')" onclick="window.parent.retoptionbg();window.parent.lq_closeANDremovediv('Function/option','bgDiv');"
                            onmouseout="Divover(this,'0 -0')">
                        </div>
                        <div id="btn2" onmouseover="Divover(this,'-47 0')" onmouseout="Divover(this,'0 0')">

                            <asp:Button ID="Button1" Style="background-color: transparent; border: 0; margin-top: 2px"
                                runat="server" Text="" OnClientClick="return checkOption();" OnClick="Button1_Click" />

                        </div>

                    </td>
                    <td>
                        <img src="../images/CallOutInfo_14.png" />
                    </td>
                </tr>
            </table>
        </div>

    </form>
</body>
</html>
<link href="../../../CSS/lq_calloutExtender.css" rel="stylesheet" type="text/css" />
<script>
    var dragEnable = 'True';
    function dragdiv() {
        var div1 = window.parent.document.getElementById('Function/option');
        if (div1 && event.button == 0 && dragEnable == 'True') {
            window.parent.mystartDragWindow(div1, null, event); div1.style.border = "solid 3px transparent"; window.parent.cgzindex(div1);

        }
    }
    function mydragWindow() {
        var div1 = window.parent.document.getElementById('Function/option');
        if (div1) {
            window.parent.mydragWindow(div1, event);
        }
    }

    function mystopDragWindow() {
        var div1 = window.parent.document.getElementById('Function/option');
        if (div1) {
            window.parent.mystopDragWindow(div1); div1.style.border = "0px";
        }
    }
    window.onload = function () {
        // document.getElementById('Button1').value = "dfdfd";

        // alert(window.parent.GetTextByName("Terminalsettings", window.parent.useprameters.languagedata));
        //document.getElementById("han_setzhongduan").innerHTML = window.parent.GetTextByName("Terminalsettings", window.parent.useprameters.languagedata);
        //LanguageSwitch(window.parent);
        setUserHeadInfoRadioSelectedValue();

        replace_chineseName();
        document.getElementById("TabContainer1_TabPanel1_mapbackpic").src = "../UpLoad/ReadImage.aspx?name=MapBackPic&type=MapBackPic&p=" + GetRandomNum(1, 1000000);
        document.body.onmousedown = function () { dragdiv(); }
        document.body.onmousemove = function () { mydragWindow(); }
        document.body.onmouseup = function () { mystopDragWindow(); }
        document.body.oncontextmenu = function () { return false; }
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
    }

    window.parent.closeprossdiv();

    function setUserHeadInfoRadioSelectedValue() {

        var puserHeadInfo = window.parent.useprameters.userHeadInfo;
        var headInfoItem1 = "";
        var headInfoItem2 = "";
        if (puserHeadInfo.indexOf("|") != -1) {
            headInfoItem1 = puserHeadInfo.split("|")[0];
            headInfoItem2 = puserHeadInfo.split("|")[1];
        }
        else {
            headInfoItem1 = puserHeadInfo;
        }
        var userHeadInfo = this.document.getElementById("<%=userHeadInfoList.ClientID%>");
        var chks = userHeadInfo.getElementsByTagName("input");
        for (var i = 0; i < chks.length; i++) {
            if (chks[i] != null && chks[i].type == 'checkbox') {
                if (chks[i].value == headInfoItem1 || chks[i].value == headInfoItem2) {
                    chks[i].checked = true;
                }

            }

        }
    }

</script>
