using DbComponent;
using DbComponent.IDAO;
using System.Data;
using System.Text;
using System.Web;
using System.Web.SessionState;

namespace Web.Handlers
{
    /// <summary>
    /// GetUserInfoByID_Handler 的摘要说明
    /// </summary>
    public class GetUserInfoByID_Handler : IHttpHandler, IReadOnlySessionState
    {
        private userinfo UserInfoService
        {
            get
            {
                return new userinfo();
            }
        }
        private IDispatchInfoDao DispatchInfoService
        {
            get
            {
                return DbComponent.FactoryMethod.DispatchInfoFactory.CreateDispatchInfoDao();
            }
        }
        public void ProcessRequest(HttpContext context)
        {
            StringBuilder sbResult = new StringBuilder("[{");
            string ID = context.Request["id"].ToString();
            DataTable dt = UserInfoService.GetInfoByID(int.Parse(ID));

            if (dt != null && dt.Rows.Count > 0 && ID != "")
            {
                string hidissi = DbComponent.login.GETHDISSI(context.Request.Cookies["username"].Value);

                sbResult.Append("\"entity\":" + "\"" + dt.Rows[0]["Name"] + "\",");
                sbResult.Append("\"id\":" + "\"" + dt.Rows[0]["ID"] + "\",");
                sbResult.Append("\"lo\":" + "\"" + dt.Rows[0]["Longitude"] + "\",");
                sbResult.Append("\"la\":" + "\"" + dt.Rows[0]["Latitude"] + "\",");
                sbResult.Append("\"nam\":" + "\"" + dt.Rows[0]["Nam"] + "\",");
                sbResult.Append("\"issi\":" + "\"" + dt.Rows[0]["issi"] + "\",");
                //System.DateTime dtInserttime = System.DateTime.Parse(dt.Rows[0]["Inserttb_time"].ToString());
                System.DateTime dtInserttime = new System.DateTime();
                if (dt.Rows[0]["Inserttb_time"].ToString() == null || dt.Rows[0]["Inserttb_time"].ToString() == "")
                {
                    dtInserttime = System.DateTime.Now;
                }
                else
                {
                    dtInserttime = System.DateTime.Parse(dt.Rows[0]["Inserttb_time"].ToString());
                }

                sbResult.Append("\"year\":" + "\"" + dtInserttime.Year + "\",");
                sbResult.Append("\"month\":" + "\"" + checkTime(dtInserttime.Month.ToString()) + "\",");
                sbResult.Append("\"day\":" + "\"" + checkTime(dtInserttime.Day.ToString()) + "\",");
                if (hidissi.IndexOf(dt.Rows[0]["ISSI"].ToString()) > 0)
                {
                    sbResult.Append("\"isdisplay\":" + "\"False\",");
                }
                else
                {
                    sbResult.Append("\"isdisplay\":" + "\"True\",");
                }

                sbResult.Append("\"num\":" + "\"" + dt.Rows[0]["Num"] + "\",");
                sbResult.Append("\"Telephone\":" + "\"" + dt.Rows[0]["Telephone"] + "\",");
                sbResult.Append("\"Position\":" + "\"" + dt.Rows[0]["Position"] + "\",");
                 sbResult.Append("\"bz\":" + "\"" + dt.Rows[0]["bz"] + "\",");
                sbResult.Append("\"battery\":" + "\"" + dt.Rows[0]["Battery"].ToString().Trim() + "\",");//--xzj--20181224--添加获取的场强信息
                sbResult.Append("\"msRssi\":" + "\"" + dt.Rows[0]["MsRssi"].ToString().Trim() + "\",");
                sbResult.Append("\"ulRssi\":" + "\"" + dt.Rows[0]["UlRssi"].ToString().Trim() + "\"");

            }
            
            sbResult.Append("}]");
            context.Response.Write(sbResult.ToString());
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
        private string checkTime(string time)
        {
            if (int.Parse(time) < 10 && int.Parse(time.Substring(0, 1)) != 0)
            {
                time = "0" + time;
            }
            return time.ToString();
        }
    }
}