using DbComponent.IDAO;
using Ryu666.Components;
using System;
using System.Reflection;
using System.Web.UI;
using Web.lqnew.other;
namespace Web.lqnew.opePages
{
    public partial class add_BaseStation : System.Web.UI.Page
    {
        private IBaseStationDao BaseStationDaoService
        {
            get
            {
                return DbComponent.FactoryMethod.DispatchInfoFactory.CreateBaseStationDao();
            }
        }
        private static readonly log4net.ILog log = log4net.LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);
        protected void Page_Load(object sender, EventArgs e)
        {
            ImageButton1.ImageUrl = ResourceManager.GetString("LangConfirm");
            rfvBaseStationName.ErrorMessage = "<b>" + ResourceManager.GetString("enterstationinformation") + "</b>";
            BSNValidator.ErrorMessage = "<b>" + ResourceManager.GetString("BSissiarrange") + "</b>";
            rfvBaseStationISSI.ErrorMessage = "<b>" + ResourceManager.GetString("enterstationissi") + "</b>";
            rbtxtLo.ErrorMessage = "<b>" + ResourceManager.GetString("Lang_rbtxtLoErr") + "</b>";
            RequiredFieldValidator1.ErrorMessage = "<b>" + ResourceManager.GetString("qhqjd") + "</b>";
            RangeValidator1.ErrorMessage = "<b>" + ResourceManager.GetString("Lang_RangeValidator1Err") + "</b>";
            RequiredFieldValidator2.ErrorMessage = "<b>" + ResourceManager.GetString("qhqwd") + "</b>";
            Page.ClientScript.RegisterStartupScript(Page.GetType(), "LanguageSwitch", "<script>  Lang2localfunc(); </script>");
            radIsUnderGround.Items[0].Text = ResourceManager.GetString("Lang_Yes");
            radIsUnderGround.Items[1].Text = ResourceManager.GetString("Lang_No");
            revSwitch.ErrorMessage = "<b>" + ResourceManager.GetString("Lang_revSwitch") + "</b>";//xzj--20181215
            if (!Page.IsPostBack)
            {
                validateEntityLength.ValidationExpression = Properties.Resources.strNameLengthValidationExpression;
              
                validateEntityLength.ErrorMessage = "<B>" + ResourceManager.GetString("errorUnNomal");
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
        }

        protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
        {
            if (!checkISSI.RegexIssiValue(txtBaseISSI.Text.Trim()))
            {
                Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("BSbzbxwzs") + "');</script>");
                return;
            }
            if (BaseStationDaoService.FindBaseStationISSIForAdd(txtBaseISSI.Text.Trim(), int.Parse(string.IsNullOrEmpty(txtSwitch.Text)==true?"0":txtSwitch.Text)))//xzj--20181217--判断中添加交换ID
            {
                Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("StationIDexit") + "');</script>");
                return;
            }
            if (BaseStationDaoService.FindBaseStationNameForAdd(txtBaseStation.Text.Trim()))
            {
                Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('"+ResourceManager.GetString("StationNameexit")+"');</script>");
                return;
            }

            int isUnderGround = radIsUnderGround.SelectedValue=="1" ? 1 : 0;

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
                MyModel.Model_BaseStation newType = new MyModel.Model_BaseStation { StationName = txtBaseStation.Text.Trim(), StationISSI = txtBaseISSI.Text.Trim(), Lo = Lo, La = La, DivID = divID, IsUnderGround = isUnderGround, SwitchID=int.Parse(string.IsNullOrEmpty(txtSwitch.Text)==true?"0":txtSwitch.Text) };//xzj--20181217添加交换
                if (BaseStationDaoService.AddBaseStation(newType))
                {
                    //注释原来的，新的将window.parent.CloseJWD()函数删除---------------xzj--2018/6/29-------------
                    //Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("AddSucc") + "');window.parent.lq_changeifr('manager_BaseStation');window.parent.CloseJWD();window.parent.AddBaseStation('" + divID + "','" + La.ToString() + "','" + Lo.ToString() + "','" + txtBaseStation.Text.Trim() + "','" + txtBaseISSI.Text.Trim() + "');window.parent.mycallfunction('add_BaseStation');</script>");
                    int id = int.Parse(BaseStationDaoService.GetIDByDivID(divID));
                    int deviceCount = BaseStationDaoService.getAllBsDeviceCount(txtBaseISSI.Text.Trim(), int.Parse(string.IsNullOrEmpty(txtSwitch.Text) == true ? "0" : txtSwitch.Text));
                    string stationISSI = txtBaseISSI.Text.Trim();
                    string stationName = txtBaseStation.Text.Trim();
                    string basestation = "{'ID' : " + id + ", 'StationISSI' : '" + stationISSI + "', 'La' :" + La + ", 'Lo' :" + Lo + ", 'StationName' :'" + stationName + "', 'DeviceCount' :" + deviceCount + "}";
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("AddSucc") + "');window.parent.lq_changeifr('manager_BaseStation');window.parent.bsLayerManager.addBaseStationFeature(" + basestation + ");window.parent.mycallfunction('add_BaseStation');</script>");
                    //注释原来的，新的将window.parent.CloseJWD()函数删除---------------xzj--2018/6/29-------------
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