<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Manage_ProcedureAdd.aspx.cs" Inherits="Web.lqnew.opePages.Manage_ProcedureAdd" %>

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
    <style type="text/css">
        .divgrd
        {
            margin: 2 0 2 0;
            overflow: auto;
            height: 100px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
                <tr>
                    <td height="30px">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr >
                                 <td width="15" height="30px"  background="../images/tab_03.gif">
                                </td>
                                <td width="150" background="../images/tab_05.gif"></td>
                                <td background="../images/tab_05.gif" align="right">
                                       <img class="style6" style="cursor: hand;" onclick="window.parent.mycallfunction('Manage_ProcedureAdd')"
                                    onmouseover="javascript:this.src='../images/close_un.png';" onmouseout="javascript:this.src='../images/close.png';"
                                    src="../images/close.png" />
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
                                <!---------------------xzj--2018/6/29------------添加id="dragtd"用于窗口拖动-->
                                <td align="left" id="dragtd">
                                <!---------------------xzj--2018/6/29------------添加id="dragtd"用于窗口拖动-->
                                    <div id="Div1" style="font-family: Arial; width: 100%;text-align: left;">
                                        <fieldset>
                                            <legend>
                                                <label id="lb_procedurecreate">流程创建</label>
                                            </legend>
                                            <table width="100%" class="style1" cellspacing="0" border="0" cellpadding="1" id="Table1">
                                                <tr>
                                                    <td align="center" colspan="4" vertical-align="central">
                                                        <label id="Lang_procedurename">流程名称</label>
                                                        <input type="text" id="txt_procedurename"  width="200px" onblur="checkExistsProcedure()" size="10"></input>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="right">
                                                        <label id="Lang_procedureType">流程类型</label>
                                                    </td>
                                                    <td>
                                                        <select id="sel_proceduretype" style="width: 160px"></select>&nbsp;
                                                    </td>
                                                    <td align="right">
                                                        <label id="Lang_procedurelifttime">周期(天)</label>
                                                    </td>
                                                    <td>
                                                        <input type="text" id="txt_lifttime" width="200px" value="1" onblur="checkisInt()"></input>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="right">
                                                        <label id="Lang_Remark">备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注</label>
                                                    </td>
                                                    <td colspan="3">
                                                        <input type="text" id="txtRemark" width="200px"></input>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="4" align="center" heigh="100px">
                                                        <div id="Div2" style="font-family: Arial; width: 100%; text-align: left;">
                                                            <fieldset>
                                                                <legend>
                                                                    <label id="Lang_ProcedureStep">流程步骤</label>
                                                                </legend>
                                                                <div class="divgrd" id="tbtbz" style="height:100px;overflow:auto">
                                                                    <table width="100%" class="style1" cellspacing="0" border="0" cellpadding="1">
                                                                    <tr class="gridheadcss">
                                                                        <th scope="col" id="Lang_stepsequence">步骤序号</th>
                                                                        <th scope="col" id="Lang_stepname" with="200px">步骤名称</th>
                                                                        <th scope="col" style="white-space: nowrap; width: 80px;">
                                                                                <img id="Lang_AddOneLine" style="cursor: pointer" class="style5" onclick="createtr()" />
                                                                        </th>
                                                                    </tr>
                                                                     <tbody id="Tbody1"></tbody>
                                                                        
                                                                </table>
                                                                </div>
                                                            </fieldset>
                                                        </div>
                                                        <input id="Lang_btn_save" type="button" value="保存" onclick="SaveProcedure()" />
                                                        <%--<img id="Lang_Search2" style="cursor: pointer; display: none" onclick="searchList()" />--%>
                                                    </td>
                                                </tr>
                                            </table>
                                        </fieldset>
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
    
    <script type="text/javascript">
        ///关闭进度条
        window.parent.closeprossdiv();
        var language = window.parent.parent.useprameters.languagedata;
        //最后一步
        var Thelaststep = window.parent.parent.GetTextByName("Thelaststep", language);
        //全天结束
        var TodayIsOver = window.parent.parent.GetTextByName("TodayIsOver", language);
        function displaycardutymouserMenu() {
            window.parent.document.getElementById("mouseMenu").style.display = "none";
            
        }

        function SaveProcedure() {
            var tr = document.getElementById("pretr");
            if (tr) {
                alert("先提交之前添加的");
                return;
            }
            var procedurename = $("#txt_procedurename").val().trim();
            if (procedurename.length == 0||procedurename.length>50) {
                alert("流程名称不能为空且长度必须小于50！");
                return;
            }
            var lifttime = $("#txt_lifttime").val().trim();
            if (lifttime.length == 0) {
                alert("周期不能为空！");
                return;
            }

            var ptype = $("#sel_proceduretype").find("option:selected").text().trim();
            var remark = $("#txtRemark").val().trim();
            steparr.push(TodayIsOver);
            $.ajax({
                url: "../../Handlers/SaveProcedure.ashx",
                type: "POST",
                data: {
                    procedurename: procedurename,
                    ptype: ptype,
                    lifttime: lifttime,
                    remark: remark,
                    step: steparr.join(',')
                },
                dataType: 'json',
                success: function (status) {
                    if (status > 0) {
                        alert("保存成功！");
                        window.parent.lq_changeifr('manager_Procedure');
                        window.parent.mycallfunction('Manage_ProcedureAdd');
                    }
                    else {
                        alert("保存失败！")
                    }
                }
            })
        }

        ///流程名是否存在
        function checkExistsProcedure() {
            
            var procedurename = $("#txt_procedurename").val().trim();
            if (procedurename.length == 0)
            {
                alert("流程名称不能为空");
                return;
            }
            $.ajax({
                url: "../../Handlers/CheckExistProcedure.ashx",
                type: "POST",
                data: {
                    procedurename: procedurename
                },
                dataType: 'json',
                success: function (status) {
                    if (status > 0) {
                        //$("#txt_procedurename").focus();
                        $("#txt_procedurename").val("");
                        alert("流程名已存在，请修改！");
                    }

                }
            })
        }
        ///校验周期是否为数字
        function checkisInt() {
            var lifttime = $("#txt_lifttime").val().trim();
            //定义正则表达式部分
            var reg = /^\d+$/;
            if (lifttime.match(reg) == null) {
                $("#txt_lifttime").focus();
                $("#txt_lifttime").val('1');
                alert("周期(天)一栏请输入数字必须大于0");
                return;
            }
            else if (lifttime.length <= 0 || lifttime <= 0) {
                $("#txt_lifttime").focus();
                $("#txt_lifttime").val('1');
                alert("周期(天)一栏值必须大于0");
                return;
            }
        }

        var steparr = new Array();
        var rownum = 0;
        var tempname = "";
        function createtr() {
            var tr = document.getElementById("pretr");
            if (tr) {
                alert("先提交之前添加的");
                return;
            }

            $("#Tbody1").append("<tr id='pretr' style='font-size:12px;background-color:#FFFFFF;Height:20px;'>" +
                "<th scope='col' > " + (++rownum) + "</th>"+
                "<th><input id='tdText1'  type='text' style='width:150px'/></th>" +
                "<th scope='col' style='white-space:nowrap;width:80px;font-weight:normal;'><a onclick='insertLine()'><img src='images/001.gif' /> <font title='" + window.parent.GetTextByName("Lang_Submit", window.parent.useprameters.languagedata) + "' color='black'></font></a></th></tr>");
        }
        function isChinaOrLett(s){
            //判断是否是汉字、字母组成 
            var regu = "^[a-zA-Z\u4e00-\u9fa5]+$";
            var re = new RegExp(regu);
            if (re.test(s))
            {
                return true;
            }
            else {
                return false;
            }
        }
        function insertLine() {
            var value = $("#tdText1").val().trim();

            /// //判断是否是汉字、字母组成
            if (value.length == 0 || (!isChinaOrLett(value))){
                alert("步骤名称不能为空且只能是汉字或字母！");
               return;
            }
        //if (value.length == 0||(/^\d*$/).test(value)) {
        //        alert("步骤名称不能为空且只能是汉字或字母！");
        //        return;
        //    }

       
            ///判断临时变量中存在重复值
            for (var i = 0; i < steparr.length; i++) {
                if (steparr[i] == value) {
                    alert("与步骤" + (i + 1) + " 存在重复项！");
                    return;
                }
                if (TodayIsOver == value) {
                    alert("步骤重复");
                    return;
                }
            }

            tempname = value;

            steparr.push(value.trim());
            createline();
        }

        function createline() {
            var value = $("#tdText1").val().trim();
            $("#pretr").remove();
            $("#Tbody1").append("<tr id='row_" + rownum + "'  style='font-size:12px;background-color:#FFFFFF;'><th class='td_rownum' id='rownum_" + rownum + "' scope='col'style='font-weight:normal;color:black;Height:20px;' > " + (rownum) + " </th><th>" + tempname + "<th scope='col' style='white-space:nowrap;width:80px;font-weight:normal;'><a onclick=removeLine(" + rownum + ") ><img src='images/083.gif' /> <font title='" + window.parent.GetTextByName("Delete", window.parent.useprameters.languagedata) + "' id='Lang_Delete' color='black'></font></a></th></tr>");
        }
        function removeLine(value) {
            $("#row_" + value).remove();
            /*
            var rowcount = $("#Tbody1").find("tr").length + 1;
            if (value<rowcount) {
                for (var j = value; j < rowcount; j++)
                {
                    $("#rownum_" + (j + 1)).html(j);
                    document.getElementById("rownum_" + (j + 1)).id = "rownum_" + j;
                    document.getElementById("row_" + (j + 1)).id = "row_" + j;
                    
                    //$("#row_" + (j + 1)).attr("id", "#row_" + j);
                   //$("#rownum_" + (j + 1)).attr("id", "#rownum_" + j);
                }
                //for (var i = value-1 ; i < steparr.length; i++) {
                //    steparr[i].index = i + 1;
                //    //document.getElementById("rownum_" + (i + 2)).id = "rownum_" + i;
                //    $("#row_" + (i + 2)).attr("id") = "row_"+i + 1;
                //    $("#rownum_" + (i + 2)).html(i+1);
                //    //document.getElementById("rownum_" + (i + 1)).id = "rownum_" + i;
                //}
            }
            */

            $(".td_rownum").each(function (index, element) {
                element.innerHTML = index + 1;
            })

            steparr.splice(value - 1, 1);
            --rownum;
            //alert(steparr);
        }

        $(document).ready(function () {
         
            initProcedureType();
            $("#Tbody1").append("<tr style='font-size:12px;background-color:#FFFFFF;'>" +
                "<th scope='col'style='font-weight:normal;color:black;Height:20px;' >"+Thelaststep+"</th>" +
                "<th>"+TodayIsOver+"</th>" +
                "<th scope='col' style='white-space:nowrap;width:80px;font-weight:normal;'></th></tr>");
        });

        function initProcedureType() {
            $("#sel_proceduretype").find("option").remove()
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
                        option.title = value[s];
                        $("#sel_proceduretype").append(option);
                    }
                }
            });
        }
    </script>
</body>
</html>
