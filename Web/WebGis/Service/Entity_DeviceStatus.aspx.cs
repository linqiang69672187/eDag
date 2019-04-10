using DbComponent;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Web.WebGis.Service
{
    public partial class Entity_DeviceStatus : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            StringBuilder sb = new StringBuilder();
            int intvalue = 0;
            int  intvalue1 = 0;
            sb.Append("[[");
            DataTable dt = SQLHelper.ExecuteRead(CommandType.Text, "SELECT [EntityID],[Online],[Total] FROM [Entity_Device] ", "GPSStatus");
            for (int countdt = 0; countdt < dt.Rows.Count; countdt++)
            {
                if (intvalue > 0) { sb.Append(","); }
                sb.Append("{ \"EntityID\":\"" + dt.Rows[countdt][0] + "\", \"Online\":\"" + dt.Rows[countdt][1] + "\", \"Total\":\"" + dt.Rows[countdt][2] + "\"}");
                intvalue += 1;
            }
            sb.Append("],[");
            DataTable dt1 = SQLHelper.ExecuteRead(CommandType.Text, "SELECT [useid] FROM [User_onlines] ", "GPSStatus1");
            for (int countdt = 0; countdt < dt1.Rows.Count; countdt++)
            {
                if (intvalue1 > 0) { sb.Append(","); }
                sb.Append(dt1.Rows[countdt][0]);
                intvalue1 += 1;
            }

            sb.Append("]]");
            Response.Write(sb);
            Response.End();
        }
    }
}