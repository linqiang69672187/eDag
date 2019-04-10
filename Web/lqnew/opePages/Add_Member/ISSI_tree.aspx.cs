using Ryu666.Components;
using System;
using System.Web.UI;

namespace Web.lqnew.opePages.Add_Member
{
    public partial class ISSI_tree : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
            if (!Page.IsPostBack)
            {
                string Lang_Terminal = ResourceManager.GetString("Lang_Terminal");
                DbComponent.AddMemberTree myissitree = new DbComponent.AddMemberTree(Request.Cookies["id"].Value, new string[] { MyModel.Enum.TreeType.ISSI.ToString() });
                myissitree.createtreebegion(TreeView1);
            }
         
        }


    }
}