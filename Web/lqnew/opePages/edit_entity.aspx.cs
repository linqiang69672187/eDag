using Ryu666.Components;
using System;
using System.Web.UI;
using System.Text.RegularExpressions;

namespace Web.lqnew.opePages
{
    public partial class edit_entity : BasePage
    {
        private static MyModel.Model_Entity MEntity = new MyModel.Model_Entity();
        protected void Page_Load(object sender, EventArgs e)
        {
            Page.ClientScript.RegisterStartupScript(Page.GetType(), "LanguageSwitch", "<script>LanguageSwitch(window.parent.parent);</script>");
            LangConfirm.ImageUrl = ResourceManager.GetString("LangConfirm");
            if (!Page.IsPostBack)
            {
                rbtxtLo.ErrorMessage = "<b>" + ResourceManager.GetString("Lang_rbtxtLoErr") + "</b>";
                RangeValidator1.ErrorMessage = "<b>" + ResourceManager.GetString("Lang_RangeValidator1Err") + "</b>";

                validateEntityLength.ValidationExpression = Properties.Resources.strNameLengthValidationExpression;
                ValidatorBZ.ValidationExpression = Properties.Resources.strBZLenghtVaildationExpression;
                validateEntityLength.ErrorMessage = "<B>" + ResourceManager.GetString("errorUnNomal");
                ValidatorBZ.ErrorMessage = "<B>" + ResourceManager.GetString("errorBZ");


                rfvTxtName.ErrorMessage = "<b>" + ResourceManager.GetString("Fieldmust") + "!<hr/>" + ResourceManager.GetString("ReinsertEntityName") + "</b>";//请重新输入单位名

                try
                {
                    if (Request.QueryString["id"] != null)
                    {
                        DbComponent.Entity funEntity = new DbComponent.Entity();
                        MEntity = funEntity.GetEntityinfo_byid(int.Parse(Request.QueryString["id"]));
                        if (MEntity.id != 0)
                        {
                            TextBox1.Text = MEntity.Name;
                            int parntid = MEntity.ParentID;
                            if (MEntity.Depth == 0)
                            {
                                dragtd.Rows[2].Cells[1].InnerText = ResourceManager.GetString("FirstClassEntity");
                            }
                            else
                            {
                                string parntname = funEntity.GetEntityinfo_byid(parntid).Name;
                                dragtd.Rows[2].Cells[1].InnerText = parntname;
                            }

                            dragtd.Rows[3].Cells[1].InnerText = MEntity.Depth.ToString();
                            //TextBox3.Text =;

                            txtBZ.Text = MEntity.bz;
                            txtLa.Text = MEntity.La.ToString();
                            txtLo.Text = MEntity.Lo.ToString();
                            HidPic.Value = MEntity.PicUrl;
                            mypic.Src = "../../" + MEntity.PicUrl;
                        }
                        else
                        {
                            Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>window.parent.closeprossdiv();alert('"+ResourceManager.GetString("lang_EntityNotExist")+"');window.parent.mycallfunction(geturl());</script>");
                        }
                    }
                }
                catch (System.Exception et)
                {
                    log.Error(et);
                }
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
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("dwmcbhtszf") + "');</script>");
                    return;
                }
                mypic.Src = HidPic.Value.ToString();
                DbComponent.Entity funEntity = new DbComponent.Entity();
                if (funEntity.GetEntityinfo_byid(int.Parse(Request.QueryString["id"])).id == 0)
                {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("lang_ModifyFail_EntityNotExist") + "');window.parent.mycallfunction('edit_entity');</script>");
                    return;
                }
                if (funEntity.IsExistEntityNameForEdit(int.Parse(Request.QueryString["id"]), TextBox1.Text.Trim()))
                {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("EntityHasExist") + "');</script>");
                    return;
                }

                decimal dLo = 0;
                decimal DLa = 0;
                string strpicurl = HidPic.Value.ToString();
                if (!string.IsNullOrEmpty(txtLo.Text.Trim()))
                {
                    dLo = decimal.Parse(txtLo.Text.Trim());
                }
                if (!string.IsNullOrEmpty(txtLa.Text.Trim()))
                {
                    DLa = decimal.Parse(txtLa.Text.Trim());
                }
                funEntity.EditEntityinfo_byid(int.Parse(Request.QueryString["id"].ToString()), TextBox1.Text.Trim(), txtBZ.Text.Trim(), dLo, DLa, strpicurl,this.Page);
                //注释原来的，新的将window.parent.CloseJWD()函数删除---------------xzj--2018/6/29-------------
                //Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("Lang_ModifySucc") + "');window.parent.reloadtree();window.parent.lq_changeifr('manager_entity');window.parent.UpdatePoliceStation('" + MEntity.id + "','" + MEntity.DivID + "','" + DLa + "','" + dLo + "','" + TextBox1.Text.Trim() + "','" + strpicurl + "');window.parent.CloseJWD();window.parent.updateuseprameter();window.parent.mycallfunction('edit_entity',418, 342);</script>");
var entity = "{ 'ID' : '" + MEntity.id + "','DivID' : '" + MEntity.DivID + "', 'La' :" + DLa + ", 'Lo' :" + dLo + ", 'policename' :'" + TextBox1.Text.Trim() + "', 'picurl' :'" + strpicurl + "' }";
                Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("Lang_ModifySucc") + "');window.parent.reloadtree();window.parent.lq_changeifr('manager_entity');window.parent.psLayerManager.updatePoliceStation(" + entity + ");window.parent.updateuseprameter();window.parent.mycallfunction('edit_entity',418, 342);</script>");
                //注释原来的，新的将window.parent.CloseJWD()函数删除---------------xzj--2018/6/29-------------
            }
            catch (System.Exception eX)
            {
                log.Error(eX);
                Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("Lang_ModifyFail") + "');</script>");
            }
            
        }
    }
}