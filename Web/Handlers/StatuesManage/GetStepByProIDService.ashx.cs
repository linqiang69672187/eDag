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
    /// GetStepByProIDService 的摘要说明
    /// </summary>
    public class GetStepByProIDService : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            string procedure_id = context.Request["procedure_id"].ToString();
            string strSQL = "select command,name,markId from step where procedure_id=@procedure_id";
            DataTable dt = DbComponent.SQLHelper.ExecuteRead(System.Data.CommandType.Text, strSQL, "step", new SqlParameter("procedure_id", procedure_id));
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