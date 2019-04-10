using System;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Web.UI.WebControls;
namespace DbComponent
{
    public partial class UChangeETree : Component
    {
        private string[] DisptchChildren;
        private string[] DisptchParents;
        #region 生成根级单位，触发生成下级
        public void createtreebegion(TreeView TreeView1, int DisptchEntityid,string Username)
        {
            //获取调度台单位的所有下级单位
            String AllChilds = GetParentID(DisptchEntityid);
            DisptchChildren = AllChilds.Split(',');
            //获取调度台单位的所有上级单位
            string AllParents = GetAllParentsID(DisptchEntityid);
            DisptchParents = AllParents.Split(',');
            TreeNode nodes;
            DataTable dt = (SQLHelper.ExecuteRead(CommandType.Text, "SELECT name,id,Depth FROM [Entity] where Depth =0", "tree1"));
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                nodes = new TreeNode();
                //判断该单位是否为调度台的自己或下级单位,是否为超级用户
                int IsBranch = IsSelfBranch(dt.Rows[i][1].ToString());
                if (IsBranch == 1)
                {
                    nodes.Text = "<span style=''>" + dt.Rows[i][0].ToString() + "</span>";
                }
                else                    
                {
                    nodes.Text = "<span style='color:#857B7A'>" + dt.Rows[i][0].ToString() + "</span>";
                }
                nodes.Value = dt.Rows[i][1].ToString() + "," + dt.Rows[i][2].ToString();
                //nodes.SelectAction = TreeNodeSelectAction.None;
                TreeView1.Nodes.Add(nodes);
                //判断该单位是否为调度台的自己或上级单位,若是则展开节点
                int IsDispatchParents = IsSelfParents(dt.Rows[i][1].ToString());
                if (IsDispatchParents == 1)
                {
                    nodes.Expanded = true;
                }
                else
                {
                    nodes.Expanded = false;
                }
                CreateTreeViewRecursive(nodes.ChildNodes, dt.Rows[i][1].ToString(), Username);//生成下级单位
            }
        }
        #endregion

        #region 循环生成下级单位
        protected void CreateTreeViewRecursive(TreeNodeCollection nodes, string parentid, string Username)
        {
            TreeNode newnodes;
            DataTable dt = (SQLHelper.ExecuteRead(CommandType.Text, "select Name,id,Depth from Entity where ParentID = @parentid order by name", parentid, new SqlParameter("parentid", parentid)));
            
            for (int i = 0; i < dt.Rows.Count; i++)
                {
                    newnodes = new TreeNode();
                    //判断该单位是否为调度台的自己或下级单位
                    int IsBranch = IsSelfBranch(dt.Rows[i][1].ToString());
                    
                    if (IsBranch == 1)
                    {
                        newnodes.Text = "<span style='width:50px'>" + dt.Rows[i][0].ToString() + "</span>";
                    }
                    else                        
                    {
                        newnodes.Text = "<span style='width:50px; color:#857B7A'>" + dt.Rows[i][0].ToString() + "</span>";

                    }
                    newnodes.Value = dt.Rows[i][1].ToString() + "," + dt.Rows[i][2].ToString();
                    newnodes.SelectAction = TreeNodeSelectAction.Select;

                    nodes.Add(newnodes);
                    //判断该单位是否为调度台的自己或上级单位,若是则展开节点
                    int IsDispatchParents = IsSelfParents(dt.Rows[i][1].ToString());
                    if (IsDispatchParents == 1)
                    {
                        newnodes.Expanded = true;
                    }
                    else
                    {
                        newnodes.Expanded = false;
                    }
                    CreateTreeViewRecursive(newnodes.ChildNodes, dt.Rows[i][1].ToString(), Username);//循环生成下级单位                    
                }
           }
        #endregion

        #region 查询下级及所有子级单位ID
        public string GetParentID(int id)
        {
            StringBuilder sb = new StringBuilder();
            DataTable dt = DbComponent.SQLHelper.ExecuteRead(CommandType.Text, "WITH lmenu(name,id,[ParentID]) as (SELECT name,id,[ParentID]  FROM [Entity] WHERE id=@id UNION ALL    SELECT A.NAME,A.id,A.ParentID FROM [Entity] A,lmenu b    where a.ParentID = b.[ID]) select id from lmenu", "getParentID", new SqlParameter("id", id));
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                sb.Append(dt.Rows[i][0].ToString() + ",");
            }
            return sb.ToString();
        }
        #endregion

        #region 查询下级及所有子级单位ID,name,Depth
        public string GetParentIDNameDepth(int id)
        {
            StringBuilder sb = new StringBuilder();
            DataTable dt = DbComponent.SQLHelper.ExecuteRead(CommandType.Text, "WITH lmenu(name,id,Depth,[ParentID]) as (SELECT name,id,Depth,[ParentID]  FROM [Entity] WHERE id=@id UNION ALL    SELECT A.NAME,A.id,A.Depth,A.ParentID FROM [Entity] A,lmenu b    where a.ParentID = b.[ID]) select id,name,Depth from lmenu", "getParentID", new SqlParameter("id", id));
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                sb.Append(dt.Rows[i][0].ToString() + "," + dt.Rows[i][1].ToString() + "," + dt.Rows[i][2].ToString() + ";");
            }
            return sb.ToString();
        }
        #endregion

        #region 查询数据库
        public static DataTable ExecuteRead(SqlConnection conn, string cmdText, string tableName)
        {
            SqlDataAdapter dr = new SqlDataAdapter(cmdText, conn);
            DataSet ds = new DataSet();
            dr.Fill(ds, tableName);
            return ds.Tables[0];
        }
        public static DataTable ExecuteReadconn(string cmdText, string tableName)
        {
            SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["m_connectionString"]);
            conn.Open();
            SqlDataAdapter dr = new SqlDataAdapter(cmdText, conn);
            DataSet ds = new DataSet();
            dr.Fill(ds, tableName);
            conn.Close();
            return ds.Tables[0];
        }
        #endregion

        #region 根据ID查询该单位的所有上级单位(包含表名、字段名、单位名、父单位名)
        public string GetAllParentById(int id)
        {
            SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["m_connectionString"]);
            conn.Open();
            int EntityDepth = 10;
            int EntityId = id;
            string AllParentIDbyId = "";
            while (EntityDepth != -1)
            { 
                String sqlParentID = "select ParentID,Depth from Entity where id =" + EntityId;
                DataTable dt01 = ExecuteRead(conn, sqlParentID, "AllParentId");
                AllParentIDbyId += "Entity" + "," + "ParentID" + "," + EntityId.ToString() + "," + dt01.Rows[0][0] + ";";
                EntityId = Convert.ToInt32(dt01.Rows[0][0]);
                EntityDepth = Convert.ToInt32(dt01.Rows[0][1]);
            }
            conn.Close();
            return AllParentIDbyId;
        }
        #endregion

        #region 根据ID查询该单位的所有上级单位(包含自己和所有父亲单位的ID)
        public string GetAllParentsID(int id)
        {
            SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["m_connectionString"]);
            conn.Open();
            int EntityDepth = 10;
            int EntityId = id;
            string AllParentsID = id.ToString() + ",";
            while (EntityDepth != -1)
            {
                String sqlParentID = "select ParentID,Depth from Entity where id =" + EntityId;
                DataTable dt01 = ExecuteRead(conn, sqlParentID, "AllParentId");
                AllParentsID += dt01.Rows[0][0] + ",";
                EntityId = Convert.ToInt32(dt01.Rows[0][0]);
                EntityDepth = Convert.ToInt32(dt01.Rows[0][1]);
            }
            conn.Close();
            return AllParentsID;
        }
        #endregion

        #region 根据Id判断某一单位是否为自己或下级单位
        protected int IsSelfBranch(String EntityId)
        {
            int IsSelfBranch = 0;
            for (int i = 0; i < DisptchChildren.Length - 1; i++)
            {
                if (EntityId == DisptchChildren[i])
                {
                    IsSelfBranch = 1;
                    return IsSelfBranch;
                }
            }
            return IsSelfBranch;
        }
        #endregion

        #region 根据Id判断某一单位是否为自己或上级单位
        protected int IsSelfParents(string EntityId)
        {
            int IsSelfParents = 0;
            for (int i = 0; i < DisptchParents.Length - 1; i++)
            {
                if (EntityId == DisptchParents[i])
                {
                    IsSelfParents = 1;
                    return IsSelfParents;
                }
            }
            return IsSelfParents;
        }
        #endregion

        #region 判断是否为超级用户
        public Boolean IsSuperUser(int entityid)
        {
            DbComponent.Entity entity = new DbComponent.Entity();
            int entity_depth = entity.GetEntityIndex(entityid);
            if (entity_depth == -1)
            {
                return true;
            }
            else
            {
                return false;
            }
        }
        #endregion
    }
}
