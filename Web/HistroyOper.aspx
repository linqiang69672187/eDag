<%--、/***
 * 功能:用户历史轨迹控制面板
 * 公司:东方通信
 * 作者:杨德军
 * 时间:2011-06-03
 * 
 */--%>
<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HistroyOper.aspx.cs" Inherits="Web.HistroyOper" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link href="CSS/Default.css" rel="stylesheet" type="text/css" />
    <link href="CSS/lq_style.css" rel="stylesheet" type="text/css" />
    <link href="CSS/ui-lightness/demos.css" rel="stylesheet" type="text/css" />
    <link href="CSS/ui-lightness/jquery-ui-1.8.13.custom.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" href="pro_dropdown_2/pro_dropdown_2.css" />
    <script src="JQuery/jquery-1.5.2.js" type="text/javascript"></script>
    <script src="JQuery/jquery-ui-1.8.13.custom.min.js" type="text/javascript"></script>
    <script src="My97DatePicker/WdatePicker.js" type="text/javascript"></script>
    <script src="JQuery/ui.datepicker-zh-CN.js" type="text/javascript"></script>   
    <script src="JS/LangueSwitch.js" type="text/javascript"></script>
    <script src="lqnew/js/LanuageXmlToJson.js" type="text/javascript"></script>
   <%-- <script src="lqnew/js/init.js" type="text/javascript"></script>--%>
    <script src="lqnew/js/PointIn.js" type="text/javascript"></script>
    <script src="lqnew/js/Stockade.js" type="text/javascript"></script>
    <script src="lqnew/js/DrawPolygon.js" type="text/javascript"></script>
    <script src="lqnew/js/BaseStation.js" type="text/javascript"></script>
    <script src="lqnew/js/PoliceStation.js" type="text/javascript"></script>
    <script src="lqnew/js/List.js" type="text/javascript"></script>
    <script src="lqnew/js/DefaultJS.js" type="text/javascript"></script>
    <script src="lqnew/js/DrawOval.js" type="text/javascript"></script>
    <script src="lqnew/js/PlayerJS.js" type="text/javascript"></script>
    <script src="lqnew/js/GlobalConst.js" type="text/javascript"></script>
    <script src="MyCommonJS/ajax.js" type="text/javascript"></script>
    <script type="text/javascript">
        document.oncontextmenu = new Function('event.returnValue=false;');
        document.onselectstart = new Function('event.returnValue=false;');
        function showRrestart() {
           // alert("进入"); return;
            $("#Continues").css("display", "none");
            $("#stop").css("display", "none");
        }
        function showNextPage() {
            $("#Continues").css("display", "none");
            $("#stop").css("display", "block");
        }
        $(document).ready(function () {
            //$("#begTime").datepicker({ dateFormat: 'yy-mm-dd', changeMonth: true, changeYear: true });
            //$("#endTime").datepicker({ dateFormat: 'yy-mm-dd', changeMonth: true, changeYear: true });

            $("#SelTime").bind("change", function () {
                window.parent.ChangeTime($("#SelTime").val());
            });
            $("#SelPlayGHz").bind("change", function () {
                window.parent.ChanageHZ($("#SelPlayGHz").val());
            });
            //            $("#stop").click(function () {
            //                $("#Continues").css("display", "block");
            //                $("#stop").css("display", "none");
            //                window.parent.stopPlay();
            //            })
            //            $("#Continues").click(function () {
            //                $("#stop").css("display", "block");
            //                $("#Continues").css("display", "none");
            //                window.parent.continuePlay();
            //            })
            $("#showAll").click(function () {
                showRrestart();
                window.parent.ShowAllHitory();
            })
            $("#restart").click(function () {
                onclick = window.parent.location.reload();
                //                            $("#stop").css("display", "block");
                //                            $("#Continues").css("display", "none");
                //                            window.parent.reStartHistory();
            })
            //            $("#SelLimit").bind("change", function () {
            //                window.parent.SelLimitChanage();
            //                $("#stop").css("display", "block");
            //                window.parent.reStartHistory();
            //            })
            $("#closeDiv").click(function () {

                window.parent.HideDivMB();
            });
            $("#cbAutoPlay").bind("change", function () {
                if ($("#cbAutoPlay").attr("checked")) {
                    window.parent.ChanageAutoPlay("true");
                } else {
                    window.parent.ChanageAutoPlay("false");
                }
            });
            $("#cbZDGZ").bind("change", function () {
                if ($("#cbZDGZ").attr("checked")) {
                    window.parent.ChanageZdgz("true");
                } else {
                    window.parent.ChanageZdgz("false");
                }
            });
            //            $("input[name='ZDGZ'][type='radio']").bind("change", function () {
            //                var ZDGZ = $("input[name='ZDGZ'][type='radio']:checked").val();
            //                window.parent.ChanageZdgz(ZDGZ);
            //            })
        });
        function getlanguage() {
            var param = {
                "id": "0"
            };
            jquerygetNewData_ajax("WebGis/Service/LanuageXmlToJson.aspx", param, function (request) {
                if (request != null) {
                    langdata = request.root.resource;
                }
               
                document.getElementById("playbegintime").innerHTML = GetTextByName("playbegintime", langdata);
                document.getElementById("playendtime").innerHTML = window.GetTextByName("playendtime", langdata);
                document.getElementById("playintervaltime").innerHTML = window.GetTextByName("playintervaltime", langdata);
                document.getElementById("showAll").innerHTML = window.GetTextByName("quickviewtrace", langdata);
                document.getElementById("restart").innerHTML = window.GetTextByName("restart", langdata);
                document.getElementById("stop").innerHTML = window.GetTextByName("stop", langdata);
                
                document.getElementById("Continues").innerHTML = window.GetTextByName("Continues", langdata);
                document.getElementById("Lang_0.1second").innerHTML = window.GetTextByName("Lang_0.1second", langdata);
                document.getElementById("Lang_0.2second").innerHTML = window.GetTextByName("Lang_0.2second", langdata);
                document.getElementById("Lang_0.3second").innerHTML = window.GetTextByName("Lang_0.3second", langdata);
                document.getElementById("Lang_0.4second").innerHTML = window.GetTextByName("Lang_0.4second", langdata);
                document.getElementById("Lang_0.5second").innerHTML = window.GetTextByName("Lang_0.5second", langdata);
                document.getElementById("Lang_1second").innerHTML = window.GetTextByName("Lang_1second", langdata);
                document.getElementById("Lang_2second").innerHTML = window.GetTextByName("Lang_2second", langdata);
                document.getElementById("Lang_3second").innerHTML = window.GetTextByName("Lang_3second", langdata);
                document.getElementById("Lang_4second").innerHTML = window.GetTextByName("Lang_4second", langdata);
                document.getElementById("Lang_5second").innerHTML = window.GetTextByName("Lang_5second", langdata);

            }, false, false);
        }

    </script>
</head>
<body style="font-size:12px; font-family:Arial">
    <form id="form1" runat="server">
    <div>
        <table>
            <%-- <tr>
                <td colspan="3">
                    历史轨迹回放用户对象为admin
                </td>
            </tr>--%>
            <tr>
                <td width="40%" id="playbegintime">
                    <%--播放开始时间--%>
                </td>
                <td colspan="2">                                                         
                    <input type="text" disabled="disabled" style="width: 120px; height: 13px" id="begTime" readonly="readonly" /> 
                </td>
            </tr>
            <tr>
                <td width="40%" id="playendtime">
                    <%--播放结束时间--%>
                </td>
                <td colspan="2">
  
                    <input type="text" disabled="disabled" style="width: 120px; height: 13px" id="endTime" readonly="readonly" />
                </td>
            </tr>
           <tr style="display:none">
                <td width="40%" id="playintervaltime">
                    <%--播放时间间隔--%>
                </td>
                <td colspan="2">
                    <select id="SelTime"  display="false" style="height: 20px">
                        <option selected="selected" value="100" id="Lang_0.1second"><%--0.1秒--%></option>
                                            <option value="200" id="Lang_0.2second"><%--0.2秒--%></option>
                                            <option value="300" id="Lang_0.3second"><%--0.3秒--%></option>
                                            <option value="400" id="Lang_0.4second"><%--0.4秒--%></option>
                                                <option value="500" id="Lang_0.5second"><%-->0.5秒--%></option>
                                                <option value="1000" id="Lang_1second"><%--1秒--%></option>
                                                <option value="2000" id="Lang_2second"><%--2秒--%></option>
                                                <option value="3000" id="Lang_3second"><%--3秒--%></option>
                                                <option value="4000" id="Lang_4second"><%--4秒--%></option>
                                                <option value="5000" id="Lang_5second"><%--5秒--%></option>
                    </select>
                </td>
            </tr>
<%--            <tr>
                <td width="40%">
                    播放时间密度:
                </td>
                <td colspan="2">
                    <select id="SelPlayGHz" style="width: 60px; height: 20px">
                        <option value="1">1分钟</option>
                        <option value="2">2分钟</option>
                        <option value="5">5分钟</option>
                        <option value="10">10分钟</option>
                        <option value="20">20分钟</option>
                        <option value="30">30分钟</option>
                        <option value="60">60分钟</option>
                    </select>
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td width="40%">
                    每页显示条数:
                </td>
                <td colspan="2">
                    <select id="SelLimit" style="width: 60px; height: 20px">
                        <option value="50">50条</option>
                        <option selected="selected" value="100">100条</option>
                        <option value="200">200条</option>
                        <option value="300">300条</option>
                        <option value="400">400条</option>
                        <option value="500">500条</option>
                    </select>
                  
                </td>
            </tr>
            <tr>
                <td width="40%" colspan="3">
                    自动播放下一页
                    <input type="checkbox" id="cbAutoPlay" />
                    &nbsp; 跟踪轨迹
                    <input type="checkbox" id="cbZDGZ" />
                </td>
            </tr>--%>
            <tr id="tr_btn" style="display:none">
                <td align="left">
                    <span id="showAll" style=" cursor:hand; border-bottom:1px solid #999999; border-top:1px solid #999999;border-left:1px solid #999999; border-right:1px solid #999999;"><%--快速显示所有轨迹--%></span>
                </td>
                <td align="left" colspan="2">
                    <table width="100%">
                        <tr>
                            <td width="40%" align="center">
                                <span id="restart" style=" display:block; border-bottom:1px solid #999999; border-top:1px solid #999999;border-left:1px solid #999999; border-right:1px solid #999999; cursor: hand;"><%--重新开始--%></span>
                            </td>
                            <td width="20%" align="center">
                                <span id="stop" style=" display:none; border-bottom:1px solid #999999; border-top:1px solid #999999;border-left:1px solid #999999; border-right:1px solid #999999;cursor: hand" onclick=""><%--停止--%></span> <span id="Continues" style="border-bottom:1px solid #999999; border-top:1px solid #999999;border-left:1px solid #999999; border-right:1px solid #999999;cursor: hand;display: none"><%--继续--%></span>
                            </td>
                            <td align="left" width="40%">
                                <span style="cursor: hand" id="closeDiv"><img src="WebGis/images/icon_goright.gif" /></span>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
    </form>
</body>
    <script type="text/javascript">
     
            //LanguageSwitch(window.parent);
            //window.document.getElementById("playbegintime").innerHTML = window.GetTextByName("playbegintime", useprameters.languagedata);        
             getlanguage();

            //document.getElementById("playbegintime").innerHTML = GetTextByName("playbegintime", useprameters.languagedata);      
            //window.document.getElementById("playendtime").innerHTML = window.GetTextByName("playendtime", window.useprameters.languagedata);
            //window.document.getElementById("playintervaltime").innerHTML = window.GetTextByName("playintervaltime", window.useprameters.languagedata);
            //window.document.getElementById("showAll").innerHTML = window.GetTextByName("quickviewtrace", window.useprameters.languagedata);
            //window.document.getElementById("restart").innerHTML = window.GetTextByName("restart", window.useprameters.languagedata);
            //window.document.getElementById("stop").innerHTML = window.GetTextByName("stop", window.useprameters.languagedata);
  
    </script>
</html>
