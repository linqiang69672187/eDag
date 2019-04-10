using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Web.Handlers
{
    /// <summary>
    /// OpenHDHandler 的摘要说明
    /// </summary>
    public class OpenHDHandler : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            string issi = context.Request["issi"].ToString();
            string username = context.Request["username"].ToString();
            try
            {
                DbComponent.login.DISISSI(issi, username);
                context.Response.Write("{\"result\":\"true\"}");
            }
            catch (Exception ex) {
                context.Response.Write("{\"result\":\"false\"}");
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