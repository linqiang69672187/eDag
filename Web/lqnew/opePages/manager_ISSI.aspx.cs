using DbComponent;
using Ryu666.Components;
using System;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Transactions;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Web.lqnew.opePages
{
    public partial class manager_ISSI : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Page.ClientScript.RegisterStartupScript(Page.GetType(), "LanguageSwitch", "<script>LanguageSwitch(window.parent);</script>");
            DropDownList1.Items[0].Text = ResourceManager.GetString("SelectEntity");
            GridView1.EmptyDataText = ResourceManager.GetString("NoData");
            GridView1.Columns[0].HeaderText = ResourceManager.GetString("Lang_terminal_identification");
            GridView1.Columns[1].HeaderText = ResourceManager.GetString("Lang_TerminalType");
            GridView1.Columns[2].HeaderText = ResourceManager.GetString("Lang_Subordinateunits");
            GridView1.Columns[3].HeaderText = ResourceManager.GetString("Lang_zhuliuzu");
            GridView1.Columns[4].HeaderText = ResourceManager.GetString("Lang_saomiaozu");
            GridView1.Columns[5].HeaderText = ResourceManager.GetString("Lang_multicastgroup");
            GridView1.Columns[6].HeaderText = ResourceManager.GetString("external_system");
            Lang_Search2.ImageUrl = ResourceManager.GetString("Lang_Search2");
            Lang_ExternalTerminal.ImageUrl = ResourceManager.GetString("Lang_ExternalTerminal");
           
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
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
               // e.Row.Cells[7].ToolTip = ResourceManager.GetString("Lang_DeleteISSI");

                e.Row.Attributes.Add("onmouseover", "changeTgBg(this,'font',2)");
                e.Row.Attributes.Add("onmouseout", "overchangeTgBg(this,'font',2)");
                e.Row.Cells[1].Text = "&nbsp;&nbsp;" + ResourceManager.GetString(e.Row.Cells[1].Text.Trim());

                DbComponent.Entity funEntity = new DbComponent.Entity();
                DbComponent.group fungroup = new DbComponent.group();
                e.Row.Cells[2].Text = "&nbsp;&nbsp;" + funEntity.GetEntityinfo_byid(int.Parse(e.Row.Cells[2].Text)).Name;
                funEntity = null;
                
                
                string[] GSSIS = GridView1.DataKeys[e.Row.RowIndex][1].ToString().Replace("<", "").Split(new string[] { ">" }, StringSplitOptions.RemoveEmptyEntries);
                string none = ResourceManager.GetString("Lang-None");
                var zlz = from item in GSSIS where item.Contains("z") orderby item select item;
                foreach (var item in zlz)
                {
                    if (item.TrimStart('z') != none && item.TrimStart('z') != "0" && item.TrimStart('z') != "") // (item.TrimStart('z') != "无")
                    { e.Row.Cells[3].Text = "&nbsp;(" + fungroup.GetGroupGroupname_byGSSI(item.TrimStart('z')) + ")" + item.TrimStart('z'); }
                    else
                    { e.Row.Cells[3].Text = "&nbsp;"+none; }
                }

                //扫描组开始
                var smz = from item in GSSIS where item.Contains("s") orderby item select item;
                int nsmz = 0;
                StringBuilder titlevalue = new StringBuilder();
                StringBuilder value = new StringBuilder();
                foreach (var item in smz)
                {
                    if (nsmz == 0)
                    { value.Append("(" + fungroup.GetGroupGroupname_byGSSI(item.TrimStart('s')) + ")" + item.TrimStart('s')); }
                    nsmz += 1;
                    titlevalue.Append("(" + fungroup.GetGroupGroupname_byGSSI(item.TrimStart('s')) + ")" + item.TrimStart('s') + "\n");
                }
                e.Row.Cells[4].Text = (nsmz > 1) ? value.ToString() + "&nbsp;..." : value.ToString();
                e.Row.Cells[4].Attributes.Add("title", titlevalue.ToString().Trim());
                e.Row.Cells[4].Attributes.Add("style", "cursor:hand;padding:4px;");
                //扫描组结束

                //通播组开始
                smz = from item in GSSIS where item.Contains("t") orderby item select item;
                nsmz = 0;
                titlevalue.Clear();
                value.Clear();
                foreach (var item in smz)
                {
                    if (nsmz == 0)
                    { value.Append("(" + fungroup.GetGroupGroupname_byGSSI(item.TrimStart('t')) + ")" + item.TrimStart('t')); }
                    nsmz += 1;
                    //titlevalue.Append(fungroup.GetGroupGroupname_byGSSI(item.TrimStart('t'))+item.TrimStart('t') + "\n");
                    titlevalue.Append("(" + fungroup.GetGroupGroupname_byGSSI(item.TrimStart('t')) + ")" + item.TrimStart('t') + "\n");
                }
                e.Row.Cells[5].Text = (nsmz > 1) ? value.ToString() + "&nbsp;..." : value.ToString();
                e.Row.Cells[5].Attributes.Add("title", titlevalue.ToString().Trim());
                e.Row.Cells[5].Attributes.Add("style", "cursor:hand;padding:4px;");
                //通播组结束
                /*
                if (e.Row.Cells[2].Text == "True")
                {
                    e.Row.Cells[2].Text = "<img src='../images/call_on.png' />";
                }
                else
                {
                    e.Row.Cells[2].Text = "";
                }
                 */
                //if (e.Row.Cells[6].Text.Length > 10)
                //{
                //    e.Row.Cells[6].Text = e.Row.Cells[6].Text.Substring(0, 8) + "...";
                //    e.Row.Cells[6].Attributes.Add("title", e.Row.Cells[6].Text);
                //    e.Row.Cells[6].Attributes.Add("style", "cursor:hand;padding:4px;");
                //}
                 

                if(e.Row.Cells[6].Text=="1")
                {
                e.Row.Cells[6].Text = "&nbsp;&nbsp;" + ResourceManager.GetString("Lang_Yes");
                }
                else
                {
                    e.Row.Cells[6].Text = "&nbsp;&nbsp;" + ResourceManager.GetString("Lang_No");
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
                    DbComponent.ISSI funissi = new DbComponent.ISSI();
                    int ID = int.Parse(e.CommandArgument.ToString());
                    if (funissi.GetISSIinfo_byid(ID).id == 0)
                    {
                        Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>window.document.getElementById('Lang_AddNew').src = window.parent.GetTextByName('Lang_AddNew', window.parent.useprameters.languagedata);alert('" + ResourceManager.GetString("Lang_DeleteISSFail") + "');</script>");
                        return;
                    }

                    string err = "";
                    //if (funissi.ISSIstatus_byid(ID) > 0)
                    //{
                    //    err += "\\n        ☆" + ResourceManager.GetString("ISSIinCall"); 
                    //}

                    if (err == "")
                    {
                        #region 启用事务移动用户中释放终端，删除即时GIS信息，删除历史GIS信息，删除该终端,删除动态重组组信息(还未做)
                        using (TransactionScope scope = new TransactionScope())
                        {
                            DbComponent.Gis gis = new DbComponent.Gis();
                            try
                            {
                                object obj = SQLHelper.ExecuteScalar(CommandType.Text, "select count(*) from User_info WHERE [ISSI] = (SELECT top 1 [ISSI] FROM [ISSI_info] where id=@id)", new SqlParameter("id", ID));
                                if (Convert.ToInt32(obj) > 0)
                                {
                                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("Lang_DeleteISSFailBound") + "');</script>");
                                    return;
                                }

                                //删除该终端关联的所有动态重组组的信息(还未做)
                                //SQLHelper.ExecuteNonQuery(CommandType.Text, "UPDATE [User_info] SET [ISSI] = '' WHERE [ISSI] = (SELECT top 1 [ISSI] FROM [ISSI_info] where id=@id)", new SqlParameter("id", ID));//从移动用户中释放终端
                                SQLHelper.ExecuteNonQuery(CommandType.Text, "DELETE FROM [GIS_info] WHERE [ISSI]=(SELECT top 1 [ISSI] FROM [ISSI_info] where id=@id)", new SqlParameter("id", ID));//删除该终端即时GIS信息
                                //放到触发器里面去处理，不然数据过多时服务器响应太慢，会超时，导致删除失败
                                //SQLHelper.ExecuteNonQuery(CommandType.Text, "DELETE FROM [HistoryGIS_info] WHERE [ISSI]=(SELECT top 1 [ISSI] FROM [ISSI_info] where id=@id)", new SqlParameter("id", ID));//删除该终端历史GIS信息
                                funissi.DelISSIinfo_byid(ID);//删除该终端的信息
                                scope.Complete();
                                Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("OperationSuccessful") + "');window.parent.lq_changeifr('manager_ISSI');window.parent.reloadtree();</script>");
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

                        Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>window.document.getElementById('Lang_AddNew').src = window.parent.GetTextByName('Lang_AddNew', window.parent.useprameters.languagedata);alert('" + ResourceManager.GetString("Operationfails") + ":" + err + "');</script>");
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
        protected void ImageButton2_Click(object sender, ImageClickEventArgs e)
        {
            GridView1.PageIndex = 0;
        }

    }
}