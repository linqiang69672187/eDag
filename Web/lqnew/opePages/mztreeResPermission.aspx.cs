using DbComponent;
using DbComponent.resPermissions;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Text;
using System.Data.SqlClient;
using Ryu666.Components;
using Newtonsoft.Json.Linq;
using System.IO;
namespace Web.lqnew.opePages
{
    public partial class mztreeResPermission : System.Web.UI.Page
    {
        string hostipadd = String.Empty;
        string dispatchUserName = String.Empty;

        public string Lang_zhishu = "";
        private string[] DisptchChildren;
        
        string DipatchId = "";
        String loginUserId = "";
        public string strEntityandType = "";
        public DataTable dtAllEntity = new DataTable();

        public DataTable dtAllUserTypes = new DataTable();

        public JArray unit = new JArray();
        public JArray zhishu = new JArray();
        public JArray usertype = new JArray();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                hostipadd = Request.UserHostAddress;
                if (hostipadd == "::1")
                {
                    hostipadd = "127.0.0.1";
                }
            }
                        
            dispatchUserName = Request.Cookies["username"].Value;

            //多语言化
            Lang_zhishu = ResourceManager.GetString("Lang_zhishu");
            //获取调度台单位的所有下级单位
            DipatchId = Request.Cookies["id"].Value.ToString();
            loginUserId = Request.Cookies["loginUserId"].Value.ToString();
            int DisptchEntityid = int.Parse(DipatchId);
            //DisptchEntityid = 1;

            getResPermission(); 
            
            String resPermissionAllEntityIds = getResPermissionAllEntityIds();
            
            DisptchChildren = resPermissionAllEntityIds.Split(',');
            
            string strAllEntity = "SELECT * from Entity";//查询所有用户记录

            string strAllUserTypes = "select * from UserType";

            dtAllEntity = SQLHelper.ExecuteRead(CommandType.Text, strAllEntity, "allentity");

            dtAllUserTypes = SQLHelper.ExecuteRead(CommandType.Text, strAllUserTypes, "allusertypes");
             

            StringBuilder sb_entityandtype = new StringBuilder("<nodes>");
            sb_entityandtype.Append(GetEntityandType("0"));
            sb_entityandtype.Append("</nodes>");
            strEntityandType = sb_entityandtype.ToString();

            iniSelectedEntityServerFile();
                                    
        }
        private string GetEntityandType(string entityid)
        {
            DataRow[] dtOne = dtAllEntity.Select().Where(a => a.Field<string>("ParentID") == entityid).ToArray<DataRow>();
            StringBuilder sb = new StringBuilder();
            foreach (DataRow dr in dtOne)
            {               
                    int IsBranch = IsSelfBranch(dr["id"].ToString());
                    if (IsBranch == 1)
                    {
                        if (dr["Depth"].ToString() == "-1")
                        {
                            sb.Append("<node id=\"entityroot\" text=\"" + dr["Name"] + "\" isCheckbox=\"true\" checked=\"true\" display=\"none\" url=\"javascript:\" >");
                            //zhishudanwei
                            sb.Append("<node id=\"zhishuuser" + dr["id"] + "\" text=\"" + Lang_zhishu + "\" isCheckbox=\"true\" display=\"none\" url=\"javascript:\" >");
                        }
                        else
                        {
                            string childrenids = GetAllChildrenID_device(int.Parse(dr["id"].ToString()));
                            if (dr["id"].ToString() == DipatchId)
                            {
                                sb.Append("<node id=\"entity" + dr["id"] + "\" text=\"" + dr["Name"] + "\" isCheckbox=\"true\" checked=\"true\" url=\"javascript:\" childrenids=\"" + childrenids + "\">");
                                //zhishudanwei
                                sb.Append("<node id=\"zhishuuser" + dr["id"] + "\" text=\"" + Lang_zhishu + "\" isCheckbox=\"true\" url=\"javascript:\" childrenids=\"" + "[" + dr["id"] + "]" + "\">");
                            }
                            else
                            {
                                sb.Append("<node id=\"entity" + dr["id"] + "\" text=\"" + dr["Name"] + "\" isCheckbox=\"true\" url=\"javascript:\" childrenids=\"" + childrenids + "\">");
                                //zhishudanwei
                                sb.Append("<node id=\"zhishuuser" + dr["id"] + "\" text=\"" + Lang_zhishu + "\" isCheckbox=\"true\" url=\"javascript:\" childrenids=\"" + "[" + dr["id"] + "]" + "\">");
                            }

                            foreach (DataRow dtUserType in dtAllUserTypes.Rows)
                            {
                                sb.Append("<node id=\"usertype" + dtUserType["id"] + "\" entitytext=\"" + dr["Name"] + "\"  text=\"" + dtUserType["TypeName"] + "\" typename=\"" + dtUserType["TypeName"] + "\" entityid=\"" + dr["id"] + "\" isCheckbox=\"true\"  url=\"javascript:\">");
                                sb.Append("</node>");
                            }
                        }
                    }
                    else
                    {
                        if (dr["Depth"].ToString() == "-1")
                        {
                            sb.Append("<node id=\"entityroot\" text=\"" + dr["Name"] + "\"  checked=\"true\" display=\"none\" url=\"javascript:\" >");
                            //zhishudanwei
                            sb.Append("<node id=\"zhishuuserroot\" text=\"" + Lang_zhishu + "\" isCheckbox=\"true\" display=\"none\" url=\"javascript:\" >");
                        }
                        else
                        {
                            string childrenids = GetAllChildrenID_device(int.Parse(dr["id"].ToString()));
                            if (isEntityHaschildInresPermission(dr["id"].ToString())==1)
                            {
                                sb.Append("<node id=\"entity" + dr["id"] + "\" text=\"" + dr["Name"] + "\" color=\"#CC9933\" url=\"javascript:\" childrenids=\"" + childrenids + "\">");
                            }
                            else
                            {
                                sb.Append("<node id=\"entity" + dr["id"] + "\" text=\"" + dr["Name"] + "\" color=\"#857B7A\" url=\"javascript:\" childrenids=\"" + childrenids + "\">");
                            }
                            //zhishudanweijiedian
                            if (IsZhishuInResPermission(dr["id"].ToString())==1)
                            {
                                sb.Append("<node id=\"zhishuuser" + dr["id"] + "\" text=\"" + Lang_zhishu + "\" isCheckbox=\"true\" url=\"javascript:\" childrenids=\"" + "[" + dr["id"] + "]" + "\">");
                                foreach (DataRow dtUserType in dtAllUserTypes.Rows)
                                {

                                    sb.Append("<node id=\"usertype" + dtUserType["id"] + "\" entitytext=\"" + dr["Name"] + "\"  text=\"" + dtUserType["TypeName"] + "\" typename=\"" + dtUserType["TypeName"] + "\" entityid=\"" + dr["id"] + "\" isCheckbox=\"true\"  url=\"javascript:\">");
                                        sb.Append("</node>");
                                   
                                }
                            }
                            else
                            {
                                if (isZhishuHaschildInresPermission(dr["id"].ToString()) == 1)
                                {
                                    sb.Append("<node id=\"zhishuuser" + dr["id"] + "\" text=\"" + Lang_zhishu + "\" color=\"#CC9933\" url=\"javascript:\" childrenids=\"" + "[" + dr["id"] + "]" + "\">");
                                }
                                else
                                {
                                    sb.Append("<node id=\"zhishuuser" + dr["id"] + "\" text=\"" + Lang_zhishu + "\" color=\"#857B7A\" url=\"javascript:\" childrenids=\"" + "[" + dr["id"] + "]" + "\">");
                                }
                                foreach (DataRow dtUserType in dtAllUserTypes.Rows)
                                {
                                    if (IsUsertypeInResPermission(dr["id"].ToString(), dtUserType["id"].ToString()) == 1)
                                    {
                                        sb.Append("<node id=\"usertype" + dtUserType["id"] + "\" entitytext=\"" + dr["Name"] + "\"  text=\"" + dtUserType["TypeName"] + "\" typename=\"" + dtUserType["TypeName"] + "\" entityid=\"" + dr["id"] + "\" isCheckbox=\"true\"  url=\"javascript:\">");
                                        sb.Append("</node>");
                                    }
                                    else
                                    {
                                        sb.Append("<node id=\"usertype" + dtUserType["id"] + "\" entitytext=\"" + dr["Name"] + "\"  text=\"" + dtUserType["TypeName"] + "\" typename=\"" + dtUserType["TypeName"] + "\" entityid=\"" + dr["id"] + "\" color=\"#857B7A\" url=\"javascript:\">");
                                        sb.Append("</node>");
                                    }
                                }
                            }
                        }
                        
                    }
                    sb.Append("</node>");

                    sb.Append(GetEntityandType(dr["id"].ToString()));
                    sb.Append("</node>");
                //}
                //else
                //{
                //    sb.Append(GetEntityandType(dr["id"].ToString()));
                //}
            }
            return sb.ToString();
        }

        #region 根据Id判断某一单位是否为自己或下级单位
        protected int IsSelfBranch(String EntityId)
        {
            int IsSelfBranch = 0;
            for (int i = 0; i < DisptchChildren.Length - 1; i++)
            {
                if (EntityId == DisptchChildren[i])
                {
                    IsSelfBranch = 1;
                    return IsSelfBranch;
                }
            }
            return IsSelfBranch;
        }
        #endregion
        #region 根据Id判断直属是否在自己权限中
        protected int IsZhishuInResPermission(String EntityId)
        {
            int IsIn = 0;
            for (int i = 0; i < zhishu.Count(); i++)
            {
                JObject jo = (JObject)zhishu[i];
                String zhishuentityId = jo["entityId"].ToString();
                if (EntityId == zhishuentityId)
                {
                    IsIn = 1;
                    return IsIn;
                }
            }
            return IsIn;
        }
        #endregion
        #region 查询下级及所有子级单位ID  
        protected string GetAllChildrenID_device(int id)
        {
            StringBuilder sb = new StringBuilder();
            DataTable dt = DbComponent.SQLHelper.ExecuteRead(CommandType.Text, "WITH lmenu(name,id,[ParentID]) as (SELECT name,id,[ParentID]  FROM [Entity] WHERE id=@id UNION ALL    SELECT A.NAME,A.id,A.ParentID FROM [Entity] A,lmenu b    where a.ParentID = b.[ID]) select id from lmenu", "getParentID", new SqlParameter("id", id));
            
            for (int i = 0; i < dt.Rows.Count; i++)
            {                
                sb.Append("["+ dt.Rows[i][0].ToString() + "]");
            }
          
            return sb.ToString();
        }
        #endregion
        #region 查询下级及所有子级单位ID
        protected string GetAllChildrenID(int id)
        {
            StringBuilder sb = new StringBuilder();
            DataTable dt = DbComponent.SQLHelper.ExecuteRead(CommandType.Text, "WITH lmenu(name,id,[ParentID]) as (SELECT name,id,[ParentID]  FROM [Entity] WHERE id=@id UNION ALL    SELECT A.NAME,A.id,A.ParentID FROM [Entity] A,lmenu b    where a.ParentID = b.[ID]) select id from lmenu", "getParentID", new SqlParameter("id", id));
            sb.Append(",");
            for (int i = 0; i < dt.Rows.Count; i++)
            {                
                sb.Append(dt.Rows[i][0].ToString() + ",");
            }
          
            return sb.ToString();
        }
        #endregion
    public void getResPermission()
    {
        try
        {
            LoginuserResourcePermissions LoginuserResourcePermissionsClass = new LoginuserResourcePermissions();
            JArray joRelust = LoginuserResourcePermissionsClass.getLoginuserResPermissionsByUserId_JObject(loginUserId);
            for (int i = 0; i < joRelust.Count(); i++)
            {
                if (joRelust[i]["unit"] != null) {
                    unit = JArray.Parse(joRelust[i]["unit"].ToString());
                }
                if (joRelust[i]["zhishu"] != null)
                {
                    zhishu = JArray.Parse(joRelust[i]["zhishu"].ToString());
                }
                if (joRelust[i]["usertype"] != null)
                {
                    usertype = JArray.Parse(joRelust[i]["usertype"].ToString());
                }
            }           
        }
        catch (Exception ex) { }
    }
    public String getResPermissionAllEntityIds()
    {
        StringBuilder resPermissionAllEntityIds = new StringBuilder();
        if (unit != null && unit.Count() != 0)
        {
            for (int i = 0; i < unit.Count(); i++)
            {
                JObject jo = (JObject)unit[i];
                String entityId = jo["entityId"].ToString();
                String AllChilds = GetAllChildrenID(int.Parse(entityId));
                resPermissionAllEntityIds.Append(AllChilds);
            }
        }
        
        return resPermissionAllEntityIds.ToString();
    }

    #region 根据usertypeId判断该警员类型是否在权限中
    protected int IsUsertypeInResPermission(String entityId,String usertypeId)
    {
        int IsIn = 0;
        if (usertype != null && usertype.Count() != 0)
        {
            for (int i = 0; i < usertype.Count(); i++)
            {
                JObject jo = (JObject)usertype[i];
                String enId = jo["entityId"].ToString();
                if (entityId == enId)
                {
                    JArray usertypeIds = (JArray)jo["usertypeIds"];
                    for (int j = 0; j < usertypeIds.Count(); j++)
                    {
                        String utId = usertypeIds[j].ToString();
                        if (usertypeId == utId) {
                            IsIn = 1;
                            return IsIn;
                        }
                    }
                }                
            }
        }
        return IsIn;
    }
    #endregion
    #region 没有权限的单位判断其下面是否有在权限中的子单位或直属或警员类型
    protected int isEntityHaschildInresPermission(string entityid)
    {
        int ishas = 0;
        String childEnId = "";
        childEnId = entityid;
        ishas = isChildEnIdInresPermission(childEnId);
        if (ishas == 1)
        {
            return ishas;
        }
        DataRow[] dtOne = dtAllEntity.Select().Where(a => a.Field<string>("ParentID") == entityid).ToArray<DataRow>();
        if (dtOne.Length > 0)
        {
            foreach (DataRow dr in dtOne)
            {
                childEnId = dr["id"].ToString();
                ishas = isChildEnIdInresPermission(childEnId);
                if (ishas == 1)
                {
                    return ishas;
                }
                else
                {
                    ishas = isEntityHaschildInresPermission(childEnId);
                }
            }
        }
            return ishas;
    }
    #endregion
    protected int isChildEnIdInresPermission(string childEnId)
    {
        int ishas = 0;
        for (int i = 0; i < unit.Count(); i++)
                {
                    JObject jo = (JObject)unit[i];
                    String enId = jo["entityId"].ToString();
                    if (enId == childEnId)
                    {
                        ishas = 1;
                        return ishas;
                    }
                }
                for (int i = 0; i < zhishu.Count(); i++)
                {
                    JObject jo = (JObject)zhishu[i];
                    String zhishuentityId = jo["entityId"].ToString();
                    if (zhishuentityId == childEnId)
                    {
                        ishas = 1;
                        return ishas;
                    }
                }
                for (int i = 0; i < usertype.Count(); i++)
                {
                    JObject jo = (JObject)usertype[i];
                    String utEnId = jo["entityId"].ToString();
                    if (utEnId == childEnId)
                    {
                        ishas = 1;
                        return ishas;
                    }
                }
                return ishas;
    }
    #region 没有权限的直属判断其下面是否有在权限中的警员类型
    protected int isZhishuHaschildInresPermission(string entityid)
    {
        int ishas = 0;
        if (usertype != null && usertype.Count() != 0)
        {
            for (int i = 0; i < usertype.Count(); i++)
            {
                JObject jo = (JObject)usertype[i];
                String enId = jo["entityId"].ToString();
                if (enId == entityid)
                {
                    foreach (DataRow dtUserType in dtAllUserTypes.Rows)
                    {
                        
                        String usertypeId = dtUserType["id"].ToString();
                        JArray usertypeIds = (JArray)jo["usertypeIds"];
                        for (int j = 0; j < usertypeIds.Count(); j++)
                        {
                            String utId = usertypeIds[j].ToString();
                            if (utId == usertypeId)
                            {
                                ishas = 1;
                                return ishas;
                            }
                        }
                    }
                }
            }
        }
        return ishas;
    }
    #endregion
    public void iniSelectedEntityServerFile()
    {
        dispatchUserResourcePermissions_get dispatchUserResourcePermissions_getClass = new dispatchUserResourcePermissions_get();
        String DispatchPermissions = dispatchUserResourcePermissions_getClass.getDispatchUserResourcePermissions(loginUserId);
        if (DispatchPermissions == null) { 
            DispatchPermissions="";
        }
        setSelectedEntityToFile(DispatchPermissions);
    }
    public void setSelectedEntityToFile(string SelectedEntity)
    {
        try
        {
            //log.Info("setSelectedEntityToFile" + hostipadd);
            //hostipadd = "10.8.57.83";
            
            string folderpath = "..\\..\\WebGis\\Service\\SelectedEntity\\" + dispatchUserName + "\\" + hostipadd;
            string filepath = folderpath + "\\SelectedEntity.txt";
            if (!Directory.Exists(Server.MapPath(@folderpath)))
            {
                Directory.CreateDirectory(Server.MapPath(@folderpath));

            }
            if (!File.Exists(Server.MapPath(@filepath)))
            {
                FileStream fs = new FileStream(Server.MapPath(@filepath), FileMode.OpenOrCreate);
                StreamWriter sw = new StreamWriter(fs, Encoding.Default);

                sw.Write(SelectedEntity);
                sw.Close();
                fs.Close();

            }
            else
            {
                FileStream fs = new FileStream(Server.MapPath(@filepath), FileMode.Truncate);
                StreamWriter sw = new StreamWriter(fs, Encoding.Default);

                sw.Write(SelectedEntity);
                sw.Close();
                fs.Close();
            }

        }
        catch (Exception e) { }
    }

    }
}