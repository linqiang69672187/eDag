function add() {
    var ListBox1 = document.getElementById("ListBox1");
    var ListBox2 = document.getElementById("ListBox2");

    var currSelectValue = ListBox2.value;
    if (checkzhevalue(ListBox2.value) && ListBox2.value != "") {
        if (jsAddItemToSelect(ListBox1, ListBox2.value, ListBox2.value)) {
            jsRemoveItemFromSelect(ListBox2, ListBox2.value);
        }
    }
    else {
        alert(GetTextByName("CannotConnectSelfOrNotSelect", useprameters.languagedata));//多语言：不能关联自身(GSSI)或未选中GSSI
    }
}
function checkzhevalue(listvalue) {
    if (listvalue == document.getElementById("TextBox4").value) {
        return false;
    }
    else {
        return true;
    }

}


function remove() {
    var ListBox1 = document.getElementById("ListBox2");
    var ListBox2 = document.getElementById("ListBox1");
    var currSelectValue = ListBox2.value;
    if (jsAddItemToSelect(ListBox1, ListBox2.value, ListBox2.value)) {
        jsRemoveItemFromSelect(ListBox2, ListBox2.value);
    }
}



function jsSelectIsExitItem(objSelect, objItemValue) {
    var isExit = false;
    for (var i = 0; i < objSelect.options.length; i++) {
        if (objSelect.options[i].value == objItemValue) {
            isExit = true;
            break;
        }
    }
    return isExit;
}

function jsAddItemToSelect(objSelect, objItemText, objItemValue) {
    //判断是否存在
    if (jsSelectIsExitItem(objSelect, objItemValue)) {
        return false;
    }
    else {
        var varItem = new Option(objItemText, objItemValue);
        objSelect.options.add(varItem);

        return true;
    }
}

function jsRemoveItemFromSelect(objSelect, objItemValue) {

    if (jsSelectIsExitItem(objSelect, objItemValue)) {
        for (var i = 0; i < objSelect.options.length; i++) {
            if (objSelect.options[i].value == objItemValue) {
                objSelect.options.remove(i);
                break;
            }
        }
    }

}

function checkvalue() {
    var selecvalue = true;
    var ListBox1 = document.getElementById("ListBox1");

    if (jsSelectIsExitItem(ListBox1, document.getElementById("TextBox4").value)) {
        reselecvalue = false;
        alert(GetTextByName("CannotConnectSelfOrNotSelect", useprameters.languagedata));//多语言：不能关联自身(GSSI)或未选中GSSI
        return false;
    }

    return selecvalue;
}



