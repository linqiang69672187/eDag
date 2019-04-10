using Ryu666.Components;
using System;
using System.Collections.Generic;
using System.Text;
using System.Text.RegularExpressions;
using System.Web.UI;
namespace Web.lqnew.opePages.LogView
{
    public partial class view_OperationLog : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack&&Request.QueryString["id"]!=null)
            {
                Int32 id = Convert.ToInt32(Request.QueryString["id"]);

                String None = ResourceManager.GetString("Lang-None");

                DbComponent.LogInfo log = new DbComponent.LogInfo();
                IList<Object> objlist = new List<object>();
                log.GetOperationLog(ref objlist, id);

                //for (int i = 0; i < tb1.Rows.Count; i++)
                //{
                //    tb1.Rows[i].Cells[1].InnerText = objlist[i].ToString();
                //}
                tb1.Rows[0].Cells[1].InnerText = objlist[0].ToString();
                tb1.Rows[1].Cells[1].InnerText = objlist[1].ToString();
                tb1.Rows[2].Cells[1].InnerText = objlist[2].ToString();
                tb1.Rows[3].Cells[1].InnerText = objlist[3].ToString();
                tb1.Rows[4].Cells[1].InnerText = objlist[4].ToString();
                tb1.Rows[5].Cells[1].InnerText = Ryu666.Components.ResourceManager.GetString("OperateLogIdentityDeviceType" + objlist[5].ToString());
                tb1.Rows[6].Cells[1].InnerText = objlist[6].ToString();
                tb1.Rows[7].Cells[1].InnerText = objlist[7].ToString();
                tb1.Rows[8].Cells[1].InnerText = objlist[8].ToString();
                tb1.Rows[9].Cells[1].InnerText = objlist[9].ToString();
                tb1.Rows[10].Cells[1].InnerText = objlist[10].ToString();
                tb1.Rows[11].Cells[1].InnerText = Ryu666.Components.ResourceManager.GetString("Module" + objlist[11].ToString());
                tb1.Rows[12].Cells[1].InnerText = Ryu666.Components.ResourceManager.GetString("OperateLogOperType" + objlist[12].ToString());
                StringBuilder sb=new StringBuilder(objlist[13].ToString());
                Int32 index = sb.ToString().IndexOf(";");
                if (index > 0)
                {
                    ParseObjects(ref sb, sb);
                    tb1.Rows[13].Cells[1].InnerText = sb.ToString();
                }
                else
                    tb1.Rows[13].Cells[1].InnerText = Ryu666.Components.ResourceManager.GetString(sb.ToString());
            }
        }

        private void ParseObjects(ref StringBuilder sb, StringBuilder source)
        {
            String[] value = source.ToString().Split(';');
            Regex regex =new Regex(@"\w+:\w+");
            sb.Clear();
            foreach(var c in value)
            {
                switch (regex.Match(c).Success)
                { 
                    case true:
                        value = c.Split(':');
                        sb.AppendFormat("{0}:{1} \r\n", Ryu666.Components.ResourceManager.GetString(value[0]), value[1], Environment.NewLine);
                        break;
                    default:
                        sb.AppendFormat("{0} \r\n", Ryu666.Components.ResourceManager.GetString(c), Environment.NewLine);
                        break;
                }
            } 
        }
    }
}