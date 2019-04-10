using System;
using System.Web.UI;

namespace Web.lqnew.opePages.AddPPCCallMember
{
    public partial class ISSI_tree : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
            if (!Page.IsPostBack)
            {
                DbComponent.AddMemberTree myissitree = new DbComponent.AddMemberTree(Request.Cookies["id"].Value, new string[] { MyModel.Enum.TreeType.ISSI.ToString() });
                myissitree.createtreebegion(TreeView1);
            }
         
        }


    }
}