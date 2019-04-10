<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="manage_Attendance.aspx.cs" Inherits="Web.lqnew.opePages.manage_Attendance" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
     <link href="../../CSS/pagestyle.css" rel="stylesheet" type="text/css" />
     <link href="../../CSS/ui-lightness/jquery-ui-1.8.13.custom.css" rel="stylesheet" type="text/css" />
     <link href="../css/lq_addedit.css" rel="stylesheet" type="text/css" />
      
    <script src="../../JQuery/jquery-1.5.2.js" type="text/javascript"></script>
    <script src="../js/geturl.js" type="text/javascript"></script>
    <script src="../js/dragwindow.js" type="text/javascript"></script>
    <script src="../js/GlobalConst.js" type="text/javascript"></script>
    <script src="../../JS/LangueSwitch.js" type="text/javascript"></script>
    <script src="../js/geturl.js" type="text/javascript"></script>
    <script src="../js/highcharts.js"></script>
    <script src="../js/MouseMenu.js"></script>

    <script src="../../JQuery/jquery-ui-1.8.13.custom.min.js" type="text/javascript"></script>
    <%if (System.Configuration.ConfigurationManager.AppSettings["defaultLanguage"] == "zh-CN")
      { %>
    <script src="../../JQuery/ui.datepicker-zh-CN.js" type="text/javascript"></script>
    <%} %>
     <link rel="stylesheet" type="text/css" href="../js/resPermissions/jquery-easyui-1.4.1/themes/default/easyui.css" />
    <link rel="stylesheet" type="text/css" href="../js/resPermissions/jquery-easyui-1.4.1/themes/icon.css" />
    <link rel="stylesheet" type="text/css" href="../js/resPermissions/jquery-easyui-1.4.1/demo/demo.css" />
    <script type="text/javascript" src="../js/resPermissions/jquery-easyui-1.4/jquery.min.js"></script>
    <script type="text/javascript" src="../js/resPermissions/jquery-easyui-1.4.1/jquery.easyui.min.js"></script>
    <%if (System.Configuration.ConfigurationManager.AppSettings["defaultLanguage"] == "zh-CN")
      { %>
    <script type="text/javascript" src="../js/resPermissions/jquery-easyui-1.4.1/locale/easyui-lang-zh_CN.js"></script>
    <%} %>

    <style type="text/css">
        ruby {
            font-size: 50px;
            color: red;
            font-family: 黑体;
        }

        .tab {
            border: solid 1px;
            border-color: rgb(80,160,91);
            width: 950px;
            margin: 0 auto;
            text-align: left;
        }

        .hd {
            background-color: rgb(217,246,182);
            height: 20px;
            width:100%;
            border-bottom: solid 1px;
            border-color: rgb(80,160,91);
        }

            .hd ul {
                padding: 0;
                margin: 0;
                height: 20px;
                overflow: hidden;
            }

            .hd .nomal {
                font-size: 15px;
                height: 20px;
                line-height: 20px;
                float: left;
                width: 15%;
                text-align: center;
                border-right: solid 1px;
                border-color:rgb(80,160,91);
                cursor: pointer;
                list-style: none;
            }

            .hd .activeTab {
                background:  rgb(243,252,230);
                font-weight: bold;
            }

        #content {
            padding: 2px 10px;
            width: 950px;
        }
        
        .button-green {
            width:80px;
            height:22px;
            text-align:center;
            border-radius:5px;
            border:1px solid #46894D;
            box-shadow:inset -2px -2px 5px 0px #86c086;
            background-color:#ECFDD6;
            margin:0 5px;
        }

        .button-right {
            float:right;
        }
        .button-left {
            float:left;
        }
    </style>
     <style type="text/css">
        body, .style1 {
            background-color: transparent;
            margin: 0px;
            font-size: 12px;
            scrollbar-face-color: #DEDEDE;
            scrollbar-base-color: #F5F5F5;
            scrollbar-arrow-color: black;
            scrollbar-track-color: #F5F5F5;
            scrollbar-shadow-color: #EBF5FF;
            scrollbar-highlight-color: #F5F5F5;
            scrollbar-3dlight-color: #C3C3C3;
            scrollbar-darkshadow-Color: #9D9D9D;
        }

        .style2 {
            width: 10px;
        }

        .bg1 {
            background-image: url('../view_infoimg/images/bg_02.png');
            background-repeat: repeat-x;
            vertical-align: top;
        }

        .bg2 {
            background-image: url('../view_infoimg/images/bg_10.png');
            background-repeat: repeat-x;
        }

        .bg3 {
            background-image: url('../view_infoimg/images/bg_05.png');
            background-repeat: repeat-y;
        }

        .bg4 {
            background-image: url('../view_infoimg/images/bg_06.png');
        }

        .bg5 {
            background-image: url('../view_infoimg/images/bg_07.png');
            background-repeat: repeat-y;
        }

        #divClose {
            width: 33px;
            height: 16px;
            position: relative;
            border: 0px;
            float: right;
            margin-top: 1px;
            background-image: url('../view_infoimg/images/minidict_03.png');
            cursor: pointer;
        }

        .gridheadcss th {
            background-image: url(../images/tab_14.gif);
            height: 25px;
        }

        #GridView1, #GridView12 {
            margin-top: 3px;
            font-size: 12px;
        }

        .td1td {
            background-color: #FFFFFF;
            text-align: right;
        }

        .divgrd {
            margin: 2 0 2 0;
            overflow: auto;
            height: 365px;
        }

        #tags {
            width: 99px;
        }

        .style3 {
            width: 37px;
        }
    </style>
    
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <table class="style1" cellpadding="0" cellspacing="0">
        <tr style="height: 5px;" id="derppp">
            <td class="style2">
                <img src="../images/tab_03.png" width="15" height="32" /></td>
            <td style="background: url(../images/tab_05.gif)">
                <div id="Lang_djbbtj" style="display: inline; float: left; text-align: left; width: 30%; color: white"></div>
                <!-------------------onclick添加hideCarDutyMenu()函数，隐藏右键菜单-----xzj--2018/8/4------------------>
                <div id="divClose" onmouseover="Divover('on')" onclick="hideCarDutyMenu();closethispage()" onmouseout="Divover('out')"></div>
            </td>
            <td class="style2" cellpadding="0" cellspacing="0">
                <img src="../images/tab_07.png" width="14" height="32" /></td>
        </tr>
        <tr>
            <td width="15" background="../images/tab_12.gif"></td>
            <td style="background-color: white" id="dragtd">
                <div>
                    <div style="width: auto; height: auto;" id="showDiv">

                        <div class="tab">
                            <div class="hd">
                                <ul>
                                    <li class="nomal activeTab" tabid="content1" id="hzTab">今日查询</li>
                                    <li class="nomal" tabid="content2" id="mxTab">历史查询</li>
                                </ul>
                            </div>
                            <div id="content" style="height:450px;overflow: scroll">
                                <div id="content1" style="display: block;">
                                    <div id="aa" style="width: 100%; height: auto; padding: 1px;">

                                        <table border="0" cellpadding="0" cellspacing="0" align="center" style="height: 140px; width: 31%;">
                                            <tr>
                                                <td>
                                                    <div id="Div3" style="font-family: Arial; width: 950px; text-align: left;">
                                                        <fieldset>
                                                            <legend>
                                                                <asp:Label runat="server" ID="lb_LCXZ"></asp:Label>
                                                            </legend>
                                                            <div style="width: 100%; height: 25px; overflow: auto">
                                                                <asp:Label runat="server" ID="lb_PleaseXZLC"></asp:Label>
                                                                <select id="sel_WorkFlow" onchange="onRecChange1(this)" style="width: 200px">
                                                                    <option id="Lang_all_searchoption"></option>
                                                                </select>
                                                            </div>
                                                        </fieldset>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr align="center">
                                                <td>
                                                    <div id="Div2" style="font-family: Arial; width: 950px; text-align: left;">
                                                        <fieldset>
                                                            <legend>
                                                                <asp:Label runat="server" ID="Lang_Manage_GoOut_Today_Count"></asp:Label>
                                                            </legend>
                                                            <div style="width: 100%; height: 265px; overflow: auto">
                                                                <table>
                                                                    <tr>
                                                                        <td style="width: 400px" valign="top">
                                                                            <table>
                                                                                <tr>
                                                                                    <td style="" colspan="3" align="left">
                                                                                        <span id="span_freshtime">&nbsp;&nbsp;</span>
                                                                                    </td>
                                                                                    <td>
                                                                                        <input type="button" id="btn_Fresh_Total" class="button-green" style="display: none" onclick="fleshList()" value="" />
                                                                                    </td>
                                                                                </tr>

                                                                            </table>
                                                                            <div style="width: 100%; height: 210px; overflow: auto">
                                                                                <table cellspacing="1" cellpadding="0" style="background-color: #C0DE98; border-color: White; border-width: 0px; border-style: Ridge; width: 99%;" id="tab">
                                                                                    <%--<asp:Label runat="server" ID="lab_countName"></asp:Label>--%>
                                                                                    <tr class="gridheadcss" style="font-weight: bold;">
                                                                                        <th style="width: 240px" align="center">
                                                                                            <asp:Label runat="server" ID="lab_countName"></asp:Label></th>
                                                                                        <%--                                              <th style="width:100px" align="center"></th>--%>
                                                                                        <th style="width: 60px" align="center">
                                                                                            <asp:Label runat="server" ID="Lang_Count"></asp:Label>
                                                                                        </th>
                                                                                        <th style="width: 100px">
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

                                                            <div style="width: 100%; height: auto; overflow: auto">
                                                                <table cellspacing="1" cellpadding="0" id="GridView1" style="background-color: #C0DE98; border-color: White; border-width: 0px; border-style: Ridge; width: 99%;">

                                                                    <tr class="gridheadcss" style="font-weight: bold;">
                                                                        <th style="display: none" id="th_reserve1" scope="col">大队</th>
                                                                        <th style="width: 15%" id="Th15" scope="col"></th>
                                                                        <th style="width: 10%" id="Th16" scope="col"></th>
                                                                        <th style="display: none; width: 12%" id="th_reserve2" scope="col">驻勤单位</th>
                                                                        <th style="width: 10%" id="nowStep" scope="col"></th>
                                                                        <th style="width: 13%" id="doTime" scope="col"></th>
                                                                        <th style="width: 13%" id="doStep" scope="col"></th>
                                                                        <th style="width: 8%" id="Th2" scope="col"></th>
                                                                        <th style="width: 5%" id="Th3" scope="col"></th>
                                                                    </tr>

                                                                    <tbody id="Tbody1">
                                                                    </tbody>
                                                                </table>
                                                                <%-- <tr style="color: blue; background-color: White; height: 28px;">

                                                                                <th id="thppp" style="font-family: Arial" scope="col" colspan="9" align="right" >--%>
                                                                <table style="width: 100%">
                                                                    <tr>
                                                                        <td align="left" style="width: 20%">
                                                                            <span id="span_page"></span><span id="span_currentPage">0</span>/<span id="span_totalpage">0</span>&nbsp;&nbsp;
                                                                                                <span id="span_tiao"></span>
                                                                            <span id="span_currentact">0~0</span>/<span id="span_total">0</span>
                                                                        </td>
                                                                        <td align="right" style="width: 40%">
                                                                            <span onclick="firstPage()" class="YangdjPageStyle" id="Lang_FirstPage"></span>&nbsp;&nbsp;
                                                                                                <span onclick="prePage()" class="YangdjPageStyle" id="Lang_PrePage"></span>&nbsp;&nbsp;
                                                                                                <span onclick="nextPage()" class="YangdjPageStyle" id="Lang_play_next_page"></span>&nbsp;&nbsp;
                                                                                                <span onclick="lastPage()" class="YangdjPageStyle" id="Lang_LastPage"></span>
                                                                        </td>
                                                                        <td align="right" style="width: 7%">
                                                                            <select onchange="tzpage()" id="sel_page"></select>
                                                                        </td>
                                                                        <td align="right">
                                                                            <input type="button" id="btn_ExportToExcel" class="button-green" onclick="exportExcel()" value="" /></td>
                                                                    </tr>
                                                                </table>
                                                                <%--  </th>
                                                                               
                                                                            </tr>--%>
                                                            </div>
                                                        </fieldset>
                                                    </div>
                                                </td>
                                            </tr>

                                        </table>

                                    </div>
                                </div>
                                <div id="content2" style="display: none;">
                                    <div id="Div1" style="width: 100%;">

                                        <fieldset>
                                            <legend>
                                                <asp:Label runat="server" ID="lb_LCXZ2"></asp:Label>
                                            </legend>
                                            <div style="width: 100%; height: 25px; overflow: auto">
                                                <asp:Label runat="server" ID="lb_PleaseXZLC2"></asp:Label>
                                                <select id="sel_WorkFlow2" onchange="onRecChange2(this)" style="width: 200px">
                                                    <option id="Lang_all_searchoption2"></option>
                                                </select>
                                            </div>
                                        </fieldset>
                                        <fieldset>
                                            <legend>
                                                <asp:Label runat="server" ID="Condition"></asp:Label>
                                            </legend>
                                            <div style="display: inline; text-align: center; height: 30px;">
                                                <span id="issi_txt">终端号码</span>:&nbsp;<input type="text" value="" style="width: 80px;" id="txt_ISSI" />
                                                &nbsp;&nbsp;&nbsp;<img alt="" id="imgSelectISSI" onclick="OnAddMember()" />
                                                <span id="Lang_StatueRW">上报状态</span>:
                                                <select id="sel_Statues" style="width: 80px;">
                                                    <option id="Lang_Log_All" value="2">全部</option>
                                                </select>
                                                &nbsp;&nbsp;&nbsp; 
                                                 
                                                 <select id="sel_NameorNo" style="width: 120px;">
                                                     <option id="Lang_name" value="0">姓名</option>
                                                     <option id="Lang_CarONOrPoliceNo" value="1">号码(车牌号，警号等）</option>
                                                 </select>:&nbsp;<input type="text" value="" style="width: 80px;" id="txt_NO" />
                                                &nbsp;&nbsp;&nbsp;
                                                  <span id="span_reserve2" style="display: none"></span>&nbsp;<input type="text" value="" style="width: 80px; display: none" id="txt_reserve2" />
                                                <div style="height: 1px;"></div>
                                                </br>
                                                  <div style="display: inline; float: left; width: 25%; text-align: left;">
                                                      <span id="Lang_BegTime">开始时间</span>:
                                                <input id="begTime_h" class="easyui-datebox" style="width: 130px" required="required" editable="false" data-options="formatter:changeFormatter,parser:myparser" />
                                                  </div>
                                                <div style="text-align: left; float: left; width: 25%;">
                                                    <span id="Lang_EndTime">结束时间</span>:
                                                            <input id="endTime_h" class="easyui-datebox" style="width: 130px;" required="required" editable="false" data-options="formatter:changeFormatter,parser:myparser" />
                                                </div>
                                                <div style="text-align: left; float: left; width: 20%;">
                                                    <input type="radio" name="hz2" checked="checked" id="Radio1" value="0" /><span id="span_hz"></span>
                                                    <input type="radio" name="hz2" id="Radio2" value="1" /><span id="span_xx"></span>
                                                </div>
                                                <div style="text-align: center; float: left; width: 10%;">
                                                    <img id="Lang_Search2" style="cursor: pointer; display: none" onclick="searchList()" src="" />
                                                </div>
                                                <div style="text-align: left; float: left; width: 10%;">
                                                    <input onclick="exportExcel2()" type="button" class="button-green" style="padding-right: 5px" id="Lang_ExportToExcel" value="导出到Excel" />
                                                </div>
                                            </div>
                                        </fieldset>

                                        <fieldset>
                                            <legend><span id="span_ListTitle_history"></span>
                                            </legend>

                                            <div style="width: 100%; height: auto; overflow: auto">
                                                <table cellspacing="1" cellpadding="0" id="Table1" style="background-color: #C0DE98; border-color: White; border-width: 0px; border-style: Ridge; width: 99%;">

                                                    <tr class="gridheadcss" style="font-weight: bold;">

                                                        <th style="" id="th2_reserve1" scope="col">大队</th>
                                                        <th style="width: 12%" id="wth2" scope="col"></th>
                                                        <th style="width: 15%" id="wth3" scope="col"></th>
                                                        <th style="width: 14%" id="th2_reserve2" scope="col">驻勤单位</th>
                                                        <th style="width: 14%" id="wth5" scope="col"></th>
                                                        <th style="width: 17%" id="wth6" scope="col"></th>
                                                        <th style="width: 8%; display: none;" id="wth7" scope="col"></th>
                                                        <th style="width: 5%" id="wth8" scope="col"></th>

                                                    </tr>

                                                    <tbody id="Tbody2">
                                                    </tbody>
                                                </table>
                                                <table style="width: 100%">
                                                    <tr>
                                                        <td align="left" style="width: 20%">
                                                            <span id="span_page2"></span><span id="span_currentPage2">0</span>/<span id="span_totalpage2">0</span>&nbsp;&nbsp;
                                                                                                <span id="span_tiao2"></span>
                                                            <span id="span_currentact2">0~0</span>/<span id="span_total2">0</span>
                                                        </td>
                                                        <td align="right" style="width: 40%">
                                                            <span onclick="firstPage2()" class="YangdjPageStyle" id="Lang_FirstPage2"></span>&nbsp;&nbsp;
                                                                                                <span onclick="prePage2()" class="YangdjPageStyle" id="Lang_PrePage2"></span>&nbsp;&nbsp;
                                                                                                <span onclick="nextPage2()" class="YangdjPageStyle" id="Lang_play_next_page2"></span>&nbsp;&nbsp;
                                                                                                <span onclick="lastPage2()" class="YangdjPageStyle" id="Lang_LastPage2"></span>
                                                        </td>
                                                        <td align="right" style="width: 7%">
                                                            <select onchange="tzpage2()" id="sel_page2"></select>
                                                        </td>
                                                    </tr>
                                                </table>

                                            </div>
                                        </fieldset>

                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>

            </td>
            <td width="14" background="../images/tab_16.gif"></td>
        </tr>
        <tr style="height: 15px;">
            <td>
                <img src="../images/tab_20.png" width="15" height="15" /></td>
            <td background="../images/tab_21.gif"></td>
            <td>
                <img src="../images/tab_22.png" width="14" height="15" /></td>
        </tr>
    </table>
    </div>
    </form>
</body>
</html>
<script type="text/javascript">
    window.parent.closeprossdiv();
    LanguageSwitch(window.parent.parent);
    var language = window.parent.parent.useprameters.languagedata;
    //加载中
    var Lang_loading = window.parent.parent.GetTextByName("Lang_loading", language);
    //离下次自动刷新今日统计信息时间
    var var_Lang_lixcsxsj = window.parent.parent.GetTextByName("Lang_lixcsxsj", language);
    //秒
    var var_Sencond = window.parent.parent.GetTextByName("Sencond", language);
    //系统正在统计中，请稍候！
    var var_Lang_systemiscounting = window.parent.parent.GetTextByName("Lang_systemiscounting", language);
    //查看
    var var_Lang_ToLook = window.parent.parent.GetTextByName("Lang_ToLook", language);
    //详细信息
    var xxxx = window.parent.parent.GetTextByName("Info", language);
    //导出到Excel
    document.getElementById("btn_ExportToExcel").value = window.parent.parent.GetTextByName("Lang_ExportToExcel", language);
    //刷新统计
    document.getElementById("btn_Fresh_Total").value = window.parent.parent.GetTextByName("Lang_FreshCount", language);
    // 全天未结束
    var todayNotOver = window.parent.parent.GetTextByName("TodayNotOver", language);
    //全天结束
    var todayIsOver = window.parent.parent.GetTextByName("TodayIsOver", language);
    //紧急
    var emergency = window.parent.parent.GetTextByName("Emergency", language);
    //无
    var LangNone = window.parent.parent.GetTextByName("Lang-None", language);
    //执行时间
    var var_Lang_DoTime = window.parent.parent.GetTextByName("Lang_DoTime", language);
    //执行任务数量
    var var_Lang_DoDutyCount = window.parent.parent.GetTextByName("Lang_DoDutyCount", language);
    //今日明细表
    var var_Lang_TodayRecordSelectSheet = window.parent.parent.GetTextByName("Lang_TodayRecordSelectSheet", language);
    //历史记录查询表
    var var_Lang_HistoryRecordSelectSheet = window.parent.parent.GetTextByName("Lang_HistoryRecordSelectSheet", language);
    //汇总
    var var_Lang_HZRW = window.parent.parent.GetTextByName("Lang_HZRW", language);
    //详细
    var var_Lang_XXRW = window.parent.parent.GetTextByName("Lang_XXRW", language);
    //暂无数据导出
    var var_Lang_nodatetoexport = window.parent.parent.GetTextByName("Lang_nodatetoexport", language);
    //页
    var span_page = window.parent.parent.GetTextByName("Page", language);
    //条
    var span_tiao = window.parent.parent.GetTextByName("Article", language);
    //号码(车牌号，警号等）
    var Lang_CarONOrPoliceNo = window.parent.parent.GetTextByName("Lang_CarONOrPoliceNo", language);
    //终端ID
    var Lang_ZDID = window.parent.parent.GetTextByName("Lang_ZDID", language);
    //当前信息
    var Lang_CurrentInfo = window.parent.parent.GetTextByName("Lang_CurrentInfo", language);
    //执行时间
    var Lang_DoTime = window.parent.parent.GetTextByName("Lang_DoTime", language);
    //执行任务数量
    var Lang_DoDutyCount = window.parent.parent.GetTextByName("Lang_DoDutyCount", language);
    //详细信息
    var Info = window.parent.parent.GetTextByName("Info", language);
    //操作
    var Lang_Operate = window.parent.parent.GetTextByName("Lang_Operate", language);
    //上报次数
    var Lang_RecordTimes = window.parent.parent.GetTextByName("Lang_RecordTimes", language);
    //上报状态
    var Lang_RecordState = window.parent.parent.GetTextByName("Lang_RecordState", language);
    //查询记录显示区
    var Lang_SelectRecordArea = window.parent.parent.GetTextByName("Lang_SelectRecordArea", language);
    var timeCanNotBeEmpty = window.parent.parent.GetTextByName("timeCanNotBeEmpty", language);
    //结束时间不能小于开始时间
    var Lang_end_time_cannot_least_start_time = window.parent.parent.GetTextByName("Lang_end_time_cannot_least_start_time", language);
    var timeCanNotOut30Days = window.parent.parent.GetTextByName("timeCanNotOut30Days", language);
    var Lang_userinfo = window.parent.parent.GetTextByName("Lang_userinfo", language);
    //今日查询
    var hzTab = window.parent.parent.GetTextByName("Lang_TodayQuery", language);
    //历史查询
    var mxTab = window.parent.parent.GetTextByName("Lang_HistoricalQuery", language);
    //终端ID
    var Lang_ZDID = window.parent.parent.GetTextByName("Lang_ZDID", language);
    window.document.getElementById("issi_txt").innerHTML = Lang_ZDID;
    window.document.getElementById("hzTab").innerHTML = hzTab;
    window.document.getElementById("mxTab").innerHTML = mxTab;
    //    大队	终端ID	号码(车牌号）	驻勤单位	上报状态	上报次数
    //    大队	终端ID	号码(车牌号）	驻勤单位	上报状态	执行时间
    window.document.getElementById("span_page").innerHTML = span_page;//页
    window.document.getElementById("span_tiao").innerHTML = span_tiao;//条
    window.document.getElementById("span_page2").innerHTML = span_page;//页
    window.document.getElementById("span_tiao2").innerHTML = span_tiao;//条

    window.document.getElementById("Th15").innerHTML = Lang_CarONOrPoliceNo;//号码(车牌号，警号等）
    window.document.getElementById("Th16").innerHTML = Lang_ZDID;//终端ID
    window.document.getElementById("nowStep").innerHTML = Lang_CurrentInfo;
    window.document.getElementById("doTime").innerHTML = Lang_DoTime;
    window.document.getElementById("doStep").innerHTML = Lang_DoDutyCount;
    window.document.getElementById("Th2").innerHTML = Info;
    window.document.getElementById("Th3").innerHTML = Lang_Operate;

    document.getElementById("wth2").innerHTML = Lang_ZDID;
    document.getElementById("wth3").innerHTML = Lang_CarONOrPoliceNo;
    document.getElementById("wth5").innerHTML = Lang_RecordState;
    document.getElementById("wth6").innerHTML = Lang_RecordTimes;
    document.getElementById("wth7").innerHTML = Lang_userinfo;
    document.getElementById("wth8").innerHTML = Lang_Operate;


    window.document.getElementById("span_hz").innerHTML = window.parent.parent.GetTextByName("Lang_HZRW", language);
    window.document.getElementById("span_xx").innerHTML = window.parent.parent.GetTextByName("Lang_XXRW", language);

    document.getElementById("span_ListTitle").innerHTML = Lang_SelectRecordArea;
    document.getElementById("span_ListTitle_history").innerHTML = Lang_SelectRecordArea;

    document.getElementById("Lang_FirstPage2").innerHTML = window.parent.parent.GetTextByName("Lang_FirstPage", language);
    document.getElementById("Lang_PrePage2").innerHTML = window.parent.parent.GetTextByName("Lang_PrePage", language);
    document.getElementById("Lang_play_next_page2").innerHTML = window.parent.parent.GetTextByName("Lang_play_next_page", language);
    document.getElementById("Lang_LastPage2").innerHTML = window.parent.parent.GetTextByName("Lang_LastPage", language);

    function Divover(str) {
        var div1 = document.getElementById("divClose");
        if (str == "on") { div1.style.backgroundPosition = "66 0"; }
        else { div1.style.backgroundPosition = "0 0"; }
    }
    function closethispage() {
        window.parent.lq_closeANDremovediv('manage_Attendance', 'bgDiv');
    }
    function changeFormatter(date) {
        var y = date.getFullYear();
        var m = date.getMonth() + 1;
        var d = date.getDate();
        return y + "-" + (m < 10 ? ('0' + m) : m) + "-" + (d < 10 ? ('0' + d) : d);
    }
    function myparser(s) {
        if (!s) return new Date();
        var ss = (s.split('-'));
        var y = parseInt(ss[0], 10);
        var m = parseInt(ss[1], 10);
        var d = parseInt(ss[2], 10);
        if (!isNaN(y) && !isNaN(m) && !isNaN(d)) {
            return new Date(y, m - 1, d);
        } else {
            return new Date();
        }
    }



</script>

<script type="text/javascript">
    function tabClick() {
        if ($(this).hasClass('activeTab'))
            return;
        $('.hd ul li').removeClass('activeTab');
        $(this).addClass('activeTab');
        var tabId = $(this).attr('tabId');
        $('#content > div').hide();
        $('#' + tabId).show();
        if (tabId == "content1") {
            //hzDisplay();
        } else if (tabId == "content2") {
            //detDisplay();
        }
    }
    $(document).ready(function () {
        $('.hd ul li').click(tabClick);
        $('#begTime_h').datebox('setValue', changeFormatter(new Date()));//历史检索起始日期缺省值默认为当日
        $('#endTime_h').datebox('setValue', changeFormatter(new Date()));//历史检索结束日期缺省值默认为当日
        $('#begTime_h').datebox('calendar').calendar({//历史检索起始日期不能选今天之后的日期
            validator: function (date) {
                var now = new Date();
                var d1 = new Date(now.getFullYear(), now.getMonth(), now.getDate());
                var d2 = new Date(now.getFullYear(), now.getMonth(), now.getDate());
                //return d1 <= date && date <= d2;
                return date <= d2;

            }
        });
        $('#endTime_h').datebox('calendar').calendar({//历史检索截止日期不能选今天之后的日期
            validator: function (date) {
                var now = new Date();
                var d1 = new Date(now.getFullYear(), now.getMonth(), now.getDate());
                var d2 = new Date(now.getFullYear(), now.getMonth(), now.getDate());
                //return d1 <= date && date <= d2;
                return date <= d2;

            }
        });
        getProcedureList();
    })
    var strProID1 = "";      //今日页面 出车流程ID
    var strProID2 = "";      //历史页面出车流程ID
    var issi = "";//今日issi
    var carno = "";//今日车牌号
    var statues = "";//今日状态
    var begtimes = "";//今日开始时间
    var endtimes = "";//今日结束时间

    var issi_h = "";//历史issi
    var carno_h = "";//历史车牌号
    var statues_h = "";//历史状态
    var begtimes_h = "";//历史开始时间
    var endtimes_h = "";//历史结束时间
    var NameorNo = "";//
    var reserve2Value = "";//
    var EmergencyInfoShowFrom = 0;
    var EmergencyInfoShowFrom2 = 0;
    var pType_reserve1 = ""; //流程类型中的字段1名称，用于传给后台导出excel时，设置相应的列标题，在点击了“查询”按钮后赋值
    var pType_reserve2 = "";
    //时间验证
    function validateDateTime(beginTimeId, endTimeId) {

        var begtime = $("#" + beginTimeId).datebox('getValue');
        var begdate = new Date(begtime.replace(/-/g, "\/"));
        var endtime = $("#" + endTimeId).datebox('getValue');
        var enddate = new Date(endtime.replace(/-/g, "\/"));

        if (begtime == "" || endtime == "") {
            alert(timeCanNotBeEmpty);
            return true;
        }
        if (begtime > endtime) {
            alert(Lang_end_time_cannot_least_start_time);
            return true;
        }

        var diff = ((enddate) - (begdate));
        var day = diff / 1000 / 60 / 60 / 24
        if (day > 30) {
            alert(timeCanNotOut30Days);
            return true;
        }

        return false;
    }

    //终端选择页面及返回值处理
    var SelectUsers = new Array();
    function OnAddMember() {
        //window.parent.mycallfunction('AddPrivateCallMember/add_Member', 635, 514, '0&ifr=PrivateCall_ifr&issi=' + $("#txtISSIText").val().trim(), 2001);
        window.parent.mycallfunction('AddMemberTree/add_Member', 650, 514, '0&ifr=manage_Attendance_ifr&selectcount=1&type=user&selfclose=1', 2001);
    }
    function faterdo(retrunissis) {
        // window.parent.hiddenbg2();
        if (retrunissis.length > 0) {
            window.document.getElementById("txt_ISSI").value = retrunissis[0].uissi;

        }
    }
    //历史统计查询按钮图片
    var Lang_Search22 = window.parent.parent.GetTextByName("Lang_Search2", language);
    var Lang_Search2_un = window.parent.parent.GetTextByName("Lang_Search2_un", language);
    var Lang_Search2 = window.document.getElementById("Lang_Search2");
    Lang_Search2.onmousedown = function () {
        Lang_Search2.src = Lang_Search2_un;
    }
    Lang_Search2.onmouseup = function () {
        Lang_Search2.src = Lang_Search22;
    }
    //终端选择按钮图片
    var image = window.document.getElementById("imgSelectISSI");
    var srouce = window.parent.parent.GetTextByName("Lang_chooseMemberPNG", language);
    image.setAttribute("src", srouce);
    var strpath = window.parent.parent.GetTextByName("Lang_chooseMemberPNG", language);
    var strpathmove = window.parent.parent.GetTextByName("Lang_chooseMemberPNG_un", language);
    image.onmouseover = function () { this.src = strpathmove }
    image.onmouseout = function () { this.src = strpath }

    /***从后台获取流程数据***/
    function getProcedureList() {
        window.parent.jquerygetNewData_ajax("../../Handlers/StatuesManage/GetProcedureListService.ashx", "", function (msg) {
            if (msg) {
                var myarray = eval(msg);
                window.document.getElementById("btn_Fresh_Total").style.display = "inline";
                sel_WorkFlowSetData(myarray, "sel_WorkFlow");
                sel_WorkFlowSetData(myarray, "sel_WorkFlow2");
                window.document.getElementById("Lang_Search2").style.display = "inline";
            }
        })
    }
    /**根据下拉列表ID给流程下拉列表赋值**/
    function sel_WorkFlowSetData(myarray, elementID) {
        var selWorkFlow = document.getElementById(elementID);
        selWorkFlow.length = 0;

        var optionf = document.createElement("option");
        optionf.value = "";
        optionf.id = "Lang_all_searchoption_" + elementID;
        optionf.innerHTML = window.parent.parent.GetTextByName("Lang_all_searchoption", language);
        selWorkFlow.appendChild(optionf);
        selWorkFlow.style.display = "none";
        for (var pli = 0; pli < myarray.length; pli++) {
            var option = document.createElement("option");
            option.value = myarray[pli].id;
            option.innerHTML = myarray[pli].name;
            selWorkFlow.appendChild(option);

        }
        selWorkFlow.style.display = "inline";

    }

    //今日统计选择流程改变时触发
    var cuttrntPInfo1;
    function onRecChange1(obj) {
        window.parent.jquerygetNewData_ajax("../../Handlers/StatuesManage/GetProceTypeServices.ashx", { procedure_id: obj.value }, function (msg) {
            var myarray = eval(msg);
            cuttrntPInfo1 = myarray;

        })
        getStepByProID1(obj.value);

    }
    //历史统计选择流程改变时触发
    var cuttrntPInfo2;
    function onRecChange2(obj) {
        span_reserve2.style.display = "none";
        window.document.getElementById("txt_reserve2").style.display = "none";
        window.document.getElementById("txt_reserve2").value = "";
        window.parent.jquerygetNewData_ajax("../../Handlers/StatuesManage/GetProceTypeServices.ashx", { procedure_id: obj.value }, function (msg) {
            var myarray = eval(msg);
            cuttrntPInfo2 = myarray;
            for (var pli = 0; pli < myarray.length; pli++) {

                if (myarray[pli].reserve2.toString() != "") {
                    document.getElementById("span_reserve2").innerHTML = myarray[pli].reserve2;
                    span_reserve2.style.display = "inline";
                    window.document.getElementById("txt_reserve2").style.display = "inline";
                }
            }
        })
        getStepByProID2(obj.value);
    }
    var stepList1 = new Array();
    /***根据流程id获取流程步骤，生成历史检索条件的状态选择列表****/
    function getStepByProID1(proid) {
        window.parent.jquerygetNewData_ajax("../../Handlers/StatuesManage/GetStepByProIDService.ashx", { procedure_id: proid }, function (msg) {
            var myarray = eval(msg);
            stepList1 = myarray;

        });
    }
    var step_first = "";
    var step_last = "";
    var stepList = new Array();
    /***根据流程id获取流程步骤，生成历史检索条件的状态选择列表****/
    function getStepByProID2(proid) {
        window.parent.jquerygetNewData_ajax("../../Handlers/StatuesManage/GetStepByProIDService.ashx", { procedure_id: proid }, function (msg) {
            var myarray = eval(msg);
            stepList = myarray;
            var sel_Statues = document.getElementById("sel_Statues");
            sel_Statues.length = 0;
            var optionf = document.createElement("option");
            optionf.value = "";
            optionf.id = "Lang_Log_All";
            optionf.innerHTML = window.parent.parent.GetTextByName("Lang_Log_All", language);
            sel_Statues.appendChild(optionf);
            if (myarray.length <= 0) {
                return;
            }
            if (myarray.length > 0) {
                var optionun = document.createElement("option");
                optionun.value = -1;
                optionun.innerHTML = Iang_UnUp;
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
    /***历史查询页面，点击查询 执行的*******/
    var checkrad2hz;//历史查询 汇总true 明细 false
    function searchList() {
        isck = false;
        strProID2 = document.getElementById("sel_WorkFlow2").value;
        if (document.getElementById("sel_WorkFlow2").value == "") {
            alert(window.parent.parent.GetTextByName("Lang_PleaseSelectLC", language));
            return;
        }
        if (document.getElementById("Radio1").checked) {
            checkrad2hz = true;
        } else {
            checkrad2hz = false;
        }
        if (validateDateTime('begTime_h', 'endTime_h')) {
            return;
        }
        begtimes_h = $("#begTime_h").datebox('getValue');
        endtimes_h = $("#endTime_h").datebox('getValue');
        issi_h = document.getElementById("txt_ISSI").value;
        carno_h = document.getElementById("txt_NO").value;
        statues_h = document.getElementById("sel_Statues").value;
        NameorNo = document.getElementById("sel_NameorNo").value;
        reserve2Value = document.getElementById("txt_reserve2").value;
        currentPage2 = 1;
        EmergencyInfoShowFrom2 = 0;
        getData2();
    }

    var isck = false;
    var countdivlist = new Array();
    //刷新按钮执行函数
    function fleshList() {

        // window.parent.parent.SMSMsg(123456, 3, '紧急', 0, "");
        strProID1 = document.getElementById("sel_WorkFlow").value;
        if (document.getElementById("sel_WorkFlow").value == "") {
            alert(window.parent.parent.GetTextByName("Lang_PleaseSelectLC", language));
            return;
        }
        isck = false;

        issi = "";
        carno = "";
        statues = "";
        currentPage1 = 1;
        EmergencyInfoShowFrom = 0;
        getCount();
        getDataForTodayHZ();
        fcount = freshtimes;
        myfreshFun();
    }
    function myfreshFun() {
        document.getElementById("span_freshtime").innerHTML = var_Lang_lixcsxsj + "<font color=\"red\">" + fcount + "</font>" + var_Sencond;
        if (fcount == 0) {
            getCount();
            fcount = freshtimes;
        } else {
            fcount--;
        }
        clearTimeout(p);
        p = setTimeout(myfreshFun, 1000);
    }
    var p = "";
    var freshtimes = 600;
    var fcount = freshtimes;
    var Iang_UnUp = window.parent.parent.GetTextByName("Lang_UnUP", language);
    var Lang_alltotalcount = window.parent.parent.GetTextByName("Lang_alltotalcount", language);
    function getCount() {
        document.getElementById("span_freshtime").innerHTML = var_Lang_systemiscounting;
        window.parent.jquerygetNewData_ajax("../../Handlers/StatuesManage/GetDutyCountServices.ashx", { proid: strProID1 }, function (msg) {
            var myarray = eval(msg);
            //if (myarray.toString() == pary.toString()) {
            //    //return;
            //}
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
            var colNo = stepList1.length + 3;
            var height = 0;
            var tr_height = (stepList1.length - 1) * 25;
            if (colNo < 7) {
                var p = parseFloat(160 / colNo);
                col_height = "style='height:" + p + "px'";
                height = p;
                tr_height = (stepList1.length - 1) * height;
            }
            var totalcounts = 0;
            var content = "";
            $("#tb_count").html("");  // //modify by zhanq 2017-09-15 英文版每点击"refresh"汇总栏就多一行"not compeleted"的问题
            //未上报------行
            content += "<tr " + col_height + " id='" + Iang_UnUp +
                "' style='background-color:White;'><td align='left'>" + Iang_UnUp +
                "</td><td style=''  align='center' id='tc_wsb'>0</td><td align='center'><input type=\"button\"   onclick=\"ck('-1')\" value=\"" +
                var_Lang_ToLook + "\" /></td></tr>";
            countdivlist.push(Iang_UnUp);
            //全天未结束-----栏
            content += "<tr height='" + tr_height + "px' width='400px' id='" +
            todayNotOver + "'><td colSpan='3'><table><tr><td width='120px' height='100%'>" +
            todayNotOver + "</td><td width='280px' height='100%'><table id='notOver' cellspacing=\"1\" cellpadding=\"0\" "
            + "style=\"background-color: #C0DE98; border-color: White; border-width: 0px; border-style: Ridge; width: 280px;\">";

            //countdivlist.push(todayNotOver);
            //流程步骤-----行
            for (var i = 0; i < stepList1.length; i++) {
                if (stepList1[i].name != "" && stepList1[i].markId != 127) {
                    content += "<tr " + col_height + " width='275px' style='' id='" + stepList1[i].name +
                        "' style='background-color:White;'><td width='120px' align='left'>" + stepList1[i].name +
                        "</td><td style='' width='60px' align='center' id='tc_" + stepList1[i].name +
                        "'>0</td><td  width='100px' align='center'><input type=\"button\" onclick=\"ck('" + stepList1[i].name + "')\" value=\"" +
                        var_Lang_ToLook + "\" /></td></tr>";
                    countdivlist.push(stepList1[i].name);
                }
            }
            content += "</table></td></tr></table></td></tr>";
            //全天结束------行
            content += "<tr " + col_height + " style='' id='" + todayIsOver + "' style='background-color:White;'><td   align='left'>" +
                todayIsOver + "</td><td style='' align='center' id='tc_" +
                todayIsOver + "'>0</td><td align='center'><input type=\"button\"   onclick=\"ck('" +
                todayIsOver + "')\" value=\"" + var_Lang_ToLook + "\" /></td></tr>";
            countdivlist.push(todayIsOver);
            //合计------行
            content += "<tr " + col_height + " id='" + Lang_alltotalcount +
                "' style='background-color:White;'><td   align='left'><font style=\"\" color=\"blue\">" +
                Lang_alltotalcount +
                "</font></td><td style=''  align='center'><font style=\"\" id='tc_total' color=\"blue\">" +
                totalcounts + "</font></td><td align='center'></td></tr>";
            countdivlist.push(Lang_alltotalcount);
            //紧急-------行
            content += "<tr " + col_height + "' style='background-color:White;' id='" + emergency +
                "'><td align='left'><font style=\"\" color=\"red\">" + emergency +
                "</font></td><td style='' align='center'><font style=\"\" color=\"red\" id='tc_" +
                emergency + "'>0</font></td><td align='center'><input type=\"button\"   onclick=\"ck('" + emergency + "')\" value=\"" +
                var_Lang_ToLook + "\" /></td></tr>";
            countdivlist.push(emergency);
            $("#tb_count").append(content);
            // pary = myarray;
            for (var k = 0; k < myarray.length; k++) {
                totalcounts += parseInt(myarray[k].count);
                if (myarray[k].stepName != "") {
                    if (document.getElementById("tc_" + myarray[k].stepName)) {
                        document.getElementById("tc_" + myarray[k].stepName).innerHTML = myarray[k].count;
                    }
                } else {
                    document.getElementById("tc_wsb" + myarray[k].stepName).innerHTML = myarray[k].count;
                    myarray[k].stepName = Iang_UnUp;
                }
            }
            document.getElementById("tc_total").innerHTML = totalcounts;
            var time = new Date();
            var begsTime = time.getFullYear() + "-" + (time.getMonth() + 1) + "-" + time.getDate();
            var endsTime = time.getFullYear() + "-" + (time.getMonth() + 1) + "-" + time.getDate();
            window.parent.jquerygetNewData_ajax("../../Handlers/StatuesManage/GetPPCSMS.ashx",
                { begTime: begtimes, endTime: endtimes, need: "Count", proid: strProID1, issi: issi, carno: carno },
                function (msgEmergency) {
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
    function ck(title) {
        isck = true;
        statues = title;
        issi = "";
        carno = "";
        var date_s = new Date();
        begtimes = date_s.getFullYear() + "-" + (date_s.getMonth() + 1) + "-" + date_s.getDate();
        endtimes = date_s.getFullYear() + "-" + (date_s.getMonth() + 1) + "-" + date_s.getDate();
        currentPage1 = 1;
        EmergencyInfoShowFrom = 0;
        document.getElementById("doTime").innerHTML = "<span>" + var_Lang_DoTime + "</span>";
        document.getElementById("doStep").innerHTML = var_Lang_DoDutyCount;
        document.getElementById("span_ListTitle").innerHTML = var_Lang_TodayRecordSelectSheet;
        getDataForTodaySearch();
        if (title.toString() != "-1") {
            //document.getElementById("span_ListTitle").innerHTML = "当前状态列表(今日" + title + ")";
            document.getElementById("span_ListTitle").innerHTML = var_Lang_TodayRecordSelectSheet + "——" + title;
        } else {
            document.getElementById("span_ListTitle").innerHTML = var_Lang_TodayRecordSelectSheet + "——" + Iang_UnUp;
            //document.getElementById("span_ListTitle").innerHTML = "当前状态列表(今日正处于" +
            //Iang_UnUp + "状态)";
        }
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
    function getChat(arrdata) {

        var chart;
        var title = window.parent.parent.GetTextByName("Lang_ZTTJT", language);
        var x_Data = [window.parent.parent.GetTextByName("Lang_StatueRW", language)];
        var y_title = window.parent.parent.GetTextByName("Lang_DWT", language);
        //var colors = ["#4572A7", "#AA4643", "#89A54E", "#80699B", "#3D96AE", "#DB843D", "#92A8CD", "#A47D7C", "#B5CA92"];
        var colors = ["#D3D3D3", "#90EE90", "#0000FF", "#FFA500", "#FFFFE0", "#FF0000", "#92A8CD", "#A47D7C", "#B5CA92"];

        var date_column = [];
        var date_pie = [];
        var totalcounts = 0;
        for (var k = 0; k < countdivlist.length; k++) {
            if (countdivlist[k] != window.parent.parent.GetTextByName("Lang_alltotalcount", language)) {
                //var counts = 0.5;
                //var counts2 = 0.1;
                //modify by zhanq 2016-05-4,显示0.5个手台的问题
                var counts = 0;
                var counts2 = 0;
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


        chart = new Highcharts.Chart('chart_combo',{
            chart: {
                //renderTo: 'chart_combo' //关联页面元素div#id
            },

            title: {  //图表标题
                text: title
            },

            xAxis: { //x轴
                categories: x_Data,  //X轴类别
                labels: { y: 18 }  //x轴标签位置：距X轴下方18像素
            },
            yAxis: {  //y轴

                minPadding: 0,
                tickInterval: 10, // 刻度值  
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
                            var pss = (parseFloat(this.y) / totalcounts) * 100;

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
    function getEmergencyShowFromNum2(produceDataLength, msgEmergency, isHZ) {
        if (produceDataLength > 0)
        { EmergencyInfoShowFrom2 = 0; }
        else
        {
            var tempISSI = -1;
            var effectNum = 0;
            for (var i = EmergencyInfoShowFrom2; i < msgEmergency.data.length; i++) {
                if (tempISSI == msgEmergency.data[i].SendISSI) {
                    continue;
                }
                else {
                    tempISSI = msgEmergency.data[i].SendISSI;
                    effectNum++;
                }
            }
            if (totalCounts2 - effectNum == (currentPage2 - 1) * everypagecount2) {
                EmergencyInfoShowFrom2 = 0;//页面当前显示的紧急数据条数。
            }
            else {
                if (isHZ) {
                    var num = (currentPage2 - 1) * everypagecount2 - (totalCounts2 - effectNum);
                    for (var i = 0; i < msgEmergency.data.length; i++) {
                        if (tempISSI == msgEmergency.data[i].SendISSI)
                        { continue; } else { nowNum2++; }
                        if (nowNum2 >= num)
                        { EmergencyInfoShowFrom2 = i; break; }
                    }
                } else {
                    //  EmergencyInfoShowFrom2 = (currentPage2 - 1) * everypagecount2 - (totalCounts2 - msgEmergency.data.length);
                }
            }
        }
    }
    function getEmergencyShowFromNum(produceDataLength, msgEmergency, isHZ) {
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
            if (totalCounts1 - effectNum == (currentPage1 - 1) * everypagecount1)
            { EmergencyInfoShowFrom = 0; }
            else {
                if (isHZ) {
                    var num = (currentPage1 - 1) * everypagecount1 - (totalCounts1 - effectNum);
                    for (var i = 0; i < msgEmergency.data.length; i++) {
                        if (tempISSI == msgEmergency.data[i].SendISSI)
                        { continue; } else { nowNum++; }
                        if (nowNum >= num)
                        { EmergencyInfoShowFrom = i; break; }
                    }
                } else {
                    EmergencyInfoShowFrom = (currentPage1 - 1) * everypagecount1 - (totalCounts1 - msgEmergency.data.length);
                }
            }
        }
    }

    //类型0代表汇总，1代表详细,2代表详细未上报时,任务ID-1代表未上报,流程ID-1代表未上报
    //o_type ============ "Emergency0" 汇总统计紧急状态时、今日查看紧急状态时，查看详细信息；
    //                    "Emergency1" h明细统计紧急时，查看详细信息
    //                    "0" 今日汇总查看时，查看详细信息
    //id ============ j紧急时 为 sql语句，今日汇总时为duty_record.id
    function openDetail(o_type, id, todayOrHistory) {
        var begin = begtimes;
        var end = endtimes;

        if (todayOrHistory == "1") {
            begin = begtimes;
            end = endtimes;
        } else if (todayOrHistory == "2") {
            begin = begtimes_h;
            end = endtimes_h;
        }
        if (o_type.indexOf("Emergency") >= 0) {//“紧急”状态详情查看
            var sql = "";
            if (o_type.indexOf("0") >= 0)//汇总  o_type ="Emergency0"表示汇总列表中紧急查看
            {
                sql += "select d.reserve1 as r1, b.reserve1 as rc1, d.reserve2 as r2, b.reserve2 as rc2, " +
                    "c.name as proname, b.issi as issi, b.name as uname, b.num as num, e.Name as entityname, a.RevISSI as stepName, a.SendTime as begintime";
                sql += " from SMS_Info a";
                sql += " left join user_duty b on a.SendISSI=b.issi";
                sql += " left join _procedure c on b.procedure_id=c.id";
                sql += " left join procedure_type d on(d.name=c.pType)"
                sql += " left join Entity e on (b.entityID=e.ID)"
                sql += " where a.RevISSI='Emergency' and a.SendTime >='" + begin + " 00:00:00" + "' and a.SendTime <= '" + end + " 23:59:59" + "' and a.SendISSI=" + id;
            }
            else {////明细  o_type ="Emergency1"表示明细列表中紧急查看
                sql += "select d.reserve1 as r1, b.reserve1 as rc1, d.reserve2 as r2, b.reserve2 as rc2, c.name as proname," +
                    " b.issi as issi, b.name as uname, b.num as num, e.Name as entityname, a.RevISSI as stepName, a.SendTime as begintime";
                sql += " from SMS_Info a";
                sql += " left join user_duty b on a.SendISSI=b.issi";
                sql += " left join _procedure c on b.procedure_id=c.id";
                sql += " left join procedure_type d on(d.name=c.pType)"
                sql += " left join Entity e on (b.entityID=e.ID)"
                sql += " where a.RevISSI='Emergency' and a.SendTime >='" + begin + " 00:00:00" + "' and a.SendTime <= '" + end + " 23:59:59" + "' and a.ID=" + id;
            }
            id = sql;
        }

        window.parent.mycallfunction('view_info/view_CarDuty', 650, 350, id + '&type=' + o_type + '&begtime=' + begin + '&endtime=' + end);
    }
    //右键菜单
    function toShowMenu(issi, myuid) {
        window.parent.car_duty_issi_selected = issi;
        window.parent.car_duty_uid_selected = myuid;
        MouseMenu_onclick(window.parent, "carDutyMenu");
    }
    //今日明细搜索，根据状态搜索明细列表
    //今日统计页面变量
    var arrayISSI1 = new Array();
    var everypagecount1 = 5;
    var currentPage1 = 1;
    var totalPage1 = 1;
    var totalCounts1 = 0;
    //历史统计页面变量
    var arrayISSI2 = new Array();
    var everypagecount2 = 10;
    var currentPage2 = 1;
    var totalPage2 = 1;
    var totalCounts2 = 0;

    function getDataForTodayHZ() {

        document.getElementById("nowStep").style.display = "";
        document.getElementById("th_reserve1").style.display = "none";
        document.getElementById("th_reserve2").style.display = "none";
        // document.getElementById("thppp").colSpan = "9";
        document.getElementById("span_ListTitle").innerHTML = var_Lang_TodayRecordSelectSheet;
        for (var pli = 0; pli < cuttrntPInfo1.length; pli++) {
            if (cuttrntPInfo1[pli].reserve1.toString() != "") {
                document.getElementById("th_reserve1").style.display = "";
                document.getElementById("th_reserve1").innerHTML = cuttrntPInfo1[pli].reserve1;
            }
            if (cuttrntPInfo1[pli].reserve2.toString() != "") {
                document.getElementById("th_reserve2").style.display = "";
                document.getElementById("th_reserve2").innerHTML = cuttrntPInfo1[pli].reserve2;
            }

        }
        var selissiorname = "";
        var selStatues = "";
        for (var i = 0; i < arrayISSI1.length; i++) {
            $("#" + arrayISSI1[i]).remove();
        }
        $("#isprocessing").remove();
        $("#Tbody1").append("<tr id='isprocessing' style='background-color:White;height:22px;color:red'><td colspan='9' >" +
            Lang_loading + "</td></tr>");
        var date_s = new Date();
        begtimes = date_s.getFullYear() + "-" + (date_s.getMonth() + 1) + "-" + date_s.getDate();
        endtimes = date_s.getFullYear() + "-" + (date_s.getMonth() + 1) + "-" + date_s.getDate();
        window.parent.jquerygetNewData_ajax("../../Handlers/StatuesManage/getTodayDutyRecordsService.ashx",
            { PageIndex: currentPage1, Limit: everypagecount1, proid: strProID1 },
            function (msg) {
                window.parent.jquerygetNewData_ajax("../../Handlers/StatuesManage/GetPPCSMS.ashx",
                    { begTime: begtimes, endTime: endtimes, need: "Data", proid: strProID1, issi: issi, carno: carno },
                    function (msgEmergency) {
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
                        totalCounts1 = parseInt(msg.totalcount) + arrMy.length;
                        reroadpagetitle();
                        for (var i = 0; i < arrayISSI1.length; i++) {
                            $("#" + arrayISSI1[i]).remove();
                        }
                        arrayISSI1.length = 0;
                        var dotime = "";
                        if (msg.data.length == 0) {
                            $("#Tbody1").append("<tr id='isprocessing' style='background-color:White;height:22px;color:red'><td colspan='9' >" +
                                LangNone + "</td></tr>");
                        }

                        for (var i = 0; i < msg.data.length; i++) {
                            var chuc = "<span color='red'>" + Iang_UnUp + "</span>";
                            var td_r1 = "";
                            var td_r2 = "";
                            if (msg.data[i].nowstepName != "") {
                                chuc = msg.data[i].nowstepName;
                                dotime = msg.data[i].ctime;
                            } else {
                                //  v_begtime = "";
                                // dotime = msg.data[i].beginTime;
                            }
                            var s_detal = "";
                            if (msg.data[i].d_id != "") {
                                s_detal = "<span style=\"cursor:pointer;text-decoration:underline;\" onclick=\"openDetail('0','" +
                                    msg.data[i].d_id + "','1')\">" + xxxx + "</span>";
                            }
                            if (document.getElementById("th_reserve1").style.display == "none") {
                                td_r1 = "";
                            } else {
                                td_r1 = "<td align='center'>" + msg.data[i].reserve1 + "</td>"
                            }
                            if (document.getElementById("th_reserve2").style.display == "none") {
                                td_r2 = "";
                            } else {
                                td_r2 = "<td align='center'>" + msg.data[i].reserve2 + "</td>"
                            }
                            $("#Tbody1").append("<tr id=" + i +
                                " onmouseover='changeTgBg(this,&#39;font&#39;)' onmouseout='overchangeTgBg(this,&#39;font&#39;)' style='background-color:White;height:22px;'>" +
                                td_r1 + "<td  align='center'>" +
                                msg.data[i].num + "</td><td style='' align='center'>" +
                                msg.data[i].issi + "</td>" +
                                td_r2 + "<td style='' align='center' >" +
                                chuc + "</td><td style='' align='center' >" +
                                msg.data[i].ctime + "</td><td style='' align='center' >" +
                                msg.data[i].cnt + "</td><td style='' align='center' >" +
                                s_detal + "</td><td align='center'><img onclick='toShowMenu(" +
                                msg.data[i].issi + "," + msg.data[i].myuid + ")' src='../img/treebutton2.gif'/></td></tr>");
                            arrayISSI1.push(i);
                        }
                        if (msg.data.length >= everypagecount1)
                        { return; }
                        var msgCount = msg.data.length;
                        if (msgEmergency.data.length == 0)
                        { return; }
                        if (msg.data.length == 0)
                        { $("#isprocessing").remove(); }
                        var tempISSI = -1;
                        var nowNum = 0;
                        getEmergencyShowFromNum(msg.data.length, msgEmergency, true);

                        for (var i = EmergencyInfoShowFrom; i < msgEmergency.data.length; i++) {
                            var td_r1 = "";
                            var td_r2 = "";
                            if (tempISSI == msgEmergency.data[i].SendISSI)
                            { continue; } else {
                                if (msgCount + nowNum >= everypagecount1) {
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
                                s_detal = "<span style=\"cursor:pointer;text-decoration:underline;\" onclick=\"openDetail('Emergency0','" +
                                    msgEmergency.data[i].SendISSI + "','1')\">" + xxxx + "</span>";
                            }
                            if (document.getElementById("th_reserve1").style.display == "none") {
                                td_r1 = "";
                            } else {
                                td_r1 = "<td align='center'>" + msgEmergency.data[i].reserve1 + "</td>"
                            }
                            if (document.getElementById("th_reserve2").style.display == "none") {
                                td_r2 = "";
                            } else {
                                td_r2 = "<td align='center'>" + msgEmergency.data[i].reserve2 + "</td>"
                            }
                            $("#Tbody1").append("<tr id=" +
                                (nowNum + msg.data.length) + " onmouseover='changeTgBg(this,&#39;font&#39;)' onmouseout='overchangeTgBg(this,&#39;font&#39;)' style='background-color:White;height:22px;'>" +
                                td_r1 + "<td  align='center'>" +
                                msgEmergency.data[i].num + "</td><td style='' align='center'>" +
                                msgEmergency.data[i].issi + "</td>" +
                                td_r2 + "<td style='' align='center' >" +
                                chuc + "</td><td style='' align='center' >" +
                                msgEmergency.data[i].SendTime + "</td><td style='' align='center' >" +
                                count + "</td><td style='' align='center' >" +
                                s_detal + "</td><td align='center'><img onclick='toShowMenu(" +
                                msgEmergency.data[i].issi + "," + msgEmergency.data[i].user_id + ")' src='../img/treebutton2.gif'/></td></tr>");
                            arrayISSI1.push(nowNum + msg.data.length);
                            nowNum++;
                        }
                    });
            });
    }
    function getDataForTodaySearch() {
        document.getElementById("nowStep").style.display = "";
        document.getElementById("th_reserve1").style.display = "none";
        document.getElementById("th_reserve2").style.display = "none";
        for (var pli = 0; pli < cuttrntPInfo1.length; pli++) {
            if (cuttrntPInfo1[pli].reserve1.toString() != "") {
                document.getElementById("th_reserve1").style.display = "";
                document.getElementById("th_reserve1").innerHTML = cuttrntPInfo1[pli].reserve1;
            }
            if (cuttrntPInfo1[pli].reserve2.toString() != "") {
                document.getElementById("th_reserve2").style.display = "";
                document.getElementById("th_reserve2").innerHTML = cuttrntPInfo1[pli].reserve2;
            }

        }
        //    var selissiorname = "";
        //var selfun = 1;//无用
        //var selStatues = "";
        for (var i = 0; i < arrayISSI1.length; i++) {
            $("#" + arrayISSI1[i]).remove();
        }
        $("#isprocessing").remove();
        $("#Tbody1").append("<tr id='isprocessing' style='background-color:White;height:22px;color:red'><td colspan='9' >" +
            Lang_loading + "</td></tr>");
        if (statues == emergency) {
            EmergencyInfoShowFrom = 0;
            window.parent.jquerygetNewData_ajax("../../Handlers/StatuesManage/GetPPCSMS.ashx",
                { begTime: begtimes, endTime: endtimes, need: "Data", proid: strProID1, issi: issi, carno: carno },
                function (msgEmergency) {
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
                    totalCounts1 = arrMy.length;
                    reroadpagetitle();

                    getEmergencyShowFromNum(0, msgEmergency, true);


                    for (var i = 0; i < arrayISSI1.length; i++) {
                        $("#" + arrayISSI1[i]).remove();
                    }
                    arrayISSI1.length = 0;

                    if (msgEmergency.data.length == 0) {
                        $("#Tbody1").append("<tr id='isprocessing' style='background-color:White;height:22px;color:red'><td colspan='9' >" +
                            LangNone + "</td></tr>");
                    }
                    tempISSI = -1;
                    var nowNum = 0;
                    for (var i = EmergencyInfoShowFrom; i < msgEmergency.data.length; i++) {
                        var td_r1 = "";
                        var td_r2 = "";
                        if (tempISSI == msgEmergency.data[i].SendISSI)
                        { continue; } else {
                            if (nowNum >= everypagecount1) {
                                EmergencyInfoShowFrom = i;
                                break;
                            }
                            nowNum++;
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
                            s_detal = "<span style=\"cursor:pointer;text-decoration:underline;\" onclick=\"openDetail('Emergency0','" +
                                msgEmergency.data[i].SendISSI + "','1')\">" + xxxx + "</span>";
                        }
                        if (document.getElementById("th_reserve1").style.display == "none") {
                            td_r1 = "";
                        } else {
                            td_r1 = "<td align='center'>" + msgEmergency.data[i].reserve1 + "</td>"
                        }
                        if (document.getElementById("th_reserve2").style.display == "none") {
                            td_r2 = "";
                        } else {
                            td_r2 = "<td align='center'>" + msgEmergency.data[i].reserve2 + "</td>"
                        }
                        $("#Tbody1").append("<tr id=" + i +
                            " onmouseover='changeTgBg(this,&#39;font&#39;)' onmouseout='overchangeTgBg(this,&#39;font&#39;)' style='background-color:White;height:22px;'>" +
                            td_r1 + "<td  align='center'>" +
                            msgEmergency.data[i].num + "</td><td style='' align='center'>" +
                            msgEmergency.data[i].issi + "</td>" +
                            td_r2 + "<td style='' align='center' >" +
                            chuc + "</td><td style='' align='center' >" +
                            msgEmergency.data[i].SendTime + "</td><td style='' align='center' >" +
                            count + "</td><td style='' align='center' >" +
                            s_detal + "</td><td align='center'><img onclick='toShowMenu(" +
                            msgEmergency.data[i].issi + "," + msgEmergency.data[i].user_id + ")' src='../img/treebutton2.gif'/></td></tr>");
                        arrayISSI1.push(i);
                    }
                });
        }
        else {
            window.parent.jquerygetNewData_ajax("../../Handlers/StatuesManage/getSearchDutyRecordsForDetailService.ashx",
                {
                    type: "0", PageIndex: currentPage1, Limit: everypagecount1, proid: strProID1, issi: issi, carno: carno,
                    statues: statues, begtimes: begtimes, endtimes: endtimes, isCK: isck
                }, function (msg) {
                    $("#isprocessing").remove();
                    totalCounts1 = msg.totalcount;
                    reroadpagetitle();
                    for (var i = 0; i < arrayISSI1.length; i++) {
                        $("#" + arrayISSI1[i]).remove();
                    }
                    arrayISSI1.length = 0;

                    if (msg.data.length == 0) {
                        $("#Tbody1").append("<tr id='isprocessing' style='background-color:White;height:22px;color:red'><td colspan='9' >" +
                            LangNone + "</td></tr>");
                    }

                    for (var i = 0; i < msg.data.length; i++) {
                        var chuc = "<span color='red'>" + Iang_UnUp + "</span>";
                        var td_r1 = "";
                        var td_r2 = "";
                        // var v_begtime = msg.data[i].beginTime;
                        if (msg.data[i].nowstepName != "") {
                            chuc = msg.data[i].nowstepName;
                        } else {
                            //     v_begtime = "";
                        }
                        var s_detal = "";
                        if (msg.data[i].d_id != "") {
                            s_detal = "<span style=\"cursor:pointer;text-decoration:underline;\" onclick=\"openDetail('0','" +
                                msg.data[i].d_id + "','1')\">" + xxxx + "</span>";
                        }
                        if (document.getElementById("th_reserve1").style.display == "none") {
                            td_r1 = "";
                        } else {
                            td_r1 = "<td align='center'>" + msg.data[i].reserve1 + "</td>"
                        }
                        if (document.getElementById("th_reserve2").style.display == "none") {
                            td_r2 = "";
                        } else {
                            td_r2 = "<td align='center'>" + msg.data[i].reserve2 + "</td>"
                        }
                        $("#Tbody1").append("<tr id=" + i +
                            " onmouseover='changeTgBg(this,&#39;font&#39;)' onmouseout='overchangeTgBg(this,&#39;font&#39;)' style='background-color:White;height:22px;'>" +
                            td_r1 + "<td  align='center'>" +
                            msg.data[i].num + "</td><td style='' align='center'>" +
                            msg.data[i].issi + "</td>" +
                            td_r2 + "<td style='' align='center' >" +
                            chuc + "</td><td style='' align='center' >" +
                            msg.data[i].ctime + "</td><td style='' align='center' >" +
                            msg.data[i].cnt + "</td><td style='' align='center' >" +
                            s_detal + "</td><td align='center'><img onclick='toShowMenu(" +
                            msg.data[i].issi + "," + msg.data[i].myuid + ")' src='../img/treebutton2.gif'/></td></tr>");
                        arrayISSI1.push(i);
                    }
                });
        }
    }


    function getDataForSearchHZNew() {
        for (var i = 0; i < arrayISSI2.length; i++) {
            $("#h" + arrayISSI2[i]).remove();
        }
        document.getElementById("th2_reserve1").style.display = "none";
        document.getElementById("th2_reserve2").style.display = "none";
        for (var pli = 0; pli < cuttrntPInfo2.length; pli++) {
            if (cuttrntPInfo2[pli].reserve1.toString() != "") {
                document.getElementById("th2_reserve1").style.display = "block";
                document.getElementById("th2_reserve1").innerHTML = cuttrntPInfo2[pli].reserve1;
            }
            if (cuttrntPInfo2[pli].reserve2.toString() != "") {
                document.getElementById("th2_reserve2").style.display = "";
                document.getElementById("th2_reserve2").innerHTML = cuttrntPInfo2[pli].reserve2;
                document.getElementById("span_reserve2").innerHTML = cuttrntPInfo2[pli].reserve2;
                span_reserve2.style.display = "inline";
                window.document.getElementById("txt_reserve2").style.display = "inline";
            }
        }
        $("#isprocessing").remove();
        $("#Tbody2").append("<tr id='isprocessing' style='background-color:White;height:22px;color:red'><td colspan='9' >" + Lang_loading + "</td></tr>");
        window.parent.jquerygetNewData_ajax("../../Handlers/Duty/getDutyRecordsHistory.ashx",
              {
                  type: "0", PageIndex: currentPage2, Limit: everypagecount2, proid: strProID2, issi: issi_h, carno: carno_h,
                  statues: statues_h, begtimes: begtimes_h, endtimes: endtimes_h,
                  //isCK: isck,
                  nameorNo: NameorNo, reserveValue: reserve2Value
              }, function (msg) {
                  $("#isprocessing").remove();
                  totalCounts2 = msg.totalcount;
                  reroadpagetitle2();
                  for (var i = 0; i < arrayISSI2.length; i++) {
                      $("#h" + arrayISSI2[i]).remove();
                  }
                  arrayISSI2.length = 0;

                  if (msg.data.length == 0) {
                      $("#Tbody2").append("<tr id='isprocessing' style='background-color:White;height:22px;color:red'><td colspan='9' >" +
                          LangNone + "</td></tr>");
                  }
                  for (var i = 0; i < msg.data.length; i++) {
                      //var chuc = "<span color='red'>" + Iang_UnUp + "</span>";
                      var s_detal = "";
                      if (msg.data[i].StepName == emergency) {
                          s_detal = "<span style=\"cursor:pointer;text-decoration:underline;\" onclick=\"openDetail('Emergency0','" +
                                 msg.data[i].issi + "','2')\">" + Lang_userinfo + "</span>";
                      } else {
                          s_detal = "<span style=\"cursor:pointer;text-decoration:underline;\" onclick=\"openDetail('0','" +
                                 msg.data[i].issi + "','2')\">" + Lang_userinfo + "</span>";;
                      }
                      var td_r1 = "";
                      var td_r2 = "";
                      if (document.getElementById("th2_reserve1").style.display == "none") {
                          td_r1 = "";
                      } else {
                          td_r1 = "<td align='center'>" + msg.data[i].reserve1 + "</td>"
                      }
                      if (document.getElementById("th2_reserve2").style.display == "none") {
                          td_r2 = "";
                      } else {
                          td_r2 = "<td align='center'>" + msg.data[i].reserve2 + "</td>"
                      }
                      $("#Tbody2").append("<tr id=h" + i +
                          " onmouseover='changeTgBg(this,&#39;font&#39;)' onmouseout='overchangeTgBg(this,&#39;font&#39;)' style='background-color:White;height:22px;'>" +
                          td_r1 + "<td  align='center'>" +
                          msg.data[i].issi + "</td><td style='' align='center'>" +
                          msg.data[i].num + "</td>" +
                          td_r2 + "<td style='' align='center' >" +
                          msg.data[i].StepName + "</td><td style='' align='center' >" +
                          msg.data[i].cnt + "</td>" +
                         // "<td style='' align='center' >" + s_detal + "</td>"+
                          "<td align='center'><img onclick='toShowMenu(" +
                          msg.data[i].issi + "," + msg.data[i].userID + ")' src='../img/treebutton2.gif'/></td></tr>");

                      arrayISSI2.push(i);
                  }
              });
    }

    function getDataForSearchXX() {
        for (var i = 0; i < arrayISSI2.length; i++) {
            $("#h" + arrayISSI2[i]).remove();
        }
        document.getElementById("th2_reserve1").style.display = "none";
        document.getElementById("th2_reserve2").style.display = "none";
        for (var pli = 0; pli < cuttrntPInfo2.length; pli++) {
            if (cuttrntPInfo2[pli].reserve1.toString() != "") {
                document.getElementById("th2_reserve1").style.display = "block";
                document.getElementById("th2_reserve1").innerHTML = cuttrntPInfo2[pli].reserve1;
            }
            if (cuttrntPInfo2[pli].reserve2.toString() != "") {
                document.getElementById("th2_reserve2").style.display = "";
                document.getElementById("th2_reserve2").innerHTML = cuttrntPInfo2[pli].reserve2;
                document.getElementById("span_reserve2").innerHTML = cuttrntPInfo2[pli].reserve2;
                span_reserve2.style.display = "inline";
                window.document.getElementById("txt_reserve2").style.display = "inline";
            }
        }
        $("#isprocessing").remove();
        $("#Tbody2").append("<tr id='isprocessing' style='background-color:White;height:22px;color:red'><td colspan='9' >" + Lang_loading + "</td></tr>");
        if (statues_h == emergency) {
            window.parent.jquerygetNewData_ajax("../../Handlers/Duty/getEmergencySMS.ashx",
                {
                    begTime: begtimes_h, endTime: endtimes_h, need: "Data", proid: strProID2, issi: issi_h, carno: carno_h,
                    nameorNo: NameorNo, reserveValue: reserve2Value
                },
                function (msgEmergency) {
                    $("#isprocessing").remove();
                    totalCounts2 = msgEmergency.totalcount;
                    reroadpagetitle2();
                    for (var i = 0; i < arrayISSI2.length; i++) {
                        $("#h" + arrayISSI2[i]).remove();
                    }
                    arrayISSI2.length = 0;

                    if (msgEmergency.data.length == 0) {
                        $("#Tbody2").append("<tr id='isprocessing' style='background-color:White;height:22px;color:red'><td colspan='9' >" +
                            LangNone + "</td></tr>");
                    }
                    var nowNum2 = 0;
                    getEmergencyShowFromNum2(0, msgEmergency, false);
                    for (var i = EmergencyInfoShowFrom2; i < msgEmergency.data.length; i++) {
                        if (nowNum2 >= everypagecount2) {
                            EmergencyInfoShowFrom2 = i;
                            break;
                        }
                        nowNum2++;
                        //     var v_begtime = msg.data[i].SendTime;
                        var chuc = emergency;
                        var s_detal = "";
                        if (msgEmergency.data[i].SendISSI != "") {
                            s_detal = "<span style=\"cursor:pointer;text-decoration:underline;\" onclick=\"openDetail('Emergency1','" +
                                msgEmergency.data[i].ID + "','2')\">" +
                                xxxx + "</span>";
                        }
                        var td_r1 = "";
                        var td_r2 = "";
                        if (document.getElementById("th2_reserve1").style.display == "none") {
                            td_r1 = "";
                        } else {
                            td_r1 = "<td align='center'>" + msgEmergency.data[i].reserve1 + "</td>"
                        }
                        if (document.getElementById("th2_reserve2").style.display == "none") {
                            td_r2 = "";
                        } else {
                            td_r2 = "<td align='center'>" + msgEmergency.data[i].reserve2 + "</td>"
                        }
                        $("#Tbody2").append("<tr id=h" + i
                            + " onmouseover='changeTgBg(this,&#39;font&#39;)' onmouseout='overchangeTgBg(this,&#39;font&#39;)' style='background-color:White;height:22px;'>" +
                            td_r1 + "<td  align='center'>" +
                            msgEmergency.data[i].issi + "</td><td style='' align='center'>" +
                            msgEmergency.data[i].num + "</td>" +
                            td_r2 + "<td style='' align='center' >" +
                            chuc + "</td><td style='' align='center' >" +
                            msgEmergency.data[i].SendTime + "</td><td style='display:none' align='center' ></td><td style='' align='center' >" +
                            s_detal + "</td><td align='center'><img onclick='toShowMenu(" + msgEmergency.data[i].issi + "," + msgEmergency.data[i].user_id +
                            ")' src='../img/treebutton2.gif'/></td></tr>");
                        arrayISSI2.push(i);
                    }
                });
        } else if (statues_h == "")   //全选
        {
            window.parent.jquerygetNewData_ajax("../../Handlers/Duty/getDutyRecordsHistory.ashx",
                {
                    type: "1", PageIndex: currentPage2, Limit: everypagecount2, proid: strProID2,
                    issi: issi_h, carno: carno_h, statues: statues_h, begtimes: begtimes_h, endtimes: endtimes_h,
                    // isCK: isck,
                    nameorNo: NameorNo, reserveValue: reserve2Value

                },
                function (msg) {
                    window.parent.jquerygetNewData_ajax("../../Handlers/Duty/getEmergencySMS.ashx",
                        {
                            begTime: begtimes_h, endTime: endtimes_h, need: "Data", proid: strProID2, issi: issi_h, carno: carno_h,
                            nameorNo: NameorNo, reserveValue: reserve2Value
                        },
                        function (msgEmergency) {
                            $("#isprocessing").remove();

                            totalCounts2 = parseInt(msg.totalcount) + parseInt(msgEmergency.totalcount);
                            reroadpagetitle2();
                            for (var i = 0; i < arrayISSI2.length; i++) {
                                $("#h" + arrayISSI2[i]).remove();
                            }
                            arrayISSI2.length = 0;

                            if (msg.data.length == 0) {
                                $("#Tbody2").append("<tr id='isprocessing' style='background-color:White;height:22px;color:red'><td colspan='9' >" +
                                    LangNone + "</td></tr>");
                            }

                            for (var i = 0; i < msg.data.length; i++) {
                                var chuc = "<span color='red'>" + Iang_UnUp + "</span>";
                                var s_detal = "";
                                if (msg.data[i].stepName != "") {
                                    chuc = msg.data[i].stepName;
                                    if (msg.data[i].s_id != "") {
                                        s_detal = "<span style=\"cursor:pointer;text-decoration:underline;\" onclick=\"openDetail('1','" +
                                            msg.data[i].s_id + "','2')\">" + xxxx + "</span>";
                                    }
                                } else {
                                    if (msg.data[i].d_id != "") {
                                        s_detal = "<span style=\"cursor:pointer;text-decoration:underline;\" onclick=\"openDetail('2','" +
                                            msg.data[i].d_id + "','2')\">" + xxxx + "</span>";
                                    }
                                }
                                var td_r1 = "";
                                var td_r2 = "";
                                if (document.getElementById("th2_reserve1").style.display == "none") {
                                    td_r1 = "";
                                } else {
                                    td_r1 = "<td align='center'>" + msg.data[i].reserve1 + "</td>"
                                }
                                if (document.getElementById("th2_reserve2").style.display == "none") {
                                    td_r2 = "";
                                } else {
                                    td_r2 = "<td align='center'>" + msg.data[i].reserve2 + "</td>"
                                }
                                $("#Tbody2").append("<tr id=h" + i +
                                    " onmouseover='changeTgBg(this,&#39;font&#39;)' onmouseout='overchangeTgBg(this,&#39;font&#39;)' style='background-color:White;height:22px;'>" +
                                    td_r1 + "<td  align='center'>" +
                                    msg.data[i].issi + "</td><td style='' align='center'>" +
                                    msg.data[i].num + "</td>" +
                                    td_r2 + "<td style='' align='center' >" +
                                    chuc + "</td><td style='' align='center' >" +
                                    msg.data[i].changeTime + "</td><td style='' align='center' >" +
                                    s_detal + "</td><td align='center'><img onclick='toShowMenu(" +
                                    msg.data[i].issi + "," + msg.data[i].myuid + ")' src='../img/treebutton2.gif'/></td></tr>");
                                arrayISSI2.push(i);
                            }

                            var msgCount = msg.data.length;
                            if (msgEmergency.data.length == 0)
                            { return; }
                            if (msg.data.length == 0)
                            { $("#isprocessing").remove(); }
                            var nowNum2 = 0;
                            getEmergencyShowFromNum2(msgCount, msgEmergency, false);
                            //if (msg.data.length <= everypagecount && msg.data.length > 0) 
                            //{ EmergencyInfoShowFrom = 0;}
                            for (var i = EmergencyInfoShowFrom2; i < msgEmergency.data.length; i++) {
                                if (msgCount + nowNum2 >= everypagecount2) {
                                    EmergencyInfoShowFrom2 = i;
                                    return;
                                }
                                var chuc = emergency;
                                var s_detal = "";
                                if (msgEmergency.data[i].SendISSI != "") {
                                    s_detal = "<span style=\"cursor:pointer;text-decoration:underline;\" onclick=\"openDetail('Emergency1','" +
                                        msgEmergency.data[i].ID + "','2')\">" + xxxx + "</span>";
                                }
                                var td_r1 = "";
                                var td_r2 = "";
                                if (document.getElementById("th2_reserve1").style.display == "none") {
                                    td_r1 = "";
                                } else {
                                    td_r1 = "<td align='center'>" + msgEmergency.data[i].reserve1 + "</td>"
                                }
                                if (document.getElementById("th2_reserve2").style.display == "none") {
                                    td_r2 = "";
                                } else {
                                    td_r2 = "<td align='center'>" + msgEmergency.data[i].reserve2 + "</td>"
                                }
                                $("#Tbody2").append("<tr id=h" + (nowNum2 + msgCount) +
                                    " onmouseover='changeTgBg(this,&#39;font&#39;)' onmouseout='overchangeTgBg(this,&#39;font&#39;)' style='background-color:White;height:22px;'>" +
                                    td_r1 + "<td  align='center'>" +
                                    msgEmergency.data[i].num + "</td><td style='' align='center'>" +
                                    msgEmergency.data[i].issi + "</td>" +
                                    td_r2 + "<td style='' align='center' >" +
                                    chuc + "</td><td style='' align='center' >" +
                                    msgEmergency.data[i].SendTime + "</td><td style='display:none' align='center' ></td><td style='' align='center' >" +
                                    s_detal + "</td><td align='center'><img onclick='toShowMenu(" +
                                    msgEmergency.data[i].issi + "," + msgEmergency.data[i].user_id + ")' src='../img/treebutton2.gif'/></td></tr>");
                                arrayISSI2.push(nowNum2 + msgCount);
                                nowNum2++;
                            }
                        });
                });
        }
        else {
            window.parent.jquerygetNewData_ajax("../../Handlers/Duty/getDutyRecordsHistory.ashx",
                {
                    type: "1", PageIndex: currentPage2, Limit: everypagecount2, proid: strProID2, issi: issi_h, carno: carno_h,
                    statues: statues_h, begtimes: begtimes_h, endtimes: endtimes_h,
                    //  isCK: isck,
                    nameorNo: NameorNo, reserveValue: reserve2Value
                }, function (msg) {
                    $("#isprocessing").remove();


                    totalCounts2 = msg.totalcount;
                    reroadpagetitle2();
                    for (var i = 0; i < arrayISSI2.length; i++) {
                        $("#h" + arrayISSI2[i]).remove();
                    }
                    arrayISSI2.length = 0;

                    if (msg.data.length == 0) {
                        $("#Tbody2").append("<tr id='isprocessing' style='background-color:White;height:22px;color:red'><td colspan='9' >" +
                            LangNone + "</td></tr>");
                    }

                    for (var i = 0; i < msg.data.length; i++) {
                        var chuc = "<span color='red'>" + window.parent.parent.GetTextByName("Lang_UnUP", language) + "</span>";
                        var s_detal = "";
                        if (msg.data[i].stepName != "") {
                            chuc = msg.data[i].stepName;
                            if (msg.data[i].s_id != "") {
                                s_detal = "<span style=\"cursor:pointer;text-decoration:underline;\" onclick=\"openDetail('1','" +
                                    msg.data[i].s_id + "','2')\">" + xxxx + "</span>";
                            }
                        } else {
                            if (msg.data[i].d_id != "") {
                                s_detal = "<span style=\"cursor:pointer;text-decoration:underline;\" onclick=\"openDetail('2','" +
                                    msg.data[i].d_id + "','2')\">" + xxxx + "</span>";
                            }
                        }
                        var td_r1 = "";
                        var td_r2 = "";
                        if (document.getElementById("th2_reserve1").style.display == "none") {
                            td_r1 = "";
                        } else {
                            td_r1 = "<td align='center'>" + msg.data[i].reserve1 + "</td>"
                        }
                        if (document.getElementById("th2_reserve2").style.display == "none") {
                            td_r2 = "";
                        } else {
                            td_r2 = "<td align='center'>" + msg.data[i].reserve2 + "</td>"
                        }
                        $("#Tbody2").append("<tr id=h" + i +
                            " onmouseover='changeTgBg(this,&#39;font&#39;)' onmouseout='overchangeTgBg(this,&#39;font&#39;)' style='background-color:White;height:22px;'>" +
                            td_r1 + "<td  align='center'>" +
                            msg.data[i].num + "</td><td style='' align='center'>" +
                            msg.data[i].issi + "</td>" +
                            td_r2 + "<td style='' align='center' >" +
                            chuc + "</td><td style='' align='center' >" +
                            msg.data[i].changeTime + "</td><td style='display:none' align='center' ></td><td style='' align='center' >" +
                            s_detal + "</td><td align='center'><img onclick='toShowMenu(" +
                            msg.data[i].issi + "," + msg.data[i].myuid + ")' src='../img/treebutton2.gif'/></td></tr>");
                        arrayISSI2.push(i);
                    }
                });
        }
    }

    //今日统计
    function getData1() {
        if (isck) {
            getDataForTodaySearch();
        } else {
            getDataForTodayHZ();//查询
            document.getElementById("doTime").innerHTML = "<span>" + var_Lang_DoTime + "</span>";
            document.getElementById("doStep").innerHTML = var_Lang_DoDutyCount;
            document.getElementById("span_ListTitle").innerHTML = var_Lang_TodayRecordSelectSheet;

        }
    }
    function getData2() {
        var strstatues = statues_h;
        if (statues_h == "") {
            strstatues = window.parent.parent.GetTextByName("Lang_Log_All", language);
        } else if (statues_h.toString() == "-1") {
            strstatues = Iang_UnUp;
        }
        if (checkrad2hz) {
            document.getElementById("span_ListTitle_history").innerHTML = var_Lang_HistoryRecordSelectSheet + "——" + var_Lang_HZRW + "、" + strstatues + "、" + begtimes_h + "~" + endtimes_h;
            document.getElementById("wth6").innerHTML = Lang_RecordTimes;
            document.getElementById("wth7").style.display = "none";
            document.getElementById("wth8").style.width = "13%";
            getDataForSearchHZNew();

        } else {
            document.getElementById("wth7").style.display = "";
            document.getElementById("span_ListTitle_history").innerHTML = var_Lang_HistoryRecordSelectSheet + "——" + var_Lang_XXRW + " 、 " + strstatues + "、" + begtimes_h + "~" + endtimes_h;
            document.getElementById("wth6").innerHTML = Lang_DoTime;
            document.getElementById("wth8").style.width = "5%";;
            getDataForSearchXX();

        }
        pType_reserve1 = "";
        pType_reserve2 = "";
        if (cuttrntPInfo2[0].reserve1.toString() != "") {
            pType_reserve1 = document.getElementById("th2_reserve1").innerHTML;
        }
        if (cuttrntPInfo2[0].reserve2.toString() != "") {
            pType_reserve2 = document.getElementById("th2_reserve2").innerHTML;
        }

    }

    function reroadpagetitle() {

        if (totalCounts1 % everypagecount1 == 0) {
            totalPage1 = parseInt(totalCounts1 / everypagecount1);
        } else {
            totalPage1 = parseInt(totalCounts1 / everypagecount1 + 1);
        }
        if (currentPage1 > totalPage1) {
            currentPage1 = totalPage1;
        }

        var sel = document.getElementById("sel_page");

        if (totalPage1 < sel.length) {
            sel.length = totalPage1;
        } else if (totalPage1 == sel.length) {

        } else {
            topageselect();
        }

        sel.value = currentPage1;
        document.getElementById("span_currentPage").innerHTML = currentPage1;
        document.getElementById("span_totalpage").innerHTML = totalPage1;
        document.getElementById("span_total").innerHTML = totalCounts1;
        isFirstPage();
        if (isLastPage(currentPage1) && currentPage1 > 0) {

            document.getElementById("span_currentact").innerHTML = (currentPage1 - 1) * everypagecount1 + 1 + "~" + totalCounts1;
        } else if (currentPage1 <= 0) {
            document.getElementById("span_currentact").innerHTML = 0 + "~" + currentPage1 * everypagecount1;

        } else {
            document.getElementById("span_currentact").innerHTML = (currentPage1 - 1) * everypagecount1 + 1 + "~" + currentPage1 * everypagecount1;
        }

    }
    //页面跳转
    function topageselect() {
        var selobj = document.getElementById("sel_page");
        var firstt = 1;
        if (parseInt(currentPage1) - 250 > 0) {
            firstt = parseInt(currentPage1) - 250;//之前
        }
        var lastt = totalPage1;
        if (parseInt(totalPage1) - parseInt(currentPage1) > 500) {
            lastt = parseInt(currentPage1) + 250;
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
    function isFirstPage() {
        if (currentPage1 <= 1) {
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
    function isLastPage(currentPage1) {
        if (currentPage1 >= totalPage1) {
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
        if (totalPage1 <= currentPage1) {
            return;
        }
        currentPage1++;
        getData1();

        document.getElementById("sel_page").value = currentPage1;
    }
    function prePage() {
        if (currentPage1 <= 1) {
            return;
        }
        currentPage1--;
        if (EmergencyInfoShowFrom - everypagecount1 >= 0) {
            EmergencyInfoShowFrom = EmergencyInfoShowFrom - everypagecount1;
        } else {
            EmergencyInfoShowFrom = 0;
        }
        getData1();

        document.getElementById("sel_page").value = currentPage1;
    }
    function firstPage() {
        if (currentPage1 == 1) {
            return;
        }
        currentPage1 = 1;
        EmergencyInfoShowFrom = 0;
        getData1();

        document.getElementById("sel_page").value = currentPage1;
    }
    function lastPage() {
        if (currentPage1 == totalPage1) {
            return;
        }
        currentPage1 = totalPage1;
        getData1();

        document.getElementById("sel_page").value = currentPage1;
    }
    function tzpage() {

        var sel = document.getElementById("sel_page").value;

        if (sel == currentPage1) {
            return;
        }
        currentPage1 = sel;
        getData1();

        document.getElementById("sel_page").value = currentPage1;

    }

    //今日统计导出到excel
    function exportExcel() {
        if (arrayISSI1.length <= 0) {
            alert(var_Lang_nodatetoexport);
            return;
        }
        var protitle = document.getElementById("sel_WorkFlow").options[document.getElementById("sel_WorkFlow").selectedIndex].text;     //流程选择
        var type = "";//汇总还是详细 0代表汇总 1代表详细

        type = 0;

        if (begtimes == "" && endtimes == "") {
            var myDate = new Date();
            begtimes = endtimes = myDate.toLocaleDateString();
        }
        window.location = '../../Handlers/OutputtoExcel.ashx?strProID=' + strProID1 + '&issi=' + issi +
            '&carno=' + carno + '&statues=' + statues + '&begtimes=' + begtimes +
            '&endtimes=' + endtimes + '&protitle=' + protitle + '&type=' + type;
    }
    //历史统计导出到excel
    function exportExcel2() {
        if (arrayISSI2.length <= 0) {
            alert(var_Lang_nodatetoexport);
            return;
        }
        var protitle = document.getElementById("sel_WorkFlow2").options[document.getElementById("sel_WorkFlow2").selectedIndex].text;     //流程选择
        var type = "";//汇总还是详细 0代表汇总 1代表详细
        if (checkrad2hz) {
            type = 0;//汇总
        } else {
            type = 1;//明细
        }
        if (begtimes_h == "" && endtimes_h == "") {
            var myDate = new Date();
            begtimes_h = endtimes_h = myDate.toLocaleDateString();
        }
        //nameorNo, reserveValue
        window.location = '../../Handlers/Duty/dutyrecordToExcel.ashx?strProID=' + strProID2 + '&issi=' + issi_h +
            '&carno=' + carno_h + '&statues=' + statues_h + '&begtimes=' + begtimes_h +
            '&endtimes=' + endtimes_h + '&protitle=' + protitle + '&type=' + type +
            '&nameorNo= ' + NameorNo + '&reserveValue= ' + reserve2Value +
            '&pType_reserve1=' + pType_reserve1 + '&pType_reserve2=' + pType_reserve2;
    }
    function reroadpagetitle2() {

        if (totalCounts2 % everypagecount2 == 0) {
            totalPage2 = parseInt(totalCounts2 / everypagecount2);
        } else {
            totalPage2 = parseInt(totalCounts2 / everypagecount2 + 1);
        }
        if (currentPage2 > totalPage2) {
            currentPage2 = totalPage2;
        }

        var sel = document.getElementById("sel_page2");

        if (totalPage2 < sel.length) {
            sel.length = totalPage2;
        } else if (totalPage2 == sel.length) {

        } else {
            topageselect2();
        }

        sel.value = currentPage2;
        document.getElementById("span_currentPage2").innerHTML = currentPage2;
        document.getElementById("span_totalpage2").innerHTML = totalPage2;
        document.getElementById("span_total2").innerHTML = totalCounts2;
        isFirstPage2();
        if (isLastPage2(currentPage2) && currentPage2 > 0) {

            document.getElementById("span_currentact2").innerHTML = (currentPage2 - 1) * everypagecount2 + 1 + "~" + totalCounts2;
        } else if (currentPage2 <= 0) {
            document.getElementById("span_currentact2").innerHTML = 0 + "~" + currentPage2 * everypagecount2;

        } else {
            document.getElementById("span_currentact2").innerHTML = (currentPage2 - 1) * everypagecount2 + 1 + "~" + currentPage2 * everypagecount2;
        }
    }
    function isFirstPage2() {
        if (currentPage2 <= 1) {
            window.document.getElementById("Lang_FirstPage2").style.color = "gray";
            window.document.getElementById("Lang_PrePage2").style.color = "gray";
            window.document.getElementById("Lang_FirstPage2").style.textDecoration = "none";
            window.document.getElementById("Lang_PrePage2").style.textDecoration = "none";
        } else {
            window.document.getElementById("Lang_FirstPage2").style.color = "blue";
            window.document.getElementById("Lang_PrePage2").style.color = "blue";
            window.document.getElementById("Lang_FirstPage2").style.textDecoration = "underline";
            window.document.getElementById("Lang_PrePage2").style.textDecoration = "underline";
        }
    }
    //判断是否为最后一页
    function isLastPage2(currentPage2) {
        if (currentPage2 >= totalPage2) {
            window.document.getElementById("Lang_play_next_page2").style.color = "gray";
            window.document.getElementById("Lang_LastPage2").style.color = "gray";
            window.document.getElementById("Lang_play_next_page2").style.textDecoration = "none";
            window.document.getElementById("Lang_LastPage2").style.textDecoration = "none";
            return true;
        } else {
            window.document.getElementById("Lang_play_next_page2").style.color = "blue";
            window.document.getElementById("Lang_LastPage2").style.color = "blue";
            window.document.getElementById("Lang_play_next_page2").style.textDecoration = "underline";
            window.document.getElementById("Lang_LastPage2").style.textDecoration = "underline";
            return false;
        }
    }
    //页面跳转
    function topageselect2() {
        var selobj = document.getElementById("sel_page2");
        var firstt = 1;
        if (parseInt(currentPage2) - 250 > 0) {
            firstt = parseInt(currentPage2) - 250;//之前
        }
        var lastt = totalPage2;
        if (parseInt(totalPage2) - parseInt(currentPage2) > 500) {
            lastt = parseInt(currentPage2) + 250;
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
    function nextPage2() {
        if (totalPage2 <= currentPage2) {
            return;
        }
        currentPage2++;
        getData2();

        document.getElementById("sel_page2").value = currentPage2;
    }
    function prePage2() {
        if (currentPage2 <= 1) {
            return;
        }
        currentPage2--;
        if (EmergencyInfoShowFrom2 - everypagecount2 >= 0) {
            EmergencyInfoShowFrom2 = EmergencyInfoShowFrom2 - everypagecount2;
        } else {
            EmergencyInfoShowFrom2 = 0;
        }
        getData2();

        document.getElementById("sel_page2").value = currentPage2;
    }
    function firstPage2() {
        if (currentPage2 == 1) {
            return;
        }
        currentPage2 = 1;
        EmergencyInfoShowFrom2 = 0;
        getData2();

        document.getElementById("sel_page2").value = currentPage2;
    }
    function lastPage2() {
        if (currentPage2 == totalPage2) {
            return;
        }
        currentPage2 = totalPage2;
        getData2();

        document.getElementById("sel_page2").value = currentPage2;
    }
    function tzpage2() {

        var sel = document.getElementById("sel_page2").value;

        if (sel == currentPage2) {
            return;
        }
        currentPage2 = sel;
        getData2();

        document.getElementById("sel_page2").value = currentPage1;

    }
        //点击其他地方隐藏右键菜单----------xzj--2018/8/4-------------------------
    document.onmouseup = function () {
        hideCarDutyMenu();
    }
    function hideCarDutyMenu() {
        window.parent.document.getElementById("carDutyMenu").style.display = "none";
    }
</script>

