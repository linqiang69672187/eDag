#region Author
/*
 *Modules:
 *CreateTime:2011-07-26
 *Author:杨德军    
 *Company:Eastcom
 **/

#endregion
using Ryu666.Components;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Web.lqnew.opePages
{
    public partial class edit_Stackade : BasePage
    {
        private DbComponent.ISSI ISSIService
        {
            get
            {
                return new DbComponent.ISSI();
            }
        }
        private DbComponent.IDAO.IStockadeDao StockadeService
        {
            get
            {
                return DbComponent.FactoryMethod.DispatchInfoFactory.CreateStockadeDao();
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {

            Page.ClientScript.RegisterStartupScript(Page.GetType(), "resizediv", "<script>Lang2localfunc();var image = window.document.getElementById('imgSelectUser');var srouce = window.parent.parent.GetTextByName('Lang_chooseMemberPNG', window.parent.parent.useprameters.languagedata);image.setAttribute('src', srouce);</script>");
            if (!Page.IsPostBack)
            {
                if (Request.QueryString["id"] != null)
                {
                    MyModel.Model_Stockade SkView = StockadeService.GetStockadeByDivID(Request.QueryString["id"].ToString());
                    if (SkView.ID != 0)
                    {
                        lbCreateUser.Text = SkView.LoginName;
                        lbCreateTime.Text = SkView.CreateTime.ToString();
                        labTitle.Text = SkView.Title;
                        DivID.Value = SkView.DivID;
                        String listMS = StockadeService.GetMyStockUsers(Request.QueryString["id"].ToString());
                        txtUsers.Value = listMS;
                    }
                    else
                    {
                        Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>window.parent.closeprossdiv();alert('" + ResourceManager.GetString("nxyxgddzzlybcz") + "');window.parent.mycallfunction(geturl());</script>");
                    }
                    if (System.Configuration.ConfigurationManager.AppSettings["OpenWindow"] == "1")
                    {
                        Page.ClientScript.RegisterStartupScript(Page.GetType(), "resizediv", "<script>  window.parent.lq_changeheight(geturl(), document.body.clientHeight);window.parent.change(geturl());</script>");
                    }
                }
                ImageButton1.ImageUrl = ResourceManager.GetString("LangConfirm");
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

            if (!Page.IsValid) { return; }//验证失败禁止通过提交
            try
            {
               
                if (StockadeService.GetStockadeByDivID(Request.QueryString["id"].ToString()).ID == 0)
                {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("dzzleditfaile") + "');window.parent.mycallfunction('edit_Stackade');</script>");
                    return;
                }

                string[] strs = txtUsers.Value.Split(new char[] { ';' }, StringSplitOptions.RemoveEmptyEntries);
                IList<string> listUID = new List<string>();
                foreach (string i in strs)
                {
                    string[] a = i.Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries);
                    listUID.Add(a[1]);
                }

                if (StockadeService.UpdateUsers(DivID.Value, listUID.ToArray<string>()))//逻辑 主要是添加用户跟删除用户 在UserInStockade表中
                {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("Lang_ModifySucc") + "');window.parent.lq_changeifr('manager_Stackade');window.parent.mycallfunction('edit_Stackade');</script>");

                }
                else
                {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("Lang_ModifyFail") + "');</script>");
                }
            }
            catch (System.Exception eX)
            {
                log.Error(eX);
                Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("Lang_ModifyFail") + "');</script>");
            }
        }
        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
        }
        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
        }
        protected void GridView2_RowCommand(object sender, GridViewCommandEventArgs e)
        {
        }
        protected void GridView2_RowDataBound(object sender, GridViewRowEventArgs e)
        {
        }
        protected void Label2_Load(object sender, EventArgs e)
        {
        }
        protected void Label3_Load(object sender, EventArgs e)
        {
        }
        protected void CustomValidator1_ServerValidate(object source, ServerValidateEventArgs args)
        {
            //DbComponent.ISSI addissi = new DbComponent.ISSI();
            //args.IsValid = true;
            //if (addissi.checkISSI(TextBox1.Text.Trim(), int.Parse(Request.QueryString["id"])) > 0)
            //{
            //    args.IsValid = false; CustomValidator1.ErrorMessage = "<b>" + ResourceManager.GetString("InvalidDataInput") + "！</b><hr/>" + ResourceManager.GetString("ISSIExists");
            //}
        }
    }
}