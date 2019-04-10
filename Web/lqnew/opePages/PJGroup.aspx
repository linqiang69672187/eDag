<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PJGroup.aspx.cs" Inherits="Web.lqnew.opePages.PJGroup" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Import Namespace="DbComponent.Comm" %>
<%@ Import Namespace="System.Configuration" %>
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
        .css_Grid
        {
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
        var stringlength = 12; //字长度
        var haveCallPJ = new Array(); //存放已经发起派接的派接组
        var infoList = new Array(); //存放派接组成员列表，当用户修改后 直接在此列表中添加
        var MemberInfoList = new Array(); //被派接的成员列表，点击派接初始化此数组，格式{pgid:1,mid:1020}
        var pjgssi = ""; //选中的派接组ISSI
        var PJFlag = false; //是否派接
        var AddPjName = new Array();//自定义派接组组名列表，防止重复
        var pjcount = 0;
        var Iscall = false; //判断是否正在进行派接组呼叫
        var IsClickPTT = false;//判断是否点击过PTT按钮
        var dragEnable = 'True';
        
        function dragdiv() {
            var div1 = window.parent.document.getElementById(geturl());
            if (div1 && event.button == 1 && dragEnable == 'True') {
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
            //不派接时清空状态信息栏
            $("#PJMsgDIV").bind("DOMSubtreeModified", function (e) {
                if(!PJFlag){
                    ClearMsg();
                }
            });

            document.body.oncontextmenu = function () { return false; };
            $.ajax({
                type: "POST",
                url: "../../Handlers/GetDXGroupInfoForCallPanl.ashx?TYPE=PJ",
                data: "",
                success: function (msg) {


                    var myMsg = eval(msg);
                    if (myMsg != undefined && myMsg != null) {
                        pjcount = myMsg.length;
                        document.getElementById('selDXZ').options.length = 0;
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
                            var varitem = new Option(myMsg[i].Group_name, myMsg[i].Group_index);
                            document.getElementById('selDXZ').options.add(varitem);


                            infoList.push({ id: myMsg[i].Group_index, gssi: myMsg[i].GSSIS, groupname: myMsg[i].Group_name });
                        }
                        vta += "</table>";
                        $("#divDXZ").html(vta);
                    }
                }
            });
        })

        function updateMemberStatusByGssi(pid, gssi, status) {
            for (var i = 0; i < MemberInfoList.length; i++) {
                if (MemberInfoList[i].mid == gssi && MemberInfoList[i].pid == pid) {
                    MemberInfoList[i].status = status;
                }
            }
        }
        function addMemberInfoList(mid, pid, status) {
            var flag = false;
            for (var i = 0; i < MemberInfoList.length; i++) {
                if (MemberInfoList[i].mid == mid && MemberInfoList[i].pid == pid) {
                    flag = true;
                    MemberInfoList[i].status = status;
                    break;
                }
            }
            if (!flag) {
                MemberInfoList.push({ mid: mid, pid: pid, status: status });
            }
        }
        function findMemberStatusByGssi(gssi, pid) {
            var vret = "";
            for (var i = 0; i < MemberInfoList.length; i++) {
                if (MemberInfoList[i].mid.toString() == gssi.toString() && MemberInfoList[i].pid.toString() == pid.toString()) {
                    vret = MemberInfoList[i].status;
                }
            }
            return vret;
        }
        function DateFor(str) {
            if (str.length < 2) {
                return "0" + str;
            } else
                return str;
        }
        function ClearMsg() {
            $("#PJMsgDIV").html("");
        }
        function AddMsg(msg) {
            $("#PJMsgDIV").html("<img src='../../Images/Police.png' />" + msg);

//            var varNow = new Date();
//            var times = varNow.getYear().toString() + "-" + DateFor(varNow.getMonth().toString()) + "-" + DateFor(varNow.getDay().toString()) + "&nbsp;&nbsp;" + DateFor(varNow.getHours().toString()) + ":" + DateFor(varNow.getMinutes().toString()) + ":" + DateFor(varNow.getSeconds().toString());
//            $("#PJMsgDIV").html(times + "&nbsp;&nbsp;" + msg + "<br>" + $("#PJMsgDIV").html());

            //调试信息
//            var msgs = "infoList|";
//            for (var i = 0; i < infoList.length; i++) {
//                msgs += "id:" + infoList[i].id + ";gssi:" + infoList[i].gssi + ";groupname:" + infoList[i].groupname+"<br>";
//            }
//            msgs += "<br>MemberInfoList|";
//            for (var i = 0; i < MemberInfoList.length; i++) {
//                msgs += "mid:" + MemberInfoList[i].mid + ";pid:" + MemberInfoList[i].pid + ";status:" + MemberInfoList[i].status+"<br>";
//            }
//            msgs += "<br>";
//            $("#PJMsgDIV").html(msgs);
        }
        //判断是否有多选组选中
        function isselDXZFSelect() {
            var isflag = false;
            if (pjgssi != "") {
                isflag = true;
            }
            return isflag;
        }
        //选中多选组
        var Lang_NO_PaiJie= window.parent.parent.GetTextByName("Lang_NO_PaiJie", window.parent.parent.useprameters.languagedata); //未派接

        function onChanger(pid) {
            //假如能同时发起多个派接，就不能调用DelPatchGroupId去结束派接 多选也一样
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

            var obj = document.getElementById('selDXZ');
            var gssi = "";
            for (var i in infoList) {
                if (pid == infoList[i].id) {
                    gssi = infoList[i].gssi;
                }
            }
            pjgssi = pid;

            //alert(gssi);
            $.ajax({
                type: "POST",
                url: "../../Handlers/GetGroupInfoByDXGroup.ashx",
                data: "GSSI=" + gssi,
                success: function (msg) {

                    var myMsg = eval(msg);
                    if (myMsg != undefined && myMsg != null) {
                        DelAllRow();
                        if (IsCalling(pjgssi)) {
                            for (var i = 0; i < myMsg.length; i++) {
                                for (var j = 0; j < MemberInfoList.length; j++) {
                                    if (MemberInfoList[j].mid == myMsg[i].GSSI && MemberInfoList[j].pid == pjgssi) {
                                        AddRow(myMsg[i].GSSI, myMsg[i].Group_name, MemberInfoList[j].status);
                                        break;
                                    }
                                }
                            }
                        } else {
                            for (var i = 0; i < myMsg.length; i++) {
                                //AddRow(myMsg[i].GSSI, myMsg[i].Group_name, "未派接");Lang_NO_PaiJie
                                AddRow(myMsg[i].GSSI, myMsg[i].Group_name, Lang_NO_PaiJie);Lang_NO_PaiJie
                            }
                        }
                    }
                }
            });
            //AddMsg("修改派接组");
        }

        //修改成员
        var Lang_Please_choose_PJGroup= window.parent.parent.GetTextByName("Lang_Please_choose_PJGroup", window.parent.parent.useprameters.languagedata);
        var Lang_Cannot_modify_PJGroup=window.parent.parent.GetTextByName("Lang_Cannot_modify_PJGroup", window.parent.parent.useprameters.languagedata);
        function modifymember() {
            if(Iscall)
            {
                alert(Lang_First_End_PatchCall);
                return;
            }
            if (!isselDXZFSelect()) {
                alert(Lang_Please_choose_PJGroup);//("请选择派接组");
                return;
            }
            var issis = "";
            //            var obj = document.getElementById('selDXZ');
            //            var PGID = obj.options[obj.selectedIndex].value;
            var PGID = pjgssi;
            //暂时规定派接组中有获取授权的
            if(document.getElementById("img_" + PGID).style.display != "none"){
                alert(Lang_Cannot_modify_PJGroup);//("正在派接中的派接组，不能修改成员");
                return;
            }

            for (var i = 0; i < infoList.length; i++) {
                if (infoList[i].id == PGID) {
                    issis = infoList[i].gssi;
                }
            }
            window.parent.mycallfunction('UpdatePJDXMember', 635, 514, '0&ifr=PJGroup_ifr&issi=' + issis, 2001);
        }
        var Lang_At_least_one_member_of_group= window.parent.parent.GetTextByName("Lang_At_least_one_member_of_group", window.parent.parent.useprameters.languagedata);
        var Lang_have_PaiJie= window.parent.parent.GetTextByName("Lang_have_PaiJie", window.parent.parent.useprameters.languagedata);
        var PJFailed=window.parent.parent.GetTextByName("PJFailed", window.parent.parent.useprameters.languagedata);
        var  Lang_NO_PaiJie=window.parent.parent.GetTextByName("Lang_NO_PaiJie", window.parent.parent.useprameters.languagedata);
        function faterdo(retrunissis) {
            var gssis = "";
            if (retrunissis.length < 1) {
                alert(Lang_At_least_one_member_of_group);//("至少一个成员组");
                return;
            }
            DelAllRow();
            for (var i = 0; i < retrunissis.length; i++) {

                gssis += retrunissis[i].gissi + ";";
                //将新增成员加入到排解组中，否则不加入
                if (IsCalling(pjgssi)) {
                    //                    var obj = document.getElementById('selDXZ');
                    //                    var PGID = obj.options[obj.selectedIndex].value;
                    var PGID = pjgssi;
                    var yisflag = false;
                    for (var j = 0; j < MemberInfoList.length; j++) {
                    //当以前不存在此派接组下此组 时 需要添加，所以当此派接组中存在此组
                        if (MemberInfoList[j].mid == retrunissis[i].gissi && PGID == MemberInfoList[j].pid) {
                            yisflag = true;
                        } 
                    };
                    if (yisflag == false) {
                        if (window.parent.parent.AddPatchGroupMem(PGID, retrunissis[i].gissi)) {
                            //MemberInfoList.push({ mid: retrunissis[i].gissi, pid: PGID, status: "已派接" });
                            //addMemberInfoList(retrunissis[i].gissi, PGID, "已派接");
                            addMemberInfoList(retrunissis[i].gissi, PGID, Lang_have_PaiJie);
                            //AddRow(retrunissis[i].gissi, retrunissis[i].gname, "已派接");
                            AddRow(retrunissis[i].gissi, retrunissis[i].gname, Lang_have_PaiJie);

                        } else {
                            //addMemberInfoList(retrunissis[i].gissi, PGID, "派接失败");
                            // AddRow(retrunissis[i].gissi, retrunissis[i].gname, "派接失败");
                            addMemberInfoList(retrunissis[i].gissi, PGID, PJFailed);
                            AddRow(retrunissis[i].gissi, retrunissis[i].gname, PJFailed);
                        }
                    } else {
                        AddRow(retrunissis[i].gissi, retrunissis[i].gname, findMemberStatusByGssi(retrunissis[i].gissi,PGID));
                    }
                } else {
                    //AddRow(retrunissis[i].gissi, retrunissis[i].gname, "未派接");                
                    AddRow(retrunissis[i].gissi, retrunissis[i].gname,  Lang_NO_PaiJie);
                }
            }
            //将没有的给移除掉
            var tempArray = new Array();
            for (var i = 0; i < MemberInfoList.length; i++) {
                if (IsCalling(pjgssi)) {
                    //                    var obj = document.getElementById('selDXZ');
                    //                    var PGID = obj.options[obj.selectedIndex].value;
                    var PGID = pjgssi;
                    var yisflag = false;
                    for (var j = 0; j < retrunissis.length; j++) {//问题就出现在这个地方
                        if (MemberInfoList[i].mid == retrunissis[j].gissi) {
                            yisflag = true;
                        } else if (PGID != MemberInfoList[i].pid) {
                            yisflag = true;
                        }
                    }
                    if (yisflag == false) {
                        window.parent.parent.DelPatchGroupMem(PGID, MemberInfoList[i].mid);
                    } else {
                        tempArray.push({ mid: MemberInfoList[i].mid, pid: MemberInfoList[i].pid, status: MemberInfoList[i].status });
                    }
                } else {
                    tempArray.push({ mid: MemberInfoList[i].mid, pid: MemberInfoList[i].pid, status: MemberInfoList[i].status });
                }
            }
            MemberInfoList.length = 0;
            for (var i = 0; i < tempArray.length; i++) {
                MemberInfoList.push(tempArray[i]);
            }

            for (var i in infoList) {
                if (pjgssi == infoList[i].id) {
                    infoList[i].gssi = gssis;
                }
            }

            $.ajax({
                type: "POST",
                url: "../../Handlers/UpdateGSSIByGroupIndex_handler.ashx",
                data: "zno=" + pjgssi + "&GSSI=" + gssis,
                success: function (msg) {
                }
            });

            //调试代码
            //AddMsg("修改成员");
        }
        //自定义
        var Lang_TheMostCount=window.parent.parent.GetTextByName("Lang_TheMostCount", window.parent.parent.useprameters.languagedata);//您最多可创建
        var Lang_ge_PaiJieGroup=window.parent.parent.GetTextByName("Lang_ge_PaiJieGroup", window.parent.parent.useprameters.languagedata);//个派接组
        function OpenAddPJGroup() {
            if(Iscall)
            {
                alert(Lang_First_End_PatchCall);
                return;
            }
            if(pjcount>=<%=int.Parse(ConfigurationManager.AppSettings["PjCount"]) %>){
   
                alert('<%=Ryu666.Components.ResourceManager.GetString("TheMostCountPF")+":["+int.Parse(ConfigurationManager.AppSettings["PjCount"])+"]" %>');
                return;
            }
            window.parent.mycallfunction('add_DXGroup', 571, 481, "&CMD=CALLPANL", 2001);
            window.parent.document.getElementById("mybkdiv").style.zIndex = 2000;
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


            // var varitem = new Option(groupname, groupindex);
            // document.getElementById('selDXZ').options.add(varitem);
            infoList.push({ id: groupindex, gssi: gssis, groupname: groupname });
            pjcount++;
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
        //添加派接组号
        var Lang_have_lunched_PaiJie=window.parent.parent.GetTextByName("Lang_have_lunched_PaiJie", window.parent.parent.useprameters.languagedata);//派接已发起
        var Lang_have_PaiJie=window.parent.parent.GetTextByName("Lang_have_PaiJie", window.parent.parent.useprameters.languagedata);//派接已发起
        function AddPatchGroupId() {
            if(Iscall)
            {
                alert(Lang_First_End_PatchCall);
                return;
            }
            if (!isselDXZFSelect()) {
                alert(Lang_Please_choose_PJGroup);//("请选择派接组");
                return;
            }

            //            var obj = document.getElementById('selDXZ');
            //            var PGID = obj.options[obj.selectedIndex].value;
            var PGID = pjgssi;
            if (IsCalling(PGID)) {
                alert(Lang_have_lunched_PaiJie);//("派接已发起");
                return;
            }

            AddHaveCall(PGID);
            if (window.parent.parent.AddPatchGroupId(PGID)) {

                if (document.getElementById("img_" + PGID) != null) {
                    document.getElementById("img_" + PGID).style.display = "block";
                }
                for (var i = 0; i < infoList.length; i++) {
                    if (infoList[i].id == PGID) {
                        var members = infoList[i].gssi.split(";");
                        for (var j = 0; j < members.length; j++) {
                            if (members[j] != "") {
                                if (window.parent.parent.AddPatchGroupMem(PGID, members[j])) {
                                    //addMemberInfoList(members[j], PGID, "已派接");
                                    addMemberInfoList(members[j], PGID, Lang_have_PaiJie);
                                    if (document.getElementById(members[j]) != null) {
                                        //document.getElementById(members[j]).innerHTML = "<span style='color:blue'>已派接</span>";
                                        document.getElementById(members[j]).innerHTML = "<span style='color:blue'>"+Lang_have_PaiJie+"</span>";
                                    }

                                } else {

                                    if (document.getElementById(members[j]) != null) {
                                        //document.getElementById(members[j]).innerHTML = "<span style='color:red'>派接失败</span>";
                                        
                                        document.getElementById(members[j]).innerHTML = "<span style='color:red'>"+PJFailed+"</span>";
                                    }
                                    //addMemberInfoList(members[j], PGID, "派接失败");
                                    addMemberInfoList(members[j], PGID, PJFailed);
                                }
                            }
                        }
                    }
                }

                PJFlag = true;
            }
            PJFlag = true;
            //调试代码
            //AddMsg("发起派接");
        }
        //删除派接组号
        var Lang_please_lunch_PaiJie=window.parent.parent.GetTextByName("Lang_please_lunch_PaiJie", window.parent.parent.useprameters.languagedata);
        function DelPatchGroupId() {
            if(Iscall)
            {
                alert(Lang_First_End_PatchCall);
                return;
            }
            
            //            var obj = document.getElementById('selDXZ');
            //            var PGID = obj.options[obj.selectedIndex].value;
            var PGID = pjgssi;
            if (!IsCalling(PGID)) {
                alert(Lang_please_lunch_PaiJie);//("请先发起派接");
                return;
            }

            if(PJFlag&&!IsClickPTT){
                window.parent.parent.EndPatchGroupCall(PGID);//cxy--当调度台发起派接但未发起PTT呼叫，选择结束派接时，自动结束派接呼叫
            }
            RemoveHavaCall(PGID);
            if (window.parent.parent.DelPatchGroupId(PGID)) {
            //都放外面去处理了
                ClearMsg();
            }
            for (var i = 0; i < MemberInfoList.length; i++) {
                if (MemberInfoList[i].pid == PGID) {
                    if (document.getElementById(MemberInfoList[i].mid) != null) {
                        document.getElementById(MemberInfoList[i].mid).innerHTML = Lang_NO_PaiJie;//"未派接";
                    }
                }
            }
            if (document.getElementById("img_" + PGID) != null) {
                document.getElementById("img_" + PGID).style.display = "none";
            }
            PJFlag = false;
            IsClickPTT = false;
            //AddMsg("派接号为" + PGID + "的派接组已解派");
           
        }
        var isCallFlag = false;
        //开始派接组呼
        var Lang_First_End_PatchCall=window.parent.parent.GetTextByName("Lang_First_End_PatchCall", window.parent.parent.useprameters.languagedata);

        function StartPatchGroupCall() {
           

            //            var obj = document.getElementById('selDXZ');
            //            var PGID = obj.options[obj.selectedIndex].value;

            var PGID = pjgssi;
            if (!IsCalling(PGID)) {
                alert(Lang_please_lunch_PaiJie);//("请先发起派接");
                return;
            }
            document.getElementById("Button2").setAttribute("class", "yellowC");
            //if(Iscall)
            //{
            //    return;
            //}
            if (window.parent.parent.StartPatchGroupCall(PGID)) {
                isCallFlag = true;
                Iscall = true;
                IsClickPTT = true;
            }
        }
        //释放派接呼叫
        function CeasedPatchGroupCall() {
            document.getElementById("Button2").setAttribute("class", "btn");
            //            var obj = document.getElementById('selDXZ');
            //            var PGID = obj.options[obj.selectedIndex].value;
            var PGID = pjgssi;
            if (window.parent.parent.CeasedPatchGroupCall(PGID)) {
               // Iscall = false;
            }
        }
        //结束派接呼叫
        function EndPatchGroupCall() {
            //AddMsg("呼叫结束");//结
            //            var obj = document.getElementById('selDXZ');
            //            var PGID = obj.options[obj.selectedIndex].value;
          
            var PGID = pjgssi;
            if (!IsCalling(PGID)) {
                alert(Lang_please_lunch_PaiJie);//("请先发起派接");
                return;
            }
            if (window.parent.parent.EndPatchGroupCall(PGID)) {
                isCallFlag = false;
                Iscall = false;

            }
        }



        //关闭页面
        var Lang_please_end_XiangGuan_PaiJie=window.parent.parent.GetTextByName("Lang_please_end_XiangGuan_PaiJie", window.parent.parent.useprameters.languagedata);
        function ClosePage() {

            if (haveCallPJ.length > 0) {
                alert(Lang_please_end_XiangGuan_PaiJie);//("请先结束相关派接");
                return;
            }
            <%SessionContent.ClearPJNameToList(); %>
            window.parent.hiddenbg2();
            window.parent.mycallfunction(geturl(), 693, 354);
        }

        function AddPjz() {

        }

        function AddRow(gssi, gname, status) {
            var co = "";
            if (status == Lang_NO_PaiJie) { //未派接

            } else if (status == Lang_have_PaiJie) {//已派接
                co = "blue";
            } else if (status ==PJFailed ) { //"派接失败"
                co = "red";
            }
            var tdCY = document.getElementById("tdCY");
            var newTr = tdCY.insertRow();
            newTr.style.height = "10px";
            newTr.onclick = function () {

            }
            var newTd0 = newTr.insertCell();
            newTd0.style.width = "70%";
            var newTd1 = newTr.insertCell();
            newTd1.style.width = "30%";
            newTd0.innerHTML = "<div id='divG_" + gssi + "'>" + gname + "</div>";
            newTd1.innerHTML = "<div id='" + gssi + "'><span style='color:" + co + "'>" + status + "</span></div>";
            if (status ==Lang_NO_PaiJie ) {//"未派接"
                newTd1.innerHTML = "<div id='" + gssi + "'>" + status + "</div>";
            }
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
                                            <img src="../images/037.gif" /><span id="Lang_PieJieTitle" ><%--派接--%></span></li>
                                    </ul>
                                </td>
                                <td width="281" background="../images/tab_05.gif" align="right">
                                    <img class="style6" style="cursor: hand;" onclick="ClosePage();" onmouseover="javascript:this.src='../images/close_un.png';"
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
                                        <td id="PJgroup" class="style3" align="center" style="width: 35%">
                                            <%--派接组--%>
                                        </td>
                                        <td id="Lang_Operate" class="style3" align="center" style="width: 20%">
                                           <%-- 操作--%>
                                        </td>
                                        <td align="center" style="width: 50%">
                                            <table style="width: 90%">
                                                <tr>
                                                    <td id="Members" align="left" style="width: 50%">
                                                        <%--成员--%>
                                                    </td>
                                                    <td id="Lang_Status" align="center" style="width: 60%">
                                                       <%-- 状态--%>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td id="lang_status_1" align="center" style="width: 15%; display: none">
                                            <%--状态--%>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="style3" align="center" valign="top" style="width: 35%">
                                            <div id="divDXZ" style="position: absolute; width: 190px; height: 205px; overflow-y: scroll">
                                            </div>
                                            <select onchange="onChanger()" id="selDXZ" name="selDXZ" multiple="multiple" style="width: 100%;
                                                height: 210px; display: none">
                                            </select>
                                        </td>
                                        <td class="style3" align="center" style="width: 20%">
                                            <br />
                                            <table width="100%">
                                                <tr>
                                                    <td>
                                                        <button id="imgpatch" onclick="AddPatchGroupId()" class="btn" style="width: 80%;
                                                            text-align: center; cursor: hand;">
                                                            <%--派接--%></button>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <button id="Button1" onclick="DelPatchGroupId()" class="btn" style="width: 80%; text-align: center;
                                                            cursor: hand;">
                                                            <%--解派--%></button>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <button id="Button2"  onmousedown="StartPatchGroupCall()"
                                                            onmouseup="CeasedPatchGroupCall()" class="btn" style="width: 80%; text-align: center;
                                                            cursor: hand;">
                                                            PTT</button>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <button id="Button3" onclick="EndPatchGroupCall()" class="btn" style="width: 80%;
                                                            text-align: center; cursor: hand;">
                                                            <%--结束--%></button>
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
                                        <td align="left" valign="top" style="width: 30%">
                                            <div style="position: absolute; width: 244px; height: 205px; overflow-y: scroll">
                                                <table id="tdCY" class="" style="width: 100%;">
                                                </table>
                                            </div>
                                        </td>
                                        <td align="center" style="width: 15%; display: none">
                                        </td>
                                    </tr>
                                    <tr style="height: 100px">
                                        <td class="style3" align="left" colspan="3">
                                            <div id="PJMsgDIV" style="height: 100px; overflow: auto">
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
    window.document.getElementById("PJgroup").innerHTML = window.parent.parent.GetTextByName("PJgroup", window.parent.parent.useprameters.languagedata);
    window.document.getElementById("Members").innerHTML = window.parent.parent.GetTextByName("Members", window.parent.parent.useprameters.languagedata);   
    window.document.getElementById("lang_status_1").innerHTML = window.parent.parent.GetTextByName("Lang_Status", window.parent.parent.useprameters.languagedata);
    window.document.getElementById("imgpatch").innerHTML = window.parent.parent.GetTextByName("Lang_PieJie", window.parent.parent.useprameters.languagedata);
    window.document.getElementById("Button1").innerHTML = window.parent.parent.GetTextByName("Lang_Rlease_PaiJie", window.parent.parent.useprameters.languagedata);
    window.document.getElementById("Button3").innerHTML = window.parent.parent.GetTextByName("TOend", window.parent.parent.useprameters.languagedata);
    window.document.getElementById("Button4").innerHTML = window.parent.parent.GetTextByName("Modify", window.parent.parent.useprameters.languagedata);
    window.document.getElementById("Button5").innerHTML = window.parent.parent.GetTextByName("Lang_definition", window.parent.parent.useprameters.languagedata);


</script>
<link href="../../CSS/lq_calloutExtender.css" rel="stylesheet" type="text/css" />
