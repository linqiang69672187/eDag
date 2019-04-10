using System.Configuration;

namespace Web
{
    static public class Config
    {
        static public string m_connectionString = ConfigurationManager.AppSettings["m_connectionString"];
        static public string mapGray = ConfigurationManager.AppSettings["mapGray"];
        static Config()
        {
            //
            //TODO: 在此处添加构造函数逻辑
            //
        }
    }
}