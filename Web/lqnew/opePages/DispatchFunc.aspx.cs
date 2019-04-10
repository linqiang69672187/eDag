using Ryu666.Components;
using System;

namespace Web.lqnew.opePages
{
    public partial class DispatchFunc : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Panel2.GroupingText = ResourceManager.GetString("Lang_messageService");
            Panel1.GroupingText = ResourceManager.GetString("CallService");
            Panel3.GroupingText = ResourceManager.GetString("ApplicationService");

            if (System.Configuration.ConfigurationManager.AppSettings["OpenWindow"] == "1")
            {
                Page.ClientScript.RegisterStartupScript(Page.GetType(), "resizediv", "<script>  window.parent.lq_changeheight(geturl(), document.body.clientHeight);window.parent.change(geturl());</script>");
            }
        }
    }
}