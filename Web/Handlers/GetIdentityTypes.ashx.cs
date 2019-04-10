using DbComponent;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace Web.Handlers
{
    /// <summary>
    /// GetIdentityTypes 的摘要说明
    /// 获取移动用户类型
    /// </summary>
    public class GetIdentityTypes : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            String tablename = context.Request["Table"].ToString();
            IList<Object> types = new List<Object>();
            String sql=String.Format("select distinct(identitytype) from {0} where identitytype is not null",tablename);
            SQLHelper.ExecuteDataReaderTableFields(ref types,sql,CommandType.Text);
            
            context.Response.ContentType = "text/plain";
            context.Response.Write(fastJSON.JSON.Instance.ToJSON(types));
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