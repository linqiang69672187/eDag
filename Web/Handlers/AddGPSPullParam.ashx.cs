using DbComponent;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Text;
using System.Web.SessionState;
using System.Data;
using System.Data.SqlClient;

namespace Web.Handlers
{
    /// <summary>
    /// AddGPSPullParam 的摘要说明
    /// </summary>
    public class AddGPSPullParam : IHttpHandler, IReadOnlySessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            string mtype = context.Request["mtype"].ToString();
            string srcissi = context.Request["srcissi"].ToString();
            string operatetype = context.Request["operatetype"].ToString();
            string expire = context.Request["expire"].ToString();
            string period = context.Request["period"].ToString();
            string distance = context.Request["distance"].ToString();
            string dstissi = context.Request["dstissi"].ToString();
            string gisissi = context.Request["gisissi"].ToString();
            string result = context.Request["result"].ToString();
            string pullstatus = context.Request["pullstatus"].ToString();
            //string cmd = context.Request["cmd"].ToString();

            String sql = "SELECT [SrcISSI],[PullStatus] FROM GPSPull_Records Where SrcISSI=@SrcISSI ";

            DataTable dt = DbComponent.SQLHelper.ExecuteRead(CommandType.Text, sql, "dsfs", new SqlParameter("SrcISSI", srcissi));

            if (mtype == "add" && dt.Rows.Count == 0)
            {
                DbComponent.SQLHelper.ExecuteNonQuery(System.Data.CommandType.StoredProcedure, "AddToGPSPullList", new System.Data.SqlClient.SqlParameter("srcissi", srcissi), new System.Data.SqlClient.SqlParameter("operatetype", operatetype), new System.Data.SqlClient.SqlParameter("expire", expire), new System.Data.SqlClient.SqlParameter("period", period), new System.Data.SqlClient.SqlParameter("distance", distance), new System.Data.SqlClient.SqlParameter("dstissi", dstissi), new System.Data.SqlClient.SqlParameter("gisissi", gisissi), new System.Data.SqlClient.SqlParameter("result", result), new System.Data.SqlClient.SqlParameter("pullstatus", pullstatus), new System.Data.SqlClient.SqlParameter("mtype", "add"));
                context.Response.Write("0");// 激活
            }
            else if (mtype == "add" && dt.Rows.Count > 0 && dt.Rows[0][1].ToString() == "1")
            {
                context.Response.Write(dt.Rows[0][1].ToString());// 其他调度台正在上拉
            }
            else if (mtype == "add" && dt.Rows.Count > 0 && dt.Rows[0][1].ToString() == "0")
            {
                DbComponent.SQLHelper.ExecuteNonQuery(System.Data.CommandType.StoredProcedure, "AddToGPSPullList", new System.Data.SqlClient.SqlParameter("srcissi", srcissi), new System.Data.SqlClient.SqlParameter("operatetype", operatetype), new System.Data.SqlClient.SqlParameter("expire", expire), new System.Data.SqlClient.SqlParameter("period", period), new System.Data.SqlClient.SqlParameter("distance", distance), new System.Data.SqlClient.SqlParameter("dstissi", dstissi), new System.Data.SqlClient.SqlParameter("gisissi", gisissi), new System.Data.SqlClient.SqlParameter("result", result), new System.Data.SqlClient.SqlParameter("pullstatus", pullstatus), new System.Data.SqlClient.SqlParameter("mtype", "add"));
                context.Response.Write(dt.Rows[0][1].ToString());// 初始化后解析没做处理，属于异常情况，仍然允许激活
            }
            else if (mtype == "update" && dt.Rows.Count > 0 && dt.Rows[0][1].ToString() == "1")
            {
                //DbComponent.SQLHelper.ExecuteNonQuery(System.Data.CommandType.StoredProcedure, "AddToGPSPullList", new System.Data.SqlClient.SqlParameter("srcissi", srcissi), new System.Data.SqlClient.SqlParameter("operatetype", operatetype), new System.Data.SqlClient.SqlParameter("expire", expire), new System.Data.SqlClient.SqlParameter("period", period), new System.Data.SqlClient.SqlParameter("distance", distance), new System.Data.SqlClient.SqlParameter("dstissi", dstissi), new System.Data.SqlClient.SqlParameter("gisissi", gisissi), new System.Data.SqlClient.SqlParameter("result", result), new System.Data.SqlClient.SqlParameter("pullstatus", pullstatus), new System.Data.SqlClient.SqlParameter("mtype", "update"));
                context.Response.Write("2");// 去激活
            }
            else if (mtype == "update" && dt.Rows.Count > 0 && dt.Rows[0][1].ToString() == "0")
            {
                context.Response.Write("3");// 上拉状态为未操作的，不允许去激活，返回响应提示
            }
            else if (mtype == "update" && dt.Rows.Count == 0)
            {
                context.Response.Write("4");// 找不到此终端信息，不允许去激活，返回响应提示
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