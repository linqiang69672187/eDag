using DbComponent;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Web.WebGis.Service
{
    public partial class getentityidsbyuserids : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["userids"].Trim() != "")  /**1,2,0;**/
            {
                string[] id = Request.QueryString["userids"].Trim().Split(';');
                DataTable dt = SQLHelper.ExecuteRead(CommandType.Text, "select [Entity_ID] from [User_info] where id in (@id)", "entity", new SqlParameter("id", id));
                System.Text.StringBuilder st = new System.Text.StringBuilder();
                st.Append("[");
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    if (i > 0) { st.Append(","); }
                    st.Append( dt.Rows[i][0]);
                }
                st.Append("]");
                Response.Write(st);
            }
        }
    }
}