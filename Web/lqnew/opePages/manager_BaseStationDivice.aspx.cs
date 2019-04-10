using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Ryu666.Components;
using DbComponent.FactoryMethod;
using DbComponent.IDAO;
using MyModel;

namespace Web.lqnew.opePages
{
    public partial class manager_BaseStationDivice : BasePage
    {

        private IBaseStationDao BaseStationService
        {
            get
            {
                return DispatchInfoFactory.CreateBaseStationDao();
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            GridView1.EmptyDataText = ResourceManager.GetString("NoData");
            GridView1.Columns[0].HeaderText = ResourceManager.GetString("Lang_BaseStationIdentification");//StationISSI";
            GridView1.Columns[1].HeaderText = ResourceManager.GetString("Lang_StationName");//基站名称
            GridView1.Columns[2].HeaderText = ResourceManager.GetString("Lang_terminal_identification");//终端号码
            GridView1.Columns[3].HeaderText = ResourceManager.GetString("Username");//姓名
            GridView1.Columns[4].HeaderText = ResourceManager.GetString("Lang_Serialnumber");//编号
            GridView1.Columns[5].HeaderText = ResourceManager.GetString("Type");//类型
            GridView1.Columns[6].HeaderText = ResourceManager.GetString("Lang_IdentityID");//移动用户ID
            GridView1.Columns[7].HeaderText = ResourceManager.GetString("Lang_Locationtext");//定位
            GridView1.EmptyDataText = ResourceManager.GetString("NoData");
            string bsName = ResourceManager.GetString("Lang_StationName");//基站名称
            string jingDu = ResourceManager.GetString("Longitude");
            string weidu = ResourceManager.GetString("Latitude");
            string regTerminal = ResourceManager.GetString("terminal_device");
            string bsid = "-1";      
            int switchID = 0;//xzj--20181217--添加交换
            if (!Page.IsPostBack)
            {
                if (System.Configuration.ConfigurationManager.AppSettings["OpenWindow"] == "1")
                {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "resizediv",
                        "<script>  window.parent.lq_changeheight(geturl(), document.body.clientHeight);window.parent.change(geturl());</script>");
                }
                if (Request["bsid"] != null && Request["switchID"] != "")//xzj--20190213--添加“”判断
                {
                    bsid = Request["bsid"].ToString();
                }
                if (Request["switchID"] != null && Request["switchID"] != "")//xzj--20190213--添加“”判断
                {
                    switchID = int.Parse(Request["switchID"].ToString());
                }
                ObjectDataSource1.SelectParameters.Add(new Parameter("bsid", TypeCode.String, bsid));
                ObjectDataSource1.SelectParameters.Add(new Parameter("switchID", TypeCode.Int32, switchID.ToString()));

                Model_BaseStation MBS = BaseStationService.GetBaseStationByISSI(bsid, switchID);//xzj--20181217--添加交换
                int count = BaseStationService.getAllBsDeviceCount(bsid, switchID);
                string strBsDetail = bsName + ":" + MBS.StationName + "&nbsp;&nbsp;&nbsp;&nbsp;" + jingDu + ":" + MBS.Lo.ToString() + ", " + weidu + ":" + MBS.La.ToString();
                BsInfo.Text = strBsDetail + "&nbsp;&nbsp;&nbsp;&nbsp;" + regTerminal+ ":" + count;

            }
            else
            {
                if (System.Configuration.ConfigurationManager.AppSettings["OpenWindow"] == "1")
                {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "resizediv",
                        "<script>  window.parent.lq_changeheight(geturl(), document.body.clientHeight);</script>");
                    //Page.ClientScript.RegisterStartupScript(Page.GetType(), "resizediv",
                    //    "<script> parent.lq_changeheight(geturl(),)</script> ");
                }
            }

        }
        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                string nodata = ResourceManager.GetString("Nodata");
                e.Row.Attributes.Add("onmouseover", "changeTgBg(this,'font',2)");
                e.Row.Attributes.Add("onmouseout", "overchangeTgBg(this,'font',2)");

                e.Row.Cells[7].Text += "&nbsp;&nbsp;";

                if (e.Row.Cells[6].Text.Trim() != null && e.Row.Cells[6].Text.Trim() != "" && e.Row.Cells[6].Text.Trim() != "&nbsp;")
                {
                    string userid = e.Row.Cells[6].Text.Trim();
                    e.Row.Cells[7].Text = "<img src='../../images/xz.gif' style='cursor: hand;' onclick='window.parent.locationbyUseid("
                    + userid + ");'/>";
                    // e.Row.Cells[6].Text = type;


                }


            }


        }
        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {
            ;
        }
    }
}