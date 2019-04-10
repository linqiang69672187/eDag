using System;
using System.Linq;
using System.Text;
using System.Web.UI;
using Ryu666.Components;
namespace Web.lqnew.opePages.view_info
{
    public partial class add_Member : System.Web.UI.Page
    {
        public string typeName;
        protected void Page_Load(object sender, EventArgs e)
        {
            //MultiLanguages
            Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>LanguageSwitch(window.parent);</script>");
           
            if (!Page.IsPostBack&&Request.QueryString["id"]!=null)
            {
                DbComponent.ISSI ISSIinfo = new DbComponent.ISSI();
                MyModel.Model_ISSI DbISSI = new MyModel.Model_ISSI();
                DbComponent.group group = new DbComponent.group();
                DbComponent.Entity Entityinfo = new DbComponent.Entity(); 
                DbISSI = ISSIinfo.GetISSIinfo_byid(int.Parse(Request.QueryString["id"]));
                string[] GSSIS = DbISSI.GSSIS.Replace("<","").Split(new char[]{'>'},StringSplitOptions.RemoveEmptyEntries);
                StringBuilder cgvalue = new StringBuilder();   
    
                var smz = from item in GSSIS where item.Contains("s") orderby item select item;       
                foreach (var item in smz)
                { cgvalue.Append(group.GetGroupGroupname_byGSSI(item.TrimStart('s')) + "," + item.TrimStart('s')+"|");}
                tbsmz.InnerHtml = LQCommonCS.ISSI.CreateGroupTB(cgvalue.ToString().Split('|'));
                cgvalue.Clear();
                smz = from item in GSSIS where item.Contains("t") orderby item select item;
                foreach (var item in smz)
                { cgvalue.Append(group.GetGroupGroupname_byGSSI(item.TrimStart('t')) + "," + item.TrimStart('t') + "|"); }
                tbtbz.InnerHtml = LQCommonCS.ISSI.CreateGroupTB(cgvalue.ToString().Split('|'));
                var zlz = from item in GSSIS where item.Contains("z") orderby item select item;
                foreach (var item in zlz)
                {
                    tb1.Rows[6].Cells[1].InnerHtml = "&nbsp;&nbsp;" + item.TrimStart('z');
                }
                tb1.Rows[0].Cells[1].InnerHtml = "&nbsp;&nbsp;" + DbISSI.ISSI;

                typeName = DbISSI.typeName.ToString().Trim();
                tb1.Rows[1].Cells[1].InnerHtml = "&nbsp;&nbsp;" + ResourceManager.GetString(typeName);
                if (typeName == "LTE") {
                    tb1.Rows[2].Cells[1].InnerHtml = "&nbsp;&nbsp;" + DbISSI.ipAddress.Trim();
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "none", "<script>document.getElementById('tr_ipAddress').style.display = 'block';</script>");
                }
                string terminalStatus = DbISSI.status;
                if (terminalStatus == "0")
                {
                    tb1.Rows[3].Cells[1].InnerHtml = "&nbsp;&nbsp;" + ResourceManager.GetString("Lang_ISSIInValide");
                                        
                }
                else if (terminalStatus == "1")
                {
                    
                    tb1.Rows[3].Cells[1].InnerHtml = "&nbsp;&nbsp;" + ResourceManager.GetString("Lang_ISSIValide");
                }
                
                tb1.Rows[4].Cells[1].InnerHtml = "&nbsp;&nbsp;" + Entityinfo.GetEntityinfo_byid(int.Parse(DbISSI.Entity_ID)).Name;
                tb1.Rows[5].Cells[1].InnerHtml = "<div style='word-break: break-all;overflow-y:auto; width:100% ;height:60px'>" + DbISSI.Bz + "</div>";
               
            }
     
        }
    }
}