using Microsoft.Win32;
using System;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Reflection;

namespace DbComponent
{
    public class Entity
    {
        string connstring = System.Configuration.ConfigurationManager.AppSettings["m_connectionString"];
        private static readonly log4net.ILog log = log4net.LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);

        #region 分页排序单位信息
        public DataTable AllEntityInfo(int selectcondition, string textseach, int id, string sort, int startRowIndex, int maximumRows)
        {
            string sqlcondition = "";
            if (selectcondition != 0) { sqlcondition += " and [ParentID]=" + selectcondition; }
            if (textseach != null) { sqlcondition += " and [Name] like '%" + stringfilter.Filter(textseach.Trim()) + "%'"; }
            if (sort == "") { sort = "id asc"; }
            return SQLHelper.ExecuteRead(CommandType.Text, "WITH lmenu(name,id) as (SELECT name,id  FROM [Entity] WHERE id=@id UNION ALL SELECT A.NAME,A.id FROM [Entity] A,lmenu b    where a.[ParentID] = b.id) select id,Name,ParentID,cast(Depth as int) as Depth,BZ,Lo,La,DivID,PicUrl from Entity where len([Name]) > 0 and Depth>=0 " + sqlcondition + " and id in (select id from lmenu) order by " + sort, startRowIndex, maximumRows, "Entity", new SqlParameter("id", id));
        }
        #endregion

        #region 取得单位数量信息
        public int getallentitycount(int selectcondition, string textseach, int id)
        {
            string sqlcondition = "";
            if (selectcondition != 0) { sqlcondition += " and [ParentID]=" + selectcondition; }
            if (textseach != null) { sqlcondition += " and [Name] like '%" + stringfilter.Filter(textseach.Trim()) + "%'"; }
            return int.Parse(SQLHelper.ExecuteScalar(CommandType.Text, "WITH lmenu(name,id) as (SELECT name,id  FROM [Entity] WHERE id=@id UNION ALL SELECT A.NAME,A.id FROM [Entity] A,lmenu b    where a.[ParentID] = b.id) select count(*) from Entity where len([Name]) > 0 and Depth>=0 and id in (select id from lmenu)" + sqlcondition, new SqlParameter("id", id)).ToString());

        }
        #endregion

        public static string GetMimeMapping(string fileName)
        {
            string mimeType = "application/octet-stream";
            string ext = Path.GetExtension(fileName).ToLower();
            RegistryKey regKey = Registry.ClassesRoot.OpenSubKey(ext);
            if (regKey != null && regKey.GetValue("Content Type") != null)
            {
                mimeType = regKey.GetValue("Content Type").ToString();
            }
            return mimeType;
        }

        #region 添加单位信息
        public bool AddEntityinfo(string name, int ParentID, int Depth, string bz, decimal lo, decimal la, string DivID, string picURL,System.Web.UI.Page p )
        {

            try
            {
                string[] path = picURL.Split('/');

             //   for (int i = 3; i <= 10; i++)
               // {
                    string originalImagePath =path[0] + "/" + path[1] + "/" + path[2] + "/" + path[3] + "/" + path[4] + "/" + path[5];
                    string serverPath =  path[2] + "\\" + path[3] + "\\" + path[4]  + "\\" + path[5];
                    string contentType = GetMimeMapping(path[5]);
                    System.Drawing.Image originalImage = System.Drawing.Image.FromFile(p.Server.MapPath(serverPath));
                    MemoryStream ms = new MemoryStream();
                    originalImage.Save(ms, System.Drawing.Imaging.ImageFormat.Png);
                    byte[] imgedat= ms.ToArray();
                    int count = int.Parse(SQLHelper.ExecuteScalar(CommandType.Text, "select count(id) from [Images] where name =@name and type='Entity' ", new SqlParameter("name", originalImagePath)).ToString());
                 if (count == 0) {
                     SQLHelper.ExecuteNonQuery(CommandType.Text, "INSERT [Images] ([name],[ImageData],[ImageContentType],[ImageSize],[type] ) VALUES (@name,@ImageData,@ImageContentType,@ImageSize,@type)", new SqlParameter("name", originalImagePath), new SqlParameter("ImageData", imgedat), new SqlParameter("ImageContentType", contentType), new SqlParameter("ImageSize", imgedat.Length), new SqlParameter("type", "Entity"));
                 }
                


               // }
              

                SQLHelper.ExecuteNonQuery(CommandType.Text, "INSERT [Entity]([Name],[ParentID],[Depth],[BZ],[Lo],[La],[DivID],[PicUrl])VALUES (@name,@ParentID,@Depth,@bz,@Lo,@La,@DivID,@PicUrl)", new SqlParameter("name", name), new SqlParameter("ParentID", ParentID), new SqlParameter("Depth", Depth), new SqlParameter("bz", bz), new SqlParameter("Lo", lo), new SqlParameter("La", la), new SqlParameter("DivID", DivID), new SqlParameter("PicUrl", picURL));
                
                
                return true;
            }
            catch(Exception e)
            { return false; }
        }
        #endregion

        #region 根据ID取单位信息
        public MyModel.Model_Entity GetEntityinfo_byid(int id)
        {
            MyModel.Model_Entity entity = new MyModel.Model_Entity();
            DataTable dt = SQLHelper.ExecuteRead(CommandType.Text, "select top 1 * from entity where id =@id", "entity", new SqlParameter("id", id));
            for (int countdt = 0; countdt < dt.Rows.Count; countdt++)
            {
                entity.id = int.Parse(dt.Rows[countdt][0].ToString());
                entity.Name = dt.Rows[countdt][1].ToString();
                entity.ParentID = int.Parse(dt.Rows[countdt][2].ToString());
                entity.Depth = int.Parse(dt.Rows[countdt][3].ToString());
                entity.bz = dt.Rows[countdt][4].ToString();
                if (!string.IsNullOrEmpty(dt.Rows[countdt][5].ToString()))
                {
                    entity.Lo = Decimal.Parse(dt.Rows[countdt][5].ToString());
                }
                if (!string.IsNullOrEmpty(dt.Rows[countdt][6].ToString()))
                {
                    entity.La = Decimal.Parse(dt.Rows[countdt][6].ToString());
                }
                entity.DivID = dt.Rows[countdt]["DivID"].ToString();
                entity.PicUrl = dt.Rows[countdt]["PicUrl"].ToString();
            }
            return entity;
        }
        #endregion

        #region 根据ID修改单位信息
        public void EditEntityinfo_byid(int id, string name, string bz, Decimal lo, decimal la, string picUrl, System.Web.UI.Page p)
        {
             try
            {
            string[] path = picUrl.Split('/');

           // for (int i = 3; i <= 10; i++)
           // {
                string originalImagePath = path[0] + "/" + path[1] + "/" + path[2] + "/" + path[3] + "/" + path[4] +  "/" + path[5];
                string serverPath = path[2] + "\\" + path[3] + "\\" + path[4]  + "\\" + path[5];
                string contentType = GetMimeMapping(path[5]);
                System.Drawing.Image originalImage = System.Drawing.Image.FromFile(p.Server.MapPath(serverPath));
                MemoryStream ms = new MemoryStream();
                originalImage.Save(ms, System.Drawing.Imaging.ImageFormat.Png);
                byte[] imgedat = ms.ToArray();
                int count = int.Parse(SQLHelper.ExecuteScalar(CommandType.Text, "select count(id) from [Images] where name =@name and type='Entity' ", new SqlParameter("name", originalImagePath)).ToString());
                if (count == 0)
                {
                    SQLHelper.ExecuteNonQuery(CommandType.Text, "INSERT [Images] ([name],[ImageData],[ImageContentType],[ImageSize] ,[type] ) VALUES (@name,@ImageData,@ImageContentType,@ImageSize,@type)", new SqlParameter("name", originalImagePath), new SqlParameter("ImageData", imgedat), new SqlParameter("ImageContentType", contentType), new SqlParameter("ImageSize", imgedat.Length), new SqlParameter("type", "Entity"));
                }



            //}
            SQLHelper.ExecuteNonQuery(CommandType.Text, "UPDATE [Entity] SET [Name] =@name,[BZ] = @bz,[Lo]=@Lo,[La]=@La,[PicUrl]=@PicUrl where id =@id", new SqlParameter("name", name), new SqlParameter("bz", bz), new SqlParameter("Lo", lo), new SqlParameter("La", la), new SqlParameter("id", id), new SqlParameter("PicUrl", picUrl));
            }
             catch (Exception e)
             { 
             }
             
             }
        #endregion

        #region 查看[ParentID]下单位数
        public int EntityCount_byParentID(int ParentID)
        {
            return int.Parse(SQLHelper.ExecuteScalar(CommandType.Text, "select count(*) from [Entity] where [ParentID] =@ParentID", new SqlParameter("ParentID", ParentID)).ToString());
        }
        #endregion

        #region 根据ID删除单位信息
        public void DelEntityinfo_byid(int id)
        {
            SQLHelper.ExecuteNonQuery(CommandType.Text, "DELETE FROM [Entity] where id =@id", new SqlParameter("id", id));
        }
        #endregion

        #region 所有单位ID,name信息
        public DataTable GetAllEntityInfo(int id)
        { return SQLHelper.ExecuteRead(CommandType.Text, "WITH lmenu(name,id,ParentID) as (SELECT name,id,ParentID  FROM [Entity] WHERE id=@id UNION ALL SELECT A.NAME,A.id,A.ParentID FROM [Entity] A,lmenu b where a.[ParentID] = b.id) select id,name,ParentID,Depth from Entity where id in (select id from lmenu) and Depth>=0 order by Depth", "Entity", new SqlParameter("id", id)); }
        #endregion

        #region 所有单位ID,name信息
        public DataTable GetAllEntityInfo(string unitId)
        {
            unitId = Uri.UnescapeDataString(unitId);
            return SQLHelper.ExecuteRead(CommandType.Text, "WITH lmenu(name,id,ParentID) as (SELECT name,id,ParentID  FROM [Entity] WHERE id in("+unitId+") UNION ALL SELECT A.NAME,A.id,A.ParentID FROM [Entity] A,lmenu b where a.[ParentID] = b.id) select id,name,ParentID,Depth from Entity where id in (select id from lmenu) and Depth>=0 order by Depth", "Entity");
        }
        #endregion

        #region 查询所有单位ID,Name信息通过权限控制
        public DataTable GetAllEntityInfoByPermissions(string unitId)
        {
            unitId = Uri.UnescapeDataString(unitId);
            return SQLHelper.ExecuteRead(CommandType.Text, "WITH lmenu(name,id,ParentID) as (SELECT name,id,ParentID  FROM [Entity] WHERE id in(" + unitId + ")) select id,name,ParentID,Depth from Entity where id in (select id from lmenu) and Depth>=0 order by Depth", "Entity");
        }
        #endregion

        #region 获取角色列表
        public static DataTable GetAllRoleInfo()
        {
            return SQLHelper.ExecuteRead(CommandType.Text, "select id,RoleName,EnRoleName from Role where Status=1 order by id asc", "Entity");
        }
        #endregion

        #region 根据ID查询单位所属层次
        public int GetEntityIndex(int id)
        {
            try
            {
                return int.Parse(SQLHelper.ExecuteScalar(CommandType.Text, "select Depth FROM Entity where [ID] =@id", new SqlParameter("id", id)).ToString());
            }
            catch (Exception ex)
            {
                log.Error(ex);
                return 10000;
            }
        }
        #endregion

        #region 根据单位ID查询单位是否关联编组
        public int EntityContainsGroup(int id)
        {
            return int.Parse(SQLHelper.ExecuteScalar(CommandType.Text, "SELECT count(ID) FROM [Group_info] where [Entity_ID] =@id", new SqlParameter("id", id)).ToString());
        }
        #endregion

        #region 根据单位ID查询单位是否关联移动用户
        public int EntityContainsUser(int id)
        {
            return int.Parse(SQLHelper.ExecuteScalar(CommandType.Text, "SELECT count(ID) FROM [User_info] where [Entity_ID] =@id", new SqlParameter("id", id)).ToString());
        }
        #endregion

        #region 根据单位ID查询单位是否关联调度员
        public int EntityContainslogin(int id)
        {
            return int.Parse(SQLHelper.ExecuteScalar(CommandType.Text, "SELECT count(ID) FROM [login] where [Entity_ID] =@id", new SqlParameter("id", id)).ToString());
        }
        #endregion
        /// <summary>
        /// 根据单位id查询单位是否关联调度台
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public int EntityContainsDispatch(int id)
        {
            log.Info("查询SELECT count(ID) FROM [Dispatch_Info] where [Entity_ID] ='" + id.ToString() + "'");
            return int.Parse(SQLHelper.ExecuteScalar(CommandType.Text, "SELECT count(ID) FROM [Dispatch_Info] where [Entity_ID] =@id", new SqlParameter("id", id)).ToString());
        }
        /// <summary>
        /// 根据单位id查询单位是否关联基站组
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public int EntityContainsBaseStationGroup(int id)
        {
            return int.Parse(SQLHelper.ExecuteScalar(CommandType.Text, "SELECT count(ID) FROM [BSGroup_info] where [Entity_ID] =@id", new SqlParameter("id", id)).ToString());
        }

        #region 根据单位ID查询单位是否关联终端
        public int EntityContainsISSI(int id)
        {
            return int.Parse(SQLHelper.ExecuteScalar(CommandType.Text, "SELECT count(ID) FROM [ISSI_info] where [Entity_ID] =@id", new SqlParameter("id", id)).ToString());
        }
        #endregion

        #region 根据两个单位ID判断前者是否为后者父级单位
        public int IsParentA_B(int parentId, int id)
        {
            return int.Parse(SQLHelper.ExecuteScalar(CommandType.Text, "WITH lmenu(name,id) as (SELECT name,id  FROM [Entity] WHERE id=@parentId UNION ALL    SELECT A.NAME,A.id FROM [Entity] A,lmenu b  where a.[ParentID] = b.id) select count(id) from lmenu where id =@id", new SqlParameter("parentId", parentId), new SqlParameter("id", id)).ToString());
        }
        #endregion

        #region 根据两个单位ID判断两者是否兄弟单位
        public int IsbrothA_B(int brothId, int id)
        {
            return int.Parse(SQLHelper.ExecuteScalar(CommandType.Text, " select count(a.id) from [Entity] a inner join [Entity] b on a.Depth = b.Depth and a.ParentID = b.ParentID where a.ID = @brothId and b.id=@id", new SqlParameter("brothId", brothId), new SqlParameter("id", id)).ToString());
        }
        #endregion

        public DataTable GetAllEntity()
        {
            return SQLHelper.ExecuteRead(CommandType.Text, "select * from Entity where PicUrl is not NULL", "allentity");
        }
        public string GetDivIDbyID(int ID)
        {
            return SQLHelper.ExecuteScalar(CommandType.Text, "select DivID FROM Entity where [ID] =@id", new SqlParameter("id", ID)).ToString();
        }
        public string GetIdByDivID(string DIVID)
        {
            return SQLHelper.ExecuteScalar(CommandType.Text, "select ID FROM Entity where [DivID] =@DivID", new SqlParameter("DivID", DIVID)).ToString();
        }

        public bool IsExistEntityNameForAdd(string EntityName)
        {
            bool returnResult = false;
            string strSQL = "Select count(0) from Entity where [Name]=@Name";
            DataTable dt = SQLHelper.ExecuteRead(CommandType.Text, strSQL, "fdsfs", new SqlParameter("Name", EntityName));
            if (int.Parse(dt.Rows[0][0].ToString()) > 0)
                returnResult = true;

            return returnResult;
        }
        public bool IsExistEntityNameForEdit(int ID, string EntityName)
        {
            bool returnResult = false;
            string strSQL = "Select count(0) from Entity where [Name]=@Name and ID!=@ID";
            DataTable dt = SQLHelper.ExecuteRead(CommandType.Text, strSQL, "fdsfs", new SqlParameter("Name", EntityName), new SqlParameter("ID", ID));
            if (int.Parse(dt.Rows[0][0].ToString()) > 0)
                returnResult = true;

            return returnResult;
        }




        #region  取得框选单位数量信息
        public int getAllEntity_infocount(string minLa, string minLo, string maxLa, string maxLo, string textseach, string selecttype)
        {

            string sqlcondition = "";
            if (selecttype != null && textseach != null) { sqlcondition += " and  " + selecttype + " like '%" + textseach + "%' "; }

            return int.Parse(SQLHelper.ExecuteScalar(CommandType.Text, "select count(*) from Entity  where Lo between " + minLo + " and " + maxLo + " and La between " + minLa + " and " + maxLa + sqlcondition).ToString());

        }

        #endregion

        #region 分页排序框选单位信息
        public DataTable AllEntity_info(string minLa, string minLo, string maxLa, string maxLo, string sort, int startRowIndex, int maximumRows, string textseach, string selecttype)
        {

            string sqlcondition = "";
            if (selecttype != null && textseach != null) { sqlcondition += " and  " + selecttype + " like '%" + textseach + "%' "; }
            if (sort == "") { sort = "Name DESC"; }
            return SQLHelper.ExecuteRead(CommandType.Text, "select ID,Name,Lo,La  from  Entity where Lo between " + minLo + " and " + maxLo + " and La between " + minLa + " and " + maxLa + sqlcondition + " order by " + sort, startRowIndex, maximumRows, "Entity");


        }
        #endregion




    }
}
