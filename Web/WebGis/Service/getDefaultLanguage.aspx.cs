using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Text;

namespace Web.WebGis.Service
{
    public partial class getDefaultLanguage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("{");
            string defaultLanguage = ConfigurationManager.AppSettings["defaultLanguage"];

            sb.Append("\"defaultLanguage\":\"" + defaultLanguage + "\"");
            string allowLoginRole = System.Web.Configuration.WebConfigurationManager.AppSettings["LoginRole"];
            sb.Append(",\"LoginRole\":\"" + allowLoginRole + "\"");
            sb.Append("}");
            Response.Write(sb);
            Response.End();
        }
    }
}