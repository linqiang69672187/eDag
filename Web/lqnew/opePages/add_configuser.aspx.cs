using Ryu666.Components;
using System;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Web.lqnew.opePages
{
    public partial class add_configuser : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //Page.ClientScript.RegisterStartupScript(Page.GetType(), "LanguageSwitch", "<script> LanguageSwitch(window.parent); </script>");

            Page.ClientScript.RegisterStartupScript(Page.GetType(), "LanguageSwitch", "<script>  Lang2localfunc(); </script>");

            if (!Page.IsPostBack)
            {
                RequiredFieldValidator1.ErrorMessage = "<b>" + ResourceManager.GetString("Fieldmust") + "!<hr/>" + ResourceManager.GetString("USERNAMEFieldMust") + "</b>";//用户名不能为空
                RequiredFieldValidator2.ErrorMessage = "<b>" + ResourceManager.GetString("Fieldmust") + "!<hr/>" + ResourceManager.GetString("PWDFieldMust") + "</b>";//密码不能为空
                //RegularExpressionValidator1.ValidationExpression = Properties.Resources.strNameLengthValidationExpression;
                RegularExpressionValidator1.ErrorMessage = "<b>" + ResourceManager.GetString("ChooseUsername_error");
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
            //RegularExpressionValidator1.ValidationExpression = Properties.Resources.strNameLengthValidationExpression;
            RegularExpressionValidator1.ErrorMessage = "<b>" + ResourceManager.GetString("usenameyaoqiu") + "</b>";
            RequiredFieldValidator3.ErrorMessage = "<b>" + ResourceManager.GetString("Fieldmust") + "</b>";
            CompareValidator1.ErrorMessage = "<b>" + ResourceManager.GetString("ConfirmPWDErr") + "</b>";
            this.regExpVali2.ErrorMessage = "<b>" + ResourceManager.GetString("pwdyaoqiu") + "</b>";
            this.regExpVali3.ErrorMessage = "<b>" + ResourceManager.GetString("pwdyaoqiu") + "</b>";
        }

        protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
        {
            if (!Page.IsValid) { return; }
            try
            {
                string Usename = TextBox1.Text.Trim();
                string Pwd = TextBox2.Text.Trim();
                string Eentity_ID = DropDownList1.SelectedValue;
                string err = "";
                if (err == "")
                {
                    DbComponent.login addlogin = new DbComponent.login();
                    addlogin.AddConfiguserinfo(Usename, Pwd, Eentity_ID, decimal.Parse(hidLastLo.Value), decimal.Parse(hidLastLa.Value));
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("AddSucc") + "');window.parent.lq_changeifr('manager_configuser');window.parent.mycallfunction('add_configuser');</script>");

                }
                else
                {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("AddFail") + ":" + err + "');</script>");
                }
            }
            catch (System.Exception eX)
            {
                //log.Error(eX);
                Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("AddFail") + "');</script>");
            }
        }

        protected void CustomValidator1_ServerValidate(object source, ServerValidateEventArgs args)
        {

            args.IsValid = true;
            if (DbComponent.login.loginin(TextBox1.Text.Trim(), 0) > 0)
            {
                args.IsValid = false; CustomValidator1.ErrorMessage = "<b>" + ResourceManager.GetString("InvalidDataInput") + "!<hr/>" + ResourceManager.GetString("ChooseUsername_DuplicateUserName") + "</b>";
                Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("accountexists") + "');</script>");
            }
        }
    }
}