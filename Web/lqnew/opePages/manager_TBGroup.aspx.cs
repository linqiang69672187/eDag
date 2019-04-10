using DbComponent;
using Ryu666.Components;
using System;
using System.Data;
using System.Text;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Web.lqnew.opePages
{
    public partial class manager_TBGroup : System.Web.UI.Page
    {

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
            Lang_ExternalGroup.ImageUrl = ResourceManager.GetString("Lang_ExternalGroup");
            DropDownList1.Items[0].Text = ResourceManager.GetString("SelectEntity");
            GridView1.EmptyDataText = ResourceManager.GetString("SearchHaveNoData");
            GridView1.Columns[0].HeaderText = ResourceManager.GetString("Lang-T-TBGroupNametext");
            GridView1.Columns[1].HeaderText = ResourceManager.GetString("Lang_TBGroupType");
            GridView1.Columns[2].HeaderText = ResourceManager.GetString("Subordinateunits");
            GridView1.Columns[3].HeaderText = ResourceManager.GetString("groupbz");
            GridView1.Columns[5].HeaderText = ResourceManager.GetString("Membersgroup");
            GridView1.Columns[6].HeaderText = ResourceManager.GetString("external_system");

        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Attributes.Add("onmouseover", "changeTgBg(this,'font',2)");
                e.Row.Attributes.Add("onmouseout", "overchangeTgBg(this,'font',2)");
                if (e.Row.Cells[4].Text == "True")
                {
                    e.Row.Cells[4].Text = "<img src='../images/call_on.png' />";
                }
                else
                {
                    e.Row.Cells[4].Text = "";
                }
                DbComponent.Entity funEntity = new DbComponent.Entity();
                DbComponent.group funGroup = new DbComponent.group();
                e.Row.Cells[2].Text = "&nbsp;&nbsp;" + funEntity.GetEntityinfo_byid(int.Parse(e.Row.Cells[2].Text)).Name;

                string[] GSSIs = GridView1.DataKeys[e.Row.RowIndex].Values[1].ToString().Replace(">", "").Split(new char[] { '<' }, StringSplitOptions.RemoveEmptyEntries);

                e.Row.Cells[5].Text = "&nbsp;&nbsp;(" + funGroup.GetGroupGroupname_byGSSI(GSSIs[0]) + ")" + GSSIs[0];
                if (GSSIs.Length > 1)
                {
                    e.Row.Cells[5].Text += "...";
                }
                StringBuilder titlevalue = new StringBuilder();
                foreach (string GSSI in GSSIs) { titlevalue.Append("(" + funGroup.GetGroupGroupname_byGSSI(GSSI) + ")" + GSSI + "\n"); }
                e.Row.Cells[5].Attributes.Add("title", titlevalue.ToString().Trim());
                e.Row.Cells[5].Attributes.Add("style", "cursor:hand;");
                titlevalue.Clear();
                funEntity = null;
                funGroup = null;
                if (e.Row.Cells[6].Text == "1")
                {
                    e.Row.Cells[6].Text = "&nbsp;&nbsp;" + ResourceManager.GetString("Lang_Yes");
                }
                else
                {
                    e.Row.Cells[6].Text = "&nbsp;&nbsp;" + ResourceManager.GetString("Lang_No");

                }
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
                    DbComponent.group fungroup = new DbComponent.group();
                    int ID = int.Parse(e.CommandArgument.ToString());
                    if (fungroup.GetGroupinfo_byid(ID).id == 0)
                    {
                        Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>window.document.getElementById('Lang_AddNew').src = window.parent.GetTextByName('Lang_AddNew', window.parent.useprameters.languagedata);alert('" + ResourceManager.GetString("Delfailmanager_TBgroup") + "');</script>");
                        return;
                    }

                    string GSSI = fungroup.GetGroupinfo_byid(ID).GSSI;
                    string err = "";

                    //检查小组呼叫状态，有终端烧有该通播组
                    #region chenck

                      string strMarker;

                    if (System.Configuration.ConfigurationManager.AppSettings["defaultLanguage"] == "zh-CN")
                    {
                        strMarker = "☆";
                    }
                    else
                    {
                        strMarker = "#";
                    }

                    if (fungroup.Groupstatus_byid(ID) > 0)
                    {
                        err += "\\n        " + strMarker + ResourceManager.GetString("GroupinCall"); // 检查小组呼叫状态
                    }
                    if (int.Parse(SQLHelper.ExecuteScalar(CommandType.Text, "select count(id) from [ISSI_info] where [GSSIS] like '%<" + GSSI + ">%'").ToString()) > 0)
                    {
                        err += "\\n        " + strMarker + ResourceManager.GetString("ISSIhaveGroup");//有终端烧有该通播组
                    }
                    #endregion

                    if (err == "")
                    {
                        fungroup.DelGroupinfo_byid(ID);
                        Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>window.document.getElementById('Lang_AddNew').src = window.parent.GetTextByName('Lang_AddNew', window.parent.useprameters.languagedata);alert('" + ResourceManager.GetString("OperationSuccessful") + "');window.parent.updatecallgroup();window.parent.lq_changeifr('manager_TBGroup');window.parent.reloadtree();</script>");
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