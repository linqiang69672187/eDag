using Ryu666.Components;
using System;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Web.lqnew.opePages
{
    public partial class add_DTGroup : BasePage
    {
        private DbComponent.DTGroupDao DTGroupDaoService
        {
            get
            {
                return new DbComponent.DTGroupDao();
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {

            Page.ClientScript.RegisterStartupScript(Page.GetType(), "LanguageSwitch", "<script> LanguageSwitch(window.parent); </script>");

            if (!Page.IsPostBack)
            {

               
                validateEntityLength.ValidationExpression = Properties.Resources.strNameLengthValidationExpression;
              
                validateEntityLength.ErrorMessage = "<B>" + ResourceManager.GetString("errorUnNomal");
             
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
            RequiredFieldValidator1.ErrorMessage = "<B>" + ResourceManager.GetString("Lang_dtczxxNameNotNULL") + "</B>";
            RequiredFieldValidator2.ErrorMessage = "<B>" + ResourceManager.GetString("Lang_dtczxxNONotNULL") + "</B>";
            ImageButton1.ImageUrl = ResourceManager.GetString("LangConfirm");
        }

        protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
        {

            if (!Page.IsValid) { return; }
            Page.ClientScript.RegisterStartupScript(Page.GetType(), "changeimage", "<script> var image = window.document.getElementById('Lang-Cancel'); var source = window.parent.parent.GetTextByName('Lang-Cancel', window.parent.parent.useprameters.languagedata);image.setAttribute('src', source);</script>");
            try
            {
               
                
                string Nam = TextBox1.Text.Trim();
             
                string ISSI = okw.Text.Trim();
              
                string err = "";
                if (err == "")
                {
                    string reg = "^[0-9]*[1-9][0-9]*$";
                    System.Text.RegularExpressions.Regex a = new System.Text.RegularExpressions.Regex(reg);
                    if (!a.IsMatch(ISSI) || !(Convert.ToDouble(ISSI) > 0 && Convert.ToDouble(ISSI) <= 80699999))
                    {
                        Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("Lang_Illegal_DTGroup_ISSI") + "');</script>");
                        return;
                    }
                    if (DTGroupDaoService.FindDTGroupNameForAdd(Nam))
                    {
                        Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("dtczxxisexistname") + "');</script>");
                        return;
                    }
                    if (DTGroupDaoService.FindDTGroupISSIForAdd(ISSI))
                    {
                        Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("dtczxxisexistgssi") + "');</script>");
                        return;
                    }

                    if (DTGroupDaoService.AddDTGroup(Nam,ISSI))
                    {
                        Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("AddSucc") + "');window.parent.lq_changeifr('manager_DTGroup');window.parent.mycallfunction('add_DTGroup');</script>");
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
            


        }
        protected void CustomValidator2_ServerValidate(object source, ServerValidateEventArgs args)
        {

            args.IsValid = true;
        
        }

    }
}