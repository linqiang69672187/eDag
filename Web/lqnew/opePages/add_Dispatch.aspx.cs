#region Author
/*
 *Modules:添加调度台信息
 *CreateTime:2011-07-26
 *Author:杨德军    
 *Company:Eastcom
 **/

#endregion
using Ryu666.Components;
using System;
using System.Reflection;
using System.Web.UI;
using System.Web.UI.WebControls;
using Web.lqnew.other;

namespace Web.lqnew.opePages
{
    public partial class add_Dispatch : System.Web.UI.Page
    {
        private DbComponent.IDAO.IDispatchInfoDao DispatchInfoService
        {
            get
            {
                return DbComponent.FactoryMethod.DispatchInfoFactory.CreateDispatchInfoDao();
            }
        }
        private DbComponent.ISSI issiService
        {
            get {
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
        protected void Page_Load(object sender, EventArgs e)
        {
            ImageButton1.ImageUrl = ResourceManager.GetString("LangConfirm");

            rfvBaseStationName.ErrorMessage = "<b>" + ResourceManager.GetString("EnterSchedulinguseid") + "</b>";
            RequiredFieldValidator1.ErrorMessage = "<b>" + ResourceManager.GetString("GrouperrorNO") + "</b>";
            RegularExpressionValidator1.ErrorMessage = "<b>" + ResourceManager.GetString("IPaddressEnterErr") + "</b>";
            Page.ClientScript.RegisterStartupScript(Page.GetType(), "LanguageSwitch", "<script>  Lang2localfunc(); </script>");

            if (!Page.IsPostBack)
            {

            }

        }
        private static readonly log4net.ILog log = log4net.LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);
        protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
        {
            //if (!Page.IsValid) { return; }

            try
            {
                MyModel.Model_Dispatch md = DispatchInfoService.GetModelDispatchViewByISSI(TextBox1.Text.Trim());
                if (!checkISSI.RegexIssiValue(TextBox1.Text.Trim()))
                {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("ddyhbzbxwzs") + "');</script>");
                    return;
                }
                if (md != null && md.ISSI!=null && md.ISSI.Trim() == TextBox1.Text.Trim())
                {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("Schedulinguseidexit") + "');</script>");
                    return;
                }
                //不能跟issi表中的issi相同
                string tempissi = issiService.GetISSIinfoByISSI(TextBox1.Text.Trim()).ISSI;
                if (tempissi!=null && tempissi.Trim() == TextBox1.Text.Trim()) {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("ddyhzISSIycz") + "');</script>");
                    return;
                }
                //不能跟组中的GIIS相同
                if (groupService.GetGroupInfoByGIIS(TextBox1.Text.Trim()).Rows.Count > 0)
                {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("ddyhzgroupycz") + "');</script>");
                    return;
                }

                MyModel.Model_Dispatch NewDispatch = new MyModel.Model_Dispatch() { Entity_ID = DropDownList1.SelectedValue, IPAddress = txtIpAddress.Text, ISSI = TextBox1.Text.Trim() };
                DispatchInfoService.AddDispatchInfo(NewDispatch);

                Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("AddSucc") + "');window.parent.lq_changeifr('manager_Dispatch');window.parent.mycallfunction('add_Dispatch');</script>");

            }
            catch (System.Exception eX)
            {
                log.Error(eX);
                Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("AddFail") + "');</script>");
            }
        }
        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        { }
        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        { }
        protected void GridView2_RowCommand(object sender, GridViewCommandEventArgs e)
        { }
        protected void GridView2_RowDataBound(object sender, GridViewRowEventArgs e)
        { }
        protected void Label1_Load(object sender, EventArgs e)
        { }
        protected void Label2_Load(object sender, EventArgs e)
        { }
        protected void CustomValidator1_ServerValidate(object source, ServerValidateEventArgs args)
        {
            DbComponent.ISSI addissi = new DbComponent.ISSI();
            args.IsValid = true;
            if (addissi.checkISSI(TextBox1.Text.Trim(), 0) > 0)
            {
                args.IsValid = false; CustomValidator1.ErrorMessage = "<b>" + ResourceManager.GetString("InvalidDataInput") + "!<hr/>" + ResourceManager.GetString("ISSIExists") + "</b>";
            }
        }
    }
}