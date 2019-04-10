
function language_change()
{
    document.getElementById("Callpanel").innerHTML = window.parent.GetTextByName("Callpanel", window.parent.useprameters.languagedata);
    document.getElementById("single").innerHTML = window.parent.GetTextByName("single", window.parent.useprameters.languagedata);
    document.getElementById("call").innerHTML = window.parent.GetTextByName("call", window.parent.useprameters.languagedata);
    document.getElementById("smallGroupCall").innerHTML = window.parent.GetTextByName("smallGroupCall", window.parent.useprameters.languagedata);
    document.getElementById("YAOQIYAOBI").innerHTML = window.parent.GetTextByName("YAOQIYAOBI", window.parent.useprameters.languagedata);
    document.getElementById("PJgroup_call").innerHTML = window.parent.GetTextByName("PJgroup_call", window.parent.useprameters.languagedata);
    document.getElementById("DXgroup_call").innerHTML = window.parent.GetTextByName("DXgroup_call", window.parent.useprameters.languagedata);
    document.getElementById("CloseMonitoring").innerHTML = window.parent.GetTextByName("CloseMonitoring", window.parent.useprameters.languagedata);
    document.getElementById("EnvironmentalMonitoring").innerHTML = window.parent.GetTextByName("EnvironmentalMonitoring", window.parent.useprameters.languagedata);



}