using DbComponent.Comm;
/*
 * 杨德军
 * **/
using System;
using System.Collections.Generic;
using System.Web;
using System.Web.SessionState;

namespace Web.Handlers
{
    /// <summary>
    /// GetBSGroupMember_Handlers 的摘要说明
    /// </summary>
    public class GetBSGroupMember_Handlers : IHttpHandler, IReadOnlySessionState
    {
        private DbComponent.IDAO.IBaseStationDao BSService
        {
            get
            {
                return DbComponent.FactoryMethod.DispatchInfoFactory.CreateBaseStationDao();
            }
        }
        private DbComponent.IDAO.IBSGroupInfoDao BSGService
        {
            get
            {
                return DbComponent.FactoryMethod.DispatchInfoFactory.CreateBSGroupInfoDao();
            }
        }
        public void ProcessRequest(HttpContext context)
        {
            IList<MyModel.Model_BaseStation>      list              = new List<MyModel.Model_BaseStation>();
            string                                BSISSI            = context.Request["BSISSI"].ToString();
            string                                memberids         = BSGService.GetBSGroupInfoByISSI(BSISSI).MemberIds;
            string[]                              ArrMembers        = memberids.Split(new char[] { ';' }, 
                                                                                      StringSplitOptions.RemoveEmptyEntries
                                                                                      );
            if (ArrMembers != null)
            {
                foreach (string issi in ArrMembers)
                {//xzj--20181217--添加交换
                    string[] bsInfo = issi.Split(new char[] { '{', ',','}' }, StringSplitOptions.RemoveEmptyEntries);
                    list.Add(BSService.GetBaseStationByISSI(bsInfo[1].ToString(), string.IsNullOrEmpty(bsInfo[0].ToString()) == true ? 0 : int.Parse(bsInfo[0].ToString())));
                }
            }

            string                                strresults       = TypeConverter.List2ArrayJson<MyModel.Model_BaseStation>(list);
            context.Response.ContentType                           = "text/plain";
            context.Response.Write(strresults);
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