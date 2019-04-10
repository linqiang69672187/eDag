using DbComponent.Comm;
using DbComponent.StatuesManage;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using Ryu666.Components;
using System.Data.SqlClient;
using System.Text;

namespace Web.Handlers.Duty
{
    /// <summary>
    /// getDutyRecordsHistory 的摘要说明
    /// </summary>
    public class getDutyRecordsHistory : IHttpHandler
    {
        private DutyRecordDao drdService = new DutyRecordDao();
        public void ProcessRequest(HttpContext context)
        {
            string strProID = context.Request["proid"].ToString();
            string PageIndex = context.Request["PageIndex"].ToString();
            string Limit = context.Request["Limit"].ToString();
            string entitid = context.Request.Cookies["id"].Value;
            string type = context.Request["type"].ToString();
            //nameorNo: NameorNo, reserveValue: reserve2Value
            string issi = context.Request["issi"].ToString();
            string carno = context.Request["carno"].ToString().Trim();
            string statues = context.Request["statues"].ToString();
            string begtimes = context.Request["begtimes"].ToString();
            string endtimes = context.Request["endtimes"].ToString();
            //   bool isCK = Convert.ToBoolean(context.Request["isCK"].ToString());

            string nameorNo = context.Request["nameorNo"].ToString();
            string reserveValue = context.Request["reserveValue"].ToString();

            DateTime begtime = DateTime.Parse(begtimes + " 0:0:0");
            DateTime endtime = DateTime.Parse(endtimes + " 23:59:59");

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

            DataTable dt = new DataTable();
            DataTable dt2 = new DataTable();
            if (type == "1")
            {//详细
                dt = getSearchDutyRecordsForDetail(int.Parse(strProID), entitid, Start, End, issi, carno, 
                    statues, begtime, endtime, nameorNo, reserveValue);
                dt2 = getSearchDutyDutyRecordsForDetailCount(int.Parse(strProID), entitid, issi, carno,
                    statues, begtime, endtime, nameorNo, reserveValue);
            }
            else if (type == "0")
            {//汇总
         
                dt = getSearchDutyRecords(int.Parse(strProID), entitid, Start, End, issi, carno,
                    statues, begtime, endtime, nameorNo, reserveValue);
                dt2 = getSearchDutyRecordsCount(int.Parse(strProID), entitid, issi, carno, 
                    statues, begtime, endtime, nameorNo, reserveValue);

            }
            string str1 = TypeConverter.DataTable2ArrayJson(dt);
            context.Response.Write("{\"totalcount\":\"" + dt2.Rows[0][0].ToString() + "\",\"data\":" + str1 + "}");
        }

        private DataTable getSearchDutyRecords(int ProcId, string entitid, int start, int limit, string issi, string carno,
            string statues, DateTime begtimes, DateTime endtimes, string nameorNo, string reserveValue)
        {
            DataTable dt = null;
            StringBuilder sbWhere = new StringBuilder();
            StringBuilder sbSQL = new StringBuilder();
            DateTime begtime = DateTime.Parse(begtimes.ToShortDateString() + " 0:0:0");
            DateTime endtime = DateTime.Parse(endtimes.ToShortDateString() + " 23:59:59");
            String strEntity = "WITH lmenu(id) as (SELECT id  FROM [Entity] WHERE id=@entityid UNION ALL SELECT A.id FROM [Entity] A,lmenu b where a.[ParentID] = b.id)";

            StringBuilder sqlStep = new StringBuilder();
            StringBuilder sqlEmergency = new StringBuilder();
            StringBuilder sqlNull = new StringBuilder();
            String sqlStart = "select w.* from (select r.* ,ROW_NUMBER() over(order by issi desc) rownms from (";
            String sqlEnd=" ) r )w WHERE rownms BETWEEN "+start+ " and "+ limit ;
            sbSQL.Append(strEntity + sqlStart);
            //statues ="" 表示全部（紧急+各状态）； 
            //statues = "-1"表示未上报
            if (issi != "")
            {
                sbWhere.Append(" and issi=@issi ");
            }
            if (!string.IsNullOrEmpty(carno))
            {
                if (nameorNo == "0")
                {
                    sbWhere.Append(" and b.name like '%" + carno + "%'");
                }
                else if (nameorNo == "1")
                {
                    sbWhere.Append(" and num like '%" + carno + "%'");
                }
            }
            if (!string.IsNullOrEmpty(reserveValue))
            { sbWhere.Append(" and reserve2 like '%" + reserveValue + "%'"); }
            if (statues == ResourceManager.GetString("Emergency")) //紧急
            {
                sqlEmergency.Append(" select b.reserve1, b.issi,b.num,b.name,b.reserve2,StepName = '" + ResourceManager.GetString("Emergency") + "',count(SendISSI) cnt,b.user_id as userID from SMS_Info a");
                sqlEmergency.Append(" left join user_duty b on a.SendISSI=b.issi ");
                sqlEmergency.Append(" left join _procedure c on b.procedure_id=c.id ");
                sqlEmergency.Append(" where procedure_id=@ProcId and a.RevISSI='Emergency' and a.SendTime >=@begtime");
                sqlEmergency.Append(" and a.SendTime <=@endtime and entityID in  (select id from lmenu) ");
                sqlEmergency.Append(sbWhere.ToString());
                sqlEmergency.Append(" group by issi,reserve1, num,reserve2,b.name,b.user_id ");
               
                sbSQL.Append(sqlEmergency.ToString());
         
                
            }
            else if (statues == "-1") //"未上报"
            {
                
                sqlNull.Append(" SELECT * from (");
                sqlNull.Append(" SELECT b.reserve1, b.issi,b.num,b.name,b.reserve2, StepName ='未上报',sum(case when stepName is null then 1 else 0 end) cnt,b.user_id as userID");
                sqlNull.Append(" from duty_record a ");
                sqlNull.Append(" join user_duty b on a.user_duty_id = b.id ");
                sqlNull.Append(" where procedure_id=@ProcId and a.BeginTime>=@begtime and a.BeginTime<=@endtime ");
                sqlNull.Append(" and entityID in  (select id from lmenu) ");
                sqlNull.Append( sbWhere.ToString());
                sqlNull.Append(" GROUP BY issi,reserve1, num,reserve2,b.name,b.user_id) wsb where cnt>0 ");

                sbSQL.Append(sqlNull.ToString());

            }
            else if (statues == "")//全部
            {
                sqlStep.Append(" select  D.reserve1, D.issi,D.num,D.name,D.reserve2,C.StepName,Count(C.stepName) cnt,userID ");
                sqlStep.Append(" from duty_status C inner join (");
                sqlStep.Append(" select  b.reserve1, b.issi,b.num,b.name,b.reserve2,a.id, b.user_id as userID ");
                sqlStep.Append(" from user_duty b ");//
                sqlStep.Append(" join duty_Record a on b.id=a.user_duty_id ");
                sqlStep.Append("  where  procedure_id=@ProcId and a.BeginTime>=@begtime and a.BeginTime<=@endtime ");
                sqlStep.Append(" and entityID in  (select id from lmenu)");
                sqlStep.Append(sbWhere.ToString());
                sqlStep.Append(" ) D on D.ID=C.duty_record_id group by issi,StepName,reserve1,num,reserve2,name,userID");
                sbSQL.Append(sqlStep.ToString());
                sbSQL.Append(" union ");

                sqlNull.Append(" SELECT * from (");
                sqlNull.Append(" SELECT b.reserve1, b.issi,b.num,b.name,b.reserve2, StepName ='未上报',sum(case when stepName is null then 1 else 0 end) cnt,b.user_id as userID");
                sqlNull.Append(" from duty_record a ");
                sqlNull.Append(" join user_duty b on a.user_duty_id = b.id ");
                sqlNull.Append(" where procedure_id=@ProcId and a.BeginTime>=@begtime and a.BeginTime<=@endtime ");
                sqlNull.Append(" and entityID in  (select id from lmenu) ");
                sqlNull.Append(sbWhere.ToString());
                sqlNull.Append(" GROUP BY issi,reserve1, num,reserve2,b.name,b.user_id) wsb where cnt>0 ");
                sbSQL.Append(sqlNull.ToString());
                sbSQL.Append(" union ");

                sqlEmergency.Append(" select b.reserve1, b.issi,b.num,b.name,b.reserve2,StepName ='" + ResourceManager.GetString("Emergency") + "',count(SendISSI) cnt,b.user_id as userID from SMS_Info a");
                sqlEmergency.Append(" left join user_duty b on a.SendISSI=b.issi ");
                sqlEmergency.Append(" left join _procedure c on b.procedure_id=c.id ");
                sqlEmergency.Append(" where procedure_id=@ProcId and a.RevISSI='Emergency' and a.SendTime >=@begtime");
                sqlEmergency.Append(" and a.SendTime <=@endtime and entityID in  (select id from lmenu) ");
                sqlEmergency.Append(sbWhere.ToString());
                sqlEmergency.Append(" group by issi,reserve1,num,reserve2,b.name,b.user_id  ");

                sbSQL.Append(sqlEmergency.ToString());
               

            }
            else
            {
                sqlStep.Append(" select  D.reserve1, D.issi,D.num,D.name,D.reserve2,C.StepName,Count(C.stepName) cnt,userID ");
                sqlStep.Append(" from duty_status C inner join (");
                sqlStep.Append(" select  b.reserve1, b.issi,b.num,b.name,b.reserve2,a.id,b.user_id as userID ");
                sqlStep.Append(" from user_duty b ");//
                sqlStep.Append(" join duty_Record a on b.id=a.user_duty_id ");
                sqlStep.Append("  where  procedure_id=@ProcId and a.BeginTime>=@begtime and a.BeginTime<=@endtime ");
                sqlStep.Append(" and entityID in  (select id from lmenu) " );
                sqlStep.Append(sbWhere.ToString());
                sqlStep.Append(" ) D on D.ID=C.duty_record_id where StepName= '" + statues +
                    "'" + " group by issi,StepName,reserve1,num,reserve2,name,userID");
                
                sbSQL.Append(sqlStep.ToString());
              
            }
            sbSQL.Append(sqlEnd);
            
            dt = DbComponent.SQLHelper.ExecuteRead(CommandType.Text, sbSQL.ToString(), "tdr",
                new SqlParameter("endtime", endtime), new SqlParameter("statues", statues), 
                new SqlParameter("carno", carno), new SqlParameter("issi", issi), new SqlParameter("limit", limit), 
                new SqlParameter("start", start), new SqlParameter("entityid", entitid),
                new SqlParameter("begtime", begtime), new SqlParameter("ProcId", ProcId));

            return dt;
        }
        private DataTable getSearchDutyRecordsCount(int ProcId, string entitid, string issi, string carno, 
            string statues, DateTime begtimes, DateTime endtimes, string nameorNo, string reserveValue)
        {
            DataTable dt = null;
            StringBuilder sbWhere = new StringBuilder();
            StringBuilder sbSQL = new StringBuilder();
            DateTime begtime = DateTime.Parse(begtimes.ToShortDateString() + " 0:0:0");
            DateTime endtime = DateTime.Parse(endtimes.ToShortDateString() + " 23:59:59");
            String strEntity = "WITH lmenu(id) as (SELECT id  FROM [Entity] WHERE id=@entityid UNION ALL SELECT A.id FROM [Entity] A,lmenu b where a.[ParentID] = b.id)";

            StringBuilder sqlStep = new StringBuilder();
            StringBuilder sqlEmergency = new StringBuilder();
            StringBuilder sqlNull = new StringBuilder();
            String sqlStart = "select count(0) from (";
            String sqlEnd = " )r ";
            sbSQL.Append(strEntity + sqlStart);
            //statues ="" 表示全部（紧急+各状态）； 
            //statues = "-1"表示未上报
            if (issi != "")
            {
                sbWhere.Append(" and issi=@issi ");
            }
            if (!string.IsNullOrEmpty(carno))
            {
                if (nameorNo == "0")
                {
                    sbWhere.Append(" and b.name like '%" + carno + "%'");
                }
                else if (nameorNo == "1")
                {
                    sbWhere.Append(" and num like '%" + carno + "%'");
                }
            }
            if (!string.IsNullOrEmpty(reserveValue))
            { sbWhere.Append(" and reserve2 like '%" + reserveValue + "%'"); }
            if (statues == ResourceManager.GetString("Emergency")) //紧急
            {
                sqlEmergency.Append(" select b.reserve1, b.issi,b.num,b.name,b.reserve2,StepName = '" + ResourceManager.GetString("Emergency") + "',count(SendISSI) cnt from SMS_Info a");
                sqlEmergency.Append(" left join user_duty b on a.SendISSI=b.issi ");
                sqlEmergency.Append(" left join _procedure c on b.procedure_id=c.id ");
                sqlEmergency.Append(" where procedure_id=@ProcId and a.RevISSI='Emergency' and a.SendTime >=@begtime");
                sqlEmergency.Append(" and a.SendTime <=@endtime and entityID in  (select id from lmenu) ");
                sqlEmergency.Append(sbWhere.ToString());
                sqlEmergency.Append(" group by issi,reserve1, num,reserve2,b.name ");

                sbSQL.Append(sqlEmergency.ToString());


            }
            else if (statues == "-1") //"未上报"
            {

                sqlNull.Append(" SELECT * from (");
                sqlNull.Append(" SELECT b.reserve1, b.issi,b.num,b.name,b.reserve2, StepName ='未上报',sum(case when stepName is null then 1 else 0 end) cnt");
                sqlNull.Append(" from duty_record a ");
                sqlNull.Append(" join user_duty b on a.user_duty_id = b.id ");
                sqlNull.Append(" where procedure_id=@ProcId and a.BeginTime>=@begtime and a.BeginTime<=@endtime ");
                sqlNull.Append(" and entityID in  (select id from lmenu) ");
                sqlNull.Append(sbWhere.ToString());
                sqlNull.Append(" GROUP BY issi,reserve1, num,reserve2,b.name) wsb where cnt>0 ");

                sbSQL.Append(sqlNull.ToString());

            }
            else if (statues == "")//全部
            {
                sqlStep.Append(" select  D.reserve1, D.issi,D.num,D.name,D.reserve2,C.StepName,Count(C.stepName) cnt ");
                sqlStep.Append(" from duty_status C inner join (");
                sqlStep.Append(" select  b.reserve1, b.issi,b.num,b.name,b.reserve2,a.id ");
                sqlStep.Append(" from user_duty b ");//
                sqlStep.Append(" join duty_Record a on b.id=a.user_duty_id ");
                sqlStep.Append("  where  procedure_id=@ProcId and a.BeginTime>=@begtime and a.BeginTime<=@endtime ");
                sqlStep.Append(" and entityID in  (select id from lmenu)");
                sqlStep.Append(sbWhere.ToString());
                sqlStep.Append(" ) D on D.ID=C.duty_record_id group by issi,StepName,reserve1,num,reserve2,name");
                sbSQL.Append(sqlStep.ToString());
                sbSQL.Append(" union ");

                sqlNull.Append(" SELECT * from (");
                sqlNull.Append(" SELECT b.reserve1, b.issi,b.num,b.name,b.reserve2, StepName ='未上报',sum(case when stepName is null then 1 else 0 end) cnt");
                sqlNull.Append(" from duty_record a ");
                sqlNull.Append(" join user_duty b on a.user_duty_id = b.id ");
                sqlNull.Append(" where procedure_id=@ProcId and a.BeginTime>=@begtime and a.BeginTime<=@endtime ");
                sqlNull.Append(" and entityID in  (select id from lmenu) ");
                sqlNull.Append(sbWhere.ToString());
                sqlNull.Append(" GROUP BY issi,reserve1, num,reserve2,b.name) wsb where cnt>0 ");
                sbSQL.Append(sqlNull.ToString());
                sbSQL.Append(" union ");

                sqlEmergency.Append(" select b.reserve1, b.issi,b.num,b.name,b.reserve2,StepName = '" + ResourceManager.GetString("Emergency") + "',count(SendISSI) cnt from SMS_Info a");
                sqlEmergency.Append(" left join user_duty b on a.SendISSI=b.issi ");
                sqlEmergency.Append(" left join _procedure c on b.procedure_id=c.id ");
                sqlEmergency.Append(" where procedure_id=@ProcId and a.RevISSI='Emergency' and a.SendTime >=@begtime");
                sqlEmergency.Append(" and a.SendTime <=@endtime and entityID in  (select id from lmenu) ");
                sqlEmergency.Append(sbWhere.ToString());
                sqlEmergency.Append(" group by issi,reserve1,num,reserve2,b.name ");

                sbSQL.Append(sqlEmergency.ToString());


            }
            else
            {
                sqlStep.Append(" select  D.reserve1, D.issi,D.num,D.name,D.reserve2,C.StepName,Count(C.stepName) cnt ");
                sqlStep.Append(" from duty_status C inner join (");
                sqlStep.Append(" select  b.reserve1, b.issi,b.num,b.name,b.reserve2,a.id ");
                sqlStep.Append(" from user_duty b ");//
                sqlStep.Append(" join duty_Record a on b.id=a.user_duty_id ");
                sqlStep.Append("  where  procedure_id=@ProcId and a.BeginTime>=@begtime and a.BeginTime<=@endtime ");              
                sqlStep.Append(" and entityID in  (select id from lmenu) ");
                sqlStep.Append(sbWhere.ToString());
                sqlStep.Append(" ) D on D.ID=C.duty_record_id where StepName= '" + statues+"'"+" group by issi,StepName,reserve1,num,reserve2,name");

                sbSQL.Append(sqlStep.ToString());

            }
            sbSQL.Append(sqlEnd);
            dt = DbComponent.SQLHelper.ExecuteRead(CommandType.Text, sbSQL.ToString(), "tdr",
                new SqlParameter("endtime", endtime), new SqlParameter("statues", statues), 
                new SqlParameter("carno", carno), new SqlParameter("issi", issi), 
                new SqlParameter("entityid", entitid), new SqlParameter("begtime", begtime),
                new SqlParameter("ProcId", ProcId));

            return dt;
        }
        private DataTable getSearchDutyRecordsForDetail(int ProcId, string entitid, int start, int limit, string issi, 
            string carno, string statues, DateTime begtimes, DateTime endtimes, string nameorNo, string reserveValue)
        {

            StringBuilder sbWhere = new StringBuilder();
            if (issi != "")
            {
                sbWhere.Append(" and issi=@issi ");
            }
            if (!string.IsNullOrEmpty(carno))
            {
                if (nameorNo == "0")
                {
                    sbWhere.Append(" and name like '%" + carno + "%'");
                }
                else if (nameorNo == "1")
                {
                    sbWhere.Append(" and num like '%" + carno + "%'");
                }
            }
            if (!string.IsNullOrEmpty(reserveValue))
            { sbWhere.Append(" and reserve2 like '%" + reserveValue + "%'"); }
            DateTime begtime = DateTime.Parse(begtimes.ToShortDateString() + " 0:0:0");
            DateTime endtime = DateTime.Parse(endtimes.ToShortDateString() + " 23:59:59");
            String str = " WITH lmenu(id) as (SELECT id  FROM [Entity] WHERE id=@entityid UNION ALL SELECT A.id FROM [Entity] A,lmenu b where a.[ParentID] = b.id)";
            StringBuilder sbSQL = new StringBuilder(str +
                "select w.* from( select q.*, ROW_NUMBER() over(order by changeTime desc) rownms from" +
                " (  select a.user_id as myuid,b.id as d_id,d.id as s_id, b.stepName as nowstepName, "+
                "reserve1,reserve2,issi,num,name,beginTime,endTime,d.stepName,d.changeTime from user_duty a ");
            sbSQL.Append(" left join duty_record b on (b.user_duty_id=a.id) ");
            sbSQL.Append("");
            sbSQL.Append(" left join duty_status d on (b.id=d.duty_record_id)  ");
            sbSQL.Append(" where b.id is not null and  procedure_id=@pid and a.entityID in (select  id from lmenu) ");

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

            sbSQL.Append(" )q where myuid>0" + sbWhere.ToString() + ")w where rownms between @start and @limit ");
            return DbComponent.SQLHelper.ExecuteRead(CommandType.Text, sbSQL.ToString(), "tdr", 
                new SqlParameter("endtime", endtime), new SqlParameter("statues", statues), 
                new SqlParameter("carno", carno), new SqlParameter("issi", issi), 
                new SqlParameter("limit", limit), new SqlParameter("start", start), 
                new SqlParameter("entityid", entitid), new SqlParameter("begtime", begtime),
                new SqlParameter("pid", ProcId));

        }
        private DataTable getSearchDutyDutyRecordsForDetailCount(int ProcId, string entitid, string issi, 
            string carno, string statues, DateTime begtimes, DateTime endtimes, string nameorNo, string reserveValue)
        {
            StringBuilder sbWhere = new StringBuilder();
            if (issi != "")
            {
                sbWhere.Append(" and issi=@issi ");
            }
            if (!string.IsNullOrEmpty(carno))
            {
                if (nameorNo == "0")
                {
                    sbWhere.Append(" and name like '%" + carno + "%'");
                }
                else if (nameorNo == "1")
                {
                    sbWhere.Append(" and num like '%" + carno + "%'");
                }
            }
        
            if (!string.IsNullOrEmpty(reserveValue))
            { sbWhere.Append(" and reserve2 like '%" + reserveValue + "%'"); }
            DateTime begtime = DateTime.Parse(begtimes.ToShortDateString() + " 0:0:0");
            DateTime endtime = DateTime.Parse(endtimes.ToShortDateString() + " 23:59:59");
            String str = " WITH lmenu(id) as (SELECT id  FROM [Entity] WHERE id=@entityid UNION ALL SELECT A.id FROM [Entity] A,lmenu b where a.[ParentID] = b.id)";
            StringBuilder sbSQL = new StringBuilder(str + " select count(0) from ( ");
            sbSQL.Append("select * from (");
            sbSQL.Append("select b.id, procedure_id, issi, num,name,reserve2, b.stepName, stepChangeTime, a.entityID from user_duty a");
            sbSQL.Append(" left join duty_record b on (b.user_duty_id=a.id) ");
            sbSQL.Append(" left join duty_status d on (b.id=d.duty_record_id) ");
            sbSQL.Append(" where b.id is not null and  a.entityID in (select  id from lmenu)  ");

            sbSQL.Append(" and b.beginTime>=@begtime ");//历史状态
            sbSQL.Append(" and b.beginTime<=@endtime ");//历史状态
            //if (isCK)
            //{
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
            sbSQL.Append(")w  where  procedure_id=@pid " + sbWhere.ToString() + ")a");
            return DbComponent.SQLHelper.ExecuteRead(CommandType.Text, sbSQL.ToString(), "tdrs", 
                new SqlParameter("endtime", endtime), new SqlParameter("statues", statues),
                new SqlParameter("carno", carno), new SqlParameter("issi", issi), 
                new SqlParameter("entityid", entitid), new SqlParameter("begtime", begtime),
                new SqlParameter("pid", ProcId));

        }
        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}