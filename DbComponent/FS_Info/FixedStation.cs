using System;
using System.Data;
using System.Data.SqlClient;
using System.Reflection;
using System.Text;

namespace DbComponent.FS_Info
{
    public class FixedStation : IFixedStationDao
    {
        private static readonly log4net.ILog log = log4net.LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);

        #region FixedStation 固定台
        public bool AddFixedStation(Model_FixedStation model)
        {
            StringBuilder sbSql = new StringBuilder();
            StringBuilder sbStr1 = new StringBuilder();
            StringBuilder sbStr2 = new StringBuilder();
            sbSql.Append("insert into FixedStation_info (");
            if (model.StationISSI != null)
            {
                sbStr1.Append("[StationISSI],");
                sbStr2.Append("'" + model.StationISSI + "',");
            }
            if (model.Entity_ID != null)
            {
                sbStr1.Append("[Entity_ID],");
                sbStr2.Append("'" + model.Entity_ID + "',");
            }
            if (model.GSSIS != null)
            {
                sbStr1.Append("[GSSIS],");
                sbStr2.Append("'" + model.GSSIS + "',");
            }
            if (model.Lo != null)
            {
                sbStr1.Append("[Lo],");
                sbStr2.Append("'" + model.Lo + "',");
            }
            if (model.La != null)
            {
                sbStr1.Append("[La],");
                sbStr2.Append("'" + model.La + "',");
            }
            if (model.IsDisplay != null)
            {
                sbStr1.Append("[IsDisplay],");
                sbStr2.Append("'" + model.IsDisplay + "',");
            }
            if (sbStr1.Length > 0)
            {
                sbSql.Append(sbStr1.ToString().Substring(0, sbStr1.ToString().Length - 1));
                sbSql.Append(") values (");
                sbSql.Append(sbStr2.ToString().Substring(0, sbStr2.ToString().Length - 1));
                sbSql.Append(")");
            }
            else
            {
                sbSql.Append(sbStr1.ToString());
                sbSql.Append(") values (");
                sbSql.Append(sbStr2.ToString());
                sbSql.Append(")");
            }
            try
            {
                SQLHelper.ExecuteNonQuery(CommandType.Text, sbSql.ToString());
                return true;
            }
            catch (Exception ex)
            {
                log.Info(sbSql.ToString());
                log.Error(ex);
                return false;
            }
        }

        public bool UpdateFixedStation(Model_FixedStation newModel)
        {
            StringBuilder sbSQL = new StringBuilder();
            sbSQL.Append("update FixedStation_info set ");
            bool flag = false;
            if (newModel.StationISSI != null)
            {
                sbSQL.Append(" [StationISSI] = '" + newModel.StationISSI + "',");
                flag = true;
            }
            if (newModel.Entity_ID != null)
            {
                sbSQL.Append(" [Entity_ID] = '" + newModel.Entity_ID + "',");
                flag = true;
            }
            if (newModel.GSSIS != null)
            {
                sbSQL.Append(" [GSSIS] = '" + newModel.GSSIS + "',");
                flag = true;
            }
            if (newModel.Lo != null)
            {
                sbSQL.Append(" [Lo] = '" + newModel.Lo + "',");
                flag = true;
            }
            if (newModel.La != null)
            {
                sbSQL.Append(" [La] = '" + newModel.La + "',");
                flag = true;
            }
            if (newModel.IsDisplay != null)
            {
                sbSQL.Append(" [IsDisplay] = '" + newModel.IsDisplay + "',");
                flag = true;
            }
            string strSql = "";
            if (flag)
            {
                strSql = sbSQL.ToString().Substring(0, sbSQL.ToString().Length - 1);
            }

            strSql += " where ID=@ID";

            int i = 0;
            try
            {
                log.Info(strSql);
                i = SQLHelper.ExecuteNonQuery(CommandType.Text, strSql, new SqlParameter("ID", newModel.ID));
                if (i > 0)
                    return true;
                else return false;
            }
            catch (Exception ex)
            {
                log.Info(strSql);
                log.Error(ex);
                return false;
            }
        }

        #region 根据ID删除现有固定台
        public bool DeleteFixedStation(int ID)
        {
            StringBuilder sbSQL = new StringBuilder("DELETE FROM FixedStation_info WHERE ID=@ID");
            try
            {
                SQLHelper.ExecuteNonQuery(CommandType.Text, sbSQL.ToString(), new SqlParameter("ID", ID));
                return true;
            }
            catch (Exception ex)
            {
                log.Info(sbSQL.ToString());
                log.Error(ex);
                return false;
            }
        }
        #endregion

        #region 根据ISSI获取固定台信息
        public Model_FixedStation GetFixedStationByISSI(string StationISSI)
        {
            StringBuilder sbSQL = new StringBuilder(" SELECT TOP 1 [ID],[StationISSI],[Entity_ID],[GSSIS],[Lo],[La],[IsDisplay] FROM FixedStation_info WHERE StationISSI=@ISSI");
            DataTable dt = SQLHelper.ExecuteRead(CommandType.Text, sbSQL.ToString(), "asdfadfaf", new SqlParameter("StationISSI", StationISSI));
            if (dt != null && dt.Rows.Count == 1)
            {
                DataRow dr = dt.Rows[0];
                return new Model_FixedStation { ID = int.Parse(dr["ID"].ToString()), StationISSI = dr["StationISSI"].ToString(), Entity_ID = dr["Entity_ID"].ToString(), GSSIS = dr["GSSIS"].ToString(), Lo = decimal.Parse(dr["lo"].ToString()), La = decimal.Parse(dr["la"].ToString()), IsDisplay = Convert.ToBoolean(dr["IsDisplay"].ToString()) };

            }
            else return null;
        }
        #endregion

        #region 根据ID获取固定台信息
        public Model_FixedStation GetFixedStationByID(int ID)
        {
            StringBuilder sbSQL = new StringBuilder(" SELECT TOP 1 [ID],[StationISSI],[GSSIS],[Entity_ID],[Lo],[La],[IsDisplay] FROM FixedStation_info WHERE ID=@ID");
            DataTable dt = SQLHelper.ExecuteRead(CommandType.Text, sbSQL.ToString(), "ad22faf", new SqlParameter("ID", ID));
            if (dt != null && dt.Rows.Count == 1)
            {
                DataRow dr = dt.Rows[0];
                return new Model_FixedStation { ID = ID, StationISSI = dr["StationISSI"].ToString(), Entity_ID = dr["Entity_ID"].ToString(), GSSIS = dr["GSSIS"].ToString(), Lo = decimal.Parse(dr["lo"].ToString()), La = decimal.Parse(dr["la"].ToString()), IsDisplay = Convert.ToBoolean(dr["IsDisplay"].ToString()) };
            }
            else return null;
        }
        #endregion

        #region 获取固定台数量
        public int getAllFixedStationCount()
        {
            StringBuilder sbSQL = new StringBuilder();
            sbSQL.Append("select  count(0) from [FixedStation_info]  ");
            return int.Parse(SQLHelper.ExecuteScalar(CommandType.Text, sbSQL.ToString()).ToString());
        }

        public int getAllFixedStationCount(string selectcondition, string textseach, int id)
        {
            string strWhere = " where 1=1 ";
            if (selectcondition != "0")
            {
                strWhere += "and [Entity_ID]=" + selectcondition;
            }
            if (!string.IsNullOrEmpty(textseach))
            {
                strWhere += "and [StationISSI] like '%" + textseach.Trim() + "%'";
            }
            StringBuilder sbSQL = new StringBuilder();
            sbSQL.Append("select  count(0) from FixedStation_info a left join Entity b on a.Entity_ID=b.ID  " + strWhere);
            return int.Parse(SQLHelper.ExecuteScalar(CommandType.Text, sbSQL.ToString()).ToString());
        }

        #endregion
        public DataTable GetAllFixedStation(string selectcondition, string textseach, int id, string sort, int startRowIndex, int maximumRows)
        {
            string strWhere = " where 1=1 ";
            if (sort == "") { sort = "id asc"; }
            StringBuilder sbSQL = new StringBuilder();
            if (selectcondition != "0")
            {
                strWhere += "and [Entity_ID]=" + selectcondition;
            }
            if (!string.IsNullOrEmpty(textseach))
            {
                strWhere += "and StationISSI like '%" + textseach + "%'";
            }
            sbSQL.Append("select a.ID,StationISSI,GSSIS,Name,a.lo,a.la,a.IsDisplay from FixedStation_info a left join Entity b on a.Entity_ID=b.ID " + strWhere + "   order by " + sort);
            return SQLHelper.ExecuteRead(CommandType.Text, sbSQL.ToString(), startRowIndex, maximumRows, "FixedStation_info");
        }

        public DataTable GetAllFixedStation(string sort, int startRowIndex, int maximumRows)
        {
            if (sort == "") { sort = "id asc"; }
            StringBuilder sbSQL = new StringBuilder();
            sbSQL.Append("select  *  from [FixedStation_info]   order by " + sort);
            return SQLHelper.ExecuteRead(CommandType.Text, sbSQL.ToString(), startRowIndex, maximumRows, "FixedStation_info");
        }

        public DataTable GetAllFixedStation()
        {
            StringBuilder sbSQL = new StringBuilder("SELECT * FROM FixedStation_info a left join Entity b on a.Entity_ID=b.ID");
            return SQLHelper.ExecuteRead(CommandType.Text, sbSQL.ToString(), "edfa");
        }

        #region 根据ID获取固定台驻留组信息
        public string GetIDByEntity_ID(string Entity_ID)
        {
            StringBuilder sbSQL = new StringBuilder("SELECT top 1 ID FROM FixedStation_info WHERE Entity_ID=@Entity_ID");
            DataTable dt = SQLHelper.ExecuteRead(CommandType.Text, sbSQL.ToString(), "dividifd", new SqlParameter("Entity_ID", Entity_ID));
            if (dt != null && dt.Rows.Count > 0)
            {
                return dt.Rows[0]["ID"].ToString();
            }
            else
                return "";
        }
        #endregion

        #region 根据ISSI号判断新增固定台是否和已有的相重
        public bool FindFixedStationISSIForAdd(string ISSI)
        {
            bool isReturn = false;
            string strSQL = "select count(0) from FixedStation_info where StationISSI = @StationISSI";
            DataTable dt = SQLHelper.ExecuteRead(CommandType.Text, strSQL, "dsdsf", new SqlParameter("StationISSI", ISSI));
            try
            {
                if (int.Parse(dt.Rows[0][0].ToString()) > 0)
                {
                    isReturn = true;
                }
            }
            catch (Exception ex) { }
            return isReturn;
        }
        #endregion

        #region 根据ID和ISSI号判断新增固定台是否和已有的相重
        public bool FindFixedStationISSIForUpdate(int ID, string ISSI)
        {
            bool isReturn = false;
            string strSQL = "select count(0) from FixedStation_info where StationISSI = @StationISSI and ID!=@ID";
            DataTable dt = SQLHelper.ExecuteRead(CommandType.Text, strSQL, "dsdsf", new SqlParameter("StationISSI", ISSI), new SqlParameter("ID", ID));
            try
            {
                if (int.Parse(dt.Rows[0][0].ToString()) > 0)
                {
                    isReturn = true;
                }
            }
            catch (Exception ex) { }
            return isReturn;
        }
        #endregion

        #region 根据所属单位判断新增固定台是否和已有的相重
        public bool FindFixedStationNameForAdd(string GSSIS)
        {
            bool isReturn = false;
            string strSQL = "select count(0) from FixedStation_info where GSSIS = @GSSIS";
            DataTable dt = SQLHelper.ExecuteRead(CommandType.Text, strSQL, "dsdsf", new SqlParameter("GSSIS", GSSIS));
            try
            {
                if (int.Parse(dt.Rows[0][0].ToString()) > 0)
                {
                    isReturn = true;
                }
            }
            catch (Exception ex) { }
            return isReturn;
        }
        #endregion

        #region 根据ID和所属单位判断新增固定台是否和已有的相重
        public bool FindFixedStationNameForUpdate(int ID, string GSSIS)
        {
            bool isReturn = false;
            string strSQL = "select count(0) from FixedStation_info where GSSIS = @GSSIS and ID!=@ID";
            DataTable dt = SQLHelper.ExecuteRead(CommandType.Text, strSQL, "dsdsf", new SqlParameter("GSSIS", GSSIS), new SqlParameter("ID", ID));
            try
            {
                if (int.Parse(dt.Rows[0][0].ToString()) > 0)
                {
                    isReturn = true;
                }
            }
            catch (Exception ex) { }
            return isReturn;
        }
        #endregion

        #endregion
    }
}
