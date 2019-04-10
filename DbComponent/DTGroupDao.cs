using DbComponent.IDAO;
using MyModel;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Reflection;
using System.Text;
namespace DbComponent
{
    public class DTGroupDao 
    {
        
        private static readonly log4net.ILog log = log4net.LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);

        #region IBaseStationDao 成员
        public bool AddDTGroup(string Name,string issi)
        {
            StringBuilder sbSql = new StringBuilder("INSERT into DTGroup_info (Group_name,GSSI) values (@Name,@issi)");
          
            try
            {
                SQLHelper.ExecuteNonQuery(CommandType.Text, sbSql.ToString(), new SqlParameter("Name", Name), new SqlParameter("issi", issi));
                return true;
            }
            catch (Exception ex)
            {
                log.Info(sbSql.ToString());
                log.Error(ex);
                return false;
            }
        }


        public bool DeleteDTGroup(string GSSI)
        {
            StringBuilder sbSQL = new StringBuilder("DELETE FROM DTGroup_info WHERE GSSI=@GSSI;Delete from DTG_Member where DTG_ID=@GSSI ");
            try
            {
                SQLHelper.ExecuteNonQuery(CommandType.Text, sbSQL.ToString(), new SqlParameter("GSSI", GSSI));
                return true;
            }
            catch (Exception ex)
            {
                log.Info(sbSQL.ToString());
                log.Error(ex);
                return false;
            }
        }

        public bool haveDTing(string GSSI)
        {
            StringBuilder sbSQL = new StringBuilder("SELECT count(0) from DTG_Member where Status=1 and DTG_ID=@GSSI");//0代表失败 1代表成功 99代表未发送
            try
            {
                DataTable dt = SQLHelper.ExecuteRead(CommandType.Text, sbSQL.ToString(), "dd", new SqlParameter("GSSI", GSSI));
               if (dt != null && dt.Rows.Count > 0 && int.Parse(dt.Rows[0][0].ToString()) > 0)
                   return true;
               else return false;
            }
            catch (Exception ex)
            {
                log.Info(sbSQL.ToString());
                log.Error(ex);
                return false;
            }
        }

        public int getAllDTGroupCount()
        {
            StringBuilder sbSQL = new StringBuilder();
            sbSQL.Append("select  count(0) from [DTGroup_info]  ");
            return int.Parse(SQLHelper.ExecuteScalar(CommandType.Text, sbSQL.ToString()).ToString());
        }

        public DataTable GetAllDTGroup(string sort, int startRowIndex, int maximumRows)
        {
            if (sort == "") { sort = "id asc"; }
            StringBuilder sbSQL = new StringBuilder();
            sbSQL.Append("select  *  from [DTGroup_info]   order by " + sort);
            return SQLHelper.ExecuteRead(CommandType.Text, sbSQL.ToString(), startRowIndex, maximumRows, "DTGroup_info");
        }

        public DataTable GetAllDTGroup()
        {
            StringBuilder sbSQL = new StringBuilder("SELECT * FROM [DTGroup_info]");
            return SQLHelper.ExecuteRead(CommandType.Text, sbSQL.ToString(), "dfa");
        }



        public bool FindDTGroupISSIForAdd(string ISSI)
        {
            bool isReturn = false;
            string strSQL = "select count(0) from DTGroup_info where GSSI = @GSSI";
            DataTable dt = SQLHelper.ExecuteRead(CommandType.Text, strSQL, "dsdsf", new SqlParameter("GSSI", ISSI));
            try {
                if (int.Parse(dt.Rows[0][0].ToString()) > 0)
                {
                    isReturn = true;
                }
            }
            catch (Exception ex) { }
            return isReturn;
        }


        public bool FindDTGroupNameForAdd(string Name)
        {
            bool isReturn = false;
            string strSQL = "select count(0) from DTGroup_info where Group_name = @Name";
            DataTable dt = SQLHelper.ExecuteRead(CommandType.Text, strSQL, "dsdsf", new SqlParameter("Name", Name));
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
    }
}
