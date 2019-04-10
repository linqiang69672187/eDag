<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="path_selectcolor.aspx.cs"
	Inherits="Web.lqnew.opePages.path_selectcolor" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<html xmlns:v>
<head runat="server">

	<script src="../../JQuery/jquery-1.5.2.js" type="text/javascript"></script>
	<script src="../iColorPicker.js" type="text/javascript"></script>
	<script src="../../JS/LangueSwitch.js"></script>
	<script src="../../LangJS/managerGroup_langjs.js"></script>
	<%-- <script src="../js/dragwindow.js" type="text/javascript"></script>--%>
	<title></title>
	<style type="text/css">
		body
		{
			font-size: 12px;
			margin: 0px;
			background-color: transparent;
		}

		td
		{
			font-size: 12px;
			color: Black;
		}

		v\:*
		{
			behavior: url(#default#VML);
		}

		#multiinput
		{
			font-size: 12px;
			border: 1px #000 solid;
			font-weight: 700;
			height: 55px;
			width: 280px;
			overflow-y: auto;
		}
			/*span {
			   color:Blue;
			   cursor:hand;
			}*/

			#multiinput a:hover
			{
				background-color: #eee;
				cursor: text;
			}
	</style>
	<script src="../js/geturl.js" type="text/javascript"></script>
	<script src="../js/dragwindow.js" type="text/javascript"></script>
	<script src="../js/CommValidator.js" type="text/javascript"></script>
	<script src="../js/manageStopSelectSubmit.js" type="text/javascript"></script>
	<script src="../../LangJS/managerGroup_langjs.js"></script>
</head>
<body style="font-size: 12px; margin: 0px;">
	<form id="form1" runat="server">

		<div style="top: 0px; left: 0px; height: 100%;">
			<table width="100%" border="0"  align="center" cellpadding="0" cellspacing="0">
				<tr>
					<td height="">
						<div id="divdrag" style="cursor: move">
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td width="15" height="32">
										<asp:ScriptManager ID="ScriptManager2" runat="server">
										</asp:ScriptManager>
										<img src="../images/tab_03.png" width="15" height="100%" />
									</td>
									<td id="Lang_Choice_of_electronic_fence_style" width="1101" background="../images/tab_05.gif" style="color: White">
										<%--选择电子栅栏样式--%>
									</td>
									<td width="281" background="../images/tab_05.gif" align="right">
										<img class="style6" style="cursor: hand;" onclick="javascript:window.parent.hiddenbg2();window.parent.mycallfunction(geturl(),693, 354)"
											onmouseover="javascript:this.src='../images/close_un.png';" onmouseout="javascript:this.src='../images/close.png';"
											src="../images/close.png" />
									</td>
									<td width="14">
										<img src="../images/tab_07.png" width="14" height="100%" />
									</td>
								</tr>
							</table>
						</div>
					</td>
				</tr>
				<tr>
					<td valign="top" id="dragtd">
						<table width="100%" style="background-color: White" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="15" background="../images/tab_12.gif">&nbsp;
								</td>
								<td align="left" valign="middle" height="25px" colspan="3">
									<table style="width: 100%">
										<tr>
											<td style="width: 70px" align="right">
												<span id="Lang_Shape"></span>
											</td>
											<td>
												<li id="square" title="<%--矩形--%>" onclick="vmltype(this)" style="background-image: url('images/pathstyle.png'); background-position: 0 0; float: left; height: 32px; width: 32px; margin-left: 10px; list-style-type: none; background-repeat: no-repeat; cursor: hand;"></li>
												<li title="<%--圆形--%>" onclick="vmltype(this)" id="oval" style="background-image: url('images/pathstyle.png'); background-position: -42px 0; float: left; height: 32px; width: 32px; margin-left: 10px; list-style-type: none; background-repeat: no-repeat; cursor: hand;"></li>
												<!--<li id="ellipse" title='<%--椭圆--%>' onclick="vmltype(this)" style="background-image: url('images/pathstyle.png'); background-position: -84px 0; float: left; height: 32px; width: 32px; margin-left: 10px; list-style-type: none; background-repeat: no-repeat; cursor: hand"></li>-->
												<li onclick="vmltype(this)" id="polygon" style="background-image: url('images/pathstyle.png'); background-position: -126px 0; float: left; height: 32px; width: 32px; margin-left: 10px; list-style-type: none; background-repeat: no-repeat; cursor: hand"
													title="<%--多边形--%>"></li>
											</td>
										</tr>
									</table>

								</td>
								<td align="left">

									<img id="add_okPNG" style="margin: 0px 0px 0px 3px; cursor: hand; display: none" src="<%--../images/add_ok.png--%>" onclick="selectcolor()" />
								</td>

								<td width="14" background="../images/tab_16.gif">&nbsp;
								</td>
							</tr>
							<tr>
								<td width="15" background="../images/tab_12.gif">&nbsp;
								</td>
								<td align="left" colspan="3" valign="middle" height="40px" class="style1">
									<div style="color: Red" id="divNotice"></div>
								</td>
								<td align="left">&nbsp;&nbsp;
								</td>
								<td width="14" background="../images/tab_16.gif">&nbsp;
								</td>
							</tr>
							<tr>
								<td width="15" background="../images/tab_12.gif">&nbsp;
								</td>
								<td align="left" valign="middle" height="25px" class="style1">
									<table>
										<tr>
											<td style="width: 80px" align="right">
												<span id="Lang_name_trace"><%--&nbsp; 名&nbsp;&nbsp;&nbsp;&nbsp;称：&nbsp;&nbsp;--%></span>&nbsp;&nbsp; 
											</td>
											<td align="left">
												<input type="text" id="stockadeTitle" />
											</td>
										</tr>
									</table>

								</td>
								<td align="left" valign="middle">&nbsp;
								</td>
								<td align="left" width="80px">&nbsp;
								</td>
								<td align="left">&nbsp;&nbsp;
								</td>
								<td width="14" background="../images/tab_16.gif">&nbsp;
								</td>
							</tr>
							<tr>
								<td width="15" background="../images/tab_12.gif">&nbsp;
								</td>
								<td align="left" valign="middle" height="25px" class="style1" colspan="2">
									<table>
										<tr>
											<td style="width: 80px" align="right">
												<span id="Lang_Filling"><%--&nbsp;填&nbsp; &nbsp;&nbsp;充：&nbsp;--%></span>&nbsp;&nbsp;
											</td>
											<td align="left">
                                                <div style="display:none">
												<input class="iColorPicker" id="color1" onpropertychange="rewritevml();" style="margin-top: 5px; width: 60px;"
													type="text" value="#fff799" />
                                                    </div>
                                                 <select id="selColor" onchange="rewritevml()">
                                                    
                                                </select>
                                                
											</td>
										</tr>
									</table>


								</td>
								<td align="middle" width="80px" rowspan="3"></td>
								<td align="left">&nbsp;&nbsp;
								</td>
								<td width="14" background="../images/tab_16.gif">&nbsp;
								</td>
							</tr>
							<tr>
								<td width="15" background="../images/tab_12.gif">&nbsp;
								</td>
								<td align="left" valign="middle" height="25px" class="style1" colspan="2">
									<table>
										<tr>
											<td style="width: 80px" align="right">
												<span id="Lang_lunkuo"><%--&nbsp; 轮&nbsp; &nbsp;&nbsp;廓：&nbsp;--%></span> &nbsp;&nbsp;
											</td>
											<td align="left">
                                                 <div style="display:none">
												<input id="color2" class="iColorPicker" onpropertychange="rewritevml();" style="margin-top: 5px; width: 60px;"
													type="text" value="#000" />
                                                     </div>
                                                 <select id="selColor2" onchange="rewritevml()">
                                                    
                                                </select>
											</td>
										</tr>
									</table>



								</td>
								<td align="left">&nbsp;&nbsp;
								</td>
								<td width="14" background="../images/tab_16.gif">&nbsp;
								</td>
							</tr>

							<tr>
								<td width="15" background="../images/tab_12.gif">&nbsp;
								</td>
								<td align="left" height="25px" valign="middle" class="style1" colspan="2">
									<table>
										<tr>
											<td style="width: 80px" align="right">
												<span id="Lang_Transparency"><%--&nbsp;透明度：&nbsp;--%></span>&nbsp;&nbsp;
											</td>
											<td align="left">
												<asp:TextBox ReadOnly="true" Enabled="false" onPropertyChange="rewritevml();" ID="TextBox2" runat="server" Height="18px"
													Width="60px">0.3</asp:TextBox>
												<cc1:NumericUpDownExtender ID="TextBox2_NumericUpDownExtender" runat="server" Enabled="True"
													Maximum="1" Minimum="0" RefValues="" ServiceDownMethod="" ServiceDownPath=""
													ServiceUpMethod="" Step="0.1" Tag="" TargetButtonDownID="" TargetButtonUpID=""
													TargetControlID="TextBox2" Width="50">
												</cc1:NumericUpDownExtender>
											</td>
										</tr>
									</table>


								</td>
								<td align="left">&nbsp;&nbsp;
								</td>
								<td width="14" background="../images/tab_16.gif">&nbsp;
								</td>
							</tr>
							<tr style="display:none">
								<td width="15" background="../images/tab_12.gif">&nbsp;
								</td>
								<td align="left"  height="25px" valign="middle" class="style1" colspan="3">
									<table>
										<tr>
											<td style="width: 80px" align="right">
												<span id="Lang_style_trace"><%--&nbsp;&nbsp;样&nbsp;&nbsp;&nbsp;式：&nbsp;--%></span> &nbsp;&nbsp;
											</td>
											<td align="left">
												<select id="Select1" name="D1" style="" onchange="rewritevml()">
													<option value="solid" id="Lang_solid"><%--实线--%></option>
													<option value="dot" id="Lang_dot"><%--点线--%></option>
													<option value="dash" id="Lang_dash"><%--虚线--%></option>
													<option value="dashdot" id="Lang_dashdot"><%--点虚线--%></option>
													<option value="longdash" id="Lang_longdash"><%--长虚线--%></option>
													<option value="longdashdot" id="Lang_longdashdot"><%--虚点线--%></option>
													<option value="longdashdotdot" id="Lang_longdashdotdot"><%--双点线--%></option>
												</select>&nbsp;
											</td>
										</tr>
									</table>


								</td>
								<td align="left">&nbsp;&nbsp;
								</td>
								<td width="14" background="../images/tab_16.gif">&nbsp;
								</td>
							</tr>
							<tr>
								<td width="15" background="../images/tab_12.gif">&nbsp;
								</td>
								<td align="left" valign="middle" height="25px" class="style1" colspan="3">
									<table>
										<tr>
											<td style="width: 80px" align="right"><span id="Lang_user_trace"></span><%--&nbsp;用&nbsp;&nbsp;&nbsp; 户：&nbsp;--%>&nbsp;&nbsp;</td>
											<td>
												<div style="display: none">
													<textarea type="text" id="txtUsers" style="height: 100%; width: 90%" rows="3" runat="server"></textarea>
												</div>
												<div id="multiinput">&nbsp;</div>
											</td>
											<td>
												<img src="<%--../images/btn_add.png--%>" id="imgSelectUser" onmouseover="<%--javascript:this.src='../images/btn_add_un.png';--%>" onmouseout="<%--javascript:this.src='../images/btn_add.png';--%>" /></td>
										</tr>
									</table>


								</td>
								<td align="left">&nbsp;&nbsp;
								</td>
								<td width="14" background="../images/tab_16.gif">&nbsp;
								</td>
							</tr>
							<tr>
								<td width="15" background="../images/tab_12.gif">&nbsp;
								</td>
								<td align="center" valign="middle" height="25px" class="style1" colspan="3">

									<input id="btn_begdraw" type="button" onclick="selectcolor()" />

								</td>
								<td align="left">&nbsp;&nbsp;
								</td>
								<td width="14" background="../images/tab_16.gif">&nbsp;
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
									<img src="../images/tab_20.png" width="15" height="15" />
								</td>
								<td background="../images/tab_21.gif">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td width="25%" nowrap="nowrap">&nbsp;
											</td>
											<td width="75%" valign="top" class="STYLE1">&nbsp;
											</td>
										</tr>
									</table>
								</td>
								<td width="14">
									<img src="../images/tab_22.png" width="14" height="15" />
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<v:oval id="ellipsepath" style="z-index: 3001; left: 255; width: 120; position: absolute; top: 128; height: 80; display: none;"
				filled="t" fillcolor="#e1e1e1" strokecolor='#000'>
		<v:fill id="ellipsefill" type="frame" opacity=".5"/>
		<v:stroke  id="ellipsestroke" dashstyle="shortDashDot"/>
		</v:oval>
			<v:oval id="ovalpath" style="z-index: 3001; left: 255; width: 120; position: absolute; top: 94; height: 120; display: none;"
				filled="t" fillcolor="#e1e1e1" strokecolor='#000'>
		<v:fill id="ovalfill" type="frame" opacity=".5"/>
		<v:stroke  id="ovalstroke" dashstyle="shortDashDot"/>
		</v:oval>
			<v:rect id="squarepath" style="z-index: 3001; left: 255; width: 120; position: absolute; top: 128; height: 80; display: none;"
				filled="t" fillcolor="#e1e1e1" strokecolor='#000'>
		<v:fill id="squarefill" type="frame" opacity=".5"/>
		<v:stroke  id="squarestroke" dashstyle="shortDashDot"/>
		</v:rect>
			<v:polyline id="polygonpath" style="z-index: 3087; left: 257px; position: absolute; top: 144px; display: none;"
				points="0,0,0,60,120,60,120,40,80,0,120,-40,40,-40,0,0"
				filled="t" fillcolor="#e1e1e1" strokecolor='#000'>
		<v:fill id="polygonfill" type="frame" opacity=".5"/>
		<v:stroke  id="polygonstroke" dashstyle="shortDashDot"/>
		</v:polyline>
		</div>
	</form>
</body>
</html>
<script language="javascript">
	var type = "";
	var SelectUsers = new Array();
	var memberlimitcount = window.parent.fenceMemberCount;
	function geturl() {
		var str = window.location.href;
		str = str.substring(str.lastIndexOf("/") + 1)
		str = str.split(".")[0];
		return str;
	}
	var userids = ""; //用户列表 用逗号隔开 用来传递给后台的 格式为：id1;id2;id3
	var uinfo = ""; //用户名,id;用户名,id
	var userInfos = new Array();
	/**@提供给选择页面调用***/
	function faterdo(arrR) {

		userInfos.length = 0;
		uinfo = "";
		userids = "";
		for (var i in arrR) {
			userids += arrR[i].id + ";";
			uinfo += arrR[i].uname + "," + arrR[i].id + "," + arrR[i].uissi + ";";
		}
		if (uinfo.length > 0) {
			uinfo = uinfo.substring(0, uinfo.length - 1);
			userids = userids.substring(0, userids.length - 1);
		}
		//uinfo = strR;
		showUserInfo();
	}
	/***@在用户框内显示用户信息，并把需要传给后台的值赋值给userids变量****/
	function showUserInfo() {
		var strShow = "";
		userInfos.length = 0;
		userids = "";
		if (uinfo.indexOf(";") <= 0) {
			if (uinfo.split(',')[0] != "") {
				strShow = uinfo.split(',')[0] + "<span style='cursor:hand' onclick=\"DeleteArray('" + uinfo + "')\"><img class='style6' onmouseover=\"javascript:this.src='../images/close_un.png';\" onmouseout=\"javascript:this.src='../images/close.png';\" src=\"../images/close.png\" /></span> &nbsp;&nbsp;";
				userids = uinfo.split(',')[1];
				userInfos.push(uinfo);

			}
		}
		else {
			var parr = uinfo.split(";");
			for (var pa in parr) {
				userInfos.push(parr[pa]);
				if (parr[pa].split(',')[0] != "") {
					strShow += parr[pa].split(',')[0] + "<span style='cursor:hand' onclick=\"DeleteArray('" + parr[pa] + "')\"><img class='style6' onmouseover=\"javascript:this.src='../images/close_un.png';\" onmouseout=\"javascript:this.src='../images/close.png';\" src=\"../images/close.png\" /></span> &nbsp;&nbsp;";
					userids += parr[pa].split(',')[1] + ";";
				}
			}
			if (userids.length > 0) {
				userids = userids.substring(0, userids.length - 1);
			}
		}
		$('#multiinput').html(strShow);


	}
	function DeleteArray(infos) {
		var Lang_Please_complete_prior_electronic_fence = window.parent.parent.GetTextByName("Lang_Please_complete_prior_electronic_fence", window.parent.parent.useprameters.languagedata);
		userids = "";
		uinfo = "";
		for (var k in userInfos) {
			if (infos != userInfos[k]) {
				userids += userInfos[k].split(',')[1] + ";";
				uinfo += userInfos[k] + ";";
			}
		}
		if (uinfo.length > 0) {
			uinfo = uinfo.substring(0, uinfo.length - 1);
			userids = userids.substring(0, userids.length - 1);
		}
		showUserInfo();
	}
	$(document).ready(function () {
		var Lang_Please_complete_prior_electronic_fence = window.parent.parent.GetTextByName("Lang_Please_complete_prior_electronic_fence", window.parent.parent.useprameters.languagedata);
		var members = window.parent.parent.GetTextByName("members", window.parent.parent.useprameters.languagedata);

		if (window.parent.isBegStackadeSel) {
			alert(Lang_Please_complete_prior_electronic_fence);//("请先完成之前发起的电子栅栏");
			window.parent.closeprossdiv(); window.parent.mycallfunction(geturl());
			return;
		}

		uinfo = $('#<%=txtUsers.ClientID %>').val();
		showUserInfo();
		$("#imgSelectUser").click(function () {
			SelectUsers.length = 0;
			var myusers = uinfo.split(";");

			for (var i in myusers) {
			    try {

					var mname = myusers[i].split(",")[0];
					var mid = myusers[i].split(",")[1];
					var missi = myusers[i].split(",")[2];
					if (missi != undefined && mname != undefined) {
					    $.ajax({
					        type: "POST",
					        url: "../../Handlers/GetUserInfo_Handler.ashx",
					        data: "issi=" + missi,
					        success: function (msg) {
					            var my = eval(msg);
					            usertype = escape(my[0].type);
					            if (my[0].nam != undefined) {
					                SelectUsers.push({
					                    uname: my[0].nam, uissi: my[0].issi, utype: my[0].type, issitype: my[0].issitype
					                })
					            }

					        }
					    });
					}
				} catch (ex) {

				}
			}
			//for (var i = 0; i < myMemberArray.length; i++) {
			//    SelectUsers.push({ uname: myMemberArray[i].name, uissi: myMemberArray[i].issi, utype: myMemberArray[i].type });
			//}
			window.parent.mycallfunction('AddMemberTree/add_Member', 650, 514, '0&ifr=path_selectcolor_ifr&selectcount=' + memberlimitcount + '&type=user&selfclose=1', 2001);
			//window.parent.mycallfunction('Add_StackMember/add_Member', 635, 514, userids + "&ifr=path_selectcolor_ifr", 2001);

		});

		$("#divdrag").mousedown(function () {
			dragdiv();
		});
		$("#divdrag").mousemove(function () {
			mydragWindow();
		});
		$("#divdrag").mouseup(function () {
			mystopDragWindow();
		});
		document.body.oncontextmenu = function () { return false; }
		document.body.oncontextmenu = function () { return false; }
		var arrayelement = ["input", "a", "select", "li", "font", "textarea"];
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
	});
	function selectcolor() {

		var ToEndSMSMultiSend = window.parent.parent.GetTextByName("ToEndSMSMultiSend", window.parent.parent.useprameters.languagedata);
		var Alert_PleaseOverKX = window.parent.parent.GetTextByName("Alert_PleaseOverKX", window.parent.parent.useprameters.languagedata);
		var PleaseEndRang = window.parent.parent.GetTextByName("PleaseEndRang", window.parent.parent.useprameters.languagedata);
		var Lang_Please_select_an_electronic_fence_shape = window.parent.parent.GetTextByName("Lang_Please_select_an_electronic_fence_shape", window.parent.parent.useprameters.languagedata);
		var Lang_biggerthansystemlimit = window.parent.parent.GetTextByName("Lang_biggerthansystemlimit", window.parent.parent.useprameters.languagedata);

		if (window.parent.isBegSendMsgSel) {
			alert(ToEndSMSMultiSend);//("请先完成短信群发功能");
			return;
		}
		if (window.parent.ismyrectangleSel) {
			alert(Alert_PleaseOverKX);//("请先完成框选");
			return;
		}
		var cj = window.parent.document.getElementById("imgrang");

		//if (cj.src.indexOf("Images/ToolBar/rightbg/ring_un.png") > 0) {
		//    alert(PleaseEndRang);//("请结束当前测距状态");
		//    return;
		//}
		if (type == "") {
			alert(Lang_Please_select_an_electronic_fence_shape);//('请选择一个电子栅栏形状');
			return;
		}

		var myusers = uinfo.split(";");

		if (myusers.length > memberlimitcount) {
			alert(Lang_biggerthansystemlimit + "[" + memberlimitcount + "]");//电子栅栏最多支持的成员数[200];
			return;
		}

		var stroke1 = document.getElementsByTagName("stroke")
		var color1 = document.getElementById("color1");
		var color2 = document.getElementById("color2");
		var Lang_please_fill_the_name_of_fence = window.parent.parent.GetTextByName("Lang_please_fill_the_name_of_fence", window.parent.parent.useprameters.languagedata);
		var fillcolor = color1.value;              /**填充颜色**/
		var strokecolor = color2.value;           /**边线颜色**/

		fillcolor = "#"+window.parent.colorCodeToFlashColor(window.document.getElementById("selColor").value);
		strokecolor = "#"+window.parent.colorCodeToFlashColor(window.document.getElementById("selColor2").value);
		

		var opacity = 100 * $("#TextBox2").val();        /**填充透明度**/
		var linestyle = $("#Select1").val();       /**边线样式**/
		//var id = getQueryStringRegExp('id');        /**url参数**/
		var mytitle = $("#stockadeTitle").val();
		var Lang_The_name_can_be_no_longer_than_10_characters = window.parent.parent.GetTextByName("Lang_The_name_can_be_no_longer_than_10_characters", window.parent.parent.useprameters.languagedata);
		var Lang_the_name_cludes_special_word = window.parent.parent.GetTextByName("Lang_the_name_cludes_special_word", window.parent.parent.useprameters.languagedata);
		var Lang_Fence_name_already_exists = window.parent.parent.GetTextByName("Lang_Fence_name_already_exists", window.parent.parent.useprameters.languagedata);
		var Lang_please_select_the_initial_user = window.parent.parent.GetTextByName("Lang_please_select_the_initial_user", window.parent.parent.useprameters.languagedata);
		if (mytitle.trim() == "") {
			alert(Lang_please_fill_the_name_of_fence);//('请填写栅栏名称');
			return;
		}
		if (mytitle.length > 10) {
			alert(Lang_The_name_can_be_no_longer_than_10_characters);//('名称长度不能大于10个字符')
			return;
		}
		if (checkUnNomal(mytitle)) {
			alert(Lang_the_name_cludes_special_word);//("名称含特殊字符");
			return;
		}
		window.parent.jquerygetNewData_ajax("../../Handlers/IsStockadeTitleExist.ashx", { title: mytitle },function (msg) {
				
				if (msg == '1') {
					alert(Lang_Fence_name_already_exists);//("栅栏名称已经存在");
				} else {
					id = userids;
					if (id == "") {
						alert(Lang_please_select_the_initial_user);//('请选择初始用户');
						return;
					}

					window.parent.hiddenbg2();
					var content = "Log_Add_Elect_Content;Log_Elect_Name:" + mytitle + ";Log_Elect_Type:" + type + ";Log_Elect_UserID:" + id.replace(new RegExp(/(;)/g), ",");
					window.parent.writeToDbByOther(window.parent.OperateLogType.operlog, window.parent.OperateLogModule.ModuleApplication, window.parent.OperateLogOperType.ElectronicFence, content, window.parent.OperateLogIdentityDeviceType.Other);

					//window.parent.begDZSL(id, type, { strokecolor: strokecolor, opacity: opacity, fillcolor: fillcolor, linestyle: linestyle }, mytitle);
					window.parent.isBegStackadeSel = true;
					//window.parent.CloseAllFrameWindow();
					//window.parent.selectcolortrace(id, fillcolor, strokecolor, opacity, linestyle, type);
					window.parent.valueDZZL = type
					window.parent.addInteraction(id, fillcolor, strokecolor, type, mytitle, opacity);
					//window.parent.FinishDraw(id, fillcolor, strokecolor, type, mytitle, opacity);
                    window.parent.mycallfunction(geturl(), 693, 354);
					window.parent.loadDZZL();//cxy-20180807-绘完电子围栏后展示在地图上
				}

			}
		);




	}
	function getQueryStringRegExp(id) {
		var reg = new RegExp("(^|\\?|&)" + id + "=([^&]*)(\\s|&|$)", "i");
		if (reg.test(location.href)) return unescape(RegExp.$2.replace(/\+/g, " ")); return "";
	};
	window.onload = function () {
		window.parent.visiablebg2();
		$("#TextBox1").bind('');
	}
	function rewritevml() {
		var stroke1 = document.getElementsByTagName("stroke")
		var color1 = document.getElementById("color1")
		var color2 = document.getElementById("color2")

		var fillcolor = color1.value;              /**填充颜色**/
		var strokecolor = color2.value;           /**边线颜色**/
	
		fillcolor = window.parent.colorCodeToHtmlColor(window.document.getElementById("selColor").value);
		strokecolor = window.parent.colorCodeToHtmlColor(window.document.getElementById("selColor2").value);

		var opacity = $("#TextBox2").val();        /**填充透明度**/
		var linestyle = $("#Select1").val();       /**边线样式**/

		$("stroke").each(function () {
			this.dashstyle = linestyle;
		})

		$("fill").each(function () {
			this.opacity = opacity;
		})


		$("oval,polyline,rect").each(function () {
			this.strokecolor = strokecolor;
			this.fillcolor = fillcolor;
		})


	}
	function vmltype(obj) {
		var DrawTitle = window.parent.parent.GetTextByName("DrawTitle", window.parent.parent.useprameters.languagedata);
		$("#square").css("backgroundPosition", "0 0");  /**长方形背景**/
		$("#squarepath").css("display", "none")
		$("#oval").css("backgroundPosition", "-42 0"); /**圆形背景**/
		$("#ovalpath").css("display", "none")
		//$("#ellipse").css("backgroundPosition", "-84 0"); /**椭圆背景**/
		$("#ellipsepath").css("display", "none")
		$("#polygon").css("backgroundPosition", "-126 0"); /**多边形**/
		$("#polygonpath").css("display", "none")
		switch (obj.id) {
			case "square":
				$("#square").css("backgroundPosition", "0 -32px");  /**长方形背景**/
				$("#squarepath").css("display", "");
				$("#divNotice").html(DrawTitle);//("在起始点点击鼠标左键不松开，移动到结束点松开鼠标左键");
				type = "Box";
				break;
			/*case "ellipse":
				$("#ellipse").css("backgroundPosition", "-84 -32px");  /**椭圆
				$("#divNotice").html(DrawTitle);//("在起始点点击鼠标左键不松开，移动到结束点松开鼠标左键");
				$("#ellipsepath").css("display", "");
				type = "ellipse";
				break;**/
			case "oval":
				$("#oval").css("backgroundPosition", "-42 -32px");  /**圆背景**/
				$("#divNotice").html(DrawTitle);//("在起始点点击鼠标左键不松开，移动到结束点松开鼠标左键");
				$("#ovalpath").css("display", "")
				type = "Circle";
				break;
			case "polygon":
				$("#polygon").css("backgroundPosition", "-126 -32px");  /**多边形背景**/
				$("#divNotice").html(DrawTitle);//("单击鼠标左键开始画图与继续画图,单击鼠标右键结束画图,开始后不得缩放地图");
				$("#polygonpath").css("display", "")
				type = "Polygon";
				break;
		}
	}

	var dragEnable = 'True';
	function dragdiv() {
		var div1 = window.parent.document.getElementById(geturl());
		if (div1 && event.button == 0 && dragEnable == 'True') {
			window.parent.mystartDragWindow(div1, null, event); div1.style.border = "solid 3px transparent"; window.parent.cgzindex(div1);

		}
	}
	function mydragWindow() {
		var div1 = window.parent.document.getElementById(geturl());
		if (div1) {
			window.parent.mydragWindow(div1, event);
		}
	}
	function mystopDragWindow() {
		var div1 = window.parent.document.getElementById(geturl());
		if (div1) {
			window.parent.mystopDragWindow(div1); div1.style.border = "0px";
		}
	}
</script>
<script>
	window.parent.closeprossdiv();
	LanguageSwitch(window.parent);
	var image1 = window.document.getElementById("add_okPNG");
	var srouce1 = window.parent.parent.GetTextByName("LangConfirm", window.parent.parent.useprameters.languagedata);
	image1.setAttribute("src", srouce1);

	var image = window.document.getElementById("imgSelectUser");
	var srouce = window.parent.parent.GetTextByName("Lang_chooseMemberPNG", window.parent.parent.useprameters.languagedata);
	image.setAttribute("src", srouce);
	var strpath = window.parent.parent.GetTextByName("Lang_chooseMemberPNG", window.parent.parent.useprameters.languagedata);
	var strpathmove = window.parent.parent.GetTextByName("Lang_chooseMemberPNG_un", window.parent.parent.useprameters.languagedata);
	image.onmouseover = function () { this.src = strpathmove }
	image.onmouseout = function () { this.src = strpath }

	window.document.getElementById("square").title = window.parent.parent.GetTextByName("Lang_square", window.parent.parent.useprameters.languagedata);
	window.document.getElementById("oval").title = window.parent.parent.GetTextByName("Lang_oval", window.parent.parent.useprameters.languagedata);
	//window.document.getElementById("ellipse").title = window.parent.parent.GetTextByName("Lang_ellipse", window.parent.parent.useprameters.languagedata);
	window.document.getElementById("polygon").title = window.parent.parent.GetTextByName("Lang_polygon", window.parent.parent.useprameters.languagedata);

	window.document.getElementById("btn_begdraw").value = window.parent.parent.GetTextByName("Lang_begdrawstockabe", window.parent.parent.useprameters.languagedata);

	window.parent.loadColorOption(window.document.getElementById("selColor"));
	window.parent.loadColorOption(window.document.getElementById("selColor2"));
</script>
