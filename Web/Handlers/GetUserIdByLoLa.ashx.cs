using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;

namespace Web.Handlers
{
    /// <summary>
    /// GetUserIdByLoLa 的摘要说明
    /// </summary>
    public class GetUserIdByLoLa : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            string sids = context.Request["sids"].ToString();
            string[] strlola = sids.Split(new char[] { ',' }, StringSplitOptions.None);
            string le = "  WITH lmenu(name,id) as (SELECT name,id  FROM [Entity] WHERE id='" + context.Request.Cookies["id"].Value + "' UNION ALL SELECT A.NAME,A.id FROM [Entity] A,lmenu b   where a.[ParentID] = b.id) ";
            string strSQL = le + " select User_ID from GIS_info join user_info on User_ID = user_info.ID join lmenu on([Entity_ID]=lmenu.id) where Longitude>'" + strlola[0] + "' and Longitude<'" + strlola[1] + "' and Latitude>'" + strlola[2] + "' and Latitude< '" + strlola[3] + "'";
            DataTable dt = DbComponent.SQLHelper.ExecuteRead(CommandType.Text, strSQL.ToString(), "adfadss");
            string strids = "";
            StringBuilder sbids = new StringBuilder();
            foreach (DataRow dr in dt.Rows)
            {
                //strids += dr["User_ID"].ToString() + ";";
                sbids.Append(dr["User_ID"].ToString());
                sbids.Append(";");
            }
            strids = sbids.ToString();
            if (strids.Length > 0)
            {
                strids = strids.Substring(0, strids.Length - 1);
            }

            context.Response.Write("{\"result\":\"" + strids + "\"}");
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