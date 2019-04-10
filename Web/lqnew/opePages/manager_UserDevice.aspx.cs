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
    public partial class manager_UserDevice : BasePage
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

        public class UserTypes
        {
            public string entityId { get; set; }
            public string[] usertypeIds { get; set; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {

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

                //重新赋值单位ID

                SqlDataReader dr = SQLHelper.GetReader(string.Format("select accessUnitsAndUsertype from login where usename='{0}'", Request.Cookies["username"].Value.Trim()));

                //{"volume":"part","unit":[{"entityId":"2"},{"entityId":"4"}],"zhishu":[],"usertype":[]}
                string unitId = "";
                string zhishuId = "";
                string usertypeId = "";
                string usertypes = "";
                Response.Cookies["unitId"].Value = string.Empty;
                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        string accessUnit = dr[0].ToString().Trim();
                        if (accessUnit != "")
                        {
                            if (accessUnit.IndexOf('[') > 0)
                            {
                                string accseeZhishu = accessUnit;
                                string accessUserType = accessUnit;
                                accessUnit = accessUnit.Substring(accessUnit.IndexOf('['));
                                accessUnit = accessUnit.Substring(0, accessUnit.IndexOf(']') + 1);
                                accseeZhishu = accseeZhishu.Substring(accseeZhishu.IndexOf('[', accseeZhishu.IndexOf("zhishu")));
                                accseeZhishu = accseeZhishu.Substring(0, accseeZhishu.IndexOf(']') + 1);
                                accessUserType = accessUserType.Substring(accessUserType.IndexOf('[', accessUserType.IndexOf("usertype")));
                                accessUserType = accessUserType.Substring(0, accessUserType.LastIndexOf(']') + 1);

                                List<Units> unitList = Serial.JSONStringToList<Units>(accessUnit);
                                List<Units> zhishuList = Serial.JSONStringToList<Units>(accseeZhishu);
                                List<UserTypes> accessUserTypeList = Serial.JSONStringToList<UserTypes>(accessUserType);

                                foreach (var item in unitList)
                                {
                                    unitId = unitId + "," + item.entityId;
                                }
                                foreach(var item in zhishuList)
                                {
                                    zhishuId = zhishuId + "," + item.entityId;
                                }
                                foreach (var item in accessUserTypeList)
                                {
                                    usertypeId = usertypeId + "," + item.entityId;
                                    foreach (var it in item.usertypeIds)
                                    {
                                        usertypes = usertypes + ";" + item.entityId + "," + it;
                                    }
                                }
                            }
                        }

                    }
                }
                string sql = "";
                if (unitId != "" && unitId.Substring(0, 1) == ",")
                {
                    unitId = unitId.Substring(1);
                    sql = "WITH lmenu(id) as (SELECT id  FROM [Entity] WHERE id in (" + unitId + ") UNION ALL SELECT A.id FROM [Entity] A,lmenu b where a.[ParentID] = b.id) select id from Entity where id in (select id from lmenu) and Depth>=0 order by Depth";
                }
                else
                {
                    sql = "WITH lmenu(id) as (SELECT id  FROM [Entity] UNION ALL SELECT A.id FROM [Entity] A,lmenu b where a.[ParentID] = b.id) select id from Entity where id in (select id from lmenu) and Depth>=0 order by Depth";
                }


                DataTable dt = new System.Data.DataTable();
                SQLHelper.ExecuteDataReader(ref dt, sql);
                unitId = "-1";
                foreach(DataRow drows in dt.Rows)
                {
                    unitId = unitId + "," + drows[0].ToString();
                }
                if (zhishuId != "" && zhishuId.Substring(0, 1) == ",")
                {
                    zhishuId = zhishuId.Substring(1);
                    unitId = unitId + "," + zhishuId;
                }

                if (usertypes != "" && usertypes.Substring(0, 1) == ";")
                {
                    usertypes = usertypes.Substring(1);
                }
                Response.Cookies["usertypes"].Value = Uri.EscapeDataString(unitId + "|" + usertypes);

                if (usertypeId != "" && usertypeId.Substring(0, 1) == ",")
                {
                    usertypeId = usertypeId.Substring(1);
                    unitId = unitId + "," + usertypeId;
                }
                
                Response.Cookies["unitId"].Value = Uri.EscapeDataString(unitId);


                this.ObjectDataSource1.SelectParameters.Add(new Parameter("unitId", TypeCode.String, Response.Cookies["usertypes"].Value));
                this.ObjectDataSource2.SelectParameters.Add(new Parameter("unitId", TypeCode.String, Response.Cookies["unitId"].Value));
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
            GridView1.EmptyDataText = ResourceManager.GetString("NoData");
            GridView1.Columns[0].HeaderText = "ID";
            GridView1.Columns[1].HeaderText = ResourceManager.GetString("ParentUnit");
            GridView1.Columns[2].HeaderText = ResourceManager.GetString("Lang_Subordinateunits");
            GridView1.Columns[3].HeaderText = ResourceManager.GetString("Username");
            GridView1.Columns[4].HeaderText = ResourceManager.GetString("Type");
            GridView1.Columns[5].HeaderText = ResourceManager.GetString("Serialnumber");
            GridView1.Columns[6].HeaderText = ResourceManager.GetString("Lang_terminal_identification");


            GridView1.Columns[7].HeaderText = ResourceManager.GetString("Lang_telephone");
            GridView1.Columns[8].HeaderText = ResourceManager.GetString("Lang_position");
            GridView1.Columns[9].HeaderText = ResourceManager.GetString("Lang_mobilemode");
            GridView1.Columns[10].HeaderText = ResourceManager.GetString("Lang_factory");

        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                string nodata = ResourceManager.GetString("Nodata");
                e.Row.Attributes.Add("onmouseover", "changeTgBg(this,'font',2)");
                e.Row.Attributes.Add("onmouseout", "overchangeTgBg(this,'font',2)");
                DbComponent.Entity funEntity = new DbComponent.Entity();
                // e.Row.Cells[1].Text = "&nbsp;&nbsp;" + funEntity.GetEntityinfo_byid(int.Parse(e.Row.Cells[1].Text)).Name;
                if (e.Row.Cells[1].Text == "Entity Lists")
                    e.Row.Cells[1].Text = "&nbsp;&nbsp;"+nodata;
                else
                    e.Row.Cells[1].Text = "&nbsp;&nbsp;" + e.Row.Cells[1].Text;

                    e.Row.Cells[2].Text = "&nbsp;&nbsp;" + e.Row.Cells[2].Text;

                funEntity = null;
                e.Row.Cells[4].Text += "&nbsp;&nbsp;";
                string type = "<img src='../images/type_img_person.png'  />";
               

                MyModel.Model_UserType myUT = UTList.Where(a => a.TypeName.ToString().Equals(GridView1.DataKeys[e.Row.RowIndex][1].ToString())).FirstOrDefault();
                if (myUT != null)
                {
                    e.Row.Cells[4].Text = "<img style='width:20px; height:30px' src='Upload/ReadImage.aspx?name=" + myUT.TypeName + "_3&type=UserType' title='" + myUT.TypeName + "' />";
                }
                else
                {
                    e.Row.Cells[4].Text = type;
                }

                e.Row.Cells[5].Text = "&nbsp;&nbsp;" + e.Row.Cells[5].Text;
                e.Row.Cells[7].Text = "&nbsp;&nbsp;" + e.Row.Cells[7].Text;
                e.Row.Cells[8].Text = "&nbsp;&nbsp;" + e.Row.Cells[8].Text;
                e.Row.Cells[9].Text = "&nbsp;&nbsp;" + e.Row.Cells[9].Text;
                e.Row.Cells[10].Text = "&nbsp;&nbsp;" + e.Row.Cells[10].Text;

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