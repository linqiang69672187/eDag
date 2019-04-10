using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;

namespace DbComponent.StatuesManage
{
    public class ProcedureDao
    {
        /// <summary>

        /// 获取所有流程列表
        /// </summary>
        /// <returns></returns>
        public DataTable getProcedureList() {
            String strSQL = "select id,name from _procedure";
            return DbComponent.SQLHelper.ExecuteRead(CommandType.Text, strSQL, "getprocedure");
        }
    }
}
