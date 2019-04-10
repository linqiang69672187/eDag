using OfficeComponent;
using Ryu666.Components;
using System;
using System.Collections.Generic;
using System.Web.SessionState;
using DbComponent.Comm;
using DbComponent.StatuesManage;
using System.Data;
using System.Linq;
using System.Web;
using System.Text;

namespace Web.Handlers.Duty
{
    /// <summary>
    /// dutyrecordToExcel 的摘要说明
    /// </summary>
    public class dutyrecordToExcel : IHttpHandler
    {
 
        public void ProcessRequest(HttpContext context)
        {
            //'&nameorNo, reserveValue = ' + nameorNo, reserveValue
            context.Response.ContentType = "text/plain";
            int strProID = Convert.ToInt32(context.Request["strProID"]);
            string issi = context.Request["issi"].ToString();
            string carno = context.Request["carno"].ToString();
            string statues = context.Request["statues"].ToString();
            DateTime begtime = DateTime.Parse(context.Request["begtimes"] + " 0:0:0");

            DateTime endtime = DateTime.Parse(context.Request["endtimes"] + " 23:59:59");
            string pType_reserve1 = context.Request["pType_reserve1"].ToString();
            string pType_reserve2 = context.Request["pType_reserve2"].ToString();
            string filename = context.Request["protitle"].ToString();
            int nameorNo = Convert.ToInt32(context.Request["nameorNo"]);
            string reserveValue = context.Request["reserveValue"].ToString();
            string entitid = context.Request.Cookies["id"].Value;
            int type = Convert.ToInt32(context.Request["type"]);
            string filetype = ResourceManager.GetString("DetailInquiry");//汇总统计
            string Lang_HZRW = ResourceManager.GetString("Lang_HZRW");//汇总
            string Lang_XXRW = ResourceManager.GetString("Lang_XXRW");//详细
            string Lang_CurrentInfo = ResourceManager.GetString("Lang_CurrentInfo");//当前信息
            string Lang_DoSetup = ResourceManager.GetString("Lang_DoSetup");//执行操作
            string Lang_ZDID = ResourceManager.GetString("Lang_ZDID");//终端ID
            string Lang_CarONOrPoliceNo = ResourceManager.GetString("Lang_CarONOrPoliceNo");//编号
            string Lang_HappenDate = ResourceManager.GetString("Lang_HappenDate");//发生日期
            string Lang_DoTime = ResourceManager.GetString("Lang_DoTime");//执行时间
            string Lang_DoDutyCount = ResourceManager.GetString("Lang_DoDutyCount");//任务执行数量
            string Lang_UnUP = ResourceManager.GetString("Lang_UnUP");//未上报
            string Lang_RecordState = ResourceManager.GetString("Lang_RecordState");//上报状态
            string Lang_RecordTimes = ResourceManager.GetString("Lang_RecordTimes");//上报次数
            string Name = ResourceManager.GetString("Name");
            string sql = "";
            string sqlEmergency = "";
           

            if (type == 0)//汇总导出
            {
                Dictionary<string, string> diclist = new Dictionary<string, string>();
                filetype = Lang_HZRW;
                sql = getsqlforHistoryRecordExcel(strProID, entitid, issi, carno, statues, begtime, endtime, nameorNo, reserveValue);
                //设置列标题，（key，value），key都用小写，为数据库查询字段名。
               // diclist.Add("happendate", Lang_HappenDate);
                diclist.Add("reserve1", pType_reserve1);//大队
                diclist.Add("issi", Lang_ZDID);//终端ID
                diclist.Add("num", Lang_CarONOrPoliceNo);//编号
                diclist.Add("name", Name);//编号
                diclist.Add("reserve2", pType_reserve2);//驻勤单位
                diclist.Add("stepname", Lang_RecordState);//上报状态
                diclist.Add("cnt", Lang_RecordTimes);//上报次数

                if (!string.IsNullOrEmpty(carno))
                    filename = String.Format("{0}_{1}", filename, carno);
                if (!string.IsNullOrEmpty(issi))
                    filename = String.Format("{0}_{1}", filename, issi);
                if (begtime.Equals(endtime))
                    filename = String.Format("{0}_{1}_{2}", filename, begtime.ToString("yyyyMMdd"), filetype);
                else
                    filename = String.Format("{0}_{1}_{2}_{3}", filename, begtime.ToString("yyyyMMdd"), endtime.ToString("yyyyMMdd"), filetype);
                Excelheper.Instance.SaveToClient2(context, filename, new List<String>() { filename },
                   sql, diclist);
                //sbSql；
            }
            else if (type == 1)//明细导出
            {
                Dictionary<string, string> diclist = new Dictionary<string, string>();
                filetype = Lang_XXRW;
                if (statues != "" && statues != ResourceManager.GetString("Emergency"))//不是“全部”,不是紧急
                {
                    sql = getSqlforHistoryDetailExcel(strProID, entitid, issi, carno, statues, begtime, endtime, nameorNo, reserveValue);
                }
                else 
                {
                    //状态全部 或紧急
                    sql = getSqlforHistoryDetailExcel(strProID, entitid, issi, carno, statues, begtime, endtime, nameorNo, reserveValue);
                    sqlEmergency = getSqlforHistoryDetailExcelEmergency(strProID, issi, carno, nameorNo, reserveValue, begtime, endtime, entitid);
                }           
                //设置列标题，（key，value），key都用小写，为数据库查询字段名。
                diclist.Add("happendate", Lang_HappenDate);
                diclist.Add("reserve1", pType_reserve1);//大队
                diclist.Add("issi", Lang_ZDID);//终端ID
                diclist.Add("num", Lang_CarONOrPoliceNo);//编号
                diclist.Add("reserve2", pType_reserve2);//驻勤单位
                diclist.Add("stepname", Lang_RecordState);//上报状态
                diclist.Add("changetime", Lang_DoTime);//执行时间

                if (!string.IsNullOrEmpty(carno))
                    filename = String.Format("{0}_{1}", filename, carno);
                if (!string.IsNullOrEmpty(issi))
                    filename = String.Format("{0}_{1}", filename, issi);
                if (begtime.Equals(endtime))
                    filename = String.Format("{0}_{1}_{2}", filename, begtime.ToString("yyyyMMdd"), filetype);
                else
                    filename = String.Format("{0}_{1}_{2}_{3}", filename, begtime.ToString("yyyyMMdd"), endtime.ToString("yyyyMMdd"), filetype);
                Excelheper.Instance.SaveToClient3(context, filename, new List<String>() { filename },
                   sql, sqlEmergency, diclist,type);

            }
        }
        private string getsqlforHistoryRecordExcel(int strProID, String entitid, String issi, String carno, String statues, DateTime begtime,
            DateTime endtime, int nameorNo, String reserveValue)
        {
            DataTable dt = null;
            StringBuilder sbWhere = new StringBuilder();
            StringBuilder sbSQL = new StringBuilder();
            String strEntity = "WITH lmenu(id) as (SELECT id  FROM [Entity] WHERE id= " + entitid + " UNION ALL SELECT A.id FROM [Entity] A,lmenu b where a.[ParentID] = b.id)";

            StringBuilder sqlStep = new StringBuilder();
            StringBuilder sqlEmergency = new StringBuilder();
            StringBuilder sqlNull = new StringBuilder();
            String sqlStart = "select * from (";
            String sqlEnd = " )r ";
            sbSQL.Append(strEntity + sqlStart);
            //statues ="" 表示全部（紧急+各状态）； 
            //statues = "-1"表示未上报
            if (issi != "")
            {
                sbWhere.Append(" and issi= "+issi);
            }
            if (!string.IsNullOrEmpty(carno))
            {
                if (nameorNo == 0)
                {
                    sbWhere.Append(" and name like '%" + carno + "%'");
                }
                else if (nameorNo == 1)
                {
                    sbWhere.Append(" and num like '%" + carno + "%'");
                }
            }
            if (!string.IsNullOrEmpty(reserveValue))
            { sbWhere.Append(" and reserve2 like '%" + reserveValue.Trim() + "%'"); }
            if (statues == ResourceManager.GetString("Emergency")) //紧急
            {
                sqlEmergency.Append(" select b.reserve1, b.issi,b.num,b.name,b.reserve2,StepName = '" + ResourceManager.GetString("Emergency") + "',count(SendISSI) cnt from SMS_Info a");
                sqlEmergency.Append(" left join user_duty b on a.SendISSI=b.issi ");
                sqlEmergency.Append(" left join _procedure c on b.procedure_id=c.id ");
                sqlEmergency.Append(" where procedure_id= " + strProID + " and a.RevISSI='Emergency' and a.SendTime >= '" + begtime + "'");
                sqlEmergency.Append(" and a.SendTime <= '" +endtime +"'and entityID in  (select id from lmenu) ");
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
                sqlNull.Append(" where procedure_id=" + strProID + " and a.BeginTime>='" + begtime + "' and a.BeginTime<='" + endtime + "' ");
                sqlNull.Append(" and entityID in  (select id from lmenu) ");
                sqlNull.Append(sbWhere.ToString());
                sqlNull.Append(" GROUP BY issi,reserve1, num,reserve2,b.name) wsb where cnt>0 ");

                sbSQL.Append(sqlNull.ToString());

            }
            else if (statues == "")//全部
            {
                sqlStep.Append(" select  b.reserve1, b.issi,b.num,b.name,b.reserve2,C.StepName,Count(C.stepName) cnt ");
                sqlStep.Append(" from duty_status C inner join (");
                sqlStep.Append(" select  d.reserve1, d.issi,d.num,d.name,d.reserve2,a.id ");
                sqlStep.Append(" from user_duty d ");//
                sqlStep.Append(" join duty_Record a on d.id=a.user_duty_id ");
                sqlStep.Append("  where  procedure_id=" + strProID + " and a.BeginTime>='" + begtime + "'and a.BeginTime<='" + endtime + "' ");
                sqlStep.Append(" and entityID in  (select id from lmenu)");
                sqlStep.Append(sbWhere.ToString());
                sqlStep.Append(" ) b on b.ID=C.duty_record_id group by issi,StepName,reserve1,num,reserve2,b.name");
                sbSQL.Append(sqlStep.ToString());
                sbSQL.Append(" union ");

                sqlNull.Append(" SELECT * from (");
                sqlNull.Append(" SELECT b.reserve1, b.issi,b.num,b.name,b.reserve2, StepName ='未上报',sum(case when stepName is null then 1 else 0 end) cnt");
                sqlNull.Append(" from duty_record a ");
                sqlNull.Append(" join user_duty b on a.user_duty_id = b.id ");
                sqlNull.Append(" where procedure_id=" + strProID + " and a.BeginTime>='" + begtime + "' and a.BeginTime<='" + endtime + "' ");
                sqlNull.Append(" and entityID in  (select id from lmenu) ");
                sqlNull.Append(sbWhere.ToString());
                sqlNull.Append(" GROUP BY issi,reserve1, num,reserve2,b.name) wsb where cnt>0 ");
                sbSQL.Append(sqlNull.ToString());
                sbSQL.Append(" union ");

                sqlEmergency.Append(" select b.reserve1, b.issi,b.num,b.name,b.reserve2,StepName = '" + ResourceManager.GetString("Emergency") + "',count(SendISSI) cnt from SMS_Info a");
                sqlEmergency.Append(" left join user_duty b on a.SendISSI=b.issi ");
                sqlEmergency.Append(" left join _procedure c on b.procedure_id=c.id ");
                sqlEmergency.Append(" where procedure_id=" + strProID + " and a.RevISSI='Emergency' and a.SendTime >='" + begtime + "'");
                sqlEmergency.Append(" and a.SendTime <='" + endtime + "' and entityID in  (select id from lmenu) ");
                sqlEmergency.Append(sbWhere.ToString());
                sqlEmergency.Append(" group by issi,reserve1,num,reserve2,b.name ");

                sbSQL.Append(sqlEmergency.ToString());


            }
            else
            {
                sqlStep.Append(" select  b.reserve1, b.issi,b.num,b.name,b.reserve2,C.StepName,Count(C.stepName) cnt ");
                sqlStep.Append(" from duty_status C inner join (");
                sqlStep.Append(" select  d.reserve1, d.issi,d.num,d.name,d.reserve2,a.id ");
                sqlStep.Append(" from user_duty d ");//
                sqlStep.Append(" join duty_Record a on d.id=a.user_duty_id ");
                sqlStep.Append("  where  procedure_id=" + strProID + " and a.BeginTime>='" + begtime + "' and a.BeginTime<='" + endtime + "' ");
                sqlStep.Append(" and entityID in  (select id from lmenu) ");
                sqlStep.Append(sbWhere.ToString());
                sqlStep.Append(" ) b on b.ID=C.duty_record_id where StepName= '" + statues + "'" + " group by issi,StepName,reserve1,num,reserve2,b.name");

                sbSQL.Append(sqlStep.ToString());

            }
            sbSQL.Append(sqlEnd);
            return sbSQL.ToString();
        }
        private string getSqlforHistoryDetailExcelEmergency(int ProcId, string issi, string carno,int nameorNo,string reserveValue,
          DateTime begtime, DateTime endtime, string entityID)
        {
            begtime = DateTime.Parse(begtime.ToShortDateString() + " 0:0:0");
            endtime = DateTime.Parse(endtime.ToShortDateString() + " 23:59:59");
            StringBuilder sqlcondition = new StringBuilder();
            sqlcondition.AppendFormat(" WITH lmenu(id) as (SELECT id  FROM [Entity] WHERE id={0} UNION ALL SELECT A.id FROM [Entity] A,lmenu b where a.[ParentID] = b.id) ", entityID);
            sqlcondition.AppendFormat(" select SendTime as happendate,reserve1,b.issi,b.num,reserve2,a.RevISSI as stepname ,SendTime as changeTime from SMS_Info a ");
            sqlcondition.AppendFormat(" left join user_duty b on a.SendISSI=b.issi");
            sqlcondition.AppendFormat(" left join _procedure c on b.procedure_id=c.id");
            sqlcondition.AppendFormat(" left join Entity e on (b.entityID=e.ID)");
            sqlcondition.AppendFormat(" where a.RevISSI='Emergency' and SendTime>='{0}' and SendTime<='{1}'", begtime, endtime);
            sqlcondition.Append(" and b.entityID in (select id from lmenu)");
            sqlcondition.Append(" and b.procedure_id=" + ProcId);
            if (!string.IsNullOrEmpty(issi))
            {
                sqlcondition.Append(" and issi= '" + issi + "'");
            }
            if (!string.IsNullOrEmpty(carno))
            {
                if (nameorNo == 0)
                {
                    sqlcondition.Append(" and b.name like '%" + carno + "%'");
                }
                else if (nameorNo == 1)
                {
                    sqlcondition.Append(" and b.num like '%" + carno + "%'");
                }
               
            }
            if (!string.IsNullOrEmpty(reserveValue))
            { sqlcondition.Append(" and reserve2 like '%" + reserveValue.Trim() + "%'"); }
            sqlcondition.Append(" order by SendISSI ");
            return sqlcondition.ToString();
        }
        private string getSqlforHistoryDetailExcel(int strProID, String entitid,String issi,String carno,String statues , DateTime begtime,
            DateTime endtime,int nameorNo ,String reserveValue)
        {
            StringBuilder sbWhere = new StringBuilder();
            if (issi != "")
            {
                sbWhere.Append(" and issi= '"+ issi +"'");
            }
            if (!string.IsNullOrEmpty(carno))
            {
                if (nameorNo == 0)
                {
                    sbWhere.Append(" and name like '%" + carno.Trim() + "%'");
                }
                else if (nameorNo == 1)
                {
                    sbWhere.Append(" and num like '%" + carno.Trim() + "%'");
                }
            }
            if (!string.IsNullOrEmpty(reserveValue))
            { sbWhere.Append(" and reserve2 like '%" + reserveValue.Trim() + "%'"); }
           
            String str = " WITH lmenu(id) as (SELECT id  FROM [Entity] WHERE id=" + entitid + 
                " UNION ALL SELECT A.id FROM [Entity] A,lmenu b where a.[ParentID] = b.id)";
            StringBuilder sbSQL = new StringBuilder(str +
               // " select q.*, ROW_NUMBER() over(order by changeTime desc) rownms from (" +
                " select b.begintime as happendate ,reserve1,issi,num,reserve2,d.stepName,d.changeTime from user_duty a ");
            sbSQL.Append(" left join duty_record b on (b.user_duty_id=a.id) ");
            sbSQL.Append("");
            sbSQL.Append(" left join duty_status d on (b.id=d.duty_record_id)  ");
            sbSQL.Append(" where b.id is not null and  procedure_id=" + strProID + " and a.entityID in (select  id from lmenu) ");

            //if (isCK)
            //{
            sbSQL.Append(" and beginTime>='" + begtime + "'");//历史状态
            sbSQL.Append(" and beginTime<='" + endtime + "'");//历史状态
            //statues ="" 表示全部（紧急+各状态）； 
            //statues = "-1"表示未上报
            if (statues != "")
            {
                if (statues != "-1")
                {
                    if (statues == Ryu666.Components.ResourceManager.GetString("TodayNotOver"))
                    {
                        statues = Ryu666.Components.ResourceManager.GetString("TodayIsOver");
                        sbSQL.Append(" and d.stepName <> '"+statues+"' or b.stepName is null ");//历史状态
                    }
                    else
                    {
                        sbSQL.Append(" and d.stepName='"+statues+"'");//历史状态
                    }
                }
                else
                {
                    sbSQL.Append(" and b.stepName is null");
                }
            }

            sbSQL.Append( sbWhere.ToString() );
            return sbSQL.ToString();
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