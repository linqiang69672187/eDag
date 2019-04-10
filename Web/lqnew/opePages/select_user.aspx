<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="select_user.aspx.cs" Inherits="Web.lqnew.opePages.select_user" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link href="../css/lq_manager.css" rel="stylesheet" type="text/css" />
    <link href="../css/lq_addedit.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/pagestyle.css" rel="stylesheet" type="text/css" />
    <script src="../js/mark.js" type="text/javascript"></script>
    <script src="../js/Cookie.js" type="text/javascript"></script>
    <script src="../js/MouseMenu.js" type="text/javascript"></script>
    <script src="../js/MouseMenuEvent.js" type="text/javascript"></script>
    <script src="../../JS/LangueSwitch.js" type="text/javascript"></script>
    <script src="../js/lq_newjs.js" type="text/javascript"></script>
    <script src="../../MyCommonJS/ajax.js"></script>
    <script src="../js/geturl.js" type="text/javascript"></script>
    <style type="text/css">
        .mytable {
            background-color: #C0DE98;
            border-color: White;
            border-width: 0px;
            border-style: Ridge;
        }

        .bg1 {
            background: url('images/CallOutInfo_07.png') repeat-y;
        }

        .button-darkgreen {
            height:22px;
            text-align:center;
            border-radius:5px;
            border:1px solid #000000;
            box-shadow:inset 1px 5px 5px 1px #3C808A;
            background-color:#054561;
            color:white;
        }
    </style>

    <script type="text/javascript">
    

        function locateBaseStation(lo, la) { 
            if (lo == "0.0000000" || la == "0.0000000" || lo == 0 || la == 0 || lo == "" || la == "") {
                alert(GetTextByName("Alert_BaseStationUnLoLa", useprameters.languagedata));
            }
            else {
                window.parent.bsLayerManager.locateBaseStation([lo, la]);
            }
        }

        function locatePoliceStation(lo, la) {
            if (lo == "0.0000000" || la == "0.0000000" || lo == 0 || la == 0 || lo == "" || la == "") {
                alert(GetTextByName("Alert_EntityUnLoLa", useprameters.languagedata));
            }
            else {
                window.parent.psLayerManager.locatePoliceStation([lo, la]);
            }
        }

        function OpenBaseStationName(switchID,bsid) {//xzj--20181217--添加交换
            window.parent.mycallfunction('manager_BaseStationDivice', 650, 570, "&bsid=" + bsid + "&switchID=" + switchID, 2000);



        }



        function clearsearchBaseStationText() {
            try {

                var BaseStationText_input = document.getElementById("TabContainer1_TabPanel2_BaseStationText");


                //var BaseStationText_input= document.getElementById("BaseStationText");
                if (BaseStationText_input && BaseStationText_input.value != "") {
                    BaseStationText_input.value = "";
                }

            }
            catch (e)
            { }

        }

        function clearsearchEntityText() {
            try {

                var EntityText_input = document.getElementById("TabContainer1_TabPanel3_EntityText");


                //var BaseStationText_input= document.getElementById("BaseStationText");
                if (EntityText_input && EntityText_input.value != "") {
                    EntityText_input.value = "";
                }

            }
            catch (e)
            { }

        }

        function OnChanged(sender, args) {
            sender.get_clientStateField().value = sender.saveClientState();
        }

    </script>

</head>
<body style="height: 550px">
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <div>
            <table width="100%" style="background-color: white" border="0" align="center" cellpadding="0" cellspacing="0">
                <tr>
                    <td width="15px" height="20px">
                        <img src="../images/tab_03.png" width="15" height="32" /></td>
                    <td height="30">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr style="height: 20px">

                                <td width="1116" background="../images/tab_05.gif"></td>
                                <td width="281" background="../images/tab_05.gif" align="right" height="32">
                                    <img class="style6" style="cursor: pointer;" onclick="HideRightMenu(window.parent,'policemouseMenu');window.parent.lq_hiddenvml('myrectangle_choose');window.parent.lq_closeANDremovediv('select_user');" onmouseover="javascript:this.src='../images/close_un.png';" onmouseout="javascript:this.src='../images/close.png';" src="../images/close.png" /></td>

                            </tr>
                        </table>
                    </td>


                       <td width="12px" height="20px" >
                        <img src="../images/tab_07.png" width="12" height="32" /></td>
                </tr>


                <tr >


                    <td background="../images/tab_12.gif" >&nbsp;
                    </td>

                    <td>

                        <cc1:TabContainer ID="TabContainer1" runat="server" ActiveTabIndex="0" OnClientActiveTabChanged="OnChanged" >
                            <cc1:TabPanel runat="server" HeaderText="TabPanel1" ID="TabPanel1" >
                                <ContentTemplate>
                                    <table id="nodragtd" width="100%" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td align="center">
                                                <table cellspacing="1">
                                                    <tr>
                                                        <td>
                                                            <input id="isHideOfflineUser" type="checkbox" onclick="changeStatusIsHideOfflineUser();" /><span id="isHideOfflineUserText"></span>
                                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                      <input id="isHideClosedisplayUser" type="checkbox" onclick="changeStatusIsHideClosedisplayUser();" /><span id="isHideClosedisplayUserText"></span></td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <table>
                                                                <tr>
                                                                    <td>
                                                                        <div id="policewindow">
                                                                            <div id="search" style="display: none;">

                                                                                <select id="searchselect">

                                                                                    <option id="Lang_name_searchoption" value="Nam"></option>

                                                                                    <option id="Lang_number_searchoption" value="Num"></option>


                                                                                    <option id="Lang_ISSI_searchoption" value="ISSI"></option>


                                                                                </select>
                                                                                <input id="searchtextinput" type="text" value="" style="width: 150px" />
                                                                                <img src="../images/close.png" onmouseover="javascript:this.src='../images/close_un.png';" onmouseout="javascript:this.src='../images/close.png';" style="position: absolute; margin-left: -20px; cursor: hand;" onclick="clearsearchtextandrepaint()" />
                                                                                <input id="Lang_searchinresult" type="button" class="button-darkgreen" value="" title="" onclick="searchinresult()" />
                                                                                <input id="Lang_searchlockuser" type="button" class="button-darkgreen" value="" title="" onclick="searchlockuser()" />
                                                                            </div>
                                                                            <div id="searchinfo" style="display: none"></div>
                                                                            <div id="pagediv" style="display: none">
                                                                                <table id="pagetable">
                                                                                    <tr>
                                                                                        <td>
                                                                                            <table>
                                                                                                <tr>
                                                                                                    <td id="Lang_firstpage" style="width: 50px"></td>
                                                                                                    <td id="Lang_prepage" style="width: 65px"></td>
                                                                                                    <td id="Lang_nextpage"></td>
                                                                                                    <td id="Lang_lastpage"></td>
                                                                                                    <td>
                                                                                                        <select id="pageselect">

                                                                                                            <option value="1">1</option>

                                                                                                        </select></td>
                                                                                                </tr>
                                                                                            </table>
                                                                                        </td>
                                                                                        <td style="text-align: right">
                                                                                            <table>
                                                                                                <tr>
                                                                                                    <td id="Lang_pagenum"></td>
                                                                                                    <td id="totalpages"></td>
                                                                                                    <td></td>
                                                                                                    <td id="Lang_policenum"></td>
                                                                                                    <td id="totalcounts"></td>
                                                                                                </tr>
                                                                                            </table>
                                                                                        </td>
                                                                                    </tr>

                                                                                </table>
                                                                            </div>
                                                                            <div id="policetitlediv" style="margin-top: 1px; margin-left: 1px; margin-right: 20px; text-align: center; display: none;">
                                                                                <table cellspacing="1" cellpadding="0" id="GridView1" style="background-color: #C0DE98; border-color: White; border-width: 0px; border-style: Ridge;">
                                                                                    <tr class="gridheadcss" style="font-weight: bold;">
                                                                                        <th id="Lang_name" style="width: 80px"></th>
                                                                                        <th id="Lang_Serialnumber" style="width: 80px"></th>
                                                                                        <th id="Lang_ISSI" style="width: 80px"></th>
                                                                                        <th id="Lang_Subordinateunits" style="width: 150px"></th>
                                                                                        <th id="Lang_style" style="width: 100px"></th>
                                                                                        <th id="Lang_Isdisplay" style="width: 50px"></th>
                                                                                        <th id="Lang_Location" style="width: 50px"></th>
                                                                                        <th id="Lang_Operate" style="width: 50px"></th>

                                                                                    </tr>
                                                                                </table>
                                                                            </div>

                                                                            <div id="policetree" style="width: 99%; height: 295px; overflow-y: scroll; margin-top: 1px; margin-left: 1px; display: none">
                                                                                <table id="policetable" style="display: none">
                                                                                </table>
                                                                            </div>
                                                                        </div>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <table style="width: 100%; height: 40px">
                                                                            <tr>
                                                                                <td align="center">
                                                                                    <input type="button" id="btn_sms" class="button-darkgreen" onclick="smsclick()" />&nbsp;&nbsp;<input type="button" id="btn_Param" class="button-darkgreen" onclick="    paramclick()" />&nbsp;&nbsp;<input type="button" id="btn_DTCZ" class="button-darkgreen" onclick="    dtczclick()" />
                                                                                </td>

                                                                            </tr>
                                                                        </table>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>



                                </ContentTemplate>





                            </cc1:TabPanel>

                            <cc1:TabPanel runat="server" HeaderText="TabPanel2" ID="TabPanel2">
                               
                                <ContentTemplate>
                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">

                                        <tr>
                                            <td>


                                                <asp:DropDownList ID="ListBaseStation" runat="server">
                                                    <asp:ListItem Value="StationISSI"></asp:ListItem>
                                                    <asp:ListItem Value="StationName"></asp:ListItem>
                                                </asp:DropDownList>



                                                <asp:TextBox ID="BaseStationText" runat="server" Style="width: 150px"></asp:TextBox>


                                                <img src="../images/close.png" onmouseover="javascript:this.src='../images/close_un.png';" onmouseout="javascript:this.src='../images/close.png';" style="position: absolute; margin-left: -20px; cursor: hand;" onclick="clearsearchBaseStationText()" />
                                                <asp:Button ID="Button_Station" runat="server" Text="Button" CssClass="button-darkgreen" OnClick="Button_Station_Click" />







                                            </td>
                                        </tr>


                                        <tr>
                                            <td align="center" id="dragtd">
                                                <asp:GridView ID="GridView2" runat="server" Width="99%" AutoGenerateColumns="False"
                                                    BorderWidth="0px" CellSpacing="1" BackColor="#C0DE98" DataSourceID="ObjectDataSource1"
                                                    BorderColor="White" BorderStyle="Ridge" AllowPaging="True" AllowSorting="True"
                                                    CellPadding="0" GridLines="None" OnRowCommand="GridView2_RowCommand"
                                                    DataKeyNames="id">
                                                    <Columns>
                                                        <asp:BoundField DataField="StationISSI" SortExpression="StationISSI">
                                                            <ItemStyle HorizontalAlign="Center" Width="50px" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="StationName" SortExpression="StationName">
                                                            <ItemStyle HorizontalAlign="Center" Width="50px" />
                                                        </asp:BoundField>
                                                        <asp:TemplateField>
                                                            <ItemTemplate>
                                                                <img alt="loction" title="<%= Ryu666.Components.ResourceManager.GetString("Lang_Location") %>" src="../../images/xz.gif" onclick="locateBaseStation('<%#Eval("Lo") %>','<%#Eval("La") %>');" style="cursor: pointer;" />


                                                            </ItemTemplate>

                                                            <ItemStyle HorizontalAlign="Center" Width="50px" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField>
                                                            <ItemTemplate>
                                                                <img alt="operation" title="<%= Ryu666.Components.ResourceManager.GetString("Lang_Location") %>" src="../img/treebutton2.gif" onclick="OpenBaseStationName('<%#Eval("SwitchID") %>','<%#Eval("StationISSI") %>');" style="cursor: pointer;" /><%--xzj--20181217--添加交换--%>


                                                            </ItemTemplate>

                                                            <ItemStyle HorizontalAlign="Center" Width="50px" />
                                                        </asp:TemplateField>
                                                    </Columns>

                                                    <FooterStyle BackColor="#C6C3C6" ForeColor="Black" />

                                                    <HeaderStyle CssClass="gridheadcss" Font-Bold="True" />

                                                    <PagerStyle CssClass="PagerStyle" />

                                                    <RowStyle BackColor="White" Height="22px" ForeColor="Black" />

                                                    <SelectedRowStyle BackColor="#9471DE" Font-Bold="True" ForeColor="White" />
                                                </asp:GridView>





                                            </td>
                                        </tr>
                                    </table>
                                    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="True" SortParameterName="sort"
                                        SelectCountMethod="getAllBaseStation_infocount" SelectMethod="AllBaseStation_info" TypeName="DbComponent.BaseStationDao">
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="ListBaseStation" Name="selecttype" PropertyName="SelectedItem.value" />
                                            <asp:ControlParameter ControlID="BaseStationText" Name="textseach" PropertyName="Text" />
                                        </SelectParameters>
                                    </asp:ObjectDataSource>




                                </ContentTemplate>


             
                            </cc1:TabPanel>


                             <cc1:TabPanel runat="server" HeaderText="TabPanel3" ID="TabPanel3">
                                <ContentTemplate>
                                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                       
                                        <tr>
                                            <td>


                                                <asp:DropDownList ID="ListEntity" runat="server">
                                                    <asp:ListItem Value="Name"></asp:ListItem>
                                                </asp:DropDownList>



                                                <asp:TextBox ID="EntityText" runat="server" Style="width: 150px"></asp:TextBox>


                                                <img src="../images/close.png" onmouseover="javascript:this.src='../images/close_un.png';" onmouseout="javascript:this.src='../images/close.png';" style="position: absolute; margin-left: -20px; cursor: hand;" onclick="clearsearchEntityText()" />
                                                <asp:Button ID="Button_Entity" runat="server" Text="Button" CssClass="button-darkgreen" OnClick="Button_Entity_Click" />



                                            </td>
                                        </tr>


                                        <tr>
                                            <td align="center" id="Td1">
                                                <asp:GridView ID="GridView3" runat="server" Width="99%" AutoGenerateColumns="False"
                                                    BorderWidth="0px" CellSpacing="1" BackColor="#C0DE98" DataSourceID="ObjectDataSource2"
                                                    BorderColor="White" BorderStyle="Ridge" AllowPaging="True" AllowSorting="True"
                                                    CellPadding="0" GridLines="None" OnRowCommand="GridView2_RowCommand"
                                                    DataKeyNames="id">
                                                    <Columns>
                                                        <asp:BoundField DataField="id" SortExpression="id">
                                                            <ItemStyle HorizontalAlign="Center" Width="50px" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="Name" SortExpression="Name">
                                                            <ItemStyle HorizontalAlign="Center" Width="50px" />
                                                        </asp:BoundField>
                                                        <asp:TemplateField>
                                                            <ItemTemplate>
                                                                <img alt="loction" title="<%= Ryu666.Components.ResourceManager.GetString("Lang_Location") %>" src="../../images/xz.gif" onclick="locatePoliceStation('<%#Eval("Lo") %>','<%#Eval("La") %>');" style="cursor: pointer;" />


                                                            </ItemTemplate>

                                                            <ItemStyle HorizontalAlign="Center" Width="50px" />
                                                        </asp:TemplateField>
                                                   
                                                    </Columns>

                                                    <FooterStyle BackColor="#C6C3C6" ForeColor="Black" />

                                                    <HeaderStyle CssClass="gridheadcss" Font-Bold="True" />

                                                    <PagerStyle CssClass="PagerStyle" />

                                                    <RowStyle BackColor="White" Height="22px" ForeColor="Black" />

                                                    <SelectedRowStyle BackColor="#9471DE" Font-Bold="True" ForeColor="White" />
                                                </asp:GridView>





                                            </td>
                                        </tr>
                                    </table>

                                    


                                        <asp:ObjectDataSource ID="ObjectDataSource2" runat="server" EnablePaging="True" SortParameterName="sort"
                                        SelectCountMethod="getAllEntity_infocount" SelectMethod="AllEntity_info" TypeName="DbComponent.Entity">
                                        <SelectParameters>
                                       
                                         <asp:ControlParameter ControlID="ListEntity" Name="selecttype" PropertyName="SelectedItem.value" />
                                            <asp:ControlParameter ControlID="EntityText" Name="textseach" PropertyName="Text" />

                                        </SelectParameters>
                                    </asp:ObjectDataSource>
                                </ContentTemplate>

                            </cc1:TabPanel>


                        </cc1:TabContainer>

                    </td>
                     <td background="../images/tab_12.gif" align="right">&nbsp;
                    </td>

                </tr>
                <tr>

                    <td width="15" height="15">
                        <img src="../images/tab_20.png" width="15" height="15" />
                    </td>
                    <td height="15">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>

                                <td background="../images/tab_21.gif">
                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td width="25%" nowrap="nowrap">&nbsp;
                                            </td>
                                            <td width="75%" valign="top" class="STYLE1" height="15">&nbsp;
                                            </td>
                                        </tr>
                                    </table>
                                </td>

                            </tr>
                        </table>
                    </td>
                              <td width="12" height="15">
                        <img src="../images/tab_22.png" width="12" height="15" />
                    </td>

                </tr>


            </table>



        </div>

        <script type="text/javascript">
            document.onkeypress = function () {
                var search_input = document.getElementById("searchtextinput");
                if (search_input) {
                    if (event.keyCode == 13 && document.activeElement.id == "searchtextinput") {
                        if (search_input.value != "") {
                            var search_button = document.getElementById("Lang_searchinresult");
                            if (search_button) {
                                search_button.click();
                            }
                        }
                        event.returnValue = false;
                    }
                }
            }

            var dragEnable = 'True';
            function dragdiv() {
                var div1 = window.parent.document.getElementById(geturl());
                window.parent.windowDivOnClick(div1);
                if (div1 && event.button == 0 && dragEnable == 'True') {
                    window.parent.mystartDragWindow(div1, null, event); div1.style.border = "solid 0px transparent"; window.parent.cgzindex(div1);

                }
            }
            function mydragWindow() {
                var div1 = window.parent.document.getElementById(geturl());
                if (div1 && event.button == 0 && dragEnable == 'True') {
                    window.parent.mydragWindow(div1, event);
                }
            }

            function mystopDragWindow() {
                var div1 = window.parent.document.getElementById(geturl());
                if (div1 && event.button == 0 && dragEnable == 'True') {
                    window.parent.mystopDragWindow(div1); div1.style.border = "0px";
                }
            }

            window.onload = function () {
                setIsHideOfflineUserInputCheck();
                setIsHideCloasedisplayUserInputCheck();
                Allpolices = eval('<%=allpolices_json%>');
                eachpagenum = 30;
                paintpolices = Allpolices;
                paintpolicestable();
                displayorhidesearchlockuserdiv();
                //给搜索输入框添加内容改变事件
                var searchtextobj = document.getElementById("searchtextinput");
                searchtextobj.addEventListener("propertychange", function (o) {
                    if (o.propertyName == "value") {
                        onsearchinputchange(searchtextobj);
                    }
                });

                document.body.onmousedown = function () {
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
                var table = document.getElementById("nodragtd");
                table.onmouseout = function () {
                    dragEnable = 'True';
                }
                table.onmouseover = function () {
                    dragEnable = 'False';
                }
            }
            function setIsHideOfflineUserInputCheck() {
                var HideOfflineUserInput = document.getElementById("isHideOfflineUser");
                if (window.parent.useprameters.isHideOfflineUserBySelect == "True") {
                    HideOfflineUserInput.checked = true;
                }
                else if (window.parent.useprameters.isHideOfflineUserBySelect == "False") {
                    HideOfflineUserInput.checked = false;
                }
                else {
                    alert("111");
                }
            }
            function setIsHideCloasedisplayUserInputCheck() {
                var HideCloasedisplayUserInputCheck = document.getElementById("isHideClosedisplayUser");
                if (window.parent.useprameters.isHideClosedisplayUserBySelect == "True") {
                    HideCloasedisplayUserInputCheck.checked = true;
                }
                else if (window.parent.useprameters.isHideClosedisplayUserBySelect == "False") {
                    HideCloasedisplayUserInputCheck.checked = false;
                }
            }
            function paintpolicestable() {
                policenum = paintpolices.length;
                pagenum = Math.ceil(policenum / eachpagenum);
                presentpage = 1;
                //有返回数据
                if (policenum > 0) {
                    displaypresentpagepolices();
                }
                    //无返回数据
                else {
                    nodata();
                }
            }
            function displaypresentpagepolices() {
                deletepolicedivcontenttables();
                hidesearchinfo_div();
                displaypolicewindow();
                displaypolicetitlediv();
                creatpolicetable();
                createpagetables();
                displaysearchdiv();
                checklock();

            }
            function creatpolicetable() {
                try {
                    var policetable = document.createElement("table");
                    policetable.id = "policetable";
                    policetable.style.marginTop = "0px";
                    policetable.style.textAlign = "center";
                    policetable.cellPadding = "0";
                    policetable.cellSpacing = "1";
                    policetable.className = "mytable";
                    //判断是否是最后一页
                    if (presentpage == pagenum) {
                        var trnum = policenum - (pagenum - 1) * eachpagenum;
                    }
                    else {
                        var trnum = policenum > eachpagenum ? eachpagenum : policenum;
                    }
                    var indexstep = (presentpage - 1) * eachpagenum;
                    for (var i = 0; i < trnum; i++) {
                        if (window.parent.useprameters.isHideClosedisplayUserBySelect == "True" && paintpolices[i + indexstep].IsDisplayByDispatch == "False") {
                            continue;
                        }
                        var policetr = document.createElement("tr");
                        policetr.id = paintpolices[i + indexstep].id;
                        policetr.style.backgroundColor = "white";
                        policetr.onmouseover = function () {
                            this.style.backgroundColor = "green";
                        }
                        policetr.onmouseout = function () {
                            this.style.backgroundColor = "white";
                        }
                        //Nam
                        var policetd_Nam = document.createElement("td");
                        policetd_Nam.innerHTML = paintpolices[i + indexstep].Nam;
                        policetd_Nam.title = paintpolices[i + indexstep].Nam;
                        policetd_Nam.id = "Nam_" + paintpolices[i + indexstep].id;
                        policetd_Nam.style.width = "80px";
                        policetd_Nam.style.textAlign = "center";
                        policetd_Nam.style.cursor = "pointer";//xzj--20181224--鼠标悬浮样式改为pointer
                        policetd_Nam.onclick = function () {
                            window.parent.mycallfunction('view_info/view_user', 418, 415, this.id.split('_')[1]);//xzj--20181224--修改高度342改为415                        
                            }
                        policetr.appendChild(policetd_Nam);

                        //Num
                        var policetd_Num = document.createElement("td");
                        policetd_Num.innerHTML = paintpolices[i + indexstep].Num;
                        policetd_Num.id = "Num_" + paintpolices[i + indexstep].id;
                        policetd_Num.style.width = "80px";
                        policetd_Num.style.textAlign = "center";
                        policetr.appendChild(policetd_Num);
                        //ISSI
                        var policetd_ISSI = document.createElement("td");
                        policetd_ISSI.innerHTML = paintpolices[i + indexstep].ISSI;
                        policetd_ISSI.style.width = "80px";
                        policetd_ISSI.style.textAlign = "center";
                        policetr.appendChild(policetd_ISSI);
                        //Entity
                        var policetd_Entity = document.createElement("td");
                        policetd_Entity.innerHTML = paintpolices[i + indexstep].entityname;
                        policetd_Entity.id = "Entity_" + paintpolices[i + indexstep].entityname;
                        policetd_Entity.style.width = "150px";
                        policetd_Entity.style.textAlign = "center";
                        policetr.appendChild(policetd_Entity);
                        //type
                        var policetd_type = document.createElement("td");
                        policetd_type.innerHTML = paintpolices[i + indexstep].type;
                        policetd_type.style.width = "100px";
                        policetd_type.style.textAlign = "center";
                        policetr.appendChild(policetd_type);
                        //isdisplay
                        var policetdIsDisplay = document.createElement("td");
                        policetdIsDisplay.id = "Isdisplay_" + paintpolices[i + indexstep].id;
                        policetdIsDisplay.CI = paintpolices[i + indexstep].ISSI;
                        policetdIsDisplay.style.width = "50px";
                        policetdIsDisplay.style.cursor = "hand";
                        if (window.parent.useprameters.DisplayEnable == "1") {
                            if (paintpolices[i + indexstep].IsDisplayByDispatch == 'True' && paintpolices[i + indexstep].ISSI != "") {
                                policetdIsDisplay.innerHTML = "<img src='../images/isinviewyes.png'/>";
                                policetdIsDisplay.onclick = function () {
                                    if (window.parent.useprameters.lockid == this.id.split('_')[1]) {
                                        alert(window.parent.GetTextByName("PoliceLockUnHidden", window.parent.useprameters.languagedata));//多语言： 锁定状态禁止隐藏
                                        return;
                                    }
                                    changevisible(this.id, this.CI);
                                }
                            }
                            else if (paintpolices[i + indexstep].IsDisplayByDispatch == 'False' && paintpolices[i + indexstep].ISSI != "") {
                                policetdIsDisplay.innerHTML = "<img src='../images/isinviewno.png'/>";

                                policetdIsDisplay.onclick = function () {
                                    changevisible(this.id);
                                }
                            }
                        }

                        policetr.appendChild(policetdIsDisplay);
                        //定位
                        var policetd_locate = document.createElement("td");
                        policetd_locate.id = "Locate_" + paintpolices[i + indexstep].id;
                        policetd_locate.style.width = "50px";
                        if (paintpolices[i + indexstep].ISSI != "") {
                            policetd_locate.style.cursor = "hand";
                            policetd_locate.innerHTML = "<img src='../../images/xz.gif'/>";
                            policetd_locate.onclick = function () {
                                var Isdisplay_td = document.getElementById("Isdisplay_" + this.id.split('_')[1]);
                                var IsDisplay = Isdisplay_td.innerHTML.indexOf("isinviewyes");
                                if (IsDisplay >= 0) {
                                    window.parent.locationbyUseid(this.id.split('_')[1]);
                                }
                                else {
                                    var hasHide = window.parent.GetTextByName("Lang_hasHide", window.parent.useprameters.languagedata);;
                                    alert(hasHide);
                                }
                            }
                        }
                        policetr.appendChild(policetd_locate);
                        //操作
                        var policetd_operate = document.createElement("td");
                        policetd_operate.id = "operate_" + paintpolices[i + indexstep].id;
                        policetd_operate.CI = paintpolices[i + indexstep].ISSI;
                        policetd_operate.terminalType = paintpolices[i + indexstep].terminalType;
                        policetd_operate.status = paintpolices[i + indexstep].status;

                        policetd_operate.style.width = "50px";


                        if (paintpolices[i + indexstep].ISSI != "") {
                            policetd_operate.innerHTML = "<img src='../img/treebutton2.gif'/>";
                            policetd_operate.onclick = function () {
                                //修改onclick事件------------------------------xzj--2018/5/3-------------------------
                                window.parent.getUserStatusByISSI(this.CI);

                                var hh = screen.availHeight - window.parent.document.documentElement.clientHeight;
                                hh = hh > 0 ? hh : 0;
                                window.parent.document.getElementById("contextmenu_container2").parentNode.style.display = "none";
                                window.parent.document.getElementById("contextmenu_container").parentNode.style.display = "block";
                                window.parent.document.getElementById("contextmenu_container").parentNode.style.left = event.screenX + 60 + "px";
                                window.parent.document.getElementById("contextmenu_container").parentNode.style.top = event.screenY - 122 + "px";
                               
                            }
                        }
                        policetr.appendChild(policetd_operate);

                        policetable.appendChild(policetr);
                    }
                    var policetree = document.getElementById("policetree");
                    policetree.appendChild(policetable);
                    policetree.style.display = "block";
                }
                catch (e) {
                    //alert("creatpolicetable" + e);
                }
            }
            function createpagetables() {
                try {
                    // if (policenum > eachpagenum) {
                    //首页
                    if (presentpage == 1) {
                        document.getElementById("Lang_firstpage").style.color = "gray";
                    }
                    else {
                        var firstpagetd = document.getElementById("Lang_firstpage");
                        firstpagetd.style.color = "black";
                        firstpagetd.style.cursor = "hand";
                        firstpagetd.onclick = function () {
                            firstpage();
                        }
                    }
                    //上一页
                    if (presentpage == 1) {
                        document.getElementById("Lang_prepage").style.color = "gray";
                    }
                    else {
                        var prepagetd = document.getElementById("Lang_prepage");
                        prepagetd.style.color = "black";
                        prepagetd.style.cursor = "hand";
                        prepagetd.onclick = function () {
                            prepage();
                        }
                    }
                    //下一页
                    if (presentpage == pagenum) {
                        document.getElementById("Lang_nextpage").style.color = "gray";
                    }
                    else {
                        var nextpagetd = document.getElementById("Lang_nextpage");
                        nextpagetd.style.color = "black";
                        nextpagetd.style.cursor = "hand";
                        nextpagetd.onclick = function () {
                            nextpage();
                        }
                    }
                    //尾页
                    if (presentpage == pagenum) {
                        document.getElementById("Lang_lastpage").style.color = "gray";
                    }
                    else {
                        var lastpagetd = document.getElementById("Lang_lastpage");
                        lastpagetd.style.color = "black";
                        lastpagetd.style.cursor = "hand";
                        lastpagetd.onclick = function () {
                            lastpage();
                        }
                    }
                    //页数                         
                    document.getElementById("totalpages").innerHTML = presentpage + "/" + pagenum;
                    //条数
                    //修改页面条数显示（点击隐藏不显示人员后条数无变化）------------------xzj--2018/7/24-----------------------------------------
                    var presentpagenum = document.getElementById("policetable").rows.length;
                    if (presentpagenum > 0) {
                        document.getElementById("totalcounts").innerHTML = ((presentpage - 1) * eachpagenum + 1) + "-" + ((presentpage - 1) * eachpagenum + presentpagenum) + "/" + policenum;
                    }
                    else { nodata() }
                    //if (presentpage != pagenum) {
                    //    document.getElementById("totalcounts").innerHTML = ((presentpage - 1) * eachpagenum + 1) + "-" + presentpage * eachpagenum + "/" + policenum;
                    //}
                    //else {
                    //    document.getElementById("totalcounts").innerHTML = ((presentpage - 1) * eachpagenum + 1) + "-" + policenum + "/" + policenum;
                    //}
                    //转到
                    var pageselect = document.getElementById("pageselect");
                    if (pagenum != pageselect.children.length) {
                        pageselect.innerHTML = "";
                        for (var n = 1; n <= pagenum; n++) {
                            var pageoption = document.createElement("option");
                            pageoption.value = n;
                            pageoption.innerHTML = n;
                            pageselect.appendChild(pageoption);
                        }
                    }
                    pageselect.value = presentpage;
                    pageselect.onchange = function () {
                        presentpage = pageselect.value;
                        displaypresentpagepolices();
                    }
                    //显示pagetable
                    document.getElementById("pagetable").style.display = "block";
                    displaypagediv();
                    // }
                    // else {
                    //      hidepagediv();
                    //  }
                }
                catch (e) {
                    //alert("createpage" + e);
                }
            }
            function deletepolicedivcontenttables() {
                try {
                    var policetree = document.getElementById("policetree");
                    policetree.innerHTML = "";
                }
                catch (e) {
                    //alert("deletepolicedivcontenttables" + e);
                }
            }
            function firstpage() {
                if (presentpage != 1) {
                    presentpage = 1;
                    displaypresentpagepolices();
                }
            }
            function prepage() {
                if (presentpage > 1) {
                    presentpage--;
                    displaypresentpagepolices();
                }
            }
            function nextpage() {
                if (presentpage < pagenum) {
                    presentpage++;
                    displaypresentpagepolices();
                }
            }
            function lastpage() {
                if (presentpage != pagenum) {
                    presentpage = pagenum;
                    displaypresentpagepolices();
                }
            }
            function displaypolicetitlediv() {
                document.getElementById("policetitlediv").style.display = "block";
            }
            function displaysearchdiv() {
                document.getElementById("search").style.display = "block";
            }
            function close_selectuser() {
                hideselectuserdiv();
                hidefrontdivs();
                deletepolicedivcontenttables();
            }
            function displaypolicewindow() {
                document.getElementById("policewindow").style.display = "block";
            }
            function changevisible(td_id, ISSI) {
                try {
                    var isdisplay_td = document.getElementById(td_id);
                    if (isdisplay_td) {
                        if (isdisplay_td.innerHTML.indexOf("isinviewyes") > 0) {
                            displayorhide_police_ajax(isdisplay_td.CI, "1", td_id);
                           
                            window.parent.changevis('hidden', isdisplay_td.CI);
                            checkDisplayImg(td_id.split('_')[1], false);
                            for (var i = 0; i < paintpolices.length; i++) {
                                if (paintpolices[i].ISSI == ISSI) {
                                    paintpolices[i].IsDisplayByDispatch = "False";
                                }
                            }
                        }
                        else if (isdisplay_td.innerHTML.indexOf("isinviewno") > 0) {
                            displayorhide_police_ajax(isdisplay_td.CI, "0", td_id);
                           
                            window.parent.changevis('visable', isdisplay_td.CI);
                            checkDisplayImg(td_id.split('_')[1], true);
                            for (var i = 0; i < paintpolices.length; i++) {
                                if (paintpolices[i].ISSI == ISSI) {
                                    paintpolices[i].IsDisplayByDispatch = "True";
                                }
                            }
                        }
                    }
                }
                catch (e) {
                    //alert("changevisible" + e);
                }
            }
            function displayorhide_police_ajax(ISSI, ISHD, td_id) {
                jquerygetNewData_ajax("policelists_Isdisplay.aspx", { ISSI: ISSI, ISHD: ISHD }, function (msg) {
                    try {
                        //返回success
                        //alert(msg.result);
                        window.parent.document.getElementById("contextmenu_container").parentNode.style.display = "none";
                        if (msg.result == "success") {

                            if (ISHD == "1") {
                                var i = window.parent.inarrISSI.length;
                                while (i--) {
                                    if (window.parent.inarrISSI[i] == ISSI)
                                        break;
                                }
                                if (i == -1) {
                                    window.parent.inarrISSI.push(ISSI);
                                    window.parent.delSelectUserVar(td_id.replace("Isdisplay_", ""), ISSI);
                                    //checkDisplayImg(id, false);
                                    window.parent.hidPerUser(td_id.replace("Isdisplay_", ""), ISHD);

                                }
                            }
                            else {
                                var i = window.parent.inarrISSI.length;
                                while (i--) {
                                    if (window.parent.inarrISSI[i] == ISSI) {
                                        window.parent.inarrISSI.splice(i, 1);
                                        //window.parent.useprameters.Selectid.push(td_id.replace("Isdisplay_", ""));
                                        //window.parent.useprameters.SelectISSI.push(ISSI);
                                        //checkDisplayImg(id, true);
                                        window.parent.hidPerUser(td_id.replace("Isdisplay_", ""), "0");
                                        break;
                                    }
                                }

                            }

                            //}
                        }
                            //返回fail
                        else if (msg.result == "fail") {
                            displayorhide_police_ajax(ISSI, ISHD, td_id);
                        }
                    }
                    catch (e) {
                        //alert("displayorhide_police_ajax" + e);
                    }
                });
            }
            function hidepolice(td_id, ISSI) {
                var isdisplaytd_isdiaplay = document.getElementById(td_id);
                if (isdisplaytd_isdiaplay) {
                    isdisplaytd_isdiaplay.innerHTML = "<img src='../images/isinviewno.png'/>";
                }
               
            }
            function hidepagediv() {
                var page_div = document.getElementById("pagediv");
                if (page_div) {
                    page_div.style.display = "none";
                }
            }
            function displaypagediv() {
                var page_div = document.getElementById("pagediv");
                if (page_div) {
                    page_div.style.display = "block";
                }
            }
            function hidesearchinfo_div() {
                var searchinfo_div = document.getElementById("searchinfo");
                if (searchinfo_div) {
                    searchinfo_div.innerHTML = "";
                    searchinfo_div.style.display = "none";
                }
            }
            function clearsearchtextandrepaint() {
                try {
                    var searchtext_input = document.getElementById("searchtextinput");
                    if (searchtext_input && searchtext_input.value != "") {
                        searchtext_input.value = "";
                        paintpolices = Allpolices;
                        paintpolicestable();
                    }
                }
                catch (e) {
                    //alert("clearsearchtextandrepaint" + e)
                }
            }




            function searchinresult() {
                var searchresult = new Array();
                var searchtext = document.getElementById("searchtextinput").value;
                if (searchtext != "") {
                    var searchitem = document.getElementById("searchselect").value;
                    var allpolicenum = Allpolices.length;
                    for (var i = 0; i < allpolicenum; i++) {
                        if (searchitem == "Nam") {
                            if (Allpolices[i].Nam.indexOf(searchtext) > -1) {
                                searchresult.push(Allpolices[i]);
                            }
                        }
                        if (searchitem == "Num") {
                            if (Allpolices[i].Num.indexOf(searchtext) > -1) {
                                searchresult.push(Allpolices[i]);
                            }
                        }
                        if (searchitem == "ISSI") {
                            if (Allpolices[i].ISSI.indexOf(searchtext) > -1) {
                                searchresult.push(Allpolices[i]);
                            }
                        }
                    }
                    //有搜素结果
                    if (searchresult.length > 0) {
                        paintpolices = searchresult;
                        paintpolicestable();
                    }
                        //无匹配
                    else {
                        nosearchdata();
                    }
                }
                else {
                    //请输入搜索内容
                    var pleaseinput = window.parent.GetTextByName("Lang_pleaseinput", window.parent.useprameters.languagedata);
                    alert(pleaseinput);
                }
            }
            function searchlockuser() {
                var search_lockuser = new Array();
                var allpolicenum = Allpolices.length;
                var lockuserid = window.parent.useprameters.lockid;
                for (var i = 0; i < allpolicenum; i++) {
                    if (Allpolices[i].id == lockuserid) {
                        search_lockuser.push(Allpolices[i]);
                        break;
                    }
                }
                //有搜素结果
                if (search_lockuser.length > 0) {
                    paintpolices = search_lockuser;
                    paintpolicestable();
                    var searchtext_input = document.getElementById("searchtextinput");
                    if (searchtext_input) {
                        searchtext_input.value = search_lockuser[0].Nam;
                    }
                    var searchtype_select = document.getElementById("searchselect");
                    if (searchtype_select) {
                        searchtype_select.value = "Nam";
                    }
                }
            }
            function nodata() {
                var searchinfo_div = document.getElementById("searchinfo");
                if (searchinfo_div) {
                    var Lang_nodata = window.parent.GetTextByName("Lang_nodata", window.parent.useprameters.languagedata);
                    searchinfo_div.innerHTML = Lang_nodata;
                    searchinfo_div.style.display = "block";
                }
            }
            function nosearchdata() {
                deletepolicedivcontenttables();
                hidepagediv();
                var policetree_div = document.getElementById("policetree");
                if (policetree_div) {
                    var searchinfo_div = document.createElement("span");
                    policetree_div.appendChild(searchinfo_div);
                    var Lang_nodata = window.parent.GetTextByName("SearchHaveNoData", window.parent.useprameters.languagedata);
                    searchinfo_div.innerHTML = Lang_nodata;
                    searchinfo_div.style.color = "red";
                    policetree_div.style.display = "block";
                }
            }
            function checklock() {
                try {
                    var id = window.parent.useprameters.lockid;
                    if (id == 0) {
                        var lock_img = document.getElementById("lock_img");
                        if (lock_img) {
                            removeChildSafe(lock_img);
                        }
                    }
                    else {
                        var last_lock_img = document.getElementById("lock_img");
                        if (last_lock_img) {
                            removeChildSafe(last_lock_img);
                        }
                        var Nam_td_lockit = document.getElementById("Nam_" + id);
                        if (Nam_td_lockit) {
                            Nam_td_lockit.innerHTML += "<img id='lock_img' src='../img/picbz.png'   />";//锁定
                        }
                    }
                    displayorhidesearchlockuserdiv();
                }
                catch (e) {
                    //alert("checklock" + e);
                }
            }
            function displayorhidesearchlockuserdiv() {
                var id = window.parent.useprameters.lockid;
                var searchlockuser_div = document.getElementById("Lang_searchlockuser");
                if (id != 0) {
                    if (searchlockuser_div) {
                        searchlockuser_div.style.display = "inline";
                    }
                }
                else {
                    if (searchlockuser_div) {
                        searchlockuser_div.style.display = "none";
                    }
                }
            }
            function setrightvalue(id, issi, terminalType, status) {
                window.parent.useprameters.rightselectid = id;
                window.parent.useprameters.rightselectissi = issi;
                window.parent.useprameters.rightselectTerminalType = terminalType;
                window.parent.useprameters.rightselectTerminalIsValide = status;
                rightselecttype = 'cell';
            }
            function hidefrontdivs() {
                //隐藏前面的div       
                document.getElementById("searchinfo").style.display = "none";
                document.getElementById("pagediv").style.display = "none";
                document.getElementById("policetitlediv").style.display = "none";
            }
            function onsearchinputchange(searchobj) {
                if (searchobj.value == "") {
                    paintpolices = Allpolices;
                    paintpolicestable();
                }
            }
            function dtczclick() {
                if (window.parent.useprameters.callActivexable == false) {
                    alert(window.parent.parent.GetTextByName("Alert_OcxUnLoad", window.parent.parent.useprameters.languagedata));//控件未加载，短信功能不可用
                    return;
                }
                var sid = "";
                var paintpolice_length = paintpolices.length;
                for (var i = 0; i < paintpolice_length; i++) {
                    sid += paintpolices[i].id + ";";
                }
                DTCZ(sid);
            }

            function paramclick() {
                if (window.parent.useprameters.callActivexable == false) {
                    alert(window.parent.parent.GetTextByName("Alert_OcxUnLoad", window.parent.parent.useprameters.languagedata));//控件未加载，短信功能不可用
                    return;
                }
                var sid = "";
                var paintpolice_length = paintpolices.length;
                hasNullTypeUser = false;
                hasLTEUser = false;
                checkUser_HasLTEOrNoType();
                for (var i = 0; i < paintpolice_length; i++) {
                    sid += paintpolices[i].id + ";";
                }
                GPSContral(sid);
            }

            var hasNullTypeUser = false;
            var hasLTEUser = false;
            function checkUser_HasLTEOrNoType() {
                for (var i = 0; i < paintpolices.length; i++) {
                    if (paintpolices[i].terminalType.toString().trim() == "" || paintpolices[i].terminalType.toString().trim() == null || paintpolices[i].terminalType.toString().trim() == undefined) {
                        hasNullTypeUser = true;
                        paintpolices.splice(i, 1);
                        checkUser_HasLTEOrNoType();
                        return;
                    }
                    //if (paintpolices[i].terminalType.toString().trim() == "LTE") {
                    //    hasLTEUser = true;
                    //    paintpolices.splice(i, 1);
                    //    checkUser_HasLTEOrNoType();
                    //    return;
                    //}
                }
                if (hasNullTypeUser) {
                    var Lang_remove_user_no_type = window.parent.parent.GetTextByName("Lang_remove_user_no_type", window.parent.parent.useprameters.languagedata);
                    alert(Lang_remove_user_no_type);
                }
                //if (hasLTEUser) {
                //    var Lang_Remove_LTE_user = window.parent.parent.GetTextByName("Lang_Remove_LTE_user", window.parent.parent.useprameters.languagedata);
                //    alert(Lang_Remove_LTE_user);
                //}
            }

            function openclick() {
                if (window.parent.useprameters.callActivexable == false) {
                    alert(window.parent.parent.GetTextByName("Alert_OcxUnLoad", window.parent.parent.useprameters.languagedata));//控件未加载，短信功能不可用
                    return;
                }
                var sid = "";
                var paintpolice_length = paintpolices.length;
                for (var i = 0; i < paintpolice_length; i++) {
                    sid += paintpolices[i].id + ";";
                }
                GPSEnableOrDisplay(sid);
            }
            function smsclick() {
                if (window.parent.useprameters.callActivexable == false) {
                    alert(window.parent.parent.GetTextByName("Alert_OcxUnLoad", window.parent.parent.useprameters.languagedata));//控件未加载，短信功能不可用
                    return;
                }
                var sid = "";
                var police_table = document.getElementById("policetable");
                var presentpagepolicenum = 0;
                if (police_table) {
                    presentpagepolicenum = police_table.childNodes.length;
                }
                if (presentpagepolicenum == eachpagenum) {
                    for (var i = 0; i < eachpagenum; i++) {
                        var indexstep = (presentpage - 1) * eachpagenum;
                        sid += paintpolices[i + indexstep].id + ";";
                    }
                }
                else if (presentpagepolicenum > 0 && presentpagepolicenum < eachpagenum) {
                    for (var i = 0; i < presentpagepolicenum; i++) {
                        var indexstep = (presentpage - 1) * eachpagenum;
                        sid += paintpolices[i + indexstep].id + ";";
                    }
                }
                else {
                    window.parent.mycallfunction('Send_SMS', 380, 400, '&cmd=Send', 1999);
                    //window.parent.Send_SMSFrom.submit();
                    window.parent.visiablebg2();
                    //return;
                }
                if (sid != "") {
                    sendsms(sid);
                }
            }

            function sendsms(sid) {
                window.parent.document.getElementById("sid").value = sid;
                window.parent.mycallfunction('Send_SMS', 380, 400, '', 1999);
                if (window.parent.document.getElementById('Send_SMS'))//20181119--xzj
                {
                    window.parent.Send_SMSFrom.submit();
                }
                window.parent.visiablebg2();
                //window.parent.lq_hiddenvml('myrectangle_choose');
                //window.parent.lq_closeANDremovediv('select_user');
            }
            function GPSEnableOrDisplay(sid) {
                window.parent.document.getElementById("sendgpscontralhidsids").value = sid;
                window.parent.mycallfunction('SendGPSControl', 580, 700, '', 1999);
                if (window.parent.document.getElementById('SendGPSContral'))//20181119--xzj
                {
                    window.parent.SendGPSContralFrom.submit();
                }
                //window.parent.lq_hiddenvml('myrectangle_choose');
                //window.parent.lq_closeANDremovediv('select_user');
            }
            function GPSContral(sid) {
                window.parent.document.getElementById("sendgpscontralhidsids").value = sid;
                window.parent.mycallfunction('SendGPSContral', 580, 700, '', 1999);
                if (window.parent.document.getElementById('SendGPSContral'))//20181119--xzj
                {
                    window.parent.SendGPSContralFrom.submit();
                }
                //window.parent.lq_hiddenvml('myrectangle_choose');
                //window.parent.lq_closeANDremovediv('select_user');
            }

            function DTCZ(sid) {
                window.parent.document.getElementById("senddtczhidsids").value = sid;
                window.parent.mycallfunction('SendDTCZ', 580, 700, '', 1999);
                if (window.parent.document.getElementById('SendDTCZ'))//20181119--xzj
                {
                    window.parent.SendDTCZFrom.submit();
                }
                //window.parent.lq_hiddenvml('myrectangle_choose');
                //window.parent.lq_closeANDremovediv('select_user');
            }
            function changeStatusIsHideOfflineUser() {
                setIsHideOfflineUserVar();
                reloadThispage();
                UpdateIsHideOfflineUserVarToDatabase();
            }
            function setIsHideOfflineUserVar() {
                var HideOfflineUserInput = document.getElementById("isHideOfflineUser");
                if (HideOfflineUserInput.checked) {
                    window.parent.useprameters.isHideOfflineUserBySelect = "True";
                }
                else {
                    window.parent.useprameters.isHideOfflineUserBySelect = "False";
                }
            }
            function reloadThispage() {
                window.parent.document.getElementById("hidisHideOfflineUser").value = window.parent.useprameters.isHideOfflineUserBySelect;
                window.parent.document.getElementById("device_timeout").value = window.parent.useprameters.device_timeout;
                window.parent.submit_selectUser.submit();
            }
            function UpdateIsHideOfflineUserVarToDatabase() {
                var isHideOfflineUser = window.parent.useprameters.isHideOfflineUserBySelect;
                jquerygetNewData_ajax("../../WebGis/Service/UpdateIsHideOfflineUserVarToDatabase.aspx", { isHideOfflineUser: isHideOfflineUser }, function (msg) {
                    try {
                        if (msg.result == "success") {

                        }
                            //返回fail
                        else if (msg.result == "fail") {

                        }
                    }
                    catch (e) {
                        //alert("UpdateIsHideOfflineUserVarToDatabase" + e);
                    }
                });
            }
            function changeStatusIsHideClosedisplayUser() {
                resetIsHideClosedisplayUserBySelect();
                reloadThispage();
            }
            function resetIsHideClosedisplayUserBySelect() {
                var HideCloasedisplayUserInputCheck = document.getElementById("isHideClosedisplayUser");
                if (HideCloasedisplayUserInputCheck.checked) {
                    window.parent.useprameters.isHideClosedisplayUserBySelect = "True";
                }
                else {
                    window.parent.useprameters.isHideClosedisplayUserBySelect = "False";
                }
            }
        </script>
    </form>
</body>
<script type="text/javascript">
    window.parent.closeprossdiv();
    //点击其他地方关闭菜单---------------------------------xzj--2018/5/3----------------------------------------------
    document.onclick = function () {
        window.parent.document.getElementById("contextmenu_container2").parentNode.style.display = "none";
        var evt = event.srcElement ? event.srcElement : event.target;
        if ((evt.id == undefined || evt.id.indexOf("operate") == -1) && (evt.parentNode == null || evt.parentNode.id == undefined || evt.parentNode.id.indexOf("operate") == -1)) {
            window.parent.document.getElementById("contextmenu_container").parentNode.style.display = "none";
        }
    };

    //右键关闭菜单，屏蔽浏览器右键菜单---------------------------------xzj--2018/5/3----------------------------------------------
    document.oncontextmenu = function () {
        //window.parent.document.getElementById("mouseMenu").style.display = "none";
        window.parent.document.getElementById("contextmenu_container2").parentNode.style.display = "none";
        window.parent.document.getElementById("contextmenu_container").parentNode.style.display = "none";
        return false;
    }
    //window.document.getElementById("span_title").innerHTML = window.parent.GetTextByName("selectuserlist", window.parent.useprameters.languagedata);
    window.document.getElementById("isHideOfflineUserText").innerHTML = window.parent.GetTextByName("lang_hideOfflineUser", window.parent.useprameters.languagedata);
    window.document.getElementById("isHideClosedisplayUserText").innerHTML = window.parent.GetTextByName("isHideClosedisplayUserText", window.parent.useprameters.languagedata);
    window.document.getElementById("btn_sms").value = window.parent.GetTextByName("Lang_send_shortMessage", window.parent.useprameters.languagedata) + "(" + window.parent.GetTextByName("Lang_CurrentPage", window.parent.useprameters.languagedata) + ")";
    window.document.getElementById("btn_Param").value = window.parent.GetTextByName("Lang_GPS_Control", window.parent.useprameters.languagedata);
    // window.document.getElementById("btn_Param").value = window.parent.GetTextByName("Lang_GPSParamReuqest", window.parent.useprameters.languagedata);
    window.document.getElementById("btn_DTCZ").value = window.parent.GetTextByName("Lang_DTCZ", window.parent.useprameters.languagedata);

    if (window.parent.useprameters.SMSEnable == "0") {
        window.document.getElementById("btn_sms").style.display = "none";
    }
    if (window.parent.useprameters.GPS_ControlEnable == "0") {
        window.document.getElementById("btn_Param").style.display = "none";
    }
    if (window.parent.useprameters.DTCZEnable == "0") {
        window.document.getElementById("btn_DTCZ").style.display = "none";
    }

    LanguageSwitch(window.parent);
</script>
</html>
