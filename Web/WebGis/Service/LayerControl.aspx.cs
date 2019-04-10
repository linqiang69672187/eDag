using DbComponent;
using System;
using System.Collections;
using System.Data.SqlClient;
using System.Data;
using System.IO;
using System.Text;
using System.Web.UI.WebControls;
using System.Web.UI;
using System.Text.RegularExpressions;
using System.Collections.Generic;
using System.Diagnostics;
using System.Web;
using System.Threading;


namespace Web.WebGis.Service
{
    public partial class LayerControl : Web.lqnew.opePages.BasePage
    {
        String SelectedEntity = String.Empty;
        string hostipadd = String.Empty;
        string dispatchUserName = String.Empty;
        //WebSQLDb db = new WebSQLDb(Web.Config.m_connectionString);      
        public String[] must_display_police;
        public int scnSliceCount = Convert.ToInt32(System.Configuration.ConfigurationManager.AppSettings["scnSliceCount"]);
        public int theCountToMoHu = Convert.ToInt32(System.Configuration.ConfigurationManager.AppSettings["theCountToMoHu"]);
        public double maxlo, maxla, minlo, minla;
        public int M;
        public List<policeData_elment> policedatalist = new List<policeData_elment>();
        private List<policeData_elment> preList = new List<policeData_elment>();

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                //DateTime tt1 = DateTime.Now;
                if (!IsPostBack)
                {
                    hostipadd = Request.UserHostAddress;
                    if (hostipadd == "::1")
                    {
                        hostipadd = "127.0.0.1";
                    }
                }

                //Response.Cookies["id"].Value = "3";
                //Response.Cookies["username"].Value = "hzga";
                dispatchUserName = Request.Cookies["username"].Value;
                if (Request.Form["SelectedEntity"] != null)
                {
                    SelectedEntity = Request.Form["SelectedEntity"];
                    setSelectedEntityToFile(SelectedEntity);
                }
                else
                {
                    SelectedEntity = getSelectedEntityFromFile();
                }

                string checkEntity = Request.Form["checkEntity"];
                if (checkEntity != "empty" && checkEntity != "" && checkEntity != null)
                {
                    SelectedEntity = checkEntity;
                }

                DbComponent.login.updateloginandlasttime(Request.Cookies["username"].Value.Trim());//更新登录时间
                string function = Request.Form["func"];

                must_display_police = Request.Form["must_display_user"].Split('|'); //获取客户端传来的必须显示警员ID
                maxla = Convert.ToDouble(Request.Form["maxla"]);    //获取客户端传来的经纬度范围
                maxlo = Convert.ToDouble(Request.Form["maxlo"]);
                minla = Convert.ToDouble(Request.Form["minla"]);
                minlo = Convert.ToDouble(Request.Form["minlo"]);
                M = Convert.ToInt32(Math.Sqrt(scnSliceCount));
                var policeData = Request.Form["users"];
                //用session存储数据
                if (policeData != null)
                {
                    preList = lqnew.opePages.Serial.JSONStringToList<policeData_elment>(policeData.ToString());
                }
                if (!string.IsNullOrEmpty(function))
                {
                    switch (function)
                    {
                        case "LoadDataToLayerControl":
                            {
                                LoadDataToLayerControlByBound(Request.Form["layers"], Request.Form["bss"]);
                                break;
                            }//bss == bound,select,storedProcedures

                        default: { break; }
                    }
                }

                //DateTime tt2 = DateTime.Now;
                //TimeSpan tts1 = new TimeSpan(tt1.Ticks);
                //TimeSpan tts2 = new TimeSpan(tt2.Ticks);
                //TimeSpan tts = tts1.Subtract(tts2).Duration();
                //string ttimediff = tts.TotalMilliseconds.ToString();
                //log.Info("time_for_milli:" + ttimediff);
            }
            catch (Exception ex)
            {
                //log.Info("LayerControl_Exception:" + ex);
            }
        }
        public struct Screen_Slice_Data
        {
            public point point1;
            public point point0;
            public int policecount;
            //public List<policeData_elment> policedata;
        }
        public struct point
        {
            public double x;
            public double y;
        }
        public struct policeData_elment
        {
            public string ID { get; set; }
            public string Info { get; set; }
            public string ISSI { get; set; }
            public double Latitude { get; set; }
            public double Longitude { get; set; }
            public string Send_reason { get; set; }
            public DateTime Send_time { get; set; }
            public string type { get; set; }
            public string terminalType { get; set; }
            public string ipAddress { get; set; }
            public string terminalStatus { get; set; }
            public string enity { get; set; }
            public int MsRssi { get; set; }
            public int UlRssi { get; set; }
            public int Battery { get; set; }
            public bool online { get; set; }
        }

        public void LoadDataToLayerControlByBound(string layers, string bss)
        {
            string[] bssArr = bss.Split('|');
            //string bound = bssArr[0];
            //string select = bssArr[1];
            //string storedProcedures = bssArr[2];
            //string hideovertimeDevice = bssArr[3];
            //string device_timeout = bssArr[4];
            LoadDataToLayerControl(bssArr[0], bssArr[1], layers, bssArr[2], bssArr[3], bssArr[4]);
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="bound"></param>
        /// <param name="select"></param>
        /// <param name="layers">@layer1isTwoG,@layer1manufactoryId,@layer1site_type|
        /// @layer2isTwoG,@layer2manufactoryId,@layer2site_type</param>
        /// <param name="storedProcedures"></param>
        public void LoadDataToLayerControl(string bound, string select, string layers, string storedProcedures, string hideovertimeDevice, string device_timeout)
        {
            //如果Session存在数据则从Session获取 否则需要重新获取
            string JSONLayerControl = GetLayerDataJSONString(layers, bound, select, storedProcedures, hideovertimeDevice, device_timeout);

            Response.Write(JSONLayerControl);
            Response.End();
        }
        /// <summary>
        /// 获取图层数据到Session
        /// </summary>
        /// <param name="LayerID"></param>
        /// <returns></returns>
        private string GetLayerDataJSONString(string layers, string bound, string select, string storedProcedures, string hideovertimeDevice, string device_timeout)
        {
            GetLayerData_datareader(layers, bound, select, storedProcedures, int.Parse(Request.Cookies["id"].Value.ToString()), Request.Cookies["username"].Value.Trim(), hideovertimeDevice, device_timeout, SelectedEntity);
            List<List<policeData_elment>> resultList = comparePreData(preList, policedatalist);
            string addJson = createjsondata(resultList[0], "add");
            string updateJson = createjsondata(resultList[1], "update");
            string removeJson = createjsondata(resultList[2], "remove");
            string resultJson = "{" + addJson + "," + updateJson + "," + removeJson + "}";
            //System.Web.HttpContext.Current.Session["Currentview"] = layerDs; 
            return resultJson;
        }

        public static string ExecDateDiff(DateTime dateBegin, DateTime dateEnd)
        {
            TimeSpan ts1 = new TimeSpan(dateBegin.Ticks);
            TimeSpan ts2 = new TimeSpan(dateEnd.Ticks);
            TimeSpan ts3 = ts1.Subtract(ts2).Duration();
            //你想转的格式
            return ts3.TotalMinutes.ToString();
        }


        string mycount = "0";
        int userLimitCount = 0;
        int count = 0;
        /// <summary>
        /// 去掉了模糊算法，改为根据web.config参数进行个数限制。
        /// </summary>
        /// <param name="layerdr"></param>
        public void selectslicedatas(SqlDataReader layerdr)
        {
            if (!layerdr.HasRows)
            {
                return;
            }
            try
            {
                int flag = 0;
               

                System.Configuration.Configuration config = System.Web.Configuration.WebConfigurationManager.OpenWebConfiguration(System.Web.HttpContext.Current.Request.ApplicationPath);
                System.Configuration.AppSettingsSection appSettings = (System.Configuration.AppSettingsSection)config.GetSection("appSettings");
                userLimitCount = int.Parse(appSettings.Settings["UserLimitCount"].Value);

                if (Request.Cookies["roleId"].Value == "4" || Request.Cookies["roleId"].Value == "5")
                {
                    if (Request.Cookies["VideoCommandEnable"].Value == "1")
                    {
                        userLimitCount = userLimitCount / 2;
                    }
                }

                policedatalist = new List<policeData_elment>();
                policeData_elment police_elment = new policeData_elment();
                DateTime dtime = DateTime.Now;
         
                while (layerdr.Read())
                {
                   
                        police_elment.ID = layerdr["ID"].ToString();
                        // police_elment.dbdatediff = layerdr["dbdatediff"].ToString();
                        police_elment.ISSI = layerdr["ISSI"].ToString();
                        police_elment.Latitude = Convert.ToDouble(layerdr["Latitude"]);
                        police_elment.Longitude = Convert.ToDouble(layerdr["Longitude"]);
                        flag = 0;
                        if (Array.IndexOf(must_display_police, police_elment.ID) >= 0 || Array.IndexOf(must_display_police, police_elment.ISSI) >= 0)
                        {
                            flag = 1;
                        }
                        count++;

                        if (count <= userLimitCount || flag == 1)
                      {
                        police_elment.Info = String.Format("{0}({1}),{2},{3}", layerdr["Nam"].ToString(), police_elment.ISSI, layerdr["Num"].ToString(), layerdr["type"].ToString());
                        police_elment.Send_reason = layerdr["Send_reason"].ToString();
                        police_elment.Send_time = Convert.ToDateTime(layerdr["Send_time"]);
                        police_elment.type = layerdr["type"].ToString();
                        police_elment.enity = layerdr["name"].ToString();
                        //terminalType
                        police_elment.terminalType = layerdr["terminalType"].ToString().Trim();
                        police_elment.ipAddress = layerdr["ipAddress"].ToString().Trim();
                        police_elment.terminalStatus = layerdr["terminalStatus"].ToString().Trim();
string msRssi = layerdr["MsRssi"].ToString().Trim();
                        police_elment.MsRssi = msRssi == string.Empty ? -1 : int.Parse(msRssi);
                        string ulRssi = layerdr["UlRssi"].ToString().Trim();
                        police_elment.UlRssi = ulRssi == string.Empty ? -1 : int.Parse(ulRssi);
                        string battery = layerdr["Battery"].ToString().Trim();
                        police_elment.Battery = battery == string.Empty ? -1 : int.Parse(battery);
                        policedatalist.Add(police_elment);
                     }
                               
                    else
                    {
                        continue;
                    }
                   

                }


                if (count > userLimitCount)
                {
                    log.Info("当前经纬度范围内警员" + count + "个,限定数量" + userLimitCount + "个");
                    mycount = "1";

                }


            }
            catch (Exception ex)
            {
                ex.ToString();
            }
        }
        public string createjsondata(List<policeData_elment> policeDataList, string type)
        {
            StringBuilder JSON = new StringBuilder();

            //JSON.Append("{");


            //JSON.Append('"');
            //JSON.Append("zcount");
            //JSON.Append('"');
            //JSON.Append(":");

            //JSON.Append('"');
            //JSON.Append(count.ToString());
            //JSON.Append('"');

            //JSON.Append(',');


            //JSON.Append('"');
            //JSON.Append("Count");
            //JSON.Append('"');
            //JSON.Append(":");

            //JSON.Append('"');
            //JSON.Append(mycount);
            //JSON.Append('"');

            //JSON.Append(',');


            //JSON.Append('"');
            //JSON.Append("userLimitCount");
            //JSON.Append('"');
            //JSON.Append(":");

            //JSON.Append('"');
            //JSON.Append(userLimitCount.ToString());
            //JSON.Append('"');

            //JSON.Append(',');




            JSON.Append('"');
            JSON.Append(type);
            JSON.Append('"');
            JSON.Append(":[");
            if (policeDataList == null || policeDataList.Count == 0)
            {
                JSON.Append("]");
                return JSON.ToString();
            }
            else
            {
                foreach (var c in policeDataList)
                {
                    JSON.Append("{");
                    JSON.Append('"');
                    JSON.Append("ISSI");
                    JSON.Append('"');
                    JSON.Append(":");
                    JSON.Append('"');
                    JSON.Append(c.ISSI);
                    JSON.Append('"');
                    JSON.Append(',');
                    JSON.Append('"');
                    JSON.Append("ID");
                    JSON.Append('"');
                    JSON.Append(":");
                    JSON.Append('"');
                    JSON.Append(c.ID);
                    JSON.Append('"');
                    JSON.Append(',');
                    JSON.Append('"');
                    JSON.Append("Info");
                    JSON.Append('"');
                    JSON.Append(":");
                    JSON.Append('"');
                    JSON.Append(c.Info);
                    JSON.Append('"');
                    JSON.Append(',');
                    JSON.Append('"');
                    JSON.Append("Latitude");
                    JSON.Append('"');
                    JSON.Append(":");
                    JSON.Append('"');
                    JSON.Append(c.Latitude.ToString());
                    JSON.Append('"');
                    JSON.Append(',');
                    JSON.Append('"');
                    JSON.Append("Longitude");
                    JSON.Append('"');
                    JSON.Append(":");
                    JSON.Append('"');
                    JSON.Append(c.Longitude.ToString());
                    JSON.Append('"');
                    JSON.Append(',');
                    JSON.Append('"');
                    JSON.Append("Send_reason");
                    JSON.Append('"');
                    JSON.Append(":");
                    JSON.Append('"');
                    JSON.Append(c.Send_reason);
                    JSON.Append('"');
                    JSON.Append(',');
                    JSON.Append('"');
                    JSON.Append("Send_time");
                    JSON.Append('"');
                    JSON.Append(":");
                    JSON.Append('"');
                    JSON.Append(c.Send_time);
                    JSON.Append('"');
                    JSON.Append(',');
                    JSON.Append('"');
                    JSON.Append("entity");
                    JSON.Append('"');
                    JSON.Append(":");
                    JSON.Append('"');
                    JSON.Append(c.enity);
                    JSON.Append('"');
                    JSON.Append(',');
                    JSON.Append('"');
                    JSON.Append("type");
                    JSON.Append('"');
                    JSON.Append(":");
                    JSON.Append('"');
                    JSON.Append(c.type);
                    JSON.Append('"');
                    JSON.Append(',');
                    JSON.Append('"');
                    JSON.Append("terminalType");
                    JSON.Append('"');
                    JSON.Append(":");
                    JSON.Append('"');
                    JSON.Append(c.terminalType);
                    JSON.Append('"');
                    JSON.Append(',');
                    JSON.Append('"');
                    JSON.Append("ipAddress");
                    JSON.Append('"');
                    JSON.Append(":");
                    JSON.Append('"');
                    JSON.Append(c.ipAddress);
                    JSON.Append('"');
                    JSON.Append(',');
                    JSON.Append('"');
                    JSON.Append("terminalStatus");
                    JSON.Append('"');
                    JSON.Append(":");
                    JSON.Append('"');
                    JSON.Append(c.terminalStatus);
                    JSON.Append('"');
                    JSON.Append(',');
                    JSON.Append('"');
                    JSON.Append("MsRssi");
                    JSON.Append('"');
                    JSON.Append(":");
                    JSON.Append('"');
                    JSON.Append(c.MsRssi);
                    JSON.Append('"');
                    JSON.Append(',');
                    JSON.Append('"');
                    JSON.Append("UlRssi");
                    JSON.Append('"');
                    JSON.Append(":");
                    JSON.Append('"');
                    JSON.Append(c.UlRssi);
                    JSON.Append('"');
                    JSON.Append(',');
                    JSON.Append('"');
                    JSON.Append("Battery");
                    JSON.Append('"');
                    JSON.Append(":");
                    JSON.Append('"');
                    JSON.Append(c.Battery);
                    JSON.Append('"');
                    JSON.Append("},");
                }
                JSON.Remove(JSON.Length - 1, 1);

                JSON.Append("]");

                return JSON.ToString();
            }
        }
 
        private List<List<policeData_elment>> comparePreData(List<policeData_elment> prePoliceData, List<policeData_elment> currentPoliceData)
        {
            List<List<policeData_elment>> resultList = new List<List<policeData_elment>>();
            List<policeData_elment> addList = new List<policeData_elment>();
            List<policeData_elment> updateList = new List<policeData_elment>();
            List<policeData_elment> removeList = new List<policeData_elment>();
            foreach (var cpd in currentPoliceData)
            {
                var isExist = false;
                foreach (var ppd in prePoliceData)
                {
                    if (cpd.ID == ppd.ID) 
                    {
                        isExist = true;
                        bool isSimilar = CompareProperties(cpd, ppd,typeof(policeData_elment));
                        if (!isSimilar) 
                        {
                            updateList.Add(cpd);
                        }
                        break;
                    }
                }
                if (!isExist)
                {
                    addList.Add(cpd);
                }
            }
            foreach (var ppd in prePoliceData)
            {
                var isExist = false;
                foreach (var cpd in currentPoliceData)
                {
                    if (ppd.ID == cpd.ID)
                    {
                        isExist = true;
                        break;
                    }
                }
                if (!isExist)
                {
                    removeList.Add(ppd);
                }
            }
            resultList.Add(addList);
            resultList.Add(updateList);
            resultList.Add(removeList);
            return resultList;
        }

        private bool CompareProperties<T>(T obj1, T obj2, Type type)
        {
            //为空判断
            if (obj1 == null && obj2 == null)
                return true;
            else if (obj1 == null || obj2 == null)
                return false;

            bool isOnline = true;

            Type t = type;
            System.Reflection.PropertyInfo[] props = t.GetProperties();
            foreach (var po in props)
            {
                if (po.PropertyType.FullName.Contains("DateTime"))
                {
                    DateTime dt1 = (DateTime)po.GetValue(obj1, null);
                    DateTime dt2 = (DateTime)po.GetValue(obj2, null);
                    if(dt1 != null && dt2 != null)
                    {
                        System.TimeSpan timeSpan = DateTime.Now - dt1;
                        if (timeSpan.TotalMinutes > 5)
                        {
                            isOnline = false;
                        }
                        if (!dt1.ToString().Equals(dt2.ToString()))
                        {
                            return false;
                        }
                    }
                }
                else if(po.Name.Contains("online"))
                {
                    bool online = Convert.ToBoolean(po.GetValue(obj2, null));
                    if (!online.Equals(isOnline))
                    {
                        po.SetValue(obj1, isOnline, null);
                        return false;
                    }
                }
                else
                {
                    if (!po.GetValue(obj1, null).Equals(po.GetValue(obj2, null)))
                    {
                        return false;
                    }
                }
            }

            return true;
        }

        public void GetLayerData_datareader(string layers, string bound, string select, string storedProcedures, int id, string username, string hideovertimeDevice, string device_timeout, String SelectedEntity)
        {
            try
            {
                SqlParameter[] sp = new SqlParameter[9];
                sp[0] = new SqlParameter("@layers", layers);
                sp[1] = new SqlParameter("@bounds", bound);
                sp[2] = new SqlParameter("@select", select);
                sp[3] = new SqlParameter("@PROCEDURE", storedProcedures);
                sp[4] = new SqlParameter("@id", id);
                sp[5] = new SqlParameter("@username", username);
                sp[6] = new SqlParameter("@hideovertimeDevice", hideovertimeDevice);
                sp[7] = new SqlParameter("@device_timeout", device_timeout);
                sp[8] = new SqlParameter("@SelectedEntity", SelectedEntity);
                ExecuteDatareader(Config.m_connectionString, CommandType.StoredProcedure, "map_LayerDataGet", sp);
            }
            catch (Exception e)
            {

            }
        }
        public void ExecuteDatareader(string connectionString, CommandType commandType, string commandText, params SqlParameter[] commandParameters)
        {
            //create & open an SqlConnection, and dispose of it after we are done.
            using (SqlConnection cn = new SqlConnection(connectionString))
            {
                cn.Open();
                //call the overload that takes a connection in place of the connection string
                ExecuteDatareader_Exe(cn, commandType, commandText, commandParameters);
            }
        }
        public void ExecuteDatareader_Exe(SqlConnection connection, CommandType commandType, string commandText, params SqlParameter[] commandParameters)
        {
            //create a command and prepare it for execution
            using (SqlCommand cmd = new SqlCommand())
            {
                PrepareCommand(cmd, connection, (SqlTransaction)null, commandType, commandText, commandParameters);
                using (SqlDataReader layerDr = cmd.ExecuteReader())
                {
                    //筛选数据
                    selectslicedatas(layerDr);
                }
                connection.Close();
            }
        }
        private void PrepareCommand(SqlCommand command, SqlConnection connection, SqlTransaction transaction, CommandType commandType, string commandText, SqlParameter[] commandParameters)
        {
            //if the provided connection is not open, we will open it
            if (connection.State != ConnectionState.Open)
            {
                connection.Open();
            }

            //associate the connection with the command
            command.Connection = connection;

            //set the command text (stored procedure name or Sql statement)
            command.CommandText = commandText;
            command.CommandTimeout = 0;
            //if we were provided a transaction, assign it.
            if (transaction != null)
            {
                command.Transaction = transaction;
            }

            //set the command type
            command.CommandType = commandType;

            //attach the command parameters if they are provided
            if (commandParameters != null)
            {
                AttachParameters(command, commandParameters);
            }

            return;
        }
        private void AttachParameters(SqlCommand command, SqlParameter[] commandParameters)
        {
            foreach (SqlParameter p in commandParameters)
            {
                //check for derived output value with no value assigned
                if ((p.Direction == ParameterDirection.InputOutput) && (p.Value == null))
                {
                    p.Value = DBNull.Value;
                }

                command.Parameters.Add(p);
            }
        }
        private Hashtable ConvertJsonToHashtable(string JSONData)
        {
            Hashtable ht = new Hashtable();
            return ht;
        }
        public void setSelectedEntityToFile(string SelectedEntity)
        {
            try
            {
                //log.Info("setSelectedEntityToFile" + hostipadd);
                //hostipadd = "10.8.57.83";

                string folderpath = "SelectedEntity\\" + dispatchUserName + "\\" + hostipadd;
                string filepath = folderpath + "\\SelectedEntity.txt";
                if (!Directory.Exists(Server.MapPath(@folderpath)))
                {
                    Directory.CreateDirectory(Server.MapPath(@folderpath));

                }
                if (!File.Exists(Server.MapPath(@filepath)))
                {
                    FileStream fs = new FileStream(Server.MapPath(@filepath), FileMode.OpenOrCreate);
                    StreamWriter sw = new StreamWriter(fs, Encoding.Default);

                    sw.Write(SelectedEntity);
                    sw.Close();
                    fs.Close();

                }
                else
                {
                    FileStream fs = new FileStream(Server.MapPath(@filepath), FileMode.Truncate);
                    StreamWriter sw = new StreamWriter(fs, Encoding.Default);

                    sw.Write(SelectedEntity);
                    sw.Close();
                    fs.Close();
                }

            }
            catch (Exception e) { }
        }

        public string getSelectedEntityFromFile()
        {
            string SelectedEntity = "";
            try
            {
                //log.Info("getSelectedEntityFromFile" + hostipadd);
                //hostipadd = "10.8.57.83";

                string folderpath = "SelectedEntity\\" + dispatchUserName + "\\" + hostipadd;
                string filepath = folderpath + "\\SelectedEntity.txt";
                if (Directory.Exists(Server.MapPath(@folderpath)))
                {
                    if (File.Exists(Server.MapPath(@filepath)))
                    {
                        FileStream fs = new FileStream(Server.MapPath(@filepath), FileMode.Open);
                        StreamReader sr = new StreamReader(fs, Encoding.Default);
                        SelectedEntity = sr.ReadToEnd();
                        sr.Close();
                        fs.Close();
                    }
                }
            }
            catch (Exception e) { }
            return SelectedEntity;
        }
    }

}