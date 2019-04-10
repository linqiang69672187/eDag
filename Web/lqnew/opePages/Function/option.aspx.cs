using DbComponent;
using Ryu666.Components;
using System;
using System.Data;
using System.Web.UI;

namespace Web.lqnew.opePages.Function
{
    public partial class Option : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                //加载警员类型
                UserTypeDao UserType = new UserTypeDao();
                DataTable dtPolice = UserType.GetAllUserType();
                this.PoliceTypeList.DataSource = dtPolice;
                this.PoliceTypeList.DataTextField = "TypeName";
                this.PoliceTypeList.DataValueField = "TypeName";
                this.PoliceTypeList.DataBind();

                System.Configuration.Configuration config = System.Web.Configuration.WebConfigurationManager.OpenWebConfiguration(System.Web.HttpContext.Current.Request.ApplicationPath);
                System.Configuration.AppSettingsSection appSettings = (System.Configuration.AppSettingsSection)config.GetSection("appSettings");
                string PoliceTypeValue = appSettings.Settings["PoliceType"].Value;
                this.PoliceTypeList.SelectedValue = PoliceTypeValue;

                //this.PoliceTypeList.Items.Insert(0, new ListItem("请选择", ""));


                Button1.Text = ResourceManager.GetString("BeSure");
                TabPanel1.HeaderText = ResourceManager.GetString("Routine_Setting");
                TabPanel2.HeaderText = ResourceManager.GetString("Terminal_Setting");
                TabPanel3.HeaderText = ResourceManager.GetString("CXBKsettings");
                TabPanel4.HeaderText = ResourceManager.GetString("GroupShortKey");

                CheckBox2.Text = ResourceManager.GetString("OfflineDevice");
                CheckBox2.ToolTip = ResourceManager.GetString("OfflineDeviceHave");
                userHeadInfoList.Items[0].Text = ResourceManager.GetString("Lang_name_searchoption");
                userHeadInfoList.Items[1].Text = ResourceManager.GetString("Lang_ISSI_searchoption");
                userHeadInfoList.Items[2].Text = ResourceManager.GetString("Lang_Num_searchoption");
                userHeadInfoList.Items[3].Text = ResourceManager.GetString("Lang_Unit");
                userHeadInfoList.Items[4].Text = ResourceManager.GetString("Lang_TerminalType");


                //气泡设置
                usermessage.Items[0].Text = ResourceManager.GetString("Lang_Unit");
                usermessage.Items[1].Text = ResourceManager.GetString("Lang-Longitude");
                usermessage.Items[2].Text = ResourceManager.GetString("Lang-Latitude");
                usermessage.Items[3].Text = ResourceManager.GetString("GPSStatus");
                usermessage.Items[4].Text = ResourceManager.GetString("Lang_SendMSGTIME");

                usermessage.Items[5].Text = ResourceManager.GetString("Lang_telephone");
                usermessage.Items[6].Text = ResourceManager.GetString("Lang_position");
                usermessage.Items[7].Text = ResourceManager.GetString("Lang_Remark");
                usermessage.Items[8].Text = ResourceManager.GetString("Lang_TerminalType");
                                usermessage.Items[9].Text = ResourceManager.GetString("energy");//xzj--20181224--添加场强信息--手台电量

                usermessage.Items[10].Text = ResourceManager.GetString("signaldown");//手台场强
                usermessage.Items[11].Text = ResourceManager.GetString("signalup");//上行场强



                UserHeaderInfoSwitch.Items[0].Text = ResourceManager.GetString("Single_Open");
                UserHeaderInfoSwitch.Items[1].Text = ResourceManager.GetString("Closebtn");
                Mode_ISSI.Text = ResourceManager.GetString("Lang_ISSI_searchoption");
                Mode_name.Text = ResourceManager.GetString("Lang_name_searchoption");
                txtBKDistance.Text = System.Configuration.ConfigurationManager.AppSettings["CXBKKilometres"];
                string groupkey = System.Configuration.ConfigurationManager.AppSettings["GroupShortcutKey"];
                txtKey0.Text = groupkey.Split(';')[0];
                txtKey1.Text = groupkey.Split(';')[1];
                txtKey2.Text = groupkey.Split(';')[2];
                txtKey3.Text = groupkey.Split(';')[3];
                txtKey4.Text = groupkey.Split(';')[4];
                txtKey5.Text = groupkey.Split(';')[5];
                txtKey6.Text = groupkey.Split(';')[6];
                txtKey7.Text = groupkey.Split(';')[7];
                txtKey8.Text = groupkey.Split(';')[8];
                txtKey9.Text = groupkey.Split(';')[9];

                //cxy-20180730
                isCluster.Text = ResourceManager.GetString("OpenCluster");
                notCluster.Text = ResourceManager.GetString("CloseCluster");
                bool iscluster = Convert.ToBoolean(System.Configuration.ConfigurationManager.AppSettings["IsBaseStationLayerCluster"]);
                if (iscluster)
                {
                    isCluster.Checked = true;
                    notCluster.Checked = false;
                }
                else {
                    isCluster.Checked = false;
                    notCluster.Checked = true;
                }
                //cxy-20180809-用户场强信息控制
                fieldStrengthList.Items[0].Text = ResourceManager.GetString("energy");
                fieldStrengthList.Items[1].Text = ResourceManager.GetString("signalup");
                fieldStrengthList.Items[2].Text = ResourceManager.GetString("signaldown");

                //ReqBKD.Text = ResourceManager.GetString("IllegalNum");
                //regValNum.Text = ResourceManager.GetString("IllegalNum");     
                //添加基站头部信息checkbox-xzj---20180926
                BSHeadInfoCheckBox.Text = ResourceManager.GetString("BaseStationHeadInfo");
                BSHeadInfoCheckBox.ToolTip = ResourceManager.GetString("BaseStationHeadInfoTooltip");
                BSHeadInfoCheckBox.Checked = Convert.ToBoolean(System.Configuration.ConfigurationManager.AppSettings["IsBasestationHeadInformation"]);

//添加呼叫加密设置--xzj--20190320
                cblCallEncryption.Items[0].Text = ResourceManager.GetString("SingleCall");
                cblCallEncryption.Items[0].Attributes.Add("style", "margin-left:-3px");
                cblCallEncryption.Items[1].Text = ResourceManager.GetString("smallGroupCall");
                cblCallEncryption.Items[1].Attributes.Add("style", "margin-left:71px");
                string callEncryption = System.Configuration.ConfigurationManager.AppSettings["CallEncryption"].ToString();
                string[] callEncryptionArr = callEncryption.Split('|');
                foreach (var ce in callEncryptionArr)
                {
                    switch (ce)
                    {
                        case "Single":
                            this.cblCallEncryption.Items[0].Selected = true;
                            break;
                        case "Group":
                            this.cblCallEncryption.Items[1].Selected = true;
                            break;
                        default:
                            break;
                    }
                }

                DataTable dt = DbComponent.usepramater.GetUseparameterByCookie(Request.Cookies["username"].Value);
                for (int countdt = 0; countdt < dt.Rows.Count; countdt++)
                {
                    if (dt.Rows[countdt][3].ToString() != "")
                    {
                        DropDownList2.SelectedValue = dt.Rows[countdt][3].ToString();
                    }
                    if (dt.Rows[countdt][4].ToString() != "")
                    {
                        CheckBox2.Checked = (Boolean.Parse(dt.Rows[countdt][4].ToString())) ? true : false;

                    }
                    if (dt.Rows[countdt][5].ToString() != "")
                    {
                        DropDownList1.SelectedValue = dt.Rows[countdt][5].ToString();
                    }
                    if (dt.Rows[countdt][8].ToString() != "")
                    {
                        viewinfo.Checked = (Boolean.Parse(dt.Rows[countdt][8].ToString())) ? true : false;

                    }
                    if (dt.Rows[countdt][12].ToString().Trim() == "Name")
                    {
                        Mode_name.Checked = true;
                        Mode_ISSI.Checked = false;
                    }
                    else if (dt.Rows[countdt][12].ToString().Trim() == "ISSI")
                    {
                        Mode_name.Checked = false;
                        Mode_ISSI.Checked = true;
                    }
                    else if (dt.Rows[countdt][12].ToString().Trim() == "NameAndISSI")
                    {
                        Mode_name.Checked = true;
                        Mode_ISSI.Checked = true;
                    }
                    else if (dt.Rows[countdt][12].ToString().Trim() == "")
                    {
                        Mode_name.Checked = false;
                        Mode_ISSI.Checked = false;
                    }
                    else
                    {
                        Mode_name.Checked = false;
                        Mode_ISSI.Checked = false;
                    }
                    if (dt.Rows[countdt]["voiceType"] == null || dt.Rows[countdt]["voiceType"].ToString().Trim() == "")
                    {
                        voiceType.SelectedValue = "1";
                    }
                    else if (int.Parse(dt.Rows[countdt]["voiceType"].ToString().Trim()) == 1)
                    {
                        voiceType.SelectedValue = "1";
                    }
                    else if (int.Parse(dt.Rows[countdt]["voiceType"].ToString().Trim()) == 2)
                    {
                        voiceType.SelectedValue = "2";
                    }
                    else if (int.Parse(dt.Rows[countdt]["voiceType"].ToString().Trim()) == 3)
                    {
                        voiceType.SelectedValue = "3";
                    }
                    if (dt.Rows[countdt]["IsOpenuserHeadInfo"].ToString().Trim() == "open")
                    {
                        UserHeaderInfoSwitch.Items[0].Selected = true;
                    }
                    else
                    {
                        UserHeaderInfoSwitch.Items[1].Selected = true;
                    }
                }

                //气泡信息
                string S_information = System.Web.Configuration.WebConfigurationManager.AppSettings["UsermessageKey"];
                string[] As_information = S_information.Split('|');
                for (int i = 0; i < As_information.Length; i++)
                {
                    switch (As_information[i])
                    {
                        case "Unit":
                            this.usermessage.Items[0].Selected = true;
                            break;
                        case "Longitude":
                            this.usermessage.Items[1].Selected = true;
                            break;
                        case "Latitude":
                            this.usermessage.Items[2].Selected = true;
                            break;
                        case "GPSStatus":
                            this.usermessage.Items[3].Selected = true;
                            break;
                        case "SendMSGTIME":
                            this.usermessage.Items[4].Selected = true;
                            break;
                        //修改usermessage.Items[]中的排序号-------------xzj--2018/7/20------------------------
                        case "telephone":
                            this.usermessage.Items[5].Selected = true;
                            break;
                        case "position":
                            this.usermessage.Items[6].Selected = true;
                            break;
                        case "Remark":
                            this.usermessage.Items[7].Selected = true;
                            break;
                        case "TerminalType":
                            this.usermessage.Items[8].Selected = true;
                            break;
                        case "Battery"://xzj--20181224--添加场强信息--手台电量
                            this.usermessage.Items[9].Selected = true;
                            break;
                        case "MsRssi"://手台场强
                            this.usermessage.Items[10].Selected = true;
                            break;
                        case "UlRssi"://上行场强
                            this.usermessage.Items[11].Selected = true;
                            break;

                        default:
                            break;

                    }

                }

                //cxy-20180809-场强控制初始化
                string fs_info = System.Web.Configuration.WebConfigurationManager.AppSettings["FieldStrength"];
                string[] fs_array = fs_info.Split('|');
                foreach (var str in fs_array) { 
                    switch(str){
                        case "energy":
                            this.fieldStrengthList.Items[0].Selected = true;
                            break;
                        case "signalup":
                            this.fieldStrengthList.Items[1].Selected = true;
                            break;
                        case "signaldown":
                            this.fieldStrengthList.Items[2].Selected = true;
                            break;
                        default:
                            break;
                    }
                }
            }


        }



        protected void Button1_Click(object sender, EventArgs e)
        {
            string mode = "";
            if (Mode_name.Checked == true && Mode_ISSI.Checked == true)
            {
                mode = "NameAndISSI";
            }
            else if (Mode_name.Checked == true && Mode_ISSI.Checked == false)
            {
                mode = "Name";
            }
            else if (Mode_name.Checked == false && Mode_ISSI.Checked == true)
            {
                mode = "ISSI";
            }
            else if (Mode_name.Checked == false && Mode_ISSI.Checked == false)
            {
                mode = "";
            }

            string isdisplay = "True";
            isdisplay = viewinfo.Checked.ToString();
            string selectedUserHeadInfo = "";
            for (int i = 0; i < userHeadInfoList.Items.Count; i++)
            {
                if (userHeadInfoList.Items[i].Selected)
                {
                    selectedUserHeadInfo = selectedUserHeadInfo + "|" + userHeadInfoList.Items[i].Value;
                }

            }
            if (selectedUserHeadInfo.IndexOf("|") == 0)
                selectedUserHeadInfo = selectedUserHeadInfo.Substring(1);


            //气泡信息显示相关操作
            string selectedUsermessage = "";
            for (int i = 0; i < usermessage.Items.Count; i++)
            {
                if (usermessage.Items[i].Selected)
                {
                    selectedUsermessage = selectedUsermessage + "|" + usermessage.Items[i].Value;
                }

            }
            if (selectedUsermessage.IndexOf("|") == 0)
                selectedUsermessage = selectedUsermessage.Substring(1);


            string selectedVoiceType = voiceType.SelectedValue.Trim();
            string IsOpenUserHeaderinfo = UserHeaderInfoSwitch.SelectedValue.Trim();

            System.Configuration.Configuration config = System.Web.Configuration.WebConfigurationManager.OpenWebConfiguration(System.Web.HttpContext.Current.Request.ApplicationPath);
            System.Configuration.AppSettingsSection appSettings = (System.Configuration.AppSettingsSection)config.GetSection("appSettings");
            System.Configuration.AppSettingsSection appSetting = (System.Configuration.AppSettingsSection)config.GetSection("appSettings");
            appSetting.Settings["CXBKKilometres"].Value = txtBKDistance.Text.Trim();
            string groupkey = txtKey0.Text.Trim() + ";" + txtKey1.Text.Trim() + ";" + txtKey2.Text.Trim() + ";" + txtKey3.Text.Trim() + ";" + txtKey4.Text.Trim() + ";" + txtKey5.Text.Trim() + ";" + txtKey6.Text.Trim() + ";" + txtKey7.Text.Trim() + ";" + txtKey8.Text.Trim() + ";" + txtKey9.Text.Trim();
            appSetting.Settings["GroupShortcutKey"].Value = groupkey;
            //气泡信息显示相关操作
            appSetting.Settings["UsermessageKey"].Value = selectedUsermessage;

            //xzj--20190320--添加呼叫加密设置
            string selectedCallEncryptionType = string.Empty;
            for (int i = 0; i < cblCallEncryption.Items.Count; i++)
            {
                if (cblCallEncryption.Items[i].Selected)
                {
                    selectedCallEncryptionType += cblCallEncryption.Items[i].Value + "|";
                }
            }
            selectedCallEncryptionType = selectedCallEncryptionType.TrimEnd('|');
            appSetting.Settings["CallEncryption"].Value = selectedCallEncryptionType;


            //cxy-20180730-基站聚合显示
            string isBaseStationLayerCluster = isCluster.Checked.ToString();


//cxy-20180809-场强配置
            string selectedFieldStrength = string.Empty;
            string objString = "{";
            for (int i = 0; i < fieldStrengthList.Items.Count; i++) {
                if (fieldStrengthList.Items[i].Selected)
                {
                    selectedFieldStrength += fieldStrengthList.Items[i].Value + "|";
                }
            }
            selectedFieldStrength = selectedFieldStrength.TrimEnd('|');

           //根据基站是否聚合判断是否刷新
            var originBSLayerCluster = appSetting.Settings["IsBaseStationLayerCluster"].Value;
            if (originBSLayerCluster != isBaseStationLayerCluster)
            {
                appSetting.Settings["IsBaseStationLayerCluster"].Value = isBaseStationLayerCluster;
                //cxy-20180730-刷新基站信息--cxy-20180809-场强控制
                Page.ClientScript.RegisterStartupScript(Page.GetType(), "bsLayerCluser", "<script>window.parent.bsLayerManager.refreshBaseStationLayer(window.parent.useprameters.BaseStationClusterDistance,'" + isBaseStationLayerCluster + "') </script>");
            }
            //根据场强信息配置判断是否刷新
            var originFieldStrength = appSetting.Settings["FieldStrength"].Value;
            var isDo = originFieldStrength.Equals(selectedFieldStrength) ? true : false;
            if (!isDo)
            {
                appSetting.Settings["FieldStrength"].Value = selectedFieldStrength;
                Page.ClientScript.RegisterStartupScript(Page.GetType(), "FieldStrength", "<script>window.parent.fsLayerManager.setHideOrShow('" + selectedFieldStrength + "') </script>");
            }
            //根据基站头部信息配置判断是否刷新
            var originBSHeaderInfo = appSetting.Settings["IsBasestationHeadInformation"].Value;
            var originPoliceType = appSetting.Settings["PoliceType"].Value;
            if (originBSHeaderInfo != BSHeadInfoCheckBox.Checked.ToString() || originPoliceType != PoliceTypeList.SelectedValue)
            {
                //警员种类
                appSetting.Settings["PoliceType"].Value = PoliceTypeList.SelectedValue;
                //xzj--20180926--基站头部信息显示
                appSetting.Settings["IsBasestationHeadInformation"].Value = BSHeadInfoCheckBox.Checked.ToString();
                Page.ClientScript.RegisterStartupScript(Page.GetType(), "bsHeaderInfo", "<script>window.parent.bsLayerManager.loadBaseStations() </script>");
            }


            config.Save();//保存web.config  
            System.Configuration.ConfigurationManager.RefreshSection("appSettings");

            DbComponent.LogModule.SystemLog.WriteLog(MyModel.Enum.ParameType.Other, MyModel.Enum.OperateLogType.operlog, MyModel.Enum.OperateLogModule.ModuleSystem, MyModel.Enum.OperateLogOperType.ParamsSet, "Parametersetting;DeviceOverTime:" + DropDownList2.SelectedValue + ";HiddenOfflineDevice:" + CheckBox2.Checked.ToString() + ";MapFreshTime:" + DropDownList1.SelectedValue + ";" + "CXBKkms:" + appSetting.Settings["CXBKKilometres"].Value, MyModel.Enum.OperateLogIdentityDeviceType.Other);

            DbComponent.usepramater.EditUseparameterByCookie(Request.Cookies["username"].Value, int.Parse(DropDownList2.SelectedValue), Boolean.Parse(CheckBox2.Checked.ToString()), int.Parse(DropDownList1.SelectedValue), Boolean.Parse(isdisplay), selectedUserHeadInfo, mode, selectedVoiceType, IsOpenUserHeaderinfo);
//xzj--20190320--添加呼叫加密设置参数
            Page.ClientScript.RegisterStartupScript(Page.GetType(), "resizediv", "<script> window.parent.setuseparameter('" + DropDownList2.SelectedValue + "','" + Boolean.Parse(CheckBox2.Checked.ToString()) + "','" + DropDownList1.SelectedValue + "','" + Boolean.Parse(isdisplay) + "','" + selectedUserHeadInfo + "','" + mode + "','" + selectedVoiceType + "','" + IsOpenUserHeaderinfo + "','" + appSetting.Settings["CXBKKilometres"].Value + "','" + appSetting.Settings["GroupShortcutKey"].Value + "','" + appSetting.Settings["UsermessageKey"].Value + "','" + appSetting.Settings["CallEncryption"].Value + "');window.parent.clearUserLayer();window.parent.fsLayerManager.loadFSLayer();window.parent.retoptionbg();window.parent.lq_closeANDremovediv('Function/option','bgDiv');alert('" + ResourceManager.GetString("Lang_setoptionsucess") + "');</script>");
    
        }
    }
}