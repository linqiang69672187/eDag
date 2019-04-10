using Ryu666.Components;
using System;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Web.UI.WebControls;

namespace DbComponent
{
    public class Tree
    {
        private string[] DisptchChildren;

        private string cookiesid { set; get; }
        private string[] newarr { set; get; }
        private string pagefrom { set; get; }
        private string usename { set; get; }

        #region 构造树形结构 初始化ID和类别
        public Tree(string cookid, string[] myarr, string page, string ursename_)
        {
            cookiesid = cookid;
            newarr = myarr;
            pagefrom = page;
            usename = ursename_;
        }
        #endregion

        #region 生成根级单位，触发生成下级
        public void createtreebegion(TreeView TreeView1)
        {

            TreeNode nodes;
            DataTable dt = (SQLHelper.ExecuteRead(CommandType.Text, "SELECT name,id,Lo,La  FROM [Entity] where Depth =0", "tree1"));
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                nodes = new TreeNode();
                nodes.Text = "<span style='cursor:hand' onclick=window.parent.parent.parent.DingWei('" + dt.Rows[i]["Lo"].ToString() + "','" + dt.Rows[i]["La"].ToString() + "','treeentity')>" + dt.Rows[i][0].ToString() + "</span>" + GetDeviceByID(int.Parse(dt.Rows[i][1].ToString())); ;
                nodes.Value = dt.Rows[i][1].ToString();
                nodes.SelectAction = TreeNodeSelectAction.None;
                //nodes.ShowCheckBox = true;

                TreeView1.Nodes.Add(nodes);
                DbComponent.Entity dbentity = new DbComponent.Entity();
                bool ISchildORMyself = dbentity.IsParentA_B(int.Parse(cookiesid), int.Parse(dt.Rows[i][1].ToString())) > 0 ? true : false;//自己或者是下级单位
                if (ISchildORMyself) { CreateTreeBJ_user_trafic(nodes.ChildNodes, dt.Rows[i][1].ToString()); }
                //生成编组，警员，设备
                CreateTreeViewRecursive(nodes.ChildNodes, dt.Rows[i][1].ToString());//生成下级单位

            }

        }
        #endregion

        #region 循环生成下级单位
        protected void CreateTreeViewRecursive(TreeNodeCollection nodes, string parentid)
        {
            DbComponent.Entity dbentity = new DbComponent.Entity();
            TreeNode newnodes;
            DataTable dt = (SQLHelper.ExecuteRead(CommandType.Text, "select Name,id,Lo,La from Entity where ParentID = @parentid order by name", parentid, new SqlParameter("parentid", parentid)));
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                bool secondentity = dbentity.GetEntityIndex(int.Parse(dt.Rows[i][1].ToString())) == 1 ? true : false;//判断二级单位
                bool ISparent = dbentity.IsParentA_B(int.Parse(dt.Rows[i][1].ToString()), int.Parse(cookiesid)) > 0 ? true : false;//直属上级单位
                bool ISbroth = dbentity.IsbrothA_B(int.Parse(dt.Rows[i][1].ToString()), int.Parse(cookiesid)) > 0 ? true : false; //同一父级兄弟单位
                bool ISchildORMyself = dbentity.IsParentA_B(int.Parse(cookiesid), int.Parse(dt.Rows[i][1].ToString())) > 0 ? true : false;//自己或者是下级单位
                if (secondentity || ISparent || ISbroth || ISchildORMyself)
                {
                    newnodes = new TreeNode();
                    newnodes.Text = "<span style='cursor:hand' onclick=window.parent.parent.parent.DingWei('" + dt.Rows[i]["Lo"].ToString() + "','" + dt.Rows[i]["La"].ToString() + "','treeentity')>" + dt.Rows[i][0].ToString() + "</span>" + GetDeviceByID(int.Parse(dt.Rows[i][1].ToString()));
                    newnodes.Value = dt.Rows[i][1].ToString();
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
                newnodes = new TreeNode();
                newnodes.Text = arr;
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

            if (type == ResourceManager.GetString("Group"))//编组
            {
                string[] arrs = { ResourceManager.GetString("smallGroup"), ResourceManager.GetString("multicastgroup"), ResourceManager.GetString("patchgroup"), ResourceManager.GetString("dxgroup"), ResourceManager.GetString("dtgroup") };
                foreach (string arr in arrs)
                {
                    newnodes = new TreeNode();
                    newnodes.Text = arr;
                    newnodes.Value = arr;

                    if (arr == ResourceManager.GetString("smallGroup"))//小组
                    {
                        sql = "SELECT  [ID],[Group_name],'manager_Group',[GSSI] FROM [Group_info] where LEN(GSSIS) <2 and Entity_ID =@Entity_ID order by [GSSI]";
                    }
                    else if (arr == ResourceManager.GetString("multicastgroup"))//通播组
                    {
                        sql = "SELECT  [ID],[Group_name],'manager_TBGroup',[GSSI] FROM [Group_info] where LEN(GSSIS) >2 and Entity_ID =@Entity_ID  order by [GSSI]";
                    }
                    else if (arr == ResourceManager.GetString("dxgroup"))//多选组
                    {
                        sql = "SELECT  [ID],[Group_name],'manager_DXGroup',[Group_index] FROM [DXGroup_info] where GType=0 and Entity_ID =@Entity_ID  order by [GSSIS]";
                    }
                    else if (arr == ResourceManager.GetString("patchgroup"))//派接组
                    {
                        sql = "SELECT  [ID],[Group_name],'manager_PJGroup',[Group_index] FROM [DXGroup_info] where GType=1 and Entity_ID =@Entity_ID  order by [GSSIS]";
                    }
                    else if (arr == ResourceManager.GetString("dtgroup"))//动态重组组
                    {
                        sql = "SELECT  [ID],[Group_name],'manager_DTGroup',[GSSI] FROM [DTGroup_info] where Entity_ID =@Entity_ID  order by [GSSI]";
                    }
                    else
                    {

                    }
                    newnodes.SelectAction = TreeNodeSelectAction.None;
                    nodes.Add(newnodes);
                    CreateTree_sql(newnodes.ChildNodes, sql, entityid);
                }
            }
            else if (type == ResourceManager.GetString("Terminal"))//终端
            {
                sql = "SELECT  A.[ID],A.[ISSI],'manager_ISSI' ,(SELECT B.[id] FROM [User_info] B where B.[ISSI] = A.ISSI) FROM [ISSI_info] A where A.Entity_ID =@Entity_ID  order by [ISSI]";
                CreateTree_sql(nodes, sql, entityid);
            }
            else if (type == ResourceManager.GetString("Dispatch"))//调度台
            {
                sql = "SELECT  [ID],[ISSI],'manager_Dispatch' FROM [Dispatch_Info] where ISSI is not null and Entity_ID =@Entity_ID  order by [ISSI]";
                CreateTree_sql(nodes, sql, entityid);
            }
            else
            {
                sql = "SELECT  [ID],[Nam],'manager_user' FROM [User_info] where Entity_ID =@Entity_ID and [type]='" + type + "'  order by [Nam]";
                CreateTree_sql(nodes, sql, entityid);
            }


        }
        #endregion

        #region 建立最后树形内容
        protected void CreateTree_sql(TreeNodeCollection nodes, string sql, string entityid)
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
                    case "manager_PJGroup":
                    case "manager_DXGroup":
                    case "manager_DTGroup":
                        width = "674"; height = "354";
                        newnodes.Text = treetext(width, height, dt.Rows[i][2].ToString(), dt.Rows[i][0].ToString(), dt.Rows[i][1].ToString(), dt.Rows[i][3].ToString());
                        break;
                    case "manager_user":
                        width = "590"; height = "370";
                        newnodes.Text = treetext(width, height, dt.Rows[i][2].ToString(), dt.Rows[i][0].ToString(), dt.Rows[i][1].ToString(), "");
                        break;
                    case "manager_ISSI":
                        width = "880"; height = "354";
                        newnodes.Text = treetext(width, height, dt.Rows[i][2].ToString(), dt.Rows[i][0].ToString(), dt.Rows[i][1].ToString(), dt.Rows[i][3].ToString());
                        break;

                    case "manager_Dispatch":
                        width = "680"; height = "354";
                        newnodes.Text = treetext(width, height, dt.Rows[i][2].ToString(), dt.Rows[i][0].ToString(), dt.Rows[i][1].ToString(), "");
                        break;

                    default:
                        break;
                }
                newnodes.Value = dt.Rows[i][0].ToString();

                nodes.Add(newnodes);
            }

        }
        #endregion

        #region 最后输出文本内容
        protected string treetext(string width, string height, string urlcase, string urlid, string value, string appenvalue)
        {
            string returntext = null;
            int devicetimeout = 15;
            //DataTable useparameter = DbComponent.usepramater.GetUseparameterByCookie(usename);
            //for (int i = 0; i < useparameter.Rows.Count; i++)
            //{
            //    devicetimeout = int.Parse(useparameter.Rows[i]["device_timeout"].ToString());
            //}
            string strOpenPageName = "";
            switch (urlcase)
            {
                case "manager_user":
                    strOpenPageName = "view_info/view_user";
                    userinfo usinf = new userinfo();
                    int useissi = usinf.UserISSI_byid(int.Parse(urlid)); // 根据ID检查用户是否关联设备
                    if (useissi > 0)
                    {
                        returntext = "<a class='onlineuse' selID='" + urlid + "'  id='onlineuse" + urlid + "' style='width:9px;height:16px;background-image:url(../img/treebutton.gif);visibility:hidden;'   ></a>";
                        returntext += "<a class='hasleftmenu' style='width:17px;height:16px;background-image:url(../img/treebutton.gif);background-position:-19 0;float:right;margin-top:-18px;' onmouseover=setrightvalue(" + urlid + ");></a>";
                    }
                    usinf = null;
                    break;
                case "manager_ISSI":
                    strOpenPageName = "view_info/view_ISSI";
                    //returntext = (DbComponent.ISSI.checkonlineISSI(value, devicetimeout) > 0) ? "<a class='onlineuse' selID='" + value + "' id='onlineuse" + value + "' style='width:9px;height:16px;background-image:url(../img/treebutton.gif)' title='" + ResourceManager.GetString("Online") + "'></a>" : "<a class='onlineuse' selID='" + value + "' id='onlineuse" + value + "' style='width:9px;height:16px;background-image:url(../img/treebutton.gif);background-position:-10 0;' title='" + ResourceManager.GetString("Offline") + "'></a>";
                    if (appenvalue != "")
                    {
                        returntext += "<a class='hasleftmenu' style='width:17px;height:16px;background-image:url(../img/treebutton.gif);background-position:-19 0;float:right;margin-top:-15px;' onmouseover=setrightvalue(" + appenvalue + ");></a>";
                    }
                    break;

                case "manager_Dispatch":
                    strOpenPageName = "view_info/view_dispatich";
                    returntext = "<a class='hasleftmenu' style='width:17px;height:16px;background-image:url(../img/treebutton.gif);background-position:-19 0;float:right;margin-top:-15px;' onmouseover=setrightvalue(" + value + ");></a>";
                    break;
                case "manager_DXGroup":
                    strOpenPageName = "view_info/view_DXgroup";
                    returntext = "<a  class='hasleftmenu' style='width:17px;height:16px;background-image:url(../img/treebutton.gif);background-position:-19 0;float:right;margin-top:-15px;'  onmouseover=setrightvalue(" + appenvalue + ",'dx_group');></a>";
                    break;
                case "manager_PJGroup":
                    strOpenPageName = "view_info/view_PJgroup";
                    returntext = "<a  class='hasleftmenu' style='width:17px;height:16px;background-image:url(../img/treebutton.gif);background-position:-19 0;float:right;margin-top:-15px;'  onmouseover=setrightvalue(" + appenvalue + ",'dx_group');></a>";
                    break;
                case "manager_TBGroup":
                    strOpenPageName = "view_info/view_TBgroup";
                    returntext = "<a  class='hasleftmenu' style='width:17px;height:16px;background-image:url(../img/treebutton.gif);background-position:-19 0;float:right;margin-top:-15px;'  onmouseover=setrightvalue(" + appenvalue + ",'dx_group');></a>";
                    break;

                default:
                    strOpenPageName = "view_info/view_group";
                    returntext = "<a  class='hasleftmenu' style='width:17px;height:16px;background-image:url(../img/treebutton.gif);background-position:-19 0;float:right;margin-top:-15px;'  onmouseover='setrightvalue(" + appenvalue + ");' onmousedown='setRightclickMenu(" + appenvalue + ");'></a>";
                    break;
            }

            //return "<div style='width:100%;height:20px;display:inline;overflow:hidden;' onmouseover='changebgcolor(this);' onmouseout='backcolor(this);'><a style='cursor:hand;' onclick=window.parent.parent.parent.CreatedivORnewopen('" + urlcase + "','" + urlid + "','" + width + "','" + height + "');><span>" + value + "</span></a>" + returntext + "</div>";
            if (urlcase == "manager_user")
            {
                return "<div style='width:100%;height:20px;display:inline;overflow:hidden;' onmouseover=changebgcolor(this);GetDevicestatus(" + urlid + "); onmouseout='backcolor(this);HiddenDevicestatus(" + urlid + ");'><a style='cursor:hand;' onclick=window.parent.parent.parent.CreatedivORnewopen('" + strOpenPageName + "','" + urlid + "','" + width + "','" + height + "');><span>" + value + "</span></a>" + returntext + "</div>";

            }
            else
            {
                return "<div style='width:100%;height:20px;display:inline;overflow:hidden;' onmouseover='changebgcolor(this)' onmouseout='backcolor(this)'><a style='cursor:hand;' onclick=window.parent.parent.parent.CreatedivORnewopen('" + strOpenPageName + "','" + urlid + "','" + width + "','" + height + "');><span>" + value + "</span></a>" + returntext + "</div>";
            }



        }
        #endregion

        #region 查询下级及所有子级单位ID
        protected string GetParentID(int id)
        {
            StringBuilder sb = new StringBuilder();
            DataTable dt = DbComponent.SQLHelper.ExecuteRead(CommandType.Text, "WITH lmenu(name,id,[ParentID]) as (SELECT name,id,[ParentID]  FROM [dbo].[Entity] WHERE id=@id UNION ALL    SELECT A.NAME,A.id,A.ParentID FROM [dbo].[Entity] A,lmenu b    where a.ParentID = b.[ID]) select id from lmenu", "getParentID", new SqlParameter("id", id));
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                sb.Append("[" + dt.Rows[i][0].ToString() + "]");
            }
            return sb.ToString();
        }
        #endregion

        #region 获取该单位下终端总数及在线终端数
        protected string GetDeviceByID(int id)
        {
            StringBuilder sb = new StringBuilder();
            string onlinvalue = "";
            string totalvalue = "";
            DataTable dt;
            int devicetimeout = 15;
            //DataTable useparameter = DbComponent.usepramater.GetUseparameterByCookie(usename);
            //for (int i = 0; i < useparameter.Rows.Count; i++)
            //{
            //    devicetimeout = int.Parse(useparameter.Rows[i]["device_timeout"].ToString());
            //}

            if (pagefrom == ResourceManager.GetString("police"))//警员
            {
                //dt = DbComponent.SQLHelper.ExecuteRead(CommandType.Text, "WITH lmenu(name,id) as (SELECT name,id  FROM [dbo].[Entity] WHERE id=@id UNION ALL    SELECT A.NAME,A.id FROM [dbo].[Entity] A,lmenu b    where a.ParentID = b.[ID])  SELECT COUNT(*) FROM [GIS_info] where USER_ID in (SELECT [id] FROM [User_info] where [Entity_ID] in (select id from lmenu)) and Send_reason not in ('" + ResourceManager.GetString("UNLogin") + "','" + ResourceManager.GetString("PowerOff") + "','" + ResourceManager.GetString("Directmode") + "','" + ResourceManager.GetString("Illegal") + "') and DATEDIFF(MINUTE,Send_time,GETDATE()) < " + devicetimeout + " union all  SELECT COUNT([id]) FROM [User_info] where [Entity_ID] in (select id from lmenu)", "getParentID", new SqlParameter("id", id));
                //for (int i = 0; i < dt.Rows.Count; i++)
                //{
                //    if (i == 0)
                //    {
                //        sb.Append(dt.Rows[i][0].ToString());
                //        onlinvalue = dt.Rows[i][0].ToString();
                //    }
                //    else
                //    {
                //        sb.Append("/" + dt.Rows[i][0].ToString());
                //        totalvalue = dt.Rows[i][0].ToString();
                //    }

                //}
                return " <span class='onlinedevice' id='entity" + id + "' selID='" + id + "' entityID='" + GetParentID(id) + "' ></span>";
            }
            else
            {
                return "";
            }

            //switch (pagefrom)
            //{
            //    case "警员":


            //    //case "终端":

            //    //    dt = DbComponent.SQLHelper.ExecuteRead(CommandType.Text, "WITH lmenu(name,id) as (SELECT name,id  FROM [dbo].[Entity] WHERE id=@id UNION ALL    SELECT A.NAME,A.id FROM [dbo].[Entity] A,lmenu b    where a.ParentID = b.[ID])  SELECT COUNT(*) FROM [GIS_info] where ISSI in (SELECT issi FROM [issi_info] where [Entity_ID] in (select id from lmenu)) and Send_reason not in ('未注册','关机','直通模式','非法') and DATEDIFF(MINUTE,Send_time,GETDATE()) < " + devicetimeout + "  union all  SELECT COUNT([id]) FROM [issi_info] where [Entity_ID] in (select id from lmenu) ", "getParentID", new SqlParameter("id", id));
            //    //    for (int i = 0; i < dt.Rows.Count; i++)
            //    //    {
            //    //        if (i==0)
            //    //        {
            //    //        sb.Append(dt.Rows[i][0].ToString());
            //    //        onlinvalue = dt.Rows[i][0].ToString();
            //    //        }
            //    //        else
            //    //        {
            //    //            sb.Append("/" + dt.Rows[i][0].ToString());
            //    //            totalvalue = dt.Rows[i][0].ToString();
            //    //        }

            //    //    }
            //    //    return " <span class='onlinedeviceentity' id='entity" + id + "' selID='" + id + "' entityID='" + GetParentID(id) + "' title='在线用户:" + onlinvalue + "  总数:" + totalvalue + "'>[" + sb.ToString() + "]</span>";

            //    default:
            //        return "";
            //}
        }

        #endregion


        #region 生成警员列表根级单位，触发生成下级
        public void createtreebegion_Police(TreeView TreeView1, int DisptchEntityid)
        {
            //获取调度台单位的所有下级单位
            String AllChilds = GetAllChildrenID(DisptchEntityid);
            DisptchChildren = AllChilds.Split(',');

            TreeNode nodes;
            DataTable dt = (SQLHelper.ExecuteRead(CommandType.Text, "SELECT name,id,Lo,La  FROM [Entity] where Depth =0", "tree1"));
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                nodes = new TreeNode();
                nodes.Text = "<span style='cursor:hand' onclick=window.parent.parent.parent.DingWei('" + dt.Rows[i]["Lo"].ToString() + "','" + dt.Rows[i]["La"].ToString() + "','treeentity')>" + dt.Rows[i][0].ToString() + "</span>" + GetDeviceByID(int.Parse(dt.Rows[i][1].ToString())); ;
                nodes.Value = dt.Rows[i][1].ToString();
                nodes.SelectAction = TreeNodeSelectAction.None;
                TreeView1.Nodes.Add(nodes);

                //如果该单位是调度台自己及下级单位则添加用户列表单位前的复选框
                ////判断该单位是否为调度台的自己或下级单位
                if (System.Configuration.ConfigurationManager.AppSettings["IsCheckbox"] != null && System.Configuration.ConfigurationManager.AppSettings["IsCheckbox"].ToString() == "1")
                {
                    int IsBranch = IsSelfBranch(dt.Rows[i][1].ToString());
                    if (IsBranch == 1)
                    {
                        nodes.ShowCheckBox = true;
                        nodes.Checked = true;
                    }
                    else
                    {
                        nodes.ShowCheckBox = false;
                    }
                }
                //DbComponent.Entity dbentity = new DbComponent.Entity();
                //bool ISchildORMyself = dbentity.IsParentA_B(int.Parse(cookiesid), int.Parse(dt.Rows[i][1].ToString())) > 0 ? true : false;//自己或者是下级单位
                //if (ISchildORMyself)
                //{
                //    //CreateTreeBJ_user_trafic(nodes.ChildNodes, dt.Rows[i][1].ToString());
                //}
                //生成编组，警员，设备
                CreateTreeViewRecursive_Police(nodes.ChildNodes, dt.Rows[i][1].ToString());//生成下级单位           
            }
        }
        #endregion

        #region 循环生成警员列表下级单位
        protected void CreateTreeViewRecursive_Police(TreeNodeCollection nodes, string parentid)
        {
            //直属用户
            TreeNode zhishunode;
            zhishunode = new TreeNode();
            zhishunode.Text = "<span style = 'color:#3333FF'>" + ResourceManager.GetString("Lang_ThisUnitBelongUser") + "</span>";
            zhishunode.Value = "zhishu-" + parentid;
            zhishunode.SelectAction = TreeNodeSelectAction.None;
            nodes.Add(zhishunode);
            zhishunode.Expand();
            //如果该单位是调度台自己及下级单位则添加用户列表单位前的复选框
            if (System.Configuration.ConfigurationManager.AppSettings["IsCheckbox"] != null && System.Configuration.ConfigurationManager.AppSettings["IsCheckbox"].ToString() == "1")
            {
                //判断该单位是否为调度台的自己或下级单位
                int zhishuIsBranch = IsSelfBranch(parentid);
                if (zhishuIsBranch == 1)
                {
                    zhishunode.ShowCheckBox = true;
                    zhishunode.Checked = true;
                }
                else
                {
                    zhishunode.ShowCheckBox = false;
                }
            }
            DbComponent.Entity dbentity = new DbComponent.Entity();
            bool zhishuISchildORMyself = dbentity.IsParentA_B(int.Parse(cookiesid), int.Parse(parentid)) > 0 ? true : false;//自己或者是下级单位
            if (zhishuISchildORMyself)
            {
                CreateTreeBJ_user_trafic(zhishunode.ChildNodes, parentid);
            }

            //DbComponent.Entity dbentity = new DbComponent.Entity();
            TreeNode newnodes;
            DataTable dt = (SQLHelper.ExecuteRead(CommandType.Text, "select Name,id,Lo,La from Entity where ParentID = @parentid order by name", parentid, new SqlParameter("parentid", parentid)));
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                bool secondentity = dbentity.GetEntityIndex(int.Parse(dt.Rows[i][1].ToString())) == 1 ? true : false;//判断二级单位
                bool ISparent = dbentity.IsParentA_B(int.Parse(dt.Rows[i][1].ToString()), int.Parse(cookiesid)) > 0 ? true : false;//直属上级单位
                bool ISbroth = dbentity.IsbrothA_B(int.Parse(dt.Rows[i][1].ToString()), int.Parse(cookiesid)) > 0 ? true : false; //同一父级兄弟单位
                bool ISchildORMyself = dbentity.IsParentA_B(int.Parse(cookiesid), int.Parse(dt.Rows[i][1].ToString())) > 0 ? true : false;//自己或者是下级单位
                if (secondentity || ISparent || ISbroth || ISchildORMyself)
                {
                    newnodes = new TreeNode();
                    newnodes.Text = "<span style='cursor:hand' onclick=window.parent.parent.parent.DingWei('" + dt.Rows[i]["Lo"].ToString() + "','" + dt.Rows[i]["La"].ToString() + "','treeentity')>" + dt.Rows[i][0].ToString() + "</span>" + GetDeviceByID(int.Parse(dt.Rows[i][1].ToString()));
                    newnodes.Value = dt.Rows[i][1].ToString();
                    newnodes.SelectAction = TreeNodeSelectAction.None;
                    nodes.Add(newnodes);
                    //如果该单位是调度台自己及下级单位则添加用户列表单位前的复选框
                    if (System.Configuration.ConfigurationManager.AppSettings["IsCheckbox"] != null && System.Configuration.ConfigurationManager.AppSettings["IsCheckbox"].ToString() == "1")
                    {
                        //判断该单位是否为调度台的自己或下级单位
                        int IsBranch = IsSelfBranch(dt.Rows[i][1].ToString());
                        if (IsBranch == 1)
                        {
                            newnodes.ShowCheckBox = true;
                            newnodes.Checked = true;
                        }
                        else
                        {
                            newnodes.ShowCheckBox = false;
                        }
                    }
                    //if (ISchildORMyself) { CreateTreeBJ_user_trafic(newnodes.ChildNodes, dt.Rows[i][1].ToString()); }//自己或者是下级单位
                    CreateTreeViewRecursive_Police(newnodes.ChildNodes, dt.Rows[i][1].ToString());//循环生成下级单位
                }
            }
            dbentity = null;
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

        #region 查询下级及所有子级单位ID
        public string GetAllChildrenID(int id)
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
    }
}
