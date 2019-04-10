using System.Data;
using System.Text;
using System.Web;
using System.Web.SessionState;

namespace Web.Handlers
{
    /// <summary>
    /// GetIssiTypeByISSI 的摘要说明
    /// </summary>
    public class GetIssiTypeByISSI : IHttpHandler, IReadOnlySessionState
    {

        private DbComponent.UserISSIViewDao ISSIService
        {
            get
            {
                return new DbComponent.UserISSIViewDao();
            }
        }
        private DbComponent.IDAO.IDispatchUserViewDao DispatchInfoDaoService
        {
            get
            {
                return DbComponent.FactoryMethod.DispatchInfoFactory.CreateDispatchUserViewDao();
            }
        }
        private DbComponent.group GroupService
        {
            get
            {
                return new DbComponent.group();
            }
        }
         ////xzj--20190225--添加基站短信
        private DbComponent.IDAO.IBaseStationDao BaseStationDaoService
        {
            get 
            {
                return DbComponent.FactoryMethod.DispatchInfoFactory.CreateBaseStationDao();
            }
        }
        public void ProcessRequest(HttpContext context)
        {
            StringBuilder                       sbResult       = new StringBuilder();
            string                              strISSI        = context.Request["issi"].ToString();
if (context.Request["switchID"]!="undefined" && context.Request["switchID"] != null && context.Request["switchID"] != "")//xzj--20190225--添加基站短信--20190321--添加undefined判断
            {
                string switchID = context.Request["switchID"].ToString();
                MyModel.Model_BaseStation bs = BaseStationDaoService.GetBaseStationByISSI(strISSI, int.Parse(switchID));
                if (bs != null && bs.StationISSI != null && bs.SwitchID != null)
                {
                    sbResult.Append("{\"sname\":\"" + bs.StationName + "\",\"stype\":\"B\",\"pcid\":\"" + bs.StationISSI + "\",\"switchID\":" + bs.SwitchID + ",\"bsid\":"+bs.ID+"}");
                }
                else
                {
                    sbResult.Append("{\"sname\":\"" + Ryu666.Components.ResourceManager.GetString("UnkownUser") + "\",\"stype\":\"W\",\"pcid\":\"-1\"}");//多语言:未知用户
                }
            }
            else
            {
                MyModel.Model_UserISSIView missi = ISSIService.GetUserISSIViewByISSI(strISSI);

            if (missi != null && missi.UserISSI != null && missi.UserISSI != "" && missi.id != null)
            {
                sbResult.Append("{\"la\":\"" + missi.Latitude + "\",\"lo\":\"" + missi.Longitude + "\",\"sname\":\"" + missi.Nam + "\",\"stype\":\"U\",\"pcid\":\"" + missi.UserID + "\"}");
            }
            else
            {
                    DataTable mgroup = GroupService.GetGroupInfoByGIIS(strISSI);
                if (mgroup != null && mgroup.Rows.Count > 0)
                {
                    sbResult.Append("{\"sname\":\"" + mgroup.Rows[0]["Group_name"].ToString() + "\",\"stype\":\"G\",\"pcid\":\"" + mgroup.Rows[0]["GSSI"].ToString() + "\"}");
                }
                else
                {
                    MyModel.Model_DispatchUser_View md = DispatchInfoDaoService.GetDispatchUserByISSI(strISSI);
                    if (md != null && md.Usename != null)
                    {
                        sbResult.Append("{\"sname\":\"" + md.Usename + "\",\"stype\":\"D\",\"pcid\":\"" + md.ID + "\"}");
                    }
                    else
                    {
                        sbResult.Append("{\"sname\":\"" + Ryu666.Components.ResourceManager.GetString("UnkownUser") + "\",\"stype\":\"W\",\"pcid\":\"-1\"}");//多语言:未知用户
                    }
                }
            }
            }

            context.Response.Write(sbResult.ToString());
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