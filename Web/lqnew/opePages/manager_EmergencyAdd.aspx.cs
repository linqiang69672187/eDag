
using Ryu666.Components;
using System;
using System.Data;
using System.IO;
using System.Text.RegularExpressions;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace Web.lqnew.opePages
{
    public partial class manager_EmergencyAdd : BasePage
    {
        //public int entity_depth = 100000;
        protected void Page_Load(object sender, EventArgs e)
        {
            Page.ClientScript.RegisterStartupScript(Page.GetType(), "LanguageSwitch", "<script>LanguageSwitch(window.parent);</script>");
            DbComponent.userinfo userinfo = new DbComponent.userinfo();
            //entity_depth = entity.GetEntityIndex(int.Parse(Request.Cookies["id"].Value));
            if (!Page.IsPostBack)
            {
                validateEntityLength.ValidationExpression = Properties.Resources.strNameLengthValidationExpression;
                validateEntityLength.ErrorMessage = "<b>" + ResourceManager.GetString("errorUnNomal");

                // RegularExpressionValidator1.ValidationExpression = Properties.Resources.strUnNomalValidationExpression;

                // RegularExpressionValidator1.ErrorMessage = "<B>" + ResourceManager.GetString("errorUnNomal");
                rfvTxtName.ErrorMessage = "<b>" + ResourceManager.GetString("Fieldmust") + "!<hr/>" + ResourceManager.GetString("ReinsertEmergencyName") + "</b>";//请重新输入预案名称

                DbComponent.userinfo DropList = new DbComponent.userinfo();
                this.DropDownList2.DataSource = DropList.DropEmergency().DefaultView;
                this.DropDownList2.DataTextField = "TypeName";
                this.DropDownList2.DataValueField = "TypeId";
                this.DropDownList2.DataBind();

            }
            else
            {
                if (System.Configuration.ConfigurationManager.AppSettings["OpenWindow"] == "1")
                {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "resizediv", "<script>  window.parent.lq_changeheight(geturl(), document.body.clientHeight);</script>");
                }
            }


        }
        protected bool checkUnNomal(String str)
        {
            var pattern = new Regex("[`~!@#$%^&*()=|{}':;',\\[\\].<>/?~！#￥……&*（）——|{}【】‘；：”“'。，、？]");

            if (pattern.IsMatch(str))//包含特殊字符
                return true;
            else
                return false;//不包含特殊字符
        }
        protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
        {
            try
            {
                if (checkUnNomal(TextBox1.Text.Trim()))
                {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("yamcbhtszf") + "');</script>");
                    return;
                }

                DbComponent.userinfo addentit = new DbComponent.userinfo();
                if (addentit.IsExistEmergencyNameForAdd(TextBox1.Text.Trim()))
                {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("EmergencyNameHasExist") + "');</script>");
                    return;
                }


                if (string.IsNullOrEmpty(HidPic.Value))
                {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("ChooseFiles") + "');</script>");
                    return;

                }
                string name1 = TextBox1.Text.Trim();

                string name2 = this.DropDownList2.SelectedItem.Text;

                DateTime dtimi = DateTime.Now;
                string divID = dtimi.ToShortDateString();



                string sPath = System.IO.Path.GetDirectoryName(Page.Request.PhysicalPath);
                sPath = sPath.Replace("lqnew\\opePages", "");
                sPath = sPath + HidPic.Value;

                //二进制流
                //byte[] buffer = new byte[1024];
                //using (FileStream fsRead = new FileStream(sPath, FileMode.Open, FileAccess.Read))
                //{

                //    int byteCount = fsRead.Read(buffer, 0, buffer.Length);
                //    while (byteCount > 0)
                //    {


                //        byteCount = fsRead.Read(buffer, 0, buffer.Length);

                //    }

                //}

                FileStream fsRead = new FileStream(sPath, FileMode.Open, FileAccess.Read);


                byte[] strFileContent = new byte[fsRead.Length];

                fsRead.Read(strFileContent, 0, System.Convert.ToInt32(fsRead.Length));

                fsRead.Flush();
                fsRead.Dispose();


                if (addentit.AddEmergencyinfo(name1, name2, strFileContent, FileName.Value, divID))
                {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("AddSucc") + "');window.parent.reloadtree();window.parent.lq_changeifr('manager_Emergency');;window.parent.mycallfunction('manager_EmergencyAdd');</script>");
                    log.Info(ResourceManager.GetString("AddEntity") + name1 + ResourceManager.GetString("lang_Success"));
                }
                else
                {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("AddFail") + "');</script>");
                }

                File.Delete(sPath);

            }
            catch (System.Exception eX)
            {
                log.Error(eX);
                Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("AddFail") + "');</script>");
            }
        }



    }
}