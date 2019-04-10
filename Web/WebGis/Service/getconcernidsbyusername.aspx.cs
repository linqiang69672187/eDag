using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DbComponent;
using System.Data;

namespace Web.WebGis.Service
{
    public partial class getconcernidsbyusername : System.Web.UI.Page
    {
        public string concernids_string;
        public string concernISSIs_string;
        protected void Page_Load(object sender, EventArgs e)
        {
            string username = Request.Cookies["username"].Value;
            concernids_string = getConcernIdsByUsername(username);

            string sql_concernusers = "select ISSI from User_info where id in(select * from Split('" + concernids_string + "', ';'))";
            DataTable dt_concernusers = SQLHelper.ExecuteRead(CommandType.Text, sql_concernusers, "sql_concernusers");
            
            foreach (DataRow dr in dt_concernusers.Rows)
            {
                concernISSIs_string += dr["ISSI"].ToString()+",";
            }

            Response.Write(concernISSIs_string);
            Response.End();
        }
        private string getConcernIdsByUsername(string username)
        {
            string sql_getconcernids = "select concernids from use_pramater where username = '" + username + "'";
            DataTable dt_concerids = SQLHelper.ExecuteRead(CommandType.Text, sql_getconcernids, "sql_getconcernids");
            string concernids_string1 = dt_concerids.Rows[0]["concernids"].ToString().Trim();
            return concernids_string1;
        }

    }
}