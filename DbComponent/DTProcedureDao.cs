#region Version Info
/*=================版本信息======================
*Copyright (C)  QJJ
*All rights reserved
*guid1:            1f7810e1-b037-4e9a-b66b-5e4388d73de7
*作者：	           QJJ
*当前登录用户名:   zhkk
*机器名称:         RT-QIJIANJ
*注册组织名:       Microsoft
*CLR版本:          4.0.30319.18052
*当前工程名：      $safeprojectname$
*工程名：          $projectname$
*新建项输入的名称: DTProcedureDao
*命名空间名称:     DbComponent
*文件名:           DTProcedureDao
*当前系统时间:     2013/11/26 15:29:27
*创建年份:         2013
*版本：
*
*功能说明：       
* 
* 修改者： 
* 时间：	   2013/11/26 15:29:27
* 修改说明：
*======================================================
*/
#endregion

using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Reflection;
using System.Text;

namespace DbComponent
{
    public class DTProcedureDao
    {
        private static readonly log4net.ILog log = log4net.LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);
        #region IDispatchInfoDao 成员

        //public bool UpdateDispatchInfo(Model_Procedure newModel)
        //{
        //    StringBuilder sbSQL = new StringBuilder();
        //    sbSQL.Append("update Dispatch_Info set ");
        //    if (newModel.Entity_ID != null)
        //    {
        //        sbSQL.Append(" [Entity_ID] = '" + newModel.Entity_ID + "',");
        //    }
        //    if (newModel.ISSI != null)
        //    {
        //        sbSQL.Append(" [ISSI] = '" + newModel.ISSI + "',");
        //    }
        //    if (newModel.IPAddress != null)
        //    {
        //        sbSQL.Append(" [IPAddress] = '" + newModel.IPAddress + "',");
        //    }
        //    if (newModel.Login_ID != null)
        //    {
        //        sbSQL.Append(" [Login_ID] = '" + newModel.Login_ID + "',");
        //    }
        //    sbSQL.Append(" [CreateTime] = '" + DateTime.Now + "'");
        //    string strSql = sbSQL.ToString();
        //    //string strSql = sbSQL.ToString().Substring(0, sbSQL.ToString().Length - 1);
        //    strSql += " where ID=@ID";

        //    int i = 0;
        //    try
        //    {
        //        i = SQLHelper.ExecuteNonQuery(CommandType.Text, strSql, new SqlParameter("ID", newModel.ID));
        //        string slog = "edit dispatch information,dispatch id is " + newModel.ID + ",new ISSI is " + newModel.ISSI + ",entityid is " + newModel.Entity_ID + ",ip is " + newModel.IPAddress + ",rel user id is " + newModel.Login_ID;
        //        LogHelper.SetLog(slog, MyModel.Enum.LogLevel.edit);
        //        if (i > 0)
        //            return true;
        //        else return false;
        //    }
        //    catch (Exception ex)
        //    {
        //        log.Info(strSql);
        //        log.Error(ex);
        //        return false;
        //    }
        //}
        #region
        /// <summary>
        /// 删除调度台
        /// </summary>
        /// <param name="DispatchID">需要删除的调度台ID</param>
        /// <returns>删除是否成功</returns>
        public bool DeleteModel_ProcedureInfo(int id)
        {
            String strsql = "delete from _procedure where id=@id;delete from step where procedure_id=@id";
            int i = SQLHelper.ExecuteNonQuery(CommandType.Text, strsql, new SqlParameter("id", id));
            if (i > 0)
                return true;
            else return false;
        }
        #endregion

        public DataTable GetAllProcedure(string textseach, string sort, int startRowIndex, int maximumRows)
        {
                StringBuilder sb = new StringBuilder();
                sb.Append("select * from _procedure ");
                if (!String.IsNullOrEmpty(textseach)) 
                { 
                    sb.AppendFormat("where name like '%{0}%'",textseach); 
                }

                if (string.IsNullOrEmpty(sort))
                { 
                    sb.Append("order by id asc");
                }
                return SQLHelper.ExecuteRead(CommandType.Text, sb.ToString(), startRowIndex, maximumRows, "procedure");

        }

        public int getallProcedurecount(string textseach)
        {
                StringBuilder sb = new StringBuilder();
                sb.Append("select count(0) from _procedure ");
                if (!String.IsNullOrEmpty(textseach))
                {
                    sb.AppendFormat("where name like '%{0}%'", textseach);
                }
                return int.Parse(SQLHelper.ExecuteScalar(CommandType.Text, sb.ToString()).ToString());
        }

        /// <summary>
        /// 根据ID获取调度台信息
        /// </summary>
        /// <param name="ID">调度台ID</param>
        /// <returns>Model_Dispatch_View</returns>
        //public Model_Procedure GetModelDispatchViewByID(int ID)
        //{
        //    StringBuilder sbSql = new StringBuilder("select [Name],[ID],[ISSI],[Entity_ID],[IPAddress],[Login_ID] from [DispatchList_View]  where [ID]=@ID");
        //    DataTable dt = SQLHelper.ExecuteRead(CommandType.Text, sbSql.ToString(), "modelView", new SqlParameter("ID", ID));
        //    Model_Dispatch_View modelView = new Model_Dispatch_View();
        //    for (int dtcount = 0; dtcount < dt.Rows.Count; dtcount++)
        //    {
        //        modelView.ID = int.Parse(dt.Rows[dtcount]["ID"].ToString());
        //        modelView.IPAddress = dt.Rows[dtcount]["IPAddress"].ToString();
        //        modelView.ISSI = dt.Rows[dtcount]["ISSI"].ToString();
        //        modelView.Login_ID = dt.Rows[dtcount]["Login_ID"].ToString();
        //        modelView.EntityName = dt.Rows[dtcount]["Name"].ToString();
        //        modelView.Entity_ID = dt.Rows[dtcount]["Entity_ID"].ToString();
        //    }
        //    return modelView;
        //}

        //public Model_Dispatch_View GetModelDispatchViewByISSI(string ISSI)
        //{
        //    StringBuilder sbSql = new StringBuilder("select [Name],[ID],[ISSI],[Entity_ID],[IPAddress],[Login_ID] from [DispatchList_View]  where [ISSI]=@ISSI");
        //    DataTable dt = SQLHelper.ExecuteRead(CommandType.Text, sbSql.ToString(), "modelView", new SqlParameter("ISSI", ISSI));
        //    Model_Dispatch_View modelView = new Model_Dispatch_View();
        //    foreach (DataRow dr in dt.Rows)
        //    {
        //        modelView.ID = int.Parse(dr["ID"].ToString());
        //        modelView.IPAddress = dr["IPAddress"].ToString();
        //        modelView.ISSI = dr["ISSI"].ToString();
        //        modelView.Login_ID = dr["Login_ID"].ToString();
        //        modelView.EntityName = dr["Name"].ToString();
        //        modelView.Entity_ID = dr["Entity_ID"].ToString();
        //    }
        //    return modelView;
        //}

        #endregion
    }
}
