using DbComponent;
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
    /// GetSMSByTypeID 的摘要说明
    /// </summary>
    public class GetSMSByTypeID : IHttpHandler, IReadOnlySessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            string strTypeid = context.Request["typeid"].ToString();
            string PageIndex = context.Request["PageIndex"].ToString();//第几页
            string Limit = context.Request["Limit"].ToString();//每页显示的条数
            string txtCondtion = context.Request["txtCondtion"].ToString();
            string revissi = "-1";
            string orderby = context.Request["orderby"].ToString();
            string txtissi = context.Request["txtissi"].ToString();
            string begtime = context.Request["begtime"].ToString();
            string endtime = context.Request["endtime"].ToString();
            if (context.Request.Cookies["dispatchissi"] != null && context.Request.Cookies["dispatchissi"].Value != null)
            {
                revissi = context.Request.Cookies["dispatchissi"].Value;
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
            if (txtCondtion != "")
            {
                strWhere += " and SMSContent like '%" + stringfilter.Filter(txtCondtion.Trim()) + "%' ";
            }
            if (txtissi != "")
            {
                if (strTypeid == "0")
                {
                    strWhere += " and SendISSI like '%" + stringfilter.Filter(txtissi.Trim()) + "%' ";
                }
                else
                {
                    strWhere += " and RevISSI like '%" + stringfilter.Filter(txtissi.Trim()) + "%' ";
                }
            }
            if (begtime != "")
            {
                strWhere += " and SendTime > '" + begtime + "' ";
            }
            if (endtime != "")
            {
                strWhere += " and SendTime < '" + endtime + "' ";
            }
            if (strTypeid == "1")
            {
                strWhere += " and IsGroup<>2 ";
            }
            
            //if (strTypeid == "0")
            //{
            //    strWhere += " and IsSend=0 ";
            //}
            //else
            //{
            //    strWhere += " and IsSend=1 ";
            //}

            StringBuilder sbSQL = new StringBuilder();
            sbSQL.Append(" select * from (");
            if (orderby == "down")
            {
     sbSQL.Append(" SELECT ReturnID,Group_name,IPAddress,SMSType,Nam,BaseStation_info.StationName,SMS_Info.ID,[SMSMsg],[SendISSI],RevISSI,[IsRead],[SMSContent],[SendTime],[IsGroup],ROW_NUMBER() over(order by [SendTime] desc) rownms");
            }
            else
            {
sbSQL.Append(" SELECT ReturnID,Group_name,IPAddress,SMSType,Nam,BaseStation_info.StationName,SMS_Info.ID,[SMSMsg],[SendISSI],RevISSI,[IsRead],[SMSContent],[SendTime],[IsGroup],ROW_NUMBER() over(order by [SendTime] asc) rownms");
            }
           
            if (strTypeid == "0")
            {
                sbSQL.Append(" FROM SMS_Info left join User_info on (SMS_Info.SendISSI=User_info.ISSI) ");
                sbSQL.Append(" left join Dispatch_Info on (SMS_Info.SendISSI=Dispatch_Info.ISSI)");
                sbSQL.Append(" left join Group_info on (SMS_Info.SendISSI=Group_info.GSSI)");
                 //xzj--20190227--添加基站短信
                sbSQL.Append(" left join BaseStation_info on (substring(SMS_Info.RevISSI,0,CHARINDEX('(',SMS_Info.RevISSI))=BaseStation_info.StationISSI and substring(SMS_Info.RevISSI,CHARINDEX('(',SMS_Info.RevISSI)+1,(case when((CHARINDEX(')',RevISSI)-CHARINDEX('(',RevISSI)))<=0 then 0 else (CHARINDEX(')',RevISSI)-CHARINDEX('(',RevISSI)-1) end))=BaseStation_info.SwitchID)");

               // revissi = "8008";//测试
                sbSQL.Append(" where RevISSI = '" + revissi + "' " + strWhere);
            }
            else
            {
                sbSQL.Append(" FROM SMS_Info left join User_info on (SMS_Info.RevISSI=User_info.ISSI) ");
                sbSQL.Append(" left join Dispatch_Info on (SMS_Info.RevISSI=Dispatch_Info.ISSI)");
                sbSQL.Append(" left join Group_info on (SMS_Info.RevISSI=Group_info.GSSI)");
                //xzj--20190227--添加基站短信
                sbSQL.Append(" left join BaseStation_info on (substring(SMS_Info.RevISSI,0,CHARINDEX('(',SMS_Info.RevISSI))=BaseStation_info.StationISSI and substring(SMS_Info.RevISSI,CHARINDEX('(',SMS_Info.RevISSI)+1,(case when((CHARINDEX(')',RevISSI)-CHARINDEX('(',RevISSI)))<=0 then 0 else (CHARINDEX(')',RevISSI)-CHARINDEX('(',RevISSI)-1) end))=BaseStation_info.SwitchID)");

               // revissi = "8008";//测试
                sbSQL.Append(" where SendISSI = '" + revissi + "' " + strWhere);
            }
            sbSQL.Append(" ) a");
            sbSQL.Append(" Where  rownms between @Start and @End ");

            SqlParameter[] par = new SqlParameter[] { 
            new SqlParameter("Start",Start),
            new SqlParameter("End",End)
            };

            DataTable dt = SQLHelper.ExecuteRead(CommandType.Text, sbSQL.ToString(), "SMSlist", par);
            string str1 = DbComponent.Comm.TypeConverter.DataTable2ArrayJson(dt);

            StringBuilder sb2 = new StringBuilder();
            if (strTypeid == "0")
            {
               // revissi = "8008";//测试
                sb2.Append("select COUNT(0)  FROM SMS_Info  where RevISSI = '" + revissi + "' " + strWhere);
            }
            else
            {
              //  revissi = "8008";//测试
                sb2.Append("select COUNT(0)  FROM SMS_Info  where SendISSI = '" + revissi + "' " + strWhere);
            }
            DataTable dt2 = SQLHelper.ExecuteRead(CommandType.Text, sb2.ToString(), "SMSlistcount");


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