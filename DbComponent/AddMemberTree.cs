using Ryu666.Components;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace DbComponent
{
    public class AddMemberTree
    {
        private string cookiesid { set; get; }
        private string[] newarr { set; get; }

        #region 构造树形结构 初始化ID和类别
        public AddMemberTree(string cookid, string[] myarr)
        {
            cookiesid = cookid;
            newarr = myarr;
        }
        #endregion

        #region 生成根级单位，触发生成下级
        public void createtreebegion(TreeView TreeView1)
        {

            TreeNode nodes;
            
            DataTable dt = (SQLHelper.ExecuteRead(CommandType.Text, string.Format("SELECT name,id  FROM [Entity] where Depth ={0}",cookiesid), "tree1"));
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                nodes = new TreeNode();
                string unit = ResourceManager.GetString("Lang_Unit");
                //nodes.Text = "<div style='width:100%;display:inline;overflow:hidden;' onmouseover=\"changebgcolor(this,'" + dt.Rows[i][1].ToString() + "','单位',0)\" onmouseout='backcolor(this)'  >" + dt.Rows[i][0].ToString() + "</div>";
                nodes.Text = "<div style='width:100%;display:inline;overflow:hidden;' onmouseover=\"changebgcolor(this,'" + dt.Rows[i][1].ToString() + "','"+unit+"',0)\" onmouseout='backcolor(this)'  >" + dt.Rows[i][0].ToString() + "</div>";
                nodes.Value = dt.Rows[i][1].ToString();
                nodes.SelectAction = TreeNodeSelectAction.None;
                TreeView1.Nodes.Add(nodes);
                CreateTreeBJ_user_trafic(nodes.ChildNodes, dt.Rows[i][1].ToString());//生成编组，警员，设备
                CreateTreeViewRecursive(nodes.ChildNodes, dt.Rows[i][1].ToString());//生成下级单位

            }

        }
        #endregion

        #region 循环生成下级单位
        protected void CreateTreeViewRecursive(TreeNodeCollection nodes, string parentid)
        {
            DbComponent.Entity dbentity = new DbComponent.Entity();
            TreeNode newnodes;
            DataTable dt = (SQLHelper.ExecuteRead(CommandType.Text, "select Name,id from Entity where ParentID = @parentid", parentid, new SqlParameter("parentid", parentid)));
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                bool secondentity = dbentity.GetEntityIndex(int.Parse(dt.Rows[i][1].ToString())) == 1 ? true : false;//判断二级单位
                bool ISparent = dbentity.IsParentA_B(int.Parse(dt.Rows[i][1].ToString()), int.Parse(cookiesid)) > 0 ? true : false;//直属上级单位
                bool ISbroth = dbentity.IsbrothA_B(int.Parse(dt.Rows[i][1].ToString()), int.Parse(cookiesid)) > 0 ? true : false; //同一父级兄弟单位
                bool ISchildORMyself = dbentity.IsParentA_B(int.Parse(cookiesid), int.Parse(dt.Rows[i][1].ToString())) > 0 ? true : false;//自己或者是下级单位
                if (secondentity || ISparent || ISbroth || ISchildORMyself)
                {
                    newnodes = new TreeNode();
                    newnodes.Value = dt.Rows[i][1].ToString();
                    string unit = ResourceManager.GetString("Lang_Unit");
                    //newnodes.Text = "<div style='width:100%;display:inline;overflow:hidden;' onmouseover=\"changebgcolor(this,'" + dt.Rows[i][1].ToString() + "','单位',0)\" onmouseout='backcolor(this)' >" + dt.Rows[i][0].ToString() + "</div>";
                    newnodes.Text = "<div style='width:100%;display:inline;overflow:hidden;' onmouseover=\"changebgcolor(this,'" + dt.Rows[i][1].ToString() + "','"+unit+"',0)\" onmouseout='backcolor(this)' >" + dt.Rows[i][0].ToString() + "</div>";


                    newnodes.SelectAction = TreeNodeSelectAction.None;
                    nodes.Add(newnodes);
                    if (ISchildORMyself) { CreateTreeBJ_user_trafic(newnodes.ChildNodes, dt.Rows[i][1].ToString()); }//自己或者是下级单位
                    CreateTreeViewRecursive(newnodes.ChildNodes, dt.Rows[i][1].ToString());//循环生成下级单位
                }
            }
        }
        #endregion

        #region 生成设备目录
        protected void CreateTreeBJ_user_trafic(TreeNodeCollection nodes, string entityid)
        {
            TreeNode newnodes;
            string[] arrs = newarr;

            foreach (string arr in arrs)
            {
                string strText = "";
                if (arr == MyModel.Enum.TreeType.Group.ToString())
                {
                    strText = ResourceManager.GetString("Group");
                }
                else
                    if (arr == MyModel.Enum.TreeType.ISSI.ToString())
                    {
                        strText = ResourceManager.GetString("Terminal");
                    }
                    else
                        if (arr == MyModel.Enum.TreeType.Dispatch.ToString())
                        {
                            strText = ResourceManager.GetString("Dispatch");
                        }
                        else
                        {
                            strText = arr;
                        }
                newnodes = new TreeNode();
                newnodes.Text = "<div style='width:100%;height:20px;display:inline;overflow:hidden;' onmouseover=\"changebgcolor(this,'" + entityid + "','" + strText + "',1)\" onmouseout='backcolor(this)'  >" + strText + "</div>";
                newnodes.Value = arr;
                newnodes.SelectAction = TreeNodeSelectAction.None;
                nodes.Add(newnodes);
                CreateTreeneir(newnodes.ChildNodes, arr, entityid);
            }
        }
        #endregion

        #region 判断不同的内容 准备生成最后内容的SQL语句
        protected void CreateTreeneir(TreeNodeCollection nodes, string type, string entityid)
        {
            TreeNode newnodes;
            string sql = null;
            string sqltable = null;
            if (type == MyModel.Enum.TreeType.Group.ToString())//编组
            {
                type = ResourceManager.GetString("Group");
                string[] arrs = { ResourceManager.GetString("smallGroup"), ResourceManager.GetString("multicastgroup"), ResourceManager.GetString("dxgroup"), ResourceManager.GetString("dtgroup") };
                foreach (string arr in arrs)
                {
                    newnodes = new TreeNode();
                    newnodes.Value = arr;

                    if (arr == ResourceManager.GetString("smallGroup"))//小组
                    {
                        sql = "SELECT  [ID],[Group_name],'manager_Group',[GSSI] FROM [Group_info] where LEN(GSSIS) <2 and Entity_ID =@Entity_ID";
                        newnodes.Text = "<div style='width:100%;height:20px;display:inline;overflow:hidden;' onmouseover=\"changebgcolor(this,'" + entityid + "','" + arr + "',1)\" onmouseout='backcolor(this)' >" + arr + "</div>";
                        sqltable = "Group_info";
                    }
                    else if (arr == ResourceManager.GetString("multicastgroup"))//通播组
                    {
                        sql = "SELECT  [ID],[Group_name],'manager_TBGroup',[GSSI] FROM [Group_info] where LEN(GSSIS) >2 and Entity_ID =@Entity_ID";
                        newnodes.Text = "<div style='width:100%;height:20px;display:inline;overflow:hidden;' onmouseover=\"changebgcolor(this,'" + entityid + "','" + arr + "',1)\" onmouseout='backcolor(this)' >" + arr + "</div>";
                        sqltable = "Group_info";
                    }
                    else if (arr == ResourceManager.GetString("dxgroup"))//多选组
                    {

                    }
                    else if (arr == ResourceManager.GetString("dtgroup"))//动态重组组
                    {
                        sql = "SELECT  [ID],[Group_name],'manager_DTGroup',[GSSI] FROM [DTGroup_info] where Entity_ID =@Entity_ID";
                        newnodes.Text = "<div style='width:100%;height:20px;display:inline;overflow:hidden;' onmouseover=\"changebgcolor(this,'" + entityid + "','" + arr + "',1)\" onmouseout='backcolor(this)'  >" + arr + "</div>";
                        sqltable = "DTGroup_info";
                    }
                    else
                    {

                    }

                    newnodes.SelectAction = TreeNodeSelectAction.None;
                    nodes.Add(newnodes);
                    CreateTree_sql(newnodes.ChildNodes, sql, entityid, arr, sqltable);
                }
            }
            else if (type == MyModel.Enum.TreeType.ISSI.ToString())//终端
            {
                type = ResourceManager.GetString("Terminal");
                sql = "SELECT  [ID],[ISSI],'manager_ISSI',[ISSI] FROM [ISSI_info] where Entity_ID =@Entity_ID";
                sqltable = "ISSI_info";
                CreateTree_sql(nodes, sql, entityid, type, sqltable);
            }
            else if (type == MyModel.Enum.TreeType.Dispatch.ToString())//调度台
            {
                type = ResourceManager.GetString("Dispatch");
                sql = "SELECT  [ID],[ISSI],'manager_Dispatch',[ISSI] FROM [Dispatch_Info] where ISSI is not null and Entity_ID =@Entity_ID";
                sqltable = "Dispatch_Info";
                CreateTree_sql(nodes, sql, entityid, type, sqltable);
            }
            else
            {
                sql = "SELECT  [ID],[Nam],'manager_user',[ISSI] FROM [User_info] where ISSI <> '' and Entity_ID =@Entity_ID and type = '" + type + "'";
                sqltable = "User_info";
                CreateTree_sql(nodes, sql, entityid, type, sqltable);
            }


        }
        #endregion

        #region 建立最后树形内容
        protected void CreateTree_sql(TreeNodeCollection nodes, string sql, string entityid, string type, string sqltable)
        {

            TreeNode newnodes;
            DataTable dt = DbComponent.SQLHelper.ExecuteRead(CommandType.Text, sql, "treetable", new SqlParameter("Entity_ID", entityid));
            string width = null, height = null;
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                newnodes = new TreeNode();
                newnodes.SelectAction = TreeNodeSelectAction.None;
                switch (dt.Rows[i][2].ToString())
                {
                    case "manager_Group":
                    case "manager_TBGroup":
                    case "manager_DXGroup":
                    case "manager_DTGroup":
                        width = "674"; height = "354";
                        newnodes.Text = treetext(width, height, dt.Rows[i][2].ToString(), dt.Rows[i][0].ToString(), dt.Rows[i][1].ToString(), type, sqltable, dt.Rows[i][3].ToString());
                        break;
                    case "manager_user":
                        width = "590"; height = "370";
                        newnodes.Text = treetext(width, height, dt.Rows[i][2].ToString(), dt.Rows[i][0].ToString(), dt.Rows[i][1].ToString(), type, sqltable, dt.Rows[i][3].ToString());
                        break;
                    case "manager_ISSI":
                        width = "880"; height = "354";
                        newnodes.Text = treetext(width, height, dt.Rows[i][2].ToString(), dt.Rows[i][0].ToString(), dt.Rows[i][1].ToString(), type, sqltable, dt.Rows[i][3].ToString());
                        break;
                    case "manager_Dispatch":
                        width = "880"; height = "354";
                        newnodes.Text = treetext(width, height, dt.Rows[i][2].ToString(), dt.Rows[i][0].ToString(), dt.Rows[i][1].ToString(), type, sqltable, dt.Rows[i][3].ToString());
                        break;

                    default:
                        break;
                }
                newnodes.Value = dt.Rows[i][0].ToString();

                nodes.Add(newnodes);
            }

        }
        #endregion

        protected string treetext(string width, string height, string urlcase, string urlid, string value, string type, string sqltable, string issi)
        {
            string returntext = null;
            switch (urlcase)
            {
                case "manager_user":
                    userinfo usinf = new userinfo();
                    int useissi = usinf.UserISSI_byid(int.Parse(urlid));
                    returntext = (useissi > 0) ? "<a style='width:9px;height:16px;background-image:url(../../img/treebutton.gif)'></a>" : "<a style='width:9px;height:16px;background-image:url(../img/treebutton.gif);background-position:-10 0;'></a>";
                    usinf = null;
                    break;
                case "manager_ISSI":
                    break;

                default:
                    break;
            }

            return "<div id='div" + issi + "' style='width:100%;height:20px;display:inline;overflow:hidden;' onmouseover=\"changebgcolor(this,'" + urlid + "','" + type + "',2)\" onmouseout='backcolor(this)'  >" + value + returntext + "</div>";
        }
    }
}
