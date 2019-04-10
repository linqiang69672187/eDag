using Ryu666.Components;
using System;

namespace Web.lqnew.opePages
{
    public partial class ShowRTByCtrlPanl : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            btnnew.Text = ResourceManager.GetString("Add_New");
        }
    }
}