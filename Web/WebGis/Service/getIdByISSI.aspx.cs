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
    public partial class getIdByISSI : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            String ISSI = Request.QueryString["ISSI"];
            String id = "";
            DataTable dt = SQLHelper.ExecuteRead(CommandType.Text, "SELECT  id FROM [User_info] where ISSI = "+ISSI, "getid");
            for (int countdt = 0; countdt < dt.Rows.Count; countdt++)
            {
                id = dt.Rows[countdt][0].ToString();
            }
            Response.Write(id);
            Response.End();
        }

    }
}