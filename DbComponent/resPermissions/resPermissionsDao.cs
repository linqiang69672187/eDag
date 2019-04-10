using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.SqlClient;
using System.Data;
namespace DbComponent.resPermissions
{
    public class resPermissionsDao
    {
        #region 更新登录用户的资源权限
        public void saveOrUpdateLoginuserResourcePermissions(String selectedLoginuserId, string accessUnitsAndUsertype)
        {
            SQLHelper.ExecuteNonQuery(CommandType.Text, "UPDATE [login] SET [accessUnitsAndUsertype] =@accessUnitsAndUsertype where [id] =@selectedLoginuserId", new SqlParameter("selectedLoginuserId", selectedLoginuserId), new SqlParameter("accessUnitsAndUsertype", accessUnitsAndUsertype));
        }
        #endregion
        public DataTable getLoginuserResourcePermissionsStringByUserId(String userId)
        {

            String sql = "select * from login where id='" + userId + "'";
            return SQLHelper.ExecuteRead(CommandType.Text, sql, "ResourcePermissions");
        }
        public DataTable getAllEntity(String EntityId)
        {
            DataTable AllEntity = new DataTable();
            try
            {
                String sqlAllEntity = "WITH lmenu(name,id) as (SELECT name,id  FROM [Entity] WHERE id=@id UNION ALL SELECT A.NAME,A.id FROM [Entity] A,lmenu b    where a.[ParentID] = b.id) select id,Name,ParentID,cast(Depth as int) as Depth from Entity where len([Name]) > 0 and Depth>=-1 and id in (select id from lmenu) order by Depth asc";
            AllEntity= SQLHelper.ExecuteRead(CommandType.Text, sqlAllEntity, "sqlAllEntity", new SqlParameter("id", EntityId));
            }
            catch (Exception ex)
            {

            }
            return AllEntity;
        }
        public DataTable getEntitySubUsertype(String EntityId)
        {
            DataTable EntitySubUsertype = new DataTable();
            try
            {
                String sqlEntitySubUsertype = "WITH lmenu(name,id) as (SELECT name,id  FROM [Entity] WHERE id=@id UNION ALL SELECT A.NAME,A.id FROM [Entity] A,lmenu b    where a.[ParentID] = b.id) select a.*,b.TypeName from entitySubUsertype a left join usertype b on(a.usertypeId=b.ID) where id in (select id from lmenu)";
                EntitySubUsertype = SQLHelper.ExecuteRead(CommandType.Text, sqlEntitySubUsertype, "sqlEntitySubUsertype", new SqlParameter("id", EntityId));
            }
            catch( Exception ex){
                
            }
            return EntitySubUsertype;
        }
        public DataTable getAllUsertype(String EntityId)
        {
            DataTable AllUsertype = new DataTable();
             try
            {
            String sqlAllUsertype = "select * from usertype";
            AllUsertype= SQLHelper.ExecuteRead(CommandType.Text, sqlAllUsertype, "sqlAllUsertype");
            }
             catch (Exception ex)
             {

             }
             return AllUsertype;
        }
       
        public string getAccessUnitsByUsername(string username) 
        {
            string accessUnitsStr = "";
            try
            {
                var accessUnits = SQLHelper.ExecuteScalar(string.Format("select accessUnitsAndUsertype from login where usename='{0}'", username));
                accessUnitsStr = accessUnits.ToString();
            }
            catch(Exception ex)
            {

            }
            return accessUnitsStr;
        }

        public string getUnitByUsername(string username)
        {
            string unitsStr = "";
            try
            {
                var accessUnits = SQLHelper.ExecuteScalar(string.Format("select Entity_ID from login where usename='{0}'", username));
                unitsStr = accessUnits.ToString();
            }
            catch (Exception ex)
            {

            }
            return unitsStr;
        }

        public IList<object> getAllAccessUnitIdByIds(string ids)
        {
            IList<object> allIdList = new List<object>();
            try
            {
                SQLHelper.ExecuteDataReader(ref allIdList, "With lmenu(id) as (SELECT id  FROM [Entity] WHERE id in (" + ids + ") UNION ALL SELECT A.id FROM [Entity] A,lmenu b where a.[ParentID] = b.id) select * from lmenu");
            }
            catch (Exception ex)
            { 
            
            }
            return allIdList;
        }
        
    }
}