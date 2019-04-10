using DbComponent;
using DbComponent.IDAO;
/*
 * 杨德军
 * **/
using System;
using System.Data;
using System.Reflection;
using System.Text;
using System.Web;
using System.Web.SessionState;

namespace Web.Handlers
{
    /// <summary>
    /// GetGroupInfo_Handler 的摘要说明
    /// </summary>
    public class GetGroupInfo_Handler : IHttpHandler, IReadOnlySessionState
    {
        private static readonly log4net.ILog log = log4net.LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);
        private group GroupService
        {
            get
            {
                return new group();
            }
        }
        private IDTGroupInfoDao DTFroupInfoDao
        {
            get
            {
                return DbComponent.FactoryMethod.DispatchInfoFactory.CreateDTGroupInfoDao();
            }
        }
        public void ProcessRequest(HttpContext context)
        {
            try
            {
                StringBuilder                   sbResult            = new StringBuilder("[");
                string                          strGIIS             = context.Request["giis"].ToString();
                if (strGIIS != "")
                {
                    DataTable dt = GroupService.GetGroupInfoByGIIS(strGIIS);
                    if (dt != null && dt.Rows.Count > 0)
                    {
                        sbResult.Append("{\"groupname\":" + "\"" + dt.Rows[0]["Group_name"] + "\",");
                        if (dt.Rows[0]["GSSIS"] != null && (dt.Rows[0]["GSSIS"].ToString() == "" || dt.Rows[0]["GSSIS"].ToString() == "0"))
                        {
                            sbResult.Append("\"grouptype\":" + "\"group\",");
                        }
                        else
                        {
                            sbResult.Append("\"grouptype\":" + "\"dtgroup\",");
                        }

                        sbResult.Append("\"entityname\":" + "\"" + dt.Rows[0]["Name"] + "\"}");
                    }
                    else {
                        sbResult.Append("{\"groupname\":\"\",");
                        sbResult.Append("\"grouptype\":\"\",");
                        sbResult.Append("\"entityname\":\"\"}");
                    }
                }
                sbResult.Append("]");
                context.Response.Write(sbResult.ToString());
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