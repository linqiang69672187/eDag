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
    public class getPGISMap : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            //在此处写入您的处理程序实现。
            bool value = false;
            WebResponse response = null;
            Stream stream = null;
            String MapSrcURL = "";
            String Service = "";
            String Type = "";
            String Zoom = "";
            String Row = "";
            String Col = "";
            String V = "";
            try
            {
                if (context.Request["MapSrcURL"] != null)
                {
                    MapSrcURL = context.Request["MapSrcURL"].ToString();
                }
                if (context.Request["Service"] != null)
                {
                    Service = context.Request["Service"].ToString();
                }
                if (context.Request["Type"] != null)
                {
                    Type = context.Request["Type"].ToString();
                }
                if (context.Request["Zoom"] != null)
                {
                    Zoom = context.Request["Zoom"].ToString();
                }
                if (context.Request["Row"] != null)
                {
                    Row = context.Request["Row"].ToString();
                }
                if (context.Request["Col"] != null)
                {
                    Col = context.Request["Col"].ToString();
                }
                if (context.Request["V"] != null)
                {
                    V = context.Request["V"].ToString();
                }
                int timeOut = 5 * 1000;
                String picUrl = "";         
                picUrl = HttpUtility.UrlDecode(MapSrcURL) + "?Service=" + Service + "&Type=" + Type + "&Zoom=" + Zoom + "&Row=" + Row + "&Col=" + Col + "&V=" + V;
               // picUrl = "http://10.8.59.197:8081/Normal/5/1_1.jpg";
                HttpWebRequest request = (HttpWebRequest)WebRequest.Create(picUrl);
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