using DbComponent;
using System;
using System.Data;
using System.Data.SqlClient;
using System.Text;

namespace Web.WebGis.Service
{
    public partial class getdevicetotalby_issi : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            int devicetimeout = 15;
            DataTable useparameter = DbComponent.usepramater.GetUseparameterByCookie(Request.Cookies["username"].Value);
            for (int i = 0; i < useparameter.Rows.Count; i++)
            {
                devicetimeout = int.Parse(useparameter.Rows[i]["device_timeout"].ToString());
            }
            StringBuilder sb = new StringBuilder();
            string ID = Request.QueryString["id"];
            DataTable dt = SQLHelper.ExecuteRead(CommandType.Text, "WITH lmenu(name,id) as (SELECT name,id  FROM [dbo].[Entity] WHERE id=@id UNION ALL    SELECT A.NAME,A.id FROM [dbo].[Entity] A,lmenu b    where a.ParentID = b.[ID])  SELECT COUNT(*) FROM [GIS_info] where ISSI in (SELECT issi FROM [issi_info] where [Entity_ID] in (select id from lmenu)) and Send_reason not in ('Subscriber_unit_is_powered_OFF','DMO_ON') and DATEDIFF(MINUTE,Send_time,GETDATE()) < " + devicetimeout + "  union all  SELECT COUNT([id]) FROM [issi_info] where [Entity_ID] in (select id from lmenu) ", "group", new SqlParameter("id", ID));
            sb.Append("{\"id\":" + ID + ",\"value\":[");
            for (int countdt = 0; countdt < dt.Rows.Count; countdt++)
            {
                if (countdt == 0)
                {
                    sb.Append(dt.Rows[countdt][0].ToString());
                }
                else
                {
                    sb.Append("," + dt.Rows[countdt][0].ToString());
                }

            }
            sb.Append("]}");
            Response.Write(sb);
            Response.End();
        }
    }
}