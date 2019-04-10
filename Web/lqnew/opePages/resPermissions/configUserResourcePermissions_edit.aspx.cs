using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Web.lqnew.opePages.resPermissions
{
    public partial class configUserResourcePermissions_edit : System.Web.UI.Page
    {
        public String par = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["id"] != null)
            {
                par = Request.QueryString["id"];
            }
        }
    }
}