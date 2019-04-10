using DbComponent;
using System;
using System.Reflection;
using System.Web;
using System.Web.SessionState;

namespace Web.Handlers
{
    /// <summary>
    /// GetISSIByISSIID 的摘要说明
    /// </summary>
    public class GetISSIByISSIID : IHttpHandler, IReadOnlySessionState
    {
        private static readonly log4net.ILog log = log4net.LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);
        public void ProcessRequest(HttpContext context)
        {
            string                      strR           = "error";
            try
            {
                ISSI                    ISSIService    = new ISSI();
                MyModel.Model_ISSI      issi           = ISSIService.GetISSIinfo_byid(int.Parse(context.Request["id"].ToString()));
                if (issi != null)
                {
                                        strR           = issi.ISSI;
                }
            }
            catch (Exception ex) {
                log.Debug(ex);
            }
            context.Response.Write(strR);
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