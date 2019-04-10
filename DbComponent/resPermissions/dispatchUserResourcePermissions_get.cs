using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using DbComponent.Comm.enums;
using Newtonsoft.Json.Linq;

namespace DbComponent.resPermissions
{
    public class dispatchUserResourcePermissions_get
    {
        public string getDispatchUserResourcePermissions(string dispatchUserId)
        {
            JArray unit = new JArray();
            JArray zhishu = new JArray();
            JArray usertype = new JArray();

            SubLoginuserResourcePermissions SubLoginuserResourcePermissionsClass = new SubLoginuserResourcePermissions();
            String res = SubLoginuserResourcePermissionsClass.getLoginuserResourcePermissionsStringByUserId(dispatchUserId);
            JObject re = JObject.Parse(res);
            JArray LoginuserResPermissionsArray_database = (JArray)re["LoginuserResourcePermissions"];
            if (LoginuserResPermissionsArray_database.Count > 0)
            {
                StringBuilder toShowDispatchPermissions = new StringBuilder("");
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
                        toShowDispatchPermissions.Append("none");
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
                        //获取直属
                        if (zhishu != null && zhishu.Count() != 0)
                        {
                            for (int i = 0; i < zhishu.Count(); i++)
                            {
                                JObject jo = (JObject)zhishu[i];
                                toShowDispatchPermissions.Append(jo["entityId"].ToString().Trim() + ",");
                            }
                        }
                        toShowDispatchPermissions.Append("/");
                        //获取unit
                        if (unit != null && unit.Count() != 0)
                        {
                            for (int i = 0; i < unit.Count(); i++)
                            {
                                JObject jo = (JObject)unit[i];
                                toShowDispatchPermissions.Append(jo["entityId"].ToString().Trim() + ",");
                            }
                        }
                        toShowDispatchPermissions.Append("/");
                        //获取警员类型
                        if (usertype != null && usertype.Count() != 0)
                        {
                            for (int i = 0; i < usertype.Count(); i++)
                            {
                                JObject jo = (JObject)usertype[i];
                                JArray usertypeIds = (JArray)jo["usertypeIds"];
                                for (int j = 0; j < usertypeIds.Count(); j++)
                                {
                                    toShowDispatchPermissions.Append(jo["entityId"].ToString().Trim() + ":" + usertypeIds[j].ToString().Trim() + ";");
                                }
                            }
                        }
                    }

                    return toShowDispatchPermissions.ToString();
                }
                catch (Exception er)
                {
                    return null;
                }
            }
            else { return null; }
        }
    }
}
