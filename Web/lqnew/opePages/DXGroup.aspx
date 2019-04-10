<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DXGroup.aspx.cs" Inherits="Web.lqnew.opePages.DXGroup" %>
<%@ Import Namespace="DbComponent.Comm" %>
<%@ Import Namespace="System.Configuration" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <script src="../../JQuery/jquery-1.5.2.js" type="text/javascript"></script>
    <link href="../css/lq_addedit.css" rel="stylesheet" type="text/css" />
    <link href="../../CSS/pagestyle.css" rel="stylesheet" type="text/css" />
    <script src="../js/geturl.js" type="text/javascript"></script>
    <script src="../js/List.js" type="text/javascript"></script>
    <link href="../css/btn.css" rel="stylesheet" type="text/css" />
    <script src="../../JS/LangueSwitch.js" type="text/javascript"></script>
     <style type="text/css">
        .css_Grid{
        }
        
        .css_TR_c1
        {
            filter: progid:DXImageTransform.Microsoft.Gradient(GradientType=0, StartColorStr=#EFEFCB, EndColorStr=#EFEFCB);
            height: 20px;
            cursor: pointer;
        }
        .css_TR_c2
        {
            height: 20px;
            cursor: pointer;
        }
    </style>
    <script type="text/javascript">
        var haveCallPJ = new Array(); //存放已经发起多选的多选组
        var infoList = new Array;
        var dxgssi = ""; //选中的多选组ISSI
        var MemberInfoList = new Array(); //被派接的成员列表，点击派接初始化此数组，格式{pgid:1,mid:1020}
        var PJFlag = false; //是否多选
        var dxCount = 0;
        var Iscall = false; //判断是否正在进行多选组呼叫
        //判断是否有多选组选中
        function isselDXZFSelect() {
            var isflag = false;
            if (dxgssi != "") {
                isflag = true;
            }
            return isflag;
        }

        function IsCalling(pid) {
            var ret = false;
            for (var i = 0; i < haveCallPJ.length; i++) {
                if (pid == haveCallPJ[i].pid) {
                    ret = true;
                    break;
                }
            }
            return ret;
        }
        function RemoveHavaCall(pid) {
            var temp = new Array();
            for (var i = 0; i < haveCallPJ.length; i++) {
                if (pid != haveCallPJ[i].pid) {
                    temp.push(haveCallPJ[i]);
                }
            }
            haveCallPJ.length = 0;
            for (var i = 0; i < temp.length; i++) {
                haveCallPJ.push(temp[i]);
            }
        }
        function AddHaveCall(pid) {
            haveCallPJ.push({ pid: pid });
        }
        function addMemberInfoList(mid, pid) {
            var flag = false;
            for (var i = 0; i < MemberInfoList.length; i++) {
                if (MemberInfoList[i].mid == mid && MemberInfoList[i].pid == pid) {
                    flag = true;
                    break;
                }
            }
            if (!flag) {
                MemberInfoList.push({ mid: mid, pid: pid });
            }
        }

        function DateFor(str) {
            if (str.length < 2) {
                return "0" + str;
            } else
                return str;
        }
        function ClearMsg() {
            $("#DXMsgDIV").html("");
        }
        function AddMsg(msg) {
            $("#DXMsgDIV").html("<img src='../../Images/Police.png' />" + msg);
//            var varNow = new Date();
//            var times = varNow.getYear().toString() + "-" + DateFor(varNow.getMonth().toString()) + "-" + DateFor(varNow.getDay().toString()) + "&nbsp;&nbsp;" + DateFor(varNow.getHours().toString()) + ":" + DateFor(varNow.getMinutes().toString()) + ":" + DateFor(varNow.getSeconds().toString());
//            $("#DXMsgDIV").html(times + "&nbsp;&nbsp;" + msg + "<br>" + $("#DXMsgDIV").html());
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
        $(document).ready(function () {

            window.parent.visiablebg2();
            $("#divdrag").mousedown(function () {
                dragdiv();
            });
            $("#divdrag").mousemove(function () {
                mydragWindow();
            });
            $("#divdrag").mouseup(function () {
                mystopDragWindow();
            });
            document.body.oncontextmenu = function () { return false; };

            $.ajax({
                type: "POST",
                url: "../../Handlers/GetDXGroupInfoForCallPanl.ashx?TYPE=DX",
                data: "",
                success: function (msg) {

                    var myMsg = eval(msg);
                    if (myMsg != undefined && myMsg != null) {
                        dxCount = myMsg.length;
                        var vta = " <table  border=\"0\" cellspacing=\"0\" cellpadding=\"0\" id=\"tabPJ\" style=\"width: 100%;\">"
                        for (var i = 0; i < myMsg.length; i++) {
                            vta += "<tr style='height:15px' onclick='onChanger(" + myMsg[i].Group_index + ")'>";
                            vta += "<td id='trpj1_" + myMsg[i].Group_index + "' class='css_TR_c2' align='left' style='width:70%'>";
                            vta += myMsg[i].Group_name + "(" + myMsg[i].Group_index + ")";
                            vta += "</td>";
                            vta += "<td id='trpj2_" + myMsg[i].Group_index + "' class='css_TR_c2' style='width:30%'>";
                            vta += "<img style='display:none' id='img_" + myMsg[i].Group_index + "' src='../../Images/calltype/pj0.gif' />";
                            vta += "</td>";
                            vta += "</tr>";

                            infoList.push({ id: myMsg[i].Group_index, gssi: myMsg[i].GSSIS, groupname: myMsg[i].Group_name });
                        }
                        vta += "</table>";
                        $("#divDXZ").html(vta);


                    }
                }
            });
        })
        //修改成员
        var Lang_At_least_one_member_of_group= window.parent.parent.GetTextByName("Lang_At_least_one_member_of_group", window.parent.parent.useprameters.languagedata);
        function modifymember() {
            if(Iscall)
            {
                return;
            }
            if (!isselDXZFSelect()) {
                alert(Lang_At_least_one_member_of_group);//("至少一个成员组");
                return;
            }
            var issis = "";
            var PGID = dxgssi;
            for (var i = 0; i < infoList.length; i++) {
                if (infoList[i].id == PGID) {
                    issis = infoList[i].gssi;
                }
            }

            window.parent.mycallfunction('UpdatePJDXMember', 635, 514, '0&ifr=DXGroup_ifr&issi=' + issis, 2001);
        }
        //自定义
        var Lang_TheMostCount=window.parent.parent.GetTextByName("Lang_TheMostCount", window.parent.parent.useprameters.languagedata);
        var Lang_ge_DXGroup=window.parent.parent.GetTextByName("Lang_ge_DXGroup", window.parent.parent.useprameters.languagedata);
        function OpenAddPJGroup() {
            if(Iscall)
            {
                return;
            }
            if(dxCount>=<%=int.Parse(ConfigurationManager.AppSettings["DxCount"]) %>){
              
                alert('<%=Ryu666.Components.ResourceManager.GetString("TheMostCountPF")+":["+int.Parse(ConfigurationManager.AppSettings["DxCount"])+"]" %>');


                return;
            }
            window.parent.mycallfunction('add_DXGroup', 571, 481, "&CMD=DXCALLPANL", 2002);
            window.parent.document.getElementById("mybkdiv").style.zIndex = 2000;
        }
        //选中多选组
        function onChanger(pid) {

            for (var i = 0; i < infoList.length; i++) {
                if (document.getElementById("trpj1_" + infoList[i].id) != null) {
                    if (infoList[i].id == pid) {

                        document.getElementById("trpj1_" + infoList[i].id).setAttribute("class", "css_TR_c1");
                        document.getElementById("trpj2_" + infoList[i].id).setAttribute("class", "css_TR_c1");
                    } else {
                        document.getElementById("trpj1_" + infoList[i].id).setAttribute("class", "css_TR_c2");
                        document.getElementById("trpj2_" + infoList[i].id).setAttribute("class", "css_TR_c2");
                    }
                }
            }

        
            var gssi = "";
            for (var i in infoList) {
                if (pid == infoList[i].id) {
                    gssi = infoList[i].gssi;
                }
            }
            dxgssi = pid;
            //alert(gssi);
            $.ajax({
                type: "POST",
                url: "../../Handlers/GetGroupInfoByDXGroup.ashx",
                data: "GSSI=" + gssi,
                success: function (msg) {
                    var myMsg = eval(msg);
                    if (myMsg != undefined && myMsg != null) {
                        DelAllRow();
                        if (IsCalling(dxgssi)) {
                            for (var i = 0; i < myMsg.length; i++) {
                                for (var j = 0; j < MemberInfoList.length; j++) {
                                    if (MemberInfoList[j].mid == myMsg[i].GSSI && MemberInfoList[j].pid == dxgssi) {
                                        AddRow(myMsg[i].GSSI, myMsg[i].Group_name);
                                        break;
                                    }
                                }
                            }
                        } else {
                            for (var i = 0; i < myMsg.length; i++) {
                                AddRow(myMsg[i].GSSI, myMsg[i].Group_name);
                            }
                        }
                    }
                }
            });

        }
        var Lang_number_group_cannot_null= window.parent.parent.GetTextByName("Lang_number_group_cannot_null", window.parent.parent.useprameters.languagedata);
        function faterdo(retrunissis) {
            //还需要去修改数据库信息
            var gssis = "";
            if (retrunissis.length < 1) {
                alert(Lang_number_group_cannot_null);//("组成员不能为空");

                return;
            }
            DelAllRow();
            for (var i = 0; i < retrunissis.length; i++) {
                gssis += retrunissis[i].gissi + ";";
                //将新增成员加入到排解组中，否则不加入
                if (IsCalling(dxgssi)) {
                    var PGID = dxgssi;
                    var yisflag = false;
                    for (var j = 0; j < MemberInfoList.length; j++) {
                         if (MemberInfoList[j].mid == retrunissis[i].gissi && PGID == MemberInfoList[j].pid) {
                            yisflag = true;
                        }
                    };
                    if (yisflag == false) {
                        if (window.parent.parent.AddMSGroupMem(PGID, retrunissis[i].gissi)) {
                        }
                        addMemberInfoList(retrunissis[i].gissi, PGID);
                    }
                }
                AddRow(retrunissis[i].gissi, retrunissis[i].gname);
            }
            //将没有的给移除掉
            var tempArray = new Array();
            for (var i = 0; i < MemberInfoList.length; i++) {
                if (IsCalling(dxgssi)) {
                    var PGID = dxgssi;
                    var yisflag = false;
                    for (var j = 0; j < retrunissis.length; j++) {
                        if (MemberInfoList[i].mid == retrunissis[j].gissi) {
                            yisflag = true;
                        } else if (PGID != MemberInfoList[i].pid) {
                            yisflag = true;
                        }
                    }
                    if (yisflag == false) {
                        window.parent.parent.DelMSGroupMem(PGID, MemberInfoList[i].mid);
                    } else {
                        tempArray.push({ mid: MemberInfoList[i].mid, pid: MemberInfoList[i].pid });
                    }
                }
            }
            MemberInfoList.length = 0;
            for (var i = 0; i < tempArray.length; i++) {
                MemberInfoList.push(tempArray[i]);
            }

            for (var i in infoList) {
                if (dxgssi == infoList[i].id) {
                    infoList[i].gssi = gssis;
                }
            }

            $.ajax({
                type: "POST",
                url: "../../Handlers/UpdateGSSIByGroupIndex_handler.ashx",
                data: "zno=" + dxgssi + "&GSSI=" + gssis,
                success: function (msg) {
                }
            });
        }
        
        //添加页面添加完后调用此方法，将新对象填入到列表中
        function OverAddPjGroup(groupname, groupindex, gssis) {
            window.parent.document.getElementById("mybkdiv").style.zIndex = 1998;
            var vta = " <table  border=\"0\" cellspacing=\"0\" cellpadding=\"0\" style=\"width: 100%;\">"
            vta += "<tr style='height:15px' onclick='onChanger(" + groupindex + ")'>";
            vta += "<td id='trpj1_" + groupindex + "' class='css_TR_c2' align='left' style='width:70%'>";
            vta += groupname + "(" + groupindex + ")";
            vta += "</td>";
            vta += "<td id='trpj2_" + groupindex + "' class='css_TR_c2' style='width:30%'>";
            vta += "<img style='display:none' id='img_" + groupindex + "' src='../../Images/calltype/pj0.gif' />";
            vta += "</td>";
            vta += "</tr>";
            vta += "</table>";
            $("#divDXZ").html($("#divDXZ").html() + vta);
            infoList.push({ id: groupindex, gssi: gssis, groupname: groupname });
            dxCount++;
        }
        //添加派接组号
        var Lang_Please_choose_DXGroup= window.parent.parent.GetTextByName("Lang_Please_choose_DXGroup", window.parent.parent.useprameters.languagedata);
        var Lang_have_lunched_DXGroup= window.parent.parent.GetTextByName("Lang_have_lunched_DXGroup", window.parent.parent.useprameters.languagedata);
        function AddPatchGroupId() {
            if(Iscall)
            {
                return;
            }
            if (!isselDXZFSelect()) {
                alert(Lang_Please_choose_DXGroup);//("请选择多选组");
                return;
            }
      
            var PGID = dxgssi;
            if (IsCalling(PGID)) {
                alert(Lang_have_lunched_DXGroup);//("多选已发起");
                return;
            }
            AddHaveCall(PGID);
            if (window.parent.parent.AddMSGroupId(PGID)) {
                if (document.getElementById("img_" + PGID) != null) {
                    document.getElementById("img_" + PGID).style.display = "block";
                }
                for (var i = 0; i < infoList.length; i++) {
                    if (infoList[i].id == PGID) {
                        var members = infoList[i].gssi.split(";");
                        for (var j = 0; j < members.length; j++) {
                            if (members[j] != "") {
                                if (window.parent.parent.AddMSGroupMem(PGID, members[j])) {
                                    addMemberInfoList(members[j], PGID);
                                } else {
                                    addMemberInfoList(members[j], PGID);
                                }
                            }
                        }
                    }
                }
                PJFlag = true;
            }
            PJFlag = true;
        }
        //删除多选组号
        var Lang_Please_lunch_DXGroup= window.parent.parent.GetTextByName("Lang_Please_lunch_DXGroup", window.parent.parent.useprameters.languagedata);
        function DelPatchGroupId() {
            if(Iscall)
            {
                return;
            }
            ClearMsg();
            var PGID = dxgssi;
            if (!IsCalling(PGID)) {
                alert(Lang_Please_lunch_DXGroup);//("请先发起多选");
                return;
            }
            RemoveHavaCall(PGID);
            if (window.parent.parent.DelMSGroupId(PGID)) {
                if (document.getElementById("img_" + PGID) != null) {
                    document.getElementById("img_" + PGID).style.display = "none";
                }
                PJFlag = false;
            }
            PJFlag = false;
        }

        //开始多选组呼
        function StartPatchGroupCall() {
           
            if (!IsCalling(dxgssi)) {
                alert(Lang_Please_lunch_DXGroup);//("请先发起多选");
                return;
            }
            
            document.getElementById("Button2").setAttribute("class", "yellowC");
            if(Iscall)
            {
                return;
            }
	    Iscall = true;
            var PGID = dxgssi;
            if (window.parent.parent.StartMSGroupCall(PGID)) {
            }
        }
        //释放多选呼叫
        function CeasedPatchGroupCall() {
            document.getElementById("Button2").setAttribute("class", "btn");
            if (!IsCalling(dxgssi)) {
                return;
            }
        
            var PGID = dxgssi;
            Iscall = false;
            if (window.parent.parent.EndMSGroupCall(PGID)) {
            }
        }
        var Lang_Please_end_xiangguan_DXGroup= window.parent.parent.GetTextByName("Lang_Please_end_xiangguan_DXGroup", window.parent.parent.useprameters.languagedata);
        function ClosePage() {
            if(Iscall)
            {
                alert(Lang_Please_end_xiangguan_DXGroup);   //("请先结束相关多选")
                return;
            }
            if (haveCallPJ.length > 0) {
                alert(Lang_Please_end_xiangguan_DXGroup);//("请先结束相关多选");
                return;
            }
                  <%SessionContent.ClearDXNameToList(); %>
            window.parent.hiddenbg2();
            window.parent.mycallfunction(geturl(), 693, 354);
        }
        function AddRow(gssi, gname) {

            var tdCY = document.getElementById("tdCY");
            var newTr = tdCY.insertRow();
            var newTd0 = newTr.insertCell();
            newTd0.style.width = "100%";
            newTd0.innerHTML = "<div id='divG_" + gssi + "'>" + gname + "</div>";
        }

        function DelAllRow() {
            var tdCY = document.getElementById("tdCY");
            var rowscount = tdCY.rows.length;

            //循环删除行,从最后一行往前删除
            for (i = rowscount - 1; i >= 0; i--) {
                tdCY.deleteRow(i);
            }

        }
    </script>
</head>
<body>
    <div>
        <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
            <tr>
                <td height="30">
                    <div id="divdrag" style="cursor: move">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td width="15" height="32">
                                    <img src="../images/tab_03.png" width="15" height="32" />
                                </td>
                                <td width="1101" background="../images/tab_05.gif">
                                    <ul class="hor_ul">
                                        <li>
                                            <img src="../images/037.gif" /><span id="Lang_DuoXuanTitle"></span></li>
                                    </ul>
                                </td>
                                <td width="281" background="../images/tab_05.gif" align="right">
                                    <img class="style6" style="cursor: hand;" onclick="ClosePage()" onmouseover="javascript:this.src='../images/close_un.png';"
                                        onmouseout="javascript:this.src='../images/close.png';" src="../images/close.png" />
                                </td>
                                <td width="14">
                                    <img src="../images/tab_07.png" width="14" height="32" />
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td width="15" background="../images/tab_12.gif">
                                &nbsp;
                            </td>
                            <td align="center" id="dragtd">
                                <table style="height: 100%" class="style1" cellspacing="1">
                                    <tr>
                                        <td id="Lang_DXGroup" class="style3" align="center" style="width: 35%">
                                           <%-- 多选组--%>
                                        </td>
                                        <td id="Lang_Operater" class="style3" align="center" style="width: 20%">
                                            <%--操作--%>
                                        </td>
                                        <td id="Lang_Members" align="center" style="width: 30%">
                                            <%--成员--%>
                                        </td>
                                        <td id="Lang_Status_1" align="center" style="width: 15%; display: none">
                                           <%-- 状态--%>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="style3" valign="top" align="center" style="width: 35%">
                                        <div id="divDXZ" style="position: absolute; width: 190px; height: 178px; overflow-y: scroll">
                                            </div>
                                            <select onchange="onChanger()" id="selDXZ" name="selDXZ" multiple="multiple" style="width: 100%;height: 210px; display:none">
                                            </select>
                                        </td>
                                        <td class="style3" align="center" style="width: 20%">
                                            <br />
                                            <table width="100%">
                                                <tr>
                                                    <td>
                                                        <button id="imgpatch" onclick="AddPatchGroupId()" class="btn" style="width: 80%;
                                                            text-align: center; cursor: hand;">
                                                            <%--多选--%></button>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <button id="Button1" onclick="DelPatchGroupId()" class="btn" style="width: 80%; text-align: center;
                                                            cursor: hand;">
                                                            <%--解选--%></button>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <button id="Button2" onmousedown="StartPatchGroupCall()" onmouseup="CeasedPatchGroupCall()"
                                                            class="btn" style="width: 80%; text-align: center; cursor: hand;">
                                                            PTT</button>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <button id="Button4" onclick="modifymember()" class="btn" style="width: 80%; text-align: center;
                                                            cursor: hand;">
                                                            <%--修改--%></button>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <button id="Button5" onclick="OpenAddPJGroup()" class="btn" style="width: 80%; text-align: center;
                                                            cursor: hand;">
                                                            <%--自定义--%></button>
                                                    </td>
                                                </tr>
                                            </table>
                                            <br />
                                        </td>
                                        <td align="left" valign="top" style="width: 45%">
                                            <div style="position: absolute; width: 244px; height: 178px; overflow-y: scroll">
                                                <table id="tdCY" class="" style="width: 100%;">
                                                </table>
                                            </div>
                                        </td>
                                        <td align="center" style="width: 15%; display: none">
                                        </td>
                                    </tr>
                                    <tr style="height: 100px">
                                        <td class="style3" align="left" colspan="3">
                                            <div id="DXMsgDIV" style="height: 100px; overflow: auto">
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td width="14" background="../images/tab_16.gif">
                                &nbsp;
                            </td>
                        </tr>
                        <%--<tr>
        <td width="15" background="../images/tab_12.gif">&nbsp;</td>
        <td align="center" height="30" >
         
        <td width="14" background="../images/tab_16.gif">&nbsp;</td>
      </tr>--%>
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
                                        <td width="25%" nowrap="nowrap">
                                            &nbsp;
                                        </td>
                                        <td width="75%" valign="top" class="STYLE1">
                                            &nbsp;
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
    </div>
</body>
</html>
<script>   
    window.parent.closeprossdiv();
    LanguageSwitch(window.parent);
    window.document.getElementById("imgpatch").innerHTML = window.parent.parent.GetTextByName("Lang_DuoXuan", window.parent.parent.useprameters.languagedata);
    window.document.getElementById("Button1").innerHTML = window.parent.parent.GetTextByName("Lang_JieXuan", window.parent.parent.useprameters.languagedata);
    window.document.getElementById("Button4").innerHTML = window.parent.parent.GetTextByName("Modify", window.parent.parent.useprameters.languagedata);
    window.document.getElementById("Button5").innerHTML = window.parent.parent.GetTextByName("Lang_definition", window.parent.parent.useprameters.languagedata);

   
</script>
<link href="../../CSS/lq_calloutExtender.css" rel="stylesheet" type="text/css" />
