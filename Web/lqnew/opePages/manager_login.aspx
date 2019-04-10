<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="manager_login.aspx.cs"
    Inherits="Web.lqnew.opePages.manager_login" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../css/lq_manager.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/pagestyle.css" rel="stylesheet" type="text/css" />
    <script src="../js/geturl.js" type="text/javascript"></script>
    <script src="../js/dragwindow.js" type="text/javascript"></script>
    <script src="../../JQuery/jquery-1.5.2.js" type="text/javascript"></script>
    <script src="../js/manageStopSelectSubmit.js" type="text/javascript"></script>
    <script src="../../LangJS/managerGroup_langjs.js"></script>
    <script type="text/javascript"
        src="../js/resPermissions/json/json2.js"></script>
    <script src="../js/Cookie.js" type="text/javascript"></script>
</head>
<body>
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
                                        <li>
                                            <img src="../images/311.gif" width="16" height="16" /><span class="Langtxt" id="Dispatcherinformationmaintenance"></span></li>
                                        <li>
                                            <asp:DropDownList ID="DropDownList1" runat="server" AppendDataBoundItems="True" DataSourceID="ObjectDataSource2"
                                                DataTextField="name" DataValueField="id">
                                                <asp:ListItem Value="0"></asp:ListItem>
                                            </asp:DropDownList>
                                            <asp:ObjectDataSource ID="ObjectDataSource2" runat="server" SelectMethod="GetAllEntityInfo"
                                                TypeName="DbComponent.Entity">
                                                <SelectParameters>
                                                    <asp:CookieParameter CookieName="id" Name="id" Type="Int32" />
                                                </SelectParameters>
                                            </asp:ObjectDataSource>
                                        </li>
                                        <li>&nbsp;&nbsp;&nbsp;&nbsp;<span class="Langtxt" id="usename"></span><span>&nbsp;&nbsp;</span>
                                            <asp:TextBox ID="TextBox1" runat="server" Width="67px"></asp:TextBox></li>
                                        <li>
                                            <asp:ImageButton ID="Lang_Search" runat="server" onmouseover="javascript:this.src=window.parent.GetTextByName('Lang_Search_un',window.parent.useprameters.languagedata);"
                                                onmouseout="javascript:this.src=window.parent.GetTextByName('Lang_Search',window.parent.useprameters.languagedata);" OnClick="ImageButton1_Click" /></li>
                                        <li>
                                            <!---------------------------xzj--2018/6/28--修改onclick()调用函数的高度参数为255------------------>
                                            <img alt="" id="Lang_AddNew" class="style6" style="cursor: hand;" onclick="window.parent.mycallfunction('add_login',450, 255)"
                                                onmouseover="javascript:this.src=window.parent.GetTextByName('Lang_AddNew_un',window.parent.useprameters.languagedata);" onmouseout="javascript:this.src=window.parent.GetTextByName('Lang_AddNew',window.parent.useprameters.languagedata);" /></li>
                                            <!---------------------------xzj--2018/6/28--修改onclick()调用函数的高度参数为255------------------>
                                    </ul>
                                </td>
                                <td width="50" background="../images/tab_05.gif" align="right">
                                    <img class="style6" style="cursor: hand;" onclick="window.parent.mycallfunction(geturl(),693, 354)"
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
                                    <asp:GridView ID="GridView1" runat="server" Width="99%" AutoGenerateColumns="False"
                                        DataSourceID="ObjectDataSource1" BorderWidth="0px" CellSpacing="1" BackColor="#C0DE98"
                                        BorderColor="White" BorderStyle="Ridge" AllowPaging="True" AllowSorting="True"
                                        CellPadding="0" DataKeyNames="id,RoleId" GridLines="None" OnRowDataBound="GridView1_RowDataBound" OnRowCommand="GridView1_RowCommand">
                                        <Columns>
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <font onclick="window.parent.mycallfunction('view_info/view_login',318, 342,'<%#Eval("id") %>')"
                                                        style="cursor: hand;">&nbsp;&nbsp;<%# Eval("Usename")%></font>
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Left" Width="80px" />
                                            </asp:TemplateField>
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <font style="cursor: hand; text-decoration: underline;" title='<%# Eval("pwd") %>'>******</font>
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Center" Width="60px" />
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="Entity_ID">
                                                <ItemStyle HorizontalAlign="Left" />
                                            </asp:BoundField>
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <!---------------------------xzj--2018/6/28--修改onclick()调用函数的高度参数为255------------------>
                                                    <font onclick="window.parent.mycallfunction('edit_login',450, 255,'<%#Eval("id") %>')"
                                                        style="cursor: pointer;">
                                                    <!---------------------------xzj--2018/6/28--修改onclick()调用函数的高度参数为255------------------>
                                                        <img id="img_modify" runat="server" src="../images/114.gif" /><%--<span  class="Langtxt"   id="Modify" ></span>--%></font>
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Center" Width="50px" />
                                            </asp:TemplateField>
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="ImageButton2" CommandName="MyDel" CommandArgument='<%# Eval("id") %>'
                                                        runat="server">
                                                        <img id="img_del" runat="server" src="images/083.gif" /><font color="black"><%--<span  class="Langtxt"   id="Delete" ></span>--%></font>
                                                    </asp:LinkButton>
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Center" Width="50px" />
                                            </asp:TemplateField>
                                            <%--resourcepermission--%>
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <span class="PermissionSetting" id='addOrEditRespermission_<%# Eval("id") %>' ci='<%# Eval("accessUnitsAndUsertype").ToString() %>' onclick="addOrEditRespermission('<%# Eval("id") %>',this,'<%# Eval("Usename")%>')" style="cursor: hand;">&nbsp;&nbsp;</span>
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Left" Width="100px" />
                                            </asp:TemplateField>
                                        </Columns>
                                        <FooterStyle BackColor="#C6C3C6" ForeColor="Black" />
                                        <HeaderStyle CssClass="gridheadcss" Font-Bold="True" />
                                        <PagerStyle CssClass="PagerStyle" />
                                        <RowStyle BackColor="#FFFFFF" Height="22px" ForeColor="Black" />
                                        <SelectedRowStyle BackColor="#9471DE" Font-Bold="True" ForeColor="White" />
                                    </asp:GridView>
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
                                            <td width="75%" valign="top" class="STYLE1">
                                                <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" SortParameterName="sort"
                                                    SelectCountMethod="getalllogincount" SelectMethod="AllloginInfo" TypeName="DbComponent.login">
                                                    <SelectParameters>
                                                        <asp:ControlParameter ControlID="DropDownList1" Name="selectcondition" PropertyName="SelectedValue" />
                                                        <asp:ControlParameter ControlID="TextBox1" Name="textseach" PropertyName="Text" />
                                                        <asp:CookieParameter CookieName="id" Name="id" Type="Int32" />
                                                    </SelectParameters>
                                                </asp:ObjectDataSource>
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
   //窗口拖动的onload()被defaultOnload()取代，将代码放进defaultOnload()中------------xzj--20181122--------------------------
   var dragEnable = 'True';
    function dragdiv() {
        var div1 = window.parent.document.getElementById(geturl());
        window.parent.windowDivOnClick(div1);
        if (div1 && event.button == 0 && dragEnable == 'True') {
            window.parent.mystartDragWindow(div1, null, event);
            div1.style.border = "solid 0px transparent";
            window.parent.cgzindex(div1);

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
    //窗口拖动的onload()被defaultOnload()取代，将代码放进defaultOnload()中------------xzj--20181122--------------------------
    window.document.getElementById("Lang_AddNew").src = window.parent.GetTextByName('Lang_AddNew', window.parent.useprameters.languagedata);
    window.onload = function () {
        var Lang_PermissionSetting = window.parent.GetTextByName('Lang_PermissionSetting', window.parent.useprameters.languagedata);
        var PermissionSetting = getElementsByClassName(document, "SPAN", "PermissionSetting");
        for (var i = 0; i < PermissionSetting.length; i++) {
            PermissionSetting[i].innerHTML = "&nbsp;&nbsp;" + Lang_PermissionSetting;
        }
          //窗口拖动的onload()被defaultOnload()取代，将代码放进defaultOnload()中------------xzj--20181122--------------------------
          document.body.onclick = function () {
            //alert();
            //var div2 = window.parent.document.getElementById(geturl());
            //window.parent.windowDivOnClick(div2);
        }
        document.body.onmousedown = function () {
            var div2 = window.parent.document.getElementById(geturl());

            window.parent.windowDivOnClick(div2);
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
        var table = document.getElementById("dragtd");
        table.onmouseout = function () {
            dragEnable = 'True';
        }

        table.onmouseover = function () {
            dragEnable = 'False';
        }
        //窗口拖动的onload()被defaultOnload()取代，将代码放进defaultOnload()中------------xzj--20181122--------------------------
    }
    function getElementsByClassName(oElm, strTagName, strClassName) {
        var arrElements = (strTagName == "*" && oElm.all) ? oElm.all :
            oElm.getElementsByTagName(strTagName);
        var arrReturnElements = new Array();
        strClassName = strClassName.replace(/\-/g, "\\-");
        var oRegExp = new RegExp("(^|\\s)" + strClassName + "(\\s|$)");
        var oElement;
        for (var i = 0; i < arrElements.length; i++) {
            oElement = arrElements[i];
            if (oRegExp.test(oElement.className)) {
                arrReturnElements.push(oElement);
            }
        }
        return (arrReturnElements);
    }
    function addOrEditRespermission(selectedLoginuserId, selfObj, subLoginUserName) {
        var par = { loginUserId: Cookies.get("loginUserId"), loginuserEntityId: Cookies.get("id"), selectedLoginuserId: selectedLoginuserId, subLoginUserName: subLoginUserName };
        var param = JSON.stringify(par);
        //var ci = selfObj.CI;
        //if (ci == "" || ci == null || ci == "0") {

        window.parent.mycallfunction('resPermissions/configUserResourcePermissions_add', 800, 700, param);
        //}
        //else {

        //    window.parent.mycallfunction('resPermissions/configUserResourcePermissions_edit', 800, 700, param);
        //}

    }
</script>
