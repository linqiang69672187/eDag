using Ryu666.Components;
using System;
using System.Transactions;
using System.Web.UI;
using System.Web.UI.WebControls;
namespace Web.lqnew.opePages
{
    public partial class manager_entity : BasePage
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            Page.ClientScript.RegisterStartupScript(Page.GetType(), "LanguageSwitch", "<script>LanguageSwitch(window.parent);</script>");

            DropDownList1.Items[0].Text = ResourceManager.GetString("Lang_SelectHigher");
            GridView1.EmptyDataText = ResourceManager.GetString("NoData");
            GridView1.Columns[0].HeaderText = ResourceManager.GetString("EntityName");
            GridView1.Columns[1].HeaderText = ResourceManager.GetString("ParentUnit");
            GridView1.Columns[2].HeaderText = ResourceManager.GetString("Entity_Depth");
            Lang_Search.ImageUrl = ResourceManager.GetString("Lang_Search2");
            if (!Page.IsPostBack)
            {
                if (System.Configuration.ConfigurationManager.AppSettings["OpenWindow"] == "1")
                {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "resizediv", "<script>  window.parent.lq_changeheight(geturl(), document.body.clientHeight);window.parent.change(geturl());</script>");
                }

            }
            else
            {
                if (System.Configuration.ConfigurationManager.AppSettings["OpenWindow"] == "1")
                {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "resizediv", "<script>  window.parent.lq_changeheight(geturl(), document.body.clientHeight);</script>");
                }

            }
            DbComponent.Entity entity = new DbComponent.Entity();
            int entity_depth = entity.GetEntityIndex(int.Parse(Request.Cookies["id"].Value));
            if (entity_depth != 0 && entity_depth != -1) //非一级单位
            {
                GridView1.Columns[3].Visible = false;
                GridView1.Columns[4].Visible = false;
                GridView1.Columns[5].Visible = false;
                Label1.Visible = false;
            }
            if (DropDownList1.Items.Count == 0)
            {
                ListItem list = new ListItem();
                list.Value = "0,0";
                list.Text = ResourceManager.GetString("FirstClassEntity");
                DropDownList1.Items.Add(list);
            }
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {

                e.Row.Attributes.Add("onmouseover", "changeTgBg(this,'font',3)");
                e.Row.Attributes.Add("onmouseout", "overchangeTgBg(this,'font',3)");
                //e.Row.Cells[0].Text = "&nbsp;&nbsp;" + e.Row.Cells[0].Text;
                if (e.Row.Cells[1].Text != "0" && e.Row.Cells[2].Text != "0")
                {
                    DbComponent.Entity funEntity = new DbComponent.Entity();
                    e.Row.Cells[1].Text = "&nbsp;&nbsp;" + funEntity.GetEntityinfo_byid(int.Parse(e.Row.Cells[1].Text)).Name;
                    funEntity = null;

                }
                else
                {
                    e.Row.Cells[1].Text = "&nbsp;&nbsp;" + ResourceManager.GetString("Lang-None");
                }

                e.Row.Cells[2].Text = (int.Parse(e.Row.Cells[2].Text) + 1).ToString();
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
                System.Web.UI.HtmlControls.HtmlImage img3 = (System.Web.UI.HtmlControls.HtmlImage)e.Row.FindControl("img_add");
                if (img3 != null)
                {
                    img3.Attributes.Add("title", ResourceManager.GetString("Lang_Add_SubordinateUnit"));
                }
                
            }
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            switch (e.CommandName)
            {
                case "MyDel":

                    DbComponent.Entity funEntity = new DbComponent.Entity();
                    int ParentID = int.Parse(e.CommandArgument.ToString());
                    if (funEntity.GetEntityinfo_byid(ParentID).id == 0)
                    {
                        Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("DelFail_NotExist") + "');</script>");
                        return;
                    }

                    string divid = funEntity.GetDivIDbyID(ParentID);
                    string err = "";

                    string strMarker;

                    if (System.Configuration.ConfigurationManager.AppSettings["defaultLanguage"] == "zh-CN")
                    {
                        strMarker = "☆";
                    }
                    else
                    {
                        strMarker = "#";
                    }

                    #region 检查是否为一级单位，含有单位，关联编组，关联移动用户，关联调度员，关联终端
                    try
                    {
                        if (funEntity.GetEntityIndex(ParentID) == 0) //是否为一级单位
                        {
                            err += "\\n        " + strMarker + ResourceManager.GetString("BasicEntityBeNotDel");
                        }
                    }
                    catch (Exception ex)
                    {
                        log.Debug(ex);
                        return;
                    }
                    if (funEntity.EntityCount_byParentID(ParentID) > 0)//检查该单位是否有下属单位
                    {
                        err += "\\n        " + strMarker + ResourceManager.GetString("ContainEntityBeNotDel");
                    }
                    if (funEntity.EntityContainsGroup(ParentID) > 0)//检查该单位是否有关联的编组
                    {
                        err += "\\n        " + strMarker + ResourceManager.GetString("EntityContainsGroup");
                    }
                    if (funEntity.EntityContainsUser(ParentID) > 0)// 检查该单位是否有关联的移动用户
                    {
                        err += "\\n        " + strMarker + ResourceManager.GetString("EntityContainsUser");
                    }
                    if (funEntity.EntityContainslogin(ParentID) > 0)//检查该单位是否有关联的调度员
                    {
                        err += "\\n        " + strMarker + ResourceManager.GetString("EntityContainslogin");
                    }
                    if (funEntity.EntityContainsISSI(ParentID) > 0)//检查该单位是否有关联的终端
                    {
                        err += "\\n        " + strMarker + ResourceManager.GetString("EntityContainsISSI");
                    }
                    if (funEntity.EntityContainsDispatch(ParentID) > 0)
                    {
                        err += "\\n        " + strMarker + ResourceManager.GetString("EntityContainsDispatch");
                    }
                    if (funEntity.EntityContainsBaseStationGroup(ParentID) > 0)
                    {
                        err += "\\n        " + strMarker + ResourceManager.GetString("EntityContainsBaseStationGroup");
                    }
                    int entity_depth_del = funEntity.GetEntityIndex(int.Parse(Request.Cookies["id"].Value));
                    if (entity_depth_del != 0 && entity_depth_del != -1) //非一级调度员
                    {
                        err += "\\n        " + strMarker + ResourceManager.GetString("NOTbasicentity");
                    }

                    #endregion
                    if (err == "")
                    {
                        #region 启用事务删除GIS，历史GIS，单位信息
                        using (TransactionScope scope = new TransactionScope())
                        {
                            DbComponent.Gis gis = new DbComponent.Gis();
                            try
                            {
                                gis.DelGis(ParentID);
                                gis.DelHistoryGis(ParentID);
                                funEntity.DelEntityinfo_byid(ParentID);
                                scope.Complete();
                                Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("OperationSuccessful") + "');window.parent.reloadtree();window.parent.psLayerManager.removePoliceSation({'ID':'" + ParentID + "'});window.parent.lq_changeifr('manager_entity');</script>");
                            }
                            catch (Exception ex)
                            {
                                log.Debug(ex);
                                Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("Operationfails") + "');</script>");
                            }
                        }
                        #endregion
                    }
                    else
                    {
                        Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("Operationfails") + ":" + err + "');</script>");
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