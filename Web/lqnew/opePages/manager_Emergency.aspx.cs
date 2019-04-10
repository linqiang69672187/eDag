using DbComponent;
using DbComponent.FactoryMethod;
using DbComponent.IDAO;
using Ryu666.Components;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Transactions;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Drawing;

namespace Web.lqnew.opePages
{
    public partial class manager_Emergency : BasePage
    {
        private static IList<MyModel.Model_UserType> UTList = new List<MyModel.Model_UserType>();
        private IUserTypeDao CreateUserTypeDaoService
        {
            get
            {
                return DispatchInfoFactory.CreateUserTypeDao();
            }
        }
        private DbComponent.login LoginDaoService
        {
            get
            {
                return new DbComponent.login();
            }
        }

        public class Units
        {
            public string entityId { get; set; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {

            if (!Page.IsPostBack)
            {
                DbComponent.userinfo DropList = new DbComponent.userinfo();
                this.DropDownList2.DataSource = DropList.DropEmergency().DefaultView;
                this.DropDownList2.DataTextField = "TypeName";
                this.DropDownList2.DataValueField = "TypeId";
                this.DropDownList2.DataBind();
                ListItem item = new ListItem(ResourceManager.GetString("Lang_Log_All"), "0");
                DropDownList2.Items.Insert(0, item);

                UTList = CreateUserTypeDaoService.GetAllForList();
                if (System.Configuration.ConfigurationManager.AppSettings["OpenWindow"] == "1")
                {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "resizediv", "<script>  window.parent.lq_changeheight(geturl(), document.body.clientHeight);window.parent.change(geturl());</script>");
                }
                if (Request.QueryString["id"] != null)
                {
                    userul.Visible = false;
                }
            }
            else
            {
                if (System.Configuration.ConfigurationManager.AppSettings["OpenWindow"] == "1")
                {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "resizediv", "<script>  window.parent.lq_changeheight(geturl(), document.body.clientHeight);</script>");
                }
            }

   
            ImageButton3.ImageUrl = ResourceManager.GetString("Lang_Search2");

            GridView1.EmptyDataText = ResourceManager.GetString("NoData");
            GridView1.Columns[0].HeaderText = "ID";
            GridView1.Columns[1].HeaderText = ResourceManager.GetString("Lang_Name");//名称
            GridView1.Columns[2].HeaderText = ResourceManager.GetString("Lang_style");//类型
            GridView1.Columns[3].HeaderText = ResourceManager.GetString("Date");//日期
            GridView1.Columns[4].HeaderText = ResourceManager.GetString("Lang_ToLook");//查看
            GridView1.Columns[5].HeaderText = ResourceManager.GetString("Delete");  //删除
 

        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            try
            {
                if (e.Row.RowType == DataControlRowType.DataRow)
                {
                    string nodata = ResourceManager.GetString("Nodata");
                    e.Row.Attributes.Add("onmouseover", "changeTgBg(this,'font',2)");
                    e.Row.Attributes.Add("onmouseout", "overchangeTgBg(this,'font',2)");

                    e.Row.Cells[1].Text = "&nbsp;&nbsp;" + e.Row.Cells[1].Text;

                    e.Row.Cells[2].Text = "&nbsp;&nbsp;" + e.Row.Cells[2].Text;

                    e.Row.Cells[3].Text = "&nbsp;&nbsp;" + e.Row.Cells[3].Text;

                  
                }
            }
            catch (Exception ex)
            {

            }

        }


        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            switch (e.CommandName)
            {
                case "Query": //查看
                    if (!string.IsNullOrEmpty(e.CommandArgument.ToString()))
                    {
                        try
                        {

                            string[] arg = e.CommandArgument.ToString().Split(',');
                            string id = arg[0];
                            string FileName = arg[1];

                            string ext = FileName.Substring(FileName.LastIndexOf(".")+1);

                            string sPath = System.IO.Path.GetDirectoryName(Page.Request.PhysicalPath);
                            sPath = sPath + "\\UpLoad\\File\\" + FileName;

                            //判断文件夹是否存在
                            if (!Directory.Exists(System.IO.Path.GetDirectoryName(Page.Request.PhysicalPath) + "\\UpLoad\\File"))
                            {
                                Directory.CreateDirectory(System.IO.Path.GetDirectoryName(Page.Request.PhysicalPath) + "\\UpLoad\\File");
                            }

                            using (FileStream fsWrite = new FileStream(sPath, FileMode.OpenOrCreate, FileAccess.Write))
                            {

                                DbComponent.userinfo userByte = new DbComponent.userinfo();
                                DataTable dt = userByte.ByteEmergency(int.Parse(id));

                                byte[] byteArray = (byte[])dt.Rows[0][3];

                                fsWrite.Write(byteArray, 0, byteArray.Length);


                            }

                            string strFilePath = sPath;
                            FileInfo fileInfo = new FileInfo(strFilePath);
                            Response.Clear();
                            Response.AddHeader("content-disposition", "attachment;filename=" + Server.UrlEncode(fileInfo.Name.ToString()));
                            Response.AddHeader("content-length", fileInfo.Length.ToString());
                            if (ext == "doc" || ext == "docx")
                            {
                                Response.ContentType = "application/msword";
                            }
                            else
                            {
                                Response.ContentType = "application/vnd.ms-excel";

                            }
                            //Response.ContentType = "application/octet-stream";
                            Response.ContentEncoding = System.Text.Encoding.Default;
                            Response.WriteFile(strFilePath);
                            Response.Flush();
                            Response.End();


                            ////Response.Write("<script>window.open('/lqnew/opePages/UpLoad/File/" + FileName + "','_blank');</script>");
                            ////Response.End();

                            //Response.ContentType = "application/msword";
                            //Response.AddHeader("Content-Disposition", "attachment;filename="+FileName);
                            ////string filename = Server.MapPath("DownLoad/z.zip");
                            //Response.TransmitFile(sPath);



                           


                        }
                        catch (Exception ex)
                        {
                            Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ex.Message + "');</script>");
                        
                        }
                    }
                    else
                    {
                        Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("ISNO") + "');</script>");
                    
                    }
                    break;

                case "MyDel"://删除
                    if (!string.IsNullOrEmpty(e.CommandArgument.ToString()))
                    {
                        try
                        {
                            string[] arg = e.CommandArgument.ToString().Split(',');
                            string id = arg[0];
                            string FileName= arg[1];

                            DbComponent.userinfo userinfo = new DbComponent.userinfo();
                            userinfo.DelEmergency(int.Parse(id));
                            Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("OperationSuccessful") + "');window.parent.reloadtree();window.parent.lq_changeifr('manager_Emergency');</script>");
                            //文件刪除
                            string sPath = System.IO.Path.GetDirectoryName(Page.Request.PhysicalPath);
                            sPath = sPath + "\\UpLoad\\File\\" + FileName;
                            File.Delete(sPath);
                        }
                        catch (Exception ex)
                        {

                            Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ex.Message + "');</script>");
                        }

                    }
                    else
                    {
                        Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("DelFail_NotExist") + "');</script>");

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

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }






    }
}