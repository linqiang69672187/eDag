using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using DbComponent;

namespace Web.lqnew.opePages
{
    public partial class getentityidsbyuserids : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string users = Request.QueryString["userids"].ToString();
            string spl_getentityid = "select Entity_ID from User_info where id in (select * from Split('" + users + "' , ','))";
            DataTable dtEntitys = SQLHelper.ExecuteRead(CommandType.Text, spl_getentityid, "spl_getentityid");
            string entitys = DbComponent.Comm.TypeConverter.DataTable2ArrayJson(dtEntitys);
            Response.Write(entitys);
            Response.End();
        }
    }
}