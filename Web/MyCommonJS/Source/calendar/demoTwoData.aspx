<%@ Page Language="C#" AutoEventWireup="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <script src="WdatePicker.js" type="text/javascript"></script>

</head>
<body>
    <form id="form1" runat="server">
    <table id="Table1" style="border-collapse: collapse;" bordercolor="#2a639d " cellspacing="0"
        cellpadding="2" align="left" bgcolor="#ffffff" border="1">
        <tr>
            <td align="center">
                开始时间:
            </td>
            <td width="200px">
                <input type="text" id="txt_starttime" runat="server" class="Wdate" onfocus="var text_endtime=$dp.$('text_endtime');WdatePicker({onpicked:function(){text_endtime.focus();},maxDate:'#F{$dp.$D(\'text_endtime\')}'})" />
            </td>
            <td>
                结束时间:
            </td>
            <td>
                <input type="text" id="text_endtime" runat="server" class="Wdate" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'txt_starttime\')}'})" />
            </td>
        </tr>
    </table>
    </form>
</body>
</html>
