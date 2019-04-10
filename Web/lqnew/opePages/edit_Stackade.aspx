<%@ Page Language="C#" AutoEventWireup="true" ValidateRequest="false" CodeBehind="edit_Stackade.aspx.cs"
    Inherits="Web.lqnew.opePages.edit_Stackade" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"> 
<head id="Head1" runat="server">
    <title></title>
    <script src="../../JQuery/jquery-1.5.2.js" type="text/javascript"></script>
    <link href="../css/lq_addedit.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/pagestyle.css" rel="stylesheet" type="text/css" />
    <script src="../js/geturl.js" type="text/javascript"></script>
    <script src="../js/dragwindow.js" type="text/javascript"></script>
    <script src="../../JQuery/jquery-1.5.2.js" type="text/javascript"></script>
    <script src="../../LangJS/managerGroup_langjs.js" type="text/javascript"></script>
    <style type="text/css">
        #multiinput
        {
            font-size: 12px;
            border: 1px #000 solid;
            font-weight: 700;
            height: 105px;
            width: 300px;
            overflow-y: auto;
        }

        span
        {
            cursor: pointer;
        }

        #multiinput a:hover
        {
            background-color: #eee;
            cursor: text;
        }
    </style>
    <script type="text/javascript">
        var memberlimitcount = window.parent.fenceMemberCount;
        var SelectUsers = new Array();
        var myUsers = new Array(); //存放用户格式为：用户名,id 用来存放有多少个
        var strRead = ""; //最后反馈给后台的 格式为：用户名,id;用户名,id
        //提供给picker页面使用
        /**@提供给选择页面调用***/
        function faterdo(arrR) {
            myUsers.length = 0;
            strRead = "";
            for (var i in arrR) {
                strRead += arrR[i].uname + "," + arrR[i].id + "," + arrR[i].uissi + ";";
            }
            if (strRead.length > 0) {
                strRead = strRead.substring(0, strRead.length - 1);
            }
            //uinfo = strR;
            ShowInfo();
        }
        /***@在用户框内显示用户信息，并把需要传给后台的值赋值给strRead变量****/
        function ShowInfo() {
            var strResult = "";/**@临时存放显示用户框用户信息的变量***/
            var arr = strRead.split(';'); /**@存放用户的数组，将选中的用户或者上个页面传过来的用户存放到此变量中***/
            strRead = "";/**@将返回结果清空，防止重复叠加，此前已经将结果转化为数组存放在arr变量值了**/
            myUsers.length = 0; /**@将存放返回用户数组清空，防止重复叠加**/
            for (var p in arr) {
                if (arr[p] == "") break;
                strRead += arr[p] + ";";
                var myar = arr[p].split(',');
                strResult += myar[0] + "<span style='cursor:hand' onclick=\"DeleteArray('" + arr[p] + "')\"><img class='style6' onmouseover=\"javascript:this.src='../images/close_un.png';\" onmouseout=\"javascript:this.src='../images/close.png';\" src=\"../images/close.png\" /></span> &nbsp;&nbsp;";
                myUsers.push(arr[p]);
            }
            if (strRead.length > 0)
                strRead = strRead.substring(0, strRead.length - 1);

            $('#multiinput').html(strResult);
            $('#<%=txtUsers.ClientID %>').val(strRead);
           
        }
        $(document).ready(function () {
            $("#imgSelectUser").click(function () {


                SelectUsers.length = 0;
               var myusers = strRead.split(";"); 
                //for (var i in myusers) {
                //    try {
                //        var mname = myusers[i].split(",")[0];
                 //       var mid = myusers[i].split(",")[1];
                //        var missi = myusers[i].split(",")[2];

                //        if (missi != undefined && mname != undefined) {
                 //           SelectUsers.push({ uname: mname, uissi: missi, utype: 'memb', id: mid });
                 //       }
                 //   } catch (ex) {

                 //   }
                // }
                for (var i in myusers) {
                    try {

                        var mname = myusers[i].split(",")[0];
                        var mid = myusers[i].split(",")[1];
                        var missi = myusers[i].split(",")[2];
                        if (missi != undefined && mname != undefined) {
                            $.ajax({
                                type: "POST",
                                url: "../../Handlers/GetUserInfo_Handler.ashx",
                                data: "issi=" + missi,
                                success: function (msg) {
                                    var my = eval(msg);
                                    usertype = escape(my[0].type);
                                    if (my[0].nam != undefined) {
                                        SelectUsers.push({
                                            uname: my[0].nam, uissi: my[0].issi, utype: my[0].type, issitype: my[0].issitype
                                        })
                                    }

                                }
                            });
                        }
                    } catch (ex) {

                    }
                }
                window.parent.mycallfunction('AddMemberTree/add_Member', 650, 514, '0&ifr=edit_Stackade_ifr&selectcount=' + memberlimitcount + '&type=user&selfclose=1', 2001);
            });
            setTimeout(function () {
                strRead = $('#<%=txtUsers.ClientID %>').val();
                ShowInfo();
            }, 500);
        })
            /***@将跟参数相同的项从数组中移除***/
            function DeleteArray(user) {
                strRead = "";
              
                for (var p in myUsers) {
                    if (myUsers[p] != user) {
                        strRead += myUsers[p] + ";";
                    }
                }
                if (strRead.length > 0)
                    strRead = strRead.substring(0, strRead.length - 1);
                ShowInfo();//移除完后 重新刷新下用户显示框。刷新完后 存放用户的数组 也是移除后的数组了
            }

            function ValidatorClick() {
                if ($("#txtUsers").val() == "") {
                    alert(window.parent.GetTextByName("Lang_please_select_user", window.parent.useprameters.languagedata));
                    return false;
                }
                else {
                    window.parent.writeLog("oper", "[" + window.parent.GetTextByName("Stack", window.parent.useprameters.languagedata) + "]:" + window.parent.GetTextByName("editstock") + "[" + window.parent.LOGTimeGet() + "]");
                    return true;
                }
            }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
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
                                        <li>
                                            <img src="../images/037.gif" /><span class="Langtxt" id="Modify"></span></li>
                                    </ul>
                                </td>
                                <td width="281" background="../images/tab_05.gif" align="right">
                                    <img class="style6" style="cursor: pointer;" onclick="window.parent.mycallfunction('edit_Stackade')"
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
                                            <td colspan="2" align="left" style="background-image: url(../images/add_entity_infobg.png); height: 33;">
                                                <div style="background-image: url(../images/add_entity_info.png); width: 109px; height: 23px;">
                                                    <div style="margin-left: 34px; font-size: 14px; font-weight: bold; color: #006633; padding-top: 5px;">
                                                        <span class="Langtxt" id="zlxx"></span>
                                                    </div>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="style3" align="right" style="width: 80px;">
                                                <span class="Langtxt" id="creater"></span>&nbsp;&nbsp;
                                            </td>
                                            <td class="style3" align="left">
                                                <asp:Label ID="lbCreateUser" runat="server"></asp:Label>
                                                <asp:HiddenField ID="DivID" runat="server" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="style3" align="right">
                                                <span class="Langtxt" id="createtime"></span>&nbsp;&nbsp;
                                            </td>
                                            <td align="left" class="style3">
                                                <asp:Label ID="lbCreateTime" runat="server"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="style3" align="right">
                                                <span class="Langtxt" id="title"></span>&nbsp;&nbsp;
                                            </td>
                                            <td align="left" class="style3">
                                                <asp:Label ID="labTitle" runat="server"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="style3" align="center">
                                                <span class="Langtxt" id="usermember"></span><br />
                                            <img src="" id="imgSelectUser" onmouseover="" onmouseout="" />
                                            </td>
                                            <td align="left">
                                                <div style="display: none">
                                                    <textarea type="text" id="txtUsers" style="height: 100%; width: 90%" rows="3" runat="server"></textarea>
                                                </div>
                                                <div id="multiinput">
                                                    &nbsp;
			                   
                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td width="14" background="../images/tab_16.gif">&nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td width="15" background="../images/tab_12.gif">&nbsp;
                                </td>
                                <td align="center" height="30">
                                    <asp:ImageButton ID="ImageButton1" runat="server" OnClientClick="return ValidatorClick()"
                                        OnClick="ImageButton1_Click" />&nbsp;&nbsp;&nbsp;
                                <img  style="cursor: pointer;" onclick="window.parent.mycallfunction('edit_Stackade')"
                                    id="Lang-Cancel" />
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
<script type="text/javascript">    window.parent.closeprossdiv();
    var image = window.document.getElementById("imgSelectUser");
    var srouce = window.parent.parent.GetTextByName("Lang_chooseMemberPNG", window.parent.parent.useprameters.languagedata);
    image.setAttribute("src", srouce);
    var imageCancel = window.document.getElementById("Lang-Cancel");
    imageCancel.src = window.parent.parent.GetTextByName("Lang-Cancel", window.parent.parent.useprameters.languagedata);
    var strpath = window.parent.parent.GetTextByName("Lang_chooseMemberPNG", window.parent.parent.useprameters.languagedata);
    var strpathmove = window.parent.parent.GetTextByName("Lang_chooseMemberPNG_un", window.parent.parent.useprameters.languagedata);
    image.onmouseover = function () { this.src = strpathmove }
    image.onmouseout = function () { this.src = strpath }

</script>
<link href="../../CSS/lq_calloutExtender.css" rel="stylesheet" type="text/css" />
