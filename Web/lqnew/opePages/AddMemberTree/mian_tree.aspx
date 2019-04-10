<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="mian_tree.aspx.cs" Inherits="Web.lqnew.opePages.AddMemberTree.mian_tree" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <!-- standalone page styling (can be removed) -->
    <link rel="stylesheet" type="text/css" href="../../css/standalone.css" />
    <!-- tab styling -->
    <link rel="stylesheet" type="text/css" href="../../css/tabs.css" />
    <style>
        body
        {
            margin: 0px;
            text-align: center;
            background-color: transparent;
            background-color: #f3ffe3;
        }

        .panes div
        {
            display: none;
            margin-left: -6px;
            margin-top: -3px;
            border-top: 0;
            height: 100%;
            font-size: 14px;
            width: 202px;
        }

        .panes
        {
            height: 100%;
             width: 100%;
        }

        .tabs li a
        {
            color: Black;
        }

            .tabs li a:hover
            {
                color: #00f416;
            }

        .tabs
        {
            width: 100%;
            background: url(../../../CSS/images/ui-bg_gloss-wave_35_f6a828_500x100.png) #f6a828 repeat-x 50% 50%;
            height: 22px;
        }

            .tabs li
            {
                margin-bottom: 0px;
            }
    </style>
</head>
<body>
    <form id="form1" style="height: 450px;" runat="server">
        <div style="height: 450px;">
            <!-- the tabs -->
            <ul class="tabs" style="margin: 0px; display: none;" id="tabsid">
                <li style="display: none" id="li_police"><a href=""  id="Lang_police" onclick="userOnClick();"><%--警员--%></a></li>
                <li style="display: none" id="li_group"><a href=""   id="Lang_Group" onclick="groupOnClick();"><%--编组--%></a></li>
                <li style="display: none" id="li_dispatch"><a href=""   id="Lang_Dispatch" onclick="dispatchOnClick();"><%--调度台--%></a></li>
                <li style="display: none" id="li_baseStation"><a href=""   id="Lang_BaseStation" onclick="baseStationOnClick();"><%--基站--%></a></li><%--xzj--20190218--添加基站短信--%>
            </ul>
            <!-- tab "panes" -->
            <div class="panes">
                <div>
                    <iframe id="smsusetree" name="smsusetree" src="" width="190px" allowtransparency="true" scrolling="no" style="padding-bottom: 20px;" frameborder="0" height="405px"></iframe>
                </div>
                <div>
                    <iframe id="smsgrouptree" name="smsgrouptree" src="" width="190px" allowtransparency="true" scrolling="no" style="padding-bottom: 20px;" frameborder="0" height="405px"></iframe>
                </div>
                <div>
                    <iframe id="smsdispatchtree" name="smsdispatchtree" src="" width="190px" allowtransparency="true" scrolling="no" style="padding-bottom: 20px;" frameborder="0" height="405px"></iframe>
                </div>
                <div>
                    <iframe id="smsbasestationtree" name="smsbasestationtree" src="" width="190px" allowtransparency="true" scrolling="no" style="padding-bottom: 20px;" frameborder="0" height="405px"></iframe>
            </div>
        </div> 
    </div> 
    </form>
</body>
    
    <script src="../../../JQuery/jquery-1.5.2.js" type="text/javascript"></script>
    <script src="../../js/tabs.js" type="text/javascript"></script>
    <script src="../../../JS/LangueSwitch.js"></script>
    <script src="../../js/Cookie.js" type="text/javascript"></script>
     <script type="text/javascript"	src="../../js/resPermissions/json/json2.js"></script>
<script>
    Request = {
        QueryString: function (item) {
            var svalue = location.search.match(new RegExp("[\?\&]" + item + "=([^\&]*)(\&?)", "i"));
            return svalue ? svalue[1] : svalue;
        }
    }



    $(function () {
        $("ul.tabs").tabs("div.panes > div", {
            effect: 'slide'
        });
    });
    window.onload = function () {
        window.document.getElementById("Lang_police").innerHTML = window.parent.parent.GetTextByName("use", window.parent.parent.useprameters.languagedata);
        window.document.getElementById("Lang_Group").innerHTML = window.parent.parent.GetTextByName("Group", window.parent.parent.useprameters.languagedata);
        window.document.getElementById("Lang_Dispatch").innerHTML = window.parent.parent.GetTextByName("Dispatch", window.parent.parent.useprameters.languagedata);
        window.document.getElementById("Lang_BaseStation").innerHTML = window.parent.parent.GetTextByName("Station", window.parent.parent.useprameters.languagedata);//xzj--20190218--添加基站短信
        //LanguageSwitch(window.parent.parent);
        var tab = document.getElementById("tabsid");
        tab.style.display = "";
        var vtype = Request.QueryString("type");
        if (vtype == "all") {//显示全部
            window.document.getElementById("li_police").style.display = "block";
            window.document.getElementById("li_group").style.display = "block";
            window.document.getElementById("li_dispatch").style.display = "block"; //userOnClick();
            window.document.getElementById("li_baseStation").style.display = "block";//xzj--20190218--添加基站短信
            window.document.getElementById("smsusetree").src = "searchUserTree.aspx?type=user";
            window.document.getElementById("smsgrouptree").src = "searchGroupTree.aspx?type=group";
            window.document.getElementById("smsdispatchtree").src = "searchDispatchTree.aspx?type=dispatch";
            window.document.getElementById("smsbasestationtree").src = "searchBaseStationTree.aspx";//xzj--20190218--添加基站短信
        } else if (vtype == "user") {
            window.document.getElementById("li_police").style.display = "block"; //userOnClick();
 //window.document.getElementById("li_dispatch").style.display = "block"; //userOnClick();xzj--20190218--注释调度台
            window.document.getElementById("smsusetree").src = "searchUserTree.aspx?type=user";
        } else if (vtype == "group") {
            window.document.getElementById("smsusetree").style.display = "none";
            window.document.getElementById("smsgrouptree").style.display = "block";
            window.document.getElementById("smsdispatchtree").style.display = "none";
            window.document.getElementById("li_dispatch").style.display = "block"; //userOnClick();
            window.document.getElementById("li_group").style.display = "block"; 
            window.document.getElementById("smsgrouptree").src = "searchGroupTree.aspx?type=group";
            window.document.getElementById("Lang_Group").click();
        } else if (vtype == "dispatch") {
            window.document.getElementById("li_dispatch").style.display = "block"; //dispatchOnClick();
            window.document.getElementById("smsdispatchtree").src = "searchDispatchTree.aspx?type=dispatch";
            window.document.getElementById("Lang_Dispatch").click();
        } else if (vtype == "usergroup") {
            window.document.getElementById("li_police").style.display = "block";
            window.document.getElementById("li_group").style.display = "block"; //groupOnClick();
            window.document.getElementById("smsusetree").src = "searchUserTree.aspx?type=user";
            window.document.getElementById("smsgrouptree").src = "searchGroupTree.aspx?type=group"; 
            //window.document.getElementById("li_police").click();
        } else if (vtype == "userdispatch") {
            window.document.getElementById("li_dispatch").style.display = "block";
            window.document.getElementById("li_police").style.display = "block"; //userOnClick(); //dispatchOnClick();
            window.document.getElementById("smsusetree").src = "searchUserTree.aspx?type=user";
            window.document.getElementById("smsdispatchtree").src = "searchDispatchTree.aspx?type=dispatch";
            //window.document.getElementById("li_police").click();
        } else if (vtype == "groupdispatch") {
            window.document.getElementById("li_dispatch").style.display = "block";
            window.document.getElementById("li_group").style.display = "block"; //dispatchOnClick();
            window.document.getElementById("smsgrouptree").src = "searchGroupTree.aspx?type=group";
            window.document.getElementById("smsdispatchtree").src = "searchDispatchTree.aspx?type=dispatch";
            window.document.getElementById("Lang_Group").click();
        }

    }


    function userOnClick()
    {
        window.document.getElementById("smsusetree").style.width = "190px";
        window.document.getElementById("smsgrouptree").style.width = "0px";
        window.document.getElementById("smsdispatchtree").style.width = "0px";
        window.document.getElementById("smsbasestationtree").style.width = "0px";//xzj--20190218--添加基站短信
        window.document.getElementById("smsusetree").src = "searchUserTree.aspx?type=user";
        //$("tabsid li").removeClass("current")
        $(".panes iframe ").css("display", "none")
        $("#Lang_police").addClass("current")
        $("#smsusetree").css("display","block")
    }

    function groupOnClick() {
        window.document.getElementById("smsusetree").style.width = "0px";
        window.document.getElementById("smsgrouptree").style.width = "190px";
        window.document.getElementById("smsdispatchtree").style.width = "0px";
        window.document.getElementById("smsbasestationtree").style.width = "0px";//xzj--20190218--添加基站短信
        window.document.getElementById("smsgrouptree").src = "searchGroupTree.aspx?type=group";

        //$("tabsid li").removeClass("current")
        $(".panes iframe ").css("display", "none")
        $("#Lang_Group").addClass("current")
        $("#smsgrouptree").css("display", "block")
    }

    function dispatchOnClick() {
        window.document.getElementById("smsusetree").style.width = "0px";
        window.document.getElementById("smsgrouptree").style.width = "0px";
        window.document.getElementById("smsdispatchtree").style.width = "190px";
        window.document.getElementById("smsbasestationtree").style.width = "0px";//xzj--20190218--添加基站短信
        window.document.getElementById("smsdispatchtree").src = "searchDispatchTree.aspx?type=dispatch";

        //$("tabsid li").removeClass("current")
        $(".panes iframe ").css("display", "none")
        $("#Lang_Dispatch").addClass("current")
        $("#smsdispatchtree").css("display", "block")
    }
    //xzj--20190218--添加基站短信
    function baseStationOnClick() {
        window.document.getElementById("smsusetree").style.width = "0px";
        window.document.getElementById("smsgrouptree").style.width = "0px";
        window.document.getElementById("smsdispatchtree").style.width = "0px";
        window.document.getElementById("smsbasestationtree").style.width = "190px";
        window.document.getElementById("smsbasestationtree").src = "searchBaseStationTree.aspx";
        $(".panes iframe ").css("display", "none")
        $("#Lang_BaseStation").addClass("current")
        $("#smsbasestationtree").css("display", "block")
    }
</script>
</html>
