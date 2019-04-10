using MyModel.Enum;
using System;
using System.Web.UI;

namespace Web.lqnew.opePages.view_info
{
    public partial class view_Stackade : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack && Request.QueryString["id"] != null)
            {
                DbComponent.group MYgroup = new DbComponent.group();
                MyModel.Model_Stockade Stockade = new MyModel.Model_Stockade();
                DbComponent.Entity MYEntity = new DbComponent.Entity();
                Stockade = MYgroup.GetStackadeGroupinfo_byid(int.Parse(Request.QueryString["id"]));
                tb1.Rows[0].Cells[1].InnerHtml = "&nbsp;&nbsp;" + Stockade.LoginName;
                tb1.Rows[1].Cells[1].InnerHtml = "&nbsp;&nbsp;" + Stockade.Title;
                tb1.Rows[2].Cells[1].InnerHtml = "&nbsp;&nbsp;" + Stockade.CreateTime.ToString();

                tb1.Rows[3].Cells[1].InnerHtml = "&nbsp;&nbsp;" + StockadeTypeS.getTpye(Stockade.Type);
                tb1.Rows[4].Cells[1].InnerHtml = "&nbsp;&nbsp;" + Stockade.DivID;
                //string[] GSSIS = group_detail.GSSIS.Split(new char[] { ';' }, StringSplitOptions.RemoveEmptyEntries);
                //StringBuilder cgvalue = new StringBuilder();
                //foreach (var item in GSSIS)
                //{ cgvalue.Append(MYgroup.GetGroupGroupname_byGSSI(item) + "," + item + "|"); }
                //tbtbz.InnerHtml = LQCommonCS.ISSI.CreateGroupTB(cgvalue.ToString().Split('|'));
            }
        }
    }
}