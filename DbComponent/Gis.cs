using System;
using System.Data;
using System.Data.SqlClient;
using System.Text;

namespace DbComponent
{
    public class Gis
    {
        #region 删除该单位所有GIS信息
        public void DelGis(int Entityid)
        {
            SQLHelper.ExecuteNonQuery(CommandType.Text, "DELETE FROM [GIS_info] WHERE [User_ID] in (SELECT [id] FROM [User_info] where [Entity_ID]=@Entityid)", new SqlParameter("Entityid", Entityid));
        }
        #endregion

        #region 删除该单位所有历史GIS信息
        public void DelHistoryGis(int Entityid)
        {
            SQLHelper.ExecuteNonQuery(CommandType.Text, "DELETE FROM [HistoryGIS_info] WHERE [User_ID] in (SELECT [id] FROM [User_info] where [Entity_ID]=@Entityid)", new SqlParameter("Entityid", Entityid));
        }
        #endregion

        #region 根据用户ID查询ISSI
        public static string GetISSI(int useid)
        {
            return SQLHelper.ExecuteScalar(CommandType.Text, "SELECT top 1 [ISSI] FROM [dbo].[GIS_info] where [User_ID] = @useid", new SqlParameter("useid", useid)).ToString();
        }
        #endregion

        #region 获取某个时间段内的某个用户轨迹
        /// <summary>
        /// 获取某个时间段内的某个用户轨迹 （杨德军 2011-6-2 添加）
        /// </summary>
        /// <param name="UserID">用户ID</param>
        /// <param name="BegTime">开始时间</param>
        /// <param name="EndTime">结束时间</param>
        /// <param name="PageIndex">当前第几页</param>
        /// <param name="Limit">每页显示条数</param>
        /// <param name="BFMD">播放密度</param>
        /// <returns>满足条件的GIS轨迹 DataTable里DataRow的列明分别为： dr["Longitude"],dr["Latitude"]</returns>
        public static DataTable GetHistoryGisByUserID(int UserID, DateTime BegTime, DateTime EndTime, string PageIndex, string Limit,string BFMD)
        {
            int Start = 0;
            int End = 10;
            if (PageIndex == "1")
            {
                Start = 1;
            }
            else
            {
                Start = (int.Parse(PageIndex) - 1) * int.Parse(Limit) + 1;
            }
            End = Start + int.Parse(Limit) - 1;

            StringBuilder sbSql = new StringBuilder();

            sbSql.Append(" select a.[Longitude],a.[Latitude],a.[Send_time],rownms from ( ");
            sbSql.Append(" select  [Longitude],[Latitude],[Send_time],ROW_NUMBER() over(order by [Send_time] asc) rownms ");
            sbSql.Append(" from [HistoryGIS_info]  ");
            //sbSql.Append(",");
            //sbSql.Append(" (select max(Send_time) as Send_time from HistoryGIS_info  where User_ID=@User_ID  )  super");
            sbSql.Append(" where USER_ID=@User_ID ");
            sbSql.Append(" and ([Longitude]!=0.0000000 or [Latitude]!=0.0000000) ");
            //sbSql.Append(" and datediff(MI,super.[Send_time],temp.[Send_time]) % @BFMD=0 ");
            sbSql.Append(" and [Send_time]>=@BegTime and [Send_time]<=@EndTime ");
            sbSql.Append(" ) a");
            sbSql.Append(" Where  rownms between @Start and @End ");



            SqlParameter[] par = new SqlParameter[] { 
            new SqlParameter("User_ID", UserID),
            new SqlParameter("BegTime",BegTime),
            new SqlParameter("EndTime",EndTime),
            new SqlParameter("Start",Start),
            new SqlParameter("End",End)
            //,
            //new SqlParameter("BFMD",BFMD)
            };

            return SQLHelper.ExecuteRead(CommandType.Text, sbSql.ToString(), "GIS", par);
        }
        #endregion

        public static DataTable GetHistoryGisByUserID(int UserID, DateTime BegTime, DateTime EndTime, string BFMD)
        {


            StringBuilder sbSql = new StringBuilder();

            sbSql.Append(" select a.[Longitude],a.[Latitude],a.[Send_time],rownms from ( ");
            sbSql.Append(" select  [Longitude],[Latitude],[Send_time],ROW_NUMBER() over(order by [Send_time] asc) rownms ");
            sbSql.Append(" from [HistoryGIS_info]  ");
            //sbSql.Append(",");
            //sbSql.Append(" (select max(Send_time) as Send_time from HistoryGIS_info  where User_ID=@User_ID  )  super");
            sbSql.Append(" where USER_ID=@User_ID ");
            sbSql.Append(" and ([Longitude]!=0.0000000 or [Latitude]!=0.0000000) ");
            //sbSql.Append(" and datediff(MI,super.[Send_time],temp.[Send_time]) % @BFMD=0 ");
            sbSql.Append(" and [Send_time]>=@BegTime and [Send_time]<=@EndTime ");
            sbSql.Append(" ) a");



            SqlParameter[] par = new SqlParameter[] { 
            new SqlParameter("User_ID", UserID),
            new SqlParameter("BegTime",BegTime),
            new SqlParameter("EndTime",EndTime)
            //,
            //new SqlParameter("BFMD",BFMD)
            };

            return SQLHelper.ExecuteRead(CommandType.Text, sbSql.ToString(), "GIS", par);
        }

        public static string GetHistoryResultTotalCount(int UserID, DateTime BegTime, DateTime EndTime, string BFMD)
        {
            StringBuilder sbSql = new StringBuilder();
            sbSql.Append(" select  COUNT(0) ");
            sbSql.Append(" from (select  User_ID,[Longitude],[Latitude],[Send_time],ROW_NUMBER() over(order by [Send_time] asc) rownms ");
            sbSql.Append(" from [HistoryGIS_info] ");
            sbSql.Append(" where [User_ID]=@User_ID  ");
            sbSql.Append(" and [Send_time]>=@BegTime and [Send_time]<=@EndTime ");
            sbSql.Append(" and ([Longitude]!=0.0000000 or [Latitude]!=0.0000000) )temp  ");
            //sbSql.Append(",");
            //sbSql.Append(" (select  [Send_time] from HistoryGIS_info ");
            //sbSql.Append(" where Send_time=( ");
            //sbSql.Append(" select max(Send_time) ");
            //sbSql.Append(" from HistoryGIS_info  )) super ");
            //sbSql.Append(" where datediff(MI,super.[Send_time],temp.[Send_time]) %  @BFMD=0 ");

            SqlParameter[] par = new SqlParameter[] { 
            new SqlParameter("User_ID", UserID),
            new SqlParameter("BegTime",BegTime),
            new SqlParameter("EndTime",EndTime)
            //,
            //new SqlParameter("BFMD",BFMD)
            };
            //DataTable dt = SQLHelper.ExecuteRead(CommandType.Text, sbSql.ToString(), "GIS", par);
            object ocount = SQLHelper.ExecuteScalar(CommandType.Text, sbSql.ToString(), par);
            if (ocount != null)
            {
                return ocount.ToString();
            }
            else {
                return "0";
            }
            
        }

        #region 获取该单位某个时间后N条
        public static DataTable gettrace_id(int id, DateTime send_time, int lineint)
        {
            if (lineint == 0)
            {
                return SQLHelper.ExecuteRead(CommandType.Text, "select  [Longitude],[Latitude] from [HistoryGIS_info] WHERE User_ID =" + id + " and Inserttb_time >='" + send_time + "'  and Position_err not in ('Position_error_not_known','Lost_ability_to_determine_location') and Longitude <> 0  order by id desc", "Trace");
            }
            else
            {
                return SQLHelper.ExecuteRead(CommandType.Text, "select top " + lineint + " [Longitude],[Latitude] from [HistoryGIS_info] WHERE User_ID =" + id + " and Inserttb_time >='" + send_time + "'   and Position_err not in ('Position_error_not_known','Lost_ability_to_determine_location') and Longitude <> 0 order by id desc", "Trace");
            }
        }
        #endregion

        #region 获取该单位某个时间前N条
        public static DataTable gethisorytrace_id(int id, DateTime send_time, int lineint)
        {
            if (lineint == 0)
            {
                return SQLHelper.ExecuteRead(CommandType.Text, "select  [Longitude],[Latitude] from [HistoryGIS_info] WHERE User_ID =" + id + " and Inserttb_time >='2012-05-23 13:00:00.123'  and Inserttb_time <='2012-05-24 15:05:30.123'  and Position_err not in ('Position_error_not_known','Lost_ability_to_determine_location') and Longitude <> 0  order by id desc", "Trace");
            }
            else
            {
                return SQLHelper.ExecuteRead(CommandType.Text, "select top " + lineint + " [Longitude],[Latitude] from [HistoryGIS_info] WHERE User_ID =" + id + " and Inserttb_time >='2011-06-29 12:30:30.123'  and Inserttb_time <='2011-06-29 15:05:30.123'   and Position_err not in ('Position_error_not_known','Lost_ability_to_determine_location') and Longitude <> 0 order by id desc", "Trace");
            }
        }
        #endregion

        #region 实时轨迹用户的经纬度
        public static DataTable gettrace_byid(string ids)
        {

            return SQLHelper.ExecuteRead(CommandType.Text, "select [User_ID],[Longitude],[Latitude] from [GIS_info] WHERE User_ID in (" + ids + ")  and Position_err not in ('Position_error_not_known','Lost_ability_to_determine_location') and Longitude <> 0 ", "Trace");
        }
        //韩德培添加为解决轨迹线位置错误上报问题
        #endregion
        #region
        public static DataTable gettrace_byid_new(string ids)
        {
            //SQLHelper.ExecuteRead(CommandType.Text, "select * from [GIS_info] WHERE User_ID in (" + ids + ")", "Trace2");
            return SQLHelper.ExecuteRead(CommandType.Text, "select [User_ID],[Longitude],[Latitude],[Position_err],[Send_reason],[Send_time] from [GIS_info] WHERE User_ID in (" + ids + ")", "Trace"); //and Position_err not in ('Position_error_not_known','Lost_ability_to_determine_location') and Longitude <> 0 
        }
        //-----------------------------------
        #endregion

        public static DataTable GetLoLaByISSI(string ISSI)
        {
            return SQLHelper.ExecuteRead(CommandType.Text, "select [User_ID],[Longitude],[Latitude] from [GIS_info] WHERE ISSI ='" + ISSI + "'  and Position_err not in ('Position_error_not_known','Lost_ability_to_determine_location') and Longitude <> 0 ", "Trace");
        }

        public static DateTime? GetSendTimeByUserID(string UserID)
        {
            DateTime? DT = null;
            DataTable dt = SQLHelper.ExecuteRead(CommandType.Text, "SELECT Send_time FROM GIS_Info where User_ID='" + UserID + "'", "fdsfaadd");
            if (dt.Rows.Count > 0)
            {
                DT = DateTime.Parse( dt.Rows[0][0].ToString());
            }

            return DT;
        }
    }
}
