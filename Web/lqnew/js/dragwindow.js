var dragEnable = 'True';
function dragdiv() {
    var div1 = window.parent.document.getElementById(geturl());
    window.parent.windowDivOnClick(div1);
    if (div1 && event.button == 0 && dragEnable == 'True') {
        window.parent.mystartDragWindow(div1, null, event);
        div1.style.border = "solid 0px transparent";
        window.parent.cgzindex(div1);

    }
}
function mydragWindow() {
    var div1 = window.parent.document.getElementById(geturl());
    if (div1 && event.button == 0 && dragEnable == 'True') {
        window.parent.mydragWindow(div1, event);
    }
}

function mystopDragWindow() {
    var div1 = window.parent.document.getElementById(geturl());
    if (div1 && event.button == 0 && dragEnable == 'True') {
        window.parent.mystopDragWindow(div1); div1.style.border = "0px";
    }
}
window.onload = function () {

    document.body.onclick = function () {
        //alert();
        //var div2 = window.parent.document.getElementById(geturl());
        //window.parent.windowDivOnClick(div2);
    }
    document.body.onmousedown = function () {
        var div2 = window.parent.document.getElementById(geturl());

        window.parent.windowDivOnClick(div2);
        dragdiv();
    }
    document.body.onmousemove = function () { mydragWindow(); }
    document.body.onmouseup = function () { mystopDragWindow(); }
    document.body.oncontextmenu = function () { return false; }
    var arrayelement = ["input", "a", "select", "li", "font", "textarea"];
    for (n = 0; n < arrayelement.length; n++) {
        var inputs = document.getElementsByTagName(arrayelement[n]);
        for (i = 0; i < inputs.length; i++) {
            inputs[i].onmouseout = function () {
                dragEnable = 'True';
            }
            inputs[i].onmouseover = function () {
                dragEnable = 'False';
            }
        }
    }
    var table = document.getElementById("dragtd");
    table.onmouseout = function () {
        dragEnable = 'True';
    }

    table.onmouseover = function () {
        dragEnable = 'False';
    }

}