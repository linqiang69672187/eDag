using System;

namespace Web.lqnew.opePages
{
    public partial class Error : System.Web.UI.Page
    {
        protected string openFrameName = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string errorPath = Request["aspxerrorpath"].ToString();
                string[] str = errorPath.Split('/');
                openFrameName = str[str.Length - 1].Substring(0, str[str.Length - 1].Length - 5);
            }
        }
    }
}