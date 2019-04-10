using System;
using System.Data;

namespace Web.WebGis.Service
{
    public partial class GetTrace_byid : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string ids = (Request.QueryString["ids"].ToString());
            DataTable dt = DbComponent.Gis.gettrace_byid_new(ids);
            System.Text.StringBuilder st = new System.Text.StringBuilder();
            st.Append("[");
            string postion_err ="";

            for (int i = 0; i < dt.Rows.Count; i++)
            {
                if (i > 0) { st.Append(","); }
                postion_err = ""+dt.Rows[i][3];
                st.Append("{ \"id\":" + dt.Rows[i][0] + ", \"lo\":" + dt.Rows[i][1] + ", \"la\":" + dt.Rows[i][2] + ", \"Position_err\":" + "\"" + postion_err + "\"" + ", \"send_time\":" + "\"" + dt.Rows[i][5] + "\"" + "}");
            }
            st.Append("]");
            Response.Write(st);
            Response.End();
        }
    }
}