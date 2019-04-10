<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ErrorList.aspx.cs" Inherits="Web.lqnew.opePages.LogList.ErrorList" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="../../../JS/LangueSwitch.js" type="text/javascript"></script>
    <link href="../../css/lq_manager.css" rel="stylesheet" type="text/css" />
    <link href="../../../CSS/pagestyle.css" rel="stylesheet" type="text/css" />
    <script src="../../js/geturl.js" type="text/javascript"></script>

    <script src="../../../JQuery/jquery-1.5.2.js" type="text/javascript"></script>
    <script src="../../js/manageStopSelectSubmit.js" type="text/javascript"></script>
    <link href="../../../../CSS/ui-lightness/jquery-ui-1.8.13.custom.css" rel="stylesheet"
        type="text/css" />
    <script src="../../../JQuery/jquery-ui-1.8.13.custom.min.js" type="text/javascript"></script>
    <script type="text/javascript">
        var everypagecount = 10;
        var currentPage = 1;
        var totalPage = 1;
        var totalCounts = 0;
        var start=0;
        var end=0;

        var recordsArray = new Array();
        var view = window.parent.parent.GetTextByName("Lang_View", window.parent.parent.useprameters.languagedata);
        function getData() {
            window.parent.jquerygetNewData_ajax("../../../Handlers/GetErrorLogList.ashx", {}, function (msg) {
                msg = eval(msg);
                totalCounts = msg.count;//总条数
                recordsArray = msg.data;
                if (totalCounts % everypagecount == 0) {
                    totalPage = parseInt(totalCounts / everypagecount);
                } else {
                    totalPage = parseInt(totalCounts / everypagecount + 1);
                }
                if (currentPage > totalPage) {
                    currentPage = totalPage;
                }

                toRendHtml();


            });
        }
        function toRendHtml() {
            toRendTitle();
            for (i = 0; i <= totalCounts; i++) {
                if ($("#" + i)) {
                    $("#" + i).remove();
                }
            }
            for (i = start-1; i < end; i++) {
                $("#Tbody1").append("<tr id=" + recordsArray[i].id + " onmouseover='changeTgBg(this,&#39;font&#39;)' onmouseout='overchangeTgBg(this,&#39;font&#39;)' style='background-color:White;height:22px;'> <td align='center'>" + recordsArray[i].name + "</td><td  align='center'>" + recordsArray[i].size + "</td><td  align='center'><span style='cursor:pointer' onclick='downFile(\"" + recordsArray[i].name + "\")'>" + view + "</span></td></tr>");
            }

        }

        function downFile(filename) {
            window.open("../../../Logs/" + filename);
        }

        function toRendTitle() {
            window.document.getElementById("span_currentPage").innerHTML = currentPage;
            window.document.getElementById("span_totalpage").innerHTML = totalPage;
            if (isLastPage(currentPage) && currentPage > 0) {

                document.getElementById("span_currentact").innerHTML = (currentPage - 1) * everypagecount + 1 + "~" + totalCounts;
                start = (currentPage - 1) * everypagecount + 1;
                end = totalCounts;
            } else if (currentPage <= 0) {
                document.getElementById("span_currentact").innerHTML = 0 + "~" + currentPage * everypagecount;
                start = 0;
                end = currentPage * everypagecount;
            } else {
                document.getElementById("span_currentact").innerHTML = (currentPage - 1) * everypagecount + 1 + "~" + currentPage * everypagecount;
                start = (currentPage - 1) * everypagecount + 1;
                end = currentPage * everypagecount;
            }
            window.document.getElementById("span_total").innerHTML = totalCounts;

            isFirstPage();

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
            toRendHtml();
            document.getElementById("sel_page").value = currentPage;
        }
        function prePage() {
            if (currentPage <= 1) {
                return;
            }
            currentPage--;
            toRendHtml();
            document.getElementById("sel_page").value = currentPage;
        }
        function firstPage() {
            if (currentPage == 1) {
                return;
            }
            currentPage = 1;
            toRendHtml();
            document.getElementById("sel_page").value = currentPage;
        }
        function lastPage() {
            if (currentPage == totalPage) {
                return;
            }
            currentPage = totalPage;
            toRendHtml();
            document.getElementById("sel_page").value = currentPage;
        }
        function tzpage() {

            var sel = document.getElementById("sel_page").value;

            if (sel == currentPage) {
                return;
            }
            currentPage = sel;
            toRendHtml();
            document.getElementById("sel_page").value = currentPage;
        }
    </script>


</head>
<body style="height: 390px" onselectstart="return false;">
    <form id="form1" runat="server">
        <div>
            <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
                <tr>
                    <td height="30">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td width="15" height="32">
                                    <img src="../../images/tab_03.png" width="15" height="32" />
                                </td>
                                <td width="1101" background="../../images/tab_05.gif">
                                    <ul class="hor_ul" id="userul2" runat="server">
                                        <li>
                                            <img src="../../images/311.gif" width="16" height="16" /><span id="errorLog_Menu"></span></li>

                                    </ul>
                                </td>
                                <td width="50" background="../../images/tab_05.gif" align="right">
                                    <img style="cursor: pointer;" onclick="window.parent.mycallfunction('LogList/ErrorList',693, 702)"
                                        onmouseover="javascript:this.src='../../images/close_un.png';" onmouseout="javascript:this.src='../../images/close.png';"
                                        src="../../images/close.png" />
                                </td>
                                <td width="14">
                                    <img src="../../images/tab_07.png" width="14" height="32" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td width="15" background="../../images/tab_12.gif">&nbsp;
                                </td>
                                <td align="center" valign="top" style="height: 300px; background-color: white" id="dragtd">

                                    <table cellspacing="1" cellpadding="0" id="GridView1" style="background-color: #C0DE98; border-color: White; border-width: 0px; border-style: Ridge; width: 99%;">
                                        <tr style="color: blue; background-color: White; height: 28px; display: none">
                                            <th style="font-family: Arial" scope="col" colspan="3" align="right">
                                                <table style="width: 100%">
                                                    <tr>
                                                        <td colspan="2" align="left"></td>
                                                        <td align="right">
                                                            <span id="pp"></span>
                                                        </td>
                                                        <td style="width: 200px" align="left"></td>
                                                        <td align="left"></td>
                                                    </tr>
                                                    <tr>
                                                        <td align="left" style="width: 60px"></td>
                                                        <td align="left" style="width: 200px"></td>
                                                        <td align="left"></td>
                                                    </tr>
                                                </table>
                                            </th>
                                        </tr>
                                        <tr style="color: blue; background-color: White; height: 28px;">

                                            <th style="font-family: Arial" scope="col" colspan="3" align="right">
                                                <table style="width: 100%">
                                                    <tr>
                                                      
                                                        <td align="right" style="width: 78%">
                                                            <span onclick="firstPage()" class="YangdjPageStyle" id="Lang_FirstPage">首页</span>&nbsp;&nbsp;<span onclick="prePage()" class="YangdjPageStyle" id="Lang_PrePage">上一页</span>&nbsp;&nbsp;<span onclick="nextPage()" class="YangdjPageStyle" id="Lang_play_next_page">下一页</span>&nbsp;&nbsp;<span onclick="lastPage()" class="YangdjPageStyle" id="Lang_LastPage">尾页</span>
                                                        </td>
                                                        <td align="right" style="width: 7%">

                                                            <select onchange="tzpage()" id="sel_page"></select>
                                                        </td>
                                                        <td align="right" style="width: 20%">
                                                            <span id="span_page"></span><span id="span_currentPage">0</span>/<span id="span_totalpage">0</span>&nbsp;&nbsp;
                                                          
                                                            <span id="span_currentact">0~0</span>/<span id="span_total">0</span>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </th>


                                        </tr>
                                        <tr class="gridheadcss" style="font-weight: bold;">

                                            <th style="width: 50%" id="Lang_LogFileName" scope="col">日志文件</th>
                                            <th style="width: 30%" id="" scope="col"><span id="Lang_LogFileSize"></span>(Byte)</th>
                                            <th style="width: 20%" id="Lang_View" scope="col">浏览</th>

                                        </tr>

                                        <tbody id="Tbody1">
                                        </tbody>
                                    </table>

                                </td>
                                <td width="14" background="../../images/tab_16.gif">&nbsp;
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
                                    <img src="../../images/tab_20.png" width="15" height="15" />
                                </td>
                                <td background="../../images/tab_21.gif">
                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td width="25%" nowrap="nowrap">&nbsp;
                                            </td>
                                            <td width="75%" valign="top" class="STYLE1"></td>
                                        </tr>
                                    </table>
                                </td>
                                <td width="14">
                                    <img src="../../images/tab_22.png" width="14" height="15" />
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

    window.document.getElementById("errorLog_Menu").innerHTML = window.parent.parent.GetTextByName("errorLog_Menu", window.parent.parent.useprameters.languagedata);
    window.document.getElementById("Lang_FirstPage").innerHTML = window.parent.parent.GetTextByName("Lang_FirstPage", window.parent.parent.useprameters.languagedata);
    window.document.getElementById("Lang_PrePage").innerHTML = window.parent.parent.GetTextByName("Lang_PrePage", window.parent.parent.useprameters.languagedata);
    window.document.getElementById("Lang_play_next_page").innerHTML = window.parent.parent.GetTextByName("Lang_play_next_page", window.parent.parent.useprameters.languagedata);
    window.document.getElementById("Lang_LastPage").innerHTML = window.parent.parent.GetTextByName("Lang_LastPage", window.parent.parent.useprameters.languagedata);
    window.document.getElementById("Lang_LogFileName").innerHTML = window.parent.parent.GetTextByName("Lang_LogFileName", window.parent.parent.useprameters.languagedata);
    window.document.getElementById("Lang_LogFileSize").innerHTML = window.parent.parent.GetTextByName("Lang_LogFileSize", window.parent.parent.useprameters.languagedata);
    window.document.getElementById("Lang_View").innerHTML = window.parent.parent.GetTextByName("Lang_View", window.parent.parent.useprameters.languagedata);
    


    var dragEnable = 'True';
    function dragdiv() {
        var div1 = window.parent.document.getElementById("LogList/ErrorList");
        window.parent.windowDivOnClick(div1);
        if (div1 && event.button == 0 && dragEnable == 'True') {
            window.parent.mystartDragWindow(div1, null, event); div1.style.border = "solid 0px transparent"; window.parent.cgzindex(div1);

        }
    }
    function mydragWindow() {
        var div1 = window.parent.document.getElementById("LogList/ErrorList");
        if (div1 && event.button == 0 && dragEnable == 'True') {
            window.parent.mydragWindow(div1, event);
        }
    }

    function mystopDragWindow() {
        var div1 = window.parent.document.getElementById("LogList/ErrorList");
        if (div1 && event.button == 0 && dragEnable == 'True') {
            window.parent.mystopDragWindow(div1); div1.style.border = "0px";
        }
    }
    window.onload = function () {
        getData();

        document.body.onclick = function () {
            //alert();
            //var div2 = window.parent.document.getElementById(geturl());
            //window.parent.windowDivOnClick(div2);
        }
        document.body.onmousedown = function () {
            var div2 = window.parent.document.getElementById("LogList/ErrorList");

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

    }
</script>
