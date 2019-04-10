using DbComponent;
using System;
using System.Data;
using System.Data.SqlClient;

namespace Web.WebGis.Service
{
    public partial class IsDisplay_byID : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string pcid = Request.QueryString["id"];

            int countpc = int.Parse(SQLHelper.ExecuteScalar(CommandType.Text, "select count(*) from [User_info] where id=@id and IsDisplay=1", new SqlParameter("id", pcid)).ToString());
            Response.Write(countpc.ToString());
            Response.End();
        }
    }
}