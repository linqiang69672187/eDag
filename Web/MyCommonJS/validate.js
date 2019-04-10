var validateIsEmptyObjs = new Array(); //为空的对象数组
var validateIsEmptysetInterval = setInterval('doValidate()', 500); //定时器
//验证内容是否为空,为空的边框变红
function validateIsEmpty() {
    var isEmpty = false;
    validateIsEmptyObjs.length = 0;
    for (var arg_i = 0; arg_i < arguments.length; arg_i++) {
        if (arguments[arg_i].value == "") {
            isEmpty = true;
            validateIsEmptyObjs.push(arguments[arg_i]);
        }
        else {
            arguments[arg_i].style.borderColor = "";
        }
    }
    if (isEmpty) {
        return true;
    }
    else {
        return false;
    }
}
//用于验证为空闪动红色边框
function doValidate() {
    for (var objs_i = 0; objs_i < validateIsEmptyObjs.length; objs_i++) {
        if (validateIsEmptyObjs[objs_i].style.borderColor == "red") {
            validateIsEmptyObjs[objs_i].style.borderColor = "";
        }
        else {
            validateIsEmptyObjs[objs_i].style.borderColor = "red";
        }
    }
}
//限制为数字文本框
function MakeIsDigit(id) {
    if (typeof (id) == "string") {
        id = document.getElementById(id);
    }
    id.onkeypress = function () { return event.keyCode >= 48 && event.keyCode <= 57 || event.keyCode == 46; }
    id.onpaste = function () { return !clipboardData.getData('text').match(/\D/); }
    id.ondragenter = function () { return false; }
    id.style.imeMode = "Disabled";
    id.onfocus = function () {
        document.onmousewheel = function () {
            var value = id.value;
            if (!value)
                value = 0;
            id.value = parseInt(value) + window.event.wheelDelta / 112;
        }
    }
    id.onblur = function () {
        document.onmousewheel = null;
    }
}