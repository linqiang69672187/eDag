#region Version Info
/*=================版本信息======================
*Copyright (C)  QJJ
*All rights reserved
*guid1:            acb216af-a3f5-448d-8533-d944aca3d480
*作者：	           QJJ
*当前登录用户名:   zhkk
*机器名称:         RT-QIJIANJ
*注册组织名:       Microsoft
*CLR版本:          4.0.30319.18052
*当前工程名：      $safeprojectname$
*工程名：          $projectname$
*新建项输入的名称: Manager_Ptype
*命名空间名称:     Web.lqnew.opePages
*文件名:           Manager_Ptype
*当前系统时间:     2013/11/25 10:47:50
*创建年份:         2013
*版本：
*
*功能说明：       
* 
* 修改者： 
* 时间：	   2013/11/25 10:47:50
* 修改说明：
*======================================================
*/
#endregion

using DbComponent;
using Ryu666.Components;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Web.lqnew.opePages
{
    public partial class Manager_Ptype : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Page.ClientScript.RegisterStartupScript(Page.GetType(), "LanguageSwitch", "<script>LanguageSwitch(window.parent);</script>");
           
            ImageButton1.ImageUrl = ResourceManager.GetString("Lang_Search2");
            Page.ClientScript.RegisterStartupScript(Page.GetType(), "resizediv", "<script>window.document.getElementById(\"Lang_AddNew\").src = window.parent.GetTextByName('Lang_AddNew', window.parent.useprameters.languagedata);</script>");
            GridView1.EmptyDataText = ResourceManager.GetString("NoData");
            GridView1.Columns[0].HeaderText = ResourceManager.GetString("Lang_ProcedureTypeName");
            GridView1.Columns[1].HeaderText = ResourceManager.GetString("Lang_reserve1");
            GridView1.Columns[2].HeaderText = ResourceManager.GetString("Lang_reserve2");
            GridView1.Columns[3].HeaderText = ResourceManager.GetString("Lang_reserve3");
            GridView1.Columns[4].HeaderText = ResourceManager.GetString("Lang_reserve4");
            GridView1.Columns[5].HeaderText = ResourceManager.GetString("Lang_reserve5");
            GridView1.Columns[6].HeaderText = ResourceManager.GetString("Lang_reserve6");
            GridView1.Columns[7].HeaderText = ResourceManager.GetString("Lang_reserve7");
            GridView1.Columns[8].HeaderText = ResourceManager.GetString("Lang_reserve8");
            GridView1.Columns[9].HeaderText = ResourceManager.GetString("Lang_reserve9");
            GridView1.Columns[10].HeaderText = ResourceManager.GetString("Lang_reserve10");
            GridView1.Columns[11].HeaderText = ResourceManager.GetString("Lang_Remark");
            //if (!Page.IsPostBack)
            //{
            //    if (System.Configuration.ConfigurationManager.AppSettings["OpenWindow"] == "1")
            //    {
            //        Page.ClientScript.RegisterStartupScript(Page.GetType(), "resizediv", "<script>  window.parent.lq_changeheight(geturl(), document.body.clientHeight);window.parent.change(geturl());</script>");
            //    }
            //    if (Request.QueryString["id"] != null)
            //    {
            //        userul.Visible = false;
            //    }
            //}
            //else
            //{
            //    if (System.Configuration.ConfigurationManager.AppSettings["OpenWindow"] == "1")
            //    {
            //        Page.ClientScript.RegisterStartupScript(Page.GetType(), "resizediv", "<script>  window.parent.lq_changeheight(geturl(), document.body.clientHeight);</script>");
            //    }
            //}
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //e.Row.Attributes.Add("onmouseover", "changeTgBg(this,'font',2)");
                //e.Row.Attributes.Add("onmouseout", "overchangeTgBg(this,'font',2)");
                //DbComponent.Entity funEntity = new DbComponent.Entity();
                //DbComponent.group fungroup = new DbComponent.group();
                //e.Row.Cells[1].Text = "&nbsp;&nbsp;" + funEntity.GetEntityinfo_byid(int.Parse(e.Row.Cells[1].Text)).Name;
                //funEntity = null;


                LinkButton linkbtn = (LinkButton)e.Row.FindControl("ImageButton2");
                if (linkbtn != null)
                {
                    linkbtn.ToolTip = ResourceManager.GetString("Delete");
                    linkbtn.OnClientClick = @"javascript:window.document.getElementById('Lang_AddNew').src = window.parent.GetTextByName('Lang_AddNew', window.parent.useprameters.languagedata);return confirm('" + ResourceManager.GetString("Delete") + "['+this.parentElement.parentElement.getElementsByTagName('font')[0].innerText.trim()+']?')";
                }
                System.Web.UI.HtmlControls.HtmlImage img = (System.Web.UI.HtmlControls.HtmlImage)e.Row.FindControl("img_del");
                if (img != null)
                {
                    img.Attributes.Add("title", ResourceManager.GetString("Delete"));
                }
                System.Web.UI.HtmlControls.HtmlImage img2 = (System.Web.UI.HtmlControls.HtmlImage)e.Row.FindControl("img_modify");
                if (img2 != null)
                {
                    img2.Attributes.Add("title", ResourceManager.GetString("Modify"));
                }

            }
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            switch (e.CommandName)
            {
                case "MyDel":
                    String name = e.CommandArgument.ToString();
                    DTProcedureType dt = new DTProcedureType();
                    Object obj=dt.DeleteModel_ProcedureInfo(name);
                    if(obj is List<Object>)
                    {
                        StringBuilder sb = new StringBuilder();
                        sb.Append("\\n 已被 流程【");
                        foreach (var c in (obj as List<Object>))
                        {
                            sb.AppendFormat("{0},", c);
                        }
                        sb.Remove(sb.Length - 1, 1);
                        sb.Append("】使用");
                        Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>window.document.getElementById('Lang_AddNew').src = window.parent.GetTextByName('Lang_AddNew', window.parent.useprameters.languagedata);alert('" + ResourceManager.GetString("Operationfails") + sb.ToString() + "');</script>");
                    }
                    else if (obj is bool)
                    {
                        if (Convert.ToBoolean(obj))
                        {
                            Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>window.document.getElementById('Lang_AddNew').src = window.parent.GetTextByName('Lang_AddNew', window.parent.useprameters.languagedata);alert('" + ResourceManager.GetString("OperationSuccessful") + "');window.parent.lq_changeifr('manager_Ptype');</script>");
                        }
                        else
                        {
                            Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>window.document.getElementById('Lang_AddNew').src = window.parent.GetTextByName('Lang_AddNew', window.parent.useprameters.languagedata);alert('" + ResourceManager.GetString("Operationfails") + "');</script>");
                        }
                    }
                    break;

                default:
                    break;
            }
        }

        protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
        {
            GridView1.PageIndex = 0;
        }
    }
}