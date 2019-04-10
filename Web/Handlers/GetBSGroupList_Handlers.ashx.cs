using DbComponent.Comm;
using DbComponent.FactoryMethod;
using DbComponent.IDAO;
/*
 * 杨德军
 * **/
using System.Collections.Generic;
using System.Web;
using System.Web.SessionState;
using DbComponent;
using System.Data;
using System.Data.SqlClient;

namespace Web.Handlers
{
    /// <summary>
    /// GetBSGroupList_Handlers 的摘要说明
    /// </summary>
    public class GetBSGroupList_Handlers : IHttpHandler, IReadOnlySessionState
    {
        private IBSGroupInfoDao BSGroupService
        {
            get
            {
                return DispatchInfoFactory.CreateBSGroupInfoDao();
            }
        }
        public void ProcessRequest(HttpContext context)
        {
            string                                  entityid            = context.Request.Cookies["id"].Value;


            string sql = "";
            string dispatchUser = context.Request.Cookies["username"].Value.Trim();
            SqlDataReader dr = SQLHelper.GetReader(string.Format("select accessUnitsAndUsertype from login where usename='{0}'", dispatchUser));

            //{"volume":"part","unit":[{"entityId":"2"},{"entityId":"4"}],"zhishu":[],"usertype":[]}
            string unitId = "";
            if (dr.HasRows)
            {
                while (dr.Read())
                {
                    string accessUnit = dr[0].ToString().Trim();
                    if (accessUnit != "")
                    {
                        accessUnit = accessUnit.Substring(accessUnit.IndexOf('['));
                        accessUnit = accessUnit.Substring(0, accessUnit.IndexOf(']') + 1);

                        List<Units> unitList = new List<Units>();

                        unitList = Web.lqnew.opePages.Serial.JSONStringToList<Units>(accessUnit);

                        //string entityid = string.Empty;
                        foreach (var item in unitList)
                        {

                            unitId = unitId + "," + item.entityId;

                        }
                    }

                }
            }
            if (unitId != "" && unitId.Substring(0, 1) == ",")
            {
                unitId = unitId.Substring(1);
            }



            IList<MyModel.Model_BSGroupInfo> list = BSGroupService.GetBsGroupInfoList(unitId);

            string strresults = TypeConverter.List2ArrayJson<MyModel.Model_BSGroupInfo>(list);

            context.Response.ContentType                                = "text/plain";
            context.Response.Write(strresults);
        }

        public class Units
        {
            public string entityId { get; set; }
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