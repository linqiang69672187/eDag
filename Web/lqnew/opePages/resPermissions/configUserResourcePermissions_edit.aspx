<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="configUserResourcePermissions_edit.aspx.cs" Inherits="Web.lqnew.opePages.resPermissions.configUserResourcePermissions_edit" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <link href="../../../CSS/pagestyle.css" rel="stylesheet" type="text/css" />
    <script src="../js/geturl.js" type="text/javascript"></script>
    <link href="../../css/lq_addedit.css" rel="stylesheet" type="text/css" />
    <script src="../../js/dragwindow.js" type="text/javascript"></script>

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
                                        <img src="../../images/037.gif" /><span style="margin-left:10px" id="subLoginUserName" ></span></li>
                                </ul>
                            </td>
                            <td width="281" background="../../images/tab_05.gif" align="right">
                                <img class="style6" style="cursor: hand;" onclick="window.parent.mycallfunction('resPermissions/configUserResourcePermissions_edit',800,600)"
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
                              <div>
                                  <div id="processImg" style="position:absolute; margin-left:375px;margin-top:50px;display:none"><img  src="../../../Images/ProgressBar/05043123.gif" /></div>
        <div style="display:inline-block;width:95%;overflow: auto"">
    <div class="easyui-panel" style="padding:5px;height:500px;overflow:scroll">

				<ul id="ResourcePermissionsTree_edit" class="easyui-tree" data-options="animate:true,checkbox:true"></ul>
			</div>
            </div>
			<script type="text/javascript">
			    			    
			    var par = '<%=par%>';
			    var param = eval('(' + par + ')')

			    var loginUserId = "";
			    var loginuserEntityId = "";
			    var selectedLoginuserId = "";
			    var subLoginUserName = "";
			    try {
			        loginUserId = param.loginUserId;
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
			    window.onload = function () {
			        $('#ResourcePermissionsTree_edit')
                            .tree(
                                    {
                                        url: '../../../Handlers/resPermissions/LoginuserResourcePermissionsByUserId_edit.ashx?loginUserId=' + loginUserId + '&subLoginUserId=' + selectedLoginuserId

                                    });
			        //var par = {loginUserId:loginUserId,subLoginUserId:selectedLoginuserId};
			        //$.ajax({
			        //    type: "POST",
			        //    url: "../../../Handlers/resPermissions/LoginuserResourcePermissionsByUserId_edit.ashx",
			        //    data: par,
			        //    success: function (msg) {
			        //        var mydd = {};
			        //        try {
			        //            mydd = eval("(" + msg + ")");
			        //        }
			        //        catch (e) {
			        //            mydd = eval(msg);
			        //        }
			        //        $("#ResourcePermissionsTree_edit").tree({
			        //            data: mydd
			        //        });
			        //    }
			        //});
			        setSubLoginUserNameInTitle(subLoginUserName);
			    }
			    function setSubLoginUserNameInTitle(subLoginUserName) {
			        var subLoginUserNameSpan = document.getElementById("subLoginUserName");
			        if (subLoginUserNameSpan) {
			            subLoginUserNameSpan.innerHTML = subLoginUserName;
			        }
			    }
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
                                <%--<asp:ImageButton ID="ImageButton1" OnClientClick="saveLoginuserResourcePermissions('ResourcePermissionsTree_edit');" ImageUrl="../../images/add_ok.png" runat="server"
                                     />--%>
                                <img id="Img1" style="cursor: hand;" onclick="saveLoginuserResourcePermissions('ResourcePermissionsTree_edit',selectedLoginuserId);" src="../../images/add_ok.png" />
                                &nbsp;&nbsp;&nbsp;
           
                                                     <img id="Lang-Cancel" style="cursor: hand;" onclick="window.parent.mycallfunction('resPermissions/configUserResourcePermissions_edit',800,600)"
                                    src="../../images/add_cancel.png" />
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
    </script>
</body>
</html>