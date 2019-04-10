using DbComponent.Comm;
using DbComponent.StatuesManage;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace Web.Handlers.StatuesManage
{
    /// <summary>
    /// getTodayDutyRecordsDetailService 的摘要说明
    /// </summary>
    public class getTodayDutyRecordsDetailService : IHttpHandler
    {
        private DutyRecordDao drdService = new DutyRecordDao();
        public void ProcessRequest(HttpContext context)
        {
            string strProID = context.Request["proid"].ToString();
            string PageIndex = context.Request["PageIndex"].ToString();
            string Limit = context.Request["Limit"].ToString();
            string entitid = context.Request.Cookies["id"].Value;

            int Start = 0;
            int End = 10;
            if (PageIndex == "1")
            {
                Start = 1;
            }
            else
            {
                Start = (int.Parse(PageIndex) - 1) * int.Parse(Limit) + 1;
            }
            End = Start + int.Parse(Limit) - 1;

            DataTable dt = drdService.getTodayDutyRecordsForDetail(int.Parse(strProID), entitid, Start, End);
            DataTable dt2 = drdService.getTodayDutyRecordsForDetailCount(int.Parse(strProID), entitid);
            string str1 = TypeConverter.DataTable2ArrayJson(dt);
            context.Response.Write("{\"totalcount\":\"" + dt2.Rows[0][0].ToString() + "\",\"data\":" + str1 + "}");
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