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

namespace Web.lqnew.opePages
{
    public partial class manager_user : BasePage
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
        protected void Page_Load(object sender, EventArgs e)
        {


            

           Page.ClientScript.RegisterStartupScript(Page.GetType(), "resizediv", "<script>window.document.getElementById(\"Lang_AddNew\").src = window.parent.GetTextByName('Lang_AddNew', window.parent.useprameters.languagedata);</script>");


            if (!Page.IsPostBack)
            {
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
            DropDownList1.Items[0].Text = ResourceManager.GetString("SelectEntity");
            DropDownList2.Items[0].Text = ResourceManager.GetString("Username");
            DropDownList2.Items[1].Text = ResourceManager.GetString("Serialnumber");
            DropDownList2.Items[2].Text = ResourceManager.GetString("Lang_terminal_identification");
            ImageButton1.ImageUrl = ResourceManager.GetString("Lang_Search2");
            Lang_ExternalUser.ImageUrl = ResourceManager.GetString("Lang_ExternalUser");
            GridView1.EmptyDataText = ResourceManager.GetString("NoData");
            GridView1.Columns[0].HeaderText = ResourceManager.GetString("Lang_Location");
            GridView1.Columns[1].HeaderText = ResourceManager.GetString("Username");
            GridView1.Columns[2].HeaderText = ResourceManager.GetString("Serialnumber");
            GridView1.Columns[3].HeaderText = ResourceManager.GetString("Lang_terminal_identification");
            GridView1.Columns[4].HeaderText = ResourceManager.GetString("Lang_Subordinateunits");
            GridView1.Columns[5].HeaderText = ResourceManager.GetString("Type");
            GridView1.Columns[6].HeaderText = ResourceManager.GetString("Lang_telephone");
            GridView1.Columns[7].HeaderText = ResourceManager.GetString("Lang_position");
            GridView1.Columns[8].HeaderText = ResourceManager.GetString("external_system");
            GridView1.Columns[9].HeaderText = ResourceManager.GetString("IsView");

        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Attributes.Add("onmouseover", "changeTgBg(this,'font',2)");
                e.Row.Attributes.Add("onmouseout", "overchangeTgBg(this,'font',2)");
                e.Row.Cells[2].Text = "&nbsp;&nbsp;" + e.Row.Cells[2].Text;
                DbComponent.Entity funEntity = new DbComponent.Entity();
                e.Row.Cells[4].Text = "&nbsp;&nbsp;" + funEntity.GetEntityinfo_byid(int.Parse(e.Row.Cells[4].Text)).Name;
                funEntity = null;
                e.Row.Cells[3].Text += "&nbsp;&nbsp;";
                string type = "<img src='../images/type_img_person.png'  />";

                MyModel.Model_UserType myUT = UTList.Where(a => a.TypeName.ToString().Equals(GridView1.DataKeys[e.Row.RowIndex][1].ToString())).FirstOrDefault();
                //if (myUT != null)
                //{
                //    e.Row.Cells[5].Text = "<img style='width:15px; height:25px' src='UpLoad/tempusertypepic/" + myUT.TypeName + "/3.png' title='" + myUT.TypeName + "' />";
                //}
                //else
                //{
                //    e.Row.Cells[5].Text = type;
                //}
                ImageButton imgbtn1 = (ImageButton)e.Row.Cells[5].FindControl("ImageButton1");
                string HDISSI = DbComponent.login.GETHDISSI(Request.Cookies["username"].Value.Trim());
                string issi = "<" + GridView1.DataKeys[e.Row.RowIndex][2].ToString() + ">";
                bool ISHD = (HDISSI.Contains(issi)) ? true : false;
                imgbtn1.ImageUrl = (!HDISSI.Contains(issi)) ? "../images/isinviewyes.png" : "../images/isinviewno.png";
                imgbtn1.CommandName = "changedisplay";
                imgbtn1.CommandArgument = GridView1.DataKeys[e.Row.RowIndex][0].ToString() + "," + GridView1.DataKeys[e.Row.RowIndex][2].ToString() + "," + ISHD;
                imgbtn1.Visible = (GridView1.DataKeys[e.Row.RowIndex][2].ToString() == "") ? false : true;

                ImageButton locationbtn = (ImageButton)e.Row.Cells[0].FindControl("imgLocation");
                if (locationbtn != null)
                {
                    locationbtn.Visible = (GridView1.DataKeys[e.Row.RowIndex][2].ToString() == "") ? false : true;
                    locationbtn.CommandArgument += "|" + ISHD.ToString();
                    locationbtn.ToolTip += "|" + ISHD.ToString();
                }
                e.Row.Cells[6].Text = "&nbsp;&nbsp;" + e.Row.Cells[6].Text;
                e.Row.Cells[7].Text = "&nbsp;&nbsp;" + e.Row.Cells[7].Text;
                //if (e.Row.Cells[8].Text.Length > 10)
                //{
                //    e.Row.Cells[8].Text = e.Row.Cells[6].Text.Substring(0, 8) + "...";
                //    e.Row.Cells[8].Attributes.Add("title", e.Row.Cells[6].Text);
                //    e.Row.Cells[8].Attributes.Add("style", "cursor:hand;padding:4px;");
                //}
                if (e.Row.Cells[8].Text == "1")
                {
                    e.Row.Cells[8].Text = ResourceManager.GetString("Lang_Yes");
                }
                else
                {
                    e.Row.Cells[8].Text = ResourceManager.GetString("Lang_No");
                }
            }
            LinkButton linkbtn = (LinkButton)e.Row.FindControl("ImageButton2");
            if (linkbtn != null)
            {


                DropDownList1.Items[0].Text = ResourceManager.GetString("SelectEntity");
                DropDownList2.Items[0].Text = ResourceManager.GetString("Username");
                DropDownList2.Items[1].Text = ResourceManager.GetString("Serialnumber");
                DropDownList2.Items[2].Text = ResourceManager.GetString("Lang_terminal_identification");
              

                linkbtn.OnClientClick = @"javascript:return confirm('" + ResourceManager.GetString("BeSureToDelete") + "['+this.parentElement.parentElement.getElementsByTagName('font')[0].innerText.trim()+']?')";
               
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

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {


            switch (e.CommandName)
            {
                case "MyDel":
                    DbComponent.userinfo funuserinfo = new DbComponent.userinfo();
                    IIsInStockadeViewDao isv = DispatchInfoFactory.CreateIsInStockadeViewDao();
                    int ID = int.Parse(e.CommandArgument.ToString());
                    if (funuserinfo.GetUserinfo_byid(ID).id == 0)
                    {
                        Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("Lang_DeleteDataFail") + "');</script>");
                        return;
                    }

                    string err = "";
                    string strMarker;

                    if (System.Configuration.ConfigurationManager.AppSettings["defaultLanguage"] == "zh-CN")
                    {
                        strMarker = "☆";
                    }
                    else
                    {
                        strMarker = "#";
                    }

                    if (isv.GetUserCountByUserID(ID) > 0)
                    {
                        err += "\\n        " + strMarker + ResourceManager.GetString("Lang_DeletFailHavestatck");
                    }
                    if (funuserinfo.UserISSI_byid(ID) > 0)
                    {
                        err += "\\n        " + strMarker + ResourceManager.GetString("UserhaveISSI");
                    }

                    if (err == "")
                    {
                        ///启用事务删除即时GIS信息，历史GIS信息，删除移动用户
                        #region shiwu
                        using (TransactionScope scope = new TransactionScope())
                        {
                            DbComponent.Gis gis = new DbComponent.Gis();
                            try
                            {
                                SQLHelper.ExecuteNonQuery(CommandType.Text, "DELETE FROM [GIS_info] WHERE [User_ID]=@id", new SqlParameter("id", ID));//删除该终端即时GIS信息
                                //历史GIS信息数据用存储过程删除
                                //SQLHelper.ExecuteNonQuery(CommandType.Text, "DELETE FROM [HistoryGIS_info] WHERE [User_ID]=@id", new SqlParameter("id", ID));//删除该终端历史GIS信息
                                funuserinfo.DelUserinfo_byid(ID);
                                scope.Complete();
                                
                                Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("OperationSuccessful") + "');window.parent.lq_changeifr('manager_user');window.parent.reloadtree();</script>");

                                //历史GIS信息数据用存储过程删除
                                try
                                {
                                    string StoredProcedureName = "P_DelHistoryGISInfo";
                                    int re = int.Parse(SQLHelper.ExecuteScalarStrProc(CommandType.StoredProcedure, StoredProcedureName, new SqlParameter("user_id", ID)).ToString());
                                }
                                catch (Exception ex) { }
                            }
                            catch (Exception ex)
                            {
                                log.Debug(ex);
                                Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("Operationfails") + "');</script>");
                            }
                        }
                        #endregion}
                    }
                    else
                    {

                        Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("PATCH_DELETE_FAIL") + ":" + err + "');</script>");
                    }
                    break;
                case "choose":
                    if (e.CommandArgument.ToString() != "")
                    {
                        if (e.CommandArgument.ToString().Split(',')[0] != "" && e.CommandArgument.ToString().Split(',')[1] != "" && e.CommandArgument.ToString().Split(',')[2] != "")
                        {
                            string LayerID = e.CommandArgument.ToString().Split('|')[0];
                            string CI = e.CommandArgument.ToString().Split('|')[1];
                            //这里加上了地图的经纬度偏移值，使得查询的结果与地图显示的图元位置先一致
                            string longitude = e.CommandArgument.ToString().Split('|')[2];
                            string latitude = e.CommandArgument.ToString().Split('|')[3];
                            string ISSIa = e.CommandArgument.ToString().Split('|')[5];
                            string pars = LayerID + "|" + CI + "|" + longitude + "|" + latitude;
                            string displayvalue = e.CommandArgument.ToString().Split('|')[6];
                            if (longitude == "" || latitude == "" || longitude == "0" || latitude == "0" || longitude == "0.0000000" ||latitude=="0.0000000"|| ISSIa == "")
                            {
                                Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script> var a=\"" + ResourceManager.GetString("LocationFailLOLA") + "\" ; alert(a);</script>");
                                return;
                            }

                            

                            switch (displayvalue)
                            {
                                case "False":
                                    {
                                        Page.ClientScript.RegisterStartupScript(Page.GetType(), "atlocation", "<script>window.parent.locationbyUseid('" + CI + "');window.parent.mycallfunction('manager_user');</script>");
                                    }
                                    break;
                                default:
                                    //Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("LocationFailViewStatus") + "');</script>");
                                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>DarewithDisplay('" + CI + "','" + ISSIa + "','" + Request.Cookies["username"].Value + "')</script>");
                                    break;

                            }


                        }
                    }
                    break;


                case "changedisplay":
                    string ISSIs = e.CommandArgument.ToString().Split(',')[1];
                    bool ISHD = bool.Parse(e.CommandArgument.ToString().Split(',')[2]);
                    if (ISHD)
                    {
                        DbComponent.login.DISISSI(ISSIs, Request.Cookies["username"].Value);//打开显示
                        Page.ClientScript.RegisterStartupScript(Page.GetType(), "display", "<script>window.parent.changevis('visable', " + ISSIs + "); </script>");

                    }
                    else
                    {
                        DbComponent.login.HDISSI(ISSIs, Request.Cookies["username"].Value);//关闭显示
                        Page.ClientScript.RegisterStartupScript(Page.GetType(), "display", "<script>window.parent.changevis('hidden', " + ISSIs + "); </script>");
                    }
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>window.parent.changvisable(" + e.CommandArgument.ToString().Split(',')[0] + ");window.parent.closeceit('Police,0,0'," + e.CommandArgument.ToString().Split(',')[0] + ",false);window.parent.useprameters.Selectid = [];window.parent.useprameters.SelectISSI = [];window.parent.LayerControl.refurbish(); </script>");
                    GridView1.DataBind();
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

        protected void ImageButton2_Click(object sender, ImageClickEventArgs e)
        {
            GridView1.PageIndex = 0;
        }





    }
}