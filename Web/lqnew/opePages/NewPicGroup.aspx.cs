using Ryu666.Components;
using System;
using System.IO;
using System.Reflection;
using System.Web.UI;

namespace Web.lqnew.opePages
{
    public partial class NewPicGroup : System.Web.UI.Page
    {
        private static readonly log4net.ILog log = log4net.LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            { }
            submitToS.ImageUrl = Ryu666.Components.ResourceManager.GetString("LangConfirm");
        }


        protected void changeImageSize(string originalImagePath, string destImagePath)
        {
            //string currentPath = Directory.
            //Directory.GetDirectories(Server.MapPath(originalImagePath));
            System.Drawing.Image originalImage = System.Drawing.Image.FromFile(this.Server.MapPath(originalImagePath));
            System.Drawing.Image bitmap = new System.Drawing.Bitmap(64, 64);
            System.Drawing.Graphics g = System.Drawing.Graphics.FromImage(bitmap);
            g.InterpolationMode = System.Drawing.Drawing2D.InterpolationMode.High;
            g.SmoothingMode = System.Drawing.Drawing2D.SmoothingMode.HighQuality;
            g.Clear(System.Drawing.Color.Transparent);
            g.DrawImage(originalImage, new System.Drawing.Rectangle(0, 0, 64, 64),
            new System.Drawing.Rectangle(0, 0, 64, 64),
            System.Drawing.GraphicsUnit.Pixel);
            bitmap.Save(this.Server.MapPath(destImagePath), System.Drawing.Imaging.ImageFormat.Png);
            originalImage.Dispose();
            bitmap.Dispose();
            g.Dispose();
        }



        protected void ImageButton_Click(object sender, ImageClickEventArgs e)
        {
            try
            {
                if (!Directory.Exists(this.Server.MapPath(@"UpLoad")))
                {
                    Directory.CreateDirectory(this.Server.MapPath(@"UpLoad"));
                }
                if (!Directory.Exists(this.Server.MapPath(@"UpLoad\usertypepic")))
                {
                    Directory.CreateDirectory(this.Server.MapPath(@"UpLoad\usertypepic"));
                }

                //判断文件夹是否已经存在
                String[] str = Directory.GetDirectories(this.Server.MapPath(@"UpLoad\usertypepic"));
                foreach (string s in str)
                {
                    if (Path.GetFileName(s) == txtPicGroupName.Text.Trim())
                    {
                        Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("PicGroupNameIsExist") + "')</script>");//多语言：PicGroupNameIsExist
                        return;
                    }
                }

                Directory.CreateDirectory(Server.MapPath(@"UpLoad\usertypepic\" + txtPicGroupName.Text.Trim()));
                if (NormalFile.HasFile && UnNormalFile.HasFile)
                {
                    if (NormalFile.PostedFile.ContentLength < 1048576)//小于1mb
                    {
                        NormalFile.PostedFile.SaveAs(Server.MapPath(@"UpLoad\usertypepic\" + txtPicGroupName.Text.Trim() + @"\1.png"));
                        //处理图片生成小图像 用于显示选择结果

                        changeImageSize(@"UpLoad\usertypepic\" + txtPicGroupName.Text.Trim() + @"\1.png", @"UpLoad\usertypepic\" + txtPicGroupName.Text.Trim() + @"\3.png");
                      
                        //____________________________________
                    }
                    else
                    {
                        Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("NormalPicLargerThanOneMBPleaseCHooseAnother") + "');</script>");//多语言：正常状态图标大于1mb，请重新选择
                        string[] files = Directory.GetFiles(Server.MapPath(@"UpLoad\usertypepic\" + txtPicGroupName.Text.Trim()));
                        foreach (string filename in files)
                        {
                            File.Delete(filename);
                            log.Error(filename);
                        }
                        Directory.Delete(Server.MapPath(@"UpLoad\usertypepic\" + txtPicGroupName.Text.Trim()));
                        return;
                    }

                    if (UnNormalFile.PostedFile.ContentLength < 1048576)//小于1mb
                    {
                        UnNormalFile.PostedFile.SaveAs(Server.MapPath(@"UpLoad\usertypepic\" + txtPicGroupName.Text.Trim() + @"\2.png"));
                    }
                    else
                    {
                        Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("UnNormalPicLargerThanOneMBPleaseCHooseAnother") + "');</script>");//多语言：不正常状态图标大于1mb，请重新选择
                        string[] files = Directory.GetFiles(Server.MapPath(@"UpLoad\usertypepic\" + txtPicGroupName.Text.Trim()));
                        foreach (string filename in files)
                        {
                            File.Delete(filename);
                            log.Error(filename);
                        }
                        Directory.Delete(Server.MapPath(@"UpLoad\usertypepic\" + txtPicGroupName.Text.Trim()));
                        return;
                    }

                }
                else
                {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("UpLoadFailPleaseChooseAnother") + "');</script>");//多语言：上传失败，请重新上传
                    string[] files = Directory.GetFiles(Server.MapPath(@"UpLoad\usertypepic\" + txtPicGroupName.Text.Trim()));
                    foreach (string filename in files)
                    {
                        File.Delete(filename);
                        log.Error(filename);
                    }
                    Directory.Delete(Server.MapPath(@"UpLoad\usertypepic\" + txtPicGroupName.Text.Trim()));
                    return;
                }
                Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("AddSucc") + "');window.parent.hiddenbg2();window.parent.frames['SelUserTypePic_ifr'].AfterNewPicGoup('" + txtPicGroupName.Text.Trim() + "');window.parent.mycallfunction(geturl());</script>");//多语言：添加成功
            }
            catch (Exception ex)
            {
                log.Error(ex);
                Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("UpLoadFailPleaseChooseAnother") + "');</script>");//多语言：上传失败，请重新上传
            }
        }
    }
}