using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DbComponent;
using System.Data;

namespace Web.WebGis.Service
{
    public partial class UpdateIsHideOfflineUserVarToDatabase : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string isHideOfflineUser = Request.QueryString["isHideOfflineUser"];
            bool UpdateIsHideOfflineUserVarResult = UpdateIsHideOfflineUserVar(isHideOfflineUser);
            Response.Write("{\"msg\":\"" + UpdateIsHideOfflineUserVarResult.ToString() + "\"}");
            Response.End();
        }
        public bool UpdateIsHideOfflineUserVar(string isHideOfflineUser)
        {
            try
            {
                string sql_UpdateIsHideOfflineUserVar = "update use_pramater set isHideOfflineUserBySelect = '" + isHideOfflineUser + "' where username = '" + Request.Cookies["username"].Value + "'";
                SQLHelper.ExecuteNonQuery(CommandType.Text, sql_UpdateIsHideOfflineUserVar);
                return true;
            }
            catch (Exception e)
            {
                return false;
            }
        }
    }
}