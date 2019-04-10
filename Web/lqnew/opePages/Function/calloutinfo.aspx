<%@ Page Language="C#" validateRequest= "false " AutoEventWireup="true" CodeBehind="calloutinfo.aspx.cs" Inherits="Web.lqnew.opePages.Function.calloutinfo" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        body{margin:0px;background-color:transparent;font-size:12px;}
        table{background-color:#FFFFFF;}
        .style1{width: 100%;}
        .style2{width: 7px;height: 19px;}
        .style3{width: 7px;height: 34px;}
        .bg1{background:url('../images/CallOutInfo_07.png') repeat-y;}
        .bg2{background:url('../images/CallOutInfo_02.png') repeat-x;}
        .bg3{background:url('../images/CallOutInfo_10.png') repeat-y;}
        .bg4{background:url('../images/CallOutInfo_13.png') repeat-x;}
        #divClose{width:33px;height:16px;position:relative;border:0px;float: right; margin-top: 1px;background-image:url('../../view_infoimg/images/minidict_03.png');cursor:hand;}
   #info_title{float:left;padding-top:2px;height:16px;font-weight:bold;}
        .style4{float:left;margin:5px;
            height: 54px;
            width: 54px;
        }
        #btn1,#btn2{width:46px;height:20px;float: right;margin-right:20px;background:url('../../images/outinfo_button.png') no-repeat 0 0;text-align:center;vertical-align:middle;line-height:22px;cursor:hand;}
       
    </style>
     <script language="javascript">
         function Divover(obj,str) {
             var div1 = obj;
            div1.style.backgroundPosition = str;
         }
 </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <table cellpadding="0" cellspacing="0" class="style1">
            <tr>
                <td class="style2">
                    <img  src="../images/CallOutInfo_01.png" /></td>
                <td class="bg2"><div id="info_title" runat="server"></div><div id="divClose" onmouseover="Divover(this,'66 0')" onclick="window.parent.lq_closeANDremovediv('Function/calloutinfo','bgDiv')" onmouseout="Divover(this,'0 0')"></div></td>
                <td class="style2" ><img src="../images/CallOutInfo_04.png" /></td>
            </tr>
            <tr>
                <td class="bg1">
                    &nbsp;</td>
                <td  runat="server"  id="dragtd" ><img class="style4" src="../../images/alertoutinfo1.gif" /></td>
                <td class="bg3">
                    &nbsp;</td>
            </tr>
            <tr>
                <td class="style3"><img  src="../images/CallOutInfo_12.png" /></td>
                <td class="bg4" align="right">
                   <div  id="btn1" onmouseover="Divover(this,'-47 -0')" onclick="window.parent.lq_closeANDremovediv('Function/calloutinfo','bgDiv')" onmouseout="Divover(this,'0 -0')"><%--取消--%></div><div id="btn2" onmouseover="Divover(this,'-47 0')"  runat="server"  onmouseout="Divover(this,'0 0')"><%--确定--%></div> </td>
                <td>
                    <img src="../images/CallOutInfo_14.png" /></td>
            </tr>
        </table>
    
    </div>
    </form>
</body>
</html>
<script>
    var dragEnable = 'True';
    function dragdiv() {
        var div1 = window.parent.document.getElementById('Function/calloutinfo');
        if (div1 && event.button == 0 && dragEnable == 'True') {
            window.parent.mystartDragWindow(div1, null, event); div1.style.border = "solid 3px transparent"; window.parent.cgzindex(div1);

        }
    }
    function mydragWindow() {
        var div1 = window.parent.document.getElementById('Function/calloutinfo');
        if (div1) {
            window.parent.mydragWindow(div1, event);
        }
    }

    function mystopDragWindow() {
        var div1 = window.parent.document.getElementById('Function/calloutinfo');
        if (div1) {
            window.parent.mystopDragWindow(div1); div1.style.border = "0px";
        }
    }
    window.onload = function () {
        document.getElementById("btn1").innerHTML = window.parent.parent.GetTextByName("BeCancel", window.parent.parent.useprameters.languagedata);
        document.getElementById("btn2").innerHTML = window.parent.parent.GetTextByName("BeSure", window.parent.parent.useprameters.languagedata);
        document.body.onmousedown = function () { dragdiv(); }
        document.body.onmousemove = function () { mydragWindow(); }
        document.body.onmouseup = function () { mystopDragWindow(); }
        document.body.oncontextmenu = function () { return false; }
             document.body.oncontextmenu = function () { return false; }
 var arrayelement = ["input", "a", "select", "li", "font","textarea"];
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
    }

    window.parent.lq_changeheight('Function/calloutinfo', document.body.clientHeight); window.parent.closeprossdiv();
</script>