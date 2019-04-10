using System;
using System.Reflection;
using Ryu666.Components;
using System.Collections;
using System.Collections.Generic;


namespace Web
{
    public partial class Default : System.Web.UI.Page
    {
        private static readonly log4net.ILog log = log4net.LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);

        protected void Page_Load(object sender, EventArgs e)
        {
            //int a = int.Parse("fdsfds");            
            lbEntityInformation.Text = System.Configuration.ConfigurationManager.AppSettings["entityinformation"];
            //新右键多语言化-policemouseMenu
           
            Lang_dispatchopr.InnerHtml = ResourceManager.GetString("Lang_dispatchopr") + "<ul> <li id='Lang_singlecall'>" + ResourceManager.GetString("Lang_SingleCall") + "</li><li id='Lang_groupcall'>" + ResourceManager.GetString("Lang_groupcall") + "</li></ul>";
            Lang_ApplicationService.InnerHtml = ResourceManager.GetString("Lang_ApplicationService") + "<ul> <li id='Lang_Location'>" + ResourceManager.GetString("Lang_Location") + "</li><li id='locked'></li><li id='Lang_concern'></li></ul>";
            Lang_smsopr.InnerHtml = ResourceManager.GetString("Lang_smsopr") + "<ul> <li id='Lang_generalsms'>" + ResourceManager.GetString("Lang_generalsms") + "</li><li id='Lang_groupsms'>" + ResourceManager.GetString("Lang_groupsms") + "</li><li id='Lang_Status_message'>" + ResourceManager.GetString("Lang_Status_message") + "</li></ul>";
            //groupmouseMenu
            Lang_smallGroupCall.InnerText = ResourceManager.GetString("Lang_smallGroupCall");
            Lang_groupgroupsms.InnerText = ResourceManager.GetString("Lang_groupgroupsms");
            Lang_groupstatussms.InnerText = ResourceManager.GetString("Lang_groupstatussms");
            //dispatchmouseMenu
            Lang_dispatchsinglecall.InnerText = ResourceManager.GetString("Lang_dispatchsinglecall");
            Lang_dispatchsms.InnerText = ResourceManager.GetString("Lang_dispatchsms");
            Lang_dispatchstatussms.InnerText = ResourceManager.GetString("Lang_dispatchstatussms");

            DbComponent.LogModule.SystemLog.getLogPression(Server.MapPath(System.Configuration.ConfigurationManager.AppSettings["logconfigpath"].ToString()));
   
        }        
    }
}