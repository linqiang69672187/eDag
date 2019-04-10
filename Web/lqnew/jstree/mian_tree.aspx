<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="mian_tree.aspx.cs" Inherits="Web.lqnew.jstree.mian_tree" %>



<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="../../JQuery/jquery-1.5.2.js" type="text/javascript"></script>
    <script src="../js/tabs.js" type="text/javascript"></script>
    <!-- standalone page styling (can be removed) -->
    <link rel="stylesheet" type="text/css" href="../css/standalone.css" />



    <!-- tab styling -->
    <link rel="stylesheet" type="text/css" href="../css/tabs.css" />

    <style>
        body
        {
            margin: 0px;
            text-align: center;
            background-color: transparent;
        }
        /* tab pane styling */
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
    </style>
</head>
<body>
    <form id="form1" style="height: 425;" runat="server">
        <div style="height: 425;">
            <!-- the tabs -->
            <ul class="tabs">
                <li><a id="LangUser" style="cursor:pointer" onclick="hide_mian_searchdiv();"></a></li>
                <%--<li><a id="LangIssi" style="cursor:pointer" ></a></li>--%>
                <li><a id="LangGroup" style="cursor:pointer" onclick="hide_mian_searchdiv();"></a></li>
                <li><a id="LangDispatch" style="cursor:pointer" onclick="hide_mian_searchdiv();"></a></li>
            </ul>

            <!-- tab "panes" -->
            <div class="panes">
                <div>
                    <%--<iframe src="../opePages/mztree.aspx" name="usetree" id="user_tree" width="180px" allowtransparency="true" scrolling="auto" style="padding-bottom: 20px;" frameborder="0" height="405px"></iframe>--%>
                    <%--respermission--%>
                    <img id="processImg_User_tree" src="../../Images/ProgressBar/05043123.gif" /><span id="processSpan_User_tree">....</span>
                    <iframe src="" name="usetree" id="user_tree" width="180px" allowtransparency="true" scrolling="auto" style="padding-bottom: 20px;" frameborder="0" height="405px"></iframe>
                </div>
              <%--  <div>
                    <iframe src="../opePages/ISSI_tree.aspx" name="issitree" id="issi_tree" width="180px" allowtransparency="true" scrolling="auto" style="padding-bottom: 20px;" frameborder="0" height="405px"></iframe>
                </div>--%>
                <div>
                    <img id="processImg_Group_tree" src="../../Images/ProgressBar/05043123.gif" /><span id="processSpan_Group_tree">....</span>
                    <iframe src="" name="grouptree" id="group_tree" width="180px" allowtransparency="true" scrolling="auto" style="padding-bottom: 20px;" frameborder="0" height="405px"></iframe>
                    <%--../opePages/group_tree.aspx--%>
                </div>
                <div>
                    <img id="processImg_Dispatch_tree" src="../../Images/ProgressBar/05043123.gif" /><span id="processSpan_Dispatch_tree">....</span>
                    <iframe src="" name="dispatchtree" id="dispatch_tree" width="180px" allowtransparency="true" scrolling="auto" style="padding-bottom: 20px;" frameborder="0" height="405px"></iframe>
                <%--../opePages/Dispatch_tree.aspx--%>
                </div>
            </div>

        </div>
    </form>
    <script type="text/javascript">
        window.onload = function () {
            setTimeout(function () {
                delayIniusertree();
            }, 1000);

            setTimeout(function () {
                delayIniGrouptree();
            }, 30000);

            setTimeout(function () {
                delayIniDispatchtree();
            }, 90000);
        }
        
        function delayIniusertree() {
            var usertreeIfr = document.getElementById("user_tree");
            if (usertreeIfr) {
                usertreeIfr.src = "../opePages/mztreeResPermission.aspx";
            }                        
        }
        function delayIniGrouptree() {
            var grouptreeIfr = document.getElementById("group_tree");
            if (grouptreeIfr) {
                grouptreeIfr.src = "../opePages/grouptreeResPermission.aspx";
            }
                        
        }
        function delayIniDispatchtree() {

            var dispatch_treeIfr = document.getElementById("dispatch_tree");
            if (dispatch_treeIfr) {
                dispatch_treeIfr.src = "../opePages/DispatchtreeResPermission.aspx";
            }            
        }
        function hideUsertreeProcessImg() {
            var processImg_User_tree = document.getElementById("processImg_User_tree");
            if (processImg_User_tree) {
                processImg_User_tree.style.display = "none";
            }
            var processSpan_User_tree = document.getElementById("processSpan_User_tree");
            if (processSpan_User_tree) {
                processSpan_User_tree.style.display = "none";
            }
        }
        function hideGrouptreeProcessImg() {
            var processImg_Group_tree = document.getElementById("processImg_Group_tree");
            if (processImg_Group_tree) {
                processImg_Group_tree.style.display = "none";
            }
            var processSpan_Group_tree = document.getElementById("processSpan_Group_tree");
            if (processSpan_Group_tree) {
                processSpan_Group_tree.style.display = "none";
            }
        }
        function hideDispatchtreeProcessImg() {
            var processImg_Dispatch_tree = document.getElementById("processImg_Dispatch_tree");
            if (processImg_Dispatch_tree) {
                processImg_Dispatch_tree.style.display = "none";
            }
            var processSpan_Dispatch_tree = document.getElementById("processSpan_Dispatch_tree");
            if (processSpan_Dispatch_tree) {
                processSpan_Dispatch_tree.style.display = "none";
            }
        }
</script>
</body>
<script>
    $(function () {
        window.document.getElementById("LangUser").innerHTML = window.parent.parent.GetTextByName("use", window.parent.parent.useprameters.languagedata);
        //window.document.getElementById("LangIssi").innerHTML = window.parent.parent.GetTextByName("Terminal", window.parent.parent.useprameters.languagedata);
        window.document.getElementById("LangGroup").innerHTML = window.parent.parent.GetTextByName("Group", window.parent.parent.useprameters.languagedata);
        window.document.getElementById("LangDispatch").innerHTML = window.parent.parent.GetTextByName("Dispatch", window.parent.parent.useprameters.languagedata);

        $("ul.tabs").tabs("div.panes > div", {
            effect: 'slide'
        });
    });

    document.body.onclick = function () {
        $("#smartMenu_mail", window.parent.parent.document).remove();
    }
    function searchtxt(str) {
        var constHtml = $(".current")[0].innerHTML;

        if (constHtml == window.parent.parent.GetTextByName("use", window.parent.parent.useprameters.languagedata)) {
            $("#use_tree").attr("src", "../opePages/use_tree.aspx?id=".concat(str));
        } else if (constHtml == window.parent.parent.GetTextByName("Terminal", window.parent.parent.useprameters.languagedata)) {
            $("#issi_tree").attr("src", "../opePages/ISSI_tree.aspx?id=".concat(str));
        } else if (constHtml == window.parent.parent.GetTextByName("Group", window.parent.parent.useprameters.languagedata)) {
            $("#group_tree").attr("src", "../opePages/group_tree.aspx?id=".concat(str));
        } else if (constHtml == window.parent.parent.GetTextByName("Dispatch", window.parent.parent.useprameters.languagedata)) {
            $("#dispatch_tree").attr("src", "../opePages/dispatch_tree.aspx?id=".concat(str));
        } else {
            $("#use_tree").attr("src", "../opePages/use_tree.aspx?id=".concat(str));
        }

        //switch ($(".current")[0].innerHTML) {
        //    case "用户":
        //        $("#use_tree").attr("src", "../opePages/use_tree.aspx?id=".concat(str));
        //        break;
        //    case "终端":
        //        $("#issi_tree").attr("src", "../opePages/ISSI_tree.aspx?id=".concat(str));
        //        break;
        //    case "编组":
        //        $("#group_tree").attr("src", "../opePages/group_tree.aspx?id=".concat(str));
        //        break;
        //    case "调度台":
        //        $("#dispatch_tree").attr("src", "../opePages/dispatch_tree.aspx?id=".concat(str));
        //        break;
        //    default:
        //        $("#use_tree").attr("src", "../opePages/use_tree.aspx?id=".concat(str));
        //        break;
        //}        
    }
    function hide_mian_searchdiv() {
        var event = event || window.event;
        if (event && event.srcElement && event.srcElement.innerHTML) {
            var constHtml = event.srcElement.innerHTML;
            var mian_searchdiv = window.parent.document.getElementById("mian_searchdiv");
            if (constHtml == window.parent.parent.GetTextByName("use", window.parent.parent.useprameters.languagedata)) {
                if (mian_searchdiv) {
                    mian_searchdiv.style.display = "none";
                }
            }
            else if (constHtml == window.parent.parent.GetTextByName("Terminal", window.parent.parent.useprameters.languagedata)) {
                if (mian_searchdiv) {
                    mian_searchdiv.style.display = "none";
                }
            }
            else if (constHtml == window.parent.parent.GetTextByName("Group", window.parent.parent.useprameters.languagedata)) {
                if (mian_searchdiv) {
                    mian_searchdiv.style.display = "none";
                }
            }
            else if (constHtml == window.parent.parent.GetTextByName("Dispatch", window.parent.parent.useprameters.languagedata)) {
                if (mian_searchdiv) {
                    mian_searchdiv.style.display = "none";
                }
            }
        }
    }
</script>
</html>
