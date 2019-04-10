using DbComponent;
using Ryu666.Components;
using System;
using System.Data;
using System.Text.RegularExpressions;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Web.lqnew.opePages
{
    public partial class use_tree : System.Web.UI.Page
    {
        int ichecks = 0;
        String DipatchId;
        String HasNoneChecked = "";
        String[] lastYelloeEntitys;
        String YellowEntity = "";
        String WhiteEntity = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            DipatchId = Request.Cookies["id"].Value.ToString();
            if (!IsPostBack)
            {
                lastYelloeEntitys = null;
                //清楚YellowNodes的Cookie值
                if (Request.Cookies["YellowNodes"] != null)
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "none", "SetCookieNone();", true);
                }
                int DisptchEntityid = int.Parse(DipatchId);
                TreeView_Police.Nodes.Clear();
                UserTypeDao ut = new UserTypeDao();
                DataTable usetype = ut.GetAllUserType();
                string sts = "";
                for (int i = 0; i < usetype.Rows.Count; i++)
                {
                    sts += (i == 0) ? usetype.Rows[i]["TypeName"] : "," + usetype.Rows[i]["TypeName"];
                }
                string[] types = sts.Split(',');
                DbComponent.Tree myissitree = new DbComponent.Tree(Request.Cookies["id"].Value, types, ResourceManager.GetString("police"),Request.Cookies["username"].Value);
                myissitree.createtreebegion_Police(TreeView_Police, DisptchEntityid);
               
                try
                {
                    if (Request.QueryString["id"].ToString().Length > 0)
                    {
                        FindInTree2(Request.QueryString["id"].ToString());
                    }
                }
                catch (Exception et)
                {
                }
            }
            //绑定事件
            TreeView_Police.Attributes.Add("onclick", "postBackByObject()");
        }

        private string regx(string str)
        {
            string regexstr = @"<[^>]*>";    //去除所有的标签
            str = Regex.Replace(str, regexstr, string.Empty, RegexOptions.IgnoreCase);
            return str;
        }
        private string regxentityname(string str)
        {
            string regexstr = @"<[^>]*>";    //去除所有的标签
            str = Regex.Replace(str, regexstr, string.Empty, RegexOptions.IgnoreCase);
            return str;
        }
        public string myReplace(string strSource, string strRe, string strTo)
        {
            string strSl, strRl;
            strSl = strSource.ToLower();
            strRl = strRe.ToLower();
            int start = strSl.IndexOf(strRl);
            if (start != -1)
            {
                strSource = strSource.Substring(0, start) + strTo
                + myReplace(strSource.Substring(start + strRe.Length), strRe, strTo);
            }
            return strSource;
        }

        //根据NodeDate寻找节点
        private void FindInTree2(string strNodeData)
        {
            foreach (TreeNode tn in TreeView_Police.Nodes)
            {
                if (!(regx(tn.Text.ToLower()) == strNodeData.ToLower()))
                {
                    FindInTree2(tn, strNodeData);
                }
                else
                {
                    ExpandTree2(tn, tn.Text);
                    return;
                }
            }
        }
        //根据NodeDate寻找节点
        private void FindInTree2(TreeNode objTreeNode, string strNodeData)
        {
            if (regx(objTreeNode.Text.ToLower()) == (strNodeData.ToLower()))
            {
                ExpandTree2(objTreeNode, regx(objTreeNode.Text));
                return;
            }
            foreach (TreeNode tn in objTreeNode.ChildNodes)
            {
                FindInTree2(tn, strNodeData);
            }
        }
        //根据NodeDate展开节点
        private void ExpandTree2(TreeNode objTreeNode,string replacetext)
        {

            objTreeNode.Selected = true;
            objTreeNode.Text = myReplace(objTreeNode.Text,"<span>" + replacetext + "</span>", "<font color='white' style='font-style:italic;background-color:red;'><b><span>" + replacetext + "</span></b></font>");
            while (objTreeNode.Parent is TreeNode)
            {
                objTreeNode = ((TreeNode)objTreeNode.Parent);
                objTreeNode.Expanded = true;

            }
            return;
        }

        protected void TreeView_Police_TreeNodeCheckChnaged(object sender, TreeNodeEventArgs e)
        {
            HasNoneChecked = "";
            ichecks = 0;

            SetChildChecked(e.Node);
            //判断是否根节点
            if (e.Node.Parent != null)
            {
                if (e.Node.Value.ToString() != DipatchId)
                {
                    SetParentChecked(e.Node);
                }
            }

            //设置选中单位Id的Cookie
            String SelectedEntity = "";
            if (e.Node.Checked && e.Node.Value == DipatchId)
            {
                SelectedEntity = "";
            }
            else if ((!e.Node.Checked && e.Node.Value == DipatchId) || HasNoneChecked == "none")
            {
                SelectedEntity = "none";
            }
            else
            {
                for (int i = 0; i < TreeView_Police.CheckedNodes.Count; i++)
                {
                    String valueid = TreeView_Police.CheckedNodes[i].Value;
                    if (valueid.Substring(0, 1) == "z")
                    {
                        if (TreeView_Police.CheckedNodes[i].Parent.Checked == true)
                        {
                            continue;
                        }
                        else
                        {
                            if (i == TreeView_Police.CheckedNodes.Count - 1)
                            {
                                SelectedEntity += TreeView_Police.CheckedNodes[i].Value.Split('-')[1];
                            }
                            else
                            {
                                SelectedEntity += TreeView_Police.CheckedNodes[i].Value.Split('-')[1] + ",";
                            }
                        }
                    }
                    else
                    {
                        if (i == TreeView_Police.CheckedNodes.Count - 1)
                        {
                            SelectedEntity += TreeView_Police.CheckedNodes[i].Value;
                        }
                        else
                        {
                            SelectedEntity += TreeView_Police.CheckedNodes[i].Value + ",";
                        }
                    }
                }
            }
            Response.Cookies["SelectedEntity"].Value = SelectedEntity;
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "SelectedEntity", "window.parent.parent.parent.LayerControl.refurbish();", true);

            //读取上次颜色为黄色的单位
            if (Request.Cookies["YellowNodes"] != null)
            {
                String lastYelloeEntity = Request.Cookies["YellowNodes"].Value.ToString();
                if (lastYelloeEntity != "")
                {
                    lastYelloeEntitys = lastYelloeEntity.Split(',');
                }
            }
            //调用js脚本设置CheckBox背景颜色
            if (YellowEntity != null && YellowEntity != "")
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "YellowEntity", "FindCheckBox('" + YellowEntity + "','Yes');", true);
            }
            if (WhiteEntity != null && WhiteEntity != "")
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "WhiteEntity", "FindCheckBox('" + WhiteEntity + "','No');", true);
            }
            //记住CheckBox背景颜色
            if (YellowEntity != null && YellowEntity != "")
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "RememberLastYellowCheckBox", "RememberLastYellowCheckBox('" + YellowEntity + "','" + WhiteEntity + "');", true);
            }
            //获取当前被设为黄色的单位,写入cookie
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "GetYellowCheckBox", "GetYellowCheckBox();", true);
        }

        private void SetChildChecked(TreeNode parentNode)
        {
            if (parentNode.Checked == true)
            {
                if (lastYelloeEntitys != null)
                {
                    int IsYellowLast = IsYellowLasttime(parentNode.Value.ToString());
                    if (IsYellowLast == 1)
                    {
                        WhiteEntity += parentNode.Value.ToString() + ",";
                    }
                }
            }
            foreach (TreeNode node in parentNode.ChildNodes)
            {
                if (node.ShowCheckBox == true)
                {
                    if (parentNode.Checked == true)
                    {
                        node.Checked = true;
                        if (lastYelloeEntitys != null)
                        {
                            int IsYellowLast = IsYellowLasttime(node.Value.ToString());
                            if (IsYellowLast == 1)
                            {
                                WhiteEntity += parentNode.Value.ToString() + ",";
                            }
                        }
                    }
                    if (parentNode.Checked == false)
                    { node.Checked = false; }

                    if (node.ChildNodes.Count > 0)
                    {
                        SetChildChecked(node);
                    }
                }
            }
        }

        private void SetParentChecked(TreeNode childNode)
        {
            if (childNode.Value.ToString() == DipatchId)
            { return; }

            TreeNode parentNode = childNode.Parent;
            int HasCheckBoxNodeNum = 0;
            int childrencheckedNum = 0;
            if (childNode.Checked)
            {
                String Numbers = GetCheckedChildren(parentNode);
                HasCheckBoxNodeNum = int.Parse(Numbers.Split(',')[0]);
                childrencheckedNum = int.Parse(Numbers.Split(',')[1]);
                if (childrencheckedNum == HasCheckBoxNodeNum)
                {
                    parentNode.Checked = true;
                    if (lastYelloeEntitys != null)
                    {
                        int IsYellowLast = IsYellowLasttime(parentNode.Value.ToString());
                        if (IsYellowLast == 1)
                        {
                            WhiteEntity += parentNode.Value.ToString() + ",";
                        }
                    }
                }
                else
                {
                    YellowEntity += parentNode.Value.ToString() + ",";
                }
                //设置所有父单位
                if (parentNode.Parent != null)
                {
                    SetParentChecked(parentNode);
                }
            }
            else if (!childNode.Checked)
            {
                parentNode.Checked = false;
                if (ichecks == 0)
                {
                    GetCheckedChild(parentNode);
                }
                if (ichecks > 0)
                {
                    YellowEntity += parentNode.Value.ToString() + ",";
                    //设置所有父单位
                    if (parentNode.Parent != null)
                    {
                        SetParentChecked(parentNode);
                    }
                }
                if (ichecks == 0)
                {
                    WhiteEntity += parentNode.Value.ToString() + ",";
                    if (parentNode.Value.ToString() == DipatchId)
                    {
                        HasNoneChecked = "none";
                    }
                    if (parentNode.Parent != null)
                    {
                        SetParentChecked(parentNode);
                    }
                }
            }
        }

        private void GetCheckedChild(TreeNode parentNode)
        {
            foreach (TreeNode node in parentNode.ChildNodes)
            {
                if (node.ShowCheckBox == true)
                {
                    if (node.Checked)
                    {
                        ichecks++;
                        return;
                    }
                    if (node.ChildNodes.Count > 0)
                    {
                        GetCheckedChild(node);
                    }
                }
            }
        }
        private String GetCheckedChildren(TreeNode parentNode)
        {
            int HasCheckBoxNodeNum = 0;
            int CheckedBoxNodeNum = 0;
            foreach (TreeNode node in parentNode.ChildNodes)
            {
                if (node.ShowCheckBox == true)
                {
                    if (node.Checked)
                    {
                        CheckedBoxNodeNum++;
                    }
                    HasCheckBoxNodeNum++;
                }
            }
            return HasCheckBoxNodeNum.ToString() + "," + CheckedBoxNodeNum.ToString();
        }
        private int IsYellowLasttime(String EntityID)
        {
            int IsYellowLasttime = 0;
            for (int i = 0; i < lastYelloeEntitys.Length - 1; i++)
            {
                if (lastYelloeEntitys[i] == EntityID)
                {
                    return IsYellowLasttime = 1;
                }
            }
            return IsYellowLasttime;
        }

        protected void UpdatePanel1_Load(object sender, EventArgs e)
        {
            //隐藏进度条
            ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "Hideprocessbar", "Hideprocessbar();", true);
            //生成鼠标点击事件
            ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "fdfsa", "MouseMenu(window.parent.parent.parent, \"a\", \"policemouseMenu\"); ", true);
        }
    }
}