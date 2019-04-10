function doPaly() {
    try{
        var wmp = document.getElementById("mhplayer");
        wmp.URL = "MP3/alrmaudio.wav"
        wmp.controls.play();
    }
    catch (e) { }
}
function endPlay() {
    try{
    var wmp = document.getElementById("mhplayer");
    wmp.controls.stop();
    }
    catch (e) { }
}