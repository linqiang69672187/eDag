//电子栅栏成员个数
var fenceMemberCount = 20;

//电子栅栏刷新时间 单位为毫秒
var fenceFreshTime = 5 * 60 * 1000;//5分钟

//电子栅栏处理延迟时间（相邻两个间隔，一般不允许改动5毫秒） 单位为毫秒
var layzTime = 5;

//历史轨迹查询间隔设置参数 单位为毫秒
var historySelectTimeSpace = 24 * 60 * 60 * 1000;

//GPS开关控制 两条记录发送间隔 默认2秒
var gpsControlSendSpace = 2 * 1000;

//两条短信发送间隔
var smsSendSpace = 1 * 1000;

//短信发送成员个数控制，一次能发送多少成员 TODO 暂无限制
var smsMemberLimit = 50;

//GPS控制成员个数限制，一次能控制多少成员 TODO 暂无限制
var gpsControlMemberLimit = 50;

//GPS控制的时候 设定的类型
var issiType = 0;//0代表摩托罗拉、1代表赛普了

//等待GPSMsg返回函数的极限时间 这个值要至少大于gpsControlSendSpace
var waitGPSMsgLimitTime = 10 * 1000;
var TimeOut_Interval = 30 * 1000;
var Distance_Mas = 2; //单位千米 当相邻GPS距离大于该值时即为应舍弃的点

var isWriteDebugLog = 1;//0表示不写 1表示写