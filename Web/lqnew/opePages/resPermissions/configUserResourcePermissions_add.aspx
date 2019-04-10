<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="configUserResourcePermissions_add.aspx.cs" Inherits="Web.lqnew.opePages.resPermissions.configUserResourcePermissions_add" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <link href="../../../CSS/pagestyle.css" rel="stylesheet" type="text/css" />
    
    <link href="../../css/lq_addedit.css" rel="stylesheet" type="text/css" />
    <%--<script src="../../js/dragwindow.js" type="text/javascript"></script>--%>

    <link rel="stylesheet" type="text/css"
	href="../../js/resPermissions/jquery-easyui-1.4/themes/default/easyui.css"/>
<link rel="stylesheet" type="text/css"
	href="../../js/resPermissions/jquery-easyui-1.4/themes/icon.css"/>
<link rel="stylesheet" type="text/css"
	href="../../js/resPermissions/jquery-easyui-1.4/themes/demo/demo.css"/>
<script type="text/javascript"
	src="../../js/resPermissions/jquery-easyui-1.4/jquery.min.js"></script>
<script type="text/javascript"
	src="../../js/resPermissions/jquery-easyui-1.4/jquery.easyui.min.js"></script>
<script type="text/javascript"
	src="../../js/resPermissions/jquery-easyui-1.4/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript"
	src="../../js/resPermissions/config_p/dispatcher.js"></script>
<script type="text/javascript"
	src="../../js/resPermissions/json/json2.js"></script>
 <script src="../../../JS/LangueSwitch.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
        <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
            <tr>
                <td height="30">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td width="15" height="32">
                                <img src="../../images/tab_03.png" width="15" height="32" />
                            </td>
                            <td width="1101" background="../../images/tab_05.gif">
                                <ul class="hor_ul">
                                    <li>
                                        <img src="../../images/001.gif" /><span style="margin-left:10px" id="subLoginUserName" ></span></li>
                                </ul>
                            </td>
                            <td width="281" background="../../images/tab_05.gif" align="right">
                                <img class="style6" style="cursor: hand;" onclick="window.parent.mycallfunction('resPermissions/configUserResourcePermissions_add',800,600)"
                                    onmouseover="javascript:this.src='../../images/close_un.png';" onmouseout="javascript:this.src='../../images/close.png';"
                                    src="../../images/close.png" />
                            </td>
                            <td width="14">
                                <img src="../../images/tab_07.png" width="14" height="32" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td width="15" background="../../images/tab_12.gif">
                                &nbsp;
                            </td>
                            <td align="center"  id="dragtd">
                              <div class="easyui-layout">
                                  <div id="processImg" style="position:absolute; margin-left:375px;margin-top:50px;display:none"><img  src="../../../Images/ProgressBar/05043123.gif" /></div>
    <div style="display:inline-block;width:95%;overflow:auto;">
			<div style="width:49%;float:left">
			<div class="easyui-panel" region="west" style="padding:5px;height:500px;overflow:scroll;">
				<ul id="entityAndTypeTree" class="easyui-tree" data-options="animate:true,checkbox:true"></ul>
			</div>
        </div>
        <div style="width:49%;float:right">
            
            <div class="easyui-panel" region="east" style="padding:5px;height:500px; overflow:scroll;">
				<div style="text-align:center;border:solid; border-width:1px"><span id="refreshPresentResPermisionTree" onclick="refreshPresentResPermisionTree()" style="cursor:pointer;color:blue"></span>&nbsp;&nbsp;&nbsp;&nbsp;<span id="PresentResPermision"><%--当前资源权限--%></span></div>
                <ul id="selectedUserResPermision" class="easyui-tree" data-options="animate:true"></ul>
			</div>
           </div>
		</div>

	<script type="text/javascript">
	    window.onload = function () {

	    }
	    var par = '<%=par%>';
	    var param = eval('(' + par + ')')

	    var loginUserId = "";
	    var loginuserEntityId = "";
	    var selectedLoginuserId = "";
	    var subLoginUserName = "";
	    try{
	        loginUserId=param.loginUserId;
	    }
	    catch (e) { }

	    try {
	        loginuserEntityId = param.loginuserEntityId;
	    }
	    catch (e) { }

	    try {
	        selectedLoginuserId = param.selectedLoginuserId;
	    }
	    catch (e) { }
	    try {
	        subLoginUserName = param.subLoginUserName;
	    }
	    catch (e) { }

	    //alert("par:"+par+",loginUserId:" + loginUserId + ",loginuserEntityId:" + loginuserEntityId + ",selectedLoginuserId:" + selectedLoginuserId);


	    $(function () {
	        
	       $.ajax({
	            type: "POST",
	            url: "../../../Handlers/resPermissions/LoginuserResourcePermissionsByUserId_get.ashx",
	            data: "loginUserId=" + loginUserId,
	            success: function (msg) {
	                var mydd = {};
	                try {
	                    mydd = eval("(" + msg + ")");
	                }
	                catch (e) {
	                    mydd = eval(msg);
	                }
	                $("#entityAndTypeTree").tree({
	                    data: mydd,

	                    onBeforeExpand: function (node, param) {
	                        $('#entityAndTypeTree').tree('options').url = "../../../Handlers/resPermissions/getSubEntityAndUsertypeByEntityIdRecursive.ashx?loginuserEntityId=" + loginuserEntityId + "&nodeId=" + node.id;
	                    }
	                });
	            }
	        });
	        //selectedUserResPermision
	       getSelectedUserResPermision();

	       setSubLoginUserNameInTitle(subLoginUserName);
	       languageSwitch();
	    });
	    function getSelectedUserResPermision() {
	        $('#selectedUserResPermision').tree(
	                       {
	                           url: '../../../Handlers/resPermissions/LoginuserResourcePermissionsByUserId_get.ashx?loginUserId=' + selectedLoginuserId,

	                           onBeforeExpand: function (node, param) {

	                               $('#selectedUserResPermision').tree('options').url = "../../../Handlers/resPermissions/getSubEntityAndUsertypeByEntityIdRecursive.ashx?loginuserEntityId=" + loginuserEntityId + "&nodeId=" + node.id;

	                           }
	                       });
	        
	        
	    }
	    function setSubLoginUserNameInTitle(subLoginUserName) {
	        var subLoginUserNameSpan = document.getElementById("subLoginUserName");
	        if (subLoginUserNameSpan) {
	            subLoginUserNameSpan.innerHTML = subLoginUserName;
	        }
	    }
	    function languageSwitch(){
	        var PresentResPermision = window.parent.GetTextByName('PresentResPermision', window.parent.useprameters.languagedata);
	        var PresentResPermisionItem = document.getElementById("PresentResPermision");
	        if (PresentResPermisionItem) {
	            PresentResPermisionItem.innerHTML = PresentResPermision;
	        }
	        var refresh = window.parent.GetTextByName('refresh', window.parent.useprameters.languagedata);
	        var refreshPresentResPermisionTree = document.getElementById("refreshPresentResPermisionTree");
	        if (refreshPresentResPermisionTree) {
	            refreshPresentResPermisionTree.innerHTML = refresh;
	        }
	        
	    }
	    function refreshPresentResPermisionTree(){
	        getSelectedUserResPermision();
	    }
	        //http://localhost:34534/Handlers/resPermissions/LoginuserResourcePermissionsByUserId_get.ashx?loginUserId=2
	        //http://localhost:34534/Handlers/resPermissions/getSubEntityAndUsertypeByEntityIdRecursive.ashx?loginuserEntityId=1
    </script>
            </div>
                            </td>
                            <td width="14" background="../../images/tab_16.gif">
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td width="15" background="../../images/tab_12.gif">
                                &nbsp;
                            </td>
                            <td align="center" height="30">
                                <%--<asp:ImageButton ID="ImageButton1" OnClientClick="saveLoginuserResourcePermissions('entityAndTypeTree',selectedLoginuserId);" ImageUrl="../../images/add_ok.png" runat="server"
                                     />--%>
                                <img id="LangConfirm" style="cursor: hand;" onclick="saveLoginuserResourcePermissions('entityAndTypeTree',selectedLoginuserId);" />
                                &nbsp;&nbsp;&nbsp;           
                                                     <img id="Lang-Cancel" style="cursor: hand;" onclick="window.parent.mycallfunction('resPermissions/configUserResourcePermissions_add',800,600)"/>
                            </td>
                            <td width="14" background="../../images/tab_16.gif">
                                &nbsp;
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td height="15">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td width="15" height="15">
                                <img src="../../images/tab_20.png" width="15" height="15" />
                            </td>
                            <td background="../../images/tab_21.gif">
                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td width="25%" nowrap="nowrap">
                                            &nbsp;
                                        </td>
                                        <td width="75%" valign="top" class="STYLE1">
                                           
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td width="14">
                                <img src="../../images/tab_22.png" width="14" height="15" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>    
               
    </form>
    <script type="text/javascript">
        window.parent.closeprossdiv();
        var image1 = window.document.getElementById("LangConfirm");
        var srouce1 = "../" + window.parent.parent.GetTextByName("LangConfirm", window.parent.parent.useprameters.languagedata);
        image1.setAttribute("src", srouce1);
        var image2 = window.document.getElementById("Lang-Cancel");
        var srouce2 = "../" + window.parent.parent.GetTextByName("Lang-Cancel", window.parent.parent.useprameters.languagedata);
        image2.setAttribute("src", srouce2);
    </script>
</body>
</html>
