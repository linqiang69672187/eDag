using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using DbComponent;

namespace Web.lqnew.opePages
{
    public partial class realTimeTraceUserList : System.Web.UI.Page
    {
        public string allRealTimeTraceUsers_json;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["userId"] != null)
            {
                string username = Request.Cookies["username"].Value;
                string sql_concernusers = "select a.id,a.Nam,a.Num,a.ISSI,a.type,b.useid,e.Name,c.typeName terminalType,c.status from User_info a left join User_onlines b on (a.id=b.useid) left join ISSI_info c on (c.ISSI=a.ISSI) left join Entity e on(a.Entity_ID=e.ID) where a.id in(select * from Split('" + Request.QueryString["userId"].ToString().Trim() + "', ':'))";
                DataTable dt_RealTimeTraceUsers = SQLHelper.ExecuteRead(CommandType.Text, sql_concernusers, "sql_concernusers");
                string HDISSI = DbComponent.login.GETHDISSI(Request.Cookies["username"].Value.Trim());
                DataColumn dc = new DataColumn("isonline", typeof(bool));
                dt_RealTimeTraceUsers.Columns.Add(dc);
                DataColumn dcdisplay = new DataColumn("IsDisplay", typeof(bool));
                dt_RealTimeTraceUsers.Columns.Add(dcdisplay);
                foreach (DataRow dr in dt_RealTimeTraceUsers.Rows)
                {
                    string issi = "<" + dr["ISSI"].ToString() + ">";
                    dr["IsDisplay"] = (HDISSI.Contains(issi)) ? false : true;
                    dr["isonline"] = dr["useid"].ToString() == "" ? false : true;
                    dr["terminalType"] = dr["terminalType"].ToString().Trim();
                }
                allRealTimeTraceUsers_json = DbComponent.Comm.TypeConverter.DataTable2ArrayJson(dt_RealTimeTraceUsers);
            }
            else { allRealTimeTraceUsers_json = null; }
        }
    }
}