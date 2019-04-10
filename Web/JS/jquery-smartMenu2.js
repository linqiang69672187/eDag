function htmltext(text) {
    var returntext;

    if (text == window.parent.parent.GetTextByName("RealTimeTrace", window.parent.parent.useprameters.languagedata)) {//多语言:实时轨迹
        returntext = window.parent.parent.tracetext(window.parent.parent.useprameters.rightselectid);
    } else if (text == window.parent.parent.GetTextByName("LockFunction", window.parent.parent.useprameters.languagedata)) {//多语言:开启锁定

    } else if (text == window.parent.parent.GetTextByName("UnLockFunction", window.parent.parent.useprameters.languagedata)) {//多语言:关闭锁定
        returntext = window.parent.parent.locktext(window.parent.parent.useprameters.rightselectid);
    } else {
        returntext = text;
    }

    return returntext;
}

(function ($) {
    var D = $(document).data("func", {});
    $.smartMenu = $.noop;
    $.fn.smartMenu = function (data, options) {
        var B = $("body", window.parent.parent.document), defaults = {
            name: "",
            offsetX: 2,
            offsetY: 2,
            textLimit: 12,
            beforeShow: $.noop,
            afterShow: $.noop
        };
        var params = $.extend(defaults, options || {});

        var htmlCreateMenu = function (datum) {
            var dataMenu = datum || data, nameMenu = datum ? Math.random().toString() : params.name, htmlMenu = "", htmlCorner = "", clKey = "smart_menu2_";
            if ($.isArray(dataMenu) && dataMenu.length) {
                htmlMenu = '<div id="smartMenu_' + nameMenu + '" class="' + clKey + 'box">' +
								'<div class="' + clKey + 'body">' +
									'<ul class="' + clKey + 'ul">';

                $.each(dataMenu, function (i, arr) {
                    if (i) {
                        htmlMenu = htmlMenu + '<li class="' + clKey + 'li_separate">&nbsp;</li>';
                    }
                    if ($.isArray(arr)) {
                        $.each(arr, function (j, obj) {
                            var text = obj.text, htmlMenuLi = "", strTitle = "", rand = Math.random().toString().replace(".", "");
                            if (text) {
                                if (text.length > params.textLimit) {
                                    text = text.slice(0, params.textLimit) + "…";
                                    strTitle = ' title="' + obj.text + '"';
                                }
                                if ($.isArray(obj.data) && obj.data.length) {
                                    htmlMenuLi = '<li class="' + clKey + 'li" data-hover="true">' + htmlCreateMenu(obj.data) +
										'<a href="javascript:" class="' + clKey + 'a"' + strTitle + ' data-key="' + rand + '"><i class="' + clKey + 'triangle"></i>' + htmltext(text) + '</a>' +
									'</li>';
                                } else {
                                    htmlMenuLi = '<li class="' + clKey + 'li">' +
										'<a href="javascript:" class="' + clKey + 'a"' + strTitle + ' data-key="' + rand + '">' + htmltext(text) + '</a>' +
									'</li>';
                                }

                                htmlMenu += htmlMenuLi;

                                var objFunc = D.data("func");
                                objFunc[rand] = obj.func;
                                D.data("func", objFunc);
                            }
                        });
                    }
                });

                htmlMenu = htmlMenu + '</ul>' +
									'</div>' +
								'</div>';
            }
            return htmlMenu;
        }, funSmartMenu = function () {
            var idKey = "#smartMenu_", clKey = "smart_menu2_", jqueryMenu = $(idKey + params.name, window.parent.parent.document);
            if (!jqueryMenu.size()) {
                // $(params.obj).append(htmlCreateMenu());
                $("body", window.parent.parent.document).append(htmlCreateMenu());

                //事件
                $(idKey + params.name + " a", window.parent.parent.document).bind("click", function () {
                    var key = $(this).attr("data-key"),
						callback = D.data("func")[key];
                    if ($.isFunction(callback)) {
                        callback.call(D.data("trigger"));
                    }
                    $.smartMenu.hide();
                    return false;
                });
                $(idKey + params.name + " li", window.parent.parent.document).each(function () {
                    var isHover = $(this).attr("data-hover"), clHover = clKey + "li_hover";
                    if (isHover) {
                        $(this).hover(function () {
                            $(this).addClass(clHover).children("." + clKey + "box").show();
                            $(this).children("." + clKey + "a").addClass(clKey + "a_hover");
                        }, function () {
                            $(this).removeClass(clHover).children("." + clKey + "box").hide();
                            $(this).children("." + clKey + "a").removeClass(clKey + "a_hover");
                        });
                    }
                });
                return $(idKey + params.name, window.parent.parent.document);
            }
            return jqueryMenu;
        };

        $(this).each(function () {
            this.oncontextmenu = function (e) {
                //回调
                if ($.isFunction(params.beforeShow)) {
                    params.beforeShow.call(this);
                }
                e = e || window.event;
                //阻止冒泡
                e.cancelBubble = true;
                if (e.stopPropagation) {
                    e.stopPropagation();
                }
                //隐藏当前上下文菜单，确保页面上一次只有一个上下文菜单
                $.smartMenu.hide();
                var st = D.scrollTop();
                var offsetvalue = 0;
                switch (data.length) {
                    case 1:
                        offsetvalue = 156;
                        break;
                    default:
                        offsetvalue = 192;
                        break;
                }
                var jqueryMenu = funSmartMenu();
                if (jqueryMenu) {
                    jqueryMenu.css({
                        display: "block",
                        left: e.clientX + params.offsetX,
                        top: e.clientY + st + params.offsetY - offsetvalue + $(window.parent.parent).height() - $(window).scrollTop()
                    });
                    D.data("target", jqueryMenu);
                    D.data("trigger", this);
                    //回调

                    if ($.isFunction(params.afterShow)) {
                        params.afterShow.call(this);
                    }
                    return false;
                }
            };
        });
        if (!B.data("bind")) {
            B.bind("click", $.smartMenu.remove).data("bind", true);
        }
    };
    $.extend($.smartMenu, {
        hide: function () {
            var target = D.data("target");
            if (target && target.css("display") === "block") {
                target.hide();
            }
        },
        remove: function () {
            var target = D.data("target");
            if (target) {
                target.remove();
            }
        }
    });
})(jQuery);