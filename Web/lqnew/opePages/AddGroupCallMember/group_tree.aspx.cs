using System;

namespace Web.lqnew.opePages.AddGroupCallMember
{
    public partial class group_tree : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            DbComponent.AddMemberTree myissitree = new DbComponent.AddMemberTree(Request.Cookies["id"].Value, new string[] { MyModel.Enum.TreeType.Group.ToString() });
            myissitree.createtreebegion(TreeView1);
        }
    }
}