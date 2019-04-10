<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MultiCall.aspx.cs" Inherits="Web.lqnew.MultiCall" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../css/lq_addedit.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/pagestyle.css" rel="stylesheet" type="text/css" />
    <script src="../js/geturl.js" type="text/javascript"></script>
    <script src="../../JQuery/jquery-1.5.2.js" type="text/javascript"></script>
    <style type="text/css">
        #multiinput
        {
            font-size: 12px;
            border: 1px #000 solid;
            font-weight: 700;
            height: 105px;
            width: 270px;
            overflow-y: auto;
        }
        span
        {
            color: Blue;
            cursor: hand;
        }
        
        #multiinput a:hover
        {
            background-color: #eee;
            cursor: text;
        }
    </style>
    <script type="text/javascript">
        var flag = false;

        function CloseWindow() {
            if (flag) {
                alert("此呼叫未结束");
                return;
            }
            window.parent.mycallfunction('MultiCall');
        }
        function PTTGCALL() {
           // alert(userids);
        }
        function CEASEDGCALL() {

        }
        function ENDCALL() {
        }

        var userids = ""; //用户列表 用逗号隔开 用来传递给后台的 格式为：id1;id2;id3
        var uinfo = ""; //用户名,id;用户名,id
        var userInfos = new Array();
        /**@提供给选择页面调用***/
        function PickerDo(arrR) {

            userInfos.length = 0;
            uinfo = "";
            userids = "";
            for (var i in arrR) {
                userids += arrR[i].split(",")[1] + ";";
                uinfo += arrR[i] + ";";
            }
            if (uinfo.length > 0) {
                uinfo = uinfo.substring(0, uinfo.length - 1);
                userids = userids.substring(0, userids.length - 1);
            }
            //uinfo = strR;
            showUserInfo();
        }
        function showUserInfo() {
            var strShow = "";
            userInfos.length = 0;
            userids = "";
            if (uinfo.indexOf(";") <= 0) {
                if (uinfo.split(',')[0] != "") {
                    strShow = uinfo.split(',')[0] + "<span style='cursor:hand' onclick=\"DeleteArray('" + uinfo + "')\"><img class='style6' onmouseover=\"javascript:this.src='../images/close_un.png';\" onmouseout=\"javascript:this.src='../images/close.png';\" src=\"../images/close.png\" /></span> &nbsp;&nbsp;";
                    userids = uinfo.split(',')[1];
                    userInfos.push(uinfo);

                }
            }
            else {
                var parr = uinfo.split(";");
                for (var pa in parr) {
                    userInfos.push(parr[pa]);
                    if (parr[pa].split(',')[0] != "") {
                        strShow += parr[pa].split(',')[0] + "<span style='cursor:hand' onclick=\"DeleteArray('" + parr[pa] + "')\"><img class='style6' onmouseover=\"javascript:this.src='../images/close_un.png';\" onmouseout=\"javascript:this.src='../images/close.png';\" src=\"../images/close.png\" /></span> &nbsp;&nbsp;";
                        userids += parr[pa].split(',')[1] + ";";
                    }
                }
                if (userids.length > 0) {
                    userids = userids.substring(0, userids.length - 1);
                }
            }
            $('#multiinput').html(strShow);


        }
        function DeleteArray(infos) {

            userids = "";
            uinfo = "";
            for (var k in userInfos) {
                if (infos != userInfos[k]) {
                    userids += userInfos[k].split(',')[1] + ";";
                    uinfo += userInfos[k] + ";";
                }
            }
            if (uinfo.length > 0) {
                uinfo = uinfo.substring(0, uinfo.length - 1);
                userids = userids.substring(0, userids.length - 1);
            }
            showUserInfo();
        }
        $(document).ready(function () {
            uinfo = $('#<%=txtUsers.ClientID %>').val();
            showUserInfo();
            $("#imgSelectUser").click(function () {
                window.parent.visiablebg();
                window.parent.mycallfunction('Add_StackMember/add_Member', 635, 514, userids + "&ifr=MultiCall_ifr", 2001);

            });

            $("#divdrag").mousedown(function () {
                dragdiv();
            });
            $("#divdrag").mousemove(function () {
                mydragWindow();
            });
            $("#divdrag").mouseup(function () {
                mystopDragWindow();
            });
            document.body.oncontextmenu = function () { return false; };
        })
        var dragEnable = 'True';
        function dragdiv() {
            var div1 = window.parent.document.getElementById(geturl());
            if (div1 && event.button == 0 && dragEnable == 'True') {
                window.parent.mystartDragWindow(div1, null, event); div1.style.border = "solid 3px transparent"; window.parent.cgzindex(div1);

            }
        }
        function mydragWindow() {
            var div1 = window.parent.document.getElementById(geturl());
            if (div1) {
                window.parent.mydragWindow(div1, event);
            }
        }
        function mystopDragWindow() {
            var div1 = window.parent.document.getElementById(geturl());
            if (div1) {
                window.parent.mystopDragWindow(div1); div1.style.border = "0px";
            }
        }
    </script>
</head>
<body>
    <div>
        <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
            <tr>
                <td height="30">
                    <div id="divdrag" style="cursor:move">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td width="15" height="32">
                                    <img src="../images/tab_03.png" width="15" height="32" />
                                </td>
                                <td width="1101" background="../images/tab_05.gif">
                                    <ul class="hor_ul">
                                        <li>
                                            <img src="../images/037.gif" />多选组呼叫</li>
                                    </ul>
                                </td>
                                <td width="281" background="../images/tab_05.gif" align="right">
                                    <img class="style6" style="cursor: hand;" onclick="CloseWindow()" onmouseover="javascript:this.src='../images/close_un.png';"
                                        onmouseout="javascript:this.src='../images/close.png';" src="../images/close.png" />
                                </td>
                                <td width="14">
                                    <img src="../images/tab_07.png" width="14" height="32" />
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td width="15" background="../images/tab_12.gif">
                                &nbsp;
                            </td>
                            <td align="center">
                                <table class="style1" cellspacing="1" id="dragtd">
                                    <tr>
                                        <td class="style3" align="right" style="width: 90px;">
                                            <div id="divIssiTitle">
                                                多选组ID：</div>
                                        </td>
                                        <td class="style3" align="left">
                                            <input type="text" id="txtPatchIDText" runat="server" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="style3" align="center" style="width: 90px;">
                                            多选组成员：
                                            <img src="../images/btn_add.png" id="imgSelectUser" onmouseover="javascript:this.src='../images/btn_add_un.png';"
                                                onmouseout="javascript:this.src='../images/btn_add.png';" />&nbsp;
                                        </td>
                                        <td class="style3" align="left">
                                            <div style="display: none">
                                                <textarea type="text" id="txtUsers" style="height: 100%; width: 90%" rows="3" runat="server"></textarea>
                                            </div>
                                            <div id="multiinput">
                                                &nbsp;</div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="style3" align="right" style="width: 60px;">
                                            状态：
                                        </td>
                                        <td class="style3" align="left">
                                            <div id="divstatue">
                                                无</div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="style3" align="center" colspan="2">
                                            <button id="Button5" style="width: 100px; text-align: center; vertical-align: bottom"
                                                onmousedown="PTTGCALL()" onmouseup="CEASEDGCALL()">
                                                PTT
                                            </button>
                                            &nbsp;&nbsp;
                                            <button id="Button7" style="width: 100px; text-align: center" onclick="ENDCALL()">
                                                结束
                                            </button>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td width="14" background="../images/tab_16.gif">
                                &nbsp;
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
                                        <td width="25%" nowrap="nowrap">
                                            &nbsp;
                                        </td>
                                        <td width="75%" valign="top" class="STYLE1">
                                            &nbsp;
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
</body>
</html>
<script>    window.parent.closeprossdiv();</script>
<link href="../../CSS/lq_calloutExtender.css" rel="stylesheet" type="text/css" />
