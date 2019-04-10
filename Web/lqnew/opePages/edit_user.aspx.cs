
using Ryu666.Components;
using System;
using System.Collections.Generic;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Web.lqnew.opePages
{
    public partial class edit_user : BasePage
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
            Page.ClientScript.RegisterStartupScript(Page.GetType(), "Lang2localfunc", "<script>Lang2localfunc();</script>");
            ImageButton1.ImageUrl = ResourceManager.GetString("LangConfirm");
            RequiredFieldValidator1.ErrorMessage = "<b>" + ResourceManager.GetString("qsbyzd") + "<hr/>" + ResourceManager.GetString("yhmcbnwk") + "</b>";
            if (!Page.IsPostBack)
            {
                cancel.Src = ResourceManager.GetString("Lang-Cancel");
                RegularExpressionValidator1.ValidationExpression = Properties.Resources.strNameLengthValidationExpression;
                RegularExpressionValidator2.ValidationExpression = Properties.Resources.strUnChineseValidationExpression;
                RegularExpressionValidator3.ValidationExpression = Properties.Resources.strNameLengthValidationExpression1;
                RegularExpressionValidator1.ErrorMessage = "<B>" + ResourceManager.GetString("errorNO");
                validateEntityLength.ValidationExpression = Properties.Resources.strNameLengthValidationExpression20;
                RegularExpressionValidator2.ErrorMessage = "<B>" + ResourceManager.GetString("MobileLenthLimit20");
                RegularExpressionValidator3.ErrorMessage = "<B>" + ResourceManager.GetString("PositionLenthLimit20");
                ValidatorBZ.ValidationExpression = Properties.Resources.strBZLenghtVaildationExpression;
                validateEntityLength.ErrorMessage = "<B>" + ResourceManager.GetString("errorUnNomal20");
                ValidatorBZ.ErrorMessage = "<B>" + ResourceManager.GetString("errorBZ");
                if (Request.QueryString["id"] != null)
                {
                    IList<MyModel.Model_UserType> list = CreateUserTypeDaoService.GetAllForList();
                    MyModel.Model_userinfo userinfo = new MyModel.Model_userinfo();
                    DbComponent.userinfo getuserinfo = new DbComponent.userinfo();
                    userinfo = getuserinfo.GetUserinfo_byid(int.Parse(Request.QueryString["id"].ToString()));
                    if (userinfo.id != 0)
                    {
                        if (list != null)
                        {
                            foreach (MyModel.Model_UserType UT in list)
                            {
                                DropDownList2.Items.Add(new ListItem(UT.TypeName, UT.TypeName.ToString()));
                            }
                        }
                        DropDownList2.SelectedValue = userinfo.type;
                        DropDownList1.SelectedValue = userinfo.Entity_ID;
                        TextBox1.Text = userinfo.Nam;
                        TextBox2.Text = userinfo.Num;
                        this.oldissi.Value = TextBox4.Text = userinfo.ISSI;
                        txtBZ.Text = userinfo.bz;
                        txtMobile.Text = userinfo.Telephone;
                        txtPosition.Text = userinfo.Position;
                        RadioButtonList1.SelectedValue = userinfo.IsDisplay.ToString();
                    }
                    else
                    {
                        Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>window.parent.closeprossdiv();alert('" + ResourceManager.GetString("nxyxgdydyhxxybcz") + "');window.parent.mycallfunction(geturl());</script>");
                    }
                }
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
        }

        protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
        {
            Page.ClientScript.RegisterStartupScript(Page.GetType(), "resizediv", "<script>   var image1 = window.document.getElementById('Lang-Cancel');var srouce1 = window.parent.parent.GetTextByName('Lang-Cancel', window.parent.parent.useprameters.languagedata);image1.setAttribute('src', srouce1);</script>");

            if (!Page.IsValid) { return; }
            try
            {
                DbComponent.userinfo edituser = new DbComponent.userinfo();
                if (edituser.GetUserinfo_byid(int.Parse(Request.QueryString["id"].ToString())).id == 0)
                {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("ydyheditfaile") + "');window.parent.mycallfunction('edit_user');</script>");
                    return;
                }
                string Nam = TextBox1.Text.Trim();
                string Num = TextBox2.Text.Trim();
                string ISSI = TextBox4.Text.Trim();
                string Eentity_ID = DropDownList1.SelectedValue;
                string type = DropDownList2.SelectedItem.Text;
                string bz = txtBZ.Text.Trim();
                string mobile = txtMobile.Text.Trim();
                string position = txtPosition.Text.Trim();
                int id = int.Parse(Request.QueryString["id"].ToString());
                string err = "";
                if (err == "")
                {
                    if (!CreateUserTypeDaoService.FindUserTypeNameIsExist(type))
                    {
                        Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("choiceusertype") + type + ResourceManager.GetString("notfindusertype") + "');window.parent.mycallfunction('edit_user');</script>");
                        return;
                    }

                    if (edituser.CheckEditUserInfo(Nam, id, Eentity_ID))
                    {
                        Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("notinsameentity") + "');</script>");
                        return;
                    }

                    edituser.EditUserinfo_byid(Nam, Num, ISSI, Eentity_ID, type, bz,mobile,position, id, bool.Parse(RadioButtonList1.SelectedValue));
                    //Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("Lang_ModifySucc") + "');window.parent.deviceuse('" + Nam + "','" + ISSI + "');window.parent.lq_changeifr('manager_user');window.parent.theIntervalFun.policePositionRefresh();window.parent.mycallfunction('edit_user');</script>");
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("Lang_ModifySucc") + "');window.parent.deviceuse('" + Nam + "','" + ISSI + "');window.parent.lq_changeifr('manager_user');window.parent.theIntervalFun.policePositionRefresh();</script>");

                }
                else
                {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("Lang_ModifyFail") + ":" + err + "');</script>");
                }
            }
            catch (System.Exception eX)
            {
                log.Error(eX);
                Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("Lang_ModifyFail") + "');</script>");
            }
        }

        protected void CustomValidator1_ServerValidate(object source, ServerValidateEventArgs args)
        {
            DbComponent.ISSI addissi = new DbComponent.ISSI();
            args.IsValid = true;
            if (addissi.checkISSIANDNotInuse(TextBox4.Text.Trim(), this.oldissi.Value) < 1 && TextBox4.Text.Trim() != "")
            {
                args.IsValid = false;
                CustomValidator1.ErrorMessage = "<b>" + ResourceManager.GetString("InvalidDataInput") + "!<hr/>" + ResourceManager.GetString("ISSIinexistence") + "</b>";
                Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("ISSIbczhyjsy") + "');</script>");
            }

        }

        protected void CustomValidator2_ServerValidate(object source, ServerValidateEventArgs args)
        {
            args.IsValid = true;
            //DbComponent.userinfo userinfo = new DbComponent.userinfo();
            //if (userinfo.IsExistPoliceNOForEdit(TextBox2.Text.Trim(), int.Parse(Request.QueryString["id"].ToString())))
            //{
            //    args.IsValid = false;
            //    Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('编号已存在');</script>");
            //}
        }

    }
}