using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using Ryu666.Components;

namespace Web.lqnew.opePages
{
    public partial class pc_status : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string connstring = ConfigurationManager.AppSettings["m_connectionString"];
            using (SqlConnection conn = new SqlConnection(connstring))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("lq_SelectPcStatus", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Pcid", Request.QueryString["ci"]);

                System.Data.SqlClient.SqlDataReader rs = cmd.ExecuteReader();
                while (rs.Read())
                {
                    string state = ResourceManager.GetString("Lang_current_state");
                    string PowerOff = ResourceManager.GetString("PowerOff");
                    string GPSovertime = ResourceManager.GetString("Lang_GPS_overtime");
                    string emergency = ResourceManager.GetString("(2)Emergency_condition");
                    string rightPowerOff = ResourceManager.GetString("(1)powered_OFF");
                    string zt = "";

                    if (rs.GetValue(1).ToString() == emergency)
                    {

                        if ((int)(rs.GetValue(2)) > 5)
                        {

                            //zt = " &nbsp;&nbsp;当前状态:" + rs.GetValue(1).ToString() + "/GPS超时";

                            zt = " &nbsp;&nbsp;" + state + ":" + rs.GetValue(1).ToString() + "/" + GPSovertime;
                        }
                        else
                        {
                            string Lang_EmergencyCall = ResourceManager.GetString("Lang_EmergencyCall");

                            //zt = " &nbsp;&nbsp;当前状态:紧急呼叫";
                            zt = " &nbsp;&nbsp;" + state + ":" + Lang_EmergencyCall;
                        }

                    }
                    if (rs.GetValue(1).ToString() == rightPowerOff)
                    {

                        //zt = " &nbsp;&nbsp;当前状态:关机";
                        zt = " &nbsp;&nbsp;" + state + ":" + PowerOff;
                    }
                    else
                    {
                        if ((int)(rs.GetValue(2)) > 5)
                        {
                            // zt = " &nbsp;&nbsp;当前状态:GPS超时";
                            zt = " &nbsp;&nbsp;" + state + ":" + GPSovertime;
                        }
                        else
                        {
                            //zt = " &nbsp;&nbsp;当前状态:" + rs.GetValue(1).ToString();
                            zt = " &nbsp;&nbsp;" + state + ":" + rs.GetValue(1).ToString();
                        }
                    }
                    string Lang_police = ResourceManager.GetString("Lang_police");
                    this.Label1.Text = Lang_police + "：" + rs.GetValue(0).ToString() + zt;

                }

            }
        }
    }
}