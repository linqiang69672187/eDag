using Ryu666.Components;
using System;
using System.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Web.lqnew.opePages
{
    public partial class manager_login : System.Web.UI.Page
    {
          
        protected void Page_Load(object sender, EventArgs e)
        {
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
            DropDownList1.Items[0].Text = ResourceManager.GetString("SelectEntity");
            GridView1.EmptyDataText = ResourceManager.GetString("NoData");
            Lang_Search.ImageUrl = ResourceManager.GetString("Lang_Search2");
            GridView1.Columns[0].HeaderText = ResourceManager.GetString("usename");
            GridView1.Columns[1].HeaderText = ResourceManager.GetString("PWD");
            GridView1.Columns[2].HeaderText = ResourceManager.GetString("Lang_Subordinateunits");
            GridView1.Columns[3].HeaderText = ResourceManager.GetString("Lang_Role");

        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {


            if (e.Row.RowType == DataControlRowType.DataRow)
            {
               
                e.Row.Attributes.Add("onmouseover", "changeTgBg(this,'font',3)");
                e.Row.Attributes.Add("onmouseout", "overchangeTgBg(this,'font',3)");
                DbComponent.Entity funEntity = new DbComponent.Entity();
                e.Row.Cells[2].Text = "&nbsp;&nbsp;" + funEntity.GetEntityinfo_byid(int.Parse(e.Row.Cells[2].Text)).Name;

                if (GridView1.DataKeys[e.Row.RowIndex].Values[1].ToString() != "" && GridView1.DataKeys[e.Row.RowIndex].Values[1].ToString() != "0")
                {
                    int roleId = int.Parse(GridView1.DataKeys[e.Row.RowIndex].Values[1].ToString());
                    if ((System.Configuration.ConfigurationManager.AppSettings["defaultLanguage"]).ToLower() == "zh-cn")
                    {
                        e.Row.Cells[3].Text = DbComponent.Role.GetRoleModelByRoleId(roleId).RoleName;
                    }
                    else
                    {
                        e.Row.Cells[3].Text = DbComponent.Role.GetRoleModelByRoleId(roleId).EnRoleName;
                    }
                }

                funEntity = null;
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
                    DbComponent.login funlogin = new DbComponent.login();
                    int ID = int.Parse(e.CommandArgument.ToString());
                    if (funlogin.GetLogininfo_byid(ID).id == 0)
                    {
                        Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>window.document.getElementById('Lang_AddNew').src = window.parent.GetTextByName('Lang_AddNew', window.parent.useprameters.languagedata);alert('" + ResourceManager.GetString("Lang_DeleteDataFail") + "');</script>");
                        return;
                    }

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

                    if (funlogin.CheckUsernameAdmin_byid(ID) > 0)
                    {
                        err += "\\n        "+strMarker + ResourceManager.GetString("admincannotdel");
                    }
                    if (Request.Cookies["username"].Value.Trim() == funlogin.GetLogininfo_byid(ID).Usename.Trim())
                    {
                        err += "\\n        " + strMarker + ResourceManager.GetString("selfcannotdel");
                    }
                    DateTime dt = DbComponent.login.checkuselogintime(funlogin.GetLogininfo_byid(ID).Usename.Trim());
                
                    DateTime dt1 = DateTime.Now;
                    TimeSpan ts = dt1 - dt;
                    double mins = ts.TotalMinutes;
                   int m_connectionString = int.Parse(ConfigurationManager.AppSettings["login_overtime"]); //获取失效时间
                   if (mins < m_connectionString)
                   {
                       err += "\\n        " + strMarker + ResourceManager.GetString("UserInLogin"); ;
                    }
                    if (err==""){
                        funlogin.DelLogin_byid(ID);
                        Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>window.document.getElementById('Lang_AddNew').src = window.parent.GetTextByName('Lang_AddNew', window.parent.useprameters.languagedata);alert('" + ResourceManager.GetString("OperationSuccessful") + "');window.parent.lq_changeifr('manager_login');</script>");
                    }
                 
                    else
                    {
                        Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>window.document.getElementById('Lang_AddNew').src = window.parent.GetTextByName('Lang_AddNew', window.parent.useprameters.languagedata);alert(\"" + ResourceManager.GetString("Operationfails") + ":" + err + "\");</script>");
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