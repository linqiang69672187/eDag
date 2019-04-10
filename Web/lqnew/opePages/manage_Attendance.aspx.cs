
using Ryu666.Components;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using OfficeComponent;
using System.Collections;

namespace Web.lqnew.opePages
{
    public partial class manage_Attendance : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            lb_LCXZ.Text = ResourceManager.GetString("Lang_selectliuc");
            lb_LCXZ2.Text = ResourceManager.GetString("Lang_selectliuc");
            lb_PleaseXZLC.Text = ResourceManager.GetString("Lang_pleaseselectliuc");
            lb_PleaseXZLC2.Text = ResourceManager.GetString("Lang_pleaseselectliuc");
            Lang_Manage_GoOut_Today_Count.Text = ResourceManager.GetString("Lang_Manage_GoOut_Today_Count");
            lab_countName.Text = ResourceManager.GetString("Lang_StateName");//状态名称
            Condition.Text = ResourceManager.GetString("Lang_Condition"); //统计条件
            //Lang_IsFreshRecordSheet.Text = ResourceManager.GetString("Lang_IsFreshRecordSheet");
            Lang_Count.Text = ResourceManager.GetString("Lang_Count");//车辆数
            //Lang_ToLook.Text = ResourceManager.GetString("Lang_ToLook");
            //if (System.Configuration.ConfigurationManager.AppSettings["OpenWindow"] == "1")
            //{
            //    Page.ClientScript.RegisterStartupScript(Page.GetType(), "resizediv", "<script>  window.parent.lq_changeheight(geturl(), document.body.clientHeight);window.parent.change(geturl());</script>");
            //}
        }
    }
}