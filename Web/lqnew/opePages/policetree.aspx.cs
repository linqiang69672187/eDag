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
    public partial class policetree :BasePage
    {
        public DataTable dtAllUsers = new DataTable();
        protected void Page_Load(object sender, EventArgs e)
        {
            //log.Info("开始allusers：" + DateTime.Now.ToString() + "." + DateTime.Now.Millisecond.ToString());
            string objtype = Request.QueryString["objtype"];
            string value = Request.QueryString["value"];
            string usertype_entityid = Request.QueryString["usertype_entityid"];
            //objtype = "entity";
            //value = "1";
            string strAllUsers = "";
            if (objtype == "entity")
            {
                strAllUsers = "select a.id,Nam,a.ISSI,[type],useid, typeName terminalType, c.status from User_info a left join User_onlines b on (a.id=b.useid) left join ISSI_info c on (a.ISSI = c.ISSI) where a.Entity_ID = " + value;
               
            }
            else if (objtype == "zhishuuser"){
                strAllUsers = "select a.id,Nam,a.ISSI,[type],useid, typeName terminalType,c.status from User_info a left join User_onlines b on (a.id=b.useid) left join ISSI_info c on (a.ISSI = c.ISSI) where a.Entity_ID = " + value;
                //dtAllUsers = SQLHelper.ExecuteRead(CommandType.Text, strAllUsers, "allusers");
            }
            else if (objtype == "usertype")
            {
                strAllUsers = "select a.id,Nam,a.ISSI,[type],useid, typeName terminalType, c.status from User_info a left join User_onlines b on (a.id=b.useid) left join ISSI_info c on (a.ISSI = c.ISSI) where a.Entity_ID = '" + usertype_entityid + "' and type = '" + value + "'";
                //dtAllUsers = SQLHelper.ExecuteRead(CommandType.Text, strAllUsers, "allusers");
            }
            else if (objtype == "search") {
                //搜全部
                if (usertype_entityid == null || usertype_entityid == "")
                {
                    string searchtype = value.Split('/')[0];
                    string searchtext = value.Split('/')[1];
                    int entity_id = int.Parse(Request.Cookies["id"].Value);
                    //strAllUsers = "WITH lmenu(id) as (SELECT id FROM [Entity] WHERE id='" + entity_id + "' UNION ALL SELECT A.id FROM [Entity] A,lmenu B where a.[ParentID] = B.id) select a.id,Nam,a.ISSI,[type],useid, typeName terminalType, c.status from User_info a left join User_onlines b on (a.id=b.useid) left join ISSI_info c on (a.ISSI = c.ISSI) where a." + searchtype + " like " + "'%" + searchtext + "%' and a.Entity_ID in(select id from lmenu)";
                    //添加权限管理
                    strAllUsers = "select a.id,Nam,a.ISSI,a.Entity_ID,[type],useid, c.typeName terminalType, c.status,u.ID as usertypeId from User_info a left join User_onlines b on (a.id=b.useid) left join ISSI_info c on (a.ISSI = c.ISSI) left join UserType u on (a.type=u.TypeName) where a." + searchtype + " like " + "'%" + searchtext + "%'";
                //dtAllUsers = SQLHelper.ExecuteRead(CommandType.Text, strAllUsers, "allusers");
                }
                    //搜本单位
                else {
                    string searchtype = value.Split('/')[0];
                    string searchtext = value.Split('/')[1];
                    strAllUsers = "select a.id,Nam,a.ISSI,[type],useid, typeName terminalType, c.status from User_info a left join User_onlines b on (a.id=b.useid) left join ISSI_info c on (a.ISSI = c.ISSI) where a.Entity_ID = '" + usertype_entityid + "' and a." + searchtype + " like " + "'%" + searchtext + "%'";                    
                }
            }
            
            dtAllUsers = SQLHelper.ExecuteRead(CommandType.Text, strAllUsers, "allusers");
           
            string HDISSI = DbComponent.login.GETHDISSI(Request.Cookies["username"].Value.Trim());
            //string IsOnline = "select * from User_onlines";
            //DataTable dt_Isonlines = SQLHelper.ExecuteRead(CommandType.Text, IsOnline, "IsOnline");
            
            DataColumn dc = new DataColumn("isonline", typeof(bool));
            dtAllUsers.Columns.Add(dc);
            DataColumn dcdisplay = new DataColumn("IsDisplay", typeof(bool));
            dtAllUsers.Columns.Add(dcdisplay);
          
            foreach (DataRow dr in dtAllUsers.Rows)
            {                
                string issi = "<" + dr["ISSI"].ToString() + ">";
                dr["IsDisplay"] = (HDISSI.Contains(issi)) ? false : true;
                dr["isonline"] = dr["useid"].ToString() == "" ? false : true;
                dr["terminalType"] = dr["terminalType"].ToString().Trim();
                //dr["isonline"] = (dt_Isonlines.Select().Where(a => a.Field<int>("useid") == (int)dr["id"]).ToArray<DataRow>().Length > 0) ? true : false;
            }
          
            string allpolices = DbComponent.Comm.TypeConverter.DataTable2ArrayJson(dtAllUsers);
            //log.Info("结束allusers：" + DateTime.Now.ToString() + "." + DateTime.Now.Millisecond.ToString());
            Response.Write(allpolices);
            Response.End();
        }
    }
}