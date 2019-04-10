using DbComponent;
using MyModel.resPermissions;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.SessionState;

namespace Web.Handlers
{
    /// <summary>
    /// GetGPSPullStatusList 的摘要说明
    /// </summary>
    public class GetGPSPullStatusList : IHttpHandler, IReadOnlySessionState
    {
        private DbComponent.resPermissions.resPermissionsDao permissionsDao = new DbComponent.resPermissions.resPermissionsDao(); 
        //返回总条数{count:100,member:[{},{}]}
        public void ProcessRequest(HttpContext context)
        {

            string PageIndex = context.Request["PageIndex"].ToString();//第几页
            string Limit = context.Request["Limit"].ToString();//每页显示的条数
            string selwhere = context.Request["selwhere"].ToString();
            string selentity = context.Request["selentity"].ToString();
            string selfun = context.Request["selfun"].ToString();
            string selStatues = context.Request["selStatues"].ToString();
            string endtime = context.Request["endtime"].ToString();
            string begtime = context.Request["begtime"].ToString();

            List<AccessUnits> units = new List<AccessUnits>();
            List<AccessZhishu> zhishus = new List<AccessZhishu>();
            List<AccessUserType> usertypes = new List<AccessUserType>();
            string dispatchUser = context.Request.Cookies["username"].Value.Trim();
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

            string strWhere = "";
            #region
            //if (selfun == "1") {//开关 
            //    if (selStatues != "-1")
            //    {
            //        strWhere += " and GPSOpen=OpenStatues and OpenStatues='" + selStatues + "' ";//开或者关
            //    }
            //    else {
            //        strWhere += " and (GPSOpen<>OpenStatues or OpenStatues='-1') ";//未知的
            //    }
            //}
            //else if (selfun == "0")//上报目的地
            //{
            //    if (selStatues != "-1")//不是未知
            //    {
            //        strWhere += " and GPSDestination!='-1' and DestinationStatues='" + selStatues + "' ";
            //    }
            //    else
            //    {
            //        strWhere += " and DestinationStatues='-1' ";
            //    }
                
            //}
            //else if (selfun == "2")//上报周期
            //{
            //    if (selStatues != "-1")//不是未知
            //    {
            //        strWhere += " and GPSCircle!='-1' and CircleStatues='" + selStatues + "' ";
            //    }
            //    else
            //    {
            //        strWhere += " and CircleStatues='-1' ";
            //    }
            //}
            //else if (selfun == "3")//上报模式
            //{
            //    if (selStatues != "-1")//不是未知
            //    {
            //        strWhere += " and GPSorBEIDOU!='-1' and GPSorBEIDOUStatues='" + selStatues + "' ";
            //    }
            //    else
            //    {
            //        strWhere += " and GPSorBEIDOUStatues='-1' ";
            //    }
            //}
            //else if (selfun == "4")
            //{
            //    if (selStatues != "-1")    //不是未知
            //    {
            //        strWhere += " and GPSDistance != '-1' and GPSDistanceStatues='" + selStatues + "' ";
            //    }
            //    else
            //    {
            //        strWhere += " and GPSDistanceStatues='-1' ";
            //    }
            //}
            #endregion
            //if (!String.IsNullOrEmpty(selentity) && selentity != "0")
            //{
            //    strWhere += " and c.Entity_ID='" + selentity + "' ";
            //}

            if (!String.IsNullOrEmpty(selwhere)) {
                strWhere += " and (a.SrcISSI like '%" + stringfilter.Filter(selwhere.Trim()) + "%' or b.Nam like '%" + stringfilter.Filter(selwhere.Trim()) + "%' ) ";
            }
            if (!String.IsNullOrEmpty(begtime))
            {
                strWhere += " and OperateTime >= '" + begtime + "'";
            }
            if (!String.IsNullOrEmpty(endtime))
            {
                strWhere += " and OperateTime <= '" + endtime + "'";
            }

            //string entitid = context.Request.Cookies["id"].Value;

            string entitid = "-1";
            string idsstr = "-1";
            foreach (var unit in units)
            {
                idsstr = idsstr + "," + unit.entityId;
            }

            IList<object> allIdList = permissionsDao.getAllAccessUnitIdByIds(idsstr);
            if (!String.IsNullOrEmpty(selentity) && selentity != "0")
            {
                IList<object> idList = permissionsDao.getAllAccessUnitIdByIds(selentity);
                foreach (var id in idList) 
                {                  
                    var ids = from a in allIdList where id.ToString().Equals(a.ToString()) select a;
                    if (ids.Count() > 0) 
                    {
                        entitid += "," + id;
                    }
                    var zids = from a in zhishus where id.ToString().Equals(a.entityId) select a;
                    if (zids.Count() > 0)
                    {
                        entitid += "," + id;
                    }
                    for (int i = 0; i < usertypes.Count; i++) {
                        if (id.ToString().Equals(usertypes[i].entityId)) {
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
            }
            else 
            {
                foreach (var id in allIdList)
                {
                    entitid = entitid + "," + id;
                }
                foreach (var zhishu in zhishus)
                {
                    entitid = entitid + "," + zhishu.entityId;
                }
            }

            string str = " WITH lmenu(id) as (SELECT id  FROM [Entity] WHERE id in (" + entitid + "))";

            StringBuilder sbSQL = new StringBuilder(str);
            sbSQL.Append(" select a.* from (");
            sbSQL.Append(" SELECT b.id as id,a.[SrcISSI],[CreateTime],[OperateTime],[OperateType],[Expire],[Period],[DstISSI],[Result],[PullStatus],b.nam, c.ipAddress,ROW_NUMBER() over(order by [OperateTime] desc) rownms");
            sbSQL.Append(" FROM GPSPull_Records a inner join User_info b on (a.SrcISSI=b.ISSI) left join ISSI_info c on (a.SrcISSI=c.ISSI)  left join UserType d on (b.type = d.TypeName) ");
            sbSQL.Append(" where b.Entity_ID in (select  id from lmenu) ");
            foreach (var t in usertypes)
            {
                string idStr = string.Empty;
                foreach (var id in t.usertypeIds)
                {
                    idStr += "," + id;
                }
                idStr = idStr.TrimStart(',');
                sbSQL.Append(" or (b.Entity_ID = " + t.entityId + " and d.ID in (" + idStr + "))");
            }
            sbSQL.Append(strWhere + " ) a");
            sbSQL.Append(" Where  rownms between @Start and @End ");

            SqlParameter[] par = new SqlParameter[] { 
            new SqlParameter("Start",Start),
            new SqlParameter("End",End)
            };

            DataTable dt = SQLHelper.ExecuteRead(CommandType.Text, sbSQL.ToString(), "Gpsresult", par);
            DataColumn dc1 = new DataColumn("OpenStatues1", typeof(string));
            DataColumn dc2 = new DataColumn("CircleStatues1", typeof(string));
            DataColumn dc3 = new DataColumn("DestinationStatues1", typeof(string));
            DataColumn dc4 = new DataColumn("GPSorBEIDOUStatues1", typeof(string));
            DataColumn dc5 = new DataColumn("GPSDistanceStatues1", typeof(string));
            dt.Columns.Add(dc1);
            dt.Columns.Add(dc2);
            dt.Columns.Add(dc3);
            dt.Columns.Add(dc4);
            dt.Columns.Add(dc5);
            foreach (DataRow dr in dt.Rows)
            {
                #region
                //if (dr["OpenStatues"].ToString() == "-1" || dr["OpenStatues"].ToString() == "0")
                //{
                //    dr["GPSOpen"] = Ryu666.Components.ResourceManager.GetString("Unkown");
                //    //dr["OpenStatues1"] = Ryu666.Components.ResourceManager.GetString("Unkown");
                //}
                //else if (dr["OpenStatues"].ToString() == dr["GPSOpen"].ToString() || dr["OpenStatues"].ToString() == "128" || dr["GPSOpen"].ToString() == "0")//相等的时候
                //{
                //    if (dr["GPSOpen"].ToString() == "1" || dr["OpenStatues"].ToString() == "128")
                //    {
                //        dr["GPSOpen"] = Ryu666.Components.ResourceManager.GetString("Single_Open");
                //    }
                //    else
                //    {
                //        dr["GPSOpen"] = Ryu666.Components.ResourceManager.GetString("Closebtn");
                //    }
                //}
                //else
                //{
                //    if (dr["GPSOpen"] == null || dr["GPSOpen"].ToString().Trim() == "-1" || dr["GPSOpen"].ToString().Trim() == "")
                //    {
                //        dr["GPSOpen"] = "-1";
                //    }
                //    else
                //    {
                //        dr["GPSOpen"] = Ryu666.Components.ResourceManager.GetString("Unkown");
                //    }
                //}

                //if (dr["CircleStatues"].ToString() == "-1")
                //{
                //    dr["CircleStatues1"] = Ryu666.Components.ResourceManager.GetString("Unkown");
                //}
                //else if (dr["CircleStatues"].ToString() == "0")
                //{
                //    dr["CircleStatues1"] = Ryu666.Components.ResourceManager.GetString("Failed");
                //}
                //else if (dr["CircleStatues"].ToString() == "1")
                //{
                //    dr["CircleStatues1"] = Ryu666.Components.ResourceManager.GetString("Success");
                //}
                //if (dr["GPSCircle"] == null || dr["GPSCircle"].ToString().Trim() == "" || dr["GPSCircle"].ToString().Trim() == "-1")
                //{
                //    dr["GPSCircle"] = "-1";
                //    dr["CircleStatues1"] = Ryu666.Components.ResourceManager.GetString("Unkown");
                //}

                //if (dr["DestinationStatues"].ToString() == "-1")
                //{
                //    dr["DestinationStatues1"] = Ryu666.Components.ResourceManager.GetString("Unkown");
                //}
                //else if (dr["DestinationStatues"].ToString() == "0")
                //{
                //    dr["DestinationStatues1"] = Ryu666.Components.ResourceManager.GetString("Failed");
                //}
                //else if (dr["DestinationStatues"].ToString() == "1")
                //{
                //    dr["DestinationStatues1"] = Ryu666.Components.ResourceManager.GetString("Success");
                //}
                //if (dr["GPSDestination"] == null || dr["GPSDestination"].ToString().Trim() == "" || dr["GPSDestination"].ToString().Trim() == "-1")
                //{
                //    dr["GPSDestination"] = "-1";
                //    dr["DestinationStatues1"] = Ryu666.Components.ResourceManager.GetString("Unkown");
                //}

                //if (dr["GPSorBEIDOUStatues"].ToString() == "-1")
                //{
                //    dr["GPSorBEIDOUStatues1"] = Ryu666.Components.ResourceManager.GetString("Unkown");
                //}
                //else if (dr["GPSorBEIDOUStatues"].ToString() == "0")
                //{
                //    dr["GPSorBEIDOUStatues1"] = Ryu666.Components.ResourceManager.GetString("Failed");
                //}
                //else if (dr["GPSorBEIDOUStatues"].ToString() == "1" || dr["GPSorBEIDOUStatues"].ToString() == "3" || dr["GPSorBEIDOUStatues"].ToString() == "7")
                //{
                //    dr["GPSorBEIDOUStatues1"] = Ryu666.Components.ResourceManager.GetString("Success");
                //}
                //if (dr["GPSorBEIDOU"] == null || dr["GPSorBEIDOU"].ToString().Trim() == "" || dr["GPSorBEIDOU"].ToString().Trim() == "-1")
                //{
                //    dr["GPSorBEIDOU"] = "-1";
                //    dr["GPSorBEIDOUStatues1"] = Ryu666.Components.ResourceManager.GetString("Unkown");
                //}

                //if (dr["GPSDistance"] == null || dr["GPSDistance"].ToString().Trim() == "" || dr["GPSDistance"].ToString().Trim() == "-1")
                //{
                //    dr["GPSDistance"] = "-1";
                //    dr["GPSDistanceStatues1"] = Ryu666.Components.ResourceManager.GetString("Unkown");
                //}
                //if (dr["GPSDistanceStatues"].ToString().Trim() == "-1")
                //{
                //    dr["GPSDistanceStatues1"] = Ryu666.Components.ResourceManager.GetString("Unkown");
                //}
                //else if (dr["GPSDistanceStatues"].ToString().Trim() == "0")
                //{
                //    dr["GPSDistanceStatues1"] = Ryu666.Components.ResourceManager.GetString("Failed");
                //}
                //else
                //{
                //    dr["GPSDistanceStatues1"] = Ryu666.Components.ResourceManager.GetString("Success");
                //}
                #endregion
            }
            string str1 = DbComponent.Comm.TypeConverter.DataTable2ArrayJson(dt);
            StringBuilder sb2 = new StringBuilder(str);
                        sb2.Append(" select count(0) from (");
            sb2.Append("select a.id  FROM GPSPull_Records a inner join User_info b on (a.SrcISSI=b.ISSI) left join ISSI_info c on (a.SrcISSI=c.ISSI) left join UserType d on (b.type = d.TypeName) where b.Entity_ID in (select  id from lmenu) ");

            foreach (var t in usertypes)
            {
                string idStr = string.Empty;
                foreach (var id in t.usertypeIds)
                {
                    idStr += "," + id;
                }
                idStr = idStr.TrimStart(',');
                sb2.Append(" or (b.Entity_ID = " + t.entityId + " and d.ID in (" + idStr + "))");
            }
            sb2.Append(strWhere + ") a");
            DataTable dt2 = SQLHelper.ExecuteRead(CommandType.Text, sb2.ToString(), "Gpsresultcount");


            context.Response.Write("{\"totalcount\":\""+dt2.Rows[0][0].ToString()+"\",\"data\":" + str1 + "}");
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