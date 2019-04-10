using DbComponent.FactoryMethod;
using DbComponent.IDAO;
using Ryu666.Components;
using System;
using System.Text;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Web.lqnew.opePages
{
    public partial class manager_BSGroup : BasePage
    {
        private IBSGroupInfoDao BSGroupInfo
        {
            get
            {
                return DispatchInfoFactory.CreateBSGroupInfoDao();
            }
        }
        private DbComponent.Entity funEntity
        {
            get { return new DbComponent.Entity(); }

        }
        private IBaseStationDao BSD
        {
            get
            {
                return DispatchInfoFactory.CreateBaseStationDao();
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
            DropDownList1.Items[0].Text = ResourceManager.GetString("SelectEntity");
            GridView1.EmptyDataText = ResourceManager.GetString("SearchHaveNoData");
            GridView1.Columns[0].HeaderText = ResourceManager.GetString("Lang-T-BSGroupNametext");
            GridView1.Columns[1].HeaderText = ResourceManager.GetString("Subordinateunits");
            GridView1.Columns[3].HeaderText = ResourceManager.GetString("Membersgroup");
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Attributes.Add("onmouseover", "changeTgBg(this,'font',2)");
                e.Row.Attributes.Add("onmouseout", "overchangeTgBg(this,'font',2)");
                if (e.Row.Cells[3].Text == "True")
                {
                    e.Row.Cells[3].Text = "<img src='../images/call_on.png' />";
                }
                else
                {
                    e.Row.Cells[3].Text = "";
                }


                e.Row.Cells[1].Text = "&nbsp;&nbsp;" + funEntity.GetEntityinfo_byid(int.Parse(e.Row.Cells[1].Text)).Name;

                string[] GSSIs = GridView1.DataKeys[e.Row.RowIndex].Values[1].ToString().Split(new char[] { ';' }, StringSplitOptions.RemoveEmptyEntries);
                if (GSSIs.Length > 0)
                {
                    string[] firstBSISSISwitch = GSSIs[0].Split(new char[] { '{', ',','}' }, StringSplitOptions.RemoveEmptyEntries);//xzj--20181217--添加交换
                    //MyModel.Model_BaseStation mb = BSD.GetBaseStationByISSI(GSSIs[0]).StationName;
                    try
                    {
                        e.Row.Cells[3].Text = "&nbsp;&nbsp;(" + BSD.GetBaseStationByISSI(firstBSISSISwitch[1].ToString(), string.IsNullOrEmpty(firstBSISSISwitch[0].ToString()) == true ? 0 : int.Parse(firstBSISSISwitch[0].ToString())).StationName + ")" + firstBSISSISwitch[0] + "," + firstBSISSISwitch[1];
                    }
                    catch (Exception ex)
                    {
                        log.Debug(ex);
                        e.Row.Cells[3].Text = "";
                    }
                    StringBuilder titlevalue = new StringBuilder();
                    foreach (string GSSI in GSSIs)
                    {
                        try
                        {
                            string[] bsISSISwitch = GSSI.Split(new char[] { '{', ',','}' }, StringSplitOptions.RemoveEmptyEntries);//xzj--20181217--添加交换
                            titlevalue.Append("(" + BSD.GetBaseStationByISSI(bsISSISwitch[1].ToString(), string.IsNullOrEmpty(bsISSISwitch[0].ToString()) == true ? 0 : int.Parse(bsISSISwitch[0].ToString())).StationName + ")" + bsISSISwitch[0] + "," + bsISSISwitch[1] + "\n");
                        }
                        catch (Exception ex)
                        {
                            log.Debug(ex);
                        }
                    }
                    e.Row.Cells[3].Attributes.Add("title", titlevalue.ToString().Trim());
                    e.Row.Cells[3].Attributes.Add("style", "cursor:hand;");
                    titlevalue.Clear();
                }

                // funEntity = null;
                // funGroup = null;
                LinkButton linkbtn = (LinkButton)e.Row.FindControl("ImageButton2");
                if (linkbtn != null)
                {
                    linkbtn.ToolTip = ResourceManager.GetString("DelTheEntity");
                    linkbtn.OnClientClick = @"javascript:window.document.getElementById('Lang_AddNew').src = window.parent.GetTextByName('Lang_AddNew', window.parent.useprameters.languagedata);return confirm('" + ResourceManager.GetString("BeSureToDel") + "['+this.parentElement.parentElement.getElementsByTagName('font')[0].innerText.trim()+']?')";
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
                    if (BSGroupInfo.GetBSGroupInfoByID(ID) == null)
                    {
                        Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>window.document.getElementById('Lang_AddNew').src = window.parent.GetTextByName('Lang_AddNew', window.parent.useprameters.languagedata);alert('" + ResourceManager.GetString("Delfailmanager_BSgroup") + "');</script>");
                        return;
                    }

                    if (BSGroupInfo.Delete(ID))
                    {
                        Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>window.document.getElementById('Lang_AddNew').src = window.parent.GetTextByName('Lang_AddNew', window.parent.useprameters.languagedata);alert('" + ResourceManager.GetString("OperationSuccessful") + "');window.parent.lq_changeifr('manager_BSGroup');</script>");
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

        protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
        {
            GridView1.PageIndex = 0;
        }

    }
}