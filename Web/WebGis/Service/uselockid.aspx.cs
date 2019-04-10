using DbComponent;
using System;
using System.Data;
using System.Data.SqlClient;

namespace Web.WebGis.Service
{
    public partial class uselockid : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string feedback = "";
            try
            {
                string username = Request.Cookies["username"].Value.Trim();
                string pcid = Request.QueryString["id"];

                if (pcid == "0")//解锁
                {
                    DataTable dts = SQLHelper.ExecuteRead(CommandType.Text, "select lockid from use_pramater where username=@username", "ddd", new SqlParameter("username", username));
                    if (dts != null && dts.Rows.Count > 0)
                    {
                        DbComponent.LogModule.SystemLog.WriteLog(MyModel.Enum.ParameType.UID, MyModel.Enum.OperateLogType.operlog, MyModel.Enum.OperateLogModule.ModuleApplication, MyModel.Enum.OperateLogOperType.Lock, "UnLockFunction", MyModel.Enum.OperateLogIdentityDeviceType.MobilePhone, dts.Rows[0][0].ToString());
                    }
                }
                else
                {
                    DbComponent.LogModule.SystemLog.WriteLog(MyModel.Enum.ParameType.UID, MyModel.Enum.OperateLogType.operlog, MyModel.Enum.OperateLogModule.ModuleApplication, MyModel.Enum.OperateLogOperType.Lock, "LockFunction", MyModel.Enum.OperateLogIdentityDeviceType.MobilePhone, pcid);
                }

                int countpc = int.Parse(SQLHelper.ExecuteScalar(CommandType.Text, "select count(*) from use_pramater where username=@username", new SqlParameter("username", username)).ToString());

                if (countpc > 0)
                {
                    SQLHelper.ExecuteNonQuery(CommandType.Text, "UPDATE [use_pramater] SET lockid=@lockid  where username=@username", new SqlParameter("lockid", pcid), new SqlParameter("username", username));
                }
                else
                {
                    SQLHelper.ExecuteNonQuery(CommandType.Text, "INSERT INTO [use_pramater] (lockid,username) VALUES (@lockid,@username)", new SqlParameter("lockid", pcid), new SqlParameter("username", username));
                }
               

                feedback = "{\"result\":\"success\"}";
            }
            catch (Exception ex)
            {
                feedback = "{\"result\":\"fail\"}";
            }
            Response.Write(feedback);
            Response.End();

        }
    }
}