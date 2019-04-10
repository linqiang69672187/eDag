using Ryu666.Components;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Transactions;
using System.Web.UI;
using System.Web.UI.WebControls;
namespace Web.UserChangEntity
{
    public partial class UserChangeRecover : System.Web.UI.Page
    {        
        private int ChangedCount = 0;
        private int delCount = 0;
        private bool changeErr = false;
        
        int ShiwuTimeoutSeconds = 60;
        String[,] AllEntity;
        protected void Page_Load(object sender, EventArgs e)
        {
            //MultiLanguages
            Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>LanguageSwitch(window.parent.parent);</script>");
            
            gridview_userchangelog.Columns[1].HeaderText = ResourceManager.GetString("Lang_ChangeEntityBatch");
            gridview_userchangelog.Columns[2].HeaderText = ResourceManager.GetString("Lang_ToEntity");
            gridview_userchangelog.Columns[3].HeaderText = ResourceManager.GetString("Lang_IsSelf");
            gridview_userchangelog.Columns[4].HeaderText = ResourceManager.GetString("Lang_Operateuser");
            gridview_userchangelog.Columns[5].HeaderText = ResourceManager.GetString("Lang_Operatetime");
            gridview_userchangelog.Columns[6].HeaderText = ResourceManager.GetString("Lang_IsRecover");
            gridview_userchangelog.Columns[7].HeaderText = ResourceManager.GetString("Lang_recovertime");
            gridview_userchangelog.Columns[8].HeaderText = ResourceManager.GetString("Lang_Operate");
            (gridview_userchangelog.Columns[8] as CommandField).SelectText = ResourceManager.GetString("Lang_Recover");
            SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["m_connectionString"]);
            conn.Open();
            InitData(conn);
            conn.Close();
        }

        #region 判断单位转移后是否再次被修改
        protected void IsChanged(int LogId)
        {
            try
            {
                SqlConnection connIsChange = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["m_connectionString"]);
                connIsChange.Open();
                String sql10 = "select AfterParentID from UserChangeLog where Id = " + LogId;
                DataTable dt = DbComponent.UChangeETree.ExecuteRead(connIsChange, sql10, "IsChange");
                String[] ParentIDs = dt.Rows[0][0].ToString().Split(';');
                for (int i = 0; i < ParentIDs.Length - 1; i++)
                {
                    String[] Ziduans = ParentIDs[i].Split(',');
                    String sql = "select " + Ziduans[1] + " from " + Ziduans[0] + " where Id = " + Ziduans[2];
                    DataTable dt11 = DbComponent.UChangeETree.ExecuteRead(connIsChange, sql, "Parent");
                    if (dt.Rows.Count == 0) {
                        delCount++;
                    }
                    else if (dt11.Rows[0][0].ToString() != Ziduans[3])
                    {
                        ChangedCount++;

                    }
                }
                connIsChange.Close();
            }
            catch (System.IndexOutOfRangeException ex)
            {
                //Response.Write(ResourceManager.GetString("Lang_ChangeEntityNotExist"));
                Label1.Text = ResourceManager.GetString("Lang_ChangeEntityNotExist");
                changeErr = true;
                return;
            }
        }
        #endregion
        
        #region 恢复用户单位
        protected void UserEntityRecover(int LogId)
        {
            if (changeErr == true)
                return;

            //事务回滚
            TransactionOptions transactionOption = new TransactionOptions();
            // 设置事务超时时间为60秒
            transactionOption.Timeout = new TimeSpan(0, 0, ShiwuTimeoutSeconds);
            using (TransactionScope scope = new TransactionScope())
            {
                try
                {
                    SqlConnection connRecover = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["m_connectionString"]);
                    connRecover.Open();
                    String sql20 = "select ContentChanged from UserChangeLog where Id = " + LogId;
                    DataTable dt20 = DbComponent.UChangeETree.ExecuteRead(connRecover, sql20, "IsChange1");
                    String[] ContentChange = dt20.Rows[0][0].ToString().Split(';');

                    SqlCommand cmd = new SqlCommand();
                    cmd.Connection = connRecover;
                    for (int i = 0; i < ContentChange.Length - 1; i++)
                    {
                        String[] Ziduans = ContentChange[i].Split(',');
                        String sql = "update " + Ziduans[0] + " set " + Ziduans[1] + " = " + Ziduans[2] + " where Id = " + Ziduans[4];
                        cmd.CommandText = sql;
                        cmd.ExecuteNonQuery();
                    }
                    String sqlisrecover = "update UserChangeLog set IsRecover = " + 1 + ", recovertime = '" + DateTime.Now.ToLocalTime() + "' where Id = " + LogId;
                    cmd.CommandText = sqlisrecover;
                    cmd.ExecuteNonQuery();

                    scope.Complete();

                    Label1.Text = ResourceManager.GetString("Lang_RecoverSucc");
                    InitData(connRecover);
                    connRecover.Close();
                }
                catch (Exception ex)
                {
                    Response.Write(ex);
                    Label1.Text = ResourceManager.GetString("Lang_RecoverFail");
                    return;
                }
            }
        }
        #endregion

        //恢复受影响的数据行
        protected void ChangeRecover(object sender, GridViewCommandEventArgs e)
        {
            string DispatchUser = Request.Cookies["username"].Value;
            Label1.Text = "";
            int Rowindex = int.Parse(e.CommandArgument.ToString());
            string LogIdString = gridview_userchangelog.DataKeys[Rowindex].Values["Id"].ToString();
            int LogId = int.Parse(LogIdString);
            String Sql0 = "select OperateUser,ContentChanged from UserChangeLog where Id = " + LogId;
            DataTable dt0 = DbComponent.UChangeETree.ExecuteReadconn(Sql0, "OperateUser");
            string Operateuser1 = dt0.Rows[0][0].ToString();
            string contentChanged = dt0.Rows[0][1].ToString();

            //判断恢复时是否已恢复父级单位
            string[] arrChanged = contentChanged.Split(new char[] { ';' }, StringSplitOptions.RemoveEmptyEntries);
            List<string> parentChanged=new List<string>();
            for (int k = 0; k < arrChanged.Length; k++)
            {
                if (arrChanged[k].ToLower().Contains("entity,parentid"))
                    parentChanged.Add(arrChanged[k]);
            }
            //Entity,ParentID,4,5,6;Entity,ParentID,4,5,10; 
            Boolean isRecoverParentEntity=true;
            string parentName = "";
            for (int i = 0; i < parentChanged.Count; i++)
            {
                string entityId = parentChanged[i].Split(',')[4].Trim();
                string cureentParentId = parentChanged[i].Split(',')[3].Trim();
                string recoverParentId = parentChanged[i].Split(',')[2].Trim();

                String sqlEntity = "select ID,Name from Entity where ParentID="+entityId;
                DataTable entity = DbComponent.UChangeETree.ExecuteReadconn(sqlEntity, "sqlEntity");
                for (int h = 0; h < entity.Rows.Count; h++)
                {
                    if (entity.Rows[h][0].ToString() == recoverParentId)
                    {
                        isRecoverParentEntity = false;
                        parentName = entity.Rows[h][1].ToString();
                        break;
                    }
                }
                if (!isRecoverParentEntity)
                {
                    break;
                }

            }
            if (!isRecoverParentEntity)
            {
                
                Response.Write("<script>alert('" + ResourceManager.GetString("Lang_RecoverPreviousUnit") + "');location.href='UserChangeRecover.aspx';</script>");
                Response.End();
            }
            else
            {

                //权限判断
                if (DispatchUser == Operateuser1)
                {
                    try
                    {
                        String Sql110 = "select IsRecover from UserChangeLog where Id = " + LogId;
                        DataTable dt110 = DbComponent.UChangeETree.ExecuteReadconn(Sql110, "IsRecover");
                        if (dt110.Rows[0][0].ToString() == "0")
                        {
                            IsChanged(LogId);

                            if (ChangedCount == 0 && delCount == 0)
                            {
                                UserEntityRecover(LogId);
                            }
                            else if (ChangedCount != 0 && delCount == 0)
                            {
                                Label1.Text = ResourceManager.GetString("Lang_HasSeveralChanged_1") + ChangedCount + ResourceManager.GetString("Lang_HasSeveralChanged_2") + ResourceManager.GetString("Lang_recoverycannotperform");
                                return;
                            }
                            else if (ChangedCount == 0 && delCount != 0)
                            {
                                Label1.Text = ResourceManager.GetString("Lang_HasSeveralChanged_1") + delCount + ResourceManager.GetString("Lang_HasSeveraldeled_2") + ResourceManager.GetString("Lang_recoverycannotperform");
                                return;
                            }
                            else if (ChangedCount != 0 && delCount != 0)
                            {
                                Label1.Text = ResourceManager.GetString("Lang_HasSeveralChanged_1") + ChangedCount + ResourceManager.GetString("Lang_HasSeveralChanged_2") + " , " + delCount + ResourceManager.GetString("Lang_HasSeveraldeled_2") + ResourceManager.GetString("Lang_recoverycannotperform");
                                return;
                            }
                        }
                        else
                        {
                            Label1.Text = ResourceManager.GetString("Lang_HasRecovered");
                            return;
                        }
                    }
                    catch (Exception ex)
                    {
                        Response.Write(ex);
                        return;
                    }
                }
                else
                {
                    Label1.Text = ResourceManager.GetString("Lang_NotYouOperated");
                    return;
                }
            }
        }

        #region 获取历史数据
        private void InitData(SqlConnection conn)
        {            
            //读取所有单位信息
            String sqlentity = "select [ID], [Name] from [Entity]";
            DataTable dtentity = DbComponent.UChangeETree.ExecuteRead(conn, sqlentity, "Entityinfo");
            AllEntity = new string[dtentity.Rows.Count, 2];
            for (int i = 0; i < dtentity.Rows.Count; i++)
            {
                AllEntity[i, 0] = dtentity.Rows[i][0].ToString();
                AllEntity[i, 1] = dtentity.Rows[i][1].ToString();
            }

            //读取历史数据
            String sqlread = "select Id,FromEntity,ToEntity, IsSelf, OperateUser, time, IsRecover, recovertime from UserChangeLog order by id Desc";
            SqlDataAdapter da = new SqlDataAdapter(sqlread, conn);
            DataSet ds = new DataSet();
            da.Fill(ds);
            //GridView数据绑定
            gridview_userchangelog.DataSource = ds;
            gridview_userchangelog.DataBind();
        }
        #endregion

        protected void gridview_userChangeRecover_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            try
            {
                if (e.Row.RowType == DataControlRowType.DataRow)
                {
                    ResourceManager.GetString("Lang_Operate");
                    for (int j = 0; j < AllEntity.Length / 2; j++)
                    {
                        if (AllEntity[j, 0] != null)
                        {
                            if (e.Row.Cells[1].Text == AllEntity[j, 0])
                                e.Row.Cells[1].Text = AllEntity[j, 1];
                            if (e.Row.Cells[2].Text == AllEntity[j, 0])
                                e.Row.Cells[2].Text = AllEntity[j, 1];
                        }
                        else
                            break;
                    }
                    if (e.Row.Cells[3].Text == "1")
                        e.Row.Cells[3].Text = ResourceManager.GetString("Lang_Yes");
                    else
                        e.Row.Cells[3].Text = ResourceManager.GetString("Lang_No");

                    if (e.Row.Cells[6].Text == "1")
                        e.Row.Cells[6].Text = ResourceManager.GetString("Lang_Yes");
                    else
                        e.Row.Cells[6].Text = ResourceManager.GetString("Lang_No");
                    
                    string DispatchUser = Request.Cookies["username"].Value;
                    if (DispatchUser != e.Row.Cells[4].Text)
                    {                       
                        e.Row.Cells[8].ForeColor = System.Drawing.Color.Gray;
                    }
                    
                }
            }
            catch (Exception ex)
            {
                Response.Write(ex);
            }
        }
    }
}