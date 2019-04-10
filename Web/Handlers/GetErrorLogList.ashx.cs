using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.IO;
using System.Text;

namespace Web.Handlers
{
    /// <summary>
    /// GetErrorLogList 的摘要说明
    /// </summary>
    public class GetErrorLogList : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {

            String path = context.Server.MapPath(@"../Logs");
            DirectoryInfo dir = new DirectoryInfo(path);
            int strCount = 0;
            StringBuilder sbdata = new StringBuilder();
            if (dir != null)
            {

                IEnumerable<FileInfo> files = dir.GetFiles().OrderByDescending(a=>a.LastWriteTime);
                 
                int id = 1;
                foreach (FileInfo file in files)
                {
                    //if (!file.Name.Contains(".txt") && !File.Exists(path + "/" + file.Name + ".txt"))
                    //{
                    //    file.CopyTo(path + "/" + file.Name + ".txt");
                    //}
                    sbdata.Append("{\"id\":\"" + id + "\",\"name\":\"" + file.Name + "\",\"size\":\"" + file.Length + "\"},");
                    id++;
                }
                strCount = id - 1;
            }
            String str = sbdata.ToString();
            if (str.Length > 0)
            {
                str = str.Substring(0, str.Length - 1);
            }
            StringBuilder sb = new StringBuilder();
            sb.Append("{\"count\":\"" + strCount + "\",\"data\":[" + str + "]}");
            context.Response.Write(sb.ToString());
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