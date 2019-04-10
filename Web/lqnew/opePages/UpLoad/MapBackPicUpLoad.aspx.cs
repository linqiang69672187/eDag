using DbComponent;
using Ryu666.Components;
using System;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI;

namespace Web.lqnew.opePages.UpLoad
{
    public partial class MapBackPicUpLoad : BasePage
    {
        protected Int32 FileLength = 0; //记录文件长度变量 

        protected void Page_Load(object sender, EventArgs e)
        {
            submitToS.Text = ResourceManager.GetString("Lang_Upload");
        }

        protected void ImageButton_Click(object sender, EventArgs e)
        {

            try
            {

                if (!Directory.Exists(this.Server.MapPath(@"UpLoad")))
                {
                    Directory.CreateDirectory(this.Server.MapPath(@"UpLoads"));
                }

                if (EntityPicFile.HasFile)
                {
                    string Lang_PicTooLarge = ResourceManager.GetString("Lang_PicTooLarge");
                    string Uploadfailed = ResourceManager.GetString("Uploadfailed");

                    if (EntityPicFile.PostedFile.ContentLength < 1048576 && EntityPicFile.PostedFile.ContentLength > 0)//小于1mb
                    {
                        FileLength = EntityPicFile.PostedFile.ContentLength; //记录文件长度 
                        Byte[] FileByteArray = new Byte[FileLength]; //图象文件临时储存Byte数组 
                        Stream StreamObject = EntityPicFile.PostedFile.InputStream; //建立数据流对像 //读取图象文件数据，FileByteArray为数据储存体，0为数据指针位置、FileLnegth为数据长度 
                        StreamObject.Read(FileByteArray, 0, FileLength);
                        string name = Request.QueryString["name"];
                        int count = int.Parse(SQLHelper.ExecuteScalar(CommandType.Text, "select count(id) from [Images] where name =@name and type='MapBackPic'", new SqlParameter("name", name)).ToString());
                        if (count == 0)
                        {
                            SQLHelper.ExecuteNonQuery(CommandType.Text, "INSERT [Images] ([name],[ImageData],[ImageContentType],[ImageSize],[type] ) VALUES (@name,@ImageData,@ImageContentType,@ImageSize,@type)", new SqlParameter("name", name), new SqlParameter("ImageData", FileByteArray), new SqlParameter("ImageContentType", EntityPicFile.PostedFile.ContentType), new SqlParameter("ImageSize", FileLength), new SqlParameter("type", "MapBackPic"));
                        }
                        else
                        {
                            SQLHelper.ExecuteNonQuery(CommandType.Text, "update [Images] set [ImageData]=@ImageData,[ImageContentType]=@ImageContentType,[ImageSize]=@ImageSize where name=@name and type=@type", new SqlParameter("name", name), new SqlParameter("ImageData", FileByteArray), new SqlParameter("ImageContentType", EntityPicFile.PostedFile.ContentType), new SqlParameter("ImageSize", FileLength), new SqlParameter("type","MapBackPic"));
                        }
                      //  EntityPicFile.PostedFile.SaveAs(Server.MapPath(@"../../../WebGis/images/preloadImg.png"));
                        Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>StrOver('" + EntityPicFile.FileName + "')</script>");
                    }
                    else
                    {
                        //Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('图片大于1mb，请重新选择');StrOver('上传失败')</script>");
                        Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + Lang_PicTooLarge + "');StrOver('" + Uploadfailed + "')</script>");

                        return;
                    }
                }
                else
                {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("Lang_ZeroPic") + "');StrOver('UploadFail')</script>");
                    return;
                }
            }
            catch (Exception ex)
            {
                log.Debug(ex);
                // Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('上传图片失败，请重新上传');StrOver('上传失败')</script>");
                Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("Lang_PicUploadFailed") + "');StrOver('" + ResourceManager.GetString("Uploadfailed") + "')</script>");

            }
        }
    }
}