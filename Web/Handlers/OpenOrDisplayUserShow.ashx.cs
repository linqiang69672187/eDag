/*
 * 杨德军
 * **/
using System.Web;
using System.Web.SessionState;

namespace Web.Handlers
{
    /// <summary>
    /// OpenOrDisplayUserShow 的摘要说明
    /// </summary>
    public class OpenOrDisplayUserShow : IHttpHandler, IReadOnlySessionState
    {
   
        public void ProcessRequest(HttpContext context)
        {
            string                  strCMD          = context.Request["cmd"].ToString();
            string                  strISSI         = context.Request["userissi"].ToString();
            if (strCMD == "false")
            {
                DbComponent.login.DISISSI(strISSI, context.Request.Cookies["username"].Value);//打开显示
            }
            else
            {
                DbComponent.login.HDISSI(strISSI, context.Request.Cookies["username"].Value);//关闭显示
            }
            context.Response.Write("OK");
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