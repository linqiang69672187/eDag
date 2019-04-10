using DbComponent.IDAO;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Text;
namespace DbComponent
{
    public class DXGroupInfoDao:IDXGroupInfoDao
    {
        string CTE = "WITH lmenu(name,id) as (SELECT name,id  FROM [Entity] WHERE id=@id UNION ALL SELECT A.NAME,A.id FROM [Entity] A,lmenu b where a.[ParentID] = b.id) ";
        #region IDXGroupInfoDao 成员

        #region 取得小组数量信息
        public int getallGroupcount(int selectcondition, string textseach, int id, string stringid, int gtype)
        {
            //if (stringid == null)
            //{
                string sqlcondition = "";
                if (selectcondition != 0) { sqlcondition += " and [Entity_ID]='" + selectcondition + "'"; }
                
                if (textseach != null) { sqlcondition += " and [Group_name] like '%" + stringfilter.Filter(textseach.Trim()) + "%'"; }
                return int.Parse(SQLHelper.ExecuteScalar(CommandType.Text, CTE + "select count(*) from DXGroup_info where GType=@GType and len([Group_index]) > 0 and [Entity_ID] in (select id from lmenu)" + sqlcondition, new SqlParameter("id", id), new SqlParameter("GType", gtype)).ToString());
            //}
            //else
            //{
            //    return 1;
            //}
        }
        #endregion
        #region 分页排序小组信息
        public DataTable AllGroupInfo(int selectcondition, string textseach, int id, string stringid, int gtype, string sort, int startRowIndex, int maximumRows)
        {
            if (stringid == null)
            {
                string sqlcondition = "";
                if (selectcondition != 0) { sqlcondition += " and [Entity_ID]='" + selectcondition + "'"; }
                
                if (textseach != null) { sqlcondition += " and [Group_name] like '%" + stringfilter.Filter(textseach.Trim()) + "%'"; }
                if (sort == "") { sort = "id asc"; }
                return SQLHelper.ExecuteRead(CommandType.Text, CTE + "select * from [DXGroup_info] where GType=@GType and len([Group_index]) > 0 " + sqlcondition + " and [Entity_ID] in (select id from lmenu) order by " + sort, startRowIndex, maximumRows, "Entity", new SqlParameter("id", id), new SqlParameter("GType", gtype));
            }
            else
            {
                return SQLHelper.ExecuteRead(CommandType.Text, "select * from [DXGroup_info] where GType=@GType and len([Group_index]) > 0 and id=@id", startRowIndex, maximumRows, "Entity", new SqlParameter("id", stringid), new SqlParameter("GType", gtype));

            }
        }
        #endregion

        public IList<MyModel.Model_DXGroup> GetDXGroupForCallPanl(int Type,string Entity_ID)
        {
            IList<MyModel.Model_DXGroup> dxList = new List<MyModel.Model_DXGroup>();
            StringBuilder sbSQL = new StringBuilder(" SELECT * From DXGroup_info Where GType=@GType ");
            DataTable dt = SQLHelper.ExecuteRead(System.Data.CommandType.Text, CTE + sbSQL.ToString()+ "and [Entity_ID] in (select id from lmenu)" , "adfdsd2", new SqlParameter("@GType", Type), new SqlParameter("@id", Entity_ID));
            if (dt != null && dt.Rows.Count > 0)
            {
                foreach (DataRow dr in dt.Rows)
                {
                    MyModel.Model_DXGroup DXG = new MyModel.Model_DXGroup();
                    DXG.ID = int.Parse(dr["ID"].ToString());
                    DXG.Group_index = dr["Group_index"].ToString();
                    DXG.Group_name = dr["Group_name"].ToString();
                    DXG.GSSIS = dr["GSSIS"].ToString();
                    DXG.Status = bool.Parse(dr["Status"].ToString());
                    DXG.Entity_ID = dr["Entity_ID"].ToString();
                    DXG.GType = Type;
                    dxList.Add(DXG);
                }
            }
            return dxList;
        }

        public bool UpdateGSSIByGroupIndex(string GroupIndex,string GSSIS)
        {
            StringBuilder sbSQL = new StringBuilder("update DXGroup_info set GSSIS=@GSSIS where Group_index=@Group_index");
            try
            {
                SQLHelper.ExecuteNonQuery(CommandType.Text, sbSQL.ToString(), new SqlParameter("GSSIS", GSSIS), new SqlParameter("Group_index", GroupIndex));
                return true;
            }
            catch (Exception ex)
            {
                return false;
            }
        }

        public bool Add(string Group_name, string Group_index, string GSSIS, string Entity_ID, int GType)
        {
            StringBuilder sbSQL = new StringBuilder(@"insert into DXGroup_info (Group_name,Group_index,GSSIS,Entity_ID,Status,GType) values (@Group_name,@Group_index,@GSSIS,@Entity_ID,@Status,@GType)");
            try
            {
                SQLHelper.ExecuteNonQuery(CommandType.Text, sbSQL.ToString(), new SqlParameter("Group_name", Group_name), new SqlParameter("Group_index", Group_index), new SqlParameter("GSSIS", GSSIS), new SqlParameter("Entity_ID", Entity_ID), new SqlParameter("Status", false), new SqlParameter("GType", GType));
                return true;
            }
            catch (Exception ex)
            {
                return false;
            }
        }

        public bool SelectStatusByID(int ID)
        {
            StringBuilder sbSQL = new StringBuilder("SELECT Status FROM DXGroup_info WHERE ID = @ID");
            DataTable dt = SQLHelper.ExecuteRead(CommandType.Text, sbSQL.ToString(), "held", new SqlParameter("ID", ID));
            if (dt != null && dt.Rows.Count > 0)
            {
                if (dt.Rows[0][0].ToString() == "False")
                    return false;
                else
                    return true;
            }
            else return false;
        }

        public bool Delete(int ID)
        {
            StringBuilder sbSQL = new StringBuilder("DELETE FROM DXGroup_info WHERE ID = @ID");
            try {
                SQLHelper.ExecuteNonQuery(CommandType.Text, sbSQL.ToString(), new SqlParameter("ID", ID));
                return true;
            }
            catch (Exception ex) {
                return false;
            }
        }

        public bool UpdateStatusByGSSI(string GSSI)
        {
            throw new NotImplementedException();
        }

        public bool IsExistGSSI(string GSSI)
        {
            StringBuilder sbSQL = new StringBuilder("Select Count(0) from DXGroup_info WHERE Group_index = @GSSI");
            DataTable dt = SQLHelper.ExecuteRead(CommandType.Text, sbSQL.ToString(), "adfddss", new SqlParameter("GSSI", GSSI));
            if (dt != null && dt.Rows.Count > 0)
            {
                if (dt.Rows[0][0].ToString() == "0")
                {
                    return false;
                }
                else
                    return true;
            }
            else
                return false;
        }

        public MyModel.Model_DXGroup GetDxGroupByID(int ID)
        {
            StringBuilder sbSQL = new StringBuilder("SELECT * FROM DXGroup_info WHERE ID = @ID ");
            DataTable dt = SQLHelper.ExecuteRead(CommandType.Text, sbSQL.ToString(), "adfadfa", new SqlParameter("ID", ID));
            MyModel.Model_DXGroup MDX = null;
            if (dt != null && dt.Rows.Count > 0)
            {
                MDX = new MyModel.Model_DXGroup()
                {
                    ID = int.Parse(dt.Rows[0]["ID"].ToString()),
                    Entity_ID = dt.Rows[0]["Entity_ID"].ToString(),
                    GSSIS = dt.Rows[0]["GSSIS"].ToString(),
                    Status = bool.Parse(dt.Rows[0]["Status"].ToString()),
                    Group_index = dt.Rows[0]["Group_index"].ToString(),
                    Group_name = dt.Rows[0]["Group_name"].ToString()
                };
            }
            return MDX;
        }

        public bool UpdateGXGroup(int id, string Group_name, string GSSIS, string Entity_ID)
        {
            StringBuilder sbSQL = new StringBuilder(@"Update DXGroup_info set  Group_name=@Group_name ,GSSIS=@GSSIS , Entity_ID=@Entity_ID Where ID=@ID");
            try
            {
                SQLHelper.ExecuteNonQuery(CommandType.Text, sbSQL.ToString(), new SqlParameter("Group_name", Group_name), new SqlParameter("GSSIS", GSSIS), new SqlParameter("Entity_ID", Entity_ID), new SqlParameter("ID", id));
                return true;
            }
            catch (Exception ex)
            {
                return false;
            }
        }

        public bool IsExistPJNameByEntityForAdd(string PjName, string EntityID)
        {
            return IsExistNameByEntityForAdd(PjName, EntityID, 1);
        }

        public bool IsExistPjNameByEntityForEdit(string PjName, string Entityid, int ID)
        {
            return IsExistNameByEntityForEdit(PjName, Entityid, 1, ID);
        }

        public bool IsExistDxNameByEntityForAdd(string PjName, string Entityid)
        {
            return IsExistNameByEntityForAdd(PjName, Entityid, 0);
        }

        public bool IsExistDxNameByEntityForEdit(string PjName, string Entityid, int ID) {
            return IsExistNameByEntityForEdit(PjName, Entityid, 0, ID);
        }

        public bool IsExistNameByEntityForAdd(string PjName, string EntityID, int GType) {
            bool bReturn = false;
            StringBuilder sbSQL = new StringBuilder("SELECT COUNT(0) FROM DXGroup_info WHERE GType=@GType and Entity_ID=@Entity_ID and Group_name=@PjName");
            DataTable dt = SQLHelper.ExecuteRead(CommandType.Text, sbSQL.ToString(), "adddaadda", new SqlParameter("PjName", PjName), new SqlParameter("Entity_ID", EntityID), new SqlParameter("GType", GType));
            if (dt != null && dt.Rows.Count > 0 && int.Parse(dt.Rows[0][0].ToString()) > 0)
            {
                bReturn = true;
            }

            return bReturn;
        }
        public bool IsExistNameByEntityForEdit(string PjName, string EntityID, int GType, int ID)
        {
            bool bReturn = false;
            StringBuilder sbSQL = new StringBuilder("SELECT COUNT(0) FROM DXGroup_info WHERE GType=@GType and Entity_ID=@Entity_ID and Group_name=@PjName and ID!=@ID");
            DataTable dt = SQLHelper.ExecuteRead(CommandType.Text, sbSQL.ToString(), "dcdfddzccvz", new SqlParameter("PjName", PjName), new SqlParameter("Entity_ID", EntityID), new SqlParameter("ID", ID), new SqlParameter("GType", GType));
            if (dt != null && dt.Rows.Count > 0 && int.Parse(dt.Rows[0][0].ToString()) > 0)
            {
                bReturn = true;
            }

            return bReturn;
        }

        public IList<MyModel.Model_DXGroup> GetAllResultInGissi(string GSSI)
        {
            IList<MyModel.Model_DXGroup> dxList = new List<MyModel.Model_DXGroup>();
            StringBuilder sbSQL = new StringBuilder(" SELECT * From DXGroup_info Where GSSIS like '%" + GSSI + "%' ");
            DataTable dt = SQLHelper.ExecuteRead(System.Data.CommandType.Text, sbSQL.ToString(), "addd");
            if (dt != null && dt.Rows.Count > 0)
            {
                foreach (DataRow dr in dt.Rows)
                {
                    MyModel.Model_DXGroup DXG = new MyModel.Model_DXGroup();
                    DXG.ID = int.Parse(dr["ID"].ToString());
                    DXG.Group_index = dr["Group_index"].ToString();
                    DXG.Group_name = dr["Group_name"].ToString();
                    DXG.GSSIS = dr["GSSIS"].ToString();
                    DXG.Status = bool.Parse(dr["Status"].ToString());
                    DXG.Entity_ID = dr["Entity_ID"].ToString();
                    DXG.GType = int.Parse(dr["GType"].ToString());
                    dxList.Add(DXG);
                }
            }
            return dxList;
        }
        #endregion
    }
}
