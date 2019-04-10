using DbComponent;
using System;
using System.Data;
using System.Data.SqlClient;
using System.Text;

namespace Web.WebGis.Service
{
    public partial class getlola_byID : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("{");
            string id = Request.QueryString["id"];
            DataTable dt = SQLHelper.ExecuteRead(CommandType.Text, "SELECT top 1 [Longitude],[Latitude],[ISSI],[Send_time]  FROM  [GIS_info] where [user_id] = @id ", "pc", new SqlParameter("id", id));
                        if (dt.Rows.Count > 0)
                        {
                            for (int countdt = 0; countdt < dt.Rows.Count; countdt++)
                            {
                                sb.Append("\"lo\":\"" + dt.Rows[countdt][0].ToString() + "\"");
                                sb.Append(",\"la\":\"" + dt.Rows[countdt][1].ToString() + "\"");
                                sb.Append(",\"ISSI\":\"" + dt.Rows[countdt][2].ToString() + "\"");
                                sb.Append(",\"Send_time\":\"" + dt.Rows[countdt][3].ToString() + "\"");
                            }
                        }
                        else
                        {
                            sb.Append("\"lo\":\"0\"");
                            sb.Append(",\"la\":\"0\"");
                            sb.Append(",\"ISSI\":\"0\"");
                        }
              sb.Append("}");
              Response.Write(sb);
              Response.End();

        }
    }
}