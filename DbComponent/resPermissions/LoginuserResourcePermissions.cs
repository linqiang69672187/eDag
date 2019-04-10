using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using Newtonsoft.Json.Linq;
using DbComponent.Comm.enums;
namespace DbComponent.resPermissions
{
    public class LoginuserResourcePermissions
    {
        public JArray getLoginuserResPermissionsByUserId_JObject(String userId)
        {
            JArray joRelust = new JArray();

            JArray unit = new JArray();
            JArray zhishu = new JArray();
            JArray usertype = new JArray();

            SubLoginuserResourcePermissions SubLoginuserResourcePermissionsClass = new SubLoginuserResourcePermissions();
            String res = SubLoginuserResourcePermissionsClass.getLoginuserResourcePermissionsStringByUserId(userId);
            JObject re = JObject.Parse(res);
            String loginuserEntityId = re["loginuserEntityId"].ToString();

            JArray LoginuserResPermissionsArray_database = (JArray)re["LoginuserResourcePermissions"];
            if (LoginuserResPermissionsArray_database.Count > 0)
            {
                StringBuilder LoginuserResourcePermissions = new StringBuilder();
                try
                {

                    JObject LoginuserResPermissions_database = (JObject)LoginuserResPermissionsArray_database[0];
                    String vol = "";
                    try
                    {
                         vol = LoginuserResPermissions_database["volume"].ToString();
                    }
                    catch (Exception ex) { }
                    if (vol == volume.none.ToString())
                    {
                        
                    }
                    else if (vol == volume.part.ToString())
                    {
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

                        ////获取unit
                        // if (unit != null && unit.Count() != 0)
                        // {
                        //     for (int i = 0; i < unit.Count(); i++)
                        //     {
                        //         JObject jo = (JObject)unit[i];
                        //         String entityId = jo["entityId"].ToString();
                        //     }
                        // }
                        ////获取直属
                        // if (zhishu != null && zhishu.Count() != 0)
                        // {
                        //     for (int i = 0; i < zhishu.Count(); i++)
                        //     {
                        //         JObject jo = (JObject)zhishu[i];
                        //         String zhishuentityId = jo["entityId"].ToString();
                        //     }
                        // }
                        ////获取警员类型
                        // if (usertype != null && usertype.Count() != 0)
                        // {
                        //     for (int i = 0; i < usertype.Count(); i++)
                        //     {
                        //         JObject jo = (JObject)usertype[i];
                        //         String entityId = jo["entityId"].ToString();
                        //         JArray usertypeIds = (JArray)jo["usertypeIds"];
                        //         for (int j = 0; j < usertypeIds.Count(); j++)
                        //         {
                        //             String usertypeId = usertypeIds[j].ToString();
                        //         }
                        //     }
                        // }
                    }
                }
                catch (Exception ex) { }
            }
            //如果未指定权限，则默认拥有自己所在单位的权限
            else
            {
                
                String entityId = re["loginuserEntityId"].ToString();
                String st="{\"entityId\":\""+entityId+"\"}";
                JObject ja = new JObject();
                ja = JObject.Parse(st);
                unit.Add(ja);
            }
            
            JObject jounit = new JObject(new JProperty("unit",unit.ToString()));
            joRelust.Add(jounit);
            JObject jozhishu = new JObject(new JProperty("zhishu", zhishu.ToString()));
            joRelust.Add(jozhishu);
            JObject jousertype = new JObject(new JProperty("usertype", usertype.ToString()));
            joRelust.Add(jousertype);
            
            String st1 = "{\"loginuserEntityId\":\"" + loginuserEntityId + "\"}";
            JObject jo1 = new JObject();
            jo1 = JObject.Parse(st1);
            joRelust.Add(jo1);

            return joRelust;
        }

    }
}
