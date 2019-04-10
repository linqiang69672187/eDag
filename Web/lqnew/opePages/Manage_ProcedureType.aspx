<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Manage_ProcedureType.aspx.cs" Inherits="Web.lqnew.opePages.Manage_ProcedureType" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link href="../css/lq_addedit.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/pagestyle.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/ui-lightness/jquery-ui-1.8.13.custom.css" rel="stylesheet" type="text/css" />
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <table width="50%" border="0" align="center" cellpadding="0" cellspacing="0">
                <tr>
                    <td height="30">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td height="32">
                                    <img src="../images/tab_03.png" width="14" height="32" />
                                </td>
                                <td width="1101" background="../images/tab_05.gif"></td>
                                <td width="281" background="../images/tab_05.gif" align="right">
                                    <img class="style6" style="cursor: hand;" onclick="displaycardutymouserMenu();window.parent.mycallfunction('manage_CarDuty');"
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
                                <td width="15" background="../images/tab_12.gif"></td>
                                <td align="left">
                                    <div id="Div1" style="font-family: Arial; width: 100%; text-align: left;">
                                        <fieldset>
                                            <legend>
                                                <label id="lbprocedurecreat">流程创建</label>
                                            </legend>
                                            <table width="100%" class="style1" cellspacing="0" border="0" cellpadding="1" id="Table1">
                                                <tr style="">
                                                    <td align="center" colspan="4" vertical-align="central">
                                                        <label id="Label2">流程名称</label>
                                                        <input type="text" id="txt_procedurename" width="200px" onblur="checkExistsProcedure()"></input>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="right">
                                                        <label id="lbprocedureType">类&nbsp;&nbsp;&nbsp;&nbsp; 型</label>
                                                    </td>
                                                    <td>
                                                        <input type="text" id="txt_proceduretype" width="200px"></input>
                                                    </td>

                                                    <td align="right">
                                                        <label id="lb_procedurelifttime">周期(天)</label>
                                                    </td>
                                                    <td>
                                                        <input type="text" id="txt_lifttime" width="200px" onblur="checkisInt()"></input>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="right">
                                                        <label id="lbRemark">备&nbsp;&nbsp;&nbsp;&nbsp; 注</label>
                                                    </td>
                                                    <td>
                                                        <input type="text" id="txtRemark" width="200px"></input>
                                                    </td>
                                                </tr>
                                             
                                                <tr>
                                                    <td colspan="4" align="center">
                                                        <div id="Div2" style="font-family: Arial; width: 100%; text-align: left;">
                                                            <fieldset>
                                                                <legend>
                                                                    <label id="Label1">流程步骤</label>
                                                                </legend>
                                                                <table width="100%" class="style1" cellspacing="0" border="0" cellpadding="1">
                                                                    <tr>
                                                                        <td align="right"><label id="lbfirststpe">第一步</label></td>
                                                                        <td><input type="text" width="200px" id="txt_firststep" /></td>
                                                                        <td align="right"><label id="lbsecstpe">第二步</label></td>
                                                                        <td><input type="text" width="200px" id="txt_secstep" /></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td align="right"><label id="lbthirdstep">第三步</label></td>
                                                                        <td><input type="text" width="200px" id="txt_thirdstep" /></td>
                                                                        <td align="right"><label id="lbfourstep">第四步</label></td>
                                                                        <td><input type="text" width="200px" id="txt_fourstep" /></td>
                                                                    </tr>
                                                                </table>
                                                            </fieldset>
                                                        </div>
                                                        <input type="button" value="保存" onclick="SaveProcedure()" />
                                                        <%--<img id="Lang_Search2" style="cursor: pointer; display: none" onclick="searchList()" />--%>
                                                    </td>
                                                </tr>
                                            </table>
                                        </fieldset>
                                    </div>
                                    <div id="Div3" style="font-family: Arial; width: 100%; text-align: left;">
                                        <fieldset>
                                            <legend>
                                                <label id="lb_procedureTypeManage">流程类型自定义</label>
                                            </legend>
                                            <table width="100%" class="style1" cellspacing="0" border="0" cellpadding="1" id="dragtd">
                                                <tr style="">
                                                    <td align="center" colspan="4" vertical-align="central">
                                                        <label id="lb_procedurename">流程名称</label>
                                                        <select id="sel_proceduretype" onchange="SelProcedureType()" style="width: 200px"></select>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="right">
                                                        <label id="lb_reserve1">reserve1</label>
                                                    </td>
                                                    <td>
                                                        <input type="text" id="txt_reserve1" width="200px"></input>
                                                    </td>

                                                    <td align="right">
                                                        <label id="lb_reserve2">reserve2</label>
                                                    </td>
                                                    <td>
                                                        <input type="text" id="txt_reserve2" width="200px"></input>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="right">
                                                        <label id="lb_reserve3">reserve3</label>
                                                    </td>
                                                    <td>
                                                        <input type="text" id="txt_reserve3" width="200px"></input>
                                                    </td>
                                                    <td align="right">
                                                        <label id="lb_reserve4">reserve4</label>
                                                    </td>
                                                    <td>
                                                        <input type="text" id="txt_reserve4" width="200px"></input>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="right">
                                                        <label id="lb_reserve5">reserve5</label>
                                                    </td>
                                                    <td>
                                                        <input type="text" id="txt_reserve5" width="200px"></input>
                                                    </td>
                                                    <td align="right">
                                                        <label id="lb_reserve6">reserve6</label>
                                                    </td>
                                                    <td>
                                                        <input type="text" id="txt_reserve6" width="200px"></input>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="right">
                                                        <label id="lb_reserve7">reserve7</label>
                                                    </td>
                                                    <td>
                                                        <input type="text" id="txt_reserve7" width="200px"></input>
                                                    </td>
                                                    <td align="right">
                                                        <label id="lb_reserve8">reserve8</label>
                                                    </td>
                                                    <td>
                                                        <input type="text" id="txt_reserve8" width="200px"></input>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="right">
                                                        <label id="lb_reserve9">reserve9</label>
                                                    </td>
                                                    <td>
                                                        <input type="text" id="txt_reserve9" width="200px"></input>
                                                    </td>
                                                    <td align="right">
                                                        <label id="lb_reserve10">reserve10</label>
                                                    </td>
                                                    <td>
                                                        <input type="text" id="txt_reserve10" width="200px"></input>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="right">
                                                        <label id="lb_Remark">Remark</label>
                                                    </td>
                                                    <td>
                                                        <input type="text" id="txt_Remark" width="200px"></input>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="4" align="center">
                                                        <input type="button" value="保存" onclick="Save()" />
                                                        <%--<img id="Lang_Search2" style="cursor: pointer; display: none" onclick="searchList()" />--%>
                                                    </td>
                                                </tr>
                                            </table>
                                        </fieldset>
                                    </div>
                                </td>
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
                                    <img src="../images/tab_20.png" width="15" height="15" />
                                </td>
                                <td background="../images/tab_21.gif">
                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td width="25%" nowrap="nowrap"></td>
                                            <td width="75%" valign="top" class="STYLE1"></td>
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

    <!--script start-->
    <script src="../../JQuery/jquery-1.5.2.js"></script>
    <script src="../js/geturl.js" type="text/javascript"></script>
    <script src="../js/dragwindow.js" type="text/javascript"></script>
    <script src="../js/GlobalConst.js" type="text/javascript"></script>
    <script src="../../JS/LangueSwitch.js" type="text/javascript"></script>
    <script src="../js/geturl.js" type="text/javascript"></script>
    <script src="../js/highcharts.js"></script>
    <script src="../js/MouseMenu.js"></script>
    <%-- <%if (System.Configuration.ConfigurationManager.AppSettings["defaultLanguage"] == "zh-CN")
      { %>
    <script src="../../JQuery/ui.datepicker-zh-CN.js" type="text/javascript"></script>
    <%} %>--%>
    <script type="text/javascript">
        function SaveProcedure() {
            var procedurename = $("#txt_procedurename").val();
            if (procedurename.length == 0) {
                alert("流程名称不能为空！");
                return;
            }
            var lifttime = $("#txt_lifttime").val();
            if (lifttime.length == 0) {
                alert("周期不能为空！");
                return;
            }
            var firststep = $("#txt_firststep").val();
            if (firststep.length == 0) {
                alert("周期不能为空！");
                return;
            }
            var ptype = $("#txt_proceduretype").val();
            var remark = $("#txtRemark").val();
            var secstep = $("#txt_secstep").val();
            var thirdstep = $("#txt_thirdstep").val();
            var fourstep = $("#txt_fourstep").val();

            $.ajax({
                url: "../../Handlers/SaveProcedure.ashx",
                type: "POST",
                data: {
                    procedurename: procedurename,
                    ptype: ptype,
                    lifttime: lifttime,
                    remark: remark,
                    firststep: firststep,
                    secstep: secstep,
                    thirdstep: thirdstep,
                    fourstep:fourstep
                },
                dataType: 'json',
                success: function (status) {
                    if (status > 0) {
                        alert("保存成功！");
                    }
                    else {
                        alert("保存失败！")
                    }

                }
            })
        }

        ///流程名是否存在
        function checkExistsProcedure()
        {
            var procedurename = $("#txt_procedurename").val();
            $.ajax({
                url: "../../Handlers/CheckExistProcedure.ashx",
                type: "POST",
                data: {
                    procedurename: procedurename
                },
                dataType: 'json',
                success: function (status) {
                    if (status > 0) {
                        $("#txt_procedurename").focus();
                        $("#txt_procedurename").val("");
                        alert("流程名已存在，请修改！");
                    }
                    
                }
            })
        }
        function checkisInt() {
            var lifttime = $("#txt_lifttime").val()
            //定义正则表达式部分
            var reg = /^\d+$/;
            if (lifttime.match(reg) == null) {
                $("#txt_lifttime").focus();
                alert("周期(天)一栏请输入数字必须大于0");
                return;
            }
            else if(lifttime<=0) {
                alert("周期(天)一栏值必须大于0");
                return;
            }
        }
        //var Lang_Save = window.parent.parent.GetTextByName("Lang_Search2", window.parent.parent.useprameters.languagedata);
        //var Lang_Save_reset = window.parent.parent.GetTextByName("Lang_Search2_un", window.parent.parent.useprameters.languagedata);
        //var Lang_Search2 = window.document.getElementById("Lang_Search2");
        //Lang_Search2.onmousedown = function () {
        //    Lang_Search2.src = Lang_Save_reset;
        //};
        //Lang_Search2.onmouseup = function () {
        //    Lang_Search2.src = Lang_Save;
        //};

        function SelProcedureType() {
            var value = $("#sel_proceduretype").find("option:selected").text();
            $.ajax({
                type: "POST",
                url: "../../Handlers/GetProcedureType.ashx",
                data: "procedurename=" + value,
                success: function (msg) {
                    if (msg == "") {
                        $("input:text").val("");
                        return;
                    }
                    var arr = eval(msg);
                    for (var c in arr[0]) {
                        $("#txt_" + c).val(arr[0][c]);
                    }
                }
            });
        }

        function Save() {
            var procedurename = $("#sel_proceduretype").find("option:selected").text();
            var reserve1 = $("#txt_reserve1").val();
            var reserve2 = $("#txt_reserve2").val();
            var reserve3 = $("#txt_reserve3").val();
            var reserve4 = $("#txt_reserve4").val();
            var reserve5 = $("#txt_reserve5").val();
            var reserve6 = $("#txt_reserve6").val();
            var reserve7 = $("#txt_reserve7").val();
            var reserve8 = $("#txt_reserve8").val();
            var reserve9 = $("#txt_reserve9").val();
            var reserve10 = $("#txt_reserve10").val();
            var remark = $("#txt_Remark").val();
            $.ajax({
                url: "../../Handlers/ModefyProcedureType.ashx",
                type: "POST",
                data: {
                    procedurename: procedurename,
                    reserve1: reserve1,
                    reserve2: reserve2,
                    reserve3: reserve3,
                    reserve4: reserve4,
                    reserve5: reserve5,
                    reserve6: reserve6,
                    reserve7: reserve7,
                    reserve8: reserve8,
                    reserve9: reserve9,
                    reserve10: reserve10,
                    remark: remark
                },
                dataType: 'json',
                success: function (status) {
                    if (status > 0)
                        alert("保存成功！");
                    else
                        alert("保存失败！");
                }
            })
        }

        $(document).ready(function () {
            $("#sel_proceduretype").bind("change", "", SelProcedureType());
            $.ajax({
                type: "POST",
                url: "../../Handlers/GetProcedureName.ashx",
                success: function (msg) {
                    if (msg == null)
                        return;
                    var value = msg.split(',');

                    for (var s in value) {
                        var option = document.createElement("option");
                        option.value = value[s];
                        option.innerHTML = value[s];
                        $("#sel_proceduretype").append(option)
                    }
                    $("#sel_proceduretype").change(SelProcedureType());
                }
            });
        });
    </script>
</body>
</html>
