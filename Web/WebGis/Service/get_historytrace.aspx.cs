using System;
using System.Data;

namespace Web.WebGis.Service
{
    public partial class get_historytrace : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            int id = int.Parse(Request.QueryString["id"].ToString());
            DateTime sendtime = DateTime.Parse("2011-01-11 13:14:11");
            int lineint = 0;
            DataTable dt = DbComponent.Gis.gethisorytrace_id(id, sendtime, lineint);
            System.Text.StringBuilder st = new System.Text.StringBuilder();
            st.Append("[");
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                if (i > 0){st.Append(",");}
                st.Append("{ \"lo\":" + dt.Rows[i][0] + ", \"la\":" + dt.Rows[i][1] + "}");
            }
            st.Append("]");
            Response.Write(st);
            Response.End();
        }
    }
}