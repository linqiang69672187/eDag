using DbComponent;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Text;
using System.Data.SqlClient;
using Ryu666.Components;

namespace Web.lqnew.opePages
{
    public partial class mztree : System.Web.UI.Page
    {
        public string zhishu = "";
        private string[] DisptchChildren;
        string DipatchId = "";
        public string strEntityandType = "";
        public DataTable dtAllEntity = new DataTable();

        public DataTable dtAllUserTypes = new DataTable();

        protected void Page_Load(object sender, EventArgs e)
        {
            //多语言化
            zhishu = ResourceManager.GetString("Lang_zhishu");
            //获取调度台单位的所有下级单位
            DipatchId = Request.Cookies["id"].Value.ToString();
            int DisptchEntityid = int.Parse(DipatchId);
            //DisptchEntityid = 1;
            String AllChilds = GetAllChildrenID(DisptchEntityid);
            DisptchChildren = AllChilds.Split(',');

            string strAllEntity = "SELECT * from Entity";//查询所有用户记录

            string strAllUserTypes = "select * from UserType";

            dtAllEntity = SQLHelper.ExecuteRead(CommandType.Text, strAllEntity, "allentity");

            dtAllUserTypes = SQLHelper.ExecuteRead(CommandType.Text, strAllUserTypes, "allusertypes");

            StringBuilder sb_entityandtype = new StringBuilder("<nodes>");
            sb_entityandtype.Append(GetEntityandType("0"));
            sb_entityandtype.Append("</nodes>");
            strEntityandType = sb_entityandtype.ToString();
                                    
        }
        private string GetEntityandType(string entityid)
        {
            DataRow[] dtOne = dtAllEntity.Select().Where(a => a.Field<string>("ParentID") == entityid).ToArray<DataRow>();
            StringBuilder sb = new StringBuilder();
            foreach (DataRow dr in dtOne)
            {               
                    int IsBranch = IsSelfBranch(dr["id"].ToString());
                    if (IsBranch == 1)
                    {                        
                        if (dr["Depth"].ToString() == "-1")
                        {
                            sb.Append("<node id=\"entity" + dr["id"] + "\" text=\"" + dr["Name"] + "\" isCheckbox=\"true\" checked=\"true\" display=\"none\" url=\"javascript:\" >");
                            //zhishudanwei
                            sb.Append("<node id=\"zhishuuser" + dr["id"] + "\" text=\"" + zhishu + "\" isCheckbox=\"true\" display=\"none\" url=\"javascript:\" >");
                        }
                        else
                        {
                            string childrenids = GetAllChildrenID_device(int.Parse(dr["id"].ToString()));
                            if (dr["id"].ToString() == DipatchId)
                            {
                                sb.Append("<node id=\"entity" + dr["id"] + "\" text=\"" + dr["Name"] + "\" isCheckbox=\"true\" checked=\"true\" url=\"javascript:\" childrenids=\"" + childrenids + "\">");
                                //zhishudanwei
                                sb.Append("<node id=\"zhishuuser" + dr["id"] + "\" text=\"" + zhishu + "\" isCheckbox=\"true\" url=\"javascript:\" childrenids=\"" + "["+dr["id"] +"]"+ "\">");
                            }
                            else
                            {
                                sb.Append("<node id=\"entity" + dr["id"] + "\" text=\"" + dr["Name"] + "\" isCheckbox=\"true\" url=\"javascript:\" childrenids=\"" + childrenids + "\">");
                                //zhishudanwei
                                sb.Append("<node id=\"zhishuuser" + dr["id"] + "\" text=\"" + zhishu + "\" isCheckbox=\"true\" url=\"javascript:\" childrenids=\"" + "[" + dr["id"] + "]" + "\">");
                            }
                        }
                        foreach (DataRow dtUserType in dtAllUserTypes.Rows)
                        {
                            sb.Append("<node id=\"usertype" + dtUserType["id"] + "\" text=\"" + dtUserType["TypeName"] + "\" typename=\"" + dtUserType["TypeName"] + "\" entityid=\"" + dr["id"] + "\" url=\"javascript:\">");
                            sb.Append("</node>");
                        }
                    }
                    else
                    {
                        if (dr["Depth"].ToString() == "-1")
                        {
                            sb.Append("<node id=\"entityroot\" text=\"" + dr["Name"] + "\" isCheckbox=\"true\" checked=\"true\" display=\"none\" url=\"javascript:\" >");
                            //zhishudanwei
                            sb.Append("<node id=\"zhishuuser" + dr["id"] + "\" text=\"" + zhishu + "\" isCheckbox=\"true\" display=\"none\" url=\"javascript:\" >");
                        }
                        else
                        {
                            sb.Append("<node id=\"entity" + dr["id"] + "\" text=\"" + dr["Name"] + "\" color=\"#857B7A\" url=\"javascript:\">");
                            //zhishudanweijiedian
                            sb.Append("<node id=\"zhishuuser" + dr["id"] + "\" text=\"" + zhishu + "\" color=\"#857B7A\" url=\"javascript:\">");
                        }
                        foreach (DataRow dtUserType in dtAllUserTypes.Rows)
                        {
                            sb.Append("<node id=\"usertype" + dtUserType["id"] + "\" text=\"" + dtUserType["TypeName"] + "\" typename=\"" + dtUserType["TypeName"] + "\" entityid=\"" + dr["id"] + "\" color=\"#857B7A\" url=\"javascript:\">");
                            sb.Append("</node>");
                        }
                    }
                    sb.Append("</node>");

                    sb.Append(GetEntityandType(dr["id"].ToString()));
                    sb.Append("</node>");
                //}
                //else
                //{
                //    sb.Append(GetEntityandType(dr["id"].ToString()));
                //}
            }
            return sb.ToString();
        }

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
        protected string GetAllChildrenID_device(int id)
        {
            StringBuilder sb = new StringBuilder();
            DataTable dt = DbComponent.SQLHelper.ExecuteRead(CommandType.Text, "WITH lmenu(name,id,[ParentID]) as (SELECT name,id,[ParentID]  FROM [Entity] WHERE id=@id UNION ALL    SELECT A.NAME,A.id,A.ParentID FROM [Entity] A,lmenu b    where a.ParentID = b.[ID]) select id from lmenu", "getParentID", new SqlParameter("id", id));
            
            for (int i = 0; i < dt.Rows.Count; i++)
            {                
                sb.Append("["+ dt.Rows[i][0].ToString() + "]");
            }
          
            return sb.ToString();
        }
        #endregion
        #region 查询下级及所有子级单位ID
        protected string GetAllChildrenID(int id)
        {
            StringBuilder sb = new StringBuilder();
            DataTable dt = DbComponent.SQLHelper.ExecuteRead(CommandType.Text, "WITH lmenu(name,id,[ParentID]) as (SELECT name,id,[ParentID]  FROM [Entity] WHERE id=@id UNION ALL    SELECT A.NAME,A.id,A.ParentID FROM [Entity] A,lmenu b    where a.ParentID = b.[ID]) select id from lmenu", "getParentID", new SqlParameter("id", id));
            sb.Append(",");
            for (int i = 0; i < dt.Rows.Count; i++)
            {                
                sb.Append(dt.Rows[i][0].ToString() + ",");
            }
          
            return sb.ToString();
        }
        #endregion
    }
}