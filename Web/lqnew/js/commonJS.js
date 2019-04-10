function checkcallimg(obj) {
    try {
        var isFree = true;
        var mainSWF;
        if (obj) {
            mainSWF = obj.document.getElementById("main");
        }
        else {
            mainSWF = document.getElementById("main");
        }
        if (mainSWF) {
            isFree = mainSWF.callbackCheckcallimg();
        }
        return isFree;
    }
    catch (e) {
        return isFree;
    }
}