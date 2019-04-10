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
    public class StockadeDao : IStockadeDao
    {
        private static readonly log4net.ILog log = log4net.LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);
        #region IStockadeDao 成员

        public bool AddStockade(Model_Stockade Stockade)
        {
            StringBuilder sbSql = new StringBuilder();
            StringBuilder sbStr1 = new StringBuilder();
            StringBuilder sbStr2 = new StringBuilder();
            sbSql.Append("insert into Stockade (");
            if (Stockade.LoginName != null)
            {
                sbStr1.Append(" LoginName, ");
                sbStr2.Append("'" + Stockade.LoginName + "',");
            }
            if (Stockade.PointArray != null)
            {
                sbStr1.Append(" PointArray, ");
                sbStr2.Append("'" + Stockade.PointArray + "',");
            }
            if (Stockade.Title != null)
            {
                sbStr1.Append(" Title, ");
                sbStr2.Append("'" + Stockade.Title + "',");
            }
            if (Stockade.Type != null)
            {
                sbStr1.Append(" Type, ");
                sbStr2.Append("'" + Stockade.Type + "',");
            }
            if (Stockade.DivStyle != null)
            {
                sbStr1.Append(" DivStyle, ");
                sbStr2.Append("'" + Stockade.DivStyle + "',");
            }
            //string divID = DateTime.Now.Year.ToString() + DateTime.Now.Month.ToString() + DateTime.Now.Day.ToString() + DateTime.Now.Hour.ToString() + DateTime.Now.Minute.ToString() + DateTime.Now.Second.ToString();

            sbStr1.Append(" DivID, ");
            sbStr2.Append("'" + Stockade.DivID + "',");

            sbStr1.Append(" CreateTime ");
            sbStr2.Append("'" + DateTime.Now.ToString() + "' ");

            sbSql.Append(sbStr1.ToString());
            sbSql.Append(") values (");
            sbSql.Append(sbStr2.ToString());
            sbSql.Append(")");
            try
            {
                int i = SQLHelper.ExecuteNonQuery(CommandType.Text, sbSql.ToString());
                if (i > 0 && Stockade.UID != null)
                {
                    StringBuilder sbS = new StringBuilder();
                    foreach (int User_ID in Stockade.UID)
                    {
                        sbS.Append("insert into UserInStockade (StockadeID,User_ID) values ('" + Stockade.DivID + "','" + User_ID + "');");
                    }
                    try
                    {
                        SQLHelper.ExecuteNonQuery(CommandType.Text, sbS.ToString());
                    }
                    catch (Exception ex)
                    {
                        DeleteStockadeByDivID(Stockade.DivID);
                        log.Info(sbS.ToString());
                        log.Error(ex);
                        return false;
                    }
                }

                return true;
            }
            catch (Exception ex)
            {
                log.Info(sbSql.ToString());
                log.Error(ex);
                return false;
            }

        }
        public bool DeleteStockade(int ID)
        {
            StringBuilder sbSql = new StringBuilder(" Delete from Stockade where ID=@ID ");
            try
            {
                SQLHelper.ExecuteNonQuery(System.Data.CommandType.Text, sbSql.ToString(), new SqlParameter("ID", ID));
                return true;
            }
            catch (Exception ex)
            {
                log.Info(sbSql.ToString());
                log.Error(ex);
                return false;
            }
        }
        public bool DeleteStockadeByDivID(string DivID)
        {
            StringBuilder sbSql = new StringBuilder(" Delete from Stockade where DivID=@DivID ;");
            sbSql.Append(" Delete from UserInStockade where StockadeID=@DivID ;");
            try
            {
                SQLHelper.ExecuteNonQuery(System.Data.CommandType.Text, sbSql.ToString(), new SqlParameter("DivID", DivID));
                return true;
            }
            catch (Exception ex)
            {
                log.Info(sbSql.ToString());
                log.Error(ex);
                return false;
            }
        }
        public IList<Model_Stockade> GetStockadeListByLoginName(string LoginName)
        {
            string strSQL = "select PointArray,DivID,DivStyle,Type,isShow,LoginName,Title,CreateTime from Stockade  where isShow=1 and LoginName=@LoginName";
            DataTable dt = SQLHelper.ExecuteRead(CommandType.Text, strSQL, "adfd", new SqlParameter("LoginName", LoginName));
            IList<Model_Stockade> returnList = new List<Model_Stockade>();
            foreach (DataRow dr in dt.Rows)
            {
                Model_Stockade ms = new Model_Stockade();
                ms.PointArray = dr["PointArray"].ToString();
                if (dr["Type"] != null)
                {
                    ms.Type = int.Parse(dr["Type"].ToString());
                }
                if (dr["CreateTime"] != null)
                {
                    ms.CreateTime = DateTime.Parse(dr["CreateTime"].ToString());
                }
                if (dr["LoginName"] != null)
                {
                    ms.LoginName = dr["LoginName"].ToString();
                }
                if (dr["Title"] != null)
                {
                    ms.Title = dr["Title"].ToString();
                }
                ms.DivID = dr["DivID"].ToString();
                ms.DivStyle = dr["DivStyle"].ToString();
                returnList.Add(ms);
            }
            return returnList;
        }
        public int GetTypeByDivID(string DivID)
        {
            string strSQL = "select top 1 Type from Stockade where DivID=@DivID";
            DataTable dt = SQLHelper.ExecuteRead(CommandType.Text, strSQL, "aaa", new SqlParameter("DivID", DivID));
            int res = 0;
            foreach (DataRow dr in dt.Rows)
            {
                res = (int)dr["Type"];
            }
            return res;
        }
        public int GetLastSatusByDivID(string DivID)
        {
            string strSQL = "select * from UserInStockade where StockadeID=@StockadeID and LastStatus='11'";
            DataTable dt = SQLHelper.ExecuteRead(CommandType.Text, strSQL, "aaa", new SqlParameter("StockadeID", DivID));
            if (dt.Rows.Count > 0)
                return 1;
            else
                return 0;
        }
        public bool UpdateUsers(string DivID, string[] users)
        {
            StringBuilder sb = new StringBuilder(" begin try  begin   tran ");
            sb.Append(" delete from UserInStockade where StockadeID=@DivID; ");
            foreach (string uid in users)
            {
                sb.Append(" insert into UserInStockade (StockadeID,User_ID) values ('" + DivID + "','" + uid + "'); ");
            }
            sb.Append(" commit  tran end   try begin catch  rollback end catch ");

            try
            {

                SQLHelper.ExecuteNonQuery(CommandType.Text, sb.ToString(), new SqlParameter("DivID", DivID));
                return true;
            }
            catch (Exception ex)
            {
                log.Info(sb.ToString());
                log.Error(ex);
                return false;
            }

        }
        public string GetMyStockUserName2String(string DivID)
        {
            string strSQL = "select Nam from UserInStockade left outer join User_info on UserInStockade.User_ID=User_info.id where UserInStockade.StockadeID=@DivID ";
            DataTable dt = SQLHelper.ExecuteRead(CommandType.Text, strSQL, "adfadfda", new SqlParameter("DivID", DivID));
            StringBuilder strResult = new StringBuilder();
            int i = 0;
            foreach (DataRow dr in dt.Rows)
            {
                if (i != dt.Rows.Count - 1)
                {
                    strResult.Append(dr["Nam"].ToString() + ";");
                }
                else
                {
                    strResult.Append(dr["Nam"].ToString());
                }
                i++;
            }
            return strResult.ToString();
        }
        public DataTable GetAllStockade(string username, string textseach, int id, string stringid, string sort, int startRowIndex, int maximumRows)
        {
            if (stringid == null)
            {
                string sqlcondition = "";
                if (System.Configuration.ConfigurationManager.AppSettings["GISTYPE"].ToString() == "PGIS")
                {
                    //去除电子栅栏类型不等于3
                    //sqlcondition += " and ([Type] != '0' And [Type] != '3') ";
                    sqlcondition += " and ([Type] != '0') ";
                }
                if (username != null) { sqlcondition += " and [LoginName] = '" + username.Trim() + "'"; }
                if (textseach != null) { sqlcondition += " and [Title] like '%" + stringfilter.Filter(textseach.Trim()) + "%'"; }
                if (sort == "") { sort = "id asc"; }
                StringBuilder sbSQL = new StringBuilder();
                sbSQL.Append("select  [ID],[LoginName],[Type] ,[Title],[DivID],isShow,[PointArray]  from [Stockade] where len([LoginName]) > 0 " + sqlcondition + " order by " + sort);
                return SQLHelper.ExecuteRead(CommandType.Text, sbSQL.ToString(), startRowIndex, maximumRows, "Stockade", new SqlParameter("id", id));

            }
            else
            {
                return SQLHelper.ExecuteRead(CommandType.Text, "select * from [Stockade] where len([LoginName]) > 0 and id =@id ", startRowIndex, maximumRows, "Stockade", new SqlParameter("id", stringid));
            }
        }
        public int getStockadeCount(string username, string textseach, int id, string stringid)
        {
            if (stringid == null)
            {
                string sqlcondition = "";
                if (System.Configuration.ConfigurationManager.AppSettings["GISTYPE"].ToString() == "PGIS")
                {
                    //去除电子栅栏类型不等于3
                    //sqlcondition += " and ([Type] != '0' And [Type] != '3') ";
                    sqlcondition += " and ([Type] != '0') ";
                }

                if (username != null) { sqlcondition += " and [LoginName] = '" + username.Trim() + "'"; }
                if (textseach != null) { sqlcondition += " and [Title] like '%" + stringfilter.Filter(textseach.Trim()) + "%'"; }

                StringBuilder sbSQL = new StringBuilder();
                sbSQL.Append("select  count(*) from [Stockade] where len([LoginName]) > 0 " + sqlcondition);
                return int.Parse(SQLHelper.ExecuteScalar(CommandType.Text, sbSQL.ToString(), new SqlParameter("id", id)).ToString());

            }
            else
            {
                return int.Parse(SQLHelper.ExecuteScalar(CommandType.Text, "select count(0) from [Stockade] where len([LoginName]) > 0 and id =@id ", new SqlParameter("id", stringid)).ToString());
            }
        }
        public string GetMyStockUsers(string DivID)
        {
            string strSQL = "select User_ID,Nam,issi from UserInStockade left outer join User_info on UserInStockade.User_ID=User_info.id where UserInStockade.StockadeID=@DivID ";
            DataTable dt = SQLHelper.ExecuteRead(CommandType.Text, strSQL, "adfadfda", new SqlParameter("DivID", DivID));
            StringBuilder strResult = new StringBuilder();
            int i = 0;
            foreach (DataRow dr in dt.Rows)
            {
                if (i != dt.Rows.Count - 1)
                {
                    strResult.Append(dr["Nam"].ToString() + "," + dr["User_ID"].ToString() + "," + dr["issi"].ToString() + ";");
                }
                else
                {
                    strResult.Append(dr["Nam"].ToString() + "," + dr["User_ID"].ToString() + "," + dr["issi"].ToString());
                }
                i++;
            }
            return strResult.ToString();
        }
        public string GetMyStockUserName(string DivID)
        {
            string strSQL = "select Nam from UserInStockade left outer join User_info on UserInStockade.User_ID=User_info.id where UserInStockade.StockadeID=@DivID ";
            DataTable dt = SQLHelper.ExecuteRead(CommandType.Text, strSQL, "adfadfda", new SqlParameter("DivID", DivID));
            StringBuilder strResult = new StringBuilder();
            int i = 0;
            foreach (DataRow dr in dt.Rows)
            {
                if (i != dt.Rows.Count - 1)
                {
                    strResult.Append(dr["Nam"].ToString() + ";");
                }
                else
                {
                    strResult.Append(dr["Nam"].ToString());
                }
                i++;
            }
            return strResult.ToString();
        }
        public bool HideStockade(string DivID)
        {
            string strSQL = "update Stockade set isShow=0 where DivID=@DivID";
            try
            {
                SQLHelper.ExecuteNonQuery(CommandType.Text, strSQL, new SqlParameter("DivID", DivID));
                return true;
            }
            catch (Exception ex)
            {
                log.Info(strSQL);
                log.Error(ex);
                return false;
            }
        }
        public bool ShowStockade(string DivID)
        {
            string strSQL = "update Stockade set isShow=1 where DivID=@DivID";
            try
            {
                SQLHelper.ExecuteNonQuery(CommandType.Text, strSQL, new SqlParameter("DivID", DivID));
                return true;
            }
            catch (Exception ex)
            {
                log.Info(strSQL);
                log.Error(ex);
                return false;
            }
        }

        public Model_Stockade GetStockadeByDivID(string DivID)
        {
            string strSQL = "select top 1 ID,LoginName,PointArray,Title,CreateTime,isShow,DivID,DivStyle,Type from Stockade where DivID=@DivID";
            DataTable dt = SQLHelper.ExecuteRead(CommandType.Text, strSQL, "adfd", new SqlParameter("DivID", DivID));
            Model_Stockade ms = new Model_Stockade();
            foreach (DataRow dr in dt.Rows)
            {
                if (dr["ID"] != null)
                {
                    ms.ID = int.Parse(dr["ID"].ToString());
                }
                if (dr["isShow"] != null)
                {
                    ms.isShow = bool.Parse(dr["isShow"].ToString());
                }
                ms.LoginName = dr["LoginName"].ToString();
                ms.PointArray = dr["PointArray"].ToString();
                ms.Title = dr["Title"].ToString();
                if (dr["Type"] != null)
                {
                    ms.Type = int.Parse(dr["Type"].ToString());
                }
                if (dr["CreateTime"] != null)
                {
                    ms.CreateTime = DateTime.Parse(dr["CreateTime"].ToString());
                }
                ms.DivID = dr["DivID"].ToString();
                ms.DivStyle = dr["DivStyle"].ToString();
            }
            return ms;
        }

        public bool IsExist(string StockadoName)
        {
            bool isReturn = false;
            string strSQL = "select count(0) from Stockade where Title=@Title";
            DataTable dt = SQLHelper.ExecuteRead(CommandType.Text, strSQL, "adfdasdf", new SqlParameter("Title", StockadoName));
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
