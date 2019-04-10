var OperateLogModule = {
    //系统模块
    ModuleSystem: 0,
    //呼叫模块
    ModuleCall: 1,
    ModuleSMS: 2,
    ModuleGPS: 3,
    ModuleApplication: 4
};
var OperateLogType=
{
    operlog : 0,
    calllog : 1,
    smslog : 2,
    syslog : 3
}

var OperateLogOperType = {
    /// <summary>
    /// 登录
    /// </summary>
    LogOn: 0,
    /// <summary>
    /// 退出
    /// </summary>
    LogOut: 1,
    /// <summary>
    /// 全双工单呼
    /// </summary>
    FullDuplex: 2,
    /// <summary>
    /// 半双工单呼
    /// </summary>
    HalfDuplex: 3,
    /// <summary>
    /// 组呼
    /// </summary>
    GroupCall: 4,
    /// <summary>
    /// 派接
    /// </summary>
    PatchCall: 5,
    /// <summary>
    /// 多选
    /// </summary>
    MultiSelect: 6,
    /// <summary>
    /// 遥启
    /// </summary>
    ReviceTerminal: 7,
    /// <summary>
    /// 遥晕
    /// </summary>
    KillTerminal: 8,
    /// <summary>
    /// 环境监听
    /// </summary>
    AmbienceListening: 9,
    /// <summary>
    /// 慎密监听
    /// </summary>
    DiscreetListening: 10,
    /// <summary>
    /// 强拆
    /// </summary>
    ForcedRelease: 11,
    /// <summary>
    /// 强插
    /// </summary>
    BreakIn: 12,
    /// <summary>
    /// 紧急全双工单呼
    /// </summary>
    PPCFullDulex: 13,
    /// <summary>
    /// 紧急半双工单呼
    /// </summary>
    PPCHalfDuplex: 14,
    /// <summary>
    /// 紧急组呼
    /// </summary>
    PPCGroupCall: 15,
    /// <summary>
    /// 全站广播
    /// </summary>
    AllBaseStation: 16,
    /// <summary>
    /// 多站广播
    /// </summary>
    MultiBaseStation: 17,
    /// <summary>
    /// 单站广播
    /// </summary>
    SingleBaseStation: 18,
    /// <summary>
    /// 动态从组
    /// </summary>
    DGNA: 19,
    /// <summary>
    /// 实时轨迹
    /// </summary>
    RealTimeTrajectory: 20,
    /// <summary>
    /// 电子栅栏
    /// </summary>
    ElectronicFence: 21,
    /// <summary>
    /// 锁定
    /// </summary>
    Lock: 22,
    /// <summary>
    /// 移动用户显示关闭
    /// </summary>
    MobileDisplay: 23,
    /// <summary>
    /// 参数设置
    /// </summary>
    ParamsSet: 24,
    /// <summary>
    /// 普通短信发送
    /// </summary>
    CommSMSSend: 25,
    /// <summary>
    /// 状态消息发送
    /// </summary>
    StatuesSMSSend: 26,
    /// <summary>
    /// GPS立即上报
    /// </summary>
    GPSImmediateSend: 27,
    /// <summary>
    /// GPS参数修改
    /// </summary>
    GPSParamsEdit: 28,

    /// <summary>
    /// GPS上报开关
    /// </summary>
    GPSOpen: 29,

    /// <summary>
    /// 历史轨迹
    /// </summary>
    HistoricalTrajectory:30,
    
    /// <summary>
    /// GPS上报模式
    /// </summary>
    GPSModeEdit: 31,

    /// <summary>
    /// GPS距离上报模式
    /// </summary>
    GPSDistanceEdit: 32
}

var OperateLogIdentityDeviceType = {
    /// <summary>
    /// 基站
    /// </summary>
    BaseStation: 0,
    /// <summary>
    /// 调度台
    /// </summary>
    DispatchConsole: 1,
    /// <summary>
    /// 固定台
    /// </summary>
    FixedStation: 2,
    /// <summary>
    /// 手台
    /// </summary>
    MobilePhone: 3,
    //其他
    Other:99
}
var IdentityType = {
    User: 0,
    Dispatch: 1,
    Car: 2
}



function isPressmiss(opernum) {
    var flag = false;
   
    return flag;
}
var ParameType ={
    /// <summary>
    /// 传用户标识
    /// </summary>
    UID:0,
    /// <summary>
    /// 传终端号码 
    /// </summary>
    UIS:1,
    /// <summary>
    /// 不传
    /// </summary>
    Other:2
}


///依据UserID，写入日志
function writeToDbByUserID(UserID, LogType, ModuleName, OperType, Content, IdentityDeviceType) {
    var parames = { fun: ParameType.UID, userid: UserID, logtype: LogType, module: ModuleName, IdentityDeviceType: IdentityDeviceType, opertype: OperType, content: Content };
    jquerygetNewData_ajax("Handlers/WriteLog.ashx", parames, function (msg) {

    });
}

///依据ISSI，写入日志
function writeToDbByUserISSI(DeviceISSI, LogType, ModuleName, OperType, Content, IdentityType) {
    var parames = { fun: ParameType.UIS, userid: DeviceISSI, logtype: LogType, module: ModuleName, IdentityDeviceType: IdentityType, opertype: OperType, content: Content };
    jquerygetNewData_ajax("Handlers/WriteLog.ashx", parames, function (msg) {

    });
}

///不针对终端与用户情况下使用
function writeToDbByOther(LogType, ModuleName, OperType, Content, IdentityType) {
    var parames = { fun: ParameType.Other, userid: "", logtype: LogType, module: ModuleName, IdentityDeviceType: IdentityType, opertype: OperType, content: Content };
    jquerygetNewData_ajax("Handlers/WriteLog.ashx", parames, function (msg) {

    });
}

///num为数字1，2，3，4等
///从多语言中获取对应值
///<resource name="Module1">Call Module</resource>
function getTextByNumForModule(num) {
    if (num != null && num != "" && num != "null") {
        return GetTextByName("Module" + num, useprameters.languagedata);
    } else
        return "";
}

///num为数字1，2，3，4等
///从多语言中获取对应值
///<resource name="OperateLogOperType12">Insert operation</resource>
function getTextByNumForOperType(num) {
    if (num != null && num != "" && num != "null") {
        return GetTextByName("OperateLogOperType" + num, useprameters.languagedata);
    } else
        return "";
}