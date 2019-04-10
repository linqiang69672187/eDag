using DbComponent;
/*
 * 杨德军
 * **/
using System;
using System.Reflection;
using System.Web;
using System.Web.SessionState;

namespace Web.Handlers
{
    /// <summary>
    /// GetHistoryTotalCount 的摘要说明
    /// </summary>
    public class GetHistoryTotalCount : IHttpHandler, IReadOnlySessionState
    {
        private static readonly log4net.ILog log = log4net.LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType); 
        public void ProcessRequest(HttpContext context)
        {
            try
            {
                string                  strUserID           = context.Request["UserID"];
                string                  strBegTimie         = context.Request["BegTime"];
                string                  strEndTimie         = context.Request["EndTime"];
                string                  PlayGHz             = context.Request["PlayGHz"];

                string                  strResult           = Gis.GetHistoryResultTotalCount(int.Parse(strUserID), 
                                                                                             DateTime.Parse(strBegTimie),
                                                                                             DateTime.Parse(strEndTimie), 
                                                                                             PlayGHz);
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