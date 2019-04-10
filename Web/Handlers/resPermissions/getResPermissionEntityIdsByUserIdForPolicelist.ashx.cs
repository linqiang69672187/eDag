using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Text;
using System.Data;
using System.Linq;
using System.Data.SqlClient;
using Newtonsoft.Json.Linq;
using DbComponent.resPermissions;
namespace Web.Handlers.resPermissions
{
    /// <summary>
    /// getResPermissionEntityIdsByUserIdForPolicelist 的摘要说明
    /// </summary>
    public class getResPermissionEntityIdsByUserIdForPolicelist : IHttpHandler
    {
        public String ResPermissionEntityIds = "";
        public JArray unit = new JArray();
        public JArray zhishu = new JArray();
        public JArray usertype = new JArray();
        public void ProcessRequest(HttpContext context)
        {
            String loginUserId = "";
            if (context.Request["loginUserId"] != null)
            {
                loginUserId = context.Request["loginUserId"].ToString().Trim();
            }
            getResPermission(loginUserId);
            ResPermissionEntityIds = getResPermissionEntityIdsByUserId(loginUserId);
            context.Response.Write(ResPermissionEntityIds);
        }
        public String getResPermissionEntityIdsByUserId(String loginUserId)
        {
            String entityIdsAndUsertypes = "";
            StringBuilder EntityIds = new StringBuilder();
            StringBuilder usertypes = new StringBuilder();
            for (int i = 0; i < unit.Count(); i++)
            {
                JObject jo = (JObject)unit[i];
                String enId = jo["entityId"].ToString();
                String enIds = GetAllChildrenID(Int32.Parse(enId));
                EntityIds.Append(enIds);
            }
            for (int i = 0; i < zhishu.Count(); i++)
            {
                JObject jo = (JObject)zhishu[i];
                String enId = jo["entityId"].ToString();
                EntityIds.Append(enId);
                EntityIds.Append(",");
            }
            entityIdsAndUsertypes = "{\"EntityIds\":[" + EntityIds + "],\"usertypes\":" + usertype.ToString()+"}";
            return entityIdsAndUsertypes;
        }
        #region 查询下级及所有子级单位ID
        protected string GetAllChildrenID(int id)
        {
            StringBuilder sb = new StringBuilder();
            DataTable dt = DbComponent.SQLHelper.ExecuteRead(CommandType.Text, "WITH lmenu(name,id,[ParentID]) as (SELECT name,id,[ParentID]  FROM [Entity] WHERE id=@id UNION ALL    SELECT A.NAME,A.id,A.ParentID FROM [Entity] A,lmenu b    where a.ParentID = b.[ID]) select id from lmenu", "getParentID", new SqlParameter("id", id));
            sb.Append(",");
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                sb.Append(dt.Rows[i][0].ToString() + ",");
            }

            return sb.ToString();
        }
        #endregion
        public void getResPermission(String loginUserId)
        {
            try
            {
                LoginuserResourcePermissions LoginuserResourcePermissionsClass = new LoginuserResourcePermissions();
                JArray joRelust = LoginuserResourcePermissionsClass.getLoginuserResPermissionsByUserId_JObject(loginUserId);
                for (int i = 0; i < joRelust.Count(); i++)
                {
                    if (joRelust[i]["unit"] != null)
                    {
                        unit = JArray.Parse(joRelust[i]["unit"].ToString());
                    }
                    if (joRelust[i]["zhishu"] != null)
                    {
                        zhishu = JArray.Parse(joRelust[i]["zhishu"].ToString());
                    }
                    if (joRelust[i]["usertype"] != null)
                    {
                        usertype = JArray.Parse(joRelust[i]["usertype"].ToString());
                    }
                }
            }
            catch (Exception ex) { }
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