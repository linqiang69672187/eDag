using Ryu666.Components;
using System;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Web.lqnew.opePages
{
    public partial class manager_BaseStation : System.Web.UI.Page
    {
        private DbComponent.IDAO.IBaseStationDao BaseStationDaoServce
        {
            get
            {
                return DbComponent.FactoryMethod.DispatchInfoFactory.CreateBaseStationDao();
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                if (System.Configuration.ConfigurationManager.AppSettings["OpenWindow"] == "1")
                {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "resizediv", "<script>  window.parent.lq_changeheight(geturl(), document.body.clientHeight);window.parent.change(geturl());</script>");
                }
                if (Request.QueryString["id"] != null)
                {
                    userul.Visible = false;
                }
            }
            else
            {
                if (System.Configuration.ConfigurationManager.AppSettings["OpenWindow"] == "1")
                {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "resizediv", "<script>  window.parent.lq_changeheight(geturl(), document.body.clientHeight);</script>");
                }
            }
            GridView1.EmptyDataText = ResourceManager.GetString("NoData");
         GridView1.Columns[0].HeaderText = ResourceManager.GetString("switchID");//xzj--20181215--添加交换表头
            GridView1.Columns[1].HeaderText = ResourceManager.GetString("StationName");
            GridView1.Columns[2].HeaderText = ResourceManager.GetString("BaseStationIdentification");
            GridView1.Columns[3].HeaderText = ResourceManager.GetString("Longitude");
            GridView1.Columns[4].HeaderText = ResourceManager.GetString("Latitude");
            GridView1.Columns[5].HeaderText = ResourceManager.GetString("UnderGroundBS");
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Attributes.Add("onmouseover", "changeTgBg(this,'font',2)");
                e.Row.Attributes.Add("onmouseout", "overchangeTgBg(this,'font',2)");
                DbComponent.IDAO.IBaseStationDao BSServce=DbComponent.FactoryMethod.DispatchInfoFactory.CreateBaseStationDao();
                int bsId = int.Parse(GridView1.DataKeys[e.Row.RowIndex].Value.ToString());
                MyModel.Model_BaseStation bs = BSServce.GetBaseStationByID(bsId);
                e.Row.Cells[5].Text = bs.IsUnderGround.ToString() == "1" ? ResourceManager.GetString("Lang_Yes") : ResourceManager.GetString("Lang_No");
                LinkButton linkbtn = (LinkButton)e.Row.FindControl("ImageButton2");
                if (linkbtn != null)
                {
                    linkbtn.OnClientClick = @"javascript:window.document.getElementById('Lang_AddNew').src = window.parent.GetTextByName('Lang_AddNew', window.parent.useprameters.languagedata);return confirm('" + ResourceManager.GetString("BeSureToDelete") + "['+this.parentElement.parentElement.getElementsByTagName('font')[0].innerText.trim()+']?')";
                }
                System.Web.UI.HtmlControls.HtmlImage img = (System.Web.UI.HtmlControls.HtmlImage)e.Row.FindControl("img_del");
                if (img != null)
                {
                    img.Attributes.Add("title", ResourceManager.GetString("Delete"));
                }
                System.Web.UI.HtmlControls.HtmlImage img2 = (System.Web.UI.HtmlControls.HtmlImage)e.Row.FindControl("img_modify");
                if (img2 != null)
                {
                    img2.Attributes.Add("title", ResourceManager.GetString("Modify"));
                }
            }
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            switch (e.CommandName)
            {
                case "MyDel":
                    int ID = int.Parse(e.CommandArgument.ToString());
                    MyModel.Model_BaseStation bs = BaseStationDaoServce.GetBaseStationByID(ID);
                    if (bs == null)
                    {
                        Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>window.document.getElementById('Lang_AddNew').src = window.parent.GetTextByName('Lang_AddNew', window.parent.useprameters.languagedata);alert('" + ResourceManager.GetString("Lang_DeleteDataFail") + "');</script>");
                        return;
                    }

                    string MBS = bs.DivID;

                    //需验证此基站是否是某些基站组成员 是 则不能删除 否 则删除
                    //TODO
                    if (BaseStationDaoServce.IsInBSGroup(bs.StationISSI, bs.SwitchID))//xzj--20181217--添加交换
                    {
                        Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>window.document.getElementById('Lang_AddNew').src = window.parent.GetTextByName('Lang_AddNew', window.parent.useprameters.languagedata);alert('" + ResourceManager.GetString("Lang_DeletFailHaveBaseStaion") + "');</script>");
                        return;
                    }

                    if (BaseStationDaoServce.DeleteBaseStation(ID))
                    {

                        Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>window.document.getElementById('Lang_AddNew').src = window.parent.GetTextByName('Lang_AddNew', window.parent.useprameters.languagedata);alert('" + ResourceManager.GetString("OperationSuccessful") + "');window.parent.lq_changeifr('manager_BaseStation');window.parent.bsLayerManager.removeBaseStaionFeature({'ID':'" + ID + "'})</script>");
                    }
                    else
                    {
                        Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>window.document.getElementById('Lang_AddNew').src = window.parent.GetTextByName('Lang_AddNew', window.parent.useprameters.languagedata);alert('" + ResourceManager.GetString("Operationfails") + "');</script>");
                    }
                    break;

                default:

                    break;
            }
        }
    }
}