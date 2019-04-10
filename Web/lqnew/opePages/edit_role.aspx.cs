using MyModel;
using Ryu666.Components;
using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using DbComponent;

namespace Web.lqnew.opePages
{
    public partial class edit_role : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Boolean isCxbk = false;
            if (!Page.IsPostBack)
            {
                //Page.ClientScript.RegisterStartupScript(Page.GetType(), "getLangCancelImg", "<script>window.parent.mycallfunction(geturl());</script>");
                cancel.Src = ResourceManager.GetString("Lang-Cancel");
                try
                {
                   
                    int roleId = int.Parse(Request.QueryString["id"]);
                    ViewState["roleId"] = roleId;
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "Lang2localfunc", "<script>Lang2localfunc();</script>");

                    ImageButton1.ImageUrl = ResourceManager.GetString("LangConfirm");
                    List<Power> powerList = new List<Power>();

                    string language = System.Configuration.ConfigurationManager.AppSettings["defaultLanguage"];
                    DataTable dtPowerFuntion = Role.GetPowerFunction();
                    string rolePower = Role.GetPowerByRoleId(roleId).Rows[0]["POWER"].ToString();
                    if (language.ToLower() == "zh-cn")
                    {
                        Dispatcher.InnerText = Role.GetPowerByRoleId(roleId).Rows[0]["RoleName"].ToString();
                    }
                    else
                    {
                        Dispatcher.InnerText = Role.GetPowerByRoleId(roleId).Rows[0]["EnRoleName"].ToString();
                    }

                    if (language.ToLower() == "zh-cn")
                    {
                        for (int i = 0; i < dtPowerFuntion.Rows.Count; i++)
                        {
                            string powerName = dtPowerFuntion.Rows[i]["PowerName"].ToString();
                            Int32 powerValue = Int32.Parse(rolePower.Substring(i, 1));
                            Power P = new Power();
                            P.powerName = powerName;
                            P.powerVaue = powerValue;
                            powerList.Add(P);
                        }
                    }
                    else
                    {
                        for (int i = 0; i < dtPowerFuntion.Rows.Count; i++)
                        {
                            string powerName = dtPowerFuntion.Rows[i]["EnPowerName"].ToString();
                            Int32 powerValue = Int32.Parse(rolePower.Substring(i, 1));
                            Power P = new Power();
                            P.powerName = powerName;
                            P.powerVaue = powerValue;
                            powerList.Add(P);
                        }

                    }

                    chkListPower.DataTextField = "powerName";
                    chkListPower.DataValueField = "powerVaue";
                    chkListPower.DataSource = powerList;
                    chkListPower.DataBind();


                    for (int k = 0; k < chkListPower.Items.Count; k++)
                    {
                        string powerValue = rolePower.Substring(k, 1);
                        if (chkListPower.Items[k].Value == "1")
                        {
                            chkListPower.Items[k].Selected = true;
                            if (chkListPower.Items[k].Text == "控件启用" || chkListPower.Items[k].Text == "ActiveX Enable")
                            {
                                chkListPower.Items[k].Enabled = false;
                            }
                        }
                        chkListPower.Items[k].Attributes.Add("style", "width:140px;display:block;float:left");
                    }
                    if (roleId == 1)
                    {
                        chkListPower.Enabled = false;
                        ImageButton1.Enabled = false;
                        cancel.Disabled = true;
                    }
                    foreach (ListItem item in chkListPower.Items)
                    {
                        item.Attributes.Add("onclick", "check(this)");
                    }
                }

                catch (Exception ex1) { }
            }
            else
            {
                for (int k = 0; k < chkListPower.Items.Count; k++)
                {
                    chkListPower.Items[k].Attributes.Add("style", "width:140px;display:block;float:left");
                    chkListPower.Items[k].Attributes.Add("onclick", "check(this)");
                }

            }

        }

        public void ChangeCXBKEanbleState(Boolean isCxbk)
        {
            if (isCxbk)
            {
                for (int k = 0; k < chkListPower.Items.Count; k++)
                {
                    if (chkListPower.Items[k].Text.Trim() == "个短消息" || chkListPower.Items[k].Text.Trim() == "Personal SMS")
                        chkListPower.Items[k].Enabled = false;
                    if (chkListPower.Items[k].Text.Trim() == "动态重组" || chkListPower.Items[k].Text.Trim() == "Dynamic Reorganization")
                        chkListPower.Items[k].Enabled = false;
                    if (chkListPower.Items[k].Text.Trim() == "GPS控制" || chkListPower.Items[k].Text.Trim() == "GPS Control")
                        chkListPower.Items[k].Enabled = false;
                }

            }
            else
            {
                for (int k = 0; k < chkListPower.Items.Count; k++)
                {
                    if (chkListPower.Items[k].Text.Trim() == "个短消息" || chkListPower.Items[k].Text.Trim() == "Personal SMS")
                        chkListPower.Items[k].Enabled = true;
                    if (chkListPower.Items[k].Text.Trim() == "动态重组" || chkListPower.Items[k].Text.Trim() == "Dynamic Reorganization")
                        chkListPower.Items[k].Enabled = true;
                    if (chkListPower.Items[k].Text.Trim() == "GPS控制" || chkListPower.Items[k].Text.Trim() == "GPS Control")
                        chkListPower.Items[k].Enabled = true;
                }
            }

        }

        public class Power
        {
            public string powerName { get; set; }
            public Int32 powerVaue { get; set; }
        }
        protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
        {
            try
            {
                string power = "";
                for (int k = 0; k < chkListPower.Items.Count; k++)
                {
                    if (chkListPower.Items[k].Selected == true)
                    {
                        power = power + "1";
                    }
                    else
                        power = power + "0";
                }

                int i = Role.UpdatePowerByRoleId(int.Parse(ViewState["roleId"].ToString()), power);
                if (i == 1)
                {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("Lang_ModifySucc") + "');</script>");
                }
                else
                {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("Lang_ModifyFail") + "');</script>");

                }
            }
            catch (Exception ex)
            {

                Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("Lang_ModifyFail") + "');</script>");
            }
        }

        //protected void chkListPower_SelectedIndexChanged(object sender, EventArgs e)
        //{
        //    CheckBoxList chklist = (CheckBoxList)sender;
        //    Boolean isCXBK = false;
        //    for (int k = 0; k < chklist.Items.Count; k++)
        //    {
        //        if ((chklist.Items[k].Text.Trim() == "查询布控" || chklist.Items[k].Text.Trim() == "Arrangement") && chklist.Items[k].Selected == true)
        //        {
        //            isCXBK = true;

        //        }
        //    }
        //    if (isCXBK == true)
        //    {
        //        for (int k = 0; k < chklist.Items.Count; k++)
        //        {
        //            if (chklist.Items[k].Text.Trim() == "个短消息" || chklist.Items[k].Text.Trim() == "Personal SMS")
        //                chklist.Items[k].Selected = true;
        //            if (chklist.Items[k].Text.Trim() == "动态重组" || chklist.Items[k].Text.Trim() == "Dynamic Reorganization")
        //                chklist.Items[k].Selected = true;
        //            if (chklist.Items[k].Text.Trim() == "GPS控制" || chklist.Items[k].Text.Trim() == "GPS Control")
        //                chklist.Items[k].Selected = true;
        //        }
        //    }

        //}
    }
}