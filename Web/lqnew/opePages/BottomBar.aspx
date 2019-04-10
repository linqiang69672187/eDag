<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BottomBar.aspx.cs" Inherits="Web.lqnew.opePages.BottomBar" %>

<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="cc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .style1
        {
            width: 100%;
        }
        body
        {
            font-size:12px;
            margin:0;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <table class="style1">
            <tr>
                <td style="width:78px;">
                    刷新频率(秒):</td>
                <td style="width:20px;">
                    <asp:Image style="cursor:hand;" onclick="cgMapfresh()" ID="Image1" runat="server" 
                        ImageUrl="~/Images/bottombar/downimg.png" />
       
    
                </td>
                <td style="width:28px;"><cc1:NumericUpDownExtender ID="TextBox1_NumericUpDownExtender" runat="server" 
            Enabled="True"  RefValues="1;2;3;5;10;30;60" ServiceDownMethod="" 
            ServiceDownPath="" ServiceUpMethod="" Tag="" TargetButtonDownID="Image1" 
            TargetButtonUpID="Image2" TargetControlID="TextBox1"  Width="25">
        </cc1:NumericUpDownExtender>
        <asp:TextBox ID="TextBox1" runat="server" Height="18px" Width="25px">5</asp:TextBox>
        
                </td>
                <td style="width:20px;">
        
    <asp:Image ID="Image2" onclick="cgMapfresh()" style="cursor:hand;" runat="server" ImageUrl="~/Images/bottombar/upimg.png" />
       
    
                </td>
                <td>
                    &nbsp;</td>
            </tr>
        </table>
        
    
    </div>
    </form>
    <script>
        function cgMapfresh() {
            // setTimeout(window.parent.cgtime(document.getElementById('TextBox1').value * 1000), 1000);
            
            setTimeout(function () {
var lq_time = document.getElementById("TextBox1").value * 1000;
                window.parent.cgtime(lq_time);
            }, 2000);

        }

        function lq_cgtime(time) {
            alert(time);
        }
    </script>
</body>
</html>
