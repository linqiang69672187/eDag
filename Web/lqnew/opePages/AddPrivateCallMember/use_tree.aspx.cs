using DbComponent;
using MyModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;

namespace Web.lqnew.opePages.AddPrivateCallMember
{
    public partial class use_tree : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                UserTypeDao utdao = new UserTypeDao();
                IList<Model_UserType> list = utdao.GetAllForList();
                IList<string> slist = new List<string>();
                foreach (Model_UserType mut in list)
                {
                    slist.Add(mut.TypeName);
                }


                DbComponent.AddMemberTree myissitree = new DbComponent.AddMemberTree(Request.Cookies["id"].Value, slist.ToArray());
                myissitree.createtreebegion(TreeView1);
            }
        }
    }
}