<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UserChangeRecover.aspx.cs" Inherits="Web.UserChangEntity.UserChangeRecover" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <script src="../JS/LangueSwitch.js" type="text/javascript"></script>
    <script src="../js/dragwindow.js" type="text/javascript"></script>
    <script src="/web/lqnew/js/lq_newjs.js" type="text/javascript"></script>
    <title id="Lang_ChangeRecover">恢复数据</title>
</head>
<body>
    <form id="form1" runat="server">
    <div style = " text-align:center">
    <h3 id="Lang_EntityChangebatchRecover">单位批量转移数据恢复</h3>
    <div style=" text-align:right"><a id="Lang_ChangeEntityBatch" href="UserChangeEntity.aspx">转移单位</a></div>
        <div style = " height:20px"><asp:Label ID="Label1" runat="server" Text="" BackColor="White" ForeColor="#CC0000"></asp:Label></div>
    <div style=" margin-left:10px">
    <asp:gridview ID="gridview_userchangelog" DataKeyNames="Id" AutoGenerateColumns="false" 
            runat="server" BorderWidth="1px" onrowcommand="ChangeRecover" 
            onrowdatabound="gridview_userChangeRecover_RowDataBound">
            <Columns>
                   <asp:BoundField DataField="Id" HeaderText="Id" ReadOnly="true" Visible="false"/>
                   <asp:BoundField DataField="FromEntity" HeaderText="转移单位" HeaderStyle-Width="100px" />
                   <asp:BoundField DataField="ToEntity" HeaderText="目标单位" HeaderStyle-Width="100px"/>
                   <asp:BoundField DataField="IsSelf" HeaderText="是否转移了本单位编制" HeaderStyle-Width="100px"/>
                   <asp:BoundField DataField="Operateuser" HeaderText="操作人" HeaderStyle-Width="60px"/>
                   <asp:BoundField DataField="time" HeaderText="操作时间" />
                   <asp:BoundField DataField="IsRecover" HeaderText="是否已经恢复" HeaderStyle-Width="60px"/>
                   <asp:BoundField DataField="recovertime" HeaderText="恢复时间" />
                   
                   <asp:CommandField   HeaderText="操作" ShowSelectButton="True"  SelectText="恢复" HeaderStyle-Width="40px"/>
             </Columns>
             <HeaderStyle BackColor="#00CC99" Font-Bold="True" ForeColor="Black" />
     </asp:gridview>
        <%--<asp:Repeater ID="Repeater_userchangelog" runat="server">
        </asp:Repeater>
--%>
</div>
    </div>
    </form>
</body>
</html>
