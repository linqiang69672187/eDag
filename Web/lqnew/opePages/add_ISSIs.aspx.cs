using Ryu666.Components;
using System;
using System.Text;
using System.Transactions;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Web.lqnew.opePages
{
    public partial class add_ISSIs : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Page.ClientScript.RegisterStartupScript(Page.GetType(), "LanguageSwitch", "<script>LanguageSwitch(window.parent);</script>");
            Lang_Search.ImageUrl = ResourceManager.GetString("Lang_Search");
            Lang_Search2.ImageUrl = ResourceManager.GetString("Lang_Search");
            DropDownList2.Items[0].Text = ResourceManager.GetString("Lang-None");
            DropDownList2.Items[0].Value ="0";
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

            this.DropDownList_TerminalType.Attributes.Add("onchange", "TerminalTypeChange('" + this.DropDownList_TerminalType.ClientID + "');");

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
                ValidatorBZ.ValidationExpression = Properties.Resources.strBZLenghtVaildationExpression;
                ValidatorBZ.ErrorMessage = "<B>" + ResourceManager.GetString("errorBZ");
                chkIsExternal.Text = ResourceManager.GetString("external_system");
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
            if (!Page.IsValid) { return; }
            Int32 num1 = Int32.Parse(hidNum1.Value);
            Int32 num2 = Int32.Parse(hidNum2.Value);
            //string ISSI = HiddenField1.Value;
            //if (num1 == ""||num2=="") { Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("Lang_AtleastOneISSI") + "');</script>"); return; }
            //string[] issis = ISSI.Split(',');

            #region 启用事务删除即时GIS信息，历史GIS信息，删除移动用户)

            TransactionOptions opt = new TransactionOptions();
            //设置TransactionOptions

            //opt.IsolationLevel = IsolationLevel.ReadCommitted;
            // 设置超时间隔为30分钟，默认为60秒
            opt.Timeout = new TimeSpan(0, 0,60);


            using (TransactionScope scope = new TransactionScope(TransactionScopeOption.Required,opt))
            {

                try
                {
                    
                    Int64 originalIssi = Int64.Parse(this.hidIssi1.Value.Trim());
                    for (int hn = num1; hn < num2 + 1; hn++)
                    {
                        string Entity_ID = DropDownList1.SelectedValue;
                        string zlz = "z<" + DropDownList2.SelectedValue + ">";
                        string smz = ""; string tbz = ""; string GSSIS = "";
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
                        string terminalType = DropDownList_TerminalType.SelectedValue.Trim();
                        if (terminalType == "pleaseSelectTerminalType")
                        {
                            Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("Lang_pleaseSelectTerminalType") + "');</script>");
                            return;
                        }
                        //else if (terminalType == "LTE")
                        //{
                        //    if (err == "")
                        //    {
                        //        DbComponent.ISSI addissi = new DbComponent.ISSI();
                        //        addissi.AddISSIinfo(issis[hn].Split('|')[0].Trim(),terminalType,issis[hn].Split('|')[1].Trim(), GSSIS, Entity_ID, true, txtBZ.Text);
                        //    }

                       //}
                        else
                        {
                            if (err == "")
                            {
                                int countpc1 = 0;
                                using (TransactionScope scope1 = new TransactionScope(TransactionScopeOption.Required))
                                {
                                    countpc1 = int.Parse(DbComponent.SQLHelper.ExecuteScalar(System.Data.CommandType.Text, "select count(1) from [ISSI_info] where OriginalIssi='" + originalIssi + "'").ToString());
                                    scope1.Complete();
                                }
                                int countpc2 = 0;
                                using (TransactionScope scope2 = new TransactionScope(TransactionScopeOption.Required))
                                {
                                    countpc2 = int.Parse(DbComponent.SQLHelper.ExecuteScalar(System.Data.CommandType.Text, "select count(1) from [ISSI_info] where ISSI='" + hn + "'").ToString());
                                    scope2.Complete();
                                }

                                if (countpc1+countpc2 == 0)
                                {
                                    DbComponent.ISSI addissi = new DbComponent.ISSI();
                                    int isExternal = chkIsExternal.Checked ? 1:0;
                                    addissi.AddISSIinfo(hn.ToString(), terminalType, GSSIS, Entity_ID, true, txtBZ.Text, originalIssi.ToString(), "", "", isExternal);
                                }

                                originalIssi++;
                            }
                        }
                    }

                    scope.Complete();
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("Lang_pladdAddedSucc") + "');window.parent.reloadtree();window.parent.lq_changeifr('manager_ISSI');window.parent.mycallfunction('add_ISSIs');</script>");

                }
                catch (Exception ex)
                {
                    log.Error(ex);
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("AddFail") + "');</script>");
                }
            }
            #endregion

            #region 注释
            //try
            //{  
            //    string ISSI = HiddenField1.Value;

            //    try { int.Parse(ISSI); }
            //    catch (Exception ex) {
            //        Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('ISSI必须为整数');</script>");
            //        return;
            //    }
            //    string Entity_ID = DropDownList1.SelectedValue;string zlz = "z<"+DropDownList2.SelectedValue+">";
            //    string smz = "";string tbz = "";string GSSIS = "";string err = "";
            //    for (int i =1; i < DropDownList5.Items.Count; i++)
            //    {
            //      string listboxvalue = DropDownList5.Items[i].Value;                
            //      smz += "s<" + listboxvalue+">";
            //    }
            //    for (int i = 1; i < DropDownList8.Items.Count; i++)
            //    {
            //        string listboxvalue = DropDownList8.Items[i].Value;
            //      tbz += "t<" + listboxvalue+">";
            //    }
            //    GSSIS = zlz + smz + tbz;


            //   if (err=="")
            //    {
            //       DbComponent.ISSI addissi = new DbComponent.ISSI();
            //       addissi.AddISSIinfo(ISSI,GSSIS,Entity_ID,false,txtBZ.Text);
            //       Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('添加成功');window.parent.reloadtree();window.parent.lq_changeifr('manager_ISSI');window.parent.mycallfunction('add_ISSI');</script>");
            //    } 
            //   else
            //    {
            //       Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('添加失败:" + err + "');</script>");
            //    }
            //}
            //catch (System.Exception eX)
            //{
            //    Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('添加失败');</script>");
            //}
            #endregion
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
            // ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "", "LanguageSwitch(window.parent) ", true);
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

        protected void CustomValidator1_ServerValidate(object source, ServerValidateEventArgs args)
        {
            DbComponent.ISSI addissi = new DbComponent.ISSI();
            args.IsValid = true;
            //if (addissi.checkISSI("111", 0) > 0)
            //{
            //    string strErr = "<b>" + ResourceManager.GetString("InvalidDataInput") + "!<hr/>" + ResourceManager.GetString("ISSIExists") + "</b>";
            //    args.IsValid = false;
            //    Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("Lang_ISSSHasExist") + "');</script>");
            //}
        }

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


    }
}