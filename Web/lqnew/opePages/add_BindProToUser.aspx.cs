using Ryu666.Components;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DbComponent;
using DbComponent.StatuesManage;
using System.Data;
using System.Data.SqlClient;

namespace Web.lqnew.opePages
{
    public partial class add_BindProToUser : System.Web.UI.Page
    {
        private ProcedureDao ProceDureService = new ProcedureDao();
        protected void Page_Load(object sender, EventArgs e)
        {
            Page.ClientScript.RegisterStartupScript(Page.GetType(), "ddsds", "<script>  todo(); </script>");

            if (!Page.IsPostBack)
            {

                ImageButton1.ImageUrl = ResourceManager.GetString("LangConfirm");
                ImageButton2.ImageUrl = ResourceManager.GetString("Lang-Cancel");
                lb_Uylcbd.Text = ResourceManager.GetString("Lang_lcyhbd");
                Lang_userselect.Text = ResourceManager.GetString("Lang_userselect");
                Lang_onlycanselect.Text = string.Format(ResourceManager.GetString("Lang_onlycanselect"), 100);
                Lang_baseinfowrite.Text = ResourceManager.GetString("Lang_baseinfowrite");
                Lang_opeResultArea.Text = ResourceManager.GetString("Lang_opeResultArea");


                lb_lcbd.Text = ResourceManager.GetString("Lang_pleaseselectliuc");
                lb_Userselect.Text = ResourceManager.GetString("Lang_please_select_user");

                DataTable dt = ProceDureService.getProcedureList();
                if (dt != null)
                {
                    ddl_LC.Items.Clear();
                    foreach (DataRow dr in dt.Rows)
                    {
                        ddl_LC.Items.Add(new ListItem(dr["name"].ToString(), dr["id"].ToString()));
                    }
                }
                bindzdy();


            }

        }
        private void bindzdy()
        {

            string lcid = ddl_LC.SelectedValue.ToString();
            string str_sql_zdy = @"select 
      [reserve1]
      ,[reserve2]
      ,[reserve3]
      ,[reserve4]
      ,[reserve5]
      ,[reserve6]
      ,[reserve7]
      ,[reserve8]
      ,[reserve9]
      ,[reserve10]
       from procedure_type  a left join _procedure  b on(a.name=b.pType ) where b.id=@pid";
            DataTable dt2 = SQLHelper.ExecuteRead(CommandType.Text, str_sql_zdy, "dss", new SqlParameter("pid", lcid));
            if (dt2 != null && dt2.Rows.Count > 0)
            {
                foreach (DataRow dr in dt2.Rows)
                {
                    if (dr["reserve1"].ToString() != "")
                    {
                        Tr1.Visible = true;
                        Label1.Text = dr["reserve1"].ToString();
                    }
                    else
                    {
                        Tr1.Visible = false;
                        TextBox1.Text = "";
                    }
                    if (dr["reserve2"].ToString() != "")
                    {
                        Tr2.Visible = true;
                        Label2.Text = dr["reserve2"].ToString();
                        TextBox2.Text = "";
                    }
                    else
                    {
                        Tr2.Visible = false;
                    }
                    if (dr["reserve3"].ToString() != "")
                    {
                        Tr3.Visible = true;
                        Label3.Text = dr["reserve3"].ToString();
                        TextBox3.Text = "";
                    }
                    else
                    {
                        Tr3.Visible = false;
                    }
                    if (dr["reserve4"].ToString() != "")
                    {
                        Tr4.Visible = true;
                        Label4.Text = dr["reserve4"].ToString();
                        TextBox4.Text = "";
                    }
                    else
                    {
                        Tr4.Visible = false;
                    }
                    if (dr["reserve5"].ToString() != "")
                    {
                        Tr5.Visible = true;
                        Label5.Text = dr["reserve5"].ToString();
                        TextBox5.Text = "";
                    }
                    else
                    {
                        Tr5.Visible = false;
                    }
                    if (dr["reserve6"].ToString() != "")
                    {
                        Tr6.Visible = true;
                        Label6.Text = dr["reserve6"].ToString();
                        TextBox6.Text = "";
                    }
                    else
                    {
                        Tr6.Visible = false;
                    }
                    if (dr["reserve7"].ToString() != "")
                    {
                        Tr7.Visible = true;
                        Label7.Text = dr["reserve7"].ToString();
                        TextBox7.Text = "";
                    }
                    else
                    {
                        Tr7.Visible = false;
                    }
                    if (dr["reserve8"].ToString() != "")
                    {
                        Tr8.Visible = true;
                        Label8.Text = dr["reserve8"].ToString();
                        TextBox8.Text = "";
                    }
                    else
                    {
                        Tr8.Visible = false;
                    }
                    if (dr["reserve9"].ToString() != "")
                    {
                        Tr9.Visible = true;
                        Label9.Text = dr["reserve9"].ToString();
                        TextBox9.Text = "";
                    }
                    else
                    {
                        Tr9.Visible = false;
                    }
                    if (dr["reserve10"].ToString() != "")
                    {
                        Tr10.Visible = true;
                        Label10.Text = dr["reserve10"].ToString();
                        TextBox10.Text = "";
                    }
                    else
                    {
                        Tr10.Visible = false;
                    }
                }
            }
            else
            {
                Tr1.Visible = false;
                Tr2.Visible = false;
                Tr3.Visible = false;
                Tr4.Visible = false;
                Tr5.Visible = false;
                Tr6.Visible = false;
                Tr7.Visible = false;
                Tr8.Visible = false;
                Tr9.Visible = false;
                Tr10.Visible = false;
                TextBox1.Text = "";
                TextBox2.Text = "";
                TextBox3.Text = "";
                TextBox4.Text = "";
                TextBox5.Text = "";
                TextBox6.Text = "";
                TextBox7.Text = "";
                TextBox8.Text = "";
                TextBox9.Text = "";
                TextBox10.Text = "";
            }
        }
        protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
        {
            string[] arrids = txtISSIValue.Value.ToString().Split(new char[] { ';' }, StringSplitOptions.RemoveEmptyEntries);
            string proid = ddl_LC.SelectedValue.ToString();
            if (arrids.Length <= 0)
            {
                lbpress.Text = ResourceManager.GetString("Lang_please_select_user");

                return;
            }
            lbpress.Text = ResourceManager.GetString("Lang_opisdoingnottoclosewindow") + "<br>";
            ImageButton1.Visible = false;
            ImageButton2.Visible = false;
            //判断是否存在

            foreach (string str in arrids)
            {
                if (isExistIssiInUserDuty(str, proid))
                {
                    lbpress.Text += string.Format(ResourceManager.GetString("Lang_bindfaildbecuseisbind"), str) + "<br>";
                }
                else
                {
                    try
                    {
                        DbComponent.SQLHelper.ExecuteNonQuery(System.Data.CommandType.StoredProcedure, "addUserToPro", new System.Data.SqlClient.SqlParameter("issi", str), new System.Data.SqlClient.SqlParameter("proid", proid), new System.Data.SqlClient.SqlParameter("r1", TextBox1.Text), new System.Data.SqlClient.SqlParameter("r2", TextBox2.Text), new System.Data.SqlClient.SqlParameter("r3", TextBox3.Text), new System.Data.SqlClient.SqlParameter("r4", TextBox4.Text), new System.Data.SqlClient.SqlParameter("r5", TextBox5.Text), new System.Data.SqlClient.SqlParameter("r6", TextBox6.Text), new System.Data.SqlClient.SqlParameter("r7", TextBox7.Text), new System.Data.SqlClient.SqlParameter("r8", TextBox8.Text), new System.Data.SqlClient.SqlParameter("r9", TextBox9.Text), new System.Data.SqlClient.SqlParameter("r10", TextBox10.Text), new System.Data.SqlClient.SqlParameter("remark", ""));
                        lbpress.Text += string.Format(ResourceManager.GetString("Lang_bindsucessed"), str) + "<br>";
                    }
                    catch (Exception ex)
                    {
                        lbpress.Text +=string.Format(ResourceManager.GetString("Lang_bindfaildbecuseisaddfaild"),str) + "<br>";
                    }
                }
            }
            lbpress.Text += ResourceManager.GetString("Lang_operover") + "<br>";
            ImageButton1.Visible = true;
            ImageButton2.Visible = true;

        }
        private bool isExistIssiInUserDuty(string issi, string pid)
        {
            bool flag = false;
            string strSQL = "SELECT Count(0) from user_duty where issi=@issi and procedure_id=@pid";
            DataTable dt = SQLHelper.ExecuteRead(CommandType.Text, strSQL, "bcd", new SqlParameter("issi", issi), new SqlParameter("pid", pid));
            if (dt != null && dt.Rows.Count > 0 && int.Parse(dt.Rows[0][0].ToString()) > 0)
            {
                flag = true;
            }
            return flag;
        }

        protected void ddl_LC_SelectedIndexChanged(object sender, EventArgs e)
        {
            bindzdy();
        }
    }
}