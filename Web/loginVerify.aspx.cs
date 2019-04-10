
using Ryu666.Components;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.IO;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
namespace Web
{
    public partial class loginVerify : System.Web.UI.Page
    {
      
        string username;
        string passwords;
        String loginResult;
        protected void Page_Load(object sender, EventArgs e)
        {

            int usertype;
            username = Request.QueryString["username"].Trim();
            passwords = Request.QueryString["passwords"].Trim();
            string sec = Request.QueryString["sec"].Trim();

            if (sec == "2")//使用MD5加密
            {
                DataTable dt = DbComponent.login.loginAll(username);
                for (int n = 0; n < dt.Rows.Count; n++)
                {
                    string s_Name = username;
                    string s_Pwd = dt.Rows[n]["Pwd"].ToString();
                    usertype = int.Parse(dt.Rows[n]["usertype"].ToString());
                    if (UserMD5(s_Name, s_Pwd))//转换MD5
                    {
                        loginResult = loginVerifyUser(usertype, s_Name, s_Pwd);
                        switch (loginResult)
                        {
                            case "success":
                                Response.Redirect("main.aspx");
                                break;
                            case "fail":
                                Response.Write("{\"msg\":\"" + loginResult + "\"}");
                                Response.End();
                                break;
                            case "logined":
                                Response.Write("{\"msg\":\"" + loginResult + "\"}");
                                Response.End();
                                break;

                        }
                    
                    }
                }

            }
            else
            {
                usertype = int.Parse(Request.QueryString["usertype"].Trim());
                loginResult = loginVerifyUser(usertype, username, passwords);
                if (sec == "1")
                    Response.Redirect("main.aspx");
                else
                Response.Write("{\"msg\":\"" + loginResult + "\"}");
                Response.End();
            }

        }

        //MD5加密 只对密码加密
        private bool UserMD5(string s_username, string s_password)
        {
            using (MD5 md5 = MD5.Create())
            {
            
                byte[] passBuffer = Encoding.UTF8.GetBytes(s_password);

       
                byte[] md5pass = md5.ComputeHash(passBuffer);
                md5.Clear();

                StringBuilder sb_pass = new StringBuilder();

                for (int i = 0; i < md5pass.Length; i++)
                {
                    sb_pass.Append(md5pass[i].ToString("x2"));
                }
                if (s_username == username && sb_pass.ToString() == passwords)
                {
                    return true;
             
                }

                return false;



            }
        
        }

        private String loginVerifyUser(int usertype, string username, string passwords)
        {
            String verifyResult;
            try
            {
                ///加载配置logconfig.xml文件
                DbComponent.LogModule.SystemLog.getLogPression(Server.MapPath(System.Configuration.ConfigurationManager.AppSettings["logconfigpath"].ToString()));

                int entityid = 0;
                entityid = DbComponent.login.loginin(username, passwords, usertype);
                String loginUserId = DbComponent.login.GetLoginUserId(username, passwords, usertype);
                string allowLoginRole = System.Web.Configuration.WebConfigurationManager.AppSettings["LoginRole"];
                Response.Cookies["roleId"].Value = "0";

                if (entityid > 0)
                {
                    System.Data.DataTable userPower = DbComponent.login.GetPower(username, passwords, usertype);
                    Response.Cookies["roleId"].Value = userPower.Rows[0]["roleId"].ToString().Trim();

                    if (usertype == 1)
                    {
                        if (allowLoginRole != "0")
                        {
                            if (Response.Cookies["roleId"].Value != allowLoginRole)
                            {
                                DbComponent.LogModule.SystemLog.WriteLog(MyModel.Enum.ParameType.Other, MyModel.Enum.OperateLogType.operlog, MyModel.Enum.OperateLogModule.ModuleSystem, MyModel.Enum.OperateLogOperType.LogOn, "Log_Login_Failed", MyModel.Enum.OperateLogIdentityDeviceType.Other);
                                //验证失败
                                verifyResult = "fail";
                                return verifyResult;

                            }
                            else
                            {
                                return login(usertype, username, passwords, loginUserId);
                            }
                        }
                        else
                        {
                            return login(usertype, username, passwords, loginUserId);
                        }
                    }
                    else
                    {
                        return login(usertype, username, passwords, loginUserId);
                    }

                }
                else
                {
                    DbComponent.LogModule.SystemLog.WriteLog(MyModel.Enum.ParameType.Other, MyModel.Enum.OperateLogType.operlog, MyModel.Enum.OperateLogModule.ModuleSystem, MyModel.Enum.OperateLogOperType.LogOn, "Log_Login_Failed", MyModel.Enum.OperateLogIdentityDeviceType.Other);
                    //验证失败
                    verifyResult = "fail";
                    return verifyResult;
                }
            }
            catch (Exception ex)
            {
                //错误
                verifyResult = "fail";
                return verifyResult;
            }
        }

        private string login(int usertype, string username, string passwords, string loginUserId)
        {

            string verifyResult;
            DateTime dt = DbComponent.login.checkuselogintime(username);

            DateTime dt1 = DateTime.Now;
            TimeSpan ts = dt1 - dt;
            double mins = ts.TotalMinutes;
            int m_connectionString = int.Parse(ConfigurationManager.AppSettings["login_overtime"]); //获取失效时间
            //if (mins > m_connectionString)
            //{
                float fCookOutTime = 2400f;
                try
                {
                    fCookOutTime = float.Parse(ConfigurationManager.AppSettings["CookOutTime"].ToString());
                }
                catch (Exception ex)
                {
                    //log.Debug(ex);
                }
                //log.Debug(username + " Login eTra GIS Dispatch System By PC " + Request.UserHostAddress + "（" + DateTime.Now.ToString() + "）");

                DbComponent.login.updateloginandlasttime(username);
                Response.Cookies["id"].Value = DbComponent.login.GetEntityID(username, passwords);
                Response.Cookies["id"].Expires = DateTime.Now.AddMinutes(fCookOutTime);
                Response.Cookies["username"].Value = username;
                Response.Cookies["username"].Expires = DateTime.Now.AddMinutes(fCookOutTime);
                Response.Cookies["usertype"].Value = usertype.ToString();
                Response.Cookies["usertype"].Expires = DateTime.Now.AddMinutes(fCookOutTime);
                Response.Cookies["loginUserId"].Value = loginUserId.ToString().Trim();
                Response.Cookies["loginUserId"].Expires = DateTime.Now.AddMinutes(fCookOutTime);
                Response.Cookies["roleId"].Expires = DateTime.Now.AddMinutes(fCookOutTime);
                Response.Cookies["videoIp"].Value = GetAppConfig("VideoIp").Trim();
                Response.Cookies["videoIp"].Expires = DateTime.Now.AddMinutes(fCookOutTime);
                Response.Cookies["VideoCommandEnable"].Value = "0";
                Response.Cookies["VideoCommandEnable"].Expires = DateTime.Now.AddMinutes(fCookOutTime);
               

                //验证成功
                verifyResult = "success";
                DbComponent.LogModule.SystemLog.WriteLog(MyModel.Enum.ParameType.Other, MyModel.Enum.OperateLogType.operlog, MyModel.Enum.OperateLogModule.ModuleSystem, MyModel.Enum.OperateLogOperType.LogOn, "Log_Login_Success", MyModel.Enum.OperateLogIdentityDeviceType.Other);
                return verifyResult;
                //Response.Redirect("main.aspx");
                //Page.ClientScript.RegisterStartupScript(Page.GetType(), "redirect", "<script>winopen();</script>");
            //}
            //else
            //{
            //    DbComponent.LogModule.SystemLog.WriteLog(MyModel.Enum.ParameType.Other, MyModel.Enum.OperateLogType.operlog, MyModel.Enum.OperateLogModule.ModuleSystem, MyModel.Enum.OperateLogOperType.LogOn, "Log_Login_Failed", MyModel.Enum.OperateLogIdentityDeviceType.Other);
            //    //验证成功但已登录
            //    verifyResult = "logined";
            //    return verifyResult;
            //}

        }

        ///<summary> 
        ///返回*.exe.config文件中appSettings配置节的value项  
        ///</summary> 
        ///<param name="strKey"></param> 
        ///<returns></returns> 
        public static string GetAppConfig(string strKey)
        {
            //string webPath = System.Reflection.Assembly.GetExecutingAssembly().Location;

            string path = System.Web.HttpContext.Current.Server.MapPath("Web.config");

            ConfigXmlDocument docXml = new ConfigXmlDocument();
            if (System.IO.File.Exists(path))
            {
                docXml.Load(path);
                System.Xml.XmlNode node2 = docXml.SelectSingleNode("configuration/appSettings/add[@key='" + strKey + "']");
                if (node2 != null)
                {
                    return node2.Attributes["value"].Value.Trim();

                }
                else
                    return "error";
            }
            else
            {
                return "error";

            }

        }
    }
}