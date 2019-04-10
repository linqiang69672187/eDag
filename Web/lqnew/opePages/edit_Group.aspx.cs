using Ryu666.Components;
using System;
using System.Collections.Generic;
using System.Web.UI;
using System.Web.UI.WebControls;
using Web.lqnew.other;

namespace Web.lqnew.opePages
{
    public partial class edit_Group : BasePage
    {
        private DbComponent.IDAO.IDXGroupInfoDao DXGroupInfoDaoService
        {
            get
            {
                return DbComponent.FactoryMethod.DispatchInfoFactory.CreateDXGroupInfoDao();
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            Page.ClientScript.RegisterStartupScript(Page.GetType(), "Lang2localfunc", "<script>Lang2localfunc();</script>");

            if (!Page.IsPostBack)
            {
                if (Request.QueryString["id"] != null)
                {
                    MyModel.Model_group group = new MyModel.Model_group();
                    DbComponent.group groupfunction = new DbComponent.group();
                    group = groupfunction.GetGroupinfo_byid(int.Parse(Request.QueryString["id"]));
                    if (group.id != 0)
                    {
                        oldGSSI.Value = group.GSSI;
                        TextBox1.Text = group.Group_name;
                        TextBox4.Text = group.GSSI;
                        HiddenField1.Value = group.GSSIS;
                        DbComponent.Entity funEntity = new DbComponent.Entity();
                        Label1.Text = funEntity.GetEntityinfo_byid(int.Parse(group.Entity_ID)).Name;
                        funEntity = null;
                        HiddenField2.Value = group.Entity_ID;
                        RadioButtonList1.SelectedValue = group.status.ToString();

                        chkExternal.Checked = group.isExternal == 1 ? true : false;
                        
                        grouptype.Text = group.TypeName == "" ? ResourceManager.GetString("NoGroupType") : group.TypeName;
                    }
                    else
                    {
                        string groupnotexit = ResourceManager.GetString("lang_GroupNotExist");
                        Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>window.parent.closeprossdiv();alert(" + groupnotexit + ");window.parent.mycallfunction(geturl());</script>");//您需要修改的小组信息已不存在
                    }
                    if (System.Configuration.ConfigurationManager.AppSettings["OpenWindow"] == "1")
                    {
                        Page.ClientScript.RegisterStartupScript(Page.GetType(), "resizediv", "<script>  window.parent.lq_changeheight(geturl(), document.body.clientHeight);window.parent.change(geturl());</script>");
                    }
                    RequiredFieldValidator1.ErrorMessage = "<b>" + ResourceManager.GetString("Fieldmust") + "!<hr/>" + ResourceManager.GetString("GroupNameMust") + "</b>";//组名不能为空
                    //RequiredFieldValidator2.ErrorMessage = "<b>" + ResourceManager.GetString("Fieldmust") + "！<hr/>" + ResourceManager.GetString("GSSIFieldMust") + "</b>";//GSSI不能为空

                }

                validateEntityLength.ValidationExpression = Properties.Resources.strNameLengthValidationExpression;

                validateEntityLength.ErrorMessage = "<B>" + ResourceManager.GetString("errorUnNomal") + "</B>";
            }
            else
            {
                if (System.Configuration.ConfigurationManager.AppSettings["OpenWindow"] == "1")
                {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "resizediv", "<script>  window.parent.lq_changeheight(geturl(), document.body.clientHeight);</script>");
                }
            }
            ImageButton1.ImageUrl = ResourceManager.GetString("LangConfirm");

        }

        protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
        {

            if (!Page.IsValid) { return; }
            try
            {
                DbComponent.group edtigroup = new DbComponent.group();
                if (edtigroup.GetGroupinfo_byid(int.Parse(Request.QueryString["id"])).id == 0)
                {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("lang_ModifyFail_EntityNotExist") + "');window.parent.mycallfunction('edit_Group');</script>");
                    return;
                }

                string Group_name = TextBox1.Text.Trim();
                string GSSI = TextBox4.Text.Trim();
                int id = Convert.ToInt32(Request.QueryString["id"]);
                int isExternal = chkExternal.Checked ? 1 : 0;
                if (string.IsNullOrEmpty(GSSI))
                {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("GSSIFieldMust") + "!');</script>");
                    return;
                }
                if (!checkISSI.RegexIssiValue(GSSI))
                {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("GrouperrorNO") + "');</script>");
                    return;
                }

                if (GSSI.Length > 8)
                {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("GrouperrorNO") + "');</script>");
                    return;
                }
                string Entity_ID = HiddenField2.Value;
                Boolean status = Boolean.Parse(RadioButtonList1.SelectedValue);
                string GSSIS = HiddenField1.Value;

                if (edtigroup.CheckEditGroupInfo(Group_name, Request.QueryString["id"], Entity_ID, GSSIS.Length))
                {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("tdwztbzmcbncf") + "!');</script>");
                    return;
                }
                if (edtigroup.CheckSSIIsExist(GSSI, DbComponent.OperType.Edit, id))
                {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("GSSIExists") + "!');</script>");
                    return;
                }
                if (edtigroup.EditGroupinfo_byid(int.Parse(Request.QueryString["id"]), Group_name, GSSI, GSSIS, Entity_ID, status,isExternal))
                {
                    //去同步修改派接组、多选组、终端驻留组、等一些列
                    IList<MyModel.Model_DXGroup> alldxgroup = DXGroupInfoDaoService.GetAllResultInGissi(oldGSSI.Value);
                    log.Debug("oldGSSI:" + oldGSSI.Value);
                    foreach (MyModel.Model_DXGroup MDX in alldxgroup)
                    {
                        if (!string.IsNullOrEmpty(MDX.GSSIS))
                        {
                            string[] dxgssi = MDX.GSSIS.Split(new char[] { ';' }, StringSplitOptions.RemoveEmptyEntries);
                            string newdxgssi = "";
                            foreach (string sgssi in dxgssi)
                            {
                                if (sgssi == oldGSSI.Value)
                                {
                                    newdxgssi += GSSI + ";";
                                }
                                else
                                {
                                    newdxgssi += sgssi + ";";
                                }
                            }
                            log.Debug("newdxgssi:" + newdxgssi);
                            DXGroupInfoDaoService.UpdateGSSIByGroupIndex(MDX.Group_index, newdxgssi);
                        }
                    }



                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("Lang_ModifySucc") + "');window.parent.updatecallgroup();window.parent.lq_changeifr('manager_Group');window.parent.mycallfunction('edit_Group',258,235);</script>");
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

        protected void CustomValidator1_ServerValidate(object source, ServerValidateEventArgs args)
        {
            DbComponent.group addissi = new DbComponent.group();
            args.IsValid = true;
            if (addissi.checkGSSI(TextBox4.Text.Trim(), int.Parse(Request.QueryString["id"])) > 0)
            {
                Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("GSSIExists") + "');</script>");
                //args.IsValid = false; CustomValidator1.ErrorMessage = "<b>" + ResourceManager.GetString("InvalidDataInput") + "!<hr/>" + ResourceManager.GetString("GSSIExists") + "</b>";
            }
        }
    }
}