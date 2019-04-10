using System.Data;
using System.Data.SqlClient;
using System.Text;

namespace DbComponent
{
    public class UserISSIViewDao:DbComponent.IDAO.IUserISSIViewDao
    {
        public MyModel.Model_UserISSIView GetUserISSIViewByID(string ID)
        {
            MyModel.Model_UserISSIView model = new MyModel.Model_UserISSIView();
            StringBuilder sbSQL = new StringBuilder("select [id],[Nam],[UserISSI],[Longitude],[Latitude] from UserISSI_View where id=@id");
            DataTable dt = SQLHelper.ExecuteRead(System.Data.CommandType.Text, sbSQL.ToString(), "uiv", new SqlParameter("id", ID));
            foreach (DataRow dr in dt.Rows)
            {
                model.id = dr["id"].ToString();
                if (dr["Nam"] != null)
                {
                    model.Nam = dr["Nam"].ToString();
                }
                else
                {
                    model.Nam = "";
                }
                if (dr["UserISSI"] != null)
                {
                    model.UserISSI = dr["UserISSI"].ToString();
                }
                else {
                    model.UserISSI = "";
                }
                if (dr["Longitude"] != null)
                {
                    model.Longitude = dr["Longitude"].ToString();
                }
                else
                {
                    model.Longitude = "";
                }
                if (dr["Latitude"] != null)
                {
                    model.Latitude = dr["Latitude"].ToString();
                }
                else
                {
                    model.Latitude = "";
                }
            }
            return model;
        }

        public MyModel.Model_UserISSIView GetUserISSIViewByISSI(string ISSI)
        {
            MyModel.Model_UserISSIView model = new MyModel.Model_UserISSIView();
            StringBuilder sbSQL = new StringBuilder("select [id],[Nam],[UserISSI],[Longitude],[Latitude],[UserID] from UserISSI_View where UserISSI=@UserISSI and Nam is not NULL");
            DataTable dt = SQLHelper.ExecuteRead(System.Data.CommandType.Text, sbSQL.ToString(), "uiv", new SqlParameter("UserISSI", ISSI));
            foreach (DataRow dr in dt.Rows)
            {
                model.id = dr["id"].ToString();
                if (dr["Nam"] != null)
                {
                    model.Nam = dr["Nam"].ToString();
                }
                else
                {
                    model.Nam = "";
                }
                if (dr["UserISSI"] != null)
                {
                    model.UserISSI = dr["UserISSI"].ToString();
                }
                else
                {
                    model.UserISSI = "";
                }
                if (dr["Longitude"] != null)
                {
                    model.Longitude = dr["Longitude"].ToString();
                }
                else
                {
                    model.Longitude = "";
                }
                if (dr["Latitude"] != null)
                {
                    model.Latitude = dr["Latitude"].ToString();
                }
                else
                {
                    model.Latitude = "";
                }
                if (dr["UserID"] != null)
                {
                    model.UserID = dr["UserID"].ToString();
                }
            }
            return model;
        }
    }
}
