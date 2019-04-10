#region
/*
 * 杨德军
 * **/
#endregion
using DbComponent.FactoryMethod;
using DbComponent.IDAO;
using System;
using System.Data;
using System.Reflection;
using System.Text;
using System.Web;
using System.Web.SessionState; 

namespace Web.Handlers
{
    /// <summary>
    /// GetAllBaseStation 的摘要说明
    /// </summary>
    public class GetAllBaseStation : IHttpHandler, IReadOnlySessionState
    {
        private static readonly log4net.ILog      log  = log4net.LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType); 
        private IBaseStationDao BaseStationDaoService {
            get {
                return DispatchInfoFactory.CreateBaseStationDao();
            }
        }
        public void ProcessRequest(HttpContext context)
        {
            System.Configuration.Configuration config = System.Web.Configuration.WebConfigurationManager.OpenWebConfiguration(System.Web.HttpContext.Current.Request.ApplicationPath);
            System.Configuration.AppSettingsSection appSettings = (System.Configuration.AppSettingsSection)config.GetSection("appSettings");
            string firstUser="";
            string PoliceType = appSettings.Settings["PoliceType"].Value.ToString();
            try
            {
                DataTable                         dt        = BaseStationDaoService.GetAllBaseStation();
                StringBuilder                     sbResult  = new StringBuilder();
                sbResult.Append("[");
                if (dt != null && dt.Rows.Count > 0)
                {
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {

                        int num = BaseStationDaoService.getAllBsDeviceCount(dt.Rows[i]["StationISSI"].ToString(), string.IsNullOrEmpty(dt.Rows[i]["SwitchID"].ToString()) == true ? 0 : int.Parse(dt.Rows[i]["SwitchID"].ToString()));//xzj--20181217
                       DataTable PoliceTypeTable = BaseStationDaoService.GetAllBaseStationUserName(PoliceType, dt.Rows[i]["StationName"].ToString());//查找当前基站下警员数量
                        if(!Convert.ToBoolean(System.Configuration.ConfigurationManager.AppSettings["IsBasestationHeadInformation"]))
                       {
                             if (PoliceTypeTable.Rows.Count != 0)
                           {
                               firstUser = PoliceTypeTable.Rows[0]["Nam"].ToString();
                           }
                           else
                           {
                               firstUser = "";
                           }

                       }

                        sbResult.Append("{");
                        sbResult.Append("\"ID\":\"" + dt.Rows[i]["ID"] + "\",");
                        sbResult.Append("\"StationName\":\"" + dt.Rows[i]["StationName"] + "\",");
                        sbResult.Append("\"StationISSI\":\"" + dt.Rows[i]["StationISSI"] + "\",");
                        sbResult.Append("\"DivID\":\"" + dt.Rows[i]["DivID"] + "\",");
                        sbResult.Append("\"PicUrl\":\"" + dt.Rows[i]["PicUrl"] + "\",");
                        sbResult.Append("\"Lo\":\"" + dt.Rows[i]["Lo"] + "\",");
                        sbResult.Append("\"La\":\"" + dt.Rows[i]["La"] + "\",");           
                        sbResult.Append("\"DeviceCount\":\"" +num + "\",");
                        sbResult.Append("\"FirstUser\":\"" + firstUser  + "\",");
                        sbResult.Append("\"SwitchID\":\"" + dt.Rows[i]["SwitchID"] + "\","); //xzj--20181217

                        string sbAdd = "";
                        for (int n = 0; n < PoliceTypeTable.Rows.Count; n++)
                        {
                            sbAdd += PoliceTypeTable.Rows[n]["Nam"] + ";";

                        }
                        if (sbAdd.Length > 0)
                            sbResult.Append("\"PoliceType\":\"" + sbAdd.Substring(0, sbAdd.Length - 1) + "\"");
                        else
                            sbResult.Append("\"PoliceType\": \" \" ");

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
                //log.Info("获取所有基站信息！");
            }
            catch (Exception ex)
            {
                log.Error(ex);
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