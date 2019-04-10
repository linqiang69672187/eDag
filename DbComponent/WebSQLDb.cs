using System;
using System.Data;
using System.Data.SqlClient;
namespace DbComponent
{
    public class WebSQLDb
    {
        public string m_connectionString;
        Object m_DBNull;
        string m_user = "";
        /// <summary>
        /// 错误信息
        /// </summary>
        public string Err_Msg;
        public WebSQLDb(string connectionString)
        {
            m_connectionString = connectionString;
            if (m_connectionString == null)
            {
                throw new Exception("Expected DB connection here.");
            }
            m_DBNull = Convert.DBNull;
            Err_Msg = "";
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="layerParms">@layer1isTwoG,@layer1manufactoryId,@layer1site_type|@layer2isTwoG,@layer2manufactoryId,@layer2site_type</param>
        /// <param name="bound"></param>
        /// <param name="select"></param>
        /// <param name="storedProcedures"></param>
        /// <returns></returns>
        public DataSet GetLayerData(string layers, string bound, string select, string storedProcedures, int id, string username, string hideovertimeDevice, string device_timeout, String SelectedEntity)
        {
            DataSet ds = null;
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
                ds = SqlData.ExecuteDataset(m_connectionString, CommandType.StoredProcedure, m_user + "map_LayersDataGet", sp);
            }
            catch (Exception e)
            {
                Err_Msg = e.Message;
                return ds;
            }
            return ds;
        }
        //图元信息查询
        public DataSet CellsInfoGet(string entityName, string pcNam, string pcNum, string ISSI)
        {
            DataSet ds = null;
            try
            {
                SqlParameter[] sp = new SqlParameter[4];
                sp[0] = new SqlParameter("@entityName", entityName);
                sp[1] = new SqlParameter("@pcNam", pcNam);
                sp[2] = new SqlParameter("@pcNum", pcNum);
                sp[3] = new SqlParameter("@ISSI", ISSI);
                ds = SqlData.ExecuteDataset(m_connectionString, CommandType.StoredProcedure, m_user + "map_CellsInfoGet", sp);
            }
            catch (Exception e)
            {
                Err_Msg = e.Message;
                return null;
            }
            return ds;
        }
        public DataSet CIInfoGet(string ci)
        {
            DataSet ds = null;
            try
            {
                SqlParameter[] sp = new SqlParameter[1];
                sp[0] = new SqlParameter("@ci", ci);
                ds = SqlData.ExecuteDataset(m_connectionString, CommandType.StoredProcedure, m_user + "map_CIInfoGet", sp);
            }
            catch (Exception e)
            {
                Err_Msg = e.Message;
                return null;
            }
            return ds;
        }

        public DataSet CompanyGet()
        {
            DataSet ds = null;
            try
            {
                ds = SqlData.ExecuteDataset(m_connectionString, CommandType.StoredProcedure, m_user + "map_companyGet");
            }
            catch (Exception e)
            {
                Err_Msg = e.Message;
                return null;
            }
            return ds;
        }
    }
}