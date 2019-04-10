using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Web.Handlers
{
    /// <summary>
    /// GetHDISSIByUserName 的摘要说明
    /// </summary>
    public class GetHDISSIByUserName : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            string userName = context.Request["userName"].ToString();
            DbComponent.login login = new DbComponent.login();
            string HDISSI=login.GetHDISSIByUserName(userName);
           
                HDISSI = "{\"HDISSI\":\"" + HDISSI + "\"}";
 
            context.Response.Write(HDISSI);
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