using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace Web.Handlers
{
    /// <summary>
    /// GetDTG_Member 的摘要说明
    /// </summary>
    public class GetDTG_Member : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            string issi = context.Request["issi"].ToString();
            string statues = context.Request["statues"].ToString();
            string dtgroupid = context.Request["dtgroupid"].ToString();
            string PageIndex = context.Request["PageIndex"].ToString();//第几页
            string Limit = context.Request["Limit"].ToString();//每页显示的条数

            string strWhere = "";
            if (issi != "") {
                strWhere += " and Memb_ISSI=@Memb_ISSI ";
            }
            if (statues != "-1") {
                strWhere += " and Status=@Status ";
            }

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
            String strsql = " select * from (SELECT *,ROW_NUMBER() over(order by [CreateTime] desc) rownms FROM DTG_Member Where DTG_ID=@ID " + strWhere + ")  a  Where  rownms between @Start and @End ";
            DataTable dt2 = DbComponent.SQLHelper.ExecuteRead(CommandType.Text, strsql, "dsfs", new SqlParameter("ID", dtgroupid), new SqlParameter("Start", Start), new SqlParameter("End", End), new SqlParameter("Memb_ISSI", issi), new SqlParameter("Status", int.Parse(statues)));
            String sql = "SELECT count(0) FROM DTG_Member Where DTG_ID=@ID " + strWhere;
            DataTable dt = DbComponent.SQLHelper.ExecuteRead(CommandType.Text, sql, "dsfs", new SqlParameter("ID", dtgroupid), new SqlParameter("Memb_ISSI", issi), new SqlParameter("Status", int.Parse(statues)));

          
            context.Response.Write("");
            context.Response.Write("{\"totalcount\":\"" + dt.Rows[0][0].ToString() + "\",\"data\":" + DbComponent.Comm.TypeConverter.DataTable2ArrayJson(dt2) + "}");
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