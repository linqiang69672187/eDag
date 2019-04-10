using DbComponent;
using MyModel;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Web.lqnew.opePages.LogView
{
    public partial class Unittree : System.Web.UI.Page
    {
        //public Entity entitySevice {
        //    get
        //    {
        //        return new Entity();
        //    }
        //}
        //public UserTypeDao userTypeService {
        //    get {
        //        return new UserTypeDao();
        //    }
        //}

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                ///获得所有单位数据
                //dtAllEntity = entitySevice.GetAllEntityInfo(int.Parse(Request.Cookies["id"].Value));

                //    DataRow[] dtOne = dtAllEntity.Select().Where(a => a.Field<int>("id") == int.Parse(Request.Cookies["id"].Value)).ToArray<DataRow>();
                //    TreeNode tn = new TreeNode();
                //    if (dtOne.Length == 0)
                //    {
                //        tn.Text = Ryu666.Components.ResourceManager.GetString("Unit");
                //    }
                //    else
                //    {
                //        foreach (DataRow dr in dtOne)
                //        {
                //            tn.Value = dr["id"].ToString();
                //            tn.Text = "<span style='cursor:hand' id='e" + dr["id"].ToString() + "' onclick='nodeClick(this,\"" + dr["id"].ToString() + "\",\"-1\",\"" + dr["Name"].ToString() + "\")'>" + dr["Name"].ToString() + "</span>";
                //        }
                //    }

                String id = Request.Cookies["id"].Value;
                IList<Object> objlist = new List<Object>();
                String sql = String.Format("select id,name from entity where id={0}", id);
                SQLHelper.ExecuteDataReader(ref objlist, sql, CommandType.Text);
                TreeNode tn = new TreeNode();
                tn.Value = id;
                tn.Text = "<span style='cursor:hand' id='e" + id + "' onclick='nodeClick(this,\"" + id + "\",\"-1\",\"" + objlist[1].ToString() + "\")'>" + objlist[1].ToString() + "</span>";
                tn.SelectAction = TreeNodeSelectAction.None;
                TreeView1.Nodes.Add(tn);
                GetResult(id, tn);

            }
        }

        private void GetResult(string entityid ,TreeNode parantNode)
        {

            //DataRow[] dtOne = dtAllEntity.Select().Where(a => a.Field<string>("ParentID") == entityid).ToArray<DataRow>();
            String sql = String.Format("select id,name from entity where parentid={0}", entityid);
            IList<Object> collist = new List<Object>() { "id", "name" };
            DataTable dt = new DataTable();
            dt.Columns.Add("id");
            dt.Columns.Add("name");
            SQLHelper.ExecuteDataReader(ref dt,  collist,sql);
            foreach (DataRow dr in dt.Rows)
            {
                TreeNode tn = new TreeNode();
                tn.Value = dr["id"].ToString();
                tn.Text = "<span style='cursor:hand' id='e" + dr["id"].ToString() + "' onclick='nodeClick(this,\"" + dr["id"].ToString() + "\",\"-1\",\"" + dr["name"].ToString() + "\")'>" + dr["name"].ToString() + "</span>"; 
                tn.SelectAction = TreeNodeSelectAction.None;
                //tn.ImageUrl = "../../../Images/Msg.png";
                parantNode.ChildNodes.Add(tn);
                //if (type == "user")
                //{
                //    DataRow[] dtTone = dtUserTypes.Select().Where(a => a.Field<string>("entityid") == dr["id"].ToString()).ToArray<DataRow>();
                //    foreach (DataRow dut in dtTone)
                //    {
                //        TreeNode tn1 = new TreeNode();
                //        tn1.Value = dut["ID"].ToString();
                //        tn1.Text = "<span style='cursor:hand' id='ut" + dut["ID"].ToString() + "_" + dr["id"].ToString() + "' onclick='nodeClick(this,\"" + dr["id"].ToString() + "\",\"" + dut["TypeName"].ToString() + "\",\"" + dr["Name"].ToString() + "\",\"" + dut["TypeName"].ToString() + "\")'>" + dut["TypeName"].ToString() + "</span>";
                //        tn1.SelectAction = TreeNodeSelectAction.None;
                //        tn1.ImageUrl = "../../../Images/icon_arrow.gif";
                //        tn.ChildNodes.Add(tn1);
                //    }
                //}
                GetResult(dr["id"].ToString(),tn);
            }
        }
    }
}