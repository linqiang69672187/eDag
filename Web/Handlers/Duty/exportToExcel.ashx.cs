
using OfficeComponent;
using Ryu666.Components;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.SessionState;
using System.Text;
using MyModel.resPermissions;
namespace Web.Handlers.Duty
{
    /// <summary>
    /// exportToExcel 的摘要说明
    /// </summary>
    public class exportToExcel : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
         
            string usename = ResourceManager.GetString("usename");//用户名
            string Lang_ISSI_searchoption = ResourceManager.GetString("Lang_ISSI_searchoption");//终端号
            
            string Lang_Subordinateunits = ResourceManager.GetString("Lang_Subordinateunits");//所属单位
            context.Response.ContentType = "text/plain";
         
         
            String type = context.Request["type"].ToString();
            String entity = context.Request["entity"].ToString();
            String status = context.Request["status"].ToString();
            DateTime begtime = Convert.ToDateTime(context.Request["begtime"] + " 0:0:0");
            DateTime endtime = Convert.ToDateTime(context.Request["endtime"] + " 23:59:59");
            string dispatchUser = context.Request.Cookies["username"].Value.Trim();
            string[] unitAndUsertype = GetAccessUnitAndUsertype(dispatchUser,entity);
            String filetype = "";
            if (type == "1")//GPS上报统计_明细查询
            {
                filetype = ResourceManager.GetString("DetailInquiry");//汇总统计
                String condition = context.Request["condition"].ToString();
                String userissi = context.Request["userissi"].ToString();
                String filename = ResourceManager.GetString("Lang_gpstj");//GPS上报统计
                String statusName = ResourceManager.GetString("Lang_Log_All");//全部

                String str = " WITH lmenu(id,usertype) as (SELECT DISTINCT a.id,c.typename  FROM [Entity] a left join User_info b on a.id =b.entity_id left join UserType c on c.TypeName=b.type WHERE a.id in (" + unitAndUsertype[0] + ") " + unitAndUsertype[1] + " )";
                StringBuilder sbSQL = new StringBuilder(str + " SELECT * from  (");
                sbSQL.Append(" select username,a.issi,Name,convert(char(10),begtime,120) as begtime,case when cnt=0 then '未上报' else '已上报' END as sbqk from GIS_Records a");
                sbSQL.Append(" JOIN Entity on (Entity.ID = entity_id) left join User_info c on a.issi=c.issi where exists (select 1 from lmenu where a.entity_id=id and c.type=usertype ) and begtime >='" + begtime + "' AND begtime <='" + endtime + "'");
                if (status == "0")
                {
                    sbSQL.Append(" and cnt=0");
                    statusName = ResourceManager.GetString("Lang_UnUP");
                    
                }
                else if (status == "1")
                {
                    sbSQL.Append(" and cnt>0");
                    statusName = ResourceManager.GetString("Lang_hasUp");
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

                
                string Date = ResourceManager.GetString("Date");//日期
                string ReportSituation = ResourceManager.GetString("ReportSituation");//上报情况

                Dictionary<string, string> diclist = new Dictionary<string, string>();
                diclist.Add("username", usename);
                diclist.Add("issi", Lang_ISSI_searchoption);
                diclist.Add("name", Lang_Subordinateunits);
                diclist.Add("begtime", Date);
                diclist.Add("sbqk", ReportSituation);
               // DYY._lists = diclist;
               // ENCN.SetENCN(filename);
                if (!string.IsNullOrEmpty(statusName))
                    filename = String.Format("{0}_{1}", filename, statusName);
                if (!string.IsNullOrEmpty(userissi))
                    filename = String.Format("{0}_{1}", filename, userissi);
                if (begtime.Equals(endtime))
                    filename = String.Format("{0}_{1}_{2}", filename, begtime.ToString("yyyyMMdd"), filetype);
                else
                    filename = String.Format("{0}_{1}_{2}_{3}", filename, begtime.ToString("yyyyMMdd"), endtime.ToString("yyyyMMdd"), filetype);
               
                Excelheper.Instance.SaveToClient2(context, filename, new List<String>() { filename },
                    sbSQL.ToString(), diclist);

            }
            else if (type == "0")//GPS上报统计_汇总统计
            {
                String filename = ResourceManager.GetString("Lang_gpstj");//GPS上报统计
                String statusName = ResourceManager.GetString("Lang_Log_All");//全部
                filetype = ResourceManager.GetString("SummaryStatistic");//汇总统计

                string UnUPCount = ResourceManager.GetString("UnUPCount");//未上报终端数
                string UPCount = ResourceManager.GetString("UPCount");//已上报终端数
                string totalCount = ResourceManager.GetString("totalCount");//拥有终端数
                string UnUPProportion = ResourceManager.GetString("UnUPProportion");//未上报比例
                string UPProportion = ResourceManager.GetString("UPProportion");//已上报比例
               
                Dictionary<string, string> diclist = new Dictionary<string, string>();
                diclist.Add("name", Lang_Subordinateunits);
                diclist.Add("total", totalCount);
                diclist.Add("entity_id", Lang_Subordinateunits + "ID");
                
                String str = " WITH lmenu(id,usertype) as (SELECT DISTINCT a.id,c.typename FROM [Entity] a left join User_info b on a.id =b.entity_id left join UserType c on c.TypeName=b.type WHERE a.id in (" + unitAndUsertype[0] + ")" + unitAndUsertype[1] + ")";

                StringBuilder sbSQL = new StringBuilder(str );

                String yOrn = "";
                if (status == "0")
                {
                    yOrn = "nnn";
                    statusName = ResourceManager.GetString("Lang_UnUP");
                    diclist.Add("nnn", UnUPCount);
                    diclist.Add("wsbbl", UnUPProportion);
                    sbSQL.Append(" select q.* ,ltrim(cast(nnn*100.0/total as decimal(5,0)))+'%' as wsbbl from ( ");
                    sbSQL.Append(" select distinct entity_id,count(issi) total,ISNULL( sum(case when cnt=0 then 1 end) ,0) nnn, name from  ");
                }
                else if (status == "1")
                {
                    yOrn = "yes";
                    statusName = ResourceManager.GetString("Lang_hasUp");
                    diclist.Add("yes", UPCount);
                    diclist.Add("ysbbl", UPProportion);
                    sbSQL.Append(" select q.* ,ltrim(cast(yes*100.0/total as decimal(5,0)))+'%' as ysbbl from ( ");
                    sbSQL.Append(" select distinct entity_id,count(issi) total,ISNULL(sum(case when cnt>0 then 1 end),0) yes ,name from  ");
                }
                sbSQL.Append(" (select distinct a.issi,sum(cnt) cnt,a.entity_id ");

                sbSQL.Append(" from gis_records a");
                sbSQL.Append(" left join User_info b on a.issi=b.issi ");
                sbSQL.Append(" where exists (select 1 from lmenu where a.entity_id=id and b.type=usertype ) and ");
                sbSQL.Append(" a.begtime>= '"+begtime+"' AND a.begtime<='" + endtime );
                sbSQL.Append("' group by a.issi,a.entity_id ");
                sbSQL.Append(" ) c join  Entity d on (d.id = c.entity_id) ");
                sbSQL.Append("group by d.name, c.entity_id )q  ");
                             

                //DYY._lists = diclist;
                //ENCN.SetENCN(filename);
                if (!string.IsNullOrEmpty(statusName))
                    filename = String.Format("{0}_{1}", filename, statusName);
               
                if (begtime.Equals(endtime))
                    filename = String.Format("{0}_{1}_{2}", filename, begtime.ToString("yyyyMMdd"), filetype);
                else
                    filename = String.Format("{0}_{1}_{2}_{3}", filename, begtime.ToString("yyyyMMdd"), endtime.ToString("yyyyMMdd"), filetype);
                Excelheper.Instance.SaveToClient2(context, filename, new List<String>() { filename },
                    sbSQL.ToString(),diclist);
            }
           
        }

private string[] GetAccessUnitAndUsertype(string dispatchUser, string entity) 
        {
            DbComponent.resPermissions.resPermissionsDao permissionsDao = new DbComponent.resPermissions.resPermissionsDao();
            string accessUnit = permissionsDao.getAccessUnitsByUsername(dispatchUser);
            if (accessUnit == "")
            {
                return new string[2] { "-1", "" };
            }
            string accseeZhishu = accessUnit;
            string accessUserType = accessUnit;
            accessUnit = accessUnit.Substring(accessUnit.IndexOf('['));
            accessUnit = accessUnit.Substring(0, accessUnit.IndexOf(']') + 1);
            accseeZhishu = accseeZhishu.Substring(accseeZhishu.IndexOf('[', accseeZhishu.IndexOf("zhishu")));
            accseeZhishu = accseeZhishu.Substring(0, accseeZhishu.IndexOf(']') + 1);
            accessUserType = accessUserType.Substring(accessUserType.IndexOf('[', accessUserType.IndexOf("usertype")));
            accessUserType = accessUserType.Substring(0, accessUserType.LastIndexOf(']') + 1);
            var units = Web.lqnew.opePages.Serial.JSONStringToList<AccessUnits>(accessUnit);
            var zhishus = Web.lqnew.opePages.Serial.JSONStringToList<AccessZhishu>(accseeZhishu);
            var usertypes = Web.lqnew.opePages.Serial.JSONStringToList<AccessUserType>(accessUserType);

            var entityids = "-1";
            string idsstr = "-1";
            foreach (var unit in units)
            {
                idsstr = idsstr + "," + unit.entityId;
            }

            IList<object> allIdList = permissionsDao.getAllAccessUnitIdByIds(idsstr);
            IList<object> idList = permissionsDao.getAllAccessUnitIdByIds(entity);
            List<string> accessUnitIdList = new List<string>();
            foreach (var id in idList)
            {
                var ids = from a in allIdList where id.ToString().Equals(a.ToString()) select a;
                if (ids.Count() > 0)
                {
                    entityids += "," + id;
                }
                var zids = from a in zhishus where id.ToString().Equals(a.entityId) select a;
                if (zids.Count() > 0)
                {
                    entityids += "," + id;
                }
                for (int i = 0; i < usertypes.Count; i++)
                {
                    if (id.ToString().Equals(usertypes[i].entityId))
                    {
                        usertypes[i].mark = true;
                        break;
                    }
                }
            }

            for (int j = 0; j < usertypes.Count; j++)
            {
                if (!usertypes[j].mark)
                {
                    usertypes.RemoveAt(j);
                    j--;
                }
            }

            var usertypeStr = "";
            foreach (var usertype in usertypes)
            {
                foreach (var id in usertype.usertypeIds)
                {
                    usertypeStr += " or (a.id=" + usertype.entityId + " and c.id = " + id + ")";
                }
            }
            return new string[2] { entityids, usertypeStr };
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