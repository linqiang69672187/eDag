using Newtonsoft.Json;
using System;
using System.Configuration;
using System.Xml;

namespace Web.WebGis.Service
{
    public partial class LanuageXmlToJson : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            XmlDocument doc = new XmlDocument();
            string defaultLanguage = ConfigurationManager.AppSettings["defaultLanguage"];
            string strFileName = Server.MapPath("../../Languages/" + defaultLanguage + "/Resources.xml");  //相对路径
            doc.Load(strFileName);
            string jsonText = JsonConvert.SerializeXmlNode(doc);
            Response.Write(jsonText);
            Response.End();
        }
    }
}