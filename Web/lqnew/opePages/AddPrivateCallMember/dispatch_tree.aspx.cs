using System;
using System.Web.UI;

namespace Web.lqnew.opePages.AddPrivateCallMember
{
    public partial class dispatch_tree : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
            if (!Page.IsPostBack)
            {
               
                DbComponent.AddMemberTree myissitree = new DbComponent.AddMemberTree(Request.Cookies["id"].Value, new string[] { MyModel.Enum.TreeType.Dispatch.ToString() });//"调度台"
                myissitree.createtreebegion(TreeView1);
            }
         
        }


    }
}