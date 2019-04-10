var xPos;
var yPos;

function showToolTip(title,msg,evt){
    if (evt) {
        var url = evt.target;
    }
    else {
        evt = window.event;
        var url = evt.srcElement;
    }
    xPos = evt.clientX;
    yPos = evt.clientY;

    var toolTip = document.getElementById("toolTip");
    toolTip.style.zIndex = "1000";
    toolTip.style.width = "100px";
    toolTip.style.height = "auto";
   toolTip.innerHTML = msg;
       //"<span style='width:" + msg.length * 2 + "px'>" + msg + "</span>";
   toolTip.style.top = parseInt(yPos)+2 + "px";
   toolTip.style.left = parseInt(xPos)+2 + "px";
   toolTip.style.visibility = "visible";
   //toolTip.style.width = msg.length * 1000000 + 2 + "px";
   //toolTip.style.height = msg.length * 1.1 + 2 + "px";
}

function hideToolTip(){
   var toolTip = document.getElementById("toolTip");
   toolTip.style.visibility = "hidden";
}