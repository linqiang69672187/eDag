<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Manager_PtypeModify.aspx.cs" Inherits="Web.lqnew.opePages.Manager_PtypeModify" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link href="../css/lq_addedit.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/pagestyle.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/ui-lightness/jquery-ui-1.8.13.custom.css" rel="stylesheet" type="text/css" />
    <script src="../../JQuery/jquery-1.5.2.js"></script>
    <script src="../js/geturl.js" type="text/javascript"></script>
    <script src="../js/dragwindow.js" type="text/javascript"></script>
    <script src="../js/GlobalConst.js" type="text/javascript"></script>
    <script src="../../JS/LangueSwitch.js" type="text/javascript"></script>
    <script src="../js/geturl.js" type="text/javascript"></script>
    <script src="../js/highcharts.js"></script>
    <script src="../js/MouseMenu.js"></script>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
                <tr>
                    <td height="30">
                         <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr >
                                 <td width="15" height="30px"  background="../images/tab_03.gif">
                                </td>
                                <td width="150" background="../images/tab_05.gif"></td>
                                <td background="../images/tab_05.gif" align="right">
                                    <!---------------------------xzj--2018/6/28--注释原来的，新的将原来的displaycardutymouserMenu()函数去了------------------>
                                    <!--<img class="style6" style="cursor: hand;" onclick="displaycardutymouserMenu();window.parent.mycallfunction('Manager_PtypeModify');"
                                        onmouseover="javascript:this.src='../images/close_un.png';" onmouseout="javascript:this.src='../images/close.png';"
                                        src="../images/close.png" />-->
                                    <img class="style6" style="cursor: hand;" onclick="window.parent.mycallfunction('Manager_PtypeModify');"
                                        onmouseover="javascript:this.src='../images/close_un.png';" onmouseout="javascript:this.src='../images/close.png';"
                                        src="../images/close.png" />
                                    <!---------------------------xzj--2018/6/28--注释原来的，新的将原来的displaycardutymouserMenu()函数去了------------------>
                                </td>
                                <td  width="14" height="30px"  background="../images/tab_07.gif">
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
                                    <div id="Div3" style="font-family: Arial; width: 100%; text-align: left;">
                                        
                                            <table width="100%" class="style1" cellspacing="0" border="0" cellpadding="1" id="dragtd">
                                                <tr style="">
                                                    <td align="center" colspan="4" vertical-align="central">
                                                        <label id="Lang_procedureType">流程类型</label>
                                                        <select id="sel_proceduretype" onchange="SelProcedureType()" style="width: 200px"></select>
                                                        <%--<select id="sel_proceduretype" onkeydown="catch_keydown(this);" onkeypress="catch_press(this)" onchange="SelProcedureType()" style="width: 200px"></select>--%>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="right">
                                                        <label id="Lang_reserve1">字段1</label>
                                                    </td>
                                                    <td>
                                                        <input type="text" id="txt_reserve1" width="200px" onblur="CheckLength(txt_reserve1)"></input>
                                                    </td>

                                                    <td align="right">
                                                        <label id="Lang_reserve2">字段2</label>
                                                    </td>
                                                    <td>
                                                        <input type="text" id="txt_reserve2" width="200px" onblur="CheckLength(txt_reserve2)"></input>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="right">
                                                        <label id="Lang_reserve3">字段3</label>
                                                    </td>
                                                    <td>
                                                        <input type="text" id="txt_reserve3" width="200px" onblur="CheckLength(txt_reserve3)"></input>
                                                    </td>
                                                    <td align="right">
                                                        <label id="Lang_reserve4">字段4</label>
                                                    </td>
                                                    <td>
                                                        <input type="text" id="txt_reserve4" width="200px" onblur="CheckLength(txt_reserve4)"></input>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="right">
                                                        <label id="Lang_reserve5">字段5</label>
                                                    </td>
                                                    <td>
                                                        <input type="text" id="txt_reserve5" width="200px" onblur="CheckLength(txt_reserve5)"></input>
                                                    </td>
                                                    <td align="right">
                                                        <label id="Lang_reserve6">字段6</label>
                                                    </td>
                                                    <td>
                                                        <input type="text" id="txt_reserve6" width="200px" onblur="CheckLength(txt_reserve6)"></input>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="right">
                                                        <label id="Lang_reserve7">字段7</label>
                                                    </td>
                                                    <td>
                                                        <input type="text" id="txt_reserve7" width="200px" onblur="CheckLength(txt_reserve7)"></input>
                                                    </td>
                                                    <td align="right">
                                                        <label id="Lang_reserve8">字段8</label>
                                                    </td>
                                                    <td>
                                                        <input type="text" id="txt_reserve8" width="200px" onblur="CheckLength(txt_reserve8)"></input>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="right">
                                                        <label id="Lang_reserve9">字段9</label>
                                                    </td>
                                                    <td>
                                                        <input type="text" id="txt_reserve9" width="200px" onblur="CheckLength(txt_reserve9)"></input>
                                                    </td>
                                                    <td align="right">
                                                        <label id="Lang_reserve10">字段10</label>
                                                    </td>
                                                    <td>
                                                        <input type="text" id="txt_reserve10" width="200px" onblur="CheckLength(txt_reserve10)"></input>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="right" >
                                                        <label id="Lang_Remark">备注</label>
                                                    </td>
                                                    <td colspan="3">
                                                        <input type="text" id="txt_Remark" width="200px" onblur="CheckLength(txt_Remark)"></input>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="4" align="center">
                                                        <input id="Lang_btn_save" type="button" value="保存" onclick="Save()" />
                                                        <%--<img id="Lang_Search2" style="cursor: pointer; display: none" onclick="searchList()" />--%>
                                                    </td>
                                                </tr>
                                            </table>
                                        
                                    </div>
                                </td>
                                <td width="14" background="../images/tab_16.gif"></td>
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
                                            <td width="75%" valign="top" class="STYLE1">


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

    <!--script start-->
   
    <script type="text/javascript">
        ///关闭进度条
        window.parent.closeprossdiv();

        //window.parent.parent.document.getElementById("mybkdiv").style.display = "block";

        Request = {
            QueryString: function (item) {
                var svalue = location.search.match(new RegExp("[\?\&]" + item + "=([^\&]*)(\&?)", "i"));
                return svalue ? svalue[1] : svalue;
            }
        }
        var language = window.parent.parent.useprameters.languagedata;

        //保存成功
        var saveSuccess = window.parent.parent.GetTextByName("saveSuccess", language);
        //保存失败
        var saveFail = window.parent.parent.GetTextByName("saveFail", language);
        //备注长度必须小于100
        var LengthOfNote = window.parent.parent.GetTextByName("LengthOfNote", language);
        //流程类型名称已存在，请修改！
        var PtypeNameExist = window.parent.parent.GetTextByName("PtypeNameExist", language);
        //流程类型名称不能为空
        var PtypeNameCannotNull = window.parent.parent.GetTextByName("PtypeNameCannotNull", language);
        //流程类型长度必须小于25
        var LengthOfPtypeName = window.parent.parent.GetTextByName("LengthOfPtypeName", language);
        //长度必须小于50
        var LengthSamllerthan50 = window.parent.parent.GetTextByName("LengthSamllerthan50", language);
        function displaycardutymouserMenu() {
            window.parent.document.getElementById("mouseMenu").style.display = "none";
            //window.parent.parent.document.getElementById("mybkdiv").style.display = "none";

        }

        //function catch_press(sel) {
        //    sel.options[sel.selectedIndex].text = sel.options[sel.selectedIndex].text + String.fromCharCode(event.keyCode);
        //    event.returnValue = false;
        //}
        //function catch_keydown(sel) {
        //    switch (event.keyCode) {
        //        case 13:
        //            //Enter;
        //            sel.options[sel.length] = new Option("", "", false, true);
        //            event.returnValue = false;
        //            break;
        //        case 27:
        //            //Esc;
        //            alert("text:" + sel.options[sel.selectedIndex].text + ", value:" + sel.options[sel.selectedIndex].value + ";");
        //            event.returnValue = false;
        //            break;
        //        case 46:
        //            //Delete;
        //            if (confirm("删除当前选项!?")) {
        //                sel.options[sel.selectedIndex] = null;
        //                if (sel.length > 0) {
        //                    sel.options[0].selected = true;
        //                }
        //            }
        //            event.returnValue = false;
        //            break;
        //        case 8:
        //            //Back Space;
        //            var s = sel.options[sel.selectedIndex].text;
        //            sel.options[sel.selectedIndex].text = s.substr(0, s.length - 1);
        //            event.returnValue = false;
        //            break;
        //    }

        //}

        ///查询流程类型
        function SelProcedureType() {
            var value = $("#sel_proceduretype").find("option:selected").text();
            $.ajax({
                type: "POST",
                url: "../../Handlers/GetProcedureType.ashx",
                data: {
                    procedurename: value,
                    type: ""
                },
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
        function CheckLength(id) {
            var value = $("#" + id.id).val();
            if (id.id == "txt_Remark") {
                if (value.length > 100) {
                    $("#" + id.id).val("");
                    alert(LengthOfNote);
                    return;
                }
            }
            else if (value.length > 50) {
                var index = id.id.indexOf('_');
                var label = "Lang" + id.id.substring(index, id.id.length);

                $("#" + id.id).val("");
                alert(window.parent.parent.GetTextByName(label, window.parent.parent.useprameters.languagedata) + LengthSamllerthan50);
                return;
            }
        }
        ///流程类型保存
        function Save() {
            //var select=$("#sel_proceduretype");
            //var temp = select.find("option:selected").text();
            //var count = 0;
            //for (var c in select.find("option"))
            //{
            //    if (c == temp)
            //        count++;
            //}
            //return;
            var procedurename = $("#sel_proceduretype").find("option:selected").text().trim();
            var reserve1 = $("#txt_reserve1").val().trim();
            var reserve2 = $("#txt_reserve2").val().trim();
            var reserve3 = $("#txt_reserve3").val().trim();
            var reserve4 = $("#txt_reserve4").val().trim();
            var reserve5 = $("#txt_reserve5").val().trim();
            var reserve6 = $("#txt_reserve6").val().trim();
            var reserve7 = $("#txt_reserve7").val().trim();
            var reserve8 = $("#txt_reserve8").val().trim();
            var reserve9 = $("#txt_reserve9").val().trim();
            var reserve10 = $("#txt_reserve10").val().trim();
            var remark = $("#txt_Remark").val().trim();
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
                    if (status > 0) {
                        alert(saveSuccess);
                        window.parent.lq_changeifr('manager_Ptype');
                        window.parent.mycallfunction('Manager_PtypeModify');
                    }
                    else
                        alert(saveFail);
                }
            })
        }

        $(document).ready(function () {
            InitProcedureType();
            
            //$("#sel_proceduretype").find("option").val(name);
        });

        function InitProcedureType() {
            $("#sel_proceduretype").find("option").remove();

            $.ajax({
                type: "POST",
                url: "../../Handlers/GetProcedureTypeName.ashx",
                success: function (msg) {
                    if (msg == null)
                        return;
                    var value = msg.split(',');

                    for (var s in value) {
                        var option = document.createElement("option");
                        option.value = value[s];
                        option.innerHTML = value[s];
                        $("#sel_proceduretype").append(option);
                        //$("#txt_proceduretype").append(option);
                    }

                    var name = Request.QueryString('id');
                    //alert(name);
                    $("#sel_proceduretype option[value='" + name + "']").attr("selected", "selected");
                    $("#sel_proceduretype").change(SelProcedureType());

                }
            });
        }
    </script>
</body>
</html>
