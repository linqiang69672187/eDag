using DbComponent;
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
    /// GetGroupInfoByDXGroup 的摘要说明
    /// </summary>
    public class GetGroupInfoByDXGroup : IHttpHandler, IReadOnlySessionState
    {
        private group GroupService
        {
            get
            {
                return new group();
            }
        }
        public void ProcessRequest(HttpContext context)
        {
            IList<MyModel.Model_group>          GNameList           = new List<MyModel.Model_group>();
            string                              GSSI                = context.Request["GSSI"].ToString();
            string[]                            Gssis               = GSSI.Split(new char[] { ';' },
                                                                                 StringSplitOptions.RemoveEmptyEntries
                                                                                 );
            if (Gssis != null)
            {
                foreach (string strGSSI in Gssis)
                {
                    //DataTable dt = GroupService.GetGroupInfoByGIIS(strGSSI);
                    //if (dt != null && dt.Rows.Count > 0)
                    //{

                    //    GNameList.Add(new MyModel.Model_group { GSSI = strGSSI, Group_name = dt.Rows[0]["Group_name"].ToString(), status = bool.Parse(dt.Rows[0]["status"].ToString()) });
                    //}
                    
                    GNameList.Add(new MyModel.Model_group { GSSI             = strGSSI,
                                                            Group_name       = GroupService.GetGroupGroupname_byGSSI(strGSSI) 
                    });
                }
            }
            context.Response.ContentType = "text/plain";
            context.Response.Write(TypeConverter.List2ArrayJson(GNameList));
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