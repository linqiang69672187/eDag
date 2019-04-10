using DbComponent.Comm;
using System.Data;
using System.Web;
using System.Web.SessionState;

namespace Web.Handlers
{
    /// <summary>
    /// GetUserLoLaInfoByISSI 的摘要说明
    /// </summary>
    public class GetUserLoLaInfoByISSI : IHttpHandler, IReadOnlySessionState
    {
        private DbComponent.WebSQLDb UserService
        {
            get
            {
                return new DbComponent.WebSQLDb(System.Configuration.ConfigurationManager.AppSettings["m_connectionString"].ToString());
            }
        }
        public void ProcessRequest(HttpContext context)
        {
            string                      issi        = context.Request["issi"].ToString();
            DbComponent.userinfo        ui          = new DbComponent.userinfo();
            MyModel.Model_userinfo      mu          = ui.GetUserInofByISSI(issi);
            if (mu != null)
            {
                DataSet                 ds          = UserService.CIInfoGet(mu.id.ToString());
                if (ds != null && ds.Tables.Count > 0)
                {
                    string              strResult   = TypeConverter.DataTable2ArrayJson(ds.Tables[0]);
                    context.Response.Write(strResult);
                    context.Response.End();
                }
                else
                {
                    context.Response.Write("[]");
                    context.Response.End();
                }
            }
            else
            {
                context.Response.Write("[]");
                context.Response.End();
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