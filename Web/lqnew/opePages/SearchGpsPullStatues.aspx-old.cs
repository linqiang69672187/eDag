using DbComponent;
using Ryu666.Components;
using System;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Transactions;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections.Generic;
using System.IO;
using System.Runtime.Serialization.Json;
using System.Web.Script.Serialization;

namespace Web.lqnew.opePages
{
    public partial class SearchGpsPullStatues : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Page.ClientScript.RegisterStartupScript(Page.GetType(), "LanguageSwitch", "<script>LanguageSwitch(window.parent);</script>");
            ddlentity.Items[0].Text = ResourceManager.GetString("SelectEntity");


            if (!Page.IsPostBack)
            {
                string dispatchUser = Request.Cookies["username"].Value.Trim();
                if (System.Configuration.ConfigurationManager.AppSettings["OpenWindow"] == "1")
                {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "resizediv", "<script>  window.parent.lq_changeheight(geturl(), document.body.clientHeight);window.parent.change(geturl());</script>");
                }
                if (Request.QueryString["id"] != null)
                {
                    //userul.Visible = false;
                }

                DropDownList_Ddlentity(dispatchUser);
            }
            else
            {
                if (System.Configuration.ConfigurationManager.AppSettings["OpenWindow"] == "1")
                {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "resizediv", "<script>  window.parent.lq_changeheight(geturl(), document.body.clientHeight);</script>");
                }
            }
        }

        protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
        {

        }

        public class Units
        {
            public string entityId { get; set; }
        }


        private void DropDownList_Ddlentity(string dispatchUser)
        {
            //DataTable dt = DbComponent.Entity.GetAllEntityInfo("2,4");
            string sql = "";
            SqlDataReader dr = SQLHelper.GetReader(string.Format("select accessUnitsAndUsertype from login where usename='{0}'", dispatchUser));

            //{"volume":"part","unit":[{"entityId":"2"},{"entityId":"4"}],"zhishu":[],"usertype":[]}
            string unitId = "";
            if (dr.HasRows)
            {
                while (dr.Read())
                {
                    string accessUnit = dr[0].ToString().Trim();
                    if (accessUnit != "")
                    {
                        accessUnit = accessUnit.Substring(accessUnit.IndexOf('['));
                        accessUnit = accessUnit.Substring(0, accessUnit.IndexOf(']') + 1);

                        List<Units> unitList = new List<Units>();

                        unitList = Serial.JSONStringToList<Units>(accessUnit);

                        //string entityid = string.Empty;
                        foreach (var item in unitList)
                        {

                            unitId = unitId + "," + item.entityId;

                        }
                    }

                }
            }
            if (unitId != "" && unitId.Substring(0, 1) == ",")
            {
                unitId = unitId.Substring(1);
            }

            DataTable dt = new System.Data.DataTable();
            if (unitId != "")
            {
                sql = "WITH lmenu(name,id,ParentID) as (SELECT name,id,ParentID  FROM [Entity] WHERE id in (" + unitId + ") UNION ALL SELECT A.NAME,A.id,A.ParentID FROM [Entity] A,lmenu b where a.[ParentID] = b.id) select id,name,ParentID,Depth from Entity where id in (select id from lmenu) and Depth>=0 order by Depth";
            }
            else
            {
                sql = "WITH lmenu(name,id,ParentID) as (SELECT name,id,ParentID  FROM [Entity] UNION ALL SELECT A.NAME,A.id,A.ParentID FROM [Entity] A,lmenu b where a.[ParentID] = b.id) select id,name,ParentID,Depth from Entity where id in (select id from lmenu) and Depth>=0 order by Depth";
            }

            SQLHelper.ExecuteDataReader(ref dt, sql);
            ddlentity.DataSource = dt;
            ddlentity.DataTextField = "name";
            ddlentity.DataValueField = "id";
            ddlentity.DataBind();

        }

    }
}