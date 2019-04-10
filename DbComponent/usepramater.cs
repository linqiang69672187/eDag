using System;
using System.Data;
using System.Data.SqlClient;
using System.Reflection;

namespace DbComponent
{
   public class usepramater
    {
       string connstring = System.Configuration.ConfigurationManager.AppSettings["m_connectionString"];
       private static readonly log4net.ILog log = log4net.LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType); 
        #region 通过cookie获取登录账户配置信息
       public static DataTable GetUseparameterByCookie(string cookie)
        {
            return SQLHelper.ExecuteRead(CommandType.Text,"select top 1 * from [use_pramater] where [username]=@usename","getparameter",new SqlParameter("usename",cookie));

        }
       #endregion

       public static void SetLockIDByUserName(string username)
       {
           SQLHelper.ExecuteNonQuery(CommandType.Text, "UPDATE [use_pramater] SET [lockid]=0 where [username]=@username", new SqlParameter("username", username));

       }
       #region 通过cookie修改登录账户配置信息
       public static void EditUseparameterByCookie(string cookie, int device_timeout, Boolean hide_timeout_device, int refresh_map_interval,Boolean displayinfo)
       {
           SQLHelper.ExecuteNonQuery(CommandType.Text, "UPDATE [use_pramater] SET [device_timeout]=@device_timeout,[hide_timeout_device] =@hide_timeout_device,[refresh_map_interval]=@refresh_map_interval,[displayinfo]=@displayinfo where [username]=@username", new SqlParameter("username", cookie), new SqlParameter("device_timeout", device_timeout), new SqlParameter("hide_timeout_device", hide_timeout_device), new SqlParameter("refresh_map_interval", refresh_map_interval), new SqlParameter("displayinfo", displayinfo));

       }
       public static void EditUseparameterByCookie(string cookie, int device_timeout, Boolean hide_timeout_device, int refresh_map_interval)
       {
           SQLHelper.ExecuteNonQuery(CommandType.Text, "UPDATE [use_pramater] SET [device_timeout]=@device_timeout,[hide_timeout_device] =@hide_timeout_device,[refresh_map_interval]=@refresh_map_interval where [username]=@username", new SqlParameter("username", cookie), new SqlParameter("device_timeout", device_timeout), new SqlParameter("hide_timeout_device", hide_timeout_device), new SqlParameter("refresh_map_interval", refresh_map_interval));

       }
       public static void EditUseparameterByCookie(string cookie, int device_timeout, Boolean hide_timeout_device, int refresh_map_interval, Boolean displayinfo, string userHeadInfo, string status_mode, string voiceType, string IsOpenuserHeadInfo)
       {
           SQLHelper.ExecuteNonQuery(CommandType.Text, "UPDATE [use_pramater] SET [device_timeout]=@device_timeout,[hide_timeout_device] =@hide_timeout_device,[refresh_map_interval]=@refresh_map_interval,[displayinfo]=@displayinfo,[userHeadInfo]=@userHeadInfo, [headerInfo_status_mode]=@status_mode,[voiceType]=@voiceType, [IsOpenuserHeadInfo]=@IsOpenuserHeadInfo where [username]=@username", new SqlParameter("username", cookie), new SqlParameter("device_timeout", device_timeout), new SqlParameter("hide_timeout_device", hide_timeout_device), new SqlParameter("refresh_map_interval", refresh_map_interval), new SqlParameter("displayinfo", displayinfo), new SqlParameter("userHeadInfo", userHeadInfo), new SqlParameter("status_mode", status_mode), new SqlParameter("voiceType", voiceType), new SqlParameter("IsOpenuserHeadInfo", IsOpenuserHeadInfo));

       }
       
       #endregion

       #region 通过cookie修改配置用户的最后经纬度
       public static void Editlast_la_laByCookie(string cookie, string last_lo,string last_la)
       {

           string strSQL = "select count(0) from [use_pramater] where [username]=@username";
           DataTable dt = SQLHelper.ExecuteRead(CommandType.Text, strSQL, "fdsfsd", new SqlParameter("username", cookie));
           if (int.Parse(dt.Rows[0][0].ToString()) > 0) {
               SQLHelper.ExecuteNonQuery(CommandType.Text, "UPDATE [use_pramater] SET [last_lo]=@last_lo,[last_la]=@last_la where [username]=@username", new SqlParameter("username", cookie), new SqlParameter("last_lo", last_lo), new SqlParameter("last_la", last_la));
           }
           else
           {
               SQLHelper.ExecuteNonQuery(CommandType.Text, "Insert into [use_pramater] (username,last_lo,last_la) values (@username,@last_lo,@last_la)", new SqlParameter("username", cookie), new SqlParameter("last_lo", last_lo), new SqlParameter("last_la", last_la));
           }

       }
       #endregion

       public static int GetLockIdByLoginName(string LoginName)
       {
           string strSQL = "select lockid from use_pramater where [username]=@username";
           DataTable dt = SQLHelper.ExecuteRead(CommandType.Text, strSQL, "addd", new SqlParameter("username", LoginName));

           if (dt.Rows[0][0] == null||dt.Rows[0][0].ToString() =="")
           {
               return 0;
           }
           else
           {
             
               return int.Parse(dt.Rows[0][0].ToString());
           }
       }
    }
}
