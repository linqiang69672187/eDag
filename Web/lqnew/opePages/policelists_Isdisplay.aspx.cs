using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Web.lqnew.opePages
{
    public partial class policelists_Isdisplay : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string feedback = "";
            try
            {
                string ISSI = Request.QueryString["ISSI"];
                string ISHD = Request.QueryString["ISHD"];
                if (ISHD == "1")
                {
                    DbComponent.login.HDISSI(ISSI, Request.Cookies["username"].Value);//关闭显示
                }
                else if (ISHD == "0")
                {
                    DbComponent.login.DISISSI(ISSI, Request.Cookies["username"].Value);//打开显示
                }
                feedback = "{\"result\":\"success\"}";
            }
            catch(Exception ex){
                feedback = "{\"result\":\"fail\"}";
            }
            Response.Write(feedback);
            Response.End();
        }
    }
}