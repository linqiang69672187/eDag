using DbComponent.FactoryMethod;
using DbComponent.IDAO;
using System.Web;
using System.Web.SessionState;

namespace Web.Handlers
{
    /// <summary>
    /// IsStockadeTitleExist 的摘要说明
    /// </summary>
    public class IsStockadeTitleExist : IHttpHandler, IReadOnlySessionState
    {

        private IStockadeDao StockadeDaoService
        {
            get
            {
                return DispatchInfoFactory.CreateStockadeDao();
            }
        }
        public void ProcessRequest(HttpContext context)
        {
            string              stockadetitle                = context.Request["title"].ToString();
            if (StockadeDaoService.IsExist(stockadetitle))
            {
                context.Response.Write("1");
            }
            else {
                context.Response.Write("0");
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