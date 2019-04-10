using DbComponent.Comm;
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
    public partial class add_DXGroup : System.Web.UI.Page
    {
        private IDXGroupInfoDao DXGroupService
        {
            get
            {
                return DispatchInfoFactory.CreateDXGroupInfoDao();
            }
        }
        private static readonly log4net.ILog log = log4net.LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);
        protected void Page_Load(object sender, EventArgs e)
        {
            Page.ClientScript.RegisterStartupScript(Page.GetType(), "LanguageSwitch", "<script>  Lang2localfunc(); </script>");

            if (!Page.IsPostBack)
            {
                Label1.Text = "<img src=\"../images/viewinfo_bg.png\" />" + ResourceManager.GetString("Lang_member_of_group");

                validateEntityLength.ValidationExpression = Properties.Resources.strNameLengthValidationExpression;
                validateEntityLength.ErrorMessage = "<b>" + ResourceManager.GetString("errorUnNomal");

                switch (Request["CMD"].ToString())
                {
                    case "CALLPANL":
                        labTitle.Text = ResourceManager.GetString("PJgroupinformation");
                        
                        break;
                    case "DXCALLPANL":
                        labTitle.Text = ResourceManager.GetString("DXgroupinformation");
                        break;
                    case "PJADD":
                        labTitle.Text = ResourceManager.GetString("PJgroupinformation");
                        if (DXGroupService.getallGroupcount(0, "", int.Parse(Request.Cookies["id"].Value), "", 1) >= int.Parse(ConfigurationManager.AppSettings["PjCount"]))
                        {
                            Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("TheMostCountPF") + ":" + "[" + ConfigurationManager.AppSettings["PjCount"] + "]');window.parent.closeprossdiv();window.parent.mycallfunction('add_DXGroup');</script>");
                        }
                        break;
                    case "DXADD":
                        labTitle.Text = ResourceManager.GetString("DXgroupinformation");
                        if (DXGroupService.getallGroupcount(0, "", int.Parse(Request.Cookies["id"].Value), "", 0) >= int.Parse(ConfigurationManager.AppSettings["DxCount"]))
                        {
                            Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("TheMostCountPF") + ":" + "[" + ConfigurationManager.AppSettings["DXCount"] + "]');window.parent.closeprossdiv();window.parent.mycallfunction('add_DXGroup');</script>");
                        }
                        break;
                    default: break;
                }
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
            RequiredFieldValidator1.ErrorMessage = "<b>" + ResourceManager.GetString("Fieldmust") + "!<hr/>" + ResourceManager.GetString("GroupNameMust") + "</b>";//组名不能为空
            ImageButton6.ImageUrl = ResourceManager.GetString("Lang_Search");

            string path = ResourceManager.GetString("Lang_Search");
            string path_un = ResourceManager.GetString("Lang_Search_un");
            string over = "javascript:this.src='" + path_un + "';";
            string mouseout = "javascript:this.src='" + path + "';";
            ImageButton6.Attributes["onmouseover"] = over;
            ImageButton6.Attributes["onmouseout"] = mouseout;               
            GridView1.Columns[1].HeaderText = ResourceManager.GetString("GroupName");
            DropDownList5.Items[0].Text = ResourceManager.GetString("hasGroupnum");
            DropDownList4.Items[0].Text = ResourceManager.GetString("GroupName");
            ImageButton1.ImageUrl = ResourceManager.GetString("LangConfirm");
            DropDownList3.Items[0].Text = ResourceManager.GetString("Lang_SelectedUnits");
        }
        private int CheckGSSI(int GSSI)
        {
            if (DXGroupService.IsExistGSSI(GSSI.ToString()))
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
                StringBuilder sbGssi = new StringBuilder();

                if (DropDownList5.Items.Count-1 > int.Parse(ConfigurationManager.AppSettings["PjMemberCount"]))
                {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("TheMostCountMember") + "[" + ConfigurationManager.AppSettings["PjMemberCount"] + "]," + ResourceManager.GetString("Haveselect") + "[" + (DropDownList5.Items.Count - 1).ToString() + "]');</script>");
                    return;
                }
                for (int i = 1; i < DropDownList5.Items.Count; i++)
                {
                    string listboxvalue = DropDownList5.Items[i].Value;

                    sbGssi.Append(listboxvalue + ";");
                }
                if (sbGssi.ToString().Trim() == "")
                {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("AtLeastOneMember") + "');</script>");
                    return;
                }

                string GName = TextBox1.Text.Trim();
                Random rd = new Random();
                int groupindex = rd.Next(255);//需要验证是否存在 存在的话重新生成
                int strGroupindex = CheckGSSI(groupindex);

                switch (Request["CMD"].ToString())
                {
                    case "CALLPANL":
                        if (DXGroupService.IsExistPJNameByEntityForAdd(GName, Request.Cookies["id"].Value) || SessionContent.JudgePjNameIsInTempPjNameList(GName))
                        {
                            Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("Nameexit") + "');</script>");
                            return;
                        }
                        SessionContent.SetTempPJNameToList(GName);

                        Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script> window.parent.frames['PJGroup_ifr'].OverAddPjGroup('" + GName + "','" + strGroupindex.ToString() + "','" + sbGssi + "');window.parent.mycallfunction('add_DXGroup');</script>");
                        break;
                    case "DXCALLPANL":
                        if (DXGroupService.IsExistDxNameByEntityForAdd(GName, Request.Cookies["id"].Value) || SessionContent.JudgeDxNameIsInTempPjNameList(GName))
                        {
                            Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("Nameexit") + "');</script>");
                            return;
                        }
                        SessionContent.SetTempDXNameToList(GName);

                        Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script> window.parent.frames['DXGroup_ifr'].OverAddPjGroup('" + GName + "','" + strGroupindex.ToString() + "','" + sbGssi + "');window.parent.mycallfunction('add_DXGroup');</script>");
                        break;
                    case "PJADD":
                        if (DXGroupService.IsExistPJNameByEntityForAdd(GName, DropDownList1.SelectedValue.ToString()))
                        {
                            Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("tdwztbzmcbncf") + "');</script>");
                            return;
                        }
                        if (DXGroupService.Add(GName, strGroupindex.ToString(), sbGssi.ToString(), DropDownList1.SelectedValue.ToString(), (int)MyModel.Enum.GroupType.Patch))
                        {
                            Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("AddSucc") + "');window.parent.lq_changeifr('manager_PJGroup');window.parent.mycallfunction('add_DXGroup');</script>");
                        }
                        else
                        {
                            Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("AddFail") + "');</script>");
                        }

                        break;
                    case "DXADD":
                        if (DXGroupService.IsExistDxNameByEntityForAdd(GName, DropDownList1.SelectedValue.ToString()))
                        {
                            Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("tdwztbzmcbncf") + "');</script>");
                            return;
                        }
                        if (DXGroupService.Add(GName, strGroupindex.ToString(), sbGssi.ToString(), DropDownList1.SelectedValue.ToString(), (int)MyModel.Enum.GroupType.Multi_Sel))
                        {
                            Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("AddSucc") + "');window.parent.lq_changeifr('manager_DXGroup');window.parent.mycallfunction('add_DXGroup');</script>");
                        }
                        else
                        {
                            Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("AddFail") + "');</script>");
                        }

                        break;
                    default: break;
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
        }


        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            LQCommonCS.ISSI.RowDataBound(DropDownList5, "ImageButton7", e);
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "", "Lang2localfunc() ", true);
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

        protected void ImageButton6_Click(object sender, ImageClickEventArgs e)
        {
            GridView1.PageIndex = 0;
        }

    }
}