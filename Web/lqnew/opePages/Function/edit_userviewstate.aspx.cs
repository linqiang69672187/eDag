using System;
using System.Web.UI;

namespace Web.lqnew.opePages.Function
{
    public partial class edit_userviewstate : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                int id = int.Parse(Request.QueryString["id"]);
                string issi = DbComponent.Gis.GetISSI(id);
                DbComponent.login.HDISSI(issi, Request.Cookies["username"].Value);
                Response.Write("<script>window.parent.lq_removeimgpc('Police,0,0_OutputLayerCell','Police,0,0|" + id + "_vFigure');window.parent.changevis('hidden'," + issi + ");</script>");



            }

        }
    }
}