using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.SessionState;

namespace Web.Handlers
{
    /// <summary>
    /// DeleteDTGMemberToDb 的摘要说明
    /// </summary>
    public class DeleteDTGMemberToDb : IHttpHandler, IReadOnlySessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            string strResult = "";
            string str_sids = context.Request["sids"].ToString();
            string str_dtgroupid = context.Request["dtgroupid"].ToString();
            try {
                DbComponent.SQLHelper.ExecuteNonQuery(System.Data.CommandType.StoredProcedure, "DelMemberFromDTGroup", new System.Data.SqlClient.SqlParameter("issis", str_sids), new System.Data.SqlClient.SqlParameter("gssi", str_dtgroupid));
                strResult = Ryu666.Components.ResourceManager.GetString("PATCH_DELETE_SUCCESS");
            }
            catch (Exception ex)
            {
                strResult = Ryu666.Components.ResourceManager.GetString("PATCH_DELETE_FAIL");
            }
            finally
            {

                context.Response.Write("{\"result\":\"" + strResult + "\"}");
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