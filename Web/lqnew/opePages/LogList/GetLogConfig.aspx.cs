using Ryu666.Components;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;

namespace Web
{
 

    public partial class GetLogConfig : System.Web.UI.Page
    {


        string strSelectChild = "";

        String strgg = "";

       


     

        private String DG(XmlElement root, String parentID)
        {
            String str1 = "";
            string str = strgg;
            strgg += "----";
            foreach (XmlNode node in root.ChildNodes)
            {

                XmlElement eletem = node as XmlElement;
                if (eletem != null)
                {
                    String ckid = parentID + "_" + eletem.GetAttribute("name");


                    if (eletem.GetAttribute("open") == "1")
                    {

                        //dicTYPE.Add(eletem.GetAttribute("value"));
                        string qxan = "";
                        if (eletem.ChildNodes.Count > 0)
                        {
                            qxan = "<input type='button' onclick='selectChildAll(this)' id='btnselect_" + ckid + "' value='" + strSelectChild + "' />";
                        }
                        else if (eletem.Name == "logoper")
                        {
                            DbComponent.LogModule.SystemLog.dicOper.Add(eletem.GetAttribute("value"));
                        }
                        str1 += "|" + strgg + "<input type='checkbox' onclick='cb_Click(this)' checked='checked' id='" + ckid + "' />" + ResourceManager.GetString(eletem.GetAttribute("name")) + qxan + "<br>";
                    }
                    else
                    {
                        string qxan = "";
                        if (eletem.ChildNodes.Count > 0)
                        {
                            qxan = "<input type='button' onclick='selectChildAll(this)' id='btnselect_" + ckid + "' value='" + strSelectChild + "' />";
                        }

                        str1 += "|" + strgg + "<input type='checkbox' onclick='cb_Click(this)' id='" + ckid + "' />" + ResourceManager.GetString(eletem.GetAttribute("name")) + qxan + "<br>";
                    }
                    str1 += DG(eletem, ckid);

                }
            }
            strgg = str;
            return str1;
        }


        protected void Page_Load(object sender, EventArgs e)
        {

            strSelectChild = Ryu666.Components.ResourceManager.GetString("LangSelectAllChilds");

            DbComponent.LogModule.SystemLog.dicOper.Clear();//移除所有的


            String str = "";

            XmlDocument xmlDoc = new XmlDocument();
            string strFileName = Server.MapPath("../../../"+ System.Configuration.ConfigurationManager.AppSettings["logconfigpath"].ToString());
            xmlDoc.Load(strFileName);
            XmlElement root = xmlDoc.SelectSingleNode("logconfig") as XmlElement;//查找

            if (root.GetAttribute("open") == "1")
            {

                str += "<input type='checkbox' onclick='cb_Click(this)' checked='checked' id='" + root.GetAttribute("name") + "' />" + ResourceManager.GetString(root.GetAttribute("name")) + "<input type='button' onclick='selectAll()' id='btn_" + root.GetAttribute("name") + "' value='" + strSelectChild + "' /><br>";
            }
            else
            {
                str += "<input type='checkbox' onclick='cb_Click(this)'  id='" + root.GetAttribute("name") + "' />" + ResourceManager.GetString(root.GetAttribute("name")) + "<input type='button' onclick='selectAll()' id='btn_" + root.GetAttribute("name") + "' value='" + strSelectChild + "' /><br>";
            }
            str += DG(root, root.GetAttribute("name"));

            //Response.Write(str + "<br>");
            lbContent.Text += str + "<br>";

            foreach (string str1 in DbComponent.LogModule.SystemLog.dicOper)
            {
               // Response.Write(str1 + "<br>");
            }
        }
    }
}