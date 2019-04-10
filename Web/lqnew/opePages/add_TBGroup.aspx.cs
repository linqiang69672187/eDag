using Ryu666.Components;
using System;
using System.Text;
using System.Web.UI;
using System.Web.UI.WebControls;
using Web.lqnew.other;

namespace Web.lqnew.opePages
{
    public partial class add_TBGroup : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Page.ClientScript.RegisterStartupScript(Page.GetType(), "LanguageSwitch", "<script>  Lang2localfunc(); </script>");
            this.DropDownList_TerminalType.Attributes.Add("onchange", "TerminalTypeChange('" + this.DropDownList_TerminalType.ClientID + "');");

           if (!Page.IsPostBack)
           {
               ListItem li1 = new ListItem();
               li1.Text = ResourceManager.GetString("pleaseSelectTerminalType");
               li1.Value = "pleaseSelectTerminalType";
               DropDownList_TerminalType.Items.Add(li1);
               DropDownList_TerminalType.SelectedValue = "pleaseSelectTerminalType";
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
            if (!Page.IsValid) { return; }
            DbComponent.group group = new DbComponent.group();

            try
            {

                string selecttypeName = DropDownList_TerminalType.SelectedValue.Trim();
                string name = TextBox1.Text.Trim();
                string OriginalGssi = TextBox4.Text.Trim();
                int isExternal = chkExternal.Checked ? 1 : 0;

                //组拔号串
                string pdtRuleType = hidPdtRule.Value;
                string GssiBhc = "";
                if (selecttypeName.ToLower() != "pdt")
                {
                    GssiBhc = TextBox4.Text.Trim();
                }
                else
                {
                    if (pdtRuleType == "1")
                    {
                        GssiBhc = hidBzPdtNum.Value.Trim();
                    }
                    else
                    {
                        GssiBhc = this.dropArea.SelectedValue;
                        string dhh = txtDanHu.Value.Trim();
                        GssiBhc = GssiBhc + dhh;
                    }

                }

                if (selecttypeName == "pleaseSelectTerminalType")
                {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("Lang_pleaseSelectTerminalType") + "');</script>");
                    return;
                }
                if (string.IsNullOrEmpty(OriginalGssi))
                {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("GSSIFieldMust") + "!');</script>");
                    return;
                }
                
                string entity_id = DropDownList1.SelectedValue;
                string listvalue = "";
                string err = "";
                string[] GSSIS = listvalue.Replace("<", "").Split('>');


                if (DropDownList5.Items.Count==1)
                {
                    err += "\\n        " + ResourceManager.GetString("AtLeastOneMember");
                 } 
                else
                {

                  for (int i = 1; i < DropDownList5.Items.Count; i++)
                  {
                    string listboxvalue = DropDownList5.Items[i].Value;
                    if (GssiBhc == listboxvalue)
                    {
                        err += "\\n        " + ResourceManager.GetString("CannotConnectSelfOrNotSelect");
                    }

                    if (group.checkTBgroup_GSSI(listboxvalue,0)>0)
                    {
                        err += "\\n        " + ResourceManager.GetString("hasbeselect");
                    }
                  

                     listvalue += "<"+listboxvalue+">"; 
                  }
                }
                
               
                if (err == "")
                {
                    if (group.CheckGroupInfo(name, GssiBhc, entity_id,listvalue.Length))
                    {
                        Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert(' " + ResourceManager.GetString("Lang_The_same_unit_TB_name_cannot_repeated") + "!');</script>");
                        return;
                    }
                    
                    if (group.checkOriginalGssi(GssiBhc)>0)
                    {
                        Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("tbzbzyczbncf") + "!');</script>");
                        return;
                    }
                    MyModel.Enum.AddTBGroupResult addTBGroupResult = group.AddTBGroupinfo(name, GssiBhc, listvalue, entity_id, isExternal, OriginalGssi, selecttypeName);
                    if (addTBGroupResult == MyModel.Enum.AddTBGroupResult.addsuccess)
                        Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("AddSucc") + "');window.parent.updatecallgroup();window.parent.reloadtree();window.parent.lq_changeifr('manager_TBGroup');window.parent.mycallfunction('add_TBGroup');</script>");
                    else if (addTBGroupResult == MyModel.Enum.AddTBGroupResult.isexistgroupname)
                    {
                        Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("AddFail") + ":" + ResourceManager.GetString("Lang_TBgroupName_is_same_to_xiaozu_group") + "');</script>");
                    }
                    else
                    {
                        Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("AddFail") + ":" + err + "');</script>");
                    }
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
            if (DropDownList5.Items.Count > 1)
                hidSelGssisValue.Value = "1";
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "", "Lang2localfunc() ", true);
        }


        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            LQCommonCS.ISSI.RowDataBound(DropDownList5, "ImageButton7", e);
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

        protected void CustomValidator1_ServerValidate(object source, ServerValidateEventArgs args)
        {
            DbComponent.group addissi = new DbComponent.group();
            args.IsValid = true;
            if (addissi.checkGSSI(TextBox4.Text.Trim(), 0) > 0)
            {
                Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("GSSIExists") + "');</script>");
                //args.IsValid = false; CustomValidator1.ErrorMessage = "<b>" + ResourceManager.GetString("InvalidDataInput") + "!<hr/>" + ResourceManager.GetString("GSSIExists") + "</b>";
            }
        }

        protected void ImageButton6_Click(object sender, ImageClickEventArgs e)
        {
            GridView1.PageIndex = 0;
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