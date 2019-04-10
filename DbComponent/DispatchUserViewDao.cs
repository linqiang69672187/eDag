using System.Data;
using System.Data.SqlClient;
using System.Text;

namespace DbComponent
{
    public class DispatchUserViewDao : DbComponent.IDAO.IDispatchUserViewDao
    {

        #region IDispatchUserViewDao 成员

        public MyModel.Model_DispatchUser_View GetDispatchUserByISSI(string issi)
        {
            StringBuilder sbSQL = new StringBuilder();
            sbSQL.Append(" select [ID],[ISSI],[IPAddress],[Usename],[loginintime],[Login_ID],[Entity_ID] ");
            sbSQL.Append(" from [DispatchUser_View] where [ISSI]=@issi ");
            DataTable dt = SQLHelper.ExecuteRead(System.Data.CommandType.Text, sbSQL.ToString(), "DispatchUserView", new SqlParameter("issi", issi));
            MyModel.Model_DispatchUser_View newModel = new MyModel.Model_DispatchUser_View();
            foreach (DataRow dr in dt.Rows)
            {
                newModel.ID = int.Parse(dr["ID"].ToString());
                newModel.ISSI = dr["ISSI"].ToString();
                newModel.IPAddress = dr["IPAddress"].ToString();
                newModel.Usename = dr["Usename"].ToString();
                newModel.loginintime = dr["loginintime"].ToString();
                newModel.Login_ID = dr["Login_ID"].ToString();
                newModel.Entity_ID = dr["Entity_ID"].ToString();
            }
            return newModel;
        }

    

        public MyModel.Model_DispatchUser_View GetDispatchUserByID(int ID)
        {
            StringBuilder sbSQL = new StringBuilder();
            sbSQL.Append(" select [ID],[ISSI],[IPAddress],[Usename],[loginintime],[Login_ID],[Entity_ID] ");
            sbSQL.Append(" from [DispatchUser_View] where [ID]=@ID ");
            DataTable dt = SQLHelper.ExecuteRead(System.Data.CommandType.Text, sbSQL.ToString(), "DispatchUserView", new SqlParameter("ID", ID));
            MyModel.Model_DispatchUser_View newModel = new MyModel.Model_DispatchUser_View();
            foreach (DataRow dr in dt.Rows)
            {
                newModel.ID = int.Parse(dr["ID"].ToString());
                newModel.ISSI = dr["ISSI"].ToString();
                newModel.IPAddress = dr["IPAddress"].ToString();
                newModel.Usename = dr["Usename"].ToString();
                newModel.loginintime = dr["loginintime"].ToString();
                newModel.Login_ID = dr["Login_ID"].ToString();
                newModel.Entity_ID = dr["Entity_ID"].ToString();
            }
            return newModel;
        }

        #endregion
    }
}
