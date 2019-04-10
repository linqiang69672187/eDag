using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace Web.Handlers.StatuesManage
{
    /// <summary>
    /// GetProcedureListService 的摘要说明
    /// </summary>
    public class GetProcedureListService : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            DataTable dt = new DbComponent.StatuesManage.ProcedureDao().getProcedureList();
            
            context.Response.Write(DbComponent.Comm.TypeConverter.DataTable2ArrayJson(dt));
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