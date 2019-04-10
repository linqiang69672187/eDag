using DbComponent;
using MyModel;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Web.lqnew.opePages.AddMemberTree
{
    public partial class use_tree : System.Web.UI.Page
    {
        public Entity entitySevice {
            get
            {
                return new Entity();
            }
        }
        public UserTypeDao userTypeService {
            get {
                return new UserTypeDao();
            }
        }
        public DataTable dtAllEntity = new DataTable();
        public IList<Model_UserType> dtAllUserTypes = new List<Model_UserType>();
        DataTable dtUserTypes = new DataTable();
        private string type = "user";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                type = Request["type"].ToString();
                dtAllEntity = entitySevice.GetAllEntityInfo(int.Parse(Request.Cookies["id"].Value));

                string strSQL = "select  distinct type as TypeName,a.Entity_ID as entityid ,b.ID from User_info a join UserType b on (a.type=b.TypeName)";
                dtUserTypes = DbComponent.SQLHelper.ExecuteRead(CommandType.Text, strSQL, "adfds");

                //dtAllUserTypes = userTypeService.GetAllForList();
                if (type == "dipatch")
                {
                    TreeNode tn = new TreeNode();
                    tn.Value="-9";
                    tn.Text="<span style='cursor:hand' id='edispatch' onclick='nodeClick(this,\"-0\",\"-1\")'>"+Ryu666.Components.ResourceManager.GetString("Dispatch")+"</span>";
                    tn.SelectAction = TreeNodeSelectAction.None;
                    TreeView1.Nodes.Add(tn);
                 
                }
                else
                {
                    DataRow[] dtOne = dtAllEntity.Select().Where(a => a.Field<int>("id") == int.Parse(Request.Cookies["id"].Value)).ToArray<DataRow>();
                    TreeNode tn = new TreeNode();
                    foreach (DataRow dr in dtOne)
                    {
                        tn.Value = dr["id"].ToString();
                        tn.ImageUrl = "../../../Images/Msg.png";
                        tn.Text = "<span style='cursor:hand' id='e" + dr["id"].ToString() + "' onclick='nodeClick(this,\"" + dr["id"].ToString() + "\",\"-1\",\"" + dr["Name"].ToString() + "\")'>" + dr["Name"].ToString() + "</span>";
                        if (type == "user")
                        {
                            DataRow[] dtTone = dtUserTypes.Select().Where(a => a.Field<string>("entityid") == dr["id"].ToString()).ToArray<DataRow>();
                            foreach (DataRow dut in dtTone)
                            {
                                TreeNode tn1 = new TreeNode();
                                tn1.Value = dut["ID"].ToString();
                                tn1.Text = "<span style='cursor:hand' id='ut" + dut["ID"].ToString() + "_" + dr["id"].ToString() + "' onclick='nodeClick(this,\"" + dr["id"].ToString() + "\",\"" + dut["TypeName"].ToString() + "\",\"" + dr["Name"].ToString() + "\",\"" + dut["TypeName"].ToString() + "\")'>" + dut["TypeName"].ToString() + "</span>";
                                tn1.SelectAction = TreeNodeSelectAction.None;
                                tn1.ImageUrl = "../../../Images/icon_arrow.gif";
                                tn.ChildNodes.Add(tn1);
                            }
                            //foreach (Model_UserType dtUserType in dtAllUserTypes)
                            //{
                            //    TreeNode tn1 = new TreeNode();
                            //    tn1.Value = dtUserType.ID.ToString();
                            //    tn1.Text = "<span style='cursor:hand' id='ut" + dtUserType.ID.ToString() + "_" + dr["id"].ToString() + "' onclick='nodeClick(this,\"" + dr["id"].ToString() + "\",\"" + dtUserType.TypeName.ToString() + "\",\"" + dr["Name"].ToString() + "\",\"" + dtUserType.TypeName + "\")'>" + dtUserType.TypeName + "</span>";
                            //    tn1.SelectAction = TreeNodeSelectAction.None;
                            //    tn.ChildNodes.Add(tn1);
                            //}
                        }
                    }
                    if (dtOne.Length == 0)
                    {
                        tn.Text = Ryu666.Components.ResourceManager.GetString("Unit");
                       
                    }
                    tn.SelectAction = TreeNodeSelectAction.None;
                    TreeView1.Nodes.Add(tn);
                    GetResult(Request.Cookies["id"].Value, tn);
                }
            }
        }
        private void GetResult(string entityid ,TreeNode parantNode)
        {

            DataRow[] dtOne = dtAllEntity.Select().Where(a => a.Field<string>("ParentID") == entityid).ToArray<DataRow>();

            foreach (DataRow dr in dtOne)
            {
                TreeNode tn = new TreeNode();
                tn.Value = dr["id"].ToString();
                tn.Text = "<span style='cursor:hand' id='e" + dr["id"].ToString() + "' onclick='nodeClick(this,\"" + dr["id"].ToString() + "\",\"-1\",\"" + dr["Name"].ToString() + "\")'>" + dr["Name"].ToString() + "</span>"; 
                tn.SelectAction = TreeNodeSelectAction.None;
                tn.ImageUrl = "../../../Images/Msg.png";
                parantNode.ChildNodes.Add(tn);
                if (type == "user")
                {
                    DataRow[] dtTone = dtUserTypes.Select().Where(a => a.Field<string>("entityid") == dr["id"].ToString()).ToArray<DataRow>();
                    foreach (DataRow dut in dtTone)
                    {
                        TreeNode tn1 = new TreeNode();
                        tn1.Value = dut["ID"].ToString();
                        tn1.Text = "<span style='cursor:hand' id='ut" + dut["ID"].ToString() + "_" + dr["id"].ToString() + "' onclick='nodeClick(this,\"" + dr["id"].ToString() + "\",\"" + dut["TypeName"].ToString() + "\",\"" + dr["Name"].ToString() + "\",\"" + dut["TypeName"].ToString() + "\")'>" + dut["TypeName"].ToString() + "</span>";
                        tn1.SelectAction = TreeNodeSelectAction.None;
                        tn1.ImageUrl = "../../../Images/icon_arrow.gif";
                        tn.ChildNodes.Add(tn1);
                    }
                    //foreach (Model_UserType dtUserType in dtAllUserTypes)
                    //{
                    //    TreeNode tn1 = new TreeNode();
                    //    tn1.Value = dtUserType.ID.ToString();
                    //    tn1.Text = "<span style='cursor:hand' id='ut" + dtUserType.ID.ToString() + "_" + dr["id"].ToString() + "' onclick='nodeClick(this,\"" + dr["id"].ToString() + "\",\"" + dtUserType.TypeName.ToString() + "\",\"" + dr["Name"].ToString() + "\",\"" + dtUserType.TypeName + "\")'>" + dtUserType.TypeName + "</span>";
                    //    tn1.SelectAction = TreeNodeSelectAction.None;
                    //    tn.ChildNodes.Add(tn1);
                    //}
                }
                GetResult(dr["id"].ToString(),tn);
            }

        }
    }
}