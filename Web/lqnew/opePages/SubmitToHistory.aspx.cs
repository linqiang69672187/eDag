using MyModel;
using System;
using System.Web.UI;

namespace Web.lqnew.opePages
{
    public partial class SubmitToHistory : System.Web.UI.Page
    {
        public  string strDataNow = DateTime.Now.ToString();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                Model_userinfo userinfo = new Model_userinfo();
                DbComponent.userinfo getuserinfo = new DbComponent.userinfo();
                int id = int.Parse(Request.QueryString["id"]);
                userinfo = getuserinfo.GetUserinfo_byid(id);
                Label1.Text = userinfo.Nam;
                usertype.Text = userinfo.type;
                labelISSI.Text = userinfo.ISSI;//xzj--20181120
            }

        }
    }
}