

$(document).ready(function () { Lang2localfunc() });

function Lang2localfunc() {

        $("*[id^='Lang-T']").each(function () {
            $("#" + this.id).text(window.parent.GetTextByName(this.id + "text", window.parent.useprameters.languagedata));
        })
        $("img[id^='Lang-Img3']").each(function () {
            $("#" + this.id).attr("src", window.parent.GetTextByName(this.id, window.parent.useprameters.languagedata));
            $("#" + this.id).attr("onmouseover", "javascript:this.src='" + window.parent.GetTextByName(this.id + "_un", window.parent.useprameters.languagedata)+"'");
            $("#" + this.id).attr("onmouseout", "javascript:this.src='" + window.parent.GetTextByName(this.id, window.parent.useprameters.languagedata)+"'");

        })
        $(".Lang").each(function (index, element) {
            element.innerHTML = window.parent.GetTextByName(this.langid + "text", window.parent.useprameters.languagedata);
      
        })
        $(".Langtxt").each(function (index, element) {
            element.innerHTML = window.parent.GetTextByName(this.id, window.parent.useprameters.languagedata);

        })
        $("img[imgid^='Lang']").each(function (index, element) {
            element.src = window.parent.GetTextByName(this.imgid, window.parent.useprameters.languagedata)
        })

  
}