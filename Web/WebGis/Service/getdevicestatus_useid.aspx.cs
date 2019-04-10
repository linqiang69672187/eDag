using DbComponent;
using System;
using System.Data;
using System.Data.SqlClient;
using System.Text;

namespace Web.WebGis.Service
{
    public partial class getdevicestatus_useid : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            int devicetimeout = 15;
            //DataTable useparameter = DbComponent.usepramater.GetUseparameterByCookie(Request.Cookies["username"].Value);
            //for (int i = 0; i < useparameter.Rows.Count; i++)
            //{
            //    devicetimeout = int.Parse(useparameter.Rows[i]["device_timeout"].ToString());
            //}
            StringBuilder sb = new StringBuilder();
            string ID = Request.QueryString["id"];
            int dt = int.Parse(SQLHelper.ExecuteScalar(CommandType.Text, "SELECT COUNT(*) FROM [GIS_info] where [User_ID] =@id and Send_reason not in ('Subscriber_unit_is_powered_OFF','DMO_ON') and DATEDIFF(MINUTE,Send_time,GETDATE()) < " + devicetimeout + " ", new SqlParameter("id", ID)).ToString());
            sb.Append("{\"id\":" + ID + ",\"value\":");
            sb.Append(dt);
            sb.Append("}");
            Response.Write(sb);
            Response.End();
        }
    }
}