using DbComponent.FactoryMethod;
using DbComponent.IDAO;
using MyModel;
/*
 * 杨德军
 * **/
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.SessionState;

namespace Web.Handlers
{
    /// <summary>
    /// GetStockade_Handler 的摘要说明
    /// </summary>
    public class GetStockade_Handler : IHttpHandler, IReadOnlySessionState
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
            string                       LoginName               = "admin";
            if (context.Request.Cookies["username"] != null)
            {
                                         LoginName               = context.Request.Cookies["username"].Value.ToString();
            }
            IList<Model_Stockade>        myList                  = StockadeDaoService.GetStockadeListByLoginName(LoginName);
            StringBuilder                sbResult                = new StringBuilder();
            sbResult.Append("[");
            int                          flag                    = 0;
            foreach (Model_Stockade md in myList)
            {
                sbResult.Append("{");

                sbResult.Append("\"divid\":\"" + md.DivID + "\",");
                sbResult.Append("\"divstyle\":\"" + md.DivStyle + "\",");
                sbResult.Append("\"type\":\"" + md.Type + "\",");
                int lastStatus = StockadeDaoService.GetLastSatusByDivID(md.DivID);
                sbResult.Append("\"LastStatus\":\"" + lastStatus + "\",");
                sbResult.Append("\"pa\":\"" + md.PointArray + "\"");
                if (flag == myList.Count() - 1)
                {
                    sbResult.Append("}");
                }
                else
                {
                    sbResult.Append("},");
                }

                flag++;
            }
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