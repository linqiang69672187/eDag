#region
/*
 * 杨德军
 * **/
#endregion
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
    public class IsInStockadeViewDao : IIsInStockadeViewDao
    {
        private static readonly log4net.ILog log = log4net.LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);
        #region IIsInStockadeViewDao 成员

        public IList<Model_IsInStockade_View> GetListByLoginName(string LoginName)
        {
            StringBuilder                   sbSql   = new StringBuilder();
            sbSql.Append(" Select PointArray,Latitude,Longitude,User_ID,Nam,ISSI,DivStyle,DivID,Type,LastStatus,UserInStockID,Title,CreateTime from IsInStockade_View where isShow=1 and LoginName=@LoginName");

            DataTable                       dt      = SQLHelper.ExecuteRead(System.Data.CommandType.Text, sbSql.ToString(), "isinsv", new SqlParameter("LoginName", LoginName));

            IList<Model_IsInStockade_View>  myList  = new List<Model_IsInStockade_View>();
            foreach (DataRow dr in dt.Rows)
            {
                Model_IsInStockade_View     md      = new Model_IsInStockade_View();
                md.Latitude                         = dr["Latitude"].ToString();
                md.LoginName                        = LoginName;
                md.Longitude                        = dr["Longitude"].ToString();
                md.Nam                              = dr["Nam"].ToString();
                md.PointArray                       = dr["PointArray"].ToString();
                md.User_ID                          = dr["User_ID"].ToString();
                md.ISSI                             = dr["ISSI"].ToString();
                md.DivStyle                         = dr["DivStyle"].ToString();
                md.DivID                            = dr["DivID"].ToString();
                md.Type                             = dr["Type"].ToString();
                md.UserInStockID                    = dr["UserInStockID"].ToString();
                md.Title                            = dr["Title"].ToString();
                md.CreateTime                       = dr["CreateTime"].ToString();
                md.LastStatus                       = dr["LastStatus"].ToString();
                myList.Add(md);
            }
            return myList;
        }
        public bool UpdateLastStatus(int id, string newStatus)
        {
            bool isreturn                           = false;
            string strSql = "update UserInStockade set LastStatus = '" + newStatus + "' where ID=@ID";
            try
            {
                SQLHelper.ExecuteNonQuery(CommandType.Text, strSql, new SqlParameter("@ID", id));
                isreturn                            = true;
            }
            catch (Exception ex)
            {
                log.Info(strSql);
                log.Error(ex);
            }

            return isreturn;
        }
        public int GetUserCountByUserID(int userID)
        {
            string      strSQL                      = "SELECT COUNT(*) FROM UserInStockade WHERE User_ID = @User_ID ";
            DataTable   dt                          = SQLHelper.ExecuteRead(CommandType.Text, strSQL, "tbname", new SqlParameter("User_ID", userID.ToString()));
            return int.Parse(dt.Rows[0][0].ToString());
        }
        #endregion
    }
}
