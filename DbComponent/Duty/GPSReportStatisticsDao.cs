using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;


namespace DbComponent.Duty
{
    /****
     * 金融护卫三期，GPS上报情况统计
     * 
     * **/
    public class GPSReportStatisticsDao
    {
        public DataTable getGPSRecordsOfSummary1(DateTime begtime, DateTime endtime, string entityid,int start,int end)
        {
            string StoredProcedureName = "Test_GPSRecord";
            return SQLHelper.ExecuteReadStrProc(CommandType.StoredProcedure, StoredProcedureName, "aaa",
                     new SqlParameter("entityid", entityid),
                     new SqlParameter("begtime", begtime),
                     new SqlParameter("endtime", endtime)
                     
                 );
            
        }
        /************************************
         Method:    getGPSRecordsOfSummary获取GPS上报汇总统计数据
         FullName:  DbComponent.StatuesManage.GPSReportStatisticsDao.getTodayDutyRecords
         Access:    public 
         Returns:   System.Data.DataTable
         Parameter: int ProcId
         Parameter: string entitid
         Parameter: int start
         Parameter: int limit
        ************************************/
        /*** 查询语句
            *
         *WITH lmenu(id) as (SELECT id FROM [Entity] WHERE id=3 UNION ALL SELECT A.id FROM [Entity] A,lmenu b where a.[ParentID] = b.id)
select * from (
select distinct entity_id,count(issi) total,ISNULL(sum(case when cnt>0 then 1 end),0) Y,ISNULL( sum(case when cnt=0 then 1 end) ,0) N ,
ROW_NUMBER() over(order by entity_id ASC) rownms ,name from
(
select distinct issi,sum(cnt) cnt,entity_id 
from gis_records 
where
exists (select 1 from lmenu where entity_id=id) and
begtime>='2015-09-01 00:00:00' AND begtime<='2015-09-22 23:59:59' 
group by issi,entity_id
) b join  Entity on (Entity.id = entity_id)
group by entity_id ,name )q where  rownms BETWEEN 1 and 10
            * **/
        public DataTable getGPSRecordsOfSummary(DateTime begtime, DateTime endtime,List<string> entityidList,List<MyModel.resPermissions.AccessUserType> usertypeList, int start, int limit)
        {
            var entityids = "-1";
            var usertypes = "";
            foreach (var id in entityidList)
            {
                entityids += "," + id;
            }
            foreach (var usertype in usertypeList)
            {
                foreach(var str in usertype.usertypeIds)
                {
                    usertypes += " or (a.id=" + usertype.entityId + " and c.id = " + str + ")";
                }
            }

            String sql = " WITH lmenu(id,usertype) as (SELECT DISTINCT a.id,c.TypeName  FROM Entity a left join User_info b on a.id =b.entity_id left join UserType c on c.TypeName=b.type WHERE a.id in (" + entityids + ") " + usertypes + " )";
           
            StringBuilder sbSQL = new StringBuilder(sql +
                " select * from ( " +
                " select distinct c.entity_id,count(c.issi) total,ISNULL(sum(case when cnt>0 then 1 end),0) yes,ISNULL( sum(case when cnt=0 then 1 end) ,0) nnn ,  " +
                " ROW_NUMBER() over(order by entity_id ASC) rownms ,name from ");

            sbSQL.Append(" ( ");
            sbSQL.Append(" select distinct a.issi,sum(cnt) cnt,a.entity_id  ");
            sbSQL.Append(" from gis_records a");
            sbSQL.Append(" left join User_info b on a.issi=b.issi ");
            sbSQL.Append(" where ");
            sbSQL.Append(" exists (select 1 from lmenu where a.entity_id=id and b.type=usertype ) and ");
            sbSQL.Append(" a.begtime>= @begtime AND a.begtime<= @endtime ");
            sbSQL.Append(" group by a.issi,a.entity_id ");
            sbSQL.Append(" ) c join  Entity d on (d.id = c.entity_id)");
            sbSQL.Append(" group by d.name,c.entity_id )q where  rownms BETWEEN @start and @limit ");
          
            return DbComponent.SQLHelper.ExecuteRead(CommandType.Text, sbSQL.ToString(), "tdr", 
                new SqlParameter("limit", limit), 
                new SqlParameter("start", start), 
                new SqlParameter("begtime", begtime),
                new SqlParameter("endtime", endtime));

        }

        /****
         * 
         * WITH lmenu(id) as (SELECT id FROM [Entity] WHERE id=1 UNION ALL SELECT A.id FROM [Entity] A,lmenu b where a.[ParentID] = b.id)
select count(0) from (
select distinct entity_id,count(issi) total,ISNULL(sum(case when cnt>0 then 1 end),0) yes,ISNULL( sum(case when cnt=0 then 1 end) ,0) nnn ,
name from
(
select distinct issi,sum(cnt) cnt,entity_id 
from gis_records 
where
exists (select 1 from lmenu where entity_id=id) and
begtime>='2015-09-21 00:00:00' AND begtime<='2015-09-23 23:59:59' 
group by issi,entity_id
) b join  Entity on (Entity.id = entity_id)
group by entity_id ,name )q 

         * 
         * */
        public DataTable getGPSRecordsOfSummaryCount(DateTime begtime, DateTime endtime, List<string> entityidList, List<MyModel.resPermissions.AccessUserType> usertypeList)
        {
            var entityids = "-1";
            var usertypes = "";
            foreach (var id in entityidList)
            {
                entityids += "," + id;
            }
            foreach (var usertype in usertypeList)
            {
                foreach (var str in usertype.usertypeIds)
                {
                    usertypes += " or (a.id=" + usertype.entityId + " and c.id = " + str + ")";
                }
            }
           
            String sql = " WITH lmenu(id,usertype) as (SELECT DISTINCT a.id,c.TypeName  FROM Entity a left join User_info b on a.id =b.entity_id left join UserType c on c.TypeName=b.type WHERE a.id in (" + entityids + ") " + usertypes + " )";
           
            StringBuilder sbSQL = new StringBuilder(sql +
                " select count(0) from ( " +
                " select distinct entity_id,count(issi) total,ISNULL(sum(case when cnt>0 then 1 end),0) yes,ISNULL( sum(case when cnt=0 then 1 end) ,0) nnn ,  " +
                " name from ");

            sbSQL.Append(" ( ");
            sbSQL.Append(" select distinct a.issi,sum(cnt) cnt,a.entity_id ");
            sbSQL.Append(" from gis_records a");
            sbSQL.Append(" left join User_info b on a.issi=b.issi ");
            sbSQL.Append(" where ");
            sbSQL.Append(" exists (select 1 from lmenu where a.entity_id=id and b.type=usertype ) and ");
            sbSQL.Append(" a.begtime>= @begtime AND a.begtime<= @endtime ");
            sbSQL.Append(" group by a.issi,a.entity_id ");
            sbSQL.Append(" ) c join  Entity d on (d.id = c.entity_id)");
            sbSQL.Append("group by c.entity_id ,d.name )q  ");
            return DbComponent.SQLHelper.ExecuteRead(CommandType.Text, sbSQL.ToString(), "tdr", 
                new SqlParameter("begtime", begtime), 
                new SqlParameter("endtime", endtime));
        }


  
        public DataTable getGPSRecordsOfDetailed(DateTime begtime, DateTime endtime, List<string> entityidList, List<MyModel.resPermissions.AccessUserType> usertypeList, string status, string userissi, int start, int limit, string condition)
        {
            var entityids = "-1";
            var usertypes = "";
            foreach (var id in entityidList)
            {
                entityids += "," + id;
            }
            foreach (var usertype in usertypeList)
            {
                foreach (var str in usertype.usertypeIds)
                {
                    usertypes += " or (a.id=" + usertype.entityId + " and c.id = " + str + ")";
                }
            }

String sql = " WITH lmenu(id,usertype) as (SELECT DISTINCT a.id,c.TypeName  FROM Entity a left join User_info b on a.id =b.entity_id left join UserType c on c.TypeName=b.type WHERE a.id in (" + entityids + ") " + usertypes + " )";
            StringBuilder sbSQL = new StringBuilder(sql + " SELECT * from  (");
            sbSQL.Append(" select a.issi,username,a.entity_id,convert(char(10),begtime,120) as begtime,Name,cnt, case when cnt=0 then '未上报' else '已上报' END as sbqk ,ROW_NUMBER() over(order by begtime ASC) rownms from GIS_Records a ");
            sbSQL.Append(" JOIN Entity b on (b.ID = entity_id) left join User_info c on a.issi=c.issi where exists (select 1 from lmenu where a.entity_id=id and c.type=usertype ) and begtime BETWEEN @begtime AND @endtime ");
            if (status == "0")
            {
                sbSQL.Append(" and cnt=0");
            }
            else if (status == "1")
            {
                sbSQL.Append(" and cnt>0");
            }
            if(userissi !=""){
                if (condition == "0")
                {
                    sbSQL.Append(" and username like '%" + userissi + "%'"); 
                }
                else if (condition == "1")
                {
                    sbSQL.Append(" and issi like '%" + userissi + "%'");
                }
            }
            sbSQL.Append(" )q");
            sbSQL.Append(" where  rownms BETWEEN @start and @limit");

            return DbComponent.SQLHelper.ExecuteRead(CommandType.Text, sbSQL.ToString(), "tdr", 
                new SqlParameter("begtime", begtime), 
                new SqlParameter("endtime", endtime),
                new SqlParameter("userissi", userissi),
                new SqlParameter("limit", limit),
                new SqlParameter("start", start),
                new SqlParameter("status", status),
                new SqlParameter("condition", condition));

        }
        public DataTable getGPSRecordsOfDetailedCount(DateTime begtime, DateTime endtime, List<string> entityidList, List<MyModel.resPermissions.AccessUserType> usertypeList, string status, string userissi, int start, int limit, string condition)
        {
            var entityids = "-1";
            var usertypes = "";
            foreach (var id in entityidList)
            {
                entityids += "," + id;
            }
            foreach (var usertype in usertypeList)
            {
                foreach (var str in usertype.usertypeIds)
                {
                    usertypes += " or (a.id=" + usertype.entityId + " and c.id = " + str + ")";
                }
            }

            String sql = " WITH lmenu(id,usertype) as (SELECT DISTINCT a.id,c.TypeName  FROM Entity a left join User_info b on a.id =b.entity_id left join UserType c on c.TypeName=b.type WHERE a.id in (" + entityids + ") " + usertypes + " )";
            StringBuilder sbSQL = new StringBuilder(sql + " SELECT count(0) from  (");
            sbSQL.Append(" select a.issi,username,a.entity_id,CONVERT(varchar(10), begtime, 120 ) as begtime,Name, case when cnt=0 then '未上报' else '已上报' END as sbqk ,ROW_NUMBER() over(order by begtime ASC) rownms from GIS_Records a ");
            sbSQL.Append(" JOIN Entity b on (b.ID = entity_id) left join User_info c on a.issi=c.issi where exists (select 1 from lmenu where a.entity_id=id and c.type=usertype ) and begtime BETWEEN @begtime AND @endtime ");
            if (status == "0")
            {
                sbSQL.Append(" and cnt=0");
            }
            else if (status == "1")
            {
                sbSQL.Append(" and cnt>0");
            }
            if (userissi != "")
            {
                if (condition == "0")
                {
                    sbSQL.Append(" and username like '%" + userissi + "%'");
                }
                else if (condition == "1")
                {
                    sbSQL.Append(" and issi like '%" + userissi + "%'");
                }
            }
            sbSQL.Append(" )q");

            return DbComponent.SQLHelper.ExecuteRead(CommandType.Text, sbSQL.ToString(), "tdr",
                new SqlParameter("begtime", begtime),
                new SqlParameter("endtime", endtime),
                new SqlParameter("userissi", userissi),
                new SqlParameter("status", status),
                new SqlParameter("condition", condition));
        }
        //新增用户时，将用户信息更新到GIS_Record表。
        public void adduserToGISRecord(String Nam, String Num, String ISSI, String Eentity_ID)
        {
            if (!FindUserInGisRecordsIsExist(Nam, Num, ISSI, Eentity_ID) && ISSI.Trim() != "")
            {
                String strsql = string.Empty;
                strsql = String.Format("insert into [gis_records] values('{0}','{1}','{2}','{3}','{4}','{5}')", ISSI, DateTime.Today, null, 0, Nam, Eentity_ID);
                SQLHelper.ExecuteNonQuery(strsql);
            }

        }
        public bool FindUserInGisRecordsIsExist(String Nam, String Num, String ISSI, String Eentity_ID)
        {
            bool isReturn = false;
            DateTime date = DateTime.Today;
            string strSql = "select count(0) from gis_records where [username]=@username and issi =@issi and entity_id=@Eentity_ID and begtime >=@date";
            DataTable dt = SQLHelper.ExecuteRead(CommandType.Text, strSql, "totals", 
                new SqlParameter("username", Nam), 
                new SqlParameter("issi", ISSI), 
                new SqlParameter("Eentity_ID", Eentity_ID),
                new SqlParameter("date",date));
            try
            {
                if (int.Parse(dt.Rows[0][0].ToString()) > 0)
                {
                    isReturn = true;
                }
            }
            catch (Exception ex)
            {
                isReturn = false;
            }
            return isReturn;

        }
    }
}
