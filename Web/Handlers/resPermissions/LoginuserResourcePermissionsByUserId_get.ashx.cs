using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using DbComponent.resPermissions;
namespace Web.Handlers
{
    /// <summary>
    /// LoginuserResourcePermissionsByUserId_get ��ժҪ˵��
    /// </summary>
    public class LoginuserResourcePermissionsByUserId_get : IHttpHandler
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
            String ResourcePermissionsEntityAndUsertype = "[]";
            if (context.Request["dispatchGroup"] != null)
            {
                dispatchUserGetGroupsByLoginUserId dispatchGroup = new dispatchUserGetGroupsByLoginUserId();
                ResourcePermissionsEntityAndUsertype = dispatchGroup.getDispatchResourcePermissionsByUserId(loginUserId, subLoginUserId);
            }
            else
            {
                SubLoginuserResourcePermissions SubLoginuserResourcePermissionsClass = new SubLoginuserResourcePermissions();
                ResourcePermissionsEntityAndUsertype = SubLoginuserResourcePermissionsClass.getLoginuserResourcePermissionsByUserId(loginUserId, subLoginUserId);
            }
            context.Response.Write(ResourcePermissionsEntityAndUsertype);
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