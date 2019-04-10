using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Net;
using System.IO;
namespace Web.Handlers
{

    /// <summary>
    /// getPGISMap 的摘要说明
    /// </summary>
    public class getBAIDUMap : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            //在此处写入您的处理程序实现。
            bool value = false;
            WebResponse response = null;
            Stream stream = null;
            String MapSrcURL = "";
            String x = "";
            String y = "";
            String z = "";
       
            try
            {
                if (context.Request["MapSrcURL"] != null)
                {
                    MapSrcURL = context.Request["MapSrcURL"].ToString();
                }
                if (context.Request["x"] != null)
                {
                    x = context.Request["x"].ToString();
                }
                if (context.Request["y"] != null)
                {
                   y = context.Request["y"].ToString();
                }
                if (context.Request["z"] != null)
                {
                    z = context.Request["z"].ToString();
                }
            
                int timeOut = 5 * 1000;
                String baiduUrl = "";
                baiduUrl = HttpUtility.UrlDecode(MapSrcURL) + "&x=" + x + "&y=" + y + "&z=" + z;
     
                HttpWebRequest request = (HttpWebRequest)WebRequest.Create(baiduUrl);
                if (timeOut != -1) request.Timeout = timeOut;
                response = request.GetResponse();
                stream = response.GetResponseStream();
                byte[] buffer = readInputStream(stream);
                context.Response.ContentType = "image/jpeg";
                context.Response.BinaryWrite(buffer);
                context.Response.End();
            }
            catch (Exception ex)
            {

            }
            finally
            {
                if (stream != null) stream.Close();
                if (response != null) response.Close();
            }
            
        }
        private static byte[] readInputStream(Stream stream)
        {
            List<byte> bytes = new List<byte>();
            try
            {
                int temp = stream.ReadByte();
                while (temp != -1)
                {
                    bytes.Add((byte)temp);
                    temp = stream.ReadByte();
                }
            }
            catch (Exception ex)
            {

            }
            finally
            {

            }
            return bytes.ToArray();
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