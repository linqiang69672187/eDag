using DbComponent;
using System;
using System.Data;
using System.Text;

namespace Web.WebGis.Service
{
    public partial class Getalldevicestatus : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            StringBuilder sb = new StringBuilder();
            int intvalue = 0;
            sb.Append("[");
            DataTable dt = SQLHelper.ExecuteRead(CommandType.Text, "SELECT a.id ,b.Send_reason,b.Send_time,a.Entity_ID FROM [User_info] a left join GIS_info b on a.id = b.User_ID ", "GPSStatus");
            for (int countdt = 0; countdt < dt.Rows.Count; countdt++)
            {
                if (intvalue > 0) { sb.Append(","); }
                sb.Append("{ \"useid\":\"" + dt.Rows[countdt][0] + "\", \"Send_reason\":\"" + dt.Rows[countdt][1] + "\", \"Send_time\":\"" + dt.Rows[countdt][2] + "\", \"Entity_ID\":\"" + dt.Rows[countdt][3] + "\"}");
                intvalue += 1;
            }
            sb.Append("]");
            Response.Write(sb);
            Response.End();
         }
     
    }
}