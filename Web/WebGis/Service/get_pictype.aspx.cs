using DbComponent;
using System;
using System.Data;
using System.Text;

namespace Web.WebGis.Service
{
    public partial class get_pictype : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            StringBuilder sb = new StringBuilder();
            DataTable dt1 = SQLHelper.ExecuteRead(CommandType.Text, "SELECT  [TypeName] ,[TypeIcons] FROM [UserType] ", "Entity");
            sb.Append("[");
            for (int countdt1 = 0; countdt1 < dt1.Rows.Count; countdt1++)
            {
                if (countdt1 != 0)
                {
                    sb.Append(",{\"name\":\"");
                }
                else
                {
                    sb.Append("{\"name\":\"");
                }
                sb.Append(dt1.Rows[countdt1][0].ToString());
                sb.Append("\",\"loc\":\"");
                sb.Append(dt1.Rows[countdt1][1].ToString());
                sb.Append("\"}");
            }
            sb.Append("]");
            Response.Write(sb);

            Response.End();
        }
    }
}