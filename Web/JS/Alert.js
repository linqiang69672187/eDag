

function showWarnDialog(title, content) {
    var obj = new Array(title, content);
    window.showModalDialog('/Admin/Error.aspx?t=' + new Date(), obj, 'dialogHeight:180px;dialogWidth:250px;status:no;')

}

window.alert = function(txt) {
    var shield = document.createElement("DIV");
    shield.id = "shield";
    shield.style.position = "absolute";
    shield.style.left = "0px";
    shield.style.top = "0px";
    shield.style.width = "300px";
    shield.style.height = "150px";
    shield.style.background = "#EAF7FD";
    shield.style.textAlign = "center";
    shield.style.zIndex = "10000";
    shield.style.filter = "alpha(opacity=0)";
    var alertFram = document.createElement("DIV");
    alertFram.id = "alertFram";
    alertFram.style.position = "absolute";
    alertFram.style.left = "50%";
    alertFram.style.top = "50%";
    alertFram.style.marginLeft = "-75px";
    alertFram.style.marginTop = "-75px";
    alertFram.style.width = "300px";
    alertFram.style.height = "150px";
    alertFram.style.background = "#ccc";
    alertFram.style.textAlign = "center";
    alertFram.style.lineHeight = "150px";
    alertFram.style.zIndex = "10001";
    strHtml = "<ul style=\"list-style:none;margin:0px;padding:0px;width:100%\">\n";
    strHtml += " <li style=\"background:#DD828D;text-align:left;padding-left:20px;font-size:14px;font-weight:bold;height:25px;line-height:25px;border:1px solid #F9CADE;\">[系统提示]</li>\n";
    strHtml += " <li style=\"background:#fff;text-align:center;font-size:12px;height:120px;line-height:120px;border-left:1px solid #F9CADE;border-right:1px solid #F9CADE;\">" + txt + "</li>\n";
    strHtml += " <li style=\"background:#FDEEF4;text-align:center;font-weight:bold;height:25px;line-height:25px; border:1px solid #F9CADE;\"><input type=\"button\" value=\"确 定\" onclick=\"doOk()\" /></li>\n";
    strHtml += "</ul>\n";
    alertFram.innerHTML = strHtml;
    document.body.appendChild(alertFram);
    document.body.appendChild(shield);
    var c = 0;
    this.doAlpha = function() {
        if (c++ > 20) { clearInterval(ad); return 0; }
        shield.style.filter = "alpha(opacity=" + c + ");";
    }
    var ad = setInterval("doAlpha()", 5);
    this.doOk = function() {
         window.close;
        window.location.href = "/admin/DefaultRight.aspx";
  
    }
     alertFram.focus();
    document.body.onselectstart = function() { return false; };
}
