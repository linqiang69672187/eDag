using DbComponent.FactoryMethod;
using DbComponent.IDAO;
using System.Text;
/*
 * 杨德军
 * **/
using System.Web;
using System.Web.SessionState;
namespace Web.Handlers
{
    /// <summary>
    /// GetBaseStationInfoByISSI 的摘要说明
    /// </summary>
    public class GetBaseStationInfoByISSI : IHttpHandler, IReadOnlySessionState
    {
        private IBaseStationDao BaseStationDaoService
        {
            get {
                return DispatchInfoFactory.CreateBaseStationDao();
            }
        }
        public void ProcessRequest(HttpContext context)
        {
            string                          strISSI          = context.Request["issi"].ToString();
            int switchID = string.IsNullOrEmpty(context.Request["switchID"].ToString()) == true ? 0 : int.Parse(context.Request["switchID"].ToString());//xzj--20181228--添加交换
            MyModel.Model_BaseStation MBS = BaseStationDaoService.GetBaseStationByISSI(strISSI, switchID);
            StringBuilder                   sbResult         = new StringBuilder();
            sbResult.Append("[");
            if (MBS != null)
            {
                sbResult.Append("{");
                sbResult.Append("\"ID\":\"" + MBS.ID + "\",");
                sbResult.Append("\"StationName\":\"" + MBS.StationName + "\",");
                sbResult.Append("\"StationISSI\":\"" + MBS.StationISSI + "\",");
                sbResult.Append("\"DivID\":\"" + MBS.DivID + "\",");
                sbResult.Append("\"PicUrl\":\"" + MBS.PicUrl + "\",");
                sbResult.Append("\"Lo\":\"" + MBS.Lo + "\",");
                sbResult.Append("\"La\":\"" + MBS.La + "\"");
                sbResult.Append("}");
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