#region
/*
 * 杨德军
 * **/
#endregion
using DbComponent.FactoryMethod;
using DbComponent.IDAO;
using System.Reflection;
using System.Web;
using System.Web.SessionState;

namespace Web.Handlers
{
    /// <summary>
    /// UpdateLastStatus 的摘要说明
    /// </summary>
    public class UpdateLastStatus : IHttpHandler, IReadOnlySessionState
    {
        private IIsInStockadeViewDao IsInStockadeViewDaoService
        {
            get
            {
                return DispatchInfoFactory.CreateIsInStockadeViewDao();
            }
        }
        private static readonly log4net.ILog log = log4net.LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);
        public void ProcessRequest(HttpContext context)
        {
            log.Info("RequestToEditStockade");
            string ID                            = context.Request["id"].ToString();
            string strStatus                     = context.Request["status"].ToString();
            if (IsInStockadeViewDaoService.UpdateLastStatus(int.Parse(ID), strStatus))
            {
                log.Info(ID + "-" + strStatus + "-success");
                context.Response.Write("{\"message\":\"" + Ryu666.Components.ResourceManager.GetString("Success") + "\"}");//多语言:成功
            }
            else 
            {
                log.Info(ID + "-" + strStatus + "-fail");
                context.Response.Write("{\"message\":\"" + Ryu666.Components.ResourceManager.GetString("Failed") + "\"}");//多语言:失败
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