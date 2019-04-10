using Ryu666.Components;
using System;
using System.Collections.Specialized;
using System.Web.UI.WebControls;

namespace Web.lqnew.opePages
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                InitPageLanguage();
                BuildDrawDownList();

                ddlLanguage.SelectedValue = ResourceManager.SiteLanguageKey;
            }

        }

        /// <summary>
        /// 生成语言选择下拉列表
        /// </summary>
        private void BuildDrawDownList()
        {
            NameValueCollection languages = ResourceManager.GetSupportedLanguages();
            for (int i = 0; i < languages.Count; i++)
            {
                ListItem item = new ListItem(languages[i], languages.Keys[i]);
                ddlLanguage.Items.Add(item);
            }
        }

        /// <summary>
        /// 初始化页面语言
        /// </summary>
        private void InitPageLanguage()
        {

            TextBox1.Text = ResourceManager.GetString("ChooseUsername_UnknownFailure");
        }

        protected void ddlLanguage_SelectedIndexChanged(object sender, EventArgs e)
        {
            //HttpCookie userLanguageCookie = new HttpCookie("userLanguage", ddlLanguage.SelectedValue);
            //Response.Cookies.Set(userLanguageCookie);

            //切换用户语言
            Session["userLanguage"] = ddlLanguage.SelectedValue;


            InitPageLanguage();
        }
    }
}