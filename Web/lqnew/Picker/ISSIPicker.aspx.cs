using DbComponent;
using System;
using System.Data;
using System.Web.UI;

namespace Web.lqnew.Picker
{
    public partial class ISSIPicker : System.Web.UI.Page
    {
        private userinfo UserInfoDao {
            get {
                return new userinfo();
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                BindRpt("");
            }
        }

        private void BindRpt(string UserName)
        {
            DataTable dt = UserInfoDao.GetAllUser(UserName);
            RptUserList.DataSource = dt;
            RptUserList.DataBind();
        }
        protected void imgSearch_OnClick(object sender, EventArgs e)
        {
            BindRpt(txtISSI.Text);
        }
    }
}