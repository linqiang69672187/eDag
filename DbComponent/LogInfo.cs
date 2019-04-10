#region Version Info
/*=================版本信息======================
*Copyright (C)     QJJ
*All rights reserved
*guid1:            10b0aca1-9eb4-4883-982c-701580985be9
*作者：	           QJJ
*当前登录用户名:   qijianj
*机器名称:         RT-QIJIANJ
*注册组织名:       Microsoft
*CLR版本:          4.0.30319.17929
*当前工程名：      
*工程名：          
*新建项输入的名称: LogInfo
*命名空间名称:     DbComponent
*文件名:           LogInfo
*当前系统时间:     2013-10-10 星期四 18:13:16
*创建年份:         2013
*版本：
*
*功能说明：       
* 
* 修改者： 
* 时间：	   2013-10-10 星期四 18:13:16
* 修改说明：
*======================================================
*/
#endregion

using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Text;

namespace DbComponent
{
    public class LogInfo
    {
        String connstring = System.Configuration.ConfigurationManager.AppSettings["m_connectionString"];
        private static readonly log4net.ILog log = log4net.LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);

        public void GetOperationLog(ref IList<Object> objlist,Int32 id)
        {
            StringBuilder sbsql=new StringBuilder();
            sbsql.AppendFormat(" select sdate,schedulissi,schedulip,schedulusername,identitydeviceid,identitydevicetype,IdentityDeviceUnit,IdentityID,IdentityName,IdentityType,IdentityUnit,ModelName,Type,Content from operationLog where id={0}",id);
            SQLHelper.ExecuteDataReader(ref objlist, sbsql.ToString(), System.Data.CommandType.Text);
        }
    }
}
