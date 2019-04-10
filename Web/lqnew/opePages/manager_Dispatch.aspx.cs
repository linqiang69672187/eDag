using MyModel;
using Ryu666.Components;
using System;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Web.lqnew.opePages
{
    public partial class manager_Dispatch : System.Web.UI.Page
    {
        private DbComponent.IDAO.IDispatchInfoDao DispatchInfoDaoServce
        {
            get
            {
                return DbComponent.FactoryMethod.DispatchInfoFactory.CreateDispatchInfoDao();
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            GridView1.EmptyDataText = ResourceManager.GetString("NoData");
            GridView1.Columns[0].HeaderText = ResourceManager.GetString("Schedulinguseid");
            GridView1.Columns[1].HeaderText = ResourceManager.GetString("IPaddress");

            Page.ClientScript.RegisterStartupScript(Page.GetType(), "LanguageSwitch", "<script>LanguageSwitch(window.parent);</script>");
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
                e.Row.Attributes.Add("onmouseover", "changeTgBg(this,'font',2)");
                e.Row.Attributes.Add("onmouseout", "overchangeTgBg(this,'font',2)");
                //DbComponent.Entity funEntity = new DbComponent.Entity();
                //DbComponent.group fungroup = new DbComponent.group();
                //e.Row.Cells[1].Text = "&nbsp;&nbsp;" + funEntity.GetEntityinfo_byid(int.Parse(e.Row.Cells[1].Text)).Name;
                //funEntity = null;


                LinkButton linkbtn = (LinkButton)e.Row.FindControl("ImageButton2");
                if (linkbtn != null)
                {
                    linkbtn.ToolTip = ResourceManager.GetString("DelTheEntity");
                    linkbtn.OnClientClick = @"javascript:window.document.getElementById('Lang_AddNew').src = window.parent.GetTextByName('Lang_AddNew', window.parent.useprameters.languagedata);return confirm('" + ResourceManager.GetString("BeSureToDel") + "['+this.parentElement.parentElement.getElementsByTagName('font')[0].innerText.trim()+']?')";
                }
                System.Web.UI.HtmlControls.HtmlImage img = (System.Web.UI.HtmlControls.HtmlImage)e.Row.FindControl("img_del");
                if (img != null)
                {
                    img.Attributes.Add("title",  ResourceManager.GetString("Delete"));
                }
                System.Web.UI.HtmlControls.HtmlImage img2 = (System.Web.UI.HtmlControls.HtmlImage)e.Row.FindControl("img_modify");
                if (img2 != null)
                {
                    img2.Attributes.Add("title",  ResourceManager.GetString("Modify"));
                }
                
            }
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            switch (e.CommandName)
            {
                case "MyDel":
                    int ID = int.Parse(e.CommandArgument.ToString());
                    if (DispatchInfoDaoServce.GetModelDispatchViewByID(ID).ID == 0)
                    {
                        Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert(\"" + ResourceManager.GetString("Lang_delete_failed_because") + "\");</script>");
                        return;
                    }

                    string dispatchISSI = DispatchInfoDaoServce.GetModelDispatchViewByID(ID).ISSI;
                    LoginDispatch ld = LoginDispatchList.FindLoginDispatch(dispatchISSI);
                    if (ld != null)
                    {
                        double logintime = 0;
                        if (System.Configuration.ConfigurationManager.AppSettings["login_overtime"] != null)
                        {
                            logintime = double.Parse(System.Configuration.ConfigurationManager.AppSettings["login_overtime"].ToString());
                        }
                        else
                        {
                            logintime = 5.00;
                        }
                        if (ld.LoginTime.AddMinutes(5.00) > DateTime.Now)//5分钟前登录过
                        {
                            Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert(\"" + ResourceManager.GetString("Lang_dispatch_have_not_del") + "\");</script>");
                            return;
                        }
                        if (Request.Cookies["dispatchissi"] != null && Request.Cookies["dispatchissi"].Value.ToString() == dispatchISSI)
                        {
                            Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert(\"" + ResourceManager.GetString("Lang_dispatch_cannot_be_deleted") + "\");</script>");
                            return;
                        }
                    }

                    if (DispatchInfoDaoServce.DeleteDispatchInfo(ID))
                    {
                        Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>window.document.getElementById('Lang_AddNew').src = window.parent.GetTextByName('Lang_AddNew', window.parent.useprameters.languagedata);alert('" + ResourceManager.GetString("OperationSuccessful") + "');window.parent.lq_changeifr('manager_Dispatch');</script>");
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