using System;
using System.Web.UI;

namespace Web.lqnew.opePages.Add_Member
{
    public partial class dispatch_tree : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
            if (!Page.IsPostBack)
            {
                //string Lang_Dispatch = ResourceManager.GetString("Lang_Dispatch");
                DbComponent.AddMemberTree myissitree = new DbComponent.AddMemberTree(Request.Cookies["id"].Value, new string[] { MyModel.Enum.TreeType.Dispatch.ToString() });
                myissitree.createtreebegion(TreeView1);
            }
         
        }


    }
}