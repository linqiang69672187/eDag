using DbComponent.IDAO;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Reflection;
using System.Text;

namespace DbComponent
{
    public class SMSInfoDao : ISMSInfoDao
    {
        #region ISMSInfoDao 成员
        private static readonly log4net.ILog log = log4net.LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);
        public bool Save(MyModel.Model_SMSInfo model)
        {
            StringBuilder sbSql = new StringBuilder();
            StringBuilder sbStr1 = new StringBuilder();
            StringBuilder sbStr2 = new StringBuilder();
            sbSql.Append("insert into SMS_Info (");
            if (model.IsRead != null)
            {
                sbStr1.Append("[IsRead],");
                sbStr2.Append("'" + model.IsRead + "',");
            }
            if (model.IsReturn != null)
            {
                sbStr1.Append("[IsReturn],");
                sbStr2.Append("'" + model.IsReturn + "',");
            }
            if (model.IsSend != null)
            {
                sbStr1.Append("[IsSend],");
                sbStr2.Append("'" + model.IsSend + "',");
            }
            if (model.ReadTime.ToString("yyyy-MM-dd HH:mm:ss:ffff") != "0001-01-01 00:00:00:0000")
            {
                sbStr1.Append("[ReadTime],");
                sbStr2.Append("'" + model.ReadTime + "',");
            }
            if (model.RevISSI != null)
            {
                sbStr1.Append("[RevISSI],");
                sbStr2.Append("'" + model.RevISSI + "',");
            }
            if (model.RevTime.ToString("yyyy-MM-dd HH:mm:ss:ffff") != "0001-01-01 00:00:00:0000")
            {
                sbStr1.Append("[RevTime],");
                sbStr2.Append("'" + model.RevTime + "',");
            }
            if (model.SendISSI != null)
            {
                sbStr1.Append("[SendISSI],");
                sbStr2.Append("'" + model.SendISSI + "',");
            }

            if (model.SMSContent != null)
            {
                sbStr1.Append("[SMSContent],");
                sbStr2.Append("'" + model.SMSContent + "',");
            }
            if (model.SMSID != null)
            {
                sbStr1.Append("[SMSID],");
                sbStr2.Append("'" + model.SMSID + "',");
            }
            if (model.SMSMsg != null)
            {
                sbStr1.Append("[SMSMsg],");
                sbStr2.Append("'" + model.SMSMsg + "',");
            }
            if (model.SMSType != null)
            {
                sbStr1.Append("[SMSType],");
                sbStr2.Append("'" + model.SMSType + "',");
            }
            if (model.ReturnID != 0)
            {
                sbStr1.Append("[ReturnID],");
                sbStr2.Append("'" + model.ReturnID + "',");
            }
            if (model.La != null)
            {
                sbStr1.Append("[La],");
                sbStr2.Append("'" + model.La + "',");
            }
            if (model.Lo != null)
            {
                sbStr1.Append("[Lo],");
                sbStr2.Append("'" + model.Lo + "',");
            }
            if (model.IsGroup != null)
            {
                sbStr1.Append("[IsGroup],");
                sbStr2.Append("'" + model.IsGroup + "',");
            }
            sbStr1.Append("[SendTime]");
            sbStr2.Append("'" + DateTime.Now.ToString() + "'");

            sbSql.Append(sbStr1.ToString());
            sbSql.Append(") values (");
            sbSql.Append(sbStr2.ToString());
            sbSql.Append(")");

            try
            {
                SQLHelper.ExecuteNonQuery(CommandType.Text, sbSql.ToString());
                return true;
            }
            catch (Exception ex)
            {
                log.Info(sbSql.ToString());
                log.Error(ex);
                return false;
            }
        }
        public bool Delete(int ID)
        {
            string strSQL = " DELETE FROM SMS_Info WHERE ID=@ID";
            try
            {
                SQLHelper.ExecuteNonQuery(CommandType.Text, strSQL, new SqlParameter("ID", ID));
                return true;
            }
            catch (Exception ex)
            {
                log.Info(strSQL);
                log.Error(ex);
                return false;
            }
        }
        public bool Update(MyModel.Model_SMSInfo newModel)
        {
            throw new NotImplementedException();
        }
        public bool UpdateSMSID(int ID)
        {
            string strSQL = "update SMS_Info set SMSID=-1 where ID=@ID";
            try
            {
                SQLHelper.ExecuteNonQuery(CommandType.Text, strSQL, new SqlParameter("ID", ID));
                return true;
            }
            catch (Exception ex)
            {
                log.Info(strSQL);
                log.Error(ex);
                return false;
            }
        }
        public bool UpdateIsReturn(int ID, bool IsReturn)
        {
            string strSQL = "update SMS_Info set IsReturn=@IsReturn where ID=@ID";
            try
            {
                SQLHelper.ExecuteNonQuery(CommandType.Text, strSQL, new SqlParameter("IsReturn", IsReturn), new SqlParameter("ID", ID));
                return true;
            }
            catch (Exception ex)
            {
                log.Info(strSQL);
                log.Error(ex);
                return false;
            }
        }
        public bool UpdateReturnSMSSendReport(string SmsID, string SendISSI, string RevISSI, string SMSMsg, bool IsSend)
        {
            string strSQL = "update SMS_Info set SMSMsg=@SMSMsg, IsSend=@IsSend where ID= ( Select top 1 ID from SMS_Info where SMSID=@SMSID and SendISSI=@SendISSI and RevISSI=@RevISSI order by SendTime DESC ) ";
            try
            {
                SQLHelper.ExecuteNonQuery(CommandType.Text, strSQL, new SqlParameter("SMSMsg", SMSMsg), new SqlParameter("IsSend", IsSend), new SqlParameter("SMSID", SmsID), new SqlParameter("SendISSI", SendISSI), new SqlParameter("RevISSI", RevISSI));
                return true;
            }
            catch (Exception ex)
            {
                log.Error(ex);
                log.Info(strSQL);
                return false;
            }
        }
        public bool UpdateCommSMSSendReport(string SmsID, string SendISSI, string RevISSI, string SMSMsg, bool IsSend)
        {
            string strSQL = "update SMS_Info set SMSMsg=@SMSMsg, IsSend=@IsSend, SMSID='-1' where ID= ( Select top 1 ID from SMS_Info where SMSID=@SMSID and SendISSI=@SendISSI and RevISSI=@RevISSI order by SendTime DESC ) ";
            try
            {
                SQLHelper.ExecuteNonQuery(CommandType.Text, strSQL, new SqlParameter("SMSMsg", SMSMsg), new SqlParameter("IsSend", IsSend), new SqlParameter("SMSID", SmsID), new SqlParameter("SendISSI", SendISSI), new SqlParameter("RevISSI", RevISSI));
                return true;
            }
            catch (Exception ex)
            {
                log.Error(ex);
                log.Info(strSQL);
                return false;
            }
        }
        public IList<MyModel.Model_SMSInfo> GetSMSInfoByWhere(string where)
        {
            string strSQL = " SELECT * FROM SMS_Info ";
            if (where != null && where != "")
            {
                strSQL += " where " + where;
            }
            DataTable dt = SQLHelper.ExecuteRead(CommandType.Text, strSQL, "mysmsinfo");
            IList<MyModel.Model_SMSInfo> list = Comm.TypeConverter.DataTable2ModelList<MyModel.Model_SMSInfo>(dt);
            return list;
        }
        public IList<MyModel.Model_SMSInfo> GetSMSInfoByRevISSI(string ISSI)
        {
            string strSQL = " SELECT * FROM SMS_Info WHERE RevISSI=@RevISSI AND  IsRead=0 ";
            DataTable dt = SQLHelper.ExecuteRead(CommandType.Text, strSQL, "mysms13", new SqlParameter("RevISSI", ISSI));
            return Comm.TypeConverter.DataTable2ModelList<MyModel.Model_SMSInfo>(dt);
        }
        public IList<MyModel.Model_SMSInfo> GetSMSInfoBySendISSI(string ISSI)
        {
            string strSQL = " SELECT * FROM SMS_Info WHERE SendISSI=@SendISSI AND  IsRead=0 ";
            DataTable dt = SQLHelper.ExecuteRead(CommandType.Text, strSQL, "mysms13", new SqlParameter("SendISSI", ISSI));
            return Comm.TypeConverter.DataTable2ModelList<MyModel.Model_SMSInfo>(dt);
        }
        public IList<MyModel.Model_SMSInfo> GetUnReadSmsList(string RevISSI)
        {
            string strSQL = " SELECT * FROM SMS_Info WHERE RevISSI=@RevISSI AND  IsRead=0 ";
            DataTable dt = SQLHelper.ExecuteRead(CommandType.Text, strSQL, "mysms12", new SqlParameter("RevISSI", RevISSI));
            return Comm.TypeConverter.DataTable2ModelList<MyModel.Model_SMSInfo>(dt);
        }
        public IList<MyModel.Model_SMSInfo> GetSMSInfoByType(MyModel.Enum.SMSType stype)
        {
            string strSQL = " SELECT * FROM SMS_Info WHERE SMSType=@SMSType ";
            DataTable dt = SQLHelper.ExecuteRead(CommandType.Text, strSQL, "mysms11", new SqlParameter("SMSType", (int)stype));
            return Comm.TypeConverter.DataTable2ModelList<MyModel.Model_SMSInfo>(dt);
        }
        public bool AddSMSInfoByDispatcher(string sendISSI, int isGroup, int notGroup, string msg, string revISSI)
        {
            string dateTime = DateTime.Now.AddMinutes(-1).ToString();
            string strSQL = "INSERT INTO SMS_Info ";
            string selectSQL = "SELECT TOP 1 SMSType,SendISSI, @RevISSI AS RevISSI,IsRead,IsSend,SMSContent,IsReturn,SendTime,RevTime,ReadTime,SMSMsg,SMSID,ReturnID,Lo,La,DispatcherID, @NotGroup AS IsGroup FROM SMS_Info WHERE ";
            string isexistsSQL = " (SELECT TOP 1 * FROM SMS_Info a WHERE SendISSI=@SendISSI and IsGroup=@NotGroup and SMSContent=@SMSContent and RevISSI=@RevISSI and SendTime>@SendTime order by SendTime DESC) ";
            string otherSQL = " AND SendISSI=@SendISSI AND IsGroup=@IsGroup AND SMSContent=@SMSContent and SendTime>@SendTime order by SendTime DESC ";
            strSQL = strSQL + selectSQL + " NOT EXISTS " + isexistsSQL + otherSQL;
            try
            {
                SQLHelper.ExecuteNonQuery(CommandType.Text, strSQL, new SqlParameter("SendISSI", sendISSI), new SqlParameter("IsGroup", isGroup), new SqlParameter("NotGroup", notGroup), new SqlParameter("SMSContent", msg), new SqlParameter("RevISSI", revISSI), new SqlParameter("SendTime", dateTime));
                return true;
            }
            catch (Exception ex)
            {
                log.Info(strSQL.ToString());
                log.Error(ex);
                return false;
            }
            
        }

        #endregion
    }
}
