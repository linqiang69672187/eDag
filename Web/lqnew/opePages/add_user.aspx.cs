using Ryu666.Components;
using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using DbComponent;
using DbComponent.Duty;
namespace Web.lqnew.opePages
{
    public partial class add_user : BasePage
    {
        private DbComponent.IDAO.IUserTypeDao CreateUserTypeDaoService
        {
            get
            {
                return DbComponent.FactoryMethod.DispatchInfoFactory.CreateUserTypeDao();
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {

            Page.ClientScript.RegisterStartupScript(Page.GetType(), "LanguageSwitch", "<script> LanguageSwitch(window.parent); </script>");

            if (!Page.IsPostBack)
            {

                RegularExpressionValidator1.ValidationExpression = Properties.Resources.strNameLengthValidationExpression;
                RegularExpressionValidator2.ValidationExpression = Properties.Resources.strUnChineseValidationExpression;
                RegularExpressionValidator3.ValidationExpression = Properties.Resources.strNameLengthValidationExpression1;
                RegularExpressionValidator1.ErrorMessage = "<B>" + ResourceManager.GetString("errorNO");
                RegularExpressionValidator2.ErrorMessage = "<B>" + ResourceManager.GetString("MobileLenthLimit20");
                RegularExpressionValidator3.ErrorMessage = "<B>" + ResourceManager.GetString("PositionLenthLimit20");
                validateEntityLength.ValidationExpression = Properties.Resources.strNameLengthValidationExpression20;
                ValidatorBZ.ValidationExpression = Properties.Resources.strBZLenghtVaildationExpression;
                validateEntityLength.ErrorMessage = "<B>" + ResourceManager.GetString("errorUnNomal20");
                ValidatorBZ.ErrorMessage = "<B>" + ResourceManager.GetString("errorBZ");
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
            RequiredFieldValidator1.ErrorMessage = "<B>" + ResourceManager.GetString("yhmcbnwk") + "</B>";
            ImageButton1.ImageUrl = ResourceManager.GetString("LangConfirm");
        }

        protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
        {

            if (!Page.IsValid) { return; }
            Page.ClientScript.RegisterStartupScript(Page.GetType(), "changeimage", "<script> var image = window.document.getElementById('Lang-Cancel'); var source = window.parent.parent.GetTextByName('Lang-Cancel', window.parent.parent.useprameters.languagedata);image.setAttribute('src', source);</script>");
            try
            {
                DbComponent.ISSI addissi = new DbComponent.ISSI();
                if (addissi.checkISSIANDNotInuse(okw.Text.Trim(), "0") < 1 && okw.Text.Trim() != "")
                {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("ISSIbczhyjsy") + "');</script>");
                    return;
                }
                string Nam = TextBox1.Text.Trim();
                string Num = TextBox2.Text.Trim();
                string ISSI = okw.Text.Trim();
                string Eentity_ID = DropDownList1.SelectedValue;
                string type = DropDownList2.SelectedItem.Text;
                string mobile = txtMobile.Text.Trim();
                string position = txtPosition.Text.Trim();
                string bz = txtBZ.Text.Trim();

                string err = "";
                if (err == "")
                {
                    if (!CreateUserTypeDaoService.FindUserTypeNameIsExist(type))
                    {
                        Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("Lang_SelectedTypeIexit") + "[" + type + "]');window.parent.mycallfunction('add_user');</script>");
                        return;
                    }

                    DbComponent.userinfo adduser = new DbComponent.userinfo();
                    if (!adduser.CheckUserInfo(Nam, Eentity_ID))
                    {
                        Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("tdwztbzmcbncf") + "');</script>");
                        return;
                    }

                    if (adduser.AddUserinfo(Nam, Num, ISSI, Eentity_ID, type, bz,mobile,position))
                    {
                        GPSReportStatisticsDao gisRecord = new GPSReportStatisticsDao();
                        Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("AddSucc") + "');window.parent.deviceuse('" + Nam + "','" + ISSI + "');window.parent.reloadtree();window.parent.lq_changeifr('manager_user');window.parent.mycallfunction('add_user');</script>");
                        gisRecord.adduserToGISRecord(Nam, Num, ISSI, Eentity_ID);
                    }
                    else
                        Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("AddFail") + ":" + err + "');</script>");
                }
                else
                {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("AddFail") + ":" + err + "');</script>");
                }
            }
            catch (System.Exception eX)
            {
                log.Error(eX);
                Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("AddFail") + "');</script>");
            }
        }
       
        protected void CustomValidator1_ServerValidate(object source, ServerValidateEventArgs args)
        {
            DbComponent.ISSI addissi = new DbComponent.ISSI();
            args.IsValid = true;
            if (addissi.checkISSIANDNotInuse(okw.Text.Trim(), "0") < 1 && okw.Text.Trim() != "")
            {
                args.IsValid = false; CustomValidator1.ErrorMessage = "<b>" + ResourceManager.GetString("InvalidDataInput") + "!<hr/>" + ResourceManager.GetString("ISSIinexistence") + "</b>";
                Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("ISSIbczhyjsy") + "');</script>");
            }


        }
        protected void CustomValidator2_ServerValidate(object source, ServerValidateEventArgs args)
        {

            args.IsValid = true;
        
        }

    }
}