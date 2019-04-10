using Ryu666.Components;
using System;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Web.lqnew.opePages
{
    public partial class manager_UserType : System.Web.UI.Page
    {
        private DbComponent.IDAO.IUserTypeDao UserTypeDaoServce
        {
            get
            {
                return DbComponent.FactoryMethod.DispatchInfoFactory.CreateUserTypeDao();
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
            GridView1.Columns[0].HeaderText = ResourceManager.GetString("typeName");
            GridView1.Columns[1].HeaderText = ResourceManager.GetString("Icon");

        }
      

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Attributes.Add("onmouseover", "changeTgBg(this,'font',2)");
                e.Row.Attributes.Add("onmouseout", "overchangeTgBg(this,'font',2)");
                //e.Row.Cells[1].Text = "<img style='width:20px; height:20px' src='UpLoad/tempusertypepic/" + e.Row.Cells[1].Text + "/3.png' />";//3 用于显示小图像
    
                LinkButton linkbtn = (LinkButton)e.Row.FindControl("ImageButton2");
                if (linkbtn != null)
                {
                    linkbtn.OnClientClick = @"window.document.getElementById('Lang_AddNew').src = window.parent.GetTextByName('Lang_AddNew', window.parent.useprameters.languagedata);javascript:return confirm('" + ResourceManager.GetString("BeSureToDelete") + "[" + e.Row.Cells[0].Text + "]?')";
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
                    if (UserTypeDaoServce.GetUserTypeByID(ID).ID == 0)
                    {
                        Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>window.document.getElementById('Lang_AddNew').src = window.parent.GetTextByName('Lang_AddNew', window.parent.useprameters.languagedata);alert('" + ResourceManager.GetString("Lang_DeleteDataFail") + "');</script>");
                        return;
                    }

                    //先判断是否有用户绑定了此用户类型，如果绑定了 则不能删除
                    if (UserTypeDaoServce.IsUsed(ID))
                    {
                        Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>window.document.getElementById('Lang_AddNew').src = window.parent.GetTextByName('Lang_AddNew', window.parent.useprameters.languagedata);alert('" + ResourceManager.GetString("UserTypebeUSE") + "');</script>");
                        return;
                    }

                    if (UserTypeDaoServce.DeleteUserType(ID))
                    {
                        Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>window.document.getElementById('Lang_AddNew').src = window.parent.GetTextByName('Lang_AddNew', window.parent.useprameters.languagedata);alert('" + ResourceManager.GetString("OperationSuccessful") + "');window.parent.reloadtree();window.parent.lq_changeifr('manager_UserType');</script>");
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