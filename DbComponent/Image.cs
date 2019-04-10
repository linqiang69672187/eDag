﻿using System;
using System.IO;
using System.Web.UI;
namespace DbComponent
{
    public class Image
    {
        public void Fengepics(string FromWebfilepath, string ToWebfilepath, string picname, Page p, double adjust)
        {          
            string webpicpath = FromWebfilepath + @"\" + picname;
            string webFilePath = p.Server.MapPath(webpicpath); // 服务器端文件路径 
            for (int i = 3; i <= 10; i++)
            {
                string webFilePathfile = p.Server.MapPath(ToWebfilepath + @"\" + i);
                if (!Directory.Exists(webFilePathfile))
                {
                    Directory.CreateDirectory(webFilePathfile);
                }
                string webFilePath_s = p.Server.MapPath(ToWebfilepath + @"\" + i + @"\" + picname);
                if (File.Exists(webFilePath_s))
                {
                    File.Delete(webFilePath_s);
                }
                int adjustint = Int32.Parse((4 * i * adjust).ToString());
                MakeThumbnail(webFilePath, webFilePath_s,adjustint, 92, "W"); // 生成缩略图方法
            }
        }
        public static void MakeThumbnail(string originalImagePath, string thumbnailPath, int width, int height, string mode)
        {
            System.Drawing.Image originalImage = System.Drawing.Image.FromFile(originalImagePath);

            int towidth = width;
            int toheight = height;

            int x = 0;
            int y = 0;
            int ow = originalImage.Width;
            int oh = originalImage.Height;

            switch (mode)
            {
                case "HW"://指定高宽缩放（可能变形） 
                    break;
                case "W"://指定宽，高按比例 
                    toheight = originalImage.Height * width / originalImage.Width;
                    break;
                case "H"://指定高，宽按比例 
                    towidth = originalImage.Width * height / originalImage.Height;
                    break;
                case "Cut"://指定高宽裁减（不变形） 
                    if ((double)originalImage.Width / (double)originalImage.Height > (double)towidth / (double)toheight)
                    {
                        oh = originalImage.Height;
                        ow = originalImage.Height * towidth / toheight;
                        y = 0;
                        x = (originalImage.Width - ow) / 2;
                    }
                    else
                    {
                        ow = originalImage.Width;
                        oh = originalImage.Width * height / towidth;
                        x = 0;
                        y = (originalImage.Height - oh) / 2;
                    }
                    break;
                default:
                    break;
            }

            //新建一个bmp图片 
            System.Drawing.Image bitmap = new System.Drawing.Bitmap(towidth, toheight);

            //新建一个画板 
            System.Drawing.Graphics g = System.Drawing.Graphics.FromImage(bitmap);

            //设置高质量插值法 
            g.InterpolationMode = System.Drawing.Drawing2D.InterpolationMode.High;

            //设置高质量,低速度呈现平滑程度 
            g.SmoothingMode = System.Drawing.Drawing2D.SmoothingMode.HighQuality;

            //清空画布并以透明背景色填充 
            g.Clear(System.Drawing.Color.Transparent);

            //在指定位置并且按指定大小绘制原图片的指定部分 
            g.DrawImage(originalImage, new System.Drawing.Rectangle(0, 0, towidth, toheight),
            new System.Drawing.Rectangle(x, y, ow, oh),
            System.Drawing.GraphicsUnit.Pixel);
           


            try
            {
                //以jpg格式保存缩略图 
                bitmap.Save(thumbnailPath, System.Drawing.Imaging.ImageFormat.Png);
               
               
            }
            catch (System.Exception e)
            {
                throw e;
            }
            finally
            {
                originalImage.Dispose();
                bitmap.Dispose();
                g.Dispose();
            }
        }
    }
}
