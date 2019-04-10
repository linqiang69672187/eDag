function LanguageSwitch(WebLevel) {
    try{
        if (WebLevel == null) {
            var listElm = document.getElementById("mouseMenu").all;
            for (var i = listElm.length - 1; i >= 0; i--) {
                var id = listElm[i].id;
                if (id == "") {
                    continue;
                }
                if (id.substr(0, 4) == "Lang") {
                    //if (listElm[i].id == "Lang-Cancel")
                    //{
                    //    alert(listElm[i].tagName);
                    //}
                    if (listElm[i].tagName == "IMG" || (listElm[i].tagName == "INPUT" && listElm[i].type == "image")) {

                        var imgsrc = GetTextByName(id, useprameters.languagedata);
                        listElm[i].src = imgsrc;


                        if (listElm[i].onmouseover != null) {
                            var onmouseover_img = GetTextByName(id + "_un", useprameters.languagedata);
                            listElm[i].onmouseover.src = onmouseover_img;
                        }
                        if (listElm[i].onmouseout != null) {
                            listElm[i].onmouseout.src = imgsrc;
                        }
                    }
                    else {
                        var innerText = GetTextByName(id, useprameters.languagedata);
                        listElm[i].innerText = innerText;
                    }
                }
            }
        }
        else {
            var listElm = document.all;
            for (var i = listElm.length - 1; i >= 0; i--) {
                var id = listElm[i].id;
                if (id == "") {
                    continue;
                }
                if (id.substr(0, 4) == "Lang") {
                    //if (listElm[i].id == "Lang-Cancel")
                    //{
                    //    alert(listElm[i].tagName);
                    //}
                    if (listElm[i].tagName == "IMG" || (listElm[i].tagName == "INPUT" && listElm[i].type == "image")) {

                        var imgsrc = WebLevel.GetTextByName(id, WebLevel.useprameters.languagedata);
                        listElm[i].src = imgsrc;


                        if (listElm[i].onmouseover != null) {
                            var onmouseover_img = WebLevel.GetTextByName(id + "_un", WebLevel.useprameters.languagedata);
                            listElm[i].onmouseover.src = onmouseover_img;
                        }
                        if (listElm[i].onmouseout != null) {
                            listElm[i].onmouseout.src = imgsrc;
                        }
                    }
                    else {
                        var innerText = WebLevel.GetTextByName(id, WebLevel.useprameters.languagedata);
                        listElm[i].innerText = innerText;
                    }
                }
            }
        }
    }
    catch(e){
        alert("LanguageSwitch" + e)
    }
}