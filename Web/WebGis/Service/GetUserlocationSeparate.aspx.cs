using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using DbComponent;
using System.Text;
namespace Web.WebGis.Service
{
    public partial class GetUserlocationSeparate : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            StringBuilder sb = new StringBuilder();            
            sb.Append("[");
            String needGetRealtimeTraceUsersString = Request.QueryString["needGetRealtimeTraceUsersString"];
            String[] needGetRealtimeTraceUsers = needGetRealtimeTraceUsersString.Split(',');
            String sql = "select a.ISSI,a.Longitude,a.Latitude,a.Inserttb_time as Send_time,a.Send_reason,a.User_ID as ID,DATEDIFF(MINUTE,Send_time,GETDATE()) as dbdatediff, b.Nam+ '('+a.ISSI+ ')' as Info,b.type from [GIS_info] a join User_info b on(a.User_ID=b.id) where ";
            for (int i = 0; i < needGetRealtimeTraceUsers.Length-1;i++ )
            {
                if (needGetRealtimeTraceUsers[i] != "")
                {
                    sql += "a.ISSI= " + needGetRealtimeTraceUsers[i] + " or ";
                }
            }
            sql += "a.ISSI= " + needGetRealtimeTraceUsers[needGetRealtimeTraceUsers.Length - 1];

            DataTable dt = SQLHelper.ExecuteRead(CommandType.Text, sql, "GetRealtimeTraceUsers");
            for (int countdt = 0; countdt < dt.Rows.Count; countdt++)
            {
                sb.Append("{ \"dbdatediff\":\"" + dt.Rows[countdt]["dbdatediff"] + "\", \"ISSI\":\"" + dt.Rows[countdt]["ISSI"] + "\", \"ID\":\"" + dt.Rows[countdt]["ID"] + "\", \"Info\":\"" + dt.Rows[countdt]["Info"] + "\", \"Latitude\":\"" + dt.Rows[countdt]["Latitude"] + "\", \"Longitude\":\"" + dt.Rows[countdt]["Longitude"] + "\", \"Send_reason\":\"" + dt.Rows[countdt]["Send_reason"] + "\", \"Send_time\":\"" + dt.Rows[countdt]["Send_time"] + "\", \"type\":\"" + dt.Rows[countdt]["type"] +"\"}");
            }
            sb.Append("]");
            Response.Write(sb);
            Response.End();
        }
    }
}