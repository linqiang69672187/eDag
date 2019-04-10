using DbComponent;
using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;
using Ryu666.Components;

namespace Web.lqnew.opePages.BaseStationPicker
{
    public partial class ISSI_tree : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
            if (!Page.IsPostBack)
            {
                //TreeNode nodes;
                //DataTable dt = (SQLHelper.ExecuteRead(CommandType.Text, "SELECT name,id  FROM [Entity] where Depth =0", "tree1"));
                //for (int i = 0; i < dt.Rows.Count; i++)
                //{
                //    nodes = new TreeNode();
                //    nodes.Text = dt.Rows[i][0].ToString();
                //    nodes.Value = dt.Rows[i][1].ToString();
                //    nodes.SelectAction = TreeNodeSelectAction.None;
                //    TreeView1.Nodes.Add(nodes);
                //    //生成基站
                //    CreateTreeBJ_user_trafic(nodes.ChildNodes, dt.Rows[i][1].ToString());
                   
                //   // CreateTreeViewRecursive(nodes.ChildNodes, dt.Rows[i][1].ToString());//生成下级单位

                //}
                //xzj--20190218--注释上部分所有一级单位都加载一次所有基站,可能会有多个一级单位出现问题，改为固定只加载一次所有基站
                TreeNode nodes;                 
                nodes = new TreeNode();
                nodes.Text = ResourceManager.GetString("Station");
                nodes.Value = "root";
                nodes.SelectAction = TreeNodeSelectAction.None;
                TreeView1.Nodes.Add(nodes);
                //生成基站
                CreateTreeBJ_user_trafic(nodes.ChildNodes, "root");
                
            }
         
        }
        #region 循环生成下级单位
        protected void CreateTreeViewRecursive(TreeNodeCollection nodes, string parentid)
        {
            DbComponent.Entity dbentity = new DbComponent.Entity();
            TreeNode newnodes;
            DataTable dt = (SQLHelper.ExecuteRead(CommandType.Text, "select Name,id from Entity where ParentID = @parentid", parentid, new SqlParameter("parentid", parentid)));
            string unit = ResourceManager.GetString("Lang_Unit");
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                newnodes = new TreeNode();
                newnodes.Value = dt.Rows[i][1].ToString();
                // newnodes.Text = "<div style='width:100%;display:inline;overflow:hidden;' onmouseover=changebgcolor(this,'" + dt.Rows[i][1].ToString() + "','单位',0) onmouseout='backcolor(this)' >" + dt.Rows[i][0].ToString() + "</div>";
                newnodes.Text = "<div style='width:100%;display:block;overflow:hidden;' onmouseover=changebgcolor(this,'" + dt.Rows[i][1].ToString() + "','" + unit + "',0) onmouseout='backcolor(this)' >" + dt.Rows[i][0].ToString() + "</div>";

                newnodes.SelectAction = TreeNodeSelectAction.None;
                nodes.Add(newnodes);
               // if (ISchildORMyself) { CreateTreeBJ_user_trafic(newnodes.ChildNodes, dt.Rows[i][1].ToString()); }//自己或者是下级单位
                CreateTreeViewRecursive(newnodes.ChildNodes, dt.Rows[i][1].ToString());//循环生成下级单位
            }
        }
        #endregion

        protected void CreateTreeBJ_user_trafic(TreeNodeCollection nodes, string entityid)
        {
            TreeNode newnodes;
            DataTable dt=SQLHelper.ExecuteRead(CommandType.Text,"  select * from BaseStation_info ","fdsfdsfdsfds");
      
            foreach (DataRow dr in dt.Rows)//xzj--20181217--添加交换
            {
                newnodes = new TreeNode();
                newnodes.Text = "<div style='width:100%;height:20px;display:block;overflow:hidden;' onmouseover=changebgcolor(this,"+dr["SwitchID"].ToString()+",'" + dr["StationISSI"].ToString() + "','" + dr["StationName"].ToString() + "') onmouseout='backcolor(this)'  >" + dr["StationName"].ToString() + "</div>";
                newnodes.Value = dr["SwitchID"].ToString() + "," + dr["StationISSI"].ToString();
                newnodes.SelectAction = TreeNodeSelectAction.None;
                nodes.Add(newnodes);
            }
        }

    }
}