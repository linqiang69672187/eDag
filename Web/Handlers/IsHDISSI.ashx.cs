using DbComponent;
using System;
using System.Reflection;
using System.Web;
using System.Web.SessionState;

namespace Web.Handlers
{
    /// <summary>
    /// IsHDISSI 的摘要说明
    /// </summary>
    public class IsHDISSI : IHttpHandler, IReadOnlySessionState
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
            bool flag = false;
            string userid=context.Request["id"].ToString();
            MyModel.Model_login mLogin = dbLogin.GetLogininfoByUserName(context.Request.Cookies["username"].Value);
            if (!string.IsNullOrEmpty(mLogin.HDISSI))
            {
                MyModel.Model_userinfo mUser = dbUser.GetUserinfo_byid(int.Parse(userid));
                string[] myhdissis = mLogin.HDISSI.Replace("<","").Split(new char[]{'>'},StringSplitOptions.RemoveEmptyEntries);
                foreach(string issi in myhdissis)
                {
                    if (issi == mUser.ISSI)
                    {
                        flag = true;
                        break;
                    }
                }
            }
            //还要去判断是否该用户是否超时
            //获取是否隐藏超时 然后获取超时时间 

            /* 有问题
            System.Data.DataTable dt = DbComponent.usepramater.GetUseparameterByCookie(context.Request.Cookies["username"].Value);
            if (dt != null && dt.Rows.Count > 0)
            {
                log.Debug("hide_timeout_device:" + dt.Rows[0]["hide_timeout_device"].ToString());
                if (dt.Rows[0]["hide_timeout_device"].ToString() == "True")//已经隐藏超时的了
                {
                    DateTime? dtSendTIme = DbComponent.Gis.GetSendTimeByUserID(userid);//要被锁定的用户
                }
            }
            */

            context.Response.Write("{\"result\":\"" + flag + "\"}");
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