using MyModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Web
{
    public partial class HistoryPlayer : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                Model_userinfo userinfo = new Model_userinfo();
                DbComponent.userinfo getuserinfo = new DbComponent.userinfo();
                int id = int.Parse(Request.QueryString["UserID"]);
                userinfo = getuserinfo.GetUserinfo_byid(id);

                Page.Title = userinfo.Nam;

            }
        }
    }
}