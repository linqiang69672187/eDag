//ALon：指定精度
//ALat：指定纬度
//Apoints:多边形顶点集合
function IsPtInPoly(ALon, ALat, APoints) {
    var iSum = 0; //交点个数
    var iCount = APoints.length;
    var iIndex;
    var dLon1;
    var dLon2;
    var dLat1;
    var dLat2;
    var dLon; //A点向左射线与边的交点的x坐标
    var returnResult = false;

    if (iCount < 3) {
        return returnResult;
    }

    for (iIndex = 0; iIndex <= iCount - 1; iIndex++) {
        // for(iIndex in APoints){//也可以使用这个
        if (iIndex == iCount - 1) {
            dLon1 = APoints[iIndex].lo;
            dLat1 = APoints[iIndex].la;
            dLon2 = APoints[0].lo;
            dLat2 = APoints[0].la;
            // alert("精度：" + dLon1 + "纬度：" + dLat1 + "  To 精度：" + dLon2 + "维度：" + dLat2);
        } else {
            dLon1 = APoints[iIndex].lo;
            dLat1 = APoints[iIndex].la;
            dLon2 = APoints[iIndex + 1].lo;
            dLat2 = APoints[iIndex + 1].la;
            // alert("精度：" + dLon1 + "纬度：" + dLat1 + "  To 精度：" + dLon2 + "维度：" + dLat2);
        }

        //以下语句判断A点是否在边的两端点的水平平行线之间，在则 可能有交点，开始判断交点是否在左射线上
        //只需判断维度 也就是Y坐标 是否在两端点中间即可
        if (((ALat >= dLat1) && (ALat < dLat2)) || ((ALat >= dLat2) && (ALat < dLat1))) {
            //
            if (Math.abs(dLat1 - dLat2) > 0) {
                //得到 A点向左射线与边的交点的x坐标：
                dLon = dLon1 - ((dLon1 - dLon2) * (dLat1 - ALat)) / (dLat1 - dLat2);
                // 如果交点在A点左侧（说明是做射线与 边的交点），则射线与边的全部交点数加一：
                if (dLon < ALon) {
                    iSum += 1;
                }
            }
        }
    }
    if (iSum % 2 != 0) {
        returnResult = true;
    }

    return returnResult;
}
/**@判断点是否在矩形内**/
function IsPtInRectangle(myPoint, arryPoint) {
    var myx = myPoint.lo;
    var myy = myPoint.la;
    var minx = arryPoint.minLo;
    var maxx = arryPoint.maxLo;
    var miny = arryPoint.minLa;
    var maxy = arryPoint.maxLa;
    if (myx >= minx && myx <= maxx && myy >= miny && myy <= maxy) {
        return true;
    }
    else return false;
}
/**@判断点是否在椭圆内**/
function IsPtInOval(myPoint, OvalPoint) {
    var a = OvalPoint.centerlo - OvalPoint.lo1;
    var b = OvalPoint.centerla - OvalPoint.la4;
    if (Math.pow(myPoint.lo - OvalPoint.centerlo, 2) / Math.pow(a, 2) + Math.pow(myPoint.la - OvalPoint.centerla, 2) / Math.pow(b, 2) <= 1) {
        return true;
    }
    return false;
}
function isPtInCrile(myPoint, CrilePoint) {
    var myX = myPoint.lo;
    var myY = myPoint.la;

    var centerX = CrilePoint.lo1;
    var centerY = CrilePoint.la1;

    var crile2X = CrilePoint.lo2;
    var crile2Y = CrilePoint.la2;

    var length1 = Math.sqrt(Math.pow(myX - centerX, 2) + Math.pow(myY - centerY, 2));
    var length2 = Math.sqrt(Math.pow(crile2X - centerX, 2) + Math.pow(crile2Y - centerY, 2));

    if (length1 < length2) {
        return true;
    } else {
        return false;
    }
}