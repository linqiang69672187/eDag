#region Version Info
/*=================版本信息======================
*Copyright (C)     QJJ
*All rights reserved
*guid1:            d1643b22-dc08-4be7-adee-d868f14c1317
*作者：	           QJJ
*当前登录用户名:   zhkk
*机器名称:         RT-QIJIANJ
*注册组织名:       Microsoft
*CLR版本:          4.0.30319.18052
*当前工程名：      $safeprojectname$
*工程名：          $projectname$
*新建项输入的名称: Manage_ProcedureType
*命名空间名称:     Web.lqnew.opePages
*文件名:           Manage_ProcedureType
*当前系统时间:     2013/11/21 9:40:55
*创建年份:         2013
*版本：
*
*功能说明：       
* 
* 修改者： 
* 时间：	   2013/11/21 9:40:55
* 修改说明：
*======================================================
*/
#endregion

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Web.lqnew.opePages
{
    public partial class Manage_ProcedureAdd : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Page.ClientScript.RegisterStartupScript(Page.GetType(), "LanguageSwitch", "<script>LanguageSwitch(window.parent);</script>");
            Page.ClientScript.RegisterStartupScript(Page.GetType(), "resizediv", "<script>window.document.getElementById(\"Lang_AddOneLine\").src = window.parent.GetTextByName('Lang_AddNew', window.parent.useprameters.languagedata);</script>");
        }
    }
}