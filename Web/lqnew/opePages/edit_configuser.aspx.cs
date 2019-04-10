using MyModel;
using Ryu666.Components;
using System;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Web.lqnew.opePages
{
    public partial class edit_configuser : System.Web.UI.Page
    {
        public string editusername = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                Page.ClientScript.RegisterStartupScript(Page.GetType(), "Lang2localfunc", "<script>Lang2localfunc();</script>");

                ImageButton1.ImageUrl = ResourceManager.GetString("LangConfirm");
                RequiredFieldValidator3.ErrorMessage = "<b>" + ResourceManager.GetString("Fieldmust") + "</b>";
                CompareValidator1.ErrorMessage = "<b>" + ResourceManager.GetString("ConfirmPWDErr") + "</b>";
                this.regExpVali2.ErrorMessage = "<b>" + ResourceManager.GetString("pwdyaoqiu") + "</b>";
                this.regExpVali3.ErrorMessage = "<b>" + ResourceManager.GetString("pwdyaoqiu") + "</b>";

                if (!Page.IsPostBack && Request.QueryString["id"] != null)
                {
                    cancel.Src = ResourceManager.GetString("Lang-Cancel");
                    Model_login logininfo = new Model_login();
                    DbComponent.login functionlogin = new DbComponent.login();
                    logininfo = functionlogin.GetLogininfo_byid(int.Parse(Request.QueryString["id"]));
                    if (logininfo.id != 0)
                    {
                        
                        TextBox1.Text = logininfo.Usename;
                        Label1.Text = logininfo.Usename;
                        TextBox2.Text = logininfo.Pwd;
                        editusername = logininfo.Usename;
                        if (editusername == "root")
                        {
                            ListItem li1 = new ListItem();
                            li1.Text = editusername;
                            li1.Value = logininfo.Entity_ID;
                            DropDownList1.Items.Add(li1);
                        }
                        
                        DropDownList1.SelectedValue = logininfo.Entity_ID;
                    }
                    else
                    {
                        Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>window.parent.closeprossdiv();alert('" + ResourceManager.GetString("ddyxxbcz") + "');window.parent.mycallfunction(geturl());</script>");
                    }
                    if (System.Configuration.ConfigurationManager.AppSettings["OpenWindow"] == "1")
                    {
                        Page.ClientScript.RegisterStartupScript(Page.GetType(), "resizediv", "<script>  window.parent.lq_changeheight(geturl(), document.body.clientHeight);window.parent.change(geturl());</script>");
                    }
                    RequiredFieldValidator1.ErrorMessage = "<b>" + ResourceManager.GetString("Fieldmust") + "!<hr/>" + ResourceManager.GetString("USERNAMEFieldMust") + "</b>";//用户名不能为空
                    RequiredFieldValidator2.ErrorMessage = "<b>" + ResourceManager.GetString("Fieldmust") + "!<hr/>" + ResourceManager.GetString("PWDFieldMust") + "</b>";//密码不能为空
                }
                else
                {
                    if (System.Configuration.ConfigurationManager.AppSettings["OpenWindow"] == "1")
                    {
                        Page.ClientScript.RegisterStartupScript(Page.GetType(), "resizediv", "<script>  window.parent.lq_changeheight(geturl(), document.body.clientHeight);</script>");
                    }
                }
            }
            catch(Exception exx){}
        }

        protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
        {
            Page.ClientScript.RegisterStartupScript(Page.GetType(), "resizediv", "<script>   var image1 = window.document.getElementById('Lang-Cancel');var srouce1 = window.parent.parent.GetTextByName('Lang-Cancel', window.parent.parent.useprameters.languagedata);image1.setAttribute('src', srouce1);</script>");

            try
            {
                DbComponent.login editlogin = new DbComponent.login();
                if (editlogin.GetLogininfo_byid(int.Parse(Request.QueryString["id"])).id == 0)
                {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("ddyeditfaile") + "');window.parent.mycallfunction('edit_configuser');</script>");
                    return;
                }
                string Usename = TextBox1.Text.Trim();
                string Pwd = TextBox2.Text.Trim();
                string Eentity_ID = DropDownList1.SelectedValue;
                string err = "";
                if (err == "")
                {

                    editlogin.EditLogininfo_byid(Usename, Pwd, Eentity_ID, int.Parse(Request.QueryString["id"]));
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("Lang_ModifySucc") + "');window.parent.lq_changeifr('manager_configuser');window.parent.mycallfunction('edit_configuser');</script>");

                }
                else
                {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("Lang_ModifyFail") + ":" + err + "');</script>");
                }
            }
            catch (System.Exception eX)
            {
                //log.Error(eX);
                Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("Lang_ModifyFail") + "');</script>");
            }
        }


        protected void CustomValidator1_ServerValidate(object source, ServerValidateEventArgs args)
        {
            args.IsValid = true;
            if (DbComponent.login.loginin(TextBox1.Text.Trim(), int.Parse(Request.QueryString["id"])) > 0)
            {
                args.IsValid = false; CustomValidator1.ErrorMessage = "<b>" + ResourceManager.GetString("InvalidDataInput") + "!<hr/>" + ResourceManager.GetString("ChooseUsername_DuplicateUserName") + "</b>";
                Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("accountexists") + "');</script>");
            }
        }
    }
}