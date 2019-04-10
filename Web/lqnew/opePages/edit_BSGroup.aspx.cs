using DbComponent.FactoryMethod;
using DbComponent.IDAO;
using Ryu666.Components;
using System;
using System.Configuration;
using System.Text;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Web.lqnew.opePages
{
    public partial class edit_BSGroup : BasePage
    {

        private IBSGroupInfoDao BSGroupInfoService
        {
            get
            {
                return DispatchInfoFactory.CreateBSGroupInfoDao();
            }
        }
        private IBaseStationDao BSService
        {
            get
            {
                return DispatchInfoFactory.CreateBaseStationDao();
            }
        }
        private DbComponent.Entity funEntity { get { return new DbComponent.Entity(); } }
        protected void Page_Load(object sender, EventArgs e)
        {
            Page.ClientScript.RegisterStartupScript(Page.GetType(), "Lang2localfunc", "<script>Lang2localfunc();</script>");

            if (!Page.IsPostBack)
            {
                Label2.Text = "<img src=\"../images/viewinfo_bg.png\" />" + ResourceManager.GetString("Lang_member_of_group");
                string imageurl = ResourceManager.GetString("LangConfirm");
                ImageButton1.ImageUrl = imageurl;
                validateEntityLength.ValidationExpression = Properties.Resources.strNameLengthValidationExpression;

                validateEntityLength.ErrorMessage = "<B>" + ResourceManager.GetString("errorUnNomal");
                if (Request.QueryString["id"] != null)
                {

                    MyModel.Model_BSGroupInfo bsInfo = BSGroupInfoService.GetBSGroupInfoByID(int.Parse(Request.QueryString["id"]));
                    if (bsInfo != null)
                    {
                        TextBox1.Text = bsInfo.BSGroupName;

                        Label1.Text = funEntity.GetEntityinfo_byid(int.Parse(bsInfo.Entity_ID)).Name;

                        HiddenField2.Value = bsInfo.Entity_ID;

                        string[] GSSIs = bsInfo.MemberIds.Split(new char[] { ';' }, StringSplitOptions.RemoveEmptyEntries);
                        foreach (string GSSI in GSSIs)
                        {
                            try
                            {
                                ListItem list = new ListItem();
                              list.Value = GSSI.Split(new char[] { '{','}' }, StringSplitOptions.RemoveEmptyEntries)[0];//xzj--20181217--添加交换
                                string[] bsISSISwitchID = GSSI.Split(new char[] { '{', ',','}' }, StringSplitOptions.RemoveEmptyEntries);
                                list.Text = BSService.GetBaseStationByISSI(bsISSISwitchID[1], string.IsNullOrEmpty(bsISSISwitchID[0].ToString()) == true ? 0 : int.Parse(bsISSISwitchID[0].ToString())).StationName + "(" + bsISSISwitchID[0] +","+ bsISSISwitchID[1] + ")";
                                DropDownList5.Items.Add(list);
                            }
                            catch (Exception ex)
                            {
                                log.Debug(ex);
                            }
                        }
                    }
                    else
                    {
                        Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>window.parent.closeprossdiv();alert('" + ResourceManager.GetString("YouWantToEidt_BSGroup_IsNotExist") + "');window.parent.mycallfunction('edit_BSGroup');</script>");
                    }
                    if (System.Configuration.ConfigurationManager.AppSettings["OpenWindow"] == "1")
                    {
                        Page.ClientScript.RegisterStartupScript(Page.GetType(), "resizediv", "<script>  window.parent.lq_changeheight(geturl(), document.body.clientHeight);window.parent.change(geturl());</script>");
                    }
                    RequiredFieldValidator1.ErrorMessage = "<b>" + ResourceManager.GetString("Fieldmust") + "!<hr/>" + ResourceManager.GetString("GroupNameMust") + "</b>";//组名不能为空


                }
            }
            else
            {
                if (System.Configuration.ConfigurationManager.AppSettings["OpenWindow"] == "1")
                {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "resizediv", "<script>  window.parent.lq_changeheight(geturl(), document.body.clientHeight);</script>");
                }
            }
            GridView1.Columns[1].HeaderText = ResourceManager.GetString("StationName");
            GridView1.Columns[2].HeaderText = ResourceManager.GetString("BaseStationIdentification");
                        GridView1.Columns[3].HeaderText = ResourceManager.GetString("switchID");//xzj--20181217--添加交换
            DropDownList5.Items[0].Text = ResourceManager.GetString("hasGroupnum");
        }

        protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
        {

            Page.ClientScript.RegisterStartupScript(Page.GetType(), "resizediv", "<script>   var image1 = window.document.getElementById('Lang-Cancel');var srouce1 = window.parent.parent.GetTextByName('Lang-Cancel', window.parent.parent.useprameters.languagedata);image1.setAttribute('src', srouce1);</script>");
            if (BSGroupInfoService.GetBSGroupInfoByID(int.Parse(Request.QueryString["id"])) == null)
            {
                Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("Lang_ModifyFail") + "," + ResourceManager.GetString("YouWantToEidt_BSGroup_IsNotExist") + "');window.parent.mycallfunction('edit_BSGroup');</script>");
                return;
            }

            if (!Page.IsValid) { return; }
            try
            {
                if (DropDownList5.Items.Count - 1 > int.Parse(ConfigurationManager.AppSettings["BSMemberCount"]))
                {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("TheMostCountMember") + ":" + ConfigurationManager.AppSettings["BSMemberCount"] + ")," + ResourceManager.GetString("Haveselect") + (DropDownList5.Items.Count - 1).ToString() + "个');</script>");
                    return;
                }

                string Group_name = TextBox1.Text.Trim();
                string Entity_ID = HiddenField2.Value;
                DbComponent.group edtigroup = new DbComponent.group();
                string listvalue = "";
                string err = "";

                for (int i = 1; i < DropDownList5.Items.Count; i++)
                {
                    string listboxvalue = DropDownList5.Items[i].Value;
                    listvalue += "{" + listboxvalue + "};";

                }
                if (listvalue.Trim() == "")
                {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("AtLeastOneMember") + "');</script>");
                    return;
                }
                if (BSGroupInfoService.IsExistBSNameInThisEntityForEdit(Group_name, Entity_ID, int.Parse(Request.QueryString["id"])))
                {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("Is_Exist_The_Same_BSGroup_In_This_Entity") + "');</script>");
                    return;
                }

                if (err == "")
                {
                    // DXGroupInfoService.UpdateGXGroup(int.Parse(Request.QueryString["id"]), Group_name, listvalue, Entity_ID);
                    //edtigroup.EditGroupinfo_byid(int.Parse(Request.QueryString["id"]), Group_name, GSSI, listvalue, Entity_ID, status);
                    if (BSGroupInfoService.Update(Group_name, listvalue, Entity_ID, false, int.Parse(Request.QueryString["id"])))
                    {
                        Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("Lang_ModifySucc") + "');window.parent.lq_changeifr('manager_BSGroup');window.parent.mycallfunction('edit_BSGroup');</script>");
                    }
                    else
                    {
                        Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("Lang_ModifyFail") + ":" + err + "');</script>");
                    }

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


        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {

            LQCommonCS.ISSI.RowCommandForBSGroup(DropDownList5, e, Label2);//xzj--20181217--添加交换
        }


        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            LQCommonCS.ISSI.RowDataBoundforBSGroup(DropDownList5, "ImageButton7", e);//xzj--20181217--添加交换
        }

        protected void Label2_Load(object sender, EventArgs e)
        {
            StringBuilder stb1 = new StringBuilder();
            for (int i = 1; i < DropDownList5.Items.Count; i++)
            {
                stb1.Append(DropDownList5.Items[i].Text + "\n");
            }
            Label2.Attributes.Add("title", stb1.ToString().Trim());
            Label2.Attributes.Add("style", "cursor:hand;");
        }

        protected void CustomValidator1_ServerValidate(object source, ServerValidateEventArgs args)
        {

        }
    }
}