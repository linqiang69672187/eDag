//用来动态添加某事件后处理函数
//循环遍历事件后处理函数
//funNames--指定需要执行的函数
function Event(args, funNames) {
    for (var i in _EventAfter) {
        if (typeof (_EventAfter[i]) == "function" && funNames.indexOf(i) >= 0) {
            _EventAfter[i](args);
        }
    }
}

//事件处理后函数
var _EventAfter = new EventAfter();
function EventAfter(outargs) {//外部参数带入
    this.args; //可通过正外部定义内部参数来在内部使用的目的 当然可以自行增加其它参数
}

//定义事件后处理函数 中某函数
_EventAfter.args = '_EventAfterargs';
_EventAfter.afun = function(outarg) {
    alert(_EventAfter.args + " " + outarg);
}
//激发事件
Event('_EventAfteroutarg');
