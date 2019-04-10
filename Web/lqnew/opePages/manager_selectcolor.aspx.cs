using Ryu666.Components;
using System;
using System.Web.UI;

namespace Web.lqnew.opePages
{
    public partial class manager_selectcolor : System.Web.UI.Page
    {
          
        protected void Page_Load(object sender, EventArgs e)
        {
            Page.ClientScript.RegisterStartupScript(Page.GetType(), "LanguageSwitch", "<script> LanguageSwitch(window.parent);</script>");
            //SliderExtender2.TooltipText = ResourceManager.GetString("Lang_select_line_width");
        }

       

     

       

      
    }
}