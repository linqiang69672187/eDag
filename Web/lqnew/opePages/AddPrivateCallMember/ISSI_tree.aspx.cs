using System;
using System.Web.UI;

namespace Web.lqnew.opePages.AddPrivateCallMember
{
    public partial class ISSI_tree : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
            if (!Page.IsPostBack)
            {
                DbComponent.AddMemberTree myissitree = new DbComponent.AddMemberTree(Request.Cookies["id"].Value, new string[] { MyModel.Enum.TreeType.ISSI.ToString() });//"终端" 
                myissitree.createtreebegion(TreeView1);
            }
         
        }


    }
}