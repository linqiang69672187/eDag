using Ryu666.Components;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;

namespace Web.lqnew.opePages
{
    public partial class Send_SMS : System.Web.UI.Page
    {
        protected DbComponent.userinfo UserInfoService
        {
            get
            {
                return new DbComponent.userinfo();
            }
        }
        protected DbComponent.ISSI ISSIService
        {
            get
            {
                return new DbComponent.ISSI();
            }
        }
        protected DbComponent.group GroupInfoService
        {
            get
            {
                return new DbComponent.group();
            }
        }
        protected DbComponent.IDAO.IDispatchUserViewDao DispatchUserViewService
        {
            get { return DbComponent.FactoryMethod.DispatchInfoFactory.CreateDispatchUserViewDao(); }
        }
        protected DbComponent.IDAO.IUserISSIViewDao UserISSIViewService
        {
            get { return DbComponent.FactoryMethod.DispatchInfoFactory.CreateUserISSIViewDao(); }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            string diaodutai = ResourceManager.GetString("Dispatch");
            string members = ResourceManager.GetString("Members");
            string Group = ResourceManager.GetString("Group");
            string baseStation = ResourceManager.GetString("Station");//xzj--20190218--添加基站短信
            if (!IsPostBack)
            {
                if (Request["cmd"] != null)
                {
                    //直接穿ISSI号码跟姓名
                    if (Request["cmd"].ToString().ToUpper() == "ISSI")
                    {
                        if (Request["issi"] != null && Request["name"] != null && Request["issi"] != "" && Request["name"] != "")
                        {
                            txtISSI.Value = Request["name"].ToString() + "(" + Request["issi"].ToString() + ")";
                            //txtISSIValue.Value = Request.QueryString["name"].ToString() + "," + Request.QueryString["issi"].ToString() + ",成员;";
                            txtISSIValue.Value = Request["name"].ToString() + "," + Request["issi"].ToString() + "," + members + ";";

                        }
                    }
                    //根据调度台ID 
                    if (Request["cmd"].ToString().ToUpper() == "D")
                    {
                        if (Request["id"].ToString() != "")//调度台ID
                        {
                            MyModel.Model_DispatchUser_View DispatchUserView = DispatchUserViewService.GetDispatchUserByID(int.Parse(Request["id"].ToString()));
                            if (DispatchUserView != null)
                            {
                                //txtISSI.Value = "调度台" + DispatchUserView.Usename + "(" + DispatchUserView.ISSI + ")";
                                //txtISSIValue.Value ="调度台" +DispatchUserView.Usename + "," + DispatchUserView.ISSI + ",调度台;";
                                txtISSI.Value = diaodutai + DispatchUserView.Usename + "(" + DispatchUserView.ISSI + ")";
                                txtISSIValue.Value = diaodutai + DispatchUserView.Usename + "," + DispatchUserView.ISSI + "," + diaodutai + ";";
                            }
                        }
                    }
                    //根据调度台ISSI
                    if (Request["cmd"].ToString().ToUpper() == "DISSI")
                    {
                        if (Request["id"].ToString() != "")//调度台ID
                        {
                            MyModel.Model_DispatchUser_View DispatchUserView = DispatchUserViewService.GetDispatchUserByISSI(Request["id"].ToString());
                            if (DispatchUserView != null)
                            {
                                //txtISSI.Value = "调度台" + DispatchUserView.Usename + "(" + DispatchUserView.ISSI + ")";
                                //txtISSIValue.Value = "调度台" + DispatchUserView.Usename + "," + DispatchUserView.ISSI + ",调度台;";
                                txtISSI.Value = diaodutai + DispatchUserView.Usename + "(" + DispatchUserView.ISSI + ")";
                                txtISSIValue.Value = diaodutai + DispatchUserView.Usename + "," + DispatchUserView.ISSI + "," + diaodutai + ";";
                            }
                        }
                    }
                    //根据编组ID
                    if (Request["cmd"].ToString().ToUpper() == "GR")
                    {
                        //if (Request["id"].ToString() != "")//组ID
                        if (Request["gssi"].ToString() != "")//组ID
                        {
                            //配置文件中是否配置组短信不能回执
                            HidTrHZ();
                            //MyModel.Model_group GroupModel = GroupInfoService.GetGroupinfo_byid(int.Parse(Request["id"].ToString()));
                            //修复收发件箱中组信息发送失败的问题，修改人：张谦
                            MyModel.Model_group GroupModel = GroupInfoService.GetGroupinfo_ByGssi(int.Parse(Request["gssi"].ToString()));
                            if (GroupModel != null)
                            {
                                txtISSI.Value = GroupModel.Group_name + "(" + GroupModel.GSSI + ")";
                                //txtISSIValue.Value = GroupModel.Group_name + "," + GroupModel.GSSI + ",编组;";
                                txtISSIValue.Value = GroupModel.Group_name + "," + GroupModel.GSSI + "," + Group + ";";
                            }
                        }
                    }
                    //根据终端ID 显示用户名跟ISSI号码
                    if (Request["cmd"].ToString().ToUpper() == "I")
                    {
                        if (Request["id"].ToString() != "")//组ID
                        {
                            MyModel.Model_UserISSIView model = UserISSIViewService.GetUserISSIViewByID(Request["id"].ToString());
                            if (model != null)
                            {
                                txtISSI.Value = model.Nam + "(" + model.UserISSI + ")";
                                //txtISSIValue.Value = model.Nam + "," + model.UserISSI + ",成员;";
                                txtISSIValue.Value = model.Nam + "," + model.UserISSI + "," + members + ";";
                            }
                        }
                    }
                    //直接根据GSSI号码进行组群发
                    if (Request["cmd"].ToString().ToUpper() == "GSSI")
                    {
                        if (Request["id"].ToString() != "")
                        {
                            //配置文件中是否配置组短信不能回执
                            HidTrHZ();
                            string MYGSSI = Request["id"].ToString();
                            DataTable GInfo = GroupInfoService.GetGroupInfoByGIIS(MYGSSI);
                            if (GInfo != null && GInfo.Rows.Count > 0)
                            {
                                txtISSI.Value = GInfo.Rows[0]["Group_name"].ToString() + "(" + MYGSSI + ")";
                                //txtISSIValue.Value = GInfo.Rows[0]["Group_name"].ToString() + "," + MYGSSI + ",编组;";
                                txtISSIValue.Value = GInfo.Rows[0]["Group_name"].ToString() + "," + MYGSSI + "," + Group + ";";
                            }
                        }
                    }

                    //根据用户ID 进行组的呼叫
                    if (Request["cmd"].ToString().ToUpper() == "G")
                    {
                        if (Request["id"].ToString() != "")
                        {
                            //配置文件中是否配置组短信不能回执
                            HidTrHZ();
                            MyModel.Model_userinfo UserInfo = UserInfoService.GetUserinfo_byid(int.Parse(Request["id"].ToString()));
                            string strISSI = UserInfo.ISSI;
                            if (!string.IsNullOrEmpty(strISSI))
                            {
                                MyModel.Model_ISSI MyISSI = ISSIService.GetISSIinfoByISSI(strISSI);
                                if (MyISSI != null)
                                {
                                    string strGSSIs = MyISSI.GSSIS;
                                    if (!string.IsNullOrEmpty(strGSSIs))
                                    {
                                        string[] arrGSSI = strGSSIs.Split(new char[] { 's' });
                                        if (arrGSSI.Length > 0)
                                        {

                                            IList<string> tbz = (from c in arrGSSI.ToList<string>() where c.Contains("z") select c).ToList<string>();
                                            if (tbz != null)
                                            {
                                                string myGssi = tbz[0].ToString().Substring(2, tbz[0].ToString().Length - 3);
                                                if (myGssi != ResourceManager.GetString("Lang-None").Trim())
                                                {
                                                    string GroupName = GroupInfoService.GetGroupGroupname_byGSSI(myGssi);
                                                    txtISSI.Value = GroupName + "(" + myGssi + ")";
                                                    //txtISSIValue.Value = GroupName + "," + myGssi + ",编组;";
                                                    txtISSIValue.Value = GroupName + "," + myGssi + "," + Group + ";";
                                                }
                                            }
                                        }

                                    }
                                }

                            }
                            
               }
                    }
                    //xzj--20190225--添加基站短信
                    if (Request["cmd"].ToString().ToUpper() == "BSISSI")
                    {//id实际为基站ISSI,不是表的id
                        if (Request["id"] != null && Request["name"] != null && Request["switchID"] != null && Request["id"] != "" && Request["name"] != "" && Request["switchID"] != "")
                        {
                            txtISSI.Value = Request["name"].ToString() + "(" + Request["id"].ToString() + "(" + Request["switchID"].ToString() + ")" + ")";
                            txtISSIValue.Value = Request["name"].ToString() + "," + Request["id"].ToString() + "(" + Request["switchID"].ToString() + ")" + "," + baseStation + ";";

                        }
                    }
                }
                else
                {
                    if (Request["id"] != null)
                    {
                        if (Request["id"].ToString() != "")
                        {
                            MyModel.Model_userinfo UserInfo = UserInfoService.GetUserinfo_byid(int.Parse(Request["id"].ToString()));
                            if (UserInfo.ISSI != null)
                            {
                                txtISSI.Value = UserInfo.Nam + "(" + UserInfo.ISSI + ")";
                                //txtISSIValue.Value = UserInfo.Nam + "," + UserInfo.ISSI + ",成员;";
                                txtISSIValue.Value = UserInfo.Nam + "," + UserInfo.ISSI + "," + members + ";";
                                txtISSIText.Value = UserInfo.Nam;
                            }
                        }
                    }
                }
                if (Request["sid"] != null)//短信群发，用;隔开的用户ID字符串
                {
                    if (!String.IsNullOrEmpty(Request["sid"].ToString()))
                    {
                        StringBuilder sbInfo = new StringBuilder();
                        StringBuilder sbInfo1 = new StringBuilder();
                        string[] arrSid = Request["sid"].ToString().Split(new char[] { ';' });
                        DataTable myUserList = UserInfoService.GetUserInfoByIds(arrSid);
                        foreach (DataRow myUser in myUserList.Rows)
                        {
                            if (!String.IsNullOrEmpty(myUser["ISSI"].ToString()))
                            {
                                sbInfo.Append(myUser["Nam"]);
                                sbInfo.Append("(");
                                sbInfo.Append(myUser["ISSI"]);
                                sbInfo.Append(")");
                                //txtISSI.Value += myUser.Nam + "(" + myUser.ISSI + ")";
                                sbInfo1.Append(myUser["Nam"]);
                                sbInfo1.Append(",");
                                sbInfo1.Append(myUser["ISSI"]);
                                sbInfo1.Append(",");
                                sbInfo1.Append(members);
                                sbInfo1.Append(";");
                                //txtISSIValue.Value += myUser.Nam + "," + myUser.ISSI + "," + members + ";";
                            }
                        }
                        txtISSI.Value = sbInfo.ToString();
                        txtISSIValue.Value = sbInfo1.ToString();
                        //个人不建议使用下面的方式，当传过来的sid数据较多的时候，需要去数据库查太多次，个人建议先根据sid把满足条件的用户信息
                        //都查出来，然后在拼装，这样数据多的时候，性能会明显提高

                        //foreach (string id in arrSid)
                        //{
                        //    MyModel.Model_userinfo UserInfo = UserInfoService.GetUserinfo_byid(int.Parse(id));
                        //    txtISSI.Value += UserInfo.Nam + "(" + UserInfo.ISSI + ")";
                        //    txtISSIValue.Value += UserInfo.Nam + "(" + UserInfo.ISSI + ");";
                        //}
                    }
                }
                if (txtISSIValue.Value.Length > 0)
                {
                    txtISSIValue.Value = txtISSIValue.Value.Substring(0, txtISSIValue.Value.Length - 1);
                }
            }
        }

        private void HidTrHZ()
        {
            if (System.Configuration.ConfigurationManager.AppSettings["BackForSendGroupMsg"].ToString() == "0")
            {

                trHZ.Style.Add("display", "none");
            }
        }

    }
}