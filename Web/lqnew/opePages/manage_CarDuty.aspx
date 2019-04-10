<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="manage_CarDuty.aspx.cs" Inherits="Web.lqnew.opePages.manage_CarDuty" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link href="../css/lq_addedit.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/pagestyle.css" rel="stylesheet" type="text/css" />
    <script src="../../JQuery/jquery-1.5.2.js" type="text/javascript"></script>
    <script src="../js/geturl.js" type="text/javascript"></script>
    <script src="../js/dragwindow.js" type="text/javascript"></script>
    <script src="../js/GlobalConst.js" type="text/javascript"></script>
    <script src="../../JS/LangueSwitch.js" type="text/javascript"></script>
    <script src="../js/geturl.js" type="text/javascript"></script>
    <script src="../js/highcharts.js"></script>
    <script src="../js/MouseMenu.js"></script>
    <link href="../../CSS/ui-lightness/jquery-ui-1.8.13.custom.css" rel="stylesheet"
        type="text/css" />
    <script src="../../JQuery/jquery-ui-1.8.13.custom.min.js" type="text/javascript"></script>
    <%if (System.Configuration.ConfigurationManager.AppSettings["defaultLanguage"] == "zh-CN")
      { %>
    <script src="../../JQuery/ui.datepicker-zh-CN.js" type="text/javascript"></script>
    <%} %>
    <script type="text/javascript">
        var todayNotOver = window.parent.parent.GetTextByName("TodayNotOver", window.parent.parent.useprameters.languagedata);
        var todayIsOver = window.parent.parent.GetTextByName("TodayIsOver", window.parent.parent.useprameters.languagedata);
        var emergency=window.parent.parent.GetTextByName("Emergency", window.parent.parent.useprameters.languagedata);
        function getChat(arrdata) {

            var chart;
            var title = window.parent.parent.GetTextByName("Lang_ZTTJT", window.parent.parent.useprameters.languagedata);
            var x_Data = [window.parent.parent.GetTextByName("Lang_StatueRW", window.parent.parent.useprameters.languagedata)];
            var y_title = window.parent.parent.GetTextByName("Lang_DWT", window.parent.parent.useprameters.languagedata);
            //var colors = ["#4572A7", "#AA4643", "#89A54E", "#80699B", "#3D96AE", "#DB843D", "#92A8CD", "#A47D7C", "#B5CA92"];
            var colors = ["#D3D3D3", "#90EE90", "#0000FF", "#FFA500", "#FFFFE0", "#FF0000", "#92A8CD", "#A47D7C", "#B5CA92"];

            var date_column = [];
            var date_pie = [];
            var totalcounts = 0;
            for (var k = 0; k < countdivlist.length; k++) {
                if (countdivlist[k] != window.parent.parent.GetTextByName("Lang_alltotalcount", window.parent.parent.useprameters.languagedata)) {
                    var counts = 0.5;
                    var counts2 = 0.1;
                    for (var i = 0; i < arrdata.length; i++) {
                        if (countdivlist[k] == arrdata[i].stepName && arrdata[i].count != 0) {
                            counts = arrdata[i].count;
                            counts2 = arrdata[i].count;
                            if (countdivlist[k] != todayNotOver && countdivlist[k] != emergency) {
                                totalcounts += parseFloat(counts);
                            }
                        }
                    }

                    date_column.push({ type: 'column', name: countdivlist[k], data: [parseFloat(counts)], color: colors[k] });
                    if (countdivlist[k] != todayNotOver && countdivlist[k] != emergency) {
                        date_pie.push({ name: countdivlist[k], y: parseFloat(counts2), color: colors[k] });
                    }
                }
            }
            

            date_column.push({ type: 'pie', name: '', data: date_pie, center: [440, 10], size: 100, dataLabels: { enabled: false } });


            chart = new Highcharts.Chart({
                chart: {
                    renderTo: 'chart_combo' //关联页面元素div#id
                },

                title: {  //图表标题
                    text: title
                },

                xAxis: { //x轴
                    categories: x_Data,  //X轴类别
                    labels: { y: 18 }  //x轴标签位置：距X轴下方18像素
                },
                yAxis: {  //y轴
                    title: { text: y_title }, //y轴标题
                    lineWidth: 2 //基线宽度
                },
                tooltip: {
                    formatter: function () { //格式化鼠标滑向图表数据点时显示的提示框
                        var s;
                        if (this.point.name) { // 饼状图
                            if (this.y == 0.1) {
                                s = '<b>' + this.point.name + '</b>: <br>' + 0 + y_title + '(0%)';
                            } else {
                                var pss = (parseFloat(this.y) / totalcounts)*100;
                              
                                s = '<b>' + this.point.name + '</b>: <br>' + this.y + y_title + '(' + twoDecimal(pss) + '%)';
                                //s = '<b>' + this.point.name + '</b>: <br>' + this.y + '台(' + twoDecimal(this.percentage) + '%)';
                            }
                        } else {
                            if (this.y == 0.5) {
                                s = '0' + y_title;
                            } else {
                                s = this.y + y_title;
                            }
                        }
                        return s;
                    }
                },
                labels: { //图表标签
                    items: [{
                        html: '',
                        style: {
                            left: '5px',
                            top: '2px'
                        }
                    }]
                },
                exporting: {
                    enabled: false  //设置导出按钮不可用
                },
                credits: {
                    text: '',
                    href: ''
                },
                series: date_column
            });
        }
        //保留2位小数
        function twoDecimal(x) {
            var f_x = parseFloat(x);
            if (isNaN(f_x)) {
               
                return false;
            }
            var f_x = Math.round(x * 100) / 100;
            var s_x = f_x.toString();
            var pos_decimal = s_x.indexOf('.');
            if (pos_decimal < 0) {
                pos_decimal = s_x.length;
                s_x += '.';
            }
            while (s_x.length <= pos_decimal + 2) {
                s_x += '0';
            }
            return s_x;
        }
        $(document).ready(function () {
            //$("#tab").co
            var date_s = new Date();

            <%if (System.Configuration.ConfigurationManager.AppSettings["defaultLanguage"] == "zh-CN")
              { %>
            $("#begTime").datepicker({ dateFormat: 'yy-mm-dd', changeMonth: true, changeYear: true });

            $("#endTime").datepicker({ dateFormat: 'yy-mm-dd', changeMonth: true, changeYear: true });
            $("#begTime").val(date_s.getFullYear() + "-" + (date_s.getMonth() + 1) + "-" + date_s.getDate());
            $("#endTime").val(date_s.getFullYear() + "-" + (date_s.getMonth() + 1) + "-" + date_s.getDate());
            <%}
              else
              {%>
            $("#begTime").datepicker({ dateFormat: 'mm/dd/yy', changeMonth: true, changeYear: true });

            $("#endTime").datepicker({ dateFormat: 'mm/dd/yy', changeMonth: true, changeYear: true });
            $("#begTime").val(date_s.getFullYear() + "/" + (date_s.getMonth() + 1) + "/" + date_s.getDate());
            $("#endTime").val(date_s.getFullYear() + "/" + (date_s.getMonth() + 1) + "/" + date_s.getDate());
            <%}%>
            getProcedureList();


        });

        function getProcedureList() {
            window.parent.jquerygetNewData_ajax("../../Handlers/StatuesManage/GetProcedureListService.ashx", "", function (msg) {
                if (msg) {
                    var myarray = eval(msg);
                    var selWorkFlow = document.getElementById("sel_WorkFlow");
                    selWorkFlow.length = 0;
                    var optionf = document.createElement("option");
                    optionf.value = "";
                    optionf.id = "Lang_all_searchoption";
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
                    window.document.getElementById("btn_Fresh_Total").style.display = "inline";
                    window.document.getElementById("Lang_Search2").style.display = "inline";


                }
            })
        }

        var SelectUsers = new Array();
        function OnAddMember() {
            //window.parent.mycallfunction('AddPrivateCallMember/add_Member', 635, 514, '0&ifr=PrivateCall_ifr&issi=' + $("#txtISSIText").val().trim(), 2001);
            window.parent.mycallfunction('AddMemberTree/add_Member', 650, 514, '0&ifr=manage_CarDuty_ifr&selectcount=1&type=user&selfclose=1', 2001);
        }
        function faterdo(retrunissis) {
            // window.parent.hiddenbg2();
            if (retrunissis.length > 0) {
                window.document.getElementById("txt_ISSI").value = retrunissis[0].uissi;

            }
        }

        var Lang_loading = window.parent.parent.GetTextByName("Lang_loading", window.parent.parent.useprameters.languagedata);
        var LangNone = window.parent.parent.GetTextByName("Lang-None", window.parent.parent.useprameters.languagedata);
        var Unkown = window.parent.parent.GetTextByName("Unkown", window.parent.parent.useprameters.languagedata);
        var xxxx = window.parent.parent.GetTextByName("Info", window.parent.parent.useprameters.languagedata);
        var arrayISSI = new Array();
        var everypagecount = 5;
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
                topageselect();
                //if (totalPage > 500) {
                //    sel.style.display = "none";
                //    for (var p = sel.length + 1; p <= 500; p++) {
                //        var option = document.createElement("option");
                //        option.value = p;
                //        option.innerHTML = p;
                //        sel.appendChild(option);
                //    }
                //    sel.style.display = "inline";
                //} else {
                //    sel.style.display = "none";
                //    for (var p = sel.length + 1; p <= totalPage; p++) {
                //        var option = document.createElement("option");
                //        option.value = p;
                //        option.innerHTML = p;
                //        sel.appendChild(option);
                //    }
                //    sel.style.display = "inline";
                //}
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
        //类型0代表汇总，1代表详细,2代表详细未上报时,任务ID-1代表未上报,流程ID-1代表未上报
        function openDetail(o_type, id) {
            if (o_type.indexOf("Emergency") >= 0)
            {
                var sql = "";
                if (o_type.indexOf("0") >= 0)//汇总
                {
                    sql += "select d.reserve1 as r1, b.reserve1 as rc1, d.reserve2 as r2, b.reserve2 as rc2, c.name as proname, b.issi as issi, b.name as uname, b.num as num, e.Name as entityname, a.RevISSI as stepName, a.SendTime as begintime";
                    sql += " from SMS_Info a";
                    sql += " left join user_duty b on a.SendISSI=b.issi";
                    sql += " left join _procedure c on b.procedure_id=c.id";
                    sql += " left join procedure_type d on(d.name=c.pType)"
                    sql += " left join Entity e on (b.entityID=e.ID)"
                    sql += " where a.RevISSI='Emergency' and a.SendTime >='" + begtimes + " 00:00:00" + "' and a.SendTime <= '" + endtimes + " 23:59:59" + "' and a.SendISSI=" + id;
                }
                else
                {
                    sql += "select d.reserve1 as r1, b.reserve1 as rc1, d.reserve2 as r2, b.reserve2 as rc2, c.name as proname, b.issi as issi, b.name as uname, b.num as num, e.Name as entityname, a.RevISSI as stepName, a.SendTime as begintime";
                    sql += " from SMS_Info a";
                    sql += " left join user_duty b on a.SendISSI=b.issi";
                    sql += " left join _procedure c on b.procedure_id=c.id";
                    sql += " left join procedure_type d on(d.name=c.pType)"
                    sql += " left join Entity e on (b.entityID=e.ID)"
                    sql += " where a.RevISSI='Emergency' and a.SendTime >='" + begtimes + " 00:00:00" + "' and a.SendTime <= '" + endtimes + " 23:59:59" + "' and a.ID=" + id;
                }
                id = sql;
            }
            window.parent.mycallfunction('view_info/view_CarDuty', 650, 514, id + '&type=' + o_type + '&begtime=' + begtimes + '&endtime=' + endtimes);
        }

        var strProID = "";      //出车流程ID
        function toShowMenu(issi, myuid)
        {
            window.parent.car_duty_issi_selected = issi;
            window.parent.car_duty_uid_selected = myuid;
            MouseMenu_onclick(window.parent, "carDutyMenu");
        }
        function getDataForTodayHZ() {
            document.getElementById("nowStep").style.display = "block";
            document.getElementById("thppp").colSpan = "9";
            var selissiorname = "";
            var selfun = 1;//无用
            var selStatues = "";
            for (var i = 0; i < arrayISSI.length; i++) {
                $("#" + arrayISSI[i]).remove();
            }
            $("#isprocessing").remove();
            $("#Tbody1").append("<tr id='isprocessing' style='background-color:White;height:22px;color:red'><td colspan='9' >" + Lang_loading + "</td></tr>");
            var date_s = new Date();
            begtimes = date_s.getFullYear() + "-" + (date_s.getMonth() + 1) + "-" + date_s.getDate();
            endtimes = date_s.getFullYear() + "-" + (date_s.getMonth() + 1) + "-" + date_s.getDate();
            window.parent.jquerygetNewData_ajax("../../Handlers/StatuesManage/getTodayDutyRecordsService.ashx", { PageIndex: currentPage, Limit: everypagecount, proid: strProID }, function (msg) {
                window.parent.jquerygetNewData_ajax("../../Handlers/StatuesManage/GetPPCSMS.ashx", { begTime: begtimes, endTime: endtimes, need: "Data", proid: strProID, issi: issi, carno: carno }, function (msgEmergency) {
                    $("#isprocessing").remove();
                    var arrMy = new Array();
                    var tempISSI = -1;
                    for (var i = EmergencyInfoShowFrom; i < msgEmergency.data.length; i++) {
                        if (tempISSI == msgEmergency.data[i].SendISSI)
                        { continue; } else {
                            tempISSI = msgEmergency.data[i].SendISSI;
                            arrMy.push(msgEmergency.data[i].SendISSI);
                        }
                    }
                    totalCounts = parseInt(msg.totalcount) + arrMy.length;
                    reroadpagetitle();
                    for (var i = 0; i < arrayISSI.length; i++) {
                        $("#" + arrayISSI[i]).remove();
                    }
                    arrayISSI.length = 0;

                    if (msg.data.length == 0) {
                        $("#Tbody1").append("<tr id='isprocessing' style='background-color:White;height:22px;color:red'><td colspan='9' >" + LangNone + "</td></tr>");
                    }

                    for (var i = 0; i < msg.data.length; i++) {
                        var chuc = "<span color='red'>" + window.parent.parent.GetTextByName("Lang_UnUP", window.parent.parent.useprameters.languagedata) + "</span>";
                        // var v_begtime = msg.data[i].beginTime;
                        if (msg.data[i].nowstepName != "") {
                            chuc = msg.data[i].nowstepName;
                        } else {
                            //  v_begtime = "";
                        }
                        var s_detal = "";
                        if (msg.data[i].d_id != "") {
                            s_detal = "<span style=\"cursor:pointer;text-decoration:underline;\" onclick=\"openDetail('0','" + msg.data[i].d_id + "')\">" + xxxx + "</span>";
                        }
                        $("#Tbody1").append("<tr id=" + i + " onmouseover='changeTgBg(this,&#39;font&#39;)' onmouseout='overchangeTgBg(this,&#39;font&#39;)' style='background-color:White;height:22px;'><td align='center'>" + msg.data[i].reserve1 + "</td><td  align='center'>" + msg.data[i].num + "</td><td style='' align='center'>" + msg.data[i].issi + "</td><td style='' align='center'>" + msg.data[i].reserve2 + "</td><td style='' align='center' >" + chuc + "</td><td style='' align='center' >" + msg.data[i].ctime + "</td><td style='' align='center' >" + msg.data[i].cnt + "</td><td style='' align='center' >" + s_detal + "</td><td align='center'><img onclick='toShowMenu(" + msg.data[i].issi + "," + msg.data[i].myuid + ")' src='../img/treebutton2.gif'/></td></tr>");
                        arrayISSI.push(i);
                    }
                    if (msg.data.length >= everypagecount) 
                    { return;}
                    var msgCount = msg.data.length;
                    if (msgEmergency.data.length == 0)
                    { return; }
                    if (msg.data.length == 0)
                    { $("#isprocessing").remove(); }
                    var tempISSI = -1;
                    var nowNum = 0;
                    getEmergencyShowFromNum(msg.data.length, msgEmergency, true);
                  
                    for (var i = EmergencyInfoShowFrom; i < msgEmergency.data.length; i++) {
                        if (tempISSI == msgEmergency.data[i].SendISSI)
                        { continue; } else {
                            if (msgCount + nowNum >= everypagecount)
                            {
                                EmergencyInfoShowFrom = i;
                                return;
                            }
                            tempISSI = msgEmergency.data[i].SendISSI;
                        }
                        var count = 0;
                        for (var m = 0; m < msgEmergency.data.length; m++) {
                            if (msgEmergency.data[m].SendISSI == tempISSI) {
                                count++;
                            }
                        }
                        var chuc = emergency;
                        var s_detal = "";
                        if (msgEmergency.data[i].SendISSI != "") {
                            s_detal = "<span style=\"cursor:pointer;text-decoration:underline;\" onclick=\"openDetail('Emergency0','" + msgEmergency.data[i].SendISSI + "')\">" + xxxx + "</span>";
                        }
                        $("#Tbody1").append("<tr id=" + (nowNum + msg.data.length) + " onmouseover='changeTgBg(this,&#39;font&#39;)' onmouseout='overchangeTgBg(this,&#39;font&#39;)' style='background-color:White;height:22px;'><td align='center'>" + msgEmergency.data[i].reserve1 + "</td><td  align='center'>" + msgEmergency.data[i].num + "</td><td style='' align='center'>" + msgEmergency.data[i].issi + "</td><td style='' align='center'>" + msgEmergency.data[i].reserve2 + "</td><td style='' align='center' >" + chuc + "</td><td style='' align='center' >" + msgEmergency.data[i].SendTime + "</td><td style='' align='center' >" + count + "</td><td style='' align='center' >" + s_detal + "</td><td align='center'><img onclick='toShowMenu(" + msgEmergency.data[i].issi + "," + msgEmergency.data[i].user_id + ")' src='../img/treebutton2.gif'/></td></tr>");
                        arrayISSI.push(nowNum + msg.data.length);
                        nowNum++;
                    }
                });
            });
        }
        var EmergencyInfoShowFrom = 0;
        function getDataForSearchHZ() {
            document.getElementById("nowStep").style.display = "block";
            document.getElementById("thppp").colSpan = "9";
            var selissiorname = "";
            var selfun = 1;//无用
            var selStatues = "";
            for (var i = 0; i < arrayISSI.length; i++) {
                $("#" + arrayISSI[i]).remove();
            }
            $("#isprocessing").remove();
            $("#Tbody1").append("<tr id='isprocessing' style='background-color:White;height:22px;color:red'><td colspan='9' >" + Lang_loading + "</td></tr>");
            if (statues == emergency)
            {
                EmergencyInfoShowFrom = 0;
                window.parent.jquerygetNewData_ajax("../../Handlers/StatuesManage/GetPPCSMS.ashx", { begTime: begtimes, endTime: endtimes, need: "Data", proid: strProID, issi: issi, carno: carno }, function (msgEmergency) {
                    $("#isprocessing").remove();
                    var arrMy = new Array();
                    var tempISSI = -1;
                    for (var i = EmergencyInfoShowFrom; i < msgEmergency.data.length; i++) {
                        if (tempISSI == msgEmergency.data[i].SendISSI)
                        { continue; } else {
                            tempISSI = msgEmergency.data[i].SendISSI;
                            arrMy.push(msgEmergency.data[i].SendISSI);
                        }
                    }
                    totalCounts = arrMy.length;
                    reroadpagetitle();

                    getEmergencyShowFromNum(0, msgEmergency, true);

                   
                    for (var i = 0; i < arrayISSI.length; i++) {
                        $("#" + arrayISSI[i]).remove();
                    }
                    arrayISSI.length = 0;

                    if (msgEmergency.data.length == 0) {
                        $("#Tbody1").append("<tr id='isprocessing' style='background-color:White;height:22px;color:red'><td colspan='9' >" + LangNone + "</td></tr>");
                    }
                    tempISSI = -1;
                    var nowNum = 0;
                    for (var i = EmergencyInfoShowFrom; i < msgEmergency.data.length; i++) {
                        if (tempISSI == msgEmergency.data[i].SendISSI)
                        { continue; } else {
                            if (nowNum >= everypagecount)
                            {
                                EmergencyInfoShowFrom = i;
                                break;
                            }
                            nowNum++;
                            tempISSI = msgEmergency.data[i].SendISSI;
                        }
                        var count = 0;
                        for (var m = 0; m < msgEmergency.data.length; m++)
                        {
                            if (msgEmergency.data[m].SendISSI == tempISSI)
                            {
                                count++;
                            }
                        }
                        var chuc = emergency;
                        var s_detal = "";
                        if (msgEmergency.data[i].SendISSI != "") {
                            s_detal = "<span style=\"cursor:pointer;text-decoration:underline;\" onclick=\"openDetail('Emergency0','" + msgEmergency.data[i].SendISSI + "')\">" + xxxx + "</span>";
                        }
                        $("#Tbody1").append("<tr id=" + i + " onmouseover='changeTgBg(this,&#39;font&#39;)' onmouseout='overchangeTgBg(this,&#39;font&#39;)' style='background-color:White;height:22px;'><td align='center'>" + msgEmergency.data[i].reserve1 + "</td><td  align='center'>" + msgEmergency.data[i].num + "</td><td style='' align='center'>" + msgEmergency.data[i].issi + "</td><td style='' align='center'>" + msgEmergency.data[i].reserve2 + "</td><td style='' align='center' >" + chuc + "</td><td style='' align='center' >" + msgEmergency.data[i].SendTime + "</td><td style='' align='center' >" + count + "</td><td style='' align='center' >" + s_detal + "</td><td align='center'><img onclick='toShowMenu(" + msgEmergency.data[i].issi + "," + msgEmergency.data[i].user_id + ")' src='../img/treebutton2.gif'/></td></tr>");
                        arrayISSI.push(i);
                    }
                });
            } else if (statues == "")   //全选
            {
                window.parent.jquerygetNewData_ajax("../../Handlers/StatuesManage/getSearchDutyRecordsForDetailService.ashx", { type: "0", PageIndex: currentPage, Limit: everypagecount, proid: strProID, issi: issi, carno: carno, statues: statues, begtimes: begtimes, endtimes: endtimes, isCK: isck }, function (msg) {
                    window.parent.jquerygetNewData_ajax("../../Handlers/StatuesManage/GetPPCSMS.ashx", { begTime: begtimes, endTime: endtimes, need: "Data", proid: strProID, issi: issi, carno: carno }, function (msgEmergency) {
                        $("#isprocessing").remove();
                        var arrMy = new Array();
                        var tempISSI = -1;
                        for (var i = EmergencyInfoShowFrom; i < msgEmergency.data.length; i++) {
                            if (tempISSI == msgEmergency.data[i].SendISSI)
                            { continue; } else {
                                tempISSI = msgEmergency.data[i].SendISSI;
                                arrMy.push(msgEmergency.data[i].SendISSI);
                            }
                        }
                        totalCounts = parseInt(msg.totalcount) + arrMy.length;
                        reroadpagetitle();
                        for (var i = 0; i < arrayISSI.length; i++) {
                            $("#" + arrayISSI[i]).remove();
                        }
                        arrayISSI.length = 0;

                        if (msg.data.length == 0) {
                            $("#Tbody1").append("<tr id='isprocessing' style='background-color:White;height:22px;color:red'><td colspan='9' >" + LangNone + "</td></tr>");
                        }

                        for (var i = 0; i < msg.data.length; i++) {
                            var chuc = "<span color='red'>" + window.parent.parent.GetTextByName("Lang_UnUP", window.parent.parent.useprameters.languagedata) + "</span>";
                            //var v_begtime = msg.data[i].beginTime;
                            if (msg.data[i].nowstepName != "") {
                                chuc = msg.data[i].nowstepName;
                            } else {
                                //    v_begtime = "";
                            }
                            var s_detal = "";
                            if (msg.data[i].d_id != "") {
                                s_detal = "<span style=\"cursor:pointer;text-decoration:underline;\" onclick=\"openDetail('0','" + msg.data[i].d_id + "')\">" + xxxx + "</span>";
                            }
                            $("#Tbody1").append("<tr id=" + i + " onmouseover='changeTgBg(this,&#39;font&#39;)' onmouseout='overchangeTgBg(this,&#39;font&#39;)' style='background-color:White;height:22px;'><td align='center'>" + msg.data[i].reserve1 + "</td><td  align='center'>" + msg.data[i].num + "</td><td style='' align='center'>" + msg.data[i].issi + "</td><td style='' align='center'>" + msg.data[i].reserve2 + "</td><td style='' align='center' >" + chuc + "</td><td style='' align='center' >" + msg.data[i].ctime + "</td><td style='' align='center' >" + msg.data[i].cnt + "</td><td style='' align='center' >" + s_detal + "</td><td align='center'><img onclick='toShowMenu(" + msg.data[i].issi + "," + msg.data[i].myuid + ")' src='../img/treebutton2.gif'/></td></tr>");
                            arrayISSI.push(i);
                        }

                        if (msgEmergency.data.length == 0)
                        { return; }
                        if (msg.data.length == 0)
                        { $("#isprocessing").remove(); }
                        var tempISSI = -1;
                        var msgCount = msg.data.length;
                        var nowNum = 0;

                        getEmergencyShowFromNum(msgCount, msgEmergency, true);
                        for (var i = EmergencyInfoShowFrom; i < msgEmergency.data.length; i++) {
                            if (tempISSI == msgEmergency.data[i].SendISSI)
                            { continue; } else {
                                if (msgCount + nowNum >= everypagecount) {
                                    EmergencyInfoShowFrom = i;
                                    return;
                                }
                                tempISSI = msgEmergency.data[i].SendISSI;
                            }
                            var count = 0;
                            for (var m = 0; m < msgEmergency.data.length; m++) {
                                if (msgEmergency.data[m].SendISSI == tempISSI) {
                                    count++;
                                }
                            }
                          //  var v_begtime = msg.data[i].SendTime;
                            var chuc = emergency;
                            var s_detal = "";
                            if (msgEmergency.data[i].SendISSI != "") {
                                s_detal = "<span style=\"cursor:pointer;text-decoration:underline;\" onclick=\"openDetail('Emergency0','" + msgEmergency.data[i].SendISSI + "')\">" + xxxx + "</span>";
                            }
                            $("#Tbody1").append("<tr id=" + (msgCount + nowNum) + " onmouseover='changeTgBg(this,&#39;font&#39;)' onmouseout='overchangeTgBg(this,&#39;font&#39;)' style='background-color:White;height:22px;'><td align='center'>" + msgEmergency.data[i].reserve1 + "</td><td  align='center'>" + msgEmergency.data[i].num + "</td><td style='' align='center'>" + msgEmergency.data[i].issi + "</td><td style='' align='center'>" + msgEmergency.data[i].reserve2 + "</td><td style='' align='center' >" + chuc + "</td><td style='' align='center' >" + msgEmergency.data[i].SendTime + "</td><td style='' align='center' >" + count + "</td><td style='' align='center' >" + s_detal + "</td><td align='center'><img onclick='toShowMenu(" + msgEmergency.data[i].issi + "," + msgEmergency.data[i].user_id + ")' src='../img/treebutton2.gif'/></td></tr>");
                            arrayISSI.push(msgCount + nowNum);
                            nowNum++;
                        }
                    });
                });
            }
            else
            {
                window.parent.jquerygetNewData_ajax("../../Handlers/StatuesManage/getSearchDutyRecordsForDetailService.ashx", { type: "0", PageIndex: currentPage, Limit: everypagecount, proid: strProID, issi: issi, carno: carno, statues: statues, begtimes: begtimes, endtimes: endtimes, isCK: isck }, function (msg) {
                    $("#isprocessing").remove();
                    totalCounts = msg.totalcount;
                    reroadpagetitle();
                    for (var i = 0; i < arrayISSI.length; i++) {
                        $("#" + arrayISSI[i]).remove();
                    }
                    arrayISSI.length = 0;

                    if (msg.data.length == 0) {
                        $("#Tbody1").append("<tr id='isprocessing' style='background-color:White;height:22px;color:red'><td colspan='9' >" + LangNone + "</td></tr>");
                    }

                    for (var i = 0; i < msg.data.length; i++) {
                        var chuc = "<span color='red'>" + window.parent.parent.GetTextByName("Lang_UnUP", window.parent.parent.useprameters.languagedata) + "</span>";
                       // var v_begtime = msg.data[i].beginTime;
                        if (msg.data[i].nowstepName != "") {
                            chuc = msg.data[i].nowstepName;
                        } else {
                       //     v_begtime = "";
                        }
                        var s_detal = "";
                        if (msg.data[i].d_id != "") {
                            s_detal = "<span style=\"cursor:pointer;text-decoration:underline;\" onclick=\"openDetail('0','" + msg.data[i].d_id + "')\">" + xxxx + "</span>";
                        }
                        $("#Tbody1").append("<tr id=" + i + " onmouseover='changeTgBg(this,&#39;font&#39;)' onmouseout='overchangeTgBg(this,&#39;font&#39;)' style='background-color:White;height:22px;'><td align='center'>" + msg.data[i].reserve1 + "</td><td  align='center'>" + msg.data[i].num + "</td><td style='' align='center'>" + msg.data[i].issi + "</td><td style='' align='center'>" + msg.data[i].reserve2 + "</td><td style='' align='center' >" + chuc + "</td><td style='' align='center' >" + msg.data[i].ctime + "</td><td style='' align='center' >" + msg.data[i].cnt + "</td><td style='' align='center' >" + s_detal + "</td><td align='center'><img onclick='toShowMenu(" + msg.data[i].issi + "," + msg.data[i].myuid + ")' src='../img/treebutton2.gif'/></td></tr>");
                        arrayISSI.push(i);
                    }
                });
            }
        }

        function getEmergencyShowFromNum(produceDataLength, msgEmergency, isHZ)
        {
            if (produceDataLength > 0)
            { EmergencyInfoShowFrom = 0; }
            else
            {
                var tempISSI = -1;
                var effectNum = 0;
                for (var i = EmergencyInfoShowFrom; i < msgEmergency.data.length; i++) {
                    if (tempISSI == msgEmergency.data[i].SendISSI)
                    { continue; } else {
                        tempISSI = msgEmergency.data[i].SendISSI;
                        effectNum++;
                    }
                }
                if (totalCounts - effectNum == (currentPage - 1) * everypagecount)
                { EmergencyInfoShowFrom = 0; }
                else {
                    if (isHZ) {
                        var num = (currentPage - 1) * everypagecount - (totalCounts - effectNum);
                        for (var i = 0; i < msgEmergency.data.length; i++) {
                            if (tempISSI == msgEmergency.data[i].SendISSI)
                            { continue; } else { nowNum++; }
                            if (nowNum >= num)
                            { EmergencyInfoShowFrom = i; break; }
                        }
                    } else {
                        EmergencyInfoShowFrom = (currentPage - 1) * everypagecount - (totalCounts - msgEmergency.data.length);
                    }
                }
            }
        }


        function getDataForTodayXX() {

            var selissiorname = "";
            var selfun = 1;//无用
            var selStatues = "";
            for (var i = 0; i < arrayISSI.length; i++) {
                $("#" + arrayISSI[i]).remove();
            }
            $("#isprocessing").remove();
            $("#Tbody1").append("<tr id='isprocessing' style='background-color:White;height:22px;color:red'><td colspan='9' >" + Lang_loading + "</td></tr>");
            var date_s = new Date();
            begtimes = date_s.getFullYear() + "-" + (date_s.getMonth() + 1) + "-" + date_s.getDate();
            endtimes = date_s.getFullYear() + "-" + (date_s.getMonth() + 1) + "-" + date_s.getDate();
            window.parent.jquerygetNewData_ajax("../../Handlers/StatuesManage/getTodayDutyRecordsDetailService.ashx", { PageIndex: currentPage, Limit: everypagecount, proid: strProID }, function (msg) {
                window.parent.jquerygetNewData_ajax("../../Handlers/StatuesManage/GetPPCSMS.ashx", { begTime: begtimes, endTime: endtimes, need: "Data", proid: strProID, issi: issi, carno: carno }, function (msgEmergency) {
                    $("#isprocessing").remove();
                    document.getElementById("nowStep").style.display = "none";
                    document.getElementById("thppp").colSpan = "8";
                    totalCounts = msg.totalcount + msgEmergency.data.length;
                    reroadpagetitle();
                    for (var i = 0; i < arrayISSI.length; i++) {
                        $("#" + arrayISSI[i]).remove();
                    }
                    arrayISSI.length = 0;
                    if (msg.data.length == 0) {
                        $("#Tbody1").append("<tr id='isprocessing' style='background-color:White;height:22px;color:red'><td colspan='9' >" + LangNone + "</td></tr>");
                    }

                    for (var i = 0; i < msg.data.length; i++) {
                        var chuc = "<span color='red'>" + window.parent.parent.GetTextByName("Lang_UnUP", window.parent.parent.useprameters.languagedata) + "</span>";
                        var s_detal = "";
                        if (msg.data[i].stepName != "") {
                            chuc = msg.data[i].stepName;
                            if (msg.data[i].s_id != "") {
                                s_detal = "<span style=\"cursor:pointer;text-decoration:underline;\" onclick=\"openDetail('1','" + msg.data[i].s_id + "')\">" + xxxx + "</span>";//还需要把时间传过去
                            }
                        } else {
                            if (msg.data[i].d_id != "") {
                                s_detal = "<span style=\"cursor:pointer;text-decoration:underline;\" onclick=\"openDetail('2','" + msg.data[i].d_id + "')\">" + xxxx + "</span>";
                            }
                        }


                        $("#Tbody1").append("<tr id=" + i + " onmouseover='changeTgBg(this,&#39;font&#39;)' onmouseout='overchangeTgBg(this,&#39;font&#39;)' style='background-color:White;height:22px;'><td align='center'>" + msg.data[i].reserve1 + "</td><td  align='center'>" + msg.data[i].num + "</td><td style='' align='center'>" + msg.data[i].issi + "</td><td style='' align='center'>" + msg.data[i].reserve2 + "</td><td style='' align='center' >" + chuc + "</td><td style='' align='center' >" + msg.data[i].changeTime + "</td><td style='display:none' align='center' ></td><td style='' align='center' >" + s_detal + "</td><td align='center'><img onclick='toShowMenu(" + msg.data[i].issi + "," + msg.data[i].myuid + ")' src='../img/treebutton2.gif'/></td></tr>");
                        arrayISSI.push(i);
                    }
                    if (msgEmergency.data.length == 0)
                    { return; }
                    if (msg.data.length == 0)
                    { $("#isprocessing").remove(); }
                    var msgCount = msg.data.length;
                    var nowNum = 0;
                    getEmergencyShowFromNum(msgCount, msgEmergency, false);
                    for (var i = EmergencyInfoShowFrom; i < msgEmergency.data.length; i++) {
                        if (msgCount + nowNum >= everypagecount) {
                            EmergencyInfoShowFrom = i;
                            return;
                        }
                        var chuc = emergency;
                        var s_detal = "";
                        if (msgEmergency.data[i].SendISSI != "") {
                            s_detal = "<span style=\"cursor:pointer;text-decoration:underline;\" onclick=\"openDetail('Emergency1','" + msgEmergency.data[i].ID + "')\">" + xxxx + "</span>";
                        }
                        $("#Tbody1").append("<tr id=" + (nowNum + msgCount) + " onmouseover='changeTgBg(this,&#39;font&#39;)' onmouseout='overchangeTgBg(this,&#39;font&#39;)' style='background-color:White;height:22px;'><td align='center'>" + msgEmergency.data[i].reserve1 + "</td><td  align='center'>" + msgEmergency.data[i].num + "</td><td style='' align='center'>" + msgEmergency.data[i].issi + "</td><td style='' align='center'>" + msgEmergency.data[i].reserve2 + "</td><td style='' align='center' >" + chuc + "</td><td style='' align='center' >" + msgEmergency.data[i].SendTime + "</td><td style='' align='center' >" + count + "</td><td style='' align='center' >" + s_detal + "</td><td align='center'><img onclick='toShowMenu(" + msgEmergency.data[i].issi + "," + msgEmergency.data[i].user_id + ")' src='../img/treebutton2.gif'/></td></tr>");
                        arrayISSI.push(nowNum + msgCount);
                        nowNum++;
                    }
                });

            });
        }
        function getDataForSearchXX() {
            document.getElementById("nowStep").style.display = "none";
            document.getElementById("thppp").colSpan = "8";;
            var selissiorname = "";
            var selfun = 1;//无用
            var selStatues = "";
            for (var i = 0; i < arrayISSI.length; i++) {
                $("#" + arrayISSI[i]).remove();
            }
            $("#isprocessing").remove();
            $("#Tbody1").append("<tr id='isprocessing' style='background-color:White;height:22px;color:red'><td colspan='9' >" + Lang_loading + "</td></tr>");
            if (statues == emergency) {
                window.parent.jquerygetNewData_ajax("../../Handlers/StatuesManage/GetPPCSMS.ashx", { begTime: begtimes, endTime: endtimes, need: "Data", proid: strProID, issi: issi, carno: carno }, function (msgEmergency) {
                    $("#isprocessing").remove();
                    totalCounts = msgEmergency.totalcount;
                    reroadpagetitle();
                    for (var i = 0; i < arrayISSI.length; i++) {
                        $("#" + arrayISSI[i]).remove();
                    }
                    arrayISSI.length = 0;

                    if (msgEmergency.data.length == 0) {
                        $("#Tbody1").append("<tr id='isprocessing' style='background-color:White;height:22px;color:red'><td colspan='9' >" + LangNone + "</td></tr>");
                    }
                    var nowNum = 0;
                    getEmergencyShowFromNum(0, msgEmergency, false);
                    for (var i = EmergencyInfoShowFrom; i < msgEmergency.data.length; i++) {
                        if (nowNum >= everypagecount) {
                            EmergencyInfoShowFrom = i;
                            break;
                        }
                        nowNum++;
                   //     var v_begtime = msg.data[i].SendTime;
                        var chuc = emergency;
                        var s_detal = "";
                        if (msgEmergency.data[i].SendISSI != "") {
                            s_detal = "<span style=\"cursor:pointer;text-decoration:underline;\" onclick=\"openDetail('Emergency1','" + msgEmergency.data[i].ID + "')\">" + xxxx + "</span>";
                        }
                        $("#Tbody1").append("<tr id=" + i + " onmouseover='changeTgBg(this,&#39;font&#39;)' onmouseout='overchangeTgBg(this,&#39;font&#39;)' style='background-color:White;height:22px;'><td align='center'>" + msgEmergency.data[i].reserve1 + "</td><td  align='center'>" + msgEmergency.data[i].num + "</td><td style='' align='center'>" + msgEmergency.data[i].issi + "</td><td style='' align='center'>" + msgEmergency.data[i].reserve2 + "</td><td style='' align='center' >" + chuc + "</td><td style='' align='center' >" + msgEmergency.data[i].SendTime + "</td><td style='display:none' align='center' ></td><td style='' align='center' >" + s_detal + "</td><td align='center'><img onclick='toShowMenu(" + msgEmergency.data[i].issi + "," + msgEmergency.data[i].user_id + ")' src='../img/treebutton2.gif'/></td></tr>");
                        arrayISSI.push(i);
                    }
                });
            } else if (statues == "")   //全选
            {
                window.parent.jquerygetNewData_ajax("../../Handlers/StatuesManage/getSearchDutyRecordsForDetailService.ashx", { type: "1", PageIndex: currentPage, Limit: everypagecount, proid: strProID, issi: issi, carno: carno, statues: statues, begtimes: begtimes, endtimes: endtimes, isCK: isck }, function (msg) {
                    window.parent.jquerygetNewData_ajax("../../Handlers/StatuesManage/GetPPCSMS.ashx", { begTime: begtimes, endTime: endtimes, need: "Data", proid: strProID, issi: issi, carno: carno }, function (msgEmergency) {
                        $("#isprocessing").remove();
                        document.getElementById("nowStep").style.display = "none";
                        document.getElementById("thppp").colSpan = "8";

                        totalCounts = parseInt(msg.totalcount) + parseInt(msgEmergency.totalcount);
                        reroadpagetitle();
                        for (var i = 0; i < arrayISSI.length; i++) {
                            $("#" + arrayISSI[i]).remove();
                        }
                        arrayISSI.length = 0;

                        if (msg.data.length == 0) {
                            $("#Tbody1").append("<tr id='isprocessing' style='background-color:White;height:22px;color:red'><td colspan='9' >" + LangNone + "</td></tr>");
                        }

                        for (var i = 0; i < msg.data.length; i++) {
                            var chuc = "<span color='red'>" + window.parent.parent.GetTextByName("Lang_UnUP", window.parent.parent.useprameters.languagedata) + "</span>";
                            var s_detal = "";
                            if (msg.data[i].stepName != "") {
                                chuc = msg.data[i].stepName;
                                if (msg.data[i].s_id != "") {
                                    s_detal = "<span style=\"cursor:pointer;text-decoration:underline;\" onclick=\"openDetail('1','" + msg.data[i].s_id + "')\">" + xxxx + "</span>";
                                }
                            } else {
                                if (msg.data[i].d_id != "") {
                                    s_detal = "<span style=\"cursor:pointer;text-decoration:underline;\" onclick=\"openDetail('2','" + msg.data[i].d_id + "')\">" + xxxx + "</span>";
                                }
                            }
                            $("#Tbody1").append("<tr id=" + i + " onmouseover='changeTgBg(this,&#39;font&#39;)' onmouseout='overchangeTgBg(this,&#39;font&#39;)' style='background-color:White;height:22px;'><td align='center'>" + msg.data[i].reserve1 + "</td><td  align='center'>" + msg.data[i].num + "</td><td style='' align='center'>" + msg.data[i].issi + "</td><td style='' align='center'>" + msg.data[i].reserve2 + "</td><td style='' align='center' >" + chuc + "</td><td style='' align='center' >" + msg.data[i].changeTime + "</td><td style='display:none' align='center' ></td><td style='' align='center' >" + s_detal + "</td><td align='center'><img onclick='toShowMenu(" + msg.data[i].issi + "," + msg.data[i].myuid + ")' src='../img/treebutton2.gif'/></td></tr>");
                            arrayISSI.push(i);
                        }

                        var msgCount = msg.data.length;
                        if (msgEmergency.data.length == 0)
                        { return; }
                        if (msg.data.length == 0)
                        { $("#isprocessing").remove(); }
                        var nowNum = 0;
                        getEmergencyShowFromNum(msgCount, msgEmergency, false);
                        //if (msg.data.length <= everypagecount && msg.data.length > 0) 
                        //{ EmergencyInfoShowFrom = 0;}
                        for (var i = EmergencyInfoShowFrom; i < msgEmergency.data.length; i++) {
                            if (msgCount + nowNum >= everypagecount) {
                                EmergencyInfoShowFrom = i;
                                return;
                            }
                            var chuc = emergency;
                            var s_detal = "";
                            if (msgEmergency.data[i].SendISSI != "") {
                                s_detal = "<span style=\"cursor:pointer;text-decoration:underline;\" onclick=\"openDetail('Emergency1','" + msgEmergency.data[i].ID + "')\">" + xxxx + "</span>";
                            }
                            $("#Tbody1").append("<tr id=" + (nowNum + msgCount) + " onmouseover='changeTgBg(this,&#39;font&#39;)' onmouseout='overchangeTgBg(this,&#39;font&#39;)' style='background-color:White;height:22px;'><td align='center'>" + msgEmergency.data[i].reserve1 + "</td><td  align='center'>" + msgEmergency.data[i].num + "</td><td style='' align='center'>" + msgEmergency.data[i].issi + "</td><td style='' align='center'>" + msgEmergency.data[i].reserve2 + "</td><td style='' align='center' >" + chuc + "</td><td style='' align='center' >" + msgEmergency.data[i].SendTime + "</td><td style='display:none' align='center' ></td><td style='' align='center' >" + s_detal + "</td><td align='center'><img onclick='toShowMenu(" + msgEmergency.data[i].issi + "," + msgEmergency.data[i].user_id + ")' src='../img/treebutton2.gif'/></td></tr>");
                            arrayISSI.push(nowNum + msgCount);
                            nowNum++;
                        }
                    });
                });
            }
            else {
                window.parent.jquerygetNewData_ajax("../../Handlers/StatuesManage/getSearchDutyRecordsForDetailService.ashx", { type: "1", PageIndex: currentPage, Limit: everypagecount, proid: strProID, issi: issi, carno: carno, statues: statues, begtimes: begtimes, endtimes: endtimes, isCK: isck }, function (msg) {
                    $("#isprocessing").remove();

                    document.getElementById("nowStep").style.display = "none";
                    document.getElementById("thppp").colSpan = "8";;
                    totalCounts = msg.totalcount;
                    reroadpagetitle();
                    for (var i = 0; i < arrayISSI.length; i++) {
                        $("#" + arrayISSI[i]).remove();
                    }
                    arrayISSI.length = 0;

                    if (msg.data.length == 0) {
                        $("#Tbody1").append("<tr id='isprocessing' style='background-color:White;height:22px;color:red'><td colspan='9' >" + LangNone + "</td></tr>");
                    }

                    for (var i = 0; i < msg.data.length; i++) {
                        var chuc = "<span color='red'>" + window.parent.parent.GetTextByName("Lang_UnUP", window.parent.parent.useprameters.languagedata) + "</span>";
                        var s_detal = "";
                        if (msg.data[i].stepName != "") {
                            chuc = msg.data[i].stepName;
                            if (msg.data[i].s_id != "") {
                                s_detal = "<span style=\"cursor:pointer;text-decoration:underline;\" onclick=\"openDetail('1','" + msg.data[i].s_id + "')\">" + xxxx + "</span>";
                            }
                        } else {
                            if (msg.data[i].d_id != "") {
                                s_detal = "<span style=\"cursor:pointer;text-decoration:underline;\" onclick=\"openDetail('2','" + msg.data[i].d_id + "')\">" + xxxx + "</span>";
                            }
                        }
                        $("#Tbody1").append("<tr id=" + i + " onmouseover='changeTgBg(this,&#39;font&#39;)' onmouseout='overchangeTgBg(this,&#39;font&#39;)' style='background-color:White;height:22px;'><td align='center'>" + msg.data[i].reserve1 + "</td><td  align='center'>" + msg.data[i].num + "</td><td style='' align='center'>" + msg.data[i].issi + "</td><td style='' align='center'>" + msg.data[i].reserve2 + "</td><td style='' align='center' >" + chuc + "</td><td style='' align='center' >" + msg.data[i].changeTime + "</td><td style='display:none' align='center' ></td><td style='' align='center' >" + s_detal + "</td><td align='center'><img onclick='toShowMenu(" + msg.data[i].issi + "," + msg.data[i].myuid + ")' src='../img/treebutton2.gif'/></td></tr>");
                        arrayISSI.push(i);
                    }
                });
            }
        }
        var checkradhz = false;
        var checkrad2hz = false;
        var var_Lang_DoTime = window.parent.parent.GetTextByName("Lang_DoTime", window.parent.parent.useprameters.languagedata);
        var var_Lang_DoDutyCount = window.parent.parent.GetTextByName("Lang_DoDutyCount", window.parent.parent.useprameters.languagedata);
        var var_Lang_TodayRecordSelectSheet = window.parent.parent.GetTextByName("Lang_TodayRecordSelectSheet", window.parent.parent.useprameters.languagedata);
        var var_Lang_HistoryRecordSelectSheet = window.parent.parent.GetTextByName("Lang_HistoryRecordSelectSheet", window.parent.parent.useprameters.languagedata);
        var var_Lang_HZRW = window.parent.parent.GetTextByName("Lang_HZRW", window.parent.parent.useprameters.languagedata);
        var var_Lang_XXRW = window.parent.parent.GetTextByName("Lang_XXRW", window.parent.parent.useprameters.languagedata);

        function getData() {
            if (isck) {
                getDataForSearchHZ();

            } else {
                if (operType == 0) {
                    if (checkradhz) {
                        getDataForTodayHZ();//查询
                        document.getElementById("doTime").innerHTML = "<span>" + var_Lang_DoTime + "</span>";
                        document.getElementById("doStep").innerHTML = var_Lang_DoDutyCount;
                        document.getElementById("span_ListTitle").innerHTML = var_Lang_TodayRecordSelectSheet;

                        //document.getElementById("span_ListTitle").innerHTML = window.parent.parent.GetTextByName("Lang_Today_Record", window.parent.parent.useprameters.languagedata) + window.parent.parent.GetTextByName("Lang_huizhongbiao", window.parent.parent.useprameters.languagedata);
                    } else {
                        getDataForTodayXX();
                        document.getElementById("doStep").innerHTML = window.parent.parent.GetTextByName("Lang_DoTime", window.parent.parent.useprameters.languagedata);
                        document.getElementById("doTime").innerHTML = window.parent.parent.GetTextByName("Lang_DoSetup", window.parent.parent.useprameters.languagedata);
                        document.getElementById("span_ListTitle").innerHTML = var_Lang_TodayRecordSelectSheet;
                        //document.getElementById("span_ListTitle").innerHTML = window.parent.parent.GetTextByName("Lang_Today_Record", window.parent.parent.useprameters.languagedata) + window.parent.parent.GetTextByName("Lang_xiangxibiao", window.parent.parent.useprameters.languagedata);
                    }

                } else
                    if (operType == 1) {//历史查询
                        var strstatues = statues;
                        if (statues == "") {
                            strstatues = window.parent.parent.GetTextByName("Lang_Log_All", window.parent.parent.useprameters.languagedata);
                        } else if (statues.toString() == "-1") {
                            strstatues = window.parent.parent.GetTextByName("Lang_UnUP", window.parent.parent.useprameters.languagedata);
                        }
                        if (checkrad2hz) {
                            getDataForSearchHZ();
                            document.getElementById("doTime").innerHTML = var_Lang_DoTime
                            document.getElementById("doStep").innerHTML = var_Lang_DoDutyCount;
                            //document.getElementById("span_ListTitle").innerHTML = window.parent.parent.GetTextByName("Lang_Search_History", window.parent.parent.useprameters.languagedata) + window.parent.parent.GetTextByName("Lang_huizhongbiao", window.parent.parent.useprameters.languagedata);

                            document.getElementById("span_ListTitle").innerHTML = var_Lang_HistoryRecordSelectSheet + "——" + var_Lang_HZRW + "、" + strstatues + "、" + begtimes + "~" + endtimes;
                        } else {
                            getDataForSearchXX();
                            document.getElementById("doStep").innerHTML = window.parent.parent.GetTextByName("Lang_DoTime", window.parent.parent.useprameters.languagedata);
                            document.getElementById("doTime").innerHTML = window.parent.parent.GetTextByName("Lang_DoSetup", window.parent.parent.useprameters.languagedata);
                            document.getElementById("span_ListTitle").innerHTML = var_Lang_HistoryRecordSelectSheet + "——" + var_Lang_XXRW + " 、 " + strstatues + "、" + begtimes + "~" + endtimes;
                            //document.getElementById("span_ListTitle").innerHTML = window.parent.parent.GetTextByName("Lang_Search_History", window.parent.parent.useprameters.languagedata) + window.parent.parent.GetTextByName("Lang_xiangxibiao", window.parent.parent.useprameters.languagedata);
                        }
                    }

            }
        }
        document.onkeypress = function () {
            if (event.keyCode == 13) {
                event.keyCode = 0;
                event.returnValue = false;
                searchList();
            }
        }

        var issi = "";
        var carno = "";
        var statues = "";
        var begtimes = "";
        var endtimes = "";

        var operType = 0;//操作类型 0代表按刷新按钮 1代表按查询按钮

        //点击查询 执行的
        function searchList() {
            isck = false;
            strProID = document.getElementById("sel_WorkFlow").value;
            if (document.getElementById("sel_WorkFlow").value == "") {
                alert(window.parent.parent.GetTextByName("Lang_PleaseSelectLC", window.parent.parent.useprameters.languagedata));
                return;
            }
            if (document.getElementById("Radio1").checked) {
                checkrad2hz = true;
            } else {
                checkrad2hz = false;
            }
            issi = document.getElementById("txt_ISSI").value;
            carno = document.getElementById("txt_NO").value;
            statues = document.getElementById("sel_Statues").value;
            begtimes = document.getElementById("begTime").value;
            endtimes = document.getElementById("endTime").value;

            operType = 1;
            currentPage = 1;
            EmergencyInfoShowFrom = 0;
            getData();
        }
        var p = "";
        var freshtimes = 600;
        var fcount = freshtimes;
        //点击刷新 执行
        function fleshList() {

           // window.parent.parent.SMSMsg(123456, 3, '紧急', 0, "");
            strProID = document.getElementById("sel_WorkFlow").value;
            if (document.getElementById("sel_WorkFlow").value == "") {
                alert(window.parent.parent.GetTextByName("Lang_PleaseSelectLC", window.parent.parent.useprameters.languagedata));
                return;
            }

            if (window.document.getElementById("ck_isTB").checked) {

                issi = "";
                carno = "";
                statues = "";

                isck = false;
                
                if (document.getElementById("rad_HZ").checked) {
                    checkradhz = true;
                } else {
                    checkradhz = false;
                }
                operType = 0;
                currentPage = 1;
                EmergencyInfoShowFrom = 0;
                getData();
                //getChat();
                getCount();
            } else {
                getCount();
            }
            fcount = freshtimes;
            myfreshFun();
        }
        var isck = false;
        function ck(title) {    //查看按钮
            isck = true;
            statues = title;
            issi = "";
            carno = "";
            var date_s = new Date();
            begtimes = date_s.getFullYear() + "-" + (date_s.getMonth() + 1) + "-" + date_s.getDate();
            endtimes = date_s.getFullYear() + "-" + (date_s.getMonth() + 1) + "-" + date_s.getDate();
            currentPage = 1;
            EmergencyInfoShowFrom = 0;
            document.getElementById("doTime").innerHTML = "<span>" + var_Lang_DoTime + "</span>";
            document.getElementById("doStep").innerHTML = var_Lang_DoDutyCount;
            document.getElementById("span_ListTitle").innerHTML = var_Lang_TodayRecordSelectSheet;
            getDataForSearchHZ();
            if (title.toString() != "-1") {
                //document.getElementById("span_ListTitle").innerHTML = "当前状态列表(今日" + title + ")";
                document.getElementById("span_ListTitle").innerHTML = var_Lang_TodayRecordSelectSheet + "——" + title;
            } else {
                document.getElementById("span_ListTitle").innerHTML = var_Lang_TodayRecordSelectSheet + "——" + window.parent.parent.GetTextByName("Lang_UnUP", window.parent.parent.useprameters.languagedata);
                //document.getElementById("span_ListTitle").innerHTML = "当前状态列表(今日正处于" + window.parent.parent.GetTextByName("Lang_UnUP", window.parent.parent.useprameters.languagedata) + "状态)";
            }
        }
        var pary = new Array();
        var var_Lang_lixcsxsj = window.parent.parent.GetTextByName("Lang_lixcsxsj", window.parent.parent.useprameters.languagedata);
        var var_Sencond = window.parent.parent.GetTextByName("Sencond", window.parent.parent.useprameters.languagedata);
        var var_Lang_systemiscounting = window.parent.parent.GetTextByName("Lang_systemiscounting", window.parent.parent.useprameters.languagedata);
        var var_Lang_ToLook = window.parent.parent.GetTextByName("Lang_ToLook", window.parent.parent.useprameters.languagedata);


        function myfreshFun() {
            document.getElementById("span_freshtime").innerHTML = var_Lang_lixcsxsj +"<font color=\"red\">"+ fcount +"</font>"+ var_Sencond;
            if (fcount == 0) {
                getCount();
                fcount = freshtimes;
            } else {
                fcount--;
            }
            clearTimeout(p);
            p = setTimeout(myfreshFun, 1000);
        }

        function getCount() {
            document.getElementById("span_freshtime").innerHTML = var_Lang_systemiscounting;
            window.parent.jquerygetNewData_ajax("../../Handlers/StatuesManage/GetDutyCountServices.ashx", { proid: strProID }, function (msg) {
                var myarray = eval(msg);
                if (myarray.toString() == pary.toString()) {
                    //return;
                }
                for (var j = 0; j < countdivlist.length; j++) {
                    $("#" + countdivlist[j]).remove();
                }
                if ($("#notOver")) {
                    $("#notOver").remove();
                }
                if ($("#" + todayNotOver)) {
                    $("#" + todayNotOver).remove();
                }
                countdivlist.length = 0;
                var col_height = "";//height:40px
                var colNo = stepList.length + 3;
                var height = 0;
                if (colNo < 7) {
                    var p = parseFloat(160 / colNo);
                    col_height = "style='height:" + p + "px'";
                    height = p;
                }
                var totalcounts = 0;
                var content = "";
                content += "<tr " + col_height + " id='" + window.parent.parent.GetTextByName("Lang_UnUP", window.parent.parent.useprameters.languagedata) + "' style='background-color:White;'><td align='left'>" + window.parent.parent.GetTextByName("Lang_UnUP", window.parent.parent.useprameters.languagedata) + "</td><td style=''  align='center' id='tc_wsb'>0</td><td align='center'><input type=\"button\"   onclick=\"ck('-1')\" value=\"" + var_Lang_ToLook + "\" /></td></tr>";
                countdivlist.push(window.parent.parent.GetTextByName("Lang_UnUP", window.parent.parent.useprameters.languagedata));
                if (height == 0) {
                    content += "<tr height='" + (stepList.length - 1) * 25 + "px' width='400px' id='" + todayNotOver + "'><td colSpan='3'><table><tr><td width='120px' height='100%'>" + todayNotOver + "</td><td width='280px' height='100%'><table id='notOver' cellspacing=\"1\" cellpadding=\"0\"  style=\"background-color: #C0DE98; border-color: White; border-width: 0px; border-style: Ridge; width: 280px; height: 100%;\">";
                } else {
                    content += "<tr height='" + (stepList.length - 1) * height + "px' width='400px' id='" + todayNotOver + "'><td colSpan='3'><table><tr><td width='120px' height='100%'>" + todayNotOver + "</td><td width='280px' height='100%'><table id='notOver' cellspacing=\"1\" cellpadding=\"0\"  style=\"background-color: #C0DE98; border-color: White; border-width: 0px; border-style: Ridge; width: 280px;\">";
                }
                //countdivlist.push(todayNotOver);
                for (var i = 0; i < stepList.length; i++) {
                    if (stepList[i].name != "" && stepList[i].name != todayIsOver) {
                        content += "<tr " + col_height + " width='275px' style='' id='" + stepList[i].name + "' style='background-color:White;'><td width='120px' align='left'>" + stepList[i].name + "</td><td style='' width='60px' align='center' id='tc_" + stepList[i].name + "'>0</td><td  width='100px' align='center'><input type=\"button\" onclick=\"ck('" + stepList[i].name + "')\" value=\"" + var_Lang_ToLook + "\" /></td></tr>";
                        countdivlist.push(stepList[i].name);
                    }
                }
                content += "</table></td></tr></table></td></tr>";
                content += "<tr " + col_height + " style='' id='" + todayIsOver + "' style='background-color:White;'><td   align='left'>" + todayIsOver + "</td><td style='' align='center' id='tc_" + todayIsOver + "'>0</td><td align='center'><input type=\"button\"   onclick=\"ck('" + todayIsOver + "')\" value=\"" + var_Lang_ToLook + "\" /></td></tr>";
                countdivlist.push(todayIsOver);
                content += "<tr " + col_height + " id='" + window.parent.parent.GetTextByName("Lang_alltotalcount", window.parent.parent.useprameters.languagedata) + "' style='background-color:White;'><td   align='left'><font style=\"\" color=\"blue\">" + window.parent.parent.GetTextByName("Lang_alltotalcount", window.parent.parent.useprameters.languagedata) + "</font></td><td style=''  align='center'><font style=\"\" id='tc_total' color=\"blue\">" + totalcounts + "</font></td><td align='center'></td></tr>";
                countdivlist.push(window.parent.parent.GetTextByName("Lang_alltotalcount", window.parent.parent.useprameters.languagedata));
                content += "<tr " + col_height + "' style='background-color:White;' id='" + emergency + "'><td align='left'><font style=\"\" color=\"red\">" + emergency + "</font></td><td style='' align='center'><font style=\"\" color=\"red\" id='tc_" + emergency + "'>0</font></td><td align='center'><input type=\"button\"   onclick=\"ck('" + emergency + "')\" value=\"" + var_Lang_ToLook + "\" /></td></tr>";
                countdivlist.push(emergency);
                $("#tb_count").append(content);
                pary = myarray;
                for (var k = 0; k < myarray.length; k++) {
                    totalcounts += parseInt(myarray[k].count);
                    if (myarray[k].stepName != "") {
                        if (document.getElementById("tc_" + myarray[k].stepName)) {
                            document.getElementById("tc_" + myarray[k].stepName).innerHTML = myarray[k].count;
                        }
                    } else {
                        document.getElementById("tc_wsb" + myarray[k].stepName).innerHTML = myarray[k].count;
                        myarray[k].stepName = window.parent.parent.GetTextByName("Lang_UnUP", window.parent.parent.useprameters.languagedata);
                    }
                }
                document.getElementById("tc_total").innerHTML = totalcounts;
                var time = new Date();
                var begsTime = time.getFullYear() + "-" + (time.getMonth() + 1) + "-" + time.getDate();
                var endsTime = time.getFullYear() + "-" + (time.getMonth() + 1) + "-" + time.getDate();
                window.parent.jquerygetNewData_ajax("../../Handlers/StatuesManage/GetPPCSMS.ashx", { begTime: begtimes, endTime: endtimes, need: "Count", proid: strProID, issi: issi, carno: carno }, function (msgEmergency) {
                    var arrMsg = eval(msgEmergency);
                    if (document.getElementById("tc_" + emergency)) {
                        document.getElementById("tc_" + emergency).innerHTML = arrMsg[0].count;
                    }
                    myarray.push(arrMsg[0]);
                    getChat(myarray)

                });
                //getChat(myarray)
            });
        }
        var countdivlist = new Array();
        var step_first = "";
        var step_last = "";
        var stepList = new Array();
        function onRecChange(obj) {
            window.parent.jquerygetNewData_ajax("../../Handlers/StatuesManage/GetProceTypeServices.ashx", { procedure_id: obj.value }, function (msg) {
                var myarray = eval(msg);

                for (var pli = 0; pli < myarray.length; pli++) {
                    document.getElementById("th_DD").innerHTML = myarray[pli].reserve1;
                    document.getElementById("th_DW").innerHTML = myarray[pli].reserve2;
                }
            })
            getStepByProID(obj.value);
           
        }
        function getStepByProID(proid) {
            window.parent.jquerygetNewData_ajax("../../Handlers/StatuesManage/GetStepByProIDService.ashx", { procedure_id: proid }, function (msg) {
                var myarray = eval(msg);
                stepList = myarray;
                var sel_Statues = document.getElementById("sel_Statues");
                sel_Statues.length = 0;
                var optionf = document.createElement("option");
                optionf.value = "";
                optionf.id = "Lang_Log_All";
                optionf.innerHTML = window.parent.parent.GetTextByName("Lang_Log_All", window.parent.parent.useprameters.languagedata);
                sel_Statues.appendChild(optionf);
                if (myarray.length <= 0) {
                    return;
                }
                if (myarray.length > 0) {
                    var optionun = document.createElement("option");
                    optionun.value = -1;
                    optionun.innerHTML = window.parent.parent.GetTextByName("Lang_UnUP", window.parent.parent.useprameters.languagedata);
                    sel_Statues.appendChild(optionun);
                }
                sel_Statues.style.display = "none";
                for (var pli = 0; pli < myarray.length; pli++) {
                    var option = document.createElement("option");
                    option.value = myarray[pli].name;
                    option.innerHTML = myarray[pli].name;
                    sel_Statues.appendChild(option);
                    if (myarray[pli].markId.toString() == "1") {
                        step_first = myarray[pli].name;
                    }
                    if (myarray[pli].markId.toString() == "127") {
                        step_last = myarray[pli].name;
                    }
                }
                var optionE = document.createElement("option");
                optionE.value = emergency;
                optionE.innerHTML = emergency;
                sel_Statues.appendChild(optionE);
                sel_Statues.style.display = "inline";
            });
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
            if (EmergencyInfoShowFrom - everypagecount >= 0)
            {
                EmergencyInfoShowFrom = EmergencyInfoShowFrom - everypagecount;
            } else {
                EmergencyInfoShowFrom = 0;
            }
            getData();
            
            document.getElementById("sel_page").value = currentPage;
        }
        function firstPage() {
            if (currentPage == 1) {
                return;
            }
            currentPage = 1;
            EmergencyInfoShowFrom = 0;
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
        function topageselect() {
            var selobj = document.getElementById("sel_page");
            var firstt = 1;
            if (parseInt(currentPage) - 250 > 0) {
                firstt = parseInt(currentPage) - 250;//之前
            }
            var lastt = totalPage;
            if (parseInt(totalPage) - parseInt(currentPage) > 500) {
                lastt = parseInt(currentPage) + 250;
            }
            selobj.length = 0;
            selobj.style.display = "none";
            for (var p = firstt; p <= lastt; p++) {
                var option = document.createElement("option");
                option.value = p;
                option.innerHTML = p;
                selobj.appendChild(option);
            }
            selobj.style.display = "inline";
        }

        function rearchHZ() {

            document.getElementById("lab_Time").innerText = window.parent.parent.GetTextByName("Lang_FirstTime", window.parent.parent.useprameters.languagedata);
            document.getElementById("lb_Statues").innerText = window.parent.parent.GetTextByName("Lang_NowStatues", window.parent.parent.useprameters.languagedata);
        }
        function rearchXX() {
            document.getElementById("lab_Time").innerText = window.parent.parent.GetTextByName("Lang_DoTime", window.parent.parent.useprameters.languagedata);
            document.getElementById("lb_Statues").innerText = window.parent.parent.GetTextByName("Lang_DoSetup", window.parent.parent.useprameters.languagedata);
        }
        var var_Lang_nodatetoexport = window.parent.parent.GetTextByName("Lang_nodatetoexport", window.parent.parent.useprameters.languagedata);

        function exportExcel() {
            if (arrayISSI.length <= 0) {
                alert(var_Lang_nodatetoexport);
                return;
            }
            var protitle = document.getElementById("sel_WorkFlow").options[document.getElementById("sel_WorkFlow").selectedIndex].text;     //流程选择
            var type = "";//汇总还是详细 0代表汇总 1代表详细

            if (isck) {
                type = 0;
            } else {
                if (operType == 0) {
                    if (checkradhz) {
                        type = 0;
                    } else {
                        type = 1;
                    }

                } else
                    if (operType == 1) {//历史查询
                        if (checkrad2hz) {
                            type = 0;
                        } else {
                            type = 1;
                        }
                    }
            }
            if (begtimes == "" && endtimes == "") {
                var myDate = new Date();
                begtimes = endtimes = myDate.toLocaleDateString();
            }
            window.location = '../../Handlers/OutputtoExcel.ashx?strProID=' + strProID + '&issi=' + issi + '&carno=' + carno + '&statues=' + statues + '&begtimes=' + begtimes + '&endtimes=' + endtimes + '&protitle=' + protitle + '&type=' + type;
            
            
        }
    </script>
</head>
<body style="height: 670px" onselectstart="return false;">
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
                                    <ul class="hor_ul">
                                        <li id="Lang_djbbtj">
                                            <img style="cursor:pointer" src="../images/037.gif" /><%--操作窗口--%></li>
                                    </ul>
                                </td>
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
                                <td width="15" background="../images/tab_12.gif">&nbsp;
                                </td>
                                <td align="center">
                                    <table class="style1" cellspacing="1" id="dragtd">

                                        <tr>
                                            <td>
                                                <table border="0" cellpadding="0" cellspacing="0" align="center" style="height: 140px; width: 31%;">
                                                    <tr>
                                                        <td>
                                                            <div id="Div3" style="font-family: Arial; width: 950px; text-align: left;">
                                                                <fieldset>
                                                                    <legend><asp:Label runat="server" ID="lb_LCXZ"></asp:Label> 
                                                                    </legend>
                                                                    <div style="width: 100%; height: 25px; overflow: auto">
                                                                        <asp:Label runat="server" ID="lb_PleaseXZLC"></asp:Label> 
                                                                        <select id="sel_WorkFlow" onchange="onRecChange(this)" style="width: 200px">
                                                                            <option id="Lang_all_searchoption"></option>
                                                                        </select>
                                                                    </div>
                                                                </fieldset>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                    <tr align="center">
                                                        <td>
                                                            <div id="Div1" style="font-family: Arial; width: 950px; text-align: left;">
                                                                <fieldset>
                                                                    <legend> <asp:Label runat="server" ID="Lang_Manage_GoOut_Today_Count"></asp:Label> 
                                                                    </legend>
                                                                    <div style="width: 100%; height: 265px; overflow: auto">
                                                                        <table>
                                                                            <tr>
                                                                                <td style="width: 400px" valign="top">
                                                                                     <table>
                                                                                          <tr >
                                                                                            <td style="" colspan="3" align="left">
                                                                                                <span id="span_freshtime">&nbsp;&nbsp;</span>
                                                                                            </td>
                                                                                        </tr>
                                                                                       <tr >
                                                                                            <td style="width:140px" align="left"><input type="checkbox" id="ck_isTB"  checked="checked" /><asp:Label runat="server" ID="Lang_IsFreshRecordSheet"></asp:Label> <span style="display:none">请选择今日记录表格式</span></td>
                                                                                            
                                                                                            <td style="width:100px" align="left">
                                                                                                
                                                                                                <span style="display:none">
                                                                                                <input type="radio" name="hz" checked="checked" id="rad_HZ" value="0" />汇总
                                                                                                  <input type="radio" name="hz" id="rad_YX" value="1" />详细
                                                                                                    </span>
                                                                                            </td>
                                                                                            <td>
                                                                                                <input type="button" id="btn_Fresh_Total" style="display: none" onclick="fleshList()" value="" />
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                     <div style="width: 100%; height: 210px; overflow: auto">
                                                                                    <table  cellspacing="1" cellpadding="0"  style="background-color: #C0DE98; border-color: White; border-width: 0px; border-style: Ridge; width: 99%;" id="tab">
                                                                                        <%--<asp:Label runat="server" ID="lab_countName"></asp:Label>--%>
                                                                                          <tr class="gridheadcss" style="font-weight: bold;">
                                                                                            <th style="width:240px" align="center"><asp:Label runat="server" ID="lab_countName"></asp:Label></th>
                                            <%--                                              <th style="width:100px" align="center"></th>--%>
                                                                                            <th style="width:60px" align="center">
                                                                                                <asp:Label runat="server" ID="Lang_Count"></asp:Label>
                                                                                            </th>
                                                                                            <th style="width:100px">
                                                                                               <asp:Label runat="server" ID="Lang_ToLook"></asp:Label>
                                                                                            </th>
                                                                                        </tr>
                                                                                            <tbody id="tb_count">
                                                                                            </tbody>
                                                                                        
                                                                                    </table>
                                                                                    </div>
                                                                                </td>
                                                                                <td>
                                                                                    <div id="chart_combo" style="width: 550px; height: 250px" class="chart_combo"></div>
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </div>
                                                                </fieldset>
                                                            </div>
                                                        </td>
                                                    </tr>

                                                    <tr align="center">
                                                        <td>
                                                            <div id="Panel2" style="font-family: Arial; width: 950px; text-align: left;">
                                                                <fieldset>
                                                                    <legend><span id="span_ListTitle"></span>
                                                                    </legend>

                                                                    <div style="width: 100%; height: 150px; overflow: auto">
                                                                        <table cellspacing="1" cellpadding="0" id="GridView1" style="background-color: #C0DE98; border-color: White; border-width: 0px; border-style: Ridge; width: 99%;">
                                                                       
                                                                            <tr class="gridheadcss" style="font-weight: bold;">
                                                                                <th style="" id="th_DD" scope="col">大队</th>
                                                                                <th style="width: 15%" id="Th15" scope="col"></th>
                                                                                <th style="width: 10%" id="Th16" scope="col"></th>
                                                                                <th style="width: 12%" id="th_DW" scope="col">驻勤单位</th>
                                                                                <th style="width: 10%" id="nowStep" scope="col"></th>
                                                                                <th style="width: 13%" id="doTime" scope="col"></th>
                                                                                <th style="width: 13%" id="doStep" scope="col"></th>
                                                                                <th style="width: 8%" id="Th2" scope="col"></th>
                                                                                <th style="width: 5%" id="Th3" scope="col"></th>
                                                                            </tr>

                                                                            <tbody id="Tbody1">
                                                                            </tbody>
                                                                        </table>
                                                                             <tr style="color: blue; background-color: White; height: 28px;">

                                                                                <th id="thppp" style="font-family: Arial" scope="col" colspan="9" align="right" >
                                                                                    <table style="width: 100%">
                                                                                        <tr> 
                                                                                            <td align="left" style="width: 20%">
                                                                                                <span id="span_page"></span><span id="span_currentPage">0</span>/<span id="span_totalpage">0</span>&nbsp;&nbsp;
                                                                                                <span id="span_tiao"></span>
                                                                                                <span id="span_currentact">0~0</span>/<span id="span_total">0</span>
                                                                                            </td>
                                                                                            <td align="right" style="width: 40%">
                                                                                                <span onclick="firstPage()" class="YangdjPageStyle" id="Lang_FirstPage"></span>&nbsp;&nbsp;<span onclick="prePage()" class="YangdjPageStyle" id="Lang_PrePage"></span>&nbsp;&nbsp;<span onclick="nextPage()" class="YangdjPageStyle" id="Lang_play_next_page"></span>&nbsp;&nbsp;<span onclick="lastPage()" class="YangdjPageStyle" id="Lang_LastPage"></span>
                                                                                            </td>
                                                                                            <td align="right" style="width: 7%">
                                                                                                <select onchange="tzpage()" id="sel_page"></select>
                                                                                            </td>
                                                                                            <td align="right">
                                                                                                <input type="button" id="btn_ExportToExcel" onclick="exportExcel()" value="" /></td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </th>
                                                                               

                                                                            </tr>
                                                                    </div>
                                                                </fieldset>
                                                            </div>
                                                        </td>
                                                    </tr>

                                                    <tr align="center">
                                                        <td>
                                                            <div id="Div2" style="font-family: Arial; width: 950px; text-align: left;">
                                                                <fieldset>
                                                                    <legend><span id="Lang_SelectHistoryRW"></span>
                                                                    </legend>
                                                                    <div style="width: 100%; height: 40px; overflow: auto">
                                                                        <table>
                                                                            <tr>
                                                                                <td>

                                                                                    <span id="lb_ISSI"></span>
                                                                                </td>
                                                                                <td>
                                                                                    <input type="text" id="txt_ISSI" style="width: 80px" />
                                                                                    <img alt="" id="imgSelectISSI" onclick="OnAddMember()" />
                                                                                </td>
                                                                                <td>

                                                                                    <span id="lb_No"></span>
                                                                                    <input type="text" id="txt_NO" style="width: 80px" />

                                                                                </td>
                                                                                <td>

                                                                                    <span id="lb_Statues"></span>
                                                                                    <select id="sel_Statues" style="width: 100px">
                                                                                        <option id="Lang_Log_All" value=""></option>
                                                                                    </select>
                                                                                </td>
                                                                                <td>

                                                                                    <span id="lab_Time"></span>
                                                                                    <input readonly="readonly" type="text" style="width: 80px; height: 13px" id="begTime" class="Wdate" onfocus="">~
                                                                                <input readonly="readonly" type="text" style="width: 80px; height: 13px" id="endTime" class="Wdate" onfocus="">
                                                                                </td>
                                                                                <td>
                                                                                    <input onclick="rearchHZ()" type="radio" name="hz2" checked="checked" id="Radio1" value="0" /><span id="span_hz"></span>
                                                                                    <input onclick="rearchXX()" type="radio" name="hz2" id="Radio2" value="1" /><span  id="span_xx"></span>
                                                                                </td>
                                                                                <td>
                                                                                    <img id="Lang_Search2" style="cursor: pointer; display: none" onclick="searchList()" />
                                                                                </td>
                                                                            </tr>

                                                                        </table>

                                                                    </div>
                                                                </fieldset>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                    <tr align="center">
                                                        <td>&nbsp;
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
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
    // alert(typeof LanguageSwitch);
    LanguageSwitch(window.parent);
    
    window.document.getElementById("Lang_Log_All").innerHTML = window.parent.parent.GetTextByName("Lang_Log_All", window.parent.parent.useprameters.languagedata);
    window.document.getElementById("Lang_all_searchoption").innerHTML = window.parent.parent.GetTextByName("Lang_all_searchoption", window.parent.parent.useprameters.languagedata);

    window.document.getElementById("Lang_SelectHistoryRW").innerHTML = window.parent.parent.GetTextByName("Lang_SelectHistoryRW", window.parent.parent.useprameters.languagedata);
    window.document.getElementById("lb_ISSI").innerHTML = window.parent.parent.GetTextByName("Lang_ZDID", window.parent.parent.useprameters.languagedata);
    window.document.getElementById("lb_No").innerHTML = window.parent.parent.GetTextByName("Lang_CarONOrPoliceNo", window.parent.parent.useprameters.languagedata);
    window.document.getElementById("lb_Statues").innerHTML = window.parent.parent.GetTextByName("Lang_StatueRW", window.parent.parent.useprameters.languagedata);
    window.document.getElementById("lab_Time").innerHTML = window.parent.parent.GetTextByName("Time", window.parent.parent.useprameters.languagedata);
    window.document.getElementById("span_hz").innerHTML = window.parent.parent.GetTextByName("Lang_HZRW", window.parent.parent.useprameters.languagedata);
    window.document.getElementById("span_xx").innerHTML = window.parent.parent.GetTextByName("Lang_XXRW", window.parent.parent.useprameters.languagedata);

    


    window.document.getElementById("Th15").innerHTML = window.parent.parent.GetTextByName("Lang_CarONOrPoliceNo", window.parent.parent.useprameters.languagedata);;
    window.document.getElementById("Th16").innerHTML = window.parent.parent.GetTextByName("Lang_ZDID", window.parent.parent.useprameters.languagedata);;
    window.document.getElementById("nowStep").innerHTML = window.parent.parent.GetTextByName("Lang_CurrentInfo", window.parent.parent.useprameters.languagedata);;
    window.document.getElementById("doTime").innerHTML = window.parent.parent.GetTextByName("Lang_DoTime", window.parent.parent.useprameters.languagedata);;
    window.document.getElementById("doStep").innerHTML = window.parent.parent.GetTextByName("Lang_DoDutyCount", window.parent.parent.useprameters.languagedata);;
    window.document.getElementById("Th2").innerHTML = window.parent.parent.GetTextByName("Info", window.parent.parent.useprameters.languagedata);;
    window.document.getElementById("Th3").innerHTML = window.parent.parent.GetTextByName("Lang_Operate", window.parent.parent.useprameters.languagedata);;

    var image = window.document.getElementById("imgSelectISSI");
    var srouce = window.parent.parent.GetTextByName("Lang_chooseMemberPNG", window.parent.parent.useprameters.languagedata);
    image.setAttribute("src", srouce);
    var strpath = window.parent.parent.GetTextByName("Lang_chooseMemberPNG", window.parent.parent.useprameters.languagedata);
    var strpathmove = window.parent.parent.GetTextByName("Lang_chooseMemberPNG_un", window.parent.parent.useprameters.languagedata);
    image.onmouseover = function () { this.src = strpathmove }
    image.onmouseout = function () { this.src = strpath }

    var Lang_Search22 = window.parent.parent.GetTextByName("Lang_Search2", window.parent.parent.useprameters.languagedata);
    var Lang_Search2_un = window.parent.parent.GetTextByName("Lang_Search2_un", window.parent.parent.useprameters.languagedata);
    var Lang_Search2 = window.document.getElementById("Lang_Search2");
    Lang_Search2.onmousedown = function () {
        Lang_Search2.src = Lang_Search2_un;
    }
    Lang_Search2.onmouseup = function () {
        Lang_Search2.src = Lang_Search22;
    }
    document.getElementById("lab_Time").innerText = window.parent.parent.GetTextByName("Lang_FirstTime", window.parent.parent.useprameters.languagedata);
    document.getElementById("lb_Statues").innerText = window.parent.parent.GetTextByName("Lang_NowStatues", window.parent.parent.useprameters.languagedata);
    document.oncontextmenu = function () {
        displaycardutymouserMenu();
    }
    function displaycardutymouserMenu() {
        window.parent.document.getElementById("mouseMenu").style.display = "none";
    }
    document.getElementById("btn_Fresh_Total").value = window.parent.parent.GetTextByName("Lang_FreshCount", window.parent.parent.useprameters.languagedata);
    document.getElementById("span_ListTitle").innerHTML = window.parent.parent.GetTextByName("Lang_SelectRecordArea", window.parent.parent.useprameters.languagedata);
    document.getElementById("btn_ExportToExcel").value = window.parent.parent.GetTextByName("Lang_ExportToExcel", window.parent.parent.useprameters.languagedata);
    var span_page = window.parent.parent.GetTextByName("Page", window.parent.parent.useprameters.languagedata);
    var span_tiao = window.parent.parent.GetTextByName("Article", window.parent.parent.useprameters.languagedata);

    window.document.getElementById("span_page").innerHTML = span_page;
    window.document.getElementById("span_tiao").innerHTML = span_tiao;
    

</script>
<link href="../../CSS/lq_calloutExtender.css" rel="stylesheet" type="text/css" />
