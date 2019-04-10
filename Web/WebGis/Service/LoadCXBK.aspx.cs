using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Text;

namespace Web.WebGis.Service
{
    public partial class LoadCXBK : System.Web.UI.Page
    {
        public string bbs;
        protected void Page_Load(object sender, EventArgs e)
        {
            bbs = (Request.QueryString["bss"]);    //获取客户端传来的经纬度范围
            GetLayerData_datareader(bbs, int.Parse(Request.Cookies["id"].Value.ToString()),Request.Cookies["username"].Value.Trim());

            Response.End();
        }
     

        public void GetLayerData_datareader( string bound, int id, string username)
        {
            try
            {
                SqlParameter[] sp = new SqlParameter[3];
                sp[0] = new SqlParameter("@bounds", bound);
                sp[1] = new SqlParameter("@id", id);
                sp[2] = new SqlParameter("@username", username);
                ExecuteDatareader(Config.m_connectionString, CommandType.StoredProcedure, "loadcxbk", sp);
            }
            catch (Exception e)
            {
                Response.Write(e.Message.ToString());
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
                StringBuilder JSON = new StringBuilder();
                JSON.Append("[");
                int flata = 0;
                    //筛选数据
                   // selectslicedatas(layerDr);
                    while (layerDr.Read())
                    {
                        if (flata > 0) { JSON.Append(","); };
                        JSON.Append("{\"issi\":"+layerDr["ISSI"].ToString()+"}");
                        flata += 1;
                    }
                    JSON.Append("]");
                    Response.Write(JSON.ToString());
               
                  
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
    }
}