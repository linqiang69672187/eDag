using Ryu666.Components;
using System;
using System.Web.UI;
namespace Web.lqnew.opePages.view_info
{
    public partial class viewpage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
          
            
            if (!Page.IsPostBack&&Request.QueryString["id"]!=null)
            {
                String None = ResourceManager.GetString("Lang-None");

                DbComponent.Entity entityinfo = new DbComponent.Entity();
                MyModel.Model_Entity DbEntity = new MyModel.Model_Entity();
                DbEntity=entityinfo.GetEntityinfo_byid(int.Parse(Request.QueryString["id"]));
                tb1.Rows[0].Cells[1].InnerHtml = "&nbsp;&nbsp;" + DbEntity.Name;
                string parantname = (DbEntity.ParentID == 0) ? None : entityinfo.GetEntityinfo_byid(DbEntity.ParentID).Name;
                tb1.Rows[1].Cells[1].InnerHtml = "&nbsp;&nbsp;" + parantname;
                tb1.Rows[2].Cells[1].InnerHtml = "&nbsp;&nbsp;" + (DbEntity.Depth+1);
                tb1.Rows[3].Cells[1].InnerHtml = "<div  style='word-break: break-all;overflow-y:auto; width:100% ;height:60px'>" + DbEntity.bz + "</div>";

            }
     
        }
    }
}