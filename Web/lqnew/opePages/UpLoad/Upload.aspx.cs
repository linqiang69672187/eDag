using DbComponent;
using System;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace Web.Demo
{
    public partial class Upload : System.Web.UI.Page
    {
        protected HtmlInputFile UP_FILE; //HtmlControl、WebControls控件对象 
        protected TextBox txtDescription;
        protected Label txtMessage;
        protected Int32 FileLength = 0; //记录文件长度变量 

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button_Submit(object sender, EventArgs e)
        {
            HttpPostedFile UpFile = UP_FILE.PostedFile; //HttpPostedFile对象，用于读取图象文件属性 
            FileLength = UpFile.ContentLength; //记录文件长度 
           try { 
                    if (FileLength == 0) { //文件长度为零时 
                     txtMessage.Text = "<b>请你选择你要上传的文件</b>"; 
                   } else { 
                        Byte[] FileByteArray = new Byte[FileLength]; //图象文件临时储存Byte数组 
                        Stream StreamObject = UpFile.InputStream; //建立数据流对像 //读取图象文件数据，FileByteArray为数据储存体，0为数据指针位置、FileLnegth为数据长度 
                        StreamObject.Read(FileByteArray,0,FileLength);
                        int count = int.Parse(SQLHelper.ExecuteScalar(CommandType.Text, "select count(id) from [Images] where name =@name ", new SqlParameter("name", "MapBackPic")).ToString());
                        if (count == 0) {
                            SQLHelper.ExecuteNonQuery(CommandType.Text, "INSERT [Images] ([name],[ImageData],[ImageContentType],[ImageSize] ) VALUES (@name,@ImageData,@ImageContentType,@ImageSize)", new SqlParameter("name", "MapBackPic"), new SqlParameter("ImageData", FileByteArray), new SqlParameter("ImageContentType", UpFile.ContentType), new SqlParameter("ImageSize", UpFile.ContentType));
                        }
                        else
                        {
                            SQLHelper.ExecuteNonQuery(CommandType.Text, "update [Images] set [ImageData]=@ImageData,[ImageContentType]=@ImageContentType where name=@name", new SqlParameter("name", "MapBackPic"), new SqlParameter("ImageData", FileByteArray), new SqlParameter("ImageContentType", UpFile.ContentType));           
                        }

                      

                       txtMessage.Text = "<p><b>OK!你已经成功上传你的图片</b>";//提示上传成功 
                 } 
                 } catch (Exception ex) { 
               txtMessage.Text = ex.Message.ToString(); 
               }
        }
    }
}