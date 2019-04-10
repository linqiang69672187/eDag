using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Web.Handlers
{
    /// <summary>
    /// WriteLog 的摘要说明
    /// 写日志
    /// 主要界面写日志
    /// </summary>
    public class WriteLog : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            string strFun = context.Request["fun"].ToString();
            string strUserid = context.Request["userid"].ToString();
            string strLogtype = context.Request["logtype"].ToString();
            string strModule = context.Request["module"].ToString();
            string strOpertype = context.Request["opertype"].ToString();
            string strContent = context.Request["content"].ToString();
            string strIdentityDeviceType = context.Request["IdentityDeviceType"].ToString();

            if (!DbComponent.LogModule.SystemLog.isHavaPression(strOpertype))
            {
                return;
            }

            string dispatchIssi = "";
            if (context.Request.Cookies["dispatchissi"] != null) {
                dispatchIssi = context.Request.Cookies["dispatchissi"].Value;
            }
            string dispatchIp = context.Request.UserHostAddress.ToString();
            
            string dispatchUsername = "";
            if (context.Request.Cookies["username"] != null) {
                dispatchUsername = context.Request.Cookies["username"].Value;
            }

            DbComponent.SQLHelper.ExecuteNonQuery(System.Data.CommandType.StoredProcedure, "WriteLog", new System.Data.SqlClient.SqlParameter("fun", int.Parse(strFun)), new System.Data.SqlClient.SqlParameter("userid", strUserid), new System.Data.SqlClient.SqlParameter("strLogtype", int.Parse(strLogtype)), new System.Data.SqlClient.SqlParameter("strModule", int.Parse(strModule)), new System.Data.SqlClient.SqlParameter("strOpertype", int.Parse(strOpertype)), new System.Data.SqlClient.SqlParameter("strContent", strContent), new System.Data.SqlClient.SqlParameter("dispatchIssi", dispatchIssi), new System.Data.SqlClient.SqlParameter("dispatchIp", dispatchIp), new System.Data.SqlClient.SqlParameter("dispatchUsername", dispatchUsername), new System.Data.SqlClient.SqlParameter("IdentityDeviceType", strIdentityDeviceType));


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