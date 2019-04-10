#region
/*
 * 杨德军
 * **/
#endregion
using DbComponent.IDAO;
using System.Data;
using System.Web;
using System.Web.SessionState;
namespace Web.Handlers
{
    /// <summary>
    /// AddSMS 的摘要说明
    /// </summary>
    public class AddSMS : IHttpHandler, IReadOnlySessionState
    {
        private ISMSInfoDao SmsInfoService
        {
            get
            {
                return DbComponent.FactoryMethod.DispatchInfoFactory.CreateSmsInfoDao();
            }
        }

        public void ProcessRequest(HttpContext context)
        {
            if (context.Request.Cookies["dispatchissi"] == null)
            {
                return;
            }

            string strSMSContent = context.Request["content"].ToString();
            strSMSContent = strSMSContent.Replace("\n", "  ");
            strSMSContent = strSMSContent.Replace("\r", "  ");
            string strSendISSI = context.Request.Cookies["dispatchissi"].Value.ToString();
            string strRevISSI = context.Request["issi"].ToString();
            string IsReturn = context.Request["isreturn"].ToString();
            string strSMSID = context.Request["smsid"].ToString();
            int SmsType = 0;
            if (context.Request["smsType"].ToString()== "")
            {
                SmsType = 0;
            }
            else
            {
             SmsType = int.Parse(context.Request["smsType"].ToString());
            }
            string isGroup = context.Request["isgroup"].ToString();
            string status ="";
            if (IsReturn == "1")
            {
                SmsType = (int)MyModel.Enum.SMSType.Need_Receipt_Msg;

            }
            if (isGroup != "1")
            {
                isGroup = "0";
                if (strRevISSI.Contains("("))//xzj--20190227--添加基站短信
                {
                    status = context.Request["status"].ToString();
                }
            }
            else
            {
                status = context.Request["status"].ToString();
            }

            //经纬度直接在这里根据ISSI号码去GIS_Info表里面查询
            DataTable lolaDt = DbComponent.Gis.GetLoLaByISSI(strSendISSI);
            decimal decLo = 0;
            decimal decLa = 0;
            if (lolaDt != null && lolaDt.Rows.Count > 0)
            {
                decLo = decimal.Parse(lolaDt.Rows[0]["Longitude"].ToString());
                decLa = decimal.Parse(lolaDt.Rows[0]["Latitude"].ToString());
            }

            MyModel.Model_SMSInfo ms = new MyModel.Model_SMSInfo
            {
                RevISSI = strRevISSI,
                SMSContent = strSMSContent,
                SendISSI = strSendISSI,
                SMSType = SmsType,
                SMSID = strSMSID,
                Lo = decLo,
                La = decLa,
                SMSMsg = status,
                IsGroup = int.Parse(isGroup)
            };
            SmsInfoService.Save(ms);
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