using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using DbComponent;
using System.Data;
using DbComponent.Comm;

namespace Web.Handlers
{
    /// <summary>
    /// GetProcedureType 的摘要说明
    /// </summary>
    public class GetProcedureType : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            String procedurename = context.Request["procedurename"].ToString();
            String type = context.Request["type"].ToString();
            if (type.Length == 0)
            {
                DataTable dt = new DataTable();
                String strsql = String.Format("select reserve1,reserve2,reserve3,reserve4,reserve5,reserve6,reserve7,reserve8,reserve9,reserve10,Remark from procedure_type where name='{0}'", procedurename);
                SQLHelper.ExecuteDataReader(ref dt, strsql);
                if (dt != null && dt.Rows.Count > 0)
                    context.Response.Write(TypeConverter.DataTable2ArrayJson(dt));
                else
                    context.Response.Write(null);
            }
            else
            {
                String strsql = String.Format("select count(0) from procedure_type where name='{0}'",procedurename);
                Object obj = SQLHelper.ExecuteScalar(strsql);
                context.Response.Write(obj.ToString());
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