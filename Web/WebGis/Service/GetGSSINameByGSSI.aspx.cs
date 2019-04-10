using DbComponent;
using System;
using System.Data;
using System.Data.SqlClient;
using System.Text;

namespace Web.WebGis.Service
{
    public partial class GetGSSINameByGSSI : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            StringBuilder sb = new StringBuilder();
            string GSSI = Request.QueryString["GSSI"];
            DataTable dt = SQLHelper.ExecuteRead(CommandType.Text, "SELECT top 1 [Group_name]  FROM [Group_info] where [GSSI] = @GSSI ", "group", new SqlParameter("GSSI", GSSI));
            for (int countdt = 0; countdt < dt.Rows.Count; countdt++)
            {
                    sb.Append("{\"GSSIName\":\"");
                    sb.Append(dt.Rows[countdt][0].ToString());
                    sb.Append("\"}");
            }
            Response.Write(sb);
            Response.End();
            
        }
    }
}