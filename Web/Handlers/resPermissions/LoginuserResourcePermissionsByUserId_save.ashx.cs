using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using DbComponent.resPermissions;
namespace Web.Handlers.resPermissions
{
    /// <summary>
    /// Handler1 的摘要说明
    /// </summary>
    public class Handler1 : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            String flag="";
            try{
			
			String authorityEntityAndUsertype = "";
			String selectedLoginuserId="";
			if(context.Request["selectedLoginuserId"] != null){
				selectedLoginuserId = context.Request["selectedLoginuserId"].ToString().Trim();
			}
            if (context.Request["authorityEntityAndUsertype"] != null)
            {
                authorityEntityAndUsertype = context.Request["authorityEntityAndUsertype"].ToString().Trim();
            }
            resPermissionsDao loginDaoClass = new resPermissionsDao();
            loginDaoClass.saveOrUpdateLoginuserResourcePermissions(selectedLoginuserId,authorityEntityAndUsertype);
            
			flag="1";
			
		}
		catch(Exception ex){
			flag="0";
			
		}
		String result = "{\"flag\":\""+flag+"\"}";
            context.Response.Write(result);
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