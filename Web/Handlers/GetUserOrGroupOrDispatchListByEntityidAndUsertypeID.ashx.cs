using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.SessionState;

namespace Web.Handlers
{
    /// <summary>
    /// GetUserOrGroupOrDispatchListByEntityidAndUsertypeID 的摘要说明
    /// </summary>
    public class GetUserOrGroupOrDispatchListByEntityidAndUsertypeID : IHttpHandler, IReadOnlySessionState
    {
        private DbComponent.userinfo userInfoService {
            get {
                return new DbComponent.userinfo();
            }
        }
        private DbComponent.DispatchInfoDao dispatchInfoService {
            get {
                return new DbComponent.DispatchInfoDao();
            }
        }
        private DbComponent.group groupService {
            get {
                return new DbComponent.group();
            }
        }
        public void ProcessRequest(HttpContext context)
        {
            string entityid = context.Request["entityid"].ToString();
            string typeid = context.Request["typeid"].ToString();
            string mtype = context.Request["mtype"].ToString();
            DataTable dt = new DataTable();
            if (mtype == "user")
            {
                if (typeid == "-1")
                {
                    dt = userInfoService.GetUsersByEntityID(entityid);
                }
                else if (typeid == "zhishu")
                {
                    dt = userInfoService.GetZhiShuUsersByEntityID(entityid);
                }
                else
                {
                    dt = userInfoService.GetUsersByEntityIDAndTypeName(entityid, typeid);
                }
            }
            else if (mtype == "group")
            {
                dt = groupService.GetGroupsByEntityId(entityid);
            }
            else if (mtype == "dispatch")
            {
                dt = dispatchInfoService.GetDispatchsByEntityId(entityid);
            }

            string strResult = DbComponent.Comm.TypeConverter.DataTable2ArrayJson(dt);
            context.Response.Write(strResult);
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