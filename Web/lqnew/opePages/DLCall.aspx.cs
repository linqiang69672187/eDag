using DbComponent;
using Ryu666.Components;
using System;

namespace Web.lqnew
{
    public partial class DLCall : System.Web.UI.Page
    {
        private userinfo UserInfoService
        {
            get
            {
                return new userinfo();
            }
        }
        private Entity entityService
        {
            get
            {
                return new Entity();
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            btnnew.Text = ResourceManager.GetString("Add_New");
            if (!IsPostBack)
            {
                if (Request["type"] != null && Request["myid"] != null)
                {
                    if (Request["type"].ToString() == "UID")
                    {
                        MyModel.Model_userinfo mu = UserInfoService.GetUserinfo_byid(int.Parse(Request["myid"].ToString()));
                        if (mu != null)
                        {
                            txtISSIText.Value = mu.ISSI;
                            txtPoliceNo.Value = mu.Num;

                            txtUserName.Value = mu.Nam;
                            MyModel.Model_Entity me = entityService.GetEntityinfo_byid(int.Parse(mu.Entity_ID));
                            if (me != null)
                            {
                                txtUserEntity.Value = me.Name;
                            }
                        }
                    }
                }
            }
        }
    }
}