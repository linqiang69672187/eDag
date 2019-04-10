using DbComponent.FactoryMethod;
using DbComponent.IDAO;
using MyModel;
/*
 * 杨德军
 * **/
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.SessionState;

namespace Web.Handlers
{
    /// <summary>
    /// GetIsInStockadeList 的摘要说明
    /// </summary>
    public class GetIsInStockadeList : IHttpHandler, IReadOnlySessionState
    {
        private IIsInStockadeViewDao IsInStockadeViewDaoService
        {
            get
            {
                return DispatchInfoFactory.CreateIsInStockadeViewDao();
            }
        }
        public void ProcessRequest(HttpContext context)
        {
            string                               LoginName          = context.Request.Cookies["username"].Value.ToString();
            IList<Model_IsInStockade_View>       myList             = IsInStockadeViewDaoService.GetListByLoginName(LoginName);
            StringBuilder                        sbResult           = new StringBuilder();
            int                                  flag               = 0;

            sbResult.Append("[");
            foreach (Model_IsInStockade_View md in myList)
            {
                sbResult.Append("{");
                sbResult.Append("\"Nam\":\"" + md.Nam + "\",");
                sbResult.Append("\"LoginName\":\"" + md.LoginName + "\",");
                sbResult.Append("\"divid\":\"" + md.DivID + "\",");
                sbResult.Append("\"divstyle\":\"" + md.DivStyle + "\",");
                sbResult.Append("\"type\":\"" + md.Type + "\",");
                sbResult.Append("\"lo\":\"" + md.Longitude + "\",");
                sbResult.Append("\"la\":\"" + md.Latitude + "\",");
                sbResult.Append("\"userid\":\"" + md.User_ID + "\",");
                sbResult.Append("\"issi\":\"" + md.ISSI + "\",");
                sbResult.Append("\"title\":\"" + md.Title + "\",");
                sbResult.Append("\"createtime\":\"" + md.CreateTime + "\",");
                sbResult.Append("\"laststatus\":\"" + md.LastStatus + "\",");
                sbResult.Append("\"userinstockid\":\"" + md.UserInStockID + "\",");
                sbResult.Append("\"pa\":\"" + md.PointArray + "\"");
                if (flag == myList.Count() - 1)
                {
                    sbResult.Append("}");
                }
                else
                {
                    sbResult.Append("},");
                }

                flag++;
            }
            sbResult.Append("]");
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