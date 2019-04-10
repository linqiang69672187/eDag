﻿//定义月历函数
function calendar() {
    var today = new Date(); //创建日期对象
    year = today.getYear(); //读取年份
    thisDay = today.getDate(); //读取当前日

    //创建每月天数数组
    var monthDays = new Array(31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
    //如果是闰年，2月份的天数为29天
    if (((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0)) monthDays[1] = 29;
    daysOfCurrentMonth = monthDays[today.getMonth()]; //从每月天数数组中读取当月的天数
    firstDay = today; //复制日期对象
    firstDay.setDate(1); //设置日期对象firstDay的日为1号
    startDay = firstDay.getDay(); //确定当月第一天是星期几

    //定义周日和月份中文名数组
    var dayNames = new Array("星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六");
    var monthNames = new Array("1月", "2月", "3月", "4月", "5月", "6月", "7月", "8月", "9月", "10月", "11月", "12月");
    //创建日期对象
    var newDate = new Date();

    //创建表格
    document.write("<TABLE BORDER='0' CELLSPACING='0' CELLPADDING='2' ALIGN='CENTER' BGCOLOR='#0080FF'>")
    document.write("<TR><TD><table border='0' cellspacing='1' cellpadding='2' bgcolor='#88FF99'>");
    document.write("<TR><th colspan='7' bgcolor='#C8E3FF'>");

    //显示当前日期和周日
    document.writeln("<FONT STYLE='font-size:9pt;Color:#FF0000'>" + newDate.getYear() + "年" + monthNames[newDate.getMonth()] + " " + newDate.getDate() + "日 " + dayNames[newDate.getDay()] + "</FONT>");

    //显示月历表头
    document.writeln("</TH></TR><TR><TH BGCOLOR='#0080FF'><FONT STYLE='font-size:9pt;Color:White'>日</FONT></TH>");
    document.writeln("<th bgcolor='#0080FF'><FONT STYLE='font-size:9pt;Color:White'>一</FONT></TH>");
    document.writeln("<TH BGCOLOR='#0080FF'><FONT STYLE='font-size:9pt;Color:White'>二</FONT></TH>");
    document.writeln("<TH BGCOLOR='#0080FF'><FONT STYLE='font-size:9pt;Color:White'>三</FONT></TH>");
    document.writeln("<TH BGCOLOR='#0080FF'><FONT STYLE='font-size:9pt;Color:White'>四</FONT></TH>");
    document.writeln("<TH BGCOLOR='#0080FF'><FONT STYLE='font-size:9pt;Color:White'>五</FONT></TH>");
    document.writeln("<TH BGCOLOR='#0080FF'><FONT STYLE='font-size:9pt;Color:White'>六</FONT></TH>");
    document.writeln("</TR><TR>");

    //显示每月前面的"空日"
    column = 0;
    for (i = 0; i < startDay; i++) {
        document.writeln(" <TD><FONT STYLE='font-size:9pt'> </FONT></TD>");
        column++;
    }

    //如果是当前日就突出显示(红色)，否则正常显示(黑色)
    for (i = 1; i <= daysOfCurrentMonth; i++) {
        if (i == thisDay) {
            document.writeln("</TD><TD ALIGN='CENTER'><FONT STYLE='font-size:9pt;Color:#ff0000'><B>")
        }
        else {
            document.writeln("</TD><TD BGCOLOR='#88FF99' ALIGN='CENTER'><FONT STYLE='font-size:9pt;font-family:Arial;font-weight:bold;Color:#000000'>");
        }
        document.writeln(i);
        if (i == thisDay) document.writeln("</FONT></TD>")
        column++;
        if (column == 7) {
            document.writeln("<TR>");
            column = 0;
        }
    }
    document.writeln("<TR><TD COLSPAN='7' ALIGN='CENTER' VALIGN='TOP' BGCOLOR='#0080FF'>")
    document.writeln("<FORM NAME='time' onSubmit='0'><FONT STYLE='font-size:9pt;Color:#ffffff'>")

    //显示当前时间
    document.writeln("当前时间:<INPUT TYPE='Text' NAME='textbox' ALIGN='TOP'></FONT></TD></TR></TABLE>")
    document.writeln("</TD></TR></TABLE></FORM>");
}

//初始化控制变量
var timerID = null;
var timerRunning = false;

//定义时间显示函数
function stoptime() {
    if (timerRunning)
        clearTimeout(timerID);
    timerRunning = false;
}

//定义显示时间函数
function showtime() {
    var newDate = new Date();
    var hours = newDate.getHours();
    var minutes = newDate.getMinutes();
    var seconds = newDate.getSeconds()
    var timeValue = " " + ((hours > 12) ? hours - 12 : hours)
    timeValue += ((minutes < 10) ? ":0" : ":") + minutes
    timeValue += ((seconds < 10) ? ":0" : ":") + seconds
    timeValue += (hours >= 12) ? " 下午 " : " 上午 "
    document.time.textbox.value = timeValue;
    timerID = setTimeout("showtime()", 1000); //设置超时,使时间动态显示
    timerRunning = true;
}

//显示当前时间
function starttime() {
    stoptime();
    showtime();
}