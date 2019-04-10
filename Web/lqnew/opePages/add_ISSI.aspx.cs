using Ryu666.Components;
using System;
using System.Text;
using System.Web.UI;
using System.Web.UI.WebControls;
using Web.lqnew.other;

namespace Web.lqnew.opePages
{
    public partial class add_ISSI : BasePage
    {
        bool ISSIExists = false;
        bool ISSIAndTypeValidate = true;
        protected void Page_Load(object sender, EventArgs e)
        {
            //MultiLanguages
            Page.ClientScript.RegisterStartupScript(Page.GetType(), "LanguageSwitch", "<script>LanguageSwitch(window.parent);</script>");
            Lang_Search.ImageUrl = ResourceManager.GetString("Lang_Search");
            Lang_Search2.ImageUrl = ResourceManager.GetString("Lang_Search");
            //RangeValidator1.ErrorMessage = "<B>" + ResourceManager.GetString("Lang_ISSS") + ResourceManager.GetString("Lang_ISSSIdRange2");
            DropDownList2.Items[0].Text = ResourceManager.GetString("Lang-None");
            DropDownList2.Items[0].Value = "0";
            DropDownList3.Items[0].Text = ResourceManager.GetString("Lang_SelectedUnits");
            DropDownList4.Items[0].Text = ResourceManager.GetString("Lang_GroupName_1");
            DropDownList4.Items[1].Text = ResourceManager.GetString("groupbz");
            GridView1.Columns[1].HeaderText = ResourceManager.GetString("Lang_GroupName_1");
            GridView1.Columns[2].HeaderText = ResourceManager.GetString("groupbz");
            DropDownList5.Items[0].Text = ResourceManager.GetString("Lang_AddedSaomiaozu");
            DropDownList6.Items[0].Text = ResourceManager.GetString("Lang_SelectedUnits");
            DropDownList7.Items[0].Text = ResourceManager.GetString("Lang_GroupName_1");
            DropDownList7.Items[1].Text = ResourceManager.GetString("groupbz");
            GridView2.Columns[1].HeaderText = ResourceManager.GetString("Lang_GroupName_1");
            GridView2.Columns[2].HeaderText = ResourceManager.GetString("groupbz");
            DropDownList8.Items[0].Text = ResourceManager.GetString("Lang_AddedTongbozu");
            chkIsExternal.Text = ResourceManager.GetString("external_system");

            this.DropDownList_TerminalType.Attributes.Add("onchange", "TerminalTypeChange('"+this.DropDownList_TerminalType.ClientID+"');");

            if (!Page.IsPostBack)
            {
                ListItem li1 = new ListItem();
                li1.Text = ResourceManager.GetString("pleaseSelectTerminalType");
                li1.Value = "pleaseSelectTerminalType";
                DropDownList_TerminalType.Items.Add(li1);
                DropDownList_TerminalType.SelectedValue = "pleaseSelectTerminalType";


                DbComponent.group group = new DbComponent.group();
                DropDownList2.DataSource = group.getALLgroup_GSSI(int.Parse(Request.Cookies["id"].Value));
                DropDownList2.DataBind();
                if (System.Configuration.ConfigurationManager.AppSettings["OpenWindow"] == "1")
                {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "resizediv", "<script>  window.parent.lq_changeheight(geturl(), document.body.clientHeight);window.parent.change(geturl());</script>");
                }
                //RequiredFieldValidator1.ErrorMessage = "<b>" + ResourceManager.GetString("Fieldmust") + "!<hr/>" + ResourceManager.GetString("ISSIFieldMust") + "</b>";//ISSI不能为空

                ValidatorBZ.ValidationExpression = Properties.Resources.strBZLenghtVaildationExpression;
                ValidatorBZ.ErrorMessage = "<B>" + ResourceManager.GetString("errorBZ");
            }
            else
            {
                if (System.Configuration.ConfigurationManager.AppSettings["OpenWindow"] == "1")
                {
                    //displayOrHideIPTr();
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "resizediv", "<script>  window.parent.lq_changeheight(geturl(), document.body.clientHeight);</script>");

                }
            }

        }

        protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
        {
            if (!Page.IsValid) { return; }

            try
            {
                //-- Zhangq 改--
                string selecttypeName = DropDownList_TerminalType.SelectedValue.Trim();
                string pdtRuleType = hidPdtRule.Value;
                string ISSI ="";
                if (selecttypeName.ToLower() != "pdt")
                {
                    ISSI = TextBox1.Text.Trim();
                }
                else
                {
                    if (pdtRuleType == "1")
                    {
                        ISSI = hidBzPdtNum.Value.Trim();
                    }
                    else
                    {
                        ISSI=this.dropArea.SelectedValue;
                        string dhh = txtDanHu.Value.Trim();
                        int l = 5 - dhh.Length;
                        if(l>0)
                        {
                            for (int i = 0; i < l; i++)
                            {
                                dhh = "0" + dhh;
                            }
                        }
                        ISSI = ISSI + dhh;
                    }

                }

                //Response.Write("<scritp>alert(" + ISSI + ");</script>");
                //Response.End();
                //-- END---

                string factury = txtFactury.Value.Trim();
                string model = txtModel.Value.Trim();
                int isExternal = 0;
                if (chkIsExternal.Checked)
                {
                     isExternal = 1;
                }
                if (!checkISSI.RegexIssiValue(ISSI))
                {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("Lang_ISSSMustInt") + "');</script>");
                    return;
                }

                if (ISSI.Length > 16)
                {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("Lang_ISSSMustLess16") + "');</script>");
                    return;
                }
                string Entity_ID = DropDownList1.SelectedValue; string zlz = "z<" + DropDownList2.SelectedValue + ">";
                string smz = ""; string tbz = ""; string GSSIS = ""; string err = "";
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


                if (err == "")
                {
                    DbComponent.ISSI addissi = new DbComponent.ISSI();
                    string orginalIssi = TextBox1.Text.Trim();
                    //Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('"+orginalIssi+"');</script>");
                    //验证终端标识唯一性
                    if (addissi.checkOriginalIssi(orginalIssi) > 0)
                    {
                        Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("Lang_OriginalISSSHasExist") + "');</script>");
                        return;
                    }

                    if (addissi.checkISSI(ISSI, 0) > 0)
                    {
                        Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("Lang_ISSSHasExist") + "');</script>");
                        return;
                    }
                    //检查ISSI和类型是否在网管中
                    //string inputISSI = TextBox1.Text.Trim();
                   
                    string result = checkISSIAndTypeValidate(ISSI, selecttypeName);
                    if (result != "none")
                    {
                        if (result.Split(',')[0] == "False")
                        {
                            Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("Lang_ISSInotinNMC") + "');</script>");
                            return;
                        }
                        else if (result.Split(',')[0] == "True" && result.Split(',')[1] != selecttypeName)
                        {
                            Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("Lang_terminalTypeNotMarch") + "," + ResourceManager.GetString("Lang_NMCsTerminalType") + ResourceManager.GetString(result.Split(',')[1].Trim()) + "');</script>");
                            return; 
                        }
                    }

                    if (selecttypeName == "pleaseSelectTerminalType")
                    {
                        Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("Lang_pleaseSelectTerminalType") + "');</script>");
                        return;
                    }
                    //else if (selecttypeName == "LTE")
                    //{
                    //    string ipadd = input_ipAddress.Text.Trim();
                    //    if (ipadd == "")
                    //    {
                    //        Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("Lang_pleaseInputIpAddress") + "');</script>");
                    //        return;
                    //    }
                    //    else
                    //    {
                    //        bool isIp = addissi.checkIpAddressPartten(ipadd);
                    //        if (!isIp)
                    //        {
                    //            Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("Lang_ipAddressParttenIsNotValidate") + "');</script>");

                    //            return;
                    //        }
                    //        else
                    //        {
                    //            addissi.AddISSIinfo(ISSI, DropDownList_TerminalType.SelectedValue.Trim(), ipadd, GSSIS, Entity_ID, true, txtBZ.Text.Trim());
                    //        }
                    //    }

                    //}
                    else
                    {
                        addissi.AddISSIinfo(ISSI, DropDownList_TerminalType.SelectedValue.Trim(), GSSIS, Entity_ID, true, txtBZ.Text.Trim(),orginalIssi,factury,model,isExternal);
                    }
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("AddSucc") + "');window.parent.reloadtree();window.parent.lq_changeifr('manager_ISSI');window.parent.mycallfunction('add_ISSI');</script>");

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



        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            LQCommonCS.ISSI.RowCommand(DropDownList5, e, Label1);
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "", "LanguageSwitch(window.parent) ", true);
        }


        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            LQCommonCS.ISSI.RowDataBound(DropDownList5, "ImageButton7", e);
        }


        protected void GridView2_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            LQCommonCS.ISSI.RowCommand(DropDownList8, e, Label2);
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "", "LanguageSwitch(window.parent) ", true);
        }

        protected void GridView2_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            LQCommonCS.ISSI.RowDataBound(DropDownList8, "ImageButton9", e);
        }

        protected void Label1_Load(object sender, EventArgs e)
        {
            StringBuilder stb1 = new StringBuilder();
            for (int i = 1; i < DropDownList5.Items.Count; i++)
            {
                stb1.Append(DropDownList5.Items[i].Text + "\n");
            }
            Label1.Attributes.Add("title", stb1.ToString().Trim());
            Label1.Attributes.Add("style", "cursor:hand;");
        }

        protected void Label2_Load(object sender, EventArgs e)
        {
            StringBuilder stb1 = new StringBuilder();
            for (int i = 1; i < DropDownList8.Items.Count; i++)
            {
                stb1.Append(DropDownList8.Items[i].Text + "\n");
            }
            Label2.Attributes.Add("title", stb1.ToString().Trim());
            Label2.Attributes.Add("style", "cursor:hand;");
        }

        //protected void CustomValidator1_ServerValidate(object source, ServerValidateEventArgs args)
        //{
        //    CustomValidator1.ErrorMessage = "test";
        //    if (TextBox1.Text != "")
        //    {
        //        DbComponent.ISSI addissi = new DbComponent.ISSI();
        //        args.IsValid = true;
        //        if (addissi.checkISSI(TextBox1.Text.Trim(), 0) > 0)
        //        {
        //            ISSIExists = true;
        //            string strErr = "<b>" + ResourceManager.GetString("InvalidDataInput") + "!<hr/>" + ResourceManager.GetString("ISSIExists") + "</b>";
        //            args.IsValid = false;
        //            CustomValidator1.ErrorMessage = strErr;
        //            Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("Lang_ISSSHasExist") + "');</script>");
        //        }
        //        else
        //        {
        //            ISSIExists = false;

        //        }
        //    }
        //}

        protected void ImageButton6_Click(object sender, ImageClickEventArgs e)
        {
            GridView1.PageIndex = 0;
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "", "LanguageSwitch(window.parent) ", true);
        }

        protected void ImageButton8_Click(object sender, ImageClickEventArgs e)
        {
            GridView2.PageIndex = 0;
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "", "LanguageSwitch(window.parent) ", true);
        }

        protected void DropDownList_TerminalType_DataBound(object sender, EventArgs e)
        {
            for (int i = 0; i < DropDownList_TerminalType.Items.Count; i++)
            {
                DropDownList_TerminalType.Items[i].Text = ResourceManager.GetString(DropDownList_TerminalType.Items[i].Value.Trim());
            }
        }

        protected void CustomValidator2_ServerValidate(object source, ServerValidateEventArgs args)
        {

        }

        protected void DropDownList_TerminalType_SelectedIndexChanged(object sender, EventArgs e)
        {
            //displayOrHideIPTr();
           

        }


        protected void displayOrHideIPTr()
        {
            if (DropDownList_TerminalType.SelectedValue.Trim() == "LTE")
            {
                Page.ClientScript.RegisterStartupScript(Page.GetType(), "block", "<script>document.getElementById('tr_ipAddress').style.display = 'block';</script>");

            }
            else
            {
                input_ipAddress.Text = "";
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