using DbComponent;
using Ryu666.Components;
using System;
using System.Data;
using System.Data.SqlClient;
using System.Transactions;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace Web.lqnew.opePages
{
    public partial class FixedStation : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            DropDownList1.Items[0].Text = ResourceManager.GetString("SelectEntity");
            GridView1.EmptyDataText = ResourceManager.GetString("NoData");
            GridView1.Columns[0].HeaderText = ResourceManager.GetString("Identification");
            GridView1.Columns[1].HeaderText = ResourceManager.GetString("Subordinateunits");
            GridView1.Columns[2].HeaderText = ResourceManager.GetString("zhuliuzu");


        }
        protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
        {
            GridView1.PageIndex = 0;
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Attributes.Add("onmouseover", "changeTgBg(this,'font',2)");
                e.Row.Attributes.Add("onmouseout", "overchangeTgBg(this,'font',2)");
                LinkButton linkbtn = (LinkButton)e.Row.FindControl("ImageButton2");
                if (linkbtn != null)
                {
                    linkbtn.OnClientClick = @"javascript:return confirm('" + ResourceManager.GetString("BeSureToDelete") + "['+this.parentElement.parentElement.getElementsByTagName('font')[0].innerText.trim()+']?')";
                }
            }
        }
        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            switch (e.CommandName)
            {
                case "MyDel":
                    DbComponent.userinfo funuserinfo = new DbComponent.userinfo();
                    int ID = int.Parse(e.CommandArgument.ToString());
                    using (TransactionScope scope = new TransactionScope())
                    {

                        try
                        {
                            SQLHelper.ExecuteNonQuery(CommandType.Text, "DELETE FROM [FixedStation_info] WHERE [ID]=@id", new SqlParameter("id", ID));
                            funuserinfo.DelUserinfo_byid(ID);
                            scope.Complete();
                            Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("OperationSuccessful") + "');window.parent.lq_changeifr('FixedStation');window.parent.reloadtree();</script>");
                        }
                        catch (Exception ex)
                        {
                            log.Error(ex);
                            Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("Operationfails") + "');</script>");
                        }
                    }
                    break;
            }
        }

    }
}