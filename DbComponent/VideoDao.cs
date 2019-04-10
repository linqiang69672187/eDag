using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Reflection;
using System.Text;

namespace DbComponent
{
    public class VideoDao
    {
        private static readonly log4net.ILog log = log4net.LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);

        public bool FindVideoNameForAdd(string name) {
            bool isReturn = false;
            string strSQL = "select count(id) from Video_Info where VideoName = @name";
            DataTable dt = SQLHelper.ExecuteRead(CommandType.Text, strSQL, "dsdsf", new SqlParameter("name", name));
            try
            {
                if (int.Parse(dt.Rows[0][0].ToString()) > 0)
                {
                    isReturn = true;
                }
            }
            catch (Exception ex) { }
            return isReturn;
        }
        public DataTable GetVideoByID(int ID) {

            return SQLHelper.ExecuteRead(CommandType.Text, "Select * from Video_Info where id=@ID", "abcsd", new SqlParameter("ID", ID));
        }
        public bool FindVideoForUpdate(int ID, string VideoName)
        {
            bool isReturn = false;
            string strSQL = "select count(0) from Video_Info where VideoName = @VideoName and id!=@ID";
            DataTable dt = SQLHelper.ExecuteRead(CommandType.Text, strSQL, "dsdsf", new SqlParameter("VideoName", VideoName), new SqlParameter("ID", ID));
            try
            {
                if (int.Parse(dt.Rows[0][0].ToString()) > 0)
                {
                    isReturn = true;
                }
            }
            catch (Exception ex) { }
            return isReturn;
        }
        public bool UpdateVideo(int ID,string Name = "", string URL = "", decimal Lo = 0.0M, Decimal la = 0.0M)
        {
            bool isSuccess = true;
            try
            {
                StringBuilder sbSQL = new StringBuilder();
                sbSQL.Append("Update Video_Info set VideoName=@VideoName,VideoPlayUrl=@VideoPlayUrl,Lo=@Lo,La=@La where id=@ID");
                SqlParameter[] sp = new SqlParameter[5];
                sp[0] = new SqlParameter("@VideoName", Name);
                sp[1] = new SqlParameter("@VideoPlayUrl", URL);
                sp[2] = new SqlParameter("@Lo", Lo);
                sp[3] = new SqlParameter("@La", la);
                sp[4] = new SqlParameter("@ID", ID);

                SQLHelper.ExecuteNonQuery(CommandType.Text, sbSQL.ToString(), sp);
            }
            catch (Exception ex)
            {

            }
            return isSuccess;
        }
        public bool AddVideo(string Name = "", string URL = "", string divID = "", decimal Lo = 0.0M, Decimal la = 0.0M)
        {
            bool isSuccess = true;
            try {
                StringBuilder sbSQL = new StringBuilder();
                sbSQL.Append("insert into Video_Info (VideoName,VideoPlayUrl,Lo,La,DivID) values (@VideoName,@VideoPlayUrl,@Lo,@La,@DivID)");
                SqlParameter[] sp = new SqlParameter[5];
                sp[0] = new SqlParameter("@VideoName", Name);
                sp[1] = new SqlParameter("@VideoPlayUrl", URL);
                sp[2] = new SqlParameter("@Lo", Lo);
                sp[3] = new SqlParameter("@La", la);
                sp[4] = new SqlParameter("@DivID", divID);

                SQLHelper.ExecuteNonQuery(CommandType.Text, sbSQL.ToString(), sp);
            }
            catch (Exception ex) { 
            
            }
            return isSuccess;
        }

        public int getAllVideoCount(string videoName)
        {
            string strWhere = "";
            if (!String.IsNullOrEmpty(videoName))
            {
                strWhere = " where VideoName like '%" + stringfilter.Filter(videoName.Trim()) + "%' ";
            }
            StringBuilder sbSQL = new StringBuilder();
            sbSQL.Append("select  count(id) from [Video_Info]  "+strWhere);
            return int.Parse(SQLHelper.ExecuteScalar(CommandType.Text, sbSQL.ToString()).ToString());
        }

        public DataTable GetAllVideo(string videoName,string sort, int startRowIndex, int maximumRows)
        {
            string strWhere = "";
            if (!String.IsNullOrEmpty(videoName))
            {
                strWhere = " where VideoName like '%" + stringfilter.Filter(videoName.Trim()) + "%' ";
            }
            if (sort == "") { sort = "id asc"; }
            StringBuilder sbSQL = new StringBuilder();
            sbSQL.Append("select  *  from [Video_Info]  " + strWhere + "   order by " + sort);
            return SQLHelper.ExecuteRead(CommandType.Text, sbSQL.ToString(), startRowIndex, maximumRows, "Video_Info");
        }
        public bool DelVideoByDivID(string DivID) {
            bool isSecuess = true;
            try {
                SQLHelper.ExecuteNonQuery("DELETE FROM Video_Info WHERE DivID='" + DivID + "'");
            }
            catch (Exception ex) {
                log.Error(ex.Message);
                isSecuess = false;
            }
            return isSecuess;
        }
    }
}
