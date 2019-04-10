using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace Web.Handlers.StatuesManage
{
    /// <summary>
    /// GetDutyCountServices 的摘要说明
    /// </summary>
    public class GetDutyCountServices : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            string strProID = context.Request["proid"].ToString();
         
            string entitid = context.Request.Cookies["id"].Value;
            DataTable dt = new DbComponent.StatuesManage.DutyRecordDao().getTodayCount(int.Parse(strProID), entitid);

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