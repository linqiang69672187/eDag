using DbComponent;
using System;
using System.Reflection;
using System.Web;
using System.Web.SessionState;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using System.Data.SqlClient;
using System.Text;

namespace Web.Handlers
{
    /// <summary>
    /// CannotLockUser 的摘要说明
    /// </summary>
    public class CannotLockUser : IHttpHandler,IReadOnlySessionState
    {
        private DbComponent.login dbLogin
        {
            get
            {
                return new DbComponent.login();
            }
        }
        private DbComponent.userinfo dbUser
        {
            get
            {
                return new userinfo();
            }
        }
        private static readonly log4net.ILog log = log4net.LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType); 
        public void ProcessRequest(HttpContext context)
        {
            //flag为true，登陆用户已将选中用户隐藏;
            bool flag = false;
            string userid = context.Request["id"].ToString();
            MyModel.Model_login mLogin = dbLogin.GetLogininfoByUserName(context.Request.Cookies["username"].Value);
            if (!string.IsNullOrEmpty(mLogin.HDISSI))
            {
                MyModel.Model_userinfo mUser = dbUser.GetUserinfo_byid(int.Parse(userid));
                string[] myhdissis = mLogin.HDISSI.Replace("<", "").Split(new char[] { '>' }, StringSplitOptions.RemoveEmptyEntries);
                foreach (string issi in myhdissis)
                {
                    if (issi == mUser.ISSI)
                    {
                        flag = true;
                        break;
                    }
                }
            }

            int devicetimeout = 15;
            DataTable useparameter = DbComponent.usepramater.GetUseparameterByCookie(context.Request.Cookies["username"].Value);
            for (int i = 0; i < useparameter.Rows.Count; i++)
            {
                devicetimeout = int.Parse(useparameter.Rows[i]["device_timeout"].ToString());
            }
            StringBuilder sb = new StringBuilder();
            string ID =context. Request.QueryString["id"];
            //查状态，value为0为不在线；
            int dt = int.Parse(SQLHelper.ExecuteScalar(CommandType.Text, "SELECT COUNT(*) FROM [GIS_info] where ISSI =(SELECT ISSI From user_info WHERE id = @id ) and Send_reason not in ('Subscriber_unit_is_powered_OFF','DMO_ON') and DATEDIFF(MINUTE,Send_time,GETDATE()) < " + devicetimeout + " ", new SqlParameter("id", ID)).ToString());
            sb.Append("{\"id\":\"" + ID + "\",\"value\":\"" + dt + "\",\"result\":\"" + flag + "\"}");

            context.Response.Write(sb.ToString());
           


             
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