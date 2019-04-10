using DbComponent.IDAO;
using MyModel;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Reflection;
using System.Text;
namespace DbComponent
{
    public class BaseStationDao : IBaseStationDao
    {
        
        private static readonly log4net.ILog log = log4net.LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);

        #region IBaseStationDao 成员
        public bool AddBaseStation(Model_BaseStation model)
        {
            StringBuilder sbSql = new StringBuilder();
            StringBuilder sbStr1 = new StringBuilder();
            StringBuilder sbStr2 = new StringBuilder();
            sbSql.Append("insert into BaseStation_info (");
            if (model.StationName != null)
            {
                sbStr1.Append("[StationName],");
                sbStr2.Append("'" + model.StationName + "',");
            }
            if (model.StationISSI != null)
            {
                sbStr1.Append("[StationISSI],");
                sbStr2.Append("'" + model.StationISSI + "',");
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
            if (model.DivID != null)
            {
                sbStr1.Append("[DivID],");
                sbStr2.Append("'" + model.DivID + "',");
            }
            if (model.PicUrl != null)
            {
                sbStr1.Append("[PicUrl],");
                sbStr2.Append("'" + model.PicUrl + "',");
            }
            if (model.IsUnderGround != null)
            {
                sbStr1.Append("[IsUnderGround],");
                sbStr2.Append("'" + model.IsUnderGround + "',");
            }
            if (model.SwitchID != null)//xzj--20181217--添加交换
            {
                sbStr1.Append("[SwitchID],");
                sbStr2.Append( model.SwitchID + ",");
            }
            if (sbStr1.Length > 0)
            {
                sbSql.Append(sbStr1.ToString().Substring(0, sbStr1.ToString().Length - 1));
                sbSql.Append(") values (");
                sbSql.Append(sbStr2.ToString().Substring(0, sbStr2.ToString().Length - 1));
                sbSql.Append(")");
            }
            else
            {
                sbSql.Append(sbStr1.ToString());
                sbSql.Append(") values (");
                sbSql.Append(sbStr2.ToString());
                sbSql.Append(")");
            }
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

        public bool UpdateBaseStation(Model_BaseStation newModel)
        {
            StringBuilder sbSQL = new StringBuilder();
            sbSQL.Append("update BaseStation_info set ");
            bool flag = false;
            if (newModel.StationName != null)
            {
                sbSQL.Append(" [StationName] = '" + newModel.StationName + "',");
                flag = true;
            }
            if (newModel.StationISSI != null)
            {
                sbSQL.Append(" [StationISSI] = '" + newModel.StationISSI + "',");
                flag = true;
                //TODO 修改基站标识的时候 必须去修改基站组成员的基站标识 （数据库设计错误 写逻辑代码太麻烦） 这里无法处理
                //string strSQL = "SELECT ID,MemberIds FROM BSGroup_info";
                //DataTable dt = SQLHelper.ExecuteRead(CommandType.Text, strSQL, "adddccc");
                //if (dt != null && dt.Rows.Count > 0)
                //{
                //    foreach (DataRow dr in dt.Rows)
                //    {
                //        string[] strs = dr["MemberIds"].ToString().Split(new char[] { ';' }, StringSplitOptions.RemoveEmptyEntries);
                //        if (strs != null && strs.Length > 0)
                //        {
                //            foreach (string s in strs)
                //            {

                //            }
                //        }
                //        //修改基站组
                //    }
                //}

            }
            if (newModel.Lo != null)
            {
                sbSQL.Append(" [Lo] = '" + newModel.Lo + "',");
                flag = true;
            }
            if (newModel.La != null)
            {
                sbSQL.Append(" [La] = '" + newModel.La + "',");
                flag = true;
            }
            if (newModel.DivID != null)
            {
                sbSQL.Append(" [DivID] = '" + newModel.DivID + "',");
                flag = true;
            }
            if (newModel.PicUrl != null)
            {
                sbSQL.Append(" [PicUrl] = '" + newModel.PicUrl + "',");
                flag = true;
            }
            if (newModel.IsUnderGround != null)
            {
                sbSQL.Append(" [IsUnderGround] = '" + newModel.IsUnderGround + "',");
                flag = true;
            }
            if (newModel.SwitchID != null)//xzj--20181217--添加交换
            {
                sbSQL.Append(" [SwitchID] = '" + newModel.SwitchID + "',");
                flag = true;
            }
            string strSql = "";
            if (flag)
            {
                strSql = sbSQL.ToString().Substring(0, sbSQL.ToString().Length - 1);
            }

            strSql += " where ID=@ID";

            int i = 0;
            try
            {
                log.Info(strSql);
                i = SQLHelper.ExecuteNonQuery(CommandType.Text, strSql, new SqlParameter("ID", newModel.ID));
                if (i > 0)
                    return true;
                else return false;
            }
            catch (Exception ex)
            {
                log.Info(strSql);
                log.Error(ex);
                return false;
            }
        }

        public bool DeleteBaseStation(int ID)
        {
            StringBuilder sbSQL = new StringBuilder("DELETE FROM BaseStation_info WHERE ID=@ID");
            try
            {
                SQLHelper.ExecuteNonQuery(CommandType.Text, sbSQL.ToString(), new SqlParameter("ID", ID));
                return true;
            }
            catch (Exception ex)
            {
                log.Info(sbSQL.ToString());
                log.Error(ex);
                return false;
            }
        }




        #region  取得基站数量信息
        public int getAllBaseStation_infocount(string minLa, string minLo, string maxLa, string maxLo, string textseach, string selecttype)
        {

            string sqlcondition = "";
            if (selecttype != null && textseach != null) { sqlcondition += " and  " + selecttype + " like '%" + textseach + "%' "; }

            return int.Parse(SQLHelper.ExecuteScalar(CommandType.Text, "select count(*) from BaseStation_info where Lo between " + minLo + " and " + maxLo + " and La between " + minLa + " and " + maxLa + sqlcondition).ToString());

        }

        #endregion

        #region 分页排序基站信息//xzj--20181217--添加交换
        public DataTable AllBaseStation_info(string minLa, string minLo, string maxLa, string maxLo, string sort, int startRowIndex, int maximumRows, string textseach, string selecttype)
        {

            string sqlcondition = "";
            if (selecttype != null && textseach != null ) { sqlcondition += " and  " + selecttype+" like '%" + textseach + "%' " ; }
            if (sort == "") { sort = "StationName DESC"; }
            return SQLHelper.ExecuteRead(CommandType.Text, "select ID,StationName,Lo,La,StationISSI,SwitchID from BaseStation_info where Lo between " + minLo + " and " + maxLo + " and La between " + minLa + " and " + maxLa + sqlcondition+" order by " + sort, startRowIndex, maximumRows, "BaseStation");


        }
        #endregion



        public Model_BaseStation GetBaseStationByISSI(string ISSI, int switchID)//xzj--20181217--添加交换
        {
            StringBuilder sbSQL = new StringBuilder(" SELECT TOP 1 [ID],[StationName],[StationISSI],[Lo],[La],[DivID],[PicUrl],[SwitchID] FROM BaseStation_info WHERE StationISSI=@ISSI and SwitchID=@SwitchID");
            DataTable dt = SQLHelper.ExecuteRead(CommandType.Text, sbSQL.ToString(), "adfaf", new SqlParameter("ISSI", ISSI),new SqlParameter("SwitchID",switchID));
            if (dt != null && dt.Rows.Count == 1)
            {
                DataRow dr = dt.Rows[0];
                return new Model_BaseStation { ID = int.Parse(dr["ID"].ToString()), StationName = dr["StationName"].ToString(), StationISSI = dr["StationISSI"].ToString(), La = decimal.Parse(dr["la"].ToString()), Lo = decimal.Parse(dr["lo"].ToString()), DivID = dr["DivID"].ToString(), PicUrl = dr["PicUrl"].ToString(), SwitchID = string.IsNullOrEmpty(dr["SwitchID"].ToString()) == true ? 0 : int.Parse(dr["SwitchID"].ToString()) };

            }
            else return null;
        }

        public Model_BaseStation GetBaseStationByID(int ID)
        {
            StringBuilder sbSQL = new StringBuilder(" SELECT TOP 1 [ID],[StationName],[StationISSI],[Lo],[La],[DivID],[PicUrl],[IsUnderGround],[SwitchID] FROM BaseStation_info WHERE ID=@ID");
            DataTable dt = SQLHelper.ExecuteRead(CommandType.Text, sbSQL.ToString(), "adfaf", new SqlParameter("ID", ID));
            if (dt != null && dt.Rows.Count == 1)
            {
                DataRow dr = dt.Rows[0];
                return new Model_BaseStation
                {
                    ID = ID,
                    StationName = dr["StationName"].ToString(),
                    StationISSI = dr["StationISSI"].ToString(),
                    La = decimal.Parse(dr["la"].ToString()),
                    Lo = decimal.Parse(dr["lo"].ToString()),
                    DivID = dr["DivID"].ToString(),
                    PicUrl = dr["PicUrl"].ToString(),
                    IsUnderGround = dr["IsUnderGround"].ToString() == "1" ? 1 : 0,
                    SwitchID=string.IsNullOrEmpty(dr["SwitchID"].ToString())==true?0:(int)dr["SwitchID"]//xzj--20181217--添加交换
                };

            }
            else return null;
        }

        public int getAllBaseStationCount()
        {
            StringBuilder sbSQL = new StringBuilder();
            sbSQL.Append("select  count(0) from [BaseStation_info]  ");
            return int.Parse(SQLHelper.ExecuteScalar(CommandType.Text, sbSQL.ToString()).ToString());
        }

        public DataTable GetAllBaseStation(string sort, int startRowIndex, int maximumRows)
        {
            if (sort == "") { sort = "id asc"; }
            StringBuilder sbSQL = new StringBuilder();
            sbSQL.Append("select  *  from [BaseStation_info]   order by " + sort);
            return SQLHelper.ExecuteRead(CommandType.Text, sbSQL.ToString(), startRowIndex, maximumRows, "BaseStation_info");
        }

        public DataTable GetAllBaseStation()
        {
            StringBuilder sbSQL = new StringBuilder("SELECT * FROM [BaseStation_info]");
            return SQLHelper.ExecuteRead(CommandType.Text, sbSQL.ToString(), "dfa");
        }

        public string GetIDByDivID(string DivID)
        {
            StringBuilder sbSQL = new StringBuilder("SELECT top 1 ID FROM BaseStation_info WHERE DivID=@DivID");
            DataTable dt = SQLHelper.ExecuteRead(CommandType.Text, sbSQL.ToString(), "dividifd", new SqlParameter("DivID", DivID));
            if (dt != null && dt.Rows.Count > 0)
            {
                return dt.Rows[0]["ID"].ToString();
            }
            else
                return "";
        }

        public bool FindBaseStationISSIForAdd(string ISSI,int switchID)//xzj--20181217--添加交换
        {
            bool isReturn = false;
            string strSQL = "select count(0) from BaseStation_info where StationISSI = @StationISSI and SwitchID=@SwitchID";
            DataTable dt = SQLHelper.ExecuteRead(CommandType.Text, strSQL, "dsdsf", new SqlParameter("StationISSI", ISSI),new SqlParameter("SwitchID",switchID));
            try {
                if (int.Parse(dt.Rows[0][0].ToString()) > 0)
                {
                    isReturn = true;
                }
            }
            catch (Exception ex) { }
            return isReturn;
        }

        public bool FindBaseStationISSIForUpdate(int ID, string ISSI, int switchID)//xzj--20181217--添加交换
        {
            bool isReturn = false;
            string strSQL = "select count(0) from BaseStation_info where StationISSI = @StationISSI and SwitchID=@SwitchID and ID!=@ID";
            DataTable dt = SQLHelper.ExecuteRead(CommandType.Text, strSQL, "dsdsf", new SqlParameter("StationISSI", ISSI), new SqlParameter("ID", ID), new SqlParameter("SwitchID", switchID));
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

        public bool FindBaseStationNameForAdd(string StationName)
        {
            bool isReturn = false;
            string strSQL = "select count(0) from BaseStation_info where StationName = @StationName";
            DataTable dt = SQLHelper.ExecuteRead(CommandType.Text, strSQL, "dsdsf", new SqlParameter("StationName", StationName));
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

        public bool FindBaseStationNameForUpdate(int ID, string StationName)
        {
            bool isReturn = false;
            string strSQL = "select count(0) from BaseStation_info where StationName = @StationName and ID!=@ID";
            DataTable dt = SQLHelper.ExecuteRead(CommandType.Text, strSQL, "dsdsf", new SqlParameter("StationName", StationName), new SqlParameter("ID", ID));
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

        public bool IsInBSGroup(string ISSI,int switchID)
        {
            bool isReturn = false;
            // TODO
            string strSQL = "SELECT MemberIds FROM BSGroup_info";
            DataTable dt = SQLHelper.ExecuteRead(CommandType.Text, strSQL, "afdsafassfds");
            if (dt != null && dt.Rows.Count > 0)
            {
                IList<string> allmemberlist = new List<string>();
                foreach (DataRow dr in dt.Rows)
                {
                    string[] strs = dr["MemberIds"].ToString().Split(new char[] { ';' }, StringSplitOptions.RemoveEmptyEntries);
                    if (strs != null && strs.Length > 0)
                    {
                        foreach (string s in strs)
                        {
                            allmemberlist.Add(s);
                        }
                    }
                }
                if (allmemberlist.Where(a => a == "{" + switchID + "," + ISSI + "}").Count() > 0)//xzj--20181217--添加交换
                {
                    isReturn = true;
                }
            }
            return isReturn;
        }

        #endregion
       public DataTable GetDeviceByBsid(string bsid, int switchID, string sort, int startRowIndex, int maximumRows)//xzj--20181217
        {
            //StringBuilder sbSQL = new StringBuilder("select a.BsId, a.issi ,b.stationname,c.Nam,c.Num ,c.type,c.id as userid from ISSI_info a LEFT JOIN BaseStation_info b ON a.BsId = b.StationISSI LEFT JOIN User_info c on c.ISSI = a.ISSI where a.BsId in (@bsid);");
            //return SQLHelper.ExecuteRead(CommandType.Text, sbSQL.ToString(), startRowIndex, maximumRows, "BaseStation_info", new SqlParameter("bsid", bsid));
            StringBuilder sbSQL = new StringBuilder("select a.BsId, a.issi ,b.stationname,c.Nam,c.Num ,c.type,c.id as userid from ISSI_info a LEFT JOIN BaseStation_info b ON a.BsId = b.id LEFT JOIN User_info c on c.ISSI = a.ISSI where a.BsId in (select id from BaseStation_info where StationISSI= " + bsid + " and SwitchID= " + switchID + " );");
            return SQLHelper.ExecuteRead(CommandType.Text, sbSQL.ToString(), startRowIndex, maximumRows, "BaseStation_info");
        }
        public int getAllBsDeviceCount(string bsid,int switchID) {//xzj--20181217

            //StringBuilder sq = new StringBuilder("select count (0) from ISSI_info a LEFT JOIN BaseStation_info b ON a.BsId = b.StationISSI LEFT JOIN User_info on User_info.ISSI = a.ISSI where a.BsId in (" + bsid + ");");
            StringBuilder sq = new StringBuilder("select count (0) from ISSI_info a LEFT JOIN BaseStation_info b ON a.BsId = b.id LEFT JOIN User_info on User_info.ISSI = a.ISSI where a.BsId in (select id from BaseStation_info where StationISSI= " + bsid + " and SwitchID= " + switchID + " );");

            return int.Parse(SQLHelper.ExecuteScalar(CommandType.Text, sq.ToString()).ToString());
            //return 5;
        }

        public DataTable GetAllBaseStationUserName(string Type,string SName)
        {
            StringBuilder sbSQL = new StringBuilder("select top 2 c.Nam,c.type from ISSI_info as a LEFT JOIN BaseStation_info as b ON a.BsId = b.StationISSI " +
"LEFT JOIN User_info as c on c.ISSI = a.ISSI where c.type=@Type and  b.StationName=@SName");
            return SQLHelper.ExecuteRead(CommandType.Text, sbSQL.ToString(), "rrr", new SqlParameter("Type", Type), new SqlParameter("SName", SName));
        }
        
    }
}
