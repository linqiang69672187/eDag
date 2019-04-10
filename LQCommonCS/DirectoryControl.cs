using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using System.Security.AccessControl;

namespace LQCommonCS
{
   public class DirectoryControl
    {
      // private Language showLanguage = new Language();
        private FileControl fileControl = new FileControl();

        #region 添加文件夹权限
        public void AddDirectorySecurity(string dirName)
        {
            if (System.IO.Directory.Exists(dirName))
            {
                DirectoryInfo dInfo = new DirectoryInfo(dirName);
                DirectorySecurity dSecurity = dInfo.GetAccessControl();
                dSecurity.AddAccessRule(new FileSystemAccessRule(@"Everyone", FileSystemRights.FullControl, AccessControlType.Allow));
                dInfo.SetAccessControl(dSecurity);
            }
        }
        #endregion

        #region 删除文件夹
        public void DeleteFolder(string dir)
        {
            try
            {
                string[] strFiles = Directory.GetFiles(dir);
                string[] strDirs = Directory.GetDirectories(dir);
                int fileCount = strFiles.Length;
                for (int i = 0; i < fileCount; i++)
                {
                   // System.IO.File.SetAttributes(strFiles[i], FileAttributes.Normal);
                    fileControl.AddFileSecurity(strFiles[i]);
                }

                int dirCount = strDirs.Length;
                if (dirCount > 0)
                {
                    for (int i = 0; i < dirCount; i++)
                    {
                        System.IO.DirectoryInfo DirInfo = new DirectoryInfo(strDirs[i]);
                        DirInfo.Attributes = FileAttributes.Normal & FileAttributes.Directory;
                    }
                }

                if (Directory.Exists(dir)) //如果存在这个文件夹删除之 
                {
                    foreach (string d in Directory.GetFileSystemEntries(dir))
                    {
                        if (System.IO.File.Exists(d))
                        {
                            fileControl.AddFileSecurity(d);
                            System.IO.File.Delete(d); //直接删除其中的文件 
                        }
                        else
                            DeleteFolder(d); //递归删除子文件夹 
                    }
                    Directory.Delete(dir); //删除已空文件夹 
                }
                //else
                //{
                //    System.Windows.MessageBox.Show(dir + showLanguage.Updatelanguage(language, 37)); //如果文件夹不存在则提示 
                //}
            }
            catch (Exception er)
            {
                //System.Windows.MessageBox.Show("***********" + er.Message);
            }
        }
        #endregion

        #region 文件夹复制
        public void CopyDirectory(string srcdir, string desdir)
        {
            try
            {
                if (!Directory.Exists(srcdir))
                    return;
                if (!Directory.Exists(desdir))
                    return;

                string sourceFolderName = srcdir.Replace(Directory.GetParent(srcdir).ToString(), "").Replace(System.IO.Path.DirectorySeparatorChar.ToString(), "");

                if (srcdir == desdir + sourceFolderName)
                    return;

                //要复制到的路径 
                string tagetPath = desdir + System.IO.Path.DirectorySeparatorChar.ToString() + sourceFolderName;
                if (Directory.Exists(tagetPath))
                {
                    Directory.Delete(tagetPath, true);
                }

                Directory.CreateDirectory(tagetPath);

                //复制文件 
                string[] files = Directory.GetFiles(srcdir);
                for (int i = 0; i < files.Length; i++)
                {
                    fileControl.AddFileSecurity(files[i]);
                    System.IO.File.Copy(files[i], tagetPath + System.IO.Path.DirectorySeparatorChar.ToString() + System.IO.Path.GetFileName(files[i]), true);
                }
                //复制目录 
                string[] dires = Directory.GetDirectories(srcdir);
                for (int j = 0; j < dires.Length; j++)
                {
                    CopyDirectory(dires[j], tagetPath);
                }
            }
            catch (Exception er)
            {
                //System.Windows.MessageBox.Show(er.Message.ToString() + "\r\n" + "::::::::Copy Directory Error!");
                //Environment.Exit(0);
            }
        }
        #endregion
    }
}
