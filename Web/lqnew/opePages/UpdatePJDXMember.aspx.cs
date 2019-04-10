using DbComponent.FactoryMethod;
using DbComponent.IDAO;
using Ryu666.Components;
using System;
using System.Data;
using System.Text;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Web.lqnew.opePages
{
    public partial class UpdatePJDXMember : System.Web.UI.Page
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

           
            //DropDownList5.SelectedValue = ResourceManager.GetString(" hasGroupnum");
           
            
           // ImageButton1.Attributes["ImageUrl"] = ResourceManager.GetString("Lang_edit_entity");

            if (!Page.IsPostBack)
            {

                string path = ResourceManager.GetString("Lang_Search");
                //ImageButton6.Attributes["src"] = path;
                ImageButton6.ImageUrl = path;
                ImageButton1.Attributes["src"] = ResourceManager.GetString("Lang_edit_entity");
                string path_un = ResourceManager.GetString("Lang_Search_un");

                string over = "javascript:this.src='" + path_un + "';";
                string mouseout = "javascript:this.src='" + path + "';";
                ImageButton6.Attributes["onmouseover"] = over;
                ImageButton6.Attributes["onmouseout"] = mouseout;
                
                
                
                //ImageButton1.Attributes.Add("ImageUrl", ResourceManager.GetString("Lang_edit_entity"));
                ImageButton1.ImageUrl = ResourceManager.GetString("Lang_edit_entity");
                
               
                
                Label2.Text = "<img src=\"../images/viewinfo_bg.png\" />" + ResourceManager.GetString("Lang_member_of_group");
                ListItem mylist = new ListItem(ResourceManager.GetString("Lang_GroupName"), "Group_name");
                DropDownList4.Items.Add(mylist);
                DropDownList4.SelectedValue = "Group_name";
                DropDownList3.Items.Add(new ListItem(ResourceManager.GetString("SelectedUnits"), "0"));
                if (Request.QueryString["id"] != null)
                {              
                    string GSSIS = Request["issi"].ToString();
                    string[] GSSIs = GSSIS.Split(new char[] { ';' }, StringSplitOptions.RemoveEmptyEntries);
                    foreach (string GSSI in GSSIs)
                    {
                        DataTable dt = GroupService.GetGroupInfoByGIIS(GSSI);
                        if (dt != null && dt.Rows.Count > 0)
                        {                      
                            ListItem list = new ListItem();
                            ListItem list1 = new ListItem();
                            list.Value = GSSI;
                            list1.Value = GSSI;
                            string strStatus = "";
                            string Lang_no_use = ResourceManager.GetString("Lang_no_use");
                            string Lang_have_usen = ResourceManager.GetString("Lang_have_usen");
                            if (dt.Rows[0]["status"].ToString() == "False") {
                                strStatus = Lang_no_use;// "未使用";
                            }
                            if (dt.Rows[0]["status"].ToString() == "True")
                            {
                                strStatus = Lang_have_usen;//"已使用";
                            }
                            list1.Text = dt.Rows[0]["Group_name"].ToString() + ";" + dt.Rows[0]["status"].ToString();
                            list.Text = dt.Rows[0]["Group_name"].ToString() + "(" + GSSI + ")";
                            DropDownList5.Items.Add(list);
                            DropDownList6.Items.Add(list1);

                        }
                       
                    }


                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "resizediv", "<script>  window.parent.lq_changeheight(geturl(), document.body.clientHeight);window.parent.change(geturl());</script>");
                  

                }
            }
            else
            {
                Page.ClientScript.RegisterStartupScript(Page.GetType(), "resizediv", "<script>  window.parent.lq_changeheight(geturl(), document.body.clientHeight);</script>");

            }

        }

        protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
        {

            for (int i = 1; i < DropDownList5.Items.Count; i++)
            {
                string listboxvalue = DropDownList5.Items[i].Value;
            }

        }


        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            LQCommonCS.ISSI.RowCommand2(DropDownList6, e);
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