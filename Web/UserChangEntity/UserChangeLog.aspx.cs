using Ryu666.Components;
using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Web.UserChangEntity
{
    public partial class UserChangeLog : System.Web.UI.Page
    {
        String[,] AllEntity;        
        protected void Page_Load(object sender, EventArgs e)
        {
            Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>LanguageSwitch(window.parent.parent);</script>");
            
            try
            {
                gridview_userchangelog.Columns[0].HeaderText = ResourceManager.GetString("Lang_ChangeEntityBatch");
                gridview_userchangelog.Columns[1].HeaderText = ResourceManager.GetString("Lang_ToEntity");
                gridview_userchangelog.Columns[2].HeaderText = ResourceManager.GetString("Lang_IsSelf");
                gridview_userchangelog.Columns[3].HeaderText = ResourceManager.GetString("Lang_Operateuser");
                gridview_userchangelog.Columns[4].HeaderText = ResourceManager.GetString("Lang_Operatetime");
                gridview_userchangelog.Columns[5].HeaderText = ResourceManager.GetString("Lang_IsRecover");
                gridview_userchangelog.Columns[6].HeaderText = ResourceManager.GetString("Lang_recovertime");

                SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["m_connectionString"]);
                conn.Open();
                //读取所有单位信息
                String sqlentity = "select [ID], [Name] from [Entity]";
                DataTable dtentity = DbComponent.UChangeETree.ExecuteRead(conn, sqlentity, "Entityinfo");
                AllEntity = new string[dtentity.Rows.Count, 2];
                for (int i = 0; i < dtentity.Rows.Count; i++)
                {
                    AllEntity[i,0] = dtentity.Rows[i][0].ToString();
                    AllEntity[i,1] = dtentity.Rows[i][1].ToString();
                }

                //读取历史数据
                String sqlread = "select FromEntity,ToEntity, IsSelf, OperateUser, time, IsRecover, recovertime from UserChangeLog order by id Desc";
                SqlDataAdapter da = new SqlDataAdapter(sqlread, conn);
                DataSet ds = new DataSet();
                da.Fill(ds);
                //GridView数据绑定
                gridview_userchangelog.DataSource = ds;
                gridview_userchangelog.DataBind();
                                
                conn.Close();
            }
            catch(Exception ex)
            {
                Response.Write(ex);
            }
        }

        protected void gridview_userchangelog_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            try
            {
                if (e.Row.RowType == DataControlRowType.DataRow)
                {
                    for (int j = 0; j < AllEntity.Length / 2; j++)
                    {
                        if (AllEntity[j, 0] != null)
                        {
                            if (e.Row.Cells[0].Text == AllEntity[j, 0])
                                e.Row.Cells[0].Text = AllEntity[j, 1];
                            if (e.Row.Cells[1].Text == AllEntity[j, 0])
                                e.Row.Cells[1].Text = AllEntity[j, 1];
                        }
                        else
                            break;
                    }
                    if (e.Row.Cells[2].Text == "1")
                        e.Row.Cells[2].Text = ResourceManager.GetString("Lang_Yes");
                    else
                        e.Row.Cells[2].Text = ResourceManager.GetString("Lang_No");

                    if (e.Row.Cells[5].Text == "1")
                        e.Row.Cells[5].Text = ResourceManager.GetString("Lang_Yes");
                    else
                        e.Row.Cells[5].Text = ResourceManager.GetString("Lang_No");
                }
            }
            catch(Exception ex)
            {
                Response.Write(ex);
            }
        }
    }
}