<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="mian.aspx.cs" Inherits="Web.lqnew.opePages.mian" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style>
        body
        {
            margin: 0px;
        }

        #div1
        {
            position: absolute;
            top: 0px;
            left: 0px;
            margin-top: -14px;
            z-index: 2;
        }

        .divsearch
        {
            position: absolute;
            top: 410px;
            left: 0px;
            z-index: 4;
        }

        #Text1
        {
            width: 125px;
            border: 1px;
            background: url(../img/inputbg.gif);
            margin-top: 3px;
            margin-left: 3px;
            color: White;
        }
    </style>
    <script src="../../JQuery/jquery-1.5.2.js" type="text/javascript"></script>
     <script type="text/javascript" >
         document.onkeypress = function () {
             if (event.keyCode == 13) {
                 event.keyCode = 0;
                 event.returnValue = false;//禁止刷新
                 window.document.getElementById("img_btn_rearch").click();//绑定img_btn_rearch的click事件
             }
         }
    </script>
    <script language="javascript">
        function closebl() {
            if ($("#mian", window.parent.document).css("left") == "0px") {
                $("#mian", window.parent.document).animate({ left: "-193px" }, 500, function () {
                    $("#opSideBar span").html("<img id='bgimg'  style='margin-top:210px;' src='../img/out.gif' />");
                });
            }
            else {
                $("#mian", window.parent.document).animate({ left: "0px" }, 500, function () {
                    $("#opSideBar span").html("<img id='bgimg'  style='margin-top:210px;' src='../img/in.gif' />");

                });
            }

        }
        function chageimg(value) {
            var div2 = document.getElementById("div2");
            var bgimg = document.getElementById("bgimg");
            if (value == 1) {  //移进
                if ($("#mian", window.parent.document).css("left") == "0px") {
                    bgimg.src = "../img/in_un.gif";
                }
                else {
                    bgimg.src = "../img/out_un.gif";
                }

            }
            else //移出
            {
                if ($("#mian", window.parent.document).css("left") == "0px") {
                    bgimg.src = "../img/in.gif";
                }
                else {
                    bgimg.src = "../img/out.gif";
                }

            }
        }

    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div id="div1">
            <iframe src="../jstree/mian_tree.aspx" name="miantree" width="200px" allowtransparency="true" style="padding-top: 0px" frameborder="0" height="425px" scrolling="no"></iframe>
        </div>
        <div id="div2" style="width: 205px; height: 445px; position: absolute; z-index: 1; left: 0px;">
            <table id="tb1" height="445px" border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td style="text-align: left; vertical-align: top;">
                        <img src="../img/tree_bg1.gif" /></td>
                    <td width="22px" id="opSideBar" style="text-align: left; vertical-align: top; background-image: url(../img/tree_bg3.gif); background-repeat: no-repeat;"><span onclick="closepolicelists();closebl();" style="width: 13px; height: 9px; margin-left: 10px; cursor: hand;" onmouseover="chageimg(1)" onmouseout="chageimg(2)">
                        <img id="bgimg" style="margin-top: 210px;" src="../img/out.gif" /></span></td>
                </tr>
            </table>
        </div>
        <div class="divsearch" id="mian_searchdiv" style="display:none">
            <table width="100%">
                <tr>
                    <td width="140">
                        <div id="tstsearch" style="width: 140px; background-image: url(../img/searchtxt.png); height: 25px; background-repeat: no-repeat;">
                            <input id="Text1" type="text" onfocus="focsdiv(1)" onblur="focsdiv(0)" />
                        </div>
                    </td>
                    <td>
                        <img id="img_btn_rearch" src="../img/searchbutton.png" style="cursor: hand;" onclick="searchtxt()" /></td>
                </tr>
            </table>

        </div>
    </form>
</body>
<script language="javascript">
    function focsdiv(type) {
        var div = document.getElementById("tstsearch");
        div.style.backgroundImage = (type == "0") ? "url(../img/searchtxt.png)" : "url(../img/searchtxtin.png)";
    }
    window.parent.closeprossdiv();
    function searchtxt() {
        var str = jQuery.trim($("#Text1").val());
        if (str == "") {
            alert(window.parent.GetTextByName("Alert_PleastEnterSearchText", window.parent.useprameters.languagedata));//多语言：请输入搜索文本

            return;
        }
        var ifr = document.frames["miantree"];
        if (ifr) {
            ifr.searchtxt(str);
        }
    }
    document.body.onclick = function () {
        $("#smartMenu_mail", window.parent.document).remove();
    }
    function closepolicelists() {
        try{
            window.parent.frames['policelists'].closepolicelists();
        }
        catch(e){}
    }
</script>

</html>
