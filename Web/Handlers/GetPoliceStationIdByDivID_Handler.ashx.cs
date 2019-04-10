using DbComponent;
using System.Web;
using System.Web.SessionState;

namespace Web.Handlers
{
    /// <summary>
    /// GetPoliceStationIdByDivID_Handler 的摘要说明
    /// </summary>
    public class GetPoliceStationIdByDivID_Handler : IHttpHandler, IReadOnlySessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            Entity e = new Entity();
            context.Response.Write(e.GetIdByDivID(context.Request["divid"].ToString()));
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