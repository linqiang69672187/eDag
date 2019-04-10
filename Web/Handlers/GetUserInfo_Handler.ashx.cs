using DbComponent;
using DbComponent.IDAO;
using System.Data;
using System.Text;
using System.Web;
using System.Web.SessionState;
using System.Reflection;

namespace Web.Handlers
{
    /// <summary>
    /// GetUserInfo_Handler 的摘要说明
    /// </summary>
    public class GetUserInfo_Handler : IHttpHandler, IReadOnlySessionState
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
        private static readonly log4net.ILog log = log4net.LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);
        public void ProcessRequest(HttpContext context)
        {
            try
            {
                StringBuilder sbResult = new StringBuilder("[{");
                string issi = context.Request["issi"].ToString();
                DataTable dt = UserInfoService.GetInfoByISSI(issi);

                if (dt != null && dt.Rows.Count > 0 && issi != "")
                {
                    string hidissi = DbComponent.login.GETHDISSI(context.Request.Cookies["username"].Value);

                    sbResult.Append("\"entity\":" + "\"" + dt.Rows[0]["Name"] + "\",");
                    sbResult.Append("\"id\":" + "\"" + dt.Rows[0]["ID"] + "\",");
                    sbResult.Append("\"lo\":" + "\"" + dt.Rows[0]["Longitude"] + "\",");
                    sbResult.Append("\"la\":" + "\"" + dt.Rows[0]["Latitude"] + "\",");
                    sbResult.Append("\"nam\":" + "\"" + dt.Rows[0]["Nam"] + "\",");
                    sbResult.Append("\"type\":" + "\"" + dt.Rows[0]["type"] + "\",");
                    sbResult.Append("\"issitype\":" + "\"" + dt.Rows[0]["typeName"] + "\",");
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
                    if (hidissi.IndexOf(issi) > 0)
                    {
                        sbResult.Append("\"isdisplay\":" + "\"False\",");
                    }
                    else
                    {
                        sbResult.Append("\"isdisplay\":" + "\"True\",");
                    }

                    sbResult.Append("\"num\":" + "\"" + dt.Rows[0]["Num"] + "\",");
                    sbResult.Append("\"issi\":" + "\"" +issi+ "\"");
                }
                else
                {
                    if (context.Request["type"] != null)
                    {
                        MyModel.Model_Dispatch_View MDV = DispatchInfoService.GetModelDispatchViewByISSI(issi);
                        if (MDV.EntityName != null)
                        {
                            sbResult.Append("\"entity\":" + "\"" + MDV.EntityName + "\",");

                            sbResult.Append("\"nam\":" + "\"" + Ryu666.Components.ResourceManager.GetString("Dispatch") + "\",");//多语言:调度台
                            sbResult.Append("\"type\":" + "\"" + Ryu666.Components.ResourceManager.GetString("Dispatch") + "\",");

                            sbResult.Append("\"num\":\"\"");
                        }
                        else
                        {
                            sbResult.Append("\"entity\":" + "\"\",");

                            sbResult.Append("\"nam\":\"\",");
                            sbResult.Append("\"type\":" + "\"\",");

                            sbResult.Append("\"num\":\"\"");
                        }
                    }
                }
                sbResult.Append("}]");
                context.Response.Write(sbResult.ToString());
            }
            catch (System.Exception er)
            {
                log.Debug(er.Message + "::::::Freeman");
            }
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