<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="mian_tree.aspx.cs" Inherits="Web.lqnew.logwindow.mian_tree" %>


<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <script src="../../JQuery/jquery-1.5.2.js" type="text/javascript"></script>
    <script src="../js/tabs.js" type="text/javascript"></script>
    <!-- standalone page styling (can be removed) -->
	<link rel="stylesheet" type="text/css" href="../css/standalone.css"/>	
	<!-- tab styling -->
	<link rel="stylesheet" type="text/css" href="../css/tab2.css" />
  <style>
body 
{
 margin:0px;
 text-align:center;
 background-color:transparent;
}
/* tab pane styling */
.panes div {
	display:none;		
	margin-left:-20px;
	margin-top:-3px;
	border-top:0;
	height:100%;
	font-size:14px;

	width:160px;

}
.panes  {

	height:100%;


}

	</style>
</head>
<body>
    <form id="form1" style="height:100%;" runat="server">
    <div style="height:100%;">
    <!-- the tabs -->
<ul class="tabs">
	
	<li><a id="lang_all" href="#">全部</a></li>
	<li><a id="lang_system" href="#">系统</a></li>
    <li><a id="lang_call" href="#">呼叫</a></li>
    <li><a id="lang_msg" href="#">短信</a></li>
</ul>

<!-- tab "panes" -->
<div class="panes">

	<div><iframe src="all_log.aspx" width="180px" allowTransparency="true" scrolling="auto" style="padding-bottom:20px;"  frameborder="0" height="405px" ></iframe></div>
	<div><iframe src="system_log.aspx" width="180px" allowTransparency="true" scrolling="auto" style="padding-bottom:20px;"  frameborder="0" height="405px" ></iframe></div>
    <div><iframe src="call_log.aspx" width="180px" allowTransparency="true" scrolling="auto" style="padding-bottom:20px;"  frameborder="0" height="405px" ></iframe></div>
    <div><iframe src="sms_log.aspx" width="180px" allowTransparency="true" scrolling="auto" style="padding-bottom:20px;"  frameborder="0" height="405px" ></iframe></div>
</div>
    </div>
    </form>

</body>
<script>
    $(function () {

        window.document.getElementById("lang_system").innerHTML = window.parent.parent.GetTextByName("System", window.parent.parent.useprameters.languagedata);
        window.document.getElementById("lang_call").innerHTML = window.parent.parent.GetTextByName("Called", window.parent.parent.useprameters.languagedata);
        window.document.getElementById("lang_msg").innerHTML = window.parent.parent.GetTextByName("Message", window.parent.parent.useprameters.languagedata);
        window.document.getElementById("lang_all").innerHTML = window.parent.parent.GetTextByName("Lang_Log_All", window.parent.parent.useprameters.languagedata);

        $("ul.tabs").tabs("div.panes > div", {
            effect: 'slide'
        });
    });
</script>
</html>
