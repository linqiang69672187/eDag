using MyModel;
using Ryu666.Components;
using System;
using System.Collections.Generic;
using System.Web.UI;
using Web.lqnew.other;

namespace Web.lqnew.opePages
{
    public partial class edit_BaseStation : BasePage
    {
        private DbComponent.IDAO.IBaseStationDao BaseStationDaoServce
        {
            get
            {
                return DbComponent.FactoryMethod.DispatchInfoFactory.CreateBaseStationDao();
            }
        }
        private DbComponent.IDAO.IBSGroupInfoDao BSGroupServce
        {
            get
            {
                return DbComponent.FactoryMethod.DispatchInfoFactory.CreateBSGroupInfoDao();
            }
        }
        private static Model_BaseStation baseStation = new Model_BaseStation();
        protected void Page_Load(object sender, EventArgs e)
        {
            validateEntityLength.ValidationExpression = Properties.Resources.strNameLengthValidationExpression;
            Page.ClientScript.RegisterStartupScript(Page.GetType(), "Lang2localfunc", "<script>Lang2localfunc();</script>");
            validateEntityLength.ErrorMessage = "<B>" + ResourceManager.GetString("errorUnNomal");
            radIsUnderGround.Items[0].Text = ResourceManager.GetString("Lang_Yes");
            radIsUnderGround.Items[1].Text = ResourceManager.GetString("Lang_No");

            if (!Page.IsPostBack && Request.QueryString["id"] != null)
            {
                cancel.Src = ResourceManager.GetString("Lang-Cancel");
                baseStation = BaseStationDaoServce.GetBaseStationByID(int.Parse(Request.QueryString["id"]));
                if (baseStation != null)
                {
                    txtBaseStation.Text = baseStation.StationName;
                    txtBaseISSI.Text = baseStation.StationISSI;
                    txtLa.Text = baseStation.La.ToString();
                    txtLo.Text = baseStation.Lo.ToString();
                    if (baseStation.IsUnderGround == 1)
                    {
                        radIsUnderGround.Items[0].Selected = true;
                    }
                    else
                    {
                        radIsUnderGround.Items[1].Selected = true;
                    }
                    txtSwitch.Text = baseStation.SwitchID.ToString();//xzj--20181217
                }
                else
                {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>window.parent.closeprossdiv();alert('" + ResourceManager.GetString("nxyxgdjzxxybcz") + "');window.parent.mycallfunction('edit_BaseStation');</script>");
                }
            }
            else
            {
                if (System.Configuration.ConfigurationManager.AppSettings["OpenWindow"] == "1")
                {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "resizediv", "<script>  window.parent.lq_changeheight(geturl(), document.body.clientHeight);</script>");
                }
            }
            ImageButton1.ImageUrl = ResourceManager.GetString("LangConfirm");
            rfvBaseStationName.ErrorMessage = "<b>" + ResourceManager.GetString("enterstationinformation") + "</b>";
            BSNValidator.ErrorMessage = "<b>" + ResourceManager.GetString("BSissiarrange") + "</b>";
            rfvBaseStationISSI.ErrorMessage = "<b>" + ResourceManager.GetString("enterstationissi") + "</b>";
            rbtxtLo.ErrorMessage = "<b>" + ResourceManager.GetString("Lang_rbtxtLoErr") + "</b>";
            RequiredFieldValidator1.ErrorMessage = "<b>" + ResourceManager.GetString("qhqjd") + "</b>";
            RangeValidator1.ErrorMessage = "<b>" + ResourceManager.GetString("Lang_RangeValidator1Err") + "</b>";
            RequiredFieldValidator2.ErrorMessage = "<b>" + ResourceManager.GetString("qhqwd") + "</b>";
            revSwitch.ErrorMessage = "<b>" + ResourceManager.GetString("Lang_revSwitch") + "</b>";//xzj--20181215
        }

        protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
        {
            Page.ClientScript.RegisterStartupScript(Page.GetType(), "resizediv", "<script>   var image1 = window.document.getElementById('Lang-Cancel');var srouce1 = window.parent.parent.GetTextByName('Lang-Cancel', window.parent.parent.useprameters.languagedata);image1.setAttribute('src', srouce1);</script>");

            if (BaseStationDaoServce.GetBaseStationByID(int.Parse(Request.QueryString["id"])) == null)
            {
                Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("BSeditfaile") + "');window.parent.mycallfunction('edit_BaseStation');</script>");
                return;
            }
            if (!checkISSI.RegexIssiValue(txtBaseISSI.Text.Trim()))
            {
                Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("BSbzbxwzs") + "');</script>");
                return;
            }
            if (BaseStationDaoServce.FindBaseStationISSIForUpdate(int.Parse(Request.QueryString["id"]), txtBaseISSI.Text.Trim(),int.Parse(string.IsNullOrEmpty(txtSwitch.Text)==true?"0":txtSwitch.Text)))//xzj--20181217--添加交换
            {
                Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("StationIDexit") + "');</script>");
                return;
            }
            if (BaseStationDaoServce.FindBaseStationNameForUpdate(int.Parse(Request.QueryString["id"]), txtBaseStation.Text.Trim()))
            {
                Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("StationNameexit") + "');</script>");
                return;
            }

            try
            {

                int isUnderGround = radIsUnderGround.SelectedValue == "1" ? 1 : 0;

        //更改基站标识了 则 需要同步更新基站组中的标识--xzj--20181217--添加交换
                if (baseStation.StationISSI.Trim() != txtBaseISSI.Text.Trim()||baseStation.SwitchID!=(string.IsNullOrEmpty(txtSwitch.Text)==true?0:int.Parse(txtSwitch.Text)))
                {
                    IList<MyModel.Model_BSGroupInfo> bsgroup = BSGroupServce.GetAllBSGroup();
                    foreach (MyModel.Model_BSGroupInfo mbsg in bsgroup)
                    {
                        if (!String.IsNullOrEmpty(mbsg.MemberIds))
                        {
                            string[] members = mbsg.MemberIds.Split(new char[] { ';' }, StringSplitOptions.RemoveEmptyEntries);
                            string newmembers = "";
                            if (members.Length > 0)
                            {
                                foreach (string memb in members)
                                {
                                    if ("{" + baseStation.SwitchID.ToString().Trim() + "," + baseStation.StationISSI.Trim() + "}" == memb)//新的跟老的不一样 就用新的--xzj--20181228--添加交换
                                    {

                                        newmembers += "{" +(string.IsNullOrEmpty(txtSwitch.Text)==true?0:int.Parse(txtSwitch.Text))+","+ txtBaseISSI.Text.Trim() + "};";
                                    }
                                    else
                                    {
                                        newmembers += memb + ";";
                                    }
                                }
                                mbsg.MemberIds = newmembers;
                                BSGroupServce.Update(mbsg.BSGroupName, newmembers, mbsg.Entity_ID, false, mbsg.ID);
                            }
                        }
                    }
                }

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
                Model_BaseStation newModel = new Model_BaseStation { ID = int.Parse(Request.QueryString["id"]), StationName = txtBaseStation.Text.Trim(), StationISSI = txtBaseISSI.Text.Trim(), Lo = Lo, La = La, DivID = baseStation.DivID, PicUrl = baseStation.PicUrl, IsUnderGround = isUnderGround, SwitchID = int.Parse(string.IsNullOrEmpty(txtSwitch.Text) == true ? "0" : txtSwitch.Text) };//xzj--20181217
                if (BaseStationDaoServce.UpdateBaseStation(newModel))
                {
                    int deviceCount = BaseStationDaoServce.getAllBsDeviceCount(txtBaseISSI.Text.Trim(), int.Parse(string.IsNullOrEmpty(txtSwitch.Text) == true ? "0" : txtSwitch.Text));
                    int id = int.Parse(Request.QueryString["id"]);
                    string basestation = "{'ID' : " + id + ", 'StationISSI' : '" + newModel.StationISSI + "', 'La' :" + La + ", 'Lo' :" + Lo + ", 'StationName' :'" + newModel.StationName + "', 'DeviceCount' :" + deviceCount + ", 'SwitchID' :" + newModel.SwitchID + "}";//xzj--20181228--添加交换
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("Lang_ModifySucc") + "');window.parent.bsLayerManager.updateBaseStationFeature(" + basestation + ");window.parent.lq_changeifr('manager_BaseStation');window.parent.mycallfunction('edit_BaseStation');</script>");

                }
                else
                {
                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("Lang_ModifyFail") + "');</script>");
                }
            }
            catch (System.Exception eX)
            {
                log.Error(eX);
                Page.ClientScript.RegisterStartupScript(Page.GetType(), "alert", "<script>alert('" + ResourceManager.GetString("Lang_ModifyFail") + "');</script>");
            }

        }
    }
}