using DbComponent;
using System;
using System.Data;
using System.Text;

namespace Web.WebGis.Service
{
    public partial class getvaluebyuseids : System.Web.UI.Page
    {
        int intvalue = 0;
        protected void Page_Load(object sender, EventArgs e)
        {

            StringBuilder sb = new StringBuilder();
            string ids = "";
            sb.Append("[");
            if (Request.QueryString["id"].Trim() != "")  /**民警1(1000);民警2(1000);**/
            {
                string[] id = Request.QueryString["id"].Trim().Split(';');
                int intdb = 0;
                for (int i = 0; i < id.Length; i++)
                {
                    if (id[i].IndexOf(Ryu666.Components.ResourceManager.GetString("Unkown")) > -1)
                    {
                        if (intvalue > 0) { sb.Append(","); }
                        sb.Append(insertweizhi(id[i].Substring(id[i].IndexOf('(') + 1).Replace(')', ' ').Trim()));
                        intvalue += 1;
                    }
                    else
                    {
                        if (intdb > 0)
                        {
                            ids += ",";
                        }
                        ids += "'" + id[i].Substring(id[i].IndexOf('(') + 1).Replace(')', ' ').Trim() + "'";
                        intdb += 1;
                    }
                }
                DataTable dt = SQLHelper.ExecuteRead(CommandType.Text, "SELECT (select [Name] from [Entity] where ID=a.[Entity_ID]),a.[type],a.[id],a.[Nam],a.[ID] FROM [User_info] a where [id] in (" + ids + ")", "pc");
                for (int countdt = 0; countdt < dt.Rows.Count; countdt++)
                {
                    if (intvalue > 0) { sb.Append(","); }
                    sb.Append("{ \"entity\":\"" + dt.Rows[countdt][0] + "\", \"type\":\"" + dt.Rows[countdt][1] + "\", \"ISSI\":\"" + dt.Rows[countdt][2] + "\", \"name\":\"" + dt.Rows[countdt][3] + "\", \"id\":\"" + dt.Rows[countdt][4] + "\", \"SQLType\":\"use_info\"}");
                    intvalue += 1;
                }
            }
            sb.Append("]");
            Response.Write(sb);
            Response.End();
        }

        private string insertweizhi(string issi)
        {
            return "{ \"entity\":\"" + Ryu666.Components.ResourceManager.GetString("Unkown") + "\", \"type\":\"" + Ryu666.Components.ResourceManager.GetString("Unkown") + "\", \"ISSI\":\"" + issi + "\", \"name\":\"" + Ryu666.Components.ResourceManager.GetString("Unkown") + "\", \"id\":\"0\", \"SQLType\":\"use_info\"}";
        }
    }
}