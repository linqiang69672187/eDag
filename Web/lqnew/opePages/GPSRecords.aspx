<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GPSRecords.aspx.cs" Inherits="Web.lqnew.opePages.GPSRecords" %>

<!DOCTYPE>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta charset="UTF-8" />
    <title>Accordion Actions - jQuery EasyUI Demo</title>
    <link href="../../CSS/pagestyle.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" href="../js/resPermissions/jquery-easyui-1.4.1/themes/default/easyui.css" />
    <link rel="stylesheet" type="text/css" href="../js/resPermissions/jquery-easyui-1.4.1/themes/icon.css" />
    <link rel="stylesheet" type="text/css" href="../js/resPermissions/jquery-easyui-1.4.1/demo/demo.css" />
    <script type="text/javascript" src="../js/resPermissions/jquery-easyui-1.4/jquery.min.js"></script>
    <script type="text/javascript" src="../js/resPermissions/jquery-easyui-1.4.1/jquery.easyui.min.js"></script>
    <%if (System.Configuration.ConfigurationManager.AppSettings["defaultLanguage"] == "zh-CN")
      { %>
    <script type="text/javascript" src="../js/resPermissions/jquery-easyui-1.4.1/locale/easyui-lang-zh_CN.js"></script>
    <%} %>

    <script type="text/javascript" src="../../JS/LangueSwitch.js"></script>
    <script src="../js/geturl.js" type="text/javascript"></script>
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
        ruby {
            font-size: 50px;
            color: red;
            font-family: 黑体;
        }

        .tab {
            border: solid 1px;
            border-color: rgb(80,160,91);
            width: 580px;
            margin: 0 auto;
            text-align: left;
        }

        .hd {
            background-color: rgb(217,246,182);
            height: 20px;
            width: 100%;
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
            padding: 20px 10px;
            width: 564px;
        }
    </style>
 <style type="text/css">   
  
/*重点：固定行头样式*/  
.scrollRowThead   
{  
     position: relative;   
     left: expression(this.parentElement.parentElement.parentElement.parentElement.scrollLeft);  
     z-index:0;  
}  
   
/*重点：固定表头样式*/  
.scrollColThead {  
     position: relative;   
     top: expression(this.parentElement.parentElement.parentElement.scrollTop);  
     z-index:2;  
}  
  
/*行列交叉的地方*/  
.scrollCR {  
     z-index:3;  
}   
  
/*表格的线*/  
.scrolltable   
{   
        border-bottom:1px solid #CCCCCC;   
        border-right:1px solid #CCCCCC;   
}  
   
/*单元格的线等*/  
.scrolltable td,.scrollTable th   
{  
     border-left: 1px solid #CCCCCC;   
     border-top: 1px solid #CCCCCC;   
     padding: 5px;   
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
                        <div id="Lang_gpstj" style="display: inline; float: left; text-align: left; width: 30%; color: white"><%--GPS上报统计--%></div>
                        <div id="divClose" onmouseover="Divover('on')" onclick="closethispage()" onmouseout="Divover('out')"></div>
                    </td>
                    <td class="style2" cellpadding="0" cellspacing="0">
                        <img src="../images/tab_07.png" width="14" height="32" /></td>
                </tr>
                <tr>
                    <td width="15" background="../images/tab_12.gif">
                    </td>
                    <td style="background-color: white" id="dragtd">
                        <div style="width: 580px; height: auto;" id="showDiv">
                         
                                <div class="tab">
                                    <div class="hd">
                                        <ul>
                                            <li class="nomal activeTab" tabid="content1" id="hzTab">汇总统计</li>
                                            <li class="nomal" tabid="content2" id="mxTab">明细查询</li>
                                        </ul>
                                    </div>
                                    <div id="content">
                                        <div id="content1" style="display: block;">
                                            <div id="aa" style="width: 100%; height: auto; overflow: auto; padding: 10px;">
                                                <table>
                                                    <tr>
                                                        <td>
                                                            <div style="display: inline; float: left; text-align: left; width: 100%;">
                                                                <span id="Lang_Unit"></span>:
                                                          
                                                                 <asp:DropDownList ID="entity_h" runat="server" >
                                                                <asp:ListItem Value="0">选择所属单位</asp:ListItem>
                                                            </asp:DropDownList>


                                                            </div>

                                                        </td>
                                                        <td>
                                                            <div style="float: left; text-align: left; width: 250px;">
                                                                <span id="Lang_StatueRW">状态</span>:
                                            <select id="statuesList_h" style="width: 80px;">
                                                <%--<option id="Option0" value="2">全部</option>--%>
                                                <option id="Lang_UnUP" value="0">未上报</option>
                                                <option id="Lang_hasUp" value="1">上报</option>
                                            </select>
                                                            </div>
                                                        </td>
                                                        <td>
                                                            <div style="display: inline; text-align: right; width: 100%;">
                                                                <input onclick="searchList1()" type="button" class="button-green button-right" id="Lang_HZRW" value="汇总" />
                                                                
                                                            </div>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <div style="display: inline; float: left; text-align: left; width: 100%;">
                                                                <span id="Lang_BegTime">开始时间</span>:
                                                <input id="begTime_h" class="easyui-datebox" style="width: 120px" required="required" editable="false" data-options="formatter:changeFormatter,parser:myparser" />
                                                            </div>
                                                        </td>
                                                        <td>
                                                            <div style="float: left; text-align: left; width: 100%;">
                                                                <span id="Lang_EndTime">结束时间</span>:
                                                <input id="endTime_h" class="easyui-datebox" style="width: 120px" required="required" editable="false" data-options="formatter:changeFormatter,parser:myparser" />

                                                            </div>
                                                        </td>
                                                        <td>
                                                          <input type="button" class="button-green button-right" id="Lang_ExportToExcel" value="导出到excel" onclick="exportExcel('0')"/>
                   
                                                        </td>
                                                    </tr>

                                                </table>

                                            </div>
                                        </div>
                                        <div id="content2" style="display: none;">
                                            <div id="Div1" style="width: 100%;">

                                                <div style="height: 30px;">
                                                    <div style="display: inline; float: left; text-align: left; width: 30%;">
                                                       <span id="Lang_Unit"></span>:
                                                         <asp:DropDownList ID="entity_m" runat="server" >
                                                                <asp:ListItem Value="0">选择所属单位</asp:ListItem>
                                                            </asp:DropDownList>

                                                    </div>
                                                    <div style="display: inline; float: left; text-align: center; width: 70%;">
                                                        <span id="Lang_StatueRW">状态</span>:
                                            <select id="statuesList_m" style="width: 80px;">
                                               <option id="Lang_Log_All" value="2">全部</option>
                                                <option id="Lang_UnUP" value="0">未上报</option>
                                                <option id="Lang_hasUp" value="1">已上报</option>
                                            </select>
                                                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <select id="Select2" style="width: 80px;">
                                              
                                                <option id="usename" value="0">姓名</option>
                                                <option id="Lang_ISSI_searchoption" value="1">终端号码</option>
                                            </select>:&nbsp;<input type="text" value="" style="width: 80px;" id="userISSI_m" />
                                                    </div>

                                                </div>
                                                <div style="width: 100%; height: 30px; display: inline;">

                                                    <div style="width: 100%; height: 30px; display: inline; float: left; text-align: left;">
                                                        <div style="display: inline; float: left; text-align: left; width: 40%;">
                                                            <span id="Lang_BegTime">开始时间</span>:
                                                <input id="begTime_m" class="easyui-datebox" style="width: 140px" required="required" editable="false" data-options="formatter:changeFormatter,parser:myparser" />
                                                        </div>
                                                        <div style="float: left; text-align: center; width: 50%;">
                                                            <span id="Lang_EndTime">结束时间</span>:
                                                            <input id="endTime_m" class="easyui-datebox" style="width: 140px" required="required" editable="false" data-options="formatter:changeFormatter,parser:myparser" />
                                                        </div>
                                                    </div>
                                                </div>

                                                <div style="height: 40px; width: 100%;">
                                                <input onclick="exportExcel('1')" type="button" class="button-green button-right" id="Lang_ExportToExcel" value="导出到Excel" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                 <input onclick="searchList2('0')" type="button" class="button-green button-right" id="DetailInquiry" value="明细查询" />     
                                                </div>
                                                 
                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                </div>
                          

                            <div id="huizongDiv" style="display: block; width: 100%; height: auto;  font-family: Arial; text-align: left;">
                                <fieldset>
                                    <legend><span id="span_ListTitle" style="display:block">终端GPS上报汇总信息如下：</span></legend>
                                </fieldset>   
                                    <div style="height:auto; width:100%; border:none; overflow-y:scroll ;">  
                                    <table   cellspacing="1" cellpadding="0" id="GridView1" style="background-color: #C0DE98; border-color: White; border-width: 0px; border-style: Ridge; width: 99%;">

                                        <tr id="hzTH" class="gridheadcss" style="font-weight: bold;display: block">
                                            <th  style="width: 25%; background-color: activeborder; text-align: center;"><span id ="Lang_Subordinateunits">所属单位</span></th>
                                            <th  style="width: 25%; background-color: activeborder; text-align: center;"><span id ="statusTitle">未上报终端数</span></th>
                                            <th  style="width: 25%; background-color: activeborder; text-align: center;"><span id="totalCount">拥有终端数</span></th>
                                            <th  style="width: 25%; background-color: activeborder; text-align: center;"><span id ="resultTitle">未上报比例(%)</span></th>
                                        </tr>
                                         <tr id="detTH" class="gridheadcss" style="font-weight: bold;display: none">
                                            <th style="width: 120px; background-color: activeborder; text-align: center;"><span id ="user">用户名</span></th>
                                            <th  style="width: 120px; background-color: activeborder; text-align: center;"><span id="Lang_ISSI_searchoption">终端号</span></th>
                                            <th  style="width: 120px; background-color: activeborder; text-align: center;"><span id="Lang_Subordinateunits">所属单位</span></th>
                                            <th  style="width: 120px; background-color: activeborder; text-align: center;"><span id="thedate">日期</span></th>
                                            <th  style="width: 120px; background-color: activeborder; text-align: center;"><span id="result">上报情况</span></th>
                                        </tr>
                                        <tbody id="Tbody1" >
                                        </tbody>
                                        <tbody id="Tbody2">
                                        </tbody>
                                    </table>
                                    <table id="MXPageTab" style="color: blue;display:none; background-color: White; height: 28px; width: 100%">
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

                                        </tr>
                                    </table>
                                        <table id ="HZPageTab" style="color: blue;display:block; background-color: White; height: 28px; width: 100%">
                                             <tr>
                                            <td align="left" style="width: 20%">
                                                <span id="span_page_h"></span><span id="span_currentPage_h">0</span>/<span id="span_totalpage_h">0</span>&nbsp;&nbsp;
                                                                                                <span id="span_tiao_h"></span>
                                                <span id="span_currentact_h">0~0</span>/<span id="span_total_h">0</span>
                                            </td>
                                            <td align="right" style="width: 40%">
                                                <span onclick="firstPage_h()" class="YangdjPageStyle" id="Lang_FirstPage_h"></span>&nbsp;&nbsp;<span onclick="prePage_h()" class="YangdjPageStyle" id="Lang_PrePage_h"></span>&nbsp;&nbsp;<span onclick="nextPage_h()" class="YangdjPageStyle" id="Lang_play_next_page_h"></span>&nbsp;&nbsp;<span onclick="lastPage_h()" class="YangdjPageStyle" id="Lang_LastPage_h"></span>
                                            </td>
                                            <td align="right" style="width: 7%">
                                                <select onchange="tzpage_h()" id="sel_page_h"></select>
                                            </td>

                                        </tr>
                                        </table>

                                     </div>
                                    
                            </div>
                   
                        </div>
                    </td>
                    <td width="14" background="../images/tab_16.gif">&nbsp;-
                    </td>
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
<script type="text/javascript">
    // var div1 = document.getElementById("huizongDiv");
    //var div2 = document.getElementById("detailDiv");
    var hzTH = document.getElementById("hzTH");
    var detTH = document.getElementById("detTH");
    var tbody1 = document.getElementById("Tbody1");
    var tbody2 = document.getElementById("Tbody2");
    var mxpageTab = document.getElementById("MXPageTab");
    var hzpageTab = document.getElementById("HZPageTab");
    var state
    var span_ListTitle = document.getElementById("span_ListTitle");

    function hzDisplay() {
        span_ListTitle.innerHTML = SummaryFollows;//"终端GPS上报汇总如下：";
        hzTH.style.display = "block";
        detTH.style.display = "none";
        tbody1.style.display = "block";
        tbody2.style.display = "none";
        hzpageTab.style.display = "block";
        mxpageTab.style.display = "none";
    }
    function detDisplay() {
        span_ListTitle.innerHTML = DetailFollows;//"终端GPS上报明细如下：";
        detTH.style.display = "block";
        tbody2.style.display = "block";
        hzTH.style.display = "none";
        tbody1.style.display = "none";
        hzpageTab.style.display = "none";
        mxpageTab.style.display = "block";
    }
    function tabClick() {
        if ($(this).hasClass('activeTab'))
            return;
        $('.hd ul li').removeClass('activeTab');
        $(this).addClass('activeTab');
        var tabId = $(this).attr('tabId');
        $('#content > div').hide();
        $('#' + tabId).show();
        if (tabId == "content1") {
            hzDisplay();
        } else if (tabId == "content2") {
            detDisplay();
        }
    }
    function setdatebox(timeID) {
        $('#' + timeID).datebox('setValue', changeFormatter(new Date()));//历史检索起始日期缺省值默认为当日

        $('#' + timeID).datebox('calendar').calendar({//历史检索起始日期不能选今天之后的日期
            validator: function (date) {
                var now = new Date();
                var d1 = new Date(now.getFullYear(), now.getMonth(), now.getDate());
                var d2 = new Date(now.getFullYear(), now.getMonth(), now.getDate());
                //return d1 <= date && date <= d2;
                return date <= d2;

            }
        });
    }
    $(document).ready(function () {
        $('.hd ul li').click(tabClick);
        setdatebox("begTime_h");
        setdatebox("endTime_h");
        setdatebox("begTime_m");
        setdatebox("endTime_m");
      
    })
</script>
<script type="text/javascript">
    window.parent.closeprossdiv();
    LanguageSwitch(window.parent.parent);
    //加载中
    var language = window.parent.parent.useprameters.languagedata;
    var Lang_loading = window.parent.parent.GetTextByName("Lang_loading", language);
    //无
    var LangNone = window.parent.parent.GetTextByName("Lang-None", language);
    //未知
    var Unkown = window.parent.parent.GetTextByName("Unkown", language);
    //详细信息
    var xxxx = window.parent.parent.GetTextByName("Info", language);
    //页
    var span_page = window.parent.parent.GetTextByName("Page", language);
    //条
    var span_tiao = window.parent.parent.GetTextByName("Article", language);
    //首页
    var firstpage = window.parent.parent.GetTextByName("Lang_firstpage", language);
    //上一页
    var prepage = window.parent.parent.GetTextByName("Lang_prepage", language);
    //下一页
    var nextpage = window.parent.parent.GetTextByName("Lang_nextpage", language);
    //尾页
    var lastpage = window.parent.parent.GetTextByName("Lang_lastpage", language);
    //暂无数据导出
    var var_Lang_nodatetoexport = window.parent.parent.GetTextByName("Lang_nodatetoexport", language);
    //汇总统计
    var SummaryStatistic = window.parent.parent.GetTextByName("SummaryStatistic", language);
    //明细查询
    var DetailInquiry = window.parent.parent.GetTextByName("DetailInquiry", language);
    //日期
    var varDate = window.parent.parent.GetTextByName("Date", language);
    //上报情况
    var ReportSituation = window.parent.parent.GetTextByName("ReportSituation", language);
    //GPS上报明细如下
    var DetailFollows = window.parent.parent.GetTextByName("DetailFollows", language);
    //GPS上报汇总如下
    var SummaryFollows = window.parent.parent.GetTextByName("SummaryFollows", language);
    //已上报比例
    var UPProportion = window.parent.parent.GetTextByName("UPProportion", language);
    //已上报终端数
    var UPCount = window.parent.parent.GetTextByName("UPCount", language);
    //未上报比例
    var UnUPProportion = window.parent.parent.GetTextByName("UnUPProportion", language);
    //未上报终端数
    var UnUPCount = window.parent.parent.GetTextByName("UnUPCount", language);
    //拥有终端数
    var totalCount = window.parent.parent.GetTextByName("totalCount", language);
    //用户名
    var usename = window.parent.parent.GetTextByName("usename", language);
    //选择所属单位
    var SelectEntity = window.parent.parent.GetTextByName("SelectEntity", language);
    //请选择起止时间
    var timeCanNotBeEmpty = window.parent.parent.GetTextByName("timeCanNotBeEmpty", language);
    //姓名
    var Username = window.parent.parent.GetTextByName("Username", language);
    //结束时间不能小于开始时间
    var Lang_end_time_cannot_least_start_time = window.parent.parent.GetTextByName("Lang_end_time_cannot_least_start_time", language);
    var timeCanNotOut30Days = window.parent.parent.GetTextByName("timeCanNotOut30Days", language);
    window.document.getElementById("hzTab").innerHTML = SummaryStatistic;
    window.document.getElementById("mxTab").innerHTML = DetailInquiry;
    window.document.getElementById("user").innerHTML = usename;
    window.document.getElementById("usename").innerHTML = usename;
    window.document.getElementById("thedate").innerHTML = varDate;
    window.document.getElementById("result").innerHTML = ReportSituation;
    window.document.getElementById("totalCount").innerHTML = totalCount;
    window.document.getElementById("statusTitle").innerHTML = UnUPCount;
    window.document.getElementById("resultTitle").innerHTML = UnUPProportion;
    window.document.getElementById("DetailInquiry").value = DetailInquiry;

    window.document.getElementById("span_page_h").innerHTML = span_page;
    window.document.getElementById("span_tiao_h").innerHTML = span_tiao;
    window.document.getElementById("span_page").innerHTML = span_page;
    window.document.getElementById("span_tiao").innerHTML = span_tiao;

    window.document.getElementById("Lang_FirstPage_h").innerHTML = firstpage;
    window.document.getElementById("Lang_PrePage_h").innerHTML = prepage;
    window.document.getElementById("Lang_play_next_page_h").innerHTML = nextpage;
    window.document.getElementById("Lang_LastPage_h").innerHTML = lastpage;
    span_ListTitle.innerHTML = SummaryFollows;//"终端GPS上报汇总如下：";
    //
    var arrayHZtable = new Array();
    var arrayMXtable = new Array();


    //汇总条件
    var entity_h = "";
    var status_h = "";
    var begtime_h = "";
    var endtime_h = "";
    //明细条件
    var userissi_m = "";
    var entity_m = "";
    var status_m = "";
    var begtime_m = "";
    var endtime_m = "";
    var condition = "";
    function getSearchCondition_h() {
        var eSection = document.getElementById("<%=entity_h.ClientID%>");
        entity_h = eSection.options[eSection.selectedIndex].value;

        status_h = document.getElementById("statuesList_h").value;
        begtime_h = $("#begTime_h").datebox('getValue');
        endtime_h = $("#endTime_h").datebox('getValue');
        if (status_h == '0') {
            document.getElementById("statusTitle").innerHTML = UnUPCount;//"未上报终端数";
            document.getElementById("resultTitle").innerHTML = UnUPProportion;//"未上报比例";
        }
        if (status_h == '1') {
            document.getElementById("statusTitle").innerHTML = UPCount;//"上报终端数";
            document.getElementById("resultTitle").innerHTML = UPProportion;//"上报比例";
        }
        if (entity_h == "0") {
            alert(SelectEntity);//"请选择所属单位"
            return true;
        }
        if (validateDateTime("begTime_h", "endTime_h")) {
            return true;
        }
        return false;
    }
    function getSearchCondition_m() {
        userissi_m = document.getElementById("userISSI_m").value;

        var eSectionm = document.getElementById("<%=entity_m.ClientID%>");
        entity_m = eSectionm.options[eSectionm.selectedIndex].value;
        status_m = document.getElementById("statuesList_m").value;
        condition = document.getElementById("Select2").value;
        begtime_m = $("#begTime_m").datebox('getValue');
        endtime_m = $("#endTime_m").datebox('getValue');

        if (entity_m == "0") {
            alert(SelectEntity);
            return true;
        }
        if (validateDateTime("begTime_m", "endTime_m")) {
            return true;
        }
        return false;
    }

    function searchList1() {
        if (getSearchCondition_h()) {
            return;
        }
        currentPage_h = 1;
        getDataForH();

    }
    function searchList2() {
        if (getSearchCondition_m()) {
            return;
        }
        currentPage = 1;
        getDataForM();
    }
    function getDataForH() {
 
        var selStatues = "";
        //注释，改为$("#Tbody1").empty();----------------xzj--2018/7/20-------------------------
        //for (var i = 0; i < arrayHZtable.length; i++) {
        //    $("#" + arrayHZtable[i] + "h").remove();
        //}
        $("#Tbody1").empty();
        //arrayHZtable.length = 0;
        $("#isprocessing1").remove();
        $("#Tbody1").append("<tr id='isprocessing1' style='background-color:White;height:22px;color:red'><td colspan='9' >" +
           Lang_loading + "</td></tr>");
        window.parent.jquerygetNewData_ajax("../../Handlers/Duty/getGPSRecordsSummary.ashx",
            { PageIndex: currentPage_h, Limit: everypagecount, entity: entity_h, status: status_h, begtime: begtime_h, endtime: endtime_h },
            function (msg) {
                $("#isprocessing1").remove();
                totalCounts_h = msg.totalcount;
                reroadpagetitle_h();
                arrayHZtable.length = 0;
                if (msg.data.length == 0) {

                    $("#Tbody1").append("<tr id='isprocessing1' style='background-color:White;height:22px;color:red'><td colspan='9' >" + LangNone + "</td></tr>");
                } else {
                    //注释,改为$("#Tbody1").empty();----------------xzj--2018/7/20-------------------------
                    //for (var i = 0; i < arrayHZtable.length; i++) {
                    //    $("#" + arrayHZtable[i] + "h").remove();
                    //}
                    $("#Tbody1").empty();
                 
                   
                    if (status_h == "0") {
                        for (var i = 0; i < msg.data.length; i++) {
                            $("#Tbody1").append("<tr id=" + i + "h onmouseover='changeTgBg(this,&#39;font&#39;)' onmouseout='overchangeTgBg(this,&#39;font&#39;)' style='background-color:White;height:22px;'><td align='center'>" + msg.data[i].name + "</td><td  align='center'>" + msg.data[i].nnn + "</td><td style='' align='center'>" + msg.data[i].total + "</td><td style='' align='center'>" + Math.round((msg.data[i].nnn) / (msg.data[i].total) * 100) + "%</td>");
                            arrayHZtable.push(i);
                        }
                    }

                    else if (status_h == "1") {
                        for (var i = 0; i < msg.data.length; i++) {

                            $("#Tbody1").append("<tr id=" + i + "h onmouseover='changeTgBg(this,&#39;font&#39;)' onmouseout='overchangeTgBg(this,&#39;font&#39;)' style='background-color:White;height:22px;'><td align='center'>" + msg.data[i].name + "</td><td  align='center'>" + msg.data[i].yes + "</td><td style='' align='center'>" + msg.data[i].total + "</td><td style='' align='center'>" + Math.round((msg.data[i].yes) / (msg.data[i].total) * 100) + "%</td>");
                            arrayHZtable.push(i);


                        }
                    }
                }
            });

    }
    function getDataForM() {
       
        for (var i = 0; i < arrayMXtable.length; i++) {
            $("#" + arrayMXtable[i] + "m").remove();
        }
        arrayMXtable.length = 0;
        $("#isprocessing2").remove();
        $("#Tbody2").append("<tr id='isprocessing2' style='background-color:White;height:22px;color:red'><td colspan='9' >" +
           Lang_loading + "</td></tr>");
        window.parent.jquerygetNewData_ajax("../../Handlers/Duty/getGPSRecordsDetailed.ashx",
          { PageIndex: currentPage, Limit: everypagecount, entity: entity_m, status: status_m, begtime: begtime_m, endtime: endtime_m, userissi: userissi_m, condition: condition },
          function (msg) {
              $("#isprocessing2").remove();
              totalCounts = msg.totalcount;
              reroadpagetitle();
              if (msg.data.length == 0) {
                  $("#Tbody2").append("<tr id='isprocessing2' style='background-color:White;height:22px;color:red'><td colspan='9' >" + LangNone + "</td></tr>");
              } else {
                 
                  for (var i = 0; i < msg.data.length; i++) {
                      $("#Tbody2").append("<tr id=" + i + "m onmouseover='changeTgBg(this,&#39;font&#39;)' onmouseout='overchangeTgBg(this,&#39;font&#39;)'" +
                          " style='background-color:White;height:22px;'>" +
                          "<td align='center'>" + msg.data[i].username + "</td><td  align='center'>" + msg.data[i].issi +
                          "</td><td style='' align='center'>" + msg.data[i].Name +
                          "</td><td style='' align='center'>" + msg.data[i].begtime +
                            "</td><td style='' align='center'>" + msg.data[i].sbqk);
                      arrayMXtable.push(i);
                  }
              }
          });

    }
    function exportExcel(type) {
        if (type == "1") {
           if (arrayMXtable.length <= 0) {
                alert(var_Lang_nodatetoexport);
                return;
            }

            if (begtime_h == "" && endtime_h == "") {
                var myDate = new Date();
                begtimes = endtimes = myDate.toLocaleDateString();
            }
            window.location = '../../Handlers/Duty/exportToExcel.ashx?type=1'+'&begtime=' + begtime_m +
                '&endtime=' + endtime_m + '&entity=' + entity_m + '&status=' + status_m + '&condition=' + condition + '&userissi=' + userissi_m;
        } else if (type == "0") {
            if (arrayHZtable.length <= 0) {
                alert(var_Lang_nodatetoexport);
                return;
            }

            if (begtime_h == "" && endtime_h == "") {
                var myDate = new Date();
                begtimes = endtimes = myDate.toLocaleDateString();
            }
            window.location = '../../Handlers/Duty/exportToExcel.ashx?type=0&begtime=' + begtime_h +
                '&endtime=' + endtime_h + '&entity=' + entity_h + '&status=' + status_h;
        }
        


    }
    $(document).ready(function () {
        $("#begTime").datebox({
            missingMessage: "必须选择",
            editable: false
        })
        $("#endTime").datebox({
            missingMessage: "必须选择",
            editable: false
        })
    })

    function validateDateTime(beginTimeId, endTimeId) {
   
        var begtime = $("#" + beginTimeId).datebox('getValue');
        var begdate = new Date(begtime.replace(/-/g,"\/"));
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

    function Divover(str) {
        var div1 = document.getElementById("divClose");
        if (str == "on") { div1.style.backgroundPosition = "66 0"; }
        else { div1.style.backgroundPosition = "0 0"; }
    }

    document.oncontextmenu = new Function("event.returnValue=false;"); //禁止右键功能,单击右键将无任何反应
    document.onselectstart = new Function("event.returnValue=false;"); //禁止选择,也就是无法复制
    Request = {
        QueryString: function (item) {
            var svalue = location.search.match(new RegExp("[\?\&]" + item + "=([^\&]*)(\&?)", "i"));
            return svalue ? svalue[1] : svalue;
        }
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

    function closethispage() {
        window.parent.lq_closeANDremovediv('GPSRecords', 'bgDiv');
    }
    var dragEnable = 'True';
    function dragdiv() {
        var div1 = window.parent.document.getElementById('GPSRecords');
        if (div1 && event.button == 0 && dragEnable == 'True') {
            window.parent.mystartDragWindow(div1, null, event); div1.style.border = "solid 0px transparent"; window.parent.cgzindex(div1);

        }
    }
    function mydragWindow() {
        var div1 = window.parent.document.getElementById('GPSRecords');
        if (div1) {
            window.parent.mydragWindow(div1, event);
        }
    }
    function mystopDragWindow() {
        var div1 = window.parent.document.getElementById('GPSRecords');
        if (div1) {
            window.parent.mystopDragWindow(div1); div1.style.border = "0px";
        }
    }

    window.onload = function () {
        document.body.onmousedown = function () { dragdiv(); }
        document.body.onmousemove = function () { mydragWindow(); }
        document.body.onmouseup = function () { mystopDragWindow(); }
        document.body.oncontextmenu = function () { return false; }
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
    //每页行数
    var everypagecount = 10;
    //当前页
    var currentPage = 1;
    //总页数
    var totalPage = 1;
    //总条数
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
            sel.length = totalPage;
        } else {
            topageselect();

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
    function isFirstPage() {
        if (currentPage <= 1) {
            window.document.getElementById("Lang_FirstPage").className = "YangdjPageStyleUnClick";
            window.document.getElementById("Lang_PrePage").className = "YangdjPageStyleUnClick";
        } else {
            window.document.getElementById("Lang_FirstPage").className = "YangdjPageStyle";
            window.document.getElementById("Lang_PrePage").className = "YangdjPageStyle";
        }
    }
    //判断是否为最后一页
    function isLastPage(currentPage) {
        if (currentPage >= totalPage) {
            window.document.getElementById("Lang_play_next_page").className = "YangdjPageStyleUnClick";
            window.document.getElementById("Lang_LastPage").className = "YangdjPageStyleUnClick";
            return true;
        } else {
            window.document.getElementById("Lang_play_next_page").className = "YangdjPageStyle";
            window.document.getElementById("Lang_LastPage").className = "YangdjPageStyle";
            return false;
        }
    }
    function nextPage() {
        if (totalPage <= currentPage) {
            return;
        }
        currentPage++;
        reroadpagetitle();
        getDataForM();
        document.getElementById("sel_page").value = currentPage;
    }
    function prePage() {
        if (currentPage <= 1) {
            return;
        }
        currentPage--;
        reroadpagetitle();
        getDataForM();
        document.getElementById("sel_page").value = currentPage;
    }
    function firstPage() {
        if (currentPage == 1) {
            return;
        }
        currentPage = 1;
        reroadpagetitle();
        getDataForM();
        document.getElementById("sel_page").value = currentPage;
    }
    function lastPage() {
        if (currentPage == totalPage) {
            return;
        }
        currentPage = totalPage;
        reroadpagetitle();
        getDataForM();
        document.getElementById("sel_page").value = currentPage;
    }
    function tzpage() {

        var sel = document.getElementById("sel_page").value;

        if (sel == currentPage) {
            return;
        }
        currentPage = sel;
        reroadpagetitle();
        getDataForM();
        document.getElementById("sel_page").value = currentPage;
    }
    //每页行数
    var everypagecount = 10;
    //当前页
    var currentPage_h = 1;
    //总页数
    var totalPage_h = 1;
    //总条数
    var totalCounts_h = 0;
    function reroadpagetitle_h() {

        if (totalCounts_h % everypagecount == 0) {
            totalPage_h = parseInt(totalCounts_h / everypagecount);
        } else {
            totalPage_h = parseInt(totalCounts_h / everypagecount + 1);
        }
        if (currentPage_h > totalPage_h) {
            currentPage_h = totalPage_h;
        }

        var sel = document.getElementById("sel_page_h");

        if (totalPage_h < sel.length) {
            sel.length = totalPage_h;
        } else if (totalPage_h == sel.length) {
            sel.length = totalPage_h;
        } else {
            topageselect_h();

        }

        sel.value = currentPage_h;
        document.getElementById("span_currentPage_h").innerHTML = currentPage_h;
        document.getElementById("span_totalpage_h").innerHTML = totalPage_h;
        document.getElementById("span_total_h").innerHTML = totalCounts_h;
        isFirstPage_h();
        if (isLastPage_h(currentPage_h) && currentPage_h > 0) {

            document.getElementById("span_currentact_h").innerHTML = (currentPage_h - 1) * everypagecount + 1 + "~" + totalCounts_h;
        } else if (currentPage_h <= 0) {
            document.getElementById("span_currentact_h").innerHTML = 0 + "~" + currentPage_h * everypagecount;

        } else {
            document.getElementById("span_currentact_h").innerHTML = (currentPage_h - 1) * everypagecount + 1 + "~" + currentPage_h * everypagecount;
        }

    }
    function topageselect_h() {
        var selobj = document.getElementById("sel_page_h");
        var firstt = 1;
        if (parseInt(currentPage_h) - 250 > 0) {
            firstt = parseInt(currentPage_h) - 250;//之前
        }
        var lastt = totalPage_h;
        if (parseInt(totalPage_h) - parseInt(currentPage_h) > 500) {
            lastt = parseInt(currentPage_h) + 250;
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
    function isFirstPage_h() {
        if (currentPage_h <= 1) {
            window.document.getElementById("Lang_FirstPage_h").className = "YangdjPageStyleUnClick";
            window.document.getElementById("Lang_PrePage_h").className = "YangdjPageStyleUnClick";
        } else {
            window.document.getElementById("Lang_FirstPage_h").className = "YangdjPageStyle";
            window.document.getElementById("Lang_PrePage_h").className = "YangdjPageStyle";
        }
    }
    //判断是否为最后一页
    function isLastPage_h(currentPage_h) {
        if (currentPage_h >= totalPage_h) {
            window.document.getElementById("Lang_play_next_page_h").className = "YangdjPageStyleUnClick";
            window.document.getElementById("Lang_LastPage_h").className = "YangdjPageStyleUnClick";
            return true;
        } else {
            window.document.getElementById("Lang_play_next_page_h").className = "YangdjPageStyle";
            window.document.getElementById("Lang_LastPage_h").className = "YangdjPageStyle";
            return false;
        }
    }
    function nextPage_h() {
        if (totalPage_h <= currentPage_h) {
            return;
        }
        currentPage_h++;
        reroadpagetitle_h();
        getDataForH();
        document.getElementById("sel_page_h").value = currentPage_h;
    }
    function prePage_h() {
        if (currentPage_h <= 1) {
            return;
        }
        currentPage_h--;
        reroadpagetitle_h();
        getDataForH();
        document.getElementById("sel_page_h").value = currentPage_h;
    }
    function firstPage_h() {
        if (currentPage_h == 1) {
            return;
        }
        currentPage_h = 1;
        reroadpagetitle_h();
        getDataForH();
        document.getElementById("sel_page_h").value = currentPage_h;
    }
    function lastPage_h() {
        if (currentPage_h == totalPage_h) {
            return;
        }
        currentPage_h = totalPage_h;
        reroadpagetitle_h();
        getDataForH();
        document.getElementById("sel_page_h").value = currentPage_h;
    }
    function tzpage_h() {

        var sel = document.getElementById("sel_page_h").value;

        if (sel == currentPage_h) {
            return;
        }
        currentPage_h = sel;
        reroadpagetitle_h();
        getDataForH();
        document.getElementById("sel_page_h").value = currentPage_h;
    }
    
</script>
</html>
