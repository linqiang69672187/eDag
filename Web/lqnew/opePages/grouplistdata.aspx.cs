using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using DbComponent;

namespace Web.lqnew.opePages
{
    public partial class grouplistdata : System.Web.UI.Page
    {
        public DataTable dtAllUsers = new DataTable();
        protected void Page_Load(object sender, EventArgs e)
        {
            string type = "";
            if(Request.QueryString["type"]!=null){
                type = Request.QueryString["type"];
            }
            string value = "";
            if(Request.QueryString["value"]!=null){
                value = Request.QueryString["value"].ToString().Trim();
            }
            string clickItemType = "";
            if (Request.QueryString["clickItemType"] != null)
            {
                clickItemType = Request.QueryString["clickItemType"];
            }

            string strSQL = "";
            if (type == "search")
            {
                strSQL = "SELECT g.id,Group_name uname,GSSI,e.Name as EntityName from Group_info g left join Entity e on (g.Entity_ID=e.ID)  where GSSI!='' and (Group_name like '%" + value + "%' or GSSI  like '%" + value + "%') ";
            }
            else {
                String entityId = value;                
                if (clickItemType == "entity") {
                    string CTE = "WITH lmenu(name,id) as (SELECT name,id  FROM [Entity] WHERE id='" + entityId + "' UNION ALL SELECT A.NAME,A.id FROM [Entity] A,lmenu b where a.[ParentID] = b.id) ";
                    strSQL = CTE + " SELECT g.id,Group_name uname,GSSI,e.Name as EntityName from Group_info g left join Entity e on (g.Entity_ID=e.ID) where GSSI!='' and Entity_ID in (select id from lmenu)";
                }
                else if(clickItemType == "zhishu"){
                    strSQL = "SELECT g.id,Group_name uname,GSSI,e.Name as EntityName from Group_info g left join Entity e on (g.Entity_ID=e.ID) where GSSI!='' and Entity_ID ='" + entityId + "'";
                }
            }
            dtAllUsers = SQLHelper.ExecuteRead(CommandType.Text, strSQL, "allusers");
            string allpolices = DbComponent.Comm.TypeConverter.DataTable2ArrayJson(dtAllUsers);
            
            Response.Write(allpolices);
            Response.End();
        }
    }
}