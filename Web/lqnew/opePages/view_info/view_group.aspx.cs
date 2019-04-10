using System;
using System.Web.UI;
using Ryu666.Components;

namespace Web.lqnew.opePages.view_info
{
    public partial class view_group : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack&&Request.QueryString["id"]!=null)
            {
                DbComponent.group MYgroup = new DbComponent.group();
                MyModel.Model_group group_detail = new MyModel.Model_group();
                DbComponent.Entity MYEntity = new DbComponent.Entity();
                group_detail = MYgroup.GetGroupinfo_byid(int.Parse(Request.QueryString["id"]));
                tb1.Rows[0].Cells[1].InnerHtml = "&nbsp;&nbsp;" + group_detail.Group_name;
                tb1.Rows[1].Cells[1].InnerHtml = "&nbsp;&nbsp;" + group_detail.TypeName;
                tb1.Rows[2].Cells[1].InnerHtml = "&nbsp;&nbsp;" + MYEntity.GetEntityinfo_byid(int.Parse(group_detail.Entity_ID)).Name;
                tb1.Rows[3].Cells[1].InnerHtml = "&nbsp;&nbsp;" + group_detail.GSSI;
                string yes = ResourceManager.GetString("Lang_Yes");
                string no = ResourceManager.GetString("Lang_No");
                tb1.Rows[4].Cells[1].InnerHtml = (group_detail.isExternal == 1) ? "&nbsp;&nbsp;" + yes : "&nbsp;&nbsp;" + no;
                tb1.Rows[5].Cells[1].InnerHtml = (group_detail.status == true) ? "&nbsp;&nbsp;" + yes : "&nbsp;&nbsp;" + no; 

            }
     
        }
    }
}