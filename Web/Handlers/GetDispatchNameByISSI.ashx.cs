using DbComponent.FactoryMethod;
using DbComponent.IDAO;
using MyModel;
/*
 * 杨德军
 * **/
using System;
using System.Reflection;
using System.Web;
using System.Web.SessionState;

namespace Web.Handlers
{
    /// <summary>
    /// GetDispatchNameByISSI 的摘要说明
    /// </summary>
    public class GetDispatchNameByISSI : IHttpHandler, IReadOnlySessionState
    {
        private static readonly log4net.ILog log = log4net.LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);
        private IDispatchUserViewDao DispatchUserViewService
        {
            get
            {
                return DispatchInfoFactory.CreateDispatchUserViewDao();
            }
        }
        public void ProcessRequest(HttpContext context)
        {
            try
            {
                string                          strResult             = "";
                string                          strISSI               = context.Request.QueryString["ISSI"].ToString();
                Model_DispatchUser_View         DispatchUserView      = DispatchUserViewService.GetDispatchUserByISSI(strISSI);
                if (DispatchUserView != null)
                {
                    if (!String.IsNullOrEmpty(DispatchUserView.Usename))
                    {
                        strResult = "{\"PCName\":\"" + Ryu666.Components.ResourceManager.GetString("Dispatch") + "[" + DispatchUserView.Usename + "]\"}";//多语言:调度台
                    }
                    else
                    {
                        strResult = "{\"PCName\":\"" + Ryu666.Components.ResourceManager.GetString("Dispatch") + "[" + Ryu666.Components.ResourceManager.GetString("Unkown") + "]\"}";//多语言:调度台；未知
                    }
                }
                else
                {
                    strResult = "{\"PCName\":\"" + Ryu666.Components.ResourceManager.GetString("UnRegDispatch") + "\"}";//多语言:未注册的调度台
                }
                context.Response.Write(strResult);
                context.Response.End();
            }
            catch (Exception ex)
            {
                log.Error(ex);
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