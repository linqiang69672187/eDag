using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;

namespace Web
{
    /// <summary>
    /// Ajax传值，设置logconfig.xml文件中节点值
    /// </summary>
    public partial class SavaLogConfig : System.Web.UI.Page
    {
        private static readonly log4net.ILog log = log4net.LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);
        public bool findFromArray(string val, string[] strs)
        {
            bool flag = strs.Where(a => a.ToString() == val).Count() > 0;

            return flag;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            string strPrama = Request["result"].ToString();
            string[] arrp = strPrama.Split(new char[] { ';' }, StringSplitOptions.RemoveEmptyEntries);

            XmlDocument xmlDoc = new XmlDocument();
            string strFileName = Server.MapPath("../../../" + System.Configuration.ConfigurationManager.AppSettings["logconfigpath"].ToString());
            xmlDoc.Load(strFileName);
            XmlElement root = xmlDoc.SelectSingleNode("logconfig") as XmlElement;//
            if (findFromArray(root.GetAttribute("name"), arrp))
            {
                root.SetAttribute("open", "1");
            }
            else
            {
                root.SetAttribute("open", "0");
            }
            DG(root, arrp);
           
            try
            {
                xmlDoc.Save(strFileName);
                Response.Write("1");
            }
            catch (Exception ex)
            {
                Response.Write("0");
                log.Error(ex.Message);
            }

        }

        /// <summary>
        /// 递归赋值，将已选节点赋值为1，不选为0
        /// </summary>
        /// <param name="xelectModule">节点</param>
        /// <param name="arrp">已勾选模块集合</param>
        private void DG(XmlElement xelectModule, string[] arrp)
        {
            foreach (XmlNode nodeOper in xelectModule.ChildNodes)
            {
                XmlElement xelectOper = nodeOper as XmlElement;
                if (xelectOper != null)
                {
                    ///判断xml文件中节点是否为已勾选节点
                    if (findFromArray(xelectOper.GetAttribute("name"), arrp))
                    {
                        xelectOper.SetAttribute("open", "1");
                    }
                    else
                    {
                        xelectOper.SetAttribute("open", "0");
                    }
                    DG(xelectOper, arrp);
                }

            }
        }
    }
}