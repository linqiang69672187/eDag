using DbComponent.IDAO;
using MyModel;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Reflection;
using System.Text;

namespace DbComponent
{
    public class UserTypeDao : IUserTypeDao
    {
        private static readonly log4net.ILog log = log4net.LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType); 
        #region IUserTypeDao 成员

        public bool AddUserType(MyModel.Model_UserType model)
        {
            StringBuilder sbSql = new StringBuilder();
            StringBuilder sbStr1 = new StringBuilder();
            StringBuilder sbStr2 = new StringBuilder();
            sbSql.Append("insert into UserType (");
            if (model.TypeName != null)
            {
                sbStr1.Append("[TypeName],");
                sbStr2.Append("'" + model.TypeName + "',");
            }
            if (model.TypeIcons != null)
            {
                sbStr1.Append("[TypeIcons],");
                sbStr2.Append("'" + model.TypeIcons + "',");
            }
            if (model.NormalIcons != null)
            {
                sbStr1.Append("[NormalIcons],");
                sbStr2.Append("'" + model.NormalIcons + "',");
            }
            if (model.UrgencyIcons != null)
            {
                sbStr1.Append("[UrgencyIcons],");
                sbStr2.Append("'" + model.UrgencyIcons + "',");
            }
            if (model.UnNormalIcons != null)
            {
                sbStr1.Append("[UnNormalIcons],");
                sbStr2.Append("'" + model.UnNormalIcons + "',");
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

        public bool UpdateUserType(MyModel.Model_UserType newModel)
        {
            StringBuilder sbSQL = new StringBuilder();
            sbSQL.Append("update UserType set ");
            bool flag = false;
            if (newModel.TypeName != null)
            {
                sbSQL.Append(" [TypeName] = '" + newModel.TypeName + "',");
                flag = true;
            }
            if (newModel.TypeIcons != null)
            {
                sbSQL.Append(" [TypeIcons] = '" + newModel.TypeIcons + "',");
                flag = true;
            }
            if (newModel.NormalIcons != null)
            {
                sbSQL.Append(" [NormalIcons] = '" + newModel.NormalIcons + "',");
                flag = true;
            }
            if (newModel.UnNormalIcons != null)
            {
                sbSQL.Append(" [UnNormalIcons] = '" + newModel.UnNormalIcons + "',");
                flag = true;
            }
            if (newModel.UrgencyIcons != null)
            {
                sbSQL.Append(" [UrgencyIcons] = '" + newModel.UrgencyIcons + "',");
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
                i = SQLHelper.ExecuteNonQuery(CommandType.Text, strSql, new SqlParameter("ID", newModel.ID));
                if (i > 0)
                    return true;
                else return false;
            }
            catch (Exception ex)
            {
                log.Info(strSql.ToString());
                log.Error(ex);
                return false;
            }
        }

        public bool DeleteUserType(int ID)
        {
            string strSQL = " delete from UserType where ID=@ID ";
            try
            {
                SQLHelper.ExecuteNonQuery(CommandType.Text, strSQL, new SqlParameter("ID", ID));
                return true;
            }
            catch (Exception ex)
            {
                log.Info(strSQL);
                log.Error(ex);
                return false;
            }
        }

        public int getAllUserTypeCount()
        {
            StringBuilder sbSQL = new StringBuilder();
            sbSQL.Append("select  count(*) from [UserType]  ");
            return int.Parse(SQLHelper.ExecuteScalar(CommandType.Text, sbSQL.ToString()).ToString());
        }

        public DataTable GetAllUserType(string sort, int startRowIndex, int maximumRows)
        {
            if (sort == "") { sort = "A.ID asc"; }
            StringBuilder sbSQL = new StringBuilder();
            sbSQL.Append("select A.ID,A.TypeName,A.TypeIcons,A.NormalIcons,A.UrgencyIcons,A.UnNormalIcons,"+
           " b.name,b.type " +
           " from UserType as A left join Images as B on A.TypeName+'_3'=B.name order by " + sort);
            return SQLHelper.ExecuteRead(CommandType.Text, sbSQL.ToString(), startRowIndex, maximumRows, "UserType");
        }

        public DataTable GetAllUserType()
        {
            StringBuilder sbSQL = new StringBuilder();
            sbSQL.Append("select  [ID],[TypeName],[TypeIcons],[NormalIcons],[UrgencyIcons],[UnNormalIcons]  from [UserType]  ");
            return SQLHelper.ExecuteRead(CommandType.Text, sbSQL.ToString(), "UserType");
        }
        public IList<Model_UserType> GetAllForList()
        {
            IList<Model_UserType> list = new List<Model_UserType>();
            StringBuilder sbSQL = new StringBuilder();
            sbSQL.Append("select  [ID],[TypeName],[TypeIcons],[NormalIcons],[UrgencyIcons],[UnNormalIcons]  from [UserType]  ");
            DataTable dt= SQLHelper.ExecuteRead(CommandType.Text, sbSQL.ToString(), "UserType");
            if (dt != null)
            {
                foreach (DataRow dr in dt.Rows)
                {
                    Model_UserType ut = new Model_UserType { ID = int.Parse(dr["ID"].ToString()), TypeName = dr["TypeName"].ToString(), TypeIcons = dr["TypeIcons"].ToString(), NormalIcons = dr["NormalIcons"].ToString(), UrgencyIcons = dr["UrgencyIcons"].ToString(), UnNormalIcons = dr["UnNormalIcons"].ToString() };
                    list.Add(ut);
                }
            }
            return list;
        }
        public MyModel.Model_UserType GetUserTypeByID(int ID)
        {
            Model_UserType model = new Model_UserType();

            StringBuilder sbSQL = new StringBuilder();
            sbSQL.Append("select top 1 [ID] ,[TypeName],[TypeIcons],[NormalIcons],[UrgencyIcons],[UnNormalIcons] FROM [UserType] where [ID]=@ID ");
            DataTable dt = SQLHelper.ExecuteRead(CommandType.Text, sbSQL.ToString(), "usetv",new SqlParameter("ID", ID));
            if (dt != null && dt.Rows.Count > 0)
            {
                foreach (DataRow dr in dt.Rows)
                {
                    model.ID = int.Parse(dr["ID"].ToString());
                    model.TypeName = dr["TypeName"].ToString();
                    model.TypeIcons = dr["TypeIcons"].ToString();
                    model.NormalIcons = dr["NormalIcons"].ToString();
                    model.UrgencyIcons = dr["UrgencyIcons"].ToString();
                    model.UnNormalIcons = dr["UnNormalIcons"].ToString();
                }
            }
            return model;
        }

     

        public bool FindUserTypeNameIsExist(string UserTypeName)
        {
            bool isReturn = false;
            string strSql = "select count(0) from UserType where [TypeName]=@TypeName";
            DataTable dt = SQLHelper.ExecuteRead(CommandType.Text, strSql, "totals", new SqlParameter("TypeName", UserTypeName));
            try {
                if (int.Parse(dt.Rows[0][0].ToString()) > 0)
                {
                    isReturn = true;
                }
            }
            catch (Exception ex)
            {
                isReturn = false;
            }
            return isReturn;

        }
        public bool FindUserTypeNameIsExistForUpdate(int ID, string UserTypeName)
        {
            bool isReturn = false;
            string strSql = "select count(0) from UserType where [TypeName]=@TypeName and ID!=@ID";
            DataTable dt = SQLHelper.ExecuteRead(CommandType.Text, strSql, "totals", new SqlParameter("TypeName", UserTypeName),new SqlParameter("ID",ID));
            try
            {
                if (int.Parse(dt.Rows[0][0].ToString()) > 0)
                {
                    isReturn = true;
                }
            }
            catch (Exception ex)
            {
                isReturn = false;
            }
            return isReturn;
        }

        public bool IsUsed(int ID)
        {
            bool isReturn = false;
            string strSQL = "select count(0) from User_info,UserType  where [type]=typename and UserType.ID=@ID";
            DataTable dt=SQLHelper.ExecuteRead(CommandType.Text,strSQL,"dsdsd",new SqlParameter("ID",ID));
            try
            {
                if (int.Parse(dt.Rows[0][0].ToString()) > 0)
                {
                    isReturn = true;
                }
            }
            catch (Exception ex) 
            {
            }
            return isReturn;
        }
        public bool PicIsUsed(string PicName)
        {
            bool isReturn = false;
            DataTable dt = SQLHelper.ExecuteRead(CommandType.Text, "SELECT COUNT(0) FROM UserType WHERE TypeIcons=@TypeIcons", "adfsaaedac", new SqlParameter("TypeIcons", PicName));
            try
            {
                if (int.Parse(dt.Rows[0][0].ToString()) > 0)
                {
                    isReturn = true;
                }
            }
            catch (Exception ex)
            {
            }
            return isReturn;
        }
        #endregion
    }
}
