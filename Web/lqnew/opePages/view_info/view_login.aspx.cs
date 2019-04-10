using System;
using System.Web.UI;

namespace Web.lqnew.opePages.view_info
{
    public partial class view_login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack&&Request.QueryString["id"]!=null)
            {
                DbComponent.login MYlogin = new DbComponent.login();
                DbComponent.Entity MYentity = new DbComponent.Entity();
                MyModel.Model_login logindetail = new MyModel.Model_login();
                logindetail = MYlogin.GetLogininfo_byid(int.Parse(Request.QueryString["id"]));
                tb1.Rows[0].Cells[1].InnerHtml = "&nbsp;&nbsp;" + logindetail.Usename;
                tb1.Rows[1].Cells[1].InnerHtml = "&nbsp;&nbsp;******";
                tb1.Rows[1].Cells[1].Attributes.Add("title", logindetail.Pwd);
                tb1.Rows[2].Cells[1].InnerHtml = "&nbsp;&nbsp;" + MYentity.GetEntityinfo_byid(int.Parse(logindetail.Entity_ID)).Name;
                int voiceType_Int = MYlogin.GetLoginParameter_byUsername(logindetail.Usename).voiceType_Int;
                if(voiceType_Int==1){
                    tb1.Rows[3].Cells[1].InnerHtml = "&nbsp;&nbsp;" + "TETRA";
                }
                else if (voiceType_Int == 2)
                {
                    tb1.Rows[3].Cells[1].InnerHtml = "&nbsp;&nbsp;" + "LTE";
                }
                else if (voiceType_Int == 3)
                {
                    tb1.Rows[3].Cells[1].InnerHtml = "&nbsp;&nbsp;" + "PDT";
                }
                else {
                    tb1.Rows[3].Cells[1].InnerHtml = "";
                }
            }
     
        }
    }
}