using System;
using System.Web.UI;
using Ryu666.Components;
using System.Data;
namespace Web.lqnew.opePages.view_info
{
    public partial class view_user : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack&&Request.QueryString["id"]!=null)//xzj--20181224--添加场强信息
            {
                DbComponent.userinfo MYuserinfo = new DbComponent.userinfo();
                DbComponent.Entity MYEntity = new DbComponent.Entity();
                DataTable userinfo_detail = MYuserinfo.GetUserinfoAndGisInfo_byid(int.Parse(Request.QueryString["id"]));
                tb1.Rows[0].Cells[1].InnerHtml = "&nbsp;&nbsp;" + userinfo_detail.Rows[0]["Nam"];
                tb1.Rows[1].Cells[1].InnerHtml = "&nbsp;&nbsp;" + userinfo_detail.Rows[0]["Num"];
                tb1.Rows[2].Cells[1].InnerHtml = "&nbsp;&nbsp;" + userinfo_detail.Rows[0]["ISSI"];
                tb1.Rows[3].Cells[1].InnerHtml = "&nbsp;&nbsp;" + MYEntity.GetEntityinfo_byid(int.Parse(userinfo_detail.Rows[0]["Entity_ID"].ToString().Trim())).Name;
                tb1.Rows[4].Cells[1].InnerHtml = "&nbsp;&nbsp;" + userinfo_detail.Rows[0]["type"];
                tb1.Rows[6].Cells[1].InnerHtml = "&nbsp;&nbsp;" + userinfo_detail.Rows[0]["Telephone"];
                tb1.Rows[7].Cells[1].InnerHtml = "&nbsp;&nbsp;" + userinfo_detail.Rows[0]["Position"];
                string typeName = userinfo_detail.Rows[0]["terminalType"].ToString().Trim();
                tb1.Rows[5].Cells[1].InnerHtml = "&nbsp;&nbsp;" + ResourceManager.GetString(typeName);
                if (typeName == "LTE")
                {
                    tb1.Rows[8].Cells[1].InnerHtml = "&nbsp;&nbsp;" + userinfo_detail.Rows[0]["ipAddress"].ToString().Trim();
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "none", "<script>document.getElementById('tr_ipAddress').style.display = 'table-row';</script>");//xzj--20181224--修改display block改为table-row
                }
                string terminalStatus = userinfo_detail.Rows[0]["terminalStatus"].ToString();
                if(terminalStatus == "0"){
                tb1.Rows[9].Cells[1].InnerHtml ="&nbsp;&nbsp;"+ ResourceManager.GetString("Lang_ISSIInValide");
                }
                else if(terminalStatus == "1"){
                    tb1.Rows[9].Cells[1].InnerHtml = "&nbsp;&nbsp;" + ResourceManager.GetString("Lang_ISSIValide");
                }
                tb1.Rows[10].Cells[1].InnerHtml = "<div  style='word-break: break-all;overflow-y:auto; width:100% ;height:60px'>" + userinfo_detail.Rows[0]["bz"] + "</div>";
                tb1.Rows[11].Cells[1].InnerHtml = "&nbsp;&nbsp;" + userinfo_detail.Rows[0]["Battery"];//手台电量
                tb1.Rows[12].Cells[1].InnerHtml = "&nbsp;&nbsp;" + userinfo_detail.Rows[0]["MsRssi"];//手台场强
                tb1.Rows[13].Cells[1].InnerHtml = "&nbsp;&nbsp;" + userinfo_detail.Rows[0]["UlRssi"];//上行场强
            }
     
        }
    }
}