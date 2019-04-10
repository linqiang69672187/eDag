using System;
using System.Web.UI.WebControls;
using DbComponent;
using System.Data;

namespace Web.lqnew.opePages.DTGroup
{
    public partial class DTGroupList : System.Web.UI.Page
    {
        DTGroupDao DTDao = new DTGroupDao();
        public string firstGSSI = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) {

                DataTable dt= DTDao.GetAllDTGroup();
                if (dt != null && dt.Rows.Count > 0) {
                  
                    foreach (DataRow dr in dt.Rows) {
                        
                        TreeNode tn2 = new TreeNode("&nbsp;&nbsp<span id='span_tv_" + dr["GSSI"] + "' style='cursor: pointer;font-size:12px' onclick='OnclickTree(this,\"" + dr["GSSI"] + "\",\"" + dr["GSSI"] + "\")'>" + dr["Group_name"] + "</span>", "0");
                        tn2.SelectAction = TreeNodeSelectAction.None;
                        tn2.ImageUrl = "../../../Images/Msg.png";
                        tv_SMS.Nodes.Add(tn2);
                    }
                    firstGSSI = dt.Rows[0]["GSSI"].ToString();
          
                }
                
              
               
            }
        }
    }
}