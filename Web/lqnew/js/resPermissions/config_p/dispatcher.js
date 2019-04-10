
//保存权限信息
function saveLoginuserResourcePermissions(treeid, selectedLoginuserId) {
    disableSaveButton();
    dispayprocessImg();
    
    window.setTimeout(function(){saveLoginuserResourcePermissionsDelay(treeid, selectedLoginuserId);},10);
}
function saveLoginuserResourcePermissionsDelay(treeid, selectedLoginuserId)
{    
    var authorityEntityAndUsertypeJson = getChecked(treeid);
    var authorityEntityAndUsertype = JSON.stringify(authorityEntityAndUsertypeJson);

    var param = { selectedLoginuserId: selectedLoginuserId, authorityEntityAndUsertype: authorityEntityAndUsertype };
    var saveSuccess = "saveSuccess";
    var saveFail = "saveFail";
    saveSuccess = window.parent.GetTextByName("saveSuccess", window.parent.useprameters.languagedata);
    saveFail = window.parent.GetTextByName("saveFail", window.parent.useprameters.languagedata);

    var url = "../../../Handlers/resPermissions/LoginuserResourcePermissionsByUserId_save.ashx";
    $.ajax({
        url: url,
        type: "POST",
        data: param,
        dataType: "json",
        success: function (response) {
            enableSaveButton();
            hideprocessImg();
            if (response.flag == "1") {
                getSelectedUserResPermision();
                alert(saveSuccess);
            } else {
                alert(saveFail);
            }
            
        }
    });
}
function getChecked(id) {
    var checkedItems = {};
    checkedItems.volume = "";
    var rootNode = $('#' + id).tree('getRoot');
    
        var nodes = $('#' + id).tree('getChecked');
        //没有选中节点
        if (nodes.length == 0) {
            checkedItems.volume = "none";
        }
            //部分节点选中
        else {
            checkedItems.volume = "part";

            var unit = new Array();
            var zhishu = new Array();
            var usertypetemp = new Array();
            for (var i = 0; i < nodes.length; i++) {

                var pnode = $('#' + id).tree('getParent',
						nodes[i].target);
                if (pnode && nodes[i].volume != "part" && !pnode.checked) {
                    if (nodes[i].type == "unit") {                        
                        var unitItem = { entityId: nodes[i].id };
                        unit.push(unitItem);
                    } else if (nodes[i].type == "zhishu") {                        
                        var zhishuItem = { entityId: nodes[i].id };
                        zhishu.push(zhishuItem);
                    } else if (nodes[i].type == "usertype") {
                        var usertypeItemtemp = { entityId: nodes[i].entityId, usertypeId: nodes[i].id };
                        usertypetemp.push(usertypeItemtemp);
                    }
                }
                else if (pnode && nodes[i].volume != "part" && pnode.checked && pnode.volume == "part") {
                        if (nodes[i].type == "unit") {                            
                            var unitItem = { entityId: nodes[i].id };
                            unit.push(unitItem);
                        } else if (nodes[i].type == "zhishu") {                            
                            var zhishuItem = { entityId: nodes[i].id };
                            zhishu.push(zhishuItem);
                        } else if (nodes[i].type == "usertype") {
                            var usertypeItemtemp = { entityId: nodes[i].entityId, usertypeId: nodes[i].id };
                            usertypetemp.push(usertypeItemtemp);
                        }
                }
                    //根节点选中的情况
                else if (pnode == null && nodes[i].volume != "part") {
                    if (nodes[i].type == "unit") {                        
                        var unitItem = { entityId: nodes[i].id };
                        unit.push(unitItem);
                    }
                }
            }
            //将同一单位下的类型放在一起
            var usertype = new Array();
            for (var i = 0; i < usertypetemp.length; i++) {
                if (usertypetemp[i] != null) {
                    var usertypeIds = new Array();
                    usertypeIds.push(usertypetemp[i].usertypeId);
                    for (var j = i + 1; j < usertypetemp.length; j++) {
                        if (usertypetemp[j] != null && usertypetemp[i].entityId == usertypetemp[j].entityId) {
                            usertypeIds.push(usertypetemp[j].usertypeId);
                            usertypetemp[j] = null;
                        }
                    }
                    var usertypeItem = { entityId: usertypetemp[i].entityId, usertypeIds: usertypeIds }
                    usertype.push(usertypeItem);
                }
            }

            checkedItems.unit = unit;
            checkedItems.zhishu = zhishu;
            checkedItems.usertype = usertype;
        }
    
    return checkedItems;
}
function setManagerLoginaccessUnitsAndUsertype(authorityEntityAndUsertype) {
    try{
        var item = window.parent.document.frames["manager_login_ifr"].document.getElementById("addOrEditRespermission_" + selectedLoginuserId);
        if (item) {
            if (authorityEntityAndUsertype != "" && authorityEntityAndUsertype != null) {
                item.CI = "1";
            }
            else {
                item.CI = "0";
            }
        }
    }
    catch (e) { }
}
function disableSaveButton() {
    try{
        var butt = document.getElementById("LangConfirm");
        if (butt) {
            butt.disabled = true;
        }
    }
    catch (e) { }
}
function enableSaveButton() {
    try {
        var butt = document.getElementById("LangConfirm");
        if (butt) {
            butt.disabled = false;
        }
    }
    catch (e) { }
} 

function dispayprocessImg() {
    try {
        var butt = document.getElementById("processImg");
        if (butt) {
            butt.style.display = "block";
        }
    }
    catch (e) { }
}
function hideprocessImg() {
    try {
        var butt = document.getElementById("processImg");
        if (butt) {
            butt.style.display = "none";
        }
    }
    catch (e) { }
}
function clearSelectedUserResPermisionTree(){
    $('#selectedUserResPermision').tree(
							{
							    data: []
							});
}