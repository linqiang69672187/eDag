using System;
using System.IO;
namespace Web.WebGis.Service
{
    public partial class loginout : Web.lqnew.opePages.BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                delete_selectedentity_file();
                string username = Request.Cookies["username"].Value.Trim();
                string last_lo = Request.QueryString["last_lo"];
                string last_la = Request.QueryString["last_la"];
                DbComponent.login.updatelasttime(username);
                DbComponent.usepramater.Editlast_la_laByCookie(username, last_lo, last_la);

                if (Request.Cookies["myissi"] != null)
                {
                    string strMyISSI = Request.Cookies["myissi"].Value;
                    MyModel.LoginDispatchList.RemoveLoginDispatch(strMyISSI);
                }
                
                    DbComponent.LogModule.SystemLog.WriteLog(MyModel.Enum.ParameType.Other, MyModel.Enum.OperateLogType.operlog, MyModel.Enum.OperateLogModule.ModuleSystem, MyModel.Enum.OperateLogOperType.LogOut, "Log_LogOut_Success", MyModel.Enum.OperateLogIdentityDeviceType.Other);
               
                log.Debug(username + " Normal LoginOut eTra GIS Dispatch System Success(" + Request.UserHostAddress + "," + DateTime.Now.ToString() + ")");
            }
            catch (Exception ex)
            {
                log.Error(ex);
            }
            finally
            {
               
            }
            Response.Write("{}");
            Response.End();
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