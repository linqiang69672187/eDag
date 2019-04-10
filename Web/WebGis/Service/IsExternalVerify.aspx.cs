using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Web.WebGis.Service
{
    public partial class IsExternalVerify : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //string s = "{\"msg\":\"" + this.IsExterVerify() + "\", \"hostAndport\":\"" + getHostAndPort() + "\"}";
            Response.Write("{\"msg\":\"" + this.IsExterVerify() + "\", \"hostURL\":\"" + getURL() + "\", \"LoginRole\":\"" + System.Web.Configuration.WebConfigurationManager.AppSettings["LoginRole"] + "\"}");
            Response.End();
        }

        /// <summary>
        /// IsExternalVerify函数读取web.config文件属性，
        /// 如果配置了IS_EXTERNAL_VERIFY的属性为true则返回true，
        /// 如果没有配置或是配置的属性不为true则返回false
        /// </summary>
        /// <returns>true or false</returns>
        private String IsExterVerify()
        {
            string resultString = null;
            try
            {
                resultString = System.Web.Configuration.
                    WebConfigurationManager.AppSettings["LoginAuthentication"];
                if (resultString == "true")
                {
                    return resultString;
                }
                return "false";
            }
            catch
            {
                return "false";
            }
        }
        //返回主机的IP和端口号
        private String getURL()
        {
            string resultString = null;
            if (IsExterVerify() == "true")
                {
                    resultString = System.Web.Configuration.
                        WebConfigurationManager.AppSettings["AuthenticationURL"];
                }
            return resultString; 
        }
    }
}