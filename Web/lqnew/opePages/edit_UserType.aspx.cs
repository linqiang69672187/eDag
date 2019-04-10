using DbComponent;
using Microsoft.Win32;
using MyModel;
using Ryu666.Components;
using System;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Reflection;
using System.Web.UI;
using System.Security.Permissions;
using System.Security.AccessControl;

namespace Web.lqnew.opePages
{
    public partial class edit_UserType : System.Web.UI.Page
    {
        private string hidvalue = "";
        private DbComponent.IDAO.IUserTypeDao UserTypeDaoServce
        {
            get
            {
                return DbComponent.FactoryMethod.DispatchInfoFactory.CreateUserTypeDao();
            }
        }
        private static readonly log4net.ILog log = log4net.LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);
        protected void Page_Load(object sender, EventArgs e)
        {

            Page.ClientScript.RegisterStartupScript(Page.GetType(), "Lang2localfunc", "<script>Lang2localfunc();</script>");

            //RegularExpressionValidator1.ValidationExpression = Properties.Resources.strNameLengthValidationExpression;
            RegularExpressionValidator1.ErrorMessage = "<B>" + ResourceManager.GetString("police_type_verify");
            if (!Page.IsPostBack && Request.QueryString["id"] != null)
            {
                cancel.Src = ResourceManager.GetString("Lang-Cancel");
                Model_UserType userType = UserTypeDaoServce.GetUserTypeByID(int.Parse(Request.QueryString["id"]));
                if (userType.ID != 0)
                {
                    txtTypeName.Text = userType.TypeName;
                    hidmyname.Value = userType.TypeName;
                    mypic.Src = "UpLoad/tempusertypepic/" + userType.TypeName + "/3.png";
                    hidNormal.Value = userType.TypeName;
                    myjy.Value = userType.TypeName;
                    //imgUnNormal.Src = "UpLoad/usertypepic/" + userType.TypeIcons + "/3.png";
                    //hidSelStatus.Value = userType.TypeIcons;
                    //imgSelStatus.Src = "UpLoad/usertypepic/" + userType.TypeIcons + "/4.png";
                }
                else
                {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>window.parent.closeprossdiv();alert('" + ResourceManager.GetString("nxyxgdyhlxxxybcz") + "');window.parent.mycallfunction(geturl());</script>");
                }
            }
            else
            {
                if (System.Configuration.ConfigurationManager.AppSettings["OpenWindow"] == "1")
                {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "resizediv", "<script>  window.parent.lq_changeheight(geturl(), document.body.clientHeight);</script>");
                }
            }
            ImageButton1.ImageUrl = ResourceManager.GetString("LangConfirm");
            RequiredFieldValidator1.ErrorMessage = "<b>" + ResourceManager.GetString("qsrlxmc") + "</b>";
        }

        protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
        {
            Page.ClientScript.RegisterStartupScript(Page.GetType(), "resizediv", "<script>   var image1 = window.document.getElementById('Lang-Cancel');var srouce1 = window.parent.parent.GetTextByName('Lang-Cancel', window.parent.parent.useprameters.languagedata);image1.setAttribute('src', srouce1);</script>");

            try
            {
                //先判断是否有用户绑定了此用户类型，如果绑定了 则不能删除
                //if (UserTypeDaoServce.IsUsed(int.Parse(Request.QueryString["id"])))
                //{
                //    Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("UserTypebeUSECantEdit") + "');</script>");
                //    return;
                //}
                LQCommonCS.FileControl fileControl = new LQCommonCS.FileControl();
                LQCommonCS.DirectoryControl dirControl = new LQCommonCS.DirectoryControl();

                if (UserTypeDaoServce.GetUserTypeByID(int.Parse(Request.QueryString["id"])).ID == 0)
                {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("yhlxeditfaile") + "');window.parent.mycallfunction('edit_UserType');</script>");
                    return;
                }
                if (!Directory.Exists(Server.MapPath(@"UpLoad\usertypepic\" + hidNormal.Value)) && myjy.Value != hidNormal.Value)
                {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("yhleixtpbcz") + "');</script>");
                    hidNormal.Value = ResourceManager.GetString("Lang_Policeman");

                    // hidSelStatus.Value = "警察";
                    return;
                }

                if (UserTypeDaoServce.FindUserTypeNameIsExistForUpdate(int.Parse(Request.QueryString["id"]), txtTypeName.Text.Trim()))
                {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("yhlxmcyjcz") + "');</script>");
                    return;
                }
                if (myjy.Value != hidNormal.Value)
                {
                    //将usertypepic对应的移动到tempusertypepic
                    if (Directory.Exists(Server.MapPath(@"UpLoad\tempusertypepic\" + txtTypeName.Text.Trim())))
                    {
                        System.GC.Collect();
                        if (File.Exists(Server.MapPath(@"UpLoad\tempusertypepic\" + txtTypeName.Text.Trim() + @"\1.png")))
                        {
                            fileControl.AddFileSecurity(Server.MapPath(@"UpLoad\tempusertypepic\" + txtTypeName.Text.Trim() + @"\1.png"));
                            File.Delete(Server.MapPath(@"UpLoad\tempusertypepic\" + txtTypeName.Text.Trim() + @"\1.png"));
                        }
                        if (File.Exists(Server.MapPath(@"UpLoad\tempusertypepic\" + txtTypeName.Text.Trim() + @"\2.png")))
                        {
                            fileControl.AddFileSecurity(Server.MapPath(@"UpLoad\tempusertypepic\" + txtTypeName.Text.Trim() + @"\2.png"));
                            File.Delete(Server.MapPath(@"UpLoad\tempusertypepic\" + txtTypeName.Text.Trim() + @"\2.png"));
                        }
                        if (File.Exists(Server.MapPath(@"UpLoad\tempusertypepic\" + txtTypeName.Text.Trim() + @"\3.png")))
                        {
                            fileControl.AddFileSecurity(Server.MapPath(@"UpLoad\tempusertypepic\" + txtTypeName.Text.Trim() + @"\3.png"));
                            File.Delete(Server.MapPath(@"UpLoad\tempusertypepic\" + txtTypeName.Text.Trim() + @"\3.png"));
                        }
                        if (File.Exists(Server.MapPath(@"UpLoad\tempusertypepic\" + txtTypeName.Text.Trim() + @"\4.png")))
                        {
                            fileControl.AddFileSecurity(Server.MapPath(@"UpLoad\tempusertypepic\" + txtTypeName.Text.Trim() + @"\4.png"));
                            File.Delete(Server.MapPath(@"UpLoad\tempusertypepic\" + txtTypeName.Text.Trim() + @"\4.png"));
                        }

                    }
                    else
                    {
                        Directory.CreateDirectory(this.Server.MapPath(@"UpLoad\tempusertypepic\" + txtTypeName.Text.Trim()));
                    }

                    File.Copy(Server.MapPath(@"UpLoad\usertypepic\" + hidNormal.Value + @"\1.png"), Server.MapPath(@"UpLoad\tempusertypepic\" + txtTypeName.Text.Trim() + @"\1.png"), true);
                    File.Copy(Server.MapPath(@"UpLoad\usertypepic\" + hidNormal.Value + @"\2.png"), Server.MapPath(@"UpLoad\tempusertypepic\" + txtTypeName.Text.Trim() + @"\2.png"), true);
                    File.Copy(Server.MapPath(@"UpLoad\usertypepic\" + hidNormal.Value + @"\3.png"), Server.MapPath(@"UpLoad\tempusertypepic\" + txtTypeName.Text.Trim() + @"\3.png"), true);

                }
                else
                {
                    if (Directory.Exists(Server.MapPath(@"UpLoad\tempusertypepic\" + txtTypeName.Text.Trim())))
                    {
                    }
                    else
                    {
                        Directory.CreateDirectory(this.Server.MapPath(@"UpLoad\tempusertypepic\" + txtTypeName.Text.Trim()));
                    }

                    if (hidmyname.Value != txtTypeName.Text.Trim())
                    {
                        System.GC.Collect();
                        if (Directory.Exists(Server.MapPath(@"UpLoad\tempusertypepic\" + hidNormal.Value)))
                        {
                            AddDirectorySecurity((Server.MapPath(@"UpLoad\tempusertypepic\" + txtTypeName.Text.Trim())), @"Everyone", FileSystemRights.FullControl, AccessControlType.Allow);

                            if (File.Exists(Server.MapPath(@"UpLoad\tempusertypepic\" + txtTypeName.Text.Trim() + @"\1.png")))
                            {
                                fileControl.AddFileSecurity(Server.MapPath(@"UpLoad\tempusertypepic\" + txtTypeName.Text.Trim() + @"\1.png"));
                                File.Delete(Server.MapPath(@"UpLoad\tempusertypepic\" + txtTypeName.Text.Trim() + @"\1.png"));
                            }

                            if (File.Exists(Server.MapPath(@"UpLoad\tempusertypepic\" + txtTypeName.Text.Trim() + @"\2.png")))
                            {
                                fileControl.AddFileSecurity(Server.MapPath(@"UpLoad\tempusertypepic\" + txtTypeName.Text.Trim() + @"\2.png"));
                                File.Delete(Server.MapPath(@"UpLoad\tempusertypepic\" + txtTypeName.Text.Trim() + @"\2.png"));
                            }

                            if (File.Exists(Server.MapPath(@"UpLoad\tempusertypepic\" + txtTypeName.Text.Trim() + @"\3.png")))
                            {
                                fileControl.AddFileSecurity(Server.MapPath(@"UpLoad\tempusertypepic\" + txtTypeName.Text.Trim() + @"\3.png"));
                                File.Delete(Server.MapPath(@"UpLoad\tempusertypepic\" + txtTypeName.Text.Trim() + @"\3.png"));
                            }

                            if (File.Exists(Server.MapPath(@"UpLoad\tempusertypepic\" + txtTypeName.Text.Trim() + @"\4.png")))
                            {
                                 fileControl.AddFileSecurity(Server.MapPath(@"UpLoad\tempusertypepic\" + txtTypeName.Text.Trim() + @"\4.png"));
                                 File.Delete(Server.MapPath(@"UpLoad\tempusertypepic\" + txtTypeName.Text.Trim() + @"\4.png"));
                            }

                            dirControl.AddDirectorySecurity(Server.MapPath(@"UpLoad\tempusertypepic\" + txtTypeName.Text.Trim()));

                            if (File.Exists(Server.MapPath(@"UpLoad\tempusertypepic\" + hidNormal.Value + @"\1.png")))
                            {
                                File.Copy(Server.MapPath(@"UpLoad\tempusertypepic\" + hidNormal.Value + @"\1.png"), Server.MapPath(@"UpLoad\tempusertypepic\" + txtTypeName.Text.Trim() + @"\1.png"), true);
                            }
                            if (File.Exists(Server.MapPath(@"UpLoad\tempusertypepic\" + hidNormal.Value + @"\2.png")))
                            {
                                File.Copy(Server.MapPath(@"UpLoad\tempusertypepic\" + hidNormal.Value + @"\2.png"), Server.MapPath(@"UpLoad\tempusertypepic\" + txtTypeName.Text.Trim() + @"\2.png"), true);
                            }
                            if (File.Exists(Server.MapPath(@"UpLoad\tempusertypepic\" + hidNormal.Value + @"\3.png")))
                            {
                                File.Copy(Server.MapPath(@"UpLoad\tempusertypepic\" + hidNormal.Value + @"\3.png"), Server.MapPath(@"UpLoad\tempusertypepic\" + txtTypeName.Text.Trim() + @"\3.png"), true);
                            }

                            if (File.Exists(Server.MapPath(@"UpLoad\tempusertypepic\" + hidNormal.Value + @"\4.png")))
                            {
                                File.Copy(Server.MapPath(@"UpLoad\tempusertypepic\" + hidNormal.Value + @"\4.png"), Server.MapPath(@"UpLoad\tempusertypepic\" + txtTypeName.Text.Trim() + @"\4.png"), true);
                            }

                            try
                            {
                                System.GC.Collect();
                                dirControl.AddDirectorySecurity(this.Server.MapPath(@"UpLoad\tempusertypepic\" + hidNormal.Value));
                                dirControl.DeleteFolder(this.Server.MapPath(@"UpLoad\tempusertypepic\" + hidNormal.Value));
                            }
                            catch (Exception ex)
                            {
                                log.Error(ex.Message + "ddd");
                            }
                        }
                    }
                }

                //分割图片
                //DbComponent.Image img = new DbComponent.Image();
                //img.Fengepics(@"UpLoad\usertypepic\" + hidNormal.Value, @"UpLoad\tempusertypepic\" + txtTypeName.Text.Trim(), "1.png", this.Page, 1);
                //img.Fengepics(@"UpLoad\usertypepic\" + hidNormal.Value, @"UpLoad\tempusertypepic\" + txtTypeName.Text.Trim(), "2.png", this.Page, 1);
                //img.Fengepics(@"UpLoad\usertypepic\" + hidNormal.Value, @"UpLoad\tempusertypepic\" + txtTypeName.Text.Trim(), "3.png", this.Page, 1);

                Model_UserType newModel = new Model_UserType { ID = int.Parse(Request.QueryString["id"]), TypeName = txtTypeName.Text.Trim(), TypeIcons = "", NormalIcons = "", UrgencyIcons = "", UnNormalIcons = "" };
                if (UserTypeDaoServce.UpdateUserType(newModel))
                {
                    insertimgtoDB(Server.MapPath(@"UpLoad\tempusertypepic\" + txtTypeName.Text.Trim() + @"\"), txtTypeName.Text.Trim());
                    //去除window.location.reload(true); 函数，原位于jQuery.ajaxSetup({cache:false});之后-----------------------xzj--2018/8/4-------------------
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>jQuery.ajaxSetup({cache:false});alert('" + ResourceManager.GetString("Lang_ModifySucc") + "');UpdateRand();window.parent.reloadtree();window.parent.lq_changeifr('manager_UserType');window.parent.mycallfunction('edit_UserType');</script>");
                    // Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("Lang_ModifySucc") + "');UpdateRand();window.parent.reloadtree();window.parent.lq_changeifr('manager_UserType');window.parent.mycallfunction('manager_UserType');</script>");

                }
                else
                {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("Lang_ModifyFail") + "');</script>");
                }
            }
            catch (System.IO.IOException eX)
            {
                log.Error(eX);
                Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("Lang_UserTypeOperateFreq") + "');</script>");

            }
            catch (System.Exception eX)
            {
                log.Error(eX);
                Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("Lang_ModifyFail") + "');</script>");
            }
        }

        public static string GetMimeMapping(string fileName)
        {
            string mimeType = "application/octet-stream";
            string ext = Path.GetExtension(fileName).ToLower();
            RegistryKey regKey = Registry.ClassesRoot.OpenSubKey(ext);
            if (regKey != null && regKey.GetValue("Content Type") != null)
            {
                mimeType = regKey.GetValue("Content Type").ToString();
            }
            return mimeType;
        }
        protected void insertimgtoDB(string dir, string name)
        {
            string contentType = GetMimeMapping("1.png");

            for (int i = 1; i <= 3; i++)
            {
                System.Drawing.Image originalImage = System.Drawing.Image.FromFile(dir + i + ".png");

                MemoryStream ms = new MemoryStream();
                originalImage.Save(ms, System.Drawing.Imaging.ImageFormat.Png);
                byte[] imgedat = ms.ToArray();
                int count = int.Parse(SQLHelper.ExecuteScalar(CommandType.Text, "select count(id) from [Images] where name =@name and type='UserType' ", new SqlParameter("name", name + "_" + i)).ToString());
                if (count == 0)
                {
                    SQLHelper.ExecuteNonQuery(CommandType.Text, "INSERT [Images] ([name],[ImageData],[ImageContentType],[ImageSize],[type] ) VALUES (@name,@ImageData,@ImageContentType,@ImageSize,@type)", new SqlParameter("name", name + "_" + i), new SqlParameter("ImageData", imgedat), new SqlParameter("ImageContentType", contentType), new SqlParameter("ImageSize", imgedat.Length), new SqlParameter("type", "UserType"));
                }
                else
                {
                    SQLHelper.ExecuteNonQuery(CommandType.Text, "update [Images] set [ImageData]=@ImageData,[ImageContentType]=@ImageContentType,[ImageSize]=@ImageSize  where name =@name and type='UserType' ", new SqlParameter("name", name + "_" + i), new SqlParameter("ImageData", imgedat), new SqlParameter("ImageContentType", contentType), new SqlParameter("ImageSize", imgedat.Length), new SqlParameter("type", "UserType"));

                }
            }

        }

        #region 添加文件夹权限
        private static void AddDirectorySecurity(string FileName, string Account, FileSystemRights Rights, AccessControlType ControlType)
        {
            try
            {
                if (System.IO.Directory.Exists(FileName))
                {
                    DirectoryInfo dInfo = new DirectoryInfo(FileName);
                    DirectorySecurity dSecurity = dInfo.GetAccessControl();
                    dSecurity.AddAccessRule(new FileSystemAccessRule(Account, Rights, InheritanceFlags.ContainerInherit | InheritanceFlags.ObjectInherit, PropagationFlags.None, ControlType));
                    dInfo.SetAccessControl(dSecurity);
                }
            }
            catch (Exception er)
            {
                log.Error(er.Message + "::::AddDirectorySecurity");
            }
        }
        #endregion

        #region 添加文件权限
        public void AddFileSecurity(string FileName)
        {
            try
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
            catch (Exception er)
            {
                log.Error(er.Message + "::::AddFileSecurity");
            }
        }
        #endregion
    }
}