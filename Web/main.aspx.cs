using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Ryu666.Components;
namespace Web
{
    public partial class main : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            //新右键多语言化-policemouseMenu

            //Lang_dispatchopr.InnerHtml = ResourceManager.GetString("Lang_dispatchopr") + "<ul> <li id='Lang_singlecall'>" + ResourceManager.GetString("Lang_SingleCall") + "</li><li id='Lang_groupcall'>" + ResourceManager.GetString("smallGroupCall") + "</li><li id='Lang_EmergencyCall'>" + ResourceManager.GetString("Lang_EmergencyCall") + "</li><li id='Lang_YAOQIYAOBI'>" + ResourceManager.GetString("Lang_YAOQIYAOBI") + "</li><li id='Lang_CloseMonitoring'>" + ResourceManager.GetString("Lang_CloseMonitoring") + "</li><li id='Lang_EnvironmentalMonitoring'>" + ResourceManager.GetString("Lang_EnvironmentalMonitoring") + "</li></ul>";

            //Lang_ApplicationService.InnerHtml = ResourceManager.GetString("Lang_ApplicationService") + "<ul> <li id='Text_OpenRealTimeTrajectory'></li><li id='Lang_HistoricalTrace'>" + ResourceManager.GetString("Lang_HistoricalTrace") + "</li><li id='Lang_Stack'>" + ResourceManager.GetString("Lang_Stack") + "</li><li id='Lang_concern'></li><li id='locked'></li><li id='Lang_videoDispatch'>" + ResourceManager.GetString("Lang_videoDispatch") + "</li><li id='Lang_weixingshu'>" + ResourceManager.GetString("Lang_weixingshu") + "</li></ul>";

            //Lang_smsopr.InnerHtml = ResourceManager.GetString("Shortmessageservice") + "<ul> <li id='Lang_generalsms'>" + ResourceManager.GetString("Lang_generalsms") + "</li><li id='Lang_groupsms'>" + ResourceManager.GetString("Lang_groupsms") + "</li><li id='Lang_Status_message'>" + ResourceManager.GetString("Lang_Status_message") + "</li></ul>";

            ////policemouseMenu_invalide
            //Lang_ApplicationService_invalide.InnerHtml = ResourceManager.GetString("Lang_ApplicationService") + "<ul><li id='Lang_HistoricalTrace_invalide'>" + ResourceManager.GetString("Lang_HistoricalTrace") + "</li></ul>";

            //groupmouseMenu
            Lang_smallGroupCall.InnerText = ResourceManager.GetString("Lang_smallGroupCall");
            Lang_groupgroupsms.InnerText = ResourceManager.GetString("Lang_groupgroupsms");
            Lang_groupstatussms.InnerText = ResourceManager.GetString("Lang_groupstatussms");
            //dispatchmouseMenu
            Lang_dispatchsinglecall.InnerText = ResourceManager.GetString("Lang_dispatchsinglecall");
            Lang_dispatchsms.InnerText = ResourceManager.GetString("Lang_dispatchsms");
            Lang_dispatchstatussms.InnerText = ResourceManager.GetString("Lang_dispatchstatussms");

            LiCarSingleCall.InnerText = ResourceManager.GetString("Lang_SingleCall");
            LiCarSMS.InnerText = ResourceManager.GetString("Lang_generalsms");
            LiCarLocate.InnerText = ResourceManager.GetString("Lang_Location");
        }
    }
}