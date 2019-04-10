using DbComponent;
using System;

namespace Web.lqnew
{
    public partial class PPCCall : System.Web.UI.Page
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
            if (!IsPostBack)
            {
                if (Request["type"] != null && Request["myid"] != null)
                {
                    if (Request["type"].ToString() == "UID")
                    {
                        MyModel.Model_userinfo mu = UserInfoService.GetUserinfo_byid(int.Parse(Request["myid"].ToString()));
                        if (mu != null)
                        {
                            txtPoliceNo.Value = mu.Num;
                            txtISSIOrGSSIText.Value= mu.ISSI;
                            
                            txtUserName.Value = mu.Nam;
                            MyModel.Model_Entity me = entityService.GetEntityinfo_byid(int.Parse(mu.Entity_ID));
                            if (me != null)
                            {
                                txtEntity.Value = me.Name;
                            }
                        }
                    }
                }
            }
        }
    }
}