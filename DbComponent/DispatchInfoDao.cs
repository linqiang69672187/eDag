#region Author
/*
 *Modules:操作调度台数据库SqlServer实现类
 *CreateTime:2011-07-26
 *Author:杨德军    
 *Company:Eastcom
 **/

#endregion
using DbComponent.Comm;
using DbComponent.IDAO;
using MyModel;
using System;
using System.Data;
using System.Data.SqlClient;
using System.Reflection;
using System.Text;
using System.Web;
using System.Web.SessionState;

namespace DbComponent
{
    /// <summary>
    /// 操作调度台数据库SqlServer实现类
    /// </summary>
    public class DispatchInfoDao : IDispatchInfoDao, IRequiresSessionState,IReadOnlySessionState
    {
        private static readonly log4net.ILog log = log4net.LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType); 
        #region IDispatchInfoDao 成员
        #region 添加调度台
        /// <summary>
        /// 添加调度台
        /// </summary>
        /// <param name="model">新调度台 id不需要填写</param>
        /// <returns>添加成功返回ture 否则返回false</returns>
        public bool AddDispatchInfo(Model_Dispatch model)
        {
            StringBuilder sbSql = new StringBuilder();
            StringBuilder sbStr1 = new StringBuilder();
            StringBuilder sbStr2 = new StringBuilder();
            sbSql.Append("insert into Dispatch_Info (");
            if (!string.IsNullOrEmpty(model.ISSI))
            {
                sbStr1.Append("[ISSI],");
                sbStr2.Append("'" + model.ISSI + "',");
            }
            if (!string.IsNullOrEmpty(model.Entity_ID))
            {
                sbStr1.Append("[Entity_ID],");
                sbStr2.Append("'" + model.Entity_ID + "',");
            }
            if (!string.IsNullOrEmpty(model.IPAddress))
            {
                sbStr1.Append("[IPAddress],");
                sbStr2.Append("'" + model.IPAddress + "',");
            }
            if (!string.IsNullOrEmpty(model.Login_ID))
            {
                sbStr1.Append("[Login_ID],");
                sbStr2.Append("'" + model.Login_ID + "',");
            }
            sbStr1.Append("[CreateTime]");
            sbStr2.Append("'" + DateTime.Now + "'");
            sbSql.Append(sbStr1.ToString());
           // sbSql.Append(sbStr1.ToString().Substring(0, sbStr1.ToString().Length - 1));
            sbSql.Append(") values (");
            sbSql.Append(sbStr2.ToString());
           // sbSql.Append(sbStr2.ToString().Substring(0, sbStr2.ToString().Length - 1));
            sbSql.Append(")");
            try
            {
                SQLHelper.ExecuteNonQuery(CommandType.Text, sbSql.ToString());
                string slog = "add dispatch,issi is " + model.ISSI + ",entityid is " + model.Entity_ID + ",Ip is " + model.IPAddress + ",rel user id is " + model.Login_ID;
                LogHelper.SetLog(slog, MyModel.Enum.LogLevel.add);
                return true;
            }
            catch (Exception ex)
            {
                log.Info(sbSql.ToString());
                log.Error(ex);
                return false;
            }

        }
        #endregion
       
        public bool UpdateDispatchInfo(Model_Dispatch newModel)
        {
            StringBuilder sbSQL = new StringBuilder();
            sbSQL.Append("update Dispatch_Info set ");
            if (newModel.Entity_ID != null)
            {
                sbSQL.Append(" [Entity_ID] = '" + newModel.Entity_ID + "',");
            }
            if (newModel.ISSI != null)
            {
                sbSQL.Append(" [ISSI] = '" + newModel.ISSI + "',");
            }
            if (newModel.IPAddress != null)
            {
                sbSQL.Append(" [IPAddress] = '" + newModel.IPAddress + "',");
            }
            if (newModel.Login_ID != null)
            {
                sbSQL.Append(" [Login_ID] = '" + newModel.Login_ID + "',");
            }
            sbSQL.Append(" [CreateTime] = '" + DateTime.Now + "'");
            string strSql = sbSQL.ToString();
            //string strSql = sbSQL.ToString().Substring(0, sbSQL.ToString().Length - 1);
            strSql += " where ID=@ID";

            int i = 0;
            try
            {
                i = SQLHelper.ExecuteNonQuery(CommandType.Text, strSql, new SqlParameter("ID", newModel.ID));
                string slog = "edit dispatch information,dispatch id is " + newModel.ID + ",new ISSI is " + newModel.ISSI + ",entityid is " + newModel.Entity_ID + ",ip is " + newModel.IPAddress + ",rel user id is " + newModel.Login_ID;
                LogHelper.SetLog(slog, MyModel.Enum.LogLevel.edit);
                if (i > 0)
                    return true;
                else return false;
            }
            catch (Exception ex)
            {
                log.Info(strSql);
                log.Error(ex);
                return false;
            }
        }
        #region
        /// <summary>
        /// 删除调度台
        /// </summary>
        /// <param name="DispatchID">需要删除的调度台ID</param>
        /// <returns>删除是否成功</returns>
        public bool DeleteDispatchInfo(int DispatchID)
        {
            StringBuilder sbSQL = new StringBuilder("delete from Dispatch_Info where id=@id");
            int i = SQLHelper.ExecuteNonQuery(CommandType.Text, sbSQL.ToString(), new SqlParameter("id", DispatchID));
            if (i > 0)
                return true;
            else return false;
        }
        #endregion

        public DataTable GetAllDsipatch(int selectcondition, string textseach, int id, string stringid, string sort, int startRowIndex, int maximumRows)
        {
            if (stringid == null)
            {
                string sqlcondition = "";
                if (selectcondition != 0) { sqlcondition += " and [Entity_ID]='" + selectcondition + "'"; }
                //if (id != 0) {
                //    sqlcondition += " and [Entity_ID]='" + id + "'"; 
                //}
                if (textseach != null) { sqlcondition += " and [ISSI] like '%" + stringfilter.Filter(textseach.Trim()) + "%'"; }
                if (sort == "") { sort = "id asc"; }
                StringBuilder sbSQL = new StringBuilder();
                sbSQL.Append("WITH lmenu(name,id) as (SELECT name,id  FROM [Entity] WHERE id=@id UNION ALL SELECT A.NAME,A.id FROM [Entity] A,lmenu b    where a.[ParentID] = b.id)  select  [Name],[ID],[ISSI] ,[Entity_ID] ,[IPAddress]  ,[Login_ID] from [DispatchList_View] where len([ISSI]) > 0 and [Entity_ID] in (select id from lmenu) " + sqlcondition + " order by " + sort);
                return SQLHelper.ExecuteRead(CommandType.Text, sbSQL.ToString(), startRowIndex, maximumRows, "DispatchList_View", new SqlParameter("id", id));

            }
            else
            {
                return SQLHelper.ExecuteRead(CommandType.Text, "select * from [DispatchList_View] where len([ISSI]) > 0 and id =@id ", startRowIndex, maximumRows, "DispatchList_View", new SqlParameter("id", stringid));
            }
        }

        public int getallIIScount(int selectcondition, string textseach, int id, string stringid)
        {
            if (stringid == null)
            {
                string sqlcondition = "";
                if (selectcondition != 0) { sqlcondition += " and [Entity_ID]='" + selectcondition + "'"; }
                //if (id != 0)
                //{
                //    sqlcondition += " and [Entity_ID]='" + id + "'";
                //}
                if (textseach != null) { sqlcondition += " and [ISSI] like '%" + stringfilter.Filter(textseach.Trim()) + "%'"; }

                StringBuilder sbSQL = new StringBuilder();
                sbSQL.Append("WITH lmenu(name,id) as (SELECT name,id  FROM [Entity] WHERE id=@id UNION ALL SELECT A.NAME,A.id FROM [Entity] A,lmenu b    where a.[ParentID] = b.id) select  count(*) from [DispatchList_View] where len([ISSI]) > 0 and [Entity_ID] in (select id from lmenu)" + sqlcondition);
                return int.Parse(SQLHelper.ExecuteScalar(CommandType.Text, sbSQL.ToString(), new SqlParameter("id", id)).ToString());

            }
            else
            {
                return int.Parse(SQLHelper.ExecuteScalar(CommandType.Text, "select count(0) from [DispatchList_View] where len([ISSI]) > 0 and id =@id ", new SqlParameter("id", stringid)).ToString());
            }
        }

        /// <summary>
        /// 根据ID获取调度台信息
        /// </summary>
        /// <param name="ID">调度台ID</param>
        /// <returns>Model_Dispatch_View</returns>
        public Model_Dispatch_View GetModelDispatchViewByID(int ID)
        {
            StringBuilder sbSql = new StringBuilder("select [Name],[ID],[ISSI],[Entity_ID],[IPAddress],[Login_ID] from [DispatchList_View]  where [ID]=@ID");
            DataTable dt = SQLHelper.ExecuteRead(CommandType.Text, sbSql.ToString(), "modelView", new SqlParameter("ID", ID));
            Model_Dispatch_View modelView = new Model_Dispatch_View();
            for (int dtcount = 0; dtcount < dt.Rows.Count; dtcount++)
            {
                modelView.ID = int.Parse(dt.Rows[dtcount]["ID"].ToString());
                modelView.IPAddress = dt.Rows[dtcount]["IPAddress"].ToString();
                modelView.ISSI = dt.Rows[dtcount]["ISSI"].ToString();
                modelView.Login_ID = dt.Rows[dtcount]["Login_ID"].ToString();
                modelView.EntityName = dt.Rows[dtcount]["Name"].ToString();
                modelView.Entity_ID = dt.Rows[dtcount]["Entity_ID"].ToString();
            }
            return modelView;
        }

        public Model_Dispatch_View GetModelDispatchViewByISSI(string ISSI)
        {
            StringBuilder sbSql = new StringBuilder("select [Name],[ID],[ISSI],[Entity_ID],[IPAddress],[Login_ID] from [DispatchList_View]  where [ISSI]=@ISSI");
            DataTable dt = SQLHelper.ExecuteRead(CommandType.Text, sbSql.ToString(), "modelView", new SqlParameter("ISSI", ISSI));
            Model_Dispatch_View modelView = new Model_Dispatch_View();
            foreach (DataRow dr in dt.Rows )
            {
                modelView.ID = int.Parse(dr["ID"].ToString());
                modelView.IPAddress = dr["IPAddress"].ToString();
                modelView.ISSI = dr["ISSI"].ToString();
                modelView.Login_ID = dr["Login_ID"].ToString();
                modelView.EntityName = dr["Name"].ToString();
                modelView.Entity_ID = dr["Entity_ID"].ToString();
            }
            return modelView;
        }
        public DataTable GetDispatchsByEntityId(string entityId)
        {
            string strSQL = " SELECT id,IPAddress uname,issi uissi,utype='" + Ryu666.Components.ResourceManager.GetString("Dispatch") + "',ucheck='0' from Dispatch_Info where issi!=''  ";
            return SQLHelper.ExecuteRead(CommandType.Text, strSQL, "bds");
        }
        #endregion


      
    }
}
