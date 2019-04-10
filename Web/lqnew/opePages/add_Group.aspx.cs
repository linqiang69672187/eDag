using Ryu666.Components;
using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using Web.lqnew.other;

namespace Web.lqnew.opePages
{
    public partial class add_Group : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Page.ClientScript.RegisterStartupScript(Page.GetType(), "LanguageSwitch", "<script>  Lang2localfunc(); </script>");
            //Page.ClientScript.RegisterStartupScript(Page.GetType(), "LanguageSwitch", "<script>LanguageSwitch(window.parent);</script>");
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
            ImageButton1.ImageUrl = ResourceManager.GetString("LangConfirm");
        }

        protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
        {
            if (!Page.IsValid) { return; }

            try
            {

                string selecttypeName = DropDownList_TerminalType.SelectedValue.Trim();
                string name = TextBox1.Text.Trim();
                string OriginalGssi = TextBox4.Text.Trim();
                string entity_id = DropDownList1.SelectedValue;
                int isExternal = 0;
                if (chkExternal.Checked)
                {
                    isExternal = 1;
                }
                if (selecttypeName == "pleaseSelectTerminalType")
                {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("Lang_pleaseSelectTerminalType") + "');</script>");
                    return;
                }
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

                if (string.IsNullOrEmpty(OriginalGssi))
                {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("GSSIFieldMust") + "!');</script>");
                    return;
                }
                
                DbComponent.group addentit = new DbComponent.group();

                if (addentit.CheckGroupInfo(name, OriginalGssi, entity_id,0))
                {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("tdwztbzmcbncf") + "!');</script>");
                    return;
                }

                if (addentit.checkOriginalGssi(GssiBhc)>0)
                {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("tbzbzyczbncf") + "!');</script>");
                    return;
                }

                if (addentit.AddGroupinfo(name, GssiBhc, entity_id, isExternal, OriginalGssi, selecttypeName))
                {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("AddSucc") + "');window.parent.updatecallgroup();window.parent.reloadtree();window.parent.lq_changeifr('manager_Group');window.parent.mycallfunction('add_Group',658,207);</script>");
                }
                else
                {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("AddFail") + "');</script>");
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
            DbComponent.group addissi = new DbComponent.group();
            args.IsValid = true;
            if (addissi.checkGSSI(TextBox4.Text.Trim(), 0) > 0)
            {
                Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("GSSIExists") + "');</script>");
                //args.IsValid = false; CustomValidator1.ErrorMessage = "<b>" + ResourceManager.GetString("InvalidDataInput") + "!<hr/>" + ResourceManager.GetString("GSSIExists") + "</b>";
            }
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