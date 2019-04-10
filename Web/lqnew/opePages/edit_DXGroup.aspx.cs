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
    public partial class edit_DXGroup : BasePage
    {

        private IDXGroupInfoDao DXGroupInfoService
        {
            get
            {
                return DispatchInfoFactory.CreateDXGroupInfoDao();
            }
        }
        private DbComponent.group GroupService
        {
            get
            {
                return new DbComponent.group();
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            Page.ClientScript.RegisterStartupScript(Page.GetType(), "Lang2localfunc", "<script>Lang2localfunc();</script>");
            if (!Page.IsPostBack)
            {
                Label2.Text = "<img src=\"../images/viewinfo_bg.png\" />" + ResourceManager.GetString("Lang_member_of_group");
                string imageurl = ResourceManager.GetString("LangConfirm");
                ImageButton1.ImageUrl = imageurl;
                validateEntityLength.ValidationExpression = Properties.Resources.strNameLengthValidationExpression;
                validateEntityLength.ErrorMessage = "<b>" + ResourceManager.GetString("errorUnNomal");
                if (Request.QueryString["id"] != null)
                {

                    MyModel.Model_DXGroup group = DXGroupInfoService.GetDxGroupByID(int.Parse(Request.QueryString["id"]));
                    if (group != null)
                    {
                        TextBox1.Text = group.Group_name;
                        DbComponent.Entity funEntity = new DbComponent.Entity();
                        Label1.Text = funEntity.GetEntityinfo_byid(int.Parse(group.Entity_ID)).Name;
                        funEntity = null;
                        HiddenField2.Value = group.Entity_ID;

                        string[] GSSIs = group.GSSIS.Split(new char[] { ';' }, StringSplitOptions.RemoveEmptyEntries);
                        foreach (string GSSI in GSSIs)
                        {
                            ListItem list = new ListItem();
                            list.Value = GSSI;
                            list.Text = GroupService.GetGroupGroupname_byGSSI(GSSI) + "(" + GSSI + ")";
                            DropDownList5.Items.Add(list);
                        }
                    }
                    else
                    {
                        Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>window.parent.closeprossdiv();alert('" + ResourceManager.GetString("Lang_The_information_of_the_Multi_select_group_does_not_exist") + "');window.parent.mycallfunction(geturl());</script>");
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
            RequiredFieldValidator1.ErrorMessage = "<b>" + ResourceManager.GetString("Fieldmust") + "!<hr/>" + ResourceManager.GetString("GroupNameMust") + "</b>";//组名不能为空
            ImageButton6.ImageUrl = ResourceManager.GetString("Lang_Search");
           
            GridView1.Columns[1].HeaderText = ResourceManager.GetString("GroupName");
            DropDownList5.Items[0].Text = ResourceManager.GetString("hasGroupnum");
            DropDownList4.Items[0].Text = ResourceManager.GetString("GroupName");
            ImageButton1.ImageUrl = ResourceManager.GetString("LangConfirm");
            DropDownList3.Items[0].Text = ResourceManager.GetString("Lang_SelectedUnits");
        }

        protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
        {

            Page.ClientScript.RegisterStartupScript(Page.GetType(), "resizediv", "<script>   var image1 = window.document.getElementById('Lang-Cancel');var srouce1 = window.parent.parent.GetTextByName('Lang-Cancel', window.parent.parent.useprameters.languagedata);image1.setAttribute('src', srouce1);</script>");

            if (!Page.IsValid) { return; }
            try
            {
                if (DXGroupInfoService.GetDxGroupByID(int.Parse(Request.QueryString["id"])) == null) {

                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("Lang_SelectedUnits") + "');window.parent.mycallfunction('edit_DXGroup');</script>");
                    return;
                }

                string Group_name = TextBox1.Text.Trim();



                string Entity_ID = HiddenField2.Value;

                DbComponent.group edtigroup = new DbComponent.group();
                string listvalue = "";
                string err = "";
                if (DropDownList5.Items.Count-1 > int.Parse(ConfigurationManager.AppSettings["PjMemberCount"]))
                {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("TheMostCountMember") + ConfigurationManager.AppSettings["PjMemberCount"] + ResourceManager.GetString("Haveselect") + (DropDownList5.Items.Count - 1).ToString() + "');</script>");
                    return;
                }
                for (int i = 1; i < DropDownList5.Items.Count; i++)
                {
                    string listboxvalue = DropDownList5.Items[i].Value;
                    listvalue += listboxvalue + ";";

                }
                if (listvalue.Trim() == "")
                {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("AtLeastOneMember") + "');</script>");
                    return;
                }

                if (err == "")
                {
                    if (DXGroupInfoService.IsExistDxNameByEntityForEdit(Group_name, Entity_ID, int.Parse(Request.QueryString["id"]))) {
                        Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("UnitHasSameStationGroup") + "');</script>");
                        return;
                    }
                    DXGroupInfoService.UpdateGXGroup(int.Parse(Request.QueryString["id"]), Group_name, listvalue, Entity_ID);
                    //edtigroup.EditGroupinfo_byid(int.Parse(Request.QueryString["id"]), Group_name, GSSI, listvalue, Entity_ID, status);
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("Lang_ModifySucc") + "');window.parent.lq_changeifr('manager_DXGroup');window.parent.mycallfunction('edit_DXGroup');</script>");

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

            LQCommonCS.ISSI.RowCommand(DropDownList5, e, Label2);
        }


        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            LQCommonCS.ISSI.RowDataBound(DropDownList5, "ImageButton7", e);
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

        protected void ImageButton6_Click(object sender, ImageClickEventArgs e)
        {
            GridView1.PageIndex = 0;
        }
    }
}