using Ryu666.Components;
using System;
using System.Text;
using System.Web.UI;
using System.Web.UI.WebControls;
using Web.lqnew.other;

namespace Web.lqnew.opePages
{
    public partial class edit_TBGroup : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            Page.ClientScript.RegisterStartupScript(Page.GetType(), "Lang2localfunc", "<script>Lang2localfunc();</script>");

            if (!Page.IsPostBack)
            {
                Label2.Text = "<img src=\"../images/viewinfo_bg.png\" />" + ResourceManager.GetString("Lang_member_of_group");

                if (Request.QueryString["id"] != null)
                {
                    MyModel.Model_group group = new MyModel.Model_group();
                    DbComponent.group groupfunction = new DbComponent.group();
                    group = groupfunction.GetGroupinfo_byid(int.Parse(Request.QueryString["id"]));
                    if (group.id != 0)
                    {
                        TextBox1.Text = group.Group_name;
                        tbgrouptype.Text = group.TypeName == "" ? ResourceManager.GetString("NoGroupType") : group.TypeName;
                        TextBox4.Text = group.GSSI;
                        chkExternal.Checked = group.isExternal == 1 ? true : false;
                        DbComponent.Entity funEntity = new DbComponent.Entity();
                        Label1.Text = funEntity.GetEntityinfo_byid(int.Parse(group.Entity_ID)).Name;
                        funEntity = null;
                        HiddenField2.Value = group.Entity_ID;
                        RadioButtonList1.SelectedValue = group.status.ToString();
                        string[] GSSIs = group.GSSIS.Replace(">", "").Split(new char[] { '<' }, StringSplitOptions.RemoveEmptyEntries);
                        foreach (string GSSI in GSSIs)
                        {
                            ListItem list = new ListItem();
                            list.Value = GSSI;
                            list.Text = groupfunction.GetGroupGroupname_byGSSI(GSSI) + "(" + GSSI + ")";
                            DropDownList5.Items.Add(list);
                        }
                    }
                    else
                    {
                        string TBnotexist = ResourceManager.GetString("lang_TGroupNotExist");
                        Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>window.parent.closeprossdiv();alert(" + TBnotexist + ");window.parent.mycallfunction(geturl());</script>");//您需要修改的通播组信息已不存在
                    }
                    if (System.Configuration.ConfigurationManager.AppSettings["OpenWindow"] == "1")
                    {
                        Page.ClientScript.RegisterStartupScript(Page.GetType(), "resizediv", "<script>  window.parent.lq_changeheight(geturl(), document.body.clientHeight);window.parent.change(geturl());</script>");
                    }
                    RequiredFieldValidator1.ErrorMessage = "<b>" + ResourceManager.GetString("Fieldmust") + "!<hr/>" + ResourceManager.GetString("GroupNameMust") + "</b>";//组名不能为空
                    //RequiredFieldValidator2.ErrorMessage = "<b>" + ResourceManager.GetString("Fieldmust") + "!<hr/>" + ResourceManager.GetString("GSSIFieldMust") + "</b>";//GSSI不能为空
                    validateEntityLength.ValidationExpression = Properties.Resources.strNameLengthValidationExpression;
                    validateEntityLength.ErrorMessage = "<B>" + ResourceManager.GetString("errorUnNomal");

                }
            }
            else
            {
                if (System.Configuration.ConfigurationManager.AppSettings["OpenWindow"] == "1")
                {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "resizediv", "<script>  window.parent.lq_changeheight(geturl(), document.body.clientHeight);</script>");
                }
            }
            DropDownList3.Items[0].Text = ResourceManager.GetString("SelectedUnits");
            DropDownList4.Items[0].Text = ResourceManager.GetString("GroupName");
            DropDownList4.Items[1].Text = ResourceManager.GetString("groupbz");
            GridView1.Columns[1].HeaderText = ResourceManager.GetString("GroupName");
            GridView1.Columns[2].HeaderText = ResourceManager.GetString("groupbz");
            DropDownList5.Items[0].Text = ResourceManager.GetString("hasGroupnum");
            ImageButton1.ImageUrl = ResourceManager.GetString("LangConfirm");
            ImageButton6.ImageUrl = ResourceManager.GetString("Lang_Search");
        }

        protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
        {
            
            Page.ClientScript.RegisterStartupScript(Page.GetType(), "resizediv", "<script>   var image1 = window.document.getElementById('Lang-Cancel');var srouce1 = window.parent.parent.GetTextByName('Lang-Cancel', window.parent.parent.useprameters.languagedata);image1.setAttribute('src', srouce1);</script>");
            if (!Page.IsValid) { return; }
            try
            {
                DbComponent.group edtigroup = new DbComponent.group();
                if (edtigroup.GetGroupinfo_byid(int.Parse(Request.QueryString["id"])).id == 0)
                {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("lang_ModifyFail_TBgroupNotExist") + "');window.parent.mycallfunction('edit_TBGroup');</script>");// 修改失败，因为您需要修改的通播组信息已不存在'
                    return;
                }
                int id = Convert.ToInt32(Request.QueryString["id"]);
                string Group_name = TextBox1.Text.Trim();
                string GSSI = TextBox4.Text.Trim();
                int isExternal = chkExternal.Checked ? 1 : 0;
                if (string.IsNullOrEmpty(GSSI))
                {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("lang_The_tag_of_TB_cannot_null") + "');</script>");//通播组标识不能为空!'
                    return;
                }
                if (!checkISSI.RegexIssiValue(GSSI))
                {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("tbzbzbxwzs") + "');</script>");//通播组标识必须为整数'
                    return;
                }
                //try { int.Parse(GSSI); }
                //catch (Exception ex)
                //{
                //    Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('通播组标识必须为整数');</script>");
                //    return;
                //}
                if (GSSI.Length > 8)
                {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("tbzbzbxxy8w") + "');</script>"); //通播组标识必须小于8位'
                    return;
                }
                string Entity_ID = HiddenField2.Value;
                Boolean status = Boolean.Parse(RadioButtonList1.SelectedValue);
               // string GSSIS = ""; //HiddenField1.Value;
               
                string listvalue = "";
                string err = "";
                if (DropDownList5.Items.Count == 1)
                {
                    string AtLeastOneMember = ResourceManager.GetString("AtLeastOneMember");
                    //err += "\\n        至少需要一个成员组";
                    err += "\\n        " + AtLeastOneMember;
                }
                else
                {
                    for (int i = 1; i < DropDownList5.Items.Count; i++)
                    {
                        string listboxvalue = DropDownList5.Items[i].Value;
                        if (GSSI == listboxvalue)
                        {
                            string CannotConnectSelfOrNotSelect = ResourceManager.GetString("CannotConnectSelfOrNotSelect");
                            //err += "\\n        不能关联自身(GSSI)";
                            err += "\\n        " + CannotConnectSelfOrNotSelect;
                        }

                        if (edtigroup.checkTBgroup_GSSI(listboxvalue, int.Parse(Request.QueryString["id"])) > 0)
                        {
                            string hasbeselect = ResourceManager.GetString("hasbeselect");
                            //err += "\\n        GSSI(" + listboxvalue + ")已被关联";
                            err += "\\n        GSSI(" + listboxvalue + ")" + hasbeselect;
                        }
                        listvalue += "<" + listboxvalue + ">";

                    }
                }

                if (err == "")
                {
                    if (edtigroup.CheckEditGroupInfo(Group_name,Request.QueryString["id"], Entity_ID,listvalue.Length))
                    {
                        Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("Lang_The_same_unit_TB_name_cannot_repeated") + "');</script>");//同单位中，通播组名称不能重复！'
                        return;
                    }

                    if (edtigroup.CheckSSIIsExist(GSSI, DbComponent.OperType.Edit,id))
                    {
                        Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("tbzbzyczbncf") + "');</script>");//通播组标识已存在，不能重复！'
                        return;
                    }

                    if(edtigroup.EditGroupinfo_byid(int.Parse(Request.QueryString["id"]), Group_name, GSSI, listvalue, Entity_ID, status,isExternal))
                        Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("Lang_ModifySucc") + "');window.parent.updatecallgroup();window.parent.lq_changeifr('manager_TBGroup');window.parent.mycallfunction('edit_TBGroup');</script>");//修改成功'
                    else
                        Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("Lang_ModifyFail") + "');</script>");
                }
                else
                {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("Lang_ModifyFail") + ":" + err + "');</script>"); //修改失败

                }

            }
            catch (System.Exception eX)
            {
                log.Error(eX);
                Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("Lang_ModifyFail") + "');</script>");//修改失败'
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
                if (DropDownList5.Items[i].Text!=""){
                stb1.Append(DropDownList5.Items[i].Text + "\n");
                }
            }
            Label2.Attributes.Add("title", stb1.ToString().Trim());
            Label2.Attributes.Add("style", "cursor:hand;");
        }

        protected void CustomValidator1_ServerValidate(object source, ServerValidateEventArgs args)
        {
            DbComponent.group addissi = new DbComponent.group();
            args.IsValid = true;
            if (addissi.checkGSSI(TextBox4.Text.Trim(), int.Parse(Request.QueryString["id"])) > 0)
            {
                Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("tbzbzyczbncf_1") + "');</script>");//通播组标识已存在'
                //args.IsValid = false; CustomValidator1.ErrorMessage = "<b>" + ResourceManager.GetString("InvalidDataInput") + "!<hr/>" + ResourceManager.GetString("GSSIExists") + "</b>";
            }
        }

        protected void Label2_Unload(object sender, EventArgs e)
        {

        }

        protected void DropDownList5_TextChanged(object sender, EventArgs e)
        {

        }

        protected void ImageButton6_Click(object sender, ImageClickEventArgs e)
        {
            GridView1.PageIndex = 0;
        }
    }
}