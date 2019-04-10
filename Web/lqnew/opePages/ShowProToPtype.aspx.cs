using Ryu666.Components;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DbComponent;
using System.Data.SqlClient;

namespace Web.lqnew.opePages
{
    public partial class ShowProToPtype : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {


            if (!Page.IsPostBack && Request.QueryString["id"] != null)
            {
                int pid =Convert.ToInt32(Request.QueryString["id"]);
                tb1.Rows[0].Cells[1].InnerHtml = Request.QueryString["Name"];
                StringBuilder sb = new StringBuilder();
                sb.Append("SELECT s.name as stepname ");
                sb.Append("FROM step s ");
                sb.AppendFormat("where s.procedure_id={0}", pid);
                using (SqlDataReader dr=SQLHelper.GetReader(sb.ToString()))
                {
                    if (!dr.HasRows)
                    {
                        tb1.Rows[1].Cells[1].InnerHtml = "无数据";
                        return;
                    }
                    sb.Clear();
                    var i=1;
                    sb.Append("<div  style='word-break: break-all;overflow-y:auto; width:100% ;height:60px'>");
                    while(dr.Read())
                    {
                        sb.AppendFormat("{0} {1} <br/>", i++, dr[0]);
                    }
                    sb.Append("</div>");
                    tb1.Rows[1].Cells[1].InnerHtml = sb.ToString();
                }
               
                //String None = ResourceManager.GetString("Lang-None");
                //DbComponent.Entity entityinfo = new DbComponent.Entity();
                //MyModel.Model_Entity DbEntity = new MyModel.Model_Entity();
                //DbEntity = entityinfo.GetEntityinfo_byid(int.Parse(Request.QueryString["id"]));
                //tb1.Rows[0].Cells[1].InnerHtml = "&nbsp;&nbsp;" + DbEntity.Name;
                //string parantname = (DbEntity.ParentID == 0) ? None : entityinfo.GetEntityinfo_byid(DbEntity.ParentID).Name;
                //tb1.Rows[1].Cells[1].InnerHtml = "&nbsp;&nbsp;" + parantname;
                //tb1.Rows[2].Cells[1].InnerHtml = "&nbsp;&nbsp;" + (DbEntity.Depth + 1);
                //tb1.Rows[3].Cells[1].InnerHtml = "<div  style='word-break: break-all;overflow-y:auto; width:100% ;height:60px'>" + DbEntity.bz + "</div>";
                
            }

        }
    }
}