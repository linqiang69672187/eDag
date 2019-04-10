function replace_chineseName()
{
    
    document.getElementById("ToBesureSave").innerHTML = window.parent.GetTextByName("ToBesureSave", window.parent.useprameters.languagedata);
    document.getElementById("Terminalsettings").innerHTML = window.parent.GetTextByName("Terminalsettings", window.parent.useprameters.languagedata);
    document.getElementById("DeviceOverTime").innerHTML = window.parent.GetTextByName("DeviceOverTime", window.parent.useprameters.languagedata);
    document.getElementById("minute").innerHTML = window.parent.GetTextByName("minute", window.parent.useprameters.languagedata);
    document.getElementById("MapFresh").innerHTML = window.parent.GetTextByName("MapFresh", window.parent.useprameters.languagedata);
    document.getElementById("Sencond").innerHTML = window.parent.GetTextByName("Sencond", window.parent.useprameters.languagedata);
    document.getElementById("Info").innerHTML = window.parent.GetTextByName("Info", window.parent.useprameters.languagedata);
    document.getElementById("Display").innerHTML = window.parent.GetTextByName("Display", window.parent.useprameters.languagedata);
    document.getElementById("MapBackgroundPicture").innerHTML = window.parent.GetTextByName("MapBackgroundPicture", window.parent.useprameters.languagedata);    
    document.getElementById("Upload").innerHTML = window.parent.GetTextByName("Upload", window.parent.useprameters.languagedata);
    document.getElementById("btn1").innerHTML = window.parent.GetTextByName("BeCancel", window.parent.useprameters.languagedata);
    document.getElementById("Hidden").innerHTML = window.parent.GetTextByName("Hidden", window.parent.useprameters.languagedata);
    document.getElementById("PoliceType").innerHTML = window.parent.GetTextByName("PoliceType", window.parent.useprameters.languagedata);
    document.getElementById("Lang_userHeadInfo").innerHTML = window.parent.GetTextByName("Lang_userHeadInfo", window.parent.useprameters.languagedata);
    document.getElementById("Lang_UserHeaderInfo_StatuesMSG").innerHTML = window.parent.GetTextByName("Lang_UserHeaderInfo_StatuesMSG", window.parent.useprameters.languagedata);
    document.getElementById("Lang_voiceType").innerHTML = window.parent.GetTextByName("Lang_voiceType", window.parent.useprameters.languagedata);
    document.getElementById("Lang_OpenUserHeaderInfo").innerHTML = window.parent.GetTextByName("Lang_OpenUserHeaderInfo", window.parent.useprameters.languagedata);
    document.getElementById("ToBesureSave2").innerHTML = window.parent.GetTextByName("ToBesureSave", window.parent.useprameters.languagedata);
    document.getElementById("Kilometres").innerHTML = window.parent.GetTextByName("Kilometres", window.parent.useprameters.languagedata);
    document.getElementById("KilometresUnit").innerHTML = window.parent.GetTextByName("KilometresUnit", window.parent.useprameters.languagedata);
    document.getElementById("Lang_key0").innerHTML = window.parent.GetTextByName("Lang_key0", window.parent.useprameters.languagedata);
    document.getElementById("Lang_key1").innerHTML = window.parent.GetTextByName("Lang_key1", window.parent.useprameters.languagedata);
    document.getElementById("Lang_key2").innerHTML = window.parent.GetTextByName("Lang_key2", window.parent.useprameters.languagedata);
    document.getElementById("Lang_key3").innerHTML = window.parent.GetTextByName("Lang_key3", window.parent.useprameters.languagedata);
    document.getElementById("Lang_key4").innerHTML = window.parent.GetTextByName("Lang_key4", window.parent.useprameters.languagedata);
    document.getElementById("Lang_key5").innerHTML = window.parent.GetTextByName("Lang_key5", window.parent.useprameters.languagedata);
    document.getElementById("Lang_key6").innerHTML = window.parent.GetTextByName("Lang_key6", window.parent.useprameters.languagedata);
    document.getElementById("Lang_key7").innerHTML = window.parent.GetTextByName("Lang_key7", window.parent.useprameters.languagedata);
    document.getElementById("Lang_key8").innerHTML = window.parent.GetTextByName("Lang_key8", window.parent.useprameters.languagedata);
    document.getElementById("Lang_key9").innerHTML = window.parent.GetTextByName("Lang_key9", window.parent.useprameters.languagedata);
    document.getElementById("Bubble_usermessage").innerHTML = window.parent.GetTextByName("Bubble_usermessage", window.parent.useprameters.languagedata);

    //cxy-20180730-添加基站聚合配置
    document.getElementById("ClusterType").innerHTML = window.parent.GetTextByName("BaseStationCluster", window.parent.useprameters.languagedata);
    //cxy-20180809-添加场强控制
    document.getElementById("Lang_fieldStrength").innerHTML = window.parent.GetTextByName("Lang_fieldStrength", window.parent.useprameters.languagedata);

    // document.getElementById("Button1").attributes.setNamedItem("Text").nodeValue = "hhh";

    //document.getElementById("TabPanel1").attributes.getNamedItem("TabPanel1").nodeValue = document.getElementById("btn1").innerHTML = window.parent.GetTextByName("Routine", window.parent.useprameters.languagedata);
//xzj--20190320--设置呼叫加密语言
document.getElementById("callEncryption").innerHTML = window.parent.GetTextByName("callEncryption", window.parent.useprameters.languagedata);
   

}