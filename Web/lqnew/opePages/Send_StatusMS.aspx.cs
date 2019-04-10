using Ryu666.Components;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;

namespace Web.lqnew.opePages
{
    public partial class Send_StatusMS : System.Web.UI.Page
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
            if (!IsPostBack)
            {
                if (Request.QueryString["cmd"] != null)
                {
                    //直接穿ISSI号码跟姓名

                    if (Request.QueryString["cmd"].ToString().ToUpper() == "ISSI")
                    {
                        if (Request.QueryString["issi"] != null && Request.QueryString["name"] != null)
                        {
                            txtISSI.Value = Request.QueryString["name"].ToString() + "(" + Request.QueryString["issi"].ToString() + ")";
                            //txtISSIValue.Value = Request.QueryString["name"].ToString() + "," + Request.QueryString["issi"].ToString() + ",成员;";
                            txtISSIValue.Value = Request.QueryString["name"].ToString() + "," + Request.QueryString["issi"].ToString() + "," + members + ";";
                        }
                    }
                    //根据调度台ID 
                    if (Request.QueryString["cmd"].ToString().ToUpper() == "D")
                    {
                        if (Request.QueryString["id"].ToString() != "")//调度台ID
                        {
                            MyModel.Model_DispatchUser_View DispatchUserView = DispatchUserViewService.GetDispatchUserByID(int.Parse(Request.QueryString["id"].ToString()));
                            if (DispatchUserView != null)
                            {
                                //txtISSI.Value = "调度台" + DispatchUserView.Usename + "(" + DispatchUserView.ISSI + ")";
                                //txtISSIValue.Value = "调度台" + DispatchUserView.Usename + "," + DispatchUserView.ISSI + ",调度台;";
                                txtISSI.Value = diaodutai + DispatchUserView.Usename + "(" + DispatchUserView.ISSI + ")";
                                txtISSIValue.Value = diaodutai + DispatchUserView.Usename + "," + DispatchUserView.ISSI + "," + diaodutai + ";";
                            }
                        }
                    }
                    //根据调度台ISSI
                    if (Request.QueryString["cmd"].ToString().ToUpper() == "DISSI")
                    {
                        if (Request.QueryString["id"].ToString() != "")//调度台ID
                        {
                            MyModel.Model_DispatchUser_View DispatchUserView = DispatchUserViewService.GetDispatchUserByISSI(Request.QueryString["id"].ToString());
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
                    if (Request.QueryString["cmd"].ToString().ToUpper() == "GR")
                    {
                        //if (Request.QueryString["id"].ToString() != "")//组ID
                        if (Request.QueryString["gssi"].ToString() != "")//组ID
                        {
                           //MyModel.Model_group GroupModel = GroupInfoService.GetGroupinfo_byid(int.Parse(Request.QueryString["id"].ToString()));
                            //修复收发件箱中对组状态消息进行发送，修改人：张谦
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
                    if (Request.QueryString["cmd"].ToString().ToUpper() == "I")
                    {
                        if (Request.QueryString["id"].ToString() != "")//组ID
                        {
                            MyModel.Model_UserISSIView model = UserISSIViewService.GetUserISSIViewByID(Request.QueryString["id"].ToString());
                            if (model != null)
                            {
                                txtISSI.Value = model.Nam + "(" + model.UserISSI + ")";
                                //txtISSIValue.Value = model.Nam + "," + model.UserISSI + ",成员;";
                                txtISSIValue.Value = model.Nam + "," + model.UserISSI + "," + members + ";";
                            }
                        }
                    }
                    //直接根据GSSI号码进行组群发
                    if (Request.QueryString["cmd"].ToString().ToUpper() == "GSSI")
                    {
                        if (Request.QueryString["id"].ToString() != "")
                        {

                            string MYGSSI = Request.QueryString["id"].ToString();
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
                    if (Request.QueryString["cmd"].ToString().ToUpper() == "G")
                    {
                        string none = ResourceManager.GetString("Lang-None");
                        if (Request.QueryString["id"].ToString() != "")
                        {

                            MyModel.Model_userinfo UserInfo = UserInfoService.GetUserinfo_byid(int.Parse(Request.QueryString["id"].ToString()));
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
                                                //if (myGssi != "无")
                                                if (myGssi != none)
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
                }
                else
                {
                    if (Request.QueryString["id"] != null)
                    {
                        if (Request.QueryString["id"].ToString() != "")
                        {
                            MyModel.Model_userinfo UserInfo = UserInfoService.GetUserinfo_byid(int.Parse(Request.QueryString["id"].ToString()));
                            txtISSI.Value = UserInfo.Nam + "(" + UserInfo.ISSI + ")";
                            txtISSIValue.Value = UserInfo.Nam + "," + UserInfo.ISSI + "," + members + ";";
                            txtISSIText.Value = UserInfo.Nam;
                        }
                    }
                }
                if (Request.QueryString["sid"] != null)//短信群发，用;隔开的用户ID字符串
                {
                    if (!String.IsNullOrEmpty(Request.QueryString["sid"].ToString()))
                    {
                        StringBuilder sbInfo = new StringBuilder();
                        StringBuilder sbInfo1 = new StringBuilder();
                        string[] arrSid = Request.QueryString["sid"].ToString().Split(new char[] { ';' });
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



    }
}