//此JS为了更方便的获取JS对象或页面参数

var getFatherFrame = window.parent;

//连接两个数组并剔除相同项,返回数组
function concatDistinct(ary1, ary2) {
    var retAry = new Array();
    Array.prototype.push.apply(retAry, ary2); //copy ary2 to retAry
    for (var ary1_i = 0; ary1_i < ary1.length; ary1_i++) {
        for (var retAry_i = 0; retAry_i < retAry.length; retAry_i++) {
            if (retAry[retAry_i] == ary1[ary1_i]) {//retAry has exist
                break;
            }
            if (retAry_i == retAry.length - 1) {//add ary1 to retAry
                retAry.push(ary1[ary1_i]);
            }
        }
    }
    return retAry;
}

//返回select下拉框选中值    2010/1/8
function getSelectValue(obj_id) {
    var sel = $(obj_id);
    return sel.options[sel.options.selectedIndex].value;
}

//获取DataGrid前chk选中的项对应的相应列值，用“,”隔开 其中name相同的chk为集合  2010/1/8
//chkIndex=0 默认为零（第一列）
//注：只适用于没有底的DataGrid
function getSelValueInDataGrid(chk_name, dataGridID, dataGridNum, chkIndex)//chk名称与要获取选择项的值列号
{
    {//构造
        if (!chkIndex)
            chkIndex = 0;
    }
    var values = "";
    var trs = $(dataGridID).getElementsByTagName('tr');
    for (var dg_i = 1; dg_i < trs.length; dg_i++)//从1开始，排除头部行
    {
        if (trs[dg_i].getElementsByTagName('td')[chkIndex].getElementsByTagName('input')[0].checked) {
            values += "'" + trs[dg_i].getElementsByTagName('td')[dataGridNum].innerText + "',";
        }
    }
    if (values != "") {
        values = values.substring(0, values.length - 1);
    }
    return values;
}

//返回Rdo选择的序号
function rtn_rdoListIndex(obj_id) {
    var rdo_len = document.getElementById(obj_id).cells.length;
    var selIndex = 0;
    for (var i = 0; i < rdo_len; i++) {
        var child_id = obj_id + "_" + i.toString();

        if (document.getElementById(child_id).checked) //注意checked不能写成Checked，要不然不成功
        {
            selIndex = i;
            break;
        }
    }
    return selIndex;
}

//返回Rdo选择的值
function rtn_rdoListValue(obj_id) {
    var rdo_len = document.getElementById(obj_id).getElementsByTagName('input').length;
    var selValue = 0;
    for (var i = 0; i < rdo_len; i++) {
        var child_id = obj_id + "_" + i.toString();

        if (document.getElementById(child_id).checked) //注意checked不能写成Checked，要不然不成功
        {
            selValue = document.getElementById(obj_id).getElementsByTagName('input')[i].value;
            break;
        }
    }
    return selValue;
}

//用逗号隔开获取chkList文本值 双边加'号 isReturnALL为true时 全选时返回'ALL'
function getchkListText(objID, isReturnALL) {
    var texts = "";
    var i = 0;
    for (var cbl_i = 0; cbl_i < document.getElementById(objID).getElementsByTagName('input').length; cbl_i++) {
        if (document.getElementById(objID).getElementsByTagName('input')[cbl_i].checked) {
            i++;
            texts += "'" + document.getElementById(objID).getElementsByTagName('LABEL')[cbl_i].innerHTML + "',";
        }
    }
    if (i != document.getElementById(objID).getElementsByTagName('input').length || !isReturnALL)//
    {
        return texts;
    }
    else {
        return 'ALL';
    }
}

//获取offsetLeft 或者 offsetTop 相对于版面距离
//isLeft 是否要获取offsetLeft
//toObj 相对与距离的元素
Math.offsetGet = function (obj, toObj) {
    var offset = { x: null, y: null };
    offset.x = obj.offsetLeft;
    offset.y = obj.offsetTop;
    while (obj = obj.offsetParent) {
        offset.x += obj.offsetLeft;
        offset.y += obj.offsetTop;
        if (toObj && obj == toObj) { break; }
    }
    return offset;
}

//获取元素
function $() {
    var elements = new Array();

    for (var i = 0; i < arguments.length; i++) {
        var element = arguments[i];
        if (typeof element == 'string')
            element = document.getElementById(element);

        if (arguments.length == 1)
            return element;

        elements.push(element);
    }

    return elements;
}

//计算字符串长度
function strlen(str) {
    var len = 0;
    for (var i = 0; i < str.length; i++) {
        if (str.charCodeAt(i) > 255 || str.charCodeAt(i < 0)) len += 2; else len++;
    }
    return len;
}
function strLEN(str) {
    var i, sum = 0;
    for (i = 0; i < str.length; i++) {
        if ((str.charCodeAt(i) >= 0) && (str.charCodeAt(i) <= 255))
            sum = sum + 1;
        else
            sum = sum + 2;
    }
    return sum;
}
//get the obj in fatherObj,but just in one level
function childGetById(fatherId, findId) {
    var fatherObj = document.getElementById(fatherId);
    if (fatherObj) {
        for (var child = 0; child < fatherObj.childNodes.length; child++) {
            if (fatherObj.childNodes[child].id == findId)
                return fatherObj.childNodes[child];
        }
    }
    return false;
}
//根据得到的结果可以使用   
//var pName = r.split("=")[0]; //获取参数名   
//var pValue = r.split("=")[1]; //获取参数值   
function getUrlParamValue(paraStr, url) {
    var result = "";
    //获取URL中全部参数列表数据   
    var str = "&" + url.split("?")[1];
    var paraName = paraStr + "=";
    //判断要获取的参数是否存在   
    if (str.indexOf("&" + paraName) != -1) {
        //如果要获取的参数到结尾是否还包含“&”   
        if (str.substring(str.indexOf(paraName), str.length).indexOf("&") != -1) {
            //得到要获取的参数到结尾的字符串   
            var TmpStr = str.substring(str.indexOf(paraName), str.length);
            //截取从参数开始到最近的“&”出现位置间的字符   
            result = TmpStr.substr(TmpStr.indexOf(paraName), TmpStr.indexOf("&") - TmpStr.indexOf(paraName));
        }
        else {
            result = str.substring(str.indexOf(paraName), str.length);
        }
    }
    else {
        result = GetTextByName("Lang_NotHaveThisArgement", useprameters.languagedata);//多语言：无此参数
    }
    return (result.replace("&", ""));
}
//保存为全局对象方便调用
function StaticObj() {
    //private
    this.data = {
        objs: {}
    }
    //obj 数据对象
    //name调用名称
    this.add = function (obj, name) {
        this.data.objs[name] = obj;
    }
    this.del = function (name) {
        delete this.data.objs[name];
    }
    this.objGet = function (name) {
        return this.data.objs[name];
    }
}
var _StaticObj = new StaticObj();
Number.prototype.toFixed = function (fractionDigits) {
    with (Math) {
        return round(this * pow(10, fractionDigits)) / pow(10, fractionDigits);
    }
}