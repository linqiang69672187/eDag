using DbComponent.FactoryMethod;
using DbComponent.IDAO;
using System.Web;
using System.Web.SessionState;

namespace Web.Handlers
{
    /// <summary>
    /// ShowOrHideStockade_Handler 的摘要说明
    /// </summary>
    public class ShowOrHideStockade_Handler : IHttpHandler, IReadOnlySessionState
    {
        private IStockadeDao CreateStockadeDaoService {
            get {
                return DispatchInfoFactory.CreateStockadeDao();
            }
        }
        public void ProcessRequest(HttpContext context)
        {
            string              strResule             = "";
            if (context.Request["cmd"].ToLower() == "hide")
            {
                if (CreateStockadeDaoService.HideStockade(context.Request["divid"].ToString()))
                                strResule             = "true";
                else
                                strResule             = "false";
            }
            context.Response.Write(strResule);
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