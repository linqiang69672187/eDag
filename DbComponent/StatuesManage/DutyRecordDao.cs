using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;

namespace DbComponent.StatuesManage
{
    public class DutyRecordDao
    {
        public DataTable getTodayDutyRecords(int ProcId, string entitid, int start, int limit)
        {

            DateTime begtime = DateTime.Parse(DateTime.Now.Date.ToShortDateString() + " 0:0:0");
            DateTime endtime = DateTime.Parse(DateTime.Now.Date.ToShortDateString() + " 23:59:59");
            String str = " WITH lmenu(id) as (SELECT id  FROM [Entity] WHERE id=@entityid UNION ALL SELECT A.id FROM [Entity] A,lmenu b    where a.[ParentID] = b.id)";

            StringBuilder sbSQL = new StringBuilder(str + " select q.* from ( select a.user_id as myuid, b.stepChangeTime as ctime,cnt,b.stepName as nowstepName,reserve1,reserve2,issi,num,beginTime,endTime,b.id as d_id, ROW_NUMBER() over(order by stepChangeTime desc) rownms from user_duty a ");
            sbSQL.Append(" left join duty_record b on (b.user_duty_id=a.id and beginTime>=@begtime and beginTime<=@endtime) ");
            sbSQL.Append(" ");
            sbSQL.Append(" where b.id is not null and  procedure_id=@pid and a.entityID in (select  id from lmenu)  )q where rownms between @start and @limit ");
            return DbComponent.SQLHelper.ExecuteRead(CommandType.Text, sbSQL.ToString(), "tdr", new SqlParameter("limit", limit), new SqlParameter("start", start), new SqlParameter("entityid", entitid), new SqlParameter("begtime", begtime), new SqlParameter("endtime", endtime), new SqlParameter("pid", ProcId));

        }
        public DataTable getTodayDutyRecordsCount(int ProcId, string entitid)
        {
            DateTime begtime = DateTime.Parse(DateTime.Now.Date.ToShortDateString() + " 0:0:0");
            DateTime endtime = DateTime.Parse(DateTime.Now.Date.ToShortDateString() + " 23:59:59");
            String str = " WITH lmenu(id) as (SELECT id  FROM [Entity] WHERE id=@entityid UNION ALL SELECT A.id FROM [Entity] A,lmenu b    where a.[ParentID] = b.id)";
            StringBuilder sbSQL = new StringBuilder(str + " select count(0) from user_duty a ");
            sbSQL.Append(" left join duty_record b on (b.user_duty_id=a.id and beginTime>=@begtime and beginTime<=@endtime) ");
            sbSQL.Append(" ");
            sbSQL.Append(" where b.id is not null and  procedure_id=@pid and  a.entityID in (select  id from lmenu)  ");
            return DbComponent.SQLHelper.ExecuteRead(CommandType.Text, sbSQL.ToString(), "tdr", new SqlParameter("entityid", entitid), new SqlParameter("begtime", begtime), new SqlParameter("endtime", endtime), new SqlParameter("pid", ProcId));

        }

        public DataTable getTodayDutyRecordsForDetail(int ProcId, string entitid, int start, int limit)
        {

            DateTime begtime = DateTime.Parse(DateTime.Now.Date.ToShortDateString() + " 0:0:0");
            DateTime endtime = DateTime.Parse(DateTime.Now.Date.ToShortDateString() + " 23:59:59");
            String str = " WITH lmenu(id) as (SELECT id  FROM [Entity] WHERE id=@entityid UNION ALL SELECT A.id FROM [Entity] A,lmenu b    where a.[ParentID] = b.id)";

            StringBuilder sbSQL = new StringBuilder(str + " select q.* from ( select a.user_id as myuid, b.id as d_id,d.id as s_id, b.stepName as nowstepName,reserve1,reserve2,issi,num,beginTime,endTime,d.stepName,d.changeTime, ROW_NUMBER() over(order by changeTime desc) rownms from user_duty a ");
            sbSQL.Append(" left join duty_record b on (b.user_duty_id=a.id and beginTime>=@begtime and beginTime<=@endtime) ");
            sbSQL.Append(" ");
            sbSQL.Append(" left join duty_status d on (b.id=d.duty_record_id and changeTime>=@begtime and changeTime<=@endtime) ");
            sbSQL.Append(" where b.id is not null and  procedure_id=@pid and a.entityID in (select  id from lmenu)  )q where rownms between @start and @limit ");
            return DbComponent.SQLHelper.ExecuteRead(CommandType.Text, sbSQL.ToString(), "tdr", new SqlParameter("limit", limit), new SqlParameter("start", start), new SqlParameter("entityid", entitid), new SqlParameter("begtime", begtime), new SqlParameter("endtime", endtime), new SqlParameter("pid", ProcId));

        }
        public DataTable getTodayDutyRecordsForDetailCount(int ProcId, string entitid)
        {
            DateTime begtime = DateTime.Parse(DateTime.Now.Date.ToShortDateString() + " 0:0:0");
            DateTime endtime = DateTime.Parse(DateTime.Now.Date.ToShortDateString() + " 23:59:59");
            String str = " WITH lmenu(id) as (SELECT id  FROM [Entity] WHERE id=@entityid UNION ALL SELECT A.id FROM [Entity] A,lmenu b    where a.[ParentID] = b.id)";
            StringBuilder sbSQL = new StringBuilder(str + " select count(0) from user_duty a ");
            sbSQL.Append(" left join duty_record b on (b.user_duty_id=a.id and beginTime>=@begtime and beginTime<=@endtime) ");
            sbSQL.Append("  ");
            sbSQL.Append(" left join duty_status d on (b.id=d.duty_record_id and changeTime>=@begtime and changeTime<=@endtime) ");
            sbSQL.Append(" where b.id is not null and  procedure_id=@pid and  a.entityID in (select  id from lmenu)  ");
            return DbComponent.SQLHelper.ExecuteRead(CommandType.Text, sbSQL.ToString(), "tdr", new SqlParameter("entityid", entitid), new SqlParameter("endtime", endtime), new SqlParameter("begtime", begtime), new SqlParameter("pid", ProcId));

        }
        public DataTable getSearchDutyRecordsForDetail(int ProcId, string entitid, int start, int limit, string issi, string carno, string statues, DateTime begtimes, DateTime endtimes, bool isCK)
        {
            StringBuilder sbWhere = new StringBuilder();
            if (issi != "")
            {
                sbWhere.Append(" and issi=@issi ");
            }
            if (carno != "")
            {
                sbWhere.Append(" and num=@carno ");
            }
            DateTime begtime = DateTime.Parse(begtimes.ToShortDateString() + " 0:0:0");
            DateTime endtime = DateTime.Parse(endtimes.ToShortDateString() + " 23:59:59");
            String str = " WITH lmenu(id) as (SELECT id  FROM [Entity] WHERE id=@entityid UNION ALL SELECT A.id FROM [Entity] A,lmenu b    where a.[ParentID] = b.id)";
            StringBuilder sbSQL = new StringBuilder(str + "select w.* from( select q.*, ROW_NUMBER() over(order by changeTime desc) rownms from (  select a.user_id as myuid,b.id as d_id,d.id as s_id, b.stepName as nowstepName, reserve1,reserve2,issi,num,beginTime,endTime,d.stepName,d.changeTime from user_duty a ");
            sbSQL.Append(" left join duty_record b on (b.user_duty_id=a.id) ");
            sbSQL.Append("");
            sbSQL.Append(" left join duty_status d on (b.id=d.duty_record_id)  ");
            sbSQL.Append(" where b.id is not null and  procedure_id=@pid and a.entityID in (select  id from lmenu) ");

            //if (isCK)
            //{
            sbSQL.Append(" and beginTime>=@begtime ");//历史状态
            sbSQL.Append(" and beginTime<=@endtime ");//历史状态
            if (statues != "")
            {
                if (statues != "-1")
                {
                    if (statues == Ryu666.Components.ResourceManager.GetString("TodayNotOver"))
                    {
                        statues = Ryu666.Components.ResourceManager.GetString("TodayIsOver");
                        sbSQL.Append(" and d.stepName <>@statues or b.stepName is null ");//历史状态
                    }
                    else
                    {
                        sbSQL.Append(" and d.stepName=@statues ");//历史状态
                    }
                }
                else
                {
                    sbSQL.Append(" and b.stepName is null");
                }
            }
            //else {
            //    sbSQL.Append(" and changeTime<=@endtime or changeTime is null or b.stepName is null ");
            //}
            //}
            //else
            //{
            //    if (statues == "")
            //    {
            //        sbSQL.Append("and changeTime<=@endtime or changeTime is null or b.stepName is null ");
            //    }
            //    else
            //    {
            //        if (statues != "-1")
            //        {
            //            sbSQL.Append(" and changeTime>=@begtime and changeTime<=@endtime and d.stepName=@statues ");
            //        }
            //        else
            //        {
            //            sbSQL.Append(" and changeTime<@begtime or changeTime is null or b.stepName is null ");
            //        }
            //    }
            //}
            sbSQL.Append(" )q where myuid>0" + sbWhere.ToString() + ")w where rownms between @start and @limit ");
            return DbComponent.SQLHelper.ExecuteRead(CommandType.Text, sbSQL.ToString(), "tdr", new SqlParameter("endtime", endtime), new SqlParameter("statues", statues), new SqlParameter("carno", carno), new SqlParameter("issi", issi), new SqlParameter("limit", limit), new SqlParameter("start", start), new SqlParameter("entityid", entitid), new SqlParameter("begtime", begtime), new SqlParameter("pid", ProcId));

        }
        public DataTable getSearchDutyDutyRecordsForDetailCount(int ProcId, string entitid, string issi, string carno, string statues, DateTime begtimes, DateTime endtimes, bool isCK)
        {
            StringBuilder sbWhere = new StringBuilder();
            if (issi != "")
            {
                sbWhere.Append(" and issi=@issi ");
            }
            if (carno != "")
            {
                sbWhere.Append(" and num=@carno ");
            }
            DateTime begtime = DateTime.Parse(begtimes.ToShortDateString() + " 0:0:0");
            DateTime endtime = DateTime.Parse(endtimes.ToShortDateString() + " 23:59:59");
            String str = " WITH lmenu(id) as (SELECT id  FROM [Entity] WHERE id=@entityid UNION ALL SELECT A.id FROM [Entity] A,lmenu b    where a.[ParentID] = b.id)";
            StringBuilder sbSQL = new StringBuilder(str + " select count(0) from ( ");
            sbSQL.Append("select * from (");
            sbSQL.Append("select b.id, procedure_id, issi, num, b.stepName, stepChangeTime, a.entityID from user_duty a");
            sbSQL.Append(" left join duty_record b on (b.user_duty_id=a.id) ");
            sbSQL.Append(" left join duty_status d on (b.id=d.duty_record_id) ");
            sbSQL.Append(" where b.id is not null and  a.entityID in (select  id from lmenu)  ");

            sbSQL.Append(" and b.beginTime>=@begtime ");//历史状态
            sbSQL.Append(" and b.beginTime<=@endtime ");//历史状态
            if (isCK)
            {
                if (statues != "")
                {
                    if (statues != "-1")
                    {
                        if (statues == Ryu666.Components.ResourceManager.GetString("TodayNotOver"))
                        {
                            statues = Ryu666.Components.ResourceManager.GetString("TodayIsOver");
                            sbSQL.Append(" and d.stepName <>@statues or b.stepName is null ");//历史状态
                        }
                        else
                        {
                            sbSQL.Append(" and d.stepName=@statues ");//历史状态
                        }
                    }
                    else
                    {
                        sbSQL.Append(" and b.stepName is null");
                    }
                }
            }
            else
            {
                if (statues == "")
                {
                    //sbSQL.Append("and b.stepChangeTime<=@endtime or b.stepChangeTime is null or b.stepName is null ");
                }
                else
                {
                    if (statues != "-1")
                    {
                        //sbSQL.Append(" and b.stepChangeTime>=@begtime and b.stepChangeTime<=@endtime and d.stepName=@statues ");
                        sbSQL.Append(" and d.stepName=@statues");
                    }
                    else
                    {
                        sbSQL.Append(" and b.stepName is null ");
                    }
                }
            }
            sbSQL.Append(")w  where  procedure_id=@pid " + sbWhere.ToString() + ")a");
            return DbComponent.SQLHelper.ExecuteRead(CommandType.Text, sbSQL.ToString(), "tdrs", new SqlParameter("endtime", endtime), new SqlParameter("statues", statues), new SqlParameter("carno", carno), new SqlParameter("issi", issi), new SqlParameter("entityid", entitid), new SqlParameter("begtime", begtime), new SqlParameter("pid", ProcId));

        }

        public DataTable getSearchDutyRecords(int ProcId, string entitid, int start, int limit, string issi, string carno, string statues, DateTime begtimes, DateTime endtimes, bool isCK)
        {
            StringBuilder sbWhere = new StringBuilder();
            if (issi != "")
            {
                sbWhere.Append(" and issi=@issi ");
            }
            if (carno != "")
            {
                sbWhere.Append(" and num=@carno ");
            }
            DateTime begtime = DateTime.Parse(begtimes.ToShortDateString() + " 0:0:0");
            DateTime endtime = DateTime.Parse(endtimes.ToShortDateString() + " 23:59:59");

            String str = " WITH lmenu(id) as (SELECT id  FROM [Entity] WHERE id=@entityid UNION ALL SELECT A.id FROM [Entity] A,lmenu b    where a.[ParentID] = b.id)";

            StringBuilder sbSQL = new StringBuilder(str + " select q.* from ( select a.user_id as myuid,b.stepChangeTime as ctime, cnt, b.stepName as nowstepName,reserve1,reserve2,issi,num,beginTime,endTime,b.id as d_id, ROW_NUMBER() over(order by beginTime desc) rownms  from user_duty a ");
            sbSQL.Append(" left join duty_record b on (b.user_duty_id=a.id) ");
            sbSQL.Append(" ");
            sbSQL.Append(" where b.id is not null and procedure_id=@pid and a.entityID in (select  id from lmenu) ");

            sbSQL.Append(" and beginTime>=@begtime ");//历史状态
            sbSQL.Append(" and beginTime<=@endtime ");//历史状态
            sbSQL.Append(sbWhere.ToString());
            if (isCK)
            {
                if (statues != "")
                {
                    if (statues != "-1")
                    {
                        if (statues == Ryu666.Components.ResourceManager.GetString("TodayNotOver"))
                        {
                            statues = Ryu666.Components.ResourceManager.GetString("TodayIsOver");
                            sbSQL.Append(" and stepName <>@statues or stepName is null ");//历史状态
                        }
                        else
                        {
                            sbSQL.Append(" and stepName=@statues ");//历史状态
                        }
                    }
                    else
                    {
                        sbSQL.Append(" and stepName is null");
                    }
                }
            }
            else
            {
                if (statues == "")
                {
                    //sbSQL.Append("and stepChangeTime<=@endtime or stepChangeTime is null or stepName is null ");
                }
                else
                {
                    if (statues != "-1")
                    {
                        sbSQL.Append(" and stepName=@statues ");
                    }
                    else
                    {
                        sbSQL.Append(" and stepName is null ");
                    }
                }
            }
            sbSQL.Append(" )q where myuid>0 and rownms between @start and @limit ");
            return DbComponent.SQLHelper.ExecuteRead(CommandType.Text, sbSQL.ToString(), "tdr", new SqlParameter("endtime", endtime), new SqlParameter("statues", statues), new SqlParameter("carno", carno), new SqlParameter("issi", issi), new SqlParameter("limit", limit), new SqlParameter("start", start), new SqlParameter("entityid", entitid), new SqlParameter("begtime", begtime), new SqlParameter("pid", ProcId));

        }
        public DataTable getSearchDutyRecordsCount(int ProcId, string entitid, string issi, string carno, string statues, DateTime begtimes, DateTime endtimes, bool isCK)
        {
            StringBuilder sbWhere = new StringBuilder();
            if (issi != "")
            {
                sbWhere.Append(" and issi=@issi ");
            }
            if (carno != "")
            {
                sbWhere.Append(" and num=@carno ");
            }
            DateTime begtime = DateTime.Parse(begtimes.ToShortDateString() + " 0:0:0");
            DateTime endtime = DateTime.Parse(endtimes.ToShortDateString() + " 23:59:59");

            String str = " WITH lmenu(id) as (SELECT id  FROM [Entity] WHERE id=@entityid UNION ALL SELECT A.id FROM [Entity] A,lmenu b    where a.[ParentID] = b.id)";
            StringBuilder sbSQL = new StringBuilder(str + " select count(0) from (");
            sbSQL.Append(" select b.id, procedure_id, issi, num, stepName, stepChangeTime, a.entityID from user_duty a ");
            sbSQL.Append(" left join duty_record b on (b.user_duty_id=a.id ) ");
            sbSQL.Append(" ");
            sbSQL.Append(" where b.id is not null and  a.entityID in (select  id from lmenu)  ");

            sbSQL.Append(" and b.beginTime>=@begtime ");//历史状态
            sbSQL.Append(" and b.beginTime<=@endtime ");//历史状态
            sbSQL.Append(sbWhere.ToString());
            if (isCK)
            {
                if (statues != "")
                {
                    if (statues != "-1")
                    {
                        if (statues == Ryu666.Components.ResourceManager.GetString("TodayNotOver"))
                        {
                            statues = Ryu666.Components.ResourceManager.GetString("TodayIsOver");
                            sbSQL.Append(" and b.stepName <>@statues or b.stepName is null ");//历史状态
                        }
                        else
                        {
                            sbSQL.Append(" and b.stepName=@statues ");//历史状态
                        }
                    }
                    else
                    {
                        sbSQL.Append(" and b.stepName is null");
                    }
                }
            }
            else
            {
                if (statues == "")
                {
                    //sbSQL.Append("and b.stepChangeTime<=@endtime or b.stepChangeTime is null or b.stepName is null ");
                }
                else
                {
                    if (statues != "-1")
                    {
                        sbSQL.Append(" and b.stepName=@statues ");
                    }
                    else
                    {
                        sbSQL.Append(" and b.stepName is null ");
                    }
                }
            }
            sbSQL.Append(" and procedure_id=@pid )w");
            return DbComponent.SQLHelper.ExecuteRead(CommandType.Text, sbSQL.ToString(), "tdr", new SqlParameter("endtime", endtime), new SqlParameter("statues", statues), new SqlParameter("carno", carno), new SqlParameter("issi", issi), new SqlParameter("entityid", entitid), new SqlParameter("begtime", begtime), new SqlParameter("pid", ProcId));

        }

        public DataTable getTodayCount(int ProcId, string entitid)
        {
            DateTime begtime = DateTime.Parse(DateTime.Now.Date.ToShortDateString() + " 0:0:0");
            DateTime endtime = DateTime.Parse(DateTime.Now.Date.ToShortDateString() + " 23:59:59");
            String str = " WITH lmenu(id) as (SELECT id  FROM [Entity] WHERE id=@entityid UNION ALL SELECT A.id FROM [Entity] A,lmenu b    where a.[ParentID] = b.id)";
            StringBuilder sbSQL = new StringBuilder(str + " select stepName,COUNT(user_duty_id) as count from user_duty a   ");
            sbSQL.Append("  left join duty_record on (a.id=duty_record.user_duty_id and beginTime>=@begtime and beginTime<=@endtime) ");
            sbSQL.Append(" ");
            sbSQL.Append(" where procedure_id=@pid and  a.entityID in (select  id from lmenu)  group by stepName ");
            return DbComponent.SQLHelper.ExecuteRead(CommandType.Text, sbSQL.ToString(), "tcount", new SqlParameter("entityid", entitid), new SqlParameter("begtime", begtime), new SqlParameter("endtime", endtime), new SqlParameter("pid", ProcId));

        }
    }
}
