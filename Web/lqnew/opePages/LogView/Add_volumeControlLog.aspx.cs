using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Web.lqnew.opePages.LogView
{
    public partial class Add_volumeControlLog : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            string voice ="";
               if (Request["voice"].Trim() == "0")
               {
                  voice= "Lang_hasMuted";
               }
            else{
                 voice= "Lang_hasLouded";
               }
            
            string GSSI = Request["GSSI"].Trim();
            DbComponent.LogModule.SystemLog.WriteLog(MyModel.Enum.ParameType.Other, MyModel.Enum.OperateLogType.operlog, MyModel.Enum.OperateLogModule.ModuleSystem, MyModel.Enum.OperateLogOperType.VolumeControl, voice, MyModel.Enum.OperateLogIdentityDeviceType.Other, GSSI);
            
                             
        }
    }
}