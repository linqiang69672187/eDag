using Ryu666.Components;
using System;
using System.Text.RegularExpressions;
using System.Web.UI.WebControls;

namespace Web.lqnew.opePages
{
    public partial class group_tree : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            DbComponent.Tree myissitree = new DbComponent.Tree(Request.Cookies["id"].Value, new string[] { ResourceManager.GetString("Group") }, ResourceManager.GetString("Group"), Request.Cookies["username"].Value);
            myissitree.createtreebegion(TreeView1);
            try
            {
                FindInTree2(Request.QueryString["id"].ToString());
            }
            catch (Exception et)
            {
                log.Debug(et);
            }
        }

        private string regx(string str)
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
            foreach (TreeNode tn in TreeView1.Nodes)
            {
                if (!(regx(tn.Text.ToLower()) == strNodeData.ToLower()))
                {
                    FindInTree2(tn, strNodeData);
                }
                else
                {
                    ExpandTree2(tn, regx(tn.Text));
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
        private void ExpandTree2(TreeNode objTreeNode, string replacetext)
        {

            objTreeNode.Selected = true;
            objTreeNode.Text = myReplace(objTreeNode.Text, "<span>" + replacetext + "</span>", "<font color='white' style='font-style:italic;background-color:red;'><b><span>" + replacetext + "</span></b></font>");
            while (objTreeNode.Parent is TreeNode)
            {
                objTreeNode = ((TreeNode)objTreeNode.Parent);
                objTreeNode.Expanded = true;

            }
            return;
        }

    }
}