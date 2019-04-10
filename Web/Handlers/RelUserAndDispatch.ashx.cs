using MyModel;
/*
 * 杨德军
 * **/
using System;
using System.Configuration;
using System.Reflection;
using System.Web;
using System.Web.SessionState;

namespace Web.Handlers
{
    /// <summary>
    /// RelUserAndDispatch 的摘要说明
    /// </summary>
    public class RelUserAndDispatch : IHttpHandler, IReadOnlySessionState
    {
        private static readonly log4net.ILog log = log4net.LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);
        private DbComponent.login LoginService
        {
            get
            {
                return new DbComponent.login();
            }
        }
        private DbComponent.IDAO.IDispatchInfoDao DispatchInfoService
        {
            get
            {
                return DbComponent.FactoryMethod.DispatchInfoFactory.CreateDispatchInfoDao();
            }
        }
        public void ProcessRequest(HttpContext context)
        {
            string strResult = "";
            string LoginUserName = "";
            string DispatchISSI = context.Request.QueryString["issi"].ToString();
            if (DispatchISSI == "")
            {
                strResult = Ryu666.Components.ResourceManager.GetString("UesrConnectDispatchSuccess");//多语言:登录用户调度台关联成功
            }

            if (context.Request.Cookies["username"] != null)
            {
                LoginUserName = context.Request.Cookies["username"].Value.ToString();
                if (DispatchISSI == "")
                {
                    strResult = Ryu666.Components.ResourceManager.GetString("DispatchLoginFailed");//多语言:调度台注册后返回的标识为空,关联失败
                }
                else
                {

                    MyModel.Model_login LoginerInfo = LoginService.GetLogininfoByUserName(context.Request.Cookies["username"].Value.ToString());
                    if (LoginerInfo != null)
                    {
                        MyModel.Model_Dispatch_View Dispacth = DispatchInfoService.GetModelDispatchViewByISSI(DispatchISSI);
                        if (Dispacth != null)
                        {
                            if (Dispacth.ISSI != null)
                            {
                                //修改调度台中的用户ID
                                MyModel.Model_Dispatch NewDipsatch = new MyModel.Model_Dispatch();
                                NewDipsatch.ID = Dispacth.ID;
                                NewDipsatch.ISSI = Dispacth.ISSI;
                                NewDipsatch.IPAddress = context.Request.UserHostAddress.ToString();
                                NewDipsatch.Entity_ID = Dispacth.Entity_ID;
                                NewDipsatch.Login_ID = LoginerInfo.id.ToString();
                                if (DispatchInfoService.UpdateDispatchInfo(NewDipsatch))
                                {
                                    context.Response.Cookies["myissi"].Value = Dispacth.ISSI;
                                    strResult = Ryu666.Components.ResourceManager.GetString("UesrConnectDispatchSuccess");//多语言:登录用户调度台关联成功
                                    if (LoginDispatchList.ISFindLoginDispatch(Dispacth.ISSI))//在全局变量中找到issi号相应的 就去修改
                                    {
                                        LoginDispatchList.UpdateLoginTime(Dispacth.ISSI,
                                                                          DateTime.Now);
                                    }
                                    else
                                    {
                                        LoginDispatchList.AddLoginDispatch(new LoginDispatch()
                                        {
                                            DispatchISSI = Dispacth.ISSI,
                                            LoginTime = DateTime.Now
                                        });
                                    }
                                }
                                else
                                {
                                    strResult = Ryu666.Components.ResourceManager.GetString("UesrConnectDispatchFailed");//多语言:登录用户调度台关联失败
                                }
                            }
                            else
                            {
                                //直接插入新的调度台信息
                                MyModel.Model_Dispatch NewDipsatch = new MyModel.Model_Dispatch();
                                NewDipsatch.Entity_ID = LoginerInfo.Entity_ID;
                                NewDipsatch.IPAddress = context.Request.UserHostAddress.ToString();
                                NewDipsatch.ISSI = DispatchISSI;
                                NewDipsatch.Login_ID = LoginerInfo.id.ToString();
                                if (DispatchInfoService.AddDispatchInfo(NewDipsatch))
                                {
                                    context.Response.Cookies["myissi"].Value = DispatchISSI;
                                    if (LoginDispatchList.ISFindLoginDispatch(DispatchISSI))//在全局变量中找到issi号相应的 就去修改
                                    {
                                        LoginDispatchList.UpdateLoginTime(DispatchISSI, DateTime.Now);
                                    }
                                    else
                                    {
                                        LoginDispatchList.AddLoginDispatch(new LoginDispatch()
                                        {
                                            DispatchISSI = DispatchISSI,
                                            LoginTime = DateTime.Now
                                        });
                                    }
                                    strResult = Ryu666.Components.ResourceManager.GetString("UesrConnectDispatchSuccess");//多语言:登录用户调度台关联成功
                                }
                                else
                                {
                                    strResult = Ryu666.Components.ResourceManager.GetString("UesrConnectDispatchFailed");//多语言:登录用户调度台关联失败
                                }
                            }
                        }
                        else
                        {
                            //直接插入新的调度台信息
                            MyModel.Model_Dispatch NewDipsatch = new MyModel.Model_Dispatch();
                            NewDipsatch.Entity_ID = LoginerInfo.Entity_ID;
                            NewDipsatch.IPAddress = context.Request.UserHostAddress.ToString();
                            NewDipsatch.ISSI = DispatchISSI;
                            NewDipsatch.Login_ID = LoginerInfo.id.ToString();
                            if (DispatchInfoService.AddDispatchInfo(NewDipsatch))
                            {
                                context.Response.Cookies["myissi"].Value = DispatchISSI;
                                if (LoginDispatchList.ISFindLoginDispatch(DispatchISSI))//在全局变量中找到issi号相应的 就去修改
                                {
                                    LoginDispatchList.UpdateLoginTime(DispatchISSI,
                                                                      DateTime.Now);
                                }
                                else
                                {
                                    LoginDispatchList.AddLoginDispatch(new LoginDispatch()
                                    {
                                        DispatchISSI = DispatchISSI,
                                        LoginTime = DateTime.Now
                                    });
                                }
                                strResult = Ryu666.Components.ResourceManager.GetString("UesrConnectDispatchSuccess");//多语言:登录用户调度台关联成功
                            }
                            else
                            {
                                strResult = Ryu666.Components.ResourceManager.GetString("UesrConnectDispatchFailed");//多语言:登录用户调度台关联失败
                            }
                        }

                    }
                }
            }
            else
            {
                strResult = Ryu666.Components.ResourceManager.GetString("UseUnLogined");//多语言:用户未登录
            }

            float fCookOutTime = 2400f;
            try
            {
                fCookOutTime = float.Parse(ConfigurationManager.AppSettings["CookOutTime"].ToString());
            }
            catch (Exception ex)
            {
                log.Debug(ex);
            }
            context.Response.Cookies["dispatchissi"].Value = DispatchISSI;
            context.Response.Cookies["dispatchissi"].Expires = DateTime.Now.AddMinutes(fCookOutTime);

            
            log.Info("after dispatch register,system return issi is " + DispatchISSI + ",login username is " + LoginUserName + ", login IP  is " + HttpContext.Current.Request.UserHostAddress + ",login pc name is " + HttpContext.Current.Request.UserHostName);
            context.Response.Write("{\"result\":\"" + strResult + "\",\"LoginUserName\":\"" + LoginUserName + "\"}");
            context.Response.End();
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