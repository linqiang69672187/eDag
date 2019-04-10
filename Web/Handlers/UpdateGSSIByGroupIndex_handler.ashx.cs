using DbComponent.FactoryMethod;
using DbComponent.IDAO;
using System.Web;
using System.Web.SessionState;

namespace Web.Handlers
{
    /// <summary>
    /// UpdateGSSIByGroupIndex_handler 的摘要说明
    /// </summary>
    public class UpdateGSSIByGroupIndex_handler : IHttpHandler, IReadOnlySessionState
    {
        private IDXGroupInfoDao DXGroupService
        {
            get
            {
                return DispatchInfoFactory.CreateDXGroupInfoDao();
            }
        }
        public void ProcessRequest(HttpContext context)
        {
            string zno              = context.Request["zno"].ToString();
            string GSSI             = context.Request["GSSI"].ToString();

            if (DXGroupService.UpdateGSSIByGroupIndex(zno, GSSI))
            {
                context.Response.Write("True");
            }
            else
            {
                context.Response.Write("False");
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