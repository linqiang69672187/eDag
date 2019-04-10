#region
/*
 * 杨德军
 * **/
#endregion
using MyModel;
using MyModel.Enum;
using System;
using System.Collections.Generic;

namespace DbComponent.IDAO
{
    public interface ISMSInfoDao
    {
        /// <summary>
        /// 新增对象
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        bool                     Save(Model_SMSInfo model);
        /// <summary>
        /// 修改对象
        /// </summary>
        /// <param name="newModel"></param>
        /// <returns></returns>
        bool                     Update(Model_SMSInfo newModel);
        /// <summary>
        /// 修改普通短息发送报告
        /// </summary>
        /// <param name="SmsID"></param>
        /// <param name="SendISSI"></param>
        /// <param name="RevISSI"></param>
        /// <param name="SMSMsg"></param>
        /// <param name="IsSend"></param>
        /// <returns></returns>
        bool                     UpdateCommSMSSendReport(string SmsID,
                                                         string SendISSI,
                                                         string RevISSI,
                                                         string SMSMsg,
                                                         bool IsSend);
        /// <summary>
        /// 有回执的短息发送报告
        /// </summary>
        /// <param name="SmsID"></param>
        /// <param name="SendISSI"></param>
        /// <param name="RevISSI"></param>
        /// <param name="SMSMsg"></param>
        /// <param name="IsSend"></param>
        /// <returns></returns>
        bool                     UpdateReturnSMSSendReport(string SmsID, 
                                                           string SendISSI, 
                                                           string RevISSI, 
                                                           string SMSMsg, 
                                                           bool IsSend);
        /// <summary>
        /// 根据ID删除对象
        /// </summary>
        /// <param name="ID"></param>
        /// <returns></returns>
        bool                     Delete(int ID);
        /// <summary>
        /// 根据ID修改是否回执
        /// </summary>
        /// <param name="ID"></param>
        /// <param name="IsReturn"></param>
        /// <returns></returns>
        bool                     UpdateIsReturn(int  ID, 
                                                bool IsReturn);
        /// <summary>
        /// 根据ID修改短消息实例句柄
        /// </summary>
        /// <param name="ID"></param>
        /// <returns></returns>
         bool                    UpdateSMSID(int ID);
        /// <summary>
        /// 根据短信类型获取短信列表
        /// </summary>
        /// <param name="stype">短信类型</param>
        /// <returns></returns>
        IList<Model_SMSInfo>     GetSMSInfoByType(SMSType stype);
        /// <summary>
        /// 根据发送者ISSI获取短信列表
        /// </summary>
        /// <param name="ISSI">发送者ISSI</param>
        /// <returns></returns>
        IList<Model_SMSInfo>     GetSMSInfoBySendISSI(string ISSI);
        /// <summary>
        /// 根据接收者ISSI获取短息列表
        /// </summary>
        /// <param name="ISSI">接受者ISSI</param>
        /// <returns></returns>
        IList<Model_SMSInfo>     GetSMSInfoByRevISSI(string ISSI);
        /// <summary>
        /// 根据自定义条件获取短息列表
        /// </summary>
        /// <param name="where">自定义条件</param>
        /// <returns></returns>
        IList<Model_SMSInfo>     GetSMSInfoByWhere(String where);
        /// <summary>
        /// 获取未读短信
        /// </summary>
        /// <param name="RevISSI">接受者</param>
        /// <returns></returns>
        IList<Model_SMSInfo>     GetUnReadSmsList(string RevISSI);
        
        /// <summary>
        /// 添加其他调度台接收而没有存在数据库中的单条短信信息
        /// </summary>
        /// <param name="sendISSI">发送的ISSI</param>
        /// <param name="isGroup">1表示是组信息</param>
        /// <param name="notGroup">2表示不是组信息</param>
        /// <param name="msg">发送的内容</param>
        /// <param name="revISSI">返回的ISSI</param>
        /// <returns></returns>
        bool AddSMSInfoByDispatcher(string sendISSI, int isGroup, int notGroup, string msg, string revISSI);
    }
}
