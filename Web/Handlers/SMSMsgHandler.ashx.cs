using DbComponent.IDAO;
using System;
using System.Collections.Generic;
using System.Data;
using System.Web;
using System.Web.SessionState;
using System.Data;
using System.Threading;

namespace Web.Handlers
{
    /// <summary>
    /// SMSMsgHandler 的摘要说明
    /// </summary>
    public class SMSMsgHandler : IHttpHandler, IReadOnlySessionState
    {
        private static ISMSInfoDao SmsInfoService
        {
            get
            {
                return DbComponent.FactoryMethod.DispatchInfoFactory.CreateSmsInfoDao();
            }
        }
        public void ProcessRequest(HttpContext context)
        {
            string strSendISSI = "";
            if (context.Request.Cookies["dispatchissi"] == null)
            {
                if (context.Request["msg"].ToString() == Ryu666.Components.ResourceManager.GetString("Emergency") && context.Request["smstype"].ToString() == "3")
                { }
                else { return; }
            }
            else
            {
                strSendISSI = context.Request.Cookies["dispatchissi"].Value.ToString(); //调度台ISSI号码 
            }

        
            string smstype                                   = context.Request["smstype"].ToString();              //短信类型
            string strSMSID = context.Request["id"].ToString();                   //短信返回实例ID
            string strSMSMsg                                 = context.Request["msg"].ToString();                  //假如是报告 就放到SMSMsg字段中 假如是短息内容 则放入到Content字段中
            string strRevISSI                                = context.Request["issi"].ToString();                 //返回的ISSI号码
            string strisconsume                              = context.Request["strisconsume"].ToString();         //回执

            switch (smstype)
            {
                case "0"://收到普通短息内容
                    {
                        RevCommonSms(strRevISSI, 
                                     strSendISSI,
                                     strSMSID, 
                                     strSMSMsg,
                                     MyModel.Enum.SMSType.Commom_Msg, 
                                     -1
                                     );
                    } break;
                case "01"://收到普通短息内容为空
                    {
                        RevCommonSms(strRevISSI, 
                                     strSendISSI, 
                                     strSMSID,
                                     strSMSMsg,
                                     MyModel.Enum.SMSType.Commom_Msg,
                                     -1
                                     );
                    } break;
                case "1"://收到回执短信的发送报告 跟 回执短信内容
                    {
                        if (strSMSMsg == Ryu666.Components.ResourceManager.GetString("SM_CONSUMED_BY_DESTINATION"))//多语言:短信已读
                        {
                            string strWhere = " SMSType='" + (int)MyModel.Enum.SMSType.Need_Receipt_Msg + "' and SMSID='" + strSMSID + "' and SendISSI='" + strSendISSI + "' and RevISSI='" + strRevISSI + "' and IsReturn=0 ";
                            IList<MyModel.Model_SMSInfo> list = SmsInfoService.GetSMSInfoByWhere(strWhere);
                            if (list != null && list.Count > 0)
                            {
                                SmsInfoService.UpdateIsReturn(list[0].ID, true);
                                SmsInfoService.UpdateSMSID(list[0].ID);
                                RevCommonSms(strRevISSI, 
                                             strSendISSI, 
                                             strSMSID, 
                                             strSMSMsg, 
                                             MyModel.Enum.SMSType.Commom_Msg, 
                                             list[0].ID
                                             );
                            }
                        }
                        else
                        {
                            SmsInfoService.UpdateReturnSMSSendReport(strSMSID, 
                                                                     strSendISSI, 
                                                                     strRevISSI, 
                                                                     strSMSMsg,
                                                                     false
                                                                     );
                        }
                    } break;
                case "2"://收到普通短息的发送报告 查询出SMSType为0的对应ID的 最近一条
                    {
                        RevCommSMSSendReport(strSendISSI, 
                                             strRevISSI, 
                                             strSMSID,
                                             strSMSMsg
                                             );
                    } break;
                case "3": {
                    if (strSMSMsg == Ryu666.Components.ResourceManager.GetString("Emergency"))
                    {
                        RevStatuesSms(strRevISSI, strSendISSI, strSMSID, strSMSMsg, MyModel.Enum.SMSType.Status_Msg);
                    }
                    else
                    {
                        RevStatuesSms(strRevISSI, strSendISSI, strSMSID, strSMSMsg, MyModel.Enum.SMSType.Status_Msg);
                    }
                } break;//状态消息的发送报告及其内容
                case "31": { } break;//收到的状态消息为空内容
                
                case "02": {
                    SaveSmsD2g(strSendISSI, strRevISSI, strSMSMsg);
                }
                    break;
                default: break;
            }

        }
        /// <summary>
        /// 保存回执短信
        /// </summary>
        /// <param name="sendISSI">返回的ISSI</param>
        /// <param name="revISSI">调度台ISSI</param>
        /// <param name="smsID">短消息实例ID</param>
        /// <param name="content">短消息内容</param>
        /// <param name="mytype">短消息类型</param>
        /// <param name="parentID">回执对应的记录ID</param>
        public static void RevCommonSms(string sendISSI, string revISSI, string smsID, string content, MyModel.Enum.SMSType mytype, int parentID)
        {
            //经纬度直接在这里根据ISSI号码去GIS_Info表里面查询 get longitude and latitude from the table of GIS_Info by ISSI
            DataTable      lolaDt                            = DbComponent.Gis.GetLoLaByISSI(sendISSI);
            decimal        decLo                             = 0;
            decimal        decLa                             = 0;
            if (lolaDt != null && lolaDt.Rows.Count > 0)
            {
                           decLo                             = decimal.Parse(lolaDt.Rows[0]["Longitude"].ToString());
                           decLa                             = decimal.Parse(lolaDt.Rows[0]["Latitude"].ToString());
            }
            MyModel.Model_SMSInfo ms = new MyModel.Model_SMSInfo { 
                           SendISSI                          = sendISSI,
                           RevISSI                           = revISSI,
                           RevTime                           = DateTime.Now, 
                           SMSContent                        = content,
                           IsSend                            = false, 
                           SMSType                           = (int)mytype,
                           ReturnID                          = parentID,
                           Lo                                = decLo, 
                           La                                = decLa
            };
            SmsInfoService.Save(ms);
        }
        /// <summary>
        /// 接受普通短息的发送报告 Recive Normal SMS's Send Report
        /// </summary>
        /// <param name="sendISSI">调度台ISSI dispatch's issi</param>
        /// <param name="revISSI">返回的ISSI the issi of system return</param>
        /// <param name="smsID">短消息实例ID sms's id</param>
        /// <param name="MSg">返回的短消息报告内容 the contant of sms's report return</param>
        public static void RevCommSMSSendReport(string sendISSI, string revISSI, string smsID, string MSg)
        {
            SmsInfoService.UpdateCommSMSSendReport(smsID, sendISSI, revISSI, MSg, false);
        }

        /// <summary>
        /// 保存收到的状态短信
        /// </summary>
        /// <param name="sendISSI">返回的ISSI</param>
        /// <param name="revISSI">调度台ISSI</param>
        /// <param name="smsID">短消息实例ID</param>
        /// <param name="content">短消息内容</param>
        /// <param name="mytype">短消息类型</param>
        /// <param name="parentID">回执对应的记录ID</param>
        public static void RevStatuesSms(string sendISSI, string revISSI, string smsID, string content, MyModel.Enum.SMSType mytype)
        {
            //经纬度直接在这里根据ISSI号码去GIS_Info表里面查询 get longitude and latitude from the table of GIS_Info by ISSI
            DataTable lolaDt = DbComponent.Gis.GetLoLaByISSI(sendISSI);
            decimal decLo = 0;
            decimal decLa = 0;
            if (lolaDt != null && lolaDt.Rows.Count > 0)
            {
                decLo = decimal.Parse(lolaDt.Rows[0]["Longitude"].ToString());
                decLa = decimal.Parse(lolaDt.Rows[0]["Latitude"].ToString());
            }
            MyModel.Model_SMSInfo ms = new MyModel.Model_SMSInfo
            {
                SendISSI = sendISSI,
                RevISSI = "",
                RevTime = DateTime.Now,
                IsSend = false,
                SMSType = (int)mytype,
                Lo = decLo,
                La = decLa,
               
                };
                if (content == Ryu666.Components.ResourceManager.GetString("Emergency"))
                {
                    DataTable count = DbComponent.SQLHelper.ExecuteRead(System.Data.CommandType.Text, "select count(*) count from Dagdb.dbo.SMS_Info where RevISSI='Emergency' and SendISSI=@sendISSI ", "sdfada", new System.Data.SqlClient.SqlParameter("@sendISSI", sendISSI));
                    ms.SMSContent = (Convert.ToInt32(count.Rows[0]["count"]) + 1).ToString();
                    ms.RevISSI = "Emergency";
                }
                else
                {
                    ms.RevISSI = revISSI;
                    ms.SMSContent = content;
                
            };
            SmsInfoService.Save(ms);
        }

        /// <summary>
        /// 保存调度台接收到来自其他调度台发送给组的信息
        /// </summary>
        /// <param name="sendISSI">发送的ISSI</param>
        /// <param name="revISSI">返回的ISSI</param>
        /// <param name="strSMSMsg">返回的信息</param>
        private static void SaveSmsD2g(string sendISSI, string revISSI,string strSMSMsg) {
            Thread.Sleep(2000);
            SmsInfoService.AddSMSInfoByDispatcher(revISSI, 1,2, strSMSMsg, sendISSI);
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}