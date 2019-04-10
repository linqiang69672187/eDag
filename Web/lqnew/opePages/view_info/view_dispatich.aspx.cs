#region Author
/*
 *Modules:
 *CreateTime:2011-07-26
 *Author:杨德军    
 *Company:Eastcom
 **/

#endregion
using System;
using System.Web.UI;

namespace Web.lqnew.opePages.view_info
{
    public partial class view_dispatich : System.Web.UI.Page
    {
        /// <summary>
        /// 调度台数据库操作句柄
        /// </summary>
        private DbComponent.IDAO.IDispatchInfoDao DispatchInfoService
        {
            get
            {
                return DbComponent.FactoryMethod.DispatchInfoFactory.CreateDispatchInfoDao();
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack && Request.QueryString["id"] != null)
            {
                MyModel.Model_Dispatch_View dispatch_detail = DispatchInfoService.GetModelDispatchViewByID(int.Parse(Request.QueryString["id"]));
                tb1.Rows[0].Cells[1].InnerHtml = "&nbsp;&nbsp;" + dispatch_detail.ISSI;
                tb1.Rows[1].Cells[1].InnerHtml = "&nbsp;&nbsp;" + dispatch_detail.EntityName;
                tb1.Rows[2].Cells[1].InnerHtml = "&nbsp;&nbsp;" + dispatch_detail.IPAddress;
            }
        }
    }
}