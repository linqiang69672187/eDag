using System;
using System.Web.UI.WebControls;

namespace Web.lqnew.opePages.SMS
{
    public partial class SMSList : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) {
                TreeNode tn1 = new TreeNode(Ryu666.Components.ResourceManager.GetString("SMS"), "-1");
                tn1.SelectAction = TreeNodeSelectAction.None;
                tv_SMS.Nodes.Add(tn1);

                TreeNode tn2 = new TreeNode("&nbsp;&nbsp<span id='span_tv_0' style='cursor: pointer;font-size:12px' onclick='OnclickTree(this,\"0\")'>" + Ryu666.Components.ResourceManager.GetString("Lang_RevMSGBOX") + "</span>", "0");
                tn2.SelectAction = TreeNodeSelectAction.None;
                tn2.ImageUrl = "../../../Images/Msg.png";
                tn1.ChildNodes.Add(tn2);

                TreeNode tn3 = new TreeNode("&nbsp;&nbsp<span id='span_tv_1' style='cursor: pointer;font-size:12px' onclick='OnclickTree(this,\"1\")'>" + Ryu666.Components.ResourceManager.GetString("Lang_SendMSGBOX") + "</span>", "1");
                tn3.SelectAction = TreeNodeSelectAction.None;
                tn3.ImageUrl = "../../../Images/Msg.png";
                tn1.ChildNodes.Add(tn3);
               
            }
        }
    }
}