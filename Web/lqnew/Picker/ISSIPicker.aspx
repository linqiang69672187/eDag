<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ISSIPicker.aspx.cs" Inherits="Web.lqnew.Picker.ISSIPicker" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <base target=_self></base>
    <script src="../../JQuery/jquery-1.5.2.js" type="text/javascript"></script>
    <script type="text/javascript">
        var strResult = "";
        var strResultISSI = "";
        var strResultISSIText = "";
        var arrUser = new Array();
        function resultClick(resuNo, resuNam) {
            strResult += resuNam + "(" + resuNo + ");";
            strResultISSI += resuNo + ";";
            strResultISSIText += resuNam + ";";
            arrUser.push(resuNam);
            $("#divResult").before("<br>" + resuNam);
        }
        function showmyuser() {
            for (var i = 0; i < arrUser.length; i++) {
                
            }
        }

        $(document).ready(function () {
            $("#btnSubmit").click(function () {
                window.returnValue = strResult.substring(0, strResult.length - 1) + "|" + strResultISSI.substring(0, strResultISSI.length - 1) + "|" + strResultISSIText.substring(0, strResultISSIText.length - 1);
                window.close();
            })
        })
    </script>
</head>
<body style="background-color: #5E71A2">
    <form id="form1" runat="server">
    <div>
        <table style="width: 100%">
            <tr style="width: 90%">
                <td style="width: 50%">
                   
                    <asp:TextBox Visible="false" ID="txtISSI" runat="server" Width="100px"></asp:TextBox>
                    &nbsp;
                    <asp:ImageButton Visible="false" runat="server" OnClick="imgSearch_OnClick" ID="imgSearch" ImageUrl="Image/Search.gif" style="width: 20px; height: 20px" />
                </td>
                <td style="width: 50%">
                </td>
            </tr>
            <tr style="width: 90%">
                <td valign="top" style="width: 50%">
                    <table>
                        <asp:Repeater runat="server" ID="RptUserList">
                            <ItemTemplate>
                            <tr>
                                <td><span onclick="resultClick('<%# DataBinder.Eval(Container.DataItem, "Issi").ToString()%>','<%# DataBinder.Eval(Container.DataItem, "Nam").ToString()%>')"><%# DataBinder.Eval(Container.DataItem, "Nam").ToString()%> </span> </td>
                            </tr>
                            </ItemTemplate>
                        </asp:Repeater>
                    </table>
                </td>
                <td valign="top" style="width: 50%;">
                    <div id="divResult">
                    </div>
                    <input type="button" id="btnSubmit" value="确定" />
                </td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
