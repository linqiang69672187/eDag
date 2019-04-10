using Ryu666.Components;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using Newtonsoft.Json.Linq;

namespace DbComponent
{
    public class userinfo
    {
        private string connstring = System.Configuration.ConfigurationManager.AppSettings["m_connectionString"];

        #region 分页排序移动用户信息
        public DataTable AllUSERInfo(int selectcondition, string selecttype, string textseach, int id, string stringid, int isExternal, string sort, int startRowIndex, int maximumRows)
        {

            if (stringid == null)
            {
                if (isExternal == 1)
                {
                    string sqlcondition = "";
                    sqlcondition += " and [ISSI_Info].IsExternal=" + isExternal + "";
                    if (sort == "") { sort = "id asc"; }
                    return SQLHelper.ExecuteRead(CommandType.Text, "WITH lmenu(name,id) as (SELECT name,id  FROM [Entity] WHERE id=@id UNION ALL SELECT A.NAME,A.id FROM [Entity] A,lmenu b    where a.[ParentID] = b.id) select [User_info].id,[User_info].Nam,[User_info].Num,[User_info].Entity_ID,[User_info].type,[User_info].IsDisplay,[GIS_info].[Longitude],[GIS_info].[Latitude],[User_info].[ISSI],[User_info].bz,[User_info].Telephone,[User_info].Position,[ISSI_Info].Productmodel,[ISSI_Info].Manufacturers,[ISSI_Info].IsExternal,Images.name,Images.type as Itype from [User_info] left join [GIS_info] on [User_info].id = [GIS_info].[User_ID] left join [ISSI_Info] on [User_info].ISSI=[ISSI_Info].ISSI  left join Images on  User_info.type+'_3'=Images.name  where len([User_info].[Entity_ID]) > 0  " + sqlcondition + " and [User_info].[Entity_ID] in (select id from lmenu) order by " + sort, startRowIndex, maximumRows, "Entity", new SqlParameter("id", id));
                }
                else
                {
                    string sqlcondition = "";
                    if (selectcondition != 0) { sqlcondition += " and [User_info].[Entity_ID]='" + selectcondition + "'"; }
                    if (textseach != null) { sqlcondition += " and [User_info]." + selecttype + " like '%" + stringfilter.Filter(textseach.Trim()) + "%'"; }
                    if (sort == "") { sort = "id asc"; }
                    return SQLHelper.ExecuteRead(CommandType.Text, "WITH lmenu(name,id) as (SELECT name,id  FROM [Entity] WHERE id=@id UNION ALL SELECT A.NAME,A.id FROM [Entity] A,lmenu b    where a.[ParentID] = b.id) select [User_info].id,[User_info].Nam,[User_info].Num,[User_info].Entity_ID,[User_info].type,[User_info].IsDisplay,[GIS_info].[Longitude],[GIS_info].[Latitude],[User_info].[ISSI],[User_info].bz,[User_info].Telephone,[User_info].Position,[ISSI_Info].Productmodel,[ISSI_Info].Manufacturers,[ISSI_Info].IsExternal,Images.name,Images.type as Itype from [User_info] left join [GIS_info] on [User_info].id = [GIS_info].[User_ID] left join [ISSI_Info] on [User_info].ISSI=[ISSI_Info].ISSI  left join Images on  User_info.type+'_3'=Images.name  where len([User_info].[Entity_ID]) > 0  " + sqlcondition + " and [User_info].[Entity_ID] in (select id from lmenu) order by " + sort, startRowIndex, maximumRows, "Entity", new SqlParameter("id", id));

                }
            }
            else
            {
                if (sort == "") { sort = "id asc"; }
                return SQLHelper.ExecuteRead(CommandType.Text, "select [User_info].id,[User_info].Nam,[User_info].Num,[User_info].Entity_ID,[User_info].type,[User_info].IsDisplay,[GIS_info].[Longitude],[GIS_info].[Latitude],[User_info].[ISSI],[User_info].bz,[User_info].Telephone,[User_info].Position,[ISSI_Info].Productmodel,[ISSI_Info].Manufacturers,[ISSI_Info].IsExternal,Images.name,Images.type as Itype from [User_info] left join [GIS_info] on [User_info].id = [GIS_info].[User_ID] left join [ISSI_Info] on [User_info].ISSI=[ISSI_Info].ISSI  left join Images on  User_info.type+'_3'=Images.name  where len([User_info].[Entity_ID]) > 0  and User_info.id=" + stringid + "  order by " + sort, startRowIndex, maximumRows, "Entity");
            }
        }
        #endregion
        #region 分页排序人员设备信息
        public DataTable AllUSERDeviceInfo(int selectcondition, string selecttype, string textseach, string UnitId, string sort, int startRowIndex, int maximumRows)
        {
            UnitId = Uri.UnescapeDataString(UnitId);
            
            var usertypes = "";
            string[] strArray = UnitId.Split('|');
            UnitId=strArray[0];
            string[] usertypeArray = strArray[1].Split(';');
            foreach (var usertype in usertypeArray)
            {
                if (!string.IsNullOrEmpty(usertype))
                {
                    string[] u = usertype.Split(',');
                    usertypes += " or (a.id=" + u[0] + " and c.id = " + u[1] + ")";
                }
            }
            string sqlcondition = "";
            if (selectcondition != 0) 
            { 
                DbComponent.resPermissions.resPermissionsDao permissionsDao = new resPermissions.resPermissionsDao();
                string ids = "-1";
                IList<object> idList = permissionsDao.getAllAccessUnitIdByIds(selectcondition.ToString());
                foreach (var id in idList)
                {
                    ids = ids + "," + id;
                }
                sqlcondition += " and [User_info].[Entity_ID] in (" + ids + ")"; 
            }
            if (textseach != null) { sqlcondition += " and [User_info]." + selecttype + " like '%" + stringfilter.Filter(textseach.Trim()) + "%'"; }
            if (sort == "") { sort = "id asc"; }
            return SQLHelper.ExecuteRead(CommandType.Text, "WITH lmenu(name,id,usertype) as (SELECT name,a.id,c.typename FROM [Entity] a left join User_info b on a.id =b.entity_id left join UserType c on c.TypeName=b.type WHERE a.id in (" + UnitId + ") " + usertypes + " ) select [User_info].id,[User_info].Nam,[User_info].Num,[User_info].Entity_ID,c.Name as UName,c.ParentId,p.Name as PName,[User_info].type,[User_info].IsDisplay,[GIS_info].[Longitude],[GIS_info].[Latitude],[User_info].[ISSI],[User_info].bz,[User_info].Telephone,[User_info].Position,[ISSI_Info].Productmodel,[ISSI_Info].Manufacturers from [User_info] left join [GIS_info] on [User_info].id = [GIS_info].[User_ID] left join [ISSI_Info] on [User_info].ISSI=[ISSI_Info].ISSI left join [Entity] c on [User_info].[Entity_ID]=c.[ID]  left join [Entity] p on p.Id=c.ParentId where len([User_info].[Entity_ID]) > 0  " + sqlcondition + " and exists (select 1 from lmenu where [User_info].entity_id=id and [User_info].type=usertype ) order by " + sort, startRowIndex, maximumRows, "Entity");
        }
        #endregion


        #region  分页排序预案管理信息
        public DataTable AllUSEREmergency( string selecttype, string textseach, string sort, int startRowIndex, int maximumRows)
        {
            string sqlcondition = "";
            string type = ResourceManager.GetString("Lang_Log_All");
            if (sort == "") { sort = "CreateDate DESC"; }
            if (textseach != null) { sqlcondition += "and Name like '%" + textseach + "%' "; }
            if (selecttype != type) { sqlcondition += "and PlanType='" + selecttype + "'"; }
            return SQLHelper.ExecuteRead(CommandType.Text, " select * from PrePlan where 1=1 " + sqlcondition + " order by " + sort, startRowIndex, maximumRows, "PrePlan");


        }
        #endregion 


        #region 取得移动用户数量信息
        public int getallIIScount2(string minLa, string minLo, string maxLa, string maxLo, int id)
        {

            string sqlcondition = " and GIS_info.Longitude>" + minLo + " and  GIS_info.Longitude<" + maxLo + " and GIS_info.Latitude>" + minLa + " and GIS_info.Latitude<" + maxLa;

            return int.Parse(SQLHelper.ExecuteScalar(CommandType.Text, "WITH lmenu(name,id) as (SELECT name,id  FROM [Entity] WHERE id=@id UNION ALL SELECT A.NAME,A.id FROM [Entity] A,lmenu b    where a.[ParentID] = b.id) select count(*) from GIS_info join user_info on User_ID = user_info.ID  where  [Entity_ID] in (select id from lmenu)" + sqlcondition, new SqlParameter("id", id)).ToString());
        }
        #endregion
        #region 分页排序移动用户信息
        public DataTable AllUSERInfo(string minla, string minlo, string maxla, string maxlo, int id, string sort, int startRowIndex, int maximumRows)
        {
            DataTable dt = null;

            string sqlcondition = " and GIS_info.Longitude>" + minlo + " and  GIS_info.Longitude<" + maxlo + " and GIS_info.Latitude>" + minla + " and GIS_info.Latitude<" + maxla;
            // string sqlcondition = "and Longitude between convert(float,dbo.Get_StrArrayStrOfIndex('" + bound + "',',',1)) and convert(float,dbo.Get_StrArrayStrOfIndex('" + bound + "',',',2)) and Latitude between convert(float,dbo.Get_StrArrayStrOfIndex('" + bound + "',',',3)) and convert(float,dbo.Get_StrArrayStrOfIndex('" + bound + "',',',4))";
            if (sort == "") { sort = "user_info.id asc"; }
            return SQLHelper.ExecuteRead(CommandType.Text, "WITH lmenu(name,id) as (SELECT name,id  FROM [Entity] WHERE id=@id UNION ALL SELECT A.NAME,A.id FROM [Entity] A,lmenu b    where a.[ParentID] = b.id) select user_info.id,user_info.type,user_info.Nam,user_info.Num,GIS_info.ISSI,user_info.Entity_ID,user_info.IsDisplay from GIS_info join user_info on User_ID = user_info.ID where len([Entity_ID]) > 0  " + sqlcondition + " and [Entity_ID] in (select id from lmenu) order by " + sort, startRowIndex, maximumRows, "Entity", new SqlParameter("id", id));

        }
        #endregion
        public DataTable AllUSERInfo(string minla, string minlo, string maxla, string maxlo, int id)
        {
            DataTable dt = null;

            string sqlcondition = " and GIS_info.Longitude>" + minlo + " and  GIS_info.Longitude<" + maxlo + " and GIS_info.Latitude>" + minla + " and GIS_info.Latitude<" + maxla;


            return SQLHelper.ExecuteRead(CommandType.Text, "WITH lmenu(name,id) as (SELECT name,id  FROM [Entity] WHERE id=@id UNION ALL SELECT A.NAME,A.id FROM [Entity] A,lmenu b    where a.[ParentID] = b.id) select user_info.id,user_info.type,user_info.Nam,user_info.Num,GIS_info.ISSI,user_info.Entity_ID,user_info.IsDisplay from GIS_info join user_info on User_ID = user_info.ID where len([Entity_ID]) > 0  " + sqlcondition + " and [Entity_ID] in (select id from lmenu) ", "Entity", new SqlParameter("id", id));

        }

        #region 取得移动用户数量信息
        public int getallIIScount(int selectcondition, string selecttype, string textseach, int id, string stringid,int isExternal)
        {
            if (stringid == null)
            {
                if (isExternal == 1)
                {
                    string sqlcondition = "";
                    sqlcondition += " and [ISSI_Info].IsExternal=" + isExternal + "";
                    return int.Parse(SQLHelper.ExecuteScalar(CommandType.Text, "WITH lmenu(name,id) as (SELECT name,id  FROM [Entity] WHERE id=@id UNION ALL SELECT A.NAME,A.id FROM [Entity] A,lmenu b    where a.[ParentID] = b.id) select count(*) from User_info left join [ISSI_Info] on [User_info].ISSI=[ISSI_Info].ISSI where [User_info].[Entity_ID] in (select id from lmenu)" + sqlcondition, new SqlParameter("id", id)).ToString());
                }
                else
                {
                    string sqlcondition = "";
                    if (selectcondition != 0) { sqlcondition += " and [Entity_ID]='" + selectcondition + "'"; }
                    if (textseach != null) { sqlcondition += " and " + selecttype + " like '%" + stringfilter.Filter(textseach.Trim()) + "%'"; }
                    return int.Parse(SQLHelper.ExecuteScalar(CommandType.Text, "WITH lmenu(name,id) as (SELECT name,id  FROM [Entity] WHERE id=@id UNION ALL SELECT A.NAME,A.id FROM [Entity] A,lmenu b    where a.[ParentID] = b.id) select count(*) from User_info where  [Entity_ID] in (select id from lmenu)" + sqlcondition, new SqlParameter("id", id)).ToString());

                }
            }
            else
            {
                return int.Parse(SQLHelper.ExecuteScalar(CommandType.Text, "select count(*) from User_info where  User_info.id=" + stringid).ToString());
            }
        }
        #endregion

        #region 取得人员设备数量信息
        public int getAllUSERDeviceCount(int selectcondition, string selecttype, string textseach, string unitId)
        {
            unitId = Uri.UnescapeDataString(unitId);
            var usertypes = "";
            string[] strArray = unitId.Split('|');
            unitId = strArray[0];
            string[] usertypeArray = strArray[1].Split(';');
            foreach (var usertype in usertypeArray)
            {
                if (!string.IsNullOrEmpty(usertype))
                {
                    string[] u = usertype.Split(',');
                    usertypes += " or (a.id=" + u[0] + " and c.id = " + u[1] + ")";
                }
            }

            string sqlcondition = "";
            if (selectcondition != 0) 
            { 
                DbComponent.resPermissions.resPermissionsDao permissionsDao = new resPermissions.resPermissionsDao();
                string ids = "-1";
                IList<object> idList = permissionsDao.getAllAccessUnitIdByIds(selectcondition.ToString());
                foreach (var id in idList)
                {
                    ids = ids + "," + id;
                }
                sqlcondition += " and [User_info].[Entity_ID] in (" + ids + ")"; 
            }
            if (textseach != null) { sqlcondition += " and " + selecttype + " like '%" + stringfilter.Filter(textseach.Trim()) + "%'"; }

            return int.Parse(SQLHelper.ExecuteScalar(CommandType.Text, "WITH lmenu(name,id,usertype) as (SELECT name,a.id,c.typename FROM [Entity] a left join User_info b on a.id =b.entity_id left join UserType c on c.TypeName=b.type WHERE a.id in (" + unitId + ")" + usertypes + " ) select count(*) from User_info where exists (select 1 from lmenu where [User_info].entity_id=id and [User_info].type=usertype )" + sqlcondition).ToString());

        }
        #endregion


        #region 取得预案管理数量信息
        public int getAllUSEREmergency(string selecttype, string textseach)
        {
            string sqlcondition = "";
            string type = ResourceManager.GetString("Lang_Log_All");
            if (textseach != null ) { sqlcondition += "and Name like '%" + textseach + "%'" ; }
            if (selecttype != type) { sqlcondition += "and PlanType='" + selecttype+"'"; }
            return int.Parse(SQLHelper.ExecuteScalar(CommandType.Text, " select COUNT(*) from PrePlan where 1=1 " + sqlcondition).ToString());

        }

        #endregion


        #region 预案管理DropDownList绑定

        public DataTable DropEmergency()
        {

            return SQLHelper.ExecuteRead(CommandType.Text, " select * from [PrePlanType]", "PrePlanType");

        }



        #endregion

        #region 判断当前预案管理是否存在
        public bool IsExistEmergencyNameForAdd(string name)
        {
            bool returnResult = false;
            string strSQL = "Select count(0) from PrePlan where [name]=@Name";
            DataTable dt = SQLHelper.ExecuteRead(CommandType.Text, strSQL, "fdsfs", new SqlParameter("Name", name));
            if (int.Parse(dt.Rows[0][0].ToString()) > 0)
                returnResult = true;

            return returnResult;
        }

        #endregion 


        #region 预案管理添加信息
        public bool AddEmergencyinfo(string name, string plantype, byte[] Url,string FileName,string createdate)
        {

            try
            {

                SQLHelper.ExecuteNonQuery(CommandType.Text, " insert into [PrePlan] (Name,PlanType,Url,FileName,CreateDate)values(@Name,@PlanType,@Url,@FileName,@CreateDate)", new SqlParameter("Name", name), new SqlParameter("PlanType", plantype), new SqlParameter("Url", Url), new SqlParameter("FileName", FileName), new SqlParameter("CreateDate", createdate));


                return true;
            }
            catch (Exception e)
            { return false; }
        }
        #endregion

        #region 预案管理查出文件二进制
        public DataTable ByteEmergency(int id)
        {
            return SQLHelper.ExecuteRead(CommandType.Text, " select * from PrePlan where  [id]=@id", "fdsfs", new SqlParameter("id", id));


        }
        #endregion


        #region 取得预案管理文件名字查询
        public int getAllFilemergency(string FileName)
        {
            return int.Parse(SQLHelper.ExecuteScalar(CommandType.Text, " select COUNT(*) from PrePlan where FileName=@FileName",new SqlParameter("FileName",FileName)).ToString());

        }

        #endregion



        #region 删除预案管理信息
        public void DelEmergency(int id)
        {
            try
            {
                SQLHelper.ExecuteNonQuery(CommandType.Text, "DELETE FROM [PrePlan] WHERE [id] =@id", new SqlParameter("id", id));
            }
            catch (Exception ex)
            { }
        }
        #endregion




        #region 获取框选经纬度范围的移动用户信息
        public DataTable getAllUSERInfo(string sid, int id, string sort)
        {
            DataTable dt = null;
            if (sid == null)
            {
                return dt;
            }

            string[] pcid = sid.Split(new string[] { "," }, StringSplitOptions.RemoveEmptyEntries);
            float minlo = float.Parse(pcid[0]);
            float maxlo = float.Parse(pcid[1]);
            float minla = float.Parse(pcid[2]);
            float maxla = float.Parse(pcid[3]);
            string sqlcondition = "and Longitude between " + minlo + " and " + maxlo + " and Latitude between " + minla + " and " + maxla;
            if (sort == "") { sort = "user_info.id asc"; }
            return SQLHelper.ExecuteRead(CommandType.Text, "WITH lmenu(name,id) as (SELECT name,id  FROM [Entity] WHERE id=@id UNION ALL SELECT A.NAME,A.id FROM [Entity] A,lmenu B where a.[ParentID] = B.id) select user_info.id,user_info.type,user_info.Nam,user_info.Num,user_info.ISSI,lmenu.name entityname,user_info.Entity_ID,user_info.IsDisplay,typeName terminalType,ISSI_info.status from GIS_info join user_info on User_ID = user_info.ID join ISSI_info on (user_info.ISSI = ISSI_info.ISSI) join lmenu  on (user_info.Entity_ID=lmenu.id) where len(user_info.Entity_ID) > 0  " + sqlcondition + " order by " + sort, "Entity", new SqlParameter("id", id));
        }
        #endregion
        #region 获取框选经纬度范围的移动用户信息，增加权限管理功能
        public DataTable getAllUSERInfoResPermission(string sid, String respermission, String isHideOfflineUser, int device_timeout)
        {

            string StoredProcedureName = "getUsersByResPermission";
            return SQLHelper.ExecuteReadStrProc(CommandType.StoredProcedure, StoredProcedureName, "AllUSER", new SqlParameter("sid", sid), new SqlParameter("respermission", respermission), new SqlParameter("isHideOfflineUser", isHideOfflineUser), new SqlParameter("device_timeout", device_timeout));
        }
        #endregion

        #region 获取框选经纬度范围的移动用户信息,不包含不在线警员
        public DataTable getAllUSERInfoWithoutOfflineUser(string sid, int id, string sort, int device_timeout)
        {
            DataTable dt = null;
            if (sid == null)
            {
                return dt;
            }

            string[] pcid = sid.Split(new string[] { "," }, StringSplitOptions.RemoveEmptyEntries);
            float minlo = float.Parse(pcid[0]);
            float maxlo = float.Parse(pcid[1]);
            float minla = float.Parse(pcid[2]);
            float maxla = float.Parse(pcid[3]);
            string sqlcondition = "and Longitude between " + minlo + " and " + maxlo + " and Latitude between " + minla + " and " + maxla;
            string sqlWithoutOfflineUser = " and DATEDIFF(MINUTE,Send_time,GETDATE()) < " + device_timeout;
            if (sort == "") { sort = "user_info.id asc"; }
            return SQLHelper.ExecuteRead(CommandType.Text, "WITH lmenu(name,id) as (SELECT name,id  FROM [Entity] WHERE id=@id UNION ALL SELECT A.NAME,A.id FROM [Entity] A,lmenu B where a.[ParentID] = B.id) select user_info.id,user_info.type,user_info.Nam,user_info.Num,user_info.ISSI,lmenu.name entityname,user_info.Entity_ID,user_info.IsDisplay,typeName terminalType,ISSI_info.status from GIS_info join user_info on User_ID = user_info.ID join ISSI_info on (user_info.ISSI = ISSI_info.ISSI) join lmenu  on (user_info.Entity_ID=lmenu.id) where len(user_info.Entity_ID) > 0  " + sqlcondition + sqlWithoutOfflineUser + " order by " + sort, "Entity", new SqlParameter("id", id));
        }
        #endregion
        #region 分页排序移动用户信息
        public DataTable AllUSERInfo(string sid, int id, string sort, int startRowIndex, int maximumRows)
        {
            DataTable dt = null;
            if (sid == null)
            {
                return dt;
            }

            //string[] pcid = sid.Split(new string[] { "," }, StringSplitOptions.RemoveEmptyEntries);
            //string sqlid = "";
            //for (int i = 0; i < pcid.Length; i++)
            //{
            //    sqlid += i == pcid.Length - 1 ? pcid[i] : pcid[i] + ",";
            //}
            // string sqlcondition = "and user_info.id in (" + sqlid + ")";
            string[] pcid = sid.Split(new string[] { "," }, StringSplitOptions.RemoveEmptyEntries);
            string sqlcondition = "and Longitude between convert(float," + pcid[0] + ") and convert(float," + pcid[1] + ") and Latitude between convert(float," + pcid[2] + ") and convert(float," + pcid[3] + ")";
            if (sort == "") { sort = "user_info.id asc"; }
            return SQLHelper.ExecuteRead(CommandType.Text, "WITH lmenu(name,id) as (SELECT name,id  FROM [Entity] WHERE id=@id UNION ALL SELECT A.NAME,A.id FROM [Entity] A,lmenu b    where a.[ParentID] = b.id) select user_info.id,user_info.type,user_info.Nam,user_info.Num,user_info.ISSI,user_info.Entity_ID,user_info.IsDisplay from GIS_info join user_info on User_ID = user_info.ID where len([Entity_ID]) > 0  " + sqlcondition + " and [Entity_ID] in (select id from lmenu) order by " + sort, startRowIndex, maximumRows, "Entity", new SqlParameter("id", id));


        }
        #endregion
        #region 取得移动用户数量信息
        public int getallIIScount(string sid, int id)
        {
            if (sid == null)
            {
                return 0;
            }
            //string[] pcid = sid.Split(new string[] { "," }, StringSplitOptions.RemoveEmptyEntries);
            //string sqlid = "";
            //for (int i = 0; i < pcid.Length; i++)
            //{
            //    sqlid += i == pcid.Length - 1 ? pcid[i] : pcid[i] + ",";
            //}
            //string sqlcondition = "and user_info.id in (" + sqlid + ")";
            string[] pcid = sid.Split(new string[] { "," }, StringSplitOptions.RemoveEmptyEntries);
            string sqlcondition = "and Longitude between convert(float," + pcid[0] + ") and convert(float," + pcid[1] + ") and Latitude between convert(float," + pcid[2] + ") and convert(float," + pcid[3] + ")";
            System.Web.HttpContext ht = System.Web.HttpContext.Current;

            ht.Cache["count"] = int.Parse(SQLHelper.ExecuteScalar(CommandType.Text, "WITH lmenu(name,id) as (SELECT name,id  FROM [Entity] WHERE id=@id UNION ALL SELECT A.NAME,A.id FROM [Entity] A,lmenu b    where a.[ParentID] = b.id) select count(*) from GIS_info join user_info on User_ID = user_info.ID  where  [Entity_ID] in (select id from lmenu)" + sqlcondition, new SqlParameter("id", id)).ToString());


            return (int)ht.Cache["count"];


        }
        #endregion
        #region 添加移动用户信息
        public bool CheckUserInfo(string Nam, string Entity_ID)
        {
            object obj = SQLHelper.ExecuteScalar(CommandType.Text, "select count(*) from User_info where Nam=@Nam and Entity_ID=@Entity_ID", new SqlParameter("Nam", Nam), new SqlParameter("Entity_ID", Entity_ID));

            if (Convert.ToInt32(obj) > 0)
            {
                return false;
            }
            else
                return true;
        }

        public bool CheckEditUserInfo(string Nam, int ID, string Entity_ID)
        {
            object obj = SQLHelper.ExecuteScalar(CommandType.Text, "select count(*) from User_info where Nam=@Nam and Entity_ID=@Entity_ID and ID<>@ID", new SqlParameter("Nam", Nam), new SqlParameter("Entity_ID", Entity_ID), new SqlParameter("ID", ID));

            if (Convert.ToInt32(obj) > 0)
            {
                return true;
            }
            else
                return false;
        }


        public bool AddUserinfo(string Nam, string Num, string ISSI, string Entity_ID, string type, string bz, string mobile, string position)
        {
            try
            {
                SQLHelper.ExecuteNonQuery(CommandType.Text, "INSERT [User_info] ([Nam],[Num],[ISSI],[Entity_ID],[type],[bz],[Position],[Telephone])VALUES (@Nam,@Num,@ISSI,@Entity_ID,@type,@bz,@Position,@Telephone)", new SqlParameter("Nam", Nam), new SqlParameter("Num", Num), new SqlParameter("ISSI", ISSI), new SqlParameter("Entity_ID", Entity_ID), new SqlParameter("type", type), new SqlParameter("bz", bz), new SqlParameter("Position", position), new SqlParameter("Telephone", mobile));
                return true;
            }
            catch
            { return false; }
        }
        #endregion

        #region 根据ID取得移动用户信息
        public MyModel.Model_userinfo GetUserinfo_byid(int id)
        {
            MyModel.Model_userinfo userinfo = new MyModel.Model_userinfo();
            DataTable dt = SQLHelper.ExecuteRead(CommandType.Text, "select top 1 [User_info].id,Nam,Num,[User_info].ISSI,[User_info].Entity_ID,type,[User_info].bz,[User_info].Telephone,[User_info].Position,IsDisplay,typeName terminalType,ipAddress,status terminalStatus from [User_info] left join ISSI_info on User_info.ISSI = ISSI_info.ISSI  where [User_info].id =@id", "userinfo", new SqlParameter("id", id));
            for (int dtcount = 0; dtcount < dt.Rows.Count; dtcount++)
            {
                userinfo.id = id;
                userinfo.Nam = dt.Rows[dtcount][1].ToString();
                userinfo.Num = dt.Rows[dtcount][2].ToString();
                userinfo.ISSI = dt.Rows[dtcount][3].ToString();
                userinfo.Entity_ID = dt.Rows[dtcount][4].ToString();
                userinfo.type = dt.Rows[dtcount][5].ToString();
                userinfo.bz = dt.Rows[dtcount][6].ToString();
                userinfo.IsDisplay = Convert.ToBoolean(dt.Rows[dtcount]["IsDisplay"].ToString());
                userinfo.terminalType = dt.Rows[dtcount]["terminalType"].ToString().Trim();
                userinfo.ipAddress = dt.Rows[dtcount]["ipAddress"].ToString().Trim();
                userinfo.terminalStatus = dt.Rows[dtcount]["terminalStatus"].ToString().Trim();
                userinfo.Telephone = dt.Rows[dtcount]["Telephone"].ToString().Trim();
                userinfo.Position = dt.Rows[dtcount]["Position"].ToString().Trim();
            }
            return userinfo;
        }
        #endregion

 #region 根据ID取得移动用户信息加场强信息（用于框选后用户的详情界面）
        public DataTable GetUserinfoAndGisInfo_byid(int id)//xzj--20181224--需要Gis_info信息，无法使用上一个函数GetUserinfo_byid
        {
            MyModel.Model_userinfo userinfo = new MyModel.Model_userinfo();
            DataTable dt = SQLHelper.ExecuteRead(CommandType.Text, "select top 1 [User_info].id,Nam,Num,[User_info].ISSI,[User_info].Entity_ID,type,[User_info].bz,[User_info].Telephone,[User_info].Position,IsDisplay,typeName terminalType,ipAddress,status terminalStatus,GIS_info.Battery,GIS_info.MsRssi,GIS_info.UlRssi from [User_info] left join ISSI_info on User_info.ISSI = ISSI_info.ISSI left join GIS_info on (User_info.ISSI=GIS_info.ISSI)  where [User_info].id =@id", "userinfo", new SqlParameter("id", id));
            return dt;
        }
        #endregion

        #region
        public DataTable GetUserInfoByIds(string[] ids)
        {

            StringBuilder sbIds = new StringBuilder();
            foreach (string id in ids)
            {
                sbIds.Append("'" + id + "',");
            }
            string strIds = sbIds.ToString();
            if (strIds.Length > 0)
            {
                strIds = strIds.Substring(0, strIds.Length - 1);
            }
            DataTable dt = SQLHelper.ExecuteRead(CommandType.Text, "(select User_info.id,User_info.Nam,User_info.ISSI,User_info.type, ISSI_info.typeName from [User_info] left outer join [ISSI_info] on (User_info.ISSI=ISSI_info.ISSI) where User_info.id in ( " + strIds + "))", "userinfo");

            return dt;
        }
        #endregion
        #region
        //public IList<MyModel.Model_userinfo> GetUserInfoByIds(string[] ids)
        //{
        //    IList<MyModel.Model_userinfo> userList = new List<MyModel.Model_userinfo>();
        //    StringBuilder sbIds = new StringBuilder();
        //    foreach (string id in ids)
        //    {
        //        sbIds.Append("'" + id + "',");
        //    }
        //    string strIds = sbIds.ToString();
        //    if (strIds.Length > 0)
        //    {
        //        strIds = strIds.Substring(0, strIds.Length - 1);
        //    }
        //    DataTable dt = SQLHelper.ExecuteRead(CommandType.Text, "select * from [User_info] where id in ( " + strIds + " )", "userinfo");
        //    for (int dtcount = 0; dtcount < dt.Rows.Count; dtcount++)
        //    {
        //        MyModel.Model_userinfo userinfo = new MyModel.Model_userinfo();
        //        userinfo.id = int.Parse(dt.Rows[dtcount]["id"].ToString());
        //        userinfo.Nam = dt.Rows[dtcount]["Nam"].ToString();
        //        userinfo.Num = dt.Rows[dtcount]["Num"].ToString();
        //        userinfo.ISSI = dt.Rows[dtcount]["ISSI"].ToString();
        //        userinfo.Entity_ID = dt.Rows[dtcount]["Entity_ID"].ToString();
        //        userinfo.type = dt.Rows[dtcount]["type"].ToString();
        //        userinfo.bz = dt.Rows[dtcount]["bz"].ToString();
        //        userinfo.IsDisplay = Convert.ToBoolean(dt.Rows[dtcount]["IsDisplay"].ToString());
        //        userList.Add(userinfo);
        //    }
        //    return userList;
        //}
        #endregion

        public MyModel.Model_userinfo GetUserInofByISSI(string issi)
        {
            MyModel.Model_userinfo userinfo = new MyModel.Model_userinfo();
            DataTable dt = SQLHelper.ExecuteRead(CommandType.Text, "select top 1 * from [User_info] where ISSI =@ISSI", "userinfo", new SqlParameter("ISSI", issi));
            for (int dtcount = 0; dtcount < dt.Rows.Count; dtcount++)
            {
                userinfo.id = int.Parse(dt.Rows[dtcount]["id"].ToString());
                userinfo.Nam = dt.Rows[dtcount]["Nam"].ToString();
                userinfo.Num = dt.Rows[dtcount]["Num"].ToString();
                userinfo.ISSI = dt.Rows[dtcount]["ISSI"].ToString();
                userinfo.Entity_ID = dt.Rows[dtcount]["Entity_ID"].ToString();
                userinfo.type = dt.Rows[dtcount]["type"].ToString();
                userinfo.bz = dt.Rows[dtcount]["bz"].ToString();
                userinfo.IsDisplay = Convert.ToBoolean(dt.Rows[dtcount]["IsDisplay"].ToString());
            }
            return userinfo;
        }

        public DataTable GetInfoByISSI(string issi)
        {
            //string strSql = " select top 1 User_info.id as ID,Nam,Num,User_info.ISSI,Name,Entity_ID,Name,IsDisplay ,Longitude,Latitude,[type],Inserttb_time from User_info left outer join Entity on (User_info.Entity_ID=Entity.ID) left outer join GIS_info on (User_info.ISSI=GIS_info.ISSI) where User_info.ISSI=@ISSI";
            string strSql = " select top 1 User_info.id as ID,User_info.Nam,User_info.Num,User_info.ISSI,Entity.Name,User_info.Entity_ID,User_info.IsDisplay ,Longitude,Latitude,[type],Inserttb_time, ISSI_info.typeName from User_info left outer join Entity on (User_info.Entity_ID=Entity.ID) left outer join ISSI_info on (User_info.ISSI=ISSI_info.ISSI) left outer join GIS_info on (User_info.ISSI=GIS_info.ISSI) where User_info.ISSI=@ISSI";
            DataTable dt = SQLHelper.ExecuteRead(CommandType.Text, strSql, "myinfo", new SqlParameter("ISSI", issi));
            return dt;
        }

        public DataTable GetInfoByID(int id)
        {//xzj--20181224--添加选择场强信息GIS_info.Battery,GIS_info.MsRssi,GIS_info.UlRssi
            string strSql = " select top 1 User_info.id as ID,Nam,Num,User_info.ISSI,User_info.bz,Name,User_info.Entity_ID,Name,User_info.Telephone,User_info.Position,IsDisplay ,Longitude,Latitude,[type],Inserttb_time,GIS_info.Battery,GIS_info.MsRssi,GIS_info.UlRssi from User_info left outer join Entity on (User_info.Entity_ID=Entity.ID) left outer join GIS_info on (User_info.ISSI=GIS_info.ISSI) where User_info.id=@id";
            DataTable dt = SQLHelper.ExecuteRead(CommandType.Text, strSql, "myinfo", new SqlParameter("id", id));
            return dt;
        }


        #region 根据ID修改移动用户信息
        public void EditUserinfo_byid(string Nam, string Num, string ISSI, string Entity_ID, string type, string bz, int id)
        {
            SQLHelper.ExecuteNonQuery(CommandType.Text, "UPDATE [User_info] SET [Nam] =@Nam,[Num]=@Num,[ISSI]=@ISSI,[Entity_ID]=@Entity_ID,[type]=@type,[bz]=@bz where id =@id", new SqlParameter("Nam", Nam), new SqlParameter("Num", Num), new SqlParameter("ISSI", ISSI), new SqlParameter("Entity_ID", Entity_ID), new SqlParameter("type", type), new SqlParameter("bz", bz), new SqlParameter("id", id));
        }
        #endregion

        #region 根据ID修改移动用户所有信息
        public void EditUserinfo_byid(string Nam, string Num, string ISSI, string Entity_ID, string type, string bz, string mobile, string posistion, int id, bool isdisplay)
        {
            SQLHelper.ExecuteNonQuery(CommandType.Text, "UPDATE [User_info] SET [Nam] =@Nam,[Num]=@Num,[ISSI]=@ISSI,[Entity_ID]=@Entity_ID,[type]=@type,[bz]=@bz,[Telephone]=@Telephone,[Position]=@Position,[IsDisplay]=@isdisplay where id =@id", new SqlParameter("Nam", Nam), new SqlParameter("Num", Num), new SqlParameter("ISSI", ISSI), new SqlParameter("Entity_ID", Entity_ID), new SqlParameter("type", type), new SqlParameter("bz", bz), new SqlParameter("Telephone", mobile), new SqlParameter("Position", posistion), new SqlParameter("isdisplay", isdisplay), new SqlParameter("id", id));
        }
        #endregion

        #region 根据ID修改移动用户单项信息
        public void EditUserinfo_byid(string field, bool value, int id)
        {
            SQLHelper.ExecuteNonQuery(CommandType.Text, "UPDATE [User_info] SET [" + field + "] ='" + value + "' where id =@id", new SqlParameter("id", id));
        }
        #endregion

        #region 根据ID检查用户是否关联设备
        public int UserISSI_byid(int id)
        {
            return int.Parse(SQLHelper.ExecuteScalar(CommandType.Text, "select count(*) from [User_info] where id=@id  and len([ISSI]) >0", new SqlParameter("id", id)).ToString());
        }
        #endregion

        #region 根据ID删除移动用户信息
        public void DelUserinfo_byid(int id)
        {
            SQLHelper.ExecuteNonQuery(CommandType.Text, "DELETE FROM [User_info] where id =@id", new SqlParameter("id", id));
        }
        #endregion

        #region 根据ISSI释放用户使用该终端
        public void removeISSI(string ISSI)
        {
            SQLHelper.ExecuteNonQuery(CommandType.Text, "UPDATE [User_info] SET [ISSI] = '' WHERE [ISSI] = @ISSI", new SqlParameter("ISSI", ISSI));
        }
        #endregion

        #region 获取所有用户
        public DataTable GetAllUser(string UserName)
        {
            if (!string.IsNullOrEmpty(UserName))
            {
                return SQLHelper.ExecuteRead(CommandType.Text, "select Nam,Issi from [User_info] where Nam like '%" + UserName.ToLower().Replace("'", "\"").Replace("delete", "").Replace("update", "").Replace("create", "").Replace("alert", "") + "%'", "AllUsers");
            }
            else
            {
                return SQLHelper.ExecuteRead(CommandType.Text, "select Nam,Issi from [User_info]", "AllUsers");
            }
        }
        #endregion

        #region 根据ID判断移动用户是否在线
        public static int checkonlineID(int id, int devicetimeout)
        {
            string weizhuce = ResourceManager.GetString("UNLogin");
            string poweroff = ResourceManager.GetString("PowerOff");
            string zhitongmodel = ResourceManager.GetString("Directmode");
            string Illegal = ResourceManager.GetString("Illegal");
            return int.Parse(SQLHelper.ExecuteScalar(CommandType.Text, "SELECT COUNT(*) FROM [GIS_info] where USER_ID =@useid and Send_reason not in ('" + weizhuce + "','" + poweroff + "','" + zhitongmodel + "','" + Illegal + "') and DATEDIFF(MINUTE,Send_time,GETDATE()) < " + devicetimeout, new SqlParameter("useid", id)).ToString());
            // return int.Parse(SQLHelper.ExecuteScalar(CommandType.Text, "SELECT COUNT(*) FROM [GIS_info] where USER_ID =@useid and Send_reason not in ('未注册','关机','直通模式','非法') and DATEDIFF(MINUTE,Send_time,GETDATE()) < " + devicetimeout, new SqlParameter("useid", id)).ToString());
        }

        #endregion

        public bool IsExistPoliceNOForAdd(string PNO)
        {
            bool breturn = false;
            string strSQL = " SELECT COUNT(0) FROM User_info WHERE Num=@Num";
            DataTable dt = SQLHelper.ExecuteRead(CommandType.Text, strSQL, "adfsadfs", new SqlParameter("Num", PNO));
            if (int.Parse(dt.Rows[0][0].ToString()) > 0)
            {
                breturn = true;
            }
            return breturn;
        }
        public bool IsExistPoliceNOForEdit(string PNO, int ID)
        {
            bool breturn = false;
            string strSQL = " SELECT COUNT(0) FROM User_info WHERE Num=@Num and id!=@ID";
            DataTable dt = SQLHelper.ExecuteRead(CommandType.Text, strSQL, "adfsadfsaa", new SqlParameter("Num", PNO), new SqlParameter("ID", ID));
            if (int.Parse(dt.Rows[0][0].ToString()) > 0)
            {
                breturn = true;
            }
            return breturn;
        }

        public bool IsRight(string UserName, int sCount)
        {
            bool breturn = false;
            string str = "SELECT COUNT(*) FROM Stockade WHERE LoginName=@LoginName";
            DataTable dt = SQLHelper.ExecuteRead(CommandType.Text, str, "aaaa", new SqlParameter("LoginName", UserName));
            if (int.Parse(dt.Rows[0][0].ToString()) < sCount)
            {
                breturn = true;
            }
            return breturn;
        }

        public DataTable GetUsersByEntityID(string entityId)
        {
            string strSQL = "WITH lmenu(name,id) as (SELECT name,id  FROM [Entity] WHERE id=@id UNION ALL SELECT A.NAME,A.id FROM [Entity] A,lmenu b    where a.[ParentID] = b.id) ";
            strSQL += " SELECT User_info.id,User_info.Nam uname,User_info.ISSI uissi,User_info.[TYPE] utype,ucheck='0',ISSI_info.typeName issitype from User_info left join ISSI_info on (User_info.ISSI=ISSI_info.ISSI) where User_info.issi!='' and User_info.Entity_ID in (select id from lmenu) ";
            return SQLHelper.ExecuteRead(CommandType.Text, strSQL, "bds", new SqlParameter("id", entityId));
        }

        public DataTable GetZhiShuUsersByEntityID(string entityId)
        {
            string strSQL = " SELECT User_info.id,User_info.Nam uname,User_info.ISSI uissi,User_info.[TYPE] utype,ucheck='0',ISSI_info.typeName issitype from User_info left join ISSI_info on (User_info.ISSI=ISSI_info.ISSI) where User_info.issi!='' and User_info.Entity_ID =@Entity_ID ";
            return SQLHelper.ExecuteRead(CommandType.Text, strSQL, "bds", new SqlParameter("Entity_ID", entityId));
        }

        public DataTable GetUsersByEntityIDAndTypeName(string entityId, string typeName)
        {
            string strSQL = " SELECT User_info.id,User_info.Nam uname,User_info.ISSI uissi,User_info.[TYPE] utype,ucheck='0',ISSI_info.typeName issitype from User_info left join ISSI_info on (User_info.ISSI=ISSI_info.ISSI) where User_info.issi!='' and User_info.Entity_ID=@Entity_ID and User_info.[type]=@typeName ";
            return SQLHelper.ExecuteRead(CommandType.Text, strSQL, "bds", new SqlParameter("Entity_ID", entityId), new SqlParameter("typeName", typeName));
        }
    }
}
