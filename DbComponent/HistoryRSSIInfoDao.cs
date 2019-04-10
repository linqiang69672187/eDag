using DbComponent.IDAO;
using MyModel;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;

namespace DbComponent
{
    public class HistoryRSSIInfoDao : IHistoryRSSIInfoDao
    {
        public DataTable getHistoryRSSIInfos(DateTime startTime, DateTime endTime,double minX,double minY,double maxX,double maxY)
        {
            SqlParameter[] parameter = new SqlParameter[] {
            new SqlParameter("startTime",startTime),
            new SqlParameter("endTime",endTime),
            new SqlParameter("minX",minX),
            new SqlParameter("minY",minY),
            new SqlParameter("maxX",maxX),
            new SqlParameter("maxY",maxY)
            };
            StringBuilder sql = new StringBuilder("select top 1000000 * from HistoryRSSI_info where (Longitude between @minX and @maxX) and (Latitude between @minY and @maxY)  and inserttb_time between @startTime and @endTime");
            DataTable dt = SQLHelper.ExecuteRead(CommandType.Text, sql.ToString(), "HistoryRSSIInfo", parameter);
            return dt;
        }
    }
}
