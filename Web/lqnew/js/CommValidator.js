function ValiateInt(INum) {
    if (INum.length > 1)
    {
        if (INum.indexOf("0") == 0)
        {
            return false;
        }
    }
    var re = new RegExp("^[0-9]*[1-9][0-9]*$");
    if (INum.match(re) == null)
        return false;
    else
        return true;
}
//验证只包含@ 下划线 数字 字母
function checkUnNomal(str) {
    var pattern = new RegExp("[`~!#@%$^&*()=|{}':;',\\[\\].<>/?~！#￥……&*（）——|{}【】‘；：”“'。，、？]");

    if (str.match(pattern) == null)//不包含特殊字符
        return false;
    else
        return true;//包含特殊字符
}
//验证短信内容
function checkMsgContent(str) {
    if (/.*[\\|\/|\<|\>]+.*$/.test(str)) {
        return false;
    } else
        return true;
}
//判断是否是汉字、字母组成 (流程步骤添加)
function isChinaOrLett(s) {
    var regu = "^[a-zA-Z\u4e00-\u9fa5]+$";
    var re = new RegExp(regu);
    if (re.test(s)) {
        return true;
    }
    else {
        return false;
    }
}

//计算中、英文或字符的字节数
function getByteLen(val) {
    var len = 0;
    for (var i = 0; i < val.length; i++) {
        var a = val.charAt(i);
        if (a.match(/[^\x00-\xff]/ig) != null) {
            len += 2;
        }
        else {
            len += 1;
        }
    }
    return len;
}

//验证是否包含双字节字符
function isContainDoubleChars(val) {
    var result = false;
    for (var i = 0; i < val.length; i++) {
        var a = val.charAt(i);
        if (a.match(/[^\x00-\xff]/ig) != null) {
            result = true;
            break;
        }
    }
    return result;
}