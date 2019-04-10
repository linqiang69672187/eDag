using DbComponent;
using Newtonsoft.Json;
using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Xml;

namespace Web.WebGis.Service
{
    public partial class get_useparameter : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            StringBuilder sb = new StringBuilder();
            string username = Request.Cookies["username"].Value.Trim();
            string scnSliceCount = GetSystemAPP("scnSliceCount");
            string theCountToMoHu = GetSystemAPP("theCountToMoHu");
            string TimeInterval = GetSystemAPP("TimeInterval");
            string UnnormalDistance = GetSystemAPP("UnnormalDistance");
            string Emapurl = GetSystemAPP("Mapurl");
            string deviation_la = GetSystemAPP("deviation_la");
            string deviation_lo = GetSystemAPP("deviation_lo");
            string deviation_lo_Hybrid = GetSystemAPP("deviation_lo_Hybrid");
            string deviation_la_Hybrid = GetSystemAPP("deviation_la_Hybrid");
            string maxLevel = GetSystemAPP("maxLevel");
            string minLevel = GetSystemAPP("minLevel");
            string currentLevel = GetSystemAPP("currentLevel");
            string maptype = GetSystemAPP("maptype");
            string mapsize = GetSystemAPP("mapsize");
            DataTable dt = SQLHelper.ExecuteRead(CommandType.Text, "SELECT top 1 a.[lockid],b.Longitude,b.Latitude,a.[device_timeout],a.[hide_timeout_device],a.[refresh_map_interval],a.[last_lo],a.[last_la],a.[displayinfo],(SELECT c.[Name] FROM [Entity] c where c.id = (SELECT d.Entity_ID  FROM [login] d where  d.[Usename]=@username)),h.ISSI,a.isHideOfflineUserBySelect,a.userHeadInfo,a.IsOpenuserHeadInfo, a.headerInfo_status_mode,a.voiceType FROM [use_pramater] a  left join [GIS_info] b on a.lockid = b.User_ID left join [User_info] h on a.lockid=h.id where username = @username ", "Entity", new SqlParameter("username", username));
            DataTable dt1 = SQLHelper.ExecuteRead(CommandType.Text, "SELECT  [TypeName] ,[TypeIcons] FROM [UserType] ", "Entity2");

            sb.Append("{");
            XmlDocument doc = new XmlDocument();
            string defaultLanguage = ConfigurationManager.AppSettings["defaultLanguage"];
            string strFileName = Server.MapPath("../../Languages/" + defaultLanguage + "/Resources.xml");  //相对路径
            doc.Load(strFileName);
            string jsonText = JsonConvert.SerializeXmlNode(doc);
            sb.Append("\"lanuage\":");
            sb.Append(jsonText);

            for (int countdt = 0; countdt < dt.Rows.Count; countdt++)
            {
                // entity.id = int.Parse(dt.Rows[countdt][0].ToString());
                sb.Append(",\"lockid\":\"");
                sb.Append(dt.Rows[countdt][0].ToString());
                sb.Append("\",\"lo\":\"");
                sb.Append(dt.Rows[countdt][1].ToString());
                sb.Append("\",\"la\":\"");
                sb.Append(dt.Rows[countdt][2].ToString());
                sb.Append("\",\"device_timeout\":\"");
                sb.Append(dt.Rows[countdt][3].ToString());
                sb.Append("\",\"hide_timeout_device\":\"");
                sb.Append(dt.Rows[countdt][4].ToString());
                sb.Append("\",\"refresh_map_interval\":\"");
                sb.Append(dt.Rows[countdt][5].ToString());
                sb.Append("\",\"last_lo\":\"");
                sb.Append(dt.Rows[countdt][6].ToString());
                sb.Append("\",\"last_la\":\"");
                sb.Append(dt.Rows[countdt][7].ToString());
                sb.Append("\",\"displayinfo\":\"");
                sb.Append(dt.Rows[countdt][8].ToString());
                sb.Append("\",\"usename\":\"");
                sb.Append(username);
                sb.Append("\",\"entity\":\"");
                sb.Append(dt.Rows[countdt][9].ToString());
                sb.Append("\",\"ISSI\":\"");
                sb.Append(dt.Rows[countdt][10].ToString());
                sb.Append("\",\"isHideOfflineUserBySelect\":\"");
                sb.Append(dt.Rows[countdt][11].ToString().Trim());
                if (dt.Rows[countdt][12].ToString() == "" || dt.Rows[countdt][12].ToString() == null)
                {
                    sb.Append("\",\"userHeadInfo\":\"");
                    sb.Append("name");
                }
                else
                {
                    sb.Append("\",\"userHeadInfo\":\"");
                    sb.Append(dt.Rows[countdt][12].ToString().Trim());
                }
                if (dt.Rows[countdt][13].ToString() == "" || dt.Rows[countdt][13].ToString() == null)
                {
                    sb.Append("\",\"headerInfo_status_mode\":\"");
                    sb.Append("");
                }
                else
                {
                    sb.Append("\",\"headerInfo_status_mode\":\"");
                    sb.Append(dt.Rows[countdt][13].ToString().Trim());
                }
                if (dt.Rows[countdt]["voiceType"].ToString() == "" || dt.Rows[countdt]["voiceType"].ToString() == null)
                {
                    sb.Append("\",\"voiceType\":\"");
                    sb.Append("1");
                }
                else
                {
                    sb.Append("\",\"voiceType\":\"");
                    sb.Append(dt.Rows[countdt]["voiceType"].ToString().Trim());
                }
                if (dt.Rows[countdt]["IsOpenuserHeadInfo"].ToString().Trim() == "open")
                {
                    sb.Append("\",\"IsOpenUserHeaderInfo\":\"");
                    sb.Append("open");
                }
                else
                {
                    sb.Append("\",\"IsOpenUserHeaderInfo\":\"");
                    sb.Append("close");
                }
            }
            sb.Append("\",\"defaultLanguage\":\"" + defaultLanguage);
            sb.Append("\",\"scnSliceCount\":\"" + scnSliceCount + "\", \"theCountToMoHu\":\"" + theCountToMoHu + "\"");
            sb.Append(",\"TimeInterval\":\"" + TimeInterval + "\", \"UnnormalDistance\":\"" + UnnormalDistance + "\"");
            sb.Append(",\"Emapurl\":\"" + Emapurl + "\", \"deviation_lo\":\"" + deviation_lo + "\"" + ", \"deviation_la\":\"" + deviation_la + "\"" + ", \"deviation_lo_Hybrid\":\"" + deviation_lo_Hybrid + "\"" + ", \"deviation_la_Hybrid\":\"" + deviation_la_Hybrid + "\"");
            sb.Append(",\"maxLevel\":\"" + maxLevel + "\"," + "\"minLevel\":\"" + minLevel + "\"," + "\"currentLevel\":\"" + currentLevel + "\"" + ", \"maptype\":\"" + maptype + "\"" + ", \"mapsize\":\"" + mapsize + "\"");
            sb.Append(",\"GISTYPE\":\"" + GetSystemAPP("GISTYPE") + "\", \"PGIS_deviation_lo\":\"" + GetSystemAPP("PGIS_deviation_lo") + "\"" + ", \"PGIS_deviation_la\":\"" + GetSystemAPP("PGIS_deviation_la") + "\"");
            sb.Append(",\"PGIS_Center_lo\":\"" + GetSystemAPP("PGIS_Center_lo") + "\", \"PGIS_Center_la\":\"" + GetSystemAPP("PGIS_Center_la") + "\", \"PGIS_API\":\"" + GetSystemAPP("PGIS_API") + "\"");
            sb.Append(",\"PGIS_Normal_index\":\"" + GetSystemAPP("PGIS_Normal_index") + "\", \"PGIS_HYBRID_index\":\"" + GetSystemAPP("PGIS_HYBRID_index") + "\"");

            sb.Append(",\"Bubble_information\":\"" + GetSystemAPP("UsermessageKey") + "\",\"BaseStationLayer\":\"" + GetSystemAPP("BaseStationLayer") + "\"");

            sb.Append(",\"OriginLo\":\"" + GetSystemAPP("OriginLo") + "\",\"OriginLa\":\"" + GetSystemAPP("OriginLa") + "\"");
            
            //cxy-20180730-聚合图层参数设置
            sb.Append(",\"IsBaseStationLayerCluster\":\"" + GetSystemAPP("IsBaseStationLayerCluster") + "\",\"BaseStationClusterDistance\":\"" + GetSystemAPP("BaseStationClusterDistance") + "\"");
            sb.Append(",\"BaseStationClusterRaduis\":\"" + GetSystemAPP("BaseStationClusterRaduis") + "\"");
            
            //cxy-20180809-场强参数设置
            sb.Append(",\"FieldStrength\":\"" + GetSystemAPP("FieldStrength") + "\"");
            
            //xzj-20180822-摄像头聚合图层参数设置
            sb.Append(",\"IsCameraLayerCluster\":\"" + GetSystemAPP("IsCameraLayerCluster") + "\",\"CameraClusterDistance\":\"" + GetSystemAPP("CameraClusterDistance") + "\"");
            sb.Append(",\"CameraClusterRaduis\":\"" + GetSystemAPP("CameraClusterRaduis") + "\"");
            //xzj--20190320--添加呼叫加密设置
            sb.Append(",\"CallEncryption\":\"" + GetSystemAPP("CallEncryption") + "\"");

            #region 权限jason
            if (Request.Cookies["roleId"].Value != "0" && Request.Cookies["roleId"].Value != "")
            {
                string power = (SQLHelper.ExecuteScalar(CommandType.Text, "select Power from Role where id=@roleId", new SqlParameter("roleId", Request.Cookies["roleId"].Value)).ToString());
                if (power != null && power.Trim() != "")
                {

                    DataTable dtPowerFunction = DbComponent.login.GetPowerFunction();
                    for (int i = 0; i < dtPowerFunction.Rows.Count; i++)
                    {
                        if (i == 0)
                        {
                            sb.Append(",\"" + dtPowerFunction.Rows[i][0].ToString().Trim() + "\":\"");
                        }
                        else
                        {
                            sb.Append("\",\"" + dtPowerFunction.Rows[i][0].ToString().Trim() + "\":\"");
                        }
                        string bit = power.Substring(i, 1);
                        sb.Append(bit);

                        if (dtPowerFunction.Rows[i][0].ToString().Trim() == "VideoCommandEnable")
                        {
                            if (bit == "1")
                                Response.Cookies["VideoCommandEnable"].Value = bit;
                        }
                    }
                    sb.Append("\"");

                }
                else
                {
                    DataTable dtPowerFunction = DbComponent.login.GetPowerFunction();
                    for (int i = 0; i < dtPowerFunction.Rows.Count; i++)
                    {

                        if (i == 0)
                        {
                            sb.Append(",\"" + dtPowerFunction.Rows[i][0].ToString().Trim() + "\":\"");
                        }
                        else
                        {
                            sb.Append("\",\"" + dtPowerFunction.Rows[i][0].ToString().Trim() + "\":\"");
                        }
                        sb.Append("0");
                    }
                    sb.Append("\"");
                }
            }
            else
            {

                DataTable dtPowerFunction = DbComponent.login.GetPowerFunction();
                for (int i = 0; i < dtPowerFunction.Rows.Count; i++)
                {

                    if (i == 0)
                    {
                        sb.Append(",\"" + dtPowerFunction.Rows[i][0].ToString().Trim() + "\":\"");
                    }
                    else
                    {
                        sb.Append("\",\"" + dtPowerFunction.Rows[i][0].ToString().Trim() + "\":\"");
                    }
                    sb.Append("0");
                }
                sb.Append("\"");


            }
            #endregion

            //读取布控公里数
            string CKBKKilometres = System.Configuration.ConfigurationManager.AppSettings["CXBKKilometres"];
            sb.Append(",\"CKBKKilometres\":\"" + CKBKKilometres + "\"");

            string allowLoginRole = System.Web.Configuration.WebConfigurationManager.AppSettings["LoginRole"];

            sb.Append(",\"LoginRole\":\"" + allowLoginRole + "\"");

            //读取组快捷键
            string groupKey = System.Configuration.ConfigurationManager.AppSettings["GroupShortcutKey"];
            sb.Append(",\"GroupShortKey\":\"" + groupKey + "\"");

            //读取entityinformation
            string entityinformation = System.Configuration.ConfigurationManager.AppSettings["entityinformation"];
            sb.Append(",\"entityinformation\":\"" + entityinformation + "\"");

            sb.Append("}");
            Response.Write(sb);

            Response.End();
        }

        private string GetSystemAPP(string st)
        {

            return System.Configuration.ConfigurationManager.AppSettings[st];
        }
    }
}