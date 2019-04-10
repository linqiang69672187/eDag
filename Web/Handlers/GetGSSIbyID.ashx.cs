using DbComponent;
using System;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;

namespace Web.Handlers
{
    /// <summary>
    /// GetGSSIbyID 的摘要说明
    /// </summary>
    public class GetGSSIbyID : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {

            StringBuilder sb = new StringBuilder();
            sb.Append("[");
            string ISSI = context.Request.QueryString["ISSI"];
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
            sb.Append("]");

            context.Response.Write(sb.ToString());
            context.Response.End();
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}