using DbComponent;
using Ryu666.Components;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Web.WebGis.Service
{
    public partial class getTypePictureLoadPath : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {          
          

            StringBuilder sb = new StringBuilder();
          //  String id = Request.QueryString["id"];
           // String ISSI = "";
            DataTable dt = SQLHelper.ExecuteRead(CommandType.Text, "SELECT distinct TypeName FROM UserType", "getType");
            sb.Append(DbComponent.Comm.TypeConverter.DataTable2ArrayJson(dt));
            //for (int countdt = 0; countdt < dt.Rows.Count; countdt++)
            //{
            //  sb.Append(dt.Rows[countdt][0].ToString());
            //  sb.Append("|");
            //}
            Response.Write(sb);
            Response.End();                  
        }
    }
}