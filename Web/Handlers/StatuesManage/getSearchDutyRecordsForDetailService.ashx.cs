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
    /// getSearchDutyRecordsForDetailService 的摘要说明
    /// </summary>
    public class getSearchDutyRecordsForDetailService : IHttpHandler
    {
        private DutyRecordDao drdService = new DutyRecordDao();
        public void ProcessRequest(HttpContext context)
        {
            string strProID = context.Request["proid"].ToString();
            string PageIndex = context.Request["PageIndex"].ToString();
            string Limit = context.Request["Limit"].ToString();
            string entitid = context.Request.Cookies["id"].Value;
            string type = context.Request["type"].ToString();

            string issi = context.Request["issi"].ToString();
            string carno = context.Request["carno"].ToString();
            string statues = context.Request["statues"].ToString();
            string begtimes = context.Request["begtimes"].ToString();
            string endtimes = context.Request["endtimes"].ToString();
            bool isCK = Convert.ToBoolean(context.Request["isCK"].ToString());
            DateTime begtime = DateTime.Parse(begtimes + " 0:0:0");
            DateTime endtime = DateTime.Parse(endtimes + " 23:59:59"); 

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

            DataTable dt = new DataTable();
            DataTable dt2 = new DataTable();
            if (type == "1")
            {
                dt = drdService.getSearchDutyRecordsForDetail(int.Parse(strProID), entitid, Start, End, issi, carno, statues, begtime, endtime, isCK);
                 dt2 = drdService.getSearchDutyDutyRecordsForDetailCount(int.Parse(strProID), entitid, issi, carno, statues, begtime, endtime, isCK);
            }
            else if (type == "0") {
                dt = drdService.getSearchDutyRecords(int.Parse(strProID), entitid, Start, End, issi, carno, statues, begtime, endtime, isCK);
                dt2 = drdService.getSearchDutyRecordsCount(int.Parse(strProID), entitid, issi, carno, statues, begtime, endtime, isCK);
          
            }
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