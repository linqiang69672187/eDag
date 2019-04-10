using DbComponent.IDAO;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Reflection;
using System.Text;

namespace DbComponent
{
    public class BSGroupInfoDao : IBSGroupInfoDao
    {
        private static readonly log4net.ILog log = log4net.LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);
        string CTE = "WITH lmenu(name,id) as (SELECT name,id  FROM [Entity] WHERE id=@id UNION ALL SELECT A.NAME,A.id FROM [Entity] A,lmenu b where a.[ParentID] = b.id) ";
        #region IBSGroupInfoDao 成员

        public bool Save(string BSGroupName, string MemberIds, string EntityID, bool Status, string BSISSI)
        {
            StringBuilder sbSQL = new StringBuilder(@"INSERT INTO BSGroup_info (BSGroupName,MemberIds,Entity_ID,Status,BSISSI) Values (@BSGroupName,@MemberIds,@Entity_ID,@Status,@BSISSI) ");
            try {
                SQLHelper.ExecuteNonQuery(CommandType.Text, sbSQL.ToString(), new SqlParameter("BSGroupName", BSGroupName), new SqlParameter("MemberIds", MemberIds), new SqlParameter("Entity_ID", EntityID), new SqlParameter("Status", Status), new SqlParameter("BSISSI", BSISSI));
                return true;
            }
            catch (Exception ex)
            {
                log.Error(ex);
                return false;
            }
        }

        public bool Update(string BSGroupName, string MemberIds, string EntityID, bool Status, int ID)
        {
            StringBuilder sbSQL = new StringBuilder(@" UPDATE BSGroup_info SET BSGroupName = @BSGroupName , MemberIds = @MemberIds, Entity_ID = @Entity_ID  Where ID=@ID ");
            try
            {
                SQLHelper.ExecuteNonQuery(CommandType.Text, sbSQL.ToString(), new SqlParameter("BSGroupName", BSGroupName), new SqlParameter("MemberIds", MemberIds), new SqlParameter("Entity_ID", EntityID),  new SqlParameter("ID", ID));
                log.Info(sbSQL.ToString());
                return true;
            }
            catch (Exception ex) {
                log.Error(ex);
                return false;
            }
        }

        public bool Delete(int ID)
        {
            StringBuilder sbSQL = new StringBuilder(@"DELETE FROM BSGroup_info WHERE ID = @ID");
            try
            {
                SQLHelper.ExecuteNonQuery(System.Data.CommandType.Text, sbSQL.ToString(), new SqlParameter("ID", ID));
                return true;
            }
            catch (Exception ex)
            {
                log.Error(ex);
                return false;
            }
        }

        #region 取得小组数量信息
        public int getallBSGroupcount(int selectcondition, string textseach, int id, string stringid, int gtype)
        {
            if (stringid == null)
            {
                string sqlcondition = "";
                if (selectcondition != 0) { sqlcondition += " and [Entity_ID]='" + selectcondition + "'"; }

                if (textseach != null) { sqlcondition += " and [BSGroupName] like '%" + stringfilter.Filter(textseach.Trim()) + "%'"; }
                return int.Parse(SQLHelper.ExecuteScalar(CommandType.Text, CTE + "select count(*) from BSGroup_info where  [Entity_ID] in (select id from lmenu)" + sqlcondition, new SqlParameter("id", id)).ToString());
            }
            else
            {
                return 1;
            }
        }
        #endregion
        #region 分页排序小组信息
        public DataTable AllBSGroupInfo(int selectcondition, string textseach, int id, string stringid, int gtype, string sort, int startRowIndex, int maximumRows)
        {
            if (stringid == null)
            {
                string sqlcondition = "";
                if (selectcondition != 0) { sqlcondition += " and [Entity_ID]='" + selectcondition + "'"; }

                if (textseach != null) { sqlcondition += " and [BSGroupName] like '%" + stringfilter.Filter(textseach.Trim()) + "%'"; }
                if (sort == "") { sort = "id asc"; }
                return SQLHelper.ExecuteRead(CommandType.Text, CTE + " select * from [BSGroup_info] where 1=1 " + sqlcondition + " and [Entity_ID] in (select id from lmenu) order by " + sort, startRowIndex, maximumRows, "Entity", new SqlParameter("id", id));
            }
            else
            {
                return SQLHelper.ExecuteRead(CommandType.Text, "select * from [BSGroup_info] where id=@id", startRowIndex, maximumRows, "Entity", new SqlParameter("id", stringid));

            }
        }
        #endregion

        public MyModel.Model_BSGroupInfo GetBSGroupInfoByID(int ID)
        {
            MyModel.Model_BSGroupInfo MBS = new MyModel.Model_BSGroupInfo();
            StringBuilder sbSQL = new StringBuilder(@" SELECT Top 1 * FROM BSGroup_info WHERE ID=@ID ");
            DataTable dt = SQLHelper.ExecuteRead(CommandType.Text, sbSQL.ToString(), "adfafd", new SqlParameter("ID", ID));
            if (dt != null && dt.Rows.Count > 0)
            {
                MBS.ID = ID;
                MBS.BSGroupName = dt.Rows[0]["BSGroupName"].ToString();
                MBS.Entity_ID = dt.Rows[0]["Entity_ID"].ToString();
                MBS.MemberIds = dt.Rows[0]["MemberIds"].ToString();
                MBS.BSISSI = dt.Rows[0]["BSISSI"].ToString();
                return MBS;
            }
            else
            {
                return null;
            }
        }



        public IList<MyModel.Model_BSGroupInfo> GetBsGroupInfoList(string entityid)
        {
            IList<MyModel.Model_BSGroupInfo> list = new List<MyModel.Model_BSGroupInfo>();
            //StringBuilder sbSQL = new StringBuilder(@"SELECT * FROM BSGroup_info WHERE Entity_ID=@Entity_ID");
            StringBuilder sbSQL = new StringBuilder(@"WITH lmenu(name,id,ParentID) as (SELECT name,id,ParentID  FROM [Entity] WHERE id in ("+entityid+") UNION ALL SELECT A.NAME,A.id,A.ParentID FROM [Entity] A,lmenu b where a.[ParentID] = b.id) SELECT * FROM BSGroup_info WHERE Entity_ID in (select id from lmenu)");
            DataTable dt = SQLHelper.ExecuteRead(CommandType.Text, sbSQL.ToString(), "adfdsfsd");
            if (dt != null && dt.Rows.Count > 0)
            {
                foreach (DataRow dr in dt.Rows)
                {
                    list.Add(new MyModel.Model_BSGroupInfo { ID = int.Parse(dr["ID"].ToString()), MemberIds = dr["MemberIds"].ToString(), BSGroupName = dr["BSGroupName"].ToString(), Entity_ID = entityid, BSISSI = dr["BSISSI"].ToString() });
                }
            }
            return list;
        }

        public MyModel.Model_BSGroupInfo GetBSGroupInfoByISSI(string BSISSI)
        {
            MyModel.Model_BSGroupInfo MBS = new MyModel.Model_BSGroupInfo();
            StringBuilder sbSQL = new StringBuilder(@" SELECT Top 1 * FROM BSGroup_info WHERE BSISSI=@BSISSI ");
            DataTable dt = SQLHelper.ExecuteRead(CommandType.Text, sbSQL.ToString(), "adfafd", new SqlParameter("BSISSI", BSISSI));
            if (dt != null && dt.Rows.Count > 0)
            {
                MBS.ID = int.Parse(dt.Rows[0]["ID"].ToString());
                MBS.BSGroupName = dt.Rows[0]["BSGroupName"].ToString();
                MBS.Entity_ID = dt.Rows[0]["Entity_ID"].ToString();
                MBS.MemberIds = dt.Rows[0]["MemberIds"].ToString();
                MBS.BSISSI = dt.Rows[0]["BSISSI"].ToString();
            }
            return MBS;
        }

        public bool IsExistBSGISSI(string ISSI)
        {
            StringBuilder sbSQL = new StringBuilder(@"SELECT Count(0) FROM BSGroup_info WHERE BSISSI = @BSISSI");
            DataTable dt = SQLHelper.ExecuteRead(CommandType.Text, sbSQL.ToString(), "inte", new SqlParameter("BSISSI", ISSI));
            if (dt != null && dt.Rows.Count > 0)
            {
                if (int.Parse(dt.Rows[0][0].ToString()) > 0)
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }
            else
            {
                return false;
            }
        }

        public IList<MyModel.Model_BSGroupInfo> GetAllBSGroup()
        {
            IList<MyModel.Model_BSGroupInfo> list = new List<MyModel.Model_BSGroupInfo>();
            StringBuilder sbSQL = new StringBuilder(@"SELECT * FROM BSGroup_info");
            DataTable dt = SQLHelper.ExecuteRead(CommandType.Text, sbSQL.ToString(), "adfdsfsdaaa");
            if (dt != null && dt.Rows.Count > 0)
            {
                foreach (DataRow dr in dt.Rows)
                {
                    list.Add(new MyModel.Model_BSGroupInfo { ID = int.Parse(dr["ID"].ToString()), MemberIds = dr["MemberIds"].ToString(), BSGroupName = dr["BSGroupName"].ToString(), Entity_ID = dr["Entity_ID"].ToString(), BSISSI = dr["BSISSI"].ToString() });
                }
            }
            return list;
        }

        public bool IsExistBSNameInThisEntity(string BSName, string EntityID)
        {
            bool bReturn = false;
            StringBuilder sbSQL = new StringBuilder("SELECT COUNT(0) FROM BSGroup_info WHERE Entity_ID=@Entity_ID and BSGroupName=@BSGroupName");
            DataTable dt = SQLHelper.ExecuteRead(CommandType.Text, sbSQL.ToString(), "bsinfsdf", new SqlParameter("BSGroupName", BSName), new SqlParameter("Entity_ID", EntityID));
            if (dt != null && dt.Rows.Count > 0 && int.Parse(dt.Rows[0][0].ToString())>0)
            {
                bReturn = true;
            }

            return bReturn;
        }
        public bool IsExistBSNameInThisEntityForEdit(string BSName, string EntityID, int ID)
        {
            bool bReturn = false;
            StringBuilder sbSQL = new StringBuilder("SELECT COUNT(0) FROM BSGroup_info WHERE Entity_ID=@Entity_ID and BSGroupName=@BSGroupName and ID!=@ID");
            DataTable dt = SQLHelper.ExecuteRead(CommandType.Text, sbSQL.ToString(), "bsinfsdf", new SqlParameter("BSGroupName", BSName), new SqlParameter("Entity_ID", EntityID), new SqlParameter("ID", ID));
            if (dt != null && dt.Rows.Count > 0 && int.Parse(dt.Rows[0][0].ToString()) > 0)
            {
                bReturn = true;
            }

            return bReturn;
        }
        #endregion
    }
}
