using System;
using System.Collections.Generic;

using System.Linq;
using System.Text;
using System.Data.Objects;
using System.Data.SqlClient;
using System.Data;
using MyModel.Enum;
using System.Web;
using System.Xml;
namespace DbComponent.LogModule
{
    public class SystemLog
    {

        public static void WriteLog(ParameType strFun, OperateLogType strLogtype, OperateLogModule strModule, OperateLogOperType strOpertype, String strContent, OperateLogIdentityDeviceType strIdentityDeviceType, string strUserid = "")
        {
         
            if (DbComponent.LogModule.SystemLog.isHavaPression(strOpertype))
            {
                string dispatchIssi = "";

                if (HttpContext.Current.Request.Cookies["dispatchissi"] != null)
                {
                    dispatchIssi = HttpContext.Current.Request.Cookies["dispatchissi"].Value;
                }
                string dispatchIp = HttpContext.Current.Request.UserHostAddress.ToString();

                string dispatchUsername = "";
                if (HttpContext.Current.Request.Cookies["username"] != null)
                {
                    dispatchUsername = HttpContext.Current.Request.Cookies["username"].Value;
                }

                DbComponent.SQLHelper.ExecuteNonQuery(System.Data.CommandType.StoredProcedure, "WriteLog", new System.Data.SqlClient.SqlParameter("fun", (int)strFun), new System.Data.SqlClient.SqlParameter("userid", strUserid), new System.Data.SqlClient.SqlParameter("strLogtype", (int)strLogtype), new System.Data.SqlClient.SqlParameter("strModule", (int)strModule), new System.Data.SqlClient.SqlParameter("strOpertype", (int)strOpertype), new System.Data.SqlClient.SqlParameter("strContent", strContent), new System.Data.SqlClient.SqlParameter("dispatchIssi", dispatchIssi), new System.Data.SqlClient.SqlParameter("dispatchIp", dispatchIp), new System.Data.SqlClient.SqlParameter("dispatchUsername", dispatchUsername), new System.Data.SqlClient.SqlParameter("IdentityDeviceType", (int)strIdentityDeviceType));
            }
        }


        /// <summary>
        /// 判断用户是否有权限保存
        /// </summary>
        /// <param name="operType"></param>
        /// <returns></returns>
        public static bool isHavaPression(OperateLogOperType operType)
        {
            bool b_result = false;
            int code = (int)operType;
            if (dicOper.Where(a => a == code.ToString()).Count()>0) {
                b_result = true;
            }

            return b_result;
        }

        /// <summary>
        /// 判断用户是否有权限保存
        /// Ajax传值用此方法判断
        /// </summary>
        /// <param name="code">0，1，2，3</param>
        /// <returns></returns>
        public static bool isHavaPression(string code)
        {
            bool b_result = false;
         
            if (dicOper.Where(a => a == code.ToString()).Count() > 0)
            {
                b_result = true;
            }

            return b_result;
        }
        
        /// <summary>
        /// 全局变量 存放配置项开关值
        /// </summary>
        public  static IList<string> dicOper = new List<string>();

        /// <summary>
        /// 加载配置文件logconfig.xml中有权限数据
        /// </summary>
        /// <param name="xmlUrl"></param>
        public static void getLogPression(string xmlUrl)
        {
            dicOper.Clear();//移除所有的

            XmlDocument xmlDoc = new XmlDocument();
            string strFileName = xmlUrl;
            xmlDoc.Load(strFileName);
            XmlElement root = xmlDoc.SelectSingleNode("logconfig") as XmlElement;//查找

            if (root.GetAttribute("open") == "1")
            {
                if (root.Name == "logoper")
                {
                    dicOper.Add(root.GetAttribute("value"));
                }
            }

            DG(root);
        }

        private static void DG(XmlElement root)
        {

            foreach (XmlNode node in root.ChildNodes)
            {

                XmlElement eletem = node as XmlElement;
                if (eletem != null)
                {

                    if (eletem.GetAttribute("open") == "1")
                    {
                        if (eletem.Name == "logoper")
                        {
                            dicOper.Add(eletem.GetAttribute("value"));
                        }
                    }
                    DG(eletem);

                }
            }

        }
    }
}
