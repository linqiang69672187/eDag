using DbComponent;
using DbComponent.Comm;
using DbComponent.FactoryMethod;
using DbComponent.IDAO;
using MyModel;
/*
 * 杨德军
 * **/
using System.Collections.Generic;
using System.Web;
using System.Web.SessionState;
namespace Web.Handlers
{
    /// <summary>
    /// GetDXGroupInfoForCallPanl 的摘要说明
    /// </summary>
    public class GetDXGroupInfoForCallPanl : IHttpHandler, IReadOnlySessionState
    {
        private IDXGroupInfoDao DXGroupService
        {
            get
            {
                return DispatchInfoFactory.CreateDXGroupInfoDao();
            }
        }
        private group GroupService
        {
            get
            {
                return new group();
            }
        }
        public void ProcessRequest(HttpContext context)
        {
            string                   TYPE            = context.Request["TYPE"].ToString();
            int                      itype           = 0;
            switch (TYPE)
            {
                case "PJ":
                                     itype           = (int)MyModel.Enum.GroupType.Patch;
                    break;
                case "DX":
                                     itype           = (int)MyModel.Enum.GroupType.Multi_Sel;
                    break;
                default: break;
            }
            IList<Model_DXGroup>     DXList          = DXGroupService.GetDXGroupForCallPanl(itype, 
                                                                                            context.Request.Cookies["id"].Value
                                                                                            );
            if (DXList != null)
            {
                string               str             = TypeConverter.List2ArrayJson(DXList);
                context.Response.Write(str);
            }
            else
            {
                context.Response.Write("[]");
            }
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