using Ryu666.Components;
using System;
using System.IO;
using System.Text;
using System.Web.UI;

namespace Web.lqnew.opePages.UpLoad
{
    public partial class MyUpLoadExcel : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {


            Page.ClientScript.RegisterStartupScript(Page.GetType(), "LanguageSwitch", "<script>LanguageSwitch(window.dialogArguments);</script>");
            //Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>LanguageSwitch(window.dialogArguments);</script>");

            submitToS.Text = ResourceManager.GetString("Lang_Upload");

        }
        protected void ImageButton_Click(object sender, EventArgs e)
        {
            try
            {
                if (!Directory.Exists(this.Server.MapPath(@"File")))
                {
                    Directory.CreateDirectory(this.Server.MapPath(@"File"));
                }
                if (EntityPicFile.HasFile)
                {

                    if (EntityPicFile.PostedFile.ContentLength < 10485760 && EntityPicFile.PostedFile.ContentLength > 0)//小于10mb
                    {
                        string picname = EntityPicFile.FileName.Substring(0, EntityPicFile.FileName.LastIndexOf("."));
                        //if (!Directory.Exists(Server.MapPath(@"UpLoads\" + picname)))
                        //{
                        //    Directory.CreateDirectory(Server.MapPath(@"UpLoads\" + picname));
                        //}

                        //数据库判断文件是否存在
                        DbComponent.userinfo userFileName = new DbComponent.userinfo();
                        int count=userFileName.getAllFilemergency(EntityPicFile.FileName);

                        if (File.Exists(Server.MapPath(@"File\" + EntityPicFile.FileName)) && count <= 0)
                        {
                            File.Delete(Server.MapPath(@"File\" + EntityPicFile.FileName));

                        }

                        if (File.Exists(Server.MapPath(@"File\" + EntityPicFile.FileName)) || count > 0)
                        {

                            Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("Lang_FileName") + "');</script>");
                            return;
                            //File.Delete(Server.MapPath(@"File\" + EntityPicFile.FileName));
                        }
                        EntityPicFile.PostedFile.SaveAs(Server.MapPath(@"File\" + EntityPicFile.FileName));

                        //分割图片
                        //DbComponent.Image img = new DbComponent.Image();
                        //img.Fengepics(@"UpLoads\" + picname, @"UpLoads\" + picname, EntityPicFile.FileName, this.Page, 1);


                        Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>StrOver('" + EntityPicFile.FileName + "')</script>");
                    }
                    else
                    {
                        Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("Lang_FileTooLarge") + "');StrOver('UploadFail')</script>");
                        return;
                    }
                }
                else
                {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("Lang_ZeroFile") + "');StrOver('UploadFail')</script>");
                    return;
                }
            }
            catch (Exception ex)
            {
                log.Debug(ex);
                Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("Lang_FileUploadFailed") + "');StrOver('UploadFail')</script>");
            }
        }


    }
}