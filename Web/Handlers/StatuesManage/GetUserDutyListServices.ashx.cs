using DbComponent;
using DbComponent.Comm;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;

namespace Web.Handlers.StatuesManage
{
    /// <summary>
    /// GetUserDutyListServices 的摘要说明
    /// </summary>
    public class GetUserDutyListServices : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            string entitid = context.Request.Cookies["id"].Value;
            string pid = context.Request["pid"].ToString();
            string uname = context.Request["uname"].ToString();
            string PageIndex = context.Request["PageIndex"].ToString();
            string Limit = context.Request["Limit"].ToString();

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

            string where = "";
            if (uname != "") {
                where += " and a.issi  like '%" + stringfilter.Filter(uname.Trim()) + "%' ";
            }
            if (pid != "")
            {
                where += " and b.id=@pid ";
            }

            StringBuilder sbsql = new StringBuilder(" WITH lmenu(id) as (SELECT id  FROM [Entity] WHERE id=@entityid UNION ALL SELECT A.id FROM [Entity] A,lmenu b    where a.[ParentID] = b.id)");
            sbsql.Append(" select q.* from ( select a.id,a.issi,a.name as uname,a.num,b.name as pname,c.Name as ename, ROW_NUMBER() over(order by a.createTime desc) rownms from   user_duty a  ");
            sbsql.Append(" left join _procedure b on(a.procedure_id=b.id)");
            sbsql.Append(" left join Entity c on(a.entityID=c.ID) where a.entityID in (select  id from lmenu) " + where + " )");
            sbsql.Append(" q where rownms between @start and @limit");
            DataTable dt1 = DbComponent.SQLHelper.ExecuteRead(CommandType.Text, sbsql.ToString(), "dsdfs", new SqlParameter("pid", pid), new SqlParameter("limit", End), new SqlParameter("start", Start), new SqlParameter("entityid", entitid));

            StringBuilder sbsql2 = new StringBuilder(" WITH lmenu(id) as (SELECT id  FROM [Entity] WHERE id=@entityid UNION ALL SELECT A.id FROM [Entity] A,lmenu b    where a.[ParentID] = b.id)");
            sbsql2.Append(" select count(0) from user_duty a ");
            sbsql2.Append(" left join _procedure b on(a.procedure_id=b.id) ");
            sbsql2.Append(" left join Entity c on(a.entityID=c.ID)");
            sbsql2.Append("  where a.entityID in (select  id from lmenu) " + where + " ");
            DataTable dt2 = DbComponent.SQLHelper.ExecuteRead(CommandType.Text, sbsql2.ToString(), "dsdfs", new SqlParameter("pid", pid), new SqlParameter("entityid", entitid));
            string str1 = TypeConverter.DataTable2ArrayJson(dt1);
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