using DbComponent;
using MyModel;
using Ryu666.Components;
using System;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Web.lqnew.opePages
{
    public partial class manager_Procedure : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            Page.ClientScript.RegisterStartupScript(Page.GetType(), "LanguageSwitch", "<script>LanguageSwitch(window.parent);</script>");
            ImageButton1.ImageUrl = ResourceManager.GetString("Lang_Search2");
            Page.ClientScript.RegisterStartupScript(Page.GetType(), "resizediv", "<script>window.document.getElementById(\"Lang_AddNew\").src = window.parent.GetTextByName('Lang_AddNew', window.parent.useprameters.languagedata);</script>");
            GridView1.EmptyDataText = ResourceManager.GetString("NoData");
            GridView1.Columns[0].HeaderText = ResourceManager.GetString("Lang_procedurename");
            GridView1.Columns[1].HeaderText = ResourceManager.GetString("Lang_procedureType");
            GridView1.Columns[2].HeaderText = ResourceManager.GetString("Lang_procedurelifttime");
            //if (!Page.IsPostBack)
            //{
            //    if (System.Configuration.ConfigurationManager.AppSettings["OpenWindow"] == "1")
            //    {
            //        Page.ClientScript.RegisterStartupScript(Page.GetType(), "resizediv", "<script>  window.parent.lq_changeheight(geturl(), document.body.clientHeight);window.parent.change(geturl());</script>");
            //    }
            //    if (Request.QueryString["id"] != null)
            //    {
            //        userul.Visible = false;
            //    }
            //}
            //else
            //{
            //    if (System.Configuration.ConfigurationManager.AppSettings["OpenWindow"] == "1")
            //    {
            //        Page.ClientScript.RegisterStartupScript(Page.GetType(), "resizediv", "<script>  window.parent.lq_changeheight(geturl(), document.body.clientHeight);</script>");
            //    }
            //}
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //e.Row.Attributes.Add("onmouseover", "changeTgBg(this,'font',2)");
                //e.Row.Attributes.Add("onmouseout", "overchangeTgBg(this,'font',2)");
                //DbComponent.Entity funEntity = new DbComponent.Entity();
                //DbComponent.group fungroup = new DbComponent.group();
                //e.Row.Cells[1].Text = "&nbsp;&nbsp;" + funEntity.GetEntityinfo_byid(int.Parse(e.Row.Cells[1].Text)).Name;
                //funEntity = null;


                LinkButton linkbtn = (LinkButton)e.Row.FindControl("ImageButton2");
                if (linkbtn != null)
                {
                    linkbtn.ToolTip = ResourceManager.GetString("DelTheEntity");
                    linkbtn.OnClientClick = @"javascript:window.document.getElementById('Lang_AddNew').src = window.parent.GetTextByName('Lang_AddNew', window.parent.useprameters.languagedata);return confirm('"+ResourceManager.GetString("Delete")+"['+this.parentElement.parentElement.getElementsByTagName('font')[0].innerText.trim()+']?')";
                }
                System.Web.UI.HtmlControls.HtmlImage img = (System.Web.UI.HtmlControls.HtmlImage)e.Row.FindControl("img_del");
                if (img != null)
                {
                    img.Attributes.Add("title",  ResourceManager.GetString("Delete"));
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
                case "Show":
                    break;
                case "MyDel":
                    int ID = int.Parse(e.CommandArgument.ToString());
                    DTProcedureDao dt = new DTProcedureDao();
                    if (dt.DeleteModel_ProcedureInfo(ID))
                    {
                        Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>window.document.getElementById('Lang_AddNew').src = window.parent.GetTextByName('Lang_AddNew', window.parent.useprameters.languagedata);alert('" + ResourceManager.GetString("OperationSuccessful") + "');window.parent.lq_changeifr('manager_Procedure');</script>");
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