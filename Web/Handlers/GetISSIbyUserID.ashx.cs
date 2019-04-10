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
    /// GetISSIbyUserID 的摘要说明
    /// </summary>
    public class GetISSIbyUserID : IHttpHandler, IReadOnlySessionState
    {
        private static readonly log4net.ILog log = log4net.LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);
        public void ProcessRequest(HttpContext context)
        {
            string                       strR         = "error";
            try
            {
                string                   UserID       = context.Request["id"].ToString();
                userinfo                 u            = new userinfo();
                MyModel.Model_userinfo   mu           = u.GetUserinfo_byid(int.Parse(UserID));
                if (mu != null)
                {
                    strR = mu.ISSI;
                }
            }
            catch (Exception ex)
            {
                log.Error(ex);
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