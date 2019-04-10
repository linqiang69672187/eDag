using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using Newtonsoft.Json.Linq;
using DbComponent.Comm.enums;
namespace DbComponent.resPermissions
{

    public class SubLoginuserResourcePermissions : SubLoginuserResourcePermissions_virtual
    {
        public String subLoginUserId = "";
        public String getLoginuserResourcePermissionsByUserId(String userId, String subLoginUserId)
        {
            this.subLoginUserId = subLoginUserId;
            StringBuilder LoginuserResourcePermissionsResult = new StringBuilder();
            LoginuserResourcePermissionsResult.Append("[");
            String loginuserEntityId = "";

            String res = getLoginuserResourcePermissionsStringByUserId(userId);
            JObject re = JObject.Parse(res);
            loginuserEntityId = re["loginuserEntityId"].ToString();

            JArray LoginuserResPermissionsArray_database = (JArray)re["LoginuserResourcePermissions"];
            if (LoginuserResPermissionsArray_database.Count > 0)
            {
                StringBuilder LoginuserResourcePermissions = new StringBuilder();
                try
                {                    
                    
                    JObject LoginuserResPermissions_database = (JObject)LoginuserResPermissionsArray_database[0];
                    if(LoginuserResPermissions_database.ToString() !="" && LoginuserResPermissions_database!=null)
                    {
                    String vol = "";
                    try
                    {
                         vol = LoginuserResPermissions_database["volume"].ToString();
                    }
                    catch (Exception ex) { }
                    if (vol == volume.none.ToString())
                    {
                        LoginuserResourcePermissions.Append("{}");
                    }
                    else if (vol == volume.part.ToString())
                    {
                        JArray unit = new JArray();
                        JArray zhishu = new JArray();
                        JArray usertype = new JArray();
                        try
                        {
                             unit = (JArray)LoginuserResPermissions_database["unit"];
                        }
                        catch (Exception ex) { }
                        try
                        {
                             zhishu = (JArray)LoginuserResPermissions_database["zhishu"];
                        }
                        catch (Exception ex) { }
                         try
                         {
                             usertype = (JArray)LoginuserResPermissions_database["usertype"];
                         }
                         catch (Exception ex) { }
                     
                        //unit
                        int index = 0;
                        if (unit != null && unit.Count() != 0)
                        {
                            for (int i = 0; i < unit.Count(); i++)
                            {
                                ++index;
                                if (index == 1)
                                {

                                }
                                else
                                {
                                    LoginuserResourcePermissions.Append(",");
                                }
                                JObject jo = (JObject)unit[i];
                                String ResourcePermissions = getSubEntityAndUsertypeByEntityId(jo["entityId"].ToString(), false);
                                LoginuserResourcePermissions.Append(ResourcePermissions);
                            }
                        }
                        //zhishu
                        if (zhishu != null && zhishu.Count() != 0)
                        {
                            SelfEntityAndUsertypeByEntityId SelfEntityAndUsertypeByEntityIdClass = new SelfEntityAndUsertypeByEntityId();
                            for (int i = 0; i < zhishu.Count(); i++)
                            {
                                ++index;
                                if (index == 1)
                                {

                                }
                                else
                                {
                                    LoginuserResourcePermissions.Append(",");
                                }
                                JObject jo = (JObject)zhishu[i];
                                String ResourcePermissions = SelfEntityAndUsertypeByEntityIdClass.getSubEntityAndUsertypeByEntityId(jo["entityId"].ToString(), false);
                                LoginuserResourcePermissions.Append(ResourcePermissions);
                            }
                        }
                        //usertype
                        if (usertype != null && usertype.Count() != 0)
                        {
                            selectedUsertype selectedUsertypeClass = new selectedUsertype();
                            for (int i = 0; i < usertype.Count(); i++)
                            {
                                ++index;
                                if (index == 1)
                                {

                                }
                                else
                                {
                                    LoginuserResourcePermissions.Append(",");
                                }
                                JObject jo = (JObject)usertype[i];
                                String entityId = jo["entityId"].ToString();
                                JArray usertypeIds = (JArray)jo["usertypeIds"];
                                selectedUsertypeClass.setUsertypeIds(usertypeIds);
                                String ResourcePermissions = selectedUsertypeClass.getSubEntityAndUsertypeByEntityId(entityId, false);
                                LoginuserResourcePermissions.Append(ResourcePermissions);
                            }
                        }
                    }
                }
                }
                catch(Exception ex){
                    LoginuserResourcePermissions.Clear();
                }
                LoginuserResourcePermissionsResult.Append(LoginuserResourcePermissions);
            }
                //如果未指定权限，则默认拥有自己所在单位的权限
            else {
                StringBuilder LoginuserResourcePermissions_SelfEntity = new StringBuilder();
                try
                {
                    String ResourcePermissions_SelfEntity = getSubEntityAndUsertypeByEntityId(loginuserEntityId, false);
                    LoginuserResourcePermissions_SelfEntity.Append(ResourcePermissions_SelfEntity);
                }
                catch(Exception ex){
                    LoginuserResourcePermissions_SelfEntity.Clear();
                }
                LoginuserResourcePermissionsResult.Append(LoginuserResourcePermissions_SelfEntity);
            }
            
            LoginuserResourcePermissionsResult.Append("]");
            return LoginuserResourcePermissionsResult.ToString();
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
        public override String getSubEntityAndUsertypeByEntityId(String entityId, Boolean isCallback)
        {

            SubEntityAndUsertypeByEntityId SubEntityAndUsertypeByEntityIdClass = new SubEntityAndUsertypeByEntityId();
            String ResPermissions = SubEntityAndUsertypeByEntityIdClass.getSubEntityAndUsertypeByEntityId(entityId, isCallback);
            return ResPermissions;
        }
               

    }
}
