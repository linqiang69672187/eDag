using DbComponent.FactoryMethod;
using DbComponent.IDAO;
using MyModel;
/*
 * 杨德军
 * **/
using System;
using System.Reflection;
using System.Text;
using System.Web;
using System.Web.SessionState;

namespace Web.Handlers
{
    /// <summary>
    /// GetBaseStationInfo 的摘要说明
    /// </summary>
    public class GetBaseStationInfo : IHttpHandler, IReadOnlySessionState
    {
        private static readonly log4net.ILog log = log4net.LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType); 
        private IBaseStationDao BaseStationService {
            get {
                return DispatchInfoFactory.CreateBaseStationDao();
            }
        }
        public void ProcessRequest(HttpContext context)
        {
            try
            {
                StringBuilder            sbResult                   = new StringBuilder("[{");
                string                   strStationissi             = context.Request["stationissi"].ToString();
                    int switchID = string.IsNullOrEmpty(context.Request["switchID"].ToString()) == true ? 0 : int.Parse(context.Request["switchID"].ToString());//xzj--20181217--添加交换
                Model_BaseStation MBS = BaseStationService.GetBaseStationByISSI(strStationissi, switchID);
                if (MBS != null)
                {                    
                    sbResult.Append("\"sswitchID\":" + MBS.SwitchID + ",");
                    sbResult.Append("\"sname\":" + "\"" + MBS.StationName + "\",");
                    sbResult.Append("\"sissi\":" + "\"" + MBS.StationISSI + "\",");
                    sbResult.Append("\"slo\":" + "\"" + MBS.Lo + "\",");
                    sbResult.Append("\"sla\":" + "\"" + MBS.La + "\"");
                }
                sbResult.Append("}]");
                context.Response.Write(sbResult.ToString());
            }
            catch (Exception ex)
            {
                log.Error(ex);
            }
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}