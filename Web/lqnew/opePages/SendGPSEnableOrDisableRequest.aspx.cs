using DbComponent;
using System;

namespace Web.lqnew.opePages
{
    public partial class SendGPSEnableOrDisableRequest : System.Web.UI.Page
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
                
            }
        }
    }
}