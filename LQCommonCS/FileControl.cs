using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using System.Security.AccessControl;

namespace LQCommonCS
{
    public class FileControl
    {
        #region 获取文件夹大小
        public long fileinfo(string dirpath)
        {
            long w = 0;

            string[] filelist = System.IO.Directory.GetFileSystemEntries(dirpath);
            foreach (string file in filelist)
            {
                if (System.IO.Directory.Exists(file))
                {
                    fileinfo(file);
                }
                else
                {
                    FileInfo filinfo = new FileInfo(file);
                    w += filinfo.Length;
                }
            }

            return w;
        }
        #endregion

        #region 获取文件内容
        public string[] getFileContent(string filePath)
        {
            AddFileSecurity(filePath);
            string ReadNewDftstring = string.Empty;
            using (StreamReader sr = new StreamReader(filePath))
            {
                ReadNewDftstring = sr.ReadToEnd();
                sr.Close();
            }
            string[] FileReadline = System.Text.RegularExpressions.Regex.Split(ReadNewDftstring, "\r\n");
            return FileReadline;

        }
        #endregion

        #region 判断文件是否为图片格式
        public bool isImg(string FileName)
        {
            string[] extendFileName = { ".jpeg", ".jpg", ".gif", ".bmp", ".BMP", ".JPEG", ".JPG", ".GIF", ".png", ".PNG" };
            string[] arr = FileName.Split('.');
            if (arr.Length == 0)
                return false;
            string cjm = "." + arr[arr.Length - 1];
            bool isimg = false;
            if (arr.Length == 2)
                for (int j = 0; j < extendFileName.Length && !isimg; j++)
                {
                    if (cjm == extendFileName[j])
                        isimg = true;
                }
            return isimg;
        }
        #endregion

        #region 添加文件权限
        public void AddFileSecurity(string FileName)
        {
            if (System.IO.File.Exists(FileName))
            {
                System.IO.File.SetAttributes(FileName, System.IO.FileAttributes.Normal);
                FileInfo dInfo = new FileInfo(FileName);
                FileSecurity fileSecurity = dInfo.GetAccessControl();
                fileSecurity.AddAccessRule(new FileSystemAccessRule(@"Everyone", FileSystemRights.FullControl, AccessControlType.Allow));
                dInfo.SetAccessControl(fileSecurity);
            }
        }
        #endregion

    }
}
