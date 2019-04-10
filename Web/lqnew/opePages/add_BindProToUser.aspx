<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="add_BindProToUser.aspx.cs" Inherits="Web.lqnew.opePages.add_BindProToUser" %>


<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link href="../css/lq_addedit.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/pagestyle.css" rel="stylesheet" type="text/css" />
    <script src="../js/geturl.js" type="text/javascript"></script>
    <script src="../js/dragwindow.js" type="text/javascript"></script>
    <script src="../../JQuery/jquery-1.5.2.js"></script>
    <style type="text/css">
        #multiinput {
            font-size: 12px;
            position: relative;
            left: 0px;
            top: 0px;
            border: 1px #000 solid;
            font-weight: 700;
            height: 105px;
            width: 292px;
            overflow-y: auto;
        }
            /*span
        {
            color: Blue;
            cursor: hand;
        }*/

            #multiinput a:hover {
                background-color: #eee;
                cursor: text;
            }
    </style>
    <script type="text/javascript">
        function todo() {
            var image = window.document.getElementById("imgSelectISSI");
            var srouce = window.parent.parent.GetTextByName("Lang_chooseMemberPNG", window.parent.parent.useprameters.languagedata);
            image.setAttribute("src", srouce);
            var strpath = window.parent.parent.GetTextByName("Lang_chooseMemberPNG", window.parent.parent.useprameters.languagedata);
            var strpathmove = window.parent.parent.GetTextByName("Lang_chooseMemberPNG_un", window.parent.parent.useprameters.languagedata);
            image.onmouseover = function () { this.src = strpathmove }
            image.onmouseout = function () { this.src = strpath }
        }

        var SelectUsers = new Array();

        var myMemberArray = new Array(); //存放发短信的数组，格式为:[{name:name,issi:issi,type,编组}]
        function faterdo(results) {


            myMemberArray.length = 0;
            for (var i = 0; i < results.length; i++) {
                myMemberArray.push({ name: results[i].uname, issi: results[i].uissi, type: results[i].utype });
            }
            window.parent.hiddenbg2();
            showTitle();
        }
        //每一次显示前 清空重新生成
        function showTitle() {
            var uidlist = "";
            var strRes = "";
            for (var i = 0; i < myMemberArray.length; i++) {
                uidlist += myMemberArray[i].issi + ";";
                strRes += "<span id='span_member_'" + i + ">" + myMemberArray[i].name + "(" + myMemberArray[i].issi + ")" + "<span style='cursor:hand' onclick=\"DeleteArray('" + i + "')\"><img class='style6'  src=\"../images/close.png\" /></span></span> &nbsp;&nbsp;"
            }
            $("#txtISSI").val(strRes);
            if (strRes == "")
                strRes = "&nbsp;";
            $("#multiinput").html(strRes);
            document.getElementById("txtISSIValue").value = uidlist;
        }

        function DeleteArray(i) {
            myMemberArray.splice(i, 1);
            showTitle();
        }
        function selectUsers() {
            flags = true;
            window.parent.visiablebg2();
            SelectUsers.length = 0;
            for (var i = 0; i < myMemberArray.length; i++) {
                SelectUsers.push({ uname: myMemberArray[i].name, uissi: myMemberArray[i].issi, utype: myMemberArray[i].type });
            }
            window.parent.mycallfunction('AddMemberTree/add_Member', 650, 514, '0&ifr=add_BindProToUser_ifr&selectcount=100&type=user&selfclose=1', 2001);
        }
        function test() {
            //alert(document.getElementById("txtISSIValue").value);
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
                                            <img onclick="test()" src="../images/001.gif" /><asp:Label ID="lb_Uylcbd" runat="server"></asp:Label></li>
                                    </ul>
                                </td>
                                <td width="281" background="../images/tab_05.gif" align="right">
                                    <!---------------------------xzj--2018/6/28--注释原来的，新的将原来onclick的CloseJWD()函数删除------------------>
                                    <!--<img class="style6" style="cursor: hand;" onclick="fresh_manageUserDutyList();window.parent.CloseJWD();window.parent.mycallfunction(geturl());"
                                        onmouseover="javascript:this.src='../images/close_un.png';" onmouseout="javascript:this.src='../images/close.png';"
                                        src="../images/close.png" />-->
                                    <img class="style6" style="cursor: hand;" onclick="fresh_manageUserDutyList();window.parent.mycallfunction(geturl());"
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
                                <td align="center" id="dragtd">
                                    <fieldset>
                                        <legend><asp:Label ID="Lang_userselect" runat="server"></asp:Label></legend>
                                        <table class="style1" cellspacing="1">
                                            <tr style="height: 90px">
                                                <td class="style3" align="right" style="width: 90px;">
                                                    <asp:Label ID="lb_Userselect" runat="server"></asp:Label>&nbsp;&nbsp;<br />
                                                    <img onclick="selectUsers()" id="imgSelectISSI" />&nbsp;&nbsp;<br />
                                                    <asp:Label ID="Lang_onlycanselect" runat="server"></asp:Label>
                                                </td>
                                                <td align="left" class="style3">
                                                    <div style="display: none">
                                                        <textarea type="text" id="txtISSI" style="height: 100%; width: 90%" rows="3" runat="server"></textarea>
                                                        <input type="text" id="txtISSIValue" runat="server" />
                                                        <input type="text" id="txtISSIText" runat="server" />
                                                    </div>
                                                    <div id="multiinput">
                                                        &nbsp; <a id="t"></a>
                                                    </div>
                                                </td>
                                            </tr>
                                        </table>
                                    </fieldset>
                                    <fieldset>
                                        <legend><asp:Label ID="Lang_baseinfowrite" runat="server"></asp:Label></legend>
                                        <div style="width: 100%; height: 120px; overflow: auto">
                                            <asp:UpdatePanel ID="UpdatePanel1" runat="server">

                                                <ContentTemplate>
                                                    <table class="style1" cellspacing="1">

                                                        <tr>
                                                            <td class="style3" align="right" style="width: 90px;">
                                                                <asp:Label ID="lb_lcbd" runat="server"></asp:Label>&nbsp;&nbsp;
                                                            </td>
                                                            <td align="left" class="style3">

                                                                <asp:DropDownList AutoPostBack="true" ID="ddl_LC" runat="server" OnSelectedIndexChanged="ddl_LC_SelectedIndexChanged"></asp:DropDownList>
                                                            </td>
                                                        </tr>

                                                        <tr runat="server" id="Tr1">
                                                            <td class="style3" align="right">
                                                                <asp:Label ID="Label1" runat="server"></asp:Label>&nbsp;&nbsp;
                                                            </td>
                                                            <td align="left">
                                                                <asp:TextBox runat="server" ID="TextBox1"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr runat="server" id="Tr2">
                                                            <td class="style3" align="right" style="width: 90px;">
                                                                <asp:Label ID="Label2" runat="server"></asp:Label>&nbsp;&nbsp;
                                                            </td>
                                                            <td align="left" class="style3">
                                                                <asp:TextBox runat="server" ID="TextBox2"></asp:TextBox>

                                                            </td>
                                                        </tr>
                                                        <tr runat="server" id="Tr3">
                                                            <td class="style3" align="right" style="width: 90px;">
                                                                <asp:Label ID="Label3" runat="server"></asp:Label>&nbsp;&nbsp;
                                                            </td>
                                                            <td align="left" class="style3">
                                                                <asp:TextBox runat="server" ID="TextBox3"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr runat="server" id="Tr4">
                                                            <td class="style3" align="right" style="width: 90px;">
                                                                <asp:Label ID="Label4" runat="server"></asp:Label>&nbsp;&nbsp;
                                                            </td>
                                                            <td align="left" class="style3">
                                                                <asp:TextBox runat="server" ID="TextBox4"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr runat="server" id="Tr5">
                                                            <td class="style3" align="right" style="width: 90px;">
                                                                <asp:Label ID="Label5" runat="server"></asp:Label>&nbsp;&nbsp;
                                                            </td>
                                                            <td align="left" class="style3">
                                                                <asp:TextBox runat="server" ID="TextBox5"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr runat="server" id="Tr6">
                                                            <td class="style3" align="right" style="width: 90px;">
                                                                <asp:Label ID="Label6" runat="server"></asp:Label>&nbsp;&nbsp;
                                                            </td>
                                                            <td align="left" class="style3">
                                                                <asp:TextBox runat="server" ID="TextBox6"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr runat="server" id="Tr7">
                                                            <td class="style3" align="right" style="width: 90px;">
                                                                <asp:Label ID="Label7" runat="server"></asp:Label>&nbsp;&nbsp;
                                                            </td>
                                                            <td align="left" class="style3">
                                                                <asp:TextBox runat="server" ID="TextBox7"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr runat="server" id="Tr8">
                                                            <td class="style3" align="right" style="width: 90px;">
                                                                <asp:Label ID="Label8" runat="server"></asp:Label>&nbsp;&nbsp;
                                                            </td>
                                                            <td align="left" class="style3">
                                                                <asp:TextBox runat="server" ID="TextBox8"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr runat="server" id="Tr9">
                                                            <td class="style3" align="right" style="width: 90px;">
                                                                <asp:Label ID="Label9" runat="server"></asp:Label>&nbsp;&nbsp;
                                                            </td>
                                                            <td align="left" class="style3">
                                                                <asp:TextBox runat="server" ID="TextBox9"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr runat="server" id="Tr10">
                                                            <td class="style3" align="right" style="width: 90px;">
                                                                <asp:Label ID="Label10" runat="server"></asp:Label>&nbsp;&nbsp;
                                                            </td>
                                                            <td align="left" class="style3">
                                                                <asp:TextBox runat="server" ID="TextBox10"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                    </table>

                                                </ContentTemplate>
                                            </asp:UpdatePanel>

                                        </div>
                                    </fieldset>
                                     <asp:UpdatePanel ID="UpdatePanel2" runat="server">

                                        <ContentTemplate>
                                            <fieldset>
                                                <legend><asp:Label runat="server" ID="Lang_opeResultArea"></asp:Label></legend>
                                                <table class="style1" cellspacing="1">

                                                    <tr>
                                                        <td class="style3" align="left" style="height: 120px; overflow:auto">
                                                            <div style="height:110px;overflow:auto">
                                                           <asp:Label ID="lbpress" runat="server"></asp:Label>
                                                                </div>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </fieldset>
                                            <table>
                                                <tr>
                                                    <td>


                                                        <asp:ImageButton ID="ImageButton1" runat="server"
                                                            OnClick="ImageButton1_Click" />&nbsp;&nbsp;&nbsp;
                                                 
                              
                                                  
                                                    </td>
                                                    <td>
                                                    <!---------------------------xzj--2018/6/28--注释原来的，新的将原来onclick的CloseJWD()函数删除,原来的控件ID改为ImageButton3------------------>
                                                       <!--<asp:ImageButton ID="ImageButton3" runat="server"
                                                            OnClientClick="fresh_manageUserDutyList();window.parent.CloseJWD();window.parent.mycallfunction(geturl())" />
                                                    &nbsp;&nbsp;&nbsp;-->
                                                        <asp:ImageButton ID="ImageButton2" runat="server"
                                                            OnClientClick="fresh_manageUserDutyList();window.parent.mycallfunction(geturl())" />
                                                    &nbsp;&nbsp;&nbsp;
                                                    <!---------------------------xzj--2018/6/28--注释原来的，新的将原来onclick的CloseJWD()函数删除------------------>
                                                    </td>
                                                </tr>
                                            </table>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
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
<link href="../../CSS/lq_calloutExtender.css" rel="stylesheet" type="text/css" />
<script>
    window.parent.closeprossdiv();
    function fresh_manageUserDutyList()
    {
        var ifr = "manageUserDutyList_ifr";
        var sendMsgwindo = window.parent.document.frames[ifr];
        if (sendMsgwindo) {
            sendMsgwindo.searchList();
        }
    }
</script>
