using System;
using System.Data;
using System.Data.SqlClient;
using Ryu666.Components;
using System.Text.RegularExpressions;

namespace DbComponent
{
    public class ISSI
    {
        private string connstring = System.Configuration.ConfigurationManager.AppSettings["m_connectionString"];

        #region 分页排序终端信息
        public DataTable AllISSIInfo(int selectcondition, string textseach, int id, string stringid, int isExternal, string sort, int startRowIndex, int maximumRows)
        {
            if (stringid == null)
            {
                if (isExternal == 1)
                {
                    string sqlcondition = "";
                    sqlcondition += " and IsExternal=" + isExternal + "";
                    if (sort == "") { sort = "id asc"; }
                    return SQLHelper.ExecuteRead(CommandType.Text, "WITH lmenu(name,id) as (SELECT name,id  FROM [Entity] WHERE id=@id UNION ALL SELECT A.NAME,A.id FROM [Entity] A,lmenu b    where a.[ParentID] = b.id) select * from [ISSI_info] where len([ISSI]) > 0 " + sqlcondition + " and [Entity_ID] in (select id from lmenu) order by " + sort, startRowIndex, maximumRows, "Entity", new SqlParameter("id", id));
                }
                else
                {
                    string sqlcondition = "";
                    if (selectcondition != 0) { sqlcondition += " and [Entity_ID]='" + selectcondition + "'"; }
                    if (textseach != null) { sqlcondition += " and [ISSI] like '%" + stringfilter.Filter(textseach.Trim()) + "%'"; }
                    if (sort == "") { sort = "id asc"; }
                    return SQLHelper.ExecuteRead(CommandType.Text, "WITH lmenu(name,id) as (SELECT name,id  FROM [Entity] WHERE id=@id UNION ALL SELECT A.NAME,A.id FROM [Entity] A,lmenu b    where a.[ParentID] = b.id) select * from [ISSI_info] where len([ISSI]) > 0 " + sqlcondition + " and [Entity_ID] in (select id from lmenu) order by " + sort, startRowIndex, maximumRows, "Entity", new SqlParameter("id", id));

                }
            }
            else
            {
                return SQLHelper.ExecuteRead(CommandType.Text, "select * from [ISSI_info] where len([ISSI]) > 0 and id =@id ", startRowIndex, maximumRows, "Entity", new SqlParameter("id", stringid));

            }
        }
        #endregion

        #region 取得终端数量信息
        public int getallIIScount(int selectcondition, string textseach, int id, string stringid, int isExternal)
        {
            if (stringid == null)
            {
                if (isExternal == 1)
                {
                    string sqlcondition = "";
                    sqlcondition += " and IsExternal=" + isExternal + "";
                    return int.Parse(SQLHelper.ExecuteScalar(CommandType.Text, "WITH lmenu(name,id) as (SELECT name,id  FROM [Entity] WHERE id=@id UNION ALL SELECT A.NAME,A.id FROM [Entity] A,lmenu b    where a.[ParentID] = b.id) select count(*) from ISSI_info where len([ISSI]) > 0 and [Entity_ID] in (select id from lmenu)" + sqlcondition, new SqlParameter("id", id)).ToString());
                }
                else
                {
                    string sqlcondition = "";
                    if (selectcondition != 0) { sqlcondition += " and [Entity_ID]='" + selectcondition + "'"; }
                    if (textseach != null) { sqlcondition += " and [ISSI] like '%" + stringfilter.Filter(textseach.Trim()) + "%'"; }
                    return int.Parse(SQLHelper.ExecuteScalar(CommandType.Text, "WITH lmenu(name,id) as (SELECT name,id  FROM [Entity] WHERE id=@id UNION ALL SELECT A.NAME,A.id FROM [Entity] A,lmenu b    where a.[ParentID] = b.id) select count(*) from ISSI_info where len([ISSI]) > 0 and [Entity_ID] in (select id from lmenu)" + sqlcondition, new SqlParameter("id", id)).ToString());
                }
            }
            else
            {
                return int.Parse(SQLHelper.ExecuteScalar(CommandType.Text, "select count(*) from ISSI_info where len([ISSI]) > 0 and id=@id", new SqlParameter("id", stringid)).ToString());
            }
        }
        #endregion

        #region 添加终端信息
        //public bool AddISSIinfo(string ISSI, string GSSIS, string Entity_ID, bool status,string bz)
        //{
        //    try
        //    {
        //        SQLHelper.ExecuteNonQuery(CommandType.Text, "INSERT [ISSI_info] ([ISSI],[GSSIS],[Entity_ID],[status],[Bz])VALUES (@ISSI,@GSSIS,@Entity_ID,@status,@bz)", new SqlParameter("ISSI", ISSI), new SqlParameter("GSSIS", GSSIS), new SqlParameter("Entity_ID", Entity_ID), new SqlParameter("status", status), new SqlParameter("bz", bz));
        //        return true;
        //    }
        //    catch
        //    {return false;}

        //}
        #endregion
        #region 添加终端信息,包含终端类型、OriginalIssi
        public bool AddISSIinfo(string ISSI, string typeName, string GSSIS, string Entity_ID, bool status, string bz, string OrginalIssi, string factury, string model, int isExternal)
        {
            try
            {
                SQLHelper.ExecuteNonQuery(CommandType.Text, "INSERT [ISSI_info] ([ISSI],[OriginalIssi],[typeName],[GSSIS],[Entity_ID],[status],[Bz],[Productmodel],[Manufacturers],[IsExternal])VALUES (@ISSI,@OriginalIssi,@typeName,@GSSIS,@Entity_ID,@status,@bz,@Productmodel,@Manufacturers,@IsExternal)", new SqlParameter("ISSI", ISSI), new SqlParameter("OriginalIssi", OrginalIssi), new SqlParameter("typeName", typeName), new SqlParameter("GSSIS", GSSIS), new SqlParameter("Entity_ID", Entity_ID), new SqlParameter("status", status), new SqlParameter("bz", bz), new SqlParameter("Productmodel", model), new SqlParameter("Manufacturers", factury), new SqlParameter("IsExternal", isExternal));
                return true;
            }
            catch
            { return false; }

        }
        #endregion
        #region 添加终端信息,包含终端类型、ip地址
        //public bool AddISSIinfo(string ISSI, string typeName, string ipAddress, string GSSIS, string Entity_ID, bool status, string bz)
        //{
        //    try
        //    {
        //        SQLHelper.ExecuteNonQuery(CommandType.Text, "INSERT [ISSI_info] ([ISSI],[typeName],[ipAddress],[GSSIS],[Entity_ID],[status],[Bz])VALUES (@ISSI,@typeName,@ipAddress,@GSSIS,@Entity_ID,@status,@bz)", new SqlParameter("ISSI", ISSI), new SqlParameter("typeName", typeName), new SqlParameter("ipAddress", ipAddress), new SqlParameter("GSSIS", GSSIS), new SqlParameter("Entity_ID", Entity_ID), new SqlParameter("status", status), new SqlParameter("bz", bz));
        //        return true;
        //    }
        //    catch
        //    { return false; }

        //}
        #endregion
        #region 根据ID取终端信息
        public MyModel.Model_ISSI GetISSIinfo_byid(int id)
        {
            MyModel.Model_ISSI issi = new MyModel.Model_ISSI();
            DataTable dt = SQLHelper.ExecuteRead(CommandType.Text, "select top 1 * from [ISSI_info] where id =@id", "ISSIinfo", new SqlParameter("id", id));
            for (int dtcount = 0; dtcount < dt.Rows.Count; dtcount++)
            {
                issi.id = id;

                issi.ISSI = dt.Rows[dtcount]["ISSI"].ToString();
                issi.GSSIS = dt.Rows[dtcount]["GSSIS"].ToString();
                issi.OriginalIssi = dt.Rows[dtcount]["OriginalIssi"].ToString();
                issi.Entity_ID = dt.Rows[dtcount]["Entity_ID"].ToString();
                issi.status = dt.Rows[dtcount]["status"].ToString().Trim();
                issi.Bz = dt.Rows[dtcount]["Bz"].ToString();
                issi.typeName = dt.Rows[dtcount]["typeName"].ToString().Trim();
                issi.ipAddress = dt.Rows[dtcount]["ipAddress"].ToString().Trim();
                issi.Manufacturers = dt.Rows[dtcount]["Manufacturers"].ToString().Trim();
                issi.Productmodel = dt.Rows[dtcount]["Productmodel"].ToString().Trim();
                issi.IsExternal = int.Parse(dt.Rows[dtcount]["IsExternal"].ToString());
            }
            return issi;
        }
        #endregion

        #region 获取ISSI中短信息根据ISSI
        public MyModel.Model_ISSI GetISSIinfoByISSI(string ISSI)
        {
            MyModel.Model_ISSI issi = new MyModel.Model_ISSI();
            DataTable dt = SQLHelper.ExecuteRead(CommandType.Text, "select top 1 * from [ISSI_info] where ISSI =@ISSI", "ISSIinfo", new SqlParameter("ISSI", ISSI));
            for (int dtcount = 0; dtcount < dt.Rows.Count; dtcount++)
            {
                issi.id = int.Parse(dt.Rows[dtcount]["id"].ToString());
                issi.ISSI = dt.Rows[dtcount]["ISSI"].ToString();
                issi.OriginalIssi = dt.Rows[dtcount]["OriginalIssi"].ToString();
                issi.GSSIS = dt.Rows[dtcount]["GSSIS"].ToString();
                issi.Entity_ID = dt.Rows[dtcount]["Entity_ID"].ToString();
                issi.status = dt.Rows[dtcount]["status"].ToString();
                issi.IsExternal = int.Parse(dt.Rows[dtcount]["IsExternal"].ToString());
            }
            return issi;
        }
        #endregion

        #region 根据ID修改终端信息
        public void EditISSIinfo_byid(int id, string issi, string gssi, Boolean status, string bz, string model, string factory, int isExternal)
        {
            SQLHelper.ExecuteNonQuery(CommandType.Text, "UPDATE [ISSI_info] SET [ISSI] =@issi,[GSSIS]=@gssi,[status]=@status,[Bz]=@bz,[Productmodel]=@Productmodel,[Manufacturers]=@Manufacturers,[IsExternal]=@IsExternal where id =@id", new SqlParameter("issi", issi), new SqlParameter("gssi", gssi), new SqlParameter("status", status), new SqlParameter("bz", bz), new SqlParameter("id", id), new SqlParameter("Productmodel", model), new SqlParameter("Manufacturers", factory), new SqlParameter("IsExternal", isExternal));
        }
        #endregion
        #region 根据ID修改终端信息,包含ipAddress
        public void EditISSIinfo_byid(int id, string issi, string ipAddress, string gssi, Boolean status, string bz)
        {
            SQLHelper.ExecuteNonQuery(CommandType.Text, "UPDATE [ISSI_info] SET [ISSI] =@issi,[ipAddress]=@ipAddress,[GSSIS]=@gssi,[status]=@status,[Bz]=@bz  where id =@id", new SqlParameter("issi", issi), new SqlParameter("ipAddress", ipAddress), new SqlParameter("gssi", gssi), new SqlParameter("status", status), new SqlParameter("bz", bz), new SqlParameter("id", id));
        }
        #endregion
        #region 根据ID检查设备呼叫状态
        public int ISSIstatus_byid(int id)
        {
            return int.Parse(SQLHelper.ExecuteScalar(CommandType.Text, "select count(*) from [ISSI_info] where id=@id  and [status] =1", new SqlParameter("id", id)).ToString());
        }
        #endregion

        #region 根据ID删除设备信息
        public void DelISSIinfo_byid(int id)
        {
            SQLHelper.ExecuteNonQuery(CommandType.Text, "DELETE FROM [ISSI_info] where id =@id", new SqlParameter("id", id));
        }
        #endregion

        #region 根据ISSI查询重复
        public int checkISSI(string ISSI, int id)
        {
            int intissi = int.Parse(SQLHelper.ExecuteScalar(CommandType.Text, "SELECT COUNT(id) FROM [dbo].[ISSI_info]  where ISSI = @ISSI and id <>@id ", new SqlParameter("ISSI", ISSI), new SqlParameter("id", id)).ToString());
            //int intDispatch = int.Parse(SQLHelper.ExecuteScalar(CommandType.Text, "SELECT COUNT(id) FROM [Dispatch_Info]  where ISSI = @ISSI and id <>@id ", new SqlParameter("ISSI", ISSI), new SqlParameter("id", id)).ToString());
            //int intgroup = int.Parse(SQLHelper.ExecuteScalar(CommandType.Text, "SELECT COUNT(id) FROM [Group_info]  where GSSI = @ISSI and id <>@id ", new SqlParameter("ISSI", ISSI), new SqlParameter("id", id)).ToString());
            return intissi;
        }
        #endregion

        #region 根据OrginalIssi查询重复
        public int checkOriginalIssi(string OriginalIssi)
        {
            return int.Parse(SQLHelper.ExecuteScalar(CommandType.Text, "SELECT COUNT(id) FROM [dbo].[ISSI_info]  where OriginalIssi = @OriginalIssi ", new SqlParameter("OriginalIssi", OriginalIssi)).ToString());

        }
        #endregion

        #region 确定该ISSI是否存在且未使用
        public int checkISSIANDNotInuse(string ISSI, string oldISSI)
        {
            if (ISSI == oldISSI)
            {
                return 1;
            }
            else
            {
                return int.Parse(SQLHelper.ExecuteScalar(CommandType.Text, "SELECT COUNT(id) FROM [dbo].[ISSI_info]  where ISSI = @ISSI and ISSI not in (SELECT ISSI FROM [User_info] where LEN(ISSI) >0 and ISSI <>@oldISSI)", new SqlParameter("ISSI", ISSI), new SqlParameter("oldISSI", oldISSI)).ToString());
            }
        }
        #endregion

        #region 确定个数查找相似未使用的ISSI
        public DataTable searchISSI(string ISSI, int count)
        {
            return (SQLHelper.ExecuteRead(CommandType.Text, "SELECT top " + count + " ISSI FROM [dbo].[ISSI_info]  where ISSI like '%" + ISSI + "%' and ISSI not in (SELECT ISSI FROM [User_info] where LEN(ISSI) >0)", "issi"));
        }
        #endregion

        #region 根据ISSI判断终端是否在线
        public static int checkonlineISSI(string issi, int devicetimeout)
        {
            string weizhuce = ResourceManager.GetString("UNLogin");
            string poweroff = ResourceManager.GetString("PowerOff");
            string zhitongmodel = ResourceManager.GetString("Directmode");
            string Illegal = ResourceManager.GetString("Illegal");
            return int.Parse(SQLHelper.ExecuteScalar(CommandType.Text, "SELECT COUNT(*) FROM [GIS_info] where ISSI =@issi and Send_reason not in ('" + weizhuce + "','" + poweroff + "','" + zhitongmodel + "','" + Illegal + "') and DATEDIFF(MINUTE,Send_time,GETDATE()) < " + devicetimeout, new SqlParameter("issi", issi)).ToString());
            //return int.Parse(SQLHelper.ExecuteScalar(CommandType.Text, "SELECT COUNT(*) FROM [GIS_info] where ISSI =@issi and Send_reason not in ('未注册','关机','直通模式','非法') and DATEDIFF(MINUTE,Send_time,GETDATE()) < " + devicetimeout, new SqlParameter("issi", issi)).ToString());

        }

        #endregion
        public DataTable GetAllTerminalType()
        {
            return SQLHelper.ExecuteRead(CommandType.Text, "select typeName from TerminalType", "terminaltype");
        }
        public string checkISSIAndTypeValidate(string ISSI, string typeName)
        {
            string result = "none";
            GetLDAPInfo getInfo = new GetLDAPInfo();
            string resultInfo = getInfo.GetInfoByISSI(ISSI);

            return result;
        }
        public Boolean checkIpAddressPartten(string ipAddress)
        {
            bool isIp = false;
            string ipPartten = "^(\\d{1,2}|1\\d\\d|2[0-4]\\d|25[0-5]).(\\d{1,2}|1\\d\\d|2[0-4]\\d|25[0-5]).(\\d{1,2}|1\\d\\d|2[0-4]\\d|25[0-5]).(\\d{1,2}|1\\d\\d|2[0-4]\\d|25[0-5])$";

            isIp = Regex.IsMatch(ipAddress, ipPartten);
            return isIp;
        }
        #region 根据ISSI获取status,id-----------------xzj--2018/4/17---------------------------------------
        public DataTable GetUserISSIStatusAndIDByISSI(string ISSI)
        {
            return SQLHelper.ExecuteRead(CommandType.Text, "select User_info.id,ISSI_info.status from ISSI_info left join User_info on User_info.ISSI=ISSI_info.ISSI where User_info.ISSI=@ISSI", "ISSI_info", new SqlParameter("ISSI", ISSI));
            //return int.Parse((SQLHelper.ExecuteScalar(CommandType.Text, "select status from ISSI_info where ISSI=@ISSI", new SqlParameter("ISSI", ISSI))).ToString());
        }
        #endregion
    }
}
