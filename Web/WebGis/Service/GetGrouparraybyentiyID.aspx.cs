using DbComponent;
using System;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using DbComponent.resPermissions;
using System.Web;
using System.Collections.Generic;
using Newtonsoft.Json.Linq;
using DbComponent.Comm.enums;

namespace Web.WebGis.Service
{
    public partial class GetGrouparraybyentiyID : System.Web.UI.Page
    {
        public JArray unit = new JArray();
        public JArray zhishu = new JArray();
        public JArray usertype = new JArray();

        public void getResPermission(String loginUserId)
        {
            try
            {
                LoginuserResourcePermissions LoginuserResourcePermissionsClass = new LoginuserResourcePermissions();
                JArray joRelust = LoginuserResourcePermissionsClass.getLoginuserResPermissionsByUserId_JObject(loginUserId);
                for (int i = 0; i < joRelust.Count; i++)
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
        public String getLoginuserResourcePermissionsStringByUserId(String userId)
        {
            String re = "";
            String LoginuserResourcePermissions = "";
            String loginuserEntityId = "";

            resPermissionsDao loginDaoClass = new resPermissionsDao();
            DataTable loginuserinfo = loginDaoClass.getLoginuserResourcePermissionsStringByUserId(userId);
            if (loginuserinfo.Rows.Count > 0)
            {
                loginuserEntityId = loginuserinfo.Rows[0]["Entity_ID"].ToString();
                try
                {

                    if (loginuserinfo.Rows[0]["accessUnitsAndUsertype"] != null)
                    {
                        LoginuserResourcePermissions = loginuserinfo.Rows[0]["accessUnitsAndUsertype"].ToString();
                    }
                }
                catch (Exception ex)
                {

                }
            }
            re = "{\"loginuserEntityId\":\"" + loginuserEntityId + "\",\"LoginuserResourcePermissions\":[" + LoginuserResourcePermissions + "]}";
            return re;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            List<int> entity = new List<int>();
            List<int> zhishuEntity = new List<int>();

            StringBuilder sb = new StringBuilder();
            string EntityID = Request.Cookies["id"].Value.Trim();
            string loginUserId = Request.Cookies["loginUserId"].Value.ToString();
            getResPermission(loginUserId);

            try
            {

                //unit
                if (unit != null && unit.Count != 0)
                {
                    for (int i = 0; i < unit.Count; i++)
                    {
                        JObject jo = (JObject)unit[i];
                        entity.Add(Convert.ToInt32(jo["entityId"].ToString()));
                    }
                }
                //zhishu
                if (zhishu != null && zhishu.Count != 0)
                {
                    for (int i = 0; i < zhishu.Count; i++)
                    {
                        JObject jo = (JObject)zhishu[i];
                        zhishuEntity.Add(Convert.ToInt32(jo["entityId"].ToString()));
                    }
                }
                //usertype
                if (usertype != null && usertype.Count != 0)
                {
                    for (int i = 0; i < usertype.Count; i++)
                    {
                        JObject jo = (JObject)usertype[i];
                        zhishuEntity.Add(Convert.ToInt32(jo["entityId"].ToString()));
                    }
                }

            }
            catch (Exception ex)
            {
                Response.Write("[]");
                Response.End();
            }
            int groupNum = 0;
            sb.Append("[");
            if (entity.Count > 0)
            {
                for (int i = 0; i < entity.Count; i++)
                {
                    DataTable dt = SQLHelper.ExecuteRead(CommandType.Text, "WITH lmenu(name,id) as (SELECT name,id  FROM [Entity] WHERE id=@Entity_ID UNION ALL SELECT A.NAME,A.id FROM [Entity] A,lmenu b where a.[ParentID] = b.id) SELECT [Group_name],[GSSI]  FROM [Group_info] where [GSSIS]='0' and [Entity_ID] in (select id from lmenu)", "group", new SqlParameter("Entity_ID", entity[i]));
                    for (int countdt = 0; countdt < dt.Rows.Count; countdt++)
                    {
                        if (groupNum >= 20)
                        {
                            sb.Remove(sb.Length - 1, 1);
                            sb.Append("]");
                            Response.Write(sb);
                            Response.End();
                        }
                        sb.Append("{\"groupname\":\"");
                        sb.Append(dt.Rows[countdt][0].ToString());
                        sb.Append("\",\"GSSI\":\"");
                        sb.Append(dt.Rows[countdt][1].ToString());
                        //if (countdt != dt.Rows.Count - 1)
                        //{
                        sb.Append("\"},");
                        //}
                        //else
                        //{
                        //    sb.Append("\"}");
                        //}
                        groupNum++;
                    }
                }
            }
            if (zhishuEntity.Count > 0)
            {
                DataTable dt = SQLHelper.ExecuteRead(CommandType.Text, "SELECT [Group_name],[GSSI],[Entity_ID]  FROM [Group_info] where  [GSSIS]='0' and [Entity_ID] = @Entity_ID ", "group", new SqlParameter("Entity_ID", EntityID));
                for (int countdt = 0; countdt < dt.Rows.Count; countdt++)
                {
                    bool isTrue = false;
                    for (int i = 0; i < zhishuEntity.Count; i++)
                    {
                        if (Convert.ToInt32(dt.Rows[countdt][2].ToString()) == zhishuEntity[i])
                        { isTrue = true; }
                    }
                    if (isTrue)
                    {
                        if (groupNum >= 20)
                        {
                            sb.Remove(sb.Length - 1, 1);
                            sb.Append("]");
                            Response.Write(sb);
                            Response.End();
                        }
                        sb.Append("{\"groupname\":\"");
                        sb.Append(dt.Rows[countdt][0].ToString());
                        sb.Append("\",\"GSSI\":\"");
                        sb.Append(dt.Rows[countdt][1].ToString());
                        //if (countdt != dt.Rows.Count - 1)
                        //{
                        sb.Append("\"},");
                        //}
                        //else
                        //{
                        //    sb.Append("\"}");
                        //}
                        groupNum++;
                    }
                }
            }
            sb.Remove(sb.Length - 1, 1);
            sb.Append("]");
            Response.Write(sb);
            Response.End();
            //DataTable dt = SQLHelper.ExecuteRead(CommandType.Text, "SELECT [Group_name],[GSSI],[Entity_ID]  FROM [Group_info] where [Entity_ID] = @Entity_ID ", "group", new SqlParameter("Entity_ID", EntityID));

            //for (int countdt = 0; countdt < dt.Rows.Count; countdt++)
            //{
            //    sb.Append("{\"groupname\":\"");
            //    sb.Append(dt.Rows[countdt][0].ToString());
            //    sb.Append("\",\"GSSI\":\"");
            //    sb.Append(dt.Rows[countdt][1].ToString());
            //    if (countdt != dt.Rows.Count - 1)
            //    {
            //        sb.Append("\"},");
            //    }
            //    else
            //    {
            //        sb.Append("\"}");
            //    }
            //}
            //sb.Append("]");
            //Response.Write(sb);
            //Response.End();
        }

    }
}