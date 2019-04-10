using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.SessionState;

namespace Web.Handlers.StatuesManage
{
    /// <summary>
    /// DelUserDuty 的摘要说明
    /// </summary>
    public class DelUserDuty : IHttpHandler, IReadOnlySessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            string pid = context.Request["pid"].ToString();//第几页
            string sql = "delete from user_duty where id=@pid";
            try
            {
                DbComponent.SQLHelper.ExecuteNonQuery(System.Data.CommandType.Text, sql, new SqlParameter("pid", pid));
                context.Response.Write("[{\"result\":\"" + Ryu666.Components.ResourceManager.GetString("PATCH_DELETE_SUCCESS") + "\"}]");
            }
            catch (Exception e) {
                context.Response.Write("[{\"result\":\"" + Ryu666.Components.ResourceManager.GetString("PATCH_DELETE_FAIL") + "\"}]");
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