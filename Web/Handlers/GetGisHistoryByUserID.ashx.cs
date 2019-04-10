using DbComponent;
/***
 * 功能:获取用户的历史轨迹
 * 公司:东方通信
 * 作者:杨德军
 * 时间:2011-06-02
 * 
 */
using System;
using System.Data;
using System.Reflection;
using System.Text;
using System.Web;
using System.Web.SessionState;

namespace Web.Handlers
{
    /// <summary>
    /// GetGisHistoryByUserID 的摘要说明:获取某个时间段内 用户的轨迹
    /// </summary>
    public class GetGisHistoryByUserID : IHttpHandler, IReadOnlySessionState
    {
        private static readonly log4net.ILog log = log4net.LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType); 
        public void ProcessRequest(HttpContext context)
        {
            try
            {
                //获取用户ID
                string              strUserID           = context.Request["UserID"];
                //获取开始时间
                string              strBegTimie         = context.Request["BegTime"];
                string              strEndTimie         = context.Request["EndTime"];
                string              PageIndex           = context.Request["pageIndex"];
                string              Limit               = context.Request["limit"];
                string              PlayGHz             = context.Request["PlayGHz"];

                StringBuilder       strResult           = new StringBuilder("[");
                DataTable           dt                  = Gis.GetHistoryGisByUserID(int.Parse(strUserID), 
                                                                                    DateTime.Parse(strBegTimie),
                                                                                    DateTime.Parse(strEndTimie),
                                                                                    PageIndex,
                                                                                    Limit, 
                                                                                    PlayGHz
                                                                                    );
                if (dt != null && dt.Rows.Count > 0)
                {
                    foreach (DataRow dr in dt.Rows)
                    {
                        strResult.Append("{\"lo\":\"" + dr["Longitude"] + "\",\"la\":\"" + dr["Latitude"] + "\",\"SendTime\":\"" + dr["Send_time"] + "\"},");
                    }
                    strResult.Remove(strResult.Length - 1, 1);
                }

                strResult.Append("]");

                context.Response.Write(strResult.ToString());
                context.Response.End();
            }
            catch (Exception ex) {
                log.Error(ex);
            }
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