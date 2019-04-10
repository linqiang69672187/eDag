using DbComponent;
using fastJSON;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;

namespace Web.Handlers
{
    /// <summary>
    /// GetOperationLog 的摘要说明
    /// </summary>
    public class GetOperationLog : IHttpHandler
    {
        /// <summary>
        /*  endtime: endtime,
            begtime: begtime,
            IdentityDeviceUnit: IdentityDeviceUnit,
            IdentityDeviceID: IdentityDeviceID,
            IdentityDeviceType:IdentityDeviceType,
            IdentityUnit: IdentityUnit,
            IdentityID:IdentityID,
            IdentityName: IdentityName,
            IdentityType: IdentityType,
            LoginUser: LoginUser,
            type: type,
            PageIndex: currentPage,
            Limit: everypagecount
         */
        /// </summary>
        /// <param name="context"></param>
        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            String begintime = context.Request["begtime"].ToString();
            String endtime = context.Request["endtime"].ToString();
            String IdentityDeviceUnit = context.Request["IdentityDeviceUnit"].ToString();
            String IdentityDeviceID = context.Request["IdentityDeviceID"].ToString();
            String identityDeviceType = context.Request["identityDeviceType"].ToString();
            String IdentityUnit = context.Request["IdentityUnit"].ToString();
            String IdentityID = context.Request["IdentityID"].ToString();
            String IdentityName = context.Request["IdentityName"].ToString();
            String IdentityType = context.Request["IdentityType"].ToString();
            String LoginUser = context.Request["LoginUser"].ToString();
            String type = context.Request["type"].ToString();
            //第几页
            Int32 PageIndex =Convert.ToInt32(context.Request["PageIndex"]);
            //每页显示的条数
            Int32 Limit = Convert.ToInt32(context.Request["Limit"]);

            ///分页行ID数
            Int32 rownumID = PageIndex == 1 ? 0 : (PageIndex - 1) * Limit;

            //获得表字段
            IList<Object> collist = new List<Object>();
            SQLHelper.ExecuteDataReaderTableFields(ref collist, "select [name] from sys.columns where object_id in (select object_id from sys.tables where [name]='OperationLog')",CommandType.Text);

            ///创建表格
            DataTable dt = new DataTable();
            dt.TableName = "logList";

            ///创建表字段字符串
            StringBuilder sbColumn=new StringBuilder();

            foreach(var c in collist)
            {
                dt.Columns.Add(c.ToString());
                sbColumn.AppendFormat("{0},",c.ToString());
            }
            sbColumn = sbColumn.Remove(sbColumn.Length - 1, 1);

            ///查询条件
            StringBuilder sbConditon = new StringBuilder();
            if (!String.IsNullOrEmpty(LoginUser))
                sbConditon.AppendFormat(" [SchedulUserName]='{0}' and", LoginUser);
            if (!String.IsNullOrEmpty(IdentityUnit))
                sbConditon.AppendFormat(" [IdentityUnit]='{0}' and", IdentityUnit);
            if (!String.IsNullOrEmpty(IdentityID))
                sbConditon.AppendFormat(" [IdentityID] like '%{0}%' and", IdentityID);
            if(!String.IsNullOrEmpty(IdentityName))
                sbConditon.AppendFormat(" [IdentityName] like '%{0}%' and",IdentityName);
            if(!String.IsNullOrEmpty(IdentityType))
                sbConditon.AppendFormat(" [IdentityType] like '%{0}%' and",IdentityType);
            if (!String.IsNullOrEmpty(IdentityDeviceUnit))
                sbConditon.AppendFormat(" [IdentityDeviceUnit] = '{0}' and", IdentityDeviceUnit);
            if (!String.IsNullOrEmpty(IdentityDeviceID))
                sbConditon.AppendFormat(" [IdentityDeviceID] like '%{0}%' and", IdentityDeviceID);
            if (!String.IsNullOrEmpty(identityDeviceType))
                sbConditon.AppendFormat(" [identityDeviceType] = '{0}' and", identityDeviceType);
            if (!String.IsNullOrEmpty(type))
                sbConditon.AppendFormat(" [type]='{0}' and", type);
            //if(sbConditon.Length>0)
            //    sbConditon=sbConditon.Remove(sbConditon.Length-3,3);
            sbConditon.AppendFormat(" sDate>= '{0}' and  sDate<='{1}' ",begintime, endtime);
            //sbConditon.AppendFormat(" sDate >= '{1}' and  sDate<='{2}' ", unitname, begintime, endtime);

            ///计算总数据量
            Int64 totalCount =Convert.ToInt64(SQLHelper.ExecuteScalar(String.Format("select count(0) from operationLog where {0}", sbConditon.ToString())));

            ///分页数据
            StringBuilder sbSQL = new StringBuilder();
            sbSQL.AppendFormat("select Top {0} {1} from (",Limit,sbColumn.ToString());
                sbSQL.AppendFormat("select ROW_NUMBER() OVER (ORDER BY sDate desc) AS ROWID,{0}",sbColumn.ToString());
                sbSQL.Append(" from OperationLog ");
                sbSQL.AppendFormat("where {0}",sbConditon.ToString());
            sbSQL.Append(") A ");
            sbSQL.AppendFormat(" where A.ROWID>{0}", rownumID);

            SQLHelper.ExecuteDataReader(ref dt,collist,sbSQL.ToString());
            
            String strJson=JSON.Instance.ToJSON(dt);

            String str = "{\"totalcount\":\"" + totalCount + "\",\"data\":" + strJson + "}";
           
            context.Response.Write(str);
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