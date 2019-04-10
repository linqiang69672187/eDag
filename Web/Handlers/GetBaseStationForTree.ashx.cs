using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using DbComponent;
using Ryu666.Components;
using System.Text;

namespace Web.Handlers
{
    /// <summary>
    /// GetBaseStationForTree 的摘要说明
    /// </summary>
    public class GetBaseStationForTree : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            string bsType = context.Request["bsType"].ToString();
            if (bsType == "singleRoot")
            {
                LoadSingleRootTree(context);
            }
            else if (bsType == "singleChildren")
            {
                LoadSingleChildrenTree(context);
            }
            
        }
        /// <summary>
        /// 返回基站根节点，该节点只是一个名称为“基站”的节点作为根节点
        /// </summary>
        /// <param name="context"></param>
        public void LoadSingleRootTree(HttpContext context)
        {
            string nodeName = ResourceManager.GetString("Station");//多语言 基站
            string result = "[{\"id\":\"1\",\"text\":\"" + nodeName + "\",\"children\":[]}]";
            WriteJsonBack(result, context);
        }
        /// <summary>
        /// 返回单基站所有基站
        /// </summary>
        /// <param name="context"></param>
        public void LoadSingleChildrenTree(HttpContext context)
        {
            DataTable dt = SQLHelper.ExecuteRead(CommandType.Text, "select ID,StationName uname,Cast(StationISSI as nvarchar(100))+'('+Cast(SwitchID as nvarchar(100))+')' as uissi,utype='" + Ryu666.Components.ResourceManager.GetString("Station") + "',ucheck='0' from BaseStation_info", "SingleChildrenTree");
            string result = DbComponent.Comm.TypeConverter.DataTable2ArrayJson(dt);
            context.Response.Write(result);
        }
        /// <summary>
        /// 返回json字符串
        /// </summary>
        /// <param name="result"></param>
        /// <param name="context"></param>
        public void WriteJsonBack(string result,HttpContext context)
        {
            context.Response.Clear();
            context.Response.ContentEncoding = Encoding.UTF8;
            context.Response.ContentType = "application/json";
            context.Response.Write(result);
            context.Response.Flush();
            context.ApplicationInstance.CompleteRequest();
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