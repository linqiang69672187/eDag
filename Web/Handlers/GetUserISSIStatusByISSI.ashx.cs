using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using DbComponent;
using System.Text;

namespace Web.Handlers
{
    /// <summary>
    /// GetUserISSIStatusByISSI 的摘要说明
    /// </summary>
    public class GetUserISSIStatusByISSI : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            string ISSI=context.Request["ISSI"].ToString();           
            DbComponent.ISSI oISSI = new DbComponent.ISSI();
            System.Data.DataTable dt=oISSI.GetUserISSIStatusAndIDByISSI(ISSI);

            StringBuilder sb = new StringBuilder();
            sb.Append("{\"id\":\"" + int.Parse(dt.Rows[0][0].ToString()) + "\",\"issiStatus\":\"" + int.Parse(dt.Rows[0][1].ToString()) + "\"}");

            context.Response.Write(sb.ToString());
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