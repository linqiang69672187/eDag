using DbComponent;
using System;
using System.Data;
using System.Data.SqlClient;
using System.Text;

namespace Web.WebGis.Service
{
    public partial class GetGSSIISSIbysokiet : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            StringBuilder sb = new StringBuilder();
            string id = Request.Cookies["id"].Value;
            DataTable dt = SQLHelper.ExecuteRead(CommandType.Text, "WITH lmenu(name,id) as (SELECT name,id  FROM [Entity] WHERE id=@id UNION ALL    SELECT A.NAME,A.id FROM [Entity] A,lmenu b    where a.[ParentID] = b.id) SELECT [GSSI],'GSSI' FROM [Group_info] where [Entity_ID] in (select id from lmenu)  UNION ALL SELECT [ISSI],'ISSI' FROM [ISSI_info] where [Entity_ID] in (select id from lmenu) UNION ALL SELECT [ISSI],'" + Ryu666.Components.ResourceManager.GetString("Dispatch") + "' FROM [Dispatch_Info] where [Entity_ID] in (select id from lmenu) ", "group", new SqlParameter("id", id));
            sb.Append("[");
            for (int countdt = 0; countdt < dt.Rows.Count; countdt++)
            {
                if (countdt > 0)
                {
                    sb.Append(",\"" + dt.Rows[countdt][1].ToString() + "(" + dt.Rows[countdt][0].ToString() + ")\"");
                }
                else
                {
                    sb.Append("\"" + dt.Rows[countdt][1].ToString() + "(" + dt.Rows[countdt][0].ToString() + ")\"");
                }
            }
            sb.Append("]");
            Response.Write(sb);
            Response.End();
        }
    }
}