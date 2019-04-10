using DbComponent;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Web.lqnew.opePages.UpLoad
{
    public partial class ReadImage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
       string Imgname = Server.UrlDecode(Request.QueryString["name"]); //ImgID为图片 
       string type = (Request.QueryString["type"]); //ImgID为图片 
       //建立数据库链接 
       DataTable dt = SQLHelper.ExecuteRead(CommandType.Text, "select  * from [images] where name =@Imgname and type=@type", "logininfo", new SqlParameter("Imgname", Imgname), new SqlParameter("type", type));
      if (dt.Rows.Count > 0) { 
      Response.ContentType = (string)dt.Rows[0][3].ToString(); ;//设定输出文件类型 
      //输出图象文件二进制数制 
      Response.OutputStream.Write((byte[])dt.Rows[0][2], 0, (int)dt.Rows[0][4]); 
        }
      else
      {
          Response.Redirect("nopic.png");
      }
      Response.End(); 


        }
    }
}