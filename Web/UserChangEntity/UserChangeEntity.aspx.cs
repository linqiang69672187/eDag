using DbComponent;
using Ryu666.Components;
using System;
using System.Data;
using System.Data.SqlClient;
using System.Transactions;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Web.lqnew.opePages
{
    public partial class UserChangeEntity : System.Web.UI.Page
    {
        public String ScrollValue;
        private string ContentChanged = "", AfterParentID = "";
        String[] SelfChildren;
        string Username;
        public int dispatchentityid;
        protected void Page_Load(object sender, EventArgs e)
        {
            dispatchentityid = int.Parse(Request.Cookies["id"].Value);
            Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>LanguageSwitch(window.parent.parent);</script>");

            Button1.Text = ResourceManager.GetString("Lang_Ok");
            Button2.Text = ResourceManager.GetString("Lang_Cancel");

            Label1.Text = ""; //清空操作结果状态指示标签
            //Label1.Text = "OperateUserEntity" + Request.Cookies["username"].Value;

            //获取调度台所在单位所有的下级单位Id
            DbComponent.UChangeETree MyUserTree = new DbComponent.UChangeETree();
            String AllSelfChild = MyUserTree.GetParentID(int.Parse(Request.Cookies["id"].Value));  //获取调度台单位的所有下级单位
            SelfChildren = AllSelfChild.Split(',');

            Username = Request.Cookies["username"].Value;
            if (!Page.IsPostBack)
            {
                InitTree();
                //ExpandSelf();
            }
        }

        #region TreeView回响记住滚动条位置
        //TreeView回响记住滚动条位置
        protected void TreeView_Left_SelectedNodeChanged(object sender, EventArgs e)
        {
            ScrollValue = divScrollValue.Value; //将div滚动条位置写入全局变量
            //判断选中单位是否是自己的下级单位
            IsSelfBranch(TreeView_Left);
            if (TreeView_Left.SelectedNode!= null && TreeView_Left.SelectedNode.Parent == null)
            {
                //判断是否为超级用户
                DbComponent.UChangeETree MyUserTree1 = new DbComponent.UChangeETree();
                if (MyUserTree1.IsSuperUser(dispatchentityid))
                {
                    return;
                }
                else
                {
                    Response.Write("<script type='text/javascript'>window.alert(\"" + ResourceManager.GetString("Lang_Cannottransferself") + "\")</script>");
                    TreeView_Left.SelectedNode.Selected = false;         
                    return;
                }
            }
        }

        protected void TreeView_Right_SelectedNodeChanged(object sender, EventArgs e)
        {
            ScrollValue = divScrollValue.Value;
              //判断是否为超级用户
            DbComponent.UChangeETree MyUserTree = new DbComponent.UChangeETree();
            if (MyUserTree.IsSuperUser(dispatchentityid))
            { 
                return;
            }
            //判断选中单位是否是自己的下级单位
            IsSelfBranch(TreeView_Right);
        }
        #endregion

        #region 判断选中的单位是否为自己的下级单位
        protected void IsSelfBranch(TreeView TreeView_IsSelfBranch)
        {
            //获取选中项的Id
            String SelectValue = TreeView_IsSelfBranch.SelectedValue;
            String[] SelectIdDepth = SelectValue.Split(',');
            String SelectId = SelectIdDepth[0];
            //判断选中单位是否是自己的下级单位
            int IsSelfBranch = 0;
            for (int i = 0; i < SelfChildren.Length - 1; i++)
            {
                if (SelectId == SelfChildren[i])
                {
                    IsSelfBranch = 1;
                    return;
                }
            }
            if (IsSelfBranch == 0)
            {
                Response.Write("<script type='text/javascript'>window.alert('" + ResourceManager.GetString("Lang_NotSubordinateEntity") + "')</script>");
                TreeView_IsSelfBranch.SelectedNode.Selected = false;
            }
        }
        #endregion

        //执行转组操作
        protected void Button1_Click(object sender, EventArgs e)
        {
            Label1.Text = ""; //清空操作结果状态指示标签

            TreeNode TreeNodeL = TreeView_Left.SelectedNode;
            String EntityLParent = "";
            String[] IdDepthLParent = null;
            //TreeNode TreeNodeR = TreeView_Right.SelectedNode;
            if (TreeNodeL != null)
            {
                if (TreeNodeL.Parent != null)
                {
                    EntityLParent = TreeNodeL.Parent.Value;
                    IdDepthLParent = EntityLParent.Split(',');
                }
            }
            else
            {
                Label1.Text = "<img src='../lqnew/images/isinviewno.png'/>" + ResourceManager.GetString("Lang_SelectLsft");
                RadioButton_N.Checked = false;
                RadioButton_Y.Checked = false;
                return;
            }
            String EntityL = TreeView_Left.SelectedValue;
            String[] IdDepthL = EntityL.Split(',');
            String SourceParentID = "";
            if (TreeView_Left.SelectedNode.Parent != null)
            {
                SourceParentID = TreeView_Left.SelectedNode.Parent.Value.Split(',')[0];
            }
                
            String EntityR = TreeView_Right.SelectedValue;
            String[] IdDepthR = EntityR.Split(',');
            if (EntityL == "")
            {
                //Response.Write("<script>alert('请选中转移单位')</script>");
                Label1.Text = "<img src='../lqnew/images/isinviewno.png'/>" + ResourceManager.GetString("Lang_SelectLsft");
                RadioButton_N.Checked = false;
                RadioButton_Y.Checked = false;
                return;
            }
            if (EntityR == "")
            {
                //Response.Write("<script>alert('请选中目标单位')</script>");
                Label1.Text = "<img src='../lqnew/images/isinviewno.png'/>" + ResourceManager.GetString("Lang_SelectRight");
                //Response.Write("<img src='../lqnew/images/isinviewno.png'/>");
                RadioButton_N.Checked = false;
                RadioButton_Y.Checked = false;
                return;
            }

            int IdLeft = int.Parse(IdDepthL[0].Trim());
            int Depthleft = int.Parse(IdDepthL[1].Trim());
            int IdRight = int.Parse(IdDepthR[0].Trim());
            int DepthRight = int.Parse(IdDepthR[1].Trim());
            //Response.Write(IdLeft);

            //获取选中单位所有的下级单位Id
            DbComponent.UChangeETree MyUserTree = new DbComponent.UChangeETree();
            String AllChild = MyUserTree.GetParentID(IdLeft);  //获取选中单位的所有下级单位
            String[] Children = AllChild.Split(',');
            //Response.Write(AllChild);

            //判断右边选中单位是否为左边选中单位的下级单位
            for (int k = 1; k < Children.Length - 1; k++)
            {
                if (IdDepthR[0] == Children[k])
                {
                    Label1.Text = "<img src='../lqnew/images/isinviewno.png'/>" + ResourceManager.GetString("Lang_TargetCannotSourceSub");
                    return;
                }
            }

            //定义转组历史记录UserChangelog表变量
            String FromEntity = IdDepthL[0], ToEntity = IdDepthR[0], OperateUser = Username;
            int IsSelf = 0;
            //事务过期时间
            //int ShiwuTimeoutSeconds = 100;
            if (EntityL != EntityR)
            {
                #region 如果转移本单位编制
                if (RadioButton_Y.Checked)
                {                   
                    IsSelf = 1;
                    #region 如果深度之差不为1
                    //如果深度之差不为1
                    if ((Depthleft - DepthRight) != 1)
                    {
                        int L = Children.Length;
                        int j = Depthleft - DepthRight;
                        //事务回滚
                        using (TransactionScope scope = new TransactionScope())
                        {
                            try
                            {
                                SqlConnection ConnUser = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["m_connectionString"]);
                                ConnUser.Open();
                                SqlCommand cmd = new SqlCommand();
                                cmd.Connection = ConnUser;

                                //查询转移单位原来的ParentID
                                String sqlChaxun1 = "select ParentID from Entity where ID = " + IdLeft;
                                DataTable dt = DbComponent.UChangeETree.ExecuteRead(ConnUser, sqlChaxun1, "GetParentID");

                                //修改本单位的ParentID
                                String sql1 = "update Entity set ParentID = '" + IdDepthR[0] + "' where ID = " + IdLeft;
                                cmd.CommandText = sql1;
                                cmd.ExecuteNonQuery();
                                //记录修改的内容
                                ContentChanged += "Entity" + "," + "parentID" + "," + dt.Rows[0][0] + "," + IdDepthR[0] + "," + IdDepthL[0] + ";";

                                //修改本单位及所有子单位的Depth,查询所有单位的ParentID            
                                for (int i = 0; i < L - 1; i++)
                                {
                                    int Id = int.Parse(Children[i]);
                                    //读取本单位及所有下级单位的ParentID和Depth
                                    String sql12 = "select ParentID, Depth from Entity where ID = " + Id;
                                    DataTable dt1 = DbComponent.UChangeETree.ExecuteRead(ConnUser, sql12, "GetParAndId");
                                    String AfterDepth = Convert.ToString(Convert.ToInt32(dt1.Rows[0][1]) - (j - 1));

                                    String sql = "update Entity set Depth = convert(varchar,(convert(int,Depth) - (" + j + "-1))) where ID = " + Id;
                                    cmd.CommandText = sql;
                                    cmd.ExecuteNonQuery();

                                    ContentChanged += "Entity" + "," + "Depth" + "," + dt1.Rows[0][1] + "," + AfterDepth + "," + Children[i] + ";";
                                    AfterParentID += "Entity" + "," + "ParentID" + "," + Children[i] + "," + dt1.Rows[0][0] + ";";
                                }
                                //获取目标单位之上的所有父单位
                                DbComponent.UChangeETree MyUserTree11 = new DbComponent.UChangeETree();
                                String AboveParents = MyUserTree11.GetAllParentById(IdRight);
                                AfterParentID += AboveParents;

                                //将历史记录写入UserChangeLog表
                                String sqlinsertLog = "INSERT INTO UserChangeLog (FromEntity,SourceParentID,ToEntity,IsSelf,ContentChanged,OperateUser,AfterParentID) VALUES (" + "'" + FromEntity + "'" + "," + "'" + SourceParentID + "'" + "," + "'" + ToEntity + "'" + "," + IsSelf + "," + "'" + ContentChanged + "'" + "," + "'" + OperateUser + "'" + "," + "'" + AfterParentID + "'" + ")";
                                cmd.CommandText = sqlinsertLog;
                                cmd.ExecuteNonQuery();

                                ConnUser.Close();//关闭数据库连接
                                Label1.Text = "<img src='../lqnew/images/isinviewyes.png'/>" + "<span style = 'Color:green'>" + ResourceManager.GetString("OperationSuccessful") + "</span>";
                                
                            }
                            catch (Exception ex)
                            {
                                Response.Write(ex);
                                //log.Error(ex);
                                Label1.Text = "<img src='../lqnew/images/isinviewno.png'/>" + ResourceManager.GetString("Operationfails");
                            }
                            finally
                            {
                                scope.Complete();
                            }
                        }
                        InitTree();
                        if (IdDepthLParent != null)
                        {
                            FindInTreeAfter(TreeView_Left, IdDepthLParent[0], "Left1");                            
                        }
                        FindInTreeAfter(TreeView_Right, IdDepthL[0], "Right");
                        return;
                    }
                    #endregion

                    #region 如果深度之差为1
                    //如果深度之差为1
                    else
                    {
                        int L = Children.Length;
                        int j = Depthleft - DepthRight;
                        //事务回滚                        
                        using (TransactionScope scope = new TransactionScope())
                        {
                            try
                            {
                                SqlConnection ConnUser = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["m_connectionString"]);
                                ConnUser.Open();

                                //判断右边选中单位是否为左边选中单位的父亲单位
                                String sqlIsParent = "select ParentID from Entity where ID = " + IdLeft;
                                DataTable dtIsParent = DbComponent.UChangeETree.ExecuteRead(ConnUser, sqlIsParent, "IsParent11");
                                string SelectParentID = Convert.ToString(dtIsParent.Rows[0][0]);
                                if (IdDepthR[0] == SelectParentID)
                                {
                                    Label1.Text = "<img src='../lqnew/images/isinviewno.png'/>" + ResourceManager.GetString("Lang_TheTargetUintIsTheParentUintTranferUint");
                                    return;
                                }

                                //修改本单位的ParentID
                                SqlCommand cmd = new SqlCommand();
                                cmd.Connection = ConnUser;

                                //查询转移单位原来的ParentID
                                String sqlChaxun1 = "select ParentID from Entity where ID = " + IdLeft;
                                DataTable dt = DbComponent.UChangeETree.ExecuteRead(ConnUser, sqlChaxun1, "GetParentID");
                                //修改本单位的ParentID
                                String sql1 = "update Entity set ParentID = '" + IdDepthR[0] + "' where ID = " + IdLeft;
                                cmd.CommandText = sql1;
                                cmd.ExecuteNonQuery();

                                //记录修改的内容,记录所有单位的ParentID
                                ContentChanged += "Entity" + "," + "parentID" + "," + dt.Rows[0][0] + "," + IdDepthR[0] + "," + IdDepthL[0] + ";";
                                for (int i = 0; i < L - 1; i++)
                                {
                                    int Id = int.Parse(Children[i]);
                                    String sql12 = "select ParentID from Entity where ID = " + Id;
                                    DataTable dt1 = DbComponent.UChangeETree.ExecuteRead(ConnUser, sql12, "GetParAndId");
                                    AfterParentID += "Entity" + "," + "ParentID" + "," + Children[i] + "," + dt1.Rows[0][0] + ";";
                                }
                                //获取目标单位之上的所有父单位
                                DbComponent.UChangeETree MyUserTree11 = new DbComponent.UChangeETree();
                                String AboveParents = MyUserTree11.GetAllParentById(IdRight);
                                AfterParentID += AboveParents;

                                //将历史记录写入UserChangeLog表
                                String sqlinsertLog = "INSERT INTO UserChangeLog (FromEntity,SourceParentID,ToEntity,IsSelf,ContentChanged,OperateUser,AfterParentID) VALUES (" + "'" + FromEntity + "'" + "," + "'" + SourceParentID + "'" + "," + "'" + ToEntity + "'" + "," + IsSelf + "," + "'" + ContentChanged + "'" + "," + "'" + OperateUser + "'" + "," + "'" + AfterParentID + "'" + ")";
                                cmd.CommandText = sqlinsertLog;
                                cmd.ExecuteNonQuery();

                                ConnUser.Close();//关闭数据库连接
                                Label1.Text = "<img src='../lqnew/images/isinviewyes.png'/>" + "<span style = 'Color:green'>" + ResourceManager.GetString("OperationSuccessful") + "</span>";
                                
                            }
                            catch (Exception ex)
                            {
                                Response.Write(ex);
                                Label1.Text = "<img src='../lqnew/images/isinviewno.png'/>" + ResourceManager.GetString("Operationfails");
                            }
                            finally
                            {
                                scope.Complete();
                            }
                        }
                        InitTree();
                        if (IdDepthLParent != null)
                        {
                            FindInTreeAfter(TreeView_Left, IdDepthLParent[0], "Left1");
                        }
                        FindInTreeAfter(TreeView_Right, IdDepthL[0], "Right");
                        return;
                    }
                    #endregion
                }
                #endregion

                #region 如果不转移本单位编制
                if (RadioButton_N.Checked)
                {
                    #region 如果深度之差不为0
                    //如果深度之差不为0
                    int L = Children.Length;
                    if ((Depthleft - DepthRight) != 0)
                    {
                        int j = Depthleft - DepthRight;
                        using (TransactionScope scope = new TransactionScope())
                        {
                            try
                            {
                                SqlConnection ConnUser = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["m_connectionString"]);
                                ConnUser.Open();
                                SqlCommand cmd = new SqlCommand();
                                cmd.Connection = ConnUser;

                                //修改直属警员的Etity_ID，修改直属单位的ParentID
                                EditZhishuJingyuan(cmd, ConnUser, IdDepthL, IdDepthR);

                                ////如果有下级单位，修改直属单位及所有次级单位的Depth,查询所有下级单位的ParentID
                                if (L > 2)
                                {
                                    for (int i = 1; i < L - 1; i++)
                                    {
                                        int Id = int.Parse(Children[i]);
                                        //查询直属单位和所有次级单位的ParentID，Depth
                                        String sql22 = "select ParentID, Depth from Entity where ID =" + Id;
                                        DataTable dt22 = DbComponent.UChangeETree.ExecuteRead(ConnUser, sql22, "GetParAndId22");

                                        String sql = "update Entity set Depth = convert(varchar,(convert(int,Depth) - " + j + ")) where ID = " + Id;
                                        cmd.CommandText = sql;
                                        cmd.ExecuteNonQuery();

                                        //记录所有下级单位的修改内容和parentID                                    
                                        String AfterDepth = Convert.ToString(Convert.ToInt32(dt22.Rows[0][1]) - j);
                                        ContentChanged += "Entity" + "," + "Depth" + "," + dt22.Rows[0][1] + "," + AfterDepth + "," + Children[i] + ";";
                                        AfterParentID += "Entity" + "," + "ParentID" + "," + Children[i] + "," + dt22.Rows[0][0] + ";";
                                    }
                                }
                                //获取目标单位之上的所有父单位
                                DbComponent.UChangeETree MyUserTree11 = new DbComponent.UChangeETree();
                                String AboveParents = MyUserTree11.GetAllParentById(IdRight);
                                AfterParentID += AboveParents;
                                //判断单位下面是否有单位或用户
                                if (ContentChanged == "")
                                {
                                    Label1.Text = ResourceManager.GetString("Lang_TheUnitHaveNoNextUnitToChange");
                                    return;
                                }
                                //将历史记录写入UserChangeLog表
                                String sqlinsertLog = "INSERT INTO UserChangeLog (FromEntity,SourceParentID,ToEntity,IsSelf,ContentChanged,OperateUser,AfterParentID) VALUES (" + "'" + FromEntity + "'" + "," + "'" + SourceParentID + "'" + "," + "'" + ToEntity + "'" + "," + IsSelf + "," + "'" + ContentChanged + "'" + "," + "'" + OperateUser + "'" + "," + "'" + AfterParentID + "'" + ")";
                                cmd.CommandText = sqlinsertLog;
                                cmd.ExecuteNonQuery();

                                ConnUser.Close();
                                Label1.Text = "<img src='../lqnew/images/isinviewyes.png'/>" + "<span style = 'Color:green'>" + ResourceManager.GetString("OperationSuccessful") + "</span>";
                                
                            }
                            catch (Exception ex)
                            {
                                //log.Error(ex);
                                Response.Write(ex);
                                Label1.Text = "<img src='../lqnew/images/isinviewno.png'/>" + ResourceManager.GetString("Operationfails");//多语言：操作失败
                            }
                            finally
                            {
                                scope.Complete();
                            }
                        }
                        InitTree();
                        FindInTreeAfter(TreeView_Left, IdDepthL[0], "Left0");
                        FindInTreeAfter(TreeView_Right, IdDepthR[0], "Right");
                        return;
                    }
                    #endregion

                    #region 如果深度之差为0
                    //如果深度之差为0
                    else
                    {
                        using (TransactionScope scope = new TransactionScope())
                        {
                            try
                            {
                                SqlConnection ConnUser = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["m_connectionString"]);
                                ConnUser.Open();
                                SqlCommand cmd = new SqlCommand();
                                cmd.Connection = ConnUser;

                                //修改直属警员的单位（User_info,ISSI_info,Group,DTGroup_info,DXGroup_info）,修改直属单位的ParentID
                                EditZhishuJingyuan(cmd, ConnUser, IdDepthL, IdDepthR);

                                //如果有下级单位，查询并记录直属单位和所有次级单位的ParentID
                                if (L > 2)
                                {
                                    for (int i = 1; i < L - 1; i++)
                                    {
                                        int Id = int.Parse(Children[i]);
                                        //查询直属单位和所有次级单位的ParentID
                                        String sql33 = "select ParentID from Entity where ID =" + Id;
                                        DataTable dt33 = DbComponent.UChangeETree.ExecuteRead(ConnUser, sql33, "GetParAndId33");
                                        //记录所有下级单位的parentID
                                        AfterParentID += "Entity" + "," + "ParentID" + "," + Children[i] + "," + dt33.Rows[0][0] + ";";
                                    }
                                }
                                //获取目标单位之上的所有父单位
                                DbComponent.UChangeETree MyUserTree11 = new DbComponent.UChangeETree();
                                String AboveParents = MyUserTree11.GetAllParentById(IdRight);
                                AfterParentID += AboveParents;
                                //判断单位下面是否有单位或用户
                                if (ContentChanged == "")
                                {
                                    Label1.Text = ResourceManager.GetString("Lang_TheUnitHaveNoNextUnitToChange");
                                    return;
                                }
                                //将历史记录写入UserChangeLog表
                                String sqlinsertLog = "INSERT INTO UserChangeLog (FromEntity,SourceParentID,ToEntity,IsSelf,ContentChanged,OperateUser,AfterParentID) VALUES (" + "'" + FromEntity + "'" + "," + "'" + SourceParentID + "'" + "," + "'" + ToEntity + "'" + "," + IsSelf + "," + "'" + ContentChanged + "'" + "," + "'" + OperateUser + "'" + "," + "'" + AfterParentID + "'" + ")";
                                cmd.CommandText = sqlinsertLog;
                                cmd.ExecuteNonQuery();

                                ConnUser.Close();
                                Label1.Text = "<img src='../lqnew/images/isinviewyes.png'/>" + "<span style = 'Color:green'>" + ResourceManager.GetString("OperationSuccessful") + "</span>";
                                
                            }
                            catch (Exception ex)
                            {
                                //log.Error(ex);
                                Response.Write(ex);
                                Label1.Text = "<img src='../lqnew/images/isinviewno.png'/>" + ResourceManager.GetString("Operationfails");
                            }
                            finally
                            {
                                scope.Complete();
                            }
                        }
                        InitTree();
                        FindInTreeAfter(TreeView_Left, IdDepthL[0], "Left0");
                        FindInTreeAfter(TreeView_Right, IdDepthR[0], "Right");
                        return;
                    }
                    #endregion
                #endregion
                }

                #region 如果未选择是否转移本单位编制
                else
                {
                    //Response.Write("<script>alert('请选择是否转移本单位编制')</script>");
                    Label1.Text = "<img src='../lqnew/images/isinviewno.png'/>" + ResourceManager.GetString("Lang_PleaseChooseWhetherTransferTheUnitStaff");
                    return;
                }
                #endregion
            }
            else
            {
                Label1.Text = "<img src='../lqnew/images/isinviewno.png'/>" + ResourceManager.GetString("Lang_TargetCannotSourceSame");
            }
        }

        protected void Button2_Click(object sender, EventArgs e)
        {

        }

        protected void InitTree()
        {
            TreeView_Left.Nodes.Clear();
            TreeView_Right.Nodes.Clear();
            
            DbComponent.UChangeETree MyUserTree = new DbComponent.UChangeETree();
            MyUserTree.createtreebegion(TreeView_Left, int.Parse(Request.Cookies["id"].Value), Username);
            MyUserTree.createtreebegion(TreeView_Right, int.Parse(Request.Cookies["id"].Value), Username);

            RadioButton_N.Checked = false;
            RadioButton_Y.Checked = false;
        }

        #region 查找节点
        //根据NodeDate寻找节点
        private void FindInTreeAfter(TreeView TreeView1, string strNodeData, String str)
        {
            foreach (TreeNode tn in TreeView1.Nodes)
            {
                if (!(tn.Value.Split(',')[0] == strNodeData))
                {
                    FindInTreeAfter(tn, strNodeData, str);
                }
                else
                {
                    ExpandTreeAfter(tn, str);
                    return;
                }
            }
        }
        //根据NodeData寻找节点
        private void FindInTreeAfter(TreeNode objTreeNode, string strNodeData, String str)
        {
            if (objTreeNode.Value == strNodeData)
            {
                ExpandTreeAfter(objTreeNode, str);
                return;
            }
            foreach (TreeNode tn in objTreeNode.ChildNodes)
            {
                if (tn.Value.Split(',')[0] == strNodeData)
                {
                    ExpandTreeAfter(tn, str);
                    return;
                }
                else
                    FindInTreeAfter(tn, strNodeData, str);
            }
        }
        #endregion

        #region 展开节点
        //根据NodeData展开节点
        protected void ExpandTreeAfter(TreeNode objTreeNode, String str)
        {
            switch (str)
            {
                case "Left1":
                    objTreeNode.Select();
                    objTreeNode.Expanded = true;
                    while (objTreeNode.Parent is TreeNode)
                    {
                        objTreeNode = ((TreeNode)objTreeNode.Parent);
                        objTreeNode.Expanded = true;
                    }
                    break;
                case "Left0":
                    //objTreeNode.Selected = true;
                    objTreeNode.Select();
                    objTreeNode.Expanded = true;
                    while (objTreeNode.Parent is TreeNode)
                    {
                        objTreeNode = ((TreeNode)objTreeNode.Parent);
                        objTreeNode.Expanded = true;
                    }
                    break;
                case "Right":
                    objTreeNode.Selected = true;
                    objTreeNode.Expanded = true;
                    while (objTreeNode.Parent is TreeNode)
                    {
                        objTreeNode = ((TreeNode)objTreeNode.Parent);
                        objTreeNode.Expanded = true;
                    }
                    break;
            }
        }
        #endregion

        #region 展开自己单位的所有下级单位
        protected void ExpandSelf()
        {
            //获取调度台所在单位的Id
            int OperateEntityID = int.Parse(Request.Cookies["id"].Value);
            //获取调度台的所有父级单位Id(包括自己)
            UChangeETree myUChange = new UChangeETree();
            string dtparents = myUChange.GetAllParentById(OperateEntityID);
            string[] AllSelfParents = dtparents.Split(',');
            string dtchilds = myUChange.GetParentID(OperateEntityID);
            string[] AllSelfChildren = dtchilds.Split(',');
            //展开父级和自己单位
            TreeNode node = TreeView_Left.Nodes[0];

        }
        #endregion

        #region 修改直属警员的Entity_ID和直属单位的ParentID
        protected void EditZhishuJingyuan(SqlCommand cmd, SqlConnection ConnUser, String[] IdDepthL, String[] IdDepthR)
        {
            #region 查询直属警员的Id
            //查询直属警员的Id
            String sql_User_Chaxun = "select Id from User_info where Entity_ID = '" + IdDepthL[0] + "'";
            String sql_ISSI_Chaxun = "select Id from ISSI_info where Entity_ID = '" + IdDepthL[0] + "'";
            String sql_Group_Chaxun = "select Id from Group_info where Entity_ID = '" + IdDepthL[0] + "'";
            String sql_DTGroup_Chaxun = "select Id from DTGroup_info where Entity_ID = '" + IdDepthL[0] + "'";
            String sqlDXGroup_Chaxun = "select Id from DXGroup_info where Entity_ID = '" + IdDepthL[0] + "'";
            #endregion

            #region 修改直属警员的单位（User_info,ISSI_info,Group,DTGroup_info,DXGroup_info）
            //修改直属警员的单位（User_info,ISSI_info,Group,DTGroup_info,DXGroup_info）
            String sql_User = "update User_info set Entity_ID = '" + IdDepthR[0] + "' where Entity_ID = '" + IdDepthL[0] + "'";
            String sql_ISSI = "update ISSI_info set Entity_ID = '" + IdDepthR[0] + "' where Entity_ID = '" + IdDepthL[0] + "'";
            String sql_Group = "update Group_info set Entity_ID = '" + IdDepthR[0] + "' where Entity_ID = '" + IdDepthL[0] + "'";
            String sql_DTGroup = "update DTGroup_info set Entity_ID = '" + IdDepthR[0] + "' where Entity_ID = '" + IdDepthL[0] + "'";
            String sqlDXGroup = "update DXGroup_info set Entity_ID = '" + IdDepthR[0] + "' where Entity_ID = '" + IdDepthL[0] + "'";
            #endregion

            //查询直属警员的id
            DataTable dt2 = DbComponent.UChangeETree.ExecuteRead(ConnUser, sql_User_Chaxun, "GetParentID1");
            DataTable dt3 = DbComponent.UChangeETree.ExecuteRead(ConnUser, sql_ISSI_Chaxun, "GetParentID2");
            DataTable dt4 = DbComponent.UChangeETree.ExecuteRead(ConnUser, sql_Group_Chaxun, "GetParentID3");
            DataTable dt5 = DbComponent.UChangeETree.ExecuteRead(ConnUser, sql_DTGroup_Chaxun, "GetParentID4");
            DataTable dt6 = DbComponent.UChangeETree.ExecuteRead(ConnUser, sqlDXGroup_Chaxun, "GetParentID5");

            //修改直属警员的单位（User_info,ISSI_info,Group,DTGroup_info,DXGroup_info）
            //修改User_info表的ParentID
            cmd.CommandText = sql_User;
            cmd.ExecuteNonQuery();

            //记录User_info表修改的内容
            for (int k = 0; k < dt2.Rows.Count; k++)
            {
                ContentChanged += "User_info" + "," + "Entity_ID" + "," + IdDepthL[0] + "," + IdDepthR[0] + "," + dt2.Rows[k][0] + ";";
                AfterParentID += "User_info" + "," + "Entity_ID" + "," + dt2.Rows[k][0] + "," + IdDepthR[0] + ";";

            }
            //修改ISSI_info表的ParentID
            cmd.CommandText = sql_ISSI;
            cmd.ExecuteNonQuery();

            //记录ISSI_info表修改的内容
            for (int k = 0; k < dt3.Rows.Count; k++)
            {
                ContentChanged += "ISSI_info" + "," + "Entity_ID" + "," + IdDepthL[0] + "," + IdDepthR[0] + "," + dt3.Rows[k][0] + ";";
                AfterParentID += "ISSI_info" + "," + "Entity_ID" + "," + dt3.Rows[k][0] + "," + IdDepthR[0] + ";";

            }
            //修改Group表的ParentID
            cmd.CommandText = sql_Group;
            cmd.ExecuteNonQuery();

            //记录Group_info表修改的内容
            for (int k = 0; k < dt4.Rows.Count; k++)
            {
                ContentChanged += "Group_info" + "," + "Entity_ID" + "," + IdDepthL[0] + "," + IdDepthR[0] + "," + dt4.Rows[k][0] + ";";
                AfterParentID += "Group_info" + "," + "Entity_ID" + "," + dt4.Rows[k][0] + "," + IdDepthR[0] + ";";

            }
            //修改DTGroup_info表的ParentID
            cmd.CommandText = sql_DTGroup;
            cmd.ExecuteNonQuery();
            //记录DTGroup_info表修改的内容
            for (int k = 0; k < dt5.Rows.Count; k++)
            {
                ContentChanged += "DTGroup_info" + "," + "Entity_ID" + "," + IdDepthL[0] + "," + IdDepthR[0] + "," + dt5.Rows[k][0] + ";";
                AfterParentID += "DTGroup_info" + "," + "Entity_ID" + "," + dt5.Rows[k][0] + "," + IdDepthR[0] + ";";

            }

            //修改DXGroup_info表的ParentID
            cmd.CommandText = sqlDXGroup;
            cmd.ExecuteNonQuery();
            //记录DXGroup_info表修改的内容
            for (int k = 0; k < dt6.Rows.Count; k++)
            {
                ContentChanged += "DXGroup_info" + "," + "Entity_ID" + "," + IdDepthL[0] + "," + IdDepthR[0] + "," + dt6.Rows[k][0] + ";";
                AfterParentID += "DXGroup_info" + "," + "Entity_ID" + "," + dt6.Rows[k][0] + "," + IdDepthR[0] + ";";

            }
            //查询直属单位的Id
            String sql_zhishu_chaxun = "select ID from Entity where ParentID =" + IdDepthL[0];
            DataTable dt8 = DbComponent.UChangeETree.ExecuteRead(ConnUser, sql_zhishu_chaxun, "GetParentID8");

            //修改直属单位的ParentID
            String sql_ParentID = "update Entity set ParentID = '" + IdDepthR[0] + "' where ParentID = '" + IdDepthL[0] + "'";
            cmd.CommandText = sql_ParentID;
            cmd.ExecuteNonQuery();
            //记录直属单位的修改内容和parentID
            for (int k = 0; k < dt8.Rows.Count; k++)
            {
                ContentChanged += "Entity" + "," + "ParentID" + "," + IdDepthL[0] + "," + IdDepthR[0] + "," + dt8.Rows[k][0] + ";";
            }

        }
        #endregion
    }
}