using DbComponent.FactoryMethod;
using DbComponent.IDAO;
using Ryu666.Components;
using System;
using System.Collections.Generic;
using System.IO;
using System.Reflection;
using System.Web;
using System.Web.SessionState;

namespace Web.Handlers
{
    /// <summary>
    /// DeleteTypePic 的摘要说明
    /// </summary>
    public class DeleteTypePic : IHttpHandler, IReadOnlySessionState
    {
        private static readonly log4net.ILog log = log4net.LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);
        private IUserTypeDao UserTypeDaoService
        {
            get { return DispatchInfoFactory.CreateUserTypeDao(); }
        }

        private Stack<string> undeldirs = new Stack<string>();
        private void DelAllFilesInDirByDirPath(string dirPath)
        {

            string[] files = Directory.GetFiles(dirPath);
            foreach (string filename in files)
            {
                log.Info("fileName:" + filename);
                File.Delete(filename);
                log.Error(filename);
            }
            string[] dirs = Directory.GetDirectories(dirPath);

            undeldirs.Push(dirPath);
            foreach (string dir in dirs)
            {
                DelAllFilesInDirByDirPath(dir);
            }


        }
        private void delDir()
        {
            while (true)
            {
                if (undeldirs.Count <= 0)
                {
                    break;
                }
               
                if (Directory.GetFiles(undeldirs.Peek()).Length <= 0 && Directory.GetFiles(undeldirs.Peek()).Length <= 0)
                {
                    string dir = undeldirs.Pop();
                    log.Info("dirName:" + dir);
                    Directory.Delete(dir);
                }
                
            }
            
        }
        public void ProcessRequest(HttpContext context)
        {
            string strWriter = "";
            string StrPicName = context.Request["picname"].ToString();
            if (UserTypeDaoService.PicIsUsed(StrPicName))
            {
                strWriter = "{\"message\":\"" + ResourceManager.GetString("Lang_ThisTypePicIsUsingByUserType") + "\"}";//多语言:此类型图标正被用户类型使用
            }
            else
            {
                try
                {
                    if (Directory.Exists(context.Server.MapPath(@"..\lqnew\opePages\UpLoad\usertypepic\" + StrPicName)))
                    {
                        //string[] files = Directory.GetFiles(context.Server.MapPath(@"..\lqnew\opePages\UpLoad\usertypepic\" + StrPicName));
                        //foreach (string filename in files)
                        //{
                        //    File.Delete(filename);
                        //    log.Error(filename);
                        //}
                        //Directory.Delete(context.Server.MapPath(@"..\lqnew\opePages\UpLoad\usertypepic\" + StrPicName));

                        DelAllFilesInDirByDirPath(context.Server.MapPath(@"..\lqnew\opePages\UpLoad\usertypepic\" + StrPicName));
                        delDir();
                        strWriter = "{\"message\":\"" + ResourceManager.GetString("Lang_AlertDeleteSucess") + "\"}";//删除成功
                    }
                    else
                    {
                        strWriter = "{\"message\":\"" + ResourceManager.GetString("Lang_AlertDeleteFail") + "\"}";//删除失败
                    }
                }
                catch (Exception ex)
                {
                    log.Error(ex);
                    strWriter = "{\"message\":\"" + ResourceManager.GetString("Lang_AlertDeleteFail") + "\"}";//删除失败
                }

            }
            context.Response.Write(strWriter);
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}