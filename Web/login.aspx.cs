using Ryu666.Components;
using System;
using System.Configuration;
using System.Web.UI;
using System.IO;
namespace Web
{
    public partial class login : Web.lqnew.opePages.BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
           

            DbComponent.Comm.CookieContent.SetHostIpCookie();
            RequiredFieldValidator1.ErrorMessage = ResourceManager.GetString("USERNAMEFieldMust");
            RequiredFieldValidator2.ErrorMessage = ResourceManager.GetString("PWDFieldMust");
            delete_selectedentity_file();
        }

        protected void Button2_Click(object sender, EventArgs e) 
        {
           


            int entityid = 0;
            int usertype = -1;
            if(dispatchuser_radio.Checked){
                usertype = 1;
                entityid = DbComponent.login.loginin(TextBox1.Text.Trim(), TextBox2.Text.Trim(), usertype);
            }
            else if (configuser_radio.Checked)
            {
                usertype = 2;
                entityid = DbComponent.login.loginin(TextBox1.Text.Trim(), TextBox2.Text.Trim(), usertype);
            }
            else {
                Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + Ryu666.Components.ResourceManager.GetString("selectusertype") + "');</script>");
                return;
            }
            if (entityid > 0)
            {

                DateTime dt = DbComponent.login.checkuselogintime(TextBox1.Text.Trim());

                DateTime dt1 = DateTime.Now;
                TimeSpan ts = dt1 - dt;
                double mins = ts.TotalMinutes;
                int m_connectionString = int.Parse(ConfigurationManager.AppSettings["login_overtime"]); //获取失效时间
                if (mins > m_connectionString)
                {

                    DbComponent.LogModule.SystemLog.WriteLog(MyModel.Enum.ParameType.Other, MyModel.Enum.OperateLogType.operlog, MyModel.Enum.OperateLogModule.ModuleSystem, MyModel.Enum.OperateLogOperType.LogOn, "Log_Login_Success", MyModel.Enum.OperateLogIdentityDeviceType.Other);


                    float fCookOutTime = 2400f;
                    try
                    {
                        fCookOutTime = float.Parse(ConfigurationManager.AppSettings["CookOutTime"].ToString());
                    }
                    catch (Exception ex)
                    {
                        log.Debug(ex);
                    }
                    log.Debug(TextBox1.Text.Trim() + " Login eTra GIS Dispatch System By PC " + Request.UserHostAddress + "（" + DateTime.Now.ToString() + "）");
                    DbComponent.login.updateloginandlasttime(TextBox1.Text.Trim());
                    Response.Cookies["id"].Value = DbComponent.login.GetEntityID(TextBox1.Text.Trim(), TextBox2.Text.Trim());
                    Response.Cookies["id"].Expires = DateTime.Now.AddMinutes(fCookOutTime);
                    Response.Cookies["username"].Value = TextBox1.Text.Trim();
                    Response.Cookies["username"].Expires = DateTime.Now.AddMinutes(fCookOutTime);                   
                    Response.Cookies["usertype"].Value = usertype.ToString();
                    Response.Cookies["usertype"].Expires = DateTime.Now.AddMinutes(fCookOutTime);
                    Response.Redirect("main.aspx");
                    //Page.ClientScript.RegisterStartupScript(Page.GetType(), "redirect", "<script>winopen();</script>");
                }
                else
                {
                    Response.Cookies["username"].Value = TextBox1.Text.Trim();
                    Response.Cookies["username"].Expires = DateTime.Now.AddMinutes(2400f);
                    DbComponent.LogModule.SystemLog.WriteLog(MyModel.Enum.ParameType.Other, MyModel.Enum.OperateLogType.operlog, MyModel.Enum.OperateLogModule.ModuleSystem, MyModel.Enum.OperateLogOperType.LogOn, "Log_Login_Failed_OutTime", MyModel.Enum.OperateLogIdentityDeviceType.Other);
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + Ryu666.Components.ResourceManager.GetString("ACountIsLoginedPleaseWaitForAMoment") + "(" + m_connectionString + Ryu666.Components.ResourceManager.GetString("minute") + ")');</script>");
                }
            }
            else
            {
                DbComponent.LogModule.SystemLog.WriteLog(MyModel.Enum.ParameType.Other, MyModel.Enum.OperateLogType.operlog, MyModel.Enum.OperateLogModule.ModuleSystem, MyModel.Enum.OperateLogOperType.LogOn, "Log_Login_Failed", MyModel.Enum.OperateLogIdentityDeviceType.Other);
                Response.Cookies["username"].Value = TextBox1.Text.Trim();
                Response.Cookies["username"].Expires = DateTime.Now.AddMinutes(2400f);   

                Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + Ryu666.Components.ResourceManager.GetString("UseOrPwdOrUsertypeIsError") + "');</script>");
            }
        }
        public void delete_selectedentity_file()
        {
            try
            {
                string hostipadd = Request.UserHostAddress;
                string dispatchUserName = Request.Cookies["username"].Value;
                string folderpath = "SelectedEntity\\" + dispatchUserName + "\\" + hostipadd;
                string filepath = folderpath + "\\SelectedEntity.txt";
                if (Directory.Exists(Server.MapPath(@folderpath)))
                {
                    if (File.Exists(Server.MapPath(@filepath)))
                    {
                        File.Delete(Server.MapPath(@filepath));
                    }
                }
            }
            catch (Exception e) { }
        }
    }
}