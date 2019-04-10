<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="mian_tree.aspx.cs" Inherits="Web.lqnew.opePages.BaseStationPicker.mian_tree" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="../../../JQuery/jquery-1.5.2.js" type="text/javascript"></script>
    <script src="../../js/tabs.js" type="text/javascript"></script>
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
                <li><a href="#"><span id="Station"><%--基站--%></span></a></li>

            </ul>
            <!-- tab "panes" -->
            <div class="panes">
                <div>
                    <iframe name="smsusetree" src="ISSI_tree.aspx" width="190px" allowtransparency="true" scrolling="auto" style="padding-bottom: 20px;" frameborder="0" height="395px"></iframe><%--cxy-20180720-tree显示bug--%>
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
        window.document.getElementById("Station").innerHTML = window.parent.parent.GetTextByName("Station", window.parent.parent.useprameters.languagedata);

        var tab = document.getElementById("tabsid");
        tab.style.display = "";

    }
</script>
</html>
