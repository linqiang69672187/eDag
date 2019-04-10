using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.SessionState;

namespace Web.Handlers
{
    /// <summary>
    /// ADDDTCZMember 的摘要说明
    /// </summary>
    public class ADDDTCZMember : IHttpHandler, IReadOnlySessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            string GSSI = context.Request["GSSI"].ToString();
            string sendDTGissis = context.Request["sendDTGissis"].ToString();
            DbComponent.SQLHelper.ExecuteNonQuery(System.Data.CommandType.StoredProcedure, "AddToDTGroupMemberList", new System.Data.SqlClient.SqlParameter("issis", sendDTGissis), new System.Data.SqlClient.SqlParameter("gssi", GSSI));
               
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