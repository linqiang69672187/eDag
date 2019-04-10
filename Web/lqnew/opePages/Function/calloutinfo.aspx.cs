using MyModel;
using Ryu666.Components;
using System;
using System.Web.UI;

namespace Web.lqnew.opePages.Function
{
    public partial class calloutinfo : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                Model_userinfo userinfo = new Model_userinfo();
                DbComponent.userinfo getuserinfo = new DbComponent.userinfo();
                int id = int.Parse(Request.QueryString["id"]);
                userinfo = getuserinfo.GetUserinfo_byid(id);

                dragtd.InnerHtml += ResourceManager.GetString("Name") + ":" + userinfo.Nam;

                string[] txt = Request.QueryString["txt"].Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries);
                info_title.InnerHtml = txt[0];
                int i;
                for (i = 1; i < txt.Length;i++ )
                {
                    dragtd.InnerHtml += "<br/>" + txt[i];
                }
                btn2.Attributes.Add("onclick", "window.parent.mycallfunction('Function/edit_userviewstate',310,330," + id + ");window.parent.closeceit('Police,0,0'," + id + ");window.parent.lq_closeANDremovediv('Function/calloutinfo','bgDiv');");
            }

        }
    }
}