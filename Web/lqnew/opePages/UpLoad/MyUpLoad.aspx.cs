using Ryu666.Components;
using System;
using System.IO;
using System.Web.UI;
namespace Web.lqnew.opePages.UpLoad
{
    public partial class MyUpLoad : BasePage
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
                if (!Directory.Exists(this.Server.MapPath(@"UpLoad")))
                {
                    Directory.CreateDirectory(this.Server.MapPath(@"UpLoads"));
                }
                if (EntityPicFile.HasFile)
                {
                   
                    if (EntityPicFile.PostedFile.ContentLength < 1048576 && EntityPicFile.PostedFile.ContentLength > 0)//小于1mb
                    {
                        string picname = EntityPicFile.FileName.Substring(0, EntityPicFile.FileName.LastIndexOf("."));
                        if (!Directory.Exists(Server.MapPath(@"UpLoads\" + picname)))
                        {
                            Directory.CreateDirectory(Server.MapPath(@"UpLoads\" + picname));
                        }
                        if (File.Exists(Server.MapPath(@"UpLoads\" + picname + @"\" + EntityPicFile.FileName)))
                        {
                            File.Delete(Server.MapPath(@"UpLoads\" + picname + @"\" + EntityPicFile.FileName));
                        }
                        EntityPicFile.PostedFile.SaveAs(Server.MapPath(@"UpLoads\" + picname + @"\" + EntityPicFile.FileName));

                        //分割图片
                        DbComponent.Image img = new DbComponent.Image();
                        img.Fengepics(@"UpLoads\" + picname, @"UpLoads\" + picname, EntityPicFile.FileName, this.Page, 1);


                        Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>StrOver('" + EntityPicFile.FileName + "')</script>");
                    }
                    else
                    {
                        Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("Lang_PicTooLarge") + "');StrOver('UploadFail')</script>");
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
                Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("Lang_PicUploadFailed") + "');StrOver('UploadFail')</script>");
            }
        }
         

    }
}