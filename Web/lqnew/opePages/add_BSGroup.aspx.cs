using DbComponent.FactoryMethod;
using DbComponent.IDAO;
using Ryu666.Components;
using System;
using System.Configuration;
using System.Reflection;
using System.Text;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Web.lqnew.opePages
{
    public partial class add_BSGroup : System.Web.UI.Page
    {
        private IBSGroupInfoDao BSGroupService
        {
            get
            {
                return DispatchInfoFactory.CreateBSGroupInfoDao();
            }
        }
        private static readonly log4net.ILog log = log4net.LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);
        protected void Page_Load(object sender, EventArgs e)
        {
            Page.ClientScript.RegisterStartupScript(Page.GetType(), "LanguageSwitch", "<script>  Lang2localfunc(); </script>");

            if (!Page.IsPostBack)
            {
                if (System.Configuration.ConfigurationManager.AppSettings["OpenWindow"] == "1")
                {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "resizediv", "<script>  window.parent.lq_changeheight(geturl(), document.body.clientHeight);window.parent.change(geturl());</script>");
                }
                RequiredFieldValidator1.ErrorMessage = "<b>" + ResourceManager.GetString("Fieldmust") + "!<hr/>" + ResourceManager.GetString("GroupNameMust") + "</b>";//组名不能为空
                validateEntityLength.ValidationExpression = Properties.Resources.strNameLengthValidationExpression;

                validateEntityLength.ErrorMessage = "<B>" + ResourceManager.GetString("errorUnNomal");

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
            ImageButton1.ImageUrl = ResourceManager.GetString("LangConfirm");
        }
        private int CheckGSSI(int GSSI)
        {
            if (BSGroupService.IsExistBSGISSI(GSSI.ToString()))
            {
                Random rd = new Random();
                int groupindex = rd.Next(255);
                return CheckGSSI(groupindex);
            }
            else
                return GSSI;
        } 
        protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
        {

            try
            {
                if (DropDownList5.Items.Count - 1 > int.Parse(ConfigurationManager.AppSettings["BSMemberCount"]))
                {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("TheMostCountMember") + ":" + ConfigurationManager.AppSettings["BSMemberCount"] + "," + ResourceManager.GetString("Haveselect") + (DropDownList5.Items.Count - 1).ToString() + "');</script>");
                    return;
                }

                StringBuilder sbGssi = new StringBuilder();


                for (int i = 1; i < DropDownList5.Items.Count; i++)
                {
                    string listboxvalue = DropDownList5.Items[i].Value;

                    sbGssi.Append("{" + listboxvalue + "};");//xzj--20181217--添加交换
                }
                if (sbGssi.ToString().Trim() == "")
                {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("AtLeastOneMember") + "');</script>");
                    return;
                }

                string GName = TextBox1.Text.Trim();
                string EntityID = DropDownList1.SelectedItem.Value.ToString();
                if (BSGroupService.IsExistBSNameInThisEntity(GName, EntityID))
                {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("tdwztbzmcbncf") + "');</script>");
                    return;
                }

                Random rand = new Random();
               
                if (BSGroupService.Save(GName, sbGssi.ToString(), EntityID, false, CheckGSSI(rand.Next(255)).ToString()))
                {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("AddSucc") + "');window.parent.lq_changeifr('manager_BSGroup');window.parent.mycallfunction('add_BSGroup');</script>");
                }
                else
                {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("AddFail") + "');</script>");
                }
            }
            catch (System.Exception eX)
            {
                log.Error(eX);
            }



        }



        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {

            LQCommonCS.ISSI.RowCommandForBSGroup(DropDownList5, e, Label1);//xzj--20181217--添加交换
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "", "Lang2localfunc() ", true);
        }


        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            LQCommonCS.ISSI.RowDataBoundforBSGroup(DropDownList5, "ImageButton7", e);//xzj--20181217--添加交换
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

        }

    }
}