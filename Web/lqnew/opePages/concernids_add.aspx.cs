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
    public partial class concernids_add : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string userids = Request.Form["concernids"];
            bool IsAddSuccess = Addconcernid(userids);
            Response.Write("{\"msg\":\"" + IsAddSuccess.ToString() + "\"}");
            Response.End();
        }

        public bool Addconcernid(string userids)
        {
            try
            {
                string sql_addconcernid = "update use_pramater set concernids = '" + userids + "' where username = '" + Request.Cookies["username"].Value + "'";
                SQLHelper.ExecuteNonQuery(CommandType.Text, sql_addconcernid);
                return true;
            }
            catch (Exception e) {
                return false;
            }
        }
    }
}