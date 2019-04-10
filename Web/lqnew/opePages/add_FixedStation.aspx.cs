
using DbComponent.FS_Info;
using Ryu666.Components;
using System;
using System.Reflection;
using System.Text.RegularExpressions;
using System.Web.UI;

namespace Web.lqnew.opePages
{
    public partial class add_FixedStation : System.Web.UI.Page
    {
        private IFixedStationDao FixedStationDaoService
        {
            get
            {
                return DbComponent.FactoryMethod.DispatchInfoFactory.CreatFixedStationDao();
            }
        }
        public static bool RegexIssiValue(string value)
        {
            Regex regex = new Regex(@"^\d*$");
            return regex.IsMatch(value);
        }
        private static readonly log4net.ILog log = log4net.LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);
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
            rfvFSISSI.ErrorMessage = ResourceManager.GetString("QSRGDTBZ");
            DropDownList1.Items[0].Text = ResourceManager.GetString("SelectEntity");
            rfvFSGSSIS.ErrorMessage = ResourceManager.GetString("QSRGDTZLZ");
            rbtxtLo.ErrorMessage = ResourceManager.GetString("Lang_rbtxtLoErr");
            RequiredFieldValidator1.ErrorMessage = ResourceManager.GetString("EnterJWD");
            RangeValidator1.ErrorMessage = ResourceManager.GetString("Lang_RangeValidator1Err");
            RequiredFieldValidator2.ErrorMessage = ResourceManager.GetString("EnterJWD");
            ImageButton1.ImageUrl = ResourceManager.GetString("LangConfirm");

        }

        protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
        {
            if (!RegexIssiValue(txtFSISSI.Text.Trim()))
            {
                Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("Lang_ISSSIdRange") + "');</script>");
                return;
            }
            if (FixedStationDaoService.FindFixedStationISSIForAdd(txtFSISSI.Text.Trim()))
            {
                Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("Lang_ISSSHasExistInRange") + "');</script>");
                return;
            }
            string divID = DateTime.Now.Year.ToString() + DateTime.Now.Month.ToString() + DateTime.Now.Day.ToString() + DateTime.Now.Hour.ToString() + DateTime.Now.Minute.ToString() + DateTime.Now.Second.ToString() + DateTime.Now.Millisecond.ToString();
            try
            {
                decimal Lo = 0.0M;
                decimal La = 0.0M;
                if (!string.IsNullOrEmpty(txtLo.Text.Trim()))
                {
                    Lo = decimal.Parse(txtLo.Text.Trim());
                }
                if (!string.IsNullOrEmpty(txtLa.Text.Trim()))
                {
                    La = decimal.Parse(txtLa.Text.Trim());
                }
                DbComponent.FS_Info.Model_FixedStation newType = new DbComponent.FS_Info.Model_FixedStation { GSSIS = txtFSGSSIS.Text.Trim(), Entity_ID = DropDownList1.SelectedIndex.ToString().Trim(), StationISSI = txtFSISSI.Text.Trim(), Lo = Lo, La = La };
                if (FixedStationDaoService.AddFixedStation(newType))
                {

                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("AddSucc") + "');window.parent.lq_changeifr('FixedStation');window.parent.mycallfunction('add_FixedStation');</script>");

                }
                else
                {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("AddFail") + "');</script>");
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