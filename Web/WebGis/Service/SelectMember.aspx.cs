using Ryu666.Components;
using System;
using System.Data;

namespace Web.WebGis.Service
{
    public partial class SelectMember : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            int id = int.Parse(Request.QueryString["id"].ToString());                                              /**ID**/
            string type = Server.UrlDecode(Request.QueryString["type"].ToString());                                                 /**类型**/
            string treedepth = Request.QueryString["treedepth"].ToString();                                       /**层级**/
            string tabtype = Server.UrlDecode(Request.QueryString["url"].ToString());                                       /**tab窗口类型**/
            string urltype = null;
            string sqltext = null;

            if (tabtype == Ryu666.Components.ResourceManager.GetString("police"))//多语言:警员
            {
                switch (treedepth)
                {
                    case "0":
                        sqltext = "WITH lmenu(name,id) as (SELECT name,id  FROM [Entity] WHERE id=@id UNION ALL    SELECT A.NAME,A.id FROM [Entity] A,lmenu b    where a.[ParentID] = b.id) SELECT (select [Name] from [Entity] where ID=[Entity_ID]),[type],[ISSI],[Nam],[ID] FROM [User_info] where [Entity_ID] in (select id from lmenu)";
                        break;
                    case "1":

                        sqltext = "SELECT (select [Name] from [Entity] where ID=[Entity_ID]),[type],[ISSI],[Nam],[ID] FROM [User_info] where [Entity_ID] =@id and type ='" + type + "'";

                        break;
                    case "2":
                        sqltext = "SELECT (select [Name] from [Entity] where ID=[Entity_ID]),[type],[ISSI],[Nam],[ID] FROM [User_info] where [ID] =@id";
                        break;
                    default:
                        break;
                }
                urltype = "Group_info";
            }
            else if (tabtype == Ryu666.Components.ResourceManager.GetString("Terminal"))//多语言:终端
            {
                switch (treedepth)
                {
                    case "0":
                        sqltext = "WITH lmenu(name,id) as (SELECT name,id  FROM [Entity] WHERE id=@id UNION ALL    SELECT A.NAME,A.id FROM [Entity] A,lmenu b    where a.[ParentID] = b.id) SELECT (select [Name] from [Entity] where ID=a.[Entity_ID]),'" + Ryu666.Components.ResourceManager.GetString("Terminal") + "',a.[ISSI],(SELECT [Nam] FROM [User_info] where ISSI = a.[ISSI]),a.[ID] FROM [ISSI_info] a where a.[Entity_ID] in (select id from lmenu)";//多语言:终端
                        break;
                    case "1":
                        sqltext = "SELECT (select [Name] from [Entity] where ID=a.[Entity_ID]),'" + Ryu666.Components.ResourceManager.GetString("Terminal") + "',a.[ISSI],(SELECT [Nam] FROM [User_info] where ISSI = a.[ISSI]),a.[ID] FROM [ISSI_info] a where [Entity_ID] =@id ";//多语言:终端
                        break;
                    case "2":
                        sqltext = "SELECT (select [Name] from [Entity] where ID=a.[Entity_ID]),'" + Ryu666.Components.ResourceManager.GetString("Terminal") + "',a.[ISSI],(SELECT [Nam] FROM [User_info] where ISSI = a.[ISSI]),a.[ID] FROM [ISSI_info] a where [ID] =@id";//多语言:终端
                        break;
                    default:
                        break;
                }
                urltype = "ISSI_info";
            }
            else if (tabtype == Ryu666.Components.ResourceManager.GetString("Dispatch"))//多语言:调度台
            {
                switch (treedepth)
                {
                    case "0":
                        sqltext = "WITH lmenu(name,id) as (SELECT name,id  FROM [Entity] WHERE id=@id UNION ALL    SELECT A.NAME,A.id FROM [Entity] A,lmenu b    where a.[ParentID] = b.id) SELECT (select [Name] from [Entity] where ID=a.[Entity_ID]),'" + Ryu666.Components.ResourceManager.GetString("Dispatch") + "',a.[ISSI],'" + Ryu666.Components.ResourceManager.GetString("Dispatch") + "',a.[ID] FROM [Dispatch_Info] a where a.[Entity_ID] in (select id from lmenu)";//多语言:调度台
                        break;
                    case "1":
                        sqltext = "SELECT (select [Name] from [Entity] where ID=a.[Entity_ID]),'" + Ryu666.Components.ResourceManager.GetString("Dispatch") + "',a.[ISSI],'" + Ryu666.Components.ResourceManager.GetString("Dispatch") + "',a.[ID] FROM [Dispatch_Info] a where [Entity_ID] =@id ";//多语言:调度台
                        break;
                    case "2":
                        sqltext = "SELECT (select [Name] from [Entity] where ID=a.[Entity_ID]),'" + Ryu666.Components.ResourceManager.GetString("Dispatch") + "',a.[ISSI],'" + Ryu666.Components.ResourceManager.GetString("Dispatch") + "',a.[ID] FROM [Dispatch_Info] a where [ID] =@id";//多语言:调度台
                        break;
                    default:
                        break;
                }
                urltype = "Dispatch_Info";
            }
            else if (tabtype == Ryu666.Components.ResourceManager.GetString("Group"))//多语言:编组
            {
                switch (treedepth)
                {
                    case "0":
                        sqltext = "WITH lmenu(name,id) as (SELECT name,id  FROM [Entity] WHERE id=@id UNION ALL    SELECT A.NAME,A.id FROM [Entity] A,lmenu b    where a.[ParentID] = b.id) SELECT (select [Name] from [Entity] where ID=a.[Entity_ID]) ,'" + Ryu666.Components.ResourceManager.GetString("Group") + "',a.[GSSI],a.[Group_name],a.[ID] From [Group_info] a where a.[Entity_ID] in (select id from lmenu) UNION ALL SELECT (select [Name] from [Entity] where ID=a.[Entity_ID]) ,'" + Ryu666.Components.ResourceManager.GetString("Group") + "',a.[GSSI],a.[Group_name],a.[ID] from [DTGroup_info] a where a.[Entity_ID] in (select id from lmenu)";//多语言:编组
                        break;
                    case "1":

                        if (type == ResourceManager.GetString("smallGroup"))//多语言:小组
                        {
                            sqltext = "SELECT (select [Name] from [Entity] where ID=a.[Entity_ID]) ,'" + Ryu666.Components.ResourceManager.GetString("Group") + "',a.[GSSI],a.[Group_name],a.[ID] From [Group_info] a where a.[Entity_ID] =@id and LEN(GSSIS) <2";//多语言:编组
                        }
                        else if (type == ResourceManager.GetString("multicastgroup"))//多语言:通播组
                        {
                            sqltext = "SELECT (select [Name] from [Entity] where ID=a.[Entity_ID]) ,'" + Ryu666.Components.ResourceManager.GetString("Group") + "',a.[GSSI],a.[Group_name],a.[ID] From [Group_info] a where a.[Entity_ID] =@id and LEN(GSSIS) <2";//多语言:编组
                        }
                        else if (type == ResourceManager.GetString("dtgroup"))//多语言:动态重组组
                        {
                            sqltext = "SELECT (select [Name] from [Entity] where ID=a.[Entity_ID]) ,'" + Ryu666.Components.ResourceManager.GetString("Group") + "',a.[GSSI],a.[Group_name],a.[ID] From [DTGroup_info] a where a.[Entity_ID] =@id";//多语言:编组
                        }
                        else if (type == ResourceManager.GetString("Group"))//多语言:编组
                        {
                            sqltext = "SELECT (select [Name] from [Entity] where ID=a.[Entity_ID]) ,'" + Ryu666.Components.ResourceManager.GetString("Group") + "',a.[GSSI],a.[Group_name],a.[ID] From [Group_info] a where a.[Entity_ID] =@id UNION ALL SELECT (select [Name] from [Entity] where ID=a.[Entity_ID]) ,'" + Ryu666.Components.ResourceManager.GetString("Group") + "',a.[GSSI],a.[Group_name],a.[ID] From [DTGroup_info] a where a.[Entity_ID] =@id";//多语言:编组
                        }

                        break;
                    case "2":

                        if (type == ResourceManager.GetString("smallGroup"))//多语言:小组
                        {
                            sqltext = "SELECT (select [Name] from [Entity] where ID=a.[Entity_ID]) ,'" + Ryu666.Components.ResourceManager.GetString("Group") + "',a.[GSSI],a.[Group_name],a.[ID] From [Group_info] a where a.[id] =@id";//多语言:编组
                        }
                        else if (type == ResourceManager.GetString("multicastgroup"))//多语言:通播组
                        {
                            sqltext = "SELECT (select [Name] from [Entity] where ID=a.[Entity_ID]) ,'" + Ryu666.Components.ResourceManager.GetString("Group") + "',a.[GSSI],a.[Group_name],a.[ID] From [Group_info] a where a.[id] =@id";//多语言:编组
                        }
                        else if (type == ResourceManager.GetString("dtgroup"))//多语言:动态重组组
                        {
                            sqltext = "SELECT (select [Name] from [Entity] where ID=a.[Entity_ID]) ,'" + Ryu666.Components.ResourceManager.GetString("Group") + "',a.[GSSI],a.[Group_name],a.[ID] From [DTGroup_info] a where a.[id] =@id";//多语言:编组
                        }

                        urltype = "Group_info";
                        break;
                    default:
                        break;
                }
            }
            else if (tabtype == Ryu666.Components.ResourceManager.GetString("Person"))//多语言:人员
            {
                switch (treedepth)
                {
                    case "0":
                        sqltext = "WITH lmenu(name,id) as (SELECT name,id  FROM [Entity] WHERE id=@id UNION ALL    SELECT A.NAME,A.id FROM [Entity] A,lmenu b    where a.[ParentID] = b.id) SELECT (select [Name] from [Entity] where ID=[Entity_ID]),[type],[ID],[Nam],[ID] FROM [User_info] where [Entity_ID] in (select id from lmenu)";
                        break;
                    case "1":
                        sqltext = "SELECT (select [Name] from [Entity] where ID=[Entity_ID]),[type],[ID],[Nam],[ID] FROM [User_info] where [Entity_ID] =@id and type ='" + type + "'";
                        break;
                    case "2":
                        sqltext = "SELECT (select [Name] from [Entity] where ID=[Entity_ID]),[type],[ID],[Nam],[ID] FROM [User_info] where [ID] =@id";
                        break;
                    default:
                        break;
                }
                urltype = "use_info";
            }

            DataTable dt = DbComponent.SQLHelper.ExecuteRead(CommandType.Text, sqltext, "selectmember", new System.Data.SqlClient.SqlParameter("id", id));
            System.Text.StringBuilder st = new System.Text.StringBuilder();
            st.Append("[");
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                if (i > 0) { st.Append(","); }
                st.Append("{ \"entity\":\"" + dt.Rows[i][0] + "\", \"type\":\"" + dt.Rows[i][1] + "\", \"ISSI\":\"" + dt.Rows[i][2] + "\", \"name\":\"" + dt.Rows[i][3] + "\", \"id\":\"" + dt.Rows[i][4] + "\", \"SQLType\":\"" + urltype + "\"}");
            }
            st.Append("]");
            Response.Write(st);
            Response.End();

        }
    }
}