using DbComponent.FactoryMethod;
using DbComponent.IDAO;
using System;

namespace Web.lqnew.opePages
{
    public partial class SBCall : System.Web.UI.Page
    {
        private IBaseStationDao BaseStationService
        {
            get
            {
                return DispatchInfoFactory.CreateBaseStationDao();
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request["bsid"] != null)
                {
                    string strBaseStationID = Request["bsid"].ToString();
                    MyModel.Model_BaseStation mb = BaseStationService.GetBaseStationByID(int.Parse(strBaseStationID));
                    if (mb != null)
                    {
                        txtSwitch.Value = mb.SwitchID.ToString();//xzj--20190225--添加交换
                        txtBaseStationName.Value = mb.StationName;
                        txtBaseStationNo.Value = mb.StationISSI;
                    }
                }
               
            }
        }
    }
}