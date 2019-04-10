<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="manageUserDutyList.aspx.cs" Inherits="Web.lqnew.opePages.manageUserDutyList" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <script src="../../JS/LangueSwitch.js" type="text/javascript"></script>
    <link href="../css/lq_manager.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/pagestyle.css" rel="stylesheet" type="text/css" />
    <script src="../js/geturl.js" type="text/javascript"></script>
    <script src="../js/dragwindow.js" type="text/javascript"></script>
    <script src="../../JQuery/jquery-1.5.2.js" type="text/javascript"></script>
    <script src="../js/manageStopSelectSubmit.js" type="text/javascript"></script>
    <script type="text/javascript">

        var Lang_loading = window.parent.parent.GetTextByName("Lang_loading", window.parent.parent.useprameters.languagedata);
        var LangNone = window.parent.parent.GetTextByName("Lang-None", window.parent.parent.useprameters.languagedata);
        var Unkown = window.parent.parent.GetTextByName("Unkown", window.parent.parent.useprameters.languagedata);
        var arrayISSI = new Array();
        var everypagecount = 10;
        var currentPage = 1;
        var totalPage = 1;
        var totalCounts = 0;
        function reroadpagetitle() {

            if (totalCounts % everypagecount == 0) {
                totalPage = parseInt(totalCounts / everypagecount);
            } else {
                totalPage = parseInt(totalCounts / everypagecount + 1);
            }
            if (currentPage > totalPage) {
                currentPage = totalPage;
            }

            var sel = document.getElementById("sel_page");

            if (totalPage < sel.length) {
                sel.length = totalPage;
            } else if (totalPage == sel.length) {

            } else {
                sel.style.display = "none";
                for (var p = sel.length + 1; p <= totalPage; p++) {
                    var option = document.createElement("option");
                    option.value = p;
                    option.innerHTML = p;
                    sel.appendChild(option);
                }
                sel.style.display = "inline";
            }

            sel.value = currentPage;
            document.getElementById("span_currentPage").innerHTML = currentPage;
            document.getElementById("span_totalpage").innerHTML = totalPage;
            document.getElementById("span_total").innerHTML = totalCounts;
            isFirstPage();
            if (isLastPage(currentPage) && currentPage > 0) {

                document.getElementById("span_currentact").innerHTML = (currentPage - 1) * everypagecount + 1 + "~" + totalCounts;
            } else if (currentPage <= 0) {
                document.getElementById("span_currentact").innerHTML = 0 + "~" + currentPage * everypagecount;

            } else {
                document.getElementById("span_currentact").innerHTML = (currentPage - 1) * everypagecount + 1 + "~" + currentPage * everypagecount;
            }

        }
        var pid = "";//流程ID
        var uname = "";
        function getData() {
            var pid = window.document.getElementById("sel_WorkFlow").value;
            var uname = window.document.getElementById("txtNameOrIssi").value;
           
            for (var i = 0; i < arrayISSI.length; i++) {
                $("#" + arrayISSI[i]).remove();
            }
            $("#isprocessing").remove();
            $("#Tbody1").append("<tr id='isprocessing' style='background-color:White;height:22px;color:red'><td colspan='6' >" + Lang_loading + "</td></tr>");
            window.parent.jquerygetNewData_ajax("../../Handlers/StatuesManage/GetUserDutyListServices.ashx", { PageIndex: currentPage, Limit: everypagecount, pid: pid, uname: uname }, function (msg) {
                $("#isprocessing").remove();
                totalCounts = msg.totalcount;
                reroadpagetitle();
                for (var i = 0; i < arrayISSI.length; i++) {
                    $("#" + arrayISSI[i]).remove();
                }
                arrayISSI.length = 0;

                if (msg.data.length == 0) {
                    $("#Tbody1").append("<tr id='isprocessing' style='background-color:White;height:22px;color:red'><td colspan='6' >" + LangNone + "</td></tr>");
                }
               

                for (var i = 0; i < msg.data.length; i++) {
                  

                    $("#Tbody1").append("<tr id='bbbb" + i + "' onmouseover='changeTgBg(this,&#39;font&#39;)' onmouseout='overchangeTgBg(this,&#39;font&#39;)' style='background-color:White;height:22px;'><td align='center'>" + msg.data[i].pname + "</td><td  align='center'>" + msg.data[i].issi + "</td><td style='' align='center'>" + msg.data[i].uname + "</td><td style='' align='center'>" + msg.data[i].num + "</td><td style='' align='center' >" + msg.data[i].ename + "</td><td><span  style=\"cursor:pointer;text-decoration:underline;\" onclick='deluserpro(" + msg.data[i].id + ")'><img src='images/083.gif' /></span></td></tr>");
                    arrayISSI.push("bbbb"+i);
                }
            });
        }

        function deluserpro(id) {
            
            if (!confirm(window.parent.GetTextByName("BeSureToDel", window.parent.useprameters.languagedata))) {

                return;
            }
            window.parent.jquerygetNewData_ajax("../../Handlers/StatuesManage/DelUserDuty.ashx", { pid: id }, function (msg) {
                pid = "";//流程ID
                uname = "";
                var p = eval(msg);
                alert(p[0].result);
                searchList();
            });
            
        }

        document.onkeypress = function () {
            if (event.keyCode == 13) {
                event.keyCode = 0;
                event.returnValue = false;
                searchList();
            }
        }
        function searchList() {
            currentPage = 1;
            getData();
        }
        function isFirstPage() {
            if (currentPage <= 1) {
                window.document.getElementById("Lang_FirstPage").style.color = "gray";
                window.document.getElementById("Lang_PrePage").style.color = "gray";
                window.document.getElementById("Lang_FirstPage").style.textDecoration = "none";
                window.document.getElementById("Lang_PrePage").style.textDecoration = "none";
            } else {
                window.document.getElementById("Lang_FirstPage").style.color = "blue";
                window.document.getElementById("Lang_PrePage").style.color = "blue";
                window.document.getElementById("Lang_FirstPage").style.textDecoration = "underline";
                window.document.getElementById("Lang_PrePage").style.textDecoration = "underline";
            }
        }
        //判断是否为最后一页
        function isLastPage(currentPage) {
            if (currentPage >= totalPage) {
                window.document.getElementById("Lang_play_next_page").style.color = "gray";
                window.document.getElementById("Lang_LastPage").style.color = "gray";
                window.document.getElementById("Lang_play_next_page").style.textDecoration = "none";
                window.document.getElementById("Lang_LastPage").style.textDecoration = "none";
                return true;
            } else {
                window.document.getElementById("Lang_play_next_page").style.color = "blue";
                window.document.getElementById("Lang_LastPage").style.color = "blue";
                window.document.getElementById("Lang_play_next_page").style.textDecoration = "underline";
                window.document.getElementById("Lang_LastPage").style.textDecoration = "underline";
                return false;
            }
        }
        function nextPage() {
            if (totalPage <= currentPage) {
                return;
            }
            currentPage++;
            getData();
            document.getElementById("sel_page").value = currentPage;
        }
        function prePage() {
            if (currentPage <= 1) {
                return;
            }
            currentPage--;
            getData();
            document.getElementById("sel_page").value = currentPage;
        }
        function firstPage() {
            if (currentPage == 1) {
                return;
            }
            currentPage = 1;
            getData();
            document.getElementById("sel_page").value = currentPage;
        }
        function lastPage() {
            if (currentPage == totalPage) {
                return;
            }
            currentPage = totalPage;
            getData();
            document.getElementById("sel_page").value = currentPage;
        }
        function tzpage() {

            var sel = document.getElementById("sel_page").value;

            if (sel == currentPage) {
                return;
            }
            currentPage = sel;
            getData();
            document.getElementById("sel_page").value = currentPage;
        }

        function getProcedureList() {
            window.parent.jquerygetNewData_ajax("../../Handlers/StatuesManage/GetProcedureListService.ashx", "", function (msg) {
                if (msg) {
                    var myarray = eval(msg);
                    var selWorkFlow = document.getElementById("sel_WorkFlow");
                    selWorkFlow.length = 0;
                    var optionf = document.createElement("option");
                    optionf.value = "";
                    optionf.innerHTML = window.parent.parent.GetTextByName("Lang_all_searchoption", window.parent.parent.useprameters.languagedata);
                    selWorkFlow.appendChild(optionf);
                    selWorkFlow.style.display = "none";
                    for (var pli = 0; pli < myarray.length; pli++) {
                        var option = document.createElement("option");
                        option.value = myarray[pli].id;
                        option.innerHTML = myarray[pli].name;
                        selWorkFlow.appendChild(option);
                    }
                    selWorkFlow.style.display = "inline";
                    //将searchList()放入getProcedureList()中，注释下面的searchList()---------xzj--2018/6/29--------------
                    searchList();
                    //将searchList()放入getProcedureList()中，注释下面的searchList()---------xzj--2018/6/29--------------
                }
            })
        }
    </script>
</head>
<body style="height: 350px" onselectstart="return false;">
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
                                    <ul class="hor_ul" id="userul" runat="server">
                                        <li>
                                            <img src="../images/311.gif" width="16" height="16" /><span id="Lang_UserBindPro"></span>&nbsp;&nbsp;</li>
                                        <li>
                                           <span id="Lang_pleaseselectliuc"></span>&nbsp;&nbsp;<select id="sel_WorkFlow" onchange="" style="width: 200px">
                                                                            <option id="Lang_all_searchoption"></option>
                                                                        </select>  
                                        </li>
                                        <li><span id="span_ISSI">issi</span><span>&nbsp;&nbsp;</span>
                                            <input id="txtNameOrIssi" style="width: 67px" /></li>
                                        
                                        

                                        <li>
                                            <img id="Lang_Search2" style="cursor: pointer" onclick="searchList()" />
                                        </li>
                                         <li>
                                        <img id="Lang_AddNew"  class="style6" style="cursor: hand;" onclick="window.parent.mycallfunction('add_BindProToUser',550, 550)"
                                             onmouseover="javascript:this.src=window.parent.GetTextByName('Lang_AddNew_un',window.parent.useprameters.languagedata);" onmouseout="javascript:this.src=window.parent.GetTextByName('Lang_AddNew',window.parent.useprameters.languagedata);"
                                             /></li>
                                    </ul>
                                </td>
                                <td width="50" background="../images/tab_05.gif" align="right">
                                    <img style="cursor: pointer;" onclick="window.parent.mycallfunction('manageUserDutyList',693, 702)"
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
                                <td width="15" background="../images/tab_12.gif">&nbsp;
                                </td>
                                <td align="center" valign="top" style="height: 300px; background-color: white" id="dragtd">

                                    <table cellspacing="1" cellpadding="0" id="GridView1" style="background-color: #C0DE98; border-color: White; border-width: 0px; border-style: Ridge; width: 99%;">
                                        <tr style="color: blue; background-color: White; height: 28px;">

                                            <th style="font-family: Arial" scope="col" colspan="6" align="right">
                                                <table style="width: 100%">
                                                    <tr>
                                                        <td align="right" style="width: 68%">
                                                            <span onclick="firstPage()" class="YangdjPageStyle" id="Lang_FirstPage">首页</span>&nbsp;&nbsp;<span onclick="prePage()" class="YangdjPageStyle" id="Lang_PrePage">上一页</span>&nbsp;&nbsp;<span onclick="nextPage()"  class="YangdjPageStyle" id="Lang_play_next_page">下一页</span>&nbsp;&nbsp;<span onclick="lastPage()" class="YangdjPageStyle" id="Lang_LastPage">尾页</span>
                                                        </td>
                                                        <td align="right" style="width: 7%">

                                                            <select onchange="tzpage()" id="sel_page"></select>
                                                             </td>
                                                        <td align="right" style="width: 25%">
                                                            
                                                    <span id="span_page"></span><span id="span_currentPage">0</span>/<span id="span_totalpage">0</span>&nbsp;&nbsp;
                                                          <span id="span_tiao"></span>
                                                            <span id="span_currentact">0~0</span>/<span id="span_total">0</span>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </th>


                                        </tr>
                                        <tr class="gridheadcss" style="font-weight: bold;">
                                            <th style="width:25%" id="Lang_SSLC" scope="col"></th>
                                            <th style="width:15%" id="Lang_terminal_identification" scope="col"></th>
                                            <th style="width:15%" id="Lang_Name" scope="col"></th>
                                            <th style="width:15%" id="Number" scope="col"></th>
                                            <th style="width:22%" id="Subordinateunits"  scope="col"></th>
                                             <th style="width:8%" id="Lang_Operate"  scope="col"></th>

                                        </tr>

                                        <tbody id="Tbody1">
                                        </tbody>
                                    </table>

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
</body>
</html>
<script>  
    window.parent.closeprossdiv();
    window.document.getElementById("Lang_AddNew").src = this.src = window.parent.GetTextByName('Lang_AddNew', window.parent.useprameters.languagedata);
    var Lang_Search22 = window.parent.parent.GetTextByName("Lang_Search2", window.parent.parent.useprameters.languagedata);
    var Lang_Search2_un = window.parent.parent.GetTextByName("Lang_Search2_un", window.parent.parent.useprameters.languagedata);
    var Lang_Search2 = window.document.getElementById("Lang_Search2");
    Lang_Search2.src = Lang_Search22;
    Lang_Search2.onmousedown = function () {
        Lang_Search2.src = Lang_Search2_un;
    }
    Lang_Search2.onmouseup = function () {
        Lang_Search2.src = Lang_Search22;
    }
    getProcedureList();
    //将searchList()放入getProcedureList()中，注释下面的searchList()---------xzj--2018/6/29--------------
    //searchList();
    //将searchList()放入getProcedureList()中，注释下面的searchList()---------xzj--2018/6/29--------------
    var span_page = window.parent.parent.GetTextByName("Page", window.parent.parent.useprameters.languagedata);
    var span_tiao = window.parent.parent.GetTextByName("Article", window.parent.parent.useprameters.languagedata);

    window.document.getElementById("span_page").innerHTML = span_page;
    window.document.getElementById("span_tiao").innerHTML = span_tiao;
    window.document.getElementById("Lang_SSLC").innerHTML = window.parent.parent.GetTextByName("Lang_SSLC", window.parent.parent.useprameters.languagedata);
    window.document.getElementById("Lang_terminal_identification").innerHTML = window.parent.parent.GetTextByName("Lang_terminal_identification", window.parent.parent.useprameters.languagedata);
    window.document.getElementById("Lang_Name").innerHTML = window.parent.parent.GetTextByName("Lang_Name", window.parent.parent.useprameters.languagedata);
    window.document.getElementById("Number").innerHTML = window.parent.parent.GetTextByName("Number", window.parent.parent.useprameters.languagedata);
    window.document.getElementById("Subordinateunits").innerHTML = window.parent.parent.GetTextByName("Subordinateunits", window.parent.parent.useprameters.languagedata);
    window.document.getElementById("Lang_Operate").innerHTML = window.parent.parent.GetTextByName("Lang_Operate", window.parent.parent.useprameters.languagedata);
    window.document.getElementById("Lang_pleaseselectliuc").innerHTML = window.parent.parent.GetTextByName("Lang_pleaseselectliuc", window.parent.parent.useprameters.languagedata);
    window.document.getElementById("Lang_UserBindPro").innerHTML = window.parent.parent.GetTextByName("Lang_UserBindPro", window.parent.parent.useprameters.languagedata);
    window.document.getElementById("span_ISSI").innerHTML = window.parent.parent.GetTextByName("Lang_terminal_identification", window.parent.parent.useprameters.languagedata);
    window.document.getElementById("Lang_all_searchoption").innerHTML = window.parent.parent.GetTextByName("Lang_all_searchoption", window.parent.parent.useprameters.languagedata);
    </script>
