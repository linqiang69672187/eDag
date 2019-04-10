using System;
using System.Web.UI;

namespace Web.lqnew.opePages.view_info
{
    public partial class view_BaseStation : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack&&Request.QueryString["id"]!=null)
            {
                DbComponent.BaseStationDao bsd = new DbComponent.BaseStationDao();
           
                MyModel.Model_BaseStation mbs = new MyModel.Model_BaseStation();
                mbs = bsd.GetBaseStationByID(int.Parse(Request.QueryString["id"]));
               tb1.Rows[0].Cells[1].InnerHtml = "&nbsp;&nbsp;" + mbs.SwitchID;//xzj--20181217
                tb1.Rows[1].Cells[1].InnerHtml = "&nbsp;&nbsp;" + mbs.StationName;
                tb1.Rows[2].Cells[1].InnerHtml = "&nbsp;&nbsp" + mbs.StationISSI;
                tb1.Rows[3].Cells[1].InnerHtml = "&nbsp;&nbsp;" + mbs.Lo.ToString();
                tb1.Rows[4].Cells[1].InnerHtml = "&nbsp;&nbsp;" + mbs.La.ToString();
 
            }
     
        }
    }
}