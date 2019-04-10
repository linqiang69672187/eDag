using DbComponent;
using DbComponent.IDAO;
using Microsoft.Win32;
using Ryu666.Components;
using System;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI;
namespace Web.lqnew.opePages
{
    public partial class add_UserType : BasePage
    {
        
        private IUserTypeDao UserTypeDaoService
        {
            get
            {
                return DbComponent.FactoryMethod.DispatchInfoFactory.CreateUserTypeDao();
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
           
            ImageButton1.ImageUrl = ResourceManager.GetString("LangConfirm");
            RequiredFieldValidator1.ErrorMessage = "<b>" + ResourceManager.GetString("qsrlxmc") + "</b>";
            Page.ClientScript.RegisterStartupScript(Page.GetType(), "LanguageSwitch", "<script>  Lang2localfunc(); </script>");

            if (!Page.IsPostBack)
            {
                hidNormal.Value = ResourceManager.GetString("Lang_Policeman");



               // RegularExpressionValidator1.ValidationExpression = Properties.Resources.strNameLengthValidationExpression;
                RegularExpressionValidator1.ErrorMessage = "<B>" + ResourceManager.GetString("police_type_verify");
                if (System.Configuration.ConfigurationManager.AppSettings["OpenWindow"] == "1")
                {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "resizediv", "<script>  window.parent.lq_changeheight(geturl(), document.body.clientHeight);window.parent.change(geturl());</script>");
                }
            }
            else
            {
                if (System.Configuration.ConfigurationManager.AppSettings["OpenWindow"] == "1")
                {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "resizediv", "<script>  window.parent.lq_changeheight(geturl(), document.body.clientHeight);</script>");
                }
            }
        }

        protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
        {

            try
            {


                if (!Directory.Exists(Server.MapPath(@"UpLoad\usertypepic\" + hidNormal.Value)))
                {
                    hidNormal.Value = ResourceManager.GetString("Lang_Policeman");//"警察";Lang_Policeman


                    // hidSelStatus.Value = "警察";
                    string yhleixtpbcz = ResourceManager.GetString("yhleixtpbcz");
                    // Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('用户类型图片不存在,现已还原到警察图片,如有需要请重新选择');</script>");
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + yhleixtpbcz + "');</script>");
                    return;
                }
                if (UserTypeDaoService.FindUserTypeNameIsExist(txtTypeName.Text.Trim()))
                {
                    string yhlxmcyjcz = ResourceManager.GetString("yhlxmcyjcz");
                    //  Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('用户类型名称已经存在');</script>");
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + yhlxmcyjcz + "');</script>");
                    return;
                }
                //将usertypepic对应的移动到tempusertypepic
                if (!Directory.Exists(Server.MapPath(@"UpLoad\tempusertypepic\" + txtTypeName.Text.Trim())))
                {
                    Directory.CreateDirectory(this.Server.MapPath(@"UpLoad\tempusertypepic\" + txtTypeName.Text.Trim()));
                }
                //hidNormal.Value = ResourceManager.GetString("Lang_Policeman");
                File.Copy(Server.MapPath(@"UpLoad\usertypepic\" + hidNormal.Value + @"\1.png"), Server.MapPath(@"UpLoad\tempusertypepic\" + txtTypeName.Text.Trim() + @"\1.png"), true);
                File.Copy(Server.MapPath(@"UpLoad\usertypepic\" + hidNormal.Value + @"\2.png"), Server.MapPath(@"UpLoad\tempusertypepic\" + txtTypeName.Text.Trim() + @"\2.png"), true);
                File.Copy(Server.MapPath(@"UpLoad\usertypepic\" + hidNormal.Value + @"\3.png"), Server.MapPath(@"UpLoad\tempusertypepic\" + txtTypeName.Text.Trim() + @"\3.png"), true);
                //分割图片
                DbComponent.Image img = new DbComponent.Image();
                img.Fengepics(@"UpLoad\usertypepic\" + hidNormal.Value, @"UpLoad\tempusertypepic\" + txtTypeName.Text.Trim(), "1.png", this.Page, 1);
                img.Fengepics(@"UpLoad\usertypepic\" + hidNormal.Value, @"UpLoad\tempusertypepic\" + txtTypeName.Text.Trim(), "2.png", this.Page, 1);
                img.Fengepics(@"UpLoad\usertypepic\" + hidNormal.Value, @"UpLoad\tempusertypepic\" + txtTypeName.Text.Trim(), "3.png", this.Page, 1);

                MyModel.Model_UserType newType = new MyModel.Model_UserType { TypeName = txtTypeName.Text.Trim(), TypeIcons = "", NormalIcons = "", UrgencyIcons = "", UnNormalIcons = "" };
                if (UserTypeDaoService.AddUserType(newType))
                {
                    insertimgtoDB(Server.MapPath(@"UpLoad\tempusertypepic\" + txtTypeName.Text.Trim() + @"\"), txtTypeName.Text.Trim());
                    string AddSucc = ResourceManager.GetString("AddSucc");
                    System.Threading.Thread.Sleep(500);
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + AddSucc + "');window.parent.reloadtree();window.parent.lq_changeifr('manager_UserType');window.parent.mycallfunction('add_UserType');</script>");

                }
                else
                {
                    string AddFail = ResourceManager.GetString("AddFail");
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + AddFail + "');</script>");
                }
            }
            catch (System.Exception eX)
            {
                log.Error(eX);
                string AddFail = ResourceManager.GetString("AddFail");
                Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + AddFail + "');</script>");
            }
            finally
            {
                System.GC.Collect();
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
        protected void insertimgtoDB(string dir,string name)
        {    
                string contentType = GetMimeMapping("1.png");

              for (int i = 1; i <= 3; i++)
              {
                System.Drawing.Image originalImage = System.Drawing.Image.FromFile(dir+i+".png");

                MemoryStream ms = new MemoryStream();
                originalImage.Save(ms, System.Drawing.Imaging.ImageFormat.Png);
                byte[] imgedat = ms.ToArray();
                int count = int.Parse(SQLHelper.ExecuteScalar(CommandType.Text, "select count(id) from [Images] where name =@name and type='UserType' ", new SqlParameter("name", name + "_" + i)).ToString());
                if (count == 0)
                {
                    SQLHelper.ExecuteNonQuery(CommandType.Text, "INSERT [Images] ([name],[ImageData],[ImageContentType],[ImageSize],[type] ) VALUES (@name,@ImageData,@ImageContentType,@ImageSize,@type)", new SqlParameter("name", name+"_"+i), new SqlParameter("ImageData", imgedat), new SqlParameter("ImageContentType", contentType), new SqlParameter("ImageSize", imgedat.Length), new SqlParameter("type", "UserType"));
                }
                else
                {
                    SQLHelper.ExecuteNonQuery(CommandType.Text, "update [Images] set [ImageData]=@ImageData,[ImageContentType]=@ImageContentType,[ImageSize]=@ImageSize  where name =@name and type='UserType' ", new SqlParameter("name", name + "_" + i), new SqlParameter("ImageData", imgedat), new SqlParameter("ImageContentType", contentType), new SqlParameter("ImageSize", imgedat.Length), new SqlParameter("type", "UserType"));
              
                }
              }

      }

  


    }
}