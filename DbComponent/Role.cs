using System;
using System.Data;
using System.Data.SqlClient;
using System.Text;

namespace DbComponent
{
    public class Role
    {
        private string connstring = System.Configuration.ConfigurationManager.AppSettings["m_connectionString"];

        #region 分页排序角色信息
        public DataTable AllRoleInfo(string sort, int startRowIndex, int maximumRows)
        {
            if (sort == "") { sort = "id asc"; }
            return SQLHelper.ExecuteRead(CommandType.Text, "select id,RoleName,EnRoleName,Status,CreateDate from Role order by " + sort, startRowIndex, maximumRows, "ROLE");
        }
        #endregion

        #region 取得角色数量信息
        public int getAllRoleCount()
        {
           
            return int.Parse(SQLHelper.ExecuteScalar(CommandType.Text,"select COUNT(1) from Role").ToString());
        }
        #endregion

        #region 获得权限项列表
        public static DataTable GetPowerFunction()
        {
            return (SQLHelper.ExecuteRead(CommandType.Text, "select PowerKey,PowerName,EnPowerName from PowerFunction where Status=1 order by id asc", "PowerFunction"));
        }
        #endregion
        #region 根据角色ID获得权限
        public static DataTable GetPowerByRoleId(int id)
        {
            return (SQLHelper.ExecuteRead(CommandType.Text, "select id,RoleName,[POWER],EnRoleName from Role WHERE id=@id", "PowerFunction", new SqlParameter("id", id)));
        }
        #endregion

        #region 根据角色ID获得权限
        public static MyModel.Model_Role GetRoleModelByRoleId(int id)
        {
            DataTable dt=SQLHelper.ExecuteRead(CommandType.Text, "select * from Role WHERE id=@id", "PowerFunction", new SqlParameter("id", id));
            MyModel.Model_Role role = new MyModel.Model_Role();
            if (dt.Rows.Count > 0)
            {
                role.id = Int32.Parse(dt.Rows[0]["id"].ToString());
                role.RoleName = dt.Rows[0]["RoleName"].ToString();
                role.Power = dt.Rows[0]["Power"].ToString();
                role.Status = Int32.Parse(dt.Rows[0]["Status"].ToString());
                role.CreateDate = DateTime.Parse(dt.Rows[0]["CreateDate"].ToString());
                role.EnRoleName = dt.Rows[0]["EnRoleName"].ToString();
            }
            return role;
        }
        #endregion

        #region 根据角色ID修改角色权限
        public static int UpdatePowerByRoleId(int id,string power)
        {
            return (SQLHelper.ExecuteNonQuery(CommandType.Text, "update Role set Power=@power where id=@id", new SqlParameter("power", power), new SqlParameter("id", id)));
        }
        #endregion

    }
}
