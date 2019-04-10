using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Data;
using DbComponent;
using System.Data.SqlClient;

namespace Web.Handlers
{
    /// <summary>
    /// SaveProcedure 的摘要说明
    /// procedurename: procedurename,
    /// ptype: ptype,
    ///                lifttime: lifttime,
    ///                remark: remark,
    ///                firststep: firststep,
     ///               secstep: secstep,
    ///                thirdstep: thirdstep,
    ///                fourstep:fourstep
    /// </summary>
    public class SaveProcedure : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            string procedurename = context.Request["procedurename"].ToString();
            string ptype = context.Request["ptype"].ToString();
            string lifttime = context.Request["lifttime"].ToString();
            string remark = context.Request["remark"].ToString();
            string[] step = context.Request["step"].ToString().Split(',');
            String strsql = string.Empty;
            try
            {
                //日期格式DateTime.Now存入数据库报错改为DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")-----------xzj--2018/6/29-----------------------
                strsql = String.Format("insert into _procedure values('{0}','{1}',{2},'{3}','{4}') select SCOPE_IDENTITY()", procedurename, ptype, lifttime, DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"), remark);
                Object id = SQLHelper.ExecuteScalar(strsql);
                int j = 1;
                for(int i=0;i<step.Length;i++)
                {
                    if (i == step.Length - 1)
                    {
                        j = 127;
                    }
                    else
                        j = i+1;
                    strsql = String.Format("insert into [step] values('{0}','{1}','{2}','{3}','{4}')", id.ToString(), step[i], step[i], j, step[i]);
                    SQLHelper.ExecuteNonQuery(strsql);
                }
                context.Response.Write("5");
            }
            catch
            { 
                context.Response.Write("0");
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