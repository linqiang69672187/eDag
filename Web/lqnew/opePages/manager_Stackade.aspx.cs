using Ryu666.Components;
using System;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Web.lqnew.opePages
{
    public partial class manager_Stackade : BasePage
    {
        private DbComponent.IDAO.IDispatchInfoDao DispatchInfoDaoServce
        {
            get
            {
                return DbComponent.FactoryMethod.DispatchInfoFactory.CreateDispatchInfoDao();
            }
        }
        private DbComponent.IDAO.IStockadeDao StockadeDaoService
        {
            get
            {
                return DbComponent.FactoryMethod.DispatchInfoFactory.CreateStockadeDao();
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
            Lang_Search.ImageUrl = ResourceManager.GetString("Lang_Search2");
            GridView1.EmptyDataText = ResourceManager.GetString("NoData");
            GridView1.Columns[0].HeaderText = ResourceManager.GetString("Name");
            GridView1.Columns[1].HeaderText = ResourceManager.GetString("Person");
            GridView1.Columns[2].HeaderText = ResourceManager.GetString("Lang_Type");
            GridView1.Columns[3].HeaderText = ResourceManager.GetString("Identification");
            GridView1.Columns[4].HeaderText = ResourceManager.GetString("Display");
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Attributes.Add("onmouseover", "changeTgBg(this,'font',2)");
                e.Row.Attributes.Add("onmouseout", "overchangeTgBg(this,'font',2)");
                //DbComponent.Entity funEntity = new DbComponent.Entity();
                //DbComponent.group fungroup = new DbComponent.group();
                //e.Row.Cells[1].Text = "&nbsp;&nbsp;" + funEntity.GetEntityinfo_byid(int.Parse(e.Row.Cells[1].Text)).Name;
                //funEntity = null;
                if (e.Row.Cells[2].Text == ((int)MyModel.Enum.StockadeType.Polygon).ToString())
                {
                    e.Row.Cells[2].Text = ResourceManager.GetString("Lang_polygon");
                }
                if (e.Row.Cells[2].Text == ((int)MyModel.Enum.StockadeType.Rectangle).ToString())
                {
                    e.Row.Cells[2].Text = ResourceManager.GetString("Lang_square");
                }
                if (e.Row.Cells[2].Text == ((int)MyModel.Enum.StockadeType.Circle).ToString())
                {
                    e.Row.Cells[2].Text = ResourceManager.GetString("Lang_oval");
                }
                if (e.Row.Cells[2].Text == ((int)MyModel.Enum.StockadeType.Oval).ToString())
                {
                    e.Row.Cells[2].Text = ResourceManager.GetString("Lang_ellipse");
                }
                string strNames = StockadeDaoService.GetMyStockUserName(e.Row.Cells[3].Text);
                string[] arrStrName = strNames.Split(new char[] { ';' }, StringSplitOptions.RemoveEmptyEntries);
                if (arrStrName.Length > 0)
                {
                    e.Row.Cells[1].Text = arrStrName[0];
                    e.Row.Cells[1].Attributes.Add("title", strNames);
                }
                e.Row.Cells[4].Text = bool.Parse(e.Row.Cells[4].Text) ? "<img style='cursor:pointer;' onclick='hideDZSL(\"" + e.Row.Cells[3].Text + "\",this)' src='../images/isinviewyes.png'>" : "<img style='cursor:pointer;' onclick='showDZSL(\"" + e.Row.Cells[3].Text + "\",this)' src='../images/isinviewno.png'>";
            }
            LinkButton linkbtn = (LinkButton)e.Row.FindControl("ImageButton2");
            if (linkbtn != null)
            {
                linkbtn.OnClientClick = @"javascript:return confirm('" + ResourceManager.GetString("BeSureToDelete") + "['+this.parentElement.parentElement.getElementsByTagName('font')[0].innerText.trim()+']?')";
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

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            switch (e.CommandName)
            {
                case "MyDel":
                    string ID = e.CommandArgument.ToString();
                    try
                    {
                        if (StockadeDaoService.GetStockadeByDivID(ID).ID == 0)
                        {
                            Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("Lang_DeleteDataFail") + "');</script>");
                            return;
                        }

                        int myType = StockadeDaoService.GetTypeByDivID(ID);

                        if (StockadeDaoService.DeleteStockadeByDivID(ID))
                        {
                            Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>window.parent.delDZZL();alert('" + ResourceManager.GetString("OperationSuccessful") + "');window.parent.lq_changeifr('manager_Stackade');</script>");
                            //if (myType == (int)MyModel.Enum.StockadeType.Rectangle)
                            //{
                            //    Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>window.parent.DelRectangle('" + ID + "');alert('" + ResourceManager.GetString("OperationSuccessful") + "');window.parent.lq_changeifr('manager_Stackade');</script>");
                            //}
                            //if (myType == (int)MyModel.Enum.StockadeType.Polygon)
                            //{
                            //    Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>window.parent.delPolyDZSL('" + ID + "');alert('" + ResourceManager.GetString("OperationSuccessful") + "');window.parent.lq_changeifr('manager_Stackade');</script>");
                            //}
                            //if (myType == (int)MyModel.Enum.StockadeType.Oval)
                            //{
                            //    Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>window.parent.DelRectangle('" + ID + "');alert('" + ResourceManager.GetString("OperationSuccessful") + "');window.parent.lq_changeifr('manager_Stackade');</script>");
                            //}
                        }
                        else
                        {
                            Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("Operationfails") + "');</script>");
                        }
                    }
                    catch (Exception ex)
                    {
                        log.Debug(ex);
                        Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("Lang_DeleteDataFail") + "');</script>");
                    }
                    break;

                default:

                    break;
            }
        }

        protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
        {
            GridView1.PageIndex = 0;
        }






    }
}