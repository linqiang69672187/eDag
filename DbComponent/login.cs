using System;
using System.Data;
using System.Data.SqlClient;
using System.Text;

namespace DbComponent
{
    public class login
    {
        private string connstring = System.Configuration.ConfigurationManager.AppSettings["m_connectionString"];

        #region 分页排序调度员信息
        public DataTable AllloginInfo(int selectcondition, string textseach, int id, string sort, int startRowIndex, int maximumRows)
        {
            string sqlcondition = "";
            if (selectcondition != 0) { sqlcondition += " and [Entity_ID]='" + selectcondition + "'"; }
            if (textseach != null) { sqlcondition += " and [Usename] like '%" + stringfilter.Filter(textseach.Trim()) + "%'"; }
            if (sort == "") { sort = "id asc"; }
            return SQLHelper.ExecuteRead(CommandType.Text, "WITH lmenu(name,id) as (SELECT name,id  FROM [Entity] WHERE id=@id UNION ALL SELECT A.NAME,A.id FROM [Entity] A,lmenu b    where a.[ParentID] = b.id) select * from [login] where len([Usename]) > 0  " + sqlcondition + " and [Entity_ID] in (select id from lmenu) and [usertype] = 1  order by " + sort, startRowIndex, maximumRows, "Entity", new SqlParameter("id", id));
        }
        #endregion
        #region 分页排序配置用户信息
        public DataTable AllconfiguserInfo(int selectcondition, string textseach, int id, string sort, int startRowIndex, int maximumRows)
        {
            string sqlcondition = "";
            if (selectcondition != 0) { sqlcondition += " and [Entity_ID]='" + selectcondition + "'"; }
            if (textseach != null) { sqlcondition += " and [Usename] like '%" + stringfilter.Filter(textseach.Trim()) + "%'"; }
            if (sort == "") { sort = "id asc"; }
            return SQLHelper.ExecuteRead(CommandType.Text, "WITH lmenu(name,id) as (SELECT name,id  FROM [Entity] WHERE id=@id UNION ALL SELECT A.NAME,A.id FROM [Entity] A,lmenu b    where a.[ParentID] = b.id) select * from [login] where len([Usename]) > 0  " + sqlcondition + " and [Entity_ID] in (select id from lmenu) and [usertype] = 2  order by " + sort, startRowIndex, maximumRows, "Entity", new SqlParameter("id", id));
        }
        #endregion

        #region 取得调度员数量信息
        public int getalllogincount(int selectcondition, string textseach, int id)
        {
            string sqlcondition = "";
            if (selectcondition != 0) { sqlcondition += " and [Entity_ID]='" + selectcondition + "'"; }
            if (textseach != null) { sqlcondition += " and [Usename] like '%" + stringfilter.Filter(textseach.Trim()) + "%'"; }
            return int.Parse(SQLHelper.ExecuteScalar(CommandType.Text, "WITH lmenu(name,id) as (SELECT name,id  FROM [Entity] WHERE id=@id UNION ALL SELECT A.NAME,A.id FROM [Entity] A,lmenu b    where a.[ParentID] = b.id) select count(*) from login where  [Entity_ID] in (select id from lmenu) and [usertype] = 1 " + sqlcondition, new SqlParameter("id", id)).ToString());
        }
        #endregion

        #region 取得配置用户数量信息
        public int getallconfigusercount(int selectcondition, string textseach, int id)
        {
            string sqlcondition = "";
            if (selectcondition != 0) { sqlcondition += " and [Entity_ID]='" + selectcondition + "'"; }
            if (textseach != null) { sqlcondition += " and [Usename] like '%" + stringfilter.Filter(textseach.Trim()) + "%'"; }
            return int.Parse(SQLHelper.ExecuteScalar(CommandType.Text, "WITH lmenu(name,id) as (SELECT name,id  FROM [Entity] WHERE id=@id UNION ALL SELECT A.NAME,A.id FROM [Entity] A,lmenu b    where a.[ParentID] = b.id) select count(*) from login where  [Entity_ID] in (select id from lmenu) and [usertype] = 2 " + sqlcondition, new SqlParameter("id", id)).ToString());
        }
        #endregion

        #region 添加调度员信息
        public bool AddLogininfo(string Usename, string Pwd, string Entity_ID, decimal lo, decimal la)
        {
            try
            {
                //Entity entity = new Entity();
                //MyModel.Model_Entity me = entity.GetEntityinfo_byid(int.Parse(Entity_ID));
                //decimal lo = 0.0M;
                //decimal la = 0.0M;
                //if (me != null)
                //{
                //    lo = me.Lo;
                //    la = me.La;
                //}

                SQLHelper.ExecuteNonQuery(CommandType.Text, "INSERT [login] ([Usename],[Pwd],[Entity_ID],[usertype])VALUES (@Usename,@Pwd,@Entity_ID,1);;INSERT INTO use_pramater (lockid,username,device_timeout,hide_timeout_device,refresh_map_interval,last_lo,last_la) VALUES (0,@Usename,'10',0,'5'," + lo + "," + la + ")", new SqlParameter("Usename", Usename), new SqlParameter("Pwd", Pwd), new SqlParameter("Entity_ID", Entity_ID));
                return true;
            }
            catch
            { return false; }
        }
        #endregion
        #region 添加调度员信息,包含语音类型
        public bool AddLogininfo(string Usename, string Pwd, string Entity_ID,string roleId,decimal lo, decimal la, string voiceType)
        {
            try
            {
                //Entity entity = new Entity();
                //MyModel.Model_Entity me = entity.GetEntityinfo_byid(int.Parse(Entity_ID));
                //decimal lo = 0.0M;
                //decimal la = 0.0M;
                //if (me != null)
                //{
                //    lo = me.Lo;
                //    la = me.La;
                //}

                SQLHelper.ExecuteNonQuery(CommandType.Text, "INSERT [login] ([Usename],[Pwd],[RoleId],[Entity_ID],[usertype])VALUES (@Usename,@Pwd,@RoleId,@Entity_ID,1);;INSERT INTO use_pramater (lockid,username,device_timeout,hide_timeout_device,refresh_map_interval,last_lo,last_la,voiceType) VALUES (0,@Usename,'10',0,'5'," + lo + "," + la + "," + voiceType + ")", new SqlParameter("Usename", Usename), new SqlParameter("Pwd", Pwd), new SqlParameter("RoleId", roleId), new SqlParameter("Entity_ID", Entity_ID));
                return true;
            }
            catch(Exception ex)
            { return false; }
        }
        #endregion
        #region 添加配置用户信息
        public bool AddConfiguserinfo(string Usename, string Pwd, string Entity_ID, decimal lo, decimal la)
        {
            try
            {
                //Entity entity = new Entity();
                //MyModel.Model_Entity me = entity.GetEntityinfo_byid(int.Parse(Entity_ID));
                //decimal lo = 0.0M;
                //decimal la = 0.0M;
                //if (me != null)
                //{
                //    lo = me.Lo;
                //    la = me.La;
                //}

                SQLHelper.ExecuteNonQuery(CommandType.Text, "INSERT [login] ([Usename],[Pwd],[Entity_ID],[usertype])VALUES (@Usename,@Pwd,@Entity_ID,2);;INSERT INTO use_pramater (lockid,username,device_timeout,hide_timeout_device,refresh_map_interval,last_lo,last_la) VALUES (0,@Usename,'10',0,'5'," + lo + "," + la + ")", new SqlParameter("Usename", Usename), new SqlParameter("Pwd", Pwd), new SqlParameter("Entity_ID", Entity_ID));
                return true;
            }
            catch
            { return false; }
        }
        #endregion

        #region 根据ID取得调度员及配置用户信息
        public MyModel.Model_login GetLogininfo_byid(int id)
        {
            MyModel.Model_login logininfo = new MyModel.Model_login();
            DataTable dt = SQLHelper.ExecuteRead(CommandType.Text, "select top 1 * from [login] where id =@id", "logininfo", new SqlParameter("id", id));
            for (int dtcount = 0; dtcount < dt.Rows.Count; dtcount++)
            {
                logininfo.id = id;
                logininfo.Usename = dt.Rows[dtcount][1].ToString();
                logininfo.Pwd = dt.Rows[dtcount][2].ToString();
                logininfo.Entity_ID = dt.Rows[dtcount][3].ToString();
                logininfo.RoleId = int.Parse(dt.Rows[dtcount]["roleId"].ToString());
                logininfo.Power = dt.Rows[dtcount]["Power"].ToString();

            }
            return logininfo;
        }
        #endregion
        #region 根据ID取得调度员及配置用户的参数
        public MyModel.Model_LoginParameter GetLoginParameter_byUsername(string username)
        {
            MyModel.Model_LoginParameter LoginParameter = new MyModel.Model_LoginParameter();
            DataTable dt = SQLHelper.ExecuteRead(CommandType.Text, "select top 1 * from [use_pramater] where username =@username", "loginParameter", new SqlParameter("username", username));
            for (int dtcount = 0; dtcount < dt.Rows.Count; dtcount++)
            {

                LoginParameter.Usename = dt.Rows[dtcount]["username"].ToString();
                if (dt.Rows[dtcount]["voiceType"].ToString() == "" || dt.Rows[dtcount]["voiceType"].ToString() == null)
                {
                    LoginParameter.voiceType_Int = 1;
                }
                else
                {
                    LoginParameter.voiceType_Int = int.Parse(dt.Rows[dtcount]["voiceType"].ToString());
                }
            }
            return LoginParameter;
        }
        #endregion
        #region 根据ID修改调度员及配置用户信息
        public void EditLogininfo_byid(string Usename, string Pwd, string Entity_ID, int id)
        {
            SQLHelper.ExecuteNonQuery(CommandType.Text, "UPDATE [login] SET [Usename] =@Usename,[Pwd]=@Pwd,[Entity_ID]=@Entity_ID  where id =@id", new SqlParameter("Usename", Usename), new SqlParameter("Pwd", Pwd), new SqlParameter("Entity_ID", Entity_ID), new SqlParameter("id", id));
        }
        #endregion
        #region 根据ID修改调度员及配置用户参数，包含语音类型
        public void EditLogininfo_byid(string Usename, string Pwd,string roleId, string Entity_ID, int id, string voiceType)
        {
            SQLHelper.ExecuteNonQuery(CommandType.Text, "UPDATE [login] SET [Usename] =@Usename,[Pwd]=@Pwd,[roleId]=@roleId,[Entity_ID]=@Entity_ID  where id =@id;;UPDATE use_pramater SET voiceType = '" + voiceType + "' where username = '" + Usename + "'", new SqlParameter("Usename", Usename), new SqlParameter("Pwd", Pwd), new SqlParameter("roleId", roleId), new SqlParameter("Entity_ID", Entity_ID), new SqlParameter("id", id));
        }
        #endregion
        #region 根据ID检查用户名是否为admin
        public int CheckUsernameAdmin_byid(int id)
        {
            return int.Parse(SQLHelper.ExecuteScalar(CommandType.Text, "select count(*) from [login] where id=@id and [Usename] ='admin'", new SqlParameter("id", id)).ToString());
        }
        #endregion

        #region 根据ID删除调度员信息
        public void DelLogin_byid(int id)
        {
            StringBuilder sbSQL1 = new StringBuilder("DELETE FROM [login] where id =@id;");
            MyModel.Model_login ml = this.GetLogininfo_byid(id);
            if (ml != null)
            {
                StringBuilder sbSQL = new StringBuilder("Delete From use_pramater Where username='" + ml.Usename + "'");
                sbSQL1.Append(sbSQL.ToString());
            }
            SQLHelper.ExecuteNonQuery(CommandType.Text, sbSQL1.ToString(), new SqlParameter("id", id));
        }
        #endregion

        #region 调度员登陆
        public static int loginin(string username, string pwd)
        {
            return int.Parse(SQLHelper.ExecuteScalar(CommandType.Text, "select count(id) from login where [Usename] =@username and [Pwd]=@pwd", new SqlParameter("username", username), new SqlParameter("pwd", pwd)).ToString());
        }
        #endregion
        #region 用户登陆
        public static int loginin(string username, string pwd, int usertype)
        {
            return int.Parse(SQLHelper.ExecuteScalar(CommandType.Text, "select count(id) from login where [Usename] =@username and [Pwd]=@pwd and [usertype]=@usertype", new SqlParameter("username", username), new SqlParameter("pwd", pwd), new SqlParameter("usertype", usertype)).ToString());
        }
        #endregion
        #region 查询登陆用户id
        public static string GetLoginUserId(string username, string pwd, int usertype)
        {
            return (SQLHelper.ExecuteScalar(CommandType.Text, "select id from login where [Usename] =@username and [Pwd]=@pwd and [usertype]=@usertype", new SqlParameter("username", username), new SqlParameter("pwd", pwd), new SqlParameter("usertype", usertype)).ToString());
        }
        #endregion



        #region 查询用户名重复
        public static int loginin(string username, int id)
        {
            return (int.Parse(SQLHelper.ExecuteScalar(CommandType.Text, "select count(id) from login where [Usename] =@username and id <> @id", new SqlParameter("username", username), new SqlParameter("id", id)).ToString()));
        }
        #endregion

        #region 查询用户权限
        public static DataTable GetPower(string username, string pwd, int usertype)
        {
            return (SQLHelper.ExecuteRead(
                CommandType.Text, "select l.id,RoleId,r.Power from login l left join Role r on l.RoleId=r.id where Usename=@userName and Pwd=@pwd and usertype=@userType",
            "userpower", new SqlParameter("userName", username), new SqlParameter("pwd", pwd), new SqlParameter("userType", usertype))
                );
        }
        #endregion

        #region 获取权限功能列表
        public static DataTable GetPowerFunction()
        {
            return (SQLHelper.ExecuteRead(
                CommandType.Text, "select PowerKey,id from PowerFunction where Status=1 order by id asc", "powerFunction")
                );
        }
        #endregion

        public static bool PowerCheck(string powerName)
        {
            bool result = false;
            System.Web.UI.Page page = (System.Web.UI.Page)System.Web.HttpContext.Current.CurrentHandler;

            string powerId = (SQLHelper.ExecuteScalar(CommandType.Text, "select id from PowerFunction where PowerName=@powerName", new SqlParameter("powerName", powerName)).ToString());

            //读取 Cookie 集合
            for (int i = 0; i < page.Request.Cookies.Count; i++)
            {
                if (page.Request.Cookies.AllKeys[i] == "userPower")
                {

                    System.Web.HttpCookie cookies = page.Request.Cookies["userPower"];

                    if (cookies.HasKeys)//是否有子键
                    {
                        System.Collections.Specialized.NameValueCollection NameColl = cookies.Values;
                        for (int j = 0; j < NameColl.Count; j++)
                        {

                            //page.Response.Write("子键名=" + NameColl.AllKeys[j] + "<br/>");
                            //page.Response.Write("子键值=" + NameColl[j] + "<br/>");
                            if (powerId == NameColl[j])
                            {
                                result = true;
                                break;

                            }
                        }

                    }
                    else
                    {
                        result = false;
                    }
                }

                if (result)
                    break;
            }

            return result;

        }

        #region 根据用户名密码取得单位ID
        public static string GetEntityID(string username, string pwd)
        {
            return (SQLHelper.ExecuteScalar(CommandType.Text, "select [Entity_ID] from login where [Usename] =@username and [Pwd]=@pwd", new SqlParameter("username", username), new SqlParameter("pwd", pwd)).ToString());
        }
        #endregion

        #region 关闭显示ISSI设备
        public static void HDISSI(string ISSI, string Usename)
        {
            int countpc = int.Parse(SQLHelper.ExecuteScalar(CommandType.Text, "select count(*) from use_pramater where username=@username and lockid = ( select id  from User_info where ISSI =@ISSI )", new SqlParameter("username", Usename), new SqlParameter("ISSI", ISSI)).ToString());

            if (countpc < 1)
            {
                SQLHelper.ExecuteNonQuery(CommandType.Text, "UPDATE [login] SET [HDISSI] =[HDISSI]+'<'+@ISSI+'>' where [Usename] =@Usename", new SqlParameter("ISSI", ISSI), new SqlParameter("Usename", Usename));
                DbComponent.LogModule.SystemLog.WriteLog(MyModel.Enum.ParameType.UIS, MyModel.Enum.OperateLogType.operlog, MyModel.Enum.OperateLogModule.ModuleApplication, MyModel.Enum.OperateLogOperType.MobileDisplay, "Lang_hidden_ISSI", MyModel.Enum.OperateLogIdentityDeviceType.MobilePhone, ISSI);
            }
        }
        #endregion

        #region 根据用户名获得隐藏ISSI列表
        public static string GETHDISSI(string Usename)
        {
            try
            {
                return SQLHelper.ExecuteScalar(CommandType.Text, "select [HDISSI]  from login where [Usename] =@Usename", new SqlParameter("Usename", Usename)).ToString();
            }
            catch (Exception ex)
            {
                return "";
            }
        }
        #endregion

        #region 开启显示ISSI设备
        public static void DISISSI(string ISSI, string Usename)
        {
            SQLHelper.ExecuteNonQuery(CommandType.Text, "UPDATE [login] SET [HDISSI] =REPLACE([HDISSI],'<'+@ISSI+'>','') where [Usename] =@Usename", new SqlParameter("ISSI", ISSI), new SqlParameter("Usename", Usename));
            DbComponent.LogModule.SystemLog.WriteLog(MyModel.Enum.ParameType.UIS, MyModel.Enum.OperateLogType.operlog, MyModel.Enum.OperateLogModule.ModuleApplication, MyModel.Enum.OperateLogOperType.MobileDisplay, "Lang_open_ISSI", MyModel.Enum.OperateLogIdentityDeviceType.MobilePhone, ISSI);

        }
        #endregion

        #region 返回当前用户登陆的心跳时间
        public static DateTime checkuselogintime(string usename)
        {
            DateTime dt = new DateTime(1900, 1, 1, 1, 1, 1);
            try
            {
                return Convert.ToDateTime(SQLHelper.ExecuteScalar(CommandType.Text, "select [lastinlinetime]  from login where [Usename] =@Usename", new SqlParameter("Usename", usename)).ToString());

            }
            catch
            {
                return dt;

            }

        }
        #endregion

        #region 更新用户登陆时间和最后心跳时间
        public static void updateloginandlasttime(string usename)
        {
            SQLHelper.ExecuteNonQuery(CommandType.Text, "UPDATE [login] SET [loginintime] =getdate(),[lastinlinetime]=getdate() where [Usename] =@Usename", new SqlParameter("Usename", usename));
        }
        #endregion

        #region 清空最后心跳时间
        public static void updatelasttime(string usename)
        {
            SQLHelper.ExecuteNonQuery(CommandType.Text, "UPDATE [login] SET [lastinlinetime] =null,[loginintime] =null where [Usename] =@Usename", new SqlParameter("Usename", usename));

        }
        #endregion

        #region 根据用户名取得调度员信息
        public MyModel.Model_login GetLogininfoByUserName(string UserName)
        {
            MyModel.Model_login logininfo = new MyModel.Model_login();
            DataTable dt = SQLHelper.ExecuteRead(CommandType.Text, "select top 1 * from [login] where Usename =@UserName", "logininfo", new SqlParameter("UserName", UserName));
            foreach (DataRow dr in dt.Rows)
            {
                logininfo.id = int.Parse(dr["id"].ToString());
                logininfo.Usename = dr["Usename"].ToString();
                logininfo.Pwd = dr["Pwd"].ToString();
                logininfo.Entity_ID = dr["Entity_ID"].ToString();
                logininfo.HDISSI = dr["HDISSI"].ToString();
            }
            return logininfo;
        }
        #endregion

        #region  获取所有调度员信息用于和MD5比较
        public static DataTable loginAll(string UserName)
        {
            DataTable dt = SQLHelper.ExecuteRead(CommandType.Text, "select Pwd,usertype from [login] where Usename =@UserName", "logininfo", new SqlParameter("UserName", UserName));
         
           return dt;

        }
        #endregion 

        #region 根据用户名获取HDISSI-------------------------------xzj--2018/4/17-------------------------------------------
        public string GetHDISSIByUserName(string userName)
        {
            string returnUserName;
            object o = SQLHelper.ExecuteScalar(CommandType.Text, "select HDISSI from login where Usename=@userName", new SqlParameter("userName", userName));
            if (o is DBNull)
            {
                returnUserName = "";
            }
            else
            {
                returnUserName = o.ToString();
            }
            return returnUserName;
        }
        #endregion

    }
}
