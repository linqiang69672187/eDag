using DbComponent;
using System;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;

namespace Web.WebGis.Service
{
    public partial class GetGSSIbyID : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            StringBuilder sb = new StringBuilder();
            string ISSI = Request.QueryString["ISSI"];
            DataTable dt = SQLHelper.ExecuteRead(CommandType.Text, "SELECT top 1 [GSSIS]  FROM [ISSI_info] where [ISSI] = @ISSI ", "group", new SqlParameter("ISSI", ISSI));
            for (int countdt = 0; countdt < dt.Rows.Count; countdt++)
            {
                string[] GSSIS = dt.Rows[countdt][0].ToString().Replace("<", "").Split(new string[] { ">" }, StringSplitOptions.RemoveEmptyEntries);
                var zlz = from item in GSSIS where item.Contains("z") orderby item select item;
                foreach (var item in zlz)
                {
                    string myzlz = item.TrimStart('z');
                    sb.Append("{\"GSSI\":\"");
                    sb.Append(myzlz);
                    sb.Append("\"}");
                }
            }
            Response.Write(sb);
            Response.End();
        }
    }
}