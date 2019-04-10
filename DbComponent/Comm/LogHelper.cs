#region
/*
 * yangdj
 * **/
#endregion
using System;
using System.Configuration;
using System.Reflection;

namespace DbComponent.Comm
{
    public class LogHelper
    {
        private static readonly log4net.ILog log = log4net.LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);
        public static void SetLog(Object obj, MyModel.Enum.LogLevel level)
        {
            if ((int)level > int.Parse(ConfigurationManager.AppSettings["loglevel"].ToString()))
            {
                log.Info(level + " Level's Log <br>" + obj);
            }
        }
    }
}
