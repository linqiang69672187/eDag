using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Text;
using System.Data;
using DbComponent.Comm;

namespace Web.Handlers.StatuesManage
{
    /// <summary>
    /// GetPPCSMS 的摘要说明
    /// </summary>
    public class GetPPCSMS : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            string begTime = context.Request["begTime"].ToString() + " 00:00:00";
            string endTime = context.Request["endTime"].ToString() + " 23:59:59";
            string need = context.Request["need"].ToString();
            string proid = context.Request["proid"].ToString();
            string carno = context.Request["carno"].ToString();
            string issi = context.Request["issi"].ToString();
            string entityID = context.Request.Cookies["id"].Value.ToString();
            switch (need)
            {
                case "Count":
                    StringBuilder sqlCount = new StringBuilder();
                    sqlCount.Append("WITH lmenu(id) as (SELECT id  FROM [Entity] WHERE id=" + entityID + " UNION ALL SELECT A.id FROM [Entity] A,lmenu b    where a.[ParentID] = b.id)");
                    sqlCount.Append("select count(*) count from SMS_Info a");
                    sqlCount.Append(" left join user_duty b on a.SendISSI=b.issi");
                    sqlCount.Append(" left join _procedure c on b.procedure_id=c.id");
                    sqlCount.Append(" left join Entity e on (b.entityID=e.ID)");
                    sqlCount.Append(" where a.RevISSI='Emergency' and a.SendTime >='" + begTime + "' and a.SendTime <= '" + endTime + "' and b.entityID in (select id from lmenu)");
                    if (!string.IsNullOrEmpty(proid))
                    { sqlCount.Append(" and b.procedure_id=" + proid); }
                    if (!string.IsNullOrEmpty(carno))
                    { sqlCount.Append(" and b.num=" + carno); }
                    if (!string.IsNullOrEmpty(issi))
                    { sqlCount.Append(" and b.issi=" + issi); }
                    DataTable count = DbComponent.SQLHelper.ExecuteRead(System.Data.CommandType.Text, sqlCount.ToString(), "sdfada");
                    context.Response.Write("[{\"stepName\":\"" + Ryu666.Components.ResourceManager.GetString("Emergency") + "\",\"count\":\"" + count.Rows[0]["count"] + "\"}]");
                    context.Response.End();
                    break;
                case "Data":
                    StringBuilder sqlDataCount = new StringBuilder();
                    StringBuilder sqlDataDetail = new StringBuilder();
                    sqlDataCount.Append("WITH lmenu(id) as (SELECT id  FROM [Entity] WHERE id=" + entityID + " UNION ALL SELECT A.id FROM [Entity] A,lmenu b    where a.[ParentID] = b.id)");
                    sqlDataCount.Append("select count(*) count from Dagdb.dbo.SMS_Info a");
                    sqlDataCount.Append(" left join Dagdb.dbo.user_duty b on a.SendISSI=b.issi");
                    sqlDataCount.Append(" left join _procedure c on b.procedure_id=c.id");
                    sqlDataCount.Append(" left join Entity e on (b.entityID=e.ID)");
                    sqlDataCount.Append(" where a.RevISSI='Emergency' and a.SendTime >= '" + begTime + "' and a.SendTime <= '" + endTime + "' and b.entityID in (select id from lmenu)");
                    if (!string.IsNullOrEmpty(proid))
                    { sqlDataCount.Append(" and b.procedure_id=" + proid); }
                    if (!string.IsNullOrEmpty(carno))
                    { sqlDataCount.Append(" and b.num=" + carno); }
                    if (!string.IsNullOrEmpty(issi))
                    { sqlDataCount.Append(" and b.issi=" + issi); }
                    DataTable countHZ = DbComponent.SQLHelper.ExecuteRead(System.Data.CommandType.Text, sqlDataCount.ToString(), "sdfada");
                
                    sqlDataDetail.Append("WITH lmenu(id) as (SELECT id  FROM [Entity] WHERE id=" + entityID + " UNION ALL SELECT A.id FROM [Entity] A,lmenu b    where a.[ParentID] = b.id)");
                    sqlDataDetail.Append("select *, ROW_NUMBER() over(order by a.SendTime desc) rownms from SMS_Info a");
                    sqlDataDetail.Append(" left join user_duty b on a.SendISSI=b.issi");
                    sqlDataDetail.Append(" left join _procedure c on b.procedure_id=c.id");
                    sqlDataDetail.Append(" left join Entity e on (b.entityID=e.ID)");
                    sqlDataDetail.Append(" where a.RevISSI='Emergency' and a.SendTime >= '" + begTime + "' and a.SendTime <= '" + endTime + "' and b.entityID in (select id from lmenu)");
                    if (!string.IsNullOrEmpty(proid))
                    { sqlDataDetail.Append(" and b.procedure_id=" + proid); }
                    if (!string.IsNullOrEmpty(carno))
                    { sqlDataDetail.Append(" and b.num=" + carno); }
                    if (!string.IsNullOrEmpty(issi))
                    { sqlDataDetail.Append(" and b.issi=" + issi); }
                    sqlDataDetail.Append(" order by SendISSI");
                    DataTable dataHZ = DbComponent.SQLHelper.ExecuteRead(System.Data.CommandType.Text, sqlDataDetail.ToString(), "sdfada");

                    context.Response.Write("{\"totalcount\":\"" + countHZ.Rows[0]["count"] + "\",\"data\":" + TypeConverter.DataTable2ArrayJson(dataHZ) + "}");
                    context.Response.End();
                    break;
                default: break;
            }
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