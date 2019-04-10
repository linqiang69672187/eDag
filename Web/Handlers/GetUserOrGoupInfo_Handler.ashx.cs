using DbComponent;
using DbComponent.IDAO;
using System.Data;
using System.Text;
/*
 * 杨德军
 * **/
using System.Web;
using System.Web.SessionState;

namespace Web.Handlers
{
    /// <summary>
    /// GetUserOrGoupInfo_Handler 的摘要说明
    /// </summary>
    public class GetUserOrGoupInfo_Handler : IHttpHandler, IReadOnlySessionState
    {
        private userinfo UserInfoService
        {
            get
            {
                return new userinfo();
            }
        }
        private group GroupService
        {
            get
            {
                return new group();
            }
        }
        private IDispatchInfoDao DispatchInfoService
        {
            get
            {
                return DbComponent.FactoryMethod.DispatchInfoFactory.CreateDispatchInfoDao();
            }
        }
        public void ProcessRequest(HttpContext context)
        {
            StringBuilder                sbResult           = new StringBuilder("[{");
            string                       issi               = context.Request["issi"].ToString();
            DataTable                    dt                 = UserInfoService.GetInfoByISSI(issi);
            if (issi != "")
            {
                if (dt != null && dt.Rows.Count > 0)
                {
                    sbResult.Append("\"type\":" + "\"user\",");
                    sbResult.Append("\"entity\":" + "\"" + dt.Rows[0]["Name"] + "\",");
                    sbResult.Append("\"id\":" + "\"" + dt.Rows[0]["ID"] + "\",");
                    sbResult.Append("\"nam\":" + "\"" + dt.Rows[0]["Nam"] + "\",");
                    sbResult.Append("\"num\":" + "\"" + dt.Rows[0]["Num"] + "\"");
                    sbResult.Append("}]");
                    context.Response.Write(sbResult.ToString());
                    return;
                }
                
                if(dt==null || dt.Rows.Count==0)
                {
                    dt = GroupService.GetGroupInfoByGIIS(issi);
                    if (dt != null && dt.Rows.Count > 0)
                    {
                        sbResult.Append("\"type\":" + "\"group\",");
                        sbResult.Append("\"groupname\":" + "\"" + dt.Rows[0]["Group_name"] + "\",");
                        sbResult.Append("\"entityname\":" + "\"" + dt.Rows[0]["Name"] + "\"");
                        sbResult.Append("}]");
                        context.Response.Write(sbResult.ToString());
                        return;
                    }
                }

                 if (dt == null || dt.Rows.Count == 0)
                {
                    MyModel.Model_Dispatch_View MDV = DispatchInfoService.GetModelDispatchViewByISSI(issi);
                    if (MDV.EntityName != null)
                    {
                        sbResult.Append("\"entity\":" + "\"" + MDV.EntityName + "\",");
                        sbResult.Append("\"nam\":" + "\"" + Ryu666.Components.ResourceManager.GetString("Dispatch") + "\",");//多语言:调度台
                        sbResult.Append("\"num\":\"\"");
                    }
                    else
                    {
                        sbResult.Append("\"entity\":" + "\"\",");
                        sbResult.Append("\"nam\":\"\",");
                        sbResult.Append("\"num\":\"\"");
                    }
                    sbResult.Append("}]");
                    context.Response.Write(sbResult.ToString());
                }
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