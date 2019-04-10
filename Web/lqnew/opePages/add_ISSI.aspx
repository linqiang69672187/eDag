<%@ Page Language="C#" AutoEventWireup="true" ValidateRequest="false" CodeBehind="add_ISSI.aspx.cs" Inherits="Web.lqnew.opePages.add_ISSI" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <script src="../../JS/LangueSwitch.js" type="text/javascript"></script>
    <link href="../css/lq_addedit.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/pagestyle.css" rel="stylesheet" type="text/css" />
    <script src="../js/geturl.js" type="text/javascript"></script>
    <script src="../js/dragwindow.js" type="text/javascript"></script>
    <script src="/JQuery/jquery-1.5.2.js" type="text/javascript"></script>
    <script src="/lqnew/js/pdtCode.js" type="text/javascript"></script>
    <script src="/lqnew/js/CommValidator.js" type="text/javascript"></script>

    <script type="text/javascript">

        function init() {
            this.parent.$("#add_ISSI").height(800);
            this.parent.$("#add_ISSI_ifr").height(800);
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
                        var valpdbBz = pdt2Id_bz(val1 + val2 + val3);
                        $("#<% =TextBox1.ClientID %>").val(valpdbBz);
                    }
                });
                $('#txtBz2').blur(function () {
                    var val1 = $("#txtBz1").val();
                    var val2 = $("#txtBz2").val();
                    var val3 = $("#txtBz3").val();
                    if (val1 != "" && val2 != "" && val3 != "" && !isNaN(val1) && !isNaN(val2) && !isNaN(val3)) {
                        var valpdbBz = pdt2Id_bz(val1 + val2 + val3);
                        $("#<% =TextBox1.ClientID %>").val(valpdbBz);
                    }
                });
                $('#txtBz3').blur(function () {
                    var val1 = $("#txtBz1").val();
                    var val2 = $("#txtBz2").val();
                    var val3 = $("#txtBz3").val();
                    if (val1 != "" && val2 != "" && val3 != "" && !isNaN(val1) && !isNaN(val2) && !isNaN(val3)) {
                        var valpdbBz = pdt2Id_bz(val1 + val2 + val3);
                        $("#<% =TextBox1.ClientID %>").val(valpdbBz);
                    }
                });

                $("#<% =TextBox1.ClientID %>").blur(function () {
                    var val = $("#<% =TextBox1.ClientID %>").val();
                    var pdtNum = id2Pdt_bz(val);
                    //alert(pdtNum);
                    $("#txtBz1").val(pdtNum.substr(0, 3));
                    $("#txtBz2").val(pdtNum.substr(3, 2));
                    $("#txtBz3").val(pdtNum.substr(5, 3));
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
                    if (val1 != "" && !isNaN(val1)) {
                        //去掉字符串前面的0
                        var a = val1.replace(/\b(0+)/gi, "");
                        $("#txtDanHu").val(a);
                        var len = 5 - a.length;
                        if (len > 0)
                            for (var i = 0; i < len; i++) {
                                a = "0" + a;
                            }
                        var valpdbBz = pdt2Id_zj(val + a);
                        $("#<% =TextBox1.ClientID %>").val(valpdbBz);
                    }

                    //验证单呼范围
                    if (val1 != "" && !isNaN(val1)) {
                        if ((val1 >= 1 && val1 <= 29999) || (val1 >= 30020 && val1 <= 32767)) {
                            $("#spZjDhh").hide();
                        }
                        else {
                            //alert(window.parent.GetTextByName("pdtSingleRangeTip", window.parent.useprameters.languagedata));
                            $("#spZjDhh").html("<BR/>" + window.parent.GetTextByName("pdtSingleRangeTip", window.parent.useprameters.languagedata));
                            $("#spZjDhh").show();

                        }
                    }
                    else {

                        $("#spZjDhh").html("<BR/>" + window.parent.GetTextByName("pdtSingleRangeTip", window.parent.useprameters.languagedata));
                        $("#spZjDhh").show();

                    }
                });

                $("#<% =TextBox1.ClientID %>").blur(function () {
                    var val = $("#<% =TextBox1.ClientID %>").val();
                    var valNum = id2Pdt_zj(val.trim());
                    //alert(valNum);
                    //alert(valNum.substr(0, 3));
                    if (valNum.substr(0, 3) != "") {
                        $("#<% =dropArea.ClientID %>").val(valNum.substr(0, 3));
                    }
                    var dhh = valNum.substr(3, 5);
                    //去掉字符串前面的0
                    var a = dhh.replace(/\b(0+)/gi, "");
                    $("#txtDanHu").val(a);

                });

                $("#<% =dropArea.ClientID %>").blur(function () {
                    var options = $("#<% =dropArea.ClientID %> option:selected"); //获取选中的项 
                    var val = options.val();
                    var dhh = $("#txtDanHu").val();
                    var pdtId = $("#<% =TextBox1.ClientID %>").val();
                    if (dhh == "" || isNaN(dhh)) {
                        $("#<% =TextBox1.ClientID %>").val("");
                      }
                      else {
                          if (dhh != "" && !isNaN(dhh)) {
                              var val1 = $("#txtDanHu").val();
                              if (val1 != "" && !isNaN(val1)) {
                                  //去掉字符串前面的0
                                  var a = val1.replace(/\b(0+)/gi, "");
                                  $("#txtDanHu").val(a);
                                  var len = 5 - a.length;
                                  if (len > 0)
                                      for (var i = 0; i < len; i++) {
                                          a = "0" + a;
                                      }
                                  var valpdbBz = pdt2Id_zj(val + a);
                                  $("#<% =TextBox1.ClientID %>").val(valpdbBz);
                            }
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
                    var valpdbBz = pdt2Id_bz(val1 + val2 + val3);
                    $("#<% =TextBox1.ClientID %>").val(valpdbBz);
                }
                $("#hidBzPdtNum").val($("#txtBz1").val() + $("#txtBz2").val() + $("#txtBz3").val());
            });
            $('#txtBz2').blur(function () {
                var val1 = $("#txtBz1").val();
                var val2 = $("#txtBz2").val();
                var val3 = $("#txtBz3").val();
                if (val1 != "" && val2 != "" && val3 != "" && !isNaN(val1) && !isNaN(val2) && !isNaN(val3)) {
                    var valpdbBz = pdt2Id_bz(val1 + val2 + val3);
                    $("#<% =TextBox1.ClientID %>").val(valpdbBz);
                }
                $("#hidBzPdtNum").val($("#txtBz1").val() + $("#txtBz2").val() + $("#txtBz3").val());
            });
            $('#txtBz3').blur(function () {
                var val1 = $("#txtBz1").val();
                var val2 = $("#txtBz2").val();
                var val3 = $("#txtBz3").val();
                if (val1 != "" && val2 != "" && val3 != "" && !isNaN(val1) && !isNaN(val2) && !isNaN(val3)) {
                    var valpdbBz = pdt2Id_bz(val1 + val2 + val3);
                    $("#<% =TextBox1.ClientID %>").val(valpdbBz);
                }
                $("#hidBzPdtNum").val($("#txtBz1").val() + $("#txtBz2").val() + $("#txtBz3").val());
            });

            $("#<% =TextBox1.ClientID %>").blur(function () {
                var val = $("#<% =TextBox1.ClientID %>").val();
                    var pdtNum = id2Pdt_bz(val);
                    //alert(pdtNum);
                    $("#txtBz1").val(pdtNum.substr(0, 3));
                    $("#txtBz2").val(pdtNum.substr(3, 2));
                    $("#txtBz3").val(pdtNum.substr(5, 3));
                    $("#hidBzPdtNum").val($("#txtBz1").val() + $("#txtBz2").val() + $("#txtBz3").val());
                });

            }
            else if (pdtRuleVale == 2) {
                $("#txtDanHu").blur(function () {
                    var optionsArea = $("#<% =dropArea.ClientID %> option:selected"); //获取选中的项 
                    var val = optionsArea.val();
                    var val1 = $("#txtDanHu").val();
                    if (val1 != "" && !isNaN(val1)) {
                        //去掉字符串前面的0
                        var a = val1.replace(/\b(0+)/gi, "");
                        $("#txtDanHu").val(a);
                        var len = 5 - a.length;
                        if (len > 0)
                            for (var i = 0; i < len; i++) {
                                a = "0" + a;
                            }
                        var valpdbBz = pdt2Id_zj(val + a);
                        $("#<% =TextBox1.ClientID %>").val(valpdbBz);
                    }

                });

                $("#<% =TextBox1.ClientID %>").blur(function () {
                    var val = $("#<% =TextBox1.ClientID %>").val();
                    var valNum = id2Pdt_zj(val.trim())
                    var dhh = valNum.substr(3, 5);
                    //alert(valNum);
                    //alert(valNum.substr(0, 3));
                    if (valNum.substr(0, 3) != "") {
                        $("#<% =dropArea.ClientID %>").val(valNum.substr(0, 3));
                    }
                    //去掉字符串前面的0
                    var a = dhh.replace(/\b(0+)/gi, "");
                    $("#txtDanHu").val(a);
                });

                $("#<% =dropArea.ClientID %>").blur(function () {
                    var options = $("#<% =dropArea.ClientID %> option:selected"); //获取选中的项 
                    var val = options.val();
                    var dhh = $("#txtDanHu").val();
                    var pdtId = $("#<% =TextBox1.ClientID %>").val();
                    if (dhh == "" || isNaN(dhh)) {
                        $("#<% =TextBox1.ClientID %>").val("");
                    }
                    else {
                        if (dhh != "" && !isNaN(dhh)) {
                            var val1 = $("#txtDanHu").val();
                            if (val1 != "" && !isNaN(val1)) {
                                //去掉字符串前面的0
                                var a = val1.replace(/\b(0+)/gi, "");
                                $("#txtDanHu").val(a);
                                var len = 5 - a.length;
                                if (len > 0)
                                    for (var i = 0; i < len; i++) {
                                        a = "0" + a;
                                    }
                                var valpdbBz = pdt2Id_zj(val + a);
                                $("#<% =TextBox1.ClientID %>").val(valpdbBz);
                            }
                        }

                    }

                });
            }
    });

    //提交验证
    function checkTellRule() {
        init();
        var result;
        var issi = $("#<%=TextBox1.ClientID%>").val();
        issi = issi.trim();
        var options = $("#<% =DropDownList_TerminalType.ClientID %> option:selected"); //获取选中的项 
        var val = options.val();
        if (val == "PDT") {
            var pdtRuleVale = $('input:radio[name="radPdtRule"]:checked').val();
            if (pdtRuleVale == "2") {     //浙江规则
                var dhh = $("#txtDanHu").val();
                if (dhh != "" && !isNaN(dhh)) {
                    if ((dhh >= 1 && dhh <= 29999) || (dhh >= 30020 && dhh <= 32767)) {

                        var bhc1 = $("#<% =dropArea.ClientID %> option:selected").val() + dhh;
                        // alert(bhc1);
                        // alert($("#<% =TextBox1.ClientID %>").val());
                        if (issi == "" || isNaN(issi)) {
                            $("#spIssi").html("<BR/>" + window.parent.GetTextByName("tetraUserRangeTip", window.parent.useprameters.languagedata));
                            $("#spIssi").show();
                            result = false;
                        }
                        else if ($("#<% =TextBox1.ClientID %>").val() == bhc1) {
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
                        $("#spZjDhh").html("<BR/>" + window.parent.GetTextByName("pdtSingleRangeTip", window.parent.useprameters.languagedata));
                        $("#spZjDhh").show();
                        result = false;
                    }
                }
                else {
                    $("#spZjDhh").html("<BR/>" + window.parent.GetTextByName("pdtSingleRangeTip", window.parent.useprameters.languagedata));
                    $("#spZjDhh").show();
                    result = false;

                }
                //验证厂家与型号
                if (getByteLen($("#txtFactury").val()) > 30) {
                    $("#yzFactury").html(window.parent.GetTextByName("FactoryStrLenthLimit30", window.parent.useprameters.languagedata));
                    $("#yzFactury").show();
                    result = false;
                }
                else {
                    $("#yzFactury").hide();
                }
                if (getByteLen($("#txtModel").val()) > 15) {
                    $("#yzModel").html(window.parent.GetTextByName("ModeLenthLimit15", window.parent.useprameters.languagedata));
                    $("#yzModel").show();
                    result = false;
                }
                else {
                    $("#yzModel").hide();
                }

                return result;
            }
            else {
                //PDT ISSI验证（标准规则）  
                if (issi == "" || isNaN(issi)) {
                    $("#spIssi").html("<BR/>" + window.parent.GetTextByName("tetraUserRangeTip", window.parent.useprameters.languagedata));
                    $("#spIssi").show();
                    result = false;
                }
                else {
                    if (issi >= 1048577 && issi <= 16743880) {
                        var bhc = $("#txtBz1").val() + $("#txtBz2").val() + $("#txtBz3").val();
                        if (bhc.trim() == "") {
                            result = false;
                            $("#spPdtNum").html("<BR/>" + window.parent.GetTextByName("Lang_pdtNumNotNull", window.parent.useprameters.languagedata));
                            $("#spPdtNum").show();
                        }
                        else if ($("#<% =TextBox1.ClientID %>").val() == bhc) {
                            //alert($("#<% =TextBox1.ClientID %>").val());
                            //txtBz1
                            //alert(bhc);
                            result = false;
                            $("#spIssi").html("<BR/>" + window.parent.GetTextByName("TelNumConvertFail", window.parent.useprameters.languagedata));
                            $("#spIssi").show();
                        }
                        else {
                            $("#spIssi").hide();
                            result = true;
                        }
                    }
                    else {
                        result = false;
                        $("#spIssi").html("<BR/>" + window.parent.GetTextByName("tetraUserRangeTip", window.parent.useprameters.languagedata));
                        $("#spIssi").show();

                    }
                }

                //验证厂家与型号
                if (getByteLen($("#txtFactury").val()) > 30) {
                    $("#yzFactury").html(window.parent.GetTextByName("FactoryStrLenthLimit30", window.parent.useprameters.languagedata));
                    $("#yzFactury").show();
                    result = false;
                }
                else {
                    $("#yzFactury").hide();
                }
                if (getByteLen($("#txtModel").val()) > 15) {
                    $("#yzModel").html(window.parent.GetTextByName("ModeLenthLimit15", window.parent.useprameters.languagedata));
                    $("#yzModel").show();
                    result = false;
                }
                else {
                    $("#yzModel").hide();
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

            //验证厂家与型号
            if (getByteLen($("#txtFactury").val()) > 30) {
                $("#yzFactury").html(window.parent.GetTextByName("FactoryStrLenthLimit30", window.parent.useprameters.languagedata));
                $("#yzFactury").show();
                result = false;
            }
            else {
                $("#yzFactury").hide();
            }
            if (getByteLen($("#txtModel").val()) > 15) {
                $("#yzModel").html(window.parent.GetTextByName("ModeLenthLimit15", window.parent.useprameters.languagedata));
                $("#yzModel").show();
                result = false;
            }
            else {
                $("#yzModel").hide();
            }

            if (result) {
                $("#spIssi").hide();
                return true;
            }
            else {
                $("#spIssi").html("<BR/>" + window.parent.GetTextByName("tetraUserRangeTip", window.parent.useprameters.languagedata));
                $("#spIssi").show();
                return false
            }


        }


    }

    </script>
    <style type="text/css">
        .style6 td {
            background-color: transparent;
        }

        .auto-style2 {
            height: 22px;
            width: 85px;
        }

        #Text1 {
            width: 94px;
            padding-bottom: 0px;
        }

        #Text2 {
            width: 97px;
            padding-bottom: 0px;
        }

        #Text3 {
            width: 97px;
            padding-bottom: 0px;
        }

        #Text4 {
            width: 256px;
            padding-bottom: 0px;
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
        <div id="divPage">
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
                                            <img src="../images/001.gif" /><span id="Lang_Add">添 加</span></li>
                                    </ul>
                                </td>
                                <td width="281" background="../images/tab_05.gif" align="right">
                                    <img style="cursor: hand;" onclick="window.parent.mycallfunction('add_ISSI')" onmouseover="javascript:this.src='../images/close_un.png';"
                                        onmouseout="javascript:this.src='../images/close.png';" src="../images/close.png" />
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
                                <td align="center" id="dragtd">
                                    <table id="dragtd" class="style1" cellspacing="1">
                                        <tr>
                                            <td colspan="2" align="left" style="background-image: url(../images/add_entity_infobg.png); height: 26px;">
                                                <div style="background-image: url(../images/add_entity_info.png); width: 132px; height: 23px;">
                                                    <div id="Lang_ISSSInfo" style="margin-left: 28px; font-size: 14px; font-weight: bold; color: #006633; padding-top: 3px;">
                                                        终端信息
                                                    </div>
                                                </div>
                                            </td>
                                        </tr>

                                        <tr>
                                            <td class="auto-style2" align="right">
                                                <span id="Lang_TerminalType"></span>&nbsp;&nbsp;
                                         <%--   终端类型--%>
                                            </td>
                                            <td align="left" class="style3" style="display: inline">
                                                <asp:DropDownList ID="DropDownList_TerminalType" runat="server" Width="120px" AppendDataBoundItems="True" DataSourceID="ObjectDataSource4" DataTextField="typeName" DataValueField="typeName" OnDataBound="DropDownList_TerminalType_DataBound">
                                                </asp:DropDownList>
                                                <asp:ObjectDataSource ID="ObjectDataSource4" runat="server" SelectMethod="GetAllTerminalType" TypeName="DbComponent.ISSI"></asp:ObjectDataSource>
                                                <asp:CustomValidator ID="CustomValidator2" runat="server" ControlToValidate="DropDownList_TerminalType" Display="None"></asp:CustomValidator>
                                            </td>
                                        </tr>
                                        <tr id="trPdtRule" style="display: none;">
                                            <td class="auto-style2" align="right"> <span id="Lang_pdtTelRule"></span>&nbsp;&nbsp;</td>
                                            <td class="style3" align="left">
                                                <asp:HiddenField ID="hidPdtRule" runat="server" />
                                                <input id="Radio1" type="radio" checked="checked" onclick="radPdtRuleChange(this.value);" value="1" name="radPdtRule" /><span id="Lang_pdtRuleStand"></span><input id="Radio2" onclick="radPdtRuleChange(this.value);" value="2" type="radio" name="radPdtRule" /><span id="Lang_pdtRuleZheJiang"></span></td>
                                        </tr>
                                        <tr id="trPdtBzNum" style="display: none;">
                                            <td class="auto-style2" align="right"><span id="Lang_pdtTelNum"></span>&nbsp;&nbsp;</td>
                                            <td class="style3" align="left">
                                                <asp:HiddenField ID="hidBzPdtNum" runat="server" />
                                                <input id="txtBz1" type="text" maxlength="3" />￣<input id="txtBz2" type="text" maxlength="2" />￣<input id="txtBz3" type="text" maxlength="3" />
                                                <span id="spPdtNum" style="display:none; color:red;">dd</span>
                                            </td>
                                        </tr>
                                        <tr id="trPdtArea" style="display: none;">
                                            <td class="auto-style2" align="right"><span id="Lang_pdtArea"></span>&nbsp;&nbsp;</td>
                                            <td class="style3" align="left">
                                                <asp:DropDownList ID="dropArea" runat="server">
                                                    <asp:ListItem Value="581">(581)省厅</asp:ListItem>
                                                    <asp:ListItem Value="582">(582)保留</asp:ListItem>
                                                    <asp:ListItem Value="583">(583)保留</asp:ListItem>
                                                    <asp:ListItem Value="584">(584)保留</asp:ListItem>
                                                    <asp:ListItem Value="585">(585)保留</asp:ListItem>
                                                    <asp:ListItem Value="586">(586)保留</asp:ListItem>
                                                    <asp:ListItem Value="587">(587)保留</asp:ListItem>
                                                    <asp:ListItem Value="588">(588)保留</asp:ListItem>
                                                    <asp:ListItem Value="589">(589)保留</asp:ListItem>
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
                                            <td class="auto-style2" align="right"><span id="Lang_pdtSingleTelNum"></span>&nbsp;&nbsp;</td>
                                            <td class="style3" align="left">
                                                <input id="txtDanHu" type="text" runat="server" /><span id="spZjDhh" style="display:none; color:red;">dd</span></td>
                                        </tr>
                                        <tr>
                                            <td class="auto-style2" align="right">
                                                <span id="Lang_terminal_biaozhi"></span>&nbsp;&nbsp;
                                            <%--终端号码：--%>
                                            </td>
                                            <td class="style3" align="left">
                                                <asp:TextBox ID="TextBox1" runat="server" Width="120px"
                                                    ValidationGroup="addissi"></asp:TextBox>
                                                <span id="spIssi" style="display:none;color:red;" >DDD</span>                                
                                            </td>
                                        </tr>
                                        <tr id="tr_ipAddress" style="display: none">
                                            <td class="auto-style2" align="right">
                                                <span id="Lang_ipAddress"></span>&nbsp;&nbsp;
                                         <%--   ipAddress--%>
                                            </td>
                                            <td align="left" class="style3">
                                                <asp:TextBox ID="input_ipAddress" runat="server" Width="120px"></asp:TextBox>
                                                <asp:CustomValidator ID="CustomValidator3" runat="server" ControlToValidate="input_ipAddress" Display="None"></asp:CustomValidator>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="auto-style2" align="right">
                                                <span id="Lang_SubordinateunitsBelong"></span>&nbsp;&nbsp;
                                         <%--   所属单位--%>
                                            </td>
                                            <td align="left" class="style3">
                                                <asp:DropDownList ID="DropDownList1" runat="server" Width="120px" AppendDataBoundItems="True" DataSourceID="ObjectDataSource2"
                                                    DataTextField="name" DataValueField="id">
                                                </asp:DropDownList>
                                                <asp:ObjectDataSource ID="ObjectDataSource2" runat="server" SelectMethod="GetAllEntityInfo"
                                                    TypeName="DbComponent.Entity">
                                                    <SelectParameters>
                                                        <asp:CookieParameter CookieName="id" Name="id" Type="Int32" />
                                                    </SelectParameters>
                                                </asp:ObjectDataSource>
                                                &nbsp; &nbsp; &nbsp; &nbsp;
                                                <asp:CheckBox ID="chkIsExternal" runat="server" Text="外系统" />
                                            </td>
                                        </tr>
                                        <tr>
                                             <td class="auto-style2" align="right">
                                                <span id="Lang_factory">厂家：</span>&nbsp;&nbsp;
                                            <%--厂家：--%>
                                            </td>
                                            <td class="style3" align="left">
                                                <input type="text" id="txtFactury" runat="server" Width="120px"/>
                                                <span id="yzFactury" style="display:none;color:red;" >DDD</span>                                
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="auto-style2" align="right">
                                                <span id="Lang_mobilemode">型号：</span>&nbsp;&nbsp;
                                            <%--型号：--%>
                                            </td>
                                            <td class="style3" align="left">
                                                <input type="text" id="txtModel" runat="server" Width="120px"/>
                                                <span id="yzModel" style="display:none;color:red;" >DDD</span>                                
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="auto-style2" align="right">
                          <span class="Langtxt" id="Lang_OnlyRemark" ></span>&nbsp;&nbsp;
                                            </td>
                                            <td align="left">
                                                <asp:TextBox ID="txtBZ" runat="server" Width="190px" TextMode="MultiLine"></asp:TextBox>
                                                <asp:RegularExpressionValidator ID="ValidatorBZ" runat="server" Display="None"
                                                    ControlToValidate="txtBZ" ValidationGroup="addissi"></asp:RegularExpressionValidator>
                                                <cc1:ValidatorCalloutExtender ID="ValidatorCalloutExtender3" runat="server" TargetControlID="ValidatorBZ"
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
                                        <tr>
                                            <td class="auto-style2" align="right">
                                                <span id="Lang_zhuliuzuBelong"></span&nbsp;&nbsp;
                                        <%--    驻留组：--%>
                                            </td>
                                            <td align="left">
                                                <asp:DropDownList ID="DropDownList2" runat="server" AppendDataBoundItems="True">
                                                    <asp:ListItem Selected="True" Value="0">无</asp:ListItem>
                                                </asp:DropDownList>
                                            </td>
                                        </tr>

                                        <tr>
                                            <td class="auto-style2" valign="top" align="right">
                                                <span id="Lang_saomiaozuBelong"></span>&&nbsp;&nbsp;
                                           <%-- 扫描组：--%><br />
                                            </td>
                                            <td align="left">
                                                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                                    <ContentTemplate>
                                                        <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
                                                            <tr>
                                                                <td height="30">
                                                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                                        <tr>
                                                                            <td width="15" height="30">
                                                                                <img src="images/tab_03.gif" width="15" height="30" />
                                                                            </td>
                                                                            <td background="images/tab_05.gif">
                                                                                <ul class="hor_ul">
                                                                                    <li>
                                                                                        <asp:DropDownList ID="DropDownList3" runat="server" AppendDataBoundItems="True" DataSourceID="ObjectDataSource2"
                                                                                            DataTextField="name" DataValueField="id">
                                                                                            <asp:ListItem Value="0">选择单位</asp:ListItem>
                                                                                        </asp:DropDownList>
                                                                                        <asp:ObjectDataSource ID="ObjectDataSource3" runat="server" SelectMethod="GetAllEntityInfo"
                                                                                            TypeName="DbComponent.Entity">
                                                                                            <SelectParameters>
                                                                                                <asp:CookieParameter CookieName="id" Name="id" Type="Int32" />
                                                                                            </SelectParameters>
                                                                                        </asp:ObjectDataSource>
                                                                                    </li>
                                                                                    <li>
                                                                                        <asp:DropDownList ID="DropDownList4" runat="server">
                                                                                            <asp:ListItem Value="Group_name">组名</asp:ListItem>
                                                                                            <asp:ListItem Value="GSSI">小组标识</asp:ListItem>
                                                                                        </asp:DropDownList>
                                                                                    </li>
                                                                                    <li>
                                                                                        <asp:TextBox ID="TextBox2" runat="server" Width="65px"></asp:TextBox></li>
                                                                                    <li>
                                                                                        <asp:ImageButton ID="Lang_Search" runat="server" onmouseover="javascript:this.src=window.parent.GetTextByName('Lang_Search_un',window.parent.useprameters.languagedata);" onmouseout="javascript:this.src=window.parent.GetTextByName('Lang_Search',window.parent.useprameters.languagedata);"
                                                                                            ImageUrl="../images/btn_search.png" OnClick="ImageButton6_Click" /></li>
                                                                                </ul>
                                                                            </td>
                                                                            <td width="14">
                                                                                <img src="images/tab_07.gif" width="14" height="30" />
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                                        <tr>
                                                                            <td width="9" background="images/tab_12.gif">&nbsp;
                                                                            </td>
                                                                            <td bgcolor="#f3ffe3">
                                                                                <asp:UpdateProgress AssociatedUpdatePanelID="UpdatePanel1" ID="UpdateProgress1" runat="server">
                                                                                    <ProgressTemplate>
                                                                                        <img src="../../Images/ProgressBar/05043123.gif" /><span id="Lang_UnderOperate">正在处理数据请稍后....</span></ProgressTemplate>
                                                                                </asp:UpdateProgress>
                                                                                <asp:GridView ID="GridView1" runat="server" Width="99%" AutoGenerateColumns="False"
                                                                                    DataSourceID="ObjectDataSource1" BorderWidth="0px" CellSpacing="1" BackColor="#C0DE98"
                                                                                    BorderColor="White" BorderStyle="Ridge" AllowPaging="True" AllowSorting="True"
                                                                                    CellPadding="0" GridLines="None" PageSize="3" OnRowCommand="GridView1_RowCommand"
                                                                                    OnRowDataBound="GridView1_RowDataBound">
                                                                                    <Columns>
                                                                                        <asp:TemplateField>
                                                                                            <ItemTemplate>
                                                                                                <asp:ImageButton ID="ImageButton7" CommandName="AddSM" CommandArgument='<%# Eval("GSSI")+","+Eval("Group_name") %>'
                                                                                                    ImageUrl="../images/check_off.png" runat="server" />
                                                                                            </ItemTemplate>
                                                                                            <ItemStyle Width="20px" HorizontalAlign="Center" />
                                                                                        </asp:TemplateField>
                                                                                        <asp:BoundField DataField="Group_name" HeaderText="组名" SortExpression="Group_name">
                                                                                            <ItemStyle HorizontalAlign="Left" />
                                                                                        </asp:BoundField>
                                                                                        <asp:BoundField DataField="GSSI" HeaderText="小组标识" SortExpression="GSSI">
                                                                                            <ItemStyle HorizontalAlign="Center" Width="60px" />
                                                                                        </asp:BoundField>
                                                                                    </Columns>
                                                                                    <FooterStyle BackColor="#C6C3C6" ForeColor="Black" />
                                                                                    <HeaderStyle CssClass="gridheadcss" Font-Bold="True" />
                                                                                    <PagerStyle CssClass="PagerStyle" />
                                                                                    <RowStyle BackColor="#FFFFFF" Height="22px" ForeColor="Black" />
                                                                                    <SelectedRowStyle BackColor="#9471DE" Font-Bold="True" ForeColor="White" />
                                                                                </asp:GridView>
                                                                                <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" SortParameterName="sort"
                                                                                    SelectCountMethod="AllGroupInfocount" SelectMethod="AllGroupInfo" TypeName="DbComponent.group">
                                                                                    <SelectParameters>
                                                                                        <asp:Parameter DefaultValue="0" Name="grouptype" Type="Int32" />
                                                                                        <asp:ControlParameter ControlID="DropDownList3" Name="Entity_ID" PropertyName="SelectedValue" />
                                                                                        <asp:ControlParameter ControlID="DropDownList4" Name="selectcondition" PropertyName="SelectedValue" />
                                                                                        <asp:ControlParameter ControlID="TextBox2" Name="textseach" PropertyName="Text" />
                                                                                        <asp:CookieParameter CookieName="id" Name="id" Type="Int32" />
                                                                                    </SelectParameters>
                                                                                </asp:ObjectDataSource>
                                                                            </td>
                                                                            <td width="9" background="images/tab_16.gif">&nbsp;
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td height="15">
                                                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                                        <tr>
                                                                            <td width="15" height="29">
                                                                                <img src="images/tab_20.gif" width="15" height="29" />
                                                                            </td>
                                                                            <td background="images/tab_21.gif">
                                                                                <asp:Label ID="Label1" runat="server" OnLoad="Label1_Load"><img src="../images/viewinfo_bg.png" /><span id="Lang_AddedSaomiaozu"><%--已添加扫描组--%></span>...</asp:Label>
                                                                                <asp:DropDownList ID="DropDownList5" runat="server" Height="16px" Visible="False">
                                                                                    <asp:ListItem Value="0">已添加扫描组</asp:ListItem>
                                                                                </asp:DropDownList>
                                                                            </td>
                                                                            <td width="14">
                                                                                <img src="images/tab_22.gif" width="14" height="29" />
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </ContentTemplate>
                                                </asp:UpdatePanel>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="auto-style2" valign="top" align="right">
                                                <span id="Lang_multicastgroupBelong"></span>&nbsp;&nbsp;
                                                <%--已添加扫描组--%>
                                            </td>
                                            <td align="left">
                                                <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                                    <ContentTemplate>
                                                        <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
                                                            <tr>
                                                                <td height="30">
                                                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                                        <tr>
                                                                            <td width="15" height="30">
                                                                                <img src="images/tab_03.gif" width="15" height="30" />
                                                                            </td>
                                                                            <td background="images/tab_05.gif">
                                                                                <ul class="hor_ul">
                                                                                    <li>
                                                                                        <asp:DropDownList ID="DropDownList6" runat="server" AppendDataBoundItems="True" DataSourceID="ObjectDataSource3"
                                                                                            DataTextField="name" DataValueField="id">
                                                                                            <asp:ListItem Value="0">选择单位</asp:ListItem>
                                                                                        </asp:DropDownList>
                                                                                    </li>
                                                                                    <li>
                                                                                        <asp:DropDownList ID="DropDownList7" runat="server">
                                                                                            <asp:ListItem Value="Group_name">组名</asp:ListItem>
                                                                                            <asp:ListItem Value="GSSI">小组标识</asp:ListItem>
                                                                                        </asp:DropDownList>
                                                                                    </li>
                                                                                    <li>
                                                                                        <asp:TextBox ID="TextBox3" runat="server" Width="65px"></asp:TextBox></li>
                                                                                    <li>
                                                                                        <asp:ImageButton ID="Lang_Search2" runat="server" onmouseover="javascript:this.src=window.parent.GetTextByName('Lang_Search_un',window.parent.useprameters.languagedata);" onmouseout="javascript:this.src=window.parent.GetTextByName('Lang_Search',window.parent.useprameters.languagedata);"
                                                                                            ImageUrl="../images/btn_search.png" OnClick="ImageButton8_Click" /></li>
                                                                                </ul>
                                                                            </td>
                                                                            <td width="14">
                                                                                <img src="images/tab_07.gif" width="14" height="30" />
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                                        <tr>
                                                                            <td width="9" background="images/tab_12.gif">&nbsp;
                                                                            </td>
                                                                            <td bgcolor="#f3ffe3">
                                                                                <asp:UpdateProgress AssociatedUpdatePanelID="UpdatePanel2" ID="UpdateProgress2" runat="server">
                                                                                    <ProgressTemplate>
                                                                                        <img src="../../Images/ProgressBar/05043123.gif" /><span id="Lang_UnderOperate"><%--正在处理数据请稍后....--%></span>
                                                                                    </ProgressTemplate>
                                                                                </asp:UpdateProgress>
                                                                                <asp:GridView ID="GridView2" runat="server" Width="99%" AutoGenerateColumns="False"
                                                                                    DataSourceID="ObjectDataSource5" BorderWidth="0px" CellSpacing="1" BackColor="#C0DE98"
                                                                                    BorderColor="White" BorderStyle="Ridge" AllowPaging="True" AllowSorting="True"
                                                                                    CellPadding="0" GridLines="None" PageSize="3" OnRowCommand="GridView2_RowCommand"
                                                                                    OnRowDataBound="GridView2_RowDataBound">
                                                                                    <Columns>
                                                                                        <asp:TemplateField>
                                                                                            <ItemTemplate>
                                                                                                <asp:ImageButton ID="ImageButton9" CommandName="AddSM" CommandArgument='<%# Eval("GSSI")+","+Eval("Group_name") %>'
                                                                                                    ImageUrl="../images/check_off.png" runat="server" />
                                                                                            </ItemTemplate>
                                                                                            <ItemStyle Width="20px" HorizontalAlign="Center" />
                                                                                        </asp:TemplateField>
                                                                                        <asp:BoundField DataField="Group_name" HeaderText="组名" SortExpression="Group_name">
                                                                                            <ItemStyle HorizontalAlign="Left" />
                                                                                        </asp:BoundField>
                                                                                        <asp:BoundField DataField="GSSI" HeaderText="小组标识" SortExpression="GSSI">
                                                                                            <ItemStyle HorizontalAlign="Center" Width="60px" />
                                                                                        </asp:BoundField>
                                                                                    </Columns>
                                                                                    <FooterStyle BackColor="#C6C3C6" ForeColor="Black" />
                                                                                    <HeaderStyle CssClass="gridheadcss" Font-Bold="True" />
                                                                                    <PagerStyle CssClass="PagerStyle" />
                                                                                    <RowStyle BackColor="#FFFFFF" Height="22px" ForeColor="Black" />
                                                                                    <SelectedRowStyle BackColor="#9471DE" Font-Bold="True" ForeColor="White" />
                                                                                </asp:GridView>
                                                                                <asp:ObjectDataSource ID="ObjectDataSource5" runat="server" EnablePaging="true" SortParameterName="sort"
                                                                                    SelectCountMethod="AllGroupInfocount" SelectMethod="AllGroupInfo" TypeName="DbComponent.group">
                                                                                    <SelectParameters>
                                                                                        <asp:Parameter DefaultValue="1" Name="grouptype" Type="Int32" />
                                                                                        <asp:ControlParameter ControlID="DropDownList6" Name="Entity_ID" PropertyName="SelectedValue" />
                                                                                        <asp:ControlParameter ControlID="DropDownList7" Name="selectcondition" PropertyName="SelectedValue" />
                                                                                        <asp:ControlParameter ControlID="TextBox3" Name="textseach" PropertyName="Text" />
                                                                                        <asp:CookieParameter CookieName="id" Name="id" Type="Int32" />
                                                                                    </SelectParameters>
                                                                                </asp:ObjectDataSource>
                                                                            </td>
                                                                            <td width="9" background="images/tab_16.gif">&nbsp;
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td height="15">
                                                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                                        <tr>
                                                                            <td width="15" height="29">
                                                                                <img src="images/tab_20.gif" width="15" height="29" />
                                                                            </td>
                                                                            <td background="images/tab_21.gif">
                                                                                <asp:Label ID="Label2" runat="server" OnLoad="Label2_Load"><img src="../images/viewinfo_bg.png" /><span id="Lang_AddedTongbozu">已添加通播组</span>...</asp:Label>
                                                                                <asp:DropDownList ID="DropDownList8" runat="server" Height="16px" Visible="False">
                                                                                    <asp:ListItem Value="0">已添加通播组</asp:ListItem>
                                                                                </asp:DropDownList>
                                                                            </td>
                                                                            <td width="14">
                                                                                <img src="images/tab_22.gif" width="14" height="29" />
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </ContentTemplate>
                                                </asp:UpdatePanel>
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
                                    <asp:ImageButton ID="LangConfirm" ImageUrl="../images/add_ok.png" runat="server"
                                        OnClick="ImageButton1_Click" OnClientClick="return checkTellRule();" ValidationGroup="addissi" />&nbsp;&nbsp;&nbsp;
                                <img id="Lang-Cancel" style="cursor: hand;" onclick="window.parent.mycallfunction('add_ISSI')"
                                    src="../images/add_cancel.png" />
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
<script>    window.parent.closeprossdiv();

</script>
<link href="../../CSS/lq_calloutExtender.css" rel="stylesheet" type="text/css" />
