using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.SessionState;

namespace Web.Handlers
{
    /// <summary>
    /// AddGPSParam 的摘要说明
    /// </summary>
    public class AddGPSParam : IHttpHandler, IReadOnlySessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            string mtype = context.Request["mtype"].ToString();
            string username = context.Request["username"].ToString();
            string sendGPSParamRequestissis = context.Request["sendGPSParamRequestissis"].ToString();
            string cmd = context.Request["cmd"].ToString();

            if (mtype == "add")
            {

                if (cmd == "control")
                {
                    string strGpsOpen = context.Request["open"].ToString();
                    DbComponent.SQLHelper.ExecuteNonQuery(System.Data.CommandType.StoredProcedure, "AddToGPSControlList", new System.Data.SqlClient.SqlParameter("issis", sendGPSParamRequestissis), new System.Data.SqlClient.SqlParameter("GPSOpen", strGpsOpen), new System.Data.SqlClient.SqlParameter("username", username), new System.Data.SqlClient.SqlParameter("mtype", "add"));
                }
                else if (cmd == "param")
                {
                    string strGpsdest = context.Request["dest"].ToString();
                    string strGpscycle = context.Request["cycle"].ToString();
                    DbComponent.SQLHelper.ExecuteNonQuery(System.Data.CommandType.StoredProcedure, "AddToGPSParameList", new System.Data.SqlClient.SqlParameter("issis", sendGPSParamRequestissis), new System.Data.SqlClient.SqlParameter("GPSCircle", strGpscycle), new System.Data.SqlClient.SqlParameter("GPSdest", strGpsdest), new System.Data.SqlClient.SqlParameter("username", username), new System.Data.SqlClient.SqlParameter("mtype", "add"));
                }
                else if (cmd == "mode")
                {
                    string strModel = context.Request["mode"].ToString();
                    DbComponent.SQLHelper.ExecuteNonQuery(System.Data.CommandType.StoredProcedure, "AddToGPSModeList", new System.Data.SqlClient.SqlParameter("issis", sendGPSParamRequestissis), new System.Data.SqlClient.SqlParameter("mode", strModel), new System.Data.SqlClient.SqlParameter("username", username), new System.Data.SqlClient.SqlParameter("mtype", "add"));
                }
                else if (cmd == "distance")
                {
                    string strDistance = context.Request["distance"].ToString();
                    DbComponent.SQLHelper.ExecuteNonQuery(System.Data.CommandType.StoredProcedure, "AddToGPSDistanceList", new System.Data.SqlClient.SqlParameter("issis", sendGPSParamRequestissis), new System.Data.SqlClient.SqlParameter("GPSDistance", strDistance), new System.Data.SqlClient.SqlParameter("username", username), new System.Data.SqlClient.SqlParameter("mtype", "add"));
                }
            }
            else if (mtype == "update")
            {
                if (cmd == "control")
                {
                    string strGpsOpen = context.Request["open"].ToString();
                    DbComponent.SQLHelper.ExecuteNonQuery(System.Data.CommandType.StoredProcedure, "AddToGPSControlList", new System.Data.SqlClient.SqlParameter("issis", sendGPSParamRequestissis), new System.Data.SqlClient.SqlParameter("GPSOpen", strGpsOpen), new System.Data.SqlClient.SqlParameter("username", username), new System.Data.SqlClient.SqlParameter("mtype", "update"));
                }
                else if (cmd == "param")
                {
                    string strGpsdest = context.Request["dest"].ToString();
                    string strGpscycle = context.Request["cycle"].ToString();
                    DbComponent.SQLHelper.ExecuteNonQuery(System.Data.CommandType.StoredProcedure, "AddToGPSParameList", new System.Data.SqlClient.SqlParameter("issis", sendGPSParamRequestissis), new System.Data.SqlClient.SqlParameter("GPSCircle", strGpscycle), new System.Data.SqlClient.SqlParameter("GPSdest", strGpsdest), new System.Data.SqlClient.SqlParameter("username", username), new System.Data.SqlClient.SqlParameter("mtype", "update"));
                }
                else if (cmd == "mode")
                {
                    string strGpsmode = context.Request["mode"].ToString();
                    DbComponent.SQLHelper.ExecuteNonQuery(System.Data.CommandType.StoredProcedure, "AddToGPSModeList", new System.Data.SqlClient.SqlParameter("issis", sendGPSParamRequestissis), new System.Data.SqlClient.SqlParameter("mode", strGpsmode), new System.Data.SqlClient.SqlParameter("username", username), new System.Data.SqlClient.SqlParameter("mtype", "update"));
                }
                else if (cmd == "distance")
                {
                    string strDistance = context.Request["distance"].ToString();
                    DbComponent.SQLHelper.ExecuteNonQuery(System.Data.CommandType.StoredProcedure, "AddToGPSDistanceList", new System.Data.SqlClient.SqlParameter("issis", sendGPSParamRequestissis), new System.Data.SqlClient.SqlParameter("GPSDistance", strDistance), new System.Data.SqlClient.SqlParameter("username", username), new System.Data.SqlClient.SqlParameter("mtype", "update"));
                }
            }

            context.Response.Write("{\"Result\":\"success\"}");
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