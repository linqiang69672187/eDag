using Ryu666.Components;
using System;
using System.IO;
using System.Linq;
using System.Text;

namespace Web.lqnew.opePages
{
    public partial class SelUserTypePic : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!Directory.Exists(this.Server.MapPath(@"UpLoad")))
            {
                Directory.CreateDirectory(this.Server.MapPath(@"UpLoad"));
            }
            if (!Directory.Exists(this.Server.MapPath(@"UpLoad\usertypepic")))
            {
                Directory.CreateDirectory(this.Server.MapPath(@"UpLoad\usertypepic"));
            }

            StringBuilder sb = new StringBuilder("<table  class=\"style1\" cellspacing=\"1\">");

            String[] str = Directory.GetDirectories(this.Server.MapPath(@"UpLoad\usertypepic")).OrderBy(a => a).ToArray();
            sb.Append("<tr>");
            sb.Append("<td align='center'></td>");
            sb.Append("<td align='center'>" + ResourceManager.GetString("zczttb") + "</td>");//多语言：正常状态图标
            //sb.Append("<td align='center'>" + ResourceManager.GetString("jjhjzttb") + "</td>");//多语言：jjhjzttb紧急呼叫状态图标
            //sb.Append("<td align='center'>" + ResourceManager.GetString("bzczttb") + "</td>");//多语言：bzczttb不正常状态图标

            sb.Append("<td align='center'>" + ResourceManager.GetString("Operater") + "</td>");//多语言：操作
            sb.Append("</tr>");

            foreach (string s in str)
            {
                sb.Append("<tr>");
                sb.Append("<td align='center;'>");
                sb.Append("<input type='radio' name='usertypepic' value='" + Path.GetFileName(s) + "' />");
                sb.Append("</td>");
                for (int i = 3; i <= 3; i++) {
                    sb.Append("<td align='center'>");
                    sb.Append("<img style='width:64px;height:64px' src='UpLoad\\usertypepic\\" + Path.GetFileName(s) + "\\" + i + ".png' /> &nbsp;&nbsp;");
                    sb.Append("</td>");
                }

                //String[] myfiles = Directory.GetFiles(s).OrderBy(a => a).ToArray();
                //foreach (string f in myfiles)
                //{
                //    sb.Append("<td align='center'>");
                //    sb.Append("<img style='width:15px;height:25px' src='UpLoad\\usertypepic\\" + Path.GetFileName(s) + "\\" + Path.GetFileName(f) + "' /> &nbsp;&nbsp;");
                //    sb.Append("</td>");
                  
                //}
                sb.Append("<td align='center'><img title='" + ResourceManager.GetString("Delete") + "' onclick='deletePic(\"" + Path.GetFileName(s) + "\")' src='images/083.gif' /></td>");//多语言：删除 
                sb.Append("</tr>");
            }
            sb.Append("</table>");
            labUserTypePic.Text = sb.ToString();
        }
    }
}