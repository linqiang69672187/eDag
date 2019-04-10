using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DbComponent;
using System.Data;
using System.Data.SqlClient;

namespace Web.lqnew.opePages
{
    public partial class concernlist : System.Web.UI.Page
    {
        public string allconcernusers_json;
        public string concernids_string;
        protected void Page_Load(object sender, EventArgs e)
        {
            string username = Request.Cookies["username"].Value;

            concernids_string = getconcernidsbyusername(username);
            string sql_concernusers = "select a.id,a.Nam,a.Num,a.ISSI,a.type,b.useid,e.Name,c.typeName terminalType,c.status from User_info a left join User_onlines b on (a.id=b.useid) left join ISSI_info c on (c.ISSI=a.ISSI) left join Entity e on(a.Entity_ID=e.ID) where a.id in(select * from Split('" + concernids_string + "', ';'))";
            DataTable dt_concernusers = SQLHelper.ExecuteRead(CommandType.Text, sql_concernusers, "sql_concernusers");
            string HDISSI = DbComponent.login.GETHDISSI(Request.Cookies["username"].Value.Trim());
            DataColumn dc = new DataColumn("isonline", typeof(bool));
            dt_concernusers.Columns.Add(dc);
            DataColumn dcdisplay = new DataColumn("IsDisplay", typeof(bool));
            dt_concernusers.Columns.Add(dcdisplay);
            foreach (DataRow dr in dt_concernusers.Rows)
            {
                string issi = "<" + dr["ISSI"].ToString() + ">";
                dr["IsDisplay"] = (HDISSI.Contains(issi)) ? false : true;
                dr["isonline"] = dr["useid"].ToString() == "" ? false : true;
                dr["terminalType"] = dr["terminalType"].ToString().Trim();
            }
            allconcernusers_json = DbComponent.Comm.TypeConverter.DataTable2ArrayJson(dt_concernusers);

        }

        private string getconcernidsbyusername(string username)
        {
            string sql_getconcernids = "select concernids from use_pramater where username = '" + username + "'";
            DataTable dt_concerids = SQLHelper.ExecuteRead(CommandType.Text, sql_getconcernids, "sql_getconcernids");
            string concernids_string1 = dt_concerids.Rows[0]["concernids"].ToString().Trim();
            return concernids_string1;
        }
    }
}