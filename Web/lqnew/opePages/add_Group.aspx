<%@ Page Language="C#" AutoEventWireup="true" ValidateRequest="false" CodeBehind="add_Group.aspx.cs" Inherits="Web.lqnew.opePages.add_Group" %>


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
    <script src="../../LangJS/managerGroup_langjs.js" type="text/javascript"></script>
    <script src="/lqnew/js/pdtCode.js" type="text/javascript"></script>
    <script src="/lqnew/js/CommValidator.js" type="text/javascript"></script>
    <script type="text/javascript">
        function init() {
            this.parent.$("#add_Group").height(800);
            this.parent.$("#add_Group_ifr").height(800);
        }
        //终端类型选择
        function TerminalTypeChange(obj) {
            // add_ISSI     
            init();
            var options = $("#" + obj + " option:selected"); //获取选中的项 
            var val = options.val();
            if (val == "PDT") {
                // alert(val);
                $("#trPdtRule").show();
                var pdtRuleVale = $('input:radio[name="radPdtRule"]:checked').val();
                // alert(pdtRuleVale);
                if (pdtRuleVale == 1) {
                    $("#trPdtBzNum").show();
                    $("#trPdtArea").hide();
                    $("#trPdtZjNum").hide();
                }
                else {
                    $("#trPdtBzNum").hide();
                    $("#trPdtArea").show();
                    $("#trPdtZjNum").show();
                }
            }
            else {
                $("#trPdtRule").hide();
                $("#trPdtBzNum").hide();
                $("#trPdtArea").hide();
                $("#trPdtZjNum").hide();
            }
        }

        //拔号规则选择
        function radPdtRuleChange(obj) {
            // alert(obj);
            $("#<% =hidPdtRule.ClientID %>").val(obj);
            if (obj == 1) {
                $("#trPdtBzNum").show();
                $("#trPdtArea").hide();
                $("#trPdtZjNum").hide();
                $('#txtBz1').blur(function () {
                    var val1 = $("#txtBz1").val();
                    var val2 = $("#txtBz2").val();
                    var val3 = $("#txtBz3").val();
                    if (val1 != "" && val2 != "" && val3 != "" && !isNaN(val1) && !isNaN(val2) && !isNaN(val3)) {
                        var valpdbBz = group_marks_to_id_bz(val1 + val2 + val3);
                        $("#<% =TextBox4.ClientID %>").val(valpdbBz);
                    }
                });
                $('#txtBz2').blur(function () {
                    var val1 = $("#txtBz1").val();
                    var val2 = $("#txtBz2").val();
                    var val3 = $("#txtBz3").val();
                    if (val1 != "" && val2 != "" && val3 != "" && !isNaN(val1) && !isNaN(val2) && !isNaN(val3)) {
                        var valpdbBz = group_marks_to_id_bz(val1 + val2 + val3);
                        $("#<% =TextBox4.ClientID %>").val(valpdbBz);
                    }
                });
                $('#txtBz3').blur(function () {
                    var val1 = $("#txtBz1").val();
                    var val2 = $("#txtBz2").val();
                    var val3 = $("#txtBz3").val();
                    if (val1 != "" && val2 != "" && val3 != "" && !isNaN(val1) && !isNaN(val2) && !isNaN(val3)) {
                        var valpdbBz = group_marks_to_id_bz(val1 + val2 + val3);
                        $("#<% =TextBox4.ClientID %>").val(valpdbBz);
                    }
                });

                $("#<% =TextBox4.ClientID %>").blur(function () {
                    var val = $("#<% =TextBox4.ClientID %>").val();
                    if (val != "" && !isNaN(val)) {
                        var pdtNum = group_id_to_marks_bz(val);
                        //alert(pdtNum);
                        if (pdtNum != null) {
                            $("#txtBz1").val(pdtNum.substr(0, 3));
                            $("#txtBz2").val(pdtNum.substr(3, 2));
                            $("#txtBz3").val(pdtNum.substr(5, 3));
                        }
                        else {
                            $("#txtBz1").val("");
                            $("#txtBz2").val("");
                            $("#txtBz3").val("");
                        }
                    }
                });

                $("#hidBzPdtNum").val($("#txtBz1").val() + $("#txtBz2").val() + $("#txtBz3").val());
            }
            else if (obj == 2) {
                $("#trPdtBzNum").hide();
                $("#trPdtArea").show();
                $("#trPdtZjNum").show();
                $("#txtDanHu").blur(function () {
                    var optionsArea = $("#<% =dropArea.ClientID %> option:selected"); //获取选中的项 
                    var val = optionsArea.val();
                    var val1 = $("#txtDanHu").val();

                    //验证单呼范围
                    if (val1 != "" && !isNaN(val1)) {
                        if (val1 >= 90000 && val1 <= 99999) {
                            $("#spZjDhh").hide();
                            var valpdbBz = grouppdtToId_zj(val + val1);
                            $("#<% =TextBox4.ClientID %>").val(valpdbBz);
                        }
                        else {
                            $("#spZjDhh").html("<BR/>" + window.parent.GetTextByName("ClassifyGroupRange", window.parent.useprameters.languagedata));
                            $("#spZjDhh").show();
                        }
                    }
                    else {
                        $("#spZjDhh").html("<BR/>" + window.parent.GetTextByName("ClassifyGroupRange", window.parent.useprameters.languagedata));
                        $("#spZjDhh").show();

                    }
                });

                $("#<% =TextBox4.ClientID %>").blur(function () {
                    var val = $("#<% =TextBox4.ClientID %>").val();
                    var valNum = gourpidTopdt_zj(val.trim());
                    //alert(valNum);
                    //alert(valNum.substr(0, 3));
                    if (valNum.substr(0, 3) != "") {
                        $("#<% =dropArea.ClientID %>").val(valNum.substr(0, 3));
                    }
                    var dhh = valNum.substr(3, 5);
                    $("#txtDanHu").val(dhh);

                });

                $("#<% =dropArea.ClientID %>").blur(function () {
                    var options = $("#<% =dropArea.ClientID %> option:selected"); //获取选中的项 
                    var val = options.val();
                    var dhh = $("#txtDanHu").val();
                    var pdtId = $("#<% =TextBox4.ClientID %>").val();
                    if (dhh == "" || isNaN(dhh)) {
                        $("#<% =TextBox4.ClientID %>").val("");
                    }
                    else {
                            var val1 = $("#txtDanHu").val();
                            if (val1 != "" && !isNaN(val1)) {
                                var valpdbBz = grouppdtToId_zj(val + val1);
                                $("#<% =TextBox4.ClientID %>").val(valpdbBz);
                            }

                    }

                });
            }
    }

    //初始化
    $("document").ready(function () {

        var pdtRuleVale = $('input:radio[name="radPdtRule"]:checked').val();
        $("#<% =hidPdtRule.ClientID %>").val(pdtRuleVale);
            // alert(pdtRuleVale);
            if (pdtRuleVale == 1) {
                $('#txtBz1').blur(function () {
                    var val1 = $("#txtBz1").val();
                    var val2 = $("#txtBz2").val();
                    var val3 = $("#txtBz3").val();
                    if (val1 != "" && val2 != "" && val3 != "" && !isNaN(val1) && !isNaN(val2) && !isNaN(val3)) {
                        var valpdbBz = group_marks_to_id_bz(val1 + val2 + val3);
                        $("#<% =TextBox4.ClientID %>").val(valpdbBz);
                }
                $("#hidBzPdtNum").val($("#txtBz1").val() + $("#txtBz2").val() + $("#txtBz3").val());
            });
            $('#txtBz2').blur(function () {
                var val1 = $("#txtBz1").val();
                var val2 = $("#txtBz2").val();
                var val3 = $("#txtBz3").val();
                if (val1 != "" && val2 != "" && val3 != "" && !isNaN(val1) && !isNaN(val2) && !isNaN(val3)) {
                    var valpdbBz = group_marks_to_id_bz(val1 + val2 + val3);
                    $("#<% =TextBox4.ClientID %>").val(valpdbBz);
                }
                $("#hidBzPdtNum").val($("#txtBz1").val() + $("#txtBz2").val() + $("#txtBz3").val());
            });
            $('#txtBz3').blur(function () {
                var val1 = $("#txtBz1").val();
                var val2 = $("#txtBz2").val();
                var val3 = $("#txtBz3").val();
                if (val1 != "" && val2 != "" && val3 != "" && !isNaN(val1) && !isNaN(val2) && !isNaN(val3)) {
                    var valpdbBz = group_marks_to_id_bz(val1 + val2 + val3);
                    $("#<% =TextBox4.ClientID %>").val(valpdbBz);
                }
                $("#hidBzPdtNum").val($("#txtBz1").val() + $("#txtBz2").val() + $("#txtBz3").val());
            });

            $("#<% =TextBox4.ClientID %>").blur(function () {
                var val = $("#<% =TextBox4.ClientID %>").val();
                if (val != "" && !isNaN(val)) {
                    var pdtNum = group_id_to_marks_bz(val);
                    //alert(pdtNum);
                    if (pdtNum != null) {
                        $("#txtBz1").val(pdtNum.substr(0, 3));
                        $("#txtBz2").val(pdtNum.substr(3, 2));
                        $("#txtBz3").val(pdtNum.substr(5, 3));
                    }
                    else {
                        $("#txtBz1").val("");
                        $("#txtBz2").val("");
                        $("#txtBz3").val("");
                    }

                    $("#hidBzPdtNum").val($("#txtBz1").val() + $("#txtBz2").val() + $("#txtBz3").val());
                }
            });

        }
        else if (pdtRuleVale == 2) {
            $("#txtDanHu").blur(function () {
                var optionsArea = $("#<% =dropArea.ClientID %> option:selected"); //获取选中的项 
                var val = optionsArea.val();
                var val1 = $("#txtDanHu").val();
                if (val1 != "" && !isNaN(val1)) {
                    var valpdbBz = grouppdtToId_zj(val + val1);
                    $("#<% =TextBox4.ClientID %>").val(valpdbBz);
                    }

            });

                $("#<% =TextBox4.ClientID %>").blur(function () {
                var val = $("#<% =TextBox4.ClientID %>").val();
                    if (val != "" && !isNaN(val)) {
                        var valNum = gourpidTopdt_zj(val.trim())
                        var dhh = valNum.substr(3, 5);
                        //alert(valNum);
                        //alert(valNum.substr(0, 3));
                        if (valNum.substr(0, 3) != "") {
                            $("#<% =dropArea.ClientID %>").val(valNum.substr(0, 3));
                        }
                        $("#txtDanHu").val(dhh);
                    }
                });

                $("#<% =dropArea.ClientID %>").blur(function () {
                var options = $("#<% =dropArea.ClientID %> option:selected"); //获取选中的项 
                    var val = options.val();
                    var dhh = $("#txtDanHu").val();
                    var pdtId = $("#<% =TextBox4.ClientID %>").val();
                    if (dhh == "" || isNaN(dhh)) {
                        $("#<% =TextBox4.ClientID %>").val("");
                    }
                    else {
                            var val1 = $("#txtDanHu").val();
                            if (val1 != "" && !isNaN(val1)) {
                                var valpdbBz = grouppdtToId_zj(val + val1);
                                $("#<% =TextBox4.ClientID %>").val(valpdbBz);
                            }

                    }

                });
            }
        });

    //提交验证
    function checkTellRule() {
        init();
        var groupNameMust = window.parent.GetTextByName("GroupNameMust", window.parent.useprameters.languagedata);
        var groupNameLengthLimit = window.parent.GetTextByName("errorUnNomal", window.parent.useprameters.languagedata);
        var ClassifyGroupRange = window.parent.GetTextByName("ClassifyGroupRange", window.parent.useprameters.languagedata);
        var GroupBHCRange = window.parent.GetTextByName("GroupBHCRange", window.parent.useprameters.languagedata);

        var result;
        var groupname = $("#<%=TextBox1.ClientID%>").val();
        if (groupname == "") {
            $("#spGroupName").html(groupNameMust);
            $("#spGroupName").show();
            result = false;
            return result;
        }
        else if (getByteLen(groupname) > 10) {
            $("#spGroupName").html(groupNameLengthLimit);
            $("#spGroupName").show();
            result = false;
            return result;
        }
        else {
            $("#spGroupName").hide();
        }

        var issi = $("#<%=TextBox4.ClientID%>").val();
            issi = issi.trim();
            var options = $("#<% =DropDownList_TerminalType.ClientID %> option:selected"); //获取选中的项 
        var val = options.val();
        if (val == "PDT") {
            var pdtRuleVale = $('input:radio[name="radPdtRule"]:checked').val();
            if (pdtRuleVale == "2") {     //浙江规则
                var dhh = $("#txtDanHu").val();
                if (dhh != "" && !isNaN(dhh)) {

                    if (dhh >= 90000 && dhh <= 99999) {
                        var bhc1 = $("#<% =dropArea.ClientID %> option:selected").val() + dhh;
                        // alert(bhc1);
                        // alert($("#<% =TextBox4.ClientID %>").val());
                        if (issi == "" || isNaN(issi)) {
                            $("#spIssi").html("<BR/>" + window.parent.GetTextByName("GroupBHCRange", window.parent.useprameters.languagedata));
                            $("#spIssi").show();
                            result = false;
                        }
                        else if ($("#<% =TextBox4.ClientID %>").val() == bhc1) {
                            $("#spZjDhh").html("<BR/>" + window.parent.GetTextByName("TelNumConvertFail", window.parent.useprameters.languagedata));
                            $("#spZjDhh").show();
                            result = false;
                        }
                        else {
                            $("#spZjDhh").hide();
                            result = true;
                        }
                    }
                    else {
                        $("#spZjDhh").html("<BR/>" + window.parent.GetTextByName("ClassifyGroupRange", window.parent.useprameters.languagedata));
                        $("#spZjDhh").show();
                        result = false;
                    }
                }
                else {
                    $("#spZjDhh").html("<BR/>" + window.parent.GetTextByName("ClassifyGroupRange", window.parent.useprameters.languagedata));
                    $("#spZjDhh").show();
                    result = false;

                }
                return result;
            }
            else {
                //PDT ISSI验证（标准规则）  
                if (issi == "" || isNaN(issi)) {
                    $("#spIssi").html("<BR/>" + window.parent.GetTextByName("GroupBHCRange", window.parent.useprameters.languagedata));
                    $("#spIssi").show();
                    result = false;
                }
                else {
                    if (issi >= 1048577 && issi <= 16718680) {
                        var bhc = $("#txtBz1").val() + $("#txtBz2").val() + $("#txtBz3").val();
                        if (bhc.trim() == "") {
                            result = false;
                            $("#spPdtNum").html("<BR/>" + window.parent.GetTextByName("Lang_pdtNumNotNull", window.parent.useprameters.languagedata));
                            $("#spPdtNum").show();
                        }
                        else if ($("#<% =TextBox4.ClientID %>").val() == bhc) {
                            //alert($("#<% =TextBox4.ClientID %>").val());
                            //txtBz1
                            //alert(bhc);
                            result = false;
                            $("#spIssi").html("<BR/>" + window.parent.GetTextByName("TelNumConvertFail", window.parent.useprameters.languagedata));
                            $("#spIssi").show();
                        }
                        else {
                            $("#spIssi").hide();
                            $("#spPdtNum").hide();
                            result = true;
                        }
                }
                else {
                    result = false;
                    $("#spIssi").html("<BR/>" + window.parent.GetTextByName("GroupBHCRange", window.parent.useprameters.languagedata));
                    $("#spIssi").show();

                }
            }


            return result
        }
    }
    else {
            // Tetra 验证
        if (issi == "" || isNaN(issi)) {
            result = false;
        }
        else {
            if (issi >= 1 && issi <= 16744447)
                result = true;
            else
                result = false;
        }

        if (result) {
            $("#spIssi").hide();
            return true;
        }
        else {
            $("#spIssi").html("<BR/>" + window.parent.GetTextByName("GroupBHCRange", window.parent.useprameters.languagedata));
            $("#spIssi").show();
            return false
        }


    }


}
    </script>
    <style type="text/css">
        .style3 {
            height: 22px;
        }

        #txtBz1 {
            width: 67px;
        }

        #txtBz2 {
            width: 74px;
        }

        #txtBz3 {
            width: 74px;
        }
    </style>
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
                                    <img src="../images/tab_03.png" width="15" height="32" /></td>
                                <td width="1101" background="../images/tab_05.gif">
                                    <ul class="hor_ul">
                                        <li>
                                            <img src="../images/001.gif" />
                                            <span class="Langtxt" id="add"></span></li>
                                    </ul>
                                </td>
                                <td width="281" background="../images/tab_05.gif" align="right">
                                    <img class="style6" style="cursor: hand;" onclick="window.parent.mycallfunction('add_Group',258,207)" onmouseover="javascript:this.src='../images/close_un.png';" onmouseout="javascript:this.src='../images/close.png';" src="../images/close.png" /></td>
                                <td width="14">
                                    <img src="../images/tab_07.png" width="14" height="32" /></td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td width="15" background="../images/tab_12.gif">&nbsp;</td>
                                <td align="center" id="dragtd">
                                    <table class="style1" cellspacing="1">
                                        <tr>
                                            <td colspan="2" align="left" style="background-image: url(../images/add_entity_infobg.png); height: 33;">
                                                <div style="background-image: url(../images/add_entity_info.png); width: 109px; height: 23px;">
                                                    <div style="margin-left: 27px; font-size: 14px; font-weight: bold; color: #006633; padding-top: 5px;"><span class="Langtxt" id="GroupInfo"></span></div>
                                                </div>
                                            </td>

                                        </tr>
                                        <tr>
                                            <td class="style3" align="right" style="width: 84px;"><span id="Lang-T-GroupName"></span>&nbsp;&nbsp;</td>
                                            <td class="style3" align="left">
                                                <asp:TextBox ID="TextBox1" runat="server" Width="120px"></asp:TextBox>
                                                <span id="spGroupName" style="display:none;color:red;" >DDD</span> 
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="style3" align="right" style="width: 64px;"><span class="Langtxt" id="Lang_GroupType"></span>&nbsp;&nbsp;</td>
                                            <td class="style3" align="left">
                                                <asp:DropDownList ID="DropDownList_TerminalType" runat="server" Width="120px" AppendDataBoundItems="True" DataSourceID="ObjectDataSource4" DataTextField="typeName" DataValueField="typeName" OnDataBound="DropDownList_TerminalType_DataBound">
                                                </asp:DropDownList>
                                                <asp:ObjectDataSource ID="ObjectDataSource4" runat="server" SelectMethod="GetAllTerminalType" TypeName="DbComponent.ISSI"></asp:ObjectDataSource>
                                                <asp:CustomValidator ID="CustomValidator2" runat="server" ControlToValidate="DropDownList_TerminalType" Display="None"></asp:CustomValidator>
                                            </td>
                                        </tr>
                                        <tr id="trPdtRule" style="display: none;">
                                            <td class="auto-style2" align="right"><span class="Langtxt" id="Lang_pdtTelRule"></span>&nbsp;&nbsp;</td>
                                            <td class="style3" align="left">
                                                <asp:HiddenField ID="hidPdtRule" runat="server" />
                                                <input id="Radio1" type="radio" checked="checked" onclick="radPdtRuleChange(this.value);" value="1" name="radPdtRule" /><span class="Langtxt" id="Lang_pdtRuleStand"></span><input id="Radio2" onclick="    radPdtRuleChange(this.value);" value="2" type="radio" name="radPdtRule" /><span class="Langtxt" id="Lang_pdtRuleZheJiang"></span></td>
                                        </tr>
                                        <tr id="trPdtBzNum" style="display: none;">
                                            <td class="auto-style2" align="right"><span class="Langtxt" id="Lang_pdtTelNum"></span>&nbsp;&nbsp;</td>
                                            <td class="style3" align="left">
                                                <asp:HiddenField ID="hidBzPdtNum" runat="server" />
                                                <input id="txtBz1" type="text" maxlength="3" />￣<input id="txtBz2" type="text" maxlength="2" />￣<input id="txtBz3" type="text" maxlength="3" />
                                                <span id="spPdtNum" style="display: none; color: red;">dd</span>
                                            </td>
                                        </tr>
                                        <tr id="trPdtArea" style="display: none;">
                                            <td class="auto-style2" align="right"><span class="Langtxt" id="Lang_pdtArea"></span>&nbsp;&nbsp;</td>
                                            <td class="style3" align="left">
                                                <asp:DropDownList ID="dropArea" runat="server">
                                                    <asp:ListItem Value="581">(581)省厅</asp:ListItem>
                                                    <asp:ListItem Value="571">(571)杭州</asp:ListItem>
                                                    <asp:ListItem Value="574">(574)宁波</asp:ListItem>
                                                    <asp:ListItem Value="577">(577)温州</asp:ListItem>
                                                    <asp:ListItem Value="573">(573)嘉兴</asp:ListItem>
                                                    <asp:ListItem Value="572">(572)湖州</asp:ListItem>
                                                    <asp:ListItem Value="575">(575)绍兴</asp:ListItem>
                                                    <asp:ListItem Value="579">(579)金华</asp:ListItem>
                                                    <asp:ListItem Value="570">(570)衢州</asp:ListItem>
                                                    <asp:ListItem Value="580">(580)舟山</asp:ListItem>
                                                    <asp:ListItem Value="576">(576)台州</asp:ListItem>
                                                    <asp:ListItem Value="578">(578)丽水</asp:ListItem>
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr id="trPdtZjNum" style="display: none;">
                                            <td class="auto-style2" align="right"><span class="Langtxt" id="Lang_GroupClassifyNum"></span>&nbsp;&nbsp;</td>
                                            <td class="style3" align="left">
                                                <input id="txtDanHu" type="text" runat="server" /><span id="spZjDhh" style="display: none; color: red;">dd</span></td>
                                        </tr>
                                        <tr>
                                            <td class="style3" align="right" style="width: 64px;"><span class="Langtxt" id="Terminalinbz"></span>&nbsp;&nbsp;</td>
                                            <td class="style3" align="left">
                                                <asp:TextBox ID="TextBox4" runat="server" Width="120px"></asp:TextBox>
                                                <span id="spIssi" style="display:none;color:red;" >DDD</span>     
                                                
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="style3" align="right">
                                                <span id="externalSys"></span>&nbsp;&nbsp;</td>
                                            <td align="left">
                                                <asp:CheckBox ID="chkExternal" runat="server" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="style3" align="right">
                                                <span class="Langtxt" id="Subordinateunits"></span>&nbsp;&nbsp;</td>
                                            <td align="left">
                                                <asp:DropDownList ID="DropDownList1" runat="server" AppendDataBoundItems="True"
                                                    DataSourceID="ObjectDataSource2" DataTextField="name" Width="120px" DataValueField="id">
                                                </asp:DropDownList>
                                                <asp:ObjectDataSource ID="ObjectDataSource2" runat="server"
                                                    SelectMethod="GetAllEntityInfo" TypeName="DbComponent.Entity">
                                                    <SelectParameters>
                                                        <asp:CookieParameter CookieName="id" Name="id" Type="Int32" />
                                                    </SelectParameters>
                                                </asp:ObjectDataSource>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td width="14" background="../images/tab_16.gif">&nbsp;</td>
                            </tr>
                            <tr>
                                <td width="15" background="../images/tab_12.gif">&nbsp;</td>
                                <td align="center" height="30">
                                    <asp:ImageButton ID="ImageButton1"
                                        runat="server" OnClick="ImageButton1_Click" OnClientClick="return checkTellRule();" />&nbsp;&nbsp;&nbsp;
                    <!---------------------------xzj--2018/6/28--将imgid改为id,cursor属性值改为pointer------------------>
                    <img id="Lang-Cancel" style="cursor: pointer;" onclick="window.parent.mycallfunction('add_Group',258,207)" /></td>
                    <!---------------------------xzj--2018/6/28--将imgid改为id,cursor属性值改为pointer------------------>
                                <td width="14" background="../images/tab_16.gif">&nbsp;</td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td height="15">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td width="15" height="15">
                                    <img src="../images/tab_20.png" width="15" height="15" /></td>
                                <td background="../images/tab_21.gif">
                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td width="25%" nowrap="nowrap">&nbsp;</td>
                                            <td width="75%" valign="top" class="STYLE1">&nbsp;</td>
                                        </tr>
                                    </table>
                                </td>
                                <td width="14">
                                    <img src="../images/tab_22.png" width="14" height="15" /></td>
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
    document.getElementById("externalSys").innerHTML = window.parent.GetTextByName("external_system", window.parent.useprameters.languagedata);
    //给图片添加src-----------------------------xzj--2018/6/28----------------------
    window.document.getElementById("Lang-Cancel").src = window.parent.GetTextByName('Lang-Cancel', window.parent.useprameters.languagedata);
    //给图片添加src-----------------------------xzj--2018/6/28----------------------
</script>
<link href="../../CSS/lq_calloutExtender.css" rel="stylesheet" type="text/css" />
