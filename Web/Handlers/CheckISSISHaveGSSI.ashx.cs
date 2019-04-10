using System.Web;
using System.Web.SessionState; 

namespace Web.Handlers
{
    /// <summary>
    /// 判断一组ISSI里面是否包含GSSI
    /// </summary>
    public class CheckISSISHaveGSSI : IHttpHandler, IReadOnlySessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            string strISSI = context.Request["issis"].ToString();
            string strReturn = "0";
         
            if (System.Configuration.ConfigurationManager.AppSettings["BackForSendGroupMsg"].ToString() == "0")
            {
                if (strISSI.Length>1)
                {
                    strISSI = strISSI.Substring(0, strISSI.Length - 1);
                    DbComponent.group gr = new DbComponent.group();
                    if (gr.CheckISSIHaveGSSI(strISSI))
                    {
                        strReturn = "1";
                    }
                    else
                    {
                        strReturn = "0";
                    }
                }
            }
            context.Response.Write("{\"message\":\"" + strReturn + "\"}");
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