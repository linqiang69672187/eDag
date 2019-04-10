using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Web;

namespace Web.Handlers
{
    /// <summary>
    /// WriteDebugLog 的摘要说明
    /// </summary>
    public class WriteDebugLog : IHttpHandler
    {
        private static readonly log4net.ILog log = log4net.LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);
        public void ProcessRequest(HttpContext context)
        {
            string strLogMSG = context.Request["logmsg"].ToString();
            log.Debug("flex or javascript Debug Info:" + strLogMSG);
            context.Response.Write("{}");
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