using System;
using System.Web.UI;

namespace Web.lqnew.opePages.view_info
{
    public partial class view_FixedStation : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack && Request.QueryString["id"] != null)
            {
                DbComponent.FS_Info.FixedStation bsd = new DbComponent.FS_Info.FixedStation();
                DbComponent.FS_Info.Model_FixedStation mbs = new DbComponent.FS_Info.Model_FixedStation();
                mbs = bsd.GetFixedStationByID(int.Parse(Request.QueryString["id"]));
                tab.Rows[0].Cells[1].InnerHtml = "&nbsp;&nbsp" + mbs.StationISSI;
                tab.Rows[1].Cells[1].InnerHtml = "&nbsp;&nbsp;" + mbs.Entity_ID.ToString();
                tab.Rows[2].Cells[1].InnerHtml = "&nbsp;&nbsp;" + mbs.GSSIS;
                tab.Rows[3].Cells[1].InnerHtml = "&nbsp;&nbsp;" + mbs.Lo.ToString();
                tab.Rows[4].Cells[1].InnerHtml = "&nbsp;&nbsp;" + mbs.La.ToString();
            }

        }
    }
}