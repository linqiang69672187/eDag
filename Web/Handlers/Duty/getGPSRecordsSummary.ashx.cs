using DbComponent.Comm;
using DbComponent.Duty;
using MyModel.resPermissions;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;


namespace Web.Handlers.StatuesManage
{
    /// <summary>
    /// getGPSRecordsSummary 的摘要说明
    /// </summary>
    public class getGPSRecordsSummary : IHttpHandler
    {
        private GPSReportStatisticsDao gpsReportDao = new GPSReportStatisticsDao();
        private DbComponent.resPermissions.resPermissionsDao permissionsDao = new DbComponent.resPermissions.resPermissionsDao(); 
        public void ProcessRequest(HttpContext context)
        {// { PageIndex: currentPage, Limit: everypagecount,entity:entity_h,status:status_h,begtime:begtime_h,endtime:endtime_h },
            string begtimes = context.Request["begtime"].ToString();
            string endtimes = context.Request["endtime"].ToString();
            string PageIndex = context.Request["PageIndex"].ToString();
            string Limit = context.Request["Limit"].ToString();
            string selentity = context.Request["entity"].ToString();
            string dispatchUser = context.Request.Cookies["username"].Value.Trim();

            DateTime begtime = Convert.ToDateTime(begtimes + " 0:0:0");
            DateTime endtime = Convert.ToDateTime(endtimes + " 23:59:59");
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

            List<AccessUnits> units = new List<AccessUnits>();
            List<AccessZhishu> zhishus = new List<AccessZhishu>();
            List<AccessUserType> usertypes = new List<AccessUserType>();
            string accessUnit = permissionsDao.getAccessUnitsByUsername(dispatchUser);
            string unitID = permissionsDao.getUnitByUsername(dispatchUser);
            if (accessUnit == "")
            {
                units.Add(new AccessUnits() { entityId = unitID });
            }
            else
            {
                string accseeZhishu = accessUnit;
                string accessUserType = accessUnit;
                accessUnit = accessUnit.Substring(accessUnit.IndexOf('['));
                accessUnit = accessUnit.Substring(0, accessUnit.IndexOf(']') + 1);
                accseeZhishu = accseeZhishu.Substring(accseeZhishu.IndexOf('[', accseeZhishu.IndexOf("zhishu")));
                accseeZhishu = accseeZhishu.Substring(0, accseeZhishu.IndexOf(']') + 1);
                accessUserType = accessUserType.Substring(accessUserType.IndexOf('[', accessUserType.IndexOf("usertype")));
                accessUserType = accessUserType.Substring(0, accessUserType.LastIndexOf(']') + 1);
                units = Web.lqnew.opePages.Serial.JSONStringToList<AccessUnits>(accessUnit);
                zhishus = Web.lqnew.opePages.Serial.JSONStringToList<AccessZhishu>(accseeZhishu);
                usertypes = Web.lqnew.opePages.Serial.JSONStringToList<AccessUserType>(accessUserType);
            }
            string idsstr = "-1";
            foreach (var unit in units)
            {
                idsstr = idsstr + "," + unit.entityId;
            }

            IList<object> allIdList = permissionsDao.getAllAccessUnitIdByIds(idsstr);
            IList<object> idList = permissionsDao.getAllAccessUnitIdByIds(selentity);
            List<string> accessUnitIdList = new List<string>();
            foreach (var id in idList)
            {
                var ids = from a in allIdList where id.ToString().Equals(a.ToString()) select a;
                if (ids.Count() > 0)
                {
                    accessUnitIdList.Add(id.ToString());
                }
                var zids = from a in zhishus where id.ToString().Equals(a.entityId) select a;
                if (zids.Count() > 0)
                {
                    accessUnitIdList.Add(id.ToString());
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

            DataTable dt = gpsReportDao.getGPSRecordsOfSummary(begtime, endtime, accessUnitIdList, usertypes, Start, End);
           DataTable dt2 = gpsReportDao.getGPSRecordsOfSummaryCount(begtime, endtime, accessUnitIdList, usertypes);
            string str1 = TypeConverter.DataTable2ArrayJson(dt);
            context.Response.Write("{\"totalcount\":\"" + dt2.Rows[0][0].ToString() + "\",\"data\":" + str1 + "}");
            
            
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