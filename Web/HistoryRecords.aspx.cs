using MyModel;
using System;
using System.Web.UI;
namespace Web
{
    public partial class HistoryRecords : System.Web.UI.Page
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