//将数字*10的几次方才大于1 用于小于1的数字
function CountPow(number) {
    return Math.ceil(Math.log(1 / number) / Math.log(10));
}
function DegreeToRad(degree) {//角度转换成弧度
    return Math.PI * (degree) / 180;
}
function RadToRegree(rad) {//弧度转换成角度
    return (180 * rad) / Math.PI;
}