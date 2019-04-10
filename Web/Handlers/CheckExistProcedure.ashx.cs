using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using DbComponent;

namespace Web.Handlers
{
    /// <summary>
    /// CheckExistProcedure 的摘要说明
    /// </summary>
    public class CheckExistProcedure : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            String procedurename = context.Request["procedurename"].ToString();
            String strsql = String.Format("select count(0) from _procedure where name='{0}'",procedurename);
            Object i = SQLHelper.ExecuteScalar(strsql);
            context.Response.Write(i.ToString());
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