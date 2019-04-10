using DbComponent;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.SessionState;
using System.Reflection;

using System.Web.UI;
using System.Web.UI.WebControls;

using DbComponent.resPermissions;
using Newtonsoft.Json.Linq;
using System.Text;

namespace Web.Handlers
{
    /// <summary>
    /// SearchUserOrGroupOrDispatchList 的摘要说明
    /// </summary>
    public class SearchUserOrGroupOrDispatchList : IHttpHandler, IReadOnlySessionState
    {
        private static readonly log4net.ILog log = log4net.LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);
        public JArray unit = new JArray();
        public JArray zhishu = new JArray();
        public JArray usertype = new JArray();
        public void ProcessRequest(HttpContext context)
        {
            try
            {

                string txtCondtion = context.Request["txtCondtion"].ToString();
                string mtype = context.Request["mtype"].ToString();

                String loginuserId = context.Request.Cookies["loginUserId"].Value;
                getResPermission(loginuserId);
                String respermissionString = getRespermissionString();//-------"100/1/100:1;100:2"----------"直属，直属/循环/单位：类型；单位：类型"
                String respermissionString_G =getzu(respermissionString);
                          

                DataTable dt = new DataTable();
               // string strSqlEntity = "WITH lmenu(id) as (SELECT id  FROM [Entity] WHERE id='" + context.Request.Cookies["id"].Value + "' UNION ALL SELECT A.id FROM [Entity] A,lmenu b    where a.[ParentID] = b.id) ";

                //string strSQL = "";
                string typename_G = Ryu666.Components.ResourceManager.GetString("Group");
                string typename_D = Ryu666.Components.ResourceManager.GetString("Dispatch");
                string typename_B = Ryu666.Components.ResourceManager.GetString("Station");//xzj--20190218--添加基站短信
                string StoredProcedureName = "SearchUserOrGroupOrDispatchListByResPermission";
               
                string txtCondtion_p = stringfilter.Filter(txtCondtion.Trim());
                dt = SQLHelper.ExecuteReadStrProc(CommandType.StoredProcedure, StoredProcedureName, "aaa",
                       new SqlParameter("respermission", respermissionString),
                       new SqlParameter("respermission_G", respermissionString_G),
                       new SqlParameter("mtype", mtype),
                        new SqlParameter("txtCondtion", txtCondtion_p),
                    new SqlParameter("typename_G", typename_G),
                    new SqlParameter("typename_D", typename_D),
                    new SqlParameter("typename_B", typename_B)//xzj--20190218--添加基站短信
                   );
               
                //string strSqlEntity = "WITH lmenu(id) as (SELECT id  FROM [Entity] WHERE id='" + context.Request.Cookies["id"].Value + "' UNION ALL SELECT A.id FROM [Entity] A,lmenu b    where a.[ParentID] = b.id) ";

                //string strSQL = "";
                //if (mtype == "user")
                //{
                //    strSQL = strSqlEntity + " SELECT User_info.id,User_info.Nam uname,User_info.ISSI uissi,[TYPE] utype,ucheck='0',ISSI_info.typeName issitype from User_info left outer join ISSI_info on (User_info.ISSI=ISSI_info.ISSI) where User_info.ISSI!='' and  User_info.Entity_ID in (select id from lmenu) and (User_info.Nam like '%" + stringfilter.Filter(txtCondtion.Trim()) + "%' or User_info.ISSI like '%" + stringfilter.Filter(txtCondtion.Trim()) + "%') ";

                //}
                //else if (mtype == "group")
                //{
                //    strSQL = strSqlEntity + " SELECT id,Group_name uname,GSSI uissi,utype='" + Ryu666.Components.ResourceManager.GetString("Group") + "',ucheck='0' from Group_info   where GSSI!='' and  Entity_ID in (select id from lmenu) and (Group_name like '%" + stringfilter.Filter(txtCondtion.Trim()) + "%' or GSSI  like '%" + stringfilter.Filter(txtCondtion.Trim()) + "%') ";
                //}
                //else if (mtype == "dipatch")
                //{
                //    strSQL = "SELECT id,IPAddress uname,issi uissi,utype='" + Ryu666.Components.ResourceManager.GetString("Dispatch") + "',ucheck='0' from Dispatch_Info where ISSI!='' and IPAddress like '%" + stringfilter.Filter(txtCondtion.Trim()) + "%' or issi  like '%" + stringfilter.Filter(txtCondtion.Trim()) + "%' ";
                //}
                //else if (mtype == "usergroup")
                //{
                //    strSQL = strSqlEntity + " SELECT id,Nam uname,ISSI uissi,[TYPE] utype,ucheck='0' from User_info where ISSI!='' and  Entity_ID in (select id from lmenu) and  (Nam like '%" + stringfilter.Filter(txtCondtion.Trim()) + "%' or issi  like '%" + stringfilter.Filter(txtCondtion.Trim()) + "%') ";
                //    strSQL += " union SELECT id,Group_name uname,GSSI uissi,utype='" + Ryu666.Components.ResourceManager.GetString("Group") + "',ucheck='0' from Group_info   where GSSI!='' and  Entity_ID in (select id from lmenu) and  (Group_name like '%" + stringfilter.Filter(txtCondtion.Trim()) + "%' or GSSI  like '%" + stringfilter.Filter(txtCondtion.Trim()) + "%') ";
                //}
                //else if (mtype == "userdispatch")
                //{
                //    strSQL = strSqlEntity + " SELECT id,Nam uname,ISSI uissi,[TYPE] utype,ucheck='0' from User_info where ISSI!='' and  Entity_ID in (select id from lmenu) and  Nam like '%" + stringfilter.Filter(txtCondtion.Trim()) + "%' or issi  like '%" + stringfilter.Filter(txtCondtion.Trim()) + "%' ";
                //    strSQL += "union SELECT id,IPAddress uname,issi uissi,utype='" + Ryu666.Components.ResourceManager.GetString("Dispatch") + "',ucheck='0' from Dispatch_Info where ISSI!='' and IPAddress like '%" + stringfilter.Filter(txtCondtion.Trim()) + "%' or issi  like '%" + stringfilter.Filter(txtCondtion.Trim()) + "%' ";
                //}
                //else if (mtype == "groupdispatch")
                //{
                //    strSQL = strSqlEntity + " SELECT id,IPAddress uname,issi uissi,utype='" + Ryu666.Components.ResourceManager.GetString("Dispatch") + "',ucheck='0' from Dispatch_Info where ISSI!='' and IPAddress like '%" + stringfilter.Filter(txtCondtion.Trim()) + "%' or issi  like '%" + stringfilter.Filter(txtCondtion.Trim()) + "%' ";
                //    strSQL += " union SELECT id,Group_name uname,GSSI uissi,utype='" + Ryu666.Components.ResourceManager.GetString("Group") + "',ucheck='0' from Group_info   where GSSI!='' and  Entity_ID in (select id from lmenu) and ( Group_name like '%" + stringfilter.Filter(txtCondtion.Trim()) + "%' or GSSI  like '%" + stringfilter.Filter(txtCondtion.Trim()) + "%') ";
                //}
                //else if (mtype == "all")
                //{
                //    strSQL = strSqlEntity + " SELECT id,IPAddress uname,issi uissi,utype='" + Ryu666.Components.ResourceManager.GetString("Dispatch") + "',ucheck='0' from Dispatch_Info where ISSI!='' and IPAddress like '%" + stringfilter.Filter(txtCondtion.Trim()) + "%' or issi  like '%" + stringfilter.Filter(txtCondtion.Trim()) + "%' ";
                //    strSQL += " union SELECT id,Nam uname,ISSI uissi,[TYPE] utype,ucheck='0' from User_info where ISSI!='' and Entity_ID in (select id from lmenu) and  (Nam like '%" + stringfilter.Filter(txtCondtion.Trim()) + "%' or issi  like '%" + stringfilter.Filter(txtCondtion.Trim()) + "%') ";
                //    strSQL += " union SELECT id,Group_name uname,GSSI uissi,utype='" + Ryu666.Components.ResourceManager.GetString("Group") + "',ucheck='0' from Group_info   where GSSI!='' and  Entity_ID in (select id from lmenu) and  (Group_name like '%" + stringfilter.Filter(txtCondtion.Trim()) + "%' or GSSI  like '%" + stringfilter.Filter(txtCondtion.Trim()) + "%') ";
                //}
               // dt = DbComponent.SQLHelper.ExecuteRead(CommandType.Text, strSQL, "aaa", new SqlParameter("txtCondtion", txtCondtion));


                string strResult = DbComponent.Comm.TypeConverter.DataTable2ArrayJson(dt);
                context.Response.Write(strResult);
            }
            catch (System.Exception er)
            {
                log.Debug(er.Message + "::::::freeman:::::SearchUserOrGroupOrDispatchList.ashx");
            }
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
        public String  getzu(string respermissionString)
        {
            String[] arr = respermissionString.Split(new Char[] { '/' });
            if (arr.Length == 3)
            {
                String temp = arr.Last();
                StringBuilder zhishu = new StringBuilder(arr.First());
                if (temp != "" && temp != null)
                {
                    string[] entityandtype = temp.Split(new Char[] { ';' });
                    for (int i = 0; i < entityandtype.Length; i++)
                    {
                        string zhishuentity = entityandtype[i].Split(new Char[] { ':' }).First();
                        if (zhishu.ToString() == "")
                        {
                            zhishu.Append(zhishuentity);
                        }
                        else
                        {
                            zhishu.Append("," + zhishuentity);
                        }
                    }
                }
               string  respermissionString_G = zhishu.ToString() + "/" + arr[1] + "/" + arr[2];
               return respermissionString_G;
            }
            return respermissionString;
        }
         //获取权限
        public void getResPermission(String loginUserId)
        {
            try
            {
                LoginuserResourcePermissions LoginuserResourcePermissionsClass = new LoginuserResourcePermissions();
                JArray joRelust = new JArray();
                joRelust = LoginuserResourcePermissionsClass.getLoginuserResPermissionsByUserId_JObject(loginUserId);
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
        public String getRespermissionString()
        {
            StringBuilder respermissionString = new StringBuilder();
            int zhishuCount = 0;
            for (int i = 0; i < zhishu.Count(); i++)
            {
                ++zhishuCount;
                JObject jo = (JObject)zhishu[i];
                String entityId = jo["entityId"].ToString();
                if (zhishuCount == 1)
                {
                    respermissionString.Append(entityId);
                }
                else if (zhishuCount > 1) 
                {
                    respermissionString.Append(","+entityId);
                }
            }
            respermissionString.Append("/");
            int unitCount = 0;
            for (int i = 0; i < unit.Count(); i++)
            {
                ++unitCount;
                JObject jo = (JObject)unit[i];
                String entityId = jo["entityId"].ToString();
                if (unitCount == 1)
                {
                    respermissionString.Append(entityId);
                }
                else if (unitCount > 1)
                {
                    respermissionString.Append("," + entityId);
                }
            }
            respermissionString.Append("/");
            int usertypeCount = 0;
            for (int i = 0; i < usertype.Count(); i++)
            {
                JObject jo = (JObject)usertype[i];
                String enId = jo["entityId"].ToString();
                
                    JArray usertypeIds = (JArray)jo["usertypeIds"];
                    for (int j = 0; j < usertypeIds.Count(); j++)
                    {
                        ++usertypeCount;
                        String utId = usertypeIds[j].ToString();
                        if (usertypeCount == 1)
                        {
                            respermissionString.Append(enId + ":" + utId);
                        }
                        else if (usertypeCount > 1)
                        {
                            respermissionString.Append(";" + enId + ":" + utId);
                        }
                    }                
            }
            return respermissionString.ToString();
        }
    }
    
}