using OfficeComponent;
using Ryu666.Components;
using System;
using System.Collections.Generic;
using System.Web.SessionState;
using DbComponent.Comm;
using DbComponent.StatuesManage;
using System.Data;
using System.Linq;
using System.Web;
using System.Text;
using DbComponent;
using System.Text.RegularExpressions;

namespace Web.Handlers
{
    /// <summary>
    /// UserDeviceToExcel 的摘要说明
    /// </summary>
    public class UserDeviceToExcel : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            //'&nameorNo, reserveValue = ' + nameorNo, reserveValue
            context.Response.ContentType = "text/plain";
            int unitId = Convert.ToInt32(context.Request["unitId"]);
            string unitName = context.Request["unitName"].ToString();
            string searchTypeId = context.Request["searchTypeId"].ToString();
            string searchTypeName = context.Request["searchTypeName"].ToString();
            string key = HttpUtility.UrlDecode(context.Request["key"].ToString());

            //列标题
            string parentUnit = ResourceManager.GetString("ParentUnit");
            string Subordinateunits =ResourceManager.GetString("Lang_Subordinateunits");
            string name = ResourceManager.GetString("Lang_name");
            string policeType = ResourceManager.GetString("Lang_Type");
            string num = ResourceManager.GetString("Lang_Serialnumber");
            string termininalNum =ResourceManager.GetString("Lang_ISSI");
            string mobile = ResourceManager.GetString("Lang_telephone");
            string position = ResourceManager.GetString("Lang_position");
            string model = ResourceManager.GetString("Lang_mobilemode");
            string factory = ResourceManager.GetString("Lang_factory");
            string UserDevice = ResourceManager.GetString("Lang_UserDeviceManage");
            string sql = "";
            string filename = UserDevice;
            Dictionary<string, string> diclist = new Dictionary<string, string>();

            //设置列标题，（key，value），key都用小写，为数据库查询字段名。
            // diclist.Add("happendate", Lang_HappenDate);
            diclist.Add("pname", parentUnit);
            diclist.Add("uname", Subordinateunits);
            diclist.Add("nam", name);
            diclist.Add("type", policeType);
            diclist.Add("num", num);
            diclist.Add("issi", termininalNum);
            diclist.Add("telephone", mobile);
            diclist.Add("position", position);
            diclist.Add("productmodel", model);
            diclist.Add("manufacturers", factory);

            if (unitId > 0)
                filename = string.Format("{0}_{1}", filename, unitName.Trim());
            if (!string.IsNullOrEmpty(key))
                filename = string.Format("{0}_{1}({2})", filename, searchTypeName, key.Trim());
            //filename = string.Format("{0}_{1}", filename, new DateTime().ToString("yyyyMMdd"));
            string unitStr = Uri.UnescapeDataString(context.Request.Cookies["usertypes"].Value);
            sql = getUserDeviceSql(unitStr, unitId, searchTypeId, key, "");
            Excelheper.Instance.SaveToClient4(context, filename, new List<String>() { filename },sql,diclist);



        }

        public string getUserDeviceSql(string unitStr,int UnitId,string searchType,string key,string sort)
        {
            string unitId = Uri.UnescapeDataString(unitStr.ToString());
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
            if (UnitId != 0) 
            { 
                DbComponent.resPermissions.resPermissionsDao permissionsDao = new DbComponent.resPermissions.resPermissionsDao();
                string ids = "-1";
                IList<object> idList = permissionsDao.getAllAccessUnitIdByIds(UnitId.ToString());
                foreach (var id in idList)
                {
                    ids = ids + "," + id;
                }
                sqlcondition += " and [User_info].[Entity_ID] in (" + ids + ")";
            }
            if (key != null) { sqlcondition += " and [User_info]." + searchType + " like '%" + stringfilter.Filter(key.Trim()) + "%'"; }
            if (sort == "") { sort = "[User_info].id asc"; }
            string sql = "WITH lmenu(name,id,usertype) as (SELECT name,a.id,c.TypeName  FROM [Entity] a left join User_info b on a.id =b.entity_id left join UserType c on c.TypeName=b.type WHERE a.id in (" + unitId + ") " + usertypes + ") select p.Name as PName,c.Name as UName,[User_info].Nam,[User_info].type,[User_info].Num,[User_info].[ISSI],[User_info].Telephone,[User_info].Position,[ISSI_Info].Productmodel,[ISSI_Info].Manufacturers from [User_info] left join [GIS_info] on [User_info].id = [GIS_info].[User_ID] left join [ISSI_Info] on [User_info].ISSI=[ISSI_Info].ISSI left join [Entity] c on [User_info].[Entity_ID]=c.[ID]  left join [Entity] p on p.Id=c.ParentId where len([User_info].[Entity_ID]) > 0  " + sqlcondition + " and exists (select 1 from lmenu where [User_info].entity_id=id and [User_info].type=usertype ) order by " + sort;

            return sql;


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