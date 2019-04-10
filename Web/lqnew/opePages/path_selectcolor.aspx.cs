using Ryu666.Components;
using System;
using System.Configuration;
using System.Web.UI;

namespace Web.lqnew.opePages
{
    public partial class path_selectcolor : System.Web.UI.Page
    {
        protected DbComponent.userinfo UserService
        {
            get { return new DbComponent.userinfo(); }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //判断用户电子栅栏数量是否超了            
                string youbuilding = ResourceManager.GetString("Lang_you_just_build");
                string Lang_electronic_fence = ResourceManager.GetString("Lang_electronic_fence");
                string StockadeCount = ConfigurationManager.AppSettings["StockadeCount"].ToString();
                string UserName = Request.Cookies["username"].Value;
                if (!UserService.IsRight(UserName, int.Parse(StockadeCount))) {
                    //Page.ClientScript.RegisterStartupScript(Page.GetType(), "resizediv", "<script> alert('你只能创建" + StockadeCount + "个电子栅栏');window.parent.closeprossdiv(); window.parent.mycallfunction(geturl());</script>");
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "resizediv", "<script> alert('" + youbuilding + "[" +StockadeCount +"]"+  Lang_electronic_fence + "');window.parent.closeprossdiv(); window.parent.mycallfunction(geturl());</script>");
                    return;
                }

                if (Request.QueryString["id"] != null)
                {
                    if (Request.QueryString["id"].ToString() != "")//组ID
                    {
                        MyModel.Model_userinfo model = UserService.GetUserinfo_byid(int.Parse(Request.QueryString["id"].ToString()));
                        if (model != null)
                        {
                            txtUsers.Value = model.Nam + "," + model.id + "," + model.ISSI;
                        }
                    }
                }
            }
        }
    }
}