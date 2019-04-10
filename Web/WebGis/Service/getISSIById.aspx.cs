using DbComponent;
using System;
using System.Data;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Web.WebGis.Service
{
    public partial class getISSIById : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            String id = Request.QueryString["id"];
            String ISSI = "";
            DataTable dt = SQLHelper.ExecuteRead(CommandType.Text, "SELECT  ISSI FROM [User_info] where Id = " + id, "getISSI");
            for (int countdt = 0; countdt < dt.Rows.Count; countdt++)
            {
                ISSI = dt.Rows[countdt][0].ToString();
            }
            Response.Write(ISSI);
            Response.End();
        }
    }
}