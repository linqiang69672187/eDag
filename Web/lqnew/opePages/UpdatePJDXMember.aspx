<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UpdatePJDXMember.aspx.cs"
    Inherits="Web.lqnew.opePages.UpdatePJDXMember" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link href="../css/lq_addedit.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/pagestyle.css" rel="stylesheet" type="text/css" />
     <script src="../../JQuery/jquery-1.5.2.js" type="text/javascript"></script>
    <script src="../js/geturl.js" type="text/javascript"></script>
    <script src="../js/dragwindow.js" type="text/javascript"></script>
    <script src="../../JS/LangueSwitch.js"></script>

    <script type="text/javascript">

        Request = {
            QueryString: function (item) {
                var svalue = location.search.match(new RegExp("[\?\&]" + item + "=([^\&]*)(\&?)", "i"));
                return svalue ? svalue[1] : svalue;
            }
        }
        function SubmitRe() {
            var retrunissis = [];
            var Haveselect = window.parent.parent.GetTextByName("Haveselect", window.parent.parent.useprameters.languagedata);
            var TheMostCountMember = window.parent.parent.GetTextByName("TheMostCountMember", window.parent.parent.useprameters.languagedata);
            var obj = document.getElementById('DropDownList6');
            if (obj.options.length > parseInt(<%=System.Configuration.ConfigurationManager.AppSettings["PjMemberCount"] %>)) {
                //alert("成员组最多为"+<%=System.Configuration.ConfigurationManager.AppSettings["PjMemberCount"]%>+"个,您已选择" + obj.options.length + "个");
                alert(TheMostCountMember +<%=System.Configuration.ConfigurationManager.AppSettings["PjMemberCount"]%> +", "+Haveselect + obj.options.length);

                return;
            }
            for (var i = 0; i < obj.options.length; i++) {

                var aa = obj.options[i].text.split(';');
                retrunissis.push({ gname: aa[0], gissi: obj.options[i].value, status: aa[1] });
            }
            var ifr = Request.QueryString("ifr")
            var sendMsgwindo = window.parent.document.frames[ifr];

            if (sendMsgwindo) {
                window.parent.parent.document.getElementById("mybkdiv").style.zIndex = 1998;
                sendMsgwindo.faterdo(retrunissis); window.parent.mycallfunction(geturl());
            }
            //window.parent.frames['PJGroup_ifr'].faterdo(retrunissis);

        }
        function onClose() {
            window.parent.parent.document.getElementById("mybkdiv").style.zIndex = 1998;
            window.parent.mycallfunction(geturl());
        }
        function onLoading() {
            window.parent.parent.document.getElementById("mybkdiv").style.zIndex = 2000;
        }
        $(document).ready(function () {
            window.parent.parent.document.getElementById("mybkdiv").style.zIndex = 2000;
        });
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
                                        <img src="../images/037.gif" /><span id="Lang_modify_member"><%--修改成员--%></span></li>
                                </ul>
                            </td>
                            <td width="281" background="../images/tab_05.gif" align="right">
                                <img class="style6" style="cursor: hand;" onclick="onClose()"
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
                            <td width="15" background="../images/tab_12.gif">
                                &nbsp;
                            </td>
                            <td align="center">
                                <table class="style1" cellspacing="1" id="dragtd">
                                    <tr>
                                        <td align="left" style="background-image: url(../images/add_entity_infobg.png); height: 33;">
                                            <div style="background-image: url(../images/add_entity_info.png); width: 109px; height: 23px;">
                                                <div style="margin-left: 29px; font-size: 14px; font-weight: bold; color: #006633;
                                                    padding-top: 5px;" id="Lang_Info_of_members">
                                                    <%--成员信息--%></div>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left">
                                            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                                <ContentTemplate>
                                                    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
                                                        <tr>
                                                            <td height="30">
                                                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                                    <tr>
                                                                        <td width="15" height="30">
                                                                            <img src="images/tab_03.gif" width="15" height="30" />
                                                                        </td>
                                                                        <td background="images/tab_05.gif">
                                                                            <ul class="hor_ul">
                                                                                <li>
                                                                                    <asp:DropDownList ID="DropDownList3" runat="server" AppendDataBoundItems="True" DataSourceID="ObjectDataSource2"
                                                                                        DataTextField="name" DataValueField="id">
                                                                                      
                                                                                    </asp:DropDownList>
                                                                                    <asp:ObjectDataSource ID="ObjectDataSource2" runat="server" SelectMethod="GetAllEntityInfo"
                                                                                        TypeName="DbComponent.Entity">
                                                                                        <SelectParameters>
                                                                                            <asp:CookieParameter CookieName="id" Name="id" Type="Int32" />
                                                                                        </SelectParameters>
                                                                                    </asp:ObjectDataSource>
                                                                                </li>
                                                                                <li>
                                                                                    <asp:DropDownList ID="DropDownList4" runat="server">
                                                                                       
                                                                                        <asp:ListItem Value="GSSI">GSSI</asp:ListItem>
                                                                                    </asp:DropDownList>
                                                                                </li>
                                                                                <li>
                                                                                    <asp:TextBox ID="TextBox2" runat="server" Width="65px"></asp:TextBox></li>
                                                                                <li>
                                                                                    
                                                                                    <asp:ImageButton ID="ImageButton6" runat="server"  onmouseover=""
                                                                                        onmouseout="" 
                                                                                        ImageUrl="" onclick="ImageButton6_Click"/></li>
                                                                            </ul>
                                                                        </td>
                                                                        <td width="14"><%--../images/btn_search.png--%> <%--javascript:this.src='../images/btn_search.png';--%> <%--javascript:this.src='../images/btn_search_un.png';--%>
                                                                            <img src="images/tab_07.gif" width="14" height="30" />
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                                    <tr>
                                                                        <td width="9" background="images/tab_12.gif">
                                                                            &nbsp;
                                                                        </td>
                                                                        <td bgcolor="#f3ffe3">
                                                                            <asp:UpdateProgress AssociatedUpdatePanelID="UpdatePanel1" ID="UpdateProgress1" runat="server">
                                                                                <ProgressTemplate>
                                                                                    <img src="../../Images/ProgressBar/05043123.gif" /><span id="Lang_UnderOperate"><%--正在处理数据请稍后....--%></span>
                                                                                </ProgressTemplate>
                                                                            </asp:UpdateProgress>
                                                                            <asp:GridView ID="GridView1" runat="server" Width="99%" AutoGenerateColumns="False"
                                                                                DataSourceID="ObjectDataSource1" BorderWidth="0px" CellSpacing="1" BackColor="#C0DE98"
                                                                                BorderColor="White" BorderStyle="Ridge" AllowPaging="True" AllowSorting="True"
                                                                                CellPadding="0" GridLines="None" PageSize="5" OnRowCommand="GridView1_RowCommand"
                                                                                OnRowDataBound="GridView1_RowDataBound">
                                                                                <Columns>
                                                                                    <asp:TemplateField>
                                                                                        <ItemTemplate>
                                                                                            <asp:ImageButton ID="ImageButton7" CommandName="AddSM" CommandArgument='<%# Eval("GSSI")+","+Eval("Group_name")+","+Eval("status") %>'
                                                                                                ImageUrl="../images/check_off.png" runat="server" />
                                                                                        </ItemTemplate>
                                                                                        <ItemStyle Width="20px" HorizontalAlign="Center" />
                                                                                    </asp:TemplateField>
                                                                                    <asp:BoundField  DataField="Group_name" HeaderText="" SortExpression="Group_name"><%--组名--%>
                                                                                        <ItemStyle HorizontalAlign="Left" />
                                                                                    </asp:BoundField>
                                                                                    <asp:BoundField DataField="GSSI" HeaderText="GSSI" SortExpression="GSSI">
                                                                                        <ItemStyle HorizontalAlign="Center" Width="60px" />
                                                                                    </asp:BoundField>
                                                                                    <asp:BoundField DataField="status" Visible="false" HeaderText="" SortExpression="status"><%--状态--%>
                                                                                        <ItemStyle HorizontalAlign="Center" Width="60px" />
                                                                                    </asp:BoundField>
                                                                                </Columns>
                                                                                <FooterStyle BackColor="#C6C3C6" ForeColor="Black" />
                                                                                <HeaderStyle CssClass="gridheadcss" Font-Bold="True" />
                                                                                <PagerStyle CssClass="PagerStyle" />
                                                                                <RowStyle BackColor="#FFFFFF" Height="22px" ForeColor="Black" />
                                                                                <SelectedRowStyle BackColor="#9471DE" Font-Bold="True" ForeColor="White" />
                                                                            </asp:GridView>
                                                                            <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" SortParameterName="sort"
                                                                                SelectCountMethod="getallGroupcount" SelectMethod="AllGroupInfo" TypeName="DbComponent.group">
                                                                                <SelectParameters>
                                                                                    <asp:Parameter DefaultValue="0" Name="grouptype" Type="Int32" />
                                                                                    <asp:ControlParameter ControlID="DropDownList4" Name="GSSIorGroup" PropertyName="SelectedValue" />
                                                                                    <asp:ControlParameter ControlID="DropDownList3" Name="selectcondition" PropertyName="SelectedValue" />
                                                                                    <asp:ControlParameter ControlID="TextBox2" Name="textseach" PropertyName="Text" />
                                                                                    <asp:CookieParameter CookieName="id" Name="id" Type="Int32" />
                                                                                    <asp:QueryStringParameter Name="stringid" />
                                                                                </SelectParameters>
                                                                            </asp:ObjectDataSource>
                                                                        </td>
                                                                        <td width="9" background="images/tab_16.gif">
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
                                                                        <td width="15" height="29">
                                                                            <img src="images/tab_20.gif" width="15" height="29" />
                                                                        </td>
                                                                        <td background="images/tab_21.gif">
                                                                            <asp:Label ID="Label2" runat="server" OnLoad="Label2_Load"><%--成员组…--%></asp:Label>
                                                                            <div style="display: none">
                                                                                <asp:DropDownList ID="DropDownList5" runat="server" Height="16px" Visible="True">
                                                                                    <asp:ListItem Value="0"><%--已包含小组hasGroupnum--%></asp:ListItem>
                                                                                </asp:DropDownList>
                                                                                <asp:DropDownList ID="DropDownList6" runat="server" Height="16px" Visible="True">
                                                                                </asp:DropDownList>
                                                                            </div>
                                                                        </td>
                                                                        <td width="14">
                                                                            <img src="images/tab_22.gif" width="14" height="29" />
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </ContentTemplate>
                                            </asp:UpdatePanel>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td width="14" background="../images/tab_16.gif">
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td width="15" background="../images/tab_12.gif">
                                &nbsp;
                            </td>
                          
                            <td align="center" height="30"><%--../images/edit_entity.png  ImageUrl=""--%>
                                <asp:ImageButton ID="ImageButton1"  runat="server" 
                                  ImageUrl=""  OnClientClick="SubmitRe()" />&nbsp;&nbsp;&nbsp;
                                <img id="cancelPNG" class="" style="cursor: hand;" onclick="onClose()"
                                     src="" />
                            </td><%--../../Languages/zh-CN/Img/add_ok.png--%><%--../images/add_cancel.png--%>
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
    </form>
</body>
</html>
<script>
    window.parent.closeprossdiv();
    LanguageSwitch(window.parent);

    var image1 = window.document.getElementById("cancelPNG");
    var srouce1 = window.parent.parent.GetTextByName("Lang-Cancel", window.parent.parent.useprameters.languagedata);
    image1.setAttribute("src", srouce1);

    

</script>
<link href="../../CSS/lq_calloutExtender.css" rel="stylesheet" type="text/css" />
