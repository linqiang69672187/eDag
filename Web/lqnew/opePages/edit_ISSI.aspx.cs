using DbComponent;
using Ryu666.Components;
using System;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Web.UI;
using System.Web.UI.WebControls;
using Web.lqnew.other;

namespace Web.lqnew.opePages
{
    public partial class edit_ISSI : BasePage
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            Page.ClientScript.RegisterStartupScript(Page.GetType(), "Lang2localfunc", "<script>Lang2localfunc();</script>");
            if (!Page.IsPostBack)
            {
                Label3.Text = "<img src=\"../images/viewinfo_bg.png\" />" + ResourceManager.GetString("Lang_multicastgroup");
                Label2.Text = "<img src=\"../images/viewinfo_bg.png\" />" + ResourceManager.GetString("Lang_member_of_group");
                ValidatorBZ.ValidationExpression = Properties.Resources.strBZLenghtVaildationExpression;
                cancel.Src = ResourceManager.GetString("Lang-Cancel");
                ValidatorBZ.ErrorMessage = "<B>" + ResourceManager.GetString("errorBZ");
                if (Request.QueryString["id"] != null)
                {
                    string ID = Request.QueryString["id"].ToString();
                    //object obj = SQLHelper.ExecuteScalar(CommandType.Text, "select count(*) from User_info WHERE [ISSI] = (SELECT top 1 [ISSI] FROM [ISSI_info] where id=@id)", new SqlParameter("id", ID));
                    //if (Convert.ToInt32(obj) > 0)
                    //{
                    //防止修改出错，终端号码不允许修改
                    this.TextBox1.Enabled = false;
                    this.TextBox1.ForeColor = Color.Blue;
                    //}
                    DbComponent.group group = new DbComponent.group();
                    DbComponent.ISSI issi = new DbComponent.ISSI();
                    MyModel.Model_ISSI modeissi = new MyModel.Model_ISSI();
                    DbComponent.Entity Entity = new DbComponent.Entity();
                    DropDownList2.DataSource = group.getALLgroup_GSSI(int.Parse(Request.Cookies["id"].Value));
                    DropDownList2.DataBind();
                    modeissi = issi.GetISSIinfo_byid(int.Parse(Request.QueryString["id"]));
                    if (modeissi.id != 0)
                    {
                        TextBox1.Text = modeissi.ISSI;
                        string typeName = modeissi.typeName.Trim();
                        HiddenField_TerminalTypeKey.Value = typeName;
                        Label_TerminalType.Text = ResourceManager.GetString(typeName);
                        if (typeName == "LTE")
                        {
                            Label_ipAddress.Text = modeissi.ipAddress.Trim();
                            displayOrHideIPTr();
                        }
                        txtBZ.Text = modeissi.Bz;
                        txtModel.Value = modeissi.Productmodel;
                        txtFactury.Value = modeissi.Manufacturers;
                        Label1.Text = Entity.GetEntityinfo_byid(int.Parse(modeissi.Entity_ID)).Name;
                        string[] GSSIS = modeissi.GSSIS.Replace("<", "").Split(new string[] { ">" }, StringSplitOptions.RemoveEmptyEntries);
                        var zlz = from item in GSSIS where item.Contains("z") orderby item select item;
                        foreach (var item in zlz)
                        {
                            DropDownList2.SelectedValue = item.TrimStart('z');
                        }
                        var smz = from item in GSSIS where item.Contains("s") orderby item select item;
                        foreach (var item in smz)
                        {
                            ListItem list = new ListItem();
                            list.Value = item.TrimStart('s');
                            list.Text = group.GetGroupGroupname_byGSSI(item.TrimStart('s')) + "(" + item.TrimStart('s') + ")";
                            DropDownList5.Items.Add(list);
                        }
                        var tbz = from item in GSSIS where item.Contains("t") orderby item select item;
                        foreach (var item in tbz)
                        {
                            ListItem list = new ListItem();
                            list.Value = item.TrimStart('t');
                            list.Text = group.GetGroupGroupname_byGSSI(item.TrimStart('t')) + "(" + item.TrimStart('t') + ")";
                            DropDownList8.Items.Add(list);

                        }
                        if (modeissi.IsExternal == 1)
                            chkIsExternal.Checked = true;
                    }
                    else
                    {
                        Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>window.parent.closeprossdiv();alert('" + ResourceManager.GetString("lang_ModifyFail_EntityNotExist") + "');window.parent.mycallfunction(geturl());</script>");
                    }
                    if (System.Configuration.ConfigurationManager.AppSettings["OpenWindow"] == "1")
                    {
                        Page.ClientScript.RegisterStartupScript(Page.GetType(), "resizediv", "<script>  window.parent.lq_changeheight(geturl(), document.body.clientHeight);window.parent.change(geturl());</script>");
                    }

                }

            }
            else
            {
                if (System.Configuration.ConfigurationManager.AppSettings["OpenWindow"] == "1")
                {
                    displayOrHideIPTr();
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "resizediv", "<script>  window.parent.lq_changeheight(geturl(), document.body.clientHeight);</script>");

                }
            }
            rvTxtISSI.ErrorMessage = "<b>" + ResourceManager.GetString("Lang_ISSSIdRange2") + "</b>";
            DropDownList2.Items[0].Text = ResourceManager.GetString("Lang-None");
            DropDownList2.Items[0].Value = "0";
            DropDownList3.Items[0].Text = ResourceManager.GetString("SelectedUnits");
            DropDownList4.Items[0].Text = ResourceManager.GetString("Lang_GroupName_1");
            DropDownList4.Items[1].Text = ResourceManager.GetString("groupbz");
            ImageButton6.ImageUrl = ResourceManager.GetString("Lang_Search");
            GridView1.Columns[1].HeaderText = ResourceManager.GetString("Lang_GroupName_1");
            GridView1.Columns[2].HeaderText = ResourceManager.GetString("groupbz");
            DropDownList5.Items[0].Text = ResourceManager.GetString("Lang_AddedSaomiaozu");
            DropDownList6.Items[0].Text = ResourceManager.GetString("SelectedUnits");
            DropDownList7.Items[0].Text = ResourceManager.GetString("Lang_GroupName_1");
            DropDownList7.Items[1].Text = ResourceManager.GetString("groupbz");
            ImageButton8.ImageUrl = ResourceManager.GetString("Lang_Search");
            GridView2.Columns[1].HeaderText = ResourceManager.GetString("Lang_GroupName_1");
            DropDownList8.Items[0].Text = ResourceManager.GetString("yitianjiatongbozu");
            ImageButton1.ImageUrl = ResourceManager.GetString("LangConfirm");
            chkIsExternal.Text = ResourceManager.GetString("external_system");
        }

        protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
        {
            if (!Page.IsValid) { return; }//验证失败禁止通过提交

            Page.ClientScript.RegisterStartupScript(Page.GetType(), "resizediv", "<script>   var image1 = window.document.getElementById('Lang-Cancel');var srouce1 = window.parent.parent.GetTextByName('Lang-Cancel', window.parent.parent.useprameters.languagedata);image1.setAttribute('src', srouce1);</script>");

            try
            {
                DbComponent.ISSI addissi = new DbComponent.ISSI();
                if (addissi.GetISSIinfo_byid(int.Parse(Request.QueryString["id"])).id == 0)
                {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("lang_ModifyFail_EntityNotExist") + "');window.parent.mycallfunction('edit_ISSI');</script>");
                    return;
                }
                string ISSI = TextBox1.Text.Trim();
                if (!checkISSI.RegexIssiValue(ISSI))
                {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("Lang_ISSSIdRange2") + "');</script>");
                    return;
                }
                if (ISSI.Length > 16)
                {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("Lang_ISSSIdRange2") + "');</script>");
                    return;
                }

                //检查ISSI和类型是否在网管中
                string typeName = HiddenField_TerminalTypeKey.Value.Trim();
                string result = checkISSIAndTypeValidate(ISSI, typeName);
                if (result != "none")
                {
                    if (result.Split(',')[0] == "False")
                    {
                        Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("Lang_ISSInotinNMC") + "');</script>");
                        return;
                    }
                    else if (result.Split(',')[0] == "True" && result.Split(',')[1] != typeName)
                    {
                        Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("Lang_terminalTypeNotMarch") + "," + ResourceManager.GetString("Lang_NMCsTerminalType") + ResourceManager.GetString(result.Split(',')[1].Trim()) + "');</script>");
                        return;
                    }
                }

                string zlz = "z<" + DropDownList2.SelectedValue + ">";
                string smz = "";
                string tbz = "";
                string GSSIS = "";
                string err = "";
                for (int i = 1; i < DropDownList5.Items.Count; i++)
                {
                    string listboxvalue = DropDownList5.Items[i].Value;

                    smz += "s<" + listboxvalue + ">";
                }
                for (int i = 1; i < DropDownList8.Items.Count; i++)
                {
                    string listboxvalue = DropDownList8.Items[i].Value;
                    tbz += "t<" + listboxvalue + ">";
                }
                GSSIS = zlz + smz + tbz;
                string factory = txtFactury.Value.Trim();
                string model = txtModel.Value.Trim();
                int isExternal = 0;
                if (chkIsExternal.Checked)
                {
                    isExternal = 1;
                }
                if (err == "")
                {

                    if (addissi.checkISSI(TextBox1.Text.Trim(), int.Parse(Request.QueryString["id"])) > 0)
                    {
                        Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("Lang_ISSSHasExist") + "');</script>");
                        return;
                    }

                    //if (typeName == "LTE") {
                    //    string ipAddress = TextBox_ipAddress.Text.Trim();
                    //    bool isIp = addissi.checkIpAddressPartten(ipAddress);
                    //    if (!isIp)
                    //    {
                    //        Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("Lang_ipAddressParttenIsNotValidate") + "');</script>");

                    //        return;
                    //    }
                    //    else
                    //    {
                    //        addissi.EditISSIinfo_byid(int.Parse(Request.QueryString["id"]), ISSI, ipAddress, GSSIS, true, txtBZ.Text.Trim());
                    //    }
                    //}
                    //else
                    //{
                    addissi.EditISSIinfo_byid(int.Parse(Request.QueryString["id"]), ISSI, GSSIS, true, txtBZ.Text.Trim(),model,factory,isExternal);
                    //}
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("Lang_ModifySucc") + "');window.parent.reloadtree();window.parent.lq_changeifr('manager_ISSI');window.parent.mycallfunction('edit_ISSI');</script>");

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


        protected void GridView2_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            LQCommonCS.ISSI.RowCommand(DropDownList8, e, Label3);
        }

        protected void GridView2_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            LQCommonCS.ISSI.RowDataBound(DropDownList8, "ImageButton9", e);
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

        protected void Label3_Load(object sender, EventArgs e)
        {
            StringBuilder stb1 = new StringBuilder();
            for (int i = 1; i < DropDownList8.Items.Count; i++)
            {
                stb1.Append(DropDownList8.Items[i].Text + "\n");
            }
            Label3.Attributes.Add("title", stb1.ToString().Trim());
            Label3.Attributes.Add("style", "cursor:hand;");
        }
        protected void CustomValidator1_ServerValidate(object source, ServerValidateEventArgs args)
        {
            DbComponent.ISSI addissi = new DbComponent.ISSI();
            args.IsValid = true;
            if (addissi.checkISSI(TextBox1.Text.Trim(), int.Parse(Request.QueryString["id"])) > 0)
            {
                args.IsValid = false; CustomValidator1.ErrorMessage = "<b>" + ResourceManager.GetString("InvalidDataInput") + "!<hr/>" + ResourceManager.GetString("ISSIExists") + "</b>";
                Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("Lang_ISSSHasExist") + "');</script>");
            }
        }

        protected void ImageButton6_Click(object sender, ImageClickEventArgs e)
        {
            GridView1.PageIndex = 0;
        }

        protected void ImageButton8_Click(object sender, ImageClickEventArgs e)
        {
            GridView2.PageIndex = 0;
        }
        protected void displayOrHideIPTr()
        {
            if (HiddenField_TerminalTypeKey.Value.Trim() == "LTE")
            {
                Page.ClientScript.RegisterStartupScript(Page.GetType(), "block", "<script>document.getElementById('tr_ipAddress').style.display = 'block';</script>");

            }
            else
            {

                Page.ClientScript.RegisterStartupScript(Page.GetType(), "none", "<script>document.getElementById('tr_ipAddress').style.display = 'none';</script>");
            }
        }
        private string checkISSIAndTypeValidate(string ISSI, string typeName)
        {
            string result = "";
            DbComponent.ISSI issiclass = new DbComponent.ISSI();
            result = issiclass.checkISSIAndTypeValidate(ISSI, typeName);
            return result;
        }

    }
}