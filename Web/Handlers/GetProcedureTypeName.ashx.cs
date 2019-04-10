using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using DbComponent;
using System.Text;

namespace Web.Handlers
{
    /// <summary>
    /// GetProcedureTypeName 的摘要说明
    /// </summary>
    public class GetProcedureTypeName : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            IList<Object> valuelist=new List<Object>();
            String strsql = "select name from procedure_type";
            SQLHelper.ExecuteDataReader(ref valuelist, strsql);
            if (valuelist.Count == 0)
                return;
            StringBuilder sb = new StringBuilder();
            for (int i = valuelist.Count - 1; i >= 0; i--)
            {
                sb.AppendFormat("{0},", valuelist[i]);
            }
            sb=sb.Remove(sb.Length - 1, 1);
            context.Response.Write(sb.ToString());
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