<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UserChangeLog.aspx.cs" Inherits="Web.UserChangEntity.UserChangeLog" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title id="Lang_UserChangeBatchLog">批量用户转单位历史记录</title>
    <script src="../JS/LangueSwitch.js" type="text/javascript"></script>
        <script src="../js/dragwindow.js" type="text/javascript"></script>
</head>
<body>
    <form id="form1" runat="server">
    <h3 id="Lang_EntityChangeBatchLog" style=" text-align:center">单位批量转移历史记录</h3>
    <div style=" text-align:right"><a id="Lang_ChangeRecover" href="UserChangeRecover.aspx">恢复数据</a><a id="Lang_ChangeEntityBatch" href="UserChangeEntity.aspx" style=" margin-left:10px">转移单位</a></div>
    <div style=" text-align:center;margin-top:30px; margin-left:20px">
    <asp:gridview ID="gridview_userchangelog" AutoGenerateColumns="false" 
            runat="server" BorderWidth="1px" style="margin-right: 0px" 
            onrowdatabound="gridview_userchangelog_RowDataBound">
            <Columns>
                   <asp:BoundField DataField="FromEntity" HeaderText="转移单位" HeaderStyle-Width="100px"/>
                   <asp:BoundField DataField="ToEntity" HeaderText="目标单位" HeaderStyle-Width="100px"/>
                   <asp:BoundField DataField="IsSelf" HeaderText="是否转移了本单位编制" HeaderStyle-Width="100px" />
                   <asp:BoundField DataField="Operateuser" HeaderText="操作人" HeaderStyle-Width="60px"/>
                   <asp:BoundField DataField="time" HeaderText="操作时间" />
                   <asp:BoundField DataField="IsRecover" HeaderText="是否已经恢复" HeaderStyle-Width="60px"/>
                   <asp:BoundField DataField="recovertime" HeaderText="恢复时间" />
             </Columns>
             <HeaderStyle BackColor="#00CC99" Font-Bold="True" ForeColor="Black" />
     </asp:gridview>     
    </div>
    </form>
</body>
</html>

