using DbComponent.FactoryMethod;
using DbComponent.IDAO;
using MyModel;
using System.Text;
using System.Web;
using System.Web.SessionState;

namespace Web.Handlers
{
    /// <summary>
    /// ShowStockade_Handler 的摘要说明
    /// </summary>
    public class ShowStockade_Handler : IHttpHandler, IReadOnlySessionState
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
            string                      DivID            = context.Request["divid"].ToString();
            Model_Stockade              ms               = StockadeDaoService.GetStockadeByDivID(DivID);
            StockadeDaoService.ShowStockade(DivID);
            StringBuilder               sbResult         = new StringBuilder();
            sbResult.Append("[");

            sbResult.Append("{");

            sbResult.Append("\"divid\":\"" + ms.DivID + "\",");
            sbResult.Append("\"divstyle\":\"" + ms.DivStyle + "\",");
            sbResult.Append("\"type\":\"" + ms.Type + "\",");

            sbResult.Append("\"pa\":\"" + ms.PointArray + "\"");
            sbResult.Append("}");


            sbResult.Append("]");
            context.Response.Write(sbResult.ToString());
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