//通过cookie名获取值
function getCookieByName(cookiename) {
    var arrCookie = document.cookie.split(";");
    for (var arrCookie_i = 0; arrCookie_i < arrCookie.length; arrCookie_i++) {
        var arr = arrCookie[arrCookie_i].split("=");
        if (arr[0] == cookiename) {
            return arr[1];
        }
    }
}