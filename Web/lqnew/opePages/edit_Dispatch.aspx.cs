#region Author
/*
 *Modules:
 *CreateTime:2011-07-26
 *Author:杨德军    
 *Company:Eastcom
 **/

#endregion
using Ryu666.Components;
using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using Web.lqnew.other;

namespace Web.lqnew.opePages
{
    public partial class edit_Dispatch : BasePage
    {
        private DbComponent.ISSI ISSIService
        {
            get
            {
                return new DbComponent.ISSI();
            }
        }

        private DbComponent.group groupService
        {
            get
            {
                return new DbComponent.group();
            }
        }
        private DbComponent.IDAO.IDispatchInfoDao DispatchInfoDaoService
        {
            get
            {
                return DbComponent.FactoryMethod.DispatchInfoFactory.CreateDispatchInfoDao();
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            Page.ClientScript.RegisterStartupScript(Page.GetType(), "Lang2localfunc", "<script>Lang2localfunc();</script>");

            if (!Page.IsPostBack)
            {
                cancel.Src = ResourceManager.GetString("Lang-Cancel");
                if (Request.QueryString["id"] != null)
                {
                    MyModel.Model_Dispatch_View DisView = DispatchInfoDaoService.GetModelDispatchViewByID(int.Parse(Request.QueryString["id"].ToString()));
                    if (DisView.ID != 0)
                    {
                        TextBox1.Text = DisView.ISSI;
                        Label1.Text = DisView.EntityName;
                        txtIpAddress.Text = DisView.IPAddress;
                    }
                    else
                    {
                        Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>window.parent.closeprossdiv();alert('" + ResourceManager.GetString("nxyxgdddtxxybcz") + "');window.parent.mycallfunction('edit_Dispatch');</script>");
                    }
                    if (System.Configuration.ConfigurationManager.AppSettings["OpenWindow"] == "1")
                    {
                        Page.ClientScript.RegisterStartupScript(Page.GetType(), "resizediv", "<script>  window.parent.lq_changeheight(geturl(), document.body.clientHeight);window.parent.change(geturl());</script>");
                    }
                }
            }
            else
            {
                if (System.Configuration.ConfigurationManager.AppSettings["OpenWindow"] == "1")
                {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "resizediv", "<script>  window.parent.lq_changeheight(geturl(), document.body.clientHeight);</script>");
                }
            }
            ImageButton1.ImageUrl = ResourceManager.GetString("LangConfirm");
            RangeValidator1.ErrorMessage = "<b>" + ResourceManager.GetString("fwwzs") + "</b>";
            RequiredFieldValidator1.ErrorMessage = "<b>" + ResourceManager.GetString("EnterSchedulinguseid") + "</b>";
            RegularExpressionValidator1.ErrorMessage = "<b>" + ResourceManager.GetString("IPaddressEnterErr") + "</b>";

        }
        protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
        {

            Page.ClientScript.RegisterStartupScript(Page.GetType(), "resizediv", "<script>   var image1 = window.document.getElementById('Lang-Cancel');var srouce1 = window.parent.parent.GetTextByName('Lang-Cancel', window.parent.parent.useprameters.languagedata);image1.setAttribute('src', srouce1);</script>");

            if (DispatchInfoDaoService.GetModelDispatchViewByID(int.Parse(Request.QueryString["id"].ToString())).ID == 0)
            {
                Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("ddteditfaile") + "');window.parent.mycallfunction('edit_Dispatch');</script>");
                return;

            }
            //if (!Page.IsValid) { return; }//验证失败禁止通过提交
            try
            {
                if (!checkISSI.RegexIssiValue(TextBox1.Text.Trim()))
                {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("ddyhbzbxwzs") + "');</script>");
                    return;
                }
                MyModel.Model_Dispatch md = DispatchInfoDaoService.GetModelDispatchViewByISSI(TextBox1.Text.Trim());
                if (md != null && md.ISSI == TextBox1.Text.Trim() && md.ID != int.Parse(Request.QueryString["id"]))
                {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("Schedulinguseidexit") + "');</script>");
                    return;
                }
                //不能跟issi表中的issi相同
                if (ISSIService.GetISSIinfoByISSI(TextBox1.Text.Trim()).ISSI == TextBox1.Text.Trim())
                {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("ddyhzISSIycz") + "');</script>");
                    return;
                }
                //不能跟组中的GIIS相同
                if (groupService.GetGroupInfoByGIIS(TextBox1.Text.Trim()).Rows.Count > 0)
                {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("ddyhzgroupycz") + "');</script>");
                    return;
                }

                MyModel.Model_Dispatch newDispatch = new MyModel.Model_Dispatch() { ID = int.Parse(Request.QueryString["id"]), IPAddress = txtIpAddress.Text, ISSI = TextBox1.Text.Trim() };
                if (DispatchInfoDaoService.UpdateDispatchInfo(newDispatch))
                {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("Lang_ModifySucc") + "');window.parent.reloadtree();window.parent.lq_changeifr('manager_Dispatch');window.parent.mycallfunction('edit_Dispatch');</script>");

                }
                else
                {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("Lang_ModifyFail") + "');</script>");
                }
            }
            catch (System.Exception eX)
            {
                log.Error(eX);
                Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("Lang_ModifyFail") + "');</script>");
            }
        }
        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
        }
        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
        }
        protected void GridView2_RowCommand(object sender, GridViewCommandEventArgs e)
        {
        }
        protected void GridView2_RowDataBound(object sender, GridViewRowEventArgs e)
        {
        }
        protected void Label2_Load(object sender, EventArgs e)
        {
        }
        protected void Label3_Load(object sender, EventArgs e)
        {
        }
        protected void CustomValidator1_ServerValidate(object source, ServerValidateEventArgs args)
        {
            DbComponent.ISSI addissi = new DbComponent.ISSI();
            args.IsValid = true;
            if (addissi.checkISSI(TextBox1.Text.Trim(), int.Parse(Request.QueryString["id"])) > 0)
            {
                args.IsValid = false; CustomValidator1.ErrorMessage = "<b>" + ResourceManager.GetString("InvalidDataInput") + "!<hr/>" + ResourceManager.GetString("ISSIExists") + "</b>";
            }
        }
    }
}