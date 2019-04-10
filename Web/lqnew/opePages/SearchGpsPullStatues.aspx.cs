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
            SqlDataReader dr = SQLHelper.GetReader(string.Format("select accessUnitsAndUsertype,Entity_ID from login where usename='{0}'", dispatchUser));

            //{"volume":"part","unit":[{"entityId":"2"},{"entityId":"4"}],"zhishu":[],"usertype":[]}
            string unitId = "";
            string utUnitId = "";
            if (dr.HasRows)
            {
                while (dr.Read())
                {
                    string accessUnit = dr[0].ToString().Trim();
                    if (accessUnit != "")
                    {
                        if (accessUnit.IndexOf('[') > 0)
                        {
                            string accessUserType = accessUnit;
                            string accseeZhishu = accessUnit;
                            accessUnit = accessUnit.Substring(accessUnit.IndexOf('['));
                            accessUnit = accessUnit.Substring(0, accessUnit.IndexOf(']') + 1);
                            accseeZhishu = accseeZhishu.Substring(accseeZhishu.IndexOf('[', accseeZhishu.IndexOf("zhishu")));
                            accseeZhishu = accseeZhishu.Substring(0, accseeZhishu.IndexOf(']') + 1);
                            accessUserType = accessUserType.Substring(accessUserType.IndexOf('[', accessUserType.IndexOf("usertype")));
                            accessUserType = accessUserType.Substring(0, accessUserType.LastIndexOf(']') + 1);

                            List<Units> unitList = Serial.JSONStringToList<Units>(accessUnit);
                            List<Units> zhishuList = Serial.JSONStringToList<Units>(accseeZhishu);
                            List<Units> accessUserTypeList = Serial.JSONStringToList<Units>(accessUserType);

                            //string entityid = string.Empty;
                            foreach (var item in unitList)
                            {

                                unitId = unitId + "," + item.entityId;

                            }
                            foreach (var item in zhishuList) 
                            {
                                utUnitId = utUnitId + "," + item.entityId;
                            }
                            foreach (var item in accessUserTypeList) 
                            {
                                utUnitId = utUnitId + "," + item.entityId;
                            }
                        }
                    }
                    else
                    {
                        string entityID = dr[1].ToString().Trim();
                        unitId = unitId + "," + entityID;
                    }
                }
            }
            if (unitId != "" && unitId.Substring(0, 1) == ",")
            {
                unitId = unitId.Substring(1);
            }
            string notinSql = "";
            if (utUnitId != "" && utUnitId.Substring(0, 1) == ",") 
            {
                utUnitId = utUnitId.Substring(1);
                notinSql = " and b.id not in (" + utUnitId + ")";
            }
      
            if (unitId != "" || utUnitId != "")
            {
                string idsSql = unitId + "," + utUnitId;
                if (unitId == "")
                {
                    idsSql = utUnitId;
                }
                if (utUnitId == "")
                {
                    idsSql = unitId;
                }
                sql = "WITH lmenu(name,id,ParentID) as (SELECT name,id,ParentID  FROM [Entity] WHERE id in (" + idsSql + ") UNION ALL SELECT A.NAME,A.id,A.ParentID FROM [Entity] A,lmenu b where a.[ParentID] = b.id" + notinSql + ") select id,name,ParentID,Depth from Entity where id in (select id from lmenu) and Depth>=0 order by Depth";
            }
            else
            {
                sql = "WITH lmenu(name,id,ParentID) as (SELECT name,id,ParentID  FROM [Entity] UNION ALL SELECT A.NAME,A.id,A.ParentID FROM [Entity] A,lmenu b where a.[ParentID] = b.id) select id,name,ParentID,Depth from Entity where id in (select id from lmenu) and Depth>=0 order by Depth";
            }

            DataTable dt = new System.Data.DataTable();
            SQLHelper.ExecuteDataReader(ref dt, sql);
            ddlentity.DataSource = dt;
            ddlentity.DataTextField = "name";
            ddlentity.DataValueField = "id";
            ddlentity.DataBind();
            ddlentity.Items.Insert(0, new ListItem(ResourceManager.GetString("SelectEntity"), "0"));
        }

    }
}