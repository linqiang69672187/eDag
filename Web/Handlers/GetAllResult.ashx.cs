using DbComponent;
/*
 * 杨德军
 * **/
using System;
using System.Data;
using System.Reflection;
using System.Text;
using System.Web;
using System.Web.SessionState;

namespace Web.Handlers
{
    /// <summary>
    /// GetAllResult 的摘要说明
    /// </summary>
    public class GetAllResult : IHttpHandler, IReadOnlySessionState
    {
        private static readonly log4net.ILog    log   = log4net.LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType); 
        public void ProcessRequest(HttpContext context)
        {
            try
            {
                //获取用户ID
                string               strUserID       = context.Request["UserID"];
                //获取开始时间
                string               strBegTimie     = context.Request["BegTime"];
                string               strEndTimie     = context.Request["EndTime"];
                string               PlayGHz         = context.Request["PlayGHz"];

                StringBuilder        strResult       = new StringBuilder("[");
                DataTable            dt              = Gis.GetHistoryGisByUserID(int.Parse(strUserID),
                                                                                 DateTime.Parse(strBegTimie),
                                                                                 DateTime.Parse(strEndTimie), 
                                                                                 PlayGHz
                                                                                 );
                if (dt != null&&dt.Rows.Count>0)
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
            catch (Exception ex)
            {
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