﻿#region Version Info
/*=================版本信息======================
*Copyright (C)  QJJ
*All rights reserved
*guid1:            4b55b0a9-ae55-41a4-b8f7-003c175bf901
*作者：	           QJJ
*当前登录用户名:   zhkk
*机器名称:         RT-QIJIANJ
*注册组织名:       Microsoft
*CLR版本:          4.0.30319.18052
*当前工程名：      $safeprojectname$
*工程名：          $projectname$
*新建项输入的名称: DTProcedureType
*命名空间名称:     DbComponent
*文件名:           DTProcedureType
*当前系统时间:     2013/11/27 14:58:23
*创建年份:         2013
*版本：
*
*功能说明：       
* 
* 修改者： 
* 时间：	   2013/11/27 14:58:23
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
    public class DTProcedureType
    {
        private static readonly log4net.ILog log = log4net.LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);
        #region IDispatchInfoDao 成员

        
        #region
        /// <summary>
        /// 删除调度台
        /// </summary>
        /// <param name="DispatchID">需要删除的调度台ID</param>
        /// <returns>删除是否成功</returns>
        public Object DeleteModel_ProcedureInfo(string name)
        {
            IList<Object> objlist = new List<Object>();
            String strsql =string.Format("select name from _procedure where ptype='{0}'",name);
            SQLHelper.ExecuteDataReader(ref objlist, strsql);

            if (objlist.Count > 0)
                return objlist;
            strsql = "delete from procedure_type where name=@pname";
            int i = SQLHelper.ExecuteNonQuery(CommandType.Text, strsql, new SqlParameter("pname", name));
            if (i > 0)
                return true;
            else 
                return false;
        }
        #endregion

        public DataTable GetAllProcedure(string textseach, string sort, int startRowIndex, int maximumRows)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("select * from procedure_type ");
            if (!String.IsNullOrEmpty(textseach))
            {
                sb.AppendFormat("where name like '%{0}%'", textseach);
            }

            if (string.IsNullOrEmpty(sort))
            {
                sb.Append("order by id asc");
            }
            return SQLHelper.ExecuteRead(CommandType.Text, sb.ToString(), startRowIndex, maximumRows, "procedure_type");

        }

        public int getallProcedurecount(string textseach)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("select count(0) from procedure_type ");
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