using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using DbComponent.resPermissions;
using System.Text;
namespace Web.Handlers.resPermissions
{
    /// <summary>
    /// getSubEntityAndUsertypeByEntityIdRecursive 的摘要说明
    /// </summary>
    public class getSubEntityAndUsertypeByEntityIdRecursive : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            String loginuserEntityId = "";
            if (context.Request["loginuserEntityId"] != null)
            {
                loginuserEntityId = context.Request["loginuserEntityId"].ToString().Trim();
            }
            String nodeId = "";
            if (context.Request["nodeId"] != null)
            {
                nodeId = context.Request["nodeId"].ToString().Trim();
            }
            String EntityId = loginuserEntityId;
            Boolean isCallBack = false;
            if (nodeId != "" && nodeId != loginuserEntityId)
            {
                isCallBack = true;
                EntityId = nodeId;
            }
            
            SubEntityAndUsertypeByEntityId SubEntityAndUsertypeByEntityIdClass = new SubEntityAndUsertypeByEntityId();
            
            StringBuilder subEntityAndUsertype = new StringBuilder();
            subEntityAndUsertype.Append("[");
            subEntityAndUsertype.Append(SubEntityAndUsertypeByEntityIdClass.getSubEntityAndUsertypeByEntityId(EntityId, isCallBack));
            subEntityAndUsertype.Append("]");
            String subEntityAndUsertypeString = subEntityAndUsertype.ToString();
            context.Response.Write(subEntityAndUsertypeString);
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