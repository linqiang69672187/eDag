using DbComponent.FactoryMethod;
using DbComponent.IDAO;
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
    /// GetBaseStationIDByDivID 的摘要说明
    /// </summary>
    public class GetBaseStationIDByDivID : IHttpHandler, IReadOnlySessionState
    {
        private static readonly log4net.ILog    log = log4net.LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType); 
        private IBaseStationDao BaseStationDaoService
        {
            get
            {
                return DispatchInfoFactory.CreateBaseStationDao();
            }
        }
        public void ProcessRequest(HttpContext context)
        {
            try
            {
                StringBuilder        str              = new StringBuilder("[{");
                string               strID            = context.Request["divid"].ToString();
                string               myID             = BaseStationDaoService.GetIDByDivID(strID);
                str.Append("\"bsid\":\"" + myID + "\"");
                str.Append("}]");

                context.Response.Write(str.ToString());
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