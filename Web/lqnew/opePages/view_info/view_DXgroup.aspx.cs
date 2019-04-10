using System;
using System.Text;
using System.Web.UI;

namespace Web.lqnew.opePages.view_info
{
    public partial class view_DXgroup : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack && Request.QueryString["id"] != null)
            {
                DbComponent.group MYgroup = new DbComponent.group();
                MyModel.Model_group group_detail = new MyModel.Model_group();
                DbComponent.Entity MYEntity = new DbComponent.Entity();
                group_detail = MYgroup.GetPJDXGroupinfo_byid(int.Parse(Request.QueryString["id"]));
                tb1.Rows[0].Cells[1].InnerHtml = "&nbsp;&nbsp;" + group_detail.Group_name;
                tb1.Rows[1].Cells[1].InnerHtml = "&nbsp;&nbsp;" + MYEntity.GetEntityinfo_byid(int.Parse(group_detail.Entity_ID)).Name;
                //tb1.Rows[2].Cells[1].InnerHtml = "&nbsp;&nbsp;" + group_detail.GSSI;
                //tb1.Rows[3].Cells[1].InnerHtml = (group_detail.status == true) ? "&nbsp;&nbsp;是" : "&nbsp;&nbsp;否";
                string[] GSSIS = group_detail.GSSIS.Split(new char[] { ';' }, StringSplitOptions.RemoveEmptyEntries);
                StringBuilder cgvalue = new StringBuilder();
                foreach (var item in GSSIS)
                { cgvalue.Append(MYgroup.GetGroupGroupname_byGSSI(item) + "," + item + "|"); }
                tbtbz.InnerHtml = LQCommonCS.ISSI.CreateGroupTB(cgvalue.ToString().Split('|'));
            }
        }
    }
}