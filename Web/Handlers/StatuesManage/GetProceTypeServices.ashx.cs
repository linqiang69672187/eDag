using DbComponent.Comm;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace Web.Handlers.StatuesManage
{
    /// <summary>
    /// GetProceTypeServices 的摘要说明
    /// </summary>
    public class GetProceTypeServices : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            string procedure_id = context.Request["procedure_id"].ToString();
            String strSQL = "select reserve1,reserve2,reserve3,reserve4,reserve5,reserve6,reserve7,reserve8,reserve9,reserve10 from _procedure a join procedure_type t on (a.pType=t.name) where a.id=@id";
            DataTable dt = DbComponent.SQLHelper.ExecuteRead(System.Data.CommandType.Text, strSQL, "types", new SqlParameter("id", procedure_id));
            context.Response.Write(TypeConverter.DataTable2ArrayJson(dt));
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