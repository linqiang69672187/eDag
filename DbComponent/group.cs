using System;
using System.Collections;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using Ryu666.Components;
using System.Web;
using System.Web.SessionState;

namespace DbComponent
{
    public enum ISSIType
    { 
        issi,
        group,
        dispatch
    }

    public enum OperType
    { 
        Add,
        Edit
    }


    public class group :  IRequiresSessionState
    {
        string connstring = System.Configuration.ConfigurationManager.AppSettings["m_connectionString"];
        string CTE = "WITH lmenu(name,id) as (SELECT name,id  FROM [Entity] WHERE id=@id UNION ALL SELECT A.NAME,A.id FROM [Entity] A,lmenu b where a.[ParentID] = b.id) ";
        
        #region 检查SSI号是否存在
        /// <summary>
        /// 判断ISSI/GSSI是否存在
        /// </summary>
        /// <param name="GISSI">GSSI/ISSI号码</param>
        /// <returns>true/false</returns>
        public bool CheckSSIIsExist(string GISSI, OperType type, int ID)
        {
            int obj = 0;
            int intissi = int.Parse(SQLHelper.ExecuteScalar(CommandType.Text, "SELECT COUNT(id) FROM [dbo].[ISSI_info]  where ISSI = @ISSI and id <>@id ", new SqlParameter("ISSI", GISSI), new SqlParameter("id", ID)).ToString());
            int intDispatch = int.Parse(SQLHelper.ExecuteScalar(CommandType.Text, "SELECT COUNT(id) FROM [Dispatch_Info]  where ISSI = @ISSI and id <>@id ", new SqlParameter("ISSI", GISSI), new SqlParameter("id", ID)).ToString());
            int intgroup = int.Parse(SQLHelper.ExecuteScalar(CommandType.Text, "SELECT COUNT(id) FROM [Group_info]  where GSSI = @ISSI and id <>@id ", new SqlParameter("ISSI", GISSI), new SqlParameter("id", ID)).ToString());
            obj = intissi + intDispatch + intgroup;

            if (obj > 0)
            {
                return true;
            }
            else
                return false;
        }
        #endregion
        #region 根据GSSI查询重复
        public int checkOriginalGssi(string Gssi)
        {
            return int.Parse(SQLHelper.ExecuteScalar(CommandType.Text, "SELECT COUNT(id) FROM [dbo].[Group_info]  where GSSI = @OriginalGssi ", new SqlParameter("OriginalGssi", Gssi)).ToString());

        }
        #endregion

        #region 分页排序小组信息
        public DataTable AllGroupInfo(int grouptype, int selectcondition, string textseach, int id, string stringid, int isExternal, string sort, int startRowIndex, int maximumRows)
        {
            if (stringid == null)
            {
                if (isExternal == 1)
                {
                    string sqlcondition = "";
                   
                    if (grouptype == 0)
                    {
                        sqlcondition += " and len([GSSIS])<2 ";
                    }
                    else
                    {
                        sqlcondition += " and len([GSSIS])>2 ";
                    }
                    sqlcondition += " and IsExternal=1 ";
                    if (sort == "")
                    {
                        sort = "id asc";
                    }
                    return SQLHelper.ExecuteRead(CommandType.Text, CTE + "select * from [Group_info] where len([GSSI]) > 0 " + sqlcondition + " and [Entity_ID] in (select id from lmenu) order by " + sort, startRowIndex, maximumRows, "Entity", new SqlParameter("id", id));

                }
                else
                {
                    string sqlcondition = "";
                    if (selectcondition != 0)
                    {
                        sqlcondition += " and [Entity_ID]='" + selectcondition + "'";
                    }
                    if (grouptype == 0)
                    {
                        sqlcondition += " and len([GSSIS])<2 ";
                    }
                    else
                    {
                        sqlcondition += " and len([GSSIS])>2 ";
                    }
                    if (textseach != null)
                    {
                        sqlcondition += " and [Group_name] like '%" + stringfilter.Filter(textseach.Trim()) + "%'";
                    }
                    if (sort == "")
                    {
                        sort = "id asc";
                    }
                    return SQLHelper.ExecuteRead(CommandType.Text, CTE + "select * from [Group_info] where len([GSSI]) > 0 " + sqlcondition + " and [Entity_ID] in (select id from lmenu) order by " + sort, startRowIndex, maximumRows, "Entity", new SqlParameter("id", id));
                }
            }
            else
            {
                return SQLHelper.ExecuteRead(CommandType.Text, "select * from [Group_info] where len([GSSI]) > 0 and id=@id", startRowIndex, maximumRows, "Entity", new SqlParameter("id", stringid));

            }
        }

        public DataTable AllGroupInfo(int grouptype,string GSSIorGroup, int selectcondition, string textseach, int id, string stringid, string sort, int startRowIndex, int maximumRows)
        {
            if (stringid == null)
            {
                string sqlcondition = "";
                if (selectcondition != 0)
                {
                    sqlcondition += " and [Entity_ID]='" + selectcondition + "'";
                }
                if (grouptype == 0)
                {
                    sqlcondition += " and len([GSSIS])<2 ";
                }
                else
                {
                    sqlcondition += " and len([GSSIS])>2 ";
                }

                if (GSSIorGroup.ToLower().Contains("gssi"))
                {
                    if (textseach != null)
                    {
                        sqlcondition += " and [GSSI] like '%" + stringfilter.Filter(textseach.Trim()) + "%'";
                    }
                } 
                else
                {
                    if (textseach != null)
                    {
                        sqlcondition += " and [Group_name] like '%" + stringfilter.Filter(textseach.Trim()) + "%'";
                    }
                }

                
                if (string.IsNullOrEmpty(sort))
                {
                    sort = "id asc";
                }
                return SQLHelper.ExecuteRead(CommandType.Text, CTE + "select * from [Group_info] where len([GSSI]) > 0 " + sqlcondition + " and [Entity_ID] in (select id from lmenu) order by " + sort, startRowIndex, maximumRows, "Entity", new SqlParameter("id", id));
            }
            else
            {
                return SQLHelper.ExecuteRead(CommandType.Text, "select * from [Group_info] where len([GSSI]) > 0 and id=@id", startRowIndex, maximumRows, "Entity", new SqlParameter("id", stringid));

            }
        }

        
        #endregion

        #region 取得小组数量信息
        public int getallGroupcount(int grouptype, int selectcondition, string textseach, int id, string stringid, int isExternal)
        {
            if (stringid == null)
            {
                if (isExternal == 1)
                {
                    string sqlcondition = "";
                    if (grouptype == 0)
                    { sqlcondition += " and len([GSSIS])<2 "; }
                    else
                    { sqlcondition += " and len([GSSIS])>2 "; }
                    sqlcondition += " and IsExternal=1 ";
                    return int.Parse(SQLHelper.ExecuteScalar(CommandType.Text, CTE + "select count(*) from Group_info where len([GSSI]) > 0 and [Entity_ID] in (select id from lmenu)" + sqlcondition, new SqlParameter("id", id)).ToString());

                }
                else
                {
                    string sqlcondition = "";
                    if (selectcondition != 0) { sqlcondition += " and [Entity_ID]='" + selectcondition + "'"; }
                    if (grouptype == 0)
                    { sqlcondition += " and len([GSSIS])<2 "; }
                    else
                    { sqlcondition += " and len([GSSIS])>2 "; }
                    if (textseach != null) { sqlcondition += " and [Group_name] like '%" + stringfilter.Filter(textseach.Trim()) + "%'"; }
                    return int.Parse(SQLHelper.ExecuteScalar(CommandType.Text, CTE + "select count(*) from Group_info where len([GSSI]) > 0 and [Entity_ID] in (select id from lmenu)" + sqlcondition, new SqlParameter("id", id)).ToString());
                }
            }
            else
            {
                return 1;
            }
          }

        public int getallGroupcount(int grouptype,string GSSIorGroup, int selectcondition, string textseach, int id, string stringid)
        {
            if (stringid == null)
            {
                string sqlcondition = "";
                if (selectcondition != 0) { sqlcondition += " and [Entity_ID]='" + selectcondition + "'"; }
                if (grouptype == 0)
                { sqlcondition += " and len([GSSIS])<2 "; }
                else
                { sqlcondition += " and len([GSSIS])>2 "; }
                //if (textseach != null) { sqlcondition += " and [Group_name] like '%" + stringfilter.Filter(textseach.Trim()) + "%'"; }
                if (GSSIorGroup.ToLower().Contains("gssi"))
                {
                    if (textseach != null)
                    {
                        sqlcondition += " and [GSSI] like '%" + stringfilter.Filter(textseach.Trim()) + "%'";
                    }
                }
                else
                {
                    if (textseach != null)
                    {
                        sqlcondition += " and [Group_name] like '%" + stringfilter.Filter(textseach.Trim()) + "%'";
                    }
                }
                return int.Parse(SQLHelper.ExecuteScalar(CommandType.Text, CTE + "select count(*) from Group_info where len([GSSI]) > 0 and [Entity_ID] in (select id from lmenu)" + sqlcondition, new SqlParameter("id", id)).ToString());
            }
            else
            {
                return 1;
            }
        }
        #endregion

        #region 添加小组信息
        public bool CheckGroupInfo(string Group_name, string GSSI, string Entity_id,int length)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("select count(*) from Group_info where Group_name=@Group_name and Entity_ID=@Entity_ID ");
            if (length > 0)
                sb.Append(" and GSSIS<>'0'");
            else
                sb.Append(" and GSSIS='0'");

            object obj = SQLHelper.ExecuteScalar(CommandType.Text, sb.ToString(), new SqlParameter("Group_name", Group_name), new SqlParameter("Entity_ID", Entity_id));

            if (Convert.ToInt32(obj) > 0)
            {
                return true;
            }
            else
                return false;
        }

        public bool AddGroupinfo(string Group_name, string GSSI, string Entity_ID,int isExternal,string OriginalGssi,string TypeName)
        {
            try
            {
                SQLHelper.ExecuteNonQuery(CommandType.Text, "INSERT INTO [Group_info]([Group_name],[GSSI],[Entity_ID],[IsExternal],[OriginalGssi],[TypeName])VALUES (@Group_name,@GSSI,@Entity_ID,@IsExternal,@OriginalGssi,@TypeName)", new SqlParameter("Group_name", Group_name), new SqlParameter("GSSI", GSSI), new SqlParameter("Entity_ID", Entity_ID), new SqlParameter("IsExternal", isExternal), new SqlParameter("OriginalGssi", OriginalGssi), new SqlParameter("TypeName", TypeName));
                return true;
            }
            catch 
            {return false;}
         }
        #endregion

        #region 根据ID取小组信息
        public MyModel.Model_group GetGroupinfo_byid(int id)
        {
            MyModel.Model_group Group = new MyModel.Model_group();
           DataTable dt = SQLHelper.ExecuteRead(CommandType.Text, "select top 1 * from [Group_info] where id =@id order by id asc", "groupinfo", new SqlParameter("id", id));
           for (int counti = 0; counti < dt.Rows.Count;counti++ )
           {
               Group.id = int.Parse(dt.Rows[counti][0].ToString());
               Group.Group_name = dt.Rows[counti][1].ToString();
               Group.GSSI = dt.Rows[counti][2].ToString();
               Group.GSSIS = dt.Rows[counti][3].ToString();
               Group.Entity_ID = dt.Rows[counti][4].ToString();
               Group.status = Boolean.Parse(dt.Rows[counti][5].ToString());
               Group.isExternal = int.Parse(dt.Rows[counti][6].ToString());
               Group.TypeName = dt.Rows[counti][8].ToString();
           }
            return Group;
        }

        public MyModel.Model_group GetPJDXGroupinfo_byid(int id)
        {
            MyModel.Model_group Group = new MyModel.Model_group();
            DataTable dt = SQLHelper.ExecuteRead(CommandType.Text, "select top 1 * from [DXGroup_info] where id =@id order by id asc", "DXGroup_info", new SqlParameter("id", id));
            for (int counti = 0; counti < dt.Rows.Count; counti++)
            {
                Group.id = int.Parse(dt.Rows[counti][0].ToString());
                Group.Group_name = dt.Rows[counti][1].ToString();
                Group.GSSI = dt.Rows[counti][2].ToString();
                Group.GSSIS = dt.Rows[counti][3].ToString();
                Group.Entity_ID = dt.Rows[counti][4].ToString();
                Group.status = Boolean.Parse(dt.Rows[counti][5].ToString());
            }
            return Group;
        }

        public MyModel.Model_group GetBSGroupinfo_byid(int id)
        {
            MyModel.Model_group Group = new MyModel.Model_group();
            DataTable dt = SQLHelper.ExecuteRead(CommandType.Text, "select top 1 * from [BSGroup_info] where id =@id order by id asc", "BSGroup_info", new SqlParameter("id", id));
            for (int counti = 0; counti < dt.Rows.Count; counti++)
            {
                Group.id = int.Parse(dt.Rows[counti][0].ToString());
                Group.Group_name = dt.Rows[counti][1].ToString();
                Group.GSSI = dt.Rows[counti][5].ToString();
                Group.GSSIS = dt.Rows[counti][2].ToString();
                Group.Entity_ID = dt.Rows[counti][3].ToString();
                Group.status = Boolean.Parse(dt.Rows[counti][4].ToString());
            }
            return Group;
        }

        public MyModel.Model_group GetGroupinfo_ByGssi(int gssi)
        {
            MyModel.Model_group Group = new MyModel.Model_group();
            DataTable dt = SQLHelper.ExecuteRead(CommandType.Text, "select top 1 * from [Group_info] where GSSI =@GSSI order by id asc", "groupinfo", new SqlParameter("GSSI", gssi));
            for (int counti = 0; counti < dt.Rows.Count; counti++)
            {
                Group.id = int.Parse(dt.Rows[counti][0].ToString());
                Group.Group_name = dt.Rows[counti][1].ToString();
                Group.GSSI = dt.Rows[counti][2].ToString();
                Group.GSSIS = dt.Rows[counti][3].ToString();
                Group.Entity_ID = dt.Rows[counti][4].ToString();
                Group.status = Boolean.Parse(dt.Rows[counti][5].ToString());
            }
            return Group;
        }

        public MyModel.Model_Stockade GetStackadeGroupinfo_byid(int id)
        {
            MyModel.Model_Stockade Stockade = new MyModel.Model_Stockade();
            DataTable dt = SQLHelper.ExecuteRead(CommandType.Text, "select top 1 * from [Stockade] where id =@id order by id asc", "Stockade", new SqlParameter("id", id));
            for (int counti = 0; counti < dt.Rows.Count; counti++)
            {
                Stockade.ID = int.Parse(dt.Rows[counti][0].ToString());
                Stockade.LoginName = dt.Rows[counti][1].ToString();
                Stockade.Title = dt.Rows[counti][3].ToString();
                Stockade.CreateTime =DateTime.Parse(dt.Rows[counti][4].ToString());
                Stockade.DivID = dt.Rows[counti][6].ToString();
                Stockade.Type = int.Parse(dt.Rows[counti][8].ToString());
                //Stockade.status = Boolean.Parse(dt.Rows[counti][4].ToString());
            }
            return Stockade;
        }
        #endregion

        #region 根据GSSI取组名
        public string GetGroupGroupname_byGSSI(string GSSI)
        {
            try
            {
                return SQLHelper.ExecuteScalar(CommandType.Text, "select top 1 [Group_name] from [Group_info] where [GSSI] =@GSSI", new SqlParameter("GSSI", GSSI)).ToString();

            }
            catch (System.Exception ex)
            {
                return ResourceManager.GetString("Unkown");
            }
        }
        #endregion

        #region 根据ID修改小组信息
        public bool CheckEditGroupInfo(string Group_name,string ID, string Entity_id,int length)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("select count(*) from Group_info where Group_name=@Group_name and Entity_ID=@Entity_ID and ID<>@ID ");
            if (length == 1)
                sb.Append(" and GSSIS='0'");
            else
                sb.Append(" and GSSIS<>'0'");

            object obj = SQLHelper.ExecuteScalar(CommandType.Text, sb.ToString(), new SqlParameter("Group_name", Group_name), new SqlParameter("Entity_ID", Entity_id),new SqlParameter("ID",ID));

            if (Convert.ToInt32(obj)>0)
            {
                return true;
            }
            else
                return false;
        }

        public bool EditGroupinfo_byid(int ID, string Group_name, string GSSI, string GSSIS, string Entity_ID, Boolean status,int isExternal)
        {
            int i = SQLHelper.ExecuteNonQuery(CommandType.Text, "UPDATE [Group_info] SET [Group_name] =@Group_name,GSSI=@GSSI,GSSIS=@GSSIS,Entity_ID =@Entity_ID,status =@status,isExternal=@isExternal where id =@ID", new SqlParameter("Group_name", Group_name), new SqlParameter("GSSI", GSSI), new SqlParameter("GSSIS", GSSIS), new SqlParameter("Entity_ID", Entity_ID), new SqlParameter("status", status), new SqlParameter("ID", ID), new SqlParameter("IsExternal", isExternal));

            return i > 0 ? true : false;
        }
        #endregion

        #region 根据ID删除小组信息
        public void DelGroupinfo_byid(int id)
        {
            SQLHelper.ExecuteNonQuery(CommandType.Text, "DELETE FROM [Group_info] where id =@id", new SqlParameter("id", id));
        }
        #endregion

        #region 根据ID检查小组呼叫状态
        public int Groupstatus_byid(int id)
        {
            return int.Parse(SQLHelper.ExecuteScalar(CommandType.Text, "select count(*) from Group_info where id=@id  and [status] =1", new SqlParameter("id", id)).ToString());
        }
        #endregion

        #region 根据GSSI检查是否有通播组含该小组
        public int checkTBgroup_byGSSI(string GSSI)
        {
            return int.Parse(SQLHelper.ExecuteScalar(CommandType.Text, "select count(*) from Group_info where GSSIS like '%<" + GSSI + ">%'").ToString());
        }
        #endregion

        #region 获取可被通播的小组列表
        public DataTable checkTBgroup_GSSIS(string Entity_ID, string selectcondition, string textseach,string GSSI,int id, string sort, int startRowIndex, int maximumRows)
        {
            string sqlcondition = "";
            if (Entity_ID != "0") { sqlcondition += " and [Entity_ID]='" + Entity_ID + "'"; }
            if (textseach != null) { sqlcondition += " and " + selectcondition + " like '%" + stringfilter.Filter(textseach.Trim()) + "%'"; }
            if (GSSI ==null)
            {sqlcondition += " and  GSSI not in(select a.GSSI from [dbo].[Group_info] a, [dbo].[Group_info] b where CHARINDEX('<'+a.GSSI+'>',b.GSSIS)>0)";} 
            else
            { sqlcondition += " and  GSSI not in(select a.GSSI from [dbo].[Group_info] a, [dbo].[Group_info] b where CHARINDEX('<'+a.GSSI+'>',b.GSSIS)>0 and b.GSSI <>'" + GSSI + "')"; }
            if (sort == "") { sort = "id asc"; }
            return SQLHelper.ExecuteRead(CommandType.Text, CTE + "select * from [Group_info] where len([GSSIS]) < 2 " + sqlcondition + " and [Entity_ID] in (select id from lmenu) order by " + sort, startRowIndex, maximumRows, "Entity", new SqlParameter("id", id));

        }
        #endregion

        #region 获取可被通播的小组列表(数量)
        public int CountcheckTBgroup_GSSIS(string Entity_ID, string selectcondition, string textseach,string GSSI,int id)
        {
            string sqlcondition = "";
            if (Entity_ID != "0") { sqlcondition += " and [Entity_ID]='" + Entity_ID + "'"; }
            if (textseach != null) { sqlcondition += " and " + selectcondition + " like '%" + stringfilter.Filter(textseach.Trim()) + "%'"; }
            if (GSSI == null)
            { sqlcondition += " and  GSSI not in(select a.GSSI from [dbo].[Group_info] a, [dbo].[Group_info] b where CHARINDEX('<'+a.GSSI+'>',b.GSSIS)>0)"; }
            else
            { sqlcondition += " and  GSSI not in(select a.GSSI from [dbo].[Group_info] a, [dbo].[Group_info] b where CHARINDEX('<'+a.GSSI+'>',b.GSSIS)>0 and b.GSSI <>'" + GSSI + "')"; }
            return int.Parse(SQLHelper.ExecuteScalar(CommandType.Text, CTE + "select count(*) from [Group_info] where len([GSSIS]) < 2 and [Entity_ID] in (select id from lmenu)" + sqlcondition, new SqlParameter("id", id)).ToString());
        }
        #endregion

        #region 获取可被通播的小组列表
        public DataTable checkTBgroup_GSSISByStrProc(string Entity_ID, string selectcondition, string textseach, string GSSI, int id, string sort, int startRowIndex, int maximumRows)
        {
            if (GSSI == null) {
                GSSI = "0";
            }
            if (textseach == null) {
                textseach = "";
            }
            string StoredProcedureName = "checkTBgroup_GSSIS";
            return SQLHelper.ExecuteReadStrProc(CommandType.StoredProcedure, StoredProcedureName, startRowIndex, maximumRows, "Entity", new SqlParameter("id", id), new SqlParameter("GSSI", GSSI), new SqlParameter("Entity_ID", Entity_ID), new SqlParameter("selectcondition", selectcondition), new SqlParameter("textseach", textseach));

        }
        #endregion

        #region 获取可被通播的小组列表(数量)
        public int CountcheckTBgroup_GSSISByStrProc(string Entity_ID, string selectcondition, string textseach, string GSSI, int id)
        {
            if (GSSI == null)
            {
                GSSI = "0";
            }
            if (textseach == null)
            {
                textseach = "";
            }
            string StoredProcedureName = "CountcheckTBgroup_GSSIS";
            return int.Parse(SQLHelper.ExecuteScalarStrProc(CommandType.StoredProcedure, StoredProcedureName, new SqlParameter("id", id), new SqlParameter("GSSI", GSSI), new SqlParameter("Entity_ID", Entity_ID), new SqlParameter("selectcondition", selectcondition), new SqlParameter("textseach", textseach)).ToString());
        }
        #endregion

        #region GSSI是否可被通播
        public int checkTBgroup_GSSI(string GSSI,int id)
        {
            return Convert.ToInt32(SQLHelper.ExecuteScalar(CommandType.Text, "select count(*) from Group_info where GSSIS like '%<"+GSSI+">%' and id <>@id", new SqlParameter("id", id)).ToString());
        }
        #endregion

        #region 添加通播组信息
        public bool CheckGroupInfo(string Group_name, string GSSI, string GSSIS, string Entity_ID)
        {
            object obj = SQLHelper.ExecuteScalar(CommandType.Text, "select count(*) from Group_info where Group_name=@Group_name and Entity_ID=@Entity_ID", new SqlParameter("Group_name", Group_name), new SqlParameter("Entity_ID", Entity_ID));

            if (Convert.ToInt32(obj) > 0)
            {
                return false;
            }
            else
                return true;
        }

        public MyModel.Enum.AddTBGroupResult AddTBGroupinfo(string Group_name, string GSSI, string GSSIS, string Entity_ID, int isExternal, string OriginalGssi, string TypeName)
        {
            try
            {
                object obj = SQLHelper.ExecuteScalar(CommandType.Text, "select * from Group_info where Group_name=@Group_name and Entity_ID=@Entity_ID", new SqlParameter("Group_name", Group_name), new SqlParameter("Entity_ID", Entity_ID));

                if (Convert.ToInt32(obj) > 0)
                {
                    return MyModel.Enum.AddTBGroupResult.isexistgroupname;
                }

                SQLHelper.ExecuteNonQuery(CommandType.Text, "INSERT INTO [Group_info]([Group_name],[GSSI],[GSSIS],[Entity_ID],[IsExternal],[OriginalGssi],[TypeName])VALUES (@Group_name,@GSSI,@GSSIS,@Entity_ID,@IsExternal,@OriginalGssi,@TypeName)", 
                    new SqlParameter("Group_name", Group_name), new SqlParameter("GSSI", GSSI), new SqlParameter("GSSIS", GSSIS), new SqlParameter("Entity_ID", Entity_ID), new SqlParameter("IsExternal", isExternal), new SqlParameter("OriginalGssi", OriginalGssi), new SqlParameter("TypeName", TypeName));
                return MyModel.Enum.AddTBGroupResult.addsuccess;
            }
            catch
            { return MyModel.Enum.AddTBGroupResult.addfailed; }
        }

        
        #endregion

        #region 获取小组列表GSSI
        public ArrayList getALLgroup_GSSI(int id)
        {
            ArrayList GSSIS = new ArrayList();
            DataTable dt;
            dt = SQLHelper.ExecuteRead(CommandType.Text, CTE + "select GSSI from Group_info where len(GSSI) > 0 and [Entity_ID] in (select id from lmenu)", "GSSIlist", new SqlParameter("id", id));

            for (int i = 0; i < dt.Rows.Count;i++ )
            {
                GSSIS.Add(dt.Rows[i][0].ToString());
            }
            return GSSIS;
        }
        #endregion

        #region 分页排序可扫描（通播）小组信息GRIDVIEW
        public DataTable AllGroupInfo(int grouptype,string Entity_ID, string selectcondition, string textseach,int id, string sort, int startRowIndex, int maximumRows)
        {
            string sqlcondition = "";
            if (Entity_ID != "0") { sqlcondition += " and [Entity_ID]='" + Entity_ID + "'"; }

            if (textseach != null) { sqlcondition += " and " + selectcondition + " like '%" + stringfilter.Filter(textseach.Trim()) + "%'"; }
            if (sort == "") { sort = "id asc"; }
            if (grouptype==1)
            {
                sqlcondition += " and len(GSSIS) > 2 ";
            }
            return SQLHelper.ExecuteRead(CommandType.Text, "WITH lmenu(name,id) as (SELECT name,id  FROM [Entity] WHERE id=@id UNION ALL SELECT A.NAME,A.id FROM [Entity] A,lmenu b where a.[ParentID] = b.id) select * from [Group_info] where len([GSSI]) > 0 " + sqlcondition + " and [Entity_ID] in (select id from lmenu) order by " + sort, startRowIndex, maximumRows, "Entity", new SqlParameter("id", id));
        }
        #endregion

        #region 分页排序可扫描小组信息(数量)GRIDVIEW
        public int AllGroupInfocount(int grouptype, string Entity_ID, string selectcondition, string textseach,int id)
        {   string sqlcondition = "";
            if (Entity_ID != "0") { sqlcondition += " and [Entity_ID]='" + Entity_ID + "'"; }
            if (textseach != null) { sqlcondition += " and " + selectcondition + " like '%" + stringfilter.Filter(textseach.Trim()) + "%'"; }
            if (grouptype == 1)
            {sqlcondition += " and len(GSSIS) > 2 ";}
            return int.Parse(SQLHelper.ExecuteScalar(CommandType.Text, "WITH lmenu(name,id) as (SELECT name,id  FROM [Entity] WHERE id=@id UNION ALL SELECT A.NAME,A.id FROM [Entity] A,lmenu b    where a.[ParentID] = b.id) select count(*) from Group_info where len([GSSI]) > 0 and [Entity_ID] in (select id from lmenu)" + sqlcondition, new SqlParameter("id", id)).ToString());
         }

        
        #endregion

        #region 根据GSSI查询重复
        public int checkGSSI(string GSSI, int id)
        {
            return int.Parse(SQLHelper.ExecuteScalar(CommandType.Text, "SELECT COUNT(id) FROM [dbo].[Group_info]  where GSSI = @GSSI and id <>@id ", new SqlParameter("GSSI", GSSI), new SqlParameter("id", id)).ToString());
        }
        #endregion

        public DataTable GetGroupInfoByGIIS(string giis) {
            string strSql = "select top 1 Group_name,Name,GSSI,GSSIS,status from Group_info left outer join Entity on (Group_info.entity_id=Entity.id)  where GSSI=@GSSI";
            DataTable dt = SQLHelper.ExecuteRead(CommandType.Text, strSql, "adada", new SqlParameter("GSSI", giis));
            return dt;
        }
        //根据组名获取组信息
        public DataTable GetGroupInfoByGroupName(string groupname)
        {
            string strSql = "select top 1 Group_name,Name,GSSI,GSSIS,status from Group_info left outer join Entity on (Group_info.entity_id=Entity.id)  where Group_name=@groupname";
            DataTable dt = SQLHelper.ExecuteRead(CommandType.Text, strSql, "Group", new SqlParameter("groupname", groupname));
            return dt;
        }
        /// <summary>
        /// 判断一组ISSI里面是否包含GSSI
        /// </summary>
        /// <param name="issis"></param>
        /// <returns></returns>
        public bool CheckISSIHaveGSSI(string issis)
        {

            string strSQL = "Select count (0) from Group_info where GSSI in (" + issis + ") ";
            DataTable dt = SQLHelper.ExecuteRead(CommandType.Text, strSQL, "haha");
            if (dt != null && dt.Rows.Count > 0 && int.Parse(dt.Rows[0][0].ToString()) > 0)
            {
                return true;
            }
            else
                return false;
        }

        public DataTable GetGroupsByEntityId(string entityId) {
            string strSQL = CTE + " SELECT id,Group_name uname,GSSI uissi,utype='" + Ryu666.Components.ResourceManager.GetString("Group") + "',ucheck='0' from Group_info where GSSI!='' and Entity_ID in (select id from lmenu)  ";
            return SQLHelper.ExecuteRead(CommandType.Text, strSQL, "bds", new SqlParameter("id", entityId));
        }



    
    }
}
