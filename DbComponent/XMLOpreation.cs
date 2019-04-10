using System;
using System.Data;
using System.Xml;
namespace DbComponent
{
    public class XMLOpreation
    {
        /// <summary>
        /// 主要的属性 XML文档对象
        /// </summary>
        public XmlDataDocument datadoc;
        private string DataSource;
        /// <summary>
        /// xml 文档名称，将要保存在后台的XML文档的名称

        /// </summary>
        private string xmlfilename;

        /// <summary>
        /// Initializes a new instance of the XMLOpreation class. 构造函数，生成一个 XMLDATADOC 对象
        /// </summary>
        public XMLOpreation(string dataSource)
        {
            DataSource = dataSource;
            this.datadoc = new XmlDataDocument();
        }

        /// <summary>
        /// 从远程HTTP下载文件到服务器 DataSource 目录下,主要用于下载xml xsd
        /// </summary>
        /// <param name="httppath">远程文件地址. The HTTP path of the XML.</param>
        /// <param name="myfilename">本地保存文件名.The local name of the XML file.</param>
        /// <returns>下载成功返回 “TRUE” 否则反</returns>
        public bool LoadXml(string httppath, string myfilename)
        {
            string mysavepath = System.AppDomain.CurrentDomain.BaseDirectory.ToString() + DataSource + myfilename;
            System.Net.WebClient myWebClient = new System.Net.WebClient();
            try
            {
                myWebClient.DownloadFile(httppath, mysavepath);
                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }

        public DataSet GetXMLDataSet(string xmlfilepath)
        {
            DataSet ds = new DataSet();
            ds.ReadXml(xmlfilepath);
            return ds;
        }

        /// <summary>
        /// 用DATASET来装载XML ，xml schema 可以是远程文件地址
        /// </summary>
        /// <param name="xmlfilepath">服务器xml文件.XML file path in server.</param>
        /// <param name="xmlschemapath">服务器XML构架.XML schema file in server.</param>
        /// <returns>返回构架的 DATASET </returns>
        public DataSet GetXmlDataSet(string xmlfilepath, string xmlschemapath)
        {
            this.xmlfilename = xmlfilepath.Substring(xmlfilepath.LastIndexOf("/"));
            ////XmlDataDocument datadoc = new XmlDataDocument();   // 创建XML DATASET交互类

            this.datadoc.DataSet.ReadXmlSchema(xmlschemapath);     // 设置dataset的构架

            this.datadoc.Load(xmlfilepath);                        // 加载XML
            return this.datadoc.DataSet;
        }
        public XmlDataDocument Getdatadoc(string xmlfilepath, string xmlschemapath)
        {
            this.xmlfilename = xmlfilepath.Substring(xmlfilepath.LastIndexOf("/"));
            this.datadoc.DataSet.ReadXmlSchema(xmlschemapath);     // 设置dataset的构架

            this.datadoc.Load(xmlfilepath);                        // 加载XML
            return this.datadoc;
        }

        /// <summary>
        /// 将文件以指定名字保存到 DATASOUCE 目录下

        /// </summary>
        /// <param name="xmlname">以 XMLNAME 为名称保存XML文件到 DATASOURCE目录下</param>
        /// <returns>成功返回 true ， 否则返回 false</returns>
        public bool SaveToXml(string xmlname)
        {
            try
            {
                string mysavepath = System.AppDomain.CurrentDomain.BaseDirectory.ToString() + DataSource + xmlname + ".xml";
                this.datadoc.Save(mysavepath);
            }
            catch (Exception)
            {
                return false;
            }
            return true;
        }

        /// <summary>
        /// 文件以原有文件名保存到 DATASOURCE 目录
        /// </summary>
        /// <returns>成功返回 true 失败返回 false</returns>
        public bool SaveToXml()
        {
            try
            {
                string mysavepath = System.AppDomain.CurrentDomain.BaseDirectory.ToString() + DataSource + this.xmlfilename;
                this.datadoc.Save(mysavepath);
            }
            catch (Exception)
            {
                return false;
            }
            return true;
        }
    }
}
