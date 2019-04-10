using DbComponent.FactoryMethod;
using DbComponent.IDAO;
using Ryu666.Components;
using System;
using System.Text;
using System.Web.UI;
namespace Web.lqnew.opePages
{
    public partial class add_PjGroup : BasePage
    {
        private IDXGroupInfoDao DXGroupService
        {
            get
            {
                return DispatchInfoFactory.CreateDXGroupInfoDao();
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                if (System.Configuration.ConfigurationManager.AppSettings["OpenWindow"] == "1")
                {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "resizediv", "<script>  window.parent.lq_changeheight(geturl(), document.body.clientHeight);window.parent.change(geturl());</script>");
                }
            }
            else
            {
                if (System.Configuration.ConfigurationManager.AppSettings["OpenWindow"] == "1")
                {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "resizediv", "<script>  window.parent.lq_changeheight(geturl(), document.body.clientHeight);</script>");
                }
            }
            rfvBaseStationName.ErrorMessage = ResourceManager.GetString("EnterPJgroupinformation");
        }
        private int CheckGSSI(int GSSI)
        {
            if (DXGroupService.IsExistGSSI(GSSI.ToString()))
            {
                Random rd = new Random();
                int groupindex = rd.Next(255);
                return CheckGSSI(groupindex);
            }
            else
                return GSSI;
        }
        protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
        {
            try
            {
                StringBuilder sbGssi = new StringBuilder();
                string[] strISSI = txtISSIValue.Value.Split(new char[] { ';' }, StringSplitOptions.RemoveEmptyEntries);
                if (strISSI != null)
                {
                    foreach (string str in strISSI)
                    {
                        string[] myis = str.Split(new char[] { '(' }, StringSplitOptions.RemoveEmptyEntries);
                        if (myis[1] != null)
                        {
                            string[] myis1 = myis[1].Split(new char[] { ')' }, StringSplitOptions.RemoveEmptyEntries);
                            if (myis1[0] != null)
                            {
                                sbGssi.Append(myis1[0].ToString() + ";");
                            }
                        }
                    }
                }
                string GName = txtPJZName.Text.Trim();
                Random rd = new Random();
                int groupindex = rd.Next(255);//需要验证是否存在 存在的话重新生成
                int strGroupindex = CheckGSSI(groupindex);

                switch (Request["CMD"].ToString())
                {
                    case "CALLPANL":
                        Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script> window.parent.frames['PJGroup_ifr'].OverAddPjGroup('" + GName + "','" + strGroupindex.ToString() + "','" + sbGssi + "');window.parent.mycallfunction('add_PjGroup');</script>");
                        break;
                    case "DXCALLPANL":
                        Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script> window.parent.frames['DXGroup_ifr'].OverAddPjGroup('" + GName + "','" + strGroupindex.ToString() + "','" + sbGssi + "');window.parent.mycallfunction('add_PjGroup');</script>");
                        break;
                    case "PJADD":
                        if (DXGroupService.Add(GName, strGroupindex.ToString(), sbGssi.ToString(), DropDownList1.SelectedValue.ToString(), (int)MyModel.Enum.GroupType.Patch))
                        {
                            Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("AddSucc") + "');window.parent.lq_changeifr('manager_PJGroup');window.parent.mycallfunction('add_PjGroup');</script>");
                        }
                        else
                        {
                            Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("AddFail") + "');</script>");
                        }
                       
                        break;
                    case "DXADD":
                         if (DXGroupService.Add(GName, strGroupindex.ToString(), sbGssi.ToString(), DropDownList1.SelectedValue.ToString(),(int)MyModel.Enum.GroupType.Multi_Sel))
                        {
                            Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("AddSucc") + "');window.parent.lq_changeifr('manager_DXGroup');window.parent.mycallfunction('add_PjGroup');</script>");
                        }
                        else
                        {
                            Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("AddFail") + "');</script>");
                        }
                        
                        break;
                    default: break;
                }
                
            }
            catch (System.Exception eX)
            {
                log.Error(eX);
                Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("AddFail") + "');</script>");
            }
        }




    }
}