﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="mian_tree.aspx.cs" Inherits="Web.lqnew.opePages.Add_Member.mian_tree" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="../../../JQuery/jquery-1.5.2.js" type="text/javascript"></script>
    <script src="../../js/tabs.js" type="text/javascript"></script>
    <script src="../../../JS/LangueSwitch.js"></script>
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
            margin-left: -20px;
            margin-top: -3px;
            border-top: 0;
            height: 100%;
            font-size: 14px;
            width: 180px;
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
    <form id="form1" style="height: 425;" runat="server">
        <div style="height: 425;">
            <!-- the tabs -->
            <ul class="tabs" style="margin: 0px; display: none;" id="tabsid">
                <li><a href="#"><span id="Lang_police"><%--警员--%></span><span>/</span></a></li>
                <li><a href="#"><span id="Lang_Terminal"><%--终端--%></span><span>/</span></a></li>
                <li><a href="#"><span id="Lang_Group"><%--编组--%></span><span>/</span></a></li>
                <li><a href="#"><span id="Lang_Dispatch"><%--调度台--%></span></a></li>
            </ul>
            <!-- tab "panes" -->
            <div class="panes">
                <div>
                    <iframe name="smsusetree" src="use_tree.aspx" width="180px" allowtransparency="true" scrolling="auto" style="padding-bottom: 20px;" frameborder="0" height="405px"></iframe>
                </div>
                <div>
                    <iframe name="smsISSItree" src="ISSI_tree.aspx" width="180px" allowtransparency="true" scrolling="auto" style="padding-bottom: 20px;" frameborder="0" height="405px"></iframe>
                </div>
                <div>
                    <iframe name="smsgrouptree" src="group_tree.aspx" width="180px" allowtransparency="true" scrolling="auto" style="padding-bottom: 20px;" frameborder="0" height="405px"></iframe>
                </div>
                <div>
                    <iframe name="smsdispatchtree" src="dispatch_tree.aspx" width="180px" allowtransparency="true" scrolling="auto" style="padding-bottom: 20px;" frameborder="0" height="405px"></iframe>
                </div>
            </div>
        </div>
    </form>
</body>
<script>
    $(function () {
        $("ul.tabs").tabs("div.panes > div", {
            effect: 'slide'
        });
    });
    window.onload = function () {

        window.document.getElementById("Lang_police").innerHTML = window.parent.parent.GetTextByName("use", window.parent.parent.useprameters.languagedata);
        window.document.getElementById("Lang_Terminal").innerHTML = window.parent.parent.GetTextByName("Terminal", window.parent.parent.useprameters.languagedata);
        window.document.getElementById("Lang_Group").innerHTML = window.parent.parent.GetTextByName("Group", window.parent.parent.useprameters.languagedata);
        window.document.getElementById("Lang_Dispatch").innerHTML = window.parent.parent.GetTextByName("Dispatch", window.parent.parent.useprameters.languagedata);
        //LanguageSwitch(window.parent.parent);
        var tab = document.getElementById("tabsid");
        tab.style.display = "";

    }
</script>
</html>
