using DbComponent;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace Web.Handlers.Statues
{
    /// <summary>
    /// GetStatuesLoLa 的摘要说明
    /// </summary>
    public class GetStatuesLoLa : IHttpHandler
    {
   
        public void ProcessRequest(HttpContext context)
        {
            string entityid = context.Request.Cookies["id"].Value.ToString();
            string LoginName = context.Request.Cookies["username"].Value.ToString();
            string minlo = context.Request["minlo"];
            string maxlo = context.Request["maxlo"];
            string minla = context.Request["minla"];
            string maxla = context.Request["maxla"];
            SqlParameter[] sp = new SqlParameter[6];
            sp[0] = new SqlParameter("@minlo", minlo);
            sp[1] = new SqlParameter("@maxlo", maxlo);
            sp[2] = new SqlParameter("@minla", minla);
            sp[3] = new SqlParameter("@maxla", maxla);
            sp[4] = new SqlParameter("@entity_id", entityid);
            sp[5] = new SqlParameter("@username", LoginName);

            DataSet ds = SqlData.ExecuteDataset(Web.Config.m_connectionString, CommandType.StoredProcedure, "getJRHWData", sp);
            if (ds.Tables.Count > 0)
            {
                context.Response.Write(DbComponent.Comm.TypeConverter.DataTable2ArrayJson(ds.Tables[0]));
            }
            else {
                context.Response.Write("[]");
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