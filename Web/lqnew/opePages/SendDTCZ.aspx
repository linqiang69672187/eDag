<%@ Page Language="C#" AutoEventWireup="true"  ValidateRequest="false"  CodeBehind="SendDTCZ.aspx.cs"
    Inherits="Web.lqnew.opePages.SendDTCZ" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../css/lq_addedit.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/pagestyle.css" rel="stylesheet" type="text/css" />
    <script src="../js/geturl.js" type="text/javascript"></script>
    <link href="../css/btn.css" rel="stylesheet" type="text/css" />
    <script src="../../JQuery/jquery-1.5.2.js" type="text/javascript"></script>
    <script src="../../JS/LangueSwitch.js" type="text/javascript"></script>
    <script src="../js/StringPrototypeFunction.js" type="text/javascript"></script>
     <script src="../js/CommValidator.js" type="text/javascript"></script>
    <style type="text/css">
        .typelist
        {
            border: solid;
            border: 1px 1px 1px 1px;
            filter: alpha(opacity:0);
            visibility: hidden;
            position: absolute;
            z-index: 1;
        }
        .noselect
        {
            border-top: #eee 1px solid;
            padding-left: 2px;
            background: #fff;
            width: 100%;
            color: #000;
        }
        .isselect
        {
            border-top: #047 1px solid;
            padding-left: 2px;
            background: #058;
            width: 100%;
            color: #fe0;
        }
        .CALLBUTTON
        {
            visibility: visible;
        }
        .CALLBUTTON1
        {
            visibility: visible;
            border-right: #7b9ebd 1px solid;
            padding-right: 2px;
            border-top: #7b9ebd 1px solid;
            padding-left: 2px;
            font-size: 12px;
            filter: progid:DXImageTransform.Microsoft.Gradient(GradientType=0, StartColorStr=#ffffff, EndColorStr=#3C9562);
            border-left: #7b9ebd 1px solid;
            cursor: pointer;
            color: black;
            padding-top: 2px;
            border-bottom: #7b9ebd 1px solid;
            width: 60px;
            height: 25px;
        }
    </style>
     <script type="text/javascript">
         var SelectUsers = new Array();
         var everypagecount = 50;
         var currentPage = 1;
         var totalPage = 1;
         var totalCounts = 0;

         var Lang_Illegal_terminal_identification = window.parent.parent.GetTextByName("Lang_Illegal_terminal_identification", window.parent.parent.useprameters.languagedata);
         var Delete = window.parent.parent.GetTextByName("Delete", window.parent.parent.useprameters.languagedata);
         var Lang_DTCZIsSendingPleaseSeeSysLogWindow = window.parent.parent.GetTextByName("Lang_DTCZIsSendingPleaseSeeSysLogWindow", window.parent.parent.useprameters.languagedata);
         var Lang_DTCZISDoing = window.parent.parent.GetTextByName("Lang_DTCZISDoing", window.parent.parent.useprameters.languagedata);
         var Memberscannotbeempty = window.parent.parent.GetTextByName("Memberscannotbeempty", window.parent.parent.useprameters.languagedata);
         var CreateDTZFirst = window.parent.parent.GetTextByName("CreateDTZFirst", window.parent.parent.useprameters.languagedata);
         //添加成员
         function addSelectUsers(uname, uissi, utype, issitype) {
             SelectUsers.push({ uname: uname, uissi: uissi, utype: utype, issitype: issitype });
         }
         //移除成员
         function removeSelectUsers(i) {
             SelectUsers.splice(i, 1);
             //for (var i = 0; i < SelectUsers.length; i++) {
             //    if (SelectUsers[i].uissi == issi) {
             //        SelectUsers.splice(i, 1);
             //        break;
             //    }
             //}
         }

         function reroadpagetitle() {
             totalCounts = SelectUsers.length;
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



         }
         var Lang_ThisRecordHasAdd = window.parent.parent.GetTextByName("Lang_ThisRecordHasAdd", window.parent.parent.useprameters.languagedata);
         function addMemberToSelectUsers() {
             var issi = document.getElementById("txtISSIText").value;
             for (var i = 0; i < SelectUsers.length; i++) {
                 if (SelectUsers[i].uissi == issi) {
                     alert(Lang_ThisRecordHasAdd);
                     return;
                 }
             }

             $.ajax({
                 type: "POST",
                 url: "../../Handlers/GetUserInfo_Handler.ashx",
                 data: "issi=" + issi,
                 success: function (msg) {

                     var my = eval(msg);

                     if (my[0].nam == undefined) {
                         alert(Lang_Illegal_terminal_identification);//Lang_Illegal_terminal_identification
                         return;
                     }
                     var IsGoOn = true;
                     if (my[0].issitype.toString().trim() == "" || my[0].issitype.toString().trim() == null || my[0].issitype.toString().trim() == undefined) {
                         var Lang_remove_user_no_type = window.parent.parent.GetTextByName("Lang_remove_user_no_type", window.parent.parent.useprameters.languagedata);
                         IsGoOn = false;
                         alert(Lang_remove_user_no_type);
                     }
                     //if (my[0].issitype.toString().trim() == "LTE") {
                     //    var Lang_Remove_LTE_user = window.parent.parent.GetTextByName("Lang_Remove_LTE_user", window.parent.parent.useprameters.languagedata);
                     //    IsGoOn = false;
                     //    alert(Lang_Remove_LTE_user);
                     //}
                     if (IsGoOn) {
                         addSelectUsers(my[0].nam, issi, my[0].type, my[0].issitype);
                     }
                     reroadpagetitle();
                     currentPage = totalPage;//显示最后一页
                     var sel = document.getElementById("sel_page");
                     sel.value = totalPage;//最后一页
                     document.getElementById("span_currentPage").innerHTML = currentPage;
                     renderTable();
                     document.getElementById("txtISSIText").value = "";
                     scrollBottom();
                 }
             });


         }
         function DelUserMember(i) {
             removeSelectUsers(i);
             reroadpagetitle();
            
             renderTable();
         }
         function renderTable() {
             isFirstPage();
             var strResult = "<table>";

             var ii = 0;
             if (isLastPage(currentPage) && currentPage > 0) {
                 ii = totalCounts;
                 document.getElementById("span_currentact").innerHTML = (currentPage - 1) * everypagecount + 1 + "~" + totalCounts;
             } else if (currentPage <= 0) {
                 document.getElementById("span_currentact").innerHTML = 0 + "~" + currentPage * everypagecount;

             } else {
                 ii = (currentPage - 1) * everypagecount + everypagecount;
                 document.getElementById("span_currentact").innerHTML = (currentPage - 1) * everypagecount + 1 + "~" + currentPage * everypagecount;
             }

             if (currentPage > 0) {
                 for (var i = (currentPage - 1) * everypagecount; i < ii; i++) {

                     strResult += "<tr><td align='center' style='width:90px'>" + SelectUsers[i].uname + "</td><td align='center' style='width:90px'>" + SelectUsers[i].uissi + "</td><td align='center' style='width:90px'>" + SelectUsers[i].utype + "</td><td align='center' style='width:90px'><span style='cursor:pointer;;color:red' onclick='DelUserMember(\"" + i + "\")'>" + Delete + "</span></td></tr>";
                 }
             }
             strResult += "</table>";

             window.document.getElementById("div_selectUserList").innerHTML = strResult;
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
             renderTable();
             document.getElementById("sel_page").value = currentPage;
         }
         function prePage() {
             if (currentPage <= 1) {
                 return;
             }
             currentPage--;
             reroadpagetitle();
             renderTable();
             document.getElementById("sel_page").value = currentPage;
         }
         function firstPage() {
             if (currentPage == 1) {
                 return;
             }
             currentPage = 1;
             reroadpagetitle();
             renderTable();
             document.getElementById("sel_page").value = currentPage;
         }
         function lastPage() {
             if (currentPage == totalPage) {
                 return;
             }
             currentPage = totalPage;
             reroadpagetitle();
             renderTable();
             document.getElementById("sel_page").value = currentPage;
         }
         function tzpage() {

             var sel = document.getElementById("sel_page").value;

             if (sel == currentPage) {
                 return;
             }
             currentPage = sel;
             reroadpagetitle();
             renderTable();
             document.getElementById("sel_page").value = currentPage;
         }

         function CloseWindow() {
             window.parent.hiddenbg2();
             window.parent.mycallfunction('SendDTCZ');
         }

         $(document).ready(function () {
             if (window.parent.isSendingDTCX) {
                 alert(Lang_DTCZISDoing);
                 CloseWindow();
                 return;
             }
             window.parent.visiablebg2();
             if (document.getElementById("hiduserinfo").value != "") {
                 var users = document.getElementById("hiduserinfo").value.split(";");
                 for (var i = 0; i < users.length; i++) {
                     var sx = users[i].split(",");
                     SelectUsers.push({ uname: sx[0], uissi: sx[1], utype: sx[2], issitype: sx[3]  });
                 }
                 reroadpagetitle();
                 renderTable();
             } else {
                 isFirstPage();
                 isLastPage(currentPage);
             }
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
         });

         var dragEnable = 'True';
         function dragdiv() {
             var div1 = window.parent.document.getElementById(geturl());
             if (div1 && event.button == 1 && dragEnable == 'True') {
                 window.parent.mystartDragWindow(div1, null, event); div1.style.border = "solid 0px transparent"; window.parent.cgzindex(div1);

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
         function OnAddMember() {
             window.parent.mycallfunction('AddMemberTree/add_Member', 650, 514, '0&ifr=SendDTCZ_ifr&selectcount=-1&type=user', 2001);
         }
         function faterdo(retrunissis) {
             SelectUsers.length = 0;
             for (var i = 0; i < retrunissis.length; i++) {
                 SelectUsers.push(retrunissis[i]);
             }
             currentPage = 1;
             reroadpagetitle();
             renderTable();
         }

         function clearTS() {
             window.document.getElementById("span_result").innerHTML = "";
             window.document.getElementById("span_sendtimes").innerHTML = "";
             window.document.getElementById("span_destissi").innerHTML = "";
         }

         //开始发送 去让default中的方法去做，这个界面关闭
         function SendGPSContralRequest() {
             if (SelectUsers.length == 0) {
                 alert(Memberscannotbeempty);
                 return;
             }
             
             var groupname = document.getElementById('<%=ddrDCZ.ClientID%>').value;
       
             if (groupname == null || groupname == "") {
                 alert(CreateDTZFirst);
                 return;
             }
             window.parent.SendAddMemberToDTGroup2(groupname,SelectUsers);//周期不要 -1
             //alert(Lang_DTCZIsSendingPleaseSeeSysLogWindow);
             if (window.parent.document.frames["DTGroup/ResultList_ifr"] != null || window.parent.document.frames["DTGroup/ResultList_ifr"] != undefined) {
                 window.parent.document.frames["DTGroup/ResultList_ifr"].tohidclosebtn();
             } else {
                 window.parent.mycallfunction('DTGroup/ResultList', 450, 250);
             }
             CloseWindow();
         }
         document.onkeypress = function () {
             if (event.keyCode == 13) {
                 event.keyCode = 0;
                 event.returnValue = false;
                 addMemberToSelectUsers();
             }
         }
         function scrollBottom() {
             document.getElementById("div_selectUserList").scrollTop = document.getElementById("div_selectUserList").scrollHeight;
         }
    </script>
</head>
<body onselectstart="return false;">
    <div>
        <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
            <tr>
                <td height="30">
                    <div id="divdrag" style="cursor: move">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td width="15" height="32">
                                    <img alt="" src="../images/tab_03.png" width="15" height="32" />
                                </td>
                                <td width="1101" background="../images/tab_05.gif">
                                    <ul class="hor_ul">
                                        <li>
                                            <img alt="" src="../images/037.gif" /><span id="Lang_DTCZ"></span></li>
                                    </ul>
                                </td>
                                <td width="281" background="../images/tab_05.gif" align="right">
                                    <img alt="" class="style6" style="cursor: pointer;" onclick="CloseWindow()" onmouseover="javascript:this.src='../images/close_un.png';"
                                        onmouseout="javascript:this.src='../images/close.png';" src="../images/close.png" />
                                </td>
                                <td width="14">
                                    <img alt="" src="../images/tab_07.png" width="14" height="32" />
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
                                        <td class="style3" align="right" style="width: 100px;height:250px">
                                            <div >
                                                <%--终端号码:--%><span id="usermember"></span><span>&nbsp;&nbsp</span></div>
                                        </td>
                                        <td class="style3" align="left" valign="top">
                                            <span id="Lang_ISSS"></span>
                                          <input type="text" id="txtISSIText" runat="server" /><input onclick="addMemberToSelectUsers()" type="button" id="aLang-Add" value="添加" />
                                            <input type="hidden" id="hiduserinfo" runat="server" />
                                           <table style="width:400px; border-top:solid;border-top-color:mediumseagreen;border-top-width:1px">
                                               <tr>
                                                   <td align="left" colspan="4" style="width:270px"><span onclick="firstPage()" class="YangdjPageStyle" id="Lang_FirstPage">首页</span>&nbsp;&nbsp;<span onclick="prePage()" class="YangdjPageStyle" id="Lang_PrePage">上一页</span>&nbsp;&nbsp;<span onclick="nextPage()" class="YangdjPageStyle" id="Lang_play_next_page">下一页</span>&nbsp;&nbsp;<span onclick="lastPage()" class="YangdjPageStyle" id="Lang_LastPage">尾页</span></td>
                                               
                                                   <td align="right"><select onchange="tzpage()" id="sel_page"></select></td>
                                               </tr>
                                               <tr>
                                                   <td align="right" colspan="5"><span id="span_page"></span><span id="span_currentPage">0</span>/<span id="span_totalpage">0</span>&nbsp;&nbsp;&nbsp;<span id="span_Article"></span><span id="span_currentact">0~0</span>/<span id="span_total">0</span></td>
                                               </tr>
                                               <tr class="gridheadcss">
                                                   <th align="center"  style="width:90px;background-color:ActiveBorder"><span  id="Lang_Name">名称</span></th>
                                                   <th align="center"  style="width:90px;background-color:ActiveBorder"><span  id="txtISSIText1">终端号码</span></th>
                                                   <th align="center"  style="width:90px;background-color:ActiveBorder"><span  id="Lang_style">用户类型</span></th>
                                                   <th align="center" style="background-color:ActiveBorder" colspan="2" ><span id="Lang_Operater"></span></th>
                                               </tr>
                                               
                                           </table>
                                            <div id="div_selectUserList" style="position:absolute;top:126px;width:400px;height:158px;background-color:azure;overflow:auto"></div>
                                        </td>
                                          <td align="left" style="width: 80px;">
                                           
                                         <img alt="" src="<%--../images/chooseMember0.png--%>" id="imgSelectUser" onclick="OnAddMember()" onmouseover="<%--javascript:this.src='../images/chooseMember_un.png';--%>"
                                                onmouseout="<%--javascript:this.src='../images/chooseMember0.png';--%>" />&nbsp;
                                           
                                          </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <span id="Lang_dtczxxName">上报周期</span>

                                        </td>
                                        <td align="left" colspan="2">
                                              <form id="Form2" runat="server">
                                            <asp:DropDownList ID="ddrDCZ" runat="server"></asp:DropDownList>
                                                  </form>
                                              </td>

                                        
                                    </tr>
                                   
                                    <tr>
                                        <td class="style3" align="center" colspan="3">
                                            <table>
                                                <tr>
                                                    <td align="center">
                                                        <button class="CALLBUTTON1" id="btn_OK" style="text-align: center; cursor: pointer;"
                                                            onclick="SendGPSContralRequest()">
                                                            <%--关闭--%></button>
                                                      
                                                    </td>
                                                   
                                                </tr>
                                                <tr>
                                                      <td align="center">
                                                            <span style="color:red" id="span_result"></span>
                                                          </td>
                                                </tr>
                                            </table>
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
                                <img alt="" src="../images/tab_20.png" width="15" height="15" />
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
                                <img alt="" src="../images/tab_22.png" width="14" height="15" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
</body>
</html>
<script type="text/javascript">
    window.parent.closeprossdiv();
    LanguageSwitch(window.parent);


    var image = window.document.getElementById("imgSelectUser");
    var srouce = "../" + window.parent.parent.GetTextByName("Lang_chooseMemberPNG", window.parent.parent.useprameters.languagedata);
    image.setAttribute("src", srouce);
    //var Lang_AddNew_un = window.parent.parent.GetTextByName("Lang_AddNew_un", window.parent.parent.useprameters.languagedata);
    var strpath = "../" + window.parent.parent.GetTextByName("Lang_chooseMemberPNG", window.parent.parent.useprameters.languagedata);
    var strpathmove = "../" + window.parent.parent.GetTextByName("Lang_chooseMemberPNG_un", window.parent.parent.useprameters.languagedata);
    image.onmousemove = function () { this.src = strpathmove }//"javascript:this.src='../../images/btn_add_un.png'";// onmouse_move();
    image.onmouseout = function () { this.src = strpath }//"javascript:this.src='../../images/btn_add.png'";//  onmouse_out();

    window.document.getElementById("usermember").innerHTML = window.parent.parent.GetTextByName("usermember", window.parent.parent.useprameters.languagedata);
    window.document.getElementById("btn_OK").innerHTML = window.parent.parent.GetTextByName("BeSure", window.parent.parent.useprameters.languagedata);

    window.document.getElementById("span_page").innerHTML = window.parent.parent.GetTextByName("Page", window.parent.parent.useprameters.languagedata);
    window.document.getElementById("span_Article").innerHTML = window.parent.parent.GetTextByName("Article", window.parent.parent.useprameters.languagedata);
    window.document.getElementById("aLang-Add").value = window.parent.parent.GetTextByName("Lang-Add", window.parent.parent.useprameters.languagedata);
    window.document.getElementById("txtISSIText1").innerHTML = window.parent.parent.GetTextByName("Lang_ISSS", window.parent.parent.useprameters.languagedata);
    
</script>

<link href="../../CSS/lq_calloutExtender.css" rel="stylesheet" type="text/css" />
