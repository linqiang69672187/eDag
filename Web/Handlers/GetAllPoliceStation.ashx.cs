#region
/*
 * 杨德军
 * **/
#endregion
using DbComponent;
using System.Data;
using System.Text;
using System.Web;
using System.Web.SessionState; 

namespace Web.Handlers
{
    /// <summary>
    /// GetAllPoliceStation 的摘要说明
    /// </summary>
    public class GetAllPoliceStation : IHttpHandler, IReadOnlySessionState
    {
        private Entity entityService
        {
            get {
                return new Entity();
            }
        }
        public void ProcessRequest(HttpContext context)
        {
            DataTable dt        = entityService.GetAllEntity();
            StringBuilder sbResult = new StringBuilder();
            sbResult.Append("[");
            if (dt != null && dt.Rows.Count > 0)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    sbResult.Append("{");
                    sbResult.Append("\"ID\":\"" + dt.Rows[i]["ID"] + "\",");
                    sbResult.Append("\"policename\":\"" + dt.Rows[i]["Name"] + "\",");
                    sbResult.Append("\"picurl\":\"" + dt.Rows[i]["PicUrl"] + "\",");
                    sbResult.Append("\"DivID\":\"" + dt.Rows[i]["DivID"] + "\",");
                    sbResult.Append("\"Lo\":\"" + dt.Rows[i]["Lo"] + "\",");
                    sbResult.Append("\"La\":\"" + dt.Rows[i]["La"] + "\"");
                    if (i == dt.Rows.Count - 1)
                    {
                        sbResult.Append("}");
                    }
                    else
                    {
                        sbResult.Append("},");
                    }
                }
            }
            sbResult.Append("]");
            context.Response.Write(sbResult.ToString());
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