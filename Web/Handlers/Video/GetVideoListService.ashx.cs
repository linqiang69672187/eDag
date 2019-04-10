using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using DbComponent;
using System.Data;
using System.Data.SqlClient;
namespace Web.Handlers.Video
{
    /// <summary>
    /// GetVideoListService 的摘要说明
    /// </summary>
    public class GetVideoListService : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            //正是版本不用
            if (System.Configuration.ConfigurationManager.AppSettings["versionType"].ToString() == "1")
            {
                return;
            }

            if (context.Request["bound"] == null)
            {
                StringBuilder sbSQL = new StringBuilder("SELECT ID,VideoName,VideoPlayUrl,Lo,La,DivID,PicURL FROM Video_Info ");
                DataTable dt = SQLHelper.ExecuteRead(CommandType.Text, sbSQL.ToString(), "viewlist");
                string strResult = DbComponent.Comm.TypeConverter.DataTable2ArrayJson(dt);
                context.Response.Write(strResult);
            }
            else { 
                //bound=120.13215065002441,120.15789985656738,30.190763529455722,30.211608223816917

                string str = context.Request["bound"].ToString();
                string[] arr = str.Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries);
                StringBuilder sbSQL = new StringBuilder("SELECT ID,VideoName,VideoPlayUrl,Lo,La,DivID,PicURL FROM Video_Info where Lo>@minlo and Lo<@maxlo and La>@minla and La<@maxla");
                DataTable dt = SQLHelper.ExecuteRead(CommandType.Text, sbSQL.ToString(), "viewlist", new SqlParameter("minlo", arr[0]), new SqlParameter("maxlo", arr[1]), new SqlParameter("minla", arr[2]), new SqlParameter("maxla", arr[3]));
                string strResult = DbComponent.Comm.TypeConverter.DataTable2ArrayJson(dt);
                context.Response.Write(strResult);

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