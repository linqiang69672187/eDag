using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using DbComponent.resPermissions;
namespace Web.Handlers.resPermissions
{
    /// <summary>
    /// LoginuserResourcePermissionsByUserId_edit 的摘要说明
    /// </summary>
    public class LoginuserResourcePermissionsByUserId_edit : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            String loginUserId = "";
            if (context.Request["loginUserId"] != null)
            {
                loginUserId = context.Request["loginUserId"].ToString().Trim();
            }
            String subLoginUserId = "";
            if (context.Request["subLoginUserId"] != null)
            {
                subLoginUserId = context.Request["subLoginUserId"].ToString().Trim();
            }
            SubLoginuserResourcePermissions_edit SubLoginuserResourcePermissions_editClass = new SubLoginuserResourcePermissions_edit();

            String resPermisionEdit = SubLoginuserResourcePermissions_editClass.getLoginuserResourcePermissionsByUserId(loginUserId, subLoginUserId);

            context.Response.Write(resPermisionEdit);
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