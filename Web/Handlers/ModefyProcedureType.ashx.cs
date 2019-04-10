using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using DbComponent;
using System.Data;

namespace Web.Handlers
{
    /// <summary>
    /// ModefyProcedureType 的摘要说明
    /// </summary>
    public class ModefyProcedureType : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            String procedurename = context.Request["procedurename"].ToString();
            String reserve1 = context.Request["reserve1"].ToString();
            String reserve2 = context.Request["reserve2"].ToString();
            String reserve3 = context.Request["reserve3"].ToString();
            String reserve4 = context.Request["reserve4"].ToString();
            String reserve5 = context.Request["reserve5"].ToString();
            String reserve6 = context.Request["reserve6"].ToString();
            String reserve7 = context.Request["reserve7"].ToString();
            String reserve8 = context.Request["reserve8"].ToString();
            String reserve9 = context.Request["reserve9"].ToString();
            String reserve10 = context.Request["reserve10"].ToString();
            String remark = context.Request["remark"].ToString();

            StringBuilder sbcondition = new StringBuilder();
            sbcondition.AppendFormat("if exists(select name from procedure_type where name='{0}') ", procedurename);
            sbcondition.Append("begin ");
            sbcondition.Append("update procedure_type set ");
            sbcondition.AppendFormat("reserve1='{0}',reserve2='{1}',reserve3='{2}',reserve4='{3}',reserve5='{4}',reserve6='{5}',reserve7='{6}',reserve8='{7}',reserve9='{8}',reserve10='{9}',remark='{10}' ", reserve1, reserve2, reserve3, reserve4, reserve5, reserve6, reserve7, reserve8, reserve9, reserve10, remark);
            sbcondition.AppendFormat("where name='{0}' ",procedurename);
            sbcondition.Append("end ");
            sbcondition.Append("else begin ");
            sbcondition.AppendFormat("insert into procedure_type values('{0}','{1}','{2}','{3}','{4}','{5}','{6}','{7}','{8}','{9}','{10}','{11}') ",procedurename, reserve1, reserve2, reserve3, reserve4, reserve5, reserve6, reserve7, reserve8, reserve9, reserve10, remark);
            sbcondition.Append("end");
            int i=SQLHelper.ExecuteNonQuery(sbcondition.ToString());
            context.Response.Write(i.ToString());
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